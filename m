Return-Path: <linux-hyperv+bounces-11214-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPf8IxopFmqUiQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11214-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:13:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2A5DD782
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506E430BCD02
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93663AD524;
	Tue, 26 May 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+qaG6jH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A83CCFA6;
	Tue, 26 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836872; cv=none; b=M5nC0teu219RxGEUzgdPkcPzhyebZXqjayADOqC5vI4Gp5kgid5YL8JRueQGVgJop0TUNW6X3F2KtycjeeSThCDWEO8gUkb/u7rq0F+MhZMlQAdPiVsYZ3lQccX7s1Ym4LVuuuLbAbxJ1alxlhuJb5UKewm2+2nfgOylqXuzsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836872; c=relaxed/simple;
	bh=eCTu5YcbUbETkSz3dp/VHofDn1X74WyGgSjGQq6Ar4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBapxrULqwSpcrCxJNe/bJPUkYOOcZjZHREzKGmA46HWgountEbpArXQLDfXuPBhpWoPQ+lDAwLqucOxCjTvDAWK0u0VjWyZpTAxEzj3PJ1Vo/3QrCxKkCmYt88vtZPRDsqujM73rWgLehbaTqdHSphTlsZTJyW16g+A8ZhkBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d+qaG6jH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1v/58WjcgAQaixeVqP20tmhjKGpwtAf1/dVp6v1u3SE=; b=d+qaG6jH6PoMAzXphjmbflGM9y
	VznbDiRsV8u2/ThPcOWzHWIEvCNWIlw+WRk2wpysGRBRP5K7oJu2s2mde02C5RuNaWLAdPyZ/QZWo
	KeW6XDaVSz6OHzd8oQvaP3v60DhGnxm4grOw48wIqNyODPN+e0rPrEJG0TbTJ33Q6SjJvoO4wfNcH
	jLXEg5qrXKNertir2qnR54CMzkRK8w1CPT1c94/zPKsYxKr9/cMDdP5wGuBrAYg55JhrcdLuXJfQA
	KayRaoO/+PRc3RdXdgN9TX2kRcQvhAIKXLXtqYYp8TQs3AfWcssP0z8RG6sbv0QxZ9vuRL30ZGe+x
	JM7FBFKw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-0000000CV9E-0cxJ;
	Tue, 26 May 2026 23:06:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r5-00000000Zci-3JJf;
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
Subject: [RFC PATCH 4/8] KVM: x86: Use ktime_get_snapshot_id() for master clock
Date: Wed, 27 May 2026 00:06:31 +0100
Message-ID: <20260526230635.136914-4-dwmw2@infradead.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-11214-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,kernel.org,outlook.com];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim,amazon.co.uk:email]
X-Rspamd-Queue-Id: E9E2A5DD782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Replace the KVM-private vgettsc()/do_kvmclock_base()/do_monotonic()/
do_realtime() timekeeping reimplementation with calls to the generic
ktime_get_snapshot_id() interface.

The snapshot provides both the system time and the raw_cycles (TSC)
atomically paired. When raw_cycles is zero, the clocksource could not
provide a raw hardware counter value, which is equivalent to the
previous vgettsc() returning VDSO_CLOCKMODE_NONE.

For kvm_get_time_and_clockread(), the kvmclock base time is
CLOCK_MONOTONIC_RAW + offs_boot. The snapshot provides the raw time
atomically paired with the TSC; offs_boot is added separately as it
only changes at suspend/resume boundaries.

This is a step towards eliminating the pvclock_gtod_data private copy
of timekeeping state and the associated notifier callback.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 arch/x86/kvm/x86.c | 50 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9e17e01f82d..e6f740f95ff9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -35,6 +35,7 @@
 #include "smm.h"
 
 #include <linux/clocksource.h>
+#include <linux/timekeeping.h>
 #include <linux/interrupt.h>
 #include <linux/kvm.h>
 #include <linux/fs.h>
@@ -3137,14 +3138,34 @@ static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
  * reports the TSC value from which it do so. Returns true if host is
  * using TSC based clocksource.
  */
+static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
+				u64 *tsc_timestamp)
+{
+	if (snap->cs_id == CSID_X86_TSC) {
+		*tsc_timestamp = snap->cycles;
+		return true;
+	}
+
+	if (snap->raw_csid == CSID_X86_TSC && snap->raw_cycles) {
+		*tsc_timestamp = snap->raw_cycles;
+		return true;
+	}
+
+	return false;
+}
+
 static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap;
+
+	if (!ktime_get_snapshot_id(&snap, CLOCK_MONOTONIC_RAW))
+		return false;
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
-						     tsc_timestamp));
+	*kernel_ns = ktime_to_ns(snap.sys) +
+		     ktime_to_ns(ktime_mono_to_any(0, TK_OFFS_BOOT));
+	return true;
 }
 
 /*
@@ -3153,12 +3174,15 @@ static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
  */
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap;
+
+	if (!ktime_get_snapshot_id(&snap, CLOCK_MONOTONIC))
+		return false;
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_monotonic(kernel_ns,
-						 tsc_timestamp));
+	*kernel_ns = ktime_to_ns(snap.sys);
+	return true;
 }
 
 /*
@@ -3171,11 +3195,15 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
 static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
 					   u64 *tsc_timestamp)
 {
-	/* checked again under seqlock below */
-	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
+	struct system_time_snapshot snap;
+
+	if (!ktime_get_snapshot_id(&snap, CLOCK_REALTIME))
+		return false;
+	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
 		return false;
 
-	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
+	*ts = ktime_to_timespec64(snap.sys);
+	return true;
 }
 #endif
 
-- 
2.54.0


