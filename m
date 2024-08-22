Return-Path: <linux-hyperv+bounces-2806-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714D95BE5D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0B9283A59
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D51D174E;
	Thu, 22 Aug 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPvtYDEi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF801D0DEA;
	Thu, 22 Aug 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351873; cv=none; b=GecaLQvsCWp1sn3r7gJ4oyx3RdxISjX+gdc9hoasOSFSBShzkg2XqqsMAmEmrdVax8sJ4qtvktNvbGJy7bibFCjZn8kia/AZy1/2WtOGFweOldrr48sQkN8IU3w4U+Ew4Wgsv+5J9dk2NKwSo9byRrx2AtbXy5owhDoT8yj73tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351873; c=relaxed/simple;
	bh=htxc2DqPCapb6n7XzlxbqGRMERf/FZW0+ZevZ0VUTwQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ct6TOn77tv/TX4ffr+dz6LrlAw+vixa46+YiUX8Jvr74pCWaPcKBofVIBpu/lziWdI7WUgJ1argiGuD2kJuAWmH+KC+RuHGV/nMrhBzIA/wdpLeVrWjkDc7f4W9kLsjG1XL2VG/jbuZkq35+l1YPGwSW5PN5De85spkr3RBCqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPvtYDEi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021a99af5eso10369085ad.1;
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351870; x=1724956670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=WPvtYDEixXro0pOMsNsGfzSzierGQTN+12CbTMmNCg44GS74ds/lJJsqRxZKoQnoRR
         x5dVR5GEqxkzIzwjjkg6xD/EQTumLZjAlVjUkHBFE8OCXoWp6eCKg/lqr5ysssKLh+KO
         W5qgAfWPLI2sXqC3s1Oex1LL+xvD/Vu8kfW8tFRu347kwi/4CXC+LEaXppE1ivNLepv2
         lJJCaodLGzWgnX6IKAk4rnokHFFt6VGOw5LfL06cKheouYqDNvQi/9+vQjuxXLRrefQB
         0xXPLl4j4ApA1WyVLbHSzPnUAdQ+ALfceobkEvb9mgTahqzYMdjfJT/8Sem3Uo/BxUH7
         rVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351870; x=1724956670;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/FSttR6p2yucCC2C1ycZHoGqThcAXEf4kSal+8QkByQ=;
        b=QzWasYh0vQYdm43KWY6ofECL8hXzdkAW4zePOfQxCe5IPgMdwjj3n7E+KWa/3oQWsw
         CFicQ6PdXkoKYwrDcGAwqxkfwbBrSASdba4o6hZnnCfeTxSb2K15vnksXNJ0esZCOkDF
         cAlQD0/sPizXpr1NU33AnR/CqdnT2B3r6PBFF1Wgbhb2t/pejLR2wKX5Sgkp4vaWe6jh
         BMfuuMY4+V0REinT1kFmf5Jg5Pzi0se2WsVL8WxaLGWjLlkcpwhEc/KUVKy62Hu3c7q/
         aMG8wBi/CuR8ggw9tbM2AX7mdHWnrajO9OTe5WeBcb3dmJGTj8zPblgBhMgtaUkg58x9
         A2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVL6R8cBoW0QfB/FEmeXUg0HQGbUxisHdylsJxLQWKseu3cCJz910ZpPVDkm+VW8UOB/DmU2MFEzpXd39QP@vger.kernel.org, AJvYcCW8U+PXXNiJSKwvrcELrdxwJQU4TOzZ7WrfatiS45Dd12WHyXoUYm3u7AOYgc+V5kfOROqulU0pClbSbg==@vger.kernel.org, AJvYcCWsFihG8ghEcaOsw+HCWadP8xQdbfRnHYH9FH7ujj2V0GvI0pzH8pvxLk3TgbOo8Pc1IOX1sZ6SJTINVLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBI4X4++yGG+CfEhPOSf85Yg3p59H0pwqHc3S2W/dY8MlWB58X
	A5IJI1FYgCOoER3v+w7aP3zFU9LwpD9RI8bL06k6cyttcDuLzm8R
