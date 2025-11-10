Return-Path: <linux-hyperv+bounces-7479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C7C44F62
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 06:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C9254E5CA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 05:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316C2E62B4;
	Mon, 10 Nov 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mbMUrBYv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E575849C;
	Mon, 10 Nov 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751333; cv=none; b=lDLiCPYL7+PL0e/7/Ci+hvOD4WEYCr3d1g8Qjl5f5edalhpPfDXt3Ai3zZbwNazfJQd94ceCJTUJtvE3eH2/BnRnyS2b/mQLJttUZbMgekeQj/ZFJxu//cyWd2Zziu41ThTjymyLWnNMkIXZJuJAp7sJjzESCMa0cATD51371fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751333; c=relaxed/simple;
	bh=bCm1J99NWc4jjQqAlN/imka4xXI5Y0qBL0RgQn5Vfag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ellpWwdru2AW3pa9mwKo6ndblGSBK7/3go3mv1mxacnVwbVQ+HOswlCLNSUm5+1QhhIcAunrWowFFSzwAjBd2LZyUZBacTelnHoN09nZmg+5uFmCmGis1FllNwQHGWiCWpo0PSU1SNVmJKGbffTDnaf0VKoafaSdQItdToQMCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mbMUrBYv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-1AYIP.redmond.corp.microsoft.com (unknown [4.213.232.44])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E480206C16E;
	Sun,  9 Nov 2025 21:08:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E480206C16E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762751331;
	bh=ywTpnvyUZ9q8qmgw2M1XvicAqjpo/lYW4xUhfd1xNKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbMUrBYvLs/wwzvRqccGQXphnN4sc6Eh6hHun8WV6Kk0TPad0jshOZdg+q9t3Ykwo
	 fjfd4zYCSodlqjQzYkQ6bCwmQEYmJw6keDmFvJ7j92pRRec7dzMt4B0Om5L4Vf7Pl7
	 lEKmdskjsDXcwRy25DSw0FDQV4axfWq1Gtrnwfl4=
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
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH v11 1/2] Drivers: hv: Export some symbols for mshv_vtl
Date: Mon, 10 Nov 2025 05:08:34 +0000
Message-ID: <20251110050835.1603847-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110050835.1603847-1-namjain@linux.microsoft.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/hv.c           | 3 +++
 drivers/hv/hyperv_vmbus.h | 1 +
 drivers/hv/vmbus_drv.c    | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 936c5f310df6..c100f04b3581 100644
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
+EXPORT_SYMBOL_FOR_MODULES(hv_context, "mshv_vtl");
 
 /*
  * hv_init - Main initialization routine.
@@ -104,6 +106,7 @@ int hv_post_message(union hv_connection_id connection_id,
 
 	return hv_result(status);
 }
+EXPORT_SYMBOL_FOR_MODULES(hv_post_message, "mshv_vtl");
 
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
index 0dc4692b411a..47fcab38398a 100644
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
+EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-- 
2.43.0


