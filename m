Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646EF3666F2
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Apr 2021 10:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhDUIZd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 04:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234632AbhDUIZc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 04:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618993499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bk8W5PYdHyJiKDovJRouAdDCNSetd5qB4OVJxOdiFwg=;
        b=LDkRp0Tj3nF3rLDMdRs4eQHvBjxwr5zi79nMsb8woptM7ERXXXgk7NIyUuJiptTUckLiuY
        L7hyiIRaCt9TIYX7gHR6kKaUItEfKrBjfvHqsm8qeirVp6Grxb6jxSb8KTTcxQiNv4c94f
        SPCUggI0Rk+UboLCzICgyMPB8SocdPA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-jaI-jcOHN_uV6ixvvRkSuw-1; Wed, 21 Apr 2021 04:24:55 -0400
X-MC-Unique: jaI-jcOHN_uV6ixvvRkSuw-1
Received: by mail-wr1-f70.google.com with SMTP id s7-20020adfc5470000b0290106eef17cbdso8857150wrf.11
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Apr 2021 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bk8W5PYdHyJiKDovJRouAdDCNSetd5qB4OVJxOdiFwg=;
        b=tx3AmqGblYyG8iHXU/a2AYW4dMlCyMQCvtambYZo1bBR3xUOFY3Q5zrmncXuu/+sRn
         oLDK72ZtJKFx+zcFQBoDQlH9JZ0IVEI5LmBbr+/6ajXbrp+OS/pyJmYFuZMpU7UZSxZJ
         f3V2iEMp6GeiBL3GJtM6GSoSvf24mDvmDx3dwbXHY7gn86v83+XuxumXibmlv36mjPAm
         iFCRFdmvl5JZ5v7TyoCtrGYl9Gxdo8+o/Y+LR5msT9Yc1agEGfKbUvZe5TA9IkD9F/7c
         biE28tXjJ/UIDGdnI+XVcgi4G7rwdDGMZrJnTmVDJwdMkItG5zETgI87zdALTjcXN9Mt
         1bXA==
X-Gm-Message-State: AOAM530cPp7v15SoDDDj1MmM9ucbqodg50gbUE+b/IqE7AJCv8yLcUyD
        npYgmY6WW9/q8rEr42qMFYMRjM1Kmg5mUvswWN4WP6ilaOnwz90FXmbzjG6/eO643yoyJZchLLK
        Yv2tk97mBR+7z+00MK5NVivh5
X-Received: by 2002:a7b:cd98:: with SMTP id y24mr8533419wmj.52.1618993494612;
        Wed, 21 Apr 2021 01:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz66JaAPB0MZ3k8rlE/+XxLnpLgswfnSuQ0gGhJbGsKo8b8e2liPNbXu1b7K15K8mCo+h3b7A==
X-Received: by 2002:a7b:cd98:: with SMTP id y24mr8533405wmj.52.1618993494454;
        Wed, 21 Apr 2021 01:24:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l13sm2067320wrt.14.2021.04.21.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:24:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 1/1] Drivers:
 hv: vmbus: Increase wait time for VMbus unload
In-Reply-To: <MWHPR21MB15937990D10174A63E65F579D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
 <87tuo1i9o5.fsf@vitty.brq.redhat.com>
 <MWHPR21MB15937990D10174A63E65F579D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Wed, 21 Apr 2021 10:24:53 +0200
