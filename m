Return-Path: <linux-hyperv+bounces-2655-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4894531A
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD70B24BB6
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00914374D;
	Thu,  1 Aug 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6FOfnFU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQsv1d0m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0951428F0;
	Thu,  1 Aug 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539175; cv=none; b=jOpnsxBpyeNgj2AFfos4rBStSVHS3Xu8PRVjq/LFYe8voVxYR12StuIlEDzTN5opOzrna8osp1Ui2ia7FL5GPGeXRrpV70xXIuB+UzpPftXI8BgCc/sU0M3tPGyw44p5nDsQ6AUhPgXHaYElnY8v5nS4Xo/VHv+zhCHXxxFnZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539175; c=relaxed/simple;
	bh=kQTpxg03Xdinmr9JXXZU4+W/Fkxsyz9mNFGn7SfrIXw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2c063mbGziDSyulgw+C77yoG8dNYWm6ARpW8QtmchfEB5hEw1QQzxsKDfc6GBSc4E/6nFASh0mTF/GofnlBRsCUw09RaboNU6OSSUjfmyNMIlVHhl6ZmDY5kt5ENXPWRV6RWOca5leO4ccfi2P3nIhVuT6f3JpuCs5kvYdG14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6FOfnFU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQsv1d0m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722539172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9C1XAnhR/9RI3VBBwfVyRvGT3nLZRlVcmSdqUm/JwA=;
	b=g6FOfnFUOI+trqIyzmqHT9dTzD7ZPcBuicE+HVzbzL3ckaQpjVzvSm2BBlHZvks8oPAw0O
	yHXKn7BfBZLxiZ0NAuzDLi75F3iRSNpA8Ec3cnh8vsJpBKKsyN3P4ldm0m9F0n3y84rXqR
	1BYMc6Z7a3eFKr/WjUr5Rf6W/sVwFHSm9F2/vZg45y+moDNztBoXy/VBHkKi71xcWqMjgz
	Q05V5heymAVgn4DjpFu8B6JaMJUB/tuDNHElEpRJuIsbVhbDtkKEMBpgZU5uGXr+qUqYez
	xYjHTAsBBeL9vRLhoEL6QpRqYb/rRGYZYBjh2M3RiSpmZEI/RszV1DS0k6Hugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722539172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9C1XAnhR/9RI3VBBwfVyRvGT3nLZRlVcmSdqUm/JwA=;
	b=vQsv1d0mW7lsydl3omlmzTYePVux4j2IFlQn8Y9OzQrgyVyRCxj4jNdUK6UhSQKTN4EvN8
	oeQwBwyaXS45S4CA==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
Date: Thu, 01 Aug 2024 21:06:11 +0200
Message-ID: <87ikwk2hcs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01 2024 at 18:49, David Woodhouse wrote:
> On Thu, 2024-08-01 at 16:21 +0200, Thomas Gleixner wrote:
>> The stop sequence is wrong:
>>=20
>> =C2=A0=C2=A0=C2=A0 When there is a count in progress, writing a new LSB =
before the
>> =C2=A0=C2=A0=C2=A0 counter has counted down to 0 and rolled over to FFFF=
h, WILL stop
>> =C2=A0=C2=A0=C2=A0 the counter.=C2=A0 However, if the LSB is loaded AFTE=
R the counter has
>> =C2=A0=C2=A0=C2=A0 rolled over to FFFFh, so that an MSB now exists in th=
e counter, then
>> =C2=A0=C2=A0=C2=A0 the counter WILL NOT stop.
>>=20
>> The original i8253 datasheet says:
>>=20
>> =C2=A0=C2=A0=C2=A0 1) Write 1st byte stops the current counting
>> =C2=A0=C2=A0=C2=A0 2) Write 2nd byte starts the new count
>
> It says that for mode zero ("Interrupt on Terminal Count"), yes. But in
> that mode, shouldn't the IRQ only fire *one* more time anyway, rather
> than repeatedly? That should be OK, shouldn't it?
>
> "When terminal count is reached, the output will go high and remain
> high until the selected count register is reloaded wityh the mode or a
> new count is loaded".

I just confirmed that this is the case on KVM.

> It's OK for it to keep *counting* as long as it stops firing
> interrupts, isn't it?

Yes. So the sequence should stop KVM from trying to inject
interrupts. Maybe someone fixes it to actually stop fiddling with the
counter too :)

> Either way, this is somewhat orthogonal to the patch I posted in=20
> https://lore.kernel.org/kvm/6cd62b5058e11a6262cb2e798cc85cc5daead3b1.came=
l@infradead.org/T/#u
> for the fact that we don't shut down the PIT at *all* if we aren't ever
> going to use it.
>
> I'm glad I decided to export a function from the clocksource driver and
> just *call* it from pit_timer_init() though. Means we can bikeshed the
> shutdown sequence in *one* place and it isn't duplicated.

Right. Though we don't have to make this conditional on hypervisor I
think.

Thanks,

        tglx


