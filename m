Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A76942F0
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBMKet (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBMKem (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17166144A1;
        Mon, 13 Feb 2023 02:34:39 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3A2B320C8B73;
        Mon, 13 Feb 2023 02:34:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A2B320C8B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284478;
        bh=seVPAjNfSiYKxnX2j0YblQLtaiY/QQf1dxqHVHTN/Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQaKS8/tWGPsg/vr+lv3W7e7ETHFnqAEdaZn7cwscr/pRpUtFeY5yo4n4AFouND64
         QvKhy7BXBALbt13SRO9CASzhjkwKrgJgvBepCJ9MK6xl3KloUl2x6WuXb0cb6qIY2k
         2F98P3q2k92KEl2+UF5tE+nrqNorqi8OJIFvgbo0=
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
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux.dev
Subject: [RFC PATCH v2 5/7] iommu/amd: Don't fail snp_enable when running virtualized
Date:   Mon, 13 Feb 2023 10:34:00 +0000
Message-Id: <20230213103402.1189285-6-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
References: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
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

Hyper-V VMs do not have access to an IOMMU but can support hosting SNP
VMs. amd_iommu_snp_enable() is on the SNP init path and should not fail
in that case.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/iommu/amd/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d1270e3c5baf..8049dbe78a27 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3619,6 +3619,12 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 int amd_iommu_snp_enable(void)
 {
+	/*
+	 * If we're running virtualized there doesn't have to be an IOMMU for SNP to work.
+	 */
+	if (init_state == IOMMU_NOT_FOUND && boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return 0;
+
 	/*
 	 * The SNP support requires that IOMMU must be enabled, and is
 	 * not configured in the passthrough mode.
-- 
2.25.1

