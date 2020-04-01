Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3319B5FD
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2020 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgDASxl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Apr 2020 14:53:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33930 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASxk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Apr 2020 14:53:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id c195so4188293wme.1;
        Wed, 01 Apr 2020 11:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gABD0nQMKQ+AayjxHslKqozn5LgoJ0N6roIyuryx81M=;
        b=NXEWtNr0W+1Z6G7PgZVmAnAHWnbpfJtpnmkbtu76pd/ueWaYnh0jWUETLUXXzmXyP6
         ibmyp/Pjalh95x6mLMfXRZ9L28yuNwc+ndq18+ggb4p0rZS0BYwxg49rUU2STuDC5yga
         HzLZlP2BiHJYMJ6QrQvV5PwE3JT++lNBdvRv+q/3CkqXhmSW9/xhUKEME5wo8bNrMkIm
         kCxpehG3OyuR8kJOsrTROI8CciI/XcfvOvuVCTaXe/MoBj1LYix++Gve9rZRDxYhY3/w
         rQe3Ev6Y6+AqLEayJnae7rM4nLHssS+fvjj8nI22fUcpiT34yc56wfxghOBPhuNu2KlH
         4dKw==
X-Gm-Message-State: AGi0PuanXjKWOe3gM7FDEqgshbzVh/At2HUto62PeJxPxPft2O2YTi2g
        kcHa4A2920qOd4prOtZ+f4M=
X-Google-Smtp-Source: APiQypLYYrp2fUjosqz6TqlRn2Br/HKN0fbVC9t7zSABK/GBt5LHLk8cLtpJr6pH5BRTkiAE+C/aaQ==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr6117812wmc.68.1585767219131;
        Wed, 01 Apr 2020 11:53:39 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id h132sm3977863wmf.18.2020.04.01.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:53:38 -0700 (PDT)
Date:   Wed, 1 Apr 2020 19:53:36 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Message-ID: <20200401185336.fsnwxejwn3nd5lhx@debian>
References: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
 <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052A8FEF85F381B3EAF7D36D7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <9eb81216-8e00-64e5-ab1c-b363983b245e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eb81216-8e00-64e5-ab1c-b363983b245e@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 31, 2020 at 10:26:06PM +0800, Tianyu Lan wrote:
> 
> 
> On 3/31/2020 9:51 PM, Michael Kelley wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 31, 2020 12:39 AM
> > > 
> > > When oops happens with panic_on_oops unset, the oops
> > > thread is killed by die() and system continues to run.
> > > In such case, guest should not report crash register
> > > data to host since system still runs. Fix it.
> > > 
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > > ---
> > > Change since v3:
> > > 	Fix compile error
> > > ---
> > >   drivers/hv/vmbus_drv.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 172ceae69abb..4bc02aea2098 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -31,6 +31,7 @@
> > >   #include <linux/kdebug.h>
> > >   #include <linux/efi.h>
> > >   #include <linux/random.h>
> > > +#include <linux/kernel.h>
> > 
> > Unfortunately, adding the #include doesn't solve the problem.  The error occurs when
> > CONFIG_HYPERV=m, because panic_on_oops is not exported.  I haven't thought it
> > through, but hopefully there's a solution where panic_on_oops can be tested in
> > hyperv_report_panic() or some other Hyper-V specific function that's never in a
> > module, so that we don't need to export panic_on_oops.
> 
> Yes, I don't consider modules case. I think we may introduce a check
> function of panic_on_oops in the mshyperv.c and expose it to module.
> 

Why expose something new? You can just test panic_on_oops in
hyperv_report_panic and bail if it is false, right?

Something like the following (not compiled) diff:

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b0da5320bcff..0dc229a9142c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -424,6 +424,9 @@ void hyperv_report_panic(struct pt_regs *regs, long err)
        static bool panic_reported;
        u64 guest_id;

+       if (!panic_on_oops)
+               return;
+
        /*
         * We prefer to report panic on 'die' chain as we have proper
         * registers to report, but if we miss it (e.g. on BUG()) we need

I haven't checked all the error reporting paths and don't know if this
works or not though.

Wei.
