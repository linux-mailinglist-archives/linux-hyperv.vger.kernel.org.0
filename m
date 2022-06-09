Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB4544E81
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiFIOPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiFIOPq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 10:15:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE2D703F9;
        Thu,  9 Jun 2022 07:15:45 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 8DA9B20BE67A; Thu,  9 Jun 2022 07:15:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DA9B20BE67A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654784145;
        bh=ZzQ8s+JLlHZSFP0kGBR5neakWDODON3S1FHot9s2MIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKtzLefkltxNUcqgVJDYcBwRKwEFFgS+8QLXFwXYcD5QNTcGPWosXjC8TDLEaBVOi
         fEzLu3/4Jv4LHaRYj1TTatoi4Jb938KlyyNrgjNdX+Q1+4n2gd72emHGB8cADoAgDi
         61E6mToqHcw0CgvFvK91urcd7lopNwBAPqBIgEXs=
Date:   Thu, 9 Jun 2022 07:15:45 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Message-ID: <20220609141545.GA15934@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1654752446-20113-1-git-send-email-ssengar@linux.microsoft.com>
 <PH0PR21MB30251360E8081A96F5A33F3ED7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DM5PR21MB17495741194946995BA2F7D5CAA79@DM5PR21MB1749.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB17495741194946995BA2F7D5CAA79@DM5PR21MB1749.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 09, 2022 at 01:59:02PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Thursday, June 9, 2022 9:51 AM
> > To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; linux-hyperv@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Saurabh Singh Sengar <ssengar@microsoft.com>
> > Subject: RE: [PATCH] Drivers: hv: vmbus: Add cpu read lock
> > 
> > From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, June
> > 8, 2022 10:27 PM
> > >
> > > Add cpus_read_lock to prevent CPUs from going offline between query and
> > > actual use of cpumask. cpumask_of_node is first queried, and based on it
> > > used later, in case any CPU goes offline between these two events, it can
> > > potentially cause an infinite loop of retries.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/hv/channel_mgmt.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > > index 85a2142..6a88b7e 100644
> > > --- a/drivers/hv/channel_mgmt.c
> > > +++ b/drivers/hv/channel_mgmt.c
> > > @@ -749,6 +749,9 @@ static void init_vp_index(struct vmbus_channel
> > *channel)
> > >  		return;
> > >  	}
> > >
> > > +	/* No CPUs should come up or down during this. */
> > > +	cpus_read_lock();
> > > +
> > >  	for (i = 1; i <= ncpu + 1; i++) {
> > >  		while (true) {
> > >  			numa_node = next_numa_node_id++;
> > > @@ -781,6 +784,7 @@ static void init_vp_index(struct vmbus_channel
> > *channel)
> > >  			break;
> > >  	}
> > >
> > > +	cpus_read_unlock();
> > >  	channel->target_cpu = target_cpu;
> > >
> > >  	free_cpumask_var(available_mask);
> > > --
> > > 1.8.3.1
> > 
> > This patch was motivated because I suggested a potential issue here during
> > a separate conversation with Saurabh, but it turns out I was wrong. :-(
> > 
> > init_vp_index() is only called from vmbus_process_offer(), and the
> > cpus_read_lock() is already held when init_vp_index() is called.  So the
> > issue doesn't exist, and this patch isn't needed.
> > 
> > However, looking at vmbus_process_offer(), there appears to be a
> > different problem in that cpus_read_unlock() is not called when taking
> > the error return because the sub_channel_index is zero.
> > 
> > Michael
> > 
> 
>         } else {
>                 /*
>                  * Check to see if this is a valid sub-channel.
>                  */
>                 if (newchannel->offermsg.offer.sub_channel_index == 0) {
>                         mutex_unlock(&vmbus_connection.channel_mutex);
>                         /*
>                          * Don't call free_channel(), because newchannel->kobj
>                          * is not initialized yet.
>                          */
>                         kfree(newchannel);
>                         WARN_ON_ONCE(1);
>                         return;
>                 }
> 
> If this happens, it should be a host bug. Yes, I also think the cpus_read_unlock()
> is missing in this error path.
> 
> Thanks,
> - Haiyang

I see, will send another patch to fix this.

Regards,
Saurabh
