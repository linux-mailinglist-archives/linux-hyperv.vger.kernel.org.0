Return-Path: <linux-hyperv+bounces-11484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aMKMNgpQIWpmDAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11484-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 12:14:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E863EE77
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 12:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=X1DXTNJK;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11484-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11484-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 922963106497
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A33F1664;
	Thu,  4 Jun 2026 09:58:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEF2D1907;
	Thu,  4 Jun 2026 09:58:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567097; cv=none; b=HDOk1Nl7zu5R4Kq3GQFgdYBX4Cm4+o7JctY2YmToBldb9DWueRNRvlPFXwFs+HnYABN+n+FukhNQSz6KXntFjIpTADD5tWkXIu2BAPlB/yq6P/cccUOVtd2U9fEZJs7cLID9yffUT9atDAXQmEiiOW6v471nPBJkIQR4fV4V9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567097; c=relaxed/simple;
	bh=J3L9DEWX4rkamfUBp48RjipQB97rKBJ18gA5N9C86Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4osQhlakyecPz6mtbNoWHYj3wMx1To6nc6y1B+MF0d86SNk07DarUVUAswoRFxc3lzNc+gg1im07bQvgS2kDIIDDSKPxsnKK8SnuIQxo2pUw5cHHNlflYKqOghA2epKN9xXRWCmWHeVsrgNIWIVG3p+Tgxcpfu95F7EKSir/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X1DXTNJK; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Et8eOtHzrcYDSA2taulDH16mYcf076lGo5l3V2QRT+c=; b=X1DXTNJKHtjwUazcqTcLiLTHv6
	nCV+awGALkFsFFKW9DdIxHEUzw/V/X8Kiag88WG52tZCrxF+FKriW51cm8MYulWjTQPF1uI3eTMPd
	0xpRdI3lJbefxhEf7nyb9u6Hn5cN4hGT+hWXWSxapaCqUFrDwApeur6UTs/xmCGCobCY99GGFH8Mq
	nIGsEyALEsqEiBE+otwPtVdzZJbgFUxUHJ2QTOLoW9o6rjJIvUVaYLMcs4gicFZYTL/s1jMPiI+oN
	DxxGNQbAREHG3TdTYX3ZIx8t427jn96VnksURqNNEwMUFTrpRSI8kY9VCSa4ereCO1YFoCE07t0f2
	wh4M8zwA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV4pq-00000005aXV-3krp;
	Thu, 04 Jun 2026 09:57:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4pq-00000000H0u-3EHb;
	Thu, 04 Jun 2026 10:57:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/3] ptp: vmclock: Use hw_cycles from snapshot for precise TSC pairing
Date: Thu,  4 Jun 2026 10:35:18 +0100
Message-ID: <20260604095755.64849-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604095755.64849-1-dwmw2@infradead.org>
References: <20260604095755.64849-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[redhat.com,outlook.com,alien8.de,linux.intel.com,kernel.org,zytor.com,microsoft.com,infradead.org,gmail.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11484-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:pbonzini@redhat.com,m:vkuznets@redhat.com,m:mhklinux@outlook.com,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:daniel.lezcano@kernel.org,m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F9E863EE77

From: David Woodhouse <dwmw@amazon.co.uk>

When the system clocksource is kvmclock or Hyper-V (not the TSC
directly), vmclock_get_crosststamp() previously fell through to a
separate get_cycles() call, losing the atomic pairing between the
system time snapshot and the TSC reading.

Now that ktime_get_snapshot_id() populates hw_cycles with the
underlying TSC value for derived clocksources, use it when available.
This gives a perfect (system_time, tsc) pairing for the device time
calculation.

The SUPPORT_KVMCLOCK wrapper is still needed to convert the TSC into
kvmclock nanoseconds for system_counter->cycles, because otherwise
get_device_system_crosststamp() can't interpret the result against
the system clock.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 drivers/ptp/ptp_vmclock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index d6a5a533164a..eebdcd5ebc08 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -140,6 +140,10 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 			if (sts->pre_sts.cs_id == st->cs_id) {
 				cycle = sts->pre_sts.cycles;
 				sts->post_sts = sts->pre_sts;
+			} else if (sts->pre_sts.hw_csid == st->cs_id &&
+				   sts->pre_sts.hw_cycles) {
+				cycle = sts->pre_sts.hw_cycles;
+				sts->post_sts = sts->pre_sts;
 			} else {
 				cycle = get_cycles();
 				ptp_read_system_postts(sts);
-- 
2.54.0


