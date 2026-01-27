Return-Path: <linux-hyperv+bounces-8554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJDoDF0YeWn9vAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8554-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 20:56:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC59A250
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE0EF301C8B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC0366DB4;
	Tue, 27 Jan 2026 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QoHvUAP3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137AD330D54;
	Tue, 27 Jan 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543769; cv=none; b=XZrVyn4k6BshGCsoskkxC9KjRSqQ4blVlWRlsS+OhJn+SQpdFGH14jgPt1+NgHTDY00rb79fRf4NV1CpYraraumQGvD4o0d8VzldvwSit8gDvwnxervroJzD5bJ/O+kNzTUcnND927+Ocb0V/iJLNIkpp45bGhypgOUyDPNV60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543769; c=relaxed/simple;
	bh=DzTKVUJm1BTpjEQ+80mXZfoucGuEooCWj0GQQ/II8Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AISrGQscxble4wV6QoA5TyGXgix8mDUm2j6bn61lwHaTJgKg1wqNFnvQ4YH3BxK3ySVN6+pXxB2NTfn+IzTkkaHPpzjrJGaiVrcI4hqKA52mVZHgbUnJci0TKmwW4ecyFjq7gojK45VouwUCPMs2gSMneuOlzEI3iZ538xG/eUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QoHvUAP3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A071D20B7165;
	Tue, 27 Jan 2026 11:56:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A071D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769543762;
	bh=opOnLHc1Ui/6WC7HbYLu4r+NXes30PqBLqj76+AOM+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QoHvUAP3NhWksNIB39b0u0jJW1htsVZvHXyM4tuamvz9Gw7q/AlHscA5pSo6aYHyg
	 f/qjl9OjusTCt8jEdxB+3Yh8M8HrlHCwvoJMALdExvzDozEvMST4PEpmDCpLDF0O1f
	 Y4yylbNa1+6Z0lxqKFzORIN0/foRPSHcL5g22jC0=
Message-ID: <4bcd7b66-6e3b-8f53-b688-ce0272123839@linux.microsoft.com>
Date: Tue, 27 Jan 2026 11:56:02 -0800
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
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXj6FXahxZU8QFq0@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8554-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78BC59A250
X-Rspamd-Action: no action

On 1/27/26 09:47, Stanislav Kinsburskii wrote:
> On Mon, Jan 26, 2026 at 05:39:49PM -0800, Mukesh R wrote:
>> On 1/26/26 16:21, Stanislav Kinsburskii wrote:
>>> On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
>>>> On 1/26/26 12:43, Stanislav Kinsburskii wrote:
>>>>> On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
>>>>>> On 1/25/26 14:39, Stanislav Kinsburskii wrote:
>>>>>>> On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
>>>>>>>> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
>>>>>>>>> The MSHV driver deposits kernel-allocated pages to the hypervisor during
>>>>>>>>> runtime and never withdraws them. This creates a fundamental incompatibility
>>>>>>>>> with KEXEC, as these deposited pages remain unavailable to the new kernel
>>>>>>>>> loaded via KEXEC, leading to potential system crashes upon kernel accessing
>>>>>>>>> hypervisor deposited pages.
>>>>>>>>>
>>>>>>>>> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
>>>>>>>>> management is implemented.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>>>>>>>> ---
>>>>>>>>>       drivers/hv/Kconfig |    1 +
>>>>>>>>>       1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>>>>>>> index 7937ac0cbd0f..cfd4501db0fa 100644
>>>>>>>>> --- a/drivers/hv/Kconfig
>>>>>>>>> +++ b/drivers/hv/Kconfig
>>>>>>>>> @@ -74,6 +74,7 @@ config MSHV_ROOT
>>>>>>>>>       	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>>>>>>>>>       	# no particular order, making it impossible to reassemble larger pages
>>>>>>>>>       	depends on PAGE_SIZE_4KB
>>>>>>>>> +	depends on !KEXEC
>>>>>>>>>       	select EVENTFD
>>>>>>>>>       	select VIRT_XFER_TO_GUEST_WORK
>>>>>>>>>       	select HMM_MIRROR
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
>>>>>>>> implying that crash dump might be involved. Or did you test kdump
>>>>>>>> and it was fine?
>>>>>>>>
>>>>>>>
>>>>>>> Yes, it will. Crash kexec depends on normal kexec functionality, so it
>>>>>>> will be affected as well.
>>>>>>
>>>>>> So not sure I understand the reason for this patch. We can just block
>>>>>> kexec if there are any VMs running, right? Doing this would mean any
>>>>>> further developement would be without a ver important and major feature,
>>>>>> right?
>>>>>
>>>>> This is an option. But until it's implemented and merged, a user mshv
>>>>> driver gets into a situation where kexec is broken in a non-obvious way.
>>>>> The system may crash at any time after kexec, depending on whether the
>>>>> new kernel touches the pages deposited to hypervisor or not. This is a
>>>>> bad user experience.
>>>>
>>>> I understand that. But with this we cannot collect core and debug any
>>>> crashes. I was thinking there would be a quick way to prohibit kexec
>>>> for update via notifier or some other quick hack. Did you already
>>>> explore that and didn't find anything, hence this?
>>>>
>>>
>>> This quick hack you mention isn't quick in the upstream kernel as there
>>> is no hook to interrupt kexec process except the live update one.
>>
>> That's the one we want to interrupt and block right? crash kexec
>> is ok and should be allowed. We can document we don't support kexec
>> for update for now.
>>
>>> I sent an RFC for that one but given todays conversation details is
>>> won't be accepted as is.
>>
>> Are you taking about this?
>>
>>          "mshv: Add kexec safety for deposited pages"
>>
> 
> Yes.
> 
>>> Making mshv mutually exclusive with kexec is the only viable option for
>>> now given time constraints.
>>> It is intended to be replaced with proper page lifecycle management in
>>> the future.
>>
>> Yeah, that could take a long time and imo we cannot just disable KEXEC
>> completely. What we want is just block kexec for updates from some
>> mshv file for now, we an print during boot that kexec for updates is
>> not supported on mshv. Hope that makes sense.
>>
> 
> The trade-off here is between disabling kexec support and having the
> kernel crash after kexec in a non-obvious way. This affects both regular
> kexec and crash kexec.

crash kexec on baremetal is not affected, hence disabling that
doesn't make sense as we can't debug crashes then on bm.

Let me think and explore a bit, and if I come up with something, I'll
send a patch here. If nothing, then we can do this as last resort.

Thanks,
-Mukesh


> It?s a pity we can?t apply a quick hack to disable only regular kexec.
> However, since crash kexec would hit the same issues, until we have a
> proper state transition for deposted pages, the best workaround for now
> is to reset the hypervisor state on every kexec, which needs design,
> work, and testing.
> 
> Disabling kexec is the only consistent way to handle this in the
> upstream kernel at the moment.
> 
> Thanks, Stanislav
> 
> 
>> Thanks,
>> -Mukesh
>>
>>
>>
>>> Thanks,
>>> Stanislav
>>>
>>>> Thanks,
>>>> -Mukesh
>>>>
>>>>> Therefor it should be explicitly forbidden as it's essentially not
>>>>> supported yet.
>>>>>
>>>>> Thanks,
>>>>> Stanislav
>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Stanislav
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Mukesh


