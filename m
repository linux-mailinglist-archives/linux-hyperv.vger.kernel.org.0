Return-Path: <linux-hyperv+bounces-3256-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F959BC4DB
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 06:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA3282F89
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 05:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346C1B6D04;
	Tue,  5 Nov 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZwKy7diW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1818C35C;
	Tue,  5 Nov 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730785629; cv=none; b=caBMK3RUllaSpikEjDBnTME+eTFSKcuTkLwYgujaAsMLJ3NBVlVV2wcuysZ05jOFkHfBJj6g602SNPVLDjXAvzuP/ZbdRKy+grWTFCdmFh0qd0GfvOSJFOvEFyi6sEtQYvr0p196/KS6UWdFJDxNSLeHK3rTCxyERDVJauV//A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730785629; c=relaxed/simple;
	bh=zNj3+IE7PK3pn+cwi9TWyAxZ3vbkwU+8c6a7UFTwvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxg+LYeR0smHF0dGTrYqzGJeFc+TGNUwzWaiZ7yxTIQTKQy9FY77jVEWRABQ4K6OMvTLgNKMq87NnSUwpSNtmVuVIzr49h7tmx63bnHe0I6Z4ja5gX9OfLZzHzi2DMKS6hBMTFkUw+zdET2cR56+hA5QAFj8F7xLJVVAcl/XzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZwKy7diW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.102] (unknown [49.205.243.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED4882126CA0;
	Mon,  4 Nov 2024 21:40:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED4882126CA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730785251;
	bh=SXOg4LFBVYBfqR/j+AbMWtD4ob7RG7MU0yBzyQh3CNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZwKy7diWidehlE4SFgSkJEsjVomy9GW01QUANRDwzyFEz2LlycDkzdMchvRpc47yY
	 VB1lkACTKPBIqXZBW8aKr2kTxq/We46q68f/iK34gM05fW6+ne7HmLtTj8IMouo6dp
	 jVhL9tE9rAfn+oYqX3Yodheh6UgHRK/y7JjihH2c=
Message-ID: <1246e9a8-1a71-4cd4-a55c-5d9cb25f2312@linux.microsoft.com>
Date: Tue, 5 Nov 2024 11:10:44 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Starks <jostarks@microsoft.com>, jacob.pan@linux.microsoft.com,
 Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
References: <20241029080147.52749-1-namjain@linux.microsoft.com>
 <20241029080147.52749-2-namjain@linux.microsoft.com>
 <4d4e0c14-af3d-4bae-a599-0ccf7a3c1961@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <4d4e0c14-af3d-4bae-a599-0ccf7a3c1961@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/2024 2:01 AM, Easwar Hariharan wrote:
> On 10/29/2024 1:01 AM, Naman Jain wrote:
>> Channel offers are requested during VMBus initialization and resume
>> from hibernation. Add support to wait for all channel offers to be
>> delivered and processed before returning from vmbus_request_offers.
>>
>> This is in analogy to a PCI bus not returning from probe until it has
>> scanned all devices on the bus.
>>
>> Without this, user mode can race with VMBus initialization and miss
>> channel offers. User mode has no way to work around this other than
>> sleeping for a while, since there is no way to know when VMBus has
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
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com
>> * Added Easwar's Reviewed-By tag
>> * Addressed Michael's comments:
>>    * Added explanation of all offers delivered message in comments
>>    * Removed infinite wait for offers logic, and changed it wait once.
>>    * Removed sub channel workqueue flush logic
>>    * Added comments on why MLX device offer is not expected as part of
>>      this essential boot offer list. I refrained from adding too many                                                        details on it as it felt like it is beyond the scope of this patch                                                      series and may not be relevant to this. However, please let me know if
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
>> @@ -1296,13 +1284,22 @@ EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>>   
>>   /*
>>    * vmbus_onoffers_delivered -
>> - * This is invoked when all offers have been delivered.
>> + * CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the essential
>> + * boot-time offers are delivered. Other channels can be hot added
>> + * or removed later, even immediately after the all-offers-delivered
>> + * message. A boot-time offer will be any of the virtual hardware the
>> + * VM is configured with at boot.
>>    *
>> - * Nothing to do here.
>> + * Virtual devices like Mellanox NIC may not be included in the list of
>> + * these initial boot offers because it is an optional accelerator to
>> + * the synthetic VMBus NIC. It is hot added only after the VMBus NIC
>> + * channel is opened (once it knows the guest can support it, via the
>> + * sriov bit in the netvsc protocol).
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
> 
> secs_to_jiffies() has been merged [1] so please update this to a call to
> secs_to_jiffies(10). A Cocinelle script will probably take care of it
> sooner or later in any case.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=b35108a51cf7bab58d7eace1267d7965978bcdb8
> 

Thank you. I will update it.

Regards,
Naman

