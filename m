Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258F319D994
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbgDCO4D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 10:56:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35649 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404013AbgDCO4D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 10:56:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id i19so8067778wmb.0;
        Fri, 03 Apr 2020 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xd2wdVuetpDXEk2PfqeNvx9TKWdzd+iderl1V/no1rk=;
        b=gzhPhWDMUJiPbQzetxHKg3B2DLbg58B5GmFYjdUT1AIlXXm+gz6k3AVtTsahrIkxsH
         8DO0zClHNS0Ave2j7H0mz7PSjGcWmi9BWILTWjRXCzaqn+zCLvyFe8kzQqOrTAUKbepE
         MeCeGhiu31wH9lx7fko++SK8dflLLQDr0af30yP3WNCwXXCblWM6N6vgIhkmzUTbZtNz
         f3p+kKFbA9YU9W4ZY0IU9K9LbvXJrNPMTxTK35TgeMCQRFx7nb8Qezu+gp3u+UtEBlsn
         kHus1bTOS2iFB0SgoRACqmmqe0Fx8KLZm6lhj8KpQIBtPkfEjtwCsKrejSD9asSqPX2b
         IDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xd2wdVuetpDXEk2PfqeNvx9TKWdzd+iderl1V/no1rk=;
        b=r0xwKTufvT4pisvLb9P2aJYkXSZNtJ2yTZfphb2hdI7GHzga7BAE49pB8FGtDB2zUx
         s2lwvNZuk65p7sOrKupPqiqpKdSkXCNwCVfnHCvYOHEjN0dntJxdhwg+fqPm1mRJ28ZV
         OnoCSqICbPy1gzk/7F1gHP8DllIug03X+dDEM/wM+OLvdUJFgM2dT+g8R8rnk7WMQdjm
         yv1lWLG/cqrw6QZlC9PgXKwiqG5WouABOT5tRSK2nEjA+fpHCoC4/OTZJSphHfr7Fu3E
         SdpQXh/i6Jbr9+1uUipnBrRtfoHjVgEwWW9u4ItCuOyP5bFBBTdi1SKw/HlYMXVJwH+L
         8v+g==
X-Gm-Message-State: AGi0PuaaAUNC/ayI6WaJdRtWNciwvCHbervGc7+YRk9uB8OJv62K9SWN
        6wYcwMeK1G8iTe68Xeeltz4=
X-Google-Smtp-Source: APiQypJudNVwFVtHeBX1+GEmZvJQyHXnuQqrcZUGVYDG3MPtBlvdos8jOclywHtAUNKANWwsEzU9zA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr9532306wmb.26.1585925760669;
        Fri, 03 Apr 2020 07:56:00 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id a15sm11562914wme.17.2020.04.03.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:56:00 -0700 (PDT)
Date:   Fri, 3 Apr 2020 16:55:53 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 10/11] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL message type
Message-ID: <20200403145533.GA26675@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-11-parri.andrea@gmail.com>
 <87v9mr41j4.fsf@vitty.brq.redhat.com>
 <20200328184821.GA12184@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328184821.GA12184@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > I can only think of a 'lazy' approach to setting channel CPU affinity:
> > we actually re-assign it to the target CPU when we receive first
> > interrupt there - but it's not very different from re-assigning it there
> > but still handling interrupts on the old CPU like you do.
> 
> Interesting!  I'm wondering whether it'd make sense to use a similar
> approach to (lazily) "unblock" the "old" CPUs; let me think more...

So, I spent some more time thinking about this...  AFAICT, one main
issue with this approach (besides the fact that we'd need to "save"
the "old" CPUs...) is that we might be blocking that CPU for "too
long" (depending on the channel/device usage); also, this approach
seemed to make the handling of target_cpu a bit more involved, and
this is a concern considered that (as mentioned before) we'd like to
keep the target_cpu of *all* channels in the system balanced.

I'm sticking to the approach implemented here for now: I'm planning
to send a new version of the series with minor changes soon.

Thanks,
  Andrea
