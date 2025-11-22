Return-Path: <linux-hyperv+bounces-7779-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C3C7CBBB
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 10:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A363A349A18
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A22DD60F;
	Sat, 22 Nov 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP0YfPCq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBA86347
	for <linux-hyperv@vger.kernel.org>; Sat, 22 Nov 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804033; cv=none; b=mHOuJeoRrFVAsNyA6AHD6croc1khkIH8xQ+ZA76iCLpZHEVwqx2vIc+8QfcMY7ZfZFCGtqz1Vd5CCYj6EcoceKH9hekb8PzrasG7jqdl3DJ7nYMETrAwzkmXSxmleabmgnFRAhQYx6OMBMaCC0bdq9gppxDeiKK68qUSgPmuMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804033; c=relaxed/simple;
	bh=Yj/Uk2ipsatHobbsHL8YWMKKz7OZtA3uZOi+KMb9WQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMdHkRIhRG1tN2X2AgOcVEAdHZmqoD7PeG/nAhvJio04hkKFveUmYLdoxa1Cl434Z0oRUFZ2oCQ287hzCmW1CtSNDBmeJEE5t4ZW21GHXNTWCeUsseBmEdW3Wje7hzp7leoZYU9W5uHmKFrhQ23Ls4zTAOcFUp2skbdldkhVV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP0YfPCq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso22565731fa.1
        for <linux-hyperv@vger.kernel.org>; Sat, 22 Nov 2025 01:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763804030; x=1764408830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea6qfU3y4fIb6NWRtws/YG3BGg6e/z0cIFQ/9Whh1X8=;
        b=QP0YfPCqO84PvraoFoMH7+GLpGS0BtpRXT1IzDw8lHSZ/i0O/NfL8wGRiiEQqJZGZ0
         n7Tk5chzn7bu24Bfy1ldiHnSpzEgwg9Bo6yE/Zu9fEJ8mmI6ZqiV+Z1sFRPQ91DiUQFz
         9cjiGtSiUT+NGOS/VqgJ6jtnOcOm+2y6IAgjYN57j0i36iF3jv2ffEF+loxT6VnMg2YF
         OuWy0xPWfzeO+zwO1SU0vu8PAk/gkEgeP1MP+PBFK2+CulmVaoBtT2+7e8PzrKfPl1Fo
         uHrrAB1z2WYiu4Ed1Q4AMkyI3j6IgeDmdob4AZpcyJlXfIu7MDvXJnIyxpTi5bJV5fql
         OnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763804030; x=1764408830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ea6qfU3y4fIb6NWRtws/YG3BGg6e/z0cIFQ/9Whh1X8=;
        b=WVaehT0LZdVmFSv1mSM53B79MVaMJo9TzT+a8JO3wSzrH0crMOf8abuznCnYZIlYUK
         bkHRd2BadF/aExHr/e3qlG4SQvx3AdDhJTpHikyU7cHUGSzoGcu9fkfYJhAwqith734M
         oUX/SDuVdo5Ho+H3FYRVnJMgy05Tlyz9Y6BgjC9kZdJ/uYdFWrIMXi++JLSsYLbp3kWw
         VqURTT51lf07QYwsFIB1WJTvYk4njsausnv+EAgQ1QZ4o7jEQIQQJ9WoB+QEX9V6L4kD
         9gWjJ2/jqifeUL+Q1VYrrbhzAw5/F2+3nJBBOk0GPkJQtdf+7ykVC3PKJUGAunhKxTzL
         c10g==
X-Gm-Message-State: AOJu0Yxoq2iDYgjlXHRq/NG7qPu0PtMt117LafaZ2kJKTN7KcOjWReVR
	kvwLWd4aLyUpkn824eW0hvzRldCtCO6ABpxO/+MX2IIEHr2WVbKp3vXCiuEzi+u40rj+iLsRviL
	GAi7HcIWAcsBqPnc372X+p3jHxlLn7zE=
