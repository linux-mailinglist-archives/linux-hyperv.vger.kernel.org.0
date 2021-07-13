Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C513C70EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhGMNHk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 09:07:40 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34471 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhGMNHk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 09:07:40 -0400
Received: by mail-wr1-f49.google.com with SMTP id p8so30370727wrr.1;
        Tue, 13 Jul 2021 06:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMwcKZl2eGecVWJGoui9ncs6auLmuusIIosF9nJ4JOY=;
        b=FJ0aoAeMUqVa6Cpknnf3emtIUZDjIUvai/fLGYRJEnmGX/jI5e29E7lVQA+FUUW7Pb
         LqPz2F9EyYdSmhGXmSzM7Zuh88D8jt1xvTRwrB4lr3bJtHrCQ2c5SEudPjDC1qB50M2b
         Xvn8C9ixbgDLZrIg8VaEPZgoUffwxkcgRJtBiWTg5dObh7Mc6tzXB7Z7z3sMk+TGYhJQ
         bccmtCjdY/7wmzjbP7HN71w40PBi9516o0RmY98fMvH6GfxNH5P4SI5/ytbwNCldsa1p
         cw+nTrZbkqnO2ivgDsIziCut9UgcHin8Lv5DovUMRqioF9em0vDtNUvryVyxxsf9Cry7
         uxdA==
X-Gm-Message-State: AOAM530kRdu1DD9uINUKJla+kdC3MkQsy6pmR5/GC1UMIlbjCSIgzGrH
        Y0/ZYP9CSguthscRg7WfpmQ=
X-Google-Smtp-Source: ABdhPJwB5m+Kje6LulbZ0ZYa2TIEKxQ5iNLKohSNmZom8MTPM3lD+z15LR5z06jBORKccvUbJc8v6w==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr5529925wrn.138.1626181489176;
        Tue, 13 Jul 2021 06:04:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e15sm17621509wrp.29.2021.07.13.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 06:04:48 -0700 (PDT)
Date:   Tue, 13 Jul 2021 13:04:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        mikelley@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Message-ID: <20210713130446.gt7k3cwlmhsxtltw@liuwe-devbox-debian-v2>
References: <20210713030522.1714803-1-ani@anisinha.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713030522.1714803-1-ani@anisinha.ca>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 08:35:21AM +0530, Ani Sinha wrote:
> Marking TSC as unstable has a side effect of marking sched_clock as
> unstable when TSC is still being used as the sched_clock. This is not
> desirable. Hyper-V ultimately uses a paravirtualized clock source that
> provides a stable scheduler clock even on systems without TscInvariant
> CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> scheduler clock has been changed to the paravirtualized clocksource. This
> will prevent any unwanted manipulation of the sched_clock. Only TSC will
> be correctly marked as unstable.

Correct me if I'm wrong, what you're trying to address is that
sched_clock remains marked as unstable even after Linux has switched to
a stable clock source.

I think a better approach will be to mark the sched_clock as stable when
we switch to the paravirtualized clock source.

See hyperv_timer.c:hv_setup_sched_clock.

Wei.

> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 22f13343b5da..715458b7729a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -	} else {
> -		mark_tsc_unstable("running on Hyper-V");
>  	}
>  
>  	/*
> @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
>  #endif
> +	/* TSC should be marked as unstable only after Hyper-V
> +	 * clocksource has been initialized. This ensures that the
> +	 * stability of the sched_clock is not altered.
> +	 */
> +	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +		mark_tsc_unstable("running on Hyper-V");
>  }
>  
>  static bool __init ms_hyperv_x2apic_available(void)
> -- 
> 2.25.1
> 
