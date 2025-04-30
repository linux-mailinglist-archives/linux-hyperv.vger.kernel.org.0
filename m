Return-Path: <linux-hyperv+bounces-5265-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE294AA555F
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72637A00EF5
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40AE298CCA;
	Wed, 30 Apr 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j/wTQ8f3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F051296FA1;
	Wed, 30 Apr 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043796; cv=none; b=u3/fzEz3tALUpmD81K3kesyhY4uIPck1jXNKjPId2ny6figG2AUZ15mYeP6SWWb+mwETSnc0QFJJg2cMYV9ttZZrYc+lpPbI+qGu6GODRvqcknza3VfVN9mZXuydLNjecKI8w+NGTLS1J962j7vyY6Aoa3ngyIVM4thZDOFo5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043796; c=relaxed/simple;
	bh=36HW03H3Ip/jVm1paHEhCU4nKB13PehL4ul4tUL4/ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhISzKYbDmI4QD/clVBE4mtev4fbq5FVANbhE0g60iYXNaX3FM2j/exMvNylIpcJJqDicRH0a865F+2lPPfuE2yIjMmqmM2E9M8emkG5SADiRNzUOj5bwJNqZZBiRiyBTEZlgULQ7w2TEbq95XTMpFddsQTb3tFCat2Bhd7Mtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j/wTQ8f3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E190204E7F7;
	Wed, 30 Apr 2025 13:09:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E190204E7F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746043794;
	bh=nuGMBQgokk3vx/kNrEanbrh6i8qfkD4pt6K5cJ9v9MU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/wTQ8f3ig4ccZTE5AsYZeYgPlBP6Nuj+eFUSIVlY/CeiYFKIoL4ce1yWg+0USwFN
	 VY8E8ocFyU86GGWjPW4ENowpa32Tzfm5MalHjXam4/c7NaRrfDRx8GWohBD8/zKaAX
	 ijY+YEqlBzfKyjSHTiS68Nv7ZSYydopanCwLYnl0=
Message-ID: <16211a0d-b6bd-498a-adb5-7715e4013da1@linux.microsoft.com>
Date: Wed, 30 Apr 2025 13:09:54 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the
 wakeup AP callback
To: Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, dimitri.sivanich@hpe.com,
 haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
 jacob.jun.pan@linux.intel.com, jgross@suse.com, justin.ernst@hpe.com,
 kprateek.nayak@amd.com, kyle.meyer@hpe.com, kys@microsoft.com,
 lenb@kernel.org, mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
 perry.yuan@amd.com, peterz@infradead.org, rafael@kernel.org,
 russ.anderson@hpe.com, steve.wahl@hpe.com, tim.c.chen@linux.intel.com,
 tony.luck@intel.com, wei.liu@kernel.org, xin@zytor.com,
 yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250430161413.276759-1-romank@linux.microsoft.com>
 <87cyctphqo.ffs@tglx> <15be9f01-717f-51a1-6a5b-3bc4335d2506@amd.com>
 <877c31pgbm.ffs@tglx>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <877c31pgbm.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/2025 1:03 PM, Thomas Gleixner wrote:
> On Wed, Apr 30 2025 at 14:44, Tom Lendacky wrote:
>> On 4/30/25 14:33, Thomas Gleixner wrote:
>>> bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
>>> {
>>> 	return (u32)phys_id == cpu;
>>> }
>>
>> There is an x86 version of this function in arch/x86/kernel/cpu/topology.c
>> that overrides the __weak definition and does:
>>
>> bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>> {
>> 	return phys_id == (u64)cpuid_to_apicid[cpu];
>> }
> 
> Oops. I missed that somehow. So yes, aside of the signed/unsigned thing
> this looks fine.
> 

Thomas,

Thanks a lot for the review! Will fix that in the next version.

> Thanks,
> 
>          tglx
> 

-- 
Thank you,
Roman


