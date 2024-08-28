Return-Path: <linux-hyperv+bounces-2893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1B9625ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 13:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40411C23730
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F616CD03;
	Wed, 28 Aug 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="DF7UnX+E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874F170A3A;
	Wed, 28 Aug 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844162; cv=pass; b=dVSTrxphI78dRbiRpfrR72vGNFEyH0XZxYIPx4Mf2Y9QLOQ0zL1EK0X0GqDdjcDQtx6UXM5HcBjxEsoejWUFDMzk78bCParTNxer330PqsDC23vhqF6MCPUVeMHyqBBGUC++aP9TVjyN/pKORSNS0N803rcGJO7RSjkdkrs9iFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844162; c=relaxed/simple;
	bh=yVppzYDbQWwfqceHCGmVA/74JSTQdScgm955fmD9D5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qF5NeQ22/6boZOwQTVVgIRph9j7eapCFrtkVugGW/bQiwgnx0KiynKOOJrPG1HMYHrZczy1dLW74wmcDfuwJOeQu0aUWKBvWwF9djZRNZ1/X5Yv661O+y+GLF/nYF9v4SPvnPszPCDuqlg31G9kaeHh4Eyr+jdzWrwabbm3OTB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=fail (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=DF7UnX+E reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Delivered-To: anirudh@anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1724844140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WoJBXDDgTgwxU3OBOM3HrvXWVs4UODSmYTZJrQGiBYI+vI9obljtJ4cjNCaM+liaq3BHu24TDtXgHDVW6R4y9L5QVpPIqYkHq/KtXpd+h/2L6shlswkL5W55v/qBpbG4WuXZgCoIAZUHlApsiBWkrbLMI8zNww95iTIGv3lyu2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724844140; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vVW9787axKEB5O5XY7bxU2JHzWR3lad4WOowwBNCaeY=; 
	b=JcVbS3dx5VQZA4/63gQJNTgsJT29NXy6aVjk4RbPHjefmf9SiX+JrlxRBLoQrOZKpfek5IZ5vlPTy06W2W/Gb3LWXuLoundzPHeOOHs27XwmJjzkfPZMCV1zVl0BEHIlrgYotB21qzu4brTIWVq9aGAF8wythNizrBgz7WxHw+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724844140;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vVW9787axKEB5O5XY7bxU2JHzWR3lad4WOowwBNCaeY=;
	b=DF7UnX+EPdDta1GZYnAl1I4K4ylH3SjtC4K9lYsfB6j7Q0uJxR+36ulYvKFW7OoL
	TMzAq35ecZUcR0RQIYbYy8n6X+dFMYUOMhRKosJuSfLLWp38rX8qI/y9xi8HPB24mYn
	yuy5NEubZEDbkPD350+HTeTUhSKvOoNgCDgPXpaY=
Received: by mx.zohomail.com with SMTPS id 1724844137482399.08515585114355;
	Wed, 28 Aug 2024 04:22:17 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	stable@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/hyperv: fix kexec crash due to VP assist page corruption
Date: Wed, 28 Aug 2024 16:51:56 +0530
Message-ID: <20240828112158.3538342-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

commit 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when
CPUs go online/offline") introduces a new cpuhp state for hyperv
initialization.

cpuhp_setup_state() returns the state number if state is
CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN and 0 for all other states.
For the hyperv case, since a new cpuhp state was introduced it would
return 0. However, in hv_machine_shutdown(), the cpuhp_remove_state() call
is conditioned upon "hyperv_init_cpuhp > 0". This will never be true and
so hv_cpu_die() won't be called on all CPUs. This means the VP assist page
won't be reset. When the kexec kernel tries to setup the VP assist page
again, the hypervisor corrupts the memory region of the old VP assist page
causing a panic in case the kexec kernel is using that memory elsewhere.
This was originally fixed in commit dfe94d4086e4 ("x86/hyperv: Fix kexec
panic/hang issues").

Get rid of hyperv_init_cpuhp entirely since we are no longer using a
dynamic cpuhp state and use CPUHP_AP_HYPERV_ONLINE directly with
cpuhp_remove_state().

Cc: stable@vger.kernel.org
Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---

v1->v2:
- Remove hyperv_init_cpuhp entirely and use CPUHP_AP_HYPERV_ONLINE directly
  with cpuhp_remove_state().

v1: https://lore.kernel.org/linux-hyperv/87wmk2xt5i.fsf@redhat.com/T/#m54b8ae17e98d65e77a09002e478669d15d9830d0

---
 arch/x86/hyperv/hv_init.c       | 5 +----
 arch/x86/include/asm/mshyperv.h | 1 -
 arch/x86/kernel/cpu/mshyperv.c  | 4 ++--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..95eada2994e1 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -35,7 +35,6 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 
-int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
 EXPORT_SYMBOL_GPL(hv_current_partition_id);
 
@@ -607,8 +606,6 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
-	hyperv_init_cpuhp = cpuhp;
-
 	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
 
@@ -637,7 +634,7 @@ void __init hyperv_init(void)
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
-	cpuhp_remove_state(cpuhp);
+	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
 free_vp_assist_page:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 390c4d13956d..5f0bc6a6d025 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -40,7 +40,6 @@ static inline unsigned char hv_get_nmi_reason(void)
 }
 
 #if IS_ENABLED(CONFIG_HYPERV)
-extern int hyperv_init_cpuhp;
 extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..e98db51f25ba 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -199,8 +199,8 @@ static void hv_machine_shutdown(void)
 	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
 	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
 	 */
-	if (kexec_in_progress && hyperv_init_cpuhp > 0)
-		cpuhp_remove_state(hyperv_init_cpuhp);
+	if (kexec_in_progress)
+		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 
 	/* The function calls stop_other_cpus(). */
 	native_machine_shutdown();
-- 
2.45.2