X-Gm-Gg: ASbGnctZx1wHN4fIv8T1XOoSALFfLZAqU/bR91Ty1o59YjJtQVRoP9fPzAXuK9OU2jz
	JpOBUtnFvE1ChlU7Qtm33DdXCvM9+zNzXLEOJuCDSr7Mp5MEH0gpLUZM6I0VVdhcISsziYVbaI5
	bn6YUiX/Ioh099xuWhNuIUj4sl39P7CuGA3R8qL2JbbmjGjx0lhRWIjdGSpzptYjNcYvwd+oLDA
	qsjvRmFEE98esfQ3f6Loe6QGwIHChLw9iRKiqzCu5I4UckEu8p6welQ8vNvySkjhyXMiDz7zabM
	hHI=
X-Google-Smtp-Source: AGHT+IHN96XmoisjYbLYgpjyL2cwxLjzJLLXdmNH/uEakUgTy8mCd49I1d4zkUP6wWPYOGfZswNz2D7zTdgxDN/8d5U=
X-Received: by 2002:a05:651c:f09:b0:37b:9bfb:90a6 with SMTP id
 38308e7fff4ca-37cd91ca671mr16867191fa.10.1763804029667; Sat, 22 Nov 2025
 01:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121141437.205481-1-ubizjak@gmail.com> <20251121141437.205481-3-ubizjak@gmail.com>
 <8F5147DF-E0E2-4942-99D9-4242F3013635@zytor.com>
In-Reply-To: <8F5147DF-E0E2-4942-99D9-4242F3013635@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 22 Nov 2025 10:33:47 +0100
X-Gm-Features: AWmQ_bnjMiahRD9ERcAJ_RLwrHshlYYFhPLbAcLKVFBFyIXWi4uD7K6ngbjQJWE
Message-ID: <CAFULd4ZaRGENKVYXZiaPO0heT+1bpGrVBGzA+Wz9VS1NG6trAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/hyperv: Remove ASM_CALL_CONSTRAINT with
 VMMCALL insn
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 1:06=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On November 21, 2025 6:14:11 AM PST, Uros Bizjak <ubizjak@gmail.com> wrot=
e:
> >Unlike CALL instruction, VMMCALL does not push to the stack, so it's
> >OK to allow the compiler to insert it before the frame pointer gets
> >set up by the containing function. ASM_CALL_CONSTRAINT is for CALLs
> >that must be inserted after the frame pointer is set up, so it is
> >over-constraining here and can be removed.
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Tested-by: Michael Kelley <mhklinux@outlook.com>
> >Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> >Cc: Haiyang Zhang <haiyangz@microsoft.com>
> >Cc: Wei Liu <wei.liu@kernel.org>
> >Cc: Dexuan Cui <decui@microsoft.com>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >---
> >v2: Expand commit message and include ASM_CALL_CONSTRAINT explanation
> >---
> > arch/x86/hyperv/ivm.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> >index 7365d8f43181..be7fad43a88d 100644
> >--- a/arch/x86/hyperv/ivm.c
> >+++ b/arch/x86/hyperv/ivm.c
> >@@ -392,7 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 param1, u64 pa=
ram2)
> >
> >       register u64 __r8 asm("r8") =3D param2;
> >       asm volatile("vmmcall"
> >-                   : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> >+                   : "=3Da" (hv_status),
> >                      "+c" (control), "+d" (param1), "+r" (__r8)
> >                    : : "cc", "memory", "r9", "r10", "r11");
> >
>
> I think it would be good to have a comment at the point where ASM_CALL_CO=
NSTRAINT is defined explaining its proper use.
>
> Specifically, instructions like syscall, vmcall, vmfunc, vmmcall, int xx =
and VM-specific escape instructions are not "calls" because they either don=
't modify the stack or create an exception frame (kernel) or signal frame (=
user space) which is completely special.

The existing comment already mentions CALL instruction only:

/*
 * This output constraint should be used for any inline asm which has a "ca=
ll"
 * instruction.  Otherwise the asm may be inserted before the frame pointer
 * gets set up by the containing function.  If you forget to do this, objto=
ol
 * may print a "call without frame pointer save/setup" warning.
 */

Uros.

