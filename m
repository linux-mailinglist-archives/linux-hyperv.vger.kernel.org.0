Return-Path: <linux-hyperv+bounces-7365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25037C18449
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 06:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F33B74E909A
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 05:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72475288C25;
	Wed, 29 Oct 2025 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fFnXgTLr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5332F657F;
	Wed, 29 Oct 2025 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761714121; cv=none; b=OX4tunPxny7np3HTpbIt9CPEAaUywLjYwv5E3qoB0A7p4aLCYW8sKQbQg+TcdlIWFg0Ds3sjAe6lioUhrDYVk9HLlrI0F28QBgoM8rVE6nj0DyGgfuwsGtEC5Thc//7G+VahPsaulSVUlkBc0A3nnQmVLXZJlkrI6IaHwHWBL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761714121; c=relaxed/simple;
	bh=y3Gj/WbRMGKkoj7tl2On03ti94HfLD+G70hzCXYHkkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB072T18cu9/dU9e3Ei28HdLjBc38kQal6oBstTPkvAZkC9C5p+V3pmrrAxBdLTHXVOuMb3Ok/137iUwwfbBQmk4kzuKoy9nadMf7hnIfM4eVecAGLXPbmZ4wp5SvCIwM0dBO/Cyk1Y7M4U+tUZZzEdis71RV1HaYn24yVIoqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fFnXgTLr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-1AYIP.redmond.corp.microsoft.com (unknown [4.213.232.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD66C211D8DB;
	Tue, 28 Oct 2025 22:01:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD66C211D8DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761714119;
	bh=vBZYdZvaGmcRu0+iQEmBvmob+NMHDxrCG0mCffx7EFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFnXgTLrMpRTXVeM0NRB6FDDQQxElhPw7yj15yaTBEWj+/HtbVcrlK/lwvRHtRXYg
	 L5/aMLVHy24ooKJYrFAVgRYPO/VVm7dMZoySkOnbUYaLbwX7O9EJSqBHRc8FSRppiw
	 NM27rjIJ8LuQJ4JmxTgMs+cOlWOh1CNaJo9Gr4BE=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH v10 1/2] Drivers: hv: Export some symbols for mshv_vtl
Date: Wed, 29 Oct 2025 05:01:38 +0000
Message-ID: <20251029050139.46545-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029050139.46545-1-namjain@linux.microsoft.com>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@intel.com/
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/hv.c           | 3 +++
 drivers/hv/hyperv_vmbus.h | 1 +
 drivers/hv/vmbus_drv.c    | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 936c5f310df6..c924e3294b8b 100644
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
@@ -104,6 +106,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
 	return hv_result(status);
 }
+EXPORT_SYMBOL_GPL(hv_post_message);
 
 static int hv_alloc_page(void **page, bool decrypt, const char *note)
 {
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f7fc2630c054..b2862e0a317a 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -33,6 +33,7 @@
  */
 #define HV_UTIL_NEGO_TIMEOUT 55
 
+void vmbus_isr(void);
 
 /* Definitions for the monitored notification facility */
 union hv_monitor_trigger_group {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0dc4692b411a..c9ad17ed562d 100644
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
@@ -1349,7 +1350,7 @@ static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message
 	}
 }
 
-static void vmbus_isr(void)
+void vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1362,6 +1363,7 @@ static void vmbus_isr(void)
 
 	add_interrupt_randomness(vmbus_interrupt);
 }
+EXPORT_SYMBOL_GPL(vmbus_isr);
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-- 
2.43.0


