Return-Path: <linux-hyperv+bounces-9519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDAzD1B4ummTWwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9519-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:02:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6722B9999
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E774305A406
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881283BA24C;
	Wed, 18 Mar 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GrbVitoK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aA4wBk9f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF729D273;
	Wed, 18 Mar 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828110; cv=none; b=qnnCoUjOf6MAfB4+Ojg2PbOjJFMQRC/NGW2sHId7TUyD4YLiDZAGEUtnrtp2q+q1HSNA6MTFoo7s0mIjs4xmEdPyCu00RzH84KPZ+QaJ51EKfkRIWCLxJ+WXyPaB4tIJjdDd+xsHvD5A0RMvFGtGahXSMwYcXXkF/L1E8hv1HwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828110; c=relaxed/simple;
	bh=pBrT/kEH9RRg8P1HYcDktaS/F5A6c1FErxSGPIhH5XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZpqwUMf4P0t6vN2M2cZOZhD0Wo08tRBnMqWvTnwPihv4OCwy0XJXJucTgWrolnUYU4kdr1I3BxPrqTGLKcXz+gkQFZbDqQCtsIh7IM29mc8y8D6EMAAVamrwxFPnK1FVMBwrsOq8ipfbo2zuY8i4gULt9/+RrWi0XSNXB3dSsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GrbVitoK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aA4wBk9f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 11:01:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773828100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPYB+vdUZO9Mw2E7Pdv55Argl9Sr0qxO+lmI3FizhCE=;
	b=GrbVitoKPtfsUJ+cGKE2EUPCcTlJyWClmWP85tGqf5UMSDBX9vfSxbPeL79agbWSUx9UPz
	pr/q1jfduiNxtncK+GfZnnOjU+CCi06jSiE1GskbOKPQzG5AsDo8CP4Ld/XIu6axXBQU2O
	s3ASk82dgIhP5Pu+oTA90AimWTfDsBO9sLM+AZolEAHGAZ84lp7KxfWmxJnqy6kDwD8vQg
	BMIQy3rg/H3i3P0vF55F1PZoMHjQyfN4AmOPwQVW4rfywzeO1kr6zbefI8y1NfSywVLAA9
	5KWOzbK2YXvMtj8GZv4T4H1ONTmgePHuiPJMD8s8oJWfQFtxuYnsTPmfCl1F/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773828100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPYB+vdUZO9Mw2E7Pdv55Argl9Sr0qxO+lmI3FizhCE=;
	b=aA4wBk9fx931UcTlhSB7Qu9MCrqMco98btJxmW+A4Sfb2CySB3c5jdq05K8bVLc+t8uwQC
	QGPt5B+X/umHewCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: RE: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus
 interrupts on PREEMPT_RT
Message-ID: <20260318100138.GimjldpV@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9519-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[siemens.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,gmail.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid]
X-Rspamd-Queue-Id: BD6722B9999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 17:25:20 [+0000], Michael Kelley wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Thursday, M=
arch 12, 2026 10:07 AM
> >
>=20
> Let me try to address the range of questions here and in the follow-up
> discussion. As background, an overview of VMBus interrupt handling is in:
>=20
> Documentation/virt/hyperv/vmbus.rst
>=20
> in the section entitled "Synthetic Interrupt Controller (synic)". The
> relevant text is:
>=20
>    The SINT is mapped to a single per-CPU architectural interrupt (i.e,
>    an 8-bit x86/x64 interrupt vector, or an arm64 PPI INTID). Because
>    each CPU in the guest has a synic and may receive VMBus interrupts,
>    they are best modeled in Linux as per-CPU interrupts. This model works
>    well on arm64 where a single per-CPU Linux IRQ is allocated for
>    VMBUS_MESSAGE_SINT. This IRQ appears in /proc/interrupts as an IRQ lab=
elled
>    "Hyper-V VMbus". Since x86/x64 lacks support for per-CPU IRQs, an x86
>    interrupt vector is statically allocated (HYPERVISOR_CALLBACK_VECTOR)
>    across all CPUs and explicitly coded to call vmbus_isr(). In this case,
>    there's no Linux IRQ, and the interrupts are visible in aggregate in
>    /proc/interrupts on the "HYP" line.
>=20
> The use of a statically allocated sysvec pre-dates my involvement in this
> code starting in 2017, but I believe it was modelled after what Xen does,
> and for the same reason -- to effectively create a per-CPU interrupt on
> x86/x64. Acorn is also using HYPERVISOR_CALLBACK_VECTOR, but I
> don't know if that is also to create a per-CPU interrupt.

If you create a vector, it becomes per-CPU. There is simply no mapping
=66rom HYPERVISOR_CALLBACK_VECTOR to request_percpu_irq(). But if we had
this=E2=80=A6

