Return-Path: <linux-hyperv+bounces-10327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHMrOfMU6mmVtgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10327-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA745241F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF5F830D6A42
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4913EDAA6;
	Thu, 23 Apr 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XxtnKmAZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE13EDAD3;
	Thu, 23 Apr 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948167; cv=none; b=HM9lCX/l407oehMWQ751gmvlyVR1OpJUqpLSKTa4TMu/5RogzaSQoEH8y1nJTCy5a++Adb+HSM6bD9d2mKnngcmxypNGJC28jjnXMGN4upcb8A+8GE6OaqrJ3sr03A5dFfDDyJtYIv+utr96lyMKyXT3OvD+tmzv627vxLGGUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948167; c=relaxed/simple;
	bh=O/KxpLA9As2ClJGwVyI5h46bbQ5m3KVt+eTtzgD7ddI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvH9O+cFvjeJC6BHebye7qP0F4MpLbpFJNmOnxXlPwI3QD5TIll6KR6ysKpDvlbOJQOh3U3l70aYrwX5Qpk+2VCcYBSA2b2C2Os1HgJf3lpks1h72fdOYb15wxtDVOFaAZCMyQqpf8F877OAFW0QR1Fep7+qf4IVZXf4XJrNl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XxtnKmAZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A37520B716E;
	Thu, 23 Apr 2026 05:42:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A37520B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948165;
	bh=RgOk9CuNiMb2ueZsexw1395h43OXuM/ZLDHAurB/vUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxtnKmAZkBsl1fo5vHmG1yFvwFiMsZTf0tpny7IxDVM9D9co5+6lVoSiRvy5ZEWXL
	 m/QTC0zSPOY++7G88l5sW5gq6ud3jQim6h/EFnC2Hp3qNkNFTjTwp2dqZtRDLlCAfk
	 FJuSJjmd4QdYK/ZdtpBJGsvpEESRR2oihG4xQh/I=
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
Subject: [PATCH v2 03/15] Drivers: hv: Move vmbus_handler to common code
Date: Thu, 23 Apr 2026 12:41:53 +0000
Message-ID: <20260423124206.2410879-4-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10327-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 34EA745241F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the vmbus_handler global variable and hv_setup_vmbus_handler()/
hv_remove_vmbus_handler() from arch/x86 to drivers/hv/hv_common.c.

hv_setup_vmbus_handler() is called unconditionally in vmbus_bus_init()
and works for both x86 (sysvec handler) and arm64 (vmbus_percpu_isr).

This eliminates the need for separate percpu vmbus handler setup
functions and __weak stubs, that are needed for adding ARM64 support
in MSHV_VTL driver where we need to set a custom per-cpu vmbus handler.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 12 ------------
 drivers/hv/hv_common.c         |  9 +++++++--
 drivers/hv/vmbus_drv.c         | 17 +++++++++--------
 include/asm-generic/mshyperv.h |  1 +
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 89a2eb8a0722..68706ff5880e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -145,7 +145,6 @@ void hv_set_msr(unsigned int reg, u64 value)
 EXPORT_SYMBOL_GPL(hv_set_msr);
 
 static void (*mshv_handler)(void);
-static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
@@ -172,17 +171,6 @@ void hv_setup_mshv_handler(void (*handler)(void))
 	mshv_handler = handler;
 }
 
-void hv_setup_vmbus_handler(void (*handler)(void))
-{
-	vmbus_handler = handler;
-}
-
-void hv_remove_vmbus_handler(void)
-{
-	/* We have no way to deallocate the interrupt gate */
-	vmbus_handler = NULL;
-}
-
 /*
  * Routines to do per-architecture handling of stimer0
  * interrupts when in Direct Mode
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e8633bc51d56..eb7b0028b45d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -758,13 +758,18 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
-void __weak hv_setup_vmbus_handler(void (*handler)(void))
+void (*vmbus_handler)(void);
+EXPORT_SYMBOL_GPL(vmbus_handler);
+
+void hv_setup_vmbus_handler(void (*handler)(void))
 {
+	vmbus_handler = handler;
 }
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
 
-void __weak hv_remove_vmbus_handler(void)
+void hv_remove_vmbus_handler(void)
 {
+	vmbus_handler = NULL;
 }
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..052ca8b11cee 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1415,7 +1415,8 @@ EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
-	vmbus_isr();
+	if (vmbus_handler)
+		vmbus_handler();
 	return IRQ_HANDLED;
 }
 
@@ -1517,8 +1518,10 @@ static int vmbus_bus_init(void)
 		vmbus_irq_initialized = true;
 	}
 
+	hv_setup_vmbus_handler(vmbus_isr);
+
 	if (vmbus_irq == -1) {
-		hv_setup_vmbus_handler(vmbus_isr);
+		/* x86: sysvec handler uses vmbus_handler directly */
 	} else {
 		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
 				"Hyper-V VMbus", &vmbus_evt);
@@ -1553,9 +1556,8 @@ static int vmbus_bus_init(void)
 	return 0;
 
 err_connect:
-	if (vmbus_irq == -1)
-		hv_remove_vmbus_handler();
-	else
+	hv_remove_vmbus_handler();
+	if (vmbus_irq != -1)
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
 err_setup:
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
@@ -3026,9 +3028,8 @@ static void __exit vmbus_exit(void)
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
-	if (vmbus_irq == -1)
-		hv_remove_vmbus_handler();
-	else
+	hv_remove_vmbus_handler();
+	if (vmbus_irq != -1)
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
 		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 2810aa05dc73..db183c8cfb95 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -179,6 +179,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
+extern void (*vmbus_handler)(void);
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
-- 
2.43.0


