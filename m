Return-Path: <linux-hyperv+bounces-6431-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04919B1477D
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 07:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABF7189B748
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E3230D08;
	Tue, 29 Jul 2025 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S/R1A7D1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35431236431;
	Tue, 29 Jul 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766093; cv=none; b=E2XjmJ2ZDGciw6n+weJyc8W4euCtF8ZwTbTf3IGXSJi167QI9RmPr5WxtXGv6WxmUFA5Dm1O/5xC/JdVWraaajq0AWIZFIKfFhKDEhHagL0crSuF63FzqBXh4SkG0R+GIH3ji0mAOxvYPhTnDNrl/LaYFy2VSMlw4ajjJvj5OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766093; c=relaxed/simple;
	bh=mWvkhpSqWhI4QxVpXUxZ+ddsYY4Go7gvULOWZ1oBRa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsVnQQeJ8pubzDZkQPpJHBddU7IfsRX/Ca6oaCTB9pVyQb3CcbM8nOm20wgXFyz4wup8MKiNBV6kLn5EQ5qg+d6RMjDpJQ9P5Oa0kcuu2TdwZA4pO9mTmrovAZhlzs40bDc/bBiup9Bu/Ad0SSydWj7upAffn4jurLB4wbx+MJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S/R1A7D1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.41])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B71F2117647;
	Mon, 28 Jul 2025 22:14:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B71F2117647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753766091;
	bh=km3UbVQWOUyw7xP9GJcOMVJRseCPwvZ8cgODGI+74TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/R1A7D1HXUTyTBdI9vrLSWE3gGyEqgqjHo3Q/TEgwuagQiKOOU+1spYHCSfEMVzI
	 4cqEM2rTGmtcTkHC3B/njvNz2aa70HuDBOaQw4YiiVlVKLdRlilhmCbPNi9BBFGGLD
	 ho2bbOeaVpeIK+1pxgIj0zEJAI8rN8xuguqEjmaA=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v7 1/2] Drivers: hv: Export some symbols for mshv_vtl
Date: Tue, 29 Jul 2025 10:44:35 +0530
Message-Id: <20250729051436.190703-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250729051436.190703-1-namjain@linux.microsoft.com>
References: <20250729051436.190703-1-namjain@linux.microsoft.com>
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@intel.com/
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/hv.c           | 3 +++
 drivers/hv/hyperv_vmbus.h | 1 +
 drivers/hv/vmbus_drv.c    | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b14c5f9e0ef2..b16e94daa270 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/export.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include <linux/set_memory.h>
@@ -25,6 +26,7 @@
 
 /* The one and only */
 struct hv_context hv_context;
+EXPORT_SYMBOL_GPL(hv_context);
 
 /*
  * hv_init - Main initialization routine.
@@ -95,6 +97,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
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
index 2ed5a1e89d69..a366365f2c49 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,6 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
+#include <linux/export.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -1306,7 +1307,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	}
 }
 
-static void vmbus_isr(void)
+void vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1329,6 +1330,7 @@ static void vmbus_isr(void)
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
+EXPORT_SYMBOL_GPL(vmbus_isr);
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-- 
2.34.1


