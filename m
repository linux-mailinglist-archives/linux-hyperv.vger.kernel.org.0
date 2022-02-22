Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6474BFCDE
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiBVPg3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiBVPgI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 10:36:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D7164D04;
        Tue, 22 Feb 2022 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hwGHho6vVoG5zxL+r+gO/HrLW55gSYiZK1xOFy8bPWY=; b=EXbyg4oElbNBCkXxF5PHE19cjU
        Fhh8CM69nTRceyzTldor3WTO4HGvmvQXWPAh2WGra1WaTbxlQ5XzvwoMBUILahCpilzLJA96AAAkQ
        TxbPVjzqLsMLHXjWbfzEQdEzhkxzcS9SI8zzxJt5k4gy+nwhAHszCs3y9seiMTLWuA8wDaiKoiqC5
        R2eiLkkdWQMz990U+MVaVkdNuIk/Vpp0/S/BdvNauv1e7YcyxIPyfk9ydUE1i1051hAU9G59sMV3x
        I/UwQdy2sd/TJAeypMn9AZP0W9cKSL4qQ8b8g2Cf7svHpTJvkKFLcjADA+rDauJKsTjC/CcM8rhTP
        BJ9+5XEA==;
Received: from [2001:4bb8:198:f8fc:c22a:ebfc:be8d:63c2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXCE-00AGpk-IC; Tue, 22 Feb 2022 15:35:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: [PATCH 02/11] swiotlb: make swiotlb_exit a no-op if SWIOTLB_FORCE is set
Date:   Tue, 22 Feb 2022 16:35:05 +0100
Message-Id: <20220222153514.593231-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222153514.593231-1-hch@lst.de>
References: <20220222153514.593231-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If force bouncing is enabled we can't release the bufffers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b433..36fbf1181d285 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -378,6 +378,9 @@ void __init swiotlb_exit(void)
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 
+	if (swiotlb_force == SWIOTLB_FORCE)
+		return;
+
 	if (!mem->nslabs)
 		return;
 
-- 
2.30.2

