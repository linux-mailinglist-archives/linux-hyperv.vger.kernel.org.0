Return-Path: <linux-hyperv+bounces-8597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EWyKCJkefGmgKgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8597-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 03:59:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CDB6A54
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 03:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1556300D453
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC22459E5;
	Fri, 30 Jan 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rP06X/uD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE2D531;
	Fri, 30 Jan 2026 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741974; cv=none; b=uCiFX50n6bQlnP1Fci2ahK8iCsmAODkEq1ERAcxDIYwnKX+6vU1j1ZeVi/B1rNnLjI7XQ4aU8dDBYsg9HOmPRSrFr4vZoBz6wf3R5UwRYvkpo2+qDRu6uUN3PZ1iNQUEUxOE3nV+M8CHuAEzliCpOmIFBG0mA6hUUu4+S4N1A4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741974; c=relaxed/simple;
	bh=7Uk+ZEuPYatvsyaJm2suJb7vBz2Tyy/2XKhvZ1E5ZIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k11OvwoPBCtF/kkcFYJ58hulFs9sReTtyofl7FgUqlaE2UT+FZ8eHrwZT7U50/reUHw+nhttdPVkh8HdZmZh9nPunWPtSXS3ZeiIxXZdiWq2z40T/JirFxzzXnS8iAyWTOzQaInHYKfnV+XRCogmsHpAQEFfaI56ezaTGK0dU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rP06X/uD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.96.72] (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8662E20B7167;
	Thu, 29 Jan 2026 18:59:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8662E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769741972;
	bh=ws8fU+u6oIT40gVv4hOR3t6onI87N9K9q5BzJacLZHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rP06X/uDitH1hgfYmE2n93gX6MSU5UMkHwIo7J/LWVuGIvxV69tPwBTjbd5gmxJy5
	 NE40N630YpmNwNAZxSn11asXXH1xO09j+8pre5Vrm5xgdqNDkS07F/LsbvCtvv+8Nb
	 gHWVrsD2zIDF/xxX1wusJD90QO0c1LqH4Pykpags=
Message-ID: <919446c3-e02f-d532-3ea8-74d0cee38d33@linux.microsoft.com>
Date: Thu, 29 Jan 2026 18:59:31 -0800
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
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <549041d1-360d-d34c-4e3b-62802346acaa@linux.microsoft.com>
 <aXabnnCV50Thv9tZ@skinsburskii.localdomain>
 <890506f6-9b91-5d59-8c98-086cf5d206bb@linux.microsoft.com>
 <aXfSDm-4BjPPZMNu@skinsburskii.localdomain>
 <2b42997d-7cc0-56ba-e1ca-a8640ce71ea9@linux.microsoft.com>
 <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
 <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
 <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
 <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
 <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXqW7v-lnAT_gr0s@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8597-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 638CDB6A54
X-Rspamd-Action: no action

On 1/28/26 15:08, Stanislav Kinsburskii wrote:
> On Tue, Jan 27, 2026 at 11:56:02AM -0800, Mukesh R wrote:
>> On 1/27/26 09:47, Stanislav Kinsburskii wrote:
>>> On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
>>>> On 1/26/26 16:21, Stanislav Kinsburskii wrote:
>>>>> On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
>>>>>> On 1/26/26 12:43, Stanislav Kinsburskii wrote:
>>>>>>> On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
>>>>>>>> On 1/25/26 14:39, Stanislav Kinsburskii wrote:
>>>>>>>>> On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
>>>>>>>>>> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
>>>>>>>>>>> The MSHV driver deposits kernel-allocated pages to the hypervisor during
>>>>>>>>>>> runtime and never withdraws them. This creates a fundamental incompatibility
>>>>>>>>>>> with KEXEC, as these deposited pages remain unavailable to the new kernel
>>>>>>>>>>> loaded via KEXEC, leading to potential system crashes upon kernel accessing
>>>>>>>>>>> hypervisor deposited pages.
>>>>>>>>>>>
>>>>>>>>>>> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
>>>>>>>>>>> management is implemented.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        drivers/hv/Kconfig |    1 +
>>>>>>>>>>>        1 file changed, 1 insertion(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>>>>>>>>> index 7937ac0cbd0f..cfd4501db0fa 100644
>>>>>>>>>>> --- a/drivers/hv/Kconfig
>>>>>>>>>>> +++ b/drivers/hv/Kconfig
>>>>>>>>>>> @@ -74,6 +74,7 @@ config MSHV_ROOT
>>>>>>>>>>>        	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>>>>>>>>>>>        	# no particular order, making it impossible to reassemble larger pages
>>>>>>>>>>>        	depends on PAGE_SIZE_4KB
>>>>>>>>>>> +	depends on !KEXEC
>>>>>>>>>>>        	select EVENTFD
>>>>>>>>>>>        	select VIRT_XFER_TO_GUEST_WORK
>>>>>>>>>>>        	select HMM_MIRROR
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
>>>>>>>>>> implying that crash dump might be involved. Or did you test kdump
>>>>>>>>>> and it was fine?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yes, it will. Crash kexec depends on normal kexec functionality, so it
>>>>>>>>> will be affected as well.
>>>>>>>>
>>>>>>>> So not sure I understand the reason for this patch. We can just block
>>>>>>>> kexec if there are any VMs running, right? Doing this would mean any
>>>>>>>> further developement would be without a ver important and major feature,
>>>>>>>> right?
>>>>>>>
>>>>>>> This is an option. But until it's implemented and merged, a user mshv
>>>>>>> driver gets into a situation where kexec is broken in a non-obvious way.
>>>>>>> The system may crash at any time after kexec, depending on whether the
>>>>>>> new kernel touches the pages deposited to hypervisor or not. This is a
>>>>>>> bad user experience.
>>>>>>
>>>>>> I understand that. But with this we cannot collect core and debug any
>>>>>> crashes. I was thinking there would be a quick way to prohibit kexec
>>>>>> for update via notifier or some other quick hack. Did you already
>>>>>> explore that and didn't find anything, hence this?
>>>>>>
>>>>>
>>>>> This quick hack you mention isn't quick in the upstream kernel as there
>>>>> is no hook to interrupt kexec process except the live update one.
>>>>
>>>> That's the one we want to interrupt and block right? crash kexec
>>>> is ok and should be allowed. We can document we don't support kexec
>>>> for update for now.
>>>>
>>>>> I sent an RFC for that one but given todays conversation details is
>>>>> won't be accepted as is.
>>>>
>>>> Are you taking about this?
>>>>
>>>>           "mshv: Add kexec safety for deposited pages"
>>>>
>>>
>>> Yes.
>>>
>>>>> Making mshv mutually exclusive with kexec is the only viable option for
>>>>> now given time constraints.
>>>>> It is intended to be replaced with proper page lifecycle management in
>>>>> the future.
>>>>
>>>> Yeah, that could take a long time and imo we cannot just disable KEXEC
>>>> completely. What we want is just block kexec for updates from some
>>>> mshv file for now, we an print during boot that kexec for updates is
>>>> not supported on mshv. Hope that makes sense.
>>>>
>>>
>>> The trade-off here is between disabling kexec support and having the
>>> kernel crash after kexec in a non-obvious way. This affects both regular
>>> kexec and crash kexec.
>>
>> crash kexec on baremetal is not affected, hence disabling that
>> doesn't make sense as we can't debug crashes then on bm.
>>
> 
> Bare metal support is not currently relevant, as it is not available.
> This is the upstream kernel, and this driver will be accessible to
> third-party customers beginning with kernel 6.19 for running their
> kernels in Azure L1VH, so consistency is required.

Well, without crashdump support, customers will not be running anything
anywhere.

Thanks,
-Mukesh

> Thanks,
> Stanislav
> 
>> Let me think and explore a bit, and if I come up with something, I'll
>> send a patch here. If nothing, then we can do this as last resort.
>>
>> Thanks,
>> -Mukesh
>>
>>
>>> It?s a pity we can?t apply a quick hack to disable only regular kexec.
>>> However, since crash kexec would hit the same issues, until we have a
>>> proper state transition for deposted pages, the best workaround for now
>>> is to reset the hypervisor state on every kexec, which needs design,
>>> work, and testing.
>>>
>>> Disabling kexec is the only consistent way to handle this in the
>>> upstream kernel at the moment.
>>>
>>> Thanks, Stanislav
>>>
>>>
>>>> Thanks,
>>>> -Mukesh
>>>>
>>>>
>>>>
>>>>> Thanks,
>>>>> Stanislav
>>>>>
>>>>>> Thanks,
>>>>>> -Mukesh
>>>>>>
>>>>>>> Therefor it should be explicitly forbidden as it's essentially not
>>>>>>> supported yet.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Stanislav
>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Stanislav
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> -Mukesh


