Return-Path: <linux-hyperv+bounces-3171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F209A9F2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11932B23BAC
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1CB198E91;
	Tue, 22 Oct 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="coMoczt6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A917187330;
	Tue, 22 Oct 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590623; cv=none; b=A9PcoXoEXXsohIDFKKdwL/lu2P1eVltxel+T4DnQbPbwJSbEUi/hflh3aBDHmqU8WNzvM54iEwn11kndJRQsG2VexpASAkknqK4ZgQzQaJw0n7RrK69YOPQm7Mkgbt4qdHMbhwAv+lS29KzwMPdfTZwCTH8SZaVdTKfBXHQfePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590623; c=relaxed/simple;
	bh=A0DY30k6mCjy+3mccBeJUIerEWWPD5C1uJzQVsk6V20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=je4pMR3YYSR6XMvjAlHbKn7khz1fIIVVJYYKJwtSQ8lcStFWJgsJ2erMsDqseHwWlC8HOvtlw+wPdfP4MjsLSJIwG3sRRlwJMulH7/WrXgeWLYrcovrK/Dks+ewCNMJRui42R0cBhs6FsTa+aEhK5YqW9cAdUGYto3mgNY1Idk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=coMoczt6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.102] (unknown [49.205.243.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8201B210DEAC;
	Tue, 22 Oct 2024 02:50:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8201B210DEAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729590620;
	bh=PMBtNPaK7JO20cPACuX3x9kAI9l+aXSkHcoskBrf4OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=coMoczt6cqi1X/EDD4T/O/pewY0GT+a52NHKIXN/7uEvgvuM9zBMXMrEmqCjaR5Be
	 OorArfCj0pXHFoVuQJ5cLHQwc/BCoyD09TSNHjtABeJJKY1I2koVrjF17ezKWpmK6R
	 UYnctn4Bs63aptOvvhrl+wqZlqXum8Mp37fi9Iwk=
Message-ID: <81b0e19f-7711-4cfb-8cb1-8d4c1affc0d1@linux.microsoft.com>
Date: Tue, 22 Oct 2024 15:20:17 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 John Starks <jostarks@microsoft.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157F0678E2F7074A905BB64D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F0678E2F7074A905BB64D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/21/2024 10:03 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 18, 2024 4:58 AM
>>
>> Channels offers are requested during vmbus initialization and resume
>> from hibernation. Add support to wait for all channel offers to be
>> delivered and processed before returning from vmbus_request_offers.
>> This is to support user mode (VTL0) in OpenHCL (A Linux based
>> paravisor for Confidential VMs) to ensure that all channel offers
>> are present when init begins in VTL0, and it knows which channels
>> the host has offered and which it has not.
>>
>> This is in analogy to a PCI bus not returning from probe until it has
>> scanned all devices on the bus.
>>
>> Without this, user mode can race with vmbus initialization and miss
>> channel offers. User mode has no way to work around this other than
>> sleeping for a while, since there is no way to know when vmbus has
>> finished processing offers.
>>
>> With this added functionality, remove earlier logic which keeps track
>> of count of offered channels post resume from hibernation. Once all
>> offers delivered message is received, no further offers are going to
>> be received. Consequently, logic to prevent suspend from happening
>> after previous resume had missing offers, is also removed.
>>
>> Co-developed-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
>>   drivers/hv/connection.c   |  4 ++--
>>   drivers/hv/hyperv_vmbus.h | 14 +++-----------
>>   drivers/hv/vmbus_drv.c    | 16 ----------------
>>   4 files changed, 28 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 3c6011a48dab..ac514805dafe 100644
>> --- a/drivers/hv/channel_mgmt.c
>> +++ b/drivers/hv/channel_mgmt.c
>> @@ -944,16 +944,6 @@ void vmbus_initiate_unload(bool crash)
>>   		vmbus_wait_for_unload();
>>   }
>>
>> -static void check_ready_for_resume_event(void)
>> -{
>> -	/*
>> -	 * If all the old primary channels have been fixed up, then it's safe
>> -	 * to resume.
>> -	 */
>> -	if (atomic_dec_and_test(&vmbus_connection.nr_chan_fixup_on_resume))
>> -		complete(&vmbus_connection.ready_for_resume_event);
>> -}
>> -
>>   static void vmbus_setup_channel_state(struct vmbus_channel *channel,
>>   				      struct vmbus_channel_offer_channel *offer)
>>   {
>> @@ -1109,8 +1099,6 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>>
>>   		/* Add the channel back to the array of channels. */
>>   		vmbus_channel_map_relid(oldchannel);
>> -		check_ready_for_resume_event();
>> -
>>   		mutex_unlock(&vmbus_connection.channel_mutex);
>>   		return;
>>   	}
>> @@ -1297,12 +1285,11 @@
>> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>>   /*
>>    * vmbus_onoffers_delivered -
>>    * This is invoked when all offers have been delivered.
>> - *
>> - * Nothing to do here.
>>    */
> 
> I'm unclear on the meaning of the ALLOFFERS_DELIVERED message. In the
> early days of Hyper-V, the set of virtual devices in a VM was fixed before a
> VM started, so presumably ALLOFFERS_DELIVERED meant that offers for
> that fixed set of devices had been delivered. That meaning makes sense
> conceptually.
> 
> But more recent versions of Hyper-V support adding and removing devices
> at any time during the life of the VM. If a device is added, a new offer is
> generated. Existing devices (such as netvsc) can reconfigure their channels,
> in which case new subchannel offers are generated. So the core concept of
> "all offers delivered" isn't valid anymore.
> 
> To date Linux hasn't done anything with this message, so we didn't need
> precision about what it means. There's no VMBus specification or
> documentation, so we need some text here in the comments that
> explains precisely what ALLOFFERS_DELIVERED means, and how that
> meaning aligns with the fact that offers can be delivered anytime during
> the life of the VM.
> 
> I'll note that in the past there's also been some behavior where during guest
> boot, Hyper-V offers a virtual PCI device to the guest, immediately
> rescinds the vPCI device (before Linux even finished processing the offer),
> then offers it again. I wonder about how ALLOFFERS_DELIVERED interacts
> with that situation.
> 
> I ran some tests in an Azure L16s_v3 VM, which has three vPCI devices:
> 2 NVMe devices and 1 Mellanox CX-5. The offers for the 2 NVMe devices
> came before the ALLOFFERS_DELIVERED message, but the offer for
> the Mellanox CX-5 came *after* the ALLOFFERS_DELIVERED message.
> If that's the way the Mellanox CX-5 offers work, this patch breaks things
> in the hibernation resume path because ALLOFFERS_DELIVERED isn't
> sufficient to indicate that all primary channels have been re-offered
> and the resume can proceed. All sub-channel offers came after the
> ALLOFFERS_DELIVERED message, but that is what I expected and
> shouldn't be a problem.
> 
> It's hard for me to review this patch set without some precision around
> what ALLOFFERS_DELIVERED means.

Thanks for your valuable comments.
I checked this internally with John and here is the information you are
looking for.

CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the boot-time
offers are delivered. Other channels can be hot added later, even
immediately after the all-offers-delivered message.

A boot-time offer will be any of the virtual hardware the VM is
configured with at boot. The reason the Mellanox NIC is not included in
this list is because the Mellanoc NIC is an optional accelerator to the
synthetic vmbus NIC. It is hot added only after the vmbus NIC channel is
opened (once we know the guest can support it, via the sriov bit in the
netvsc protocol). So, it is not there at boot time, as we define it.

The reason the logs show the ordering below is that the vmbus driver
queues offer work to a work queue. The logs are out of order from the
actual messages that arrive. That’s why we have to flush the work queues
before we consider all the offers handled.

Regarding your comment for MLX CX-5, it is by design.The MLX device must
be logically hot removed and hot added back across a hibernate. There is
no guarantee the same accelerator device is present with the same
capabilities or device IDs or anything; the VHD could have been moved to
another machine with a different NIC, or to a VM without accelnet, or
whatever. This is all supported. So, it's not required to wait for the
MLX device to come back as part of hibernate resume.

Since Linux doesn't currently handle this correctly, the host works
around this by removing the MLX device before the guest hibernates. This
way, the guest does not expect an MLX device to still be present on
resume. This is inconvenient because it means the guest cannot initiate
hibernate on its own.

The behavior we want is for the guest to hot remove the MLX device
driver on resume, even if the MLX device was still present at suspend,
so that the host does not need this special pre-hibernate behavior. This
patch series may not be sufficient to ensure this, though. It just moves
things in the right direction, by handling the all-offers-delivered
message.

> 
>>   static void vmbus_onoffers_delivered(
>>   			struct vmbus_channel_message_header *hdr)
>>   {
>> +	complete(&vmbus_connection.all_offers_delivered_event);
>>   }
>>
>>   /*
>> @@ -1578,7 +1565,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
>>   }
>>
>>   /*
>> - * vmbus_request_offers - Send a request to get all our pending offers.
>> + * vmbus_request_offers - Send a request to get all our pending offers
>> + * and wait for all offers to arrive.
>>    */
>>   int vmbus_request_offers(void)
>>   {
>> @@ -1596,6 +1584,10 @@ int vmbus_request_offers(void)
>>
>>   	msg->msgtype = CHANNELMSG_REQUESTOFFERS;
>>
>> +	/*
>> +	 * This REQUESTOFFERS message will result in the host sending an all
>> +	 * offers delivered message.
>> +	 */
>>   	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header),
>>   			     true);
>>
>> @@ -1607,6 +1599,22 @@ int vmbus_request_offers(void)
>>   		goto cleanup;
>>   	}
>>
>> +	/* Wait for the host to send all offers. */
>> +	while (wait_for_completion_timeout(
>> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 1000)) == 0) {
> 
> Maybe do !wait_for_completion_timeout( ...) instead of explicitly testing
> for 0? I see that some existing code uses the explicit test for 0, but that's
> not the usual kernel code idiom.
> 
>> +		pr_warn("timed out waiting for all offers to be delivered...\n");
>> +	}
> 
> The while loop could continue forever. We don't want to trust the Hyper-V
> host to be well-behaved, so there should be an uber timeout where it gives
> up after 100 seconds (or pick some value). If the uber timeout is reached,
> I'm not sure if the code should panic or just go on -- it's debatable. But doing
> something explicit is probably better than repeatedly outputting the
> warning message forever.

