Return-Path: <linux-hyperv+bounces-1553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1D85916E
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 19:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3009B20B14
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB27E0ED;
	Sat, 17 Feb 2024 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EU2LoIpZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2C7E0E7;
	Sat, 17 Feb 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193075; cv=none; b=QX2X5ORDhx4tfZpPg18RIpTIo8sDt273sj85cG9PmFq7EVVSSA0/oK+f3uAWR6EH5GeXhZMbYUWANTV/HuHV4HwaG0mCxyR+MdYueidnddEipuqpLM2WICnfnJV6R1iU3MKfkVTn63B/RGEYxr25zPpsw09zbKHHm9svS3JTXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193075; c=relaxed/simple;
	bh=z1X7X1YCv6aHaCd20LNe+sdLH/lgI1gAQ3Ruj1baOqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nY6TN7hPU6DfSaLevCmDFGLhzTAT1wz9VCL+YOKHSyYC9FKR23d9qQyC4eKFD2cAfTbWOncmkG4W+nBIDew59JQS2H4d9zVQJTon2xayGU6WcQrHRa77zBVw822eaLf4qX/yKihE/CU3yNUwlInNs6iNWK54Aex8Oo+De6cO/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EU2LoIpZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8591E207FD2E;
	Sat, 17 Feb 2024 10:04:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8591E207FD2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708193067;
	bh=f7wzYQnISkQFMWedckuhXxywKeM0U3MrfpoPt6WGRmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EU2LoIpZxgjvME+yjDjLlalSytwEGhoALQOKLplBtV8MaMA8cWR0212JqWr2Viy/H
	 G+AwxfzKEorD1cA49iSP2G8JVJ0WH3Q5jXGl4ZwSbjXwcMaYTFXGExeii3PpVIsbyJ
	 6HIVe1o7EAJ5NCSVmIuIBX1GmcrmXQkCErrKx9DM=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH 2/6] uio_hv_generic: Query the ringbuffer size for device
Date: Sat, 17 Feb 2024 10:03:36 -0800
Message-Id: <1708193020-14740-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Query the ring buffer size from pre defined table per device.
Keep the size as is if the device doesn't have any preferred
ring size.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
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


