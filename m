Return-Path: <linux-hyperv+bounces-3194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415B59B23F2
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 05:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5803A1C20F16
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 04:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5744A47;
	Mon, 28 Oct 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UJ/AXYzx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB60653;
	Mon, 28 Oct 2024 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730091260; cv=none; b=ZzRv5NUI9bkdbe0cbsP7bdmjPFmZW3e19Cy7TPiBdIhOeY+NyqeunrZ2KxsD9hfv0WeVwuGrNcm4C2qbnHBexA202NDROPbGjJ74mAFWy+7wxknC1X3nKfGR2MTebKEs16nWcxMyWRUtj7S3etAB1wBSi3OGlXVIb6/TBASDGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730091260; c=relaxed/simple;
	bh=TFJ/yAyScYcMkzfflmrAMRrUrJXuqttbV4yCIHa1PIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKpDAIWaYwnygRZKIxSAaWm4kSuokrdH+TL+cwVrSp0cIyazhtmPFqFjP4vGZXhtWv2gVkCS8lrTA9GF52YQHQ6095rsCJu7ZI4jSgmc/IY1eFve0J/7xSmHpA5CFEKWfk4bJwRpaFiNow1oR4Xq9stcAirc8KypJq5QQyIBrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UJ/AXYzx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.10] (unknown [223.233.78.26])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22D5C211DBD2;
	Sun, 27 Oct 2024 21:54:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22D5C211DBD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730091252;
	bh=apY/3CtRc7P+pO+oc5SxIzp/lqiDK77EC1pMQ2GHN0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UJ/AXYzxOWMFUANgG8r3tzMjdFWdXURmUhyDqhgEOZggtWJ7ElCZwH1LKPEUgsCLM
	 bjPGmj8y2o+BRXgsr5SohtVWc1y3oP0WBCFHpPmCZ1xk/ey/KDftj/maBArERg6X3r
	 z3kPg+Zot05Yj+0VnWAcXcyODyp4Xy26Q9yDT/dk=
Message-ID: <0efac688-4c75-4249-972a-75e26001f65f@linux.microsoft.com>
Date: Mon, 28 Oct 2024 10:24:04 +0530
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
 <81b0e19f-7711-4cfb-8cb1-8d4c1affc0d1@linux.microsoft.com>
 <SN6PR02MB4157FAF47E917885BFDBB9DDD44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157FAF47E917885BFDBB9DDD44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/22/2024 11:33 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 22, 2024 2:50 AM
