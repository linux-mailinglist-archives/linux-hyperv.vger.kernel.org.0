Return-Path: <linux-hyperv+bounces-8541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGkGG2oXeGkynwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8541-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 02:39:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE98EC6E
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 02:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD85301325C
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jan 2026 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0C27F18F;
	Tue, 27 Jan 2026 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rjN1gZdT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74980221F1C;
	Tue, 27 Jan 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477991; cv=none; b=qYoPdxJRZzAt/jLgDtuqUu7ThfV+tbnkqVsIDkufnUu0NGBg1Y3onQZ+icKKgyCbLkWA8iuvjuvN3pypmbLvjuGoW9QawMjgap1hgYmj5KSa2gElOgAkgpF11Rllx4PWiW0c/ib30DhW3yTmBGG1DRyGM6Dov9fMLzMLT/KnA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477991; c=relaxed/simple;
	bh=2JEBU6oaV7lnfZNc/xUzhLCYVxf/kT9fdSyGSYNuNR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JH5NwDGZ1Ac2Y13KWGbLo6SjSod3q5+Nz5EMPpJSs1FqV6tW2D/t2ApPdPFLY8bw82ARp9Sg8zBqqPzHxivdZd133S/EmFFDyNd812CJINuo4YyVVP3wMm3hvqMXO6tXgPktLxfOKreIv1m5I2NtDPpq7Ac8UycPR1FV4EigQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rjN1gZdT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B78AD20B7165;
	Mon, 26 Jan 2026 17:39:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B78AD20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769477990;
	bh=Ilaz+B/LsBKzd43PtzQaPH9bSG4zNfW6Jzxzs7uO1R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjN1gZdTuIeeOaJr47f4aqOp0aZCWF2hwyNA//73z5dEGZSV6Y9EYi+cVmxHLx99F
	 X7O2jhoW5UNTVdjFWUu6nijwdVXrWZ2zenAOBHlCtIlVfKQ5JR3W37dfW4zU1RWgkm
	 E0eK8bHgCm+AjUpxZXigXPgTzmBW1zXWWNM1d6HA=
Message-ID: <257ad7f1-5dc0-2644-41c3-960c396caa38@linux.microsoft.com>
Date: Mon, 26 Jan 2026 17:39:49 -0800
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
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXgFFz7YuJJQabyp@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8541-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6DE98EC6E
X-Rspamd-Action: no action

On 1/26/26 16:21, Stanislav Kinsburskii wrote:
> On Mon, Jan 26, 2026 at 03:07:18PM -0800, Mukesh R wrote:
>> On 1/26/26 12:43, Stanislav Kinsburskii wrote:
>>> On Mon, Jan 26, 2026 at 12:20:09PM -0800, Mukesh R wrote:
>>>> On 1/25/26 14:39, Stanislav Kinsburskii wrote:
>>>>> On Fri, Jan 23, 2026 at 04:16:33PM -0800, Mukesh R wrote:
>>>>>> On 1/23/26 14:20, Stanislav Kinsburskii wrote:
>>>>>>> The MSHV driver deposits kernel-allocated pages to the hypervisor during
>>>>>>> runtime and never withdraws them. This creates a fundamental incompatibility
>>>>>>> with KEXEC, as these deposited pages remain unavailable to the new kernel
>>>>>>> loaded via KEXEC, leading to potential system crashes upon kernel accessing
>>>>>>> hypervisor deposited pages.
>>>>>>>
>>>>>>> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
>>>>>>> management is implemented.
>>>>>>>
>>>>>>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>>>>>> ---
>>>>>>>      drivers/hv/Kconfig |    1 +
>>>>>>>      1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>>>>>>> index 7937ac0cbd0f..cfd4501db0fa 100644
>>>>>>> --- a/drivers/hv/Kconfig
>>>>>>> +++ b/drivers/hv/Kconfig
>>>>>>> @@ -74,6 +74,7 @@ config MSHV_ROOT
>>>>>>>      	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>>>>>>>      	# no particular order, making it impossible to reassemble larger pages
>>>>>>>      	depends on PAGE_SIZE_4KB
>>>>>>> +	depends on !KEXEC
>>>>>>>      	select EVENTFD
>>>>>>>      	select VIRT_XFER_TO_GUEST_WORK
>>>>>>>      	select HMM_MIRROR
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Will this affect CRASH kexec? I see few CONFIG_CRASH_DUMP in kexec.c
>>>>>> implying that crash dump might be involved. Or did you test kdump
>>>>>> and it was fine?
>>>>>>
>>>>>
>>>>> Yes, it will. Crash kexec depends on normal kexec functionality, so it
>>>>> will be affected as well.
>>>>
>>>> So not sure I understand the reason for this patch. We can just block
>>>> kexec if there are any VMs running, right? Doing this would mean any
>>>> further developement would be without a ver important and major feature,
>>>> right?
>>>
>>> This is an option. But until it's implemented and merged, a user mshv
>>> driver gets into a situation where kexec is broken in a non-obvious way.
>>> The system may crash at any time after kexec, depending on whether the
>>> new kernel touches the pages deposited to hypervisor or not. This is a
>>> bad user experience.
>>
>> I understand that. But with this we cannot collect core and debug any
>> crashes. I was thinking there would be a quick way to prohibit kexec
>> for update via notifier or some other quick hack. Did you already
>> explore that and didn't find anything, hence this?
>>
> 
> This quick hack you mention isn't quick in the upstream kernel as there
> is no hook to interrupt kexec process except the live update one.

That's the one we want to interrupt and block right? crash kexec
is ok and should be allowed. We can document we don't support kexec
for update for now.

> I sent an RFC for that one but given todays conversation details is
> won't be accepted as is.

Are you taking about this?

         "mshv: Add kexec safety for deposited pages"

> Making mshv mutually exclusive with kexec is the only viable option for
> now given time constraints.
> It is intended to be replaced with proper page lifecycle management in
> the future.

Yeah, that could take a long time and imo we cannot just disable KEXEC
completely. What we want is just block kexec for updates from some
mshv file for now, we an print during boot that kexec for updates is
not supported on mshv. Hope that makes sense.

Thanks,
-Mukesh



> Thanks,
> Stanislav
> 
>> Thanks,
>> -Mukesh
>>
>>> Therefor it should be explicitly forbidden as it's essentially not
>>> supported yet.
>>>
>>> Thanks,
>>> Stanislav
>>>
>>>>
>>>>> Thanks,
>>>>> Stanislav
>>>>>
>>>>>> Thanks,
>>>>>> -Mukesh


