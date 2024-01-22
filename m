Return-Path: <linux-hyperv+bounces-1461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B096836E23
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269611F25317
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5803DBAE;
	Mon, 22 Jan 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpF1WIcn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0553EA65;
	Mon, 22 Jan 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943415; cv=none; b=THRIgeDaF2JEFgSuRoWxxvKx6Isn2Gd0d6uF2gXdlxoxcNUByq3NNDQmVhNq1pfudNt+eYqCXf3XuY6xNzvLz3jdtbVo2qzN4eWMfFCUEisahvhgxpyWfMBpl+VwPdjClgMqUEprLYQXtm52dcNr1tSYWwrY4K/l4arGxf6Iiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943415; c=relaxed/simple;
	bh=hg6YVFiUag7Jpn+ogfj/fOty689o28bCOhcvA6bAVyM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LQ471mR9+Kuri/77n7RBRcNHRDCGx749ilcnpqwtw01YAL2vFjQugTADWjQGIb7GYEGc5BC7gJLn23uidGijauMzaUyQtcvVlKoZVo4xDIVCfpDPkfEXkzouJYmI1S6SmaGcSu21Tcf16QA/6VaCuRLUxdRa/pBknLHwyNuV+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpF1WIcn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da9c834646so3365277b3a.3;
        Mon, 22 Jan 2024 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705943414; x=1706548214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJG831c9X6YdaovxlTqiwAZnTkqpj5rWBo3Fhk5z9C0=;
        b=NpF1WIcnLkN+vK/4MlwYxA9DPZhfdqYP6kFzuE+t50GsLpWBBDojIBe5jxf1MA5G6B
         RWzRLZIrVNebin45kqFWw7BZc2Vp7ZOvshup+l5gvFW4Djn6hmoizBB5vcfcp+8qAGpN
         Og11sEFfIzx+Ac9voB2ZwM8dqWClrpZ9aRfMe68O7RJE37FD+HGF/rIwzFQqla5hzmfM
         LlGDZJ1L6TKa+ycNCZbnzz4zC5CCm73cjUhrC2iS2tEeKzq8Pc3AEXEF45imJks3QNtK
         3qbHooXI7oI4/N8j2TVOCqZJmb3iTwxdbqigUdvMPRr6jA2K84eRFO2wOorrGva2Wo04
         LJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943414; x=1706548214;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJG831c9X6YdaovxlTqiwAZnTkqpj5rWBo3Fhk5z9C0=;
        b=R4auaEYi1qC9bWbluEPATPoMoDALYkVw2qbAiUL7U3i/UcpBCrwabNm+3jQvw1r/T0
         Cq4+y+aSoMh14uuq0ZJ7NvR91lunxr8G3UQTBX4n2sm/k8HUI/IgmG+jbIR5iwYJ1hLC
         icfyvChUQ/Km4z10zRhrXh/FNjjixNaMPRD0z60MJwOSnTUVyUqs87ZeCxeu/gDzgnjt
         YqBJUfiVhkXsXM+4oYh9wi412TA3qNpO9NPLvDUL4HANK+fw2X7HIYm5Kl59mYvLve09
         KrMoDDJsXw2ndltIqVZctnBPpuTPlaniUm3kFrgPJkdYGPy0CrnC9GRj4/crW7gN41yJ
         0esw==
X-Gm-Message-State: AOJu0YwXCOFKekG07U/o3Riyu+luwklI0lZAULXsztUCpbedJGoxIsmJ
	rgfovu67NX8m1gDIN3rLCOk1aEBquSRrudf8Sa1ib8qbVgW8QC4u
X-Google-Smtp-Source: AGHT+IGMAkEmkRAFTXivmjaEGv5mnh0z4Lxw/gwh0uW8k6XsWOS2sg7jlgnsTVKbIPBT+Zl5rlPDjw==
X-Received: by 2002:a05:6a20:8e19:b0:19b:118e:bd87 with SMTP id y25-20020a056a208e1900b0019b118ebd87mr6197660pzj.90.1705943413700;
        Mon, 22 Jan 2024 09:10:13 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id lc14-20020a056a004f4e00b006db00cb78a8sm10209855pfb.179.2024.01.22.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:10:13 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] scsi: storvsc: Fix ring buffer size calculation
Date: Mon, 22 Jan 2024 09:09:56 -0800
Message-Id: <20240122170956.496436-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code uses the specified ring buffer size (either the default of
128 Kbytes or a module parameter specified value) to encompass the one page
ring buffer header plus the actual ring itself.  When the page size is
4K, carving off one page for the header isn't significant.  But when the
page size is 64K on ARM64, only half of the default 128 Kbytes is left
for the actual ring.  While this doesn't break anything, the smaller
ring size could be a performance bottleneck.

Fix this by applying the VMBUS_RING_SIZE macro to the specified ring
buffer size.  This macro adds a page for the header, and rounds up
the size to a page boundary, using the page size for which the kernel
is built.  Use this new size for subsequent ring buffer calculations.
For example, on ARM64 with 64K page size and the default ring size,
this results in the actual ring being 128 Kbytes, which is intended.

Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a95936b18f69..7ceb982040a5 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -330,6 +330,7 @@ enum storvsc_request_type {
  */
 
 static int storvsc_ringbuffer_size = (128 * 1024);
+static int aligned_ringbuffer_size;
 static u32 max_outstanding_req_per_channel;
 static int storvsc_change_queue_depth(struct scsi_device *sdev, int queue_depth);
 
@@ -687,8 +688,8 @@ static void handle_sc_creation(struct vmbus_channel *new_sc)
 	new_sc->next_request_id_callback = storvsc_next_request_id;
 
 	ret = vmbus_open(new_sc,
-			 storvsc_ringbuffer_size,
-			 storvsc_ringbuffer_size,
+			 aligned_ringbuffer_size,
+			 aligned_ringbuffer_size,
 			 (void *)&props,
 			 sizeof(struct vmstorage_channel_properties),
 			 storvsc_on_channel_callback, new_sc);
@@ -1973,7 +1974,7 @@ static int storvsc_probe(struct hv_device *device,
 	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
 
 	stor_device->port_number = host->host_no;
-	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
+	ret = storvsc_connect_to_vsp(device, aligned_ringbuffer_size, is_fc);
 	if (ret)
 		goto err_out1;
 
@@ -2164,7 +2165,7 @@ static int storvsc_resume(struct hv_device *hv_dev)
 {
 	int ret;
 
-	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
+	ret = storvsc_connect_to_vsp(hv_dev, aligned_ringbuffer_size,
 				     hv_dev_is_fc(hv_dev));
 	return ret;
 }
@@ -2198,8 +2199,9 @@ static int __init storvsc_drv_init(void)
 	 * the ring buffer indices) by the max request size (which is
 	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
 	 */
+	aligned_ringbuffer_size = VMBUS_RING_SIZE(storvsc_ringbuffer_size);
 	max_outstanding_req_per_channel =
-		((storvsc_ringbuffer_size - PAGE_SIZE) /
+		((aligned_ringbuffer_size - PAGE_SIZE) /
 		ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
 		sizeof(struct vstor_packet) + sizeof(u64),
 		sizeof(u64)));
-- 
2.25.1


