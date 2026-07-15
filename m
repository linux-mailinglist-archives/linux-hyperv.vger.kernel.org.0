Return-Path: <linux-hyperv+bounces-11988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gGrqGZqeV2oKYAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11988-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 16:52:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E038375F98A
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 16:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=C7FPdE7E;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=JHRP+u0d;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11988-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11988-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 750F233B9D42
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5C38737B;
	Wed, 15 Jul 2026 14:33:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A5388E62
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 14:33:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125983; cv=none; b=uTmemHXkz85lyZN99CghZoZ78Fa9ky4nTIKZIwtk9v8YW8WiyAQJqvfRNMCcrDHU9IiBTKE532XY8BIgGOu8U4NtrrxievfRHvTCRKYqOEfh0Xj98EW+jO9/r72tcSAivTKWHFORMtLAAmpTsNtfyzersBJtQXJAiHViuhKGKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125983; c=relaxed/simple;
	bh=uPj+Sc+rqsDCxvIWOjSdivoSnd+ME+gL9jxKEnqWcWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JborLsWbjrLsix+GjCleY+YwCV5B3+gdCcLOFjFu7j4iiP5yB3trj0SuCKH2IXRguR85jLzofuAJvaDJPQjVlwuK3DLTEgF17EbAMZ4pYZQ5xPRWRYFq0M6gRiMDKMhyH3PkKYRGmZRYNr+wZRpAMd5ziTt+8bKJQvLhBZae+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7FPdE7E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHRP+u0d; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 15 Jul 2026 16:32:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784125973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2a8q8ic7CkdM8yMLQ6ZHYx85VK0OYL++A5hUJ6/Z6IU=;
	b=C7FPdE7Ejutrgrv816LOkEd/Q8mABS/mx9vkhcjk7hJeo8lo8UhqH2DCw2zP5eJuzWLJWm
	sYSnqA9LD17Z9GCPHjiua4HMavNwO/rWKzNQYNgZgWiMXTFPHAsbQoQQ9cfUZVKw9x0vK3
	m4vuDE8008bwcPBZoajv1c6KxNjW/llUpuseU2AKQR+OyReZ0SHwhT2g0L++lbEoptgHnj
	ulwuz0RKgE8V/1S8UxqrAXgheVWcAe+JHLuI+nPSZcePTXeqgbrn5i7OHOcSxpWQ7bNiLJ
	4WUp/Nga6b9IV+HS8jNtf+7uVnuPvgi/PKWL2BLUYqMxdT6zMW0ZbimHl5A8/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784125973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2a8q8ic7CkdM8yMLQ6ZHYx85VK0OYL++A5hUJ6/Z6IU=;
	b=JHRP+u0ds15P1h+Rp0LrpTj5s8BL33X4/0jrF2XZLD4aFKgaJA2yJZo17A5Z+lR1s1dQyH
	QxutI5RqM6WZQeBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: RE: [PATCH 1/2] hv: vmbus: Replace lockdep_hardirq_threaded()
 with lockdep annotation
Message-ID: <20260715143252.gWEZfb5B@linutronix.de>
References: <20260401151517.1743555-1-bigeasy@linutronix.de>
 <20260401151517.1743555-2-bigeasy@linutronix.de>
 <SN6PR02MB4157524E39FC4ABD058A4A52D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157524E39FC4ABD058A4A52D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-hyperv@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:kys@microsoft.com,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jan.kiszka@siemens.com,m:longli@microsoft.com,m:wei.liu@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11988-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E038375F98A
X-Rspamd-Action: no action

On 2026-04-04 01:22:08 [+0000], Michael Kelley wrote:
> Nit: For historical consistency, use "Drivers: hv: vmbus:" as the prefix for the
> patch "Subject:" line.  Same in Patch 2 of this series.

okay.

> Also, any reason not to have copied linux-kernel@vger.kernel.org? I know this
> is pretty much just a Hyper-V thing, but I would have liked to see what the
> Sashiko AI did with these two patches. :-)

