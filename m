Return-Path: <linux-hyperv+bounces-2671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E417945EA3
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4F01F24101
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC141E3CD0;
	Fri,  2 Aug 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpCYIDtT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1nd0WyA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127E1DAC4F;
	Fri,  2 Aug 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605232; cv=none; b=Hq6HCoyI9467VVLi3XdyShZJ4ePajFvNI8rVvlzBmhVvRDQVVxE52ngC6LESzvRzhg87pGeeGYAyFoOj2K5SaxLUp+BZDcZDo4GruekVNb5VhdHC492hyZoYQkOBkEAPRUIpAeCLj3UE+HN4fsqj+gGno80CTniIuBi5et9SI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605232; c=relaxed/simple;
	bh=+D0B+zACpr0SQpoPFeMU9/uhsa32Q4vJAOpGX4LnfYg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ML6jhCTLRzRk7YwYUa5HLBa7kyCLlP32RHuIAH+mHB7Od+JA3Ni81q39uT3cRUfpRNg9xFD7JgowBRyMz0JNRqVsDVnUen+m75ZDxkG96GFtPPvZ9F9bqqIOJPJ6qBUM/3ZW3VQwvHMQ9xbqMfsYKY6nwwBasO7rzw96TBScAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpCYIDtT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1nd0WyA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722605229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86wk7LV9LcadGA5hJWz9i5HCOktuGvMOuDCIQk84Ddg=;
	b=DpCYIDtTrHLE6CnWu+YIWn+tYd2pM/PORxS6cpUMsJppG2ppchgx2Dc55Bd3lcDSCzaGdx
	JYhoHEGFo7qo01fXCIBI1CbKeWm0YAq2gQe4H2UBujn37w6icAB8uUmMlfRr4xuammZGY4
	L6PIEVORILZEvE0QI8HhE95etnq3v7+2MrIgQd9Ok9kfUdsJ1PUU3P/r92f7VxDsSVzLHC
	OForDl1suwcS/CSzE9TPpDCkmm0hRjA8T5eDNb7q07qgYYJYBg8DwVkjC0KLqsAYwLHitN
	HRzYfAYPgxmoXoNvftWl9aDjtghB7Q4CT+CK3W7S4b2XqZd84xZt+pnADedTwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722605229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86wk7LV9LcadGA5hJWz9i5HCOktuGvMOuDCIQk84Ddg=;
	b=e1nd0WyA3/eJjoJeemLyp82S+jMl8I2zVoWz3Q6Ex73mrmvlbjJjLRq7+ux4AvmExOlyog
	tiUeAg/dzovpztAw==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <544598eefaf23cd5c62d97012a7fe2128870d7aa.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
 <b781a3f94e7ff1c2b49101255d382ab9d8d74035.camel@infradead.org>
 <87le1g2hrx.ffs@tglx>
 <56d3780bc42c98721e15129b7fd53080c4530760.camel@infradead.org>
 <87plqr19oj.ffs@tglx>
 <544598eefaf23cd5c62d97012a7fe2128870d7aa.camel@infradead.org>
Date: Fri, 02 Aug 2024 15:27:09 +0200
Message-ID: <87a5hv12du.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 12:04, David Woodhouse wrote:
> On Fri, 2024-08-02 at 12:49 +0200, Thomas Gleixner wrote:
>> So fine, we can go with the patch from Li, but the changelog needs a
>> rewrite and the code want's a big fat comment.
>
> Nah, it wants to be MODE, COUNT, COUNT, MODE to handle all known
> implementations.

Yes. That works for whatever reason :)

> Already posted as [PATCH 2/1] (with big fat comments and a version of
> your test) at
>
> https://lore.kernel.org/kvm/3bc237678ade809cc685fedb8c1a3d435e590639.camel@infradead.org/
>
> Although I just realised that I edited the first patch (to *remove* the
> now-bogus comments about the stop sequence) before posting that one, so
> they don't follow cleanly from one another; there's a trivial conflict.
> I also forgot to remove the pre-1999 typedefs from the test program,
> despite fixing it to use <stdint.h> like it's the 21st century :)

Grandpas are allowed to use pre-1999 typedefs. :)

> Top two commits of
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/clocks
>
> I'll repost properly if you're happy with them?

Just make the disable unconditional.

Thanks,

        tglx