Message-ID: <875z0ghwoa.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, April 20, 2021 2:32 AM
>> 
>> Michael Kelley <mikelley@microsoft.com> writes:
>> 
>> > When running in Azure, disks may be connected to a Linux VM with
>> > read/write caching enabled. If a VM panics and issues a VMbus
>> > UNLOAD request to Hyper-V, the response is delayed until all dirty
>> > data in the disk cache is flushed.  In extreme cases, this flushing
>> > can take 10's of seconds, depending on the disk speed and the amount
>> > of dirty data. If kdump is configured for the VM, the current 10 second
>> > timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
>> > complete message may arrive well after the kdump kernel is already
>> > running, causing problems.  Note that no problem occurs if kdump is
>> > not enabled because Hyper-V waits for the cache flush before doing
>> > a reboot through the BIOS/UEFI code.
>> >
>> > Fix this problem by increasing the timeout in vmbus_wait_for_unload()
>> > to 100 seconds. Also output periodic messages so that if anyone is
>> > watching the serial console, they won't think the VM is completely
>> > hung.
>> >
>> > Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload")
>> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> > ---
>> >
>> > Changed in v2: Fixed silly error in the argument to mdelay()
>> >
>> > ---
>> >  drivers/hv/channel_mgmt.c | 30 +++++++++++++++++++++++++-----
>> >  1 file changed, 25 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index f3cf4af..ef4685c 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -755,6 +755,12 @@ static void init_vp_index(struct vmbus_channel *channel)
>> >  	free_cpumask_var(available_mask);
>> >  }
>> >
>> > +#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
>> > +#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
>> > +#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
>> > +#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
>> > +#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
>> > +
>> >  static void vmbus_wait_for_unload(void)
>> >  {
>> >  	int cpu;
>> > @@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
>> >  	 * vmbus_connection.unload_event. If not, the last thing we can do is
>> >  	 * read message pages for all CPUs directly.
>> >  	 *
>> > -	 * Wait no more than 10 seconds so that the panic path can't get
>> > -	 * hung forever in case the response message isn't seen.
>> > +	 * Wait up to 100 seconds since an Azure host must writeback any dirty
>> > +	 * data in its disk cache before the VMbus UNLOAD request will
>> > +	 * complete. This flushing has been empirically observed to take up
>> > +	 * to 50 seconds in cases with a lot of dirty data, so allow additional
>> > +	 * leeway and for inaccuracies in mdelay(). But eventually time out so
>> > +	 * that the panic path can't get hung forever in case the response
>> > +	 * message isn't seen.
>> 
>> I vaguely remember debugging cases when CHANNELMSG_UNLOAD_RESPONSE never
>> arrives, it was kind of pointless to proceed to kexec as attempts to
>> reconnect Vmbus devices were failing (no devices were offered after
>> CHANNELMSG_REQUESTOFFERS AFAIR). Would it maybe make sense to just do
>> emergency reboot instead of proceeding to kexec when this happens? Just
>> wondering.
>> 
>
> Yes, I think there have been (and maybe still are) situations where we don't
> ever get the UNLOAD response.  But there have been bugs fixed in Hyper-V
> that I think make that less likely.  There's also an unfixed (and maybe not fixable)
> problem when not operating in STIMER Direct Mode, where an old-style
> timer message can block the UNLOAD response message.  But as the world
> moves forward to later kernel versions that use STIMER Direct Mode, that
> also becomes less likely.   So my inclination is to let execution continue on
> the normal execution path, even if the UNLOAD response message isn't
> received.  Maybe we just didn't wait quite long enough (even at 100 seconds).
> It's a judgment call, and it's not clear to me that doing an emergency reboot
> is really any better.
>
> As background work for this patch, we also discovered another bug in Hyper-V.
> If the kdump kernel runs and does a VMbus INITIATE_CONTACT while the
> UNLOAD is still in progress, the Hyper-V code is supposed to wait for the UNLOAD
> to complete, and then commence the VMbus version negotiation.  But it
> doesn't do that -- it finally sends the UNLOAD response, but never does the
> version negotiation, so the kdump kernel hangs forever.  The Hyper-V team
> plans to fix this, and hopefully we'll get a patch deployed in Azure, which
> will eliminate one more scenario where the kdump kernel doesn't succeed.
>

Ah, ok, if bugs in Hyper-V/Azure are being fixed then it seems
reasonable to keep the current logic (proceeding to kexec even when we
didn't receive UNLOAD). Thanks for the additional info!

-- 
Vitaly

