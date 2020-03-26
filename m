Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 829BB1945B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZRnO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 13:43:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46521 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgCZRnM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 13:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585244590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iY1VQzG5YGZeuqalkw7ZWUxW/oZQYRokOGvysW5G5q0=;
        b=C6w5x0BicXTl8+JYWHnnffLxeJDB+EavnL5m5bTthb4Z9Illzwskb/wS5xgC9BJGVwA212
        j76EMRz2ToOJgHpktmd6FW7nDdzvqaYjjy/D1HLZ6AVkXp2n9r16ZvPj3ieHhb45udhtsQ
        8N0qWoD3fq+wz3aNEoUcFn1MCM15N20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-B_FoOOgRM-SJpytJSIfiJQ-1; Thu, 26 Mar 2020 13:43:08 -0400
X-MC-Unique: B_FoOOgRM-SJpytJSIfiJQ-1
Received: by mail-wm1-f71.google.com with SMTP id g9so4235029wmh.1
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 10:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iY1VQzG5YGZeuqalkw7ZWUxW/oZQYRokOGvysW5G5q0=;
        b=htyhSjDvhsPX6j9HH9xyq6lcHQR9Yo8m48IYn41rEMNgzSOABJ1TYReN8bcnMQm71x
         uOVi+6e9RjQbAo1YU/B+kNBRkouwupNI7L5jYr4jjw95BSTBntHncgw8ENJ93UV80YV7
         fbmCKpkdKq8vJX2WGiDcCdDRJSUbP1Y7CDne2SLLArAEiKBZoAv7tzoCyafPzzq8hNOA
         R2IhK7kYvJk4vvZDxqd+XK9+/dkTj7FFmBsuwMwUQ7dWxa6DHtKOcdojFdVjhOjyk3Xa
         sJ9XfCSqrcpIhpRDssOZgyuLIipgUCWaRe5AhkbpgahCv/Y5Ku2sXrMFvt50aWDDdI2i
         3ZKA==
X-Gm-Message-State: ANhLgQ0G4nRNe4We2PhfH9GIimIji5WczJZ9ZHNdfJ0t7aZBQrYL3ptI
        csvcHqcl1ZCF5JD/DELV5vfNDF77uf5Q6UH575MrmEZ4zIGzqmrLTdf4OPXUCAkfNf1avkcObSU
        XYf9LNEZeieG1b+fYuhuzLq2z
X-Received: by 2002:a1c:f409:: with SMTP id z9mr1104035wma.51.1585244586894;
        Thu, 26 Mar 2020 10:43:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtMPwHwvPhttNZ6hV7WchIpLI2fmUMkAhr+s1EXwiqdIt4GRMnfd7iJuY6ed0EETpPwr/6N7A==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr1104010wma.51.1585244586553;
        Thu, 26 Mar 2020 10:43:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p13sm4605885wru.3.2020.03.26.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:43:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
