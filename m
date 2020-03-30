Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6C1983C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC3Szb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 14:55:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41584 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Sza (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 14:55:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so22976220wrc.8;
        Mon, 30 Mar 2020 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32j/jWOh/JoGNCY9T2ymy4o9tq2DJaYB84CkOyDnYBQ=;
        b=r7oFOl1d4ZRejMsBqwJzbLk2Kkdx81XtOhIEDSMfYaJ1xZTTcEg48lUHi2Hucjxlb1
         y3YIuriU2iNuUTHOUrO+zfxO5agjN1n7vs/C9TtreajwB/UBGmgQaJLC8hoygQ71liS1
         blmn9l2mnMPmdke2K6QabGNn4FGkt5QpFFW6ADjnIBVN2DOlqUHRGJ4ap2xtwolZfdnk
         ShrjIc1ssts/u3qs2AFlEH6z4VFigKcnvG9lR+KuQumgls5/oHx8RBO7pm2dlARQ+1Lo
         GYuAT7Pcy4QtXyMHPzqnxq9i0J2kuFAeJzI3T7tV2X72+tPAYDZXp4zw05qhCLfuiYpz
         cRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32j/jWOh/JoGNCY9T2ymy4o9tq2DJaYB84CkOyDnYBQ=;
        b=SF8lhnqPH3tLRAQbJk9h1bYI33ooMvYDGBjbqMGFIQqN6BN38Z9TOMR0He6JVLkcLu
         E5E8v09SZgH4a+64m5XeqCxJShKvesGdzsGUtCr6+WrA+LuQ70xuXPQx2Aen2CH+qa6Z
         Cw1LAS4RdYHYZiqLbd2Onvq0/2bfSgMN+3b6ukIVnMGjCUOrYsU0CnOmAkaFH5zwdTlj
         CgSZX0O6A/wi/K3Dd9OfuwSCWpP4Tg6lWJ9LyEbIyM3k/kxjRVgcMD8azIN86GX/dxUQ
         1kRpzX4hUb+4B01Tw99fLr2GSNizT16xEZAu/R3YyrJDrfHr1gNKzFynxs0gNJlOH6h1
         Fqsg==
X-Gm-Message-State: ANhLgQ0gMQVj3RHzanjYPhXqHU/p8JKH6i3bQ4CdQzIJ5JPcq9T7FCDx
        WW9uRyYwXGU1bW7x/4Q3/eI=
X-Google-Smtp-Source: ADFU+vtscKaGXobI51lj7JPOxWqqpLvAx9H0/pRaFotwszYyMVWZPPL/JfpFxsse8vhNaZcRxMgiTQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr15627484wrw.235.1585594525622;
        Mon, 30 Mar 2020 11:55:25 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id p16sm504183wmi.40.2020.03.30.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:55:24 -0700 (PDT)
Date:   Mon, 30 Mar 2020 20:55:13 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 11/11] scsi: storvsc: Re-init stor_chns when a
 channel interrupt is re-assigned
Message-ID: <20200330185513.GA26823@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-12-parri.andrea@gmail.com>
 <MW2PR2101MB105208138683A6DE0564745AD7CB0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105208138683A6DE0564745AD7CB0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1721,6 +1721,10 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
> >  	 * in on a CPU that is different from the channel target_cpu value.
> >  	 */
> > 
> > +	if (channel->change_target_cpu_callback)
> > +		(*channel->change_target_cpu_callback)(channel,
> > +				channel->target_cpu, target_cpu);
> > +
> >  	channel->target_cpu = target_cpu;
> >  	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
> >  	channel->numa_node = cpu_to_node(target_cpu);
> 
> I think there's an ordering problem here.  The change_target_cpu_callback
> will allow storvsc to flush the cache that it is keeping, but there's a window
> after the storvsc callback releases the spin lock and before this function
> changes channel->target_cpu to the new value.  In that window, the cache
> could get refilled based on the old value of channel->target_cpu, which is
> exactly what we don't want.  Generally with caches, you have to set the new
> value first, then flush the cache, and I think that works in this case.  The
> callback function doesn't depend on the value of channel->target_cpu,
> and any cache filling that might happen after channel->target_cpu is set
> to the new value but before the callback function runs is OK.   But please
> double-check my thinking. :-)

Sorry, I don't see the problem.  AFAICT, the "cache" gets refilled based
on the values of alloced_cpus and on the current state of the cache but
not based on the value of channel->target_cpu.  The callback invocation
uses the value of the "old" target_cpu; I think I ended up placing the
callback call where it is for not having to introduce a local variable
"old_cpu".  ;-)


