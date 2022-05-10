Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F7521D3D
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbiEJPAE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 May 2022 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345257AbiEJO7y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 May 2022 10:59:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72121496BE;
        Tue, 10 May 2022 07:21:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r192so10588463pgr.6;
        Tue, 10 May 2022 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/+VFEBe/LSPrTXVeYivM+3OUMTgtuIGywMyZxhof3k=;
        b=O6L52kFHagR46TJPmGCxbhTD7MAV7fRTV88+fu1qZh1PExXXRlTvUD8pwrqgsK1CoA
         6pQrsxXG/Ex/lsGUHN7nwxR1VOR5hGDzwetXGkCxfKRcJ+DgqVj1KspjlaUIBg7bB8oU
         tHB4VF8+qxlxUsBuPiYrg8ijAOb31n+sx64wgYOpqZEImZl2QiXSbMeqP9wyRe1jTKmi
         jsv7v1eED4sOxITiEBM8h8d7xZkNV2jNcnGFeFBwN1QJdS/7yhUfYf3ZmEVvM+UmfMps
         QBcfB7v6uPUEldWhB0LYC/mu6FWEIC2mA3hgWxuXXeF0c9jwq475Wsqqrv+oAnvkzf8H
         cEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/+VFEBe/LSPrTXVeYivM+3OUMTgtuIGywMyZxhof3k=;
        b=NfpKqL8H6F4iV5AX+/AJ+bjMyRXcalGu/biMl81nPLmvxofNgChXW+UAnsh323iiie
         20ZrZ+A+sBQkVxHWIfe/SBHSoWUu3/cuIRUObX+NBOZvaJuOUrNrrVM/sek7XpFWuCJb
         n1S9J4GgDlXMmfYhZu531VMrSOwW45Cuix4rUYih5NaNWC6FPyBhojFKyq9XXJ8msfhc
         YF+lG2xptaPAcHmZoPBblqdxTVgBzHW2aHQGJvpn09Xe9DUmjXV9anPCbkuw1esQSUjc
         cWmGnnIdicVBm+g+L7s3PobLWPU+MLDKlyrAYZS7y25E01bkMgcH3aOb++l3OMM3IPF8
         jcxA==
X-Gm-Message-State: AOAM533/ZcRjYZbt24rGqXmt5Qiguwe9150rHTnwhzTU154F4vHyygkx
        DDcP94WHyCAHwdUGIw5q52U=
X-Google-Smtp-Source: ABdhPJy97bolhJvIHOqV7+NcNzzrZ2GCZ5C6CuQaXVigvumxvAKUDd/RIyzO41HHMysQeVCx64xC2Q==
X-Received: by 2002:a05:6a00:1acf:b0:50e:1872:c6b1 with SMTP id f15-20020a056a001acf00b0050e1872c6b1mr20763004pfv.76.1652192476948;
        Tue, 10 May 2022 07:21:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:6c3c:3386:3925:381a])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b0050dc76281d8sm11031647pfh.178.2022.05.10.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:21:16 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        vkuznets@redhat.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: [PATCH] swiotlb: Max mapping size takes min align mask into account
Date:   Tue, 10 May 2022 10:21:09 -0400
Message-Id: <20220510142109.777738-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

swiotlb_find_slots() skips slots according to io tlb aligned mask
calculated from min aligned mask and original physical address
offset. This affects max mapping size. The mapping size can't
achieve the IO_TLB_SEGSIZE * IO_TLB_SIZE when original offset is
non-zero. This will cause system boot up failure in Hyper-V
Isolation VM where swiotlb force is enabled. Scsi layer use return
value of dma_max_mapping_size() to set max segment size and it
finally calls swiotlb_max_mapping_size(). Hyper-V storage driver
sets min align mask to 4k - 1. Scsi layer may pass 256k length of
request buffer with 0~4k offset and Hyper-V storage driver can't
get swiotlb bounce buffer via DMA API. Swiotlb_find_slots() can't
find 256k length bounce buffer with offset. Make swiotlb_max_mapping
_size() take min align mask into account.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 kernel/dma/swiotlb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 73a41cec9e38..0d6684ca7eab 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -743,7 +743,18 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 size_t swiotlb_max_mapping_size(struct device *dev)
 {
-	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
+	int min_align_mask = dma_get_min_align_mask(dev);
+	int min_align = 0;
+
+	/*
+	 * swiotlb_find_slots() skips slots according to
+	 * min align mask. This affects max mapping size.
+	 * Take it into acount here.
+	 */
+	if (min_align_mask)
+		min_align = roundup(min_align_mask, IO_TLB_SIZE);
+
+	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
 }
 
 bool is_swiotlb_active(struct device *dev)
-- 
2.25.1

