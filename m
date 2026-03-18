Return-Path: <linux-hyperv+bounces-9520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCBaJyJ7ummTWwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9520-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:14:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C22B9B79
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4AA309B504
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D093BE62A;
	Wed, 18 Mar 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+teoV2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmo9bZOe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFE3B9616;
	Wed, 18 Mar 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828650; cv=none; b=fyjxkKeFK5KVA/TPI4GTuIFxeswIybG26MRXk7s+rLi3tZrnpGX8Pnw8RzWMLrcwotHvF7SQvLdeIkHrdL1WbUMWI6x4GjUM6ylH7CUqJdwyv+PD/QIKgFNvn5l4Z/4Bgyk43DfyZmMVso2td8qi0GUGEwpg2B0NFXAw4AHS8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828650; c=relaxed/simple;
	bh=ayuu3U0Aywjw0PS6KJa8Fl36m8eofG4rwjWBeoomj0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWnKvRbe4Lo3jxoKhVVfVLKfn8t6d6bgFnFXyoLLmLzMVKup1AO8mTpKogb0Lv7o2U+tmW5CzPZtRZdB1rUZ7G3QOTMPIizuHe3cmNGBRdgcTHfOTZzSIBIrrqvuLd2lIiCHiSc3M+B45CudlToEmXo22QEbTsM/HXz6u/E+sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K+teoV2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmo9bZOe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 11:10:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773828643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsyjFqkQEgoUPKvIpyC4SH/ZYl5INrqCC/Ztm9edl30=;
	b=K+teoV2pUChW010qa/H0cILpaSGBd67/XMM2Ir7zgbmnmyNGO2YwDxbWhghV4COj7hU75a
	55lZnMbAnDZS1dFqmcDVgmUeN+Yw6hhPJEbXYSWCAJ7pjApfo7i/IwuPOja9f9qe3PGc06
	xpVFMndU24hyxCO/vrDCvB/RsKuhnObJx1j3gAP/KC41M9iAkRpGMkBl8LMWb4NDTixvf4
	rr7VHJL/d3gGNTsro7s2b4gzXHe8j86L/+qXpAT/iY3S+N4PbWeab70WKpTQxDBSgwaqMb
	cDsWYkBw+BDpFACRCNr1TJcHK/jXrH9MWJPzmNjv0y8K73ZC/mj3QPbykcQxvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773828643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsyjFqkQEgoUPKvIpyC4SH/ZYl5INrqCC/Ztm9edl30=;
	b=zmo9bZOePIZyapMyJAb4knVoMWeLL//883P+SyDTgUaCm3gWO3PBec+NKpUyIAV4fwuGYX
	rnsylGksX9NaGVAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: RE: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness
 back to real interrupt
Message-ID: <20260318101042.-QHDXjlS@linutronix.de>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
 <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
 <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9520-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 1B3C22B9B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 17:26:39 [+0000], Michael Kelley wrote:
> > > Who is other one and does it have its add_interrupt_randomness() there
> > > already?
> > 
> > It's the arm64 path of the hv support. Regarding the vmbus IRQ, it seems
> > to be fully handled here, without an equivalent of
> > arch/x86/kernel/cpu/mshyperv.c.
> 
> The arm64 path is the call to request_percpu_irq() in vmbus_bus_init().
> That call is only made when running on arm64. See the code comment in
> vmbus_bus_init().
> 
> The specified interrupt handler is vmbus_percpu_isr(), which again runs
> only on arm64. It calls vmbus_isr(), which starts the common path for both
> x86/x64 and arm64.
> 
> Then the slight weirdness is that the standard Linux IRQ handling for
> per-CPU IRQs on arm64 with a GICv3 (which is what Hyper-V emulates) 
> does *not* call add_interrupt_randomness().  The function
> gic_irq_domain_map() sets the IRQ handler for PPI range to
> handle_percpu_devid_irq(), and that function does not do
> add_interrupt_randomness().  The other variant, handle_percpu_irq(),
> calls handle_irq_event_percpu(), which *does* do the
> add_interrupt_randomness().

So despite all the generic code on arm64 does not do it? Then don't
workaround this in your driver. Either talk to the IRQ maintainer and
suggest adding it there so everyone benefits from or don't because there
might be a reason to avoid it. Having it in driver code is wrong.

> So at this point, putting the add_interrupt_randomness() in
> vmbus_isr() is needed to catch both architectures. If the lack of
> add_interrupt_randomness() in handle_percpu_devid_irq() is a bug,
> then that would be a cleaner way to handle this. But maybe there's
> a reason behind the current behavior of handle_percpu_devid_irq()
> that I'm unaware of.
>
> Michael

Sebastian