=E2=80=A6
> > What clears this? This is wrongly placed. This should go to
> > sysvec_hyperv_callback() instead with its matching canceling part. The
> > add_interrupt_randomness() should also be there and not here.
> > sysvec_hyperv_stimer0() managed to do so.
>=20
> I don't have any knowledge to bring regarding the use of
> lockdep_hardirq_threaded().

It is used in IRQ core to mark the execution of an interrupt handler
which becomes threaded in a forced-threaded scenario. The goal is to let
lockdep know that this piece of code on !RT will be threaded on RT and
therefore there is no need to report a possible locking problem that
will not exist on RT.

> > Different question: What guarantees that there won't be another
> > interrupt before this one is done? The handshake appears to be
> > deprecated. The interrupt itself returns ACKing (or not) but the actual
> > handler is delayed to this thread. Depending on the userland it could
> > take some time and I don't know how impatient the host is.
>=20
> In more recent versions of Hyper-V, what's deprecated is Hyper-V implicit=
ly
> and automatically doing the EOI. So in sysvec_hyperv_callback(), apic_eoi=
()
> is usually explicitly called to ack the interrupt.
>=20
> There's no guarantee, in either the existing case or the new PREEMPT_RT
> case, that another VMBus interrupt won't come in on the same CPU
> before the tasklets scheduled by vmbus_message_sched() or
> vmbus_chan_sched() have run. From a functional standpoint, the Linux
> code and interaction with Hyper-V handles another interrupt correctly.

So there is no scenario that the host will trigger interrupts because
the guest is leaving the ISR without doing anything/ making progress?

> From a delay standpoint, there's not a problem for the normal (i.e., not
> PREEMPT_RT) case because the tasklets run as the interrupt exits -- they
> don't end up in ksoftirqd. For the PREEMPT_RT case, I can see your point
> about delays since the tasklets are scheduled from the new per-CPU thread.
> But my understanding is that Jan's motivation for these changes is not to
> achieve true RT behavior, since Hyper-V doesn't provide that anyway.
> The goal is simply to make PREEMPT_RT builds functional, though Jan may
> have further comments on the goal.

I would be worried if the host would storming interrupts to the guest
because it makes no progress.

> > > +		__vmbus_isr();
> > Moving on. This (trying very hard here) even schedules tasklets. Why?
> > You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
> > You don't want that.
>=20
> Again, Jan can comment on the impact of delays due to ending up
> in ksoftirqd.

My point is that having this with threaded interrupt support would
eliminate the usage of tasklets.

> > Couldn't the whole logic be integrated into the IRQ code? Then we could
> > have mask/ unmask if supported/ provided and threaded interrupts. Then
> > sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
> > instead apic_eoi() + schedule_delayed_work().
>=20
> As I described above, Hyper-V needs a per-CPU interrupt. It's faked up
> on x86/x64 with the hardcoded HYPERVISOR_CALLBACK_VECTOR sysvec
> entry, but on arm64 a normal Linux per-CPU IRQ is used. Once the execution
> path gets to vmbus_isr(), the two architectures share the same code. Same
> thing is done with the Hyper-V STIMER0 interrupt as a per-CPU interrupt.

This one has the "random" collecting on the right spot.

> If there's a better way to fake up a per-CPU interrupt on x86/x64, I'm op=
en
> to looking at it.
>=20
> As I recently discovered in discussion with Jan, standard Linux IRQ handl=
ing
> will *not* thread per-CPU interrupts. So even on arm64 with a standard
> Linux per-CPU IRQ is used for VMBus and STIMER0 interrupts, we can't
> request threading.

It would require a statement from the x86 & IRQ maintainers if it is
worth on x86 to make allow pass HYPERVISOR_CALLBACK_VECTOR to
request_percpu_irq() and have an IRQF_ that this one needs to be forced
threaded. Otherwise we would need to remain with the workarounds.

If you say that an interrupt storm can not occur, I would prefer
|static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
|=E2=80=A6
|	lock_map_acquire_try(&vmbus_map);
|	__vmbus_isr();
|	lock_map_release(&vmbus_map);

while it has mostly the same effect.

Either way, that add_interrupt_randomness() should be moved to
sysvec_hyperv_callback() like it has been done for
sysvec_hyperv_stimer0(). It should be invoked twice now if gets there
via vmbus_percpu_isr().

> I need to refresh my memory on sysvec_hyperv_reenlightenment(). If
> I recall correctly, it's not a per-CPU interrupt, so it probably doesn't
> need to have a hardcoded vector. Overall, the Hyper-V reenlightenment
> functionality is a bit of a fossil that isn't needed on modern x86/x64
> processors that support TSC scaling. And it doesn't exist for arm64.
> It might be worth seeing if it could be dropped entirely ...
>=20
> Michael

Sebastian

