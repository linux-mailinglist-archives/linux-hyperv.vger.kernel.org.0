Return-Path: <linux-hyperv+bounces-11212-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMAsNJUoFmqUiQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11212-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:11:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCBE5DD745
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9128C30942C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D703CE4A7;
	Tue, 26 May 2026 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MB3xJ188"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023383CE0A4;
	Tue, 26 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836865; cv=none; b=fRevjlIi0h7yqEbWdoKk010kM70ppc/kaZg6+VUuaTwDquGiRxvdnM92TDKyUbKEE1Kb7RQtraGuQkJsSW6mZjgvyB5ConHiVtC9b1KtR/pGMTnNLOzZ11c9tICBBPEYEQhEOUN5ryNfKq9q2p7UUbzedkLXQtYlF4Z/UBAicfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836865; c=relaxed/simple;
	bh=g/+11vI5whb/zPcFbqqSAwr7qMkKVJSd0nYkxQkfT8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlP2RI/5jT52lk00nw4qTVVEjNfbUNxRt+9FMN7/vmjxTLxqGaPEZbb1PBwVpneO64nZVOmtnANJWBU36WqHy7TkyKFZA4bkfN5nKuv944OrPyCL2+R2nThRkWMuRVtNqS5m3b4vYqUA7P0yzQZ2PLC2X0v2zUneGiETGoD9hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MB3xJ188; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kjELQUn/TdspDb/kupTCJRsohsXwqZDF5f0hKtXNw7I=; b=MB3xJ188nfA7RycwXxFmlHmU6V
	N7RRPxHaJ3UeTXC7w6ryE5okx9cwwWs297ndIqDF7PU2AuIZj70yyyiax4D1wQ5dwRDwAcHull7pE
	iVWSzsB9wPUHtyz5O+VzqPVNugXGDE2mtBYhpYX+AoFzRpghaenS/VqPy2iJmJsFuSfyS/zIjRlsG
	LyT73AXlcnj6JLvQ2fmEsK6TGuJIbGmPWtRAp4Y0Y3ovei0cwaUW+Xj8rksdgPfwiksP2cGqGv4lk
	Fqr+qXeO1UVqBat6vNXjr3hWUUk2GZj+gBwpVBdRnIWMzIzO7jqgTbflTVsRpTt3gCsf7Pl08LLQQ
	FmX2C83g==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-0000000CV9G-0cOj;
	Tue, 26 May 2026 23:06:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r5-00000000ZcZ-2IIp;
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
Subject: [RFC PATCH 1/8] timekeeping: Add clocksource read_raw() method and raw_cycles to snapshot
Date: Wed, 27 May 2026 00:06:28 +0100
Message-ID: <20260526230635.136914-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <to=b6d2173312b8d0469774846eb18b9799832d9cfc.camel@infradead.org>
References: <to=b6d2173312b8d0469774846eb18b9799832d9cfc.camel@infradead.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11212-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,kernel.org,outlook.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7DCBE5DD745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Add a read_raw() callback to struct clocksource which returns the
derived clocksource value while also providing the underlying hardware
counter reading. This allows ktime_get_snapshot_id() to populate a new
raw_cycles field in struct system_time_snapshot.

For clocksources that are derived from an underlying counter (e.g.,
Hyper-V TSC page scales TSC to 10MHz, kvmclock scales TSC to 1GHz), this
provides atomic access to both the derived value needed for timekeeping
calculations, and the raw hardware counter needed by consumers like
KVM's master clock and the vmclock PTP driver.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 include/linux/clocksource.h |  8 ++++++++
 include/linux/timekeeping.h |  6 ++++++
 kernel/time/timekeeping.c   | 30 +++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7c38190b10bf..674299e32f0c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -37,6 +37,10 @@ struct module;
  *	This is the structure used for system time.
  *
  * @read:		Returns a cycle value, passes clocksource as argument
