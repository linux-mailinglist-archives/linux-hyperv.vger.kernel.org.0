Return-Path: <linux-hyperv+bounces-1796-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBB880FE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF8285261
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67DC446AE;
	Wed, 20 Mar 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LGwo4rz+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD340C0C;
	Wed, 20 Mar 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930591; cv=none; b=k1boej/Ee0f0ukkHX5o0ST3FeI392VhFMJW+TDGR7UCT97jEferzsin7n3+95Jpkq107nsT9ReZeQjOY5XDO5IxyfK4I4S5u7aMcPpV6mhpQL2GPsiYaw3BTnKrPkjtovCvDQrj+PP7hX1rfzhg+FoTwjzNHnIgJuBitz7LJRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930591; c=relaxed/simple;
	bh=9653XaZCccTvubxzAH7uMrWyexERHI5ZBOzhYW1iEPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eaCKUEgWlaFzU+kI7VZPKParEnbC3OJQ99rucxt7k0DdLnaO6617RG3YCS5g3HaHgXiDnI3GjCoMLwSeoV8NKmNtu/3w4Jup0Vy1Gb3NcRY5Qg2250wtLSn1f4IzlpcgYnb1X7pyqj+ZFz4dJ2GZq4RgtwvQqUl2Jt+HuB6DK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LGwo4rz+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A0A8420B74C7;
	Wed, 20 Mar 2024 03:29:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0A8420B74C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710930588;
	bh=olYvZHNXlz3AXQeX5LfF8FHqGubxvfHVp6D6F2JpFFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGwo4rz+Y+5fnAPonE4TCWUlWUQZcDLLcseguFzS4p9Wqge+UX2xSqunoIe3TrXsF
	 e3uGH6Xn978q3jUDkYamwuSMCeqtmxWnkPQEAgoSPBpHpBQ+z4wA87Kf5uRwzA/98s
	 9L61oFtSUGs6eyXsgeRUdhLVBYeggeqc4Fpa3EM8=
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
Subject: [PATCH v2 7/7] uio_hv_generic: Remove use of PAGE_SIZE
Date: Wed, 20 Mar 2024 03:29:44 -0700
Message-Id: <1710930584-31180-8-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
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


