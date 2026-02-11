Return-Path: <linux-hyperv+bounces-8785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5nBOndjGl8uQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8785-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 20:52:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D69127458
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD0930125C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD47335083;
	Wed, 11 Feb 2026 19:52:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3A3340294;
	Wed, 11 Feb 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839522; cv=none; b=fC7e9m22c3lrCW7vwnAbcf+lWGi0QMHeommfEpFsm9qhZaQMbjX47Zl3O41oZddmPYErDW2jIzGs5ClnfwxTHJUhdaHMoe3qdom75qq0tLoTYB24PJQHLdyfDsviLutDWsZuYyo8HtKitjUGm1D+qlQ3TKYX1WsmfPGOzpku2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839522; c=relaxed/simple;
	bh=xWcXAYZtWhqf7hWQTTWrx3U4YQwT3zS1LTEdULvXLQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLL2gtfAlQUwQA1J7nWTPRYEzIZeUZx6/tAqapxeicpUj8UE7DnZyT3oYaN59uqK78NqsHKXEHzM5cgIky/NvdmpQ3Z8lavl63GWOuj1s3TRrr4eq05PS8LF4r8P7pUM9a0BqeK6XCU+dxchW6md/cQBgkMNSoDsmKe9zCZyzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CE4F339;
	Wed, 11 Feb 2026 11:51:52 -0800 (PST)
Received: from [10.57.53.64] (unknown [10.57.53.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DB953F632;
	Wed, 11 Feb 2026 11:51:56 -0800 (PST)
Message-ID: <cc4dc4a6-2d74-49c1-bbb0-cfa44802a66b@arm.com>
Date: Wed, 11 Feb 2026 19:51:53 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer transition
To: Michael Kelley <mhklinux@outlook.com>, Tianyu Lan <ltykernel@gmail.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>
Cc: Tianyu Lan <tiala@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
References: <20260210162107.2270823-1-ltykernel@gmail.com>
 <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8785-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,microsoft.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvmm.dev:url]
X-Rspamd-Queue-Id: 67D69127458
X-Rspamd-Action: no action

On 2026-02-11 6:00 pm, Michael Kelley wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, February 10, 2026 8:21 AM
>>
>> Hyper-V provides Confidential VMBus to communicate between
>> device model and device guest driver via encrypted/private
>> memory in Confidential VM. The device model is in OpenHCL
>> (https://openvmm.dev/guide/user_guide/openhcl.html) that
>> plays the paravisor rule.
>>
>> For a VMBUS device, there are two communication methods to
> 
> s/VMBUS/VMBus/
> 
>> talk with Host/Hypervisor. 1) VMBus Ring buffer 2) dynamic
>> DMA transition.
> 
> I'm not sure what "dynamic DMA transition" is. Maybe just
> "DMA transfers"?  Also, do the same substitution further
> down in this commit message.
> 
>> The Confidential VMBus Ring buffer has been
>> upstreamed by Roman Kisel(commit 6802d8af).
> 
> It's customary to use 12 character commit IDs, which would be
> 6802d8af47d1 in this case.
> 
>>
>> The dynamic DMA transition of VMBus device normally goes
>> through DMA core and it uses SWIOTLB as bounce buffer in
>> CVM
> 
> "CVM" is Microsoft-speak. The Linux terminology is "a CoCo VM".
> 
>> to communicate with Host/Hypervisor. The Confidential
>> VMBus device may use private/encrypted memory to do DMA
>> and so the device swiotlb(bounce buffer) isn't necessary.
> 
> The phrase "isn't necessary" does not capture the real issue
> here. Saying "isn't necessary" makes it sound like this patch is
> just avoids unnecessary work, so that it is a performance
> improvement. But that's not the case.
> 
> The real issue is that swiotlb memory is decrypted. So bouncing
> through the swiotlb exposes to the host what is supposed to be
> confidential data passed on the Confidential VMBus. Disabling
> the swiotlb bouncing in this case is a hard requirement to preserve
> confidentially.

