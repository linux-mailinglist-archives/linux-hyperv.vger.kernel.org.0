Return-Path: <linux-hyperv+bounces-1887-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47A89322C
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 18:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796D6282875
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86AB145340;
	Sun, 31 Mar 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iJIgd8nj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3314532F;
	Sun, 31 Mar 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900911; cv=pass; b=GM4WKG1yQv4O+jk8KiB4YsolFeG4AALWAZe1nu4OIR6YPfs/pL88GzTbTEgXwmxTZg+6pbCzFSXWv6bQcuCpXHyTQlCFWML2oagQgLFbphRZVc4eETiXJTipOb7iCaCKQO1CifA4FXskGJkB0YcgdP9VD2vLdd3n9Sg1EH6WFDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900911; c=relaxed/simple;
	bh=JvItBV8S7Y31HMTBenjNqg15k1PnGv+HzKdN7fwkC+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWNB5D+5FD/ee8T0cb6dOBJV0NMKPZQ7pgREetan+IXO6yI/6FCNotbpam/h895+Qfx9oTJQF1bJVKyV3nOT+wWQl+3L+LCbzMxHz5mmicOpgW9ISBaCPMNr1dy1qWJ79zgu4HlA0Z44rgfWQXP3dx2DS1Rc5XIMkU41mPYKbiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=fail smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iJIgd8nj; arc=none smtp.client-ip=13.77.154.182; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.microsoft.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4F3BF2067F;
	Sun, 31 Mar 2024 18:01:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PgEYT208xhjF; Sun, 31 Mar 2024 18:01:47 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B5ACB20612;
	Sun, 31 Mar 2024 18:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B5ACB20612
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id A89F280004A;
	Sun, 31 Mar 2024 18:01:47 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:01:47 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:44 +0000
X-sender: <linux-kernel+bounces-125624-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoA+C5rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAD8BAADWigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 14840
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125624-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 93FFD20315
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iJIgd8nj"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788731; cv=none; b=OIsy2/5zncrPDDDv1SmbSfoJZbQrxMXwLvs279O35EZFVQCH7ye/9Swsc0vGkEk/zjSCRdZvVBFzJSnUMY0qckVwdUyjmvFKJCcJ6m2OOj0W00sjnQQ4bi/gTpL2mQZGSH9+Z/STTqtjRTwTxQHrVGCKnlizHx6SWebU/NkjkIs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788731; c=relaxed/simple;
	bh=JvItBV8S7Y31HMTBenjNqg15k1PnGv+HzKdN7fwkC+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TBa0ltExKXXF1Ou2+D77LPWx7mwpku8pLAIMt5e2dh4rsvorH1htnZfl1Uuag6OpFrRHYTBRXf24QnhNLXf+xpmsUd7jcDnI9khZ/NQwSaOU7E9EH28W1z8+F/QcHI6p7ivB+kCT8FNN6fVUFNIwg/qEOTTOwfdiTj6bsmUjOAA=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iJIgd8nj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40B5520E7039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711788728;
	bh=BtKE7O5OWVM7SyPdRoHlAAnjh2otvkVJidlO3O/WDfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJIgd8njauEFfrqab1aHlcM8q6HjkukZ6SmfRUHRtttswzVuFTjGIJAFAlHb9vzeB
	 pz9jaClMEtTXns1dXkYp3ODhFJufdDI47sAKnRvsSbiEX1W2EGW2dY0fYlNVTQ/4vz
	 X/9mWe/yPSL2QgYHC7cSJkvTw+6UH74KqYsLVRiA=
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
Subject: [PATCH v3 1/7] Drivers: hv: vmbus: Add utility function for querying ring size
Date: Sat, 30 Mar 2024 01:51:57 -0700
Message-ID: <1711788723-8593-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
References: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Add a function to query for the preferred ring buffer size of VMBus
device. This will allow the drivers (eg. UIO) to allocate the most
optimized ring buffer size for devices.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
[V2]
- Added more details in commit message.
- Added comments for preferred ring sizes and there values.
- Added reviewed-by from Long Li.

 drivers/hv/channel_mgmt.c | 15 ++++++++++++---
 drivers/hv/hyperv_vmbus.h |  5 +++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f4d09ce027a..3c6011a48dab 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -120,7 +120,9 @@ const struct vmbus_device vmbus_devs[] = {
 	},
 
 	/* File copy */
-	{ .dev_type = HV_FCOPY,
+	/* fcopy always uses 16KB ring buffer size and is working well for last many years */
+	{ .pref_ring_size = 0x4000,
+	  .dev_type = HV_FCOPY,
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
@@ -140,12 +142,19 @@ const struct vmbus_device vmbus_devs[] = {
 	  .allowed_in_isolated = false,
 	},
 
-	/* Unknown GUID */
-	{ .dev_type = HV_UNKNOWN,
+	/*
+	 * Unknown GUID
+	 * 64 KB ring buffer + 4 KB header should be sufficient size for any Hyper-V device apart
+	 * from HV_NIC and HV_SCSI. This case avoid the fallback for unknown devices to allocate
+	 * much bigger (2 MB) of ring size.
+	 */
+	{ .pref_ring_size = 0x11000,
+	  .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
 	},
 };
+EXPORT_SYMBOL_GPL(vmbus_devs);
 
 static const struct {
 	guid_t guid;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f6b1e710f805..76ac5185a01a 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -417,6 +417,11 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
 	return vmbus_devs[channel->device_id].perf_device;
 }
 
+static inline size_t hv_dev_ring_size(struct vmbus_channel *channel)
+{
+	return vmbus_devs[channel->device_id].pref_ring_size;
+}
+
 static inline bool hv_is_allocated_cpu(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6ef0557b4bff..7de9f90d3f95 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -820,6 +820,8 @@ struct vmbus_requestor {
 #define VMBUS_RQST_RESET (U64_MAX - 3)
 
 struct vmbus_device {
+	/* preferred ring buffer size in KB, 0 means no preferred size for this device */
+	size_t pref_ring_size;
 	u16  dev_type;
 	guid_t guid;
 	bool perf_device;
-- 
2.34.1



