Return-Path: <linux-hyperv+bounces-3685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7FAA129B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0B164F2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098A1553BB;
	Wed, 15 Jan 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SygvR5/j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF141BD51F;
	Wed, 15 Jan 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961770; cv=none; b=ZgSYWRyH+JH2bcvBiOwCAVueVX0YEpF1yVmeO9YpHKWOW5EkgftZnFeMag4JDuBCt2cmb0h62VheUfuONTjCI6BQ95aIb7xBRhol4GGD2cG4098hW6ZYecD1oc9oqO0Jntw6pwMqY/OP8/zoQnEyT8YuiY4j5JISEHwdNnQ2t2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961770; c=relaxed/simple;
	bh=EmWuT+9imbAdXIgkbeKiaB/MQr7jPY9hSujfnz5nXFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGwU7a0HtWBw+S7wfturiDcmAq/K8H2NZJLv872vOmbn9QDOjWZV15zBkPBbHgmU4T/Fcsv7PX4A366Pdx52feaOaiEKW7xoyQRz6Bw1yp+XJ6TZGhks0rm2gosahv+vjH2Fuarb7RP2vvfIzfXYfBkGk1/1tt6xJIRWmlum0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SygvR5/j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-60-142-114-100-59.dsl.bell.ca [142.114.100.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7BFD20BEBE1;
	Wed, 15 Jan 2025 09:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7BFD20BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736961768;
	bh=y9rFIIVVdLrYYVrAzqBXSQfOxdx1IVXvQQHDY4H9DvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SygvR5/jJZPbmLuwC/7JqQgqqUex1gnklRrBdGPDYywm4bXo50sD074NgANE+smbc
	 tTHIczz8IybEW4pzJGYqK2mSA7rnxlcGFATowO9HLR8rOBYkJa88qGYdzfUY8gf9nX
	 OEPTECUbdy382tswYsXJ3Znqbvhj1AU4Dym1K1J4=
Date: Wed, 15 Jan 2025 12:22:46 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Message-ID: <Z4fu5p70KggmQstL@hm-sls2>
References: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
 <20250110215951.175514-2-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157906A4E40E416D61AFEEBD4182@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157906A4E40E416D61AFEEBD4182@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jan 14, 2025 at 02:43:33AM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, January 10, 2025 2:00 PM
> > 
> > Currently, it is effectively impossible to offline CPUs. Since, most
> > CPUs will have vmbus channels attached to them. So, as made mention of
> > in commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize
> > init_vp_index() vs. CPU hotplug"), rebind channels associated with CPUs
> > that a user is trying to offline to a new "randomly" selected CPU.
> 
> Let me provide some additional context and thoughts about the new
> functionality proposed in this patch set.
> 
> 1. I would somewhat challenge the commit message statement that
> "it is effectively impossible to offline CPUs". VMBus device interrupts
> can be assigned to a different CPU via a /sys interface and the code
> in target_cpu_store().  So a CPU *can* be taken offline by first reassigning
> any VMBus device interrupts, and then the offlining operation will succeed.
> That reassigning requires manual sysadmin actions or some scripting,
> which isn't super easy or automatic, but it's not "effectively impossible".

Fair enough.

> 
> 2. As background, when a CPU goes offline, the Linux kernel already has
> functionality to reassign unmanaged IRQs that are assigned to the CPU
> going offline.  (Managed IRQs are just shut down.)  See fixup_irqs().
> Unfortunately, VMBus device interrupts are not modelled as Linux IRQs,
> so the existing mechanism is not applied to VMBus devices.
> 
> 3. In light of #2 and for other reasons, I submitted a patch set in June 2024
> that models VMBus device interrupts as Linux IRQs. See [1]. This patch set
> got feedback from Thomas Gleixner about how to demultiplex the IRQs, but
> no one from Microsoft gave feedback on the overall idea. I think it would
> be worthwhile to pursue these patches, but I would like to get some
> macro-level thoughts from the Microsoft folks. There are implications for
> things such as irqbalance.
> 
> 4. As the cover letter in my patch set notes, there's still a problem with
> the automatic Linux IRQ reassignment mechanism for the new VMBus IRQs.
> The cover letter doesn't give full details, but the problem is ultimately due
> to needing to get an ack from Hyper-V that the change in VMBus device
> interrupt assignment has been completed. I have investigated alternatives
> for making it work, but they are all somewhat convoluted. Nevertheless,
> if we want to move forward with the patch set, further work on these
> alternatives would be warranted.
> 
> 5. In May 2020, Andrea Parri worked on a patch set that does what this
> patch set does -- automatically reassign VMBus device interrupts when
> a CPU tries to go offline. That patch set took a broader focus on making a
> smart decision about the CPU to which to assign the interrupt in several
> different circumstances, one of which was offlining a CPU. It was
> somewhat complex and posted as an RFC [2]. I think Andrea ended up
> having to work on some other things, and the patch set was not pursued
> after the initial posting. It might be worthwhile to review it for comparison
> purposes, or maybe it's worth reviving.
> 
> All of that is to say that I think there are two paths forward:
> 
> A. The quicker fix is to take the approach of this patch set and continue
> handling VMBus device interrupts outside of the Linux IRQ mechanism.
> Do the automatic reassignment when taking a CPU offline, as coded
> in this patch. Andrea Parri's old patch set might have something to add
> to this approach, if just for comparison purposes.
> 
> B. Take a broader look at the problem by going back to my patch set
> that models VMBus device interrupts as Linux IRQs. Work to get
> the existing Linux IRQ reassignment mechanism to work for the new
> VMBus IRQs. This approach will probably take longer than (A).
> 
> I lean toward (B) because it converges with standard Linux IRQs, but I
> don't know what's driving doing (A). If there's need to do (A) sooner,
> see my comments in the code below. I'm less inclined to add the
> complexity of Andrea Parri's old patch set because I think it takes
> us even further down the path of doing custom VMBus-related
> work when we would do better to converge toward existing Linux
> IRQ mechanisms.

I would prefer (B) as well, though as you said it will take longer.
So, I think my series is a reasonable stopgap until we get there.

> 
> [1] https://lore.kernel.org/linux-hyperv/20240604050940.859909-1-mhklinux@outlook.com/
> [2] https://lore.kernel.org/linux-hyperv/20200526223218.184057-1-parri.andrea@gmail.com/
> 
> > 
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> > v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
> >     lockdep_assert_cpus_held().
> > ---
> >  drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 36d9ba097ff5..9fef71403c86 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -433,13 +433,39 @@ static bool hv_synic_event_pending(void)
> >  	return pending;
> >  }
> > 
> > +static int hv_pick_new_cpu(struct vmbus_channel *channel,
> > +			   unsigned int current_cpu)
> > +{
> > +	int ret = 0;
> > +	int cpu;
> > +
> > +	lockdep_assert_cpus_held();
> > +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> > +
> > +	/*
> > +	 * We can't assume that the relevant interrupts will be sent before
> > +	 * the cpu is offlined on older versions of hyperv.
> > +	 */
> > +	if (vmbus_proto_version < VERSION_WIN10_V5_3)
> > +		return -EBUSY;
> 
> I'm not sure why this test is here.  The function vmbus_set_channel_cpu()
> tests the vmbus_proto_version against V4_1 and returns an appropriate
> error. Do we *need* to filter against V5_3 instead of V4_1?

Yes, please see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hv/vmbus_drv.c#n1685

> 
> > +
> > +	cpu = cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_mask);
> > +
> > +	if (cpu >= nr_cpu_ids || cpu == current_cpu)
> > +		cpu = VMBUS_CONNECT_CPU;
> 
> Picking a random CPU like this seems to have some problems:
> 
> 1. The selected CPU might be an isolated CPU, in which case the
> call to vmbus_channel_set_cpu() will return an error, and the
> attempt to take the CPU offline will eventually fail. But if you try
> again to take the CPU offline, a different random CPU may be
> chosen that isn't an isolated CPU, and taking the CPU offline
> will succeed. Such inconsistent behavior should be avoided.
> 
> 2. I wonder if we should try to choose a CPU in the same NUMA node
> as "current_cpu".  The Linux IRQ mechanism has the concept of CPU
> affinity for an IRQ, which can express the NUMA affinity. The normal
> Linux reassignment mechanism obeys the IRQ's affinity if possible,
> and so would do the right thing for NUMA. So we need to consider
> whether to do that here as well.

