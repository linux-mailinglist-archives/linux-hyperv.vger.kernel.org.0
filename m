Return-Path: <linux-hyperv+bounces-1883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AD8929CC
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A6A1C20F07
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB80DF5A;
	Sat, 30 Mar 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nX4WGy6p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B528F6B;
	Sat, 30 Mar 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788732; cv=none; b=pUbgFVaYai2WlMDi5G+O/Zg+8KJPNJci1zv2VuNPThx5KDti+vg0o+V5/g4ZUQ13w48HLRbYDSw1TnRqIo/+4iCrj5WmIaYpEVc49o8Cj9Zk/NOQNe2rdu2OkRnjhJHujtkB7a6gGnta5zrcEajNgaeFBmae0ZVAiQyDb0XCro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788732; c=relaxed/simple;
	bh=9653XaZCccTvubxzAH7uMrWyexERHI5ZBOzhYW1iEPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uUohA9kp6tl/vHqwBl4Eo9VU1G+Vhsb5t4bD47ufsonj0S5V3l1eywzO+ztXNdQMoNKAW8PPSGhLOyKjFwHTpLUyBEF3FRyD0FmVvA3OGkchRi56KRljZBMqPIN5JpvVkqbWwneOmW4wOLk+2St6L6+Lsc8lhnELRq+njOhljeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nX4WGy6p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D842620E704A;
	Sat, 30 Mar 2024 01:52:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D842620E704A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711788728;
	bh=olYvZHNXlz3AXQeX5LfF8FHqGubxvfHVp6D6F2JpFFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nX4WGy6pZNffMmzYWnYVCflltbesyhimtlDt+ywAilfl4qKupxUvPbOeTFw+iCahD
	 qQf+pP1ukI8mKn+dl6jjaQBQdR2c2eoqdJLWwRoJXWTw4EJD558thnn+g0O2aIFYQG
	 ORGR0hBTk/YBLGPsXQ82IuuZVojvD1sEO6bFKi7k=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: longli@microsoft.com,
	ssengar@microsoft.com
Subject: [PATCH v3 7/7] uio_hv_generic: Remove use of PAGE_SIZE
Date: Sat, 30 Mar 2024 01:52:03 -0700
Message-Id: <1711788723-8593-8-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
References: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Remove use of PAGE_SIZE for device ring buffer size calculation, as
there is no dependency on device ring buffer size for linux kernel's
PAGE_SIZE. Use the absolute value of 2 MB instead.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 289611c7dfd7..015ddbddd6e1 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -36,7 +36,6 @@
 #define DRIVER_AUTHOR	"Stephen Hemminger <sthemmin at microsoft.com>"
 #define DRIVER_DESC	"Generic UIO driver for VMBus devices"
 
-#define HV_RING_SIZE	 512	/* pages */
 #define SEND_BUFFER_SIZE (16 * 1024 * 1024)
 #define RECV_BUFFER_SIZE (31 * 1024 * 1024)
 
@@ -146,7 +145,7 @@ static const struct bin_attribute ring_buffer_bin_attr = {
 		.name = "ring",
 		.mode = 0600,
 	},
-	.size = 2 * HV_RING_SIZE * PAGE_SIZE,
+	.size = 2 * SZ_2M,
 	.mmap = hv_uio_ring_mmap,
 };
 
@@ -156,7 +155,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 {
 	struct hv_device *hv_dev = new_sc->primary_channel->device_obj;
 	struct device *device = &hv_dev->device;
-	const size_t ring_bytes = HV_RING_SIZE * PAGE_SIZE;
+	const size_t ring_bytes = SZ_2M;
 	int ret;
 
 	/* Create host communication ring */
@@ -244,7 +243,7 @@ hv_uio_probe(struct hv_device *dev,
 	size_t ring_size = hv_dev_ring_size(channel);
 
 	if (!ring_size)
-		ring_size = HV_RING_SIZE * PAGE_SIZE;
+		ring_size = SZ_2M;
 
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-- 
2.34.1


