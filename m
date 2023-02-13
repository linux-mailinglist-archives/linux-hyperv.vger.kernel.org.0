Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C1694BCE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBMPzN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjBMPzL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 10:55:11 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561B3ABF;
        Mon, 13 Feb 2023 07:54:58 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id o18so12760034wrj.3;
        Mon, 13 Feb 2023 07:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WozpRvtDUWPUwFz1/SmNCmlgt7PdnZkVRLNYabSNOFk=;
        b=55YPzLJ9nHSWpnobRnlvqFSaVfFB7cCQFvwxPzGhtEpb8MTtPBXp3CEURfZFh2a4HB
         Ftow9/7cgenQVa88rYtEws819DiUx6+JhznK4RYUiO1Q+qFJu3iOX/l2pJF8LmNsgx22
         G8Aa0SC59FPX4okSePmoo8CFYGPGG0x+1qnecq4a2rS7jNc5daYdEgvSaWHu//wBoLR/
         O/7NHm8QSSKcN5pQZDNHWQc08/5NPgPUa+pL9mWBO2Dgt/Howxrpw13X4BIfJlc6GixV
         rkWRnt1xmvCFJ4BLpRBPP7nmlZ0qMgG1lgrw+PqZSUkulN+C4wQAnFidT8g6XZ6Mg3S4
         cnrA==
X-Gm-Message-State: AO0yUKWYxvsbdhuJ1soE8JvSJc4y5H1G4JNagwNO3NdC8lRsF83P6CPp
        iBAm6xM6DOrY5SzO9oix5ZU=
X-Google-Smtp-Source: AK7set8RVkuOzzkDM92v7gr6/49GSS6oITZbC1/ENbRlDU/0UI8FSpJdsLCMKHeyEWzKAphOgojGSA==
X-Received: by 2002:a5d:4dc9:0:b0:2c5:5a6a:72af with SMTP id f9-20020a5d4dc9000000b002c55a6a72afmr2421063wru.4.1676303697062;
        Mon, 13 Feb 2023 07:54:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12-20020adfdb0c000000b002c3ec1fbc0bsm10766438wri.94.2023.02.13.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:54:56 -0800 (PST)
Date:   Mon, 13 Feb 2023 15:54:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Message-ID: <Y+pdQGsSjUJP2vVk@liuwe-devbox-debian-v2>
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <b8a0e0b7-26dc-cc80-b0f4-104d37ea427d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a0e0b7-26dc-cc80-b0f4-104d37ea427d@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 07, 2023 at 03:24:47PM -0800, Nuno Das Neves wrote:
> On 2/6/2023 12:49 PM, Stanislav Kinsburskii wrote:
> > From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> > 
> > And have it preset.

In the future please add a blank line between two paragraphs.

> > This change allows to significantly reduce time to bring up guest SMP
> > configuration as well as make sure the guest won't get inaccurate
> > calibration results due to "noisy neighbour" situation.
> > 

This looks like a good idea. 0293615f3fb9 was committed in 2008, so
we're very late to the party. Better late than never though.

If I hear no objections in a few days' time I will apply this to
hyperv-next with Nuno's Rb tag.

Thanks,
Wei.

> > Below are the numbers for 16 VCPU guest before the patch (~1300 msec)
> > 
> > [    0.562938] x86: Booting SMP configuration:
> > ...
> > [    1.859447] smp: Brought up 1 node, 16 CPUs
> > 
> > and after the patch (~130 msec):
> > 
> > [    0.445079] x86: Booting SMP configuration:
> > ...
> > [    0.575035] smp: Brought up 1 node, 16 CPUs
> > 
> > This change is inspired by commit 0293615f3fb9 ("x86: KVM guest: use
> > paravirt function to calculate cpu khz").
> > 
> > Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > CC: Haiyang Zhang <haiyangz@microsoft.com>
> > CC: Wei Liu <wei.liu@kernel.org>
> > CC: Dexuan Cui <decui@microsoft.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: x86@kernel.org
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: linux-hyperv@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index dedec2f23ad1..0282b2e96cc2 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -320,6 +320,21 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> >  }
> >  #endif
> >  
> > +static void __init __maybe_unused hv_preset_lpj(void)
> > +{
> > +	unsigned long khz;
> > +	u64 lpj;
> > +
> > +	if (!x86_platform.calibrate_tsc)
> > +		return;
> > +
> > +	khz = x86_platform.calibrate_tsc();
> > +
> > +	lpj = ((u64)khz * 1000);
> > +	do_div(lpj, HZ);
> > +	preset_lpj = lpj;
> > +}
> > +
> >  static void __init ms_hyperv_init_platform(void)
> >  {
> >  	int hv_max_functions_eax;
> > @@ -521,6 +536,12 @@ static void __init ms_hyperv_init_platform(void)
> >  
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> > +
> > +	/*
> > +	 * Preset lpj to make calibrate_delay a no-op, which is turn helps to
> > +	 * speed up secondary cores initialization.
> > +	 */
> > +	hv_preset_lpj();
> >  #endif
> >  	/*
> >  	 * TSC should be marked as unstable only after Hyper-V
> > 
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

