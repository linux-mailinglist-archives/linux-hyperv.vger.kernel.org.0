Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608DA2B1DB2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMOvL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 09:51:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34003 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOvK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 09:51:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id r17so10234464wrw.1;
        Fri, 13 Nov 2020 06:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aAlmyA4sfYYrPjrQD695bEObeqnhiYZCjllcBnn0e5k=;
        b=TnAW1wf5CKPIV63JcECSbhI2Wg24FHUPACVebIHjpwE+1SQDgPyHexpak5mAnmlLaf
         uYIqJiYarmvRgV/qcxrE8rRzdZq9ZLB8SBvevlFXVTGSG9uLRpIBQjJ5x6gWhyjLCGUR
         wf3rsAvx8hU2FkDCBvFLsz0JN4NK8xFqY+y5vIdvrLVejIa93dn1WIbshNgXnt/i2j/l
         v7wOpWEF3e/VLYLh4SEV+w/ZEheqfZepv47H4RBSZk+xNeco+wtqijH8U8+MZ38x2m88
         N/JAIwGgqkNlOOX1eehxxL2omev+g2JiSGaTiVqW78toaTEoY661C4dnvZLbSDtjlzpl
         fNQQ==
X-Gm-Message-State: AOAM533wWrRtwMyM6FtrE0wHidEzhG4Eu3q6YMJ3E6lk2l8rSWRahvjX
        076TIKHFdArsVDiwzQNIQho=
X-Google-Smtp-Source: ABdhPJyGBkq3j9fFqjeueSZX46lLXN1F5neV8oNQAbZqbarx52SOLQVZz9CqIiA4OIOiFcHhRqYHpg==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr3823980wrq.309.1605279068895;
        Fri, 13 Nov 2020 06:51:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g138sm10560175wme.39.2020.11.13.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:51:08 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:51:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v2 03/17] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
Message-ID: <20201113145106.k4ekiw5cu427e3wi@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-4-wei.liu@kernel.org>
 <87imaay4w9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imaay4w9.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:24:38PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > There is no VMBus and the other infrastructures initialized in
> > hv_acpi_init when Linux is running as the root partition.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/hv/vmbus_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 4fad3e6745e5..37c4d3a28309 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
> >  	if (!hv_is_hyperv_initialized())
> >  		return -ENODEV;
> >  
> > +	if (hv_root_partition)
> > +		return -ENODEV;
> > +
> 
> Nit: any particular reason why we need to return an error from here? I'd
> suggest we 'return 0;' if it doesn't break anything (we're still running
> on Hyper-V, it's just a coincedence that there's nothing to do here,
> eventually we may get some devices/handlers I guess. Also, there's going
> to be server-side Vmbus eventually, we may as well initialize it here.

Returning 0 should be fine. It is not likely to make any practical
difference at this stage.

Not sure what you mean by server-side Vmbus. If you mean Vmbus on the
host, yes, there will be. The initialization is, again, a bit different
there.  You will see why when my colleague post /dev/mshv code. The long
term goal is to refactor the Vmbus initialization code to work in all
scenarios.  We are not there yet though.

Wei.

> 
> >  	init_completion(&probe_event);
> >  
> >  	/*
> 
> -- 
> Vitaly
> 
