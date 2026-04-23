Return-Path: <linux-hyperv+bounces-10333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP86OvUU6mmVtgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10333-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB7452426
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FEBD302E1B4
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761F3EDAA6;
	Thu, 23 Apr 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JmSCk4Ym"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624561D6DB5;
	Thu, 23 Apr 2026 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948217; cv=none; b=BYp4ABpRZ7P5ZyFEpiR2zD1p4G07vzLo5ddK1MNKYW+qY2DwTyhdl5pqLLuam2AnR2jz2i+Riiw82EB8HZRm+4wxNL5za+PUCEaxsAwMHHZzP80n4oqW6sj0SO1rDwFQGW5qcCGJXBTjhh4CMDryf6jHuOq6b5bEprrcCoMvs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948217; c=relaxed/simple;
	bh=YOK/a+e/PtY6w+pqw8Ybhle3cg9YiSM6I03HdX42Bn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY47PbL1R8b1ZEuAXBz1Ll4fqTTlnPsdAZiBV+q7k79+unDOUHXSImG6ExudALoVQkyob2AEw78y8Vkz2NmbhIQpirwGDvW6XZ9uWKS3ff+9u9HRl71YBew0mMBPJ5dWyvEChGlAuLk0u+HJCasUhoe7YEbTV+Bb7lgnRfyl6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JmSCk4Ym; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45C5820B7169;
	Thu, 23 Apr 2026 05:43:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45C5820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948216;
	bh=uQw1PT6DTk9aMq/uyQg5ZP88ycqsrhH6HFR6Qo8Qtvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmSCk4YmnmzDUTARRleR7GDQGFC3wWT780ANEY8sBDC6VoRAKc1F1Pu5BC9WoCnMg
	 r/u12AZ5+4NrhrxhIlwandv1AmysWhK0cKlFyYYnR9i1JF53ayB68lBxA7/apqCUIj
	 lAWWPdgMd6mxfsTq7rhiVIrk3AHCq5ZseKLZPkJE=
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move hv_vtl_configure_reg_page() to x86
Date: Thu, 23 Apr 2026 12:41:59 +0000
Message-ID: <20260423124206.2410879-10-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423124206.2410879-1-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10333-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org,mailbox.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: AFDB7452426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move hv_vtl_configure_reg_page() from drivers/hv/mshv_vtl_main.c to
arch/x86/hyperv/hv_vtl.c. The register page overlay is an x86-specific
feature that uses HV_X64_REGISTER_REG_PAGE, so its configuration belongs
in architecture-specific code.

Move struct mshv_vtl_per_cpu and union hv_synic_overlay_page_msr to
include/asm-generic/mshyperv.h so they are visible to both arch and
driver code.

Change the return type from void to bool so the caller can determine
whether the register page was successfully configured and set
mshv_has_reg_page accordingly.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c       | 32 ++++++++++++++++++++++
 drivers/hv/mshv_vtl_main.c     | 49 +++-------------------------------
 include/asm-generic/mshyperv.h | 17 ++++++++++++
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 09d81f9b853c..f3ffb6a7cb2d 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -20,6 +20,7 @@
 #include <uapi/asm/mtrr.h>
 #include <asm/debugreg.h>
 #include <linux/export.h>
+#include <linux/hyperv.h>
 #include <../kernel/smpboot.h>
 #include "../../kernel/fpu/legacy.h"
 
@@ -259,6 +260,37 @@ int __init hv_vtl_early_init(void)
 	return 0;
 }
 
+static const union hv_input_vtl input_vtl_zero;
+
+bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
+{
+	struct hv_register_assoc reg_assoc = {};
+	union hv_synic_overlay_page_msr overlay = {};
+	struct page *reg_page;
+
+	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
+	if (!reg_page) {
+		WARN(1, "failed to allocate register page\n");
+		return false;
+	}
+
+	overlay.enabled = 1;
+	overlay.pfn = page_to_hvpfn(reg_page);
+	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
+	reg_assoc.value.reg64 = overlay.as_uint64;
+
+	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
+				     1, input_vtl_zero, &reg_assoc)) {
+		WARN(1, "failed to setup register page\n");
+		__free_page(reg_page);
+		return false;
+	}
+
+	per_cpu->reg_page = reg_page;
+	return true;
+}
+EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
+
 DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
 
 void mshv_vtl_return_call_init(u64 vtl_return_offset)
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 91517b45d526..c79d24317b8e 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -78,21 +78,6 @@ struct mshv_vtl {
 	u64 id;
 };
 
-struct mshv_vtl_per_cpu {
-	struct mshv_vtl_run *run;
-	struct page *reg_page;
-};
-
-/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
-union hv_synic_overlay_page_msr {
-	u64 as_uint64;
-	struct {
-		u64 enabled: 1;
-		u64 reserved: 11;
-		u64 pfn: 52;
-	} __packed;
-};
-
 static struct mutex mshv_vtl_poll_file_lock;
 static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
 static union hv_register_vsm_capabilities mshv_vsm_capabilities;
@@ -201,34 +186,6 @@ static struct page *mshv_vtl_cpu_reg_page(int cpu)
 	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
 }
 
-static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
-{
-	struct hv_register_assoc reg_assoc = {};
-	union hv_synic_overlay_page_msr overlay = {};
-	struct page *reg_page;
-
-	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
-	if (!reg_page) {
-		WARN(1, "failed to allocate register page\n");
-		return;
-	}
-
-	overlay.enabled = 1;
-	overlay.pfn = page_to_hvpfn(reg_page);
-	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
-	reg_assoc.value.reg64 = overlay.as_uint64;
-
-	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
-				     1, input_vtl_zero, &reg_assoc)) {
-		WARN(1, "failed to setup register page\n");
-		__free_page(reg_page);
-		return;
-	}
-
-	per_cpu->reg_page = reg_page;
-	mshv_has_reg_page = true;
-}
-
 static void mshv_vtl_synic_enable_regs(unsigned int cpu)
 {
 	union hv_synic_sint sint;
@@ -329,8 +286,10 @@ static int mshv_vtl_alloc_context(unsigned int cpu)
 	if (!per_cpu->run)
 		return -ENOMEM;
 
-	if (mshv_vsm_capabilities.intercept_page_available)
-		mshv_vtl_configure_reg_page(per_cpu);
+	if (mshv_vsm_capabilities.intercept_page_available) {
+		if (hv_vtl_configure_reg_page(per_cpu))
+			mshv_has_reg_page = true;
+	}
 
 	mshv_vtl_synic_enable_regs(cpu);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ef0b9466808c..9e86178c182e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -420,12 +420,29 @@ static inline int hv_call_set_vp_registers(u32 vp_index, u64 partition_id,
 }
 #endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
 
+struct mshv_vtl_per_cpu {
+	struct mshv_vtl_run *run;
+	struct page *reg_page;
+};
+
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
+/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
+union hv_synic_overlay_page_msr {
+	u64 as_uint64;
+	struct {
+		u64 enabled: 1;
+		u64 reserved: 11;
+		u64 pfn: 52;
+	} __packed;
+};
+
 u8 __init get_vtl(void);
 void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
+bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
 #else
 static inline u8 get_vtl(void) { return 0; }
 static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
+static inline bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu) { return false; }
 #endif
 
 #endif
-- 
2.43.0


