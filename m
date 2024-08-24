Return-Path: <linux-hyperv+bounces-2847-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD95295DB45
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 05:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DD02857EF
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 03:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E17DA6D;
	Sat, 24 Aug 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPx46HT/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9487710C;
	Sat, 24 Aug 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724471379; cv=none; b=DNydp7+oHUj7cwXp5ovAU7dE9l69fY2t+xcqUMpfHDcsy8H7APDnebsMVouMp7cl57LFMIuRNRz6JESLNlinkqz90ZPeXmKa7sqWW0GAOcY17Q9TJ9xppYSP5wywvhG7t8IUL3Jq34S6y9Z7AXCgaezGn/CjVkP8xi/j+Zp/Nj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724471379; c=relaxed/simple;
	bh=BFDbserhlR5cehnbsKBdFA26QrYkt7KdnUxNBUE9LLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK31gnH7NE2sjxhUGpndBlBohVeKwPqbN4SMnFZXOKaF20tkM8gCaGDsu3OgzMt7kEoOOHfDU/GKv93clCw6pZBKKd0O38T8ly2ExfGcU5tKqNPvURd4+kCIk6a2QMJdEEmS7jFv4PWT/y4lZ9t/D/yQ/S8aAIBBM7jl7Tx8Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tPx46HT/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C7hSBdR/JVARfpeK58WO4kcqQWPz9QPRrMIi46F/pbw=; b=tPx46HT/1sF6ukuutt61ki7ry+
	sYLlN62PjveNHfkOHkxK86wIX1nhFj3Q9xUyL1ZLuTJnoDMThRNOynXS6Ck6edZvEpf1ahU9yERW7
	GMeDySrEPv4zatSYrvJx81LzFEjX3rpxznHpV+AahQQ0P7vWq004ZvUw2ismjmohd22gs0FoWSH+9
	1VHJBbL2y4EjO5mIHbttonms8HND50NHigQBFMaliKkv43obWb5xo+fLiV4jd+09evKLFifYpeNsj
	z3+qEvUFtRm8Zc0n+9RHR+o0GuuURlKFb9wy/LIzx0IP79SYsH/ZDyduP+rVIOADd/Hq/y7bPYd4j
	IQj7liPQ==;
Received: from 2a02-8389-2341-5b80-7457-864c-9b77-b751.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7457:864c:9b77:b751] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shhmS-00000001N17-18bn;
	Sat, 24 Aug 2024 03:49:36 +0000
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
Subject: [PATCH 3/4] dma-mapping: don't return errors from dma_set_seg_boundary
Date: Sat, 24 Aug 2024 05:49:14 +0200
Message-ID: <20240824034925.1163244-4-hch@lst.de>
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
 include/linux/dma-mapping.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cfd6bafec3f944..6bd1333dbacb9b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -559,13 +559,11 @@ static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
 	return (dma_get_seg_boundary(dev) >> page_shift) + 1;
 }
 
-static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
+static inline void dma_set_seg_boundary(struct device *dev, unsigned long mask)
 {
-	if (dev->dma_parms) {
-		dev->dma_parms->segment_boundary_mask = mask;
-		return 0;
-	}
-	return -EIO;
+	if (WARN_ON_ONCE(!dev->dma_parms))
+		return;
+	dev->dma_parms->segment_boundary_mask = mask;
 }
 
 static inline unsigned int dma_get_min_align_mask(struct device *dev)
-- 
2.43.0


