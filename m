Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F00194182
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2020 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZOb3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Mar 2020 10:31:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27120 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbgCZOb2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Mar 2020 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585233087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hHlgqWBGTYF+EP7OJv8CgOvjntab1ZGJc7fSi3pD38=;
        b=e80tzGzfyTMvBgW10Gmk8j5SG5o7+qobU/GCBOJT/0aPYM1XxP1+RddN56werKwNR3W52V
        kna60o83tCOym5SPzWoZsf25djdG9qJNU2E4gMdIDFQhQUWo18/GVFJW/bM9oSJ75qBgJe
        wwfz97L7LAKBQ1T5IlmppRBWMrs99SE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-ZYA-iEsyMdC4Fbp6rAtUXg-1; Thu, 26 Mar 2020 10:31:24 -0400
X-MC-Unique: ZYA-iEsyMdC4Fbp6rAtUXg-1
Received: by mail-wr1-f72.google.com with SMTP id v6so3090304wrg.22
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Mar 2020 07:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3hHlgqWBGTYF+EP7OJv8CgOvjntab1ZGJc7fSi3pD38=;
        b=XMqkQQZq7cu4RLz/rFVYseJMbdxAylE4xxre4mfODUVy/RguHMQ/AA2O9+omicToCA
         42Q4/fD7goQtn2tgYx4gBA4KE+pMhEgUwBjuPedDuNnWme9nUAkruBTH6F6SUvnvP+4E
         U/7MdNCDxguodbzLVDz7QHDgyuUL9pMndyXOfic9VJlISwkk9oozGHZStwIz48QDXOji
         J7iKoRtvKvhZZNFF0FEvtd5Gu6vbdH6XxPQ5Cq79o7O65lX4+G1UenIDf9/1cUTpsgPQ
         0lxmDegn6APrPpLp+aYOwng+Mx0M48S3V4em7I5mjXa1FcPbNY19qXPO4wnPZYd025M/
         oFxg==
X-Gm-Message-State: ANhLgQ2VDZyA50l0x8Irks6pGmo3pmaFxbeLqdgFSoJNQi7ZNMJ/CjA9
        WKro7D/4voRXFChfNsCZgFRVNL3CA6xdLsOE72xoT6jB/zcLSkFRUH3rcrcG2dDbdeo2U0hGv0S
        jK1oyQRrVZM870JVW3VRy9t+q
X-Received: by 2002:a1c:a552:: with SMTP id o79mr217097wme.87.1585233082772;
        Thu, 26 Mar 2020 07:31:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtnYnQFi5DhVEgwMpR/bpn4ML5NB0wBTt4PmvgHKIZ2naWHhDzcdlzTqPNOhCyhHsZre2gFaw==
X-Received: by 2002:a1c:a552:: with SMTP id o79mr217059wme.87.1585233082299;
        Thu, 26 Mar 2020 07:31:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm3904511wru.88.2020.03.26.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:31:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Andrea Parri \(Microsoft\)" <parri.andrea@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
In-Reply-To: <20200325225505.23998-4-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com>
Date:   Thu, 26 Mar 2020 15:31:20 +0100
Message-ID: <87y2rn4287.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:

