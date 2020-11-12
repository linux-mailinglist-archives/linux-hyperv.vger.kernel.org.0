Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8F2B0AA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgKLQp7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 11:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbgKLQo5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 11:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605199495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBaJhrVAS26Rm76b8qfX/jPZQo0xctgs1+BzsCLEDzc=;
        b=N87xLwY17iHBTuKChGTkxYSy18SJifNZuVuCEbDFHSKaW2c4E5z4okUVZQ2Lmq/WAcmI0a
        IjQA0B2j7EDfLe9eCwhQ7Hvr8AsRw8mmlS3SxH2HtdJmgVynZpelcHyNsjPYhpDihPVD6o
        i0HPgktap7RgyBh7TCifCresDO77g6Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-7JtrUPioOjKfg8juOdsr9w-1; Thu, 12 Nov 2020 11:44:53 -0500
X-MC-Unique: 7JtrUPioOjKfg8juOdsr9w-1
Received: by mail-wm1-f72.google.com with SMTP id h2so2405535wmm.0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 08:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oBaJhrVAS26Rm76b8qfX/jPZQo0xctgs1+BzsCLEDzc=;
        b=i4OTiqBlmbE5DbXC/cYwhbPmp/lMnZXdnfRQyge4G8e6sVAj66TMz1rsGWA55gHui7
         CXDYIQ8hYVmPjtUJ4mS/LaGrB0M27sllixaClZ8HzawhxpJblnz1+f3zDwH12w0k41lW
         o6ClOnycxfs99S36pojMD96Z5WHgT4VqqrLESu2JIeZ29YJxwjAqJ37urOjhbjGR9XI6
         AQm183DKR0wIWbAglk43t8SBQPPAP5zI4GpZZQGPuqV+VAA52Vv/7rO4jGFsn7lIOGXn
         f/FTFEa6tBr2Ho/DVm84N4C1PhCrdi3T7YiEgRFxGPiJ697zeGMZhEgcNmbafb2sSdSr
         cRJg==
X-Gm-Message-State: AOAM530DP8lO1rEZCAAKzQdEjEQ1XQyY2SHueq7zNsGUymDwCREBmFC7
        u4Fdsms0CH2BBMCWD/A8jb+HAfrVzsuCU6Q9j8Rh9paAtMoYjxDfBadFzY1Y0DxsCPRuJyO7elr
        6Bzvfhm/j9RDgwAqOPyqO125j
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr509597wmg.27.1605199492586;
        Thu, 12 Nov 2020 08:44:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwejZcKtx6F+o5hHeSMVHcvBzx8/ntsqvQ7ohWy6THyGvnfCHkeEWFtHXBT1nj5ZKtcZTpVUA==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr509445wmg.27.1605199490460;
        Thu, 12 Nov 2020 08:44:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m3sm3190396wrv.6.2020.11.12.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:44:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 10/17] x86/hyperv: implement and use hv_smp_prepare_cpus
In-Reply-To: <20201105165814.29233-11-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-11-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 17:44:48 +0100
Message-ID: <87y2j6wmm7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Microsoft Hypervisor requires the root partition to make a few
> hypercalls to setup application processors before they can be used.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> CPU hotplug and unplug is not yet supported in this setup, so those
> paths remain untouched.
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f7633e1e4c82..4795e54550e6 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -31,6 +31,7 @@
>  #include <asm/reboot.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/numa.h>
>  
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
> @@ -208,6 +209,30 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#if defined(CONFIG_X86_64)

'#ifdef CONFIG_X86_64' is equally good as you can't compile x86_64
support as a module :-)

> +	int i;
> +	int ret;
> +
> +	native_smp_prepare_cpus(max_cpus);
> +

So hypotetically, if hv_root_partition is true but 'ifdef CONFIG_X86_64'
is false, we won't even be doing native_smp_prepare_cpus()? This doesn't
sound right. Either move it outside of #ifdef or put the #ifdef around
'smp_ops.smp_prepare_cpus' assignment too.

> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> +		BUG_ON(ret);
> +	}
> +
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>  
>  static void __init ms_hyperv_init_platform(void)
> @@ -364,6 +389,8 @@ static void __init ms_hyperv_init_platform(void)
>  
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> +	if (hv_root_partition)
> +		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>  # endif
>  
>  	/*

-- 
Vitaly