>>
>> On 10/21/2024 10:03 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 18, 2024 4:58 AM
> 
> [snip]
> 
>>>> @@ -1297,12 +1285,11 @@
>>>> EXPORT_SYMBOL_GPL(vmbus_hvsock_device_unregister);
>>>>    /*
>>>>     * vmbus_onoffers_delivered -
>>>>     * This is invoked when all offers have been delivered.
>>>> - *
>>>> - * Nothing to do here.
>>>>     */
>>>
>>> I'm unclear on the meaning of the ALLOFFERS_DELIVERED message. In the
>>> early days of Hyper-V, the set of virtual devices in a VM was fixed before a
>>> VM started, so presumably ALLOFFERS_DELIVERED meant that offers for
>>> that fixed set of devices had been delivered. That meaning makes sense
>>> conceptually.
>>>
>>> But more recent versions of Hyper-V support adding and removing devices
>>> at any time during the life of the VM. If a device is added, a new offer is
>>> generated. Existing devices (such as netvsc) can reconfigure their channels,
>>> in which case new subchannel offers are generated. So the core concept of
>>> "all offers delivered" isn't valid anymore.
>>>
>>> To date Linux hasn't done anything with this message, so we didn't need
>>> precision about what it means. There's no VMBus specification or
>>> documentation, so we need some text here in the comments that
>>> explains precisely what ALLOFFERS_DELIVERED means, and how that
>>> meaning aligns with the fact that offers can be delivered anytime during
>>> the life of the VM.
>>>
>>> I'll note that in the past there's also been some behavior where during guest
>>> boot, Hyper-V offers a virtual PCI device to the guest, immediately
>>> rescinds the vPCI device (before Linux even finished processing the offer),
>>> then offers it again. I wonder about how ALLOFFERS_DELIVERED interacts
>>> with that situation.
>>>
>>> I ran some tests in an Azure L16s_v3 VM, which has three vPCI devices:
>>> 2 NVMe devices and 1 Mellanox CX-5. The offers for the 2 NVMe devices
>>> came before the ALLOFFERS_DELIVERED message, but the offer for
>>> the Mellanox CX-5 came *after* the ALLOFFERS_DELIVERED message.
>>> If that's the way the Mellanox CX-5 offers work, this patch breaks things
>>> in the hibernation resume path because ALLOFFERS_DELIVERED isn't
>>> sufficient to indicate that all primary channels have been re-offered
>>> and the resume can proceed. All sub-channel offers came after the
>>> ALLOFFERS_DELIVERED message, but that is what I expected and
>>> shouldn't be a problem.
>>>
>>> It's hard for me to review this patch set without some precision around
>>> what ALLOFFERS_DELIVERED means.
>>
>> Thanks for your valuable comments.
>> I checked this internally with John and here is the information you are
>> looking for.
>>
>> CHANNELMSG_ALLOFFERS_DELIVERED message arrives after all the boot-time
>> offers are delivered. Other channels can be hot added later, even
>> immediately after the all-offers-delivered message.
>>
>> A boot-time offer will be any of the virtual hardware the VM is
>> configured with at boot. The reason the Mellanox NIC is not included in
>> this list is because the Mellanoc NIC is an optional accelerator to the
>> synthetic vmbus NIC. It is hot added only after the vmbus NIC channel is
>> opened (once we know the guest can support it, via the sriov bit in the
>> netvsc protocol). So, it is not there at boot time, as we define it.
> 
> Good info about the meaning of ALLOFFERS_DELIVERED! Please
> capture the info in comments in the code so it's available for future
> readers.

Noted.

> 
>>
>> The reason the logs show the ordering below is that the vmbus driver
>> queues offer work to a work queue. The logs are out of order from the
>> actual messages that arrive. That’s why we have to flush the work queues
>> before we consider all the offers handled.
> 
> I'm not sure which logs are referenced in the above paragraph. When
> I captured logs (which I didn't send), I did so in vmbus_on_msg_dpc(),
> which is before the offer messages are put in the work queue. So my
> logs reflected the order of the actual messages. But I agree that the
> work queues need to be flushed.
> 
>>

My bad.
The logs, which I referred to here, was actually ftrace logs, for 
different channels offer, request for offer and all offers delivered 
event. My observation was then based on how these works are processed in 
workqueues. I was observing that all offers delivered event was being 
processed before channel offers. This was misleading, and sorry for the 
confusion.

>> Regarding your comment for MLX CX-5, it is by design.The MLX device must
>> be logically hot removed and hot added back across a hibernate. There is
>> no guarantee the same accelerator device is present with the same
>> capabilities or device IDs or anything; the VHD could have been moved to
>> another machine with a different NIC, or to a VM without accelnet, or
>> whatever. This is all supported. So, it's not required to wait for the
>> MLX device to come back as part of hibernate resume.
>>
>> Since Linux doesn't currently handle this correctly, the host works
>> around this by removing the MLX device before the guest hibernates. This
>> way, the guest does not expect an MLX device to still be present on
>> resume. This is inconvenient because it means the guest cannot initiate
>> hibernate on its own.
> 
> I wasn't aware of the VF handling. Where does the guest notify the
> host that it is planning to hibernate? I went looking for such code, but
> couldn't immediately find it.  Is it in the netvsc driver? Is this the
> sequence?
> 
> 1) The guest notifies the host of the hibernate
> 2) The host sends a RESCIND_CHANNELOFFER message for each VF
>      in the VM
> 3) The guest waits for all VF rescind processing to complete, and
>      also must ensure that no new VFs get added in the meantime
> 4) Then the guest proceeds with the hibernation, knowing that there
>      are no open channels for VF devices
> 

Dexuan has responded to this query.

