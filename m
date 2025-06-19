Return-Path: <linux-hyperv+bounces-5969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE85AE0FE2
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 01:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2E64A2657
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61028E56B;
	Thu, 19 Jun 2025 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B9SuDABR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735D28DF32;
	Thu, 19 Jun 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374443; cv=none; b=kEeMh0vBwETiqLn4szvknPezX+Lu9cvhP/JAZjo9UdGyw4Irwc86xHmc9xCUzQBrQRRk1nGk03spdYuicoJ7R+p3rkJM6tMl+P+Mj0jmVqv7pkjbvxH7278AlCOS56/jodpRLEdzO9a1bjk4JngixOWY1JGticH7cN32iwNHUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374443; c=relaxed/simple;
	bh=/sOaS+hbkequcuE8aG0SsZSgDJ3nCjqOHEY1BGDzuFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZmMA70/k9sscXfTjg1/o/JyxCckvoX8gCRQmE7iZqgMa/CGGMTdx4iMQHsg1WsQ04dMXfbHw+4SnCNiQJJpL8tmwur3o0dYFV46u13pO4zMp1WNDz4mEq2SixPOYBu0oIvdqNMFkZtYKgnhPZHpFgJHMjWLpK20iGZIeIX5jPp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B9SuDABR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 142F9201C74B; Thu, 19 Jun 2025 16:07:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 142F9201C74B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750374442;
	bh=0xy7llJQ1xMXfeeDPMOG3Jf8ypWlDPfWsIqQcRypAm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9SuDABRolltD+vDbDtKifeG5Q4jkTN+pNSKimAJ4ZrFFfuukgqh/5Wudt0JzpQg/
	 yN8/IPrITqUECV/94x1geaT5cWnOy17MNeP4FSP+O+58oAW4Y8iufMn/mAD2o6mYrk
	 HmrRzGbkfa7u6p+4as7KWrytyK8z2kmCH6OnqcTA=
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
Subject: [PATCH v4 2/2] vmbus: retrieve connection-id from DeviceTree
Date: Thu, 19 Jun 2025 16:06:35 -0700
Message-Id: <1750374395-14615-3-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
References: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

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
v3: https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com
v2: https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com
v1: https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com
---
 drivers/hv/connection.c |  6 ++++--
 drivers/hv/vmbus_drv.c  | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index be490c598785..15d2b652783d 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -99,11 +99,13 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	if (version >= VERSION_WIN10_V5) {
 		msg->msg_sint = VMBUS_MESSAGE_SINT;
 		msg->msg_vtl = ms_hyperv.vtl;
-		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
 	} else {
 		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
-		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
 	}
+	/* Set default connection ID if not provided via DeviceTree */
+	if (!vmbus_connection.msg_conn_id)
+		vmbus_connection.msg_conn_id = (version >= VERSION_WIN10_V5) ?
+			VMBUS_MESSAGE_CONNECTION_ID_4 : VMBUS_MESSAGE_CONNECTION_ID;
 
 	/*
 	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c236081d0a87..b78d5499e4bc 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2541,10 +2541,23 @@ static int vmbus_device_add(struct platform_device *pdev)
 	struct of_range range;
 	struct of_range_parser parser;
 	struct device_node *np = pdev->dev.of_node;
+	unsigned int conn_id;
 	int ret;
 
 	vmbus_root_device = &pdev->dev;
 
+	/*
+	 * Read connection ID from DeviceTree. The property name follows the
+	 * format <vendor>,<field> where:
+	 * - vendor: "microsoft"
+	 * - field: "message-connection-id"
+	 */
+	ret = of_property_read_u32(np, "microsoft,message-connection-id", &conn_id);
+	if (!ret) {
+		pr_info("VMBus message connection ID: %u\n", conn_id);
+	    vmbus_connection.msg_conn_id = conn_id;
+	}
+
 	ret = of_range_parser_init(&parser, np);
 	if (ret)
 		return ret;
-- 
2.40.4


