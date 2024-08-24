Return-Path: <linux-hyperv+bounces-2846-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D195DB3B
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D2D285289
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C561FEA;
	Sat, 24 Aug 2024 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQjhwG5q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08C54656;
	Sat, 24 Aug 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724471376; cv=none; b=KlQMarhQKbT04cY7cfd82clcECogOEGJB4xI5+RITqSOipmavrJZv0u0pE8IAWcdUMcdN7gRBr5DM/RnzrOEpD217Pwi3mBLmE1yesxh9tYNct8FcAdDdrIw8rtsK6cDI+qI8uua4U+ODUPW/JADUJGqNZ3pDUQeneJgRrcoXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724471376; c=relaxed/simple;
	bh=EjXTttXNsoLvanbwHwjv3u35NP/R2A0QOQfw9VKz73c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOTpQyRwvHRas2L8k5G68f8fPsjkLb+051gMYOPnd5ZuBz2+P5WtlY5d5Ehi7e5/Lrdx1lPOrDQpQ+RU7vgoS0Ihw3awyxXJIVxRAzFHDwzLxG+kCfVu+6QapDCyTHGa1GXWoVRV4SijZmaDJZYIftf4oaOg6sDqINng8D4S1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OQjhwG5q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D9jVhl7oJxULjz2/rXwXfEOWQLpDc7NeMcx1BhhLUUk=; b=OQjhwG5q0Syjaw8wq3XKSQxyzK
	F9hdV5VMIlZ4OpNOBRpUW4cP4Uov5jWpPSM3Ymnyux9uaOqRperERaJvNp5R7Ejwlg/31yHfe/18/
	LDmv+Pc3eS9ZmLURoaAkGj5/EWBm5E/57XTEaSKR6lv7FfaxTScBeGXi+kCY//jkX6+8i4CyV5/bW
	EiNNAAArjhjZm3nvjgwJlHca2s/RtGgqlkF88XC2YnoNxd/m4g8/WpQMk2XG7bKxwmXIlKo4tp65X
	HyB+AI9FHIqoC5DkZ5Tmg5FOGfaNnqGRJYY6IjwTw/Tb1ncGAjYwXnGhfrt63FxkvdxHxOUFIVmhY
	aGsZkdBg==;
Received: from 2a02-8389-2341-5b80-7457-864c-9b77-b751.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7457:864c:9b77:b751] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shhmP-00000001N0f-2L3A;
	Sat, 24 Aug 2024 03:49:34 +0000
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
Subject: [PATCH 2/4] dma-mapping: don't return errors from dma_set_min_align_mask
Date: Sat, 24 Aug 2024 05:49:13 +0200
Message-ID: <20240824034925.1163244-3-hch@lst.de>
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

A NULL dev->dma_parms indicates either a bus that is not DMA capable or
grave bug in the implementation of the bus code.

There isn't much the driver can do in terms of error handling for either
case, so just warn and continue as DMA operations will fail anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-mapping.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f2c..cfd6bafec3f944 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -575,13 +575,12 @@ static inline unsigned int dma_get_min_align_mask(struct device *dev)
 	return 0;
 }
 
-static inline int dma_set_min_align_mask(struct device *dev,
+static inline void dma_set_min_align_mask(struct device *dev,
 		unsigned int min_align_mask)
 {
 	if (WARN_ON_ONCE(!dev->dma_parms))
-		return -EIO;
+		return;
 	dev->dma_parms->min_align_mask = min_align_mask;
-	return 0;
 }
 
 #ifndef dma_get_cache_alignment
-- 
2.43.0


