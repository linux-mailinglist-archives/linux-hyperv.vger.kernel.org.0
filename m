Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4380093
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfHBTCF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 15:02:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41597 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbfHBTCF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 15:02:05 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so150268415ioj.8;
        Fri, 02 Aug 2019 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cg39H2VNzTuG3+WBUWDglAjB91SXV5TEH8pFiAs4tqc=;
        b=GozK4p3iBsoNfloIGkbcBFk76im6JeO3vuVVmfoYScZs08Fkx7M1XwKw8zHyRzaRId
         URhY/BYy5EEjNq2KYaaWjr2YZUElVSzhmpW7L+er2Ey6WNhU2l4tMrgQjGEHZ271HoT5
         r8u432JeZkMpbmUSE8W1yodNaJyM5KnSpj+Q6sgk7jrgodkLRYZzB/oyy4/t504ilxhI
         6Zpe5Jr/YYQosTPuG3PwfaZNt0oHaXgTiaCOmkR6WM9Lr5KrDmmnUWBHiwckcfCp8Xzt
         YJkINiEXBZPgxvaaO2mX0l5ici1vSYnXa5ntzDNWIbK+zv9pMeQ1WeDCOqY2mNaWp1e6
         AUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cg39H2VNzTuG3+WBUWDglAjB91SXV5TEH8pFiAs4tqc=;
        b=iJ6ajOiQOxLypTJB8BTBLJmgBtnIUIE0Kqp/Jcfq8+NA5DarYc6XpImYZrz15uOQop
         F82IlgsUbRmq8KZN3kuqHYLPG0CdalGhNrjjQNo3YhpnEwr8hd5+x83bAk+E57TCja57
         +7YHmygufU9NiWmJlRWuvk4O17J9x1L55UP0i62qT45uEllbzWsbjbXYBIeYLQdKo42H
         0KbIE6DlDMl/wc4rWKpXhlahdwphMTjxkMlraxKEV7wkWudmLPBv0RNkLGM0mrNZIfAs
         SoSIl+oMkNsySi4xKX0+p0Q9kJJrQOoeGpr0FVmGOLa9LsuVIQEcRBNCNPElpJcYJXsU
         8mtg==
X-Gm-Message-State: APjAAAUZsWi7nTGrJWTvar7aJbJc1Ibp8xlvw30Il/wnRURVw05M5KYu
        OESv7haAcoC2qA19XJeVTg==
X-Google-Smtp-Source: APXvYqyXzb1wAAEaTeZj7fl8imRnLcsEqdVjvvrqppYBo4stseB0zoVv1Qo/sXiEwU+IKXMcaR5PYw==
X-Received: by 2002:a5d:890d:: with SMTP id b13mr10957395ion.124.1564772524465;
        Fri, 02 Aug 2019 12:02:04 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id d25sm62545657iom.52.2019.08.02.12.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 12:02:03 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:02:01 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH 0/3] hv: vmbus: add fuzz testing to hv devices
Message-ID: <20190802190201.GA26975@Test-Virtual-Machine>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
 <87ftmkgh2t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftmkgh2t.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 09:30:18AM +0200, Vitaly Kuznetsov wrote:
> Branden Bonaby <brandonbonaby94@gmail.com> writes:
> 
> > This patchset introduces a testing framework for Hyper-V drivers.
> > This framework allows us to introduce delays in the packet receive
> > path on a per-device basis. While the current code only supports 
> > introducing arbitrary delays in the host/guest communication path,
> > we intend to expand this to support error injection in the future.
> >
> > Branden Bonaby (3):
> >   drivers: hv: vmbus: Introduce latency testing
> >   drivers: hv: vmbus: add fuzz test attributes to sysfs
> >   tools: hv: add vmbus testing tool
> >
> >  Documentation/ABI/stable/sysfs-bus-vmbus |  22 ++
> >  drivers/hv/connection.c                  |   5 +
> >  drivers/hv/ring_buffer.c                 |  10 +
> >  drivers/hv/vmbus_drv.c                   |  97 ++++++-
> 
> Can we have something like CONFIG_HYPERV_TESTING and put this new 
> code under #ifdef?
> 
> >  include/linux/hyperv.h                   |  14 +
> >  tools/hv/vmbus_testing                   | 326 +++++++++++++++++++++++
> >  6 files changed, 473 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/hv/vmbus_testing
> 
> -- 
> Vitaly

You're right, it would be better to do it that way with ifdef's.
Will edit my patches and resend.

Branden Bonaby
