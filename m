Return-Path: <linux-hyperv+bounces-5534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B946AABA084
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25677B0869
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 May 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4387C1DF756;
	Fri, 16 May 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSrrW3t8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB41DF247;
	Fri, 16 May 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411140; cv=none; b=tFs7aBluy1R2vta640FhwtNIUQh6moei0vy62KD0bDZYfHd5Hb9R7kTUiOV0fmra1+GS4bHBwEb6r5nMkF+vwhhAi5UTIan6DT9vFVxCukB9Oa1dOaUAGtjmCQdtDUcod+0VGJYmhO3XGShEGdpCYys8eZ/I/7PNGzHd9/TTIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411140; c=relaxed/simple;
	bh=krG3ZQ/kFm6Nmu9+FVKfHwTUMG9LfWCQ5Jk5oi6Ls7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFSnncQZ7KW+knMTO/cmUl+qPdsRa0GhEbEvZ3ss0Fd5wRX3JqA14cpsJfR3/cK2rVForOhdgBHxFtWx3w3cgHuDTXStFuB31gsjcS3CRI3OQ/BwZiK2hQZrObd/6RBjLLQxRbPLNdmwq27LE1FR0eL5ujl6VDalw2xVOEBHB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSrrW3t8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b074d908e56so1480630a12.2;
        Fri, 16 May 2025 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747411138; x=1748015938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsoEPEmI5AxdSVlymUHhTpkf03lOfLnTmC2m6qhHMYY=;
        b=VSrrW3t8B0edHgaciKM9vc6oWg51qQXfOyEP890MiUYwjsz2csQOO+BzkZvIlfEd3T
         Vfo0khFKU9PEa2XWK2p43+l2Nn7L8kqjzFHYcxtlwzCI3+vIAOqujrfF9usPcUKkuc8Z
         L/7A6tQW59TL2DN4W5Ys+iAgpTUTpVLIBm4xYQgfAVANmVdVIy57QdTpZ8PWJGCB9jNJ
         PZPQcPJDhEdGE3VJj17fzHui7pjTTQOHjljxM8nYD9aBOZy06NiSmcLJNJIzBY+i6It/
         LqZfv/oloGn0Kc+sP5SeqDkuZ2FYRnuWP9h+tPFq/SbRgZvjPQTal38XdYGLWiN1r2s3
         1o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411138; x=1748015938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsoEPEmI5AxdSVlymUHhTpkf03lOfLnTmC2m6qhHMYY=;
        b=joFiWJ0jOYXpt4tlnmd7/Mt35IYGJB4WSKqFCa0XqsPFsslbFXmatvuPZI+R6OZdDI
         EfDGNuo3h6axkDo8jayHhPX3GCdOsLs7z2p+/1tO6VXmBleY0/4vXwuB4qCzzsIbXau0
         EyaaB8ybWoh2Eq+LZOiP4sK6bQc2XbJvBgKAz44uReHDqLebhw0CYbp5XjDPj0Fg7LR7
         kIbgD2jPTfrax5r13w5P+z7SX3qM+E2LLkeScPKgYv9ZUeYQFyT3On5+qwWfodSP9jnF
         pec1G2rsWj2MEcS5op3aW9gGbqtwJstI9mjdM4eeZmxjfOKIRloogl+ed/t/L5S+OlQ4
         dGpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Js4LJwqRJ/smR27Wh9aXLAjfTBYoyWKeykRqC9g1/p+meh2Y7zj+phVuD14a6RwAkL7q3XV3+MfvuYQ=@vger.kernel.org, AJvYcCV614BM7J6cGZ2Qr04gwblqjGM+Ywk/QgTMYEOscZmbz8BNi8oD2YI5V0Vs3wJNXaKICfTe+uJ+rTjZfMZ5@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9i/66R2mEq3+MCVlr4x6OqgEc0oYMucnD59nAxaaaKRvfepe
	0f2O8u3itxOg5J4jQwdZquZZSIYk0Qqn4S5K6XicfRVIXRBazpLi7hRUdALpH7SHg3BEj0OpiYH
	HolKtR/0uY3zBaaU+7QFYBF3I8PWvhpZrZJKlj8U=
X-Gm-Gg: ASbGncu3aCdAJkvpXeEVfoQyzdk5p+a79h3N76Mdl4rcPeWRxMCfkB6hUkiiNFcUdbg
	TKBlfW1eTLlo/SjGthbvjZTpRrxpyr/MYpN3HrQNVLVbU2thPKhZ188Mjsx2wFMYc1oW2RkCc2g
	/K5D7pLukDSzJflZW8a3Ah/8pEBBc2Xo1THpMsVYCqKYkhmNcHJJY=
X-Google-Smtp-Source: AGHT+IGX2ZYc0fawgiD3hSuSC1/mCQUoY3YG7H0jn6I9liC4deGrhqTA3gLS8yyKS30ECavj0xZHIwAYl0v9wMd6fYw=
X-Received: by 2002:a17:902:fc46:b0:231:c2ea:f0c0 with SMTP id
 d9443c01a7336-231de37016cmr41010465ad.42.1747411137831; Fri, 16 May 2025
 08:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <20250506130712.156583-7-ltykernel@gmail.com>
 <d1dbeac3-42d1-4ca7-a8cf-8d3b27176a98@amd.com>
In-Reply-To: <d1dbeac3-42d1-4ca7-a8cf-8d3b27176a98@amd.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 16 May 2025 23:58:21 +0800
X-Gm-Features: AX0GCFuBT4Y90vrthBeuKR-2VOmNlQJ7eh4EcZ9fq2VFohQNha0_DwTC-NScPe4
Message-ID: <CAMvTesA4A+ErFf+RoDJGrHVfkXOTgeZ0qw_5CRT47UbLJ-2Z0g@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] x86/x2apic-savic: Not set APIC backing page if
 Secure AVIC is not enabled.
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	yuehaibing@huawei.com, jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org, 
	tiala@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 12:03=E2=80=AFPM Neeraj Upadhyay <Neeraj.Upadhyay@am=
d.com> wrote:
>
>
>
> On 5/6/2025 6:37 PM, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> >
> > When Secure AVIC is not enabled, init_apic_page()
> > should return directly.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  arch/x86/kernel/apic/x2apic_savic.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic=
/x2apic_savic.c
> > index 0dd7e39931b0..fb09c0f9e276 100644
> > --- a/arch/x86/kernel/apic/x2apic_savic.c
> > +++ b/arch/x86/kernel/apic/x2apic_savic.c
> > @@ -333,6 +333,9 @@ static void init_apic_page(void)
> >  {
> >       u32 apic_id;
> >
> > +     if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> > +             return;
> > +
> >       /*
>
> Why is this change needed? init_apic_page() is only called from Secure AV=
IC driver's
> setup() callback. savic_probe() already does this check. So, if this chec=
k fails during
> savic_probe(), Secure AVIC apic driver won't be selected as apic driver a=
nd it's setup
> callback will never get invoked.
>
>
Hi Neeraj:
       Thanks for your review. Agree. Will remove it.


--
Thanks
Tianyu Lan

