Return-Path: <linux-hyperv+bounces-9427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ArSNkj1t2mfXQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9427-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:19:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E171299606
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7531830A906E
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02E395240;
	Mon, 16 Mar 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZMDm6OU2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D93932C3;
	Mon, 16 Mar 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663196; cv=none; b=KTPNq5+xOBH8oPQYZViC5snwRlORxg22gIp24uGR0ntnXeI3vjoYiiqNHugkbxneIISkdKmsUT7lmjwLSertRqHXRuOlfdHpzgs9JKFyasgHf1AlGv3mhC7pkjCf8ZaU6n1XGGDdUJ2cX779VG695BVfjfbWMD2WoE5Ttuo3z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663196; c=relaxed/simple;
	bh=L91r2+Tx0gccjtuHEQvwDyQe6sozm47TBr6jTa/UuoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGZpv9zDzhUJJQBXpgLpC6yCspqKD+B80Ie4+zz7MdDWaMETozD3sNVrbAWDXD+ASW8Kanl+fwaPI0N9QdHQyxOMKX+SxMa3PNiU2qeZN+exdKAUCaupINH43jQSpA7/JOhEW+4RjH8aw3JN3ZVd4k8EpsTUXomBOP8ULdV3sA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZMDm6OU2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id ECDB820B712B;
	Mon, 16 Mar 2026 05:13:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECDB820B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773663194;
	bh=E3StM9+iDpcoit1RWPxAyV+2hPmFkaB3kEah6gv3o8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMDm6OU2yqAfZL7t2pqxQXx0b+7Tzsl4B3jaASsVyXx4EtKOat/05+uslxY9NnP2z
	 2qsH8BP+y+pNNzM6HR60ValkMckk/IJ3+xUNijOYFVQ2x1XUoFaNp//Gzxc3sCXm1o
	 mbW5a0iAOYbxtYDeW/Is9Z2foXY/L41i7tMDtNB4=
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
Subject: [PATCH 03/11] Drivers: hv: Add support to setup percpu vmbus handler
Date: Mon, 16 Mar 2026 12:12:33 +0000
Message-ID: <20260316121241.910764-4-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9427-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E171299606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a wrapper function - hv_setup_percpu_vmbus_handler(), similar to
hv_setup_vmbus_handler() to allow setting up custom per-cpu VMBus
interrupt handler. This is required for arm64 support, to be added
in MSHV_VTL driver, where per-cpu VMBus interrupt handler will be
set to mshv_vtl_vmbus_isr() for VTL2 (Virtual Trust Level 2).

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   | 13 +++++++++++++
 drivers/hv/hv_common.c         | 11 +++++++++++
 drivers/hv/vmbus_drv.c         |  7 +------
 include/asm-generic/mshyperv.h |  3 +++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26ade1d7..d4494ceeaad0 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -134,3 +134,16 @@ bool hv_is_hyperv_initialized(void)
 	return hyperv_initialized;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+static void (*vmbus_percpu_handler)(void);
+void hv_setup_percpu_vmbus_handler(void (*handler)(void))
+{
+	vmbus_percpu_handler = handler;
+}
+
+irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
+{
+	if (vmbus_percpu_handler)
+		vmbus_percpu_handler();
+	return IRQ_HANDLED;
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index d1ebc0ebd08f..a5064f558bf6 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -759,6 +759,17 @@ void __weak hv_setup_vmbus_handler(void (*handler)(void))
 }
 EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
 
+irqreturn_t __weak vmbus_percpu_isr(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(vmbus_percpu_isr);
+
+void __weak hv_setup_percpu_vmbus_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_percpu_vmbus_handler);
+
 void __weak hv_remove_vmbus_handler(void)
 {
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..f99d4f2d3862 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1413,12 +1413,6 @@ void vmbus_isr(void)
 }
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
 
-static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
-{
-	vmbus_isr();
-	return IRQ_HANDLED;
-}
-
 static void vmbus_percpu_work(struct work_struct *work)
 {
 	unsigned int cpu = smp_processor_id();
@@ -1520,6 +1514,7 @@ static int vmbus_bus_init(void)
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
+		hv_setup_percpu_vmbus_handler(vmbus_isr);
 		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
 				"Hyper-V VMbus", &vmbus_evt);
 		if (ret) {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 108f135d4fd9..b147a12085e4 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
+#include <linux/interrupt.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
 #include <hyperv/hvhdk.h>
@@ -179,6 +180,8 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
+irqreturn_t vmbus_percpu_isr(int irq, void *dev_id);
+void hv_setup_percpu_vmbus_handler(void (*handler)(void));
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
-- 
2.43.0


