Return-Path: <linux-hyperv+bounces-2807-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8BB95BE5F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D91F257C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 18:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289711D175F;
	Thu, 22 Aug 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTIeQng3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB71D172E;
	Thu, 22 Aug 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351874; cv=none; b=r0h7pHuI6AM974cgK9k9kfMwPTYSfhN+m0ady8cZs8BzNQKnOvUm2qeYxaPce5cyTFapGaQaQnFkmtr9+ROpKNSo3NW4bq+p2V5TLpuO+3nJi8A9DKirb/i5WQ7fO9uQx0q7Ji6RsFQHOkzPs94ClqA//u8Eo5Gck1U7qxpmZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351874; c=relaxed/simple;
	bh=KQxA10ny3y7ONujVrMwgPmKcFbuUbkjllbN6PgK2qYA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nguua3ER5QJZxL8TjvUabpbFhgXBIaJKZLgJwKDt0fKyrFSsYjQ6YdYP7PFoPgoD5t9tmpHbharJaqwgkjf0qBqeAv53XP2x4cyxtk/81DY0FdZfm+QQ7/iXTvslUTLisnVXho46V+DoYihdVdxvFlmDdTVqUx8UID/LSAZtCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTIeQng3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20203988f37so11041895ad.1;
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351872; x=1724956672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=ZTIeQng36gCA1l50QZUdCs/jcsqPwQA6v6XwDoIvuQtBpMRFflLWzazyeKh8IbFVgV
         5X3fiN4DabtNM5eoZLA6rk3lFXvTLxjmceyOpWcK+csNdv91xGlvGbB1ZZJT88rM2zp1
         KbsD812IoK/w/2QbtVtSghLcf8cFeh1f+kGO46hYV6jvieH+muOcxg9HGgmGQrfsbRTI
         dtMteyrCox4BQGoiiIcgv2mZfjta1IhbPC4iV6OvK+PIleImPFXaUawtKN7MUgM1JNbU
         OaID+1zl5C2B1EgXKg2rJVX0W7TUEQA1Q3j3nKeYZ/qPeswygSAs/I+y9DmLmL7Pdd/F
         C87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351872; x=1724956672;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JDb2lC6vkxiQiFZDx7okJ0uyYWyOojJCyTq1IY1j8o=;
        b=RfhOSm3CekJXt5KaWw0vPfvE+JieM79ON4/kfTzrIEBG8ZKnng76xikZ5LIefZaMOP
         ngej+2a5s120OPsB1wov/gUtl/hJtKWHg+RQ6AvyneeNAHRW5iJAUQaxN2DpeMfeSiKW
         CjQ8npB5tQmYTfAM1ercvq4TXSy+A0hNu16cEEIbaaQg0w3hpNlCzI3Fj2IQoYo0ytKr
         v0geG++MMtsVsIv+bgWGK+VjV+szYKFnzTQ+qUyYGUzILvVy2tJ4+05amDKRtFggk6JL
         ZXL5BWbBmexpfGhqYQd7TDcmitfM9LVuSFZbGbqRoAKoK9kFixVoFKhGh2/betewWXem
         MBJg==
X-Forwarded-Encrypted: i=1; AJvYcCUnIFPWpAWX6HMQ764cC60jqmQ3aF0dQdGFfnjSjAmT2V/7Up0GmlV+qG/WNSSpfWRo0Q7Uj2VCkZIbwA==@vger.kernel.org, AJvYcCV3fu8XaGZkZJrlskfLd3mZwJJyPXPAbbp8fypFYhAigtstdddasClmMZ4AJywMJFhkZIx34Ly7SZTFCmI=@vger.kernel.org, AJvYcCWourzPtJ+nbYPWZG/E4yr+CsYl45qQTgMm9MtcwtfFXLxUSAiDwb+q6LlIpLlp6d6Y+HgNQV7bKPmtFLSy@vger.kernel.org
X-Gm-Message-State: AOJu0YzqO/8IczjN9xr/Qr6ECWwnM56cwKHSOUftaV5QVpjI7V+x2Llr
	wsfULn+wx0oNn/OVps8q2QgSYeVePiEjU/1JWTSvW5OI3NMTPgyk
X-Google-Smtp-Source: AGHT+IEoJ1gpzNrcpekG/3JPJrpxwsytoY1vLLalws9b/ZRPgjfwB0Ov7rhSrw2br36PLdiErGBT6A==
X-Received: by 2002:a17:903:1cc:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-20367d32768mr57195805ad.4.1724351871710;
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:51 -0700 (PDT)
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
Subject: [RFC 5/7] scsi: storvsc: Enable swiotlb throttling
Date: Thu, 22 Aug 2024 11:37:16 -0700
Message-Id: <20240822183718.1234-6-mhklinux@outlook.com>
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
Storage devices can be large consumers of bounce buffer memory because it
is possible to have large numbers of I/Os in flight across multiple
devices. Bounce buffer memory must be pre-allocated at boot time, and
it is difficult to know how much memory to allocate to handle peak
storage I/O loads. Consequently, bounce buffer memory is typically
over-provisioned, which wastes memory, and may still not avoid a peak
that exhausts bounce buffer memory and cause storage I/O errors.

To solve this problem for Coco VMs running on Hyper-V, update the
storvsc driver to permit bounce buffer throttling. First, use
scsi_dma_map_attrs() instead of scsi_dma_map(). Then gate the
throttling behavior on a DMA layer check indicating that throttling is
useful, so that no change occurs in a non-CoCo VM. If throttling is
useful, pass the DMA_ATTR_MAY_BLOCK attribute, and set the block queue
flag indicating that the I/O request submission path may sleep, which
could happen when throttling. With these options in place, DMA map
requests are pended when necessary to reduce the likelihood of usage
peaks caused by storvsc that could exhaust bounce buffer memory and
generate errors.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 7ceb982040a5..7bedd5502d07 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -457,6 +457,7 @@ struct hv_host_device {
 	struct workqueue_struct *handle_error_wq;
 	struct work_struct host_scan_work;
 	struct Scsi_Host *host;
+	unsigned long dma_attrs;
 };
 
 struct storvsc_scan_work {
@@ -1810,7 +1811,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-		sg_count = scsi_dma_map(scmnd);
+		sg_count = scsi_dma_map_attrs(scmnd, host_dev->dma_attrs);
 		if (sg_count < 0) {
 			ret = SCSI_MLQUEUE_DEVICE_BUSY;
 			goto err_free_payload;
@@ -2030,6 +2031,12 @@ static int storvsc_probe(struct hv_device *device,
 	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE.
 	 */
 	host->sg_tablesize = (max_xfer_bytes >> HV_HYP_PAGE_SHIFT) + 1;
+
+	if (dma_recommend_may_block(&device->device)) {
+		host->queuecommand_may_block = true;
+		host_dev->dma_attrs = DMA_ATTR_MAY_BLOCK;
+	}
+
 	/*
 	 * For non-IDE disks, the host supports multiple channels.
 	 * Set the number of HW queues we are supporting.
-- 
2.25.1


