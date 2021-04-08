Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579B35814E
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Apr 2021 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhDHLHK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Apr 2021 07:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229721AbhDHLHJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Apr 2021 07:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617880018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqFnFnU+W5hoDYL4hIDIXsxj0nax+65fpHN1hSzXtQU=;
        b=i5RFaEYOoBBVxgion5/FMLabt+iHjFmzycvPHnes5VOYfGVW67/TwK3wqaFaf/bHdfqLvh
        EHfUTdt1lZJAwO1pjJb+KIZiCUycVdwulaXah9JDiPcZSkXGfs4hLp7j/tSLRGKhr7rMrO
        4HxXGDwWIvjgPJPVvACL+2fi7AYE+uw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-4JcfE1RUPzyIK8El0GfZwA-1; Thu, 08 Apr 2021 07:06:56 -0400
X-MC-Unique: 4JcfE1RUPzyIK8El0GfZwA-1
Received: by mail-wm1-f72.google.com with SMTP id n2so329749wmi.2
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Apr 2021 04:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uqFnFnU+W5hoDYL4hIDIXsxj0nax+65fpHN1hSzXtQU=;
        b=AA76KTBxG8Jd6BhJN0qIi5bbRXx3+SVTwPtqUXO+Ozh98tbPKipQMkdYAepKXsZ1aQ
         A/XI6CIIEq41s6Lp/29IhCyijgnZxsc5UKISYt9FAGcD+E8woN/LR9JW01kUJAak/uW/
         ZSHzZGohrKkhXfmvcDJ2AqURIq9CDzJ/y2btu6dYyGVzQTKNifKzRIaY2uy9foLDyKjq
         q8dZZ0+mQz+hKWfd8We/pXhB9+JueX7hrnfcZo/pMgQ9LGQYWu3OSDIXwhchFDkFVqTY
         qWJqmOHBYx7fd6tfZac31xS8Fu6LgTJ7qAzI2dWh9lt7KnYVnh6g2YXIIh8ETHo2861+
         zA8g==
X-Gm-Message-State: AOAM530LyJsjJAfBih+LsBVjEh7hhyrgjRYN/8357WzM3MfjtmVlY6Ss
        4hHpwRv1no7GD9mzVweT5fi3AGUjCo5PEJ32ly0TawCn/cqqG9PPwBg+SfV5HSYcUloRYDyM9e0
        38nLWrnql7tYnloqwmb6VxYVB
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr7810241wme.87.1617880015662;
        Thu, 08 Apr 2021 04:06:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhTjY0W2FDvXVXeD2w+sxa4IvR8DiEXHT/hvQBvRN5BWI+R63DZx6H7rXpPawxMiiXKC0BMw==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr7810214wme.87.1617880015445;
        Thu, 08 Apr 2021 04:06:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z15sm15469155wrw.38.2021.04.08.04.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:06:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH 1/7] hyperv: Detect Nested virtualization support for SVM
In-Reply-To: <e14dac75ff1088b2c4bea361954b37e414edd03c.1617804573.git.viremana@linux.microsoft.com>
References: <cover.1617804573.git.viremana@linux.microsoft.com>
 <e14dac75ff1088b2c4bea361954b37e414edd03c.1617804573.git.viremana@linux.microsoft.com>
Date:   Thu, 08 Apr 2021 13:06:53 +0200
Message-ID: <87lf9tavci.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Detect nested features exposed by Hyper-V if SVM is enabled.
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 3546d3e21787..4d364acfe95d 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -325,9 +325,17 @@ static void __init ms_hyperv_init_platform(void)
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>  	}
>  
> -	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
> +	/*
> +	 * AMD does not need enlightened VMCS as VMCB is already a
> +	 * datastructure in memory. 

Well, VMCS is also a structure in memory, isn't it? It's just that we
don't have a 'clean field' concept for it and we can't use normal memory
accesses.

> 	We need to get the nested
> +	 * features if SVM is enabled.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_SVM) ||
> +	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {

Do I understand correctly that we can just look at CPUID.0x40000000.EAX
and in case it is >= 0x4000000A we can read HYPERV_CPUID_NESTED_FEATURES
leaf? I'd suggest we do that intead then.

>  		ms_hyperv.nested_features =
>  			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
> +		pr_info("Hyper-V nested_features: 0x%x\n",
> +			ms_hyperv.nested_features);
>  	}
>  
>  	/*

-- 
Vitaly