+ * @read_raw:		Where a clocksource such as kvmclock or the Hyper-V
+ *			scaled TSC is calculated from an underlying hardware
+ *			counter, return both a cycle value and the raw value
+ *			of the underlying counter from which it was calculated
  * @mask:		Bitmask for two's complement
  *			subtraction of non 64 bit counters
  * @mult:		Cycle to nanosecond multiplier
@@ -69,6 +73,8 @@ struct module;
  *			in certain snapshot functions to allow callers to
  *			validate the clocksource from which the snapshot was
  *			taken.
+ * @raw_csid:		If a @read_raw method exists, the clocksource_id of the
+ *			raw underlying counter
  * @flags:		Flags describing special properties
  * @base:		Hardware abstraction for clock on which a clocksource
  *			is based
@@ -97,6 +103,7 @@ struct module;
  */
 struct clocksource {
 	u64			(*read)(struct clocksource *cs);
+	u64			(*read_raw)(struct clocksource *cs, u64 *raw);
 	u64			mask;
 	u32			mult;
 	u32			shift;
@@ -109,6 +116,7 @@ struct clocksource {
 	u32			freq_khz;
 	int			rating;
 	enum clocksource_ids	id;
+	enum clocksource_ids	raw_csid;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
 	struct clocksource_base *base;
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index f7945f1048fc..54799a9ebeb0 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -279,18 +279,24 @@ static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { ret
  * struct system_time_snapshot - Simultaneous time capture of CLOCK_MONOTONIC_RAW,
  *				 a selected CLOCK_* and the clocksource counter value
  * @cycles:		Clocksource counter value to produce the system times
+ * @raw_cycles:		For derived clocksources, the raw hardware counter value from
+ *			which @cycles was derived
  * @sys:		The system time of the selected CLOCK ID
  * @raw:		Monotonic raw system time
  * @cs_id:		Clocksource ID
+ * @raw_csid:		Clocksource ID of underlying raw hardware counter, set if
+ *			@raw_cycles is non-zero
  * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @valid:		True if the snapshot is valid
  */
 struct system_time_snapshot {
 	u64			cycles;
+	u64			raw_cycles;
 	ktime_t			sys;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
+	enum clocksource_ids	raw_csid;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
 	u8			valid;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c4fd7229b7da..6c75a677fd2a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -304,6 +304,21 @@ static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
 	return clock->read(clock);
 }
 
+static __always_inline u64 tk_clock_read_raw(const struct tk_read_base *tkr, u64 *raw)
+{
+	struct clocksource *clock = READ_ONCE(tkr->clock);
+
+	*raw = 0;
+
+	if (static_branch_likely(&clocksource_read_inlined))
+		return arch_inlined_clocksource_read(clock);
+
+	if (clock->read_raw)
+		return clock->read_raw(clock, raw);
+	else
+		return clock->read(clock);
+}
+
 static inline void clocksource_disable_inline_read(void)
 {
 	static_branch_disable(&clocksource_read_inlined);
@@ -320,6 +335,18 @@ static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
 
 	return clock->read(clock);
 }
+
+static __always_inline u64 tk_clock_read_raw(const struct tk_read_base *tkr, u64 *raw)
+{
+	struct clocksource *clock = READ_ONCE(tkr->clock);
+
+	*raw = 0;
+
+	if (clock->read_raw)
+		return clock->read_raw(clock, raw);
+	else
+		return clock->read(clock);
+}
 static inline void clocksource_disable_inline_read(void) { }
 static inline void clocksource_enable_inline_read(void) { }
 #endif
@@ -1243,8 +1270,9 @@ bool ktime_get_snapshot_id(struct system_time_snapshot *systime_snapshot, clocki
 		if (!tk->clock_valid)
 			return false;
 
-		now = tk_clock_read(&tk->tkr_mono);
+		now = tk_clock_read_raw(&tk->tkr_mono, &systime_snapshot->raw_cycles);
 		systime_snapshot->cs_id = tk->tkr_mono.clock->id;
+		systime_snapshot->raw_csid = tk->tkr_mono.clock->raw_csid;
 		systime_snapshot->cs_was_changed_seq = tk->cs_was_changed_seq;
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
 
-- 
2.54.0


