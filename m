Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64633CB7D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhGPN3A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 09:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239391AbhGPN27 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 09:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626441964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iApEIi9Miq3UIE5s+yV3GBcv1kZmgG+1mZKk7FrnGGs=;
        b=Zp4xc7nXIFLhaVtaESurVUIRya5+vaADnTXzLGS1LwtOkfQksWFVoMNItOuxA/GX1oMUkN
        Da5k6/bjNXXjPbcUoZDyXJlrwocy29nhG/gvO6tuLIB7tJ9xm6ssEVwADskE+lVOTU7PCf
        hMltZA9NufWdCXzESpYWqehj4d3xusw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-PIxvucwCPRazdzJaGNwC2w-1; Fri, 16 Jul 2021 09:26:03 -0400
X-MC-Unique: PIxvucwCPRazdzJaGNwC2w-1
Received: by mail-ed1-f72.google.com with SMTP id n6-20020aa7c4460000b02903a12bbba1ebso4814196edr.6
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iApEIi9Miq3UIE5s+yV3GBcv1kZmgG+1mZKk7FrnGGs=;
        b=Q+ZDwPq5tZutwnl0o8KyGl//tqTRt4zgA9E6GfO2KIf267mnZDTpymzCBHMYUGtmff
         3Z6o//52SdSstVukLn0beNyGFpBpluwvke4Utzc/oNGDNfzuEQ/PiTLdhc5medm8WDZ4
         oPanfEE9Ec53h7zFWcfnAvl0JWm0XrOEcKW4YPLbCu0H51lGnsPZ6wAPPUVGlzljWftg
         JN56FtRuQlLyf/jBnT0HMz26/qjym2iAu3rxzDnGoqEEC5GkXwMqOAUpUPPGf6toLTuM
         qpdHVHFTGSYhMyCOHSG0w1qJ+ClCP/R/WYsUsXAt0PUQsKbi3g7RCfEZ5/ltPbB/1UN5
         cXRw==
X-Gm-Message-State: AOAM530eu9UIj6kxp/HA21YnurMCgpdPIxrj8i7awWImJwg7/SPzHrmj
        ft/+Z4/I+kLSiAGri2cmrZOYnoBNkNptwo8snwufuy7qfPrlifyT1F2wfu1sKoKznTmVIqBtgN8
        qb6pIq59WthiAn+cxEav95a5/w2qDgwgYjPBFtxnVk3TMmJ6XVPgKP7o6lW7t7hnKKOmcNfYT1X
        nk
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12015460ejz.235.1626441961668;
        Fri, 16 Jul 2021 06:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzg3o5Zm+WMzmX54XnqqEa0ngeEy6qu5V2lI5nMEf7EnM6pgvBbaS1pcrK55BQ7W7da23k6A==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12015103ejz.235.1626441957555;
        Fri, 16 Jul 2021 06:25:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dj16sm3781486edb.0.2021.07.16.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:25:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
In-Reply-To: <20210716063341.2865562-1-ani@anisinha.ca>
References: <20210716063341.2865562-1-ani@anisinha.ca>
Date:   Fri, 16 Jul 2021 15:25:55 +0200
Message-ID: <8735se1jbw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ani Sinha <ani@anisinha.ca> writes:

> Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
> added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
> of this synthetic MSR will allow hyper-v guests to report invariant TSC
> CPU feature through CPUID. This comment adds this explanation to the code
> and mentions where the Intel's generic platform init code reads this
> feature bit from CPUID. The comment will help developers understand how
> the two parts of the initialization (hyperV specific and non-hyperV
> specific generic hw init) are related.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 715458b7729a..d2429748170d 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -368,6 +368,14 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +		/*
> +		 * Setting bit 0 of the synthetic MSR 0x40000118 enables
> +		 * guests to report invariant TSC feature through CPUID
> +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> +		 * early_init_intel() where this bit is examined. The
> +		 * setting of this MSR bit should happen before init_intel()
> +		 * is called.

It should probably be emphasized, that write to 0x40000118
updates/changes guest visible CPUIDs. This may not be clear as CPUIDs
are generally considered 'static'. 

> +		 */
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}

-- 
Vitaly

