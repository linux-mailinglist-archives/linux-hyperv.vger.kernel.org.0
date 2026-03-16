Return-Path: <linux-hyperv+bounces-9434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELX4LTD1t2mfXQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9434-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:18:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9292995D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F9CF30342CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881A395DB8;
	Mon, 16 Mar 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cSQ16MVj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C253909A0;
	Mon, 16 Mar 2026 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663249; cv=none; b=aMreI+stFGOzM5DStZE457E9HPswJ4I/z3vBhWrnlNh8+y51tMe+0oxRmMMIj3J8FSJ3J2s9RVQblyUjQfmwKTkKRUYS7sHxqxZ4SGBuT2bMWmfgwGbm/rRZjgKrgmH08fddUylR2DGVnClmWJErVPf0XJ/C3gzSPnQnjOhOX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663249; c=relaxed/simple;
	bh=Aosphk+esZ+v58Q9WvRh97SsPNb//Li8JvZOSif4gXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwktJgwUe5UbgLOlcHdsZJ/uektWh1Y4OJxqGpxDbjpC9QT+j2U1eTk0lFu69scBTZ10KdScKjTZm6ePHNq0NIzUDm2Isjhuu2aKWerWQFvWyiMUUgUbklkFptbX77d9oLs0UC4vznebIsaUgNx480Cxw3o5ONnivYcX2IaCZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cSQ16MVj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1219420B6F12;
	Mon, 16 Mar 2026 05:14:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1219420B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773663247;
	bh=jB+RemL3Pk8PFFcu2obc8ovkfjIzseACUPlWgi1xPjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSQ16MVj4newgvduGvn6HO5LY8y/IM488Ga/wfFvNxsMmRIrMVhJbDA0bFdOGID8j
	 01S3ewI3UDGQTajSrNTPDhUwZPxE/ErNp/QuudR67eGucLFjbSFhYtwssr5mtWtjFL
	 qarbXKOqrRPQCEJeNtLfBJeb0FSsf0JoDU5lmdHk=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	ssengar@linux.microsoft.com,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 10/11] Drivers: hv: Add support for arm64 in MSHV_VTL
Date: Mon, 16 Mar 2026 12:12:40 +0000
Message-ID: <20260316121241.910764-11-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316121241.910764-1-namjain@linux.microsoft.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9434-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: BE9292995D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add necessary support to make MSHV_VTL work for arm64 architecture.
* Add stub implementation for mshv_vtl_return_call_init(): not required
  for arm64
* Remove fpu/legacy.h header inclusion, as this is not required
* handle HV_REGISTER_VSM_CODE_PAGE_OFFSETS register: not supported
  in arm64
* Configure custom percpu_vmbus_handler by using
  hv_setup_percpu_vmbus_handler()
* Handle hugepage functions by config checks

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h |  2 ++
 drivers/hv/mshv_vtl_main.c        | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 36803f0386cc..027a7f062d70 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -83,6 +83,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u
 	return 1;
 }
 
+static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
+
 void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
 bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
 #endif
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 4c9ae65ad3e8..5702fe258500 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -23,8 +23,6 @@
 #include <trace/events/ipi.h>
 #include <uapi/linux/mshv.h>
 #include <hyperv/hvhdk.h>
-
-#include "../../kernel/fpu/legacy.h"
 #include "mshv.h"
 #include "mshv_vtl.h"
 #include "hyperv_vmbus.h"
@@ -206,18 +204,21 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
 static int mshv_vtl_get_vsm_regs(void)
 {
 	struct hv_register_assoc registers[2];
-	int ret, count = 2;
+	int ret, count = 0;
 
-	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
-	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
+	registers[count++].name = HV_REGISTER_VSM_CAPABILITIES;
+	/* Code page offset register is not supported on ARM */
+	if (IS_ENABLED(CONFIG_X86_64))
+		registers[count++].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
 
 	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
 				       count, input_vtl_zero, registers);
 	if (ret)
 		return ret;
 
-	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
-	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
+	mshv_vsm_capabilities.as_uint64 = registers[0].value.reg64;
+	if (IS_ENABLED(CONFIG_X86_64))
+		mshv_vsm_page_offsets.as_uint64 = registers[1].value.reg64;
 
 	return ret;
 }
@@ -280,10 +281,13 @@ static int hv_vtl_setup_synic(void)
 
 	/* Use our isr to first filter out packets destined for userspace */
 	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
+	/* hv_setup_vmbus_handler() is stubbed for ARM64, add per-cpu VMBus handlers instead */
+	hv_setup_percpu_vmbus_handler(mshv_vtl_vmbus_isr);
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
 				mshv_vtl_alloc_context, NULL);
 	if (ret < 0) {
+		hv_setup_percpu_vmbus_handler(vmbus_isr);
 		hv_setup_vmbus_handler(vmbus_isr);
 		return ret;
 	}
@@ -296,6 +300,7 @@ static int hv_vtl_setup_synic(void)
 static void hv_vtl_remove_synic(void)
 {
 	cpuhp_remove_state(mshv_vtl_cpuhp_online);
+	hv_setup_percpu_vmbus_handler(vmbus_isr);
 	hv_setup_vmbus_handler(vmbus_isr);
 }
 
@@ -1080,10 +1085,12 @@ static vm_fault_t mshv_vtl_low_huge_fault(struct vm_fault *vmf, unsigned int ord
 			ret = vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 		return ret;
 
+#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	case PUD_ORDER:
 		if (can_fault(vmf, PUD_SIZE, &pfn))
 			ret = vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 		return ret;
+#endif
 
 	default:
 		return VM_FAULT_SIGBUS;
-- 
2.43.0


