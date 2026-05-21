Return-Path: <linux-hyperv+bounces-11138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKBzBoVdD2oZJgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11138-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:31:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A665AB77E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDE763008C3E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D7388E63;
	Thu, 21 May 2026 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="ZzWO/21n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7592727F3;
	Thu, 21 May 2026 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391464; cv=pass; b=hhf0Llt03PsHLpJN8v+dZqyonWS0brtIuYU8vtYewjA+/rc4W0yI7ahWEosjX0IwKT6T0OAWf1gPWS8lOf13lZYEePVxmsixRarymj3RTj1Xnguy+u40OcG8Yjsm8q348b5KO+iHAROL5X1XA3xdpxkecJnCdVRpXHty0HryLb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391464; c=relaxed/simple;
	bh=QccdGtjCPTuQw17Liwk6hrrcpkp2bQ2AV1Om5vkh24g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tUk4/Li5zOlBfDQhvRdFQlNsjekdUmPyJT/SAfH9eZ8jy1ZmkHdsFTYTJabDX8Bg9lfg4mEIdS55JiYsbHFMuhkpPbSaOWtITQleJj41YFr8aBNuLosbkfRQGIn8597eyrX7tHnzecY4t35H/fxe9Nf9yCvLFfC2BwOoG6rBJvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=ZzWO/21n; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1779391429; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AhjQSV7kBemP8mgCSWlmbktV6T8gfYV7999viurCqO0RKZA0Is8wOcc7Yp8RnK/vF5ZgKp4zQkijePvXTnOI2Z9gYSowjhmLBHMNUxcsOEMxeXOzx1IX7dafYojvn3o1p5NstACtHbLt8mePlNy5xkuWqrPCnBOdMhy4KEktFlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779391429; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=DQPOht69acmZBj8X2gGPUutfXrAoyI/EZiFYXIeOvSE=; 
	b=X+mGjXEZhZRVGFFqJonw9sZ7hBzOtFisynWkDocrSqCUbYp0Uv6t5rTwvUzMs6MujGCztrFrHZWvzxs2t7fURugqs6t+/5FjBQs0Fwvu1drwZWUABixunNIeTw2o+wBLyfzHGU4ErT4E5aSu4npf28kAs4i69JIQEx4hIH0w4X4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779391429;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Cc;
	bh=DQPOht69acmZBj8X2gGPUutfXrAoyI/EZiFYXIeOvSE=;
	b=ZzWO/21ny40pBYGH8TYoWeCChgbKsD5vDQnynILfslt++w1wvLDrs14ni/GQV/3x
	Lmq3mt+ibewBUlXMTv/Dy4w0FrS8JnalHHvKFHTeolXWfKKq4U81Gfmf7juQ61DcngH
	/dIAe1KSoyBKy7Z7jivYaR3IyleGzuCiwCevtr+M=
Received: by mx.zohomail.com with SMTPS id 17793914281766.829777932622733;
	Thu, 21 May 2026 12:23:48 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Refactor hv_smp_prepare_cpus()
Date: Thu, 21 May 2026 12:23:36 -0700
Message-Id: <20260521192336.99623-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122720f4ce7d35a1b8f8a99006110000021ae84133116c29292b9524c743b8259d9f7e7ff09b0f6d8d:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External
X-Spamd-Result: default: False [6.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:dkim];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11138-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[zohomail.com:s=zm2022];
	DMARC_POLICY_ALLOW(0.00)[zohomail.com,reject];
	RCPT_COUNT_TWELVE(0.00)[14];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[zohomail.com:+];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,zohomail.com:mid,zohomail.com:dkim,outlook.com:replyto,outlook.com:email]
X-Rspamd-Queue-Id: A8A665AB77E
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Michael Kelley <mhklinux@outlook.com>

hv_smp_prepare_cpus() current handles two disjoint cases: a fully
enlightened SNP guest and running in the root partition. The root
partition case has recently added more steps, and as a result the
function is getting somewhat messy.

Refactor the code by putting the SNP and root cases into separate
functions. For the root case, move most of the code into hv_proc.c,
which is built only when MSHV_ROOT is configured. The move reduces
the surface area between the main code and the root partition
extensions. Several stubs go away, with an overall modest reduction
in lines of code.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 52 +++++++---------------------------
 drivers/hv/hv_proc.c           | 35 +++++++++++++++++++++--
 include/asm-generic/mshyperv.h | 17 ++---------
 3 files changed, 45 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 640e6b223c2d..442156056cd2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,7 +32,6 @@
 #include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