X-Google-Smtp-Source: AGHT+IG0xFiyyhUEAVqUeNP4awQwMQmb0ao3xlY9kk2g+DZ4RUL1iV7dvaFZrYLPjHsqT4Fbvb/IyA==
X-Received: by 2002:a17:902:ce85:b0:1fc:6740:3ce6 with SMTP id d9443c01a7336-2038822be0cmr36095425ad.20.1724351870494;
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:50 -0700 (PDT)
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
Subject: [RFC 4/7] scsi_lib_dma: Add _attrs variant of scsi_dma_map()
Date: Thu, 22 Aug 2024 11:37:15 -0700
Message-Id: <20240822183718.1234-5-mhklinux@outlook.com>
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

Extend the SCSI DMA mapping interfaces by adding the "_attrs" variant
of scsi_dma_map(). This variant allows passing DMA_ATTR_* values, such
as is needed to support swiotlb throttling. The existing scsi_dma_map()
interface is unchanged, so no incompatibilities are introduced.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/scsi_lib_dma.c | 13 +++++++------
 include/scsi/scsi_cmnd.h    |  7 +++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib_dma.c b/drivers/scsi/scsi_lib_dma.c
index 5723915275ad..34453a79be97 100644
--- a/drivers/scsi/scsi_lib_dma.c
+++ b/drivers/scsi/scsi_lib_dma.c
@@ -14,30 +14,31 @@
 #include <scsi/scsi_host.h>
 
 /**
- * scsi_dma_map - perform DMA mapping against command's sg lists
+ * scsi_dma_map_attrs - perform DMA mapping against command's sg lists
  * @cmd:	scsi command
+ * @attrs:	DMA attribute flags
  *
  * Returns the number of sg lists actually used, zero if the sg lists
  * is NULL, or -ENOMEM if the mapping failed.
  */
-int scsi_dma_map(struct scsi_cmnd *cmd)
+int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
 {
 	int nseg = 0;
 
 	if (scsi_sg_count(cmd)) {
 		struct device *dev = cmd->device->host->dma_dev;
 
-		nseg = dma_map_sg(dev, scsi_sglist(cmd), scsi_sg_count(cmd),
-				  cmd->sc_data_direction);
+		nseg = dma_map_sg_attrs(dev, scsi_sglist(cmd),
+			scsi_sg_count(cmd), cmd->sc_data_direction, attrs);
 		if (unlikely(!nseg))
 			return -ENOMEM;
 	}
 	return nseg;
 }
-EXPORT_SYMBOL(scsi_dma_map);
+EXPORT_SYMBOL(scsi_dma_map_attrs);
 
 /**
- * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map
+ * scsi_dma_unmap - unmap command's sg lists mapped by scsi_dma_map_attrs
  * @cmd:	scsi command
  */
 void scsi_dma_unmap(struct scsi_cmnd *cmd)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 45c40d200154..6603003bc588 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -170,11 +170,14 @@ extern void scsi_kunmap_atomic_sg(void *virt);
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
 void scsi_free_sgtables(struct scsi_cmnd *cmd);
 
+#define scsi_dma_map(cmd) scsi_dma_map_attrs(cmd, 0)
+
 #ifdef CONFIG_SCSI_DMA
-extern int scsi_dma_map(struct scsi_cmnd *cmd);
+extern int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs);
 extern void scsi_dma_unmap(struct scsi_cmnd *cmd);
 #else /* !CONFIG_SCSI_DMA */
-static inline int scsi_dma_map(struct scsi_cmnd *cmd) { return -ENOSYS; }
+static inline int scsi_dma_map_attrs(struct scsi_cmnd *cmd, unsigned long attrs)
+						{ return -ENOSYS; }
 static inline void scsi_dma_unmap(struct scsi_cmnd *cmd) { }
 #endif /* !CONFIG_SCSI_DMA */
 
-- 
2.25.1


