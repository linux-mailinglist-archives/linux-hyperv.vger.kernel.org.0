Return-Path: <linux-hyperv+bounces-1557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE3859172
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 19:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A690280C3E
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3177E117;
	Sat, 17 Feb 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pL8d8Dux"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D37D3F6;
	Sat, 17 Feb 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708193075; cv=none; b=VSr7IMw/C280XxXkCnYB3cyHGdJX0F+Hi/5UkLOsD0KXqt3X/ZuuQoJ5LA6BPIlLHBk6F3nNXrtz6A7ZP23NjXGRv1dB2kGx0AEdRy51V0HS8Es7Is13EmUOZMRn/xp9Iy1iQ1GdhbS9sXVbnJSmg+ZHaS1m27QModaGwynS+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708193075; c=relaxed/simple;
	bh=eEQdEhkRhTvXLDK0ExelfFMrd3JVa1/jnkj41RfY3Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qwjg2ZQPw0OYrqHvLbCnnKL1mEDLueM0jHx2AiWE1BEkVOskU/JD16MFKhYbLh3XZDgUJ5XTUJbAfGW/oiMozw2CEA83zPrB1HDNWfeGh+YcN9fK1NGLOtq3FaQIVJB75duzMhv887KYThWHGYvNG6yuRx7MK027e4E99B+ZuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pL8d8Dux; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CB1A207FD2C;
	Sat, 17 Feb 2024 10:04:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CB1A207FD2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708193067;
	bh=u7XIjROBZmicmyXMY8w3Cxhx4ZbeH5xu95iiNnPZkuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pL8d8DuxzHRTdH9ugapQhVN8aVGBA/ZxfXsRmiv5lSJi2dptyyvtmNo/vwAFRVzWu
	 qfJAVc/B7oUGx4YEnra+xzf1oNvtVnzqofFViSPfeyYEL7aq13rLSFVH5Bm2m9GJZn
	 1UhdihCFR6WE2jaNKPfESu6MuiLMfV/sJjAam7Jo=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for querying ring size
Date: Sat, 17 Feb 2024 10:03:35 -0800
Message-Id: <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add a function to query for the preferred ring buffer size of VMBus
device.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/channel_mgmt.c | 7 +++++--
 drivers/hv/hyperv_vmbus.h | 5 +++++
 include/linux/hyperv.h    | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 2f4d09ce027a..7ea444d72f9f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -120,7 +120,8 @@ const struct vmbus_device vmbus_devs[] = {
 	},
 
 	/* File copy */
-	{ .dev_type = HV_FCOPY,
+	{ .pref_ring_size = 0x4000,
+	  .dev_type = HV_FCOPY,
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
@@ -141,11 +142,13 @@ const struct vmbus_device vmbus_devs[] = {
 	},
 
 	/* Unknown GUID */
-	{ .dev_type = HV_UNKNOWN,
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
index 2b00faf98017..5951c7bb5712 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -800,6 +800,7 @@ struct vmbus_requestor {
 #define VMBUS_RQST_RESET (U64_MAX - 3)
 
 struct vmbus_device {
+	size_t pref_ring_size;
 	u16  dev_type;
 	guid_t guid;
 	bool perf_device;
-- 
2.34.1


