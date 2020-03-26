Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DD194505
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCZRF2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 13:05:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41265 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCZRF1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 13:05:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so8731787wrc.8;
        Thu, 26 Mar 2020 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/SwPVZPHnsnHsjMmVKbjcflPz+h1SoF07T1yIdW0tjk=;
        b=BolFconVuR8kKU7pZSf5B2FXry7FPPFhSF8LOywidHC7WuNSwOAVblUZPlX67eMcKa
         fi11YKZ2E27OPO2SjK9xeDEox2ek0tmfO1oSBqLzxnRSceRP/ZMm/OScgiHPXKEf/mmH
         CvmZJlKjOIEVnw/EAeYq7JT4xyX0XVjqmK0kIjMS2ZsiBNP0bCn5kFK+1BZVmuz3Cy1Z
         akMBT86QyM2X8qNiFJGADXH7+lrQH9gch3BklQM5LRDXV85N7eJd4lsOUOPrkouiv/Di
         o7hEa57KFHG6Xq0E3LBVBdKzKwKYKvJ5QRY1bvU6MY/B91Dqk9VcPBBf1AW4vOLs4QZN
         dw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/SwPVZPHnsnHsjMmVKbjcflPz+h1SoF07T1yIdW0tjk=;
        b=nU9Syz1wskuWIKlOhe70m8dPbXeqMqAdY2IsIT4YcR6oh+ZFDOoL869HyVk0MImUbe
         DiSdAL6GW0o9xw+DDXTZ+TPF+n3UlK6sIvmESozXZSgrIYHwbkwZxe0+ruaStvSbQ0H0
         otEsMuGiCT7BLc1byNIY+7xlbcK7/3My599MLoQHbECyxN9s+wVY4ubZltyP2fiR+OV0
         XCg4PDvbyABkEr68u3++WDlc6NZuhERLaafp6JW0VQ8M+K+6jqnYSI4233wtJoRmgr7R
         qQrmnabTe6IF54rAExDanTa0oiVStCMO5uFjbNlY0cEYkk1SWKo3icLuzRJE/z0P/oXY
         FtxQ==
X-Gm-Message-State: ANhLgQ258P3+rORfI6AS8FvlDX6TF4rQBAtij6F3+B5JjoG0SkUIoo5h
        tH1acAfZadS5u/7qoBEG80lFxG45hLvRnpfP
X-Google-Smtp-Source: ADFU+vtZf+Rru0HdqckcezlKcjYIY+mDjzCxKZNmaVnzmQHiwUybydBAAYpK9IZAXgxvNYPQ79j+fw==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr10274434wrc.294.1585242324532;
        Thu, 26 Mar 2020 10:05:24 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id o9sm4484102wrx.48.2020.03.26.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:05:24 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:05:18 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU
 channel lists with a global array of channels
Message-ID: <20200326170518.GA14314@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-4-parri.andrea@gmail.com>
 <87y2rn4287.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2rn4287.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 26, 2020 at 03:31:20PM +0100, Vitaly Kuznetsov wrote:
> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
> 
> > When Hyper-V sends an interrupt to the guest, the guest has to figure
> > out which channel the interrupt is associated with.  Hyper-V sets a bit
> > in a memory page that is shared with the guest, indicating a particular
> > "relid" that the interrupt is associated with.  The current Linux code
> > then uses a set of per-CPU linked lists to map a given "relid" to a
> > pointer to a channel structure.
> >
> > This design introduces a synchronization problem if the CPU that Hyper-V
> > will interrupt for a certain channel is changed.  If the interrupt comes
> > on the "old CPU" and the channel was already moved to the per-CPU list
> > of the "new CPU", then the relid -> channel mapping will fail and the
> > interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
> > but the channel was not moved to the per-CPU list of the new CPU, then
> > the mapping will fail and the interrupt is dropped.
> >
> > Relids are integers ranging from 0 to 2047.  The mapping from relids to
> > channel structures can be done by setting up an array with 2048 entries,
> > each entry being a pointer to a channel structure (hence total size ~16K
> > bytes, which is not a problem).  The array is global, so there are no
> > per-CPU linked lists to update.   The array can be searched and updated
> > by simply loading and storing the array at the specified index.  With no
> > per-CPU data structures, the above mentioned synchronization problem is
> > avoided and the relid2channel() function gets simpler.
> >
> > Suggested-by: Michael Kelley <mikelley@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 158 ++++++++++++++++++++++----------------
> >  drivers/hv/connection.c   |  38 +++------
> >  drivers/hv/hv.c           |   2 -
> >  drivers/hv/hyperv_vmbus.h |  14 ++--
> >  drivers/hv/vmbus_drv.c    |  48 +++++++-----
> >  include/linux/hyperv.h    |   5 --
> >  6 files changed, 139 insertions(+), 126 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 1191f3d76d111..9b1449c839575 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -319,7 +319,6 @@ static struct vmbus_channel *alloc_channel(void)
> >  	init_completion(&channel->rescind_event);
> >  
> >  	INIT_LIST_HEAD(&channel->sc_list);
> > -	INIT_LIST_HEAD(&channel->percpu_list);
> >  
> >  	tasklet_init(&channel->callback_event,
> >  		     vmbus_on_event, (unsigned long)channel);
> > @@ -340,23 +339,28 @@ static void free_channel(struct vmbus_channel *channel)
> >  	kobject_put(&channel->kobj);
> >  }
> >  
> > -static void percpu_channel_enq(void *arg)
> > +void vmbus_channel_map_relid(struct vmbus_channel *channel)
> >  {
> > -	struct vmbus_channel *channel = arg;
> > -	struct hv_per_cpu_context *hv_cpu
> > -		= this_cpu_ptr(hv_context.cpu_context);
> > -
> > -	list_add_tail_rcu(&channel->percpu_list, &hv_cpu->chan_list);
> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
> > +		return;
> > +	/*
> > +	 * Pairs with the READ_ONCE() in vmbus_chan_sched().  Guarantees
> > +	 * that vmbus_chan_sched() will find up-to-date data.
> > +	 */
> > +	smp_store_release(
> > +		&vmbus_connection.channels[channel->offermsg.child_relid],
> > +		channel);
> >  }
> >  
> > -static void percpu_channel_deq(void *arg)
> > +void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
> >  {
> > -	struct vmbus_channel *channel = arg;
> > -
> > -	list_del_rcu(&channel->percpu_list);
> > +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
> > +		return;
> > +	WRITE_ONCE(
> > +		vmbus_connection.channels[channel->offermsg.child_relid],
> > +		NULL);
> 
> I don't think this smp_store_release()/WRITE_ONCE() fanciness gives you
> anything. Basically, without proper synchronization with a lock there is
> no such constructions which will give you any additional guarantee on
> top of just doing X=1. E.g. smp_store_release() is just 
>   barrier();
>   *p = v;
> if I'm not mistaken. Nobody tells you when *some other CPU* will see the
> update - 'eventually' is your best guess. Here, you're only setting one
> pointer.
> 
> Percpu structures have an advantage: we (almost) never access them from
> different CPUs so just doing updates atomically (and writing 64bit
> pointer on x86_64 is atomic) is OK.
> 
> I haven't looked at all possible scenarios but I'd suggest protecting
> this array with a spinlock (in case we can have simultaneous accesses
> from different CPUs and care about the result, of course).

The smp_store_release()+READ_ONCE() pair should guarantee that any store
to the channel fields performed before (in program order) the "mapping"
of the channel are visible to the CPU which observes that mapping; this
guarantee is expected to hold for all architectures.

Notice that this apporach follows the current/upstream code, cf. the
rcu_assign_pointer() in list_add_tail_rcu() and notice that (both before
and after this series) vmbus_chan_sched() accesses the channel array
without any mutex/lock held.

I'd be inclined to stick to the current code (unless more turns out to
be required).  Thoughts?

Thanks,
  Andrea
