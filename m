Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5278819D7D1
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbgDCNlS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 09:41:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390808AbgDCNlS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 09:41:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so8565026wrx.9;
        Fri, 03 Apr 2020 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fvuq9jvQpolHwINYS7m16hx6vPGefpqo63LpJAzMQE=;
        b=VXCwDGeScZ5cia7bGxh1ajfJpB92PhPjiRo+3BJBQ5iRvntXjU1ZYVin8FqLBcfSAU
         Bq0kB3qW5oQA57PjgvCuqdnAFH9lrMdSVyE9W0fJOCPU0tNItCDNRTUbg5hv7n0B2GHk
         e43Nv8zXoB/4HD0p6IqAZnYyhMJo8ZrM+v+DrcuifsuJ9H/yUfpW2KwapUU4PiqvkXy3
         99An1tglq84I4My447dokOyZ76SqfDXW0FyxP5VDYk6l0b2rb9fraXEqt8Y7hPsmrKVe
         9YNXPPMJ+VH5w1KbQIWzziLNxu0VyQQB9d9NYMvzzVJu/K9GBzx7Ua+hT22EBacyahYD
         Zepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fvuq9jvQpolHwINYS7m16hx6vPGefpqo63LpJAzMQE=;
        b=UyHyWospLtDJHOKjsxWT/X7mT9CXg5i6dbXCAfygnpyr19bD9K/ODpwF3br3hU1nsY
         WKB7cKWzckjzw2N5KSrUMOuYPb+gsCh3CLdWrjxfs/OPnI6sSmmboRzRbaT1UOG4gRwC
         8lpqWxUgUVaPTsiUUhhsVER+NswEirbok9SNtFrK/dPRv6bGXi0/JoYhRisKW9FqPdpf
         LCCLdVfqcAXdl1Jg9ocHwDkA7QnNRLxyy/LpqgoK37moeqGRxn8BkFm+oMdr1mdhvi2h
         4wwnRbMYj5UaXIlTvdXXhPkmtlFAsCg2Ix9X/MO2IlXF25T5TTOtVKhslrpXgb+iNdtl
         tZUg==
X-Gm-Message-State: AGi0PuZE0g6PpPFDC6hTUiqmECzZXA9UQoF1Dz8WNGuAdDVDN5LGG/qi
        dTq9b5L/jbAfu5VoOyK9q9s=
X-Google-Smtp-Source: APiQypItGAM0KwDWFvjWsZQxmVAXVDd+SbecmELBm7AL3FJ2PWFNdifNkRc6TvVXLXrXJe8QB99Q0w==
X-Received: by 2002:adf:e588:: with SMTP id l8mr8786918wrm.186.1585921273604;
        Fri, 03 Apr 2020 06:41:13 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id t81sm11317133wmb.15.2020.04.03.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:41:13 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:41:07 +0200
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
Message-ID: <20200403134107.GA25800@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-12-parri.andrea@gmail.com>
 <MW2PR2101MB105208138683A6DE0564745AD7CB0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200330185513.GA26823@andrea>
 <DM5PR2101MB104720061795F26D892D5373D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB104720061795F26D892D5373D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 30, 2020 at 07:49:00PM +0000, Michael Kelley wrote:
