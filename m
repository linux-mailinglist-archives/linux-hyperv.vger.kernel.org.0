Return-Path: <linux-hyperv+bounces-11701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /MRWCJwXQmpA0AkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11701-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:58:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C18186D6A65
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D8VLy0BC;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D8VLy0BC;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11701-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11701-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF8473026AFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7072F7462;
	Mon, 29 Jun 2026 06:56:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A43BB114
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716176; cv=none; b=sZOoFF13XTw1FKNb3Q4f7rCPb6P841C1gWl3sHb/tztpJrB8HA5c4/MJObcLd1NhBbgkYkMpfBIv7OPTEl9ijDOJPFFurdG0PA/3K8o+lyr/CjjLljAyynuRuXmVYD17uk6veU/6gQTDUPFtJAHFK1LtElkMErHfvp5CUVrL60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716176; c=relaxed/simple;
	bh=5Ob9woesx3MvkjnAz3VVCDjyk4tqT/gh17KPj8eyYB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMK5+mssNqYGq9CDRpe9ZKs8bMsiIO3oXab2f+Y5q07t4Fo8ofkD1EqdCvsQa06R9AZ8lE15zhcoUrobFLnM7mwvkfxf+dGEMx8NmPRwfFVJVSiK4pKU4tlSSg0wYZX8pZ+bTgUoJJ/x70QHk1rdb1l0zSEaAeWrKhafLAHShWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D8VLy0BC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D8VLy0BC; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2818175ADB;
	Mon, 29 Jun 2026 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhxGli54ZuPwNog8SqVwj10Mq8fqizoQk1Ksc0Y1Y4Q=;
	b=D8VLy0BCqZswZdxtZfnXkzgGVDttu6mrj27i3aTkpI6vGSBXc9KKaEhDVocYL8+x9w2US+
	K5Wh6H8IOkP3jjIwPxNQLiiJI9DArgu+cpJP05F9n4MkoI1xbo8PP/uDd1wglTVzn7VLt8
	DuJCkgOsc0rVQREjomibhAjvxyHSges=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhxGli54ZuPwNog8SqVwj10Mq8fqizoQk1Ksc0Y1Y4Q=;
	b=D8VLy0BCqZswZdxtZfnXkzgGVDttu6mrj27i3aTkpI6vGSBXc9KKaEhDVocYL8+x9w2US+
	K5Wh6H8IOkP3jjIwPxNQLiiJI9DArgu+cpJP05F9n4MkoI1xbo8PP/uDd1wglTVzn7VLt8
	DuJCkgOsc0rVQREjomibhAjvxyHSges=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C93D779A8;
	Mon, 29 Jun 2026 06:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OSDEIAkXQmqqQQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:56:09 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 04/18] x86/msr: Minimize usage of native_*() msr access functions
Date: Mon, 29 Jun 2026 08:55:30 +0200
Message-ID: <20260629065544.3643253-5-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629065544.3643253-1-jgross@suse.com>
References: <20260629065544.3643253-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11701-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-hyperv@vger.kernel.org,m:kvm@vger.kernel.org,m:jgross@suse.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:pbonzini@redhat.com,m:vkuznets@redhat.com,m:seanjc@google.com,m:boris.ostrovsky@oracle.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,zytor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C18186D6A65

In order to prepare for some MSR access function reorg work, switch
most users of native_{read|write}_msr[_safe]() to the more generic
rdmsr*()/wrmsr*() variants.

For now this will have some intermediate performance impact with
paravirtualization configured when running on bare metal, but this
is a prereq change for the planned direct inlining of the rdmsr/wrmsr
instructions with this configuration.

The main reason for this switch is the planned move of the MSR trace
function invocation from the native_*() functions to the generic
rdmsr*()/wrmsr*() variants. Without this switch the users of the
native_*() functions would lose the related tracing entries.

Note that the Xen related MSR access functions will not be switched,
as these will be handled after the move of the trace hooks.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/hyperv/ivm.c          |  2 +-
 arch/x86/kernel/cpu/mshyperv.c |  4 ++--
 arch/x86/kernel/kvmclock.c     |  2 +-
 arch/x86/kvm/svm/svm.c         | 16 ++++++++--------
 arch/x86/xen/pmu.c             |  4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..a74f121f2a02 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -328,7 +328,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	savesegment(ds, vmsa->ds.selector);
 	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
 
