Return-Path: <linux-hyperv+bounces-2809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D7695BE66
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6ACB2813D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9371D2792;
	Thu, 22 Aug 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHW2lTJA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64191D04A3;
	Thu, 22 Aug 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351876; cv=none; b=sea4+MYfz5p9fgxsPi1gLdkeyaKmsvvml9/KpAgac8djYPvMm0RXsqD37T35J7ILqoto4aY9I2zn+VEHMfTiEL9vDIcCm1qdWov80moO1EXTtJb0LLRiszl4i1TFtqTANy6UFEmTNwTq++c2TVuvx4EXne9eNCNYHBGULtaI3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351876; c=relaxed/simple;
	bh=vZUjHFmFvrYfCCwn47JEj2O7xPIiU/Pgnb18WTQj4is=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsxOE+WsGBQ2KA6WPGpQJ3Qt/jPvGTChFdWvgT7E/pNBmK8FZvzewg4PNw7APvaHM4SIH+HcJGmhpOWnvX4tKRzMn9I9NGvqqGG+l4sS2RlgFAmCFAmXYRz/odaeKVNJuE6woZHKJw7gZOwevrDlBRBNUCbAPJMkf3RHLGtgJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHW2lTJA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fec34f94abso11359465ad.2;
        Thu, 22 Aug 2024 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351874; x=1724956674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=LHW2lTJAldE/Uz5Y5H0xOGSRgixDn/dgr6L7llcRddcOvgO+ccohnvpForui0qSCbA
         V/f8pci7cnQpRFFHwcxtSwtzPeRx4Obkl72eKKpYFHu8/bVigNwNj63kFs4IDhutsJmE
         9ix7gy5DROKtaNfgqx4wHYWBWujZdwVjEMD1d4Ui+8jVlRzovHpQwWij1nJ3aIDOPRtb
         Oe46MiUmVKrDU7IPhKteXV6Pq3OdJYdASSr+0WNl7y0Rn2zSREEymGvWuR93gVfSmSMD
         +10mHbL1e9XyTOqDEvua/1wldrFy0SOPamrl4h2PSnSbMBSUhrqddFY+7ldtj3RI3JKR
         wH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351874; x=1724956674;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Hlc/i1KYMFZn1UW3B36jY0bAKWAgeG5KXhGYCaItEQ=;
        b=Am7GoIg9w2ciNZz5osSW596XcE9zFFxRhrbaxb9TMzHmnu/Vr3I7v6eCEEmAMIk66Y
         NpdUEhp8TjosYKDsKTQQIfVJ1zNIbQzkBC8FNu8swPupQKTSNC2BQPC+mmmb5pebw7tA
         70Jfa4RVKyKYjmZfmir2IKaXjM/GJpfXTqOUJN0Vf7PjHvbo3nWWv/6DNzmVR5ZG9UjJ
         0l3dahQKZoEEEqDcVEKqCxBEs4XKkXSXIfSyAGkCLc6MP6aTieEeyePARvx86DHa5szt
         onC8urdThoTpElQyJe3SPLstx4T3+p4gZqMANn9EQLk91vzc7bODdMR+O/KMUjeyW8hY
         4GzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV823huBSNkDOulcDn43oz44jRs9dU8MDClv8GMX+abz8EHCGjlyZSaczzxOrv18P+VIWCuShYiryF3Sjo=@vger.kernel.org, AJvYcCVumV+b/QqllqIC1q4/7dQcuwf45Bc9NesCLGeVA1QUYBPeUPFKF9Syv+0qYb2ypUWV7e1mB/Y2QaSOww==@vger.kernel.org, AJvYcCXw8uxrs0l8OQ8ezRgBb+679gZqSICoReU1PMxiHWuXysQ4WNgo7VkuB8sM5dtMv84WxxgyHDEDZa4enGXd@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiavsOizqcw2BtifTbWGO1oVdGygi/9LceJ6nGyEuVKTNdcrd
	RneB80kQJL9cAJDN1kco8xj+Z/B5Ll61FP6YR3zbT7dMHYWpg9J+
X-Google-Smtp-Source: AGHT+IE+oTsuXbaq9ZvaSNrcslYkvt3uX+Tvp8+A11rBrdRfV8hOJKmntJKX/3gWBiFYZVMV3hYEuw==
X-Received: by 2002:a17:902:d2ce:b0:202:13ca:d73e with SMTP id d9443c01a7336-20388240fbcmr30142745ad.28.1724351873947;
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 7/7] nvme: Enable swiotlb throttling for NVMe PCI devices
Date: Thu, 22 Aug 2024 11:37:18 -0700
Message-Id: <20240822183718.1234-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM, all DMA-based I/O must use swiotlb bounce buffers
because DMA cannot be done to private (encrypted) portions of VM
memory. The bounce buffer memory is marked shared (decrypted) at
boot time, so I/O is done to/from the bounce buffer memory and then
copied by the CPU to/from the final target memory (i.e, "bounced").
Storage devices can be large consumers of bounce buffer memory because
it is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

For Coco VMs running with NVMe PCI devices, update the driver to
permit bounce buffer throttling. Gate the throttling behavior
on a DMA layer check indicating that throttling is useful, so that
no change occurs in a non-CoCo VM. If throttling is useful, enable
the BLK_MQ_F_BLOCKING flag, and pass the DMA_ATTR_MAY_BLOCK attribute
into dma_map_bvec() and dma_map_sgtable() calls. With these options in
place, DMA map requests are pended when necessary to reduce the
likelihood of usage peaks caused by the NVMe driver that could exhaust
bounce buffer memory and generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..2c39943a87f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -156,6 +156,7 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+	unsigned long dma_attrs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
@@ -735,7 +736,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
 	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -754,7 +756,8 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
@@ -800,7 +803,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 
 	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
+			     dev->dma_attrs | DMA_ATTR_NO_WARN);
 	if (rc) {
 		if (rc == -EREMOTEIO)
 			ret = BLK_STS_TARGET;
@@ -828,7 +831,8 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req),
+					dev->dma_attrs);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -3040,6 +3044,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * a single integrity segment for the separate metadata pointer.
 	 */
 	dev->ctrl.max_integrity_segments = 1;
+
+	if (dma_recommend_may_block(dev->dev)) {
+		dev->ctrl.blocking = true;
+		dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	return dev;
 
 out_put_device:
-- 
2.25.1


