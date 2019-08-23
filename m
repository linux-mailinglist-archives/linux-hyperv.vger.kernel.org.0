Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156A99A61A
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 05:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391563AbfHWDiy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 23:38:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42462 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732546AbfHWDiy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 23:38:54 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so16804801iob.9;
        Thu, 22 Aug 2019 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9AVmOGbIsZQv/2ofQ4IWa2M0lJ73id2YbZ5T55/p234=;
        b=PNR/OnrFCJ9qWeHxxTo4/BXyJ5MRxGDYxwDBxmStRgGs9mHapBSw1jexOrtcuQr3k5
         VIPHTSUmPR01mjhRc7xOPXvEMXgvOveli84/jJ+G2N9BRaN5RJCA0wk9EGvgcuL8GGrE
         Ob4Zj2UVDkKerW26MCqxscJxkdJ8WWmphgGxwZXiTLWp2qY6wpVkGmlBPs5p+pbZlyDe
         y0QBO52bDZ/SDBK51ArRMrize4hT0+HK93PKe+uj1A/B1jittjlnsD2J5aXj56sLqToN
         VwNwt4DP854MhJWMb4Ua81ZQJ8AQP/QdlUEusPHxtgPFeZVsd4pDwXihfCxmbWvG3AZ3
         cQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9AVmOGbIsZQv/2ofQ4IWa2M0lJ73id2YbZ5T55/p234=;
        b=jLptAbjMwCpVWbl7SHkvQU70miVw8cglCvYIlI6G1gIinypJvIXgzcPb7R61xBMNaD
         qOudDyHmLwBG8CqpmyOWiFMwcP7tnGG2tImpsGYDyIk1plKiQw33d21xdu+YdRImy+zS
         e64isnsIy/9+WK83BdwTSGsAgO5u/wseHNbDuOj7r+b1OidH6286p8AqWTSHJN/B08xp
         56sSZ6Kfj1Bc1zRq+0NJhDAmpT/BB/tXi47tMQUT8spYQUNj7FETmr9Egf2PO2wiG8gr
         E04ek13KGXK7TW0MWErt85y0jizFN846ClIi3uziULQHw6Qx0KMwUyUH8hMbe77WnXAV
         fbqg==
X-Gm-Message-State: APjAAAVoZo/4ZIkcUFHNyw/GjJTDTETKTkl/ZZcaQr/iA7+hs8L6eYRK
        muZ0RK6ERLmQSQOmbH4pmhMMK6Mgi3xL
X-Google-Smtp-Source: APXvYqxOSeQzfdWxi6gD2CNj2oB78c97wZV62Bm56NMa2OFeGRqMmzwosu33VmbJlnggbs0myRlUzg==
X-Received: by 2002:a6b:4a11:: with SMTP id w17mr3777472iob.21.1566531532816;
        Thu, 22 Aug 2019 20:38:52 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id y19sm1221442ioj.62.2019.08.22.20.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 20:38:52 -0700 (PDT)
Date:   Thu, 22 Aug 2019 23:38:50 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190823033850.GA41496@Test-Virtual-Machine>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
 <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
 <DM5PR21MB01375C24AE9ECD93DBE856C2D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01375C24AE9ECD93DBE856C2D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> >  endmenu
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > index 09829e15d4a0..c9c63a4033cd 100644
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -357,6 +357,9 @@ void vmbus_on_event(unsigned long data)
> > 
> >  	trace_vmbus_on_event(channel);
> > 
> > +#ifdef CONFIG_HYPERV_TESTING
> > +	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> > +#endif /* CONFIG_HYPERV_TESTING */
> 
> You are following Vitaly's suggestion to use #ifdef's so no code is
> generated when HYPERV_TESTING is not enabled.  However, this
> direct approach to using #ifdef's really clutters the code and makes
> it harder to read and follow.  The better approach is to use the
> #ifdef in the include file where the functions are defined.  If
> HYPERV_TESTING is not enabled, provide a #else that defines
> the function with an empty implementation for which the compiler
> will generate no code.   An as example, see the function definition
> for hyperv_init() in arch/x86/include/asm/mshyperv.h.  There are
> several functions treated similarly in that include file.
> 

I checked out the code in arch/x86/include/asm/mshyperv.h, after
thinking about it, I'm wondering if it would be better just to have
two files one called hv_debugfs.c and the other hyperv_debugfs.h.
I could put the code definitions in hv_debugfs.c and at the top
include the hyperv_debugfs.h file which would house the declarations
of these functions under the ifdef. Then like you alluded too use
an #else statement that would have the null implementations of the
above functions. Then put an #include "hyperv_debugfs.h" in the
hyperv_vmbus.h file. I figured instead of putting the code directly
into the vmbus_drv.c file it might be best to put them in a seperate
file like hv_debugfs.c. This way when we start adding more tests we
don't bloat the vmbus_drv.c file unnecessarily. The hv_debugfs.c
file would have the #ifdef CONFIG_HYPERV_TESTING at the top so if
its not enabled  those null implementations in "hyperv_debugfs.h"
woud kick in anywhere that included the hyperv_vmbus.h file which
is what we want.

what do you think?

> 
> >  	do {
> >  		void (*callback_fn)(void *);
> > 
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index 362e70e9d145..edf14f596d8c 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -357,4 +357,24 @@ enum hvutil_device_state {
> >  	HVUTIL_DEVICE_DYING,     /* driver unload is in progress */
> >  };
> > 
> > +#ifdef CONFIG_HYPERV_TESTING
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> 
> Generally #include files should go at the top of the file, even if they
> are only needed conditionally.
>

I see , will change

> > +#define TESTING "hyperv"
> 
> I'm not seeing what this line is for, or how it is used.

I used it as the top level name for the dentry that
would appear in debugfs but now I realize its actually
not needed, so i'll remove this.

> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -926,6 +926,21 @@ struct vmbus_channel {
> >  	 * full outbound ring buffer.
> >  	 */
> >  	u64 out_full_first;
> > +
> > +#ifdef CONFIG_HYPERV_TESTING
> > +	/* enabling/disabling fuzz testing on the channel (default is false)*/
> > +	bool fuzz_testing_state;
> > +
> > +	/* Interrupt delay will delay the guest from emptying the ring buffer
> > +	 * for a specific amount of time. The delay is in microseconds and will
> > +	 * be between 1 to a maximum of 1000, its default is 0 (no delay).
> > +	 * The  Message delay will delay guest reading on a per message basis
> > +	 * in microseconds between 1 to 1000 with the default being 0
> > +	 * (no delay).
> > +	 */
> > +	u32 fuzz_testing_interrupt_delay;
> > +	u32 fuzz_testing_message_delay;
> > +#endif /* CONFIG_HYPERV_TESTING */
> 
> For fields in a data structure like this, you don't have much choice
> but to put the #ifdef directly inline.  However, for small fields like this
> and where the data structure isn't size sensitive, you could consider
> omitting the #ifdef and just always including the fields even when
> HYPERV_TESTING is not enabled.  I don't have a strong preference
> either way.
>

I'll take the ifdefs out since the fields aren't too big