-#include <asm/numa.h>
 #include <asm/svm.h>
 
 /* Is Linux running on nested Microsoft Hypervisor */
@@ -413,46 +412,16 @@ static void __init hv_smp_prepare_boot_cpu(void)
 #endif
 }
 
-static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
+static void __init hv_smp_prepare_cpus_for_snp(unsigned int max_cpus)
 {
-#ifdef CONFIG_X86_64
-	int i;
-	int ret;
-#endif
-
 	native_smp_prepare_cpus(max_cpus);
+	apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
+}
 
-	/*
-	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
-	 *  enlightened guest.
-	 */
-	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
-		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
-		return;
-	}
-
-#ifdef CONFIG_X86_64
-	/* If AP LPs exist, we are in a kexec'd kernel and VPs already exist */
-	if (num_present_cpus() == 1 || hv_lp_exists(1))
-		return;
-
-	for_each_present_cpu(i) {
-		if (i == 0)
-			continue;
-		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
-		BUG_ON(ret);
-	}
-
-	ret = hv_call_notify_all_processors_started();
-	WARN_ON(ret);
-
-	for_each_present_cpu(i) {
-		if (i == 0)
-			continue;
-		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
-		BUG_ON(ret);
-	}
-#endif
+static void __init hv_smp_prepare_cpus_for_root(unsigned int max_cpus)
+{
+	native_smp_prepare_cpus(max_cpus);
+	hv_smp_prep_cpus();
 }
 #endif
 
@@ -722,9 +691,10 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition() ||
-	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
-		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
+		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus_for_snp;
+	else if (hv_root_partition())
+		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus_for_root;
 # endif
 
 	/*
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 57b2c64197cb..b8aa76a7b19b 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -8,6 +8,7 @@
 #include <linux/minmax.h>
 #include <linux/export.h>
 #include <asm/mshyperv.h>
+#include <asm/numa.h>
 
 /*
  * See struct hv_deposit_memory. The first u64 is partition ID, the rest
@@ -154,7 +155,7 @@ bool hv_result_needs_memory(u64 status)
 }
 EXPORT_SYMBOL_GPL(hv_result_needs_memory);
 
-int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
+static int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
 	struct hv_input_add_logical_processor *input;
 	struct hv_output_add_logical_processor *output;
@@ -240,7 +241,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 }
 EXPORT_SYMBOL_GPL(hv_call_create_vp);
 
-int hv_call_notify_all_processors_started(void)
+static int hv_call_notify_all_processors_started(void)
 {
 	struct hv_input_notify_partition_event *input;
 	u64 status;
@@ -262,7 +263,7 @@ int hv_call_notify_all_processors_started(void)
 	return ret;
 }
 
-bool hv_lp_exists(u32 lp_index)
+static bool hv_lp_exists(u32 lp_index)
 {
 	struct hv_input_get_logical_processor_run_time *input;
 	struct hv_output_get_logical_processor_run_time *output;
@@ -286,3 +287,31 @@ bool hv_lp_exists(u32 lp_index)
 
 	return hv_result_success(status);
 }
+
+void hv_smp_prep_cpus(void)
+{
+#ifdef CONFIG_X86_64
+	int i, ret;
+
+	/* If AP LPs exist, we are in a kexec'd kernel and VPs already exist */
+	if (num_present_cpus() == 1 || hv_lp_exists(1))
+		return;
+
+	for_each_present_cpu(i) {
+		if (i == 0)
+			continue;
+		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
+		BUG_ON(ret);
+	}
+
+	ret = hv_call_notify_all_processors_started();
+	WARN_ON(ret);
+
+	for_each_present_cpu(i) {
+		if (i == 0)
+			continue;
+		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
+		BUG_ON(ret);
+	}
+#endif
+}
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..ea1c4acda1ec 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -346,9 +346,7 @@ static inline bool hv_parent_partition(void)
 bool hv_result_needs_memory(u64 status);
 int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
-int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-int hv_call_notify_all_processors_started(void);
-bool hv_lp_exists(u32 lp_index);
+void hv_smp_prep_cpus(void);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 #else /* CONFIG_MSHV_ROOT */
@@ -364,18 +362,7 @@ static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_page
 {
 	return -EOPNOTSUPP;
 }
-static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id)
-{
-	return -EOPNOTSUPP;
-}
-static inline int hv_call_notify_all_processors_started(void)
-{
-	return -EOPNOTSUPP;
-}
-static inline bool hv_lp_exists(u32 lp_index)
-{
-	return false;
-}
+static inline void hv_smp_prep_cpus(void) {}
 static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 {
 	return -EOPNOTSUPP;
-- 
2.25.1


