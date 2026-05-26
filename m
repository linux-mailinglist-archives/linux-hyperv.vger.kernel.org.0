Return-Path: <linux-hyperv+bounces-11213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ElqK/QoFmqUiQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11213-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:12:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339115DD76D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 01:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF124305583E
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 23:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60593C5535;
	Tue, 26 May 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4foA0f4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B3C4540;
	Tue, 26 May 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836871; cv=none; b=S5pJkwlw7u01aIEdaDE/34YSjqlbMhfdTDi676OKppb2w7CegafOOkKv8d3pRngFkXhjCHu72tm5kzeXV/H9VqSHT9QU0erraeXr4305uNqbmkvn4m4rRxUifKkXicdrmpGCb6kSUBHV2lRCz8OfDYNj7akumSvm8VYt4vswDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836871; c=relaxed/simple;
	bh=3M3vpbloOOVC839ZDxXIKYEDj/kk2E+45gGP4zu7kwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQQbFoy62m55+rvo7eg9pmsxNP7XR01IlkOg8o+EKBmE9khmxlb2gi9nfXtBEN3r2B/RlY45JpCgaK3qzfBRvcpdH0Gy1F3YK4V+DRWc0DZgmf3RdKYx9SV2kqk3TLD1n/KM56/MFUKuTkrfsMhDEQhCeMa0jNgKBCWSj8ANetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p4foA0f4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ft2CuWM/pX+CS9qqjbjFmQ9L6oOR54rt5Q0j3SYiTlQ=; b=p4foA0f4EFxkAFHSykaFButWtu
	wLsZkHzYYuDt2kakJx2SOrhI5z+O4gxgIFXz2x4BhjaVqD4VBKm/mhfwkIrg5u+hyWeJ5VCaRF7eA
	cW2HIW2RmkEGZcq/Ey5rZ8kkbCztnl6C1x6MzYoO71v5G8+SHDsNiAEHmMUWKKzZx0foA5N8d3DnX
	mcywRlsuO4VK3+CxHnPW/yWVZas/BjLfzS0Exg4MHPuUdXQAjh1J9NzvlV8nxKnrDFZGd+BVMPVCw
	eGSQdNKheQOmSgZH0bdxlObLGOyqz7hrxxB7Z99iLwq213LTcYvcW6e1yh3FRS1NMV0ljH/cJxT7G
	HWOeRN9g==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS0r6-0000000CV9F-0csl;
	Tue, 26 May 2026 23:06:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0r6-00000000Zcu-03H9;
	Wed, 27 May 2026 00:06:36 +0100
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
Subject: [RFC PATCH 8/8] ptp: vmclock: Use raw_cycles from snapshot for precise TSC pairing
Date: Wed, 27 May 2026 00:06:35 +0100
Message-ID: <20260526230635.136914-8-dwmw2@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-11213-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 339115DD76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

When the system clocksource is kvmclock or Hyper-V (not the TSC
directly), vmclock_get_crosststamp() previously fell through to a
separate get_cycles() call, losing the atomic pairing between the
system time snapshot and the TSC reading.

Now that ktime_get_snapshot_id() populates raw_cycles with the
underlying TSC value for derived clocksources, use it when available.
This gives a perfect (system_time, tsc) pairing for the device time
calculation.

The SUPPORT_KVMCLOCK wrapper is still needed to convert the TSC into
kvmclock nanoseconds for system_counter->cycles, because otherwise
get_device_system_crosststamp() can't interpret the result.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 drivers/ptp/ptp_vmclock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index cb18c15a4697..aacbf8f48f13 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -140,6 +140,10 @@ static int vmclock_get_crosststamp(struct vmclock_state *st,
 			if (sts->pre_sts.cs_id == st->cs_id) {
 				cycle = sts->pre_sts.cycles;
 				sts->post_sts = sts->pre_sts;
+			} else if (sts->pre_sts.raw_csid == st->cs_id &&
+				   sts->pre_sts.raw_cycles) {
+				cycle = sts->pre_sts.raw_cycles;
+				sts->post_sts = sts->pre_sts;
 			} else {
 				cycle = get_cycles();
 				ptp_read_system_postts(sts);
-- 
2.54.0


