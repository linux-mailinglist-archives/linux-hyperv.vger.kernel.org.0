Return-Path: <linux-hyperv+bounces-9518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I4xLwFsumnRWQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9518-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 10:10:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232972B8B10
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CC4301D69A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50139903B;
	Wed, 18 Mar 2026 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIdQQewl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DzbzjRU1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327EA24A07C;
	Wed, 18 Mar 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824902; cv=none; b=lsKc3p1wdFgHPqhIS47/qw09Aag3BGC83yk5gqYRLrfw0xKP0yyl0z019EK3uOT3QsnnlqVtZEDyPb4CVBgXFxiLuMarzY6tK365uHdHg1MjGd/mo0ZMAWxDAddSZwQ+PVxPAVcoENVD396oNcXai9yol47ghyGA8484pV7h3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824902; c=relaxed/simple;
	bh=TTM80qBZlbJsOX7dyYwA6eGP+26BFr/GJlY0kcXEKk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAyxQWKPmU8Pfx1VVaotF7LAuBlhkRa/B7QMH4UkdGjsn+6bxsjvfd3rpqzakxiSUgHraLqk8FLHpljMfLD7S3c44wAgeo/tRvif7LBh/nkdweIF7lDxOstN5VUScdEvmFVkfss9x0omMDsWNKqePolVtZmOZ26fdK0HnpJcbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIdQQewl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DzbzjRU1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 10:08:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773824899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NKnrM9bEizZzuiKKQeMVZLwhn/sPHNezLV+bgsaZ6U=;
	b=LIdQQewlHVmZriX+qKz7+nDCuo21a8knzcinPgkb8vggwyZsYBq5Bvk+uBgGG3T+1HOvlr
	yaiO6wJvR6g864bV0e53uslgs8PnrCp/ZN2AernZesmlPGBs7n54/PEf80NfTyFZ/eYoek
	o7/QcC1wQIcAm5vpe/bx4/6cT/JQ4wd3U9Qdr4V1+7AypgQdtBfGR9pcWqXVL8gQTOD4Ym
	rkaWvafsnOpXlHQr+WsT4/0SQEBPyBRZmtAqiIkdHLsomt5gVnkqMyiNI8gw3C0y3f8ux3
	87X9nFHUQ8+AdRdwXmp0oNzxdcDXAqVkBNzngNNQcDivOWn0xcSXEXdml6aZwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773824899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NKnrM9bEizZzuiKKQeMVZLwhn/sPHNezLV+bgsaZ6U=;
	b=DzbzjRU1fvICnNk6kspYNzW4KyFfJBewiVkuhwqOp3uYotbrOEWytkE0Ol8ooh3n/PTwua
	KxhNShO9w2WUo3Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <20260318090817.zuFUjrxd@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>
 <20260317110128.k59TflVp@linutronix.de>
 <1e15ac0d-9835-487c-9a16-c55203f01a3d@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e15ac0d-9835-487c-9a16-c55203f01a3d@siemens.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-9518-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 232972B8B10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 12:55:15 [+0100], Jan Kiszka wrote:
> Point is that a task that was interrupted by a potentially threaded
> interrupt keeps this flag longer that it needs it. And that is
> apparently harmless, but fairly confusing.

correct. My only concern would be a shared handler where the second is
not threaded.

> >> With that in mind, the new logic here is no different from the one the
> >> kernel used before. If both are not doing what they should, we likely
> >> want to add a generic reset of hardirq_threaded to the IRQ exit path(s).
> > 
> > The difference is that you expect that _everyone_ calling this driver
> > has everything else threaded. This might not be the case. That is why
> > this should be in core knowing what is called if threaded, use in driver
> > after explicit killing that flag afterwards since you don't know what
> > can follow or add a generic threaded infrastructure here. 
> 
> This driver is different, unfortunately. I'm not sure if we can / want
> to thread everything that the platform interrupt does on x86. So far,
> only the last part of it - vmbus handling - is threaded. On arm64, the
> irq is exclusive (see vmbus_percpu_isr), thus everything can be and is
> threaded.

No, it is a percpu interrupt which are not forced-threaded.

> >>> Couldn't the whole logic be integrated into the IRQ code? Then we could
> >>> have mask/ unmask if supported/ provided and threaded interrupts. Then
> >>> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
> >>> instead apic_eoi() + schedule_delayed_work(). 
> >>>
> >>
> >> Again, you are thinking x86-only. We need a portable solution.
> > 
> > well, ARM could use a threaded interrupt, too.
> 
> For a reason we didn't explore in details, per-CPU interrupts aren't
> threaded. See older version of this patch
> (https://lore.kernel.org/lkml/005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com/)
> where I thought I only had to fix x86, but arm64 was needing care as well.

Per-CPU are usually timers or other things which are not threaded and
have their own thing for the "second" port and I only remember MCE using
a workqueue for notification.

> Jan

Sebastian