In-Reply-To: <20200326170518.GA14314@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com> <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea>
Date:   Thu, 26 Mar 2020 18:43:04 +0100
Message-ID: <87pncz3tcn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Thu, Mar 26, 2020 at 03:31:20PM +0100, Vitaly Kuznetsov wrote:
>> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
>> 
>> > When Hyper-V sends an interrupt to the guest, the guest has to figure
>> > out which channel the interrupt is associated with.  Hyper-V sets a bit
>> > in a memory page that is shared with the guest, indicating a particular
>> > "relid" that the interrupt is associated with.  The current Linux code
>> > then uses a set of per-CPU linked lists to map a given "relid" to a
>> > pointer to a channel structure.
>> >
>> > This design introduces a synchronization problem if the CPU that Hyper-V
>> > will interrupt for a certain channel is changed.  If the interrupt comes
>> > on the "old CPU" and the channel was already moved to the per-CPU list
>> > of the "new CPU", then the relid -> channel mapping will fail and the
>> > interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
>> > but the channel was not moved to the per-CPU list of the new CPU, then
>> > the mapping will fail and the interrupt is dropped.
>> >
>> > Relids are integers ranging from 0 to 2047.  The mapping from relids to
>> > channel structures can be done by setting up an array with 2048 entries,
>> > each entry being a pointer to a channel structure (hence total size ~16K
>> > bytes, which is not a problem).  The array is global, so there are no
>> > per-CPU linked lists to update.   The array can be searched and updated
>> > by simply loading and storing the array at the specified index.  With no
>> > per-CPU data structures, the above mentioned synchronization problem is
>> > avoided and the relid2channel() function gets simpler.
>> >
>> > Suggested-by: Michael Kelley <mikelley@microsoft.com>
>> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>> > ---
>> >  drivers/hv/channel_mgmt.c | 158 ++++++++++++++++++++++----------------
>> >  drivers/hv/connection.c   |  38 +++------
>> >  drivers/hv/hv.c           |   2 -
>> >  drivers/hv/hyperv_vmbus.h |  14 ++--
>> >  drivers/hv/vmbus_drv.c    |  48 +++++++-----
>> >  include/linux/hyperv.h    |   5 --
>> >  6 files changed, 139 insertions(+), 126 deletions(-)
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index 1191f3d76d111..9b1449c839575 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -319,7 +319,6 @@ static struct vmbus_channel *alloc_channel(void)
>> >  	init_completion(&channel->rescind_event);
>> >  
>> >  	INIT_LIST_HEAD(&channel->sc_list);
>> > -	INIT_LIST_HEAD(&channel->percpu_list);
>> >  
>> >  	tasklet_init(&channel->callback_event,
>> >  		     vmbus_on_event, (unsigned long)channel);
>> > @@ -340,23 +339,28 @@ static void free_channel(struct vmbus_channel *channel)
>> >  	kobject_put(&channel->kobj);
>> >  }
>> >  
>> > -static void percpu_channel_enq(void *arg)
>> > +void vmbus_channel_map_relid(struct vmbus_channel *channel)
>> >  {
>> > -	struct vmbus_channel *channel = arg;
>> > -	struct hv_per_cpu_context *hv_cpu
>> > -		= this_cpu_ptr(hv_context.cpu_context);
>> > -
>> > -	list_add_tail_rcu(&channel->percpu_list, &hv_cpu->chan_list);
>> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
>> > +		return;
>> > +	/*
>> > +	 * Pairs with the READ_ONCE() in vmbus_chan_sched().  Guarantees
>> > +	 * that vmbus_chan_sched() will find up-to-date data.
>> > +	 */
>> > +	smp_store_release(
>> > +		&vmbus_connection.channels[channel->offermsg.child_relid],
>> > +		channel);
>> >  }
>> >  
>> > -static void percpu_channel_deq(void *arg)
>> > +void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
>> >  {
>> > -	struct vmbus_channel *channel = arg;
>> > -
>> > -	list_del_rcu(&channel->percpu_list);
>> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
>> > +		return;
>> > +	WRITE_ONCE(
>> > +		vmbus_connection.channels[channel->offermsg.child_relid],
>> > +		NULL);
>> 
>> I don't think this smp_store_release()/WRITE_ONCE() fanciness gives you
>> anything. Basically, without proper synchronization with a lock there is
>> no such constructions which will give you any additional guarantee on
>> top of just doing X=1. E.g. smp_store_release() is just 
>>   barrier();
>>   *p = v;
>> if I'm not mistaken. Nobody tells you when *some other CPU* will see the
>> update - 'eventually' is your best guess. Here, you're only setting one
>> pointer.
>> 
>> Percpu structures have an advantage: we (almost) never access them from
>> different CPUs so just doing updates atomically (and writing 64bit
>> pointer on x86_64 is atomic) is OK.
>> 
>> I haven't looked at all possible scenarios but I'd suggest protecting
>> this array with a spinlock (in case we can have simultaneous accesses
>> from different CPUs and care about the result, of course).
>
> The smp_store_release()+READ_ONCE() pair should guarantee that any store
> to the channel fields performed before (in program order) the "mapping"
> of the channel are visible to the CPU which observes that mapping; this
> guarantee is expected to hold for all architectures.

Yes, basically the order is preserved (but no guarantees WHEN another
CPU will see it).

>
> Notice that this apporach follows the current/upstream code, cf. the
> rcu_assign_pointer() in list_add_tail_rcu() and notice that (both before
> and after this series) vmbus_chan_sched() accesses the channel array
> without any mutex/lock held.
>
> I'd be inclined to stick to the current code (unless more turns out to
> be required).  Thoughts?

Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
per-cpu list of channels on the same CPU so we don't need a spinlock to
guarantee that during an interrupt we'll be able to see the update if it
happened before the interrupt (in chronological order). With a global
list of relids, who guarantees that an interrupt handler on another CPU
will actually see the modified list? 

-- 
Vitaly

