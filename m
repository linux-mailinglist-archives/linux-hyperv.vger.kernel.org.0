Return-Path: <linux-hyperv+bounces-9491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK8pE4A2uWmcvAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9491-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:09:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3672A87E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5703073A47
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA80E3A6EE6;
	Tue, 17 Mar 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFxkJ9H0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/e2/9Ltg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB53A6B91;
	Tue, 17 Mar 2026 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745539; cv=none; b=sTSw9J5hzuKSlgjrmpg1gQK0KoS7tb+TmUgaCUjgJUhV5OKZU2D7wuRGkJ1h6VDhA8uELFXmZhA7H1w/u/x0HMVJC7i+Ni7mjNIqFDDbt7iSHCcFUvYXLp91ovrpazoGJXNMy4bS28lW4BHguvIYC3jZ3DZioTfo0zycACTuT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745539; c=relaxed/simple;
	bh=XbeIt3ZOAl7dYmoRenwbbISnD93cW82NdG4pwZZFXJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8rGZikVD0JSPtkFar4hIl8/8xfAivdh7OfaUVx53j37xSzUDBV/NN/eohMUO0NonBnZELppttNKfXBaGcd7w+Otfg7p+TIRpJZWNRJENtvUbWdn1dPo71q7UURkR6iMPaLvyD6T+5NIBe41iKph3M1+WsnCMmrq5xlnykUNQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFxkJ9H0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/e2/9Ltg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Mar 2026 12:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773745536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JN1SD/V1awQNnrLIW7XWJMZue616SYt+kBa3fB6sCY=;
	b=PFxkJ9H0y6nJMt58mCQSmAumodne11b1d5Y5Ku843irL4qFbsWZWAuCAwFj5r5RTcJQo0g
	IvSgT/zGWAakvNW7HdjT/5Jy0oKThJ11bUzdbi+6zYz92dIpbflZWp3YJRnpA/OMD33RVD
	4cSB+x8L4hbrG2+x0Gp/upSBs1My9T5TC/kY0B2GS4LEFZ7xJ0U8qVTL0XZCJGtLIP4fcy
	xgFylrsRAb6+T1IyGnxoMJRqPQlINRTpt3GsD7mcYDMeGFVJLg3kGuOQLv68JztWNQm8H8
	SPK/ha/6ODZugMaTACgpYDzhw0Khv8N071dcGw2fNO1hTWxXxEg8helsowpUng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773745536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JN1SD/V1awQNnrLIW7XWJMZue616SYt+kBa3fB6sCY=;
	b=/e2/9LtgIepdygo4bacGdSwUGRuwmGgamLcP71bRVWcqfOjy2Np5AwnSwUw0vJi2UoMkim
	J86tICLNKuYCmACg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back
 to real interrupt
Message-ID: <20260317110535.Smn9viQ7@linutronix.de>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9491-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 9E3672A87E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 09:09:27 [+0100], Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Sebastian Siewior wrote:
> "This is feeding entropy and would like to see interrupt registers. But
> since this is invoked from a thread it won't."
> 
> So move it back to where it is always in interrupt context.
> 
> Fixes: f8e6343b7a89 ("Drivers: hv: vmbus: Simplify allocation of vmbus_evt")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc4fc1951ae1..28025a264861 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1361,8 +1361,6 @@ static void __vmbus_isr(void)
>  
>  	vmbus_message_sched(hv_cpu, hv_cpu->hyp_synic_message_page);
>  	vmbus_message_sched(hv_cpu, hv_cpu->para_synic_message_page);
> -
> -	add_interrupt_randomness(vmbus_interrupt);
>  }
>  
>  static DEFINE_PER_CPU(bool, vmbus_irq_pending);
> @@ -1410,6 +1408,8 @@ void vmbus_isr(void)
>  		lockdep_hardirq_threaded();
>  		__vmbus_isr();
>  	}
> +
> +	add_interrupt_randomness(vmbus_interrupt);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");

Why not sysvec_hyperv_callback()?

Sebastian

