Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7132B772
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Mar 2021 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbhCCLJc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360102AbhCBWQq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 17:16:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E41C061756
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Mar 2021 14:16:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66so4273256wmf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Mar 2021 14:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0KoC52/OhyByIZz76tXoXDzs+xfPJOsQW1wOukb2Dr0=;
        b=K2lY7I0r5hFw8DG5EJd659cbaFGi3SglYroCNRItp8E/06lbc+qlAasYJxwQD8sHVe
         CvBnAuIHv+P36EnJgWYWRjRH27OjVrWUvP9IABp+Ygt3KW2A+PwMHlTgsM6r+TOPY4KV
         W74IMOpEQFPtFsnK5+Td4UQTy9UO72izKfBdqzQnCdxUOtqrx3YAFUYTpz85KGQHTGMB
         iCqkOU/dQ7iTnYHqqSwqyeo7TixnuLN9YF8RIohP45X1z7kog0AqaDZ7rqadS8aa9AQ9
         mzM156Fa7oE5slhrysmBts0PwsivyFaJGkS+yq/yLFvHIRCwvaSHBwCfMvfaTVVjGlHO
         waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KoC52/OhyByIZz76tXoXDzs+xfPJOsQW1wOukb2Dr0=;
        b=p7ck4xCAW60VAyttD7n3+Z7T51jIkSiUhXxfpIpPmfGUREHEzVyD97Qgo/gkHUIG52
         h9iJC/sOA/YPYPKqbT9qTOJENm7itixcxv9DMAYPKzfIAUGaTrV+YnmxEeE6kj/2uyzn
         GCSG03eM+MiJBElwug45hMX4epESyYfjB/4iWmHBac4AshcOy5xQCCL5o7L039hWtAqm
         o62ADY+BeP5M6vM8cgdUcEl0wPM8JqOAnx+rN+IzdCxgZsy3NI/3ffV7PQ64cyNTtCpz
         MFvOR4GaS74fpsJY3OgUV3JTOBZ1iuJyTw4LdFHZxdCJmql3hhi+y9OMuYNKMdoZ7GTf
         a9tg==
X-Gm-Message-State: AOAM530s6X3qEUA28Q4jIFqL+1PO9UknbR4zTEARY7BxzOZX3rn4Th8O
        dpDlDt8adrm+5swv368lRXKsMw==
X-Google-Smtp-Source: ABdhPJz10wicz8sO2wh9H482rMWHdf3Ne7aJ3fWg/xXlXOxdwPzqDo/9psXXTFpJcsYWHB6SDSvc6g==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr6300509wmd.0.1614723329324;
        Tue, 02 Mar 2021 14:15:29 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id r10sm4943020wmh.45.2021.03.02.14.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:15:26 -0800 (PST)
Subject: Re: [PATCH v3 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
 <1614721102-2241-9-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85283676-a0aa-6934-116b-98f2c5dece9f@linaro.org>
Date:   Tue, 2 Mar 2021 23:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614721102-2241-9-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 02/03/2021 22:38, Michael Kelley wrote:
> While the Hyper-V Reference TSC code is architecture neutral, the
> pv_ops.time.sched_clock() function is implemented for x86/x64, but not
> for ARM64. Current code calls a utility function under arch/x86 (and
> coming, under arch/arm64) to handle the difference.
> 
> Change this approach to handle the difference inline based on whether
> GENERIC_SCHED_CLOCK is present.  The new approach removes code under
> arch/* since the difference is tied more to the specifics of the Linux
> implementation than to the architecture.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/x86/include/asm/mshyperv.h    | 11 -----------
>  drivers/clocksource/hyperv_timer.c | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 4f566db..5433312 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -29,17 +29,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  
>  #define hv_get_raw_timer() rdtsc_ordered()
>  
> -/*
> - * Reference to pv_ops must be inline so objtool
> - * detection of noinstr violations can work correctly.
> - */
> -static __always_inline void hv_setup_sched_clock(void *sched_clock)
> -{
> -#ifdef CONFIG_PARAVIRT
> -	pv_ops.time.sched_clock = sched_clock;
> -#endif
> -}
> -
>  void hyperv_vector_handler(struct pt_regs *regs);
>  
>  static inline void hv_enable_stimer0_percpu_irq(int irq) {}
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 06984fa..10eb5c6 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -423,6 +423,30 @@ static u64 notrace read_hv_sched_clock_msr(void)
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>  
> +/*
> + * Reference to pv_ops must be inline so objtool
> + * detection of noinstr violations can work correctly.
> + */
> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +	/*
> +	 * We're on an architecture with generic sched clock (not x86/x64).
> +	 * The Hyper-V sched clock read function returns nanoseconds, not
> +	 * the normal 100ns units of the Hyper-V synthetic clock.
> +	 */
> +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
> +}
> +#elif defined CONFIG_PARAVIRT
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +	/* We're on x86/x64 *and* using PV ops */
> +	pv_ops.time.sched_clock = sched_clock;
> +}
> +#else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
> +static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
> +#endif /* CONFIG_GENERIC_SCHED_CLOCK */
> +
>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	u64		tsc_msr;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
