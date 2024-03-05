Return-Path: <linux-hyperv+bounces-1663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24238872900
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 21:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A794928DD91
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20112C80B;
	Tue,  5 Mar 2024 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITZvfUJr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655912A16C
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Mar 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672287; cv=none; b=r66xaoZP/CV/RkK2vwKeDz+0YzxbnL6fSakRZnRR84gqCVHEbdFthGeCtvKNod2HXiaPwhpONbWuGEa+AQr2QXro9Hjahbq1gzfYT0vtldlybn0XgQk5yyNpwLgQ8uzBT7sqCQWlzhzgljofzBNP1hfjnhBKOBLpFZ7oz+oE2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672287; c=relaxed/simple;
	bh=wWG/Kgy0jS1x5qSuFdcHkkq/gavTMiUaXVlXVaHjyIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqKQqt43uuSUEVqABm2Wmf9HME0lDQp47emzXxJJV9li/Oj4JTeLCAwTi9mKAJtDCxS1q0giupRvtg/hJ7YyIlyqCZnnsusscJdUKHg2FOFPn0p4pLW+c+W+TZZcBSqDMHO19gSOrcN186Pn1yHev2/1Gn/yrFVgi8/cl0RLu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITZvfUJr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ef8193ae6so82061cf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Mar 2024 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672283; x=1710277083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=ITZvfUJraFd5Y8WZ0O2trYqgAs5xl8lqnJTECVALowK09cCrh1igdXQpaDBOzvMoRO
         WcPIibKjwXXeq2m7cWRpDwuqTveNL+JZtgBDSBpxVbxOO1BPPCUqn+hSYPjBlIOyCEfJ
         SgG1wfga3dAyR/5yP/Kzq/i9Vpjfn+EFwz1Qa1bFTUMsvvWQROxj8bpVBrIwgOGjxuak
         WvN275O+tmeQOvxrJGgxdUPdbMcR/J7E82VV7c88yAcfDf1TvFwclC9ExtoewAqD/pa9
         uvbPaFoekaJDVNQGCW7vOaJUqI0UrqcOiNzb7oUBaIYJ0jCyZ91IbXMfEtYQietkumQV
         q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672283; x=1710277083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=wb3rmtbwGN6uAhLlI9OsLaTVOq+Y3T7WVk9sQps+sbBKDr0QdcFizFr68PUvICG2sM
         pSyYDhnwT8rVF17OO70HJyKpFz634bwaoKlL2PKrYBneLEvdz6r2R3ZbP6b1KBkfeb3t
         F8t/4AaQebi+zBJxWLVD/0H86d4k5mAGCjG2G7ZD6oMKz8VLu86o3TZp66Pr3o/VYO0j
         T8ydmZJutZJW1S8hVahSZ+TLZkswxMkfb8sNd0hWf/DhcJMuS6TN9FJja5hMsr8MHgZZ
         7+KGuyOoaAzhFkeIWFRo45hAIxIr0uqpK7dgiw8QE16VxfHhCQ5Ba8N9pgfF7a0gJUDU
         uTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjvZNcc2MyfcqANRty6ngIFCY2SthHRyXASuTyABqDUypzDRDpkOC86T044dA3juhc42QtJjPe6Vb6bZ9PxNw0MmWoGVXssPqpG1xP
X-Gm-Message-State: AOJu0YywtBDGzFIbDh4TNPiLMFNVPRcpbqAlyofpnJPZQJqAD+YY9mSq
	sDspYM+7irjGcZkEFk5Qa0wpsL8U0fYld9eD3RrJiALSiWw3xQYoJxJ0AeEoOpav1u5eWqLpOE8
	7/An5nRR4N2joLrXmZdxOOiN5q1cXvbgToH/I
X-Google-Smtp-Source: AGHT+IHGajjUdBLk7kb5aU5IzN9BFfXaz7kyHr0r9Hfw9dnJJ6/Mro4cDB9qMZ+LQnnYDduac+wAa+5vLvNmFAFMPZ8=
X-Received: by 2002:a05:622a:489:b0:42e:ef12:8025 with SMTP id
 p9-20020a05622a048900b0042eef128025mr263015qtx.25.1709672283186; Tue, 05 Mar
 2024 12:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-3-mic@digikod.net>
In-Reply-To: <20240301194037.532117-3-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:51 -0500
Message-ID: <CA+GJov46__vOS9m7Jz9tw+nxd1LFh_a=g1SR=BjUzR9HT65Vew@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kunit: Fix kthread reference
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
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.

Hello!

I have tested this patch and it looks good to me.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>




>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-3-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index a5cb2ef70a25..73f5007f20ea 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,6 +11,7 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/sched/task.h>
>
>  #include "try-catch-impl.h"
>
> @@ -65,14 +66,15 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>         try_catch->context =3D context;
>         try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
> -       task_struct =3D kthread_run(kunit_generic_run_threadfn_adapter,
> -                                 try_catch,
> -                                 "kunit_try_catch_thread");
> +       task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
> +                                    try_catch, "kunit_try_catch_thread")=
;
>         if (IS_ERR(task_struct)) {
>                 try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> +       get_task_struct(task_struct);
> +       wake_up_process(task_struct);
>
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
> @@ -82,6 +84,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 kthread_stop(task_struct);
>         }
>
> +       put_task_struct(task_struct);
>         exit_code =3D try_catch->try_result;
>
>         if (!exit_code)
> --
> 2.44.0
>

