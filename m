Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E439E1A2665
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgDHPyo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Apr 2020 11:54:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729566AbgDHPyo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 11:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586361282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jL6OKsl/vevfcCXL5hEg1wpfnw6jRaU0IgVB/aka5A=;
        b=OctWYPLuqppaF1u4XW4bBK6KrKI0hSaq0mpeVpCCDIN3URhMFU+wqZiialOcZqOGhl6BVv
        jkl1lCicSIxxSXnxUmyms38E6t3es9thmW5NZ2YLKka53zGbtqAzgEk9TLXxcDvKf/PvQo
        t/5SSJ/PR1p5Moo84rx7f+zf7qaNQDA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-K_-kij1MOKu8PucOVPzBeg-1; Wed, 08 Apr 2020 11:54:39 -0400
X-MC-Unique: K_-kij1MOKu8PucOVPzBeg-1
Received: by mail-wr1-f70.google.com with SMTP id k11so4463658wrm.19
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Apr 2020 08:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0jL6OKsl/vevfcCXL5hEg1wpfnw6jRaU0IgVB/aka5A=;
        b=IFVtElYtIXnffw0vqdsKY9EynSWhErPAPMZRLYnh4qlFP7bHJf+OO3EdbEccValy0u
         viq2jwFulHh59dpSkyjRy3hkoBIPT+IoI3B1duvFck5aDi7P0z2Sy7s0bveuDINO7Tr3
         B6J5l+7fr1nGcCkICj+dznQPXbUjw4yqnDrjQjNgdvNwl65JmNbXeiC5Rv9YLbUYfhjN
         6mJLZSOfa/xgQGkIgBrWIj4/b0+G8PDDk7COO2qaDYwx0Yqo5NhxqBJcrjEKEUAjEsZD
         sUlih58CL57GWw2u5u8vBU28EFAE1A1jlLUVOlsIVm4Os+oZPPvVA8VrGJRbeyurfDtW
         iFuw==
X-Gm-Message-State: AGi0PuaQwTPT3Qm7Wv61Vd5ATSnNDwCVj7sGYyuz66sXvA4erR45QKE9
        qC/wYDhVV1JEqpc7flDNmJ4n8acOE0YcQC2d1vxIHevjUiHuKhAaY27PIY59hcGER4pzGFumxu9
        avbRngDfyd1KmYCL/mOgUjdpJ
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr5719266wmj.156.1586361278158;
        Wed, 08 Apr 2020 08:54:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJT6MzUUAi0MLdhAAZpBiuYK6o2gfpFrbxz3473qX+5EK7JCJ7DwjwpPhSkpGBI/UrWHw25Mg==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr5719247wmj.156.1586361277827;
        Wed, 08 Apr 2020 08:54:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u17sm41238777wra.63.2020.04.08.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:54:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v1] x86: hyperv: report value of misc_features
In-Reply-To: <20200407172739.31371-1-olaf@aepfle.de>
References: <20200407172739.31371-1-olaf@aepfle.de>
Date:   Wed, 08 Apr 2020 17:54:35 +0200
Message-ID: <874ktu2csk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> A few kernel features depend on ms_hyperv.misc_features, but unlike its
> siblings ->features and ->hints, the value was never reported during boot.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index caa032ce3fe3..53706fb56433 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -227,8 +227,8 @@ static void __init ms_hyperv_init_platform(void)
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints);
> +	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);

Several spare thoughts:

I'm always struggling to remember what is what here as these names don't
correspond to TLFS, could we maybe come up with better naming, e.g.

"Features.EAX", "Features.EDX", "Recommendations.EAX",...

On the other hand, there is more, e.g. nested virtualization
features. How is it useful for all users to see this in dmesg every
time? If we need it for development purposes, we can always run 'cpuid'
so maybe let's drop this altogether or print only with pr_debug? 

(Honestly: no strong opinion here, deferring to Microsoft folks).

>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
>

-- 
Vitaly

