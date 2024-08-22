Return-Path: <linux-hyperv+bounces-2808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42B95BE63
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D38B27D54
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D981D1F69;
	Thu, 22 Aug 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWoyRjoO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FF1D1731;
	Thu, 22 Aug 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351875; cv=none; b=Ft5rmdTecV3hWsvpT1sf3q0EazCULkU8kD2f2YHcnJCIAM+EJN0j59DtHzWFwkP/RVuPhiPKxeeEzOl310Yjda/5jPPfK24L/GW/m9zNeCoGFBa35rR7yrH4Ir8EjYqVzyTsIFe4yspNtEm2jSCDOM5V9YGeG+HwqRgxJG7L09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351875; c=relaxed/simple;
	bh=h7/QaozXkfleYoirlRN16+9s8z8TVAPkUO7bp7owxBs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzjP1Up18RCsTZzo8oQgvCOMBvLE2/6Er++9/m1bBd0BrHhW6d4BC1UJHK6gscVY05KJaRSA4USZ4xcxlLuydOVls1v6VtbNpm7ytVGphyn0pBDPXLk3W6TqBD26iPTwgzaeiPYTQ7hk2Sa9UAaIg6tJW5sjYMr9ZRh2JzwwTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWoyRjoO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202508cb8ebso8578655ad.3;
        Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351873; x=1724956673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=cWoyRjoOdU1PCtjbfKWdEKBmTqMJr5AIkGJLWFS0HTb1eNf+BIFtH4hvUT/ddiWeV1
         Z5/yohspZdjekhfBBEmQBY4SEuxw2U3YJjig1h/GBkFcCxE+wFwVYg4roqCnGxlF5FkR
         N71qV4auGHqHJSSx43UpV5474hAkG9VveNUwHK2rDhF7W9Lbaj1+3DbXiuP4msgI4xqr
         pvYNCvXLoafJUGSoR+MASI8u8yiNOe+0O/0mcccaip3k/3tjDy1rwrbwvos4tAqvaBth
         Uwf8x+4Q+ivuhIo0Tzfmn/Gv06eCOdwyiIA1l2ntG650z1Y3J9PYvJDk26qtQX4c8cPT
         UgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351873; x=1724956673;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=J/TlfNdg52M3iaoaRCZYvaML//W1O6+LooRuyWEPUe496gU8MIqMyyeF4Zw1nzN15G
         TDPpFL3CFtblM8kyt77V8fkd3QkjVRWNUKO+u+Tf7KfbBuZ3S3vCqPq5ft/NHNtVKVeA
         RmRx9HXiRH/48FR2D8+fEeM0PBIaVflWfSWZOhc9QFFVm3jfVsR8qMmgmmACa26S/MTg
         rJmCDXUdSXy9unqfgK38Ryvr7gGDVNO/e1+hTQdrIrr71Uam94DQ60RU6x0HzMgiE1Rj
         6sEiYcaWGHs4dZwgMxpwYUWbwiDCrThy+3pG63ayC4rMfF8bqjCo2GpSBVJLIUovmp4I
         rMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzzKznzgNTwDmOWmvcR4m+OmK3pGt0H/JyGpCyQ/P049/NTNW3f5UxZgMotb4ZUefnJ0mD7KQsawikCno=@vger.kernel.org, AJvYcCVFFlfVanqWCvyAQWzU0g4jL0c9cL9nsvSMNU2bCcXIQBRVaPMNGC0xWQRi+XseLa/S7ZEa1PuFRY8KDg==@vger.kernel.org, AJvYcCVpO/r1qDnTJPVXURWpIu9d2zxsp3j7xJTZRgnJY3n33DV/tecmlGVGH3zcDLXysDhxpr2lgzMOG656Z+40@vger.kernel.org
X-Gm-Message-State: AOJu0YyznbbK6v7iFa94a3rxwF9xGZ/rUDlNjgWsSp3mcUYgx2QZ0tcs
	FxT/RSajwX4tR6KGyjbokelxTF4NtbCWvAHKDihyq8TkGvdxfmP1
X-Google-Smtp-Source: AGHT+IHsbZYUaJ+JFNxFtzKvzmApZirKvGrVSmexHXzuMk4WrKRW/BVna5OKSIa9Rz2aGy+9FiDPnQ==
X-Received: by 2002:a17:902:e84a:b0:202:1529:3b01 with SMTP id d9443c01a7336-20367e651d0mr80002225ad.39.1724351872813;
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
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
Subject: [RFC 6/7] nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
Date: Thu, 22 Aug 2024 11:37:17 -0700
Message-Id: <20240822183718.1234-7-mhklinux@outlook.com>
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

The NVMe setting that controls the BLK_MQ_F_BLOCKING flag on the
request queue is currently a flag in struct nvme_ctrl_ops, where
it is not writable. A new use case needs this flag to be writable
based on a determination made during the NVMe device probe function.

Move this setting to struct nvme_ctrl, and update the only user to
set it in the new location.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/tcp.c  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599ad..f1ce325471f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4495,7 +4495,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
@@ -4565,7 +4565,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size,
 	set->driver_data = ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5314d32943..28709f166cab 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,6 +338,7 @@ struct nvme_ctrl {
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
+	bool blocking;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
@@ -546,7 +547,6 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
-#define NVME_F_BLOCKING			(1 << 2)
 
 	const struct attribute_group **dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ea6be0b0392..6b9fdf7dc1ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2658,7 +2658,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.name			= "tcp",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
@@ -2762,6 +2762,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret)
 		goto out_kfree_queues;
 
+	ctrl->ctrl.blocking = true;
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
2.25.1


