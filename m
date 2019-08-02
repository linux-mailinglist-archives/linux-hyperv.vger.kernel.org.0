Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46398009B
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391350AbfHBTC2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 15:02:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36143 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfHBTCZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 15:02:25 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so50800044iom.3;
        Fri, 02 Aug 2019 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LU1v53rpJU85ROHrGM2LXyEvX+BcLjuC9gY0fUSnT8U=;
        b=E6KIjL4Zoie0tQ3Oxl3zMRIe+CxD2LtJ4Ur4jIRbidsuSbkZ1MSaFApkDj0VVa5zLo
         rLeFWXOYjCn3g4fvwm8fJLHWTIvwnAD4Qb8yiFSD+ExRRylPVPaEAXY+DL6/rcaZJKoI
         Gcct0L7BGcak6Ttz4J9lREyAt8RXpQo8dGbeJw29De3/0eQDvoi6zO61k1OIKb6BlSWw
         iXSzUawdhSsxLZbVRovN0hggU4UGYf8MZWAH2+36SYThqEtSdDWkHkuahbGWvviIXOBB
         se4eAqW/zSTP/CVr8gTXby7GrQeRKBn9z+CNjAN1K5RCqKk14ZUv0y3jT7cSNfanEVwq
         Xrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LU1v53rpJU85ROHrGM2LXyEvX+BcLjuC9gY0fUSnT8U=;
        b=LZiwaakRu5ggI2791fIG/NA3nr9HXEDNv+sIosBUZe0xme66PlRPvF1NKCp3bhEqnv
         47Bru+ub338JW9fJtuWHEeMcBX1HwQW37pWQ622XGPi7tBdBCEuuAtbzfzJ7FFJ7u5dT
         LRsCw8ONs9PhBCGmqk81P1de+cnDbd+8y1JOtewh+9L01Sx4bCPIAFHLG+WcIG84PHbQ
         pY9u9HTqw5TG0byaaKRW7u2PMGn+4dmeNNfP1q9t+MTF44qILnSYR3YBwLaXWpa3prpT
         MATp/ZVfFYvBIZ/wzmwMpI/CxJtq7o/G9c9gYc1x2QONE6sG/XI2m5mJokIf6dCMRB17
         Wd2Q==
X-Gm-Message-State: APjAAAU7TkBdc2vKbEJPwrSis3NlWmiJVAMtYs7GpF0pq3iXMoRqLMd2
        +KQy0gXE9V1u0nOldBhb0g==
X-Google-Smtp-Source: APXvYqyiicCe8RFdyINyOeMNu1vMfsPrOvU9rRMEgC1UlObsouSg7VyAv38wUS/Q626R+16jkTKa+Q==
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr2186608ios.57.1564772544219;
        Fri, 02 Aug 2019 12:02:24 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id p3sm119176019iom.7.2019.08.02.12.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 12:02:23 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:02:22 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH 2/3] drivers: hv: vmbus: add fuzz test attributes to sysfs
Message-ID: <20190802190222.GA27277@Test-Virtual-Machine>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
 <20f96dba927eaa42fceeebfc7a6a37f3b1a9ee65.1564527684.git.brandonbonaby94@gmail.com>
 <87a7csggvj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7csggvj.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 09:34:40AM +0200, Vitaly Kuznetsov wrote:
> Branden Bonaby <brandonbonaby94@gmail.com> writes:
> 
> > Expose the test parameters as part of the sysfs channel attributes.
> > We will control the testing state via these attributes.
> >
> > Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> > ---
> >  Documentation/ABI/stable/sysfs-bus-vmbus | 22 ++++++
> >  drivers/hv/vmbus_drv.c                   | 97 +++++++++++++++++++++++-
> >  2 files changed, 118 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> > index 8e8d167eca31..239fcb6fdc75 100644
> > --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> > +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> > @@ -185,3 +185,25 @@ Contact:        Michael Kelley <mikelley@microsoft.com>
> >  Description:    Total number of write operations that encountered an outbound
> >  		ring buffer full condition
> >  Users:          Debugging tools
> > +
> > +What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_state
> 
> I would prefer this to go under /sys/kernel/debug/ as this is clearly a
> debug/test feature.
> -- 
> Vitaly

Alright, it is testing so I see what you mean and why the code in 
this patch should go in debugfs. Will fix that and resend.

Branden Bonaby 