-	vmsa->efer = native_read_msr(MSR_EFER);
+	vmsa->efer = rdmsrq(MSR_EFER);
 
 	vmsa->cr4 = native_read_cr4();
 	vmsa->cr3 = __native_read_cr3();
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 65ad235ef5c6..69c7cbae7a8e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -114,7 +114,7 @@ u64 hv_para_get_synic_register(unsigned int reg)
 {
 	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
 		return ~0ULL;
-	return native_read_msr(reg);
+	return rdmsrq(reg);
 }
 
 /*
@@ -124,7 +124,7 @@ void hv_para_set_synic_register(unsigned int reg, u64 val)
 {
 	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
 		return;
-	native_write_msr(reg, val);
+	wrmsrq(reg, val);
 }
 
 u64 hv_get_msr(unsigned int reg)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index cb3d0ca1fa22..6ddef8b5426a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -219,7 +219,7 @@ static void kvm_setup_secondary_clock(void)
 void kvmclock_disable(void)
 {
 	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0);
+		wrmsrq(msr_kvm_system_time, 0);
 }
 
 static void __init kvmclock_init_mem(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 977112d8713c..604f3ca3c1e3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -413,12 +413,12 @@ static void svm_init_erratum_383(void)
 		return;
 
 	/* Use _safe variants to not break nested virtualization */
-	if (native_read_msr_safe(MSR_AMD64_DC_CFG, &val))
+	if (rdmsrq_safe(MSR_AMD64_DC_CFG, &val))
 		return;
 
 	val |= (1ULL << 47);
 
-	native_write_msr_safe(MSR_AMD64_DC_CFG, val);
+	wrmsrq_safe(MSR_AMD64_DC_CFG, val);
 
 	erratum_383_found = true;
 }
@@ -471,8 +471,8 @@ static void svm_init_os_visible_workarounds(void)
 		return;
 
 	if (!this_cpu_has(X86_FEATURE_OSVW) ||
-	    native_read_msr_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
-	    native_read_msr_safe(MSR_AMD64_OSVW_STATUS, &status))
+	    rdmsrq_safe(MSR_AMD64_OSVW_ID_LENGTH, &len) ||
+	    rdmsrq_safe(MSR_AMD64_OSVW_STATUS, &status))
 		len = status = 0;
 
 	if (status == READ_ONCE(osvw_status) && len >= READ_ONCE(osvw_len))
@@ -2096,7 +2096,7 @@ static bool is_erratum_383(void)
 	if (!erratum_383_found)
 		return false;
 
-	if (native_read_msr_safe(MSR_IA32_MC0_STATUS, &value))
+	if (rdmsrq_safe(MSR_IA32_MC0_STATUS, &value))
 		return false;
 
 	/* Bit 62 may or may not be set for this mce */
@@ -2107,11 +2107,11 @@ static bool is_erratum_383(void)
 
 	/* Clear MCi_STATUS registers */
 	for (i = 0; i < 6; ++i)
-		native_write_msr_safe(MSR_IA32_MCx_STATUS(i), 0);
+		wrmsrq_safe(MSR_IA32_MCx_STATUS(i), 0);
 
-	if (!native_read_msr_safe(MSR_IA32_MCG_STATUS, &value)) {
+	if (!rdmsrq_safe(MSR_IA32_MCG_STATUS, &value)) {
 		value &= ~(1ULL << 2);
-		native_write_msr_safe(MSR_IA32_MCG_STATUS, value);
+		wrmsrq_safe(MSR_IA32_MCG_STATUS, value);
 	}
 
 	/* Flush tlb to evict multi-match entries */
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 5f50a3ee08f5..37512df8b8f2 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -324,7 +324,7 @@ static u64 xen_amd_read_pmc(int counter)
 		u64 val;
 
 		msr = amd_counters_base + (counter * amd_msr_step);
-		native_read_msr_safe(msr, &val);
+		rdmsrq_safe(msr, &val);
 		return val;
 	}
 
@@ -350,7 +350,7 @@ static u64 xen_intel_read_pmc(int counter)
 		else
 			msr = MSR_IA32_PERFCTR0 + counter;
 
-		native_read_msr_safe(msr, &val);
+		rdmsrq_safe(msr, &val);
 		return val;
 	}
 
-- 
2.54.0


