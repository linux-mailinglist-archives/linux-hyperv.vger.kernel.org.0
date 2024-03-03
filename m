Return-Path: <linux-hyperv+bounces-1654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C954C86F3F8
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Mar 2024 09:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F68D1F21C7E
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Mar 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4C9463;
	Sun,  3 Mar 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OIsDPnXO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFE10E6;
	Sun,  3 Mar 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709453351; cv=none; b=oyhqdgVWfmtoUdTjGBP2ImE6NfGuKkIfJr7TYmV/jsmMeUJbqqfWtyrrOsN1LSihzeJU0wO7Z4KBd0KZl24cl9MNywcrRpC64iGH9sijZrctldfEnWwo/KYpVJqPjBSFIsikLWcFBReF+GHDQYJMfLP+8vZ4pcIz1F3eFlLztOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709453351; c=relaxed/simple;
	bh=ivElpwwJNVf3hcpUOWwZJYI9eam2vDVE9K7L0MERDe8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uaoa744XhRtT0B4QrcIlGI10a9c9/Rz9wN3YSfya/HYA3rrovtg8J9muypyYKK9LjvoqitTVO8ESIHGUDOa8QZyVgYyHFeYU4JtAnbSqwQIcMre6SpG+u5GcPa4VvznlsE17kh+529r3Znxu0CsR+oMBQLYEYtvAqVAKIrGYj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OIsDPnXO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AC4020B74C0;
	Sun,  3 Mar 2024 00:01:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AC4020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709452900;
	bh=vUSOzIGgBi9vYkWUcajyjOx2gIH11Ew6VEiuY9yENd0=;
	h=From:To:Cc:Subject:Date:From;
	b=OIsDPnXOkFlauUZSv9FIsebaC3NeqaZU/thWQfGuhz77QVgm/yh44AQzvm4GJR5tb
	 kv/ZsCnLU79/5y9Zug5jS6sxtY7wzRD5YAke3RCKSo+XS6uSGQ+nyin7AyjR18Rcix
	 3/g1Xwfz8FjhP3W9eHM3HIwk2xBoSWZs2ybvzlv0=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	dwmw@amazon.co.uk,
	peterz@infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v3] x86/hyperv: Use per cpu initial stack for vtl context
Date: Sun,  3 Mar 2024 00:01:36 -0800
Message-Id: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently, the secondary CPUs in Hyper-V VTL context lack support for
parallel startup. Therefore, relying on the single initial_stack fetched
from the current task structure suffices for all vCPUs.

However, common initial_stack risks stack corruption when parallel startup
is enabled. In order to facilitate parallel startup, use the initial_stack
from the per CPU idle thread instead of the current task.

Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
[V3]
 - Added the VTL code dependency on SMP to fix kernel build error
   when SMP is disabled.

 arch/x86/hyperv/hv_vtl.c | 19 +++++++++++++++----
 drivers/hv/Kconfig       |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 804b629ea49d..b4e233954d0f 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
+#include <../kernel/smpboot.h>
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -58,7 +59,7 @@ static void hv_vtl_ap_entry(void)
 	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
 }
 
-static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
+static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 {
 	u64 status;
 	int ret = 0;
@@ -72,7 +73,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
 	struct ldttss_desc *ldt;
 	struct desc_struct *gdt;
 
-	u64 rsp = current->thread.sp;
+	struct task_struct *idle = idle_thread_get(cpu);
+	u64 rsp = (unsigned long)idle->thread.sp;
+
 	u64 rip = (u64)&hv_vtl_ap_entry;
 
 	native_store_gdt(&gdt_ptr);
@@ -199,7 +202,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
 static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
-	int vp_id;
+	int vp_id, cpu;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apicid))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
 	vp_id = hv_vtl_apicid_to_vp_id(apicid);
@@ -213,7 +224,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, start_eip);
+	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 00242107d62e..862c47b191af 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -16,6 +16,7 @@ config HYPERV
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
 	depends on X86_64 && HYPERV
+	depends on SMP
 	default n
 	help
 	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
-- 
2.34.1


