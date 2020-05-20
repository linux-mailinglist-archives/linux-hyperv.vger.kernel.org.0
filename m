Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418F1DAE50
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETJFb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 May 2020 05:05:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETJFb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 May 2020 05:05:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1so2330019wrt.5;
        Wed, 20 May 2020 02:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vtfSRZ5+Mpa+t2H3i2M/rGbjqAT1nghsWbPTQRPMsMw=;
        b=d5Eoz5FdaSeRO5kqfNEDtNAH/dYSo1Vg0tW6dExIv5PUNWaqXVDDjJVhHGK9NfcLZM
         C5gN6wXUF7pE5kZZvPAZ6LoIs3TxdVfZ8EngHnTiPwHgc2qBSVvQbDIro8iY+lD7+LAx
         iXA3tCQcQnKlCeMwjH/Qgt0PeXTIQizifTROIc/7xN6jFJkEr7Pw+6ZabIhWtK4w9Hjw
         PI49Vb+w+KG+hFbL65QcU4VjxfsgWZVfOKFVrvOQUC7MtiNlDzQw8JdfEcH7ZhLLFCfs
         INNjdEgYup2HgsOw/mWfciaSVlG5AjBImIwMDNz3l/oxbTIAZTUwXWg55QXQTm1au8kq
         Z6gg==
X-Gm-Message-State: AOAM530QkVX6cwhOZElxHUqmZxu7HRg0sIce4TdH8yoeMUGzHL36I8Y+
        FoVw/QOiZ8UCBsQKDIjC2CcNf/84
X-Google-Smtp-Source: ABdhPJyzoz8h8MG0oOus3GEacF8QkZaDE2L2XQMW4XNvl8vXP8FFFDpG+5YfhZ9nfMMMlhhuemWlHA==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr3253024wru.83.1589965528830;
        Wed, 20 May 2020 02:05:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n9sm2526625wmj.5.2020.05.20.02.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:05:28 -0700 (PDT)
Date:   Wed, 20 May 2020 09:05:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/Hyper-V: Support for free page reporting
Message-ID: <20200520090526.un3zvgpciy6ptta7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87ftbvt21h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbvt21h.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 20, 2020 at 10:59:22AM +0200, Vitaly Kuznetsov wrote:
> Sunil Muthuswamy <sunilmut@microsoft.com> writes:
[...]
> > +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index ebf34c7bc8bc..2de3f692c8bf 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -224,11 +224,13 @@ static void __init ms_hyperv_init_platform(void)
> >  	 * Extract the features and hints
> >  	 */
> >  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> > +	ms_hyperv.b_features = cpuid_ebx(HYPERV_CPUID_FEATURES);
> >  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
> >  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
> >  
> > -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> > -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> > +	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%x, misc 0x%x\n",
> > +		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
> > +		ms_hyperv.misc_features);
> 
> HYPERV_CPUID_FEATURES(0x40000003) EAX and EBX correspond to Partition
> Privilege Flags (TLFS), I'd suggest to take the opportunity and rename
> this to something like 'privilege flags low=0x%x high=0x%x'.
> 
> Also, I don't quite like 'ms_hyperv.b_features' as I'll always have to
> look at what it's being assigned to understand what it holds. I'd even
> suggest to rename ms_hyperv.features to ms_hyperv.priv_low and
> ms_hyperv.b_features tp ms_hyperv.priv_high. Or maybe even better, pack
> them to the same 'u64 ms_hyperv.privileges'.

+1 for this. :-)

Wei.
