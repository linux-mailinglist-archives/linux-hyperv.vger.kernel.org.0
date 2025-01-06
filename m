Return-Path: <linux-hyperv+bounces-3579-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A303A02896
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADCC1882DC8
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C813635E;
	Mon,  6 Jan 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqpuqH2/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92273C8DF;
	Mon,  6 Jan 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175250; cv=none; b=bhHO6GAlbqBl8LiqyMaArzJD/xp/B95jjWA5X+PdiEHyrNAINidToSLi5NdjC3LnVAoalF4aTdoMeTIvNBWRANF7QFKUaffjzT8CzXstZpjz42hkK6GLClYHT5kBSSodWsKZcDK4RhIsLYylu5wqKV0b5pKB7RSuGXW0uL/szMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175250; c=relaxed/simple;
	bh=usLJIZ0JjsamibX6TIiJThU5FT0wSptsKOh66NxWewo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwcRsClIJk2CcycumYu4QjHSuNpVirFAhJTDkFr2bgcxdXh87BXj2JLvQItRoupQ4kr7bIrySj4uj2ieqgcAj52G/U7h0ApijuZOFGo/266z19i33x2V39+sQ6q5SttQLtuwzhYOwR9/pbSbW7MDquo/H/IGuUYtR18BKmxnXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqpuqH2/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30167f4c1deso139662321fa.1;
        Mon, 06 Jan 2025 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175245; x=1736780045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HepQG2yr+yRvZOk+Zk67tvI9GJA/xPVXD5B8/oJueSc=;
        b=ZqpuqH2/v/C/VJsao0OVQHKwMN73+iI7C5jE+VbFUQL184jwviq6yHdKKgcKNk7ILS
         6FiZ5g3WONYdsll52AKf3ecnzIB05hZghVRlnxUnnzBOlLP27Rk6OaQ9mUnOsUoujl1G
         2bbcEFDffDzT3ZvW1YBbUxXCWaClUI9rWBMs35WxfPuLpnLL/zL3GYKnd5nmGlL69ZKH
         dPGl8d2VkxQFLU5V4uhA9IWp2ok3Xa6LMgIYf3anI1HANybh3/IBmuRkhUnv7WId2PiZ
         tY8LseQCONlNgYzo1Iz9oH4QBWtw0JoTFdG9VJD/do2vkqDIOFyHHvRNulvntOnFvMMr
         FJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175245; x=1736780045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HepQG2yr+yRvZOk+Zk67tvI9GJA/xPVXD5B8/oJueSc=;
        b=Xk1l7DFZTuGbcx8mZ+f67G1sYMCiSl1IuXWCL2eapP2FQ3Pors1Ih80gCCR/heFe8H
         6jrSZ4olDR7QfAodM4bUGkdr3SwcZiO7Ii1nQ6x4paWAyhyA48Q6cNbxxlNPDbLvJ6XN
         WVhZ3cV0cKFyWhjDyefHw9p9EWyvgqCGo9Qm1scz5pNTzxf7npEUdarKsOvOqWMl98KN
         VAlCImBxG+ErfF6Egzwg8vUJqADTf8iFVhjLtXJrHHgnAqySJtgcqrmFTIGQQEoOEnU5
         n6u3J3PFbQF4/SOkhjcSDUZ9YGN0DS9bg7fW2aquORC2XeMVBTUskIQz51D66+Qhc7BV
         7/1g==
X-Forwarded-Encrypted: i=1; AJvYcCUF186gzZDHtwtQ7Y4Y+TwnCdQRHpiLGzjNrJBIsmXi8sNbt4YrDdj3co14oO6x0/FrqYhoyhrGOHyp8czU@vger.kernel.org, AJvYcCXKwLg0kAIIch2LT79U5ziMTuA8ul6Nb0kzKP85ZiAEStzBYI8nKN+KhSJ6dUR9G1ug7Le8LSUycgiMlac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDqDB6lQb/mnhd8n266cwWb6Ne9qu5x+q+/aVK/7yYoLkVquY
	JFtUiYUW7P8y1GhdQDXgNaDRt4f+zKyNyfUjQWSYGgT7dik3oCRjjZnsWmkHm+87UaMvciyyaOm
	/F6gVPYU6tcYzQpQS+EQUq7ihdq0=
X-Gm-Gg: ASbGnct9lFE2/2anVRWOPgKYe4aJOZGe6NqoYnxfleAeukh0YvAWRoxzsQZJhpy58zR
	RhpyZeobwUkOmsPo1hSDk55QPicOHaeWQwVKyVdM=
