Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2B535879
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 May 2022 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiE0EaJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 May 2022 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiE0EaI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 May 2022 00:30:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832ADEC3E6;
        Thu, 26 May 2022 21:30:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id D9AB320B71D5; Thu, 26 May 2022 21:30:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9AB320B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653625801;
        bh=42Z9fNBmmifkuVx5f5pfyzCv7xT30xcWjT3LjPfgQG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsZ1Xq44KlVO0sHf/LjDDqz7ECT/8fcMNRXqAilohLBazEQxZEgcSXE1iLRd3AOka
         n2hjLHQv8/4+vtC4bbAUIA2h8+nUTr0RPXxLF0fE7YXKG2qmgM+2QQNd4PK0nqZI5M
         Po+wQk7CwpUOtrKwaaZ7Xjlq9l4K1UM1lvPjDELQ=
Date:   Thu, 26 May 2022 21:30:01 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Adding isolated cpu support for
 channel interrupts mapping
Message-ID: <20220527043001.GA25943@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1653591314-7077-1-git-send-email-ssengar@linux.microsoft.com>
 <PH0PR21MB3025DD41E24D239C0ECB11A9D7D99@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025DD41E24D239C0ECB11A9D7D99@PH0PR21MB3025.namprd21.prod.outlook.com>
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

On Thu, May 26, 2022 at 08:45:33PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, May 26, 2022 11:55 AM
> 
> > Subject: [PATCH] Drivers: hv: vmbus: Adding isolated cpu support for channel interrupts
> > mapping
> 
> Let me suggest a more compact and precise Subject:
> 
> Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs
[sss]: ok

> 
> > 
> > Adding support for vmbus channels to take isolated cpu in consideration
> > while assigning interrupt to different cpus. This also prevents user from
> > setting any isolated cpu to vmbus channel interrupt assignment by sysfs
> > entry. Isolated cpu can be configured by kernel command line parameter
> > 'isolcpus=managed_irq,<#cpu>'.
> 
> Also, for the commit statement:
> 
> When initially assigning a VMbus channel interrupt to a CPU, don't choose
> a managed IRQ isolated CPU (as specified on the kernel boot line with
> parameter 'isolcpus=managed_irq,<#cpu>').  Also, when using sysfs to
> change the CPU that a VMbus channel will interrupt, don't allow changing
> to a managed IRQ isolated CPU.  
>
[sss] : ok 
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 18 ++++++++++++------
> >  drivers/hv/vmbus_drv.c    |  6 ++++++
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 97d8f56..e1fe029 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/hyperv.h>
> >  #include <asm/mshyperv.h>
> > +#include <linux/sched/isolation.h>
> > 
> >  #include "hyperv_vmbus.h"
> > 
> > @@ -728,16 +729,20 @@ static void init_vp_index(struct vmbus_channel *channel)
> >  	u32 i, ncpu = num_online_cpus();
> >  	cpumask_var_t available_mask;
> >  	struct cpumask *allocated_mask;
> > +	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
> >  	u32 target_cpu;
> >  	int numa_node;
> > 
> >  	if (!perf_chn ||
> > -	    !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
> > +	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
> > +	    cpumask_empty(hk_mask)) {
> >  		/*
> >  		 * If the channel is not a performance critical
> >  		 * channel, bind it to VMBUS_CONNECT_CPU.
> >  		 * In case alloc_cpumask_var() fails, bind it to
> >  		 * VMBUS_CONNECT_CPU.
> > +		 * If all the cpus are isolated, bind it to
> > +		 * VMBUS_CONNECT_CPU.
> >  		 */
> >  		channel->target_cpu = VMBUS_CONNECT_CPU;
> >  		if (perf_chn)
> > @@ -758,17 +763,19 @@ static void init_vp_index(struct vmbus_channel *channel)
> >  		}
> >  		allocated_mask = &hv_context.hv_numa_map[numa_node];
> > 
> > -		if (cpumask_equal(allocated_mask, cpumask_of_node(numa_node))) {
> > +retry:
> > +		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
> 
> There's a bug here that existed in the code prior to this patch.  The code
> checks to make sure cpumask_of_node(numa_node) is not empty, and then
> later references cpumask_of_node(numa_node) again.  But in between the
> check and the use, one or more CPUs could go offline, leaving 
> cpumask_of_node(numa_node) empty since that array of cpumasks contains
> only online CPUs.  In such a case, execution could get stuck in an infinite
> loop with available_mask being empty.
> 
> The solution is to call cpus_read_lock() before starting the main "for"
> loop and then call cpus_read_unlock() at the end.  This lock will prevent
> CPUs from going offline, and hence ensure that the node mask can't
> become empty.   You'll notice that target_cpu_store() uses that lock
> to prevent a similar problem.
> 
> Fixing this locking problem should probably be a separate patch.
> 
> Michael
[sss] : Got it, will send this fix after this patch review is complete.

> 
> > +		cpumask_and(available_mask, available_mask, hk_mask);
> > +
> > +		if (cpumask_empty(available_mask)) {
> >  			/*
> >  			 * We have cycled through all the CPUs in the node;
> >  			 * reset the allocated map.
> >  			 */
> >  			cpumask_clear(allocated_mask);
> > +			goto retry;
> >  		}
> > 
> > -		cpumask_xor(available_mask, allocated_mask,
> > -			    cpumask_of_node(numa_node));
> > -
> >  		target_cpu = cpumask_first(available_mask);
> >  		cpumask_set_cpu(target_cpu, allocated_mask);
> > 
> > @@ -778,7 +785,6 @@ static void init_vp_index(struct vmbus_channel *channel)
> >  	}
> > 
> >  	channel->target_cpu = target_cpu;
> > -
> >  	free_cpumask_var(available_mask);
> >  }
> 
> Removing the blank line above is a gratuitous change that isn't needed.
> Generally, a patch should avoid such changes unless the purpose of
> the patch is code cleanup.
>
[sss] : Got in by mistake, will remove

> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 714d549..23660a8 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/cpu.h>
> > +#include <linux/sched/isolation.h>
> >  #include <linux/sched/task_stack.h>
> > 
> >  #include <linux/delay.h>
> > @@ -1770,6 +1771,11 @@ static ssize_t target_cpu_store(struct vmbus_channel
> > *channel,
> >  	if (target_cpu >= nr_cpumask_bits)
> >  		return -EINVAL;
> > 
> > +	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ))) {
> > +		dev_err(&channel->device_obj->device,
> > +			"cpu (%d) is isolated, can't be assigned\n", target_cpu);
> 
> I don't think a message should be output here.  The other errors in this
> function don't output a message.  Generally, the kernel doesn't output
> a message just because a user provided bad input.  Doing so makes it
> too easy for a user (even a sysadmin) to cause the kernel to go wild
> outputting messages.
> 
> Michael
> 
[sss] : sure, will remove

> > +		return -EINVAL;
> > +	}
> >  	/* No CPUs should come up or down during this. */
> >  	cpus_read_lock();
> > 
> > --
> > 1.8.3.1
