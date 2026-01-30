Return-Path: <linux-hyperv+bounces-8618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Xt3QNuoKfWkAQAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8618-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:47:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F5BE40F
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B3E630071F4
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974532FBDE0;
	Fri, 30 Jan 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G/7xWQXK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3CE18E1F;
	Fri, 30 Jan 2026 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802471; cv=none; b=f0iYoXDzfjPEyHf5Umlc69m4b84xr1gyW2aSLu0nYQVDZ+EdsvmmE7CUHd4RevIxT65CfQMA6PhxkQ0uFSw1NkNJmls1licXbnVcKlImvXTOtA4qeXIGDXDGVFIf+FavXRCrW+oTZtDQCYkehhTCj5KnITRGRDQCpuROTCQ9jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802471; c=relaxed/simple;
	bh=ohPdp5Vk2zlt7GbDupx4aHAiUKqBcmH4eE4kZle/gFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYEgNeoaDkMHrxtetFAE20/OMNk8vrUuRfDj9pblct19BGZpbPMvNrp/r3Vi326gMnZfxGiBGiCuBklzQtNr4CVLT6/3p6TLeW+QJJtev3RkaHoqNyiRIUQp+16jMj542jMKGvZHvkqGxMWwQFS3TDoXrFD8GdZgzyXWD6+x9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G/7xWQXK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.91] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 342F720B7167;
	Fri, 30 Jan 2026 11:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 342F720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769802469;
	bh=uhMRp8QGQri+ssAchwdPFCEh6p7hGnh5uxncGGGmFP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G/7xWQXKXqyWzRYs5WRQZ/tyYQXwpwRWuykuHJ9B2+DsYUv5db355GWDviZLQRJnW
	 q6PbvJD3tBj6shjzCWoJzoXOsu8KvBJNKKs9M8BbtrhpWIBPf0JVuF6+DADQxYV9yS
	 wzgPjfCgfLk9vjlybC5grIxEhZmG5426qrHK/cAA=
Message-ID: <2efb7fc8-994f-7cbf-6b7c-a1e645bdf638@linux.microsoft.com>
Date: Fri, 30 Jan 2026 11:47:48 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
 <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
 <919446c3-e02f-d532-3ea8-74d0cee38d33@linux.microsoft.com>
 <aXznwGcuP9rdffYf@anirudh-surface.localdomain>
 <aXz7Y7As4XC9rNeL@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXz7Y7As4XC9rNeL@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8618-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 751F5BE40F
X-Rspamd-Action: no action

