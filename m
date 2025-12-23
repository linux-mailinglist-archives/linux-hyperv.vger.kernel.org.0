Return-Path: <linux-hyperv+bounces-8067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CFCDACD1
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3418F3017E13
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9AD30AD06;
	Tue, 23 Dec 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="llDbrej8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC32F12C9;
	Tue, 23 Dec 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531368; cv=none; b=L7d2Ck5Z7H6E8UdtLbykNWfdZguRMR3/E/NpA6yerF/DD8tcJiBsV5vVeVjlqdZTJ+qEtACLIdgABk/Hx1JjS2LGHpP7cY25O7iJSizniC0XUx87Kezx3uMcLDSK828xZozv/69o1L3vEAcnMPloEs2WO+5m6g/CicsSkbtBoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531368; c=relaxed/simple;
	bh=sAwwy2sio6lkc47FDsReM8SoyBwcC4MIdfRDutt5yKw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RHYMImCGobNis2Pegz2LLkEabB9xvLD9m3bex+wKsR8OtipMPy0y3AtKlo/2/T9dpm5AkFRFcSM8tIb2wowbh31ceZBdKN5cm96XfnMkisHfbJRsPaCAqfuHOlE5l5FaUwsEfIAn4LkvMJ8giu/8rRFxMifDZcuCJBeCGS5sHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=llDbrej8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.124] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D2A1212A423;
	Tue, 23 Dec 2025 15:09:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D2A1212A423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766531366;
	bh=sAwwy2sio6lkc47FDsReM8SoyBwcC4MIdfRDutt5yKw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=llDbrej8RnKs7HiCXtYol6Xr74gRhUTQrEcaA/KKSG+N+Sh20qp6TGcYvt3bBlCN2
	 0wCGNwfDaGB/0eCKtBuNaBLT8jlI36puukcIoq/Um4aRmh5Ai88d/bRPQST+bVbl1Z
	 i6H3r7qWW4HPJOlfCXGHrhiVESPFH+bwwaFodIEc=
Message-ID: <10482c90-50c8-4e72-ba40-1d0e6e722128@linux.microsoft.com>
Date: Tue, 23 Dec 2025 15:09:24 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/2] Drivers: hv: vmbus: retrieve connection-id from
 DeviceTree
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, mhklinux@outlook.com
Cc: devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 longli@microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 hargar@microsoft.com
References: <58cb22cb-b0c8-4694-b9e4-971aa7f0f972@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <58cb22cb-b0c8-4694-b9e4-971aa7f0f972@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The connection-id determines which hypervisor communication channel
the guest should use to talk to the VMBus host. Add steps to read
this value from the DeviceTree. When this property is not present,
the driver selects the connection ID based on the protocol version
(4 for VERSION_WIN10_V5 and newer, or 1 for older versions).

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
v4:
https://lore.kernel.org/all/1750374395-14615-3-git-send-email-hargar@linux.microsoft.com
v3:
https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
v2:
https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
v1:
https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
---
 drivers/hv/connection.c |  7 +++++--
 drivers/hv/vmbus_drv.c  |  8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 5d9cb5bf2d62..660cad3886f5 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -100,12 +100,15 @@ int vmbus_negotiate_version(struct
vmbus_channel_msginfo *msginfo, u32 version)
     if (version >= VERSION_WIN10_V5) {
         msg->msg_sint = VMBUS_MESSAGE_SINT;
         msg->msg_vtl = ms_hyperv.vtl;
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
     } else {
         msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
     }
 
+    /* Set default connection ID if not provided via DeviceTree */
+    if (!vmbus_connection.msg_conn_id)
+        vmbus_connection.msg_conn_id = (version >= VERSION_WIN10_V5) ?
+            VMBUS_MESSAGE_CONNECTION_ID_4 : VMBUS_MESSAGE_CONNECTION_ID;
+
     if (vmbus_is_confidential() && version >= VERSION_WIN10_V6_0)
         msg->feature_flags = VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 47fcab38398a..f8c0594ab85f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2600,10 +2600,18 @@ static int vmbus_device_add(struct
platform_device *pdev)
     struct of_range range;
     struct of_range_parser parser;
     struct device_node *np = pdev->dev.of_node;
+   unsigned int conn_id;
     int ret;
 
     vmbus_root_device = &pdev->dev;
 
+    /* Read connection ID from DeviceTree */
+    if (!of_property_read_u32(np, "microsoft,message-connection-id",
+                  &conn_id)) {
+        pr_info("VMBus message connection ID: %u\n", conn_id);
+        vmbus_connection.msg_conn_id = conn_id;
+    }
+
     ret = of_range_parser_init(&parser, np);
     if (ret)
         return ret;
-- 
2.34.1



