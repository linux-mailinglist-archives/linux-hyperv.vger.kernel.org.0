Return-Path: <linux-hyperv+bounces-1554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AC85916C
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C531C20B8E
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F457E0F0;
	Sat, 17 Feb 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JESdnY/x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8437E0E3;
	Sat, 17 Feb 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193075; cv=none; b=Lqige/dc7Oved9c5g4WQDkYS9uKMok9kXv6AsALw1kInAe4PESPEcD5+0VSs4N53urmmfGwWwpIPLgHeZ8H6xQicEOWhfE0RnBKDLQT87t2emq87PzedJmbIaUUzFXLTktU5OihGOdWOsOzgL1bflCGC1vHqdZaCEdC1bFa8tG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193075; c=relaxed/simple;
	bh=aQYHlXV7kN6BYqhUEYWn7DqoPucn2DTrXeCBMweMa6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MvA0/eBiSKMb2IXykgaFxjAsslPJrOGB2G7lpzyGCLo6jlItprTOF2rKT9HQmrs5NlNnt7w7HGxkQCCx/bb9P+gdRgH4B7kaboc9yxoXYgqzXD5oF2lj7+/TNXcCHGjfhYfzvafQJuwgktfwmXNfcBvGFi1IzJB9A26NSjWxvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JESdnY/x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CBEC207FD2F;
	Sat, 17 Feb 2024 10:04:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CBEC207FD2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708193067;
	bh=IJXczuiy25vcEMZMajrYQPcvnxC/NI9o3yOT9PmVG/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JESdnY/xusHyCYTZjvMI+irpL1MF8p4TXWKvlq5nMVj8KBuOJYjRCF2iZ8cnLHKWb
	 G9ZH6wuypj9BmnmEL2fd2VDS44CUb76vZ4UMxXrXD4OaBdVEmB9JSATudM18ywWD1/
	 ybR6i3Dq8B4SmWMeZc/5Iu8Tiwv8GAgIQul1pBDM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH 3/6] uio_hv_generic: Enable interrupt for low speed VMBus devices
Date: Sat, 17 Feb 2024 10:03:37 -0800
Message-Id: <1708193020-14740-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Hyper-V is adding some "specialty" synthetic devices. Instead of writing
new kernel-level VMBus drivers for these devices, the devices will be
presented to user space via this existing Hyper-V generic UIO driver, so
that a user space driver can handle the device. Since these new synthetic
devices are low speed devices, they don't support monitor bits and we must
use vmbus_setevent() to enable interrupts from the host.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 4bda6b52e49e..289611c7dfd7 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
 	virt_mb();
 
+	if (!dev->channel->offermsg.monitor_allocated && irq_state)
+		vmbus_setevent(dev->channel);
+
 	return 0;
 }
 
@@ -240,12 +243,6 @@ hv_uio_probe(struct hv_device *dev,
 	int ret;
 	size_t ring_size = hv_dev_ring_size(channel);
 
-	/* Communicating with host has to be via shared memory not hypercall */
-	if (!channel->offermsg.monitor_allocated) {
-		dev_err(&dev->device, "vmbus channel requires hypercall\n");
-		return -ENOTSUPP;
-	}
-
 	if (!ring_size)
 		ring_size = HV_RING_SIZE * PAGE_SIZE;
 
-- 
2.34.1


