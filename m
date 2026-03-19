Return-Path: <linux-hyperv+bounces-9542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEulNAHNu2mXogIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9542-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 11:16:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D232C954D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E1A3013260
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B33B8BAE;
	Thu, 19 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2m3ZHq9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRS/Yqqb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BF23505E;
	Thu, 19 Mar 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915261; cv=none; b=EFbnBdTTeUCxqRUML7oiuerVqZF8M44NlH258iE6RP4l9wBX2nmNFLs3xgCP7SMarV2NrLgwiru/VYh/Lj13kWxNSaoxe0gxtctkB6LlsIgvQl4U33I/XeqabRaT1eNL6i82PT2l/O/Ho0t9KWZpx0diETw3TKqZqNZ+37Pligo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915261; c=relaxed/simple;
	bh=wGFiFEliROb2GTq8xhU2Xo5gA9vKJLiCTaG+74RMePA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5OWGYWeVEBhcAOWWvekEOoBCrPyY8q1nbH2dbrlKxSenkawrtC/pkaIElHxIu1u0LSJEmAIn1DDM5wsJWzaZEEu9i/uG98B6cOtZ7FFhmB4E3V6a0ewTijmbPc0IEAXSx4u+yEYsxnwvvXwrR2p5od+2gR+PT4AZrAij1++I7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2m3ZHq9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRS/Yqqb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Mar 2026 11:14:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773915257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y8eZg5XkEC5aXjIN/7Q4MRHPUl4W6f7iZ0kloIeJcZA=;
	b=a2m3ZHq9gulwaXc2fBY0nR9dDqVo+kJQBfH8AEi5GkX2abCVrQD5NPHiwZPxquerpBEBEL
	oqMBQxaYnt3tzk0lQBLF3joTUdgtwaw8Pq3Ws6iGRO3uZKwnITiSx3wP5zJdgD7ZjyLQuT
	JB+nLR86d8H0LMb6G4nomhzsjup0wW+nLd4rLi1By+q/6YSYx3Mxv3um7HnmqtFGlgiYnf
	wr7WYfXzjUUiQup4uIDjfHeAAa5YJVlUjkSZ1Y1S9L++MQTuYdHfScABgUJEiTNwsJIF2n
	vcKzkaCHJWmUcrfa+brThrISzfLNxAK5/aI4Mg5Iw75NiDuLdb81sRqSaIWQiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773915257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y8eZg5XkEC5aXjIN/7Q4MRHPUl4W6f7iZ0kloIeJcZA=;
	b=zRS/Yqqb1dQTivYG8cE6NdhI+zA7Kg/TikjkGIS/oL0K/8rGxduuyr7pacgMJTQPpwDDvC
	KVTmDEL3MpWfKBCg==
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
Subject: Re: RE: RE: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus
 interrupts on PREEMPT_RT
Message-ID: <20260319101416.d60J0GjO@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318100138.GimjldpV@linutronix.de>
 <SN6PR02MB4157EE20DCB90F955C12D2C0D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157EE20DCB90F955C12D2C0D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9542-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 35D232C954D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 03:43:12 [+0000], Michael Kelley wrote:
> Indeed, yes, that would remove the need for all the per-CPU interrupt hackery
> on x86/x64. I don't have any objection to someone pursuing that path, but it's
> not something I can do. Full disclosure:  You'll see my name on Hyper-V and
> VMBus stuff in the Linux kernel, with Microsoft as my employer. But I retired
> from Microsoft 2.5 years ago, and my current involvement in Linux kernel work
> is purely as a very part-time volunteer. I also lack access to hardware and the
> test machinery needed to make more significant changes, particularly if multiple
> versions of Hyper-V must be tested.

right. Then I would only ask for better annotation instead this current
thingy.

> > I would be worried if the host would storming interrupts to the guest
> > because it makes no progress.
> 
> No, that kind of storming won't happen. The Hyper-V host<->guest
> interface is based on message queues. The host interrupts the guest
> if it puts a message in the queue that transitions the queue from
> "empty" to "not empty". Eventually the tasklet enabled in vmbus_isr()
> and its subsidiaries gets around to emptying the queue, which effectively
> re-arms the interrupt. The host may add more messages to the queue,
> but it doesn't interrupt again for that queue until the queue is empty.
> If the guest is delayed in doing that emptying, nothing bad happens.

Okay.

> > > > Moving on. This (trying very hard here) even schedules tasklets. Why?
> > > > You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
> > > > You don't want that.
> > >
> > > Again, Jan can comment on the impact of delays due to ending up
> > > in ksoftirqd.
> > 
> > My point is that having this with threaded interrupt support would
> > eliminate the usage of tasklets.
> 
> Agreed, probably. For the non-RT case, the latency in getting to the
> tasklet code *does* matter. I'm not familiar with how tasklets compare
> to threaded interrupts on latency.

There shouldn't be much difference on level where it actually matters.

Sebastian

