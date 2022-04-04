Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A204F0EBF
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 07:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377285AbiDDFIa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 01:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377295AbiDDFIZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 01:08:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A735255;
        Sun,  3 Apr 2022 22:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3bKOwa/vIjXDTctiHR3yrY0M3Nyf9zVmyxkMzvumqG8=; b=EB7gLsK0UvHav6B4abhaPvjJm4
        FSQhyO6o0EYvmijqssvR2Q1Gs9e9b7dbZYgZENsl7+jB7rWSFCNAlCbR1TzAA8Q1NVRTUwZMhXAYN
        +T/3Yc95IAf59JX6BzJyzdXMEVJ81KmzgtXkS84pkf42p/XCgBb24+Pe6oBHh6kTieMTt7Nj5y23Z
        wylVK+JE2wcAm+tlJTJmpJJ11tUpLjiTBDIjrztXtkuVK6/+I8gAYxYGF0MZhZA3St6JQ6dVe7QQT
        4i4Fld7CnHSKQSuWGvKwAQtoK98Bi5BCZne67U1mZDxrdJZA+51OSEmE/tuOtZVdA7Qu782BgN/Y9
        QNbBls1g==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEuq-00D8ox-50; Mon, 04 Apr 2022 05:06:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: [PATCH 02/15] swiotlb: make swiotlb_exit a no-op if SWIOTLB_FORCE is set
Date:   Mon,  4 Apr 2022 07:05:46 +0200
Message-Id: <20220404050559.132378-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404050559.132378-1-hch@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
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

If force bouncing is enabled we can't release the buffers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 kernel/dma/swiotlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 73a41cec9e386..98bb0eb44a7bf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -369,6 +369,9 @@ void __init swiotlb_exit(void)
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 
+	if (swiotlb_force == SWIOTLB_FORCE)
+		return;
+
 	if (!mem->nslabs)
 		return;
 
-- 
2.30.2

