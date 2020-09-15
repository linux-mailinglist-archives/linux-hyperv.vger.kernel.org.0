Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE73E26A3FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIOLQY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 07:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgIOLPV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 07:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600168461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
        b=TYIke+CVbdgmbhBS3fbwjrN4FQc0maiTVVk0zEqK+qBw9TNA9QyrkAjlzsTubscu3IhENH
        1OfPZf1DK8cSXzoW1lPQde72QLmKxtvllS/9M4qdVnwfWPJgNn9ySZ/FwHnQmAdKd6d0P+
        w2m3o7/meUXqeQ2Xu0Ac/LkzJwqgOOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-kAiKmUh3P9iunhCMdOty9w-1; Tue, 15 Sep 2020 07:14:20 -0400
X-MC-Unique: kAiKmUh3P9iunhCMdOty9w-1
Received: by mail-wr1-f69.google.com with SMTP id d9so1089685wrv.16
        for <linux-hyperv@vger.kernel.org>; Tue, 15 Sep 2020 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
        b=diPD7WUDbIsW129i/QfLruV3M5DJY6cU1dX9DgCjQe7qSInpF8PhjYAkqPCNuyYNoC
         x3EL8ubEbpvQofoP+XrfsQ2Jbd9UdVmVUAaywAK+gkRpvpHH+Sc5q8wwPkZPxNCOnNh+
         4ia2oI/3dlBQHRVXqER5D1AWW3dHWCTsmeyefi3idQ2YwsaGMp81pB14kJmUu51tiM69
         dwmPdLLpe3LdHb2xbFPYKU0gUQwETHN/icbaSl7WX4usxTVpbm4j5Shcj+4v46KT5/q2
         DoWSakJR/UhBFIyZ4W5qEMLR1bsF61a8JFd/Wi4ZzAKhQnbUizUKgRcQLge1xjXMIsfb
         oIYg==
X-Gm-Message-State: AOAM531IOxUNGcs07mY+O6nf7gUSgkLR+QBdFKwGIOJ4h2fI/VfgYO5Y
        M7QvwGNmFGMpPXh9Rm7H5HSYcT5iY/bLJHJyNcLwISO5fAYdSu9Bt6ixF9kgqWGnu9krcGXiWV/
        M19KS19zZGosKAqKrVkp3BWka
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031968wmk.153.1600168458787;
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOzi3Ja62k21YvM26bciVJnHAtZqdXuOel1sIRIJNA9BcjPXAZhIRYZguDOvo2rTnyovo1Uw==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031937wmk.153.1600168458576;
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o6sm27250404wrm.76.2020.09.15.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 10/18] x86/hyperv: implement and use hv_smp_prepare_cpus
In-Reply-To: <20200914115928.83184-2-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914115928.83184-2-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 13:14:16 +0200
Message-ID: <87mu1rjnqv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
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
> index 1bf57d310f78..7522cae02759 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -203,6 +203,31 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#if defined(CONFIG_X86_64)

I think it makes little sense to try to make Linux work as Hyper-V root
partition when !CONFIG_X86_64. If we still care about Hyper-V enablement
for !CONFIG_X86_64 we can probably introduce something like
CONFIG_HYPERV_ROOT and enable it automatically, e.g.

config HYPERV_ROOT
        def_bool HYPERV && X86_64

and use it instead.

> +	int i;
> +	int vp_index = 1;
> +	int ret;
> +
> +	native_smp_prepare_cpus(max_cpus);
> +
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
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, vp_index++, i);

So vp_index variable is needed here to make sure there are no gaps? (or
we could've just used 'i')?

> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>  
>  static void __init ms_hyperv_init_platform(void)
> @@ -359,6 +384,8 @@ static void __init ms_hyperv_init_platform(void)
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

