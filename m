Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA723EE72
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Aug 2020 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHGNti (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Aug 2020 09:49:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40486 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHGNte (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Aug 2020 09:49:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id k20so1907173wmi.5;
        Fri, 07 Aug 2020 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvDB1R7/fz/MRMKaaPVGRhilQhRguSriuVDfLnfR5hM=;
        b=afoZvi+Lp/bS+PctC02U7j5qIlCR+se8j7IggAWwri/6bL4x5tMUNURVUn6O/8JLqc
         tp3ywx5PsE7TFQ1y8DlptraKSbC5XWVfPoqwKoSgoDQ1bi88uy/44xzefS++aedrPVf1
         2MqxnW2utQKiMIXwMjN5gM8QruNYSwNaFN/2hsJdpKqeEiFwGJ1DKjOCIPVUOZx8PVP+
         ijJONyGkWerQZSFoQc9V64QKpPjuYGQSRd/cd+8QGaCErUsy92Xh+JDH6J03gR+v1X0B
         h5bkoy1uNM5LTNnVsQnq0U+7JHEZdaBUnpnhDMBLLrYPkOSort7VfUk+RRydf+E2KkI/
         uw9g==
X-Gm-Message-State: AOAM530koWqMPpTTQmC6fMrlV9HoUBa/Q66lP04uAMuQxTdyZLmIkqMC
        5K5oU0OCJuZ6dl+uRSqF7B8=
X-Google-Smtp-Source: ABdhPJz1TMkcfEaz6ZNJkbXt1tWugQb6eY4Iitz/Ydvx+aR4R7NDUT+9N6dt8NydrSom/64m16cpIA==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr12195084wmc.115.1596808172161;
        Fri, 07 Aug 2020 06:49:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a3sm10445484wme.34.2020.08.07.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:49:31 -0700 (PDT)
Date:   Fri, 7 Aug 2020 13:49:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Only notify Hyper-V for die
 events that are oops
Message-ID: <20200807134930.tzdfbt7ekcetvnxu@liuwe-devbox-debian-v2>
References: <1596730935-11564-1-git-send-email-mikelley@microsoft.com>
 <87o8nmome0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8nmome0.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 07, 2020 at 11:06:47AM +0200, Vitaly Kuznetsov wrote:
> Michael Kelley <mikelley@microsoft.com> writes:
> 
> > Hyper-V currently may be notified of a panic for any die event. But
> > this results in false panic notifications for various user space traps
> > that are die events. Fix this by ignoring die events that aren't oops.
> >
> > Fixes: 510f7aef65bb ("Drivers: hv: vmbus: prefer 'die' notification chain to 'panic'")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index b50081c..910b6e9 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -86,6 +86,10 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
> >  	struct die_args *die = (struct die_args *)args;
> >  	struct pt_regs *regs = die->regs;
> >  
> > +	/* Don't notify Hyper-V if the die event is other than oops */
> > +	if (val != DIE_OOPS)
> > +		return NOTIFY_DONE;
> > +
> 
> Looking at die_val enum, DIE_PANIC also sounds like something we would
> want to report but it doesn't get emitted anywhere and honestly I don't
> quite understand how is was supposed to be different from DIE_OOPS.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes.

Wei.

> 
> >  	/*
> >  	 * Hyper-V should be notified only once about a panic.  If we will be
> >  	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
> 
> -- 
> Vitaly
> 
