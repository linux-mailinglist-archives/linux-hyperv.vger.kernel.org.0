Return-Path: <linux-hyperv+bounces-2654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE28945311
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C8B21394
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF61487E2;
	Thu,  1 Aug 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7uomi6q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvIcvdWU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAB14388E;
	Thu,  1 Aug 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538630; cv=none; b=E2QFHrLU5rJUaDuILkMhaKwoi0njrPYedWz7UIhYMmzctaeyecdIXufTyQc5qj8/19H3id160IMThACRahlPfESPJLHsiUOhLUQLbGmyX45FvFr2Zo9ELqdVzFY5O1wd2vHscsYzK0qXxZBmkL1pXE2qqKX0uPVRoLbqOFD6Po0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538630; c=relaxed/simple;
	bh=FmrTjJfZRJeOeksSetKsZeX8pmXxLUoNvXSzWv3VKRg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTjaDYGr/Gs5rclpNMs2cyJSjxyXlcluQq5XUw5Ctn615Cr2hbAG3Ruyr9nDSNvum1LPUtlO3pRL3LHwvkqxCyQIFjQduqSEvdsOQCkzNFH6tVY0WtDI1VPr02KDpN8zZEDaZ15XckAMFOcBuvGSvoT1k0ensOiy0+lulqBB6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7uomi6q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvIcvdWU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722538626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qtvx6UnoUyoSWHMXwIOA4ijYHSyk+SaZyONVTD97zM=;
	b=X7uomi6q3hLASo35HE776F+PpcjV8RgqjVLyGxakOYdAVj1NReqyif33JIQy86hTowZpiq
	s4w23BBQrjFpERRJiLYzGccDmZoqRee7RN1wTDqzEkV9rhk5T3lXX7+x0S0gOFdRis5NaT
	Ivq3Nldba9Kb9c7NoT1YbI4YjLvupwkMbB5dFYD6Q2nq8V4xQdOutJMia6ULSFUfl2omhr
	Hk8Rd42QhHAixHltVBsgugmforRhUpBkR7dHmLg/EsLfLLdY26IdLY9cR9+BQM2A6rZaZs
	H2wnkLUm7ZWYNfg1SP1y1WGr/G2DbkjbownuZotugiaPt9ACbxrdK1RoKVCtSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722538626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Qtvx6UnoUyoSWHMXwIOA4ijYHSyk+SaZyONVTD97zM=;
	b=NvIcvdWUQDvyRVpEmX699azWn8Q/4GGaDmsTDbOIkTz10dz6fDSkJZj0bodPKoaIi+zIke
	VopjK9ATxqlZsCBg==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <b781a3f94e7ff1c2b49101255d382ab9d8d74035.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
 <b781a3f94e7ff1c2b49101255d382ab9d8d74035.camel@infradead.org>
Date: Thu, 01 Aug 2024 20:57:06 +0200
Message-ID: <87le1g2hrx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01 2024 at 19:25, David Woodhouse wrote:
> On Thu, 2024-08-01 at 18:49 +0100, David Woodhouse wrote:
>> > The stop sequence is wrong:
>> >=20
>> > =C2=A0=C2=A0=C2=A0 When there is a count in progress, writing a new LS=
B before the
>> > =C2=A0=C2=A0=C2=A0 counter has counted down to 0 and rolled over to FF=
FFh, WILL stop
>> > =C2=A0=C2=A0=C2=A0 the counter.=C2=A0 However, if the LSB is loaded AF=
TER the counter has
>> > =C2=A0=C2=A0=C2=A0 rolled over to FFFFh, so that an MSB now exists in =
the counter, then
>> > =C2=A0=C2=A0=C2=A0 the counter WILL NOT stop.
>> >=20
>> > The original i8253 datasheet says:
>> >=20
>> > =C2=A0=C2=A0=C2=A0 1) Write 1st byte stops the current counting
>> > =C2=A0=C2=A0=C2=A0 2) Write 2nd byte starts the new count
>>=20
>
> It also prefixes that with "Rewriting a counter register during
> counting results in the following:".
>
> But after you write the MODE register, is it actually supposed to be
> counting? Just a little further up, under 'Counter Loading', it says:

It's not counting right out of reset. But once it started counting it's
tedious to stop :)

> "The count register is not loaded until the count value is written (one
> or two bytes, depending on the mode selected by the RL bits), followed
> by a rising edge and a falling edge of the clock. Any read of the
> counter prior to that falling clock edge may yield invalid data".
>
> OK, but what *triggers* that invalid state? Given that it explicitly
> says that a one-byte counter write ends that state, it isn't the first
> of two bytes. Surely that means that from the time the MODE register is
> written, any read of the counter may yield invalid data, until the
> counter is written?

It seems to keep ticking with the old value.

> I suspect there are as many implementations (virt and hardware) as
> there are reasonable interpretations of the spec... and then some.

Indeed.

Thanks,

        tglx

