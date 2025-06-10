Return-Path: <linux-hyperv+bounces-5819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9942AD2D3F
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 07:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2E1700AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D825E469;
	Tue, 10 Jun 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HkPX503X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42D25EF92;
	Tue, 10 Jun 2025 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533087; cv=none; b=sH6dRYGmSYc4njCGKVyJzzF7MP4mjagrhCn/wCS7vSvRwPOuipYIdn0MLg2wBMbPJLaeOSGMD8CYijsEpJjMTWhbsb8BgZd8mFBa9sGR3SeW4xDXjH1gPfF0NQscN7WpQol3wKZVOIWd4WV19ZgGWRzYWNUmbEwnVEFL+63XMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533087; c=relaxed/simple;
	bh=tCkGnb6vZ3EAgcDDuUw8hCdLEoZGwE4+r/Iu8qutXnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fW+rWrXBevdRRw3FhW5+yR7vf/+MpzB3Zg04T9vRintuZwULuuexdtI44eOg5SOCBrUWputhihpWvp0Q2K5PKP4LY7q7e6QtwvafZzxuPJKvACbn+xuJUINQJE4uqSNfFN7UDPAfekThU/zVp3oJf+4zo8I18/8nmLJ3FM1pF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HkPX503X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-RSFL4TU.corp.microsoft.com (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9304211759A;
	Mon,  9 Jun 2025 22:24:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9304211759A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749533085;
	bh=XEoc+Br4dcJuVWPskqWf+oSpbnRsODzFVciFxFiigkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkPX503Xjv9MTv82eC/IYAyorKY7CKVaZ06roXA5Cp1vs+ayiIujcT7EXtcyMLBmI
	 dmSA8yhDQww7SccyE63K4VaF/HF0HQAy8D7URYP9+p5roQDs8lxfwY6xsvk8yxDnAw
	 fO/mgiyv4jfD9sT1ThI5MluHyXS4VxFb59Ns1PVM=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v4 1/2] Drivers: hv: Export some symbols for mshv_vtl
Date: Tue, 10 Jun 2025 10:54:34 +0530
Message-Id: <20250610052435.1660967-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610052435.1660967-1-namjain@linux.microsoft.com>
References: <20250610052435.1660967-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSHV_VTL driver is going to be introduced, which is supposed to
provide interface for Virtual Machine Monitors (VMMs) to control
Virtual Trust Level (VTL). Export the symbols needed
to make it work (vmbus_isr, hv_context and hv_post_message).

Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Message-ID: <20250512140432.2387503-2-namjain@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/hv.c           | 2 ++
 drivers/hv/hyperv_vmbus.h | 1 +
 drivers/hv/vmbus_drv.c    | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..11e8096fe840 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -25,6 +25,7 @@
 
 /* The one and only */
 struct hv_context hv_context;
+EXPORT_SYMBOL_GPL(hv_context);
 
 /*
  * hv_init - Main initialization routine.
@@ -93,6 +94,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
 	return hv_result(status);
 }
+EXPORT_SYMBOL_GPL(hv_post_message);
 
 int hv_synic_alloc(void)
 {
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 0b450e53161e..b61f01fc1960 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -32,6 +32,7 @@
  */
 #define HV_UTIL_NEGO_TIMEOUT 55
 
+void vmbus_isr(void);
 
 /* Definitions for the monitored notification facility */
 union hv_monitor_trigger_group {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4291e4db70e4..855cf5c111c2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1306,7 +1306,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	}
 }
 
-static void vmbus_isr(void)
+void vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1329,6 +1329,7 @@ static void vmbus_isr(void)
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
+EXPORT_SYMBOL_GPL(vmbus_isr);
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-- 
2.34.1


