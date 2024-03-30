Return-Path: <linux-hyperv+bounces-1882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341798929CB
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF401F2207F
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60066C2E3;
	Sat, 30 Mar 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PogBlzdg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F28464;
	Sat, 30 Mar 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788732; cv=none; b=M2+NWtn5DVoq8hkJhVJcjSJEYcdYX2bsqWK87dyFSh8LTEYLr8m42zpsN1jVXbslEOdpQJ/EJHP25JPPK7aF6uXhrYYcyKAAyWoIyal0lJRf3NFRKp3+wXSd4FR2G6gQmZHAaBNhMpyY+OiJfIcPFUohMslh83BTQ0thnapwQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788732; c=relaxed/simple;
	bh=vgiLOXN5x389jykiH7i0vlj8Z45dgOo5OQSMR/aLqB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sTm+/0iatqPY59r8oI3CDG2UQcNZ2GoF4/dB+5YfOAyvpIwHluw9s3BqmsVu61knAOcm7DYLEB/ID4cyoHd0YzicgoIQSPcSoJFyAbckwUhh3R8X/VBx5GrfC7FS/S9QRHgAeEPNYTyGpoKUqv+KbPpp9c6G/alfTXN/0EqDYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PogBlzdg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5A3CB20E703D;
	Sat, 30 Mar 2024 01:52:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A3CB20E703D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711788728;
	bh=NAy5EC39+afjFHDkEQlx0+eqqPhVPwXu63T0KZBTnFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PogBlzdgaqxSCjHXwNe2Px9Q0+seW8N611HQw37cQEnt9lVKbEstwCQj8VuX+1tRl
	 Kalwo18hNFEtUhFlVaMQfMTRaH/yXF4RXqIahMk/X/c//vmDIUATOBWShTnSo59YYZ
	 eqLP/WhQ57eQ9rf+cVCS23jVLi47dSkkecHNAiuE=
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
Subject: [PATCH v3 2/7] uio_hv_generic: Query the ringbuffer size for device
Date: Sat, 30 Mar 2024 01:51:58 -0700
Message-Id: <1711788723-8593-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
References: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Query the ring buffer size from pre defined table per device
and use that value for allocating the ring buffer for that
device. Keep the size as current default which is 2 MB if
the device doesn't have any preferred ring size.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
[V2]
- Improve commit message.
- Added Reviewed-by from Long Li.

 drivers/uio/uio_hv_generic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 20d9762331bd..4bda6b52e49e 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -238,6 +238,7 @@ hv_uio_probe(struct hv_device *dev,
 	struct hv_uio_private_data *pdata;
 	void *ring_buffer;
 	int ret;
+	size_t ring_size = hv_dev_ring_size(channel);
 
 	/* Communicating with host has to be via shared memory not hypercall */
 	if (!channel->offermsg.monitor_allocated) {
@@ -245,12 +246,14 @@ hv_uio_probe(struct hv_device *dev,
 		return -ENOTSUPP;
 	}
 
+	if (!ring_size)
+		ring_size = HV_RING_SIZE * PAGE_SIZE;
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = vmbus_alloc_ring(channel, HV_RING_SIZE * PAGE_SIZE,
-			       HV_RING_SIZE * PAGE_SIZE);
+	ret = vmbus_alloc_ring(channel, ring_size, ring_size);
 	if (ret)
 		return ret;
 
-- 
2.34.1