X-Google-Smtp-Source: AGHT+IEMyuN/Ovpvw+InCtb/clfNdG27nHrk7IdyHIg9Sh1gXpYslCgFUuAq/8pAwsq86N43PUpLMWHRkgjIl1dE7Y4=
X-Received: by 2002:a2e:743:0:b0:300:4107:6294 with SMTP id
 38308e7fff4ca-30468627b2fmr139135801fa.35.1736175245335; Mon, 06 Jan 2025
 06:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com> <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJ-90NKKfF-KcWJ7sdMCXK9fWiXwMG-9xtjQn9fVhXgjRinZbA@mail.gmail.com>
In-Reply-To: <CAJ-90NKKfF-KcWJ7sdMCXK9fWiXwMG-9xtjQn9fVhXgjRinZbA@mail.gmail.com>
From: Alex Ionescu <aionescu@gmail.com>
Date: Mon, 6 Jan 2025 09:53:48 -0500
Message-ID: <CAJ-90N+uyZETZnAOCo03YRm=8as5d_dbO1VObfgYp=4AxBEH3A@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com" <tiala@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>, 
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>, 
	"vdso@hexbites.dev" <vdso@hexbites.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For another 2c worth, I had previously requested #1 (always allocate
output page) as this would simplify some further work I was interested
in at some point to provide VSM-like functionality to a VTL 0 Linux
guest, which would, at that point, not make it wasteful for VTL 0 any
longer (since some required hypercalls for VSM support need an output
page).

I realize this is "future-proofing" something that doesn't exist yet
but it would avoid a further change down the road.

Best regards,
Alex Ionescu

Best regards,
Alex Ionescu


On Mon, Jan 6, 2025 at 9:45=E2=80=AFAM Alex Ionescu <aionescu@gmail.com> wr=
ote:
>
> For another 2c worth, I had previously requested #1 (always allocate outp=
ut page) as this would simplify some further work I was interested in at so=
me point to provide VSM-like functionality to a VTL 0 Linux guest, which wo=
uld, at that point, not make it wasteful for VTL 0 any longer (since some r=
equired hypercalls for VSM support need an output page).
>
> I realize this is "future-proofing" something that doesn't exist yet but =
it would avoid a further change down the road.
>
> Best regards,
> Alex Ionescu
>
>
> On Fri, Jan 3, 2025 at 5:08=E2=80=AFPM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>>
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Fri=
day, January 3, 2025 11:20 AM
>> >
>> > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
>> > > Due to the hypercall page not being allocated in the VTL mode,
>> > > the code resorts to using a part of the input page.
>> > >
>> > > Allocate the hypercall output page in the VTL mode thus enabling
>> > > it to use it for output and share code with dom0.
>> > >
>> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> > > ---
>> > >  drivers/hv/hv_common.c | 6 +++---
>> > >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> > > index c6ed3ba4bf61..c983cfd4d6c0 100644
>> > > --- a/drivers/hv/hv_common.c
>> > > +++ b/drivers/hv/hv_common.c
>> > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
>> > >     BUG_ON(!hyperv_pcpu_input_arg);
>> > >
>> > >     /* Allocate the per-CPU state for output arg for root */
>> > > -   if (hv_root_partition) {
>> > > +   if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>> >
>> > This check doesn't look nice.
>> > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that thi=
s
>> > particular kernel is being booted in VTL other that VTL0.
>>
>> Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_MODE=
=3Dy
>> will not run as a normal guest in VTL 0. See the third paragraph of the
>> "help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.
>>
>> Michael
>>
>> >
>> > Second, current approach is that a VTL1+ kernel is a different build f=
rom VTL0
>> > kernel and thus relying on the config option looks reasonable. However=
,
>> > this is not true in general case.
>> >
>> > I'd suggest one of the following three options:
>> >
>> > 1. Always allocate per-cpu output pages. This is wasteful for the VTL0
>> > guest case, but it might worth it for overall simplification.
>> >
>> > 2. Don't touch this code and keep the cnage in the Underhill tree.
>> >
>> > 3. Introduce a configuration option (command line or device tree or
>> > both) and use it instead of the kernel config option.
>> >
>> > Thanks,
>> > Stas
>> >
>> > >             hyperv_pcpu_output_arg =3D alloc_percpu(void *);
>> > >             BUG_ON(!hyperv_pcpu_output_arg);
>> > >     }
>> > > @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
>> > >     void **inputarg, **outputarg;
>> > >     u64 msr_vp_index;
>> > >     gfp_t flags;
>> > > -   int pgcount =3D hv_root_partition ? 2 : 1;
>> > > +   const int pgcount =3D (hv_root_partition ||
>> > IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
>> > >     void *mem;
>> > >     int ret;
>> > >
>> > > @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
>> > >             if (!mem)
>> > >                     return -ENOMEM;
>> > >
>> > > -           if (hv_root_partition) {
>> > > +           if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MO=
DE)) {
>> > >                     outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_=
output_arg);
>> > >                     *outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>> > >             }
>> > > --
>> > > 2.34.1
>> > >
>>

