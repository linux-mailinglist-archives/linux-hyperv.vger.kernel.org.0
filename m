Return-Path: <linux-hyperv+bounces-2459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8126911204
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88568285B3B
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D61B47BA;
	Thu, 20 Jun 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HFoeBB5g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039F22EED;
	Thu, 20 Jun 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911388; cv=none; b=I0Hg/uE+Fq4nU4Wh6DGF8AOyMcQvVScKHuVYOm11T3iGJ7GeaOEt8BuLbGU8U+J0AE1HhsdqUgZbbs/OneKdF5bHz4feGiUx37PZIQXM9fi/GfZdVK6LSD5EBRAFS/Ly+3zbN1AYn0p36FemmwZLwiFYkRli61Rdwbm71CsRXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911388; c=relaxed/simple;
	bh=eCMeN0lzP9UrNuCqV1ZUPlK/kylfQtBMoQitfd2StEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MY0dzFy/+NKqnpOFjIgCkJo5tQ62454aY3KLabv6MtqrmVNz+P4HqOilML/m156Qo5Ebz0912SoliglvzNhZZk0/7MVgYDg6CFsPMEaa7Ff++vzzmHV8xVr9fC4akEiVL0BOeIBONrCvDcoDpoul0q9zZZRzbCKtBpMlHR3mdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HFoeBB5g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7CB4820B7004;
	Thu, 20 Jun 2024 12:23:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CB4820B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718911386;
	bh=VnHT0brBrdifbJ8+mZwZG6m8zfp7b8yTRmWCV073osI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFoeBB5gWFzriPUx6xUfOnLsQp1SheK3ziWa/tKzSJUUEVOUJd5CPp494VhSQzrd2
	 wuwUVA6hrCT0b2rfagoubPI6/uY0sifbenRqgzK2QQtUmcj2+dDG/43GRpDUxIAEkV
	 fVqMZMOsGH3HKSggFYXc/mqR+frM4fMFR6uxsR+Y=
Message-ID: <d0382b2a-2d8f-45f3-a29b-0bd49103a182@linux.microsoft.com>
Date: Thu, 20 Jun 2024 12:23:06 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without
 paravisor
To: Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org
References: <20240619002504.3652-1-decui@microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240619002504.3652-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/2024 5:25 PM, Dexuan Cui wrote:
> In a TDX VM without paravisor, currently the default timer is the Hyper-V
> timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TSC
> page is not enabled in such a VM because the VM uses Invariant TSC as a
> better clocksource and it's challenging to mark the Hyper-V TSC page shared
> in very early boot.
> 
> Lower the rating of the Hyper-V timer so the local APIC timer becomes the
> the default timer in such a VM. This change should cause no perceivable
> performance difference.
> 
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
>   drivers/clocksource/hyperv_timer.c | 16 +++++++++++++++-
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e0fd57a8ba840..745af47ca0459 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -449,9 +449,13 @@ static void __init ms_hyperv_init_platform(void)
>   			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
>   
>   			if (!ms_hyperv.paravisor_present) {
> -				/* To be supported: more work is required.  */
> +				/* Use Invariant TSC as a better clocksource. */
>   				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
>   
> +				/* Use the Ref Counter in case Invariant TSC is unavailable. */
> +				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +					pr_warn("Hyper-V: Invariant TSC is unavailable\n");
> +
>   				/* HV_MSR_CRASH_CTL is unsupported. */
>   				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>   
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index b2a080647e413..99177835cadec 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -137,7 +137,21 @@ static int hv_stimer_init(unsigned int cpu)
>   	ce->name = "Hyper-V clockevent";
>   	ce->features = CLOCK_EVT_FEAT_ONESHOT;
>   	ce->cpumask = cpumask_of(cpu);
> -	ce->rating = 1000;
> +
> +	/*
> +	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
> +	 * so the local APIC timer (lapic_clockevent) is the default timer in
> +	 * such a VM. The Hyper-V timer is not preferred in such a VM because
> +	 * it depends on the slow VM Reference Counter MSR (the Hyper-V TSC
> +	 * page is not enbled in such a VM because the VM uses Invariant TSC
> +	 * as a better clocksource and it's challenging to mark the Hyper-V
> +	 * TSC page shared in very early boot).
> +	 */
> +	if (!ms_hyperv.paravisor_present && hv_isolation_type_tdx())
> +		ce->rating = 90;
> +	else
> +		ce->rating = 1000;
> +
>   	ce->set_state_shutdown = hv_ce_shutdown;
>   	ce->set_state_oneshot = hv_ce_set_oneshot;
>   	ce->set_next_event = hv_ce_set_next_event;

LGTM.

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman

