Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AC122E28
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2019 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfLQOKX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Dec 2019 09:10:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728853AbfLQOKW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Dec 2019 09:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576591820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+9uMkP5RS2E3iz9PV+jjXlyXbFKuV9GLhcKuu5FhcU=;
        b=bf+oLmaPduq6BxX6/NiRntDGm8D6SBf12z8x5EMb5bc72yb79/qeJ/hUlRWAI8BN1FoVTs
        nsN0hx5K6TF1sU334VzlvHwGw8aJsFR4L0TM5dJQqAB7yEx745BSpfyowbkCjcE7abuTks
        baqZBWbYRgbJ4PMuUCR5tRNO8mK1IOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-e-oSPvbxN62ZoThW5f_ciQ-1; Tue, 17 Dec 2019 09:10:19 -0500
X-MC-Unique: e-oSPvbxN62ZoThW5f_ciQ-1
Received: by mail-wm1-f72.google.com with SMTP id q26so600189wmq.8
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Dec 2019 06:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=l+9uMkP5RS2E3iz9PV+jjXlyXbFKuV9GLhcKuu5FhcU=;
        b=nNLKsLefjCxAoL0Rq900Zaj/HgGVbtBjP12h3s99cFH1ZLGzx0XWJbdg7ih4nouS3h
         9wd3TpxE1/tALl/vV+jb4BqG92bA0TuKh+R/Zsns5D2IBaNs7Wyh5wz5qqISMUKAFJ1n
         bU2IgHI03PmQUJmySZhcwuKsbjoLt4c+MuEcR99i3fFP9wszd5ZASm/h50XvLGBNhbj4
         LpNvUO5HgxsgkVe3i/cxJjN++cLjw4X9HNsJ80iLg/tGdKRIf3IJSGLjx6YCsUV0w+7R
         WVBRHEGYxaKfzPuD7VuGT2tOuAaSf4DbTtc1Q/+pnCkAKclzAzv5MinggO+ChHvcje/c
         ZHKA==
X-Gm-Message-State: APjAAAXBQ2Rgiyz1LV4AWVngB3zs23mpd2C2oNT0s9NOoSxqTHZoYZCB
        TsUXL11J5ZMZvKdnqWUXBaHV8yJNt6vQw4p85ttI2ahe5i/zAJmRDbL8oHXotejwYBI0Jab2XbP
        Ga4W0K6yfNNFwJr8EoPSJC3sJ
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr38825224wrp.314.1576591817700;
        Tue, 17 Dec 2019 06:10:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaELcthklaxQ6wLgDx/YlEXj3opzNJiBv6389QDhORMgwNtbPpUtXb75P8pH2ZWl6IiqNKdg==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr38825179wrp.314.1576591817477;
        Tue, 17 Dec 2019 06:10:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o194sm3248953wme.45.2019.12.17.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:10:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 6/6] arm64: hyperv: Enable vDSO
In-Reply-To: <20191216001922.23008-7-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com> <20191216001922.23008-7-boqun.feng@gmail.com>
Date:   Tue, 17 Dec 2019 15:10:16 +0100
Message-ID: <87y2vb82lz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:

> Similar to x86, add a new vclock_mode VCLOCK_HVCLOCK, and reuse the
> hv_read_tsc_page() for userspace to read tsc page clocksource.
>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/arm64/include/asm/clocksource.h       |  3 ++-
>  arch/arm64/include/asm/mshyperv.h          |  2 +-
>  arch/arm64/include/asm/vdso/gettimeofday.h | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
> index fbe80057468c..c6acd45fe748 100644
> --- a/arch/arm64/include/asm/clocksource.h
> +++ b/arch/arm64/include/asm/clocksource.h
> @@ -4,7 +4,8 @@
>  
>  #define VCLOCK_NONE	0	/* No vDSO clock available.		*/
>  #define VCLOCK_CNTVCT	1	/* vDSO should use cntvcnt		*/
> -#define VCLOCK_MAX	1
> +#define VCLOCK_HVCLOCK	2	/* vDSO should use vread_hvclock()	*/
> +#define VCLOCK_MAX	2
>  
>  struct arch_clocksource_data {
>  	int vclock_mode;
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index 0afb00e3501d..7c85dd816dca 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -90,7 +90,7 @@ extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
>  #define hv_set_reference_tsc(val) \
>  		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
>  #define hv_set_clocksource_vdso(val) \
> -		((val).archdata.vclock_mode = VCLOCK_NONE)
> +		((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  #define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> index e6e3fe0488c7..7e689b903f4d 100644
> --- a/arch/arm64/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> @@ -67,6 +67,20 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_HYPERV_TIMER
> +/* This will override the default hv_get_raw_timer() */
> +#define hv_get_raw_timer() __arch_counter_get_cntvct()
> +#include <clocksource/hyperv_timer.h>
> +
> +extern struct ms_hyperv_tsc_page
> +_hvclock_page __attribute__((visibility("hidden")));
> +
> +static u64 vread_hvclock(void)
> +{
> +	return hv_read_tsc_page(&_hvclock_page);
> +}
> +#endif

The function is almost the same on x86 (&_hvclock_page ->
&hvclock_page), would it maybe make sense to move this to arch neutral
clocksource/hyperv_timer.h?

> +
>  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
>  {
>  	u64 res;
> @@ -78,6 +92,11 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
>  	if (clock_mode == VCLOCK_NONE)
>  		return __VDSO_USE_SYSCALL;
>  
> +#ifdef CONFIG_HYPERV_TIMER
> +	if (likely(clock_mode == VCLOCK_HVCLOCK))
> +		return vread_hvclock();

I'm not sure likely() is justified here: it'll make ALL builds which
enable CONFIG_HYPERV_TIMER (e.g. distro kernels) to prefer
VCLOCK_HVCLOCK, even if the kernel is not running on Hyper-V.

> +#endif
> +
>  	/*
>  	 * This isb() is required to prevent that the counter value
>  	 * is speculated.

-- 
Vitaly