You're right its debatable. It seems to be a best effort mechanism, and
we can't say for sure what all offers are going to be provided. So
printing a warning and moving ahead seems right to me. I'll remove the
loop, and keep it simple.

> 
>> +
>> +	/*
>> +	 * Flush handling of offer messages (which may initiate work on
>> +	 * other work queues).
>> +	 */
>> +	flush_workqueue(vmbus_connection.work_queue);
>> +
>> +	/* Flush processing the incoming offers. */
>> +	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
>> +	flush_workqueue(vmbus_connection.handle_sub_chan_wq);
> 
> Why does the sub-channel workqueue need to be flushed? Sub-channels
> get created at the request of the Linux driver, in cooperation with the VSP
> on the Hyper-V side. If the top-level goal is for user-space drivers to be
> able to know that at least a core set of offers have been processed, it
> seems like waiting for sub-channel offers isn't necessary. And new
> subchannel offers could arrive immediately after this flush, so the flush
> doesn't provide any guarantee about whether there are offers in that
> workqueue. If there is a valid reason to wait, some explanatory
> comments would be helpful.

I'll either remove it, or put a comment to manage the expectations that
this is just for best effort and there is no guarantee that all sub
channel offers will be entertained by now.

> 
> Michael
> 
>> +
>>   cleanup:
>>   	kfree(msginfo);
>>
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index f001ae880e1d..8351360bba16 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -34,8 +34,8 @@ struct vmbus_connection vmbus_connection = {
>>
>>   	.ready_for_suspend_event = COMPLETION_INITIALIZER(
>>   				  vmbus_connection.ready_for_suspend_event),
>> -	.ready_for_resume_event	= COMPLETION_INITIALIZER(
>> -				  vmbus_connection.ready_for_resume_event),
>> +	.all_offers_delivered_event = COMPLETION_INITIALIZER(
>> +				  vmbus_connection.all_offers_delivered_event),
>>   };
>>   EXPORT_SYMBOL_GPL(vmbus_connection);
>>
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index d2856023d53c..80cc65dac740 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -287,18 +287,10 @@ struct vmbus_connection {
>>   	struct completion ready_for_suspend_event;
>>
>>   	/*
>> -	 * The number of primary channels that should be "fixed up"
>> -	 * upon resume: these channels are re-offered upon resume, and some
>> -	 * fields of the channel offers (i.e. child_relid and connection_id)
>> -	 * can change, so the old offermsg must be fixed up, before the resume
>> -	 * callbacks of the VSC drivers start to further touch the channels.
>> +	 * Completed once the host has offered all channels. Note that
>> +	 * some channels may still be being process on a work queue.
>>   	 */
>> -	atomic_t nr_chan_fixup_on_resume;
>> -	/*
>> -	 * vmbus_bus_resume() waits for "nr_chan_fixup_on_resume" to
>> -	 * drop to zero.
>> -	 */
>> -	struct completion ready_for_resume_event;
>> +	struct completion all_offers_delivered_event;
>>   };
>>
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 9b15f7daf505..bd3fc41dc06b 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2427,11 +2427,6 @@ static int vmbus_bus_suspend(struct device *dev)
>>   	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
>>   		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
>>
>> -	if (atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) != 0) {
>> -		pr_err("Can not suspend due to a previous failed resuming\n");
>> -		return -EBUSY;
>> -	}
>> -
>>   	mutex_lock(&vmbus_connection.channel_mutex);
>>
>>   	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>> @@ -2456,17 +2451,12 @@ static int vmbus_bus_suspend(struct device *dev)
>>   			pr_err("Sub-channel not deleted!\n");
>>   			WARN_ON_ONCE(1);
>>   		}
>> -
>> -		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
>>   	}
>>
>>   	mutex_unlock(&vmbus_connection.channel_mutex);
>>
>>   	vmbus_initiate_unload(false);
>>
>> -	/* Reset the event for the next resume. */
>> -	reinit_completion(&vmbus_connection.ready_for_resume_event);
>> -
>>   	return 0;
>>   }
>>
>> @@ -2502,14 +2492,8 @@ static int vmbus_bus_resume(struct device *dev)
>>   	if (ret != 0)
>>   		return ret;
>>
>> -	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) == 0);
>> -
>>   	vmbus_request_offers();
>>
>> -	if (wait_for_completion_timeout(
>> -		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
>> -		pr_err("Some vmbus device is missing after suspending?\n");
>> -
>>   	/* Reset the event for the next suspend. */
>>   	reinit_completion(&vmbus_connection.ready_for_suspend_event);
>>
>> --
>> 2.34.1
>>
> 

Regards,
Naman