>>
>> The behavior we want is for the guest to hot remove the MLX device
>> driver on resume, even if the MLX device was still present at suspend,
>> so that the host does not need this special pre-hibernate behavior. This
>> patch series may not be sufficient to ensure this, though. It just moves
>> things in the right direction, by handling the all-offers-delivered
>> message.
> 
> This aspect of the patch might be worth calling out in the commit
> message.

Will do.

> 
>>
>>>
>>>>    static void vmbus_onoffers_delivered(
>>>>    			struct vmbus_channel_message_header *hdr)
>>>>    {
>>>> +	complete(&vmbus_connection.all_offers_delivered_event);
>>>>    }
>>>>
>>>>    /*
>>>> @@ -1578,7 +1565,8 @@ void vmbus_onmessage(struct vmbus_channel_message_header *hdr)
>>>>    }
>>>>
>>>>    /*
>>>> - * vmbus_request_offers - Send a request to get all our pending offers.
>>>> + * vmbus_request_offers - Send a request to get all our pending offers
>>>> + * and wait for all offers to arrive.
>>>>     */
>>>>    int vmbus_request_offers(void)
>>>>    {
>>>> @@ -1596,6 +1584,10 @@ int vmbus_request_offers(void)
>>>>
>>>>    	msg->msgtype = CHANNELMSG_REQUESTOFFERS;
>>>>
>>>> +	/*
>>>> +	 * This REQUESTOFFERS message will result in the host sending an all
>>>> +	 * offers delivered message.
>>>> +	 */
>>>>    	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_message_header),
>>>>    			     true);
>>>>
>>>> @@ -1607,6 +1599,22 @@ int vmbus_request_offers(void)
>>>>    		goto cleanup;
>>>>    	}
>>>>
>>>> +	/* Wait for the host to send all offers. */
>>>> +	while (wait_for_completion_timeout(
>>>> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 1000)) == 0) {
>>>
>>> Maybe do !wait_for_completion_timeout( ...) instead of explicitly testing
>>> for 0? I see that some existing code uses the explicit test for 0, but that's
>>> not the usual kernel code idiom.
>>>
>>>> +		pr_warn("timed out waiting for all offers to be delivered...\n");
>>>> +	}
>>>
>>> The while loop could continue forever. We don't want to trust the Hyper-V
>>> host to be well-behaved, so there should be an uber timeout where it gives
>>> up after 100 seconds (or pick some value). If the uber timeout is reached,
>>> I'm not sure if the code should panic or just go on -- it's debatable. But doing
>>> something explicit is probably better than repeatedly outputting the
>>> warning message forever.
>>
>> You're right its debatable. It seems to be a best effort mechanism, and
>> we can't say for sure what all offers are going to be provided. So
>> printing a warning and moving ahead seems right to me. I'll remove the
>> loop, and keep it simple.
>>
>>>
>>>> +
>>>> +	/*
>>>> +	 * Flush handling of offer messages (which may initiate work on
>>>> +	 * other work queues).
>>>> +	 */
>>>> +	flush_workqueue(vmbus_connection.work_queue);
>>>> +
>>>> +	/* Flush processing the incoming offers. */
>>>> +	flush_workqueue(vmbus_connection.handle_primary_chan_wq);
>>>> +	flush_workqueue(vmbus_connection.handle_sub_chan_wq);
>>>
>>> Why does the sub-channel workqueue need to be flushed? Sub-channels
>>> get created at the request of the Linux driver, in cooperation with the VSP
>>> on the Hyper-V side. If the top-level goal is for user-space drivers to be
>>> able to know that at least a core set of offers have been processed, it
>>> seems like waiting for sub-channel offers isn't necessary. And new
>>> subchannel offers could arrive immediately after this flush, so the flush
>>> doesn't provide any guarantee about whether there are offers in that
>>> workqueue. If there is a valid reason to wait, some explanatory
>>> comments would be helpful.
>>
>> I'll either remove it, or put a comment to manage the expectations that
>> this is just for best effort and there is no guarantee that all sub
>> channel offers will be entertained by now.
>>
> 
> I lean toward removing it, as flushing the sub channel work queue
> doesn't seem related to the stated goals of the patch. It just leaves a
> dangling "why is this flush being done?" question.

Understood, will remove it. Thanks.

> 
> Michael

Regards,
Naman

