Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D62EC12B
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAFQYU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 11:24:20 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38535 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbhAFQYU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 11:24:20 -0500
Received: by mail-wr1-f54.google.com with SMTP id r7so2950836wrc.5;
        Wed, 06 Jan 2021 08:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+hC9DvKOanZlSAHqP8+E54nE4aEfcVp9G0WYEjhUlOE=;
        b=Yg19HpT4O/jxJqntwMRg+QH2reIvqZ6J2GO9oeiSZE9U6MjAwlY6HQvdCvr7dziWty
         Qi0jbUnn7JpdCa2YrYmgjCx0HNVCM/Ri2kLjC3IAsjoI5RRPY850X4B76QVq8kq0oIWs
         jy3roh5cq4Z86WqKGl/g7grt6l0TNZQ8FKYSB8L8o0Wzlexx6r54Pn1lE4JTOznqYJG8
         t8d2XT1zF24cavg52kGiKc9tQGzkmKKIRpCI3VC878pD+X8yZE//4jUVcqkzn6JS86ns
         d7gGENrhq25kY9yOXOkr+Va43oZQEz2GNVRWhlk3lVDcanpg1NSXt3iGjJwR78X/OVUx
         QcBw==
X-Gm-Message-State: AOAM531zUg63SK9JHCjGbKvsThpurlMVgOAlbVG6MO5UkBc7wCuCt4bI
        G4OqilwuZC7xwnVtPo2JqWI=
X-Google-Smtp-Source: ABdhPJywY7DbXp5+EicONC3sXVZrHpltDREfn0bI0ALbiiotzcxxna/Zkrq/R3t3B3IOZYe6BCX11g==
X-Received: by 2002:adf:d082:: with SMTP id y2mr5056270wrh.301.1609950217599;
        Wed, 06 Jan 2021 08:23:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y7sm3713889wmb.37.2021.01.06.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 08:23:37 -0800 (PST)
Date:   Wed, 6 Jan 2021 16:23:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Message-ID: <20210106162335.apqevxx2achwsirj@liuwe-devbox-debian-v2>
References: <20201223001222.30242-1-decui@microsoft.com>
 <20210105125805.7yypaghcpgafsrcs@liuwe-devbox-debian-v2>
 <MW2PR2101MB18197FBF40A9EC6313FCB5B1BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB18197FBF40A9EC6313FCB5B1BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 11:04:15PM +0000, Dexuan Cui wrote:
> > From: Wei Liu <wei.liu@kernel.org>
> > Sent: Tuesday, January 5, 2021 4:58 AM
> > > ...
> > >  Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
> > >  drivers/hv/vmbus_drv.c                   | 20
> > ++++++++++++++++++++
> > >  2 files changed, 27 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus
> > b/Documentation/ABI/stable/sysfs-bus-vmbus
> > > index c27b7b89477c..3ba765ae6695 100644
> > > --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> > > +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> > > @@ -1,3 +1,10 @@
> > > +What:		/sys/bus/vmbus/supported_features
> > > +Date:		Dec 2020
> > > +KernelVersion:	5.11
> > 
> > Too late for 5.11 now.
> 
> The patch was posted 2 weeks ago, before 5.11-rc1. :-)
> 
> If possible, we still want this patch to be in 5.11, because:
> 1. The patch is small and IMO pretty safe.
> 2. The patch adds new code and doesn't really change any old code.
> 3. The patch adds a new sys file, which is needed by some
> user space tool to auto-setup the configuration for hibernation.
> We'd like to integrate the patch into the Linux distros ASAP and
> as we know some distros don't accept a patch if it's not in the
> mainline.
> 
> So, if the patch itself looks good, IMO it would be better to be
> in v5.11 rather than in v5.12, which will need extra time of
> 2~3 months.
> 
> That said, I don't know if there is any hard rule in regard of
> the timing here. If there is, then v5.12 is OK to me. :-)
>  

By the time you posted this (Dec 22), 5.11 was already more or less
"frozen". Linus wanted -next patches to be merged before Christmas.

The way I see it this is a new sysfs interface so I think this is
something new, which is for 5.12.

Do you think this should be considered a bug fix?

Wei.

> > Given this is a list of strings, do you want to enumerate them in a
> > Values section or the Description section?
> > 
> > Wei.
> 
> Currently there is only one possible string "hibernation".
> Not sure if we would need to add more strings in future, but yes
> it's a good idea to list the string in a "Value" section. 
> 
> Will post v2 shortly.
> 
> Thanks,
> -- Dexuan
