Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09126A32E
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOKcK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 06:32:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34369 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIOKcI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 06:32:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id l15so7777511wmh.1;
        Tue, 15 Sep 2020 03:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iu1a051qw6glF2gbjBYkACqFqsFXF3vFbvUgHvXqm8s=;
        b=CGGuXF2dk9T5CRX54TmyufVE21PuvHkBHin9OL2JKqc1jZ8b1W6QMvKNijTMKIp2Mn
         71dZSRdkGMTkyWmGDpeRJvSmyHJiuRElIqxThKWDBkgluQEo167sggteVyIjD7kgITg+
         m0EyRMSWx1HuATDcp0KdOWrXxNA3hIY1G+z0TfTSsni9Y1Zjd/79hdUiIDuN7cIVocEJ
         K+Dhf5+X3/kc1iUxio/CS2x5rR7pCjAUaK7nCxAhwzBK7kqGZjwV/AhyECXoTc8KpiuB
         LH5Rwj+iLAHNJPL+ijFVzUvSvWq/ScadzrdaQnT4L4LhVoIJXyqsgRtNSyqopde6a6yF
         YwTQ==
X-Gm-Message-State: AOAM532sZuq+SvE+tMCSCq/ygcpQo0E+AAsl+cDrMf7UXHW77JDa4sX6
        vp2ae1hjzwfLuKv9GCvH5cM=
X-Google-Smtp-Source: ABdhPJxV04RkXjfvibgWeB04D5pYNW6Px4h9t4Qs58VtzvxsijiahR4fe4QBLtC6jloVWYpUOnhgdA==
X-Received: by 2002:a1c:7c01:: with SMTP id x1mr3800243wmc.57.1600165926455;
        Tue, 15 Sep 2020 03:32:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n21sm24208316wmi.21.2020.09.15.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:32:06 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:32:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v1 05/18] clocksource/hyperv: use MSR-based access if
 running as root
Message-ID: <20200915103204.53zlqx4jq7z2hpjw@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-6-wei.liu@kernel.org>
 <874knzl5ab.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874knzl5ab.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 12:10:04PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/clocksource/hyperv_timer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index 09aa44cb8a91..fe96082ce85e 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> >  		return false;
> >  
> > +	if (hv_root_partition)
> > +		return false;
> > +
> 
> Out of pure curiosity,
> 
> TSC page clocksource seems to be available to the root partition (as
> HV_MSR_REFERENCE_TSC_AVAILABLE is set), why don't we use it? (I
> understand that with TSC scaling support in modern CPUs even migration
> is a no-issue and we can use raw TSC but this all seems to be
> independent from root/non-root partition question).
> 

Yes. It is available to the root partition. An earlier version of this
patch did use that.  With some major restructuring of the code between
4.19 and 5.6 (splitting out the clocksource to and getting initialized
earlier), the old code wouldn't work anymore. 

The catch is that the page will have been set up by the hypervisor, so
in the function we will need to take a different path.  And making that
work again on 5.8 requires a bit more code churn.

Like I said in the cover letter, this is the bare minimum to get things
going. I try not distract people too much with less important stuff at
this stage, but making the reference TSC work again is definitely
something we want to look into in the future.

Wei.

> >  	hv_read_reference_counter = read_hv_clock_tsc;
> >  	phys_addr = virt_to_phys(hv_get_tsc_page());
> 
> -- 
> Vitaly
> 