> When Hyper-V sends an interrupt to the guest, the guest has to figure
> out which channel the interrupt is associated with.  Hyper-V sets a bit
> in a memory page that is shared with the guest, indicating a particular
> "relid" that the interrupt is associated with.  The current Linux code
> then uses a set of per-CPU linked lists to map a given "relid" to a
> pointer to a channel structure.
>
> This design introduces a synchronization problem if the CPU that Hyper-V
> will interrupt for a certain channel is changed.  If the interrupt comes
> on the "old CPU" and the channel was already moved to the per-CPU list
> of the "new CPU", then the relid -> channel mapping will fail and the
> interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
> but the channel was not moved to the per-CPU list of the new CPU, then
> the mapping will fail and the interrupt is dropped.
>
> Relids are integers ranging from 0 to 2047.  The mapping from relids to
> channel structures can be done by setting up an array with 2048 entries,
> each entry being a pointer to a channel structure (hence total size ~16K
> bytes, which is not a problem).  The array is global, so there are no
> per-CPU linked lists to update.   The array can be searched and updated
> by simply loading and storing the array at the specified index.  With no
> per-CPU data structures, the above mentioned synchronization problem is
> avoided and the relid2channel() function gets simpler.
>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 158 ++++++++++++++++++++++----------------
>  drivers/hv/connection.c   |  38 +++------
>  drivers/hv/hv.c           |   2 -
>  drivers/hv/hyperv_vmbus.h |  14 ++--
>  drivers/hv/vmbus_drv.c    |  48 +++++++-----
>  include/linux/hyperv.h    |   5 --
>  6 files changed, 139 insertions(+), 126 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 1191f3d76d111..9b1449c839575 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -319,7 +319,6 @@ static struct vmbus_channel *alloc_channel(void)
>  	init_completion(&channel->rescind_event);
>  
>  	INIT_LIST_HEAD(&channel->sc_list);
> -	INIT_LIST_HEAD(&channel->percpu_list);
>  
>  	tasklet_init(&channel->callback_event,
>  		     vmbus_on_event, (unsigned long)channel);
> @@ -340,23 +339,28 @@ static void free_channel(struct vmbus_channel *channel)
>  	kobject_put(&channel->kobj);
>  }
>  
> -static void percpu_channel_enq(void *arg)
> +void vmbus_channel_map_relid(struct vmbus_channel *channel)
>  {
> -	struct vmbus_channel *channel = arg;
> -	struct hv_per_cpu_context *hv_cpu
> -		= this_cpu_ptr(hv_context.cpu_context);
> -
> -	list_add_tail_rcu(&channel->percpu_list, &hv_cpu->chan_list);
> +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
> +		return;
> +	/*
> +	 * Pairs with the READ_ONCE() in vmbus_chan_sched().  Guarantees
> +	 * that vmbus_chan_sched() will find up-to-date data.
> +	 */
> +	smp_store_release(
> +		&vmbus_connection.channels[channel->offermsg.child_relid],
> +		channel);
>  }
>  
> -static void percpu_channel_deq(void *arg)
> +void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
>  {
> -	struct vmbus_channel *channel = arg;
> -
> -	list_del_rcu(&channel->percpu_list);
> +	if (WARN_ON(channel->offermsg.child_relid >= MAX_CHANNEL_RELIDS))
> +		return;
> +	WRITE_ONCE(
> +		vmbus_connection.channels[channel->offermsg.child_relid],
> +		NULL);

I don't think this smp_store_release()/WRITE_ONCE() fanciness gives you
anything. Basically, without proper synchronization with a lock there is
no such constructions which will give you any additional guarantee on
top of just doing X=1. E.g. smp_store_release() is just 
  barrier();
  *p = v;
if I'm not mistaken. Nobody tells you when *some other CPU* will see the
update - 'eventually' is your best guess. Here, you're only setting one
pointer.

Percpu structures have an advantage: we (almost) never access them from
different CPUs so just doing updates atomically (and writing 64bit
pointer on x86_64 is atomic) is OK.

I haven't looked at all possible scenarios but I'd suggest protecting
this array with a spinlock (in case we can have simultaneous accesses
from different CPUs and care about the result, of course).

>  }
>  
> -
>  static void vmbus_release_relid(u32 relid)
>  {
>  	struct vmbus_channel_relid_released msg;
> @@ -376,17 +380,25 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>  	struct vmbus_channel *primary_channel;
>  	unsigned long flags;
>  
> -	BUG_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
>  	BUG_ON(!channel->rescind);
>  
> -	if (channel->target_cpu != get_cpu()) {
> -		put_cpu();
> -		smp_call_function_single(channel->target_cpu,
> -					 percpu_channel_deq, channel, true);
> -	} else {
> -		percpu_channel_deq(channel);
> -		put_cpu();
> -	}
> +	/*
> +	 * hv_process_channel_removal() could find INVALID_RELID only for
> +	 * hv_sock channels.  See the inline comments in vmbus_onoffer().
> +	 */
> +	WARN_ON(channel->offermsg.child_relid == INVALID_RELID &&
> +		!is_hvsock_channel(channel));
> +
> +	/*
> +	 * Upon suspend, an in-use hv_sock channel is removed from the array of
> +	 * channels and the relid is invalidated.  After hibernation, when the
> +	 * user-space appplication destroys the channel, it's unnecessary and
> +	 * unsafe to remove the channel from the array of channels.  See also
> +	 * the inline comments before the call of vmbus_release_relid() below.
> +	 */
> +	if (channel->offermsg.child_relid != INVALID_RELID)
> +		vmbus_channel_unmap_relid(channel);
>  
>  	if (channel->primary_channel == NULL) {
>  		list_del(&channel->listentry);
> @@ -447,16 +459,6 @@ static void vmbus_add_channel_work(struct work_struct *work)
>  
>  	init_vp_index(newchannel, dev_type);
>  
> -	if (newchannel->target_cpu != get_cpu()) {
> -		put_cpu();
> -		smp_call_function_single(newchannel->target_cpu,
> -					 percpu_channel_enq,
> -					 newchannel, true);
> -	} else {
> -		percpu_channel_enq(newchannel);
> -		put_cpu();
> -	}
> -
>  	/*
>  	 * This state is used to indicate a successful open
>  	 * so that when we do close the channel normally, we
> @@ -523,17 +525,10 @@ static void vmbus_add_channel_work(struct work_struct *work)
>  		spin_unlock_irqrestore(&primary_channel->lock, flags);
>  	}
>  
> -	mutex_unlock(&vmbus_connection.channel_mutex);
> +	/* vmbus_process_offer() has mapped the channel. */
> +	vmbus_channel_unmap_relid(newchannel);
>  
> -	if (newchannel->target_cpu != get_cpu()) {
> -		put_cpu();
> -		smp_call_function_single(newchannel->target_cpu,
> -					 percpu_channel_deq,
> -					 newchannel, true);
> -	} else {
> -		percpu_channel_deq(newchannel);
> -		put_cpu();
> -	}
> +	mutex_unlock(&vmbus_connection.channel_mutex);
>  
>  	vmbus_release_relid(newchannel->offermsg.child_relid);
>  
> @@ -599,6 +594,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
>  		spin_unlock_irqrestore(&channel->lock, flags);
>  	}
>  
> +	vmbus_channel_map_relid(newchannel);
> +
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>  
>  	/*
> @@ -937,8 +934,6 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>  	oldchannel = find_primary_channel_by_offer(offer);
>  
>  	if (oldchannel != NULL) {
> -		atomic_dec(&vmbus_connection.offer_in_progress);
> -
>  		/*
>  		 * We're resuming from hibernation: all the sub-channel and
>  		 * hv_sock channels we had before the hibernation should have
> @@ -946,36 +941,65 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>  		 * primary channel that we had before the hibernation.
>  		 */
>  
> +		/*
> +		 * { Initially: channel relid = INVALID_RELID,
> +		 *		channels[valid_relid] = NULL }
> +		 *
> +		 * CPU1					CPU2
> +		 *
> +		 * [vmbus_onoffer()]			[vmbus_device_release()]
> +		 *
> +		 * LOCK channel_mutex			LOCK channel_mutex
> +		 * STORE channel relid = valid_relid	LOAD r1 = channel relid
> +		 * MAP_RELID channel			if (r1 != INVALID_RELID)
> +		 * UNLOCK channel_mutex			  UNMAP_RELID channel
> +		 *					UNLOCK channel_mutex
> +		 *
> +		 * Forbids: r1 == valid_relid &&
> +		 * 		channels[valid_relid] == channel
> +		 *
> +		 * Note.  r1 can be INVALID_RELID only for an hv_sock channel.
> +		 * None of the hv_sock channels which were present before the
> +		 * suspend are re-offered upon the resume.  See the WARN_ON()
> +		 * in hv_process_channel_removal().
> +		 */
> +		mutex_lock(&vmbus_connection.channel_mutex);
> +
> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +
>  		WARN_ON(oldchannel->offermsg.child_relid != INVALID_RELID);
>  		/* Fix up the relid. */
>  		oldchannel->offermsg.child_relid = offer->child_relid;
>  
>  		offer_sz = sizeof(*offer);
> -		if (memcmp(offer, &oldchannel->offermsg, offer_sz) == 0) {
> -			check_ready_for_resume_event();
> -			return;
> +		if (memcmp(offer, &oldchannel->offermsg, offer_sz) != 0) {
> +			/*
> +			 * This is not an error, since the host can also change
> +			 * the other field(s) of the offer, e.g. on WS RS5
> +			 * (Build 17763), the offer->connection_id of the
> +			 * Mellanox VF vmbus device can change when the host
> +			 * reoffers the device upon resume.
> +			 */
> +			pr_debug("vmbus offer changed: relid=%d\n",
> +				 offer->child_relid);
> +
> +			print_hex_dump_debug("Old vmbus offer: ",
> +					     DUMP_PREFIX_OFFSET, 16, 4,
> +					     &oldchannel->offermsg, offer_sz,
> +					     false);
> +			print_hex_dump_debug("New vmbus offer: ",
> +					     DUMP_PREFIX_OFFSET, 16, 4,
> +					     offer, offer_sz, false);
> +
> +			/* Fix up the old channel. */
> +			vmbus_setup_channel_state(oldchannel, offer);
>  		}
>  
> -		/*
> -		 * This is not an error, since the host can also change the
> -		 * other field(s) of the offer, e.g. on WS RS5 (Build 17763),
> -		 * the offer->connection_id of the Mellanox VF vmbus device
> -		 * can change when the host reoffers the device upon resume.
> -		 */
> -		pr_debug("vmbus offer changed: relid=%d\n",
> -			 offer->child_relid);
> -
> -		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
> -				     16, 4, &oldchannel->offermsg, offer_sz,
> -				     false);
> -		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
> -				     16, 4, offer, offer_sz, false);
> -
> -		/* Fix up the old channel. */
> -		vmbus_setup_channel_state(oldchannel, offer);
> -
> +		/* Add the channel back to the array of channels. */
> +		vmbus_channel_map_relid(oldchannel);
>  		check_ready_for_resume_event();
>  
> +		mutex_unlock(&vmbus_connection.channel_mutex);
>  		return;
>  	}
>  
> @@ -1033,14 +1057,14 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
>  	 *
>  	 * CPU1				CPU2
>  	 *
> -	 * [vmbus_process_offer()]	[vmbus_onoffer_rescind()]
> +	 * [vmbus_onoffer()]		[vmbus_onoffer_rescind()]
>  	 *
>  	 * LOCK channel_mutex		WAIT_ON offer_in_progress == 0
>  	 * DECREMENT offer_in_progress	LOCK channel_mutex
> -	 * INSERT chn_list		SEARCH chn_list
> +	 * STORE channels[]		LOAD channels[]
>  	 * UNLOCK channel_mutex		UNLOCK channel_mutex
>  	 *
> -	 * Forbids: CPU2's SEARCH from *not* seeing CPU1's INSERT
> +	 * Forbids: CPU2's LOAD from *not* seeing CPU1's STORE
>  	 */
>  
>  	while (atomic_read(&vmbus_connection.offer_in_progress) != 0) {
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index f4bd306d2cef9..11170d9a2e1a5 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -248,6 +248,14 @@ int vmbus_connect(void)
>  	pr_info("Vmbus version:%d.%d\n",
>  		version >> 16, version & 0xFFFF);
>  
> +	vmbus_connection.channels = kcalloc(MAX_CHANNEL_RELIDS,
> +					    sizeof(struct vmbus_channel *),
> +					    GFP_KERNEL);
> +	if (vmbus_connection.channels == NULL) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
>  	kfree(msginfo);
>  	return 0;
>  
> @@ -295,33 +303,9 @@ void vmbus_disconnect(void)
>   */
>  struct vmbus_channel *relid2channel(u32 relid)
>  {
> -	struct vmbus_channel *channel;
> -	struct vmbus_channel *found_channel  = NULL;
> -	struct list_head *cur, *tmp;
> -	struct vmbus_channel *cur_sc;
> -
> -	BUG_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
> -
> -	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> -		if (channel->offermsg.child_relid == relid) {
> -			found_channel = channel;
> -			break;
> -		} else if (!list_empty(&channel->sc_list)) {
> -			/*
> -			 * Deal with sub-channels.
> -			 */
> -			list_for_each_safe(cur, tmp, &channel->sc_list) {
> -				cur_sc = list_entry(cur, struct vmbus_channel,
> -							sc_list);
> -				if (cur_sc->offermsg.child_relid == relid) {
> -					found_channel = cur_sc;
> -					break;
> -				}
> -			}
> -		}
> -	}
> -
> -	return found_channel;
> +	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
> +		return NULL;
> +	return READ_ONCE(vmbus_connection.channels[relid]);
>  }
>  
>  /*
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index e2b3310454640..17bf1f229152b 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -117,8 +117,6 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> -
> -		INIT_LIST_HEAD(&hv_cpu->chan_list);
>  	}
>  
>  	return 0;
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 67fb1edcbf527..2216cd5e8e8bf 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -132,12 +132,6 @@ struct hv_per_cpu_context {
>  	 * basis.
>  	 */
>  	struct tasklet_struct msg_dpc;
> -
> -	/*
> -	 * To optimize the mapping of relid to channel, maintain
> -	 * per-cpu list of the channels based on their CPU affinity.
> -	 */
> -	struct list_head chan_list;
>  };
>  
>  struct hv_context {
> @@ -202,6 +196,8 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
>  /* TODO: Need to make this configurable */
>  #define MAX_NUM_CHANNELS_SUPPORTED	256
>  
> +#define MAX_CHANNEL_RELIDS					\
> +	max(MAX_NUM_CHANNELS_SUPPORTED, HV_EVENT_FLAGS_COUNT)
>  
>  enum vmbus_connect_state {
>  	DISCONNECTED,
> @@ -251,6 +247,9 @@ struct vmbus_connection {
>  	struct list_head chn_list;
>  	struct mutex channel_mutex;
>  
> +	/* Array of channels */
> +	struct vmbus_channel **channels;
> +
>  	/*
>  	 * An offer message is handled first on the work_queue, and then
>  	 * is further handled on handle_primary_chan_wq or
> @@ -337,6 +336,9 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj,
>  
>  void vmbus_remove_channel_attr_group(struct vmbus_channel *channel);
>  
> +void vmbus_channel_map_relid(struct vmbus_channel *channel);
> +void vmbus_channel_unmap_relid(struct vmbus_channel *channel);
> +
>  struct vmbus_channel *relid2channel(u32 relid);
>  
>  void vmbus_free_channels(void);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 903b1ec6a259e..301e3f484bb1a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1198,33 +1198,39 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
>  		if (relid == 0)
>  			continue;
>  
> +		/*
> +		 * Pairs with the kfree_rcu() in vmbus_chan_release().
> +		 * Guarantees that the channel data structure doesn't
> +		 * get freed while the channel pointer below is being
> +		 * dereferenced.
> +		 */
>  		rcu_read_lock();
>  
>  		/* Find channel based on relid */
> -		list_for_each_entry_rcu(channel, &hv_cpu->chan_list, percpu_list) {
> -			if (channel->offermsg.child_relid != relid)
> -				continue;
> +		channel = relid2channel(relid);
> +		if (channel == NULL)
> +			goto sched_unlock_rcu;
>  
> -			if (channel->rescind)
> -				continue;
> +		if (channel->rescind)
> +			goto sched_unlock_rcu;
>  
> -			trace_vmbus_chan_sched(channel);
> +		trace_vmbus_chan_sched(channel);
>  
> -			++channel->interrupts;
> +		++channel->interrupts;
>  
> -			switch (channel->callback_mode) {
> -			case HV_CALL_ISR:
> -				vmbus_channel_isr(channel);
> -				break;
> +		switch (channel->callback_mode) {
> +		case HV_CALL_ISR:
> +			vmbus_channel_isr(channel);
> +			break;
>  
> -			case HV_CALL_BATCHED:
> -				hv_begin_read(&channel->inbound);
> -				/* fallthrough */
> -			case HV_CALL_DIRECT:
> -				tasklet_schedule(&channel->callback_event);
> -			}
> +		case HV_CALL_BATCHED:
> +			hv_begin_read(&channel->inbound);
> +			fallthrough;
> +		case HV_CALL_DIRECT:
> +			tasklet_schedule(&channel->callback_event);
>  		}
>  
> +sched_unlock_rcu:
>  		rcu_read_unlock();
>  	}
>  }
> @@ -2208,9 +2214,12 @@ static int vmbus_bus_suspend(struct device *dev)
>  
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>  		/*
> -		 * Invalidate the field. Upon resume, vmbus_onoffer() will fix
> -		 * up the field, and the other fields (if necessary).
> +		 * Remove the channel from the array of channels and invalidate
> +		 * the channel's relid.  Upon resume, vmbus_onoffer() will fix
> +		 * up the relid (and other fields, if necessary) and add the
> +		 * channel back to the array.
>  		 */
> +		vmbus_channel_unmap_relid(channel);
>  		channel->offermsg.child_relid = INVALID_RELID;
>  
>  		if (is_hvsock_channel(channel)) {
> @@ -2450,6 +2459,7 @@ static void __exit vmbus_exit(void)
>  	hv_debug_rm_all_dir();
>  
>  	vmbus_free_channels();
> +	kfree(vmbus_connection.channels);
>  
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		kmsg_dump_unregister(&hv_kmsg_dumper);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 692c89ccf5dfd..6c794fd5c903e 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -854,11 +854,6 @@ struct vmbus_channel {
>  	 * Support per-channel state for use by vmbus drivers.
>  	 */
>  	void *per_channel_state;
> -	/*
> -	 * To support per-cpu lookup mapping of relid to channel,
> -	 * link up channels based on their CPU affinity.
> -	 */
> -	struct list_head percpu_list;
>  
>  	/*
>  	 * Defer freeing channel until after all cpu's have

-- 
Vitaly

