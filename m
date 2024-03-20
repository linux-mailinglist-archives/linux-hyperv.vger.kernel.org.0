Return-Path: <linux-hyperv+bounces-1793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A087880FD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 11:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D7928534A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791241208;
	Wed, 20 Mar 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NlApVX93"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24C405D8;
	Wed, 20 Mar 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930590; cv=none; b=VbS0ZPl6Xqwg3wn4YLlcCYuT9MtrtoFqD3mCPcLx/v4ObY+6VF0mTouD8vm4ZLYaMQb1Js2RRvJeQMZYoPA4sjWNtph0q8w5RxZ6dpEOoTMHs3njV2gHxtNEvh8ct3n6ISIwLk9JRfoUAbfFvQZMoVZyhrelHCRspuKDha5msxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930590; c=relaxed/simple;
	bh=OtlHloyPyeniToJMbwKNtvJXxZeJasCcJsQXkoFTzzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B1Jkg1GnPnPylRNscZyeDPuO2Ad+rxhz0SO1VlgearPaAxrsykJTiHWdSq2gv8nh1pRelLb8wR+DGdsZVUbzW7xWo/+aZNPttcJEnLjPVShPSm/O/AIV0NCYzOpwtJDP9mZjkgsQay5YzI6nq4CguKS2/x87vzgxktqrywb10fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NlApVX93; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3FA9B20B74C3;
	Wed, 20 Mar 2024 03:29:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FA9B20B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710930588;
	bh=8sNJLDeO3//ygBsBaKWyExrUSf4lpQZ7TMC4jMog21w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlApVX93aTcpT0QDXePHEpswPpxyfGH1ydbN9xLUQpSQksjfD/1liZG1BzLDDZZby
	 JW9Q4gTROWswP0tMjp7Jm4bu5TsOvWBwuIl0tcvERNuY5+3ZMPsgI+QB8+yFUay5Il
	 hz++tuk78KrR/ZSgmXhDJY0IwH3/CVFR5Fpds/6o=
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
Subject: [PATCH v2 3/7] uio_hv_generic: Enable interrupt for low speed VMBus devices
Date: Wed, 20 Mar 2024 03:29:40 -0700
Message-Id: <1710930584-31180-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
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
Reviewed-by: Long Li <longli@microsoft.com>
---
[V2]
- Added Reviewed-by form Long Li

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


