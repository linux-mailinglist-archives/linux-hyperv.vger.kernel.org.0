Return-Path: <linux-hyperv+bounces-5968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D450AE0FDF
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 01:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A3C1BC42FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174728C870;
	Thu, 19 Jun 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oj/SXPx+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD52673AA;
	Thu, 19 Jun 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374440; cv=none; b=cjOkFAxW6urDl4/s4M99jwTiSdu3+5snzlMOREBN0cCZlmb6xjQ1l3esN1hS/a5ClBtQxonUdrvxcJhoF5PYNb3kjTZwiPGS9BY7+V42BwqwwslTrRyyIlWMNshh9zKIg4E/+7PItvt5UGMi8IxnIMwUxgZtAxAFkH8YTFCat9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374440; c=relaxed/simple;
	bh=p7pAlPmMB/gvfRpS1D9ARYqS1/tXZtp/xSZNtxetRQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BPJDJ/iy06HH8Oe+YzIxj1RpsQJfettOjR58qAOA2ZuupMp+mDx+s5LoJ8EuaVOQTBg1IoAMNJdcAcyzPTlDho/mPPodQwb+dbINy5fPwLWQYpaQqEosTd8ea9rVlvq4r1fquuBwO1Nxiwp7yRlQGVv+QZ2DQyJcnOSRQfTtY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oj/SXPx+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 3637E201C768; Thu, 19 Jun 2025 16:07:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3637E201C768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750374439;
	bh=cXGJWrpYn8fTcAHe48jOe5AVDF7Ze1gV6pAIwUYIgDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oj/SXPx+I0DRqJiejCLDPp3EXIPif8ief+NIm3uPH5paIJF8vcrjSqRUp/SXqhefy
	 kA8OK7uNKOfIufiky4ixyFRSi/ko7yCtWxnKqXdUTbABEVO11HaBU3qi9JXGeYTrch
	 Cx2x2hVIzGYcpkBpMOj6Xc9CANMUkkxR+BJh85u0=
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	hargar@microsoft.com,
	apais@microsoft.com,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus message-connection-id property
Date: Thu, 19 Jun 2025 16:06:34 -0700
Message-Id: <1750374395-14615-2-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
References: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Document the microsoft,message-connection-id property for VMBus DeviceTree
node. This property allows specifying the connection ID used for
communication between host and guest.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
v3: https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
v2: https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
v1: https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
---
 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index 0bea4f5287ce..615b48bd6a8b 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -17,6 +17,14 @@ properties:
   compatible:
     const: microsoft,vmbus
 
+  microsoft,message-connection-id:
+    description: |
+      VMBus message connection ID to be used for communication between host and
+      guest. If not specified, defaults to VMBUS_MESSAGE_CONNECTION_ID_4 (4) for
+      protocol version VERSION_WIN10_V5 and above, or VMBUS_MESSAGE_CONNECTION_ID
+      (1) for older versions.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   ranges: true
 
   '#address-cells':
@@ -55,6 +63,7 @@ examples:
 
             vmbus@ff0000000 {
                 compatible = "microsoft,vmbus";
+                microsoft,message-connection-id = <4>;
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
-- 
2.40.4


