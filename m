Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA84C94B4
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbiCATrM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiCATrL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7961C6C947;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 23A3520B7188;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23A3520B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163990;
        bh=d7flK6DTAH4K/8AvhJPZUlMO2bWVUd8vNwXQiXnMMWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsj9iNpSw0BDb8TUlWvxRAA+GEbids65zPPqkAmeWGHPGUGNdL6iK5kUFOwTBqil6
         5MfmuuNXwOpPNGOnxEM7I8DWsIg2I48G6iJeb3JBgXswoiqZ05p2dTE325K3mNvARW
         yb/4iLUmuWQKMi6qcxLkC/UcvcdEHShn7fj0R1xQ=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 01/30] drivers: hv: dxgkrnl: Add virtual compute device VM bus channel guids
Date:   Tue,  1 Mar 2022 11:45:48 -0800
Message-Id: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646161341.git.iourit@linux.microsoft.com>
References: <cover.1646161341.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add VM bus channel guids, which are used by hyper-v virtual
compute device driver.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 include/linux/hyperv.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b823311eac79..9d21055b003d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1414,6 +1414,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
 			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
 
+/*
+ * GPU paravirtualization global DXGK channel
+ * {DDE9CBC0-5060-4436-9448-EA1254A5D177}
+ */
+#define HV_GPUP_DXGK_GLOBAL_GUID \
+	.guid = GUID_INIT(0xdde9cbc0, 0x5060, 0x4436, 0x94, 0x48, \
+			  0xea, 0x12, 0x54, 0xa5, 0xd1, 0x77)
+
+/*
+ * GPU paravirtualization per virtual GPU DXGK channel
+ * {6E382D18-3336-4F4B-ACC4-2B7703D4DF4A}
+ */
+#define HV_GPUP_DXGK_VGPU_GUID \
+	.guid = GUID_INIT(0x6e382d18, 0x3336, 0x4f4b, 0xac, 0xc4, \
+			  0x2b, 0x77, 0x3, 0xd4, 0xdf, 0x4a)
+
 /*
  * Synthetic FC GUID
  * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
-- 
2.35.1

