Return-Path: <linux-hyperv+bounces-5533-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A0ABA051
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B311BA6FC1
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D71632DD;
	Fri, 16 May 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkfnpN2P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41386359;
	Fri, 16 May 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410852; cv=none; b=POHZU3Qr1iADquDerVW3tBRctXt3nQS9Vi8BaetFvmhZeBQrqaX4p1KeZmG86kPRp3sQ3btJdoSvJ/cOtqoZ+7KqEtCGmGDDtymdoeCUOV5J/5v95nBSkefVFJP0TJzO0tjKeQqbdOsR1wUg45zqoixuteVw4ljeQgsCpSXhWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410852; c=relaxed/simple;
	bh=D4iYYT0X40KZcO9JmEZKyAItgljn44Gvvk7FEmk9F7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtfUQWblrmX+N+r8ulkMs308IOP+C4HrPKZ22VOlX6InvDyAadCd+nc/ihqTyJqrF4UGmzfJZmIPROg7GL3cl2kPHrbTXlVjPYU1wMoBYyE+qZ+YHoU0V5rID3nkVF07EXaDlr4ZdLaHx8rON8mt0o5Sc/oxekjmi5oBGVqsLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkfnpN2P; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ecd4f2a5so5918435ad.0;
        Fri, 16 May 2025 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747410850; x=1748015650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnwing6EPkTIf4TgTw+aRTggKpgaJ9sx4x1j/r+rC2U=;
        b=fkfnpN2PeUWKYO7O/WuOQchnX7EFdpX1MpdxZ1fEfxQP11dQQWjLQniqOE5GowtqhF
         Ndj3GyAiznzFmgnUR3RyXQD9WMiQNQNCaavDjWckZ6y2g+j6ZfdRYSomrPa22xDzJHTi
         Lbv/KSIrZMQjetBC/zPzSr/B/mi8YDMtx39B7sf8mm96yJw9q23wWSX/aMCukBDm0sNI
         TbtEg3fsFWhEqE11MQz9cgjHZQTJXF6DIZqAMHQsMl9t/gwOWUhO2q3eqpFqqH1Bgf/n
         VIGQOwjrGZHSr7UxlnZkc2/PUu/f0Hgiyyx0rNAJdK1I01yXn8lVyLZMQLl3kgaEWAm4
         JmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410850; x=1748015650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnwing6EPkTIf4TgTw+aRTggKpgaJ9sx4x1j/r+rC2U=;
        b=aQA+850i4dL43hQ3mdWSyWNBJbAcl/4JqSxkwAXQ7mU0OEFD/IsdYDY78yngoiZTx3
         B31d9LivF1wStfqJjwHhKl1eOOHBQxcexDGoXdWChgeDr95ptLNanMRD3h98Yc/cfqlY
         JZ8BYMZzOXFc6hN/3n7xGz3cLoGAlY1r38t37klObPtG66XPAA0dH08IVITmydYunDdG
         Vh64Qhx3DMf1ey1tWIXR6IT+2CzPpukpRYw6JVi3Joy6jatLNB0VUH0WwMFJvIBfxc57
         kJMqriEFn0i4RZeu0PxM/Qn4DdTgORcK8CgW4pmhPmmjHTQOpq+8+J5JH8HEuxo952pM
         4UGA==
X-Forwarded-Encrypted: i=1; AJvYcCUe8QG0WjjEJ3c9+h6q1vEpCbo4REkFbVJyLCXCdvZOcnPpzXtoh+VO6UptDFhA4iQxgvGa1aqMXT4xxfQ=@vger.kernel.org, AJvYcCVTYCHz02a6tlsC4TLdUz0NmbyWD4pmPb1wE+B+CLQYKjGJuVO5d0kNM0h6xWQEl0oDaqStS2lu/VDOOIGi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyae1G3atuAsbySW5N08NJRmGf5TtzAr+gTpHdSSwoODeoEesMM
	/XwXKDh4cpjJi6OfQ/JXA4YAgSoZ+H67Zpal4wEqaUnfLAcGVgeJVe4lBspNNcnM3oie+ZHCEQl
	98GqUVOSZePwCidwyIVCOgySosG8jVZg=
X-Gm-Gg: ASbGncuvHuft4QMpZVnQ0Sqa6SH8GpOfz4yYVuIzI02jPv7BbBBai4GRerxD7BEeMvE
	UMhngvvLf+uGZ5Jbu8ZbCz6YiYb084pjs2Ah8T22CLUy96LK39Su/FnE2kgbSAyFiQKer0Ybqe2
	iBczO7VHQi6Gt1eS3DLZ84FfjoWIDA+BBslqcx1zDTDLv7kToYlYA=
X-Google-Smtp-Source: AGHT+IH56Ikf/9K4NnW9SrqyUdDE3HTfAb8ndmxtarVhQeYv/CxYSytZQcpkOIliYyjxJ7hpHtVS89/nDBbpWZq9ZQo=
X-Received: by 2002:a17:902:c411:b0:231:d072:1ecf with SMTP id
 d9443c01a7336-231de3429b6mr45930805ad.29.1747410850000; Fri, 16 May 2025
 08:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <20250506130712.156583-6-ltykernel@gmail.com>
 <SN6PR02MB41578854FF8D79504DB847A0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41578854FF8D79504DB847A0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 16 May 2025 23:53:32 +0800
X-Gm-Features: AX0GCFsxaFmWm5CjNF2sgAAeEQ2eTh1C6qMtfa02LOx3G50qDNd4zteBHJ0Nr5w
Message-ID: <CAMvTesAmvVCQn47ZV+k9r0qNape_5zcCJ_Fwj+kXNi-Rby_U7A@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
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
> For the patch Subject, use:
>
> x86/hyperv: Don't use auto-EOI when Secure AVIC is available
>
> > Hyper-V doesn't support auto-eoi with Secure AVIC.
> > So Enable HV_DEPRECATING_AEOI_RECOMMENDED flag
>
> s/Enable/enable/
> > to force to write eoi register after handling interrupt.
>
> "to force writing the EOI register after handling an interrupt."
>
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyp=
erv.c
> > index 3e2533954675..fbe45b5e9790 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -463,6 +463,9 @@ static void __init ms_hyperv_init_platform(void)
> >
> >       hv_identify_partition_type();
> >
> > +     if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> > +             ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
> > +
>
> Shouldn't Hyper-V already be setting this flag if it is offering Secure A=
VIC
> to guests? I guess it doesn't hurt to do this in the Linux code, but it s=
eems
> like it should be Hyper-V's responsibility.
>

OK. I will double check from OpenHCL side.



--=20
Thanks
Tianyu Lan

