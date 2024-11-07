Return-Path: <linux-hyperv+bounces-3279-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED19BFDC8
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 06:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1327281D68
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 05:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A42C6FBF;
	Thu,  7 Nov 2024 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QXyBm+nI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766FC192B62;
	Thu,  7 Nov 2024 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958299; cv=none; b=eI4CnraK2M4i287bDvPJ4nIWnZL4VLpcsPHvBFJaVnD6VsVEtwVVY42yw3Ffpm8nlgx+bH8ybqCcmwwIABGKKsLE/AP/Hm/FzuBb+3kgH88yGuWW4zJe3ciX+HzAQksE4T9B8KkW7di0CD+Pgja17W292BcFF8FQXlyxcOGBMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958299; c=relaxed/simple;
	bh=gpzlwexvA3SG+QryXNYzAqzSPZc1bImZ6oe+eHxe7Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAJSECgLjQFviLCZ1ciIz0i1jbnMl9iRA1JTB4gWEGm96GAx1EHUT5prduEDaqFiXBOvsueveJb/1BMDWSyYqYXcQ7TCsTlD+HPOkLsy22k5y0/ZxyVV4YuWRC/kZYgwn885J097oztnRFBjksDChMk5ngUOZ30GgY2Syqp5tn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QXyBm+nI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.72.143] (unknown [167.220.238.79])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8178F212D4F2;
	Wed,  6 Nov 2024 21:44:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8178F212D4F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730958297;
	bh=NVp8ST0dxy4k335XQEtz2NsSMtwWkFQBqxef4adR+Ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QXyBm+nIx0hp1J/cE5rb5k/c2SdE0Ahae9hXwCHPMjRaD/jznN+1hHBL57vdJUhj1
	 U3opdbL66drBoQYK6nx2e9FaPMuYcv8ONxbuPR955n4IDeA6CJK3y304VQp3zZiYDP
	 6W1dRTzz6wrQm8dg35uMWhnV1oPyn+Pv7tlDaYPM=
Message-ID: <4c9e670b-eb37-4bdb-adcf-a4ebbebcefab@linux.microsoft.com>
Date: Thu, 7 Nov 2024 11:14:52 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Log on missing offers
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
 <20241029080147.52749-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157D7212FE3F0F50FAB0592D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D7212FE3F0F50FAB0592D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/1/2024 12:44 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 29, 2024 1:02 AM
>>
>> When resuming from hibernation, log any channels that were present
>> before hibernation but now are gone.
>> In general, the essential virtual devices configured for a VM, remain
>> same, before and after the hibernation and its not very common that
>> some offers are missing.
> 
> The wording here is a bit jumbled. And let's use consistent terminology.
> I'd suggest:
> 
> In general, the boot-time devices configured for a resuming VM should be
> the same as the devices in the VM at the time of hibernation. It's uncommon
> for the configuration to have been changed such that offers are missing.
> Changing the configuration violates the rules for hibernation anyway.

Sure, I'll make the required changes.

> 
>> The cleanup of missing channels is not
>> straight-forward and dependent on individual device driver
>> functionality and implementation, so it can be added in future as
>> separate changes.
>>
>> Signed-off-by: John Starks <jostarks@microsoft.com>
>> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>> Changes since v1:
>> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com/
>> * Added Easwar's Reviewed-By tag
>> * Addressed Saurabh's comments:
>>    * Added a note for missing channel cleanup in comments and commit msg
>> ---
>>   drivers/hv/vmbus_drv.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index bd3fc41dc06b..08214f28694a 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
>>
>>   static int vmbus_bus_resume(struct device *dev)
>>   {
>> +	struct vmbus_channel *channel;
>>   	struct vmbus_channel_msginfo *msginfo;
>>   	size_t msgsize;
>>   	int ret;
>> @@ -2494,6 +2495,22 @@ static int vmbus_bus_resume(struct device *dev)
>>
>>   	vmbus_request_offers();
>>
>> +	mutex_lock(&vmbus_connection.channel_mutex);
>> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>> +		if (channel->offermsg.child_relid != INVALID_RELID)
>> +			continue;
>> +
>> +		/* hvsock channels are not expected to be present. */
>> +		if (is_hvsock_channel(channel))
>> +			continue;
>> +
>> +		pr_err("channel %pUl/%pUl not present after resume.\n",
>> +			&channel->offermsg.offer.if_type,
>> +			&channel->offermsg.offer.if_instance);
>> +		/* ToDo: Cleanup these channels here */
>> +	}
>> +	mutex_unlock(&vmbus_connection.channel_mutex);
>> +
> 
> Dexuan and John have explained how in Azure VMs, there should not be
> any VFs assigned to the VM at the time of hibernation. So the above
> check for missing offers does not trigger an error message due to
> VF offers coming after the all-offers-received message.
> 
> But what about the case of a VM running on a local Hyper-V? I'm not
> completely clear, but in that case I don't think any VFs are removed
> before the hibernation, especially for VM-initiated hibernation. It's

I am not sure about this behavior. I have requested Dexuan offline
for a comment.

> a reasonable scenario to later resume that same VM, with the same
> VF assigned to the VM. Because of the way current code counts
> the offers, vmbus_bus_resume() waits for the VF to be offered again,
> and all the channels get correct post-resume relids. But the changes
> in this patch set break that scenario. Since vmbus_bus_resume() now
> proceeds before the VF offer arrives, hv_pci_resume() calling
> vmbus_open() could use the pre-hibernation relid for the VF and break
> things. Certainly the "not present after resume" error message would
> be spurious.
> 
> Maybe the focus here is Azure, and it's tolerable for the local Hyper-V
> case with a VF to not work pending later fixes. But I thought I'd call
> out the potential issue (assuming my thinking is correct).
> 
> Michael

IIUC, below scenarios can happen based on your comment-

Case 1:
VF channel offer is received in time before hv_pci_resume() and there
are no problems.

Case 2:
Resume proceeds just after getting ALLOFFERS_DELIVERED msg and a warning
is printed that this VF channel is not present after resume.
Then two scenarios can happen:
   Case 2.1:
   VF channel offer is received before hv_pci_resume() and things work
   fine. Warning printed is spurious.
   Case 2.2:
   VM channel offer is not received before hv_pci_resume() and relid is
   not yet restored by onoffer. This is a problem. Warning is printed in
   this case for missing offer.

I think it all depends on whether or not VFs are removed in local
HyperV VMs. I'll try to get this information. Thanks for pointing this
out.

Regards,
Naman


> 
>>   	/* Reset the event for the next suspend. */
>>   	reinit_completion(&vmbus_connection.ready_for_suspend_event);
>>
>> --
>> 2.34.1


