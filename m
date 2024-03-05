Return-Path: <linux-hyperv+bounces-1664-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6A872901
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 21:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93D51F2B825
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4B12BF10;
	Tue,  5 Mar 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VItnTInX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902412BEBB
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Mar 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672299; cv=none; b=kD7gUlsjd3MsIBI/a+OtYWhpqBpbZQiFAkFVQLDq3iIyBmpNhnxWq7XI0uPP44RxxKN0SKFcwHWzZn0UaigJrftngR1UMo0T8XvF4BfW2wb3WES+Cp8eU0Xt1jpaE0obwYEhWafxqGZjqUTPUW1DrETggriNb3Tz9BACSEAo01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672299; c=relaxed/simple;
	bh=hz+ZxSOYv8PxZNrsTqx4IxtCpcRrFHGU/VQIYl36LGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULMtDMQA8wcsirMQU6WGiBMtZXwOJ/Er6JpkYypoigWwG6rIFi2Zj4AtaFTnNkTnsqtN1JBMoNenwUXTTs8a3yd4YrZ2vK4ViGpRAAwtZ50gHMxZwOlZCDfRkiEObccxfRcVUj1Fp5TLfUipbcgc79U+wp44eNoWAsUakcBc3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VItnTInX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so75821cf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Mar 2024 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672297; x=1710277097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM9bu0HcRSpvQ/lk6AsEXTNfL1CGnBbQK/LGwtIb+y4=;
        b=VItnTInX7KAkkHOMp2ynIn3AlD2CYHHFuIraqXwe9THhasvj/qOOkonyVAxlRjOTWO
         kPo8lezaR4nNpxQJfm6V4lsF68/BZH2fvpVfYyaXLccHLrbh+4MievBbhCLPf508tC2R
         ZY+RuPcM+MhOetVT04AzXndvmTqnxvlWkNOKceGo6o+gTFbn0kB6Gs/VIRXG29TB7tsK
         lW3FcunEAG/JJrDbd5B4fhdZBjc7bQSxKvqE7kGC55M4wdpEQZgfEHGhnzOBgmVV2tVC
         chFM5sxG7LVxwOm4ONNVpchwCiDfe14GHs/s1MzYCG54VSk1Pc4Oa0EsDKwAnk0Wppkn
         AKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672297; x=1710277097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM9bu0HcRSpvQ/lk6AsEXTNfL1CGnBbQK/LGwtIb+y4=;
        b=VLHCjTeSXlLBafMPIdvKymdvUUBS95Sa3LxdfIy/vFLu1fPa7k2opvEU6/cfaZwk1C
         IKl/trVN0uXUq9RGyR8FeUplx8Wk2pR5mTPZWojLk4ikWF+ghW7L1PKxfy0+AB+uPYtt
         uKCEe8QIbC1NFdl0/PiFIZ+TO+Ukhet9RT3OR6lWuzjksaYxknl1Tn6HGw/a2F0KbOKW
         sCQQ9Deip1dB+GuQvXuzXYlb7RvBDwttUjdy2BTUz/bwx9N5O6iwADW9VDcHbF2U/MM9
         8d3BTar9if7DWz9dDs9fSPPItrb59AYg0+7hzqrijyi/MHUHuP6Wk+mKL6+G2O5N4Ofu
         iBwg==
X-Forwarded-Encrypted: i=1; AJvYcCWw0xqBSOoE/qsfX5MFJgYtXmeGDUX45aT1fw1oP6Bz+rXnn+1TguuumjlYelucUlkg8tft47XYDzYCS5gs2k8/ZbJwZ3sgZAVJ/HSP
X-Gm-Message-State: AOJu0Yzbh0pdKH5ord1YXyJv1VLFId++DCzEW6pFwVSEz0AwqvpA/DLn
	hoBO5uQ8RA4QD+49tsDbd9GPHJafbHc1NGIHelbJl4Kjv2d+UrTAPZM7QOreilY124zd80qwjET
	qWx9tbaZXhIENDrCcRmReQKb3qHuQEwAFs0N+
X-Google-Smtp-Source: AGHT+IGJuhFV2CSZhTpphuYInlBxp0BhTfrnQUeh2OvKsSqzEL4tX1NuAVfzJjBoxId+yPuVZh+Ut8IQpuDDq6mQdxI=
X-Received: by 2002:ac8:59d5:0:b0:42f:a3c:2d4c with SMTP id
 f21-20020ac859d5000000b0042f0a3c2d4cmr72229qtf.13.1709672297226; Tue, 05 Mar
 2024 12:58:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-4-mic@digikod.net>
In-Reply-To: <20240301194037.532117-4-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:58:05 -0500
Message-ID: <CA+GJov4BPGuuu+oivgX3Z0J8sb1bYLhrNRrex7qza45WNMtBcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Fix timeout message
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> The exit code is always checked, so let's properly handle the -ETIMEDOUT
> error code.

Hello!

This change looks good to me. Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-4-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 73f5007f20ea..cab8b24b5d5a 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -79,7 +79,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
> -               kunit_err(test, "try timed out\n");
>                 try_catch->try_result =3D -ETIMEDOUT;
>                 kthread_stop(task_struct);
>         }
> @@ -94,6 +93,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
>                 kunit_err(test, "wake_up_process() was never called\n");
> +       else if (exit_code =3D=3D -ETIMEDOUT)
> +               kunit_err(test, "try timed out\n");
>         else if (exit_code)
>                 kunit_err(test, "Unknown error: %d\n", exit_code);
>
> --
> 2.44.0
>

