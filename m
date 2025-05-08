Return-Path: <linux-hyperv+bounces-5431-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9499AAFF4F
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 17:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECBF17D934
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0E270573;
	Thu,  8 May 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OgeWeNUM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827C276023;
	Thu,  8 May 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718443; cv=none; b=UxuTFcTlhApDbBR64912qfOTExqFpIeH7jWFEMiFEpu+AIcLl6SiKJ1GhhmxRyYY8nBAI3xquvED+xCBOH6Y0Z51wkRKFkf5M9BTEFxjHVRswFrO6bsPaOpRpSiq2heBftM7XYTUXpNLDP+Mc3kpWTG6KJDpxRVln/9rpChLicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718443; c=relaxed/simple;
	bh=+fhlOQ6G4aZ2woY1PB5/3AzIa84R8tnCvv9CqUxBVlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+re4FKsiqhtVhFjPYVkFds9WH8HWEdf6U4SeX49gU5CGZ7ZXquRSWLo0e/kdQVtMPv/bzoUTIJK4MU/CnICSrUUGvUW15lliyceHkyGX9wTUU59sJHQ7lk1k+5j4uO6uFUExl95SI0YC2TxCq1CFXSRUe1gXt4/Ss+SBlnxej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OgeWeNUM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 256062115DCD;
	Thu,  8 May 2025 08:34:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 256062115DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746718441;
	bh=k9NF3ALRxjrJqIoCdrIpMYuhVmXJDYeiXE0oEu2XlwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OgeWeNUMr44WtI2xhxaGcg0xtDVKB0z7Acf3/iPXuoyAjNQKzCoowBNeQxSkNoIK9
	 usNvqSRIvGciornaWZzrzs19YAzomItcAEYYCyh1z6hlb3gYRd4gzsW4VwfD4PGvIS
	 Gr0FI0wxStrL0v+clhNhxUr/Y7xjWvFbpJWHYYpI=
Message-ID: <718eaa5a-a021-469d-9053-f622a53422b9@linux.microsoft.com>
Date: Thu, 8 May 2025 08:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <SN6PR02MB4157D124B1AF145E06431BD2D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D124B1AF145E06431BD2D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 9:03 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, May 7, 2025 12:21 PM
>>
>> On 5/7/2025 6:02 AM, Saurabh Singh Sengar wrote:
>>>
>> [..]
>>
>>>> +	}
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>>> +
>>>> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
>>>> hvcall.input_size)) {
>>>
>>> Here is an issue related to usage of user copy functions when interrupt are disabled.
>>> It was reported by Michael K here:
>>>
>>> https://github.com/microsoft/OHCL-Linux-Kernel/issues/33
>>
>>   From the practical point of view, that memory will be touched by the
>> user mode by virtue of Rust requiring initialization so the a possible
>> page fault would be resolved before the IOCTL. OpenHCL runs without swap
>> so the the memory will not be paged out to require page faults to be
>> brought in back.
>>
>> I do agree that might be turned into a footgun by the user land if
>> they malloc a page w/o prefaulting (so it's just a VA range, not backed
>> with the physical page), and then send its address straight over here
>> right after w/o writing any data to it. Perhaps likelier with the output
>> data. Anyway, yes, relying on the user land doing sane things isn't
>> the best approach to the kernel programming.
>>
>> If we're inclined to fix this, I'd encourage to take an approach that
>> works for the confidential VMs as well so we don't have to fix that
>> again when start upstreaming what we have for SNP and TDX. The
>> allocation *must* be visible to the hypervisor in the confidential
>> scenarios.
>>
>> Or, maybe we could avoid the allocations by reading the first byte
>> of the user land buffer to "pre-fault" the page outside of the
>> scope that disables interrupts. Why allocate if we can avoid that?
>> Could set up also the SMP remote calls to run this on the desired
>> CPU.
>>
>> Summarizing for the case you want to change this:
>>
>> 1. Keep interrupts disabled when reading/writing to/from the Hyper-V
>>      driver allocated input and output pages.
>> 2. If you decide to allocate separate pages, make sure they are
>>      visible to the hypervisor in the confidential scenarios. I know
>>      we're not talking SNP and TDX here just yet but it would be
>>      a waste of time imho to build something here and scrape that
>>      later. The issues with allocations are:
>>          a) If allocating on-demand, we might fail the hypercall
>>             because of OOM. That's certainly bad as the whole VM
>>             will break down.
>>          b) If allocating for the whole lifetime of the VM,
>>             let us remember that we avoid using hypercalls
>>             due to their runtime cost. We'll be keeping around
>>             2 pages per CPU for the few times we need them.
>> 3. Consider reading a byte from the user land buffers to make the page
>>      fault happen outside of disabling interrupts. There is no
>>      outswap (maybe could have disabling swap in Kconfig) so the page
>>      will stay in the memory.
>>
>> If you're not changing this, feel free to keep my "Reviewed-by".
>>
> 
> Regardless of what might be done to prevent a page fault, I don't
> see an option to not fix this. copy_from_user() contains a call to
> might_fault(), which in turn calls might_sleep(). The intent of these
> runtime "annotations" is precisely for the kernel to check for such
> errors and complain about them. The complaining is suppressed unless
> CONFIG_DEBUG_ATOMIC_SLEEP is set, but we want to be able to
> set that option for debugging purposes and not have this code
> generating complaints.

I outlined the practical point of view above to emphasize that the
existing code works very well (millions of VMs, and there is health
monitoring in place) thanks to running as a firmware and the tooling.
The VTL2 driver is run and useful only in that environment.

I agree that this approach might raise eyebrows and, as evidenced,
entails some arguing. If you must insist, perhaps for the sake of that
code looking more conventional for the reader we could tweak this.
If that's the choice, keeping this path lean should be the goal in
my opinion.

> 
> Michael

-- 
Thank you,
Roman