That sounds good to me.

> 
> 3. The handling of the current_cpu feels a bit hacky. There's
> also no wrap-around in the mask search. Together, I think that
> creates a small bias toward choosing the VMBUS_CONNECT_CPU,
> which is arguably already somewhat overloaded because all the
> low-speed devices use it. I haven't tried to look for alternative
> approaches to suggest.

Ya, I noticed that as well but I didn't want to overcomplicate the
selection heuristic. Though I guess having it wrap-around isn't too
involved.

Hamza

> 
> Michael
> 
> > +
> > +	ret = vmbus_channel_set_cpu(channel, cpu);
> > +
> > +	return ret;
> > +}
> > +
> >  /*
> >   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> >   */
> >  int hv_synic_cleanup(unsigned int cpu)
> >  {
> >  	struct vmbus_channel *channel, *sc;
> > -	bool channel_found = false;
> > +	int ret = 0;
> > 
> >  	if (vmbus_connection.conn_state != CONNECTED)
> >  		goto always_cleanup;
> > @@ -456,31 +482,31 @@ int hv_synic_cleanup(unsigned int cpu)
> > 
> >  	/*
> >  	 * Search for channels which are bound to the CPU we're about to
> > -	 * cleanup.  In case we find one and vmbus is still connected, we
> > -	 * fail; this will effectively prevent CPU offlining.
> > -	 *
> > -	 * TODO: Re-bind the channels to different CPUs.
> > +	 * cleanup.
> >  	 */
> >  	mutex_lock(&vmbus_connection.channel_mutex);
> >  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> >  		if (channel->target_cpu == cpu) {
> > -			channel_found = true;
> > -			break;
> > +			ret = hv_pick_new_cpu(channel, cpu);
> > +
> > +			if (ret) {
> > +				mutex_unlock(&vmbus_connection.channel_mutex);
> > +				return ret;
> > +			}
> >  		}
> >  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
> >  			if (sc->target_cpu == cpu) {
> > -				channel_found = true;
> > -				break;
> > +				ret = hv_pick_new_cpu(channel, cpu);
> > +
> > +				if (ret) {
> > +					mutex_unlock(&vmbus_connection.channel_mutex);
> > +					return ret;
> > +				}
> >  			}
> >  		}
> > -		if (channel_found)
> > -			break;
> >  	}
> >  	mutex_unlock(&vmbus_connection.channel_mutex);
> > 
> > -	if (channel_found)
> > -		return -EBUSY;
> > -
> >  	/*
> >  	 * channel_found == false means that any channels that were previously
> >  	 * assigned to the CPU have been reassigned elsewhere with a call of
> > @@ -497,5 +523,5 @@ int hv_synic_cleanup(unsigned int cpu)
> > 
> >  	hv_synic_disable_regs(cpu);
> > 
> > -	return 0;
> > +	return ret;
> >  }
> > --
> > 2.47.1
> > 

