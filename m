Return-Path: <linux-hyperv+bounces-9494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCQVGR5WuWnYAgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9494-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 14:24:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7A2AACD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 14:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4A55303B1B7
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CE3CCA00;
	Tue, 17 Mar 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkRovIM1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDWOSsV/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B93CB2EA;
	Tue, 17 Mar 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753777; cv=none; b=oA8Ww3zZuBw5frg5N5DTTRQw/GMvc6AdGykNvSzw9iWyAz4PLXFuhdv+moeZwthD9jo6IygQOl+bx38wjcLp3yNQP5jHQ9EHUcLZ4Q01A7ldcz2lnBTfmoOzBixE51MGPC1cm+0UpQLPBTiaElQNlqgPBAkSbNWJniWC92N3tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753777; c=relaxed/simple;
	bh=R6XbV1EnY19DqVt/YBUGcqYf3YLklqtDw02WFpp86Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0ohPIX5GwGaXAKL57bbQ4hPqtKufsFfpM4h2aNG4U+p4hQREOyx7d9Yl1MPXygoJ75bQOZTRAzHfFfPHjx5qD6co/8eVexYPM1h8ZTzyl8o31sUtxWTmk+G2W5bmtbnk+e1K27jKkTDPbYedrVx/oWAK1D1zz1w5LGg7fn4ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkRovIM1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDWOSsV/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Mar 2026 14:22:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773753774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAZ+8VFYA/lVlmT5C86sbuNqruqBNNc6fXWjRlrtojA=;
	b=OkRovIM1GkGEJabvoH5gCboHjS94Vj/T3/PUPQx2at8QtIk6uK/IOfo5iRGDd+cQe3iw21
	tJMlN1CThB5MIF7+fsD2VXWhlqnxURLq8rKc/cUO5C5qmA+93eTl5GUJgeZdFGCJUuvju3
	4BxwPwu1NwLf4bzRzrT5vj5onTi+N92QLOBolORQGtQm1iId4jA2lkoqU5vNvrb7ZxPs2w
	xdhqOcOvc81mHTVh1D8AfD4eE7jAORs/ZXguQajszWgMsVF4tfb5E+hngxvhBvs4EOzxN1
	3H1MMRpFEIgfucL3WZ7pbDT06keGulqyO9mZLgzsgT2yufrlI8trn5TnL7y/kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773753774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAZ+8VFYA/lVlmT5C86sbuNqruqBNNc6fXWjRlrtojA=;
	b=fDWOSsV/UaTqjE/2BNuMtEo2EY/Oer5BsE5X2jekngfuVyrEs5BssX0wW6kvWBOaeqRWHf
	JYrlkW4yt7TsRmDQ==
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
Message-ID: <20260317132252.AJlwEyMh@linutronix.de>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9494-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AC7A2AACD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 12:56:02 [+0100], Jan Kiszka wrote:
> >> @@ -1410,6 +1408,8 @@ void vmbus_isr(void)
> >>  		lockdep_hardirq_threaded();
> >>  		__vmbus_isr();
> >>  	}
> >> +
> >> +	add_interrupt_randomness(vmbus_interrupt);
> >>  }
> >>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> > 
> > Why not sysvec_hyperv_callback()?
> 
> Because we do not want to be x86-only.

Who is other one and does it have its add_interrupt_randomness() there
already?
This is a driver, this does not belong here.

> Jan

Sebastian