> From: Andrea Parri <parri.andrea@gmail.com> Sent: Monday, March 30, 2020 11:55 AM
> > 
> > > > @@ -1721,6 +1721,10 @@ static ssize_t target_cpu_store(struct vmbus_channel
> > *channel,
> > > >  	 * in on a CPU that is different from the channel target_cpu value.
> > > >  	 */
> > > >
> > > > +	if (channel->change_target_cpu_callback)
> > > > +		(*channel->change_target_cpu_callback)(channel,
> > > > +				channel->target_cpu, target_cpu);
> > > > +
> > > >  	channel->target_cpu = target_cpu;
> > > >  	channel->target_vp = hv_cpu_number_to_vp_number(target_cpu);
> > > >  	channel->numa_node = cpu_to_node(target_cpu);
> > >
> > > I think there's an ordering problem here.  The change_target_cpu_callback
> > > will allow storvsc to flush the cache that it is keeping, but there's a window
> > > after the storvsc callback releases the spin lock and before this function
> > > changes channel->target_cpu to the new value.  In that window, the cache
> > > could get refilled based on the old value of channel->target_cpu, which is
> > > exactly what we don't want.  Generally with caches, you have to set the new
> > > value first, then flush the cache, and I think that works in this case.  The
> > > callback function doesn't depend on the value of channel->target_cpu,
> > > and any cache filling that might happen after channel->target_cpu is set
> > > to the new value but before the callback function runs is OK.   But please
> > > double-check my thinking. :-)
> > 
> > Sorry, I don't see the problem.  AFAICT, the "cache" gets refilled based
> > on the values of alloced_cpus and on the current state of the cache but
> > not based on the value of channel->target_cpu.  The callback invocation
> > uses the value of the "old" target_cpu; I think I ended up placing the
> > callback call where it is for not having to introduce a local variable
> > "old_cpu".  ;-)
> >
> 
> You are right.   My comment is bogus.
> 
> > 
> > > > @@ -621,6 +621,63 @@ static inline struct storvsc_device *get_in_stor_device(
> > > >
> > > >  }
> > > >
> > > > +void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old, u32 new)
> > > > +{
> > > > +	struct storvsc_device *stor_device;
> > > > +	struct vmbus_channel *cur_chn;
> > > > +	bool old_is_alloced = false;
> > > > +	struct hv_device *device;
> > > > +	unsigned long flags;
> > > > +	int cpu;
> > > > +
> > > > +	device = channel->primary_channel ?
> > > > +			channel->primary_channel->device_obj
> > > > +				: channel->device_obj;
> > > > +	stor_device = get_out_stor_device(device);
> > > > +	if (!stor_device)
> > > > +		return;
> > > > +
> > > > +	/* See storvsc_do_io() -> get_og_chn(). */
> > > > +	spin_lock_irqsave(&device->channel->lock, flags);
> > > > +
> > > > +	/*
> > > > +	 * Determines if the storvsc device has other channels assigned to
> > > > +	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> > > > +	 * array.
> > > > +	 */
> > > > +	if (device->channel != channel && device->channel->target_cpu == old) {
> > > > +		cur_chn = device->channel;
> > > > +		old_is_alloced = true;
> > > > +		goto old_is_alloced;
> > > > +	}
> > > > +	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> > > > +		if (cur_chn == channel)
> > > > +			continue;
> > > > +		if (cur_chn->target_cpu == old) {
> > > > +			old_is_alloced = true;
> > > > +			goto old_is_alloced;
> > > > +		}
> > > > +	}
> > > > +
> > > > +old_is_alloced:
> > > > +	if (old_is_alloced)
> > > > +		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> > > > +	else
> > > > +		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
> > >
> > > I think target_cpu_store() can get called in parallel on multiple CPUs for different
> > > channels on the same storvsc device, but multiple changes to a single channel are
> > > serialized by higher levels of sysfs.  So this function could run after multiple
> > > channels have been changed, in which case there's not just a single "old" value,
> > > and the above algorithm might not work, especially if channel->target_cpu is
> > > updated before calling this function per my earlier comment.   I can see a
> > > couple of possible ways to deal with this.  One is to put the update of
> > > channel->target_cpu in this function, within the spin lock boundaries so
> > > that the cache flush and target_cpu update are atomic.  Another idea is to
> > > process multiple changes in this function, by building a temp copy of
> > > alloced_cpus by walking the channel list, use XOR to create a cpumask
> > > with changes, and then process all the changes in a loop instead of
> > > just handling a single change as with the current code at the old_is_alloced
> > > label.  But I haven't completely thought through this idea.
> > 
> > Same here: the invocations of target_cpu_store() are serialized on the
> > per-connection channel_mutex...
> 
> Agreed.  My comment is not valid.
> 
> > 
> > 
> > > > @@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct
> > storvsc_device
> > > > *stor_device,
> > > >  		if (cpumask_test_cpu(tgt_cpu, node_mask))
> > > >  			num_channels++;
> > > >  	}
> > > > -	if (num_channels == 0)
> > > > +	if (num_channels == 0) {
> > > > +		stor_device->stor_chns[q_num] = stor_device->device->channel;
> > >
> > > Is the above added line just fixing a bug in the existing code?  I'm not seeing how
> > > it would derive from the other changes in this patch.
> > 
> > It was rather intended as an optimization:  Each time I/O for a device
> > is initiated on a CPU that have "num_channels == 0" channel, the current
> > code ends up calling get_og_chn() (in the attempt to fill the cache) and
> > returns the device's primary channel.  In the current code, the cost of
> > this operations is basically the cost of parsing alloced_cpus, but with
> > the changes introduced here this also involves acquiring (and releasing)
> > the primary channel's lock.  I should probably put my hands forward and
> > say that I haven't observed any measurable effects due this addition in
> > my experiments; OTOH, caching the returned/"found" value made sense...
> 
> OK.  That's what I thought.  The existing code does not produce an incorrect
> result, but the cache isn't working as intended.  This fixes it.
> 
> > 
> > 
> > > > @@ -1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *device,
> > > >  					continue;
> > > >  				if (tgt_cpu == q_num)
> > > >  					continue;
> > > > -				channel = stor_device->stor_chns[tgt_cpu];
> > > > +				channel = READ_ONCE(
> > > > +					stor_device->stor_chns[tgt_cpu]);
> > > > +				if (channel == NULL)
> > > > +					continue;
> > >
> > > The channel == NULL case is new because a cache flush could be happening
> > > in parallel on another CPU.  I'm wondering about the tradeoffs of
> > > continuing in the loop (as you have coded in this patch) vs. a "goto" back to
> > > the top level "if" statement.   With the "continue" you might finish the
> > > loop without finding any matches, and fall through to the next approach.
> > > But it's only a single I/O operation, and if it comes up with a less than
> > > optimal channel choice, it's no big deal.  So I guess it's really a wash.
> > 
> > Yes, I considered both approaches; they both "worked" here.  I was a
> > bit concerned about the number of "possible" gotos (again, mainly a
> > theoretical issue, since I can imagine that the cash flushes will be
> > relatively "rare" events in most cases and, in any case, they happen
> > to be serialized); the "continue" looked like a suitable and simpler
> > approach/compromise, at least for the time being.
> 
> Yes, I'm OK with your patch "as is".  I was just thinking about the
> alternative, and evidently you did too.

Thank you for the confirmation.  I'm wondering: could take this as a
Reviewed-by: for this patch?  ;-)

Thanks,
  Andrea


> 
> > 
> > 
> > >
> > > >  				if (hv_get_avail_to_write_percent(
> > > >  							&channel->outbound)
> > > >  						> ring_avail_percent_lowater) {
> > > > @@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *device,
> > > >  			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
> > > >  				if (cpumask_test_cpu(tgt_cpu, node_mask))
> > > >  					continue;
> > > > -				channel = stor_device->stor_chns[tgt_cpu];
> > > > +				channel = READ_ONCE(
> > > > +					stor_device->stor_chns[tgt_cpu]);
> > > > +				if (channel == NULL)
> > > > +					continue;
> > >
> > > Same comment here.
> > 
> > Similarly here.
> 
> Agreed.
> 
> > 
> > Thoughts?
> > 
> > Thanks,
> >   Andrea
