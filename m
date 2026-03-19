Return-Path: <linux-hyperv+bounces-9541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JiJNcXKu2leoQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9541-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 11:07:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EC2C93B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52A6311C427
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E635E927;
	Thu, 19 Mar 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDa9Zohr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ulZcdgfX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15833F8DE;
	Thu, 19 Mar 2026 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914248; cv=none; b=HrZBZFpqKxYXZI3KDruC6YphaHdoWEApCaLgD35R/akRmSTE2QUnCdaGvV/TvgJauIebSwYnWVDPdiINyUauci120zepJ+fTio8TPWjq2ReHYeOZAIkmiDNahlOyTavo31Q15mzQFF3CcGfHeeCaXY1OGvnzrnl1f2Owe9ZazqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914248; c=relaxed/simple;
	bh=q/fAGM1WlZtKgF1+4yom1XPC0q0gpF/vGIT7LLSp/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2EDUEnQIX56HFiSO0kEwKViSF/ypSPP+v08Ztrl1xXuqHNzBUOt3/evvgcGye+1pmtnVh8a6i1i5gJ2RTmfGMhpBBH8hVn60+c+8205uxXdqMgK7UqjmvXfJlpdeyCFmSg5SDx63kM2KrmeVoo6PRUfUD2C9rMV8rrzsT9DOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDa9Zohr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ulZcdgfX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Mar 2026 10:57:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773914240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCSakhZ22tRYlTFSu2lqYAW8ApUF+2qtxpRzx345s3o=;
	b=DDa9ZohrxpgyNrKbFynVKEwlyx37ihedjVIue/fWtS21zA1FmTG4xmqJsqww4ZPs057WAG
	jKHv1UsdO1MN1lGR+ZiKJ7UU9bouwPz10IB8JKYQR+0xjhraMaYWRRUAFio7Q+Rdb44H7T
	3vDUwiUjqaEFew7i0yd6f/Q7DwG+NT46wXa+4BDOCIpmmXm7f5YyyBjeO6waChF8DpR92N
	f38AChd9Bwe9L2F8UOknWtjwB5AwRlEGplplhX6hxCUFoM1+HKoZaf//rGDH9xysmRWLvS
	ujydg4AwKNcP621bg8MUl7IKXKHsz2kG3Aor8u0IJSBvlzGLYW6CSAK85GWUvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773914240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCSakhZ22tRYlTFSu2lqYAW8ApUF+2qtxpRzx345s3o=;
	b=ulZcdgfXSxCsjHh9MhJAXrKcpDZCCfuVdLmAO1oANiESaxXmAC1bz5lgMTLiil9wWeEQnb
	4BY9KQeDXU31rOCA==
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
Subject: Re: RE: RE: [PATCH] Drivers: hv: vmbus: Move
 add_interrupt_randomness back to real interrupt
Message-ID: <20260319095719.7cPrV_6A@linutronix.de>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
 <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
 <SN6PR02MB41573332BF202DAE0AF79ED1D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318101042.-QHDXjlS@linutronix.de>
 <SN6PR02MB4157392A02838453BAFBA807D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157392A02838453BAFBA807D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9541-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 563EC2C93B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 03:39:12 [+0000], Michael Kelley wrote:
> I'll raise the topic with ARM maintainers and IRQ subsystem maintainers
> to see if there's any reason one way or the other. I would not be surprised

Thank you.

> if adding interrupt randomness is intentionally excluded because these
> per-CPU interrupts were historically used for IPIs and timers only. What's
> changed is that ARM64 is now used significantly in data centers, and
> support for VMs is super important. The per-CPU interrupts are now used
> for more that IPIs and timers, such as in the Hyper-V case, and
> handle_percpu_devid_irq() was never reconsidered in that light. I would
> expect a reluctance to burden the IPI and timer interrupt paths with the
> overhead of add_interrupt_randomness(). But the Hyper-V VMBus case
> still needs it because that's the primary source of interrupt entropy in the
> VM. There aren't necessarily other devices generating non-per-CPU interrupts
> like in a physical machine. To me, it is perfectly valid for the IPI & timer
> interrupt paths to want to skip interrupt randomness, while the
> Hyper-V VMBus interrupt path needs it, and we will be back where we
> are now.

But if that is your concern, don't you have or should have something
similar to virtio-rng where you can feed high quality random data to the
guest?

> Related, *not* doing add_interrupt_randomness() on the ARM64 Hyper-V
> synthetic timer path is consistent with the ARM64 architectural timer, since
> it also uses handle_percpu_devid_irq(). I did the original work to get the
> Hyper-V synthetic timers working on ARM64 back in 2019 (?), but I don't
> recall if that consistency with the ARM64 architectural timer was
> intentional or accidental.
> 
> Again, I'll raise this with the appropriate maintainers and see what the
> feedback is.

Again, thank you.

> Michael

Sebastian

