Return-Path: <linux-hyperv+bounces-5780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E1ACE9D0
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 08:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BC97A6962
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796B1E51EA;
	Thu,  5 Jun 2025 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UPIYNxzi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CD1FC8;
	Thu,  5 Jun 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103776; cv=none; b=gaGytrRfiqZM500YoyRMh/2alehV485YoPWLPXHhk7UEbtAuRbhnl33/Us6mP0b6OITCIs6/LSo1QE2vMruUOmtlsqCvzqswF9Zztyf2KEsHkswhaXJnxOeL0w16h48ZaJNAXv7Rb6wVnhTvuwieR2TnQnkc6zKmIW5tCtHQE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103776; c=relaxed/simple;
	bh=O84wJObH89CUpgkwkPADWcvnXK7hHeg8rak4mox67q4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P2IYWTVeDs66PoamFX08Ue/TXB9PpkZHHqQ+PNJFhHR9y2mnx/McUuF29TBZ8t7NrpNF9nkNfVURB7MREYxp7cDNeTeaP4YEwURGD84mudst1ZVmXCKWucEOTdF9mhS6obvS8cRzX12cK97JBkmWD+NHOALaLZ/6t7JrDjYGrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UPIYNxzi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.1.134] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9BD0201FF4E;
	Wed,  4 Jun 2025 23:09:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9BD0201FF4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749103773;
	bh=arEF/2LdOdCfNP5R12P7zhBgPfTao/upFbApLg+9CFw=;
	h=Date:To:Cc:From:Subject:From;
	b=UPIYNxzitA7Tyg6oV7jSLomnxLkewK0LYNmWB5L1vLFiQns5uL7IDDNPKkpQ2Ncej
	 /1CMyeG6bIQ/cDEG+9HY9EAwmTKPPrGYt65FKwtvB2D3kwS6Euxy/usrJjKDqXOb97
	 1oEbEg3gcRr7DpfDv5mJN6+Idr/lN7MeB3Vene2I=
Message-ID: <6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com>
Date: Wed, 4 Jun 2025 23:09:31 -0700
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
Subject: [PATCH v3] vmbus: retrieve connection-id from DeviceTree
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
v3:
- Added documentation for the new property in DeviceTree bindings

v2: 
https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com/

v1: 
https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com/
---
  .../devicetree/bindings/bus/microsoft,vmbus.yaml    |  8 ++++++++
  drivers/hv/connection.c                             |  6 ++++--
  drivers/hv/vmbus_drv.c                              | 13 +++++++++++++
  3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml 
b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index 0bea4f5287ce..729ca6defec6 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -17,6 +17,14 @@ properties:
    compatible:
      const: microsoft,vmbus

+  microsoft,message-connection-id:
+    description:
+      VMBus message connection ID to be used for communication between 
host and
+      guest. If not specified, defaults to 
VMBUS_MESSAGE_CONNECTION_ID_4 for
+      protocol version VERSION_WIN10_V5 and above, or 
VMBUS_MESSAGE_CONNECTION_ID
+      for older versions.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
    ranges: true

    '#address-cells':
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..e0f38d799d06 100644
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
index c236081d0a87..d14d286671cc 100644
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



