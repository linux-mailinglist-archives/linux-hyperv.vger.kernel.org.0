Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA599B599
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404122AbfHWRgi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 13:36:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42260 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404120AbfHWRgh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 13:36:37 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so21808994iob.9;
        Fri, 23 Aug 2019 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sG7Oz4tvlMM9D073f9jigVody4k5I2Lxm5iPrqf1t3c=;
        b=VLHtmtxk+kIuuTecA1rRwr2eiqLViPkFFbL1AhBsBkoC/sY5DGnPavOBKPzDloXNXz
         4pjNGcTejGbcDiOT/0xvOPV6sA3giWUAzDpAmbkuK7qkuFdtH0Dw1bCTrE70r6gf3ZvG
         ZAML6M1a2hXQ4MT24lRkKGnpYFDNSy0rsSQ4GwWIOg8ptQN6hkjFiBiFy1VfP8NSZ0A9
         km5P1g1g86OAs1YHbRXOtoEVTUGNTk2ezba6PmeyAVdPjcL4/rj/jOTcOMzAn6H/e2nj
         h32oFnFWWFj8MiuA9TNQEn911C0IfbDwh7qTN3YQWMuCr5Z6c98gFiaw83IWMlxT3XoS
         UQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sG7Oz4tvlMM9D073f9jigVody4k5I2Lxm5iPrqf1t3c=;
        b=IvqTI3/3UKDdGa+zjYjtM504+O+zsLBEcx7B34MB46i504aBwYoDWyt23MPAqZCZRH
         gXmuWe/7snFRQxOUG/vCpMHRB0Q9jSWMA9zpUgBXQUQ+yn+cLhpW3hr8E6uHC9pdCZtf
         wteKNPtj2+J6F303dTWCtmXDqS+ktCTpQmMrtSw3cHoir2/LO3KaRvatA8fw1t90lhPt
         ou6llh0mTwlBdfesHIIkSB3GFB3AOdqVtMKnBuq9nbknf6Uq1zLO1UEIK3hiy5TpfyJd
         8zRHlRe1QG8LGr/u85X7n8UEVS3tEjR7GtkB+eUSoXPjSbozHb7EfbzqGBZ8mT1+CI39
         iVHg==
X-Gm-Message-State: APjAAAWWbbReqVo7c0yCX5Bxgj+f+39KjZZIeLfwjKSBNhkfHg6NNMKA
        4yo9vm0V9spFMXUqYIrQKw==
X-Google-Smtp-Source: APXvYqw7tNl24KnjTijUUlCAayNH+6INZQwey5kTzsCzyNQ6z754f4S45VQpIQU6ki7yyFC/WsWFBg==
X-Received: by 2002:a05:6638:213:: with SMTP id e19mr5734428jaq.119.1566581796175;
        Fri, 23 Aug 2019 10:36:36 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id y25sm5539253iol.59.2019.08.23.10.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 10:36:35 -0700 (PDT)
Date:   Fri, 23 Aug 2019 13:36:33 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190823173633.GA43233@Test-Virtual-Machine>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
 <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
 <DM5PR21MB01375C24AE9ECD93DBE856C2D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20190823033850.GA41496@Test-Virtual-Machine>
 <DM5PR21MB01379300AF2B441D0B53692DD7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01379300AF2B441D0B53692DD7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 23, 2019 at 04:44:09PM +0000, Michael Kelley wrote:
> From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Thursday, August 22, 2019 8:39 PM
> > > > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > > > index 09829e15d4a0..c9c63a4033cd 100644
> > > > --- a/drivers/hv/connection.c
> > > > +++ b/drivers/hv/connection.c
> > > > @@ -357,6 +357,9 @@ void vmbus_on_event(unsigned long data)
> > > >
> > > >  	trace_vmbus_on_event(channel);
> > > >
> > > > +#ifdef CONFIG_HYPERV_TESTING
> > > > +	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> > > > +#endif /* CONFIG_HYPERV_TESTING */
> > >
> > > You are following Vitaly's suggestion to use #ifdef's so no code is
> > > generated when HYPERV_TESTING is not enabled.  However, this
> > > direct approach to using #ifdef's really clutters the code and makes
> > > it harder to read and follow.  The better approach is to use the
> > > #ifdef in the include file where the functions are defined.  If
> > > HYPERV_TESTING is not enabled, provide a #else that defines
> > > the function with an empty implementation for which the compiler
> > > will generate no code.   An as example, see the function definition
> > > for hyperv_init() in arch/x86/include/asm/mshyperv.h.  There are
> > > several functions treated similarly in that include file.
> > >
> > 
> > I checked out the code in arch/x86/include/asm/mshyperv.h, after
> > thinking about it, I'm wondering if it would be better just to have
> > two files one called hv_debugfs.c and the other hyperv_debugfs.h.
> > I could put the code definitions in hv_debugfs.c and at the top
> > include the hyperv_debugfs.h file which would house the declarations
> > of these functions under the ifdef. Then like you alluded too use
> > an #else statement that would have the null implementations of the
> > above functions. Then put an #include "hyperv_debugfs.h" in the
> > hyperv_vmbus.h file. I figured instead of putting the code directly
> > into the vmbus_drv.c file it might be best to put them in a seperate
> > file like hv_debugfs.c. This way when we start adding more tests we
> > don't bloat the vmbus_drv.c file unnecessarily. The hv_debugfs.c
> > file would have the #ifdef CONFIG_HYPERV_TESTING at the top so if
> > its not enabled  those null implementations in "hyperv_debugfs.h"
> > woud kick in anywhere that included the hyperv_vmbus.h file which
> > is what we want.
> > 
> > what do you think?
> > 
> 
> I'll preface my comments by saying that how code gets structured
> into files is always a bit of a judgment call.  The goal is to group code
> into sensible chunks to make it easy to understand and to make it
> easy to modify and extend later.  The latter is a prediction about the
> future, which may or may not be accurate.   For the former, what's
> "easy to understand," is often in the eye of the beholder.  So you may
> get different opinions from different reviewers.
> 
> That said, I like the idea of a separate hv_debugfs.c file to contain
> the implementation of the various functions you have added to
> provide the fuzzing capability.   I'm less convinced about the value
> of a separate hyperv_debugfs.h file.   I think you have one big
> #ifdef CONFIG_HYPERV_TESTING followed by the declarations of
> the functions in hv_debugfs.c, followed by #else and null
> implementations of those functions.  This is 20 lines of code or so,
> and could easily go in hyperv_vmbus.h.
> 
> For the new hv_debugfs.c, you can avoid the need for
> #ifdef CONFIG_HYPERV_TESTING by modifying the Makefile in
> drivers/hv so that hv_debugfs.o is built only if CONFIG_HYPERV_TESTING
> is defined.  Look at the current Makefile to see how this is done
> with CONFIG_HYPERV_UTILS and CONFIG_HYPERV_BALLOON.
> 
> Michael
>

I see, that does make sense, I'll go ahead and add these changes.

thanks

branden bonaby