Can do.

> > lockdep_hardirq_threaded() is supposed to be used within IRQ core code
> > and not within drivers. It is not obvious from within the driver, that
> > this is the only interrupt service routing and that it is not shared
> > handler.
> 
> I presume you meant "routine". And what do you mean by "the only interrupt
> service routine"? And why is the lack of obviousness relevant here? I don't have
> deep expertise in lockdep, but evidently there's some conclusion to reach and it
> would have helped me to have it spelled out.

You use lockdep_hardirq_threaded() which marks the hardirq as a thread
for lockdep purposes. The reason is that the IRQ core will force-thread
the handler and the whole routine will be threaded. It does invoke the
function and the very begin and nothing else will be done.

vmbus_isr() is using it before __vmbus_isr() is invoked and there can be
other functions/ ISRs that are invoked afterwards which would be wrongly
recognized.
To make it more concrete: sysvec_hyperv_callback() invokes mshv_handler
and vmbus_handler. Would vmbus_handler() be invoked first then it will
"spill" this lockdep attribute into mshv_handler(). Nested locks in
mshv_handler() would not be visible then.
This override limits it only to __vmbus_isr() while the RT case above is
using vmbus_irqd_wake().

> > 
> > Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
> > threaded context on PREEMPT_RT to __vmbus_isr().
> 
> Again, I'm not clear what "limiting threaded context" means. But see my
> additional comment further down.

Does the explanation above make it clear?

> > 
> > Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus interrupts on PREEMPT_RT")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/hv/vmbus_drv.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index bc4fc1951ae1c..e44275370ac2a 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1407,8 +1407,11 @@ void vmbus_isr(void)
> >  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >  		vmbus_irqd_wake();
> >  	} else {
> > -		lockdep_hardirq_threaded();
> 
> I see two similar occurrences of LD_WAIT_CONFIG in the kernel:
> __kfree_rcu_sheaf() and adjacent to printk_legacy_allow_spinlock_enter().
> Both occurrences have a multi-line comment explaining the "why". I'd like
> to see a similar comment here so that drive-by readers of the code have 
> some idea of what's going on. My suggestion is something like this:
> 
>    vmbus_isr() always runs at hard IRQ level -- the interrupt is not threaded. It
>    calls __vmbus_isr() here, which may obtain the spinlock_t sched_lock for
>    a VMBus channel in vmbus_chan_sched(). If CONFIG_PROVE_LOCKING=y,
>    lockdep complains because obtaining spinlock_t's is not permitted at hard
>    IRQ level in PREEMPT_RT configurations. However, the PREEMPT_RT path
>    is handled separately above, so there's actually not a problem. Tell
>    lockdep that acquiring the spinlock_t is valid by temporarily raising
>    the wait-type to LD_WAIT_CONFIG using the "fake" lock vmbus_map.
>    If lockdep is not enabled, the acquire & release of the fake lock are no-ops,
>    so performance is not impacted.
> 
> Please review my suggested text and revise as appropriate, as I'm far
> from an expert on any of this. The above is based on what I've learned
> just now from a bit of research.

What about?
  vmbus_isr is never force-threaded and always invoked at hard IRQ level.
  __vmbus_isr() below can acquire a spinlock_t which becomes a sleeping
  lock and must not be acquired in this context. Therefore on PREEMPT_RT
  this will be threaded via vmbus_irqd_wake(). On non-PREEMPT the
  annotation lets lockdep know that acquiring a spinlock_t is not an
  issue.

> And thanks for jumping in and making all this better ....

so I've been looking at __vmbus_isr() and vmbus_chan_sched() seems fine.
vmbus_message_sched() on the handler invokes hv_stimer0_isr() which
should not be done in the thread but in the hardirq. Is this the only
timer in the system or some legacy thingy that is no longer used?

And there is a lot of tasklet involved which mandates a
local_bh_disable()/enable() in run_vmbus_irqd() around the function or
everything gets pushed into ksoftirqd.

> Michael

Sebastian

