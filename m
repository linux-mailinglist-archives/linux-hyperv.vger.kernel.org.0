Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69B4EACD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Mar 2022 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiC2MH2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiC2MH1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 08:07:27 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9805E1F608
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Mar 2022 05:05:40 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id a1so24460623wrh.10
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Mar 2022 05:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Fybh/i4kizwsAwl03/NaB9gVfmssWgvIJEmlRu/kBs=;
        b=1ell5aF9ZR2inf8Q9DvShFwLzaTxY0/gDRWnlQR+CD+iNCPYV/dNHL9rmvcx2j00FI
         Cq9/yyK2Ah1OiGQSlqLsntyqLQ8LJG+SbWonBe8lbN2XOUJgGcwlXRiis2E7mQoZ+4D1
         RA/pOsMPXrfTCxbMwaluIG+IP5vCIiyhAtwgo1yJc8l3OJOWyvrJgJwX+LBeVOQEI1h0
         iUfe6LTe/nBUikYbS6K+/O3oukwc2H5KZuEKPtSjzIzsImdizsTjqc4tf3ov2BMuV8pX
         72E6UvDPKr4+SaGIQM/9pyjFDqAXWi8jN9X4mqbEjKUfLKD4gmdShEvxJrRFo5lxpTxY
         TMIw==
X-Gm-Message-State: AOAM531nFjLLq26Xlp4bQWXjrDXF75OP9Ur7QWgbZ/XPWvqHUPc//R7M
        34jZZFRNLyrD9D7LYTc72P0=
X-Google-Smtp-Source: ABdhPJw/cUNZJI9Q7bN9lcJ1HHaV7/Min1mnlL8mcYm6o4CskgCR+KoVWLRzr/AqmV/Wni5Yb53wPA==
X-Received: by 2002:a05:6000:1d8b:b0:203:df82:ff8d with SMTP id bk11-20020a0560001d8b00b00203df82ff8dmr31440333wrb.623.1648555535160;
        Tue, 29 Mar 2022 05:05:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm15005273wrf.80.2022.03.29.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:05:34 -0700 (PDT)
Date:   Tue, 29 Mar 2022 12:05:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix potential crash on module unload
Message-ID: <20220329120533.pbmzmq7oqybrtlfd@liuwe-devbox-debian-v2>
References: <20220315203535.682306-1-gpiccoli@igalia.com>
 <PH0PR21MB302540E78316B06885EBE72AD7149@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB302540E78316B06885EBE72AD7149@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 19, 2022 at 03:30:16PM +0000, Michael Kelley (LINUX) wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Tuesday, March 15, 2022 1:36 PM
> > 
> > The vmbus driver relies on the panic notifier infrastructure to perform
> > some operations when a panic event is detected. Since vmbus can be built
> > as module, it is required that the driver handles both registering and
> > unregistering such panic notifier callback.
> > 
> > After commit 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic
> > callback")
> > though, the panic notifier registration is done unconditionally in the module
> > initialization routine whereas the unregistering procedure is conditionally
> > guarded and executes only if HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE capability
> > is set.
> > 
> > This patch fixes that by unconditionally unregistering the panic notifier
> > in the module's exit routine as well.
> > 
> > Fixes: 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > ---
> > 
> > 
> > Hi folks, thanks in advance for any reviews! This was build-tested
> > with Debian config, on 5.17-rc7.
> > 
> > This patch is a result of code analysis - I didn't experience this
> > issue but seems a valid/feasible case.
> > 
> > Also, this is part of an ongoing effort of clearing/refactoring the panic
> > notifiers, more will be done soon, but I prefer to send the simple bug
> > fixes quickly, or else it might take a while since the next steps are more
> > complex and subject to many iterations I expect.
> > 
> > Cheers,
> > 
> > Guilherme
> > 
> > 
> >  drivers/hv/vmbus_drv.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 12a2b37e87f3..12585324cc4a 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2780,10 +2780,15 @@ static void __exit vmbus_exit(void)
> >  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> >  		kmsg_dump_unregister(&hv_kmsg_dumper);
> >  		unregister_die_notifier(&hyperv_die_block);
> > -		atomic_notifier_chain_unregister(&panic_notifier_list,
> > -						 &hyperv_panic_block);
> >  	}
> > 
> > +	/*
> > +	 * The panic notifier is always registered, hence we should
> > +	 * also unconditionally unregister it here as well.
> > +	 */
> > +	atomic_notifier_chain_unregister(&panic_notifier_list,
> > +					 &hyperv_panic_block);
> > +
> >  	free_page((unsigned long)hv_panic_page);
> >  	unregister_sysctl_table(hv_ctl_table_hdr);
> >  	hv_ctl_table_hdr = NULL;
> > --
> > 2.35.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