Yeah, this really isn't a Hyper-V problem. Indeed as things stand, 
"swiotlb=force" could potentially break confidentiality for any 
environment trying to invent a notion of private DMA, and perhaps we 
could throw a big warning about that, but really the answer there is 
"Don't run your confidential workload with 'swiotlb=force'. Why would 
you even do that? Debug your drivers in a regular VM or bare-metal with 
full debug visibility like a normal person..."

The fact is we do not have a proper notion of trusted/private DMA yet, 
and this is not the way to add it. The current assumption is very much 
that all DMA is untrusted in the CoCo sense, because initially it was 
only virtual devices emulated by a hypervisor, thus had to be bounced 
through shared memory anyway. AMD SEV with a stage 1 IOMMU in the guest 
can allow an assigned physical device to access a suitably-aligned 
encrypted buffer directly, but that's still effectively just putting the 
buffer into a temporarily shared state for that device, it merely skips 
sharing it with the rest of the system. !force_dma_unencrypted() doesn't 
mean "we trust this device's DMA", it just means "we don't have to use 
explicitly-decrypted pages to accommodate untrusted/shared DMA here", 
plus it also serves double-duty for host encryption which doesn't share 
the same trust model anyway.

I assumed this would follow the TDISP stuff, but if Hyper-V has an 
alternative device-trusting mechanism already then there's no need to 
wait. We want some common device property (likely consolidating the 
current PCI external-facing port notion of trustedness plus whatever 
TDISP wants), with which we can then make proper decisions in all the 
right DMA API paths - and if it can end up replacing the horrible 
force_dma_unencrypted() as well then all the better! I'd totally 
forgotten about the previous discussion that Michael referred to (which 
I had to track down[1]), but it looks like all the main points were 
already covered there and we were approaching a consensus, so really I 
guess someone just needs to give it a go.

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-hyperv/20250409000835.285105-6-romank@linux.microsoft.com/

> 
> So I would reword the sentences as something like this:
> 
> The Confidential VMBus device can do DMA directly to
> private/encrypted memory. Because the swiotlb is decrypted
> memory, the DMA transfer must not be bounced through the
> swiotlb, so as to preserve confidentiality. This is different from
> the default for Linux CoCo VMs, so disable the VMBus device's
> use of swiotlb.
> 
>> To disable device's swiotlb, set device->dma_io_tlb_mem
>> to NULL in VMBus driver and is_swiotlb_force_bounce()
>> always returns false.
>>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>> Change since v1:
>>         Use device.dma_io_tlb_mem to disable device bounce buffer
>>
>>   drivers/hv/vmbus_drv.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index a53af6fe81a6..58dab8cc3fcb 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>>   	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
>>   	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>>
>> +	device_initialize(&child_device_obj->device);
>> +	if (child_device_obj->channel->co_external_memory)
>> +		child_device_obj->device.dma_io_tlb_mem = NULL;
>> +
> 
> Doing this as part of the VMBus bus driver makes sense. While directly
> setting device.dma_io_tlb_mem to NULL should work, it would be better
> to add a function to the swiotlb code to do this, and then call that function
> here, passing the device as an argument. The need to disable swiotlb on a
> device will likely arise in similar contexts (such as TDISP), and it would be
> better to have a swiotlb function for that purpose. This use case may be
> a bit ahead of the TDISP work, and having a swiotlb function in place will
> help ensure that duplicate mechanisms aren't created as everything
> comes together.
> 
> See my earlier comments in [1] about the key point in the commit message,
> and about adding a swiotlb_dev_disable() function to the swiotlb code.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
>>   	/*
>>   	 * Register with the LDM. This will kick off the driver/device
>>   	 * binding...which will eventually call vmbus_match() and vmbus_probe()
>>   	 */
>> -	ret = device_register(&child_device_obj->device);
>> +	ret = device_add(&child_device_obj->device);
>>   	if (ret) {
>>   		pr_err("Unable to register child device\n");
>>   		put_device(&child_device_obj->device);
>> --
>> 2.50.1