On 1/30/26 10:41, Stanislav Kinsburskii wrote:
> On Fri, Jan 30, 2026 at 05:17:52PM +0000, Anirudh Rayabharam wrote:
>> On Thu, Jan 29, 2026 at 06:59:31PM -0800, Mukesh R wrote:
>>> On 1/28/26 15:08, Stanislav Kinsburskii wrote:
>>>> On Tue, Jan 27, 2026 at 11:56:02AM -0800, Mukesh R wrote:
>>>>> On 1/27/26 09:47, Stanislav Kinsburskii wrote:
>>>>>> On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
>>>>>>> On 1/26/26 16:21, Stanislav Kinsburskii wrote:
>>>>>>>> On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
>>>>>>>>> On 1/26/26 12:43, Stanislav Kinsburskii wrote:
>>>>>>>>>> On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
>>>>>>>>>>> On 1/25/26 14:39, Stanislav Kinsburskii wrote:
>>>>>>>>>>>> On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
>>>>>>>>>>>>> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
>>>>>>>>>>>>>> The MSHV driver deposits kernel-allocated pages to the hypervisor during
>>>>>>>>>>>>>> runtime and never withdraws them. This creates a fundamental incompatibility
>>>>>>>>>>>>>> with KEXEC, as these deposited pages remain unavailable to the new kernel
>>>>>>>>>>>>>> loaded via KEXEC, leading to potential system crashes upon kernel accessing
>>>>>>>>>>>>>> hypervisor deposited pages.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
>>>>>>>>>>>>>> management is implemented.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>         drivers/hv/Kconfig |    1 +
>>>>>>>>>>>>>>         1 file changed, 1 insertion(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>>>>>>>>>>>> index 7937ac0cbd0f..cfd4501db0fa 100644
>>>>>>>>>>>>>> --- a/drivers/hv/Kconfig
>>>>>>>>>>>>>> +++ b/drivers/hv/Kconfig
>>>>>>>>>>>>>> @@ -74,6 +74,7 @@ config MSHV_ROOT
>>>>>>>>>>>>>>         	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>>>>>>>>>>>>>>         	# no particular order, making it impossible to reassemble larger pages
>>>>>>>>>>>>>>         	depends on PAGE_SIZE_4KB
>>>>>>>>>>>>>> +	depends on !KEXEC
>>>>>>>>>>>>>>         	select EVENTFD
>>>>>>>>>>>>>>         	select VIRT_XFER_TO_GUEST_WORK
>>>>>>>>>>>>>>         	select HMM_MIRROR
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
>>>>>>>>>>>>> implying that crash dump might be involved. Or did you test kdump
>>>>>>>>>>>>> and it was fine?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, it will. Crash kexec depends on normal kexec functionality, so it
>>>>>>>>>>>> will be affected as well.
>>>>>>>>>>>
>>>>>>>>>>> So not sure I understand the reason for this patch. We can just block
>>>>>>>>>>> kexec if there are any VMs running, right? Doing this would mean any
>>>>>>>>>>> further developement would be without a ver important and major feature,
>>>>>>>>>>> right?
>>>>>>>>>>
>>>>>>>>>> This is an option. But until it's implemented and merged, a user mshv
>>>>>>>>>> driver gets into a situation where kexec is broken in a non-obvious way.
>>>>>>>>>> The system may crash at any time after kexec, depending on whether the
>>>>>>>>>> new kernel touches the pages deposited to hypervisor or not. This is a
>>>>>>>>>> bad user experience.
>>>>>>>>>
>>>>>>>>> I understand that. But with this we cannot collect core and debug any
>>>>>>>>> crashes. I was thinking there would be a quick way to prohibit kexec
>>>>>>>>> for update via notifier or some other quick hack. Did you already
>>>>>>>>> explore that and didn't find anything, hence this?
>>>>>>>>>
>>>>>>>>
>>>>>>>> This quick hack you mention isn't quick in the upstream kernel as there
>>>>>>>> is no hook to interrupt kexec process except the live update one.
>>>>>>>
>>>>>>> That's the one we want to interrupt and block right? crash kexec
>>>>>>> is ok and should be allowed. We can document we don't support kexec
>>>>>>> for update for now.
>>>>>>>
>>>>>>>> I sent an RFC for that one but given todays conversation details is
>>>>>>>> won't be accepted as is.
>>>>>>>
>>>>>>> Are you taking about this?
>>>>>>>
>>>>>>>            "mshv: Add kexec safety for deposited pages"
>>>>>>>
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>> Making mshv mutually exclusive with kexec is the only viable option for
>>>>>>>> now given time constraints.
>>>>>>>> It is intended to be replaced with proper page lifecycle management in
>>>>>>>> the future.
>>>>>>>
>>>>>>> Yeah, that could take a long time and imo we cannot just disable KEXEC
>>>>>>> completely. What we want is just block kexec for updates from some
>>>>>>> mshv file for now, we an print during boot that kexec for updates is
>>>>>>> not supported on mshv. Hope that makes sense.
>>>>>>>
>>>>>>
>>>>>> The trade-off here is between disabling kexec support and having the
>>>>>> kernel crash after kexec in a non-obvious way. This affects both regular
>>>>>> kexec and crash kexec.
>>>>>
>>>>> crash kexec on baremetal is not affected, hence disabling that
>>>>> doesn't make sense as we can't debug crashes then on bm.
>>>>>
>>>>
>>>> Bare metal support is not currently relevant, as it is not available.
>>>> This is the upstream kernel, and this driver will be accessible to
>>>> third-party customers beginning with kernel 6.19 for running their
>>>> kernels in Azure L1VH, so consistency is required.
>>>
>>> Well, without crashdump support, customers will not be running anything
>>> anywhere.
>>
>> This is my concern too. I don't think customers will be particularly
>> happy that kexec doesn't work with our driver.
>>
> 
> I wasn?t clear earlier, so let me restate it. Today, kexec is not
> supported in L1VH. This is a bug we have not fixed yet. Disabling kexec
> is not a long-term solution. But it is better to disable it explicitly
> than to have kernel crashes after kexec.

I don't think there is disagreement on this. The undesired part is turning
off KEXEC config completely.

Thanks,
-Mukesh


> This does not mean the bug should not be fixed. But the upstream kernel
> has its own policies and merge windows. For kernel 6.19, it is better to
> have a clear kexec error than random crashes after kexec.
> 
> Thanks,
> Stanislav
> 
>> Thanks,
>> Anirudh
>>
>>>
>>> Thanks,
>>> -Mukesh
>>>
>>>> Thanks,
>>>> Stanislav
>>>>
>>>>> Let me think and explore a bit, and if I come up with something, I'll
>>>>> send a patch here. If nothing, then we can do this as last resort.
>>>>>
>>>>> Thanks,
>>>>> -Mukesh
>>>>>
>>>>>
>>>>>> It?s a pity we can?t apply a quick hack to disable only regular kexec.
>>>>>> However, since crash kexec would hit the same issues, until we have a
>>>>>> proper state transition for deposted pages, the best workaround for now
>>>>>> is to reset the hypervisor state on every kexec, which needs design,
>>>>>> work, and testing.
>>>>>>
>>>>>> Disabling kexec is the only consistent way to handle this in the
>>>>>> upstream kernel at the moment.
>>>>>>
>>>>>> Thanks, Stanislav
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> -Mukesh
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Stanislav
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> -Mukesh
>>>>>>>>>
>>>>>>>>>> Therefor it should be explicitly forbidden as it's essentially not
>>>>>>>>>> supported yet.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Stanislav
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Stanislav
>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> -Mukesh
>>>


