Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6353C75C7
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhGMRft (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 13:35:49 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41786 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhGMRft (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 13:35:49 -0400
Received: by mail-wr1-f49.google.com with SMTP id k4so25207537wrc.8;
        Tue, 13 Jul 2021 10:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzNkp23Updmo+9Qa3OwjPC2MPeOgka9V1Y3hAYMOtks=;
        b=X6KycBiI1QodUgRNw4GFhLSCziydmR29sQKIoW+A9SRtgmNVeIpyzZvwD9PbuI08Ly
         RXC47R3I8WPCePS+vqyDCiMLICyPoAej+u1F+MxqdBNdR9cVaRMt80adm0cHBrWgszJg
         ObIAlYPaqfbxmqA+6Mxr8MG2kRu6YHEwfy5VySX1y/7HeixauS/Q1Y4+PbjHxvPJPCRj
         SFpf+x/x3YyM8RsbxPS2Pn3AtrwkH/zDlMutN3u1Oh9oDSMZawvq9PL5X6csDJ3ZHgIc
         f8EJKz11oS8NVF34+IljKphhU2iBl8zLWCBkMR1XK5HTkO3VLVwg6N3kpd8dLe/7UUGa
         7kMA==
X-Gm-Message-State: AOAM530i/ytZl5xfkoW0NCNdoKZp8AJP7E+L/ZQThoj7EEovI88KPjlV
        WhAjv3YRB6YrsBPJnvimBcE=
X-Google-Smtp-Source: ABdhPJxYRgWtgBkIQoz393H7CDpbw9RR0mcltSYfiVXitpEWDSTu9ODbPaobVfTgXZFYC8nNKKYEZA==
X-Received: by 2002:adf:c5d2:: with SMTP id v18mr7200261wrg.386.1626197577942;
        Tue, 13 Jul 2021 10:32:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c15sm2287056wmr.28.2021.07.13.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:32:57 -0700 (PDT)
Date:   Tue, 13 Jul 2021 17:32:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Ani Sinha <ani@anisinha.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anirban.sinha@nokia.com" <anirban.sinha@nokia.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Message-ID: <20210713173256.f4guohutujyvfste@liuwe-devbox-debian-v2>
References: <20210713030522.1714803-1-ani@anisinha.ca>
 <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 05:25:59PM +0000, Michael Kelley wrote:
> From: Ani Sinha <ani@anisinha.ca> Sent: Monday, July 12, 2021 8:05 PM
[...]
> >  	/*
> > @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> >  #endif
> > +	/* TSC should be marked as unstable only after Hyper-V
> > +	 * clocksource has been initialized. This ensures that the
> > +	 * stability of the sched_clock is not altered.
> > +	 */
> 
> For multi-line comments like the above, the first comment line
> should just be "/*".  So:
> 
> 	/* 
> 	 * TSC should be marked as unstable only after Hyper-V
> 	 * clocksource has been initialized. This ensures that the
> 	 * stability of the sched_clock is not altered.
> 	 */
> 
> 
> > +	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> > +		mark_tsc_unstable("running on Hyper-V");
> >  }
> > 
> >  static bool __init ms_hyperv_x2apic_available(void)
> > --
> > 2.25.1
> 
> Modulo the comment format,
> 

I can fix this while committing. No need to resend.

> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com> 

Thanks Michael.

Wei.
