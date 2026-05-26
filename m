Return-Path: <linux-hyperv+bounces-11210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNoWAcEnFmqUiQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11210-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:07:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F75DD6EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E10300EE8D
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC43C4B86;
	Tue, 26 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iq5VUftx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B73BB661;
	Tue, 26 May 2026 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836862; cv=none; b=O+55AaI0SesHbR7bAtThPaOSbS5/BkxNPxhvSyGsrRShXkkzkfLIzaYaGO0MPqgbzMo1BjViZR4w7bh4FQPPnvHzJWAzypl/xkCbWDWanLD6xft6H1gk9cus8U6LpVQ9tgsqE9BxpcZcLAGACMWgaZuqN3ado0YfYSucNQfEtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836862; c=relaxed/simple;
	bh=7cJQ28fGJGc/dCdlBMm+ipwaMDSGO5paq6ceWUT0A6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG7CuLjBGF+nvAJuoYAOjaM/GUfX9/OGItQBOEyc+5yznD5ZBa7PiNFhy0PkwvXIBHRMpJKw4jKQdvN2IEMITEo0OqCC+AO2OhMi4Av/i78XNDC/YE7L0aRWE2VjJUABCfo3gmhxwWw20EBrLfpTQSOib4d4/o54U3wy25Nh1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iq5VUftx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GS9b7mZcSK58fwDj2kirYN2NQhTYqCmSJW6nYTyS+0M=; b=Iq5VUftxoMyv9C5InviwIZRWGT
	UcZCXjvYU5SRD9cUglmbwHdrugTR2IhGuqMSQCoG9G3PWT+1ToiFxlM5iZ1ccYeeYVncbwLYVKIJA
	cKimTOBLo3/tDiva0Q12AYcBuxtPzD73/tUSJYLr7YvR5shXPpWtETFhGupjJNFDOrpEuZAn1XMHJ
	p2dIJyxfp+j/niwax7ucCH9gTp2qMWs8gpFHu0WVTGH1aae0ecwRmYUF3SXIzgRwZZuKzT1jAtiT3
	lZfd14rGbu3+4hGpd4YEo5rlAHSFMdDDNW6t/P7iSxqMIrmMqKFZzu2CMzxPZq8zbHcxcBn7EWgcK
	8vImootA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-0000000CV9H-0cIu;
	Tue, 26 May 2026 23:06:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r5-00000000Zcf-2xmj;
	Wed, 27 May 2026 00:06:35 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] x86/kvmclock: Implement read_raw() for kvmclock clocksource
Date: Wed, 27 May 2026 00:06:30 +0100
Message-ID: <20260526230635.136914-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526230635.136914-1-dwmw2@infradead.org>
References: <to=b6d2173312b8d0469774846eb18b9799832d9cfc.camel@infradead.org>
 <20260526230635.136914-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-11210-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,kernel.org,outlook.com];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,amazon.co.uk:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C8F75DD6EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Implement the read_raw() callback for the kvmclock clocksource.
This returns the kvmclock nanosecond value (for timekeeping) while
also providing the raw TSC value that was used to compute it.

The TSC is read inside the pvclock seqlock-protected region,
ensuring the raw TSC and derived kvmclock value are atomically
paired.

This enables ktime_get_snapshot_id() to provide the raw TSC to consumers
like the vmclock PTP driver, which currently has to do a separate call
to get_cycles() to obtain the value to feed through the vmclock
calculation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 arch/x86/kernel/kvmclock.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 74aca22dc726..ef86635433f9 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -87,6 +87,25 @@ static u64 kvm_clock_get_cycles(struct clocksource *cs)
 	return kvm_clock_read();
 }
 
+static u64 kvm_clock_get_cycles_raw(struct clocksource *cs, u64 *raw)
+{
+	struct pvclock_vcpu_time_info *src;
+	unsigned version;
+	u64 ret, tsc;
+
+	preempt_disable_notrace();
+	src = this_cpu_pvti();
+	do {
+		version = pvclock_read_begin(src);
+		tsc = rdtsc_ordered();
+		ret = __pvclock_read_cycles(src, tsc);
+	} while (pvclock_read_retry(src, version));
+	preempt_enable_notrace();
+
+	*raw = tsc;
+	return ret;
+}
+
 static noinstr u64 kvm_sched_clock_read(void)
 {
 	return pvclock_clocksource_read_nowd(this_cpu_pvti()) - kvm_sched_clock_offset;
@@ -163,6 +182,8 @@ static int kvm_cs_enable(struct clocksource *cs)
 static struct clocksource kvm_clock = {
 	.name	= "kvm-clock",
 	.read	= kvm_clock_get_cycles,
+	.read_raw = kvm_clock_get_cycles_raw,
+	.raw_csid = CSID_X86_TSC,
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
2.54.0


