Return-Path: <linux-hyperv+bounces-3210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166B9B50B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA80B284814
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628B20CCDB;
	Tue, 29 Oct 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RF6C3rFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="chc3FF56"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371C1DCB31;
	Tue, 29 Oct 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222709; cv=none; b=tWj24bej1yVeYk4qR/fxyKQjbtOg3lU5enPMv5DfxD4ATLeJAfpqc5t11fYtfRgc42xsUmnRbG6XjMi58nfOgEIrfmDjmrmtK8DIa47NWYcDBqxw5MB7Vi943YfUQfstAXUm1k285gXzOWXWynkOsdYfW89IYMQq9kpPUXutIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222709; c=relaxed/simple;
	bh=tKqu5xf+7+b36Fy1aUkYpZUXg29HUSsJwQdbeju6nts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bl+0enmJaSo8YckYMbOfoFvPI7M3UHCtfq7a/jtphxCBvLnTukoku6F6tMzam4qQr6Id27pI3mR4PAR6DDzM0pzhvsIL8ku0dDrkp8Er5VX214q+TR6XQx0ODEcBWCBkPPGPNYFjdV2MXSMkAWhEEiOXyk0PgcydUOcY2NMFtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RF6C3rFx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=chc3FF56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730222705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VB2YGHKy8tQmBThMLnbaC2CRgV6b37/PrdYthMx96g4=;
	b=RF6C3rFxjgUBuYvXtWnJyhHLszik83TDhUJwNpNxIQGnmrHBaSXhJkE6uURWSUP6h57KlQ
	Raz3OalVvwaGdgUamPHcR+8xPieoNXITgOk5zVWdc/kKlnyjKCUfUXRzHsvUqKadE/9PmZ
	o9f19mhUx0/05cNoCv3LKeA65akjn6mSEfF/xdJ4EDP37Z0/F8k1OJipAKdJWgW2OVaP40
	YX2M5wdEePydt7Q9HZPBC7WiO+IKrtDGp08tWm8mWV2GO0Jd8tNMxkPpklY/rAR5gFAKka
	Ez9pzRlQZwBIvY2OWzQVz0z5Rt0clM2g1XdL18sHX9k7Zmq4O8xNym8nQY+VPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730222705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VB2YGHKy8tQmBThMLnbaC2CRgV6b37/PrdYthMx96g4=;
	b=chc3FF56A9KHBZCa+WMl54iaEOCynw2FvJe6lrJ14/EKBkByGiU+bdg0oV9XXZiJ6scDTD
	JfucYndyZggwI8DA==
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
In-Reply-To: <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
 <87wmhq28o6.ffs@tglx>
 <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
Date: Tue, 29 Oct 2024 18:25:05 +0100
Message-ID: <87ed3y255a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29 2024 at 17:22, Geert Uytterhoeven wrote:
> On Tue, Oct 29, 2024 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Mon, Oct 28 2024 at 19:11, Easwar Hariharan wrote:
>> > diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>> > index 1220f0fbe5bf..e5256bb5f851 100644
>> > --- a/include/linux/jiffies.h
>> > +++ b/include/linux/jiffies.h
>> > @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiff=
ies(const unsigned int m)
>> >       }
>> >  }
>> >
>> > +#define secs_to_jiffies(_secs) ((_secs) * HZ)
>>
>> Can you please make that a static inline, as there is no need for macro
>> magic like in the other conversions, and add a kernel doc comment which
>> documents this?
>
> Note that a static inline means it cannot be used in e.g. struct initiali=
zers,
> which are substantial users of  "<value> * HZ".

Bah. That wants to be mentioned in the change log then.

Still the macro should be documented.

Thanks,

        tglx