> > @@ -621,6 +621,63 @@ static inline struct storvsc_device *get_in_stor_device(
> > 
> >  }
> > 
> > +void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old, u32 new)
> > +{
> > +	struct storvsc_device *stor_device;
> > +	struct vmbus_channel *cur_chn;
> > +	bool old_is_alloced = false;
> > +	struct hv_device *device;
> > +	unsigned long flags;
> > +	int cpu;
> > +
> > +	device = channel->primary_channel ?
> > +			channel->primary_channel->device_obj
> > +				: channel->device_obj;
> > +	stor_device = get_out_stor_device(device);
> > +	if (!stor_device)
> > +		return;
> > +
> > +	/* See storvsc_do_io() -> get_og_chn(). */
> > +	spin_lock_irqsave(&device->channel->lock, flags);
> > +
> > +	/*
> > +	 * Determines if the storvsc device has other channels assigned to
> > +	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> > +	 * array.
> > +	 */
> > +	if (device->channel != channel && device->channel->target_cpu == old) {
> > +		cur_chn = device->channel;
> > +		old_is_alloced = true;
> > +		goto old_is_alloced;
> > +	}
> > +	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> > +		if (cur_chn == channel)
> > +			continue;
> > +		if (cur_chn->target_cpu == old) {
> > +			old_is_alloced = true;
> > +			goto old_is_alloced;
> > +		}
> > +	}
> > +
> > +old_is_alloced:
> > +	if (old_is_alloced)
> > +		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> > +	else
> > +		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
> 
> I think target_cpu_store() can get called in parallel on multiple CPUs for different
> channels on the same storvsc device, but multiple changes to a single channel are
> serialized by higher levels of sysfs.  So this function could run after multiple
> channels have been changed, in which case there's not just a single "old" value,
> and the above algorithm might not work, especially if channel->target_cpu is
> updated before calling this function per my earlier comment.   I can see a
> couple of possible ways to deal with this.  One is to put the update of
> channel->target_cpu in this function, within the spin lock boundaries so
> that the cache flush and target_cpu update are atomic.  Another idea is to
> process multiple changes in this function, by building a temp copy of
> alloced_cpus by walking the channel list, use XOR to create a cpumask
> with changes, and then process all the changes in a loop instead of
> just handling a single change as with the current code at the old_is_alloced
> label.  But I haven't completely thought through this idea.

Same here: the invocations of target_cpu_store() are serialized on the
per-connection channel_mutex...


> > @@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device
> > *stor_device,
> >  		if (cpumask_test_cpu(tgt_cpu, node_mask))
> >  			num_channels++;
> >  	}
> > -	if (num_channels == 0)
> > +	if (num_channels == 0) {
> > +		stor_device->stor_chns[q_num] = stor_device->device->channel;
> 
> Is the above added line just fixing a bug in the existing code?  I'm not seeing how
> it would derive from the other changes in this patch.

It was rather intended as an optimization:  Each time I/O for a device
is initiated on a CPU that have "num_channels == 0" channel, the current
code ends up calling get_og_chn() (in the attempt to fill the cache) and
returns the device's primary channel.  In the current code, the cost of
this operations is basically the cost of parsing alloced_cpus, but with
the changes introduced here this also involves acquiring (and releasing)
the primary channel's lock.  I should probably put my hands forward and
say that I haven't observed any measurable effects due this addition in
my experiments; OTOH, caching the returned/"found" value made sense...


> > @@ -1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *device,
> >  					continue;
> >  				if (tgt_cpu == q_num)
> >  					continue;
> > -				channel = stor_device->stor_chns[tgt_cpu];
> > +				channel = READ_ONCE(
> > +					stor_device->stor_chns[tgt_cpu]);
> > +				if (channel == NULL)
> > +					continue;
> 
> The channel == NULL case is new because a cache flush could be happening
> in parallel on another CPU.  I'm wondering about the tradeoffs of
> continuing in the loop (as you have coded in this patch) vs. a "goto" back to
> the top level "if" statement.   With the "continue" you might finish the
> loop without finding any matches, and fall through to the next approach.
> But it's only a single I/O operation, and if it comes up with a less than
> optimal channel choice, it's no big deal.  So I guess it's really a wash.

Yes, I considered both approaches; they both "worked" here.  I was a
bit concerned about the number of "possible" gotos (again, mainly a
theoretical issue, since I can imagine that the cash flushes will be
relatively "rare" events in most cases and, in any case, they happen
to be serialized); the "continue" looked like a suitable and simpler
approach/compromise, at least for the time being.


> 
> >  				if (hv_get_avail_to_write_percent(
> >  							&channel->outbound)
> >  						> ring_avail_percent_lowater) {
> > @@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *device,
> >  			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
> >  				if (cpumask_test_cpu(tgt_cpu, node_mask))
> >  					continue;
> > -				channel = stor_device->stor_chns[tgt_cpu];
> > +				channel = READ_ONCE(
> > +					stor_device->stor_chns[tgt_cpu]);
> > +				if (channel == NULL)
> > +					continue;
> 
> Same comment here.

Similarly here.

Thoughts?

Thanks,
  Andrea
