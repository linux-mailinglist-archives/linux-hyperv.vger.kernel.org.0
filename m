Return-Path: <linux-hyperv+bounces-5532-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE6CABA013
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AC03AEE6A
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D7176AC5;
	Fri, 16 May 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcx4OFPk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4337D07D;
	Fri, 16 May 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409981; cv=none; b=DBMXxucmRdw3JGJWIFeyJ1uMLEmc5W054ZycD2fd3aLUcT1PlcNb4ublZrdWS+29ugLD69wjbbrI6vMj5kx3CPsqNJiPsvoXCWMxfikscK3CgRvKA4BRUDiLTYE4lB6vTmwEU4BVq657roiz5iiAAOxyrDDbFkA2Mm1WnO/SPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409981; c=relaxed/simple;
	bh=iDIsHC3y66fGc4LfQnJ5V8YU10/v+RufQGfi5233qK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhdLElMSYJGwfytFKSbK8hxh/9DIdL+C1zJTCXOUQiuUoTcC0LyESuG+1QzpT63hdbrjYt/laC8yxf/H6ETZ5OXtyXkuIaD4NWymCDMonERagRaDzyNzfHPvJssampEWk1Xp5O4D7TTnFQbhjUeaLpS4ROWSA/OqwcdUWNayTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcx4OFPk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22fac0694aaso17353645ad.1;
        Fri, 16 May 2025 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747409979; x=1748014779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGiKIF0HHFglk0sqGu0nqCpHZY3PnkC+CaBwFGqqE6U=;
        b=Hcx4OFPko8SNJpxyY+ohqjf2zLziqnoptyA9Pv7sWsx1xdvFYPz6oq4AcBK2Kf6mkI
         loOwYaRL3PQ3+jiUa+wHMU5yn3dM6Ym4Zqk98gSOVTbO6Su46RZD9JS6IE2ZTYHhD5CX
         Tu+fw9GcO5WndAVMKyjWLZck9JF7HaNGogstIiL3CbQ25gm0stWUlHVB6u7li1ziHZ0L
         nvYNkyLiWdyy4jUBJrMNv4BCN8RKRX6x12FzXAjgBXayKsGrAolW4eZbAHgXhO3quIaY
         DHmGOFVEbk46RnTHh7L9+BtKVDRtXXb8AtW6jDv9hmZdA8qsSasMPjIxcLvdjArb6gjt
         VVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409979; x=1748014779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGiKIF0HHFglk0sqGu0nqCpHZY3PnkC+CaBwFGqqE6U=;
        b=smDBi2ndSQj+vaiCBNtYbPwvw1+MXXHaJNCQUVl9It2kmXHOE4LBSB3kYmglDmQZPz
         2yi/x68dVIcrghwxHCRBXm8N2YfOe8gtnhP7lKxc8ONt9E3EjG+UxdDhsUuFyfXZBpR3
         gksmL/gQwC7/TlDeYpQ0pY2xHNTQ8Y+yyck5khWzOISAsBts8WfVxtBve6KkQ0wYiHDF
         daZdnOK0WjqwO6Aqge2fkmGWkkMi1/tZfk0qAwBNSCcg1mXuw+vZBF+ed+DSocYMuaoM
         VcyCzf5MR+3XUhx3jbUDvGQCCxW/yE17m9a8YuE6h+a5RA9Fwozzpyi/RvM1nc7eGEMI
         ELYw==
X-Forwarded-Encrypted: i=1; AJvYcCWKKfvu51y9t0WN2JWMSveTxlLbHTD7xTLoaCWceMnZ5NG0LlGou0Sg4qLIn74/aime9PRS6QzJWfoIdVnR@vger.kernel.org, AJvYcCXe77t9RI4Ak7Fki7t0dI1V6uTaquHx/DpNGNEKYwXjjSK7xWv23Mqu0Jd1ZcOdB1UL4rGxGuWg1OfaCY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebN0KBqCZZB7AcGSYDW11s96hVGWLB49vJolmomD0k3OEo4EG
	LacqdlepWobhoiDeOonLa91QVNt/irIXsIB2U/7McOQ82UQhpgkT4P6s380mv2/m6cMPfIZ5aTi
	Iis2gmOpMfVEeGvaSvACKlKw7XZFkCU4=
X-Gm-Gg: ASbGncu4FmeZuZJQstSkKBqTi7O63wvKSg72kFZiYluUytgIwr+sVZFJb1Vt3PFjpfK
	XgQl9x1XGXZm6opUxnDBTvbezPC1BgVp2XeWYH3ftk1FoL3QC3LT7BEtZ353pV6zql3xik7yVBh
	uhwgpKVJE6ZlKRjVyssx8W1HItANuUGzs96rnfeljDN+5xb5K+KGCY9IgadK7uSQ==
X-Google-Smtp-Source: AGHT+IHikhQn4nXRiXmVKBN2OJHB2bviiEdvoxOFs3NV3OqShuxi+7fYwGopfwwtrDxFnXLqd1EwiIscXVmZINnj/EI=
X-Received: by 2002:a17:902:dac5:b0:22e:4509:cb89 with SMTP id
 d9443c01a7336-231de21d4d5mr39699155ad.0.1747409979348; Fri, 16 May 2025
 08:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <20250506130712.156583-5-ltykernel@gmail.com>
 <SN6PR02MB41576BE5D8E86D8F3B75E11AD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41576BE5D8E86D8F3B75E11AD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 16 May 2025 23:39:02 +0800
X-Gm-Features: AX0GCFsGTo92A1phqftktV3NEJoSCxkf-iPtXI1gfVfFQ5yTZqIqxSsb7kTkcus
Message-ID: <CAMvTesA7LbQpqFA=K+romUaphUo23zPNvW-J2P4LmGiBGYZEfA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] x86/Hyper-V: Allow Hyper-V to inject Hyper-V vectors
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, 
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>, "kvijayab@amd.com" <kvijayab@amd.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"tiala@microsoft.com" <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:54=E2=80=AFAM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
> >
>
> Update Subject prefix to "x86/hyperv".
>
> > When Secure AVIC is enabled, call Secure AVIC
> > function to allow Hyper-V to inject REENLIGHTENMENT,
> > STIMER0 and CALLBACK vectors.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index ddeb40930bc8..d75df5c3965d 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -131,6 +131,18 @@ static int hv_cpu_init(unsigned int cpu)
> >               wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> >       }
> >
> > +     /* Allow Hyper-V vector to be injected from Hypervisor. */
> > +     if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT)
> > +             x2apic_savic_update_vector(cpu,
> > +                                        HYPERV_REENLIGHTENMENT_VECTOR,=
 true);
>
> This will allow Hyper-V to submit the re-enlightenment interrupt on
> any vCPU, even though the Linux guest has programmed the interrupt
> to only arrive to a particular vCPU.  That selected vCPU is set up in
> set_hv_tscchange_cb(), and maintained in clear_hv_tscchange_cb()
> and in hv_cpu_die(). I'm not super familiar with the re-enlightenment
> code, but I don't see a problem if Hyper-V sends the interrupt on an
> unexpected vCPU.  So it's probably OK to enable this interrupt vector
> on all vCPUs.
>
Yes, I will double check it. Thanks for suggestion..
--
Thanks
Tianyu Lan

