Return-Path: <linux-hyperv+bounces-5802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63263AD0950
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Jun 2025 23:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30462164FD9
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Jun 2025 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE26215773;
	Fri,  6 Jun 2025 21:06:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B723A31;
	Fri,  6 Jun 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243975; cv=none; b=XnhW3HXXhuYR4okW2Ype89zPEK1KZV3mMrlXP8FSJ/fDFiRjgzy1hnw/pPjGqkRxsW0vzLkZf1bDL6l90bbqyGw7cRV+3hMRkN3696uRrTmH1mw9oJcHODoVNV/JqyVlPIC18enRarq2E0VqqdzIEWuvl5QmAJSWbrIvZT3M0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243975; c=relaxed/simple;
	bh=FlnncZQGSdLC7LALzESc5pCe5CArC+q9jpshbvYWStM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RI3BGNj8WTanUw+8TgVMcmEQOgnxGLxmEwEvlnCgs/mqnJ/OIDlwTWo08pPhSMtrJB8CVf9mwxmg3MGhhPv0fByEYHSm4ODocYAkbMMlUnwfLkOJPtPTXBlAeLqcEco+1bNWFzmNMStSIlwanV5zherV/tUUoIXgT3rtt88qqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id 9C0EF201FF41; Fri,  6 Jun 2025 13:57:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C0EF201FF41
From: Dexuan Cui <decui@microsoft.com>
To: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com
Cc: Dexuan Cui <decui@microsoft.com>,
	stable@kernel.org
Subject: [PATCH] scsi: storvsc: Increase the timeouts to storvsc_timeout
Date: Fri,  6 Jun 2025 13:57:39 -0700
Message-Id: <1749243459-10419-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently storvsc_timeout is only used in storvsc_sdev_configure(), and
5s and 10s are used elsewhere. It turns out that rarely the 5s is not
enough on Azure, so let's use storvsc_timeout everywhere.

In case a timeout happens and storvsc_channel_init() returns an error,
close the VMBus channel so that any host-to-guest messages in the
channel's ringbuffer, which might come late, can be safely ignored.

Add a "const" to storvsc_timeout.

Cc: stable@kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 2e6b2412d2c9..d9e59204a9c3 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -362,7 +362,7 @@ MODULE_PARM_DESC(ring_avail_percent_lowater,
 /*
  * Timeout in seconds for all devices managed by this driver.
  */
-static int storvsc_timeout = 180;
+static const int storvsc_timeout = 180;
 
 #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
 static struct scsi_transport_template *fc_transport_template;
@@ -768,7 +768,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 		return;
 	}
 
-	t = wait_for_completion_timeout(&request->wait_event, 10*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0) {
 		dev_err(dev, "Failed to create sub-channel: timed out\n");
 		return;
@@ -833,7 +833,7 @@ static int storvsc_execute_vstor_op(struct hv_device *device,
 	if (ret != 0)
 		return ret;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return -ETIMEDOUT;
 
@@ -1350,6 +1350,8 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size,
 		return ret;
 
 	ret = storvsc_channel_init(device, is_fc);
+	if (ret)
+		vmbus_close(device->channel);
 
 	return ret;
 }
@@ -1668,7 +1670,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	if (ret != 0)
 		return FAILED;
 
-	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
+	t = wait_for_completion_timeout(&request->wait_event, storvsc_timeout * HZ);
 	if (t == 0)
 		return TIMEOUT_ERROR;
 
-- 
2.25.1


