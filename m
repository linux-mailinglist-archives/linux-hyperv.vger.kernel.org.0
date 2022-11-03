Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376261833F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 16:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKCPsj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCPsg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 11:48:36 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0664D1;
        Thu,  3 Nov 2022 08:48:36 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id h9so3462838wrt.0;
        Thu, 03 Nov 2022 08:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Wq79lyITbkFUX8I3WqtfNpU9PWy7SSBeSmagRdmwc=;
        b=lGc0RW+F45Dx4VwI4Hh+cJtFjAg/aIehzH/gh3PsPXxFWC3R7FOUnh6dyv5WwspLT7
         jRflXjqj0RFm7Tdql1mgbnN0A9HQ7tGeLI/CruXg8Ug2AWxn/62DPWkN6CpNQk6q+K2V
         5ZFGT6PA8v1wGIwj5YfnssxXJCGSWS9GgA/buuFdi2X0w0++r3LnDIpoD1EBZhHmM9EL
         UAF2v0+Huj+xCcYLbg5OdQmznc2bUm/gllQ3TEip8IfI12/79xTgMboSqeceHwK/+OPL
         C9HOW8GT3DTRnEx76fxy7nE9nqoCbi7R1wPognEkL1i09Eu87Eu2XFIJ8jjFBX3s3w4L
         VEyg==
X-Gm-Message-State: ACrzQf1GOIE31z+GLUeNdcGqZD5CXdVNiTVOJ2z+G8akxT5+/KCJwVBw
        r010lIrhKarAayvZ5foMriQ5YUfGYzA=
X-Google-Smtp-Source: AMsMyM5Uq6UmrhMKDeWRCDF2skQQM8Ji0jpIAZssD6nSNCqorFkAwkUOI8IvRyVilyJVMf1m+kKbwQ==
X-Received: by 2002:a5d:6ac7:0:b0:236:b281:150 with SMTP id u7-20020a5d6ac7000000b00236b2810150mr18593143wrw.29.1667490514597;
        Thu, 03 Nov 2022 08:48:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c510300b003b3307fb98fsm314938wms.24.2022.11.03.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:48:34 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:48:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Message-ID: <Y2PiyAEJZitd3LS8@liuwe-devbox-debian-v2>
References: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 03:34:23PM +0000, Michael Kelley (LINUX) wrote:
> From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, November 3, 2022 8:24 AM
> > 
> > __phys_to_pfn() will return a PFN based on the guest page size, which might
> > be different from Hyper-V's page size that is always 4K. The PFN for the
> > TSC page always needs to be a Hyper-V PFN.
> > 
> > Use HVPFN_DOWN() to calculate the PFN of the TSC page from the physical
> > address.
> > 
> > Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > ---
> >  drivers/clocksource/hyperv_timer.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index 11332c82d1af..18de1f439ffd 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/acpi.h>
> > +#include <linux/hyperv.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/hyperv-tlfs.h>
> >  #include <asm/mshyperv.h>
> > @@ -412,7 +413,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
> >  	/* Re-enable the TSC page */
> >  	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> >  	tsc_msr.enable = 1;
> > -	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> > +	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
> >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >  }
> > 
> > @@ -532,7 +533,7 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	 */
> >  	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> >  	tsc_msr.enable = 1;
> > -	tsc_msr.pfn = __phys_to_pfn(phys_addr);
> > +	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
> >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> > 
> >  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> > --
> > 2.34.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thank you both for the quick turnaround. I will just squash this patch
into the previous one.
