Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D682C3CB806
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhGPNpg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 09:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232837AbhGPNpf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 09:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626442960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0SM1J4AxB0WAO/+RGPDlAQy4v0R4uwCprlL41GZQ+WY=;
        b=MiZxtuSSOL4KBWfChl8soWRMzLtACSkXdviJqH/Ft+EB6Sfp4k3uG++vN/z9AB71opsI23
        fP2CFdaZQZXcI0cj/TO1GfD2OU3kZV0rDGnju1b2DwsimXJxlGVdwzEKXEhNKs13XhtvU8
        0rjjaFbJ5pEmcFBrOiXak2SkzAIQetg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-T-5DlqLXMTOxkanD2JQ0Vw-1; Fri, 16 Jul 2021 09:42:38 -0400
X-MC-Unique: T-5DlqLXMTOxkanD2JQ0Vw-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso4846944edu.4
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jul 2021 06:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0SM1J4AxB0WAO/+RGPDlAQy4v0R4uwCprlL41GZQ+WY=;
        b=qM3+ZXvqYBMh5rZ04S5PIejekj3a/TsWziwmsmZrtp7+gvTX6ZCC4Aqpsfzm+XdEMC
         rvNI2rC7z/JncN+wtt54Znxbx1gPH7VVBE4BEtbGb/JAZiVfb7csWdW/lMvg3/QURN3o
         NWqryS+xWDb0KqtJnnLToCjcl3iSxzLLiX30s7e6sUsvIzu3eshUgefU6E8vFUYukf85
         ocH1corsr6RLQ4MZkXFEjgaaA0gy+xnv9yrYNQQ0NqwuxzYFrPzQE3OzhZGhT9IFr05u
         x4BqxEK0cJUuNgVkEJ3uXEARCiJEI9TmUGk6mEpZmOdOH1/5KX9z6jsHsE90fJwjSL2F
         yyFQ==
X-Gm-Message-State: AOAM531Wjui/C0DnAKXF5Al8MJo09+ZPbyME83B0L4k3NLyjkeTOTfs+
        +M/uwaMMSbhMZeghU1LTT4iHm6Zt/1KcQMnqtY5+R3KvrJ5JYVMe5jA9WDbwQEdAXtf6wY+QL+c
        V8vY/gpV9XJADWcIWLCYdXnw1qvpXDHKjfsykF01DBf3EeF/yJ/jcbuWPOWoQQJwVLM3COTwi1B
        bA
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr11912093ejb.431.1626442957581;
        Fri, 16 Jul 2021 06:42:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrGDt56e+ukOx0foKDrNDsirm0LRscu/xWkEFRRC3tUqzl+4xaINTt86OJ9yTpyo3ARlh0ag==
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr11912037ejb.431.1626442957116;
        Fri, 16 Jul 2021 06:42:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dn23sm3777705edb.56.2021.07.16.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:42:36 -0700 (PDT)
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
Subject: Re: [PATCH v2] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
In-Reply-To: <20210716133245.3272672-1-ani@anisinha.ca>
References: <20210716133245.3272672-1-ani@anisinha.ca>
Date:   Fri, 16 Jul 2021 15:42:35 +0200
Message-ID: <87zgumz86s.fsf@vitty.brq.redhat.com>
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
>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> changelog:
> v1: initial patch
> v2: slight comment update based on received feedback.
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 715458b7729a..3b05dab3086e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -368,6 +368,15 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +		/*
> +		 * Writing to synthetic MSR 0x40000118 updates/changes the
> +		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> +		 * guests to report invariant TSC feature through CPUID
> +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> +		 * early_init_intel() where this bit is examined. The
> +		 * setting of this MSR bit should happen before init_intel()
> +		 * is called.
> +		 */

This should be very clear now, thanks!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}

-- 
Vitaly

