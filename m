Return-Path: <linux-hyperv+bounces-2845-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AA95DB34
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319D1B228E6
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5842056;
	Sat, 24 Aug 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3/wz9G3C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB939FE5;
	Sat, 24 Aug 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724471374; cv=none; b=jz4egL28He8Ebo6HecAbrgJyZVA+hpfvunB2oS+P2AUmN1yVBG5fyWcXEPaPHLiv5bzjl78R8gMwAiyS+HFNC853QhrxYLB7Y3QgnWplN9+52BDg+5NVeWwIoie2q/3VsHr7IJWhrxMqezvv9Y5xQqvCcLgRS27weDp+ucHCjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724471374; c=relaxed/simple;
	bh=W+BTQ+nxZBGc/cI81wPerQQUGcBXhYVL8GzJKPd51Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZEBA4N5xwEnKxxwQd+L1M+dMLpkc3EdC0Fivj6yrqg+bWxFc4vkmIWEfD/UGVwfG5omOBjEaHW58KIbwDytQlGthMeFQafWsmd1XKUBbOR/8L/BuuuKtO3c+333TfdaFdmQhZyPndDI6O6GHsSw3WEmOVqIN6FuFdtc2P2OeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3/wz9G3C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hfCFH7RPHdPA6U8oxZwM/RzFKw4srQhejXrAt6uaIy8=; b=3/wz9G3CM/7zwOw+geH+3HijIX
	cgRSROcz97yOSL7g5QA59ZHHQTGTMTrLnBSogzHi6HhvO2ymO6GbZihU8VNaYatUN7nOc36JOTCzG
	nv9v6zxENuJIXEGTG6xiIkCBcQD/zvFVoHGQR2dfVcdpBGimBGrAhzDIqn0pDuzWAWDyXWErGcyCZ
	/G5zCzSvZesYxU3tkQGvOQ513LzCGjfxlDDtS4+HfGH/JxUFBCdd26G7OSLD5F+di+wI1q1S8yUvT
	YDwvZT7nd/jKD3ZHfdFIKToJqstLH63TCtL78pykSJHnWMBU+mgwk4i4n0iLR9epU0+4FDQYmFILL
	zpFmyeCQ==;
Received: from 2a02-8389-2341-5b80-7457-864c-9b77-b751.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7457:864c:9b77:b751] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shhmM-00000001N07-2TWU;
	Sat, 24 Aug 2024 03:49:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/4] scsi: check that busses support the DMA API before setting dma parameters
Date: Sat, 24 Aug 2024 05:49:12 +0200
Message-ID: <20240824034925.1163244-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824034925.1163244-1-hch@lst.de>
References: <20240824034925.1163244-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

We'll start throwing warnings soon when dma_set_seg_boundary and
dma_set_max_seg_size are called on devices for buses that don't fully
support the DMA API.  Prepare for that by making the calls in the SCSI
midlayer conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3958a6d14bf457..7f0394c4492033 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1988,8 +1988,15 @@ void scsi_init_limits(struct Scsi_Host *shost, struct queue_limits *lim)
 	if (shost->no_highmem)
 		lim->features |= BLK_FEAT_BOUNCE_HIGH;
 
-	dma_set_seg_boundary(dev, shost->dma_boundary);
-	dma_set_max_seg_size(dev, shost->max_segment_size);
+	/*
+	 * Propagate the DMA formation properties to the dma-mapping layer as
+	 * a courtesy service to the LLDDs.  This needs to check that the buses
+	 * actually support the DMA API first, though.
+	 */
+	if (dev->dma_parms) {
+		dma_set_seg_boundary(dev, shost->dma_boundary);
+		dma_set_max_seg_size(dev, shost->max_segment_size);
+	}
 }
 EXPORT_SYMBOL_GPL(scsi_init_limits);
 
-- 
2.43.0


