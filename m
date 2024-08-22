Return-Path: <linux-hyperv+bounces-2805-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7395BE59
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F27285F97
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC11D0DF1;
	Thu, 22 Aug 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB2gUFjr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297C1D04AD;
	Thu, 22 Aug 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351871; cv=none; b=cYUkhbNOJx4bxcq05TtKDQiO4oW8zlHCDMLFp+XS9hsKxgbDSu2gqrBIwAfTaBFqxe8v6hfzAUtgffMSGn7x7iOOeIe8o0jofb6qH/AE7jWik36PIHE6Jp3zVLy0zQ4XBtVc/GZkZP7YkeyZpVeYO69YoAiQoZ6ZpQu23gwhvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351871; c=relaxed/simple;
	bh=NVFmBvAgubMJWBFshBt0g9Yy9k4ztAxKDlDYqd+NV3E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnDc70wGjR4qf5vfiPK4OWkK6ZCGbVWxulLd8QG+g9xXSPla4QEhkb08mhiP2TUJ9k2BNoiChLOqSO9E7NLYO5NLho1NozurVeHSsYiGDYIZzBewna/TyZ/PCYsfbJDSKKHyCksRjrdbzpIifiPJ1sGwH7GihBSPmiEGEis4yBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB2gUFjr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc611a0f8cso10085975ad.2;
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351869; x=1724956669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=LB2gUFjrgDRg9dMvjS2uMmjJStL4L7Y27GcE99FlX+3ALJfrDoUqyPaDbwpL8z6PKH
         h/sNdX2kcEooPHOdbQJyOiwbmrrvMq/C7KCng8DFXQFYKeY7q7B20eABLmiqLgmGvMSa
         pJ8BmKfgFFyRm6IWHGQAhN+PnDavXUrLIXctmPACc78K465ru2mstDm5XfIwkS2OSsP3
         e/fmoxgKNABtOlnMryQ8F3K0GgXAveP47/jyLDO5cNQJ12joTOwhPLbZCOfx83Ra6DZy
         XSRLd7NwOMCljkZ63yTjYZQK4XoBNEqF/USfUSsCzcvchh5t/sIz3x361X1o7GycyDKM
         uyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351869; x=1724956669;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYiVVcr8/wboBmezLWjDsQm81ttJxTuVeu5qAg4kVjI=;
        b=Y26DNJ7jRn1veU2M4AwyoASvzR4vqwQ3PFkJtRAW73jNdI9vb+4z7vCE6eDMHGYILd
         KfVCFVyUfNGeKc5s9FpqvHxJpNTrrXTcsLfjGe7ib5KBsxCH5eQkJ4iQ5/wEQWJXrpTD
         dmkULtFXE9uKiA8xfFUMTJylCKrqOfoKWfN9ApQlhgh2FB79A0A3L7nyGt+QvoUIptE5
         U+uc5Wn6K3WW81Dgm9n2ciVw3UwmUKQgkD3z7g0+KtcqluuUYe7cOyHVegeZusK6IdkC
         CGcIXaieJIkVkd/0mo7PU9+1b78M+CVHNafVo7jk1/nZDjf+P1HV6hkLGIQ3XmIIrOX0
         s/uA==
X-Forwarded-Encrypted: i=1; AJvYcCVGhm83E9RRflMzYayJQji1mtLF8PyVpiGC68aBVj+JKaRt7YbBdNx91wtUSiiTWhQ0yx+0f+/BqoXfrrE=@vger.kernel.org, AJvYcCVse2JRJVxySDQxGvxUNMWhwvZm4koT14vSKBLOb4LoThZGuVTu0fmqeVulm3cOTsHvnxUfiJN6/I+2tut0@vger.kernel.org, AJvYcCWkjugV6s9oiPLFJMe3A0DXJKMlhPmgge2n0i+H6sxCGtXL8MhR8+sMIKP0TVV+ycSnMGqT5NzJNsrsBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdjjW00piTWCs1Iqu4sKOq8gdypL/4/T1EdNvEPbYBasuZtSU
	4CAjbWxufbfYlaYN8ni/eh/E0MIV7Wq9GpdAKqULgQIazqOLCvfx
X-Google-Smtp-Source: AGHT+IH8+45q6oXd8x8II3Jds1dxAoYSz31lmfPW/kQ0FnzP0cCsfuNQ8sVNo0lwZUKJpv9rCx8MxQ==
X-Received: by 2002:a17:903:228d:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-20367d1394dmr75819225ad.18.1724351869298;
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:49 -0700 (PDT)
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
Subject: [RFC 3/7] dma: Add function for drivers to know if allowing blocking is useful
Date: Thu, 22 Aug 2024 11:37:14 -0700
Message-Id: <20240822183718.1234-4-mhklinux@outlook.com>
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

With the addition of swiotlb throttling functionality, storage
device drivers may want to know whether using the DMA_ATTR_MAY_BLOCK
attribute is useful. In a CoCo VM or environment where swiotlb=force
is used, the MAY_BLOCK attribute enables swiotlb throttling. But if
throttling is not enable or useful, storage device drivers probably
do not want to set BLK_MQ_F_BLOCKING at the blk-mq request queue level.

Add function dma_recommend_may_block() that indicates whether
the underlying implementation of the DMA map calls would benefit
from allowing blocking. If the kernel was built with
CONFIG_SWIOTLB_THROTTLE, and swiotlb=force is set (on the kernel
command line or due to being a CoCo VM), this function returns
true. Otherwise it returns false.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/direct.c         |  6 ++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 10 ++++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7b78294813be..ec2edf068218 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -145,6 +145,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
+bool dma_recommend_may_block(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
 unsigned long dma_get_merge_boundary(struct device *dev);
@@ -252,6 +253,10 @@ static inline bool dma_addressing_limited(struct device *dev)
 {
 	return false;
 }
+static inline bool dma_recommend_may_block(struct device *dev)
+{
+	return false;
+}
 static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 80e03c0838d4..34d14e4ace64 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -649,6 +649,12 @@ bool dma_direct_all_ram_mapped(struct device *dev)
 				      check_ram_in_range_map);
 }
 
+bool dma_direct_recommend_may_block(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) &&
+			is_swiotlb_force_bounce(dev);
+}
+
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index d2c0b7e632fc..63516a540276 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -21,6 +21,7 @@ bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 bool dma_direct_all_ram_mapped(struct device *dev);
+bool dma_direct_recommend_may_block(struct device *dev);
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..832982bafd5a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -858,6 +858,16 @@ bool dma_addressing_limited(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
+bool dma_recommend_may_block(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops))
+		return dma_direct_recommend_may_block(dev);
+	return false;
+}
+EXPORT_SYMBOL_GPL(dma_recommend_may_block);
+
 size_t dma_max_mapping_size(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.25.1


