Return-Path: <linux-hyperv+bounces-1504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C80846910
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC81C26011
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDC17BDC;
	Fri,  2 Feb 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eypSXRLh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82417BCD;
	Fri,  2 Feb 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857971; cv=none; b=VRCv9YtnO1/IuW+o+Y1hMBVI6jOzQmsZHK0Uu0erQAn2gNiuwfUTY5lH9Grgm0l6SCiO1wPbyzIXJvaL3hXpoxMsDrb7j7KDnkukywsVJU7XxB2NzqfufZB9LrIjUqYBpIvV+3keOzDoSC4NaRuv/JtZnAdwqB42hpeGuOrdyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857971; c=relaxed/simple;
	bh=OXJcTTtmB7mC8LGM63buUTanubcADvLhLibsbVoC900=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UzQs8Z9oZSfTsD2MfU2+FWpfR+krN5vECbI/Z6lIhUqQD0NQIA0nAwciEA1AYthJ3ecY2t0NEN5znPynUebAWwA3h7BVne6sLbjAho7HsOIqKUF4GVZ4Iph1Qmxi1LqXgru0U5pqrjEIqcd3R0Vgtfncxhv+s6s2YJ7L0q22j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eypSXRLh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B26020B2000;
	Thu,  1 Feb 2024 23:12:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B26020B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706857970;
	bh=R5u/o9X7wtbTC+FTLZo+7zWFnW6hVfTvEu5yxIcwaUM=;
	h=From:To:Cc:Subject:Date:From;
	b=eypSXRLhHoOO3GKUNF+boHveRs81hoSKCuhIQoKJGEbt3UQIJH7fUL0nwBMhxkfx+
	 5ByylJbQcVKI1ZB6XWu8YEKVpU3Z13sg/lFKf7Mcnxh/kwGIEk104ARK9QPh69Hm9x
	 FEAU0H3Elx7GeZdWrvSjtKRccUdcvIO7yfhfAlRY=
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
Cc: ssengar@microsoft.com
Subject: [PATCH v2] x86/hyperv: Use per cpu initial stack for vtl context
Date: Thu,  1 Feb 2024 23:12:37 -0800
Message-Id: <1706857957-13857-1-git-send-email-ssengar@linux.microsoft.com>
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
---
 arch/x86/hyperv/hv_vtl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 96e6c51515f5..b0ab724def17 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
+#include <../kernel/smpboot.h>
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -57,7 +58,7 @@ static void hv_vtl_ap_entry(void)
 	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
 }
 
-static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
+static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 {
 	u64 status;
 	int ret = 0;
@@ -71,7 +72,8 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
 	struct ldttss_desc *ldt;
 	struct desc_struct *gdt;
 
-	u64 rsp = current->thread.sp;
+	struct task_struct *idle = idle_thread_get(cpu);
+	u64 rsp = (unsigned long)idle->thread.sp;
 	u64 rip = (u64)&hv_vtl_ap_entry;
 
 	native_store_gdt(&gdt_ptr);
@@ -198,7 +200,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
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
@@ -212,7 +222,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, start_eip);
+	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
-- 
2.34.1


