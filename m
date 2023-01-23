Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9A678242
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jan 2023 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjAWQwU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Jan 2023 11:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjAWQwS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Jan 2023 11:52:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011872DE4E;
        Mon, 23 Jan 2023 08:52:05 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF73C20E2C03;
        Mon, 23 Jan 2023 08:52:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF73C20E2C03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674492725;
        bh=pp03YGGSPJklBjx3IO05F7RCBMZonuTyZ6VVAlGDVMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bf5Vv0NXstLz3CaB5zygZxlKKX1GLIaTAcak1iUhWQBViY71Nnd7FvGy44lWis+Cx
         yKUi4GMz12SiI7eGx9b84+aOmcOTJroBQii8CKRc/JHOin4MPgBIdgqaCxaMjE0Zxl
         Yk7wCM8XCpISMrsxdGxPtfce3yJuYvr5+Up4s2Ok=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [RFC PATCH v1 6/6] crypto: ccp - Introduce quirk to always reclaim pages after SEV-legacy commands
Date:   Mon, 23 Jan 2023 16:51:28 +0000
Message-Id: <20230123165128.28185-7-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Hyper-V, the rmp_mark_pages_shared() call after a SEV_PLATFORM_STATUS
fails with return code 2 (FAIL_PERMISSION) due to the page having the
immutable bit set in the RMP (SNP has been initialized). The comment
above this spot mentions that firmware automatically clears the
immutable bit, but I can't find any mention of this behavior in the SNP
Firmware ABI Spec.

Introduce a quirk to always attempt the page reclaim and set it for the
platform PSP. It would be possible to make this behavior unconditional
as the firmware spec defines that page reclaim results in success if the
page does not have the immutable bit set.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sev-dev.c     | 6 +++++-
 drivers/crypto/ccp/sp-dev.h      | 4 ++++
 drivers/crypto/ccp/sp-platform.c | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6c4fdcaed72b..4719c0cafa28 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -658,8 +658,12 @@ static int __snp_cmd_buf_copy(int cmd, void *cmd_buf, bool to_fw, int fw_err)
 	 * no not need to reclaim the page.
 	 */
 	if (from_fw && sev_legacy_cmd_buf_writable(cmd)) {
-		if (rmp_mark_pages_shared(__pa(cmd_buf), 1))
+		if (psp_master->vdata->quirks & PSP_QUIRK_ALWAYS_RECLAIM) {
+			if (snp_reclaim_pages(__pa(cmd_buf), 1, true))
+				return -EFAULT;
+		} else if (rmp_mark_pages_shared(__pa(cmd_buf), 1)) {
 			return -EFAULT;
+		}
 
 		/* No need to go further if firmware failed to execute command. */
 		if (fw_err)
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 083e57652c7b..6fb065a7d1fd 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -28,6 +28,9 @@
 #define CACHE_NONE			0x00
 #define CACHE_WB_NO_ALLOC		0xb7
 
+/* PSP requires a reclaim after every firmware command */
+#define PSP_QUIRK_ALWAYS_RECLAIM	BIT(0)
+
 /* Structure to hold CCP device data */
 struct ccp_device;
 struct ccp_vdata {
@@ -59,6 +62,7 @@ struct psp_vdata {
 	unsigned int feature_reg;
 	unsigned int inten_reg;
 	unsigned int intsts_reg;
+	unsigned int quirks;
 };
 
 /* Structure to hold SP device data */
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index d56b34255b97..cae3e7e8f289 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -43,6 +43,7 @@ static struct psp_vdata psp_platform = {
 	.feature_reg = -1,
 	.inten_reg = -1,
 	.intsts_reg = -1,
+	.quirks = PSP_QUIRK_ALWAYS_RECLAIM,
 };
 #endif
 
-- 
2.25.1

