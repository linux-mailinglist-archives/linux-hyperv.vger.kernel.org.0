Return-Path: <linux-hyperv+bounces-8066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D936CDACBC
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A8383016931
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41972F12C9;
	Tue, 23 Dec 2025 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rjBI2ba3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062F2D97AC;
	Tue, 23 Dec 2025 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531246; cv=none; b=NB/Kh43HXnyyQ3SLGArIc8SVGD0OLEWds4TCji9ntnnRBMQ7ktHBoqSY+Ip+39QI1lzLzYazvQWPdyqPvfOtr9T6J3zPak/RDGJKiEAS0HBQY9ey5Zo58PDrj6ZgpEqjjN7HIYsRwgMHSK44n8l0nf1VefZJR1YtdIg/+5mhX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531246; c=relaxed/simple;
	bh=p4Vim08FZY9jFjXJAON9DOs70JPSNCDFirXt+o6YuZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c26EBgXpn+gmdJQYiaB9XfBUEF7P36Y5mJ4dowNtTNM6FDmY7fuB/MC9FGdfcj0pnCZyhdLT1gQiPH/93NYpK3CGnVITAh6FaCuRRHk09AiXpl3+WNEwdtxsLks9OPqWwFPod8AKS8hdeuSrHD06OJyGt5Athqo2/aQs/c3M/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rjBI2ba3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.124] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 24F85212A423;
	Tue, 23 Dec 2025 15:07:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 24F85212A423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766531244;
	bh=p4Vim08FZY9jFjXJAON9DOs70JPSNCDFirXt+o6YuZU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=rjBI2ba38RfTtEu5BbW0kliCcvjdRDZn23LebTve+rriaXtKHUwweXK1ufb9SN3oR
	 8JYF2egfQA8WfvpHErFhRijLanLhcXu5bc6b9FTj8iAd2WEz1cllsopr3s7vktmNfM
	 pzmi4i3eYsbkDLvjtBWhAtoJMKzkxdk1Ui8X5Wco=
Message-ID: <3fe6a9a3-b6e2-4550-b2a9-924b1fca21b5@linux.microsoft.com>
Date: Tue, 23 Dec 2025 15:07:22 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/2] dt-bindings: microsoft: Add vmbus
 message-connection-id property
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

Document the microsoft,message-connection-id property for VMBus
DeviceTree node. The connection-id is a hardware-level identifier
that specifies which Hyper-V message port (or mailbox slot) the
guest should use to communicate with the VMBus control plane.
Historically, VMBus always used a single, fixed connection ID.
However, with the introduction of Virtual Trust Level 2 (VTL2)
support, the control plane can now reside in a different trust
level, requiring the guest to communicate through a different
message port. This connection-id is determined by the hypervisor
based on the status of VMBus relay. From the guests perspective,
it is completely static for the lifetime of that VM instance, it
never changes at runtime. Once the kernel boots, it must read this
value to establish communication with the correct VMBus control
plane. There is currently no system API, or discoverable interface
that allows the guest to determine this value dynamically.

Each guest has a private hypervisor mailbox and cannot access any other
guests communication path. Using an incorrect connection ID does not
allow eavesdropping or cause interference, it only results in failed
VMBus initialization because the host drops messages sent to an
unexpected port. Thus, exposing the correct connection ID to the guest
is safe and necessary for correct initialization.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
v4:
https://lore.kernel.org/all/1750374395-14615-2-git-send-email-hargar@linux.microsoft.com
v3:
https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
v2:
https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
v1:
https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
---
 .../devicetree/bindings/bus/microsoft,vmbus.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index 0bea4f5287ce..4745c2b89ac5 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -17,6 +17,17 @@ properties:
   compatible:
     const: microsoft,vmbus
 
+  microsoft,message-connection-id:
+    description:
+      connection-id is a hardware-level identifier that specifies
+      which Hyper-V message port (or mailbox slot) the guest should
+      use to communicate with the VMBus control plane. When this
+      property is not present, the driver selects the connection ID
+      based on the protocol version (4 for VERSION_WIN10_V5 and
+      newer, or 1 for older versions).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
   ranges: true
 
   '#address-cells':
@@ -55,6 +66,7 @@ examples:
 
             vmbus@ff0000000 {
                 compatible = "microsoft,vmbus";
+                microsoft,message-connection-id = <4>;
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
-- 
2.34.1



