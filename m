Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410643F990
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Oct 2021 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJ2JRe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Oct 2021 05:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhJ2JRc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Oct 2021 05:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635498903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FKPJ14P0NBDDQOtnjBeYPNE2VaHGagsVkffrpahKyO4=;
        b=W7dAfloQqzge9stwUPMQjo17uQntwORJ7wGsZSlBV21hRPN+NFoYU3gTklOJCOm17f+7Vz
        e1iaF//o344ht7eg1QwN11yS+PGp6+zeTTl9Tye9Ad0y+rBgNJQpSsCvfxfo2VEN346NCs
        5YFflLSyGRa+PUVjPggjPVtrQvV+Qmw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-n050njYlOZW793RY6qmBDA-1; Fri, 29 Oct 2021 05:15:02 -0400
X-MC-Unique: n050njYlOZW793RY6qmBDA-1
Received: by mail-wm1-f70.google.com with SMTP id v18-20020a7bcb52000000b00322fea1d5b7so2937341wmj.9
        for <linux-hyperv@vger.kernel.org>; Fri, 29 Oct 2021 02:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FKPJ14P0NBDDQOtnjBeYPNE2VaHGagsVkffrpahKyO4=;
        b=1ak335f1wv9JD7m0NUugqZChN8GarRSA5AOotTfW6KTHDL1r7X0MDvTQOL2BWECu4K
         XT6GC9NkAu8q7ZDqEyZy/AoOfYpDDSdKhJLaEAAyjmlEVLfuuINtjNk6I8+wLDhmRH8I
         Oerey3RiLMJqI36qntTna5bf35eNjjIt2KkOVASX+JcxJcP4RdxW/NeSF9+s839HYRXp
         z97uZnMODZUd1WIuPenAxwVY+PzvgaufrlguVI67O55xj36heGuTY/W9OxdOATyiWS9v
         4AVrvS/KEGaMYpmWYFCp2soGPGNimyMR4UBe5VhIi5QGW2QPlMRj1sL9DeY9nXnacdnW
         Y/og==
X-Gm-Message-State: AOAM533BSJNvyuegD1pSOD4zZ+QC9CNzhe3aN1+OqStt4Z8FBdz7YNVu
        tQtkl4Fn4nSsgPPQBR+mWJPFo+pzu3IfhiYF90MzHoN6dwEIQV33VZks3XpQY+QvWLKb0RhUpps
        Cbp1Gw6tURgYzxeoMzHFchCjY
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr18314869wmr.102.1635498900945;
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBi96wOMUiniT8KYl19QAwCyp/0nDgv72yF7u0aKoMA8EIaa6Ez1bJSb8svu11JzSwqVPUsA==
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr18314851wmr.102.1635498900780;
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b8sm6816697wri.53.2021.10.29.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 02:15:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb()
 if Hyper-V setup fails
In-Reply-To: <20211028222148.2924457-2-seanjc@google.com>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
Date:   Fri, 29 Oct 2021 11:14:59 +0200
Message-ID: <87tuh0ry3w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Check for re-enlightenment support and for a valid hv_vp_index array
> prior to derefencing hv_vp_index when setting Hyper-V's TSC change
> callback.  If Hyper-V setup failed in hyperv_init(), e.g. because of a
> bad VMM config that doesn't advertise the HYPERCALL MSR, the kernel will
> still report that it's running under Hyper-V, but will have silently
> disabled nearly all functionality.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
>   Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
>   ...
>   Call Trace:
>    kvm_arch_init+0x17c/0x280
>    kvm_init+0x31/0x330
>    vmx_init+0xba/0x13a
>    do_one_initcall+0x41/0x1c0
>    kernel_init_freeable+0x1f2/0x23b
>    kernel_init+0x16/0x120
>    ret_from_fork+0x22/0x30
>
> Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
> Cc: stable@vger.kernel.org
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/hyperv/hv_init.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 708a2712a516..6cc845c026d4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -139,7 +139,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  	struct hv_reenlightenment_control re_ctrl = {
>  		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
>  		.enabled = 1,
> -		.target_vp = hv_vp_index[smp_processor_id()]
> +		.target_vp = -1,
>  	};
>  	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
>  
> @@ -148,6 +148,11 @@ void set_hv_tscchange_cb(void (*cb)(void))
>  		return;
>  	}
>  
> +	if (!hv_vp_index)
> +		return;
> +
> +	re_ctrl.target_vp = hv_vp_index[smp_processor_id()];
> +
>  	hv_reenlightenment_cb = cb;
>  
>  	/* Make sure callback is registered before we write to MSRs */

The patch looks good, however, it needs to be applied on top of the
already merged:

https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/

-- 
Vitaly

