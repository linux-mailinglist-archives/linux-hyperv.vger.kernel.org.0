Return-Path: <linux-hyperv+bounces-3255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBB9BC4C4
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 06:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA61C20F5D
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCA1B654E;
	Tue,  5 Nov 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Csl69V5D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E459926AEC;
	Tue,  5 Nov 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785260; cv=none; b=MC0JuQJA4B7hFaYbZNPJ4Fl3Ki34r8nQRNS3drio7Z/0X4uCF3AxTil6Lawmw3l6l3YHVqa3aIDUtqwJJknSvmpM4Y/ARIouDvUBALpOidnPCC3DttNGSvsi6D1lOhVSMFv8CdmfupKWwYZco4NmVSTzS8g6+gRCXHpFrRXEhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785260; c=relaxed/simple;
	bh=F4KJAkIxNOEvyGRCPeehtU28j2d6jBhighKIcng/28U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdBDDExEh/PzIsv8hLQqUGJQ98TOEnGMIOAmdcIBI4FUB0OSvRVRWThqt0ifG9cdTob3q/1YLGCq1/cTTIMZwtHFeRJL1lU3X2jZHZgWEVr8BGL+ENvIan4ghkxOnCZP3T6bJMC5Xr6UyCHqgOD8SGumaUapXSqPw97ZD+gBylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Csl69V5D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.102] (unknown [49.205.243.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 27DA42126CA5;
	Mon,  4 Nov 2024 21:40:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27DA42126CA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730785258;
	bh=OXyd1BsUuFsVYrlgfx/Fk3FA9zC/6KEyFTj+MHyQR/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Csl69V5DX0nObUas6XhvbBrK3DiM32dIwmnqQJW+6rXQ9EMIJSTNFRFtUfOxZPFhL
	 m51EZL92j8cq+PTtkG4cSSXkbsyuk9JrxGjrO4zJMjsb8MLL9V6RzVf+C0qcb0XzQU
	 F9a6zGZBnNOEz8bcCD2yno7pOOnk9raAA6N43I6Q=
Message-ID: <33061e3f-d1a8-4240-ad7e-d6ddc089f61c@linux.microsoft.com>
Date: Tue, 5 Nov 2024 11:10:54 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 John Starks <jostarks@microsoft.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157726CAAFB3F9FC8B682A4D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157726CAAFB3F9FC8B682A4D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/1/2024 12:43 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2024 1:02 AM
>>
>> Channel offers are requested during VMBus initialization and resume
>> from hibernation. Add support to wait for all channel offers to be
> 
> Given the definition of ALLOFFERS_DELIVERED, maybe change to:
> 
> " wait for all boot-time channel offers"

Thanks for reviewing, acked.

> 
>> delivered and processed before returning from vmbus_request_offers.
>>
>> This is in analogy to a PCI bus not returning from probe until it has
>> scanned all devices on the bus.
>>
>> Without this, user mode can race with VMBus initialization and miss
>> channel offers. User mode has no way to work around this other than
>> sleeping for a while, since there is no way to know when VMBus has
>> finished processing offers.
> 
> "finished processing boot-time offers."
>

Acked.


>>
>> With this added functionality, remove earlier logic which keeps track
>> of count of offered channels post resume from hibernation. Once all
>> offers delivered message is received, no further offers are going to
>> be received.
> 
> "no further boot-time offers"

Acked.

> 
>> Consequently, logic to prevent suspend from happening
>> after previous resume had missing offers, is also removed.
>>
>> Co-developed-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com/
>> * Added Easwar's Reviewed-By tag
>> * Addressed Michael's comments:
>>    * Added explanation of all offers delivered message in comments
>>    * Removed infinite wait for offers logic, and changed it wait once.
>>    * Removed sub channel workqueue flush logic
>>    * Added comments on why MLX device offer is not expected as part of
>>      this essential boot offer list. I refrained from adding too many
> 
> You've used slightly different phrasing here ("essential boot offer list").
> Potential confusion can be avoided if the terminology is super consistent.
> I'm good with "boot-time offers" (or something else if you prefer). I'm not
> sure what "essential" means here, unless it refers to offers for VFs from
> SR-IOV NICs (like Mellanox) being excluded. But it should be fine to
> use something short like "boot-time offers" and then note the VF
> exception in the code comments as you've done.

By essential, I meant the ones that the VM is configured with.
I'll stick with "boot-time offers".

> 
>> details on it as it felt like it is beyond the scope of this patch
>> series and may not be relevant to this. However, please let me know if
>>      something needs to be added.
>> * Addressed Saurabh's comments:
>>    * Changed timeout value to 10000 ms instead of 10*10000
>>    * Changed commit msg as per suggestions
>>    * Added a comment for warning case of wait_for_completion timeout
>> ---
>>   drivers/hv/channel_mgmt.c | 55 ++++++++++++++++++++++++++++-----------
>>   drivers/hv/connection.c   |  4 +--
>>   drivers/hv/hyperv_vmbus.h | 14 +++-------
>>   drivers/hv/vmbus_drv.c    | 16 ------------
>>   4 files changed, 45 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 3c6011a48dab..a2e9ebe5bf72 100644
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
>> @@ -1296,13 +1284,22 @@
>> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>>
>>   /*
>>    * vmbus_onoffers_delivered -
>> - * This is invoked when all offers have been delivered.
>> + * CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the essential
> 
> Again, I would drop "essential" here, as its meaning in this context isn't
> defined anywhere.
> 

Acked.

>> + * boot-time offers are delivered. Other channels can be hot added
>> + * or removed later, even immediately after the all-offers-delivered
>> + * message. A boot-time offer will be any of the virtual hardware the
>> + * VM is configured with at boot.
> 
> This is good to have a definition of "boot-time offer".  But I think some
> additional specification is appropriate.  Let me suggest the following:
> 
> The CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all
> boot-time offers are delivered. A boot-time offer is for the primary channel
> for any virtual hardware configured in the VM at the time it boots.
> Boot-time offers include offers for physical devices assigned to the VM
> via Hyper-V's Discrete Device Assignment (DDA) functionality that are
> handled as virtual PCI devices in Linux (e.g., NVMe devices and GPUs).
> Boot-time offers do not include offers for VMBus sub-channels. Because
> devices can be hot-added to the VM after it is booted, additional channel
> offers that aren't boot-time offers can be received at any time after the
> all-offers-delivered message.
> 
> SR-IOV NIC Virtual Functions (VFs) assigned to a VM are not considered
> to be assigned to the VM at boot-time, and offers for VFs may occur after
> the all-offers-delivered message. VFs are optional accelerators to the
> synthetic VMBus NIC and are effectively hot-added only after the VMBus
> NIC channel is opened (once it knows the guest can support it, via the
> sriov bit in the netvsc protocol).
> 
> [Please confirm that my suggested wording is correct!]

This explains really well. I'll rephrase the code comments. Thanks.

> 
>>    */
>>   static void vmbus_onoffers_delivered(
>>   			struct vmbus_channel_message_header *hdr)
>>   {
>> +	complete(&vmbus_connection.all_offers_delivered_event);
>>   }
>>
>>   /*
>> @@ -1578,7 +1575,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
>>   }
>>
>>   /*
>> - * vmbus_request_offers - Send a request to get all our pending offers.
>> + * vmbus_request_offers - Send a request to get all our pending offers
>> + * and wait for all offers to arrive.
>>    */
>>   int vmbus_request_offers(void)
>>   {
>> @@ -1596,6 +1594,10 @@ int vmbus_request_offers(void)
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
>> @@ -1607,6 +1609,29 @@ int vmbus_request_offers(void)
>>   		goto cleanup;
>>   	}
>>
>> +	/*
>> +	 * Wait for the host to send all offers.
>> +	 * Keeping it as a best-effort mechanism, where a warning is
>> +	 * printed if a timeout occurs, and execution is resumed.
>> +	 */
>> +	if (!wait_for_completion_timeout(
>> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10000))) {
>> +		pr_warn("timed out waiting for all offers to be delivered...\n");
>> +	}
>> +
>> +	/*
>> +	 * Flush handling of offer messages (which may initiate work on
>> +	 * other work queues).
>> +	 */
>> +	flush_workqueue(vmbus_connection.work_queue);
>> +
>> +	/*
>> +	 * Flush workqueues for processing the incoming offers. Subchannel
> 
> s/workqueues/workqueue/

Acked.

> 
>> +	 * offers and processing can happen later, so there is no need to
>> +	 * flush those workqueues here.
> 
> s/those workqueues/that workqueue/

Acked.

> 
>> +	 */
>> +	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
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
> 
> "all boot-time channels"

Acked.

> 
> 
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


Thanks,
Naman

