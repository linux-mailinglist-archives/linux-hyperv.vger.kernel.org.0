Return-Path: <linux-hyperv+bounces-11207-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N+BOosnFmqUiQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11207-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:06:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F38065DD6D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06B553001866
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127DD3C4B86;
	Tue, 26 May 2026 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dB8upeZw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116F3B1EC7;
	Tue, 26 May 2026 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836807; cv=none; b=RYqa2sbr7xH/iYVyIbp5JahwSpCaJugu9ioZXI91SsY9e1RiSqs8CBs/Dg9MH+wSrkuX9iGYxmixFKzVL5BAZAFsq3rVaNoVdukWcDPak/FFIf0LmsfpGLhLiZE8xTGVBd1HLs9bq5NM2vt4VrARtlksSXwQd2gO1HG1LfxiDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836807; c=relaxed/simple;
	bh=0wsGsKtUtkB3eNIgwGTNmFhIzp+vxzNyD0oG4bChOes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGy0wNoS3bEJHBP+sEedMe6cE9lT/5RXIM4pIkxnOxl4TPYRjDHxvX7EwCclSSd5bqoQIrTw4r5yMeABbzB0Y7FgW96Av8jD2eoAmfhZp11Zwwmb+oUV3y6wQyOIMMQ/wPN2jqcKduoq08MunYRuKn7dmQdrrACY/6lMXeIbuqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dB8upeZw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fdyEa2zrsSgIB0Fcu7oQ5eLJ8ehXxnjFlWD1Yj9Xvl8=; b=dB8upeZwZGExYGXC5APc03fEAl
	fdTh1Wlh8U67MUPAtT6aDlAmDWOt6SVA+S36OXTRbwKFohQ+Oi1hSz7nHsdWWCkcXCC79wSFM54fU
	MsO1N6eFbieb8h6Sfr3TMn3jfdFhBSYt3bvmSTh6lQI+yCHs9yX2k6g6FXab5V+sD13LeyRT/cUcE
	3Fm4PzlICFQfyaZTV3oMk7ke452+/w8v5kULJnRmkBQKp5Kk2my3Cb2z8m9Qbp70zp2p0l/e6MjUm
	9wlnp0PK+GQURzNA9K15T1NiGkbSOdpa9qoUwJEyYpKsk9A4qAtRYWiq34Pe7X2ctF4q2g40SlkcC
	JyS8U4vg==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-00000001dUq-1rP4;
	Tue, 26 May 2026 23:06:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r5-00000000Zcc-2d61;
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
Subject: [RFC PATCH 2/8] clocksource/hyperv: Implement read_raw() for TSC page clocksource
Date: Wed, 27 May 2026 00:06:29 +0100
Message-ID: <20260526230635.136914-2-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-11207-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,kernel.org,outlook.com];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F38065DD6D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Implement the read_raw() callback for the Hyper-V TSC page
clocksource. This returns the derived 10MHz reference time (for
timekeeping) while also providing the raw TSC value that was used
to compute it.

When the TSC page is valid, hv_read_tsc_page_tsc() atomically
captures both values from a single RDTSC inside the sequence-counter
protected read. When the TSC page is invalid (sequence == 0), raw is
set to zero indicating no value is available.

This enables ktime_get_snapshot_id() to provide the raw TSC to
consumers like KVM's master clock when running nested on Hyper-V.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index e9f5034a1bc8..c5ae01fdbd8e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -444,6 +444,18 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
 	return read_hv_clock_tsc();
 }
 
+static u64 notrace read_hv_clock_tsc_cs_raw(struct clocksource *arg, u64 *raw)
+{
+	u64 time;
+
+	if (!hv_read_tsc_page_tsc(tsc_page, raw, &time)) {
+		time = read_hv_clock_msr();
+		*raw = 0;
+	}
+
+	return time;
+}
+
 static u64 noinstr read_hv_sched_clock_tsc(void)
 {
 	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
@@ -495,6 +507,8 @@ static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 500,
 	.read	= read_hv_clock_tsc_cs,
+	.read_raw = read_hv_clock_tsc_cs_raw,
+	.raw_csid = CSID_X86_TSC,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
-- 
2.54.0


