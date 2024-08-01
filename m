Return-Path: <linux-hyperv+bounces-2657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052594539B
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305B01C21096
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE4013D62C;
	Thu,  1 Aug 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHCAQSg7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ol4smeQN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2014A0A4;
	Thu,  1 Aug 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542429; cv=none; b=cgkochAXAnjVkjqJri3oTjwHq4QgycOt5Jl2gvM2BNM+UqTZ7MRqTf4jZxCoc9iemX7hudmRc11dwn9rlFZHap09yi3le0MfzosgB9RQVS+sPTLilY16wf8MN/iRbbtFHwCuu5TGvgPp69+M3Vxo2KgCer25Gk53Ngb7HGsRd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542429; c=relaxed/simple;
	bh=57EJTOjAG2CCv5iwKQY355abCkcD+2IiP69Qu6dRAZA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YF5gmgSBGaJZpzE9gaMPK4Yw6a/z7aWSr6hVcPXc+cHd26MHCWb4Jt00rP0cIXWx3LCOTIQbfRH82NlD4uhvxghx8/dL8BZW3YyHcUnR9fCWkU0WniXlQb9mCaFnjqwrTYqNGUGNpzCAp2+LFwZyVLCS4g60pmNtyG5YWSWyArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHCAQSg7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ol4smeQN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722542424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7w0LSn9RHL7firFQ1xlYkaaoKMRvQdGnUpV8g/FWGxo=;
	b=eHCAQSg7fJdmYSiPtOCaWP73YRJJt9UriF1H1B2t5c9YfTgGsovzTUJB3nf6QCH/QPs6Ib
	50q2Hs2JoSKy1olnY03jqgYJcBgUdLdrpzvpq3e27IsFD0h/+8kc0Lz6S8kB4h3xK/iBg6
	ApqSCAQztKN/QflVCsE3WUgPX11MrsIFQjxnhxNO90e30VGtQb6seLJz6fz6F46BfhpJYY
	lzZW/JKZfaV4LZM4vn9iZv/V8akcZUIpk9oipwVIArOR06Y4Lvr1J4+zy9LisxXoTdmeEK
	E0fiGkr5omSJCP3bCQLJDQV2fQXwLFKZDnJNTOYLQ7pVwSbL925dF0BxV7kNoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722542424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7w0LSn9RHL7firFQ1xlYkaaoKMRvQdGnUpV8g/FWGxo=;
	b=Ol4smeQN1U3tKUrck3s99PfjjEOlbLF0o77GR4+V7xHNlrTYVUssWcNo4YpBaR2Q97Xndm
	eoZkUnK3BUxqJmDg==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <cf5bf4eec7cb36eec0b673353ff027bee853dd48.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
 <87ikwk2hcs.ffs@tglx>
 <cf5bf4eec7cb36eec0b673353ff027bee853dd48.camel@infradead.org>
Date: Thu, 01 Aug 2024 22:00:24 +0200
Message-ID: <87a5hw2euf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 20:21, David Woodhouse wrote:
> On Thu, 2024-08-01 at 21:06 +0200, Thomas Gleixner wrote:
>> Yes. So the sequence should stop KVM from trying to inject
>> interrupts. Maybe someone fixes it to actually stop fiddling with the
>> counter too :)
>
> I don't think we care about the counter value, as that's *calculated*
> on demand when the guest tries to read from it. Or, more to the point,
> *if* the guest tries to read from it.
>
> As opposed to the interrupt, which is a timer in the VMM which takes a
> CPU out of guest mode and incurs steal time, just to waggle a pin on
> the emulated PICs for no good reason.

Well, if the implementation still arms the timer in the background, then
it matters because that has to be processed too. I haven't looked at
that code at all, so what do I know.

>> > I'm glad I decided to export a function from the clocksource driver and
>> > just *call* it from pit_timer_init() though. Means we can bikeshed the
>> > shutdown sequence in *one* place and it isn't duplicated.
>> 
>> Right. Though we don't have to make this conditional on hypervisor I
>> think.
>
> Right, we don't *have* to. I vacillated about that and almost ripped it
> out before sending the patch, but came down on the side of "hardware is
> a steaming pile of crap and if I don't *have* to change its behaviour,
> let's not touch it".
>
> I justify my cowardice on the basis that it doesn't *matter* if a
> hardware implementation is still toggling the IRQ pin; in that case
> it's only a few irrelevant transistors which are busy, and it doesn't
> translate to steal time.

On real hardware it translates to power...

Thanks,

        tglx

