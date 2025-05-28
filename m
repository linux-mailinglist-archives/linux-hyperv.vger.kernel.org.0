Return-Path: <linux-hyperv+bounces-5686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFA4AC72C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4227A4C26
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F676193402;
	Wed, 28 May 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rNcMsMbS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFE13790B;
	Wed, 28 May 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468015; cv=none; b=V8WtLnJoy8LZLrXPV0e6FPzzQTXsbdQsJ1s4DoHAspEXI2/d70Fzyp9I0PSPQLsYb9/8MJodF12BPw0gTYM/Op+dqM6SZN1bZQdlR2bDdWFVCGBo7goucsptCspDPfS1PhNlsmd4Z0UK4nJ8kzalBb9bi+qUqt8Vjb8Bop0/7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468015; c=relaxed/simple;
	bh=mUUY/FDNNShEaTZOuDIOH7fvPhVvvV2HLK69HgmTNnU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uIlpqJF2uRnsNwHjQmoHRfyfbK9gXeNOBCx/vJX6qo8qbyWVedG9pK65opaWDECtBGAJroCIOqZtG67FhqCkL9MDfSrRpQqj1lGMhCKrasywrk5M/fmJaSwJthhlCj1K2lbnHtHuQfSTx+UwcVa17Nf7NPAyK+k+gsitDUBQdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rNcMsMbS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.229] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id CFBA5206B740;
	Wed, 28 May 2025 14:33:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFBA5206B740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748468007;
	bh=nByfw5/KhfyeQ2FOpvHo/ku3oR++oG1F+hJzHwyIbDI=;
	h=Date:To:Cc:From:Subject:From;
	b=rNcMsMbSn+/w1Cyc4UdZl6zoJLwwANZ7reJ2oECPh+uZ4FjRtu+fXnZmhkn2m4I/G
	 4gE41pNz3lbbZR4OVzQwytzvruIBLPMe0bMR+UqS4tP93zrvhoC2wXnMD7zSzDbEC2
	 /n+AHcOo2uT9gvVET5A3VLs7MkvD62VO/WjmKotA=
Message-ID: <6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com>
Date: Wed, 28 May 2025 14:33:25 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: romank@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, ssengar@microsoft.com,
 apais@microsoft.com
From: Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH] vmbus: retrieve connection-id from device tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The connection-id determines which hypervisor communication channel the
guest should use to talk to the VMBus host. This patch adds support to
read this value from the device tree where it exists as a property under
the vmbus node with the compatible ID "microsoft,message-connection-id".

Reading from device tree allows platforms to specify their preferred
communication channel, making it more flexible. If the property is
not found in the device tree, use the default connection ID
(VMBUS_MESSAGE_CONNECTION_ID or VMBUS_MESSAGE_CONNECTION_ID_4
based on protocol version).

Cc: <stable@kernel.org> # 6.14, 6.12
Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
  drivers/hv/connection.c | 7 +++++--
  drivers/hv/vmbus_drv.c  | 8 ++++++++
  2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8351360bba16..f5acc4685981 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -99,12 +99,15 @@ int vmbus_negotiate_version(struct 
vmbus_channel_msginfo *msginfo, u32 version)
      if (version >= VERSION_WIN10_V5) {
          msg->msg_sint = VMBUS_MESSAGE_SINT;
          msg->msg_vtl = ms_hyperv.vtl;
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
      } else {
          msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
      }

+    /* Set default connection ID if not provided via device tree */
+    if (!vmbus_connection.msg_conn_id)
+        vmbus_connection.msg_conn_id = (version >= VERSION_WIN10_V5) ?
+            VMBUS_MESSAGE_CONNECTION_ID_4 : VMBUS_MESSAGE_CONNECTION_ID;
+
      /*
       * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
       * bitwise OR it
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e3d51a316316..a42ec7d499aa 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2471,10 +2471,18 @@ static int vmbus_device_add(struct 
platform_device *pdev)
      struct of_range range;
      struct of_range_parser parser;
      struct device_node *np = pdev->dev.of_node;
+    unsigned int conn_id;
      int ret;

      hv_dev = &pdev->dev;

+    /* Read connection ID from device tree */
+    ret = of_property_read_u32(np, "microsoft,message-connection-id", 
&conn_id);
+    if (!ret) {
+        pr_info("VMBus message connection ID: %u\n", conn_id);
+        vmbus_connection.msg_conn_id = conn_id;
+    }
+
      ret = of_range_parser_init(&parser, np);
      if (ret)
          return ret;
-- 
2.40.4



