Return-Path: <linux-hyperv+bounces-5725-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B17ACCE8F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21BF1896512
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1021129D;
	Tue,  3 Jun 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ftezYUWK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB741487F6;
	Tue,  3 Jun 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984463; cv=none; b=sqNkKVl8Mp4Spsj0VEG46rl2g+aFCnOj3nTuCHLl0Q73kN+ehyaW6IH1RYTWNh1GOUaaYY4D5qndtdhpZZAM2y09qhy+J2rnam/G4qLYOX8hDOoO0EHllfy9vUpc6JmE/IJhx/jpFe7f9HkzNcAiiY2M9psNxlxHzpOPrSKo/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984463; c=relaxed/simple;
	bh=r3jk8NiwEP5rXMWWtANPKYEXLB8GlSyHB3WwxJIHfhk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=R7+bAO2B3ZJUjKqdPfu58DMhnetjUYCMObfMDoTzJrBV3bVzkZxGlWppI14qDgurWASq6AsreNUyb8ReIWdynNby3LuM2BM3LirrevcFGNuVs3qly2zttwFkzyJBYVeoGh5bKeXlVJPBQ+yIfIeRYPYpsEZXB96g/pBFWgSUflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ftezYUWK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.0.138] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id D578C2115DB5;
	Tue,  3 Jun 2025 14:01:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D578C2115DB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748984461;
	bh=cuvZaG9YZJheHlVoHJF6wkxDezWTkCK93CTFbc8d26I=;
	h=Date:To:Cc:From:Subject:From;
	b=ftezYUWKTthPxfuQNVJBa8vgp9KUxg5cFcs59YXTg8F2GN4x8eWQ2Qator7DxCDPd
	 nmHZFT/woaFYmroxb+XhTuavty8Q9XEBBw6Y2XU7AqlvyL4tW2FkTmd+zmNx8W2Fqm
	 OtxYrSz3itJPqK/s7PvuzagHUBMPLiaFgfvskcMo=
Message-ID: <096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com>
Date: Tue, 3 Jun 2025 14:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, ssengar@microsoft.com
Cc: romank@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, apais@microsoft.com
From: Hardik Garg <hargar@linux.microsoft.com>
Subject: Subject: [PATCH v2] vmbus: retrieve connection-id from DeviceTree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The connection-id determines which hypervisor communication channel the
guest should use to talk to the VMBus host. This patch adds support to
read this value from the DeviceTree where it exists as a property under
the vmbus node with the compatible ID "microsoft,message-connection-id".
The property name follows the format <vendor>,<field> where
"vendor": "microsoft" and "field": "message-connection-id"

Reading from DeviceTree allows platforms to specify their preferred
communication channel, making it more flexible. If the property is
not found in the DeviceTree, use the default connection ID
(VMBUS_MESSAGE_CONNECTION_ID or VMBUS_MESSAGE_CONNECTION_ID_4
based on protocol version).

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
v2:
- Rebased on hyperv-next branch as requested by maintainers
- Added details about the property name format in the commit message

v1: 
https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com/

  drivers/hv/connection.c |  6 ++++--
  drivers/hv/vmbus_drv.c  | 13 +++++++++++++
  2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..c444c943c1d4 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -99,12 +99,14 @@ int vmbus_negotiate_version(struct 
vmbus_channel_msginfo *msginfo, u32 version)
      if (version >= VERSION_WIN10_V5) {
          msg->msg_sint = VMBUS_MESSAGE_SINT;
          msg->msg_vtl = ms_hyperv.vtl;
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
      } else {
          msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
-        vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
      }

+    /* Set default connection ID if not provided via DeviceTree */
+    if (!vmbus_connection.msg_conn_id)
+        vmbus_connection.msg_conn_id = (version >= VERSION_WIN10_V5) ?
+            VMBUS_MESSAGE_CONNECTION_ID_4 : VMBUS_MESSAGE_CONNECTION_ID;
      /*
       * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
       * bitwise OR it
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c236081d0a87..6a886611c448 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2541,10 +2541,23 @@ static int vmbus_device_add(struct 
platform_device *pdev)
      struct of_range range;
      struct of_range_parser parser;
      struct device_node *np = pdev->dev.of_node;
+    unsigned int conn_id;
      int ret;

      vmbus_root_device = &pdev->dev;

+    /*
+     * Read connection ID from DeviceTree. The property name follows the
+     * format <vendor>,<field> where:
+     * - vendor: "microsoft"
+     * - field: "message-connection-id"
+     */
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



