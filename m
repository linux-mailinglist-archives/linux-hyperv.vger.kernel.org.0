Return-Path: <linux-hyperv+bounces-3584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652DA02F83
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DBB3A11CD
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9F1DED72;
	Mon,  6 Jan 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sNlPrnoC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A671B0F3D;
	Mon,  6 Jan 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187079; cv=none; b=Wu67VBfUm4wK1ZY+ekuyQ8ClLYoZt886o+AURm/3eyIHlV5R9RnjtgUzeTbDM60fWAUmcjTBEsN9BVzbd8rDxFvGNkBXAryDKkypyRtqDMCdjDePyXX7ouuxAmoY5kTRCjV8eSCrupekmoaHFneUe+Lb4VN9rZrteot1S8nNvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187079; c=relaxed/simple;
	bh=4nLtZngrlvn28kXsf+TmhhUrCI5F0ym/ztRbtKqibCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oniZX7FZMPltVjnMn0STGRcZcvYq3wkJ/dKIQ+3GSIQpz2p8cvOL1bR0AzdAIgLXUrXVoQwMzNYQKbxh20AlWOTQRwfzkcNiLhAyNfXWnHaUbHcrtQ1YaEt4dukUMSjJJSiUJebn0NsII5K0QQySTbVEGCyiHSfGelfY3YuCXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sNlPrnoC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D19EA206AB8F;
	Mon,  6 Jan 2025 10:11:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D19EA206AB8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736187077;
	bh=I5mXfPCoh+ciCQThg1PHzOJlsCr+Zq/LqqkMgwbf7Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sNlPrnoC3IMr1mIdfpAgQOTQlIwqQf0prKhxBpJYcLNcQbs9lXGtVSIzyE77dmzpF
	 ddqxi53Y6nuFB73gvHGqHSTGsDlALFJHmWZWfHB2/UHZduPr8K0SwEAgS7aUAS3R/Y
	 wkJgCnrhcaaXnuWN32FERuOqe0j45cemyoHfa10Q=
Message-ID: <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
Date: Mon, 6 Jan 2025 10:11:16 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250106171114.GA18270@skinsburskii.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/6/2025 9:11 AM, Stanislav Kinsburskii wrote:
> On Fri, Jan 03, 2025 at 01:39:29PM -0800, Roman Kisel wrote:
>>

[...]

>>
> 
> The issue is that when you boot the same kernel in both VTL0 and VTL1+,
> the pages will be allocated in any case (root or guest, VTL0 or VTL1+).

I think we share we same beliefs: use common code as much as possible.
Strategically, one day, there will be the kernel being able to boot
(or at the very minimum share the Hyper-V code for) VTL0, VTL1 (LVBS)
and VTL2 (OpenHCL). It is not today, though: VTL0 relies on ACPI|BIOS,
VTL2 relies on DeviceTree, and VTL1 boot configuration comes off as
a bit ad-hoc from my read of https://github.com/heki-linux/lvbs-linux,
and working with the LVBS folks on debugging that.

Can that day of the grand VTL code unification be tomorrow, or next
week, or next month, or maybe next year, what is the option you leaning
towards?

To me, it seems, that's not even the next month. Let us take a look
at how much ink is being spent to just fix a garden variety function.
On the meta-level that might mean some _fundamental work_ is needed to
provide a _robust foundation_ to built upon, such as removing the if
statements and #ifdef's we're debating about to let the general case
shine through.

Tactically, imo, a staged approach might give more velocity and
coverage instead of fixing the world in this small patch set. I would
not want to increase the potential "blast radius" of the change.
As it stands, it is pretty well-contained.

All told, it might be prudent to focus on the task at hand - fix the
function in question to enable building on that, e.g. proposing the v4
of the ARM64 VTL mode patches, and more of what we have in
https://github.com/microsoft/OHCL-Linux-Kernel.

Once we take that small step to fix the hyperv-next tree, someone could
propose removing the conditions for allocating the output page —-- or,
perhaps, suggest an entirely new & vastly better solution to handling
the hypercall output page. IMHO, that would enable adding features via
relying on more generic code rather than further complicating the web
of conditional statements and conditional compilation.

> 
> Also, there are other places in the code, where braching needs to be done
> differently depending in on which VTL the execution is happening in.
> 
> I think, there are two possible paths we can take here.
> 
> The first one is when the checks are done during compilation. In this case
> the kernel should explicitly fail to boot in VTL0 if compiled for VTL1+
> and vice versa.
> 
> The second one if to make checks in runtime and let the same kernel boot
> differently in different VTLs.
> 
> Thoughts?
> 
> Stas
> 
>>>
>>> Thanks,
>>> Stas
>>>
>>>>    		hyperv_pcpu_output_arg = alloc_percpu(void *);
>>>>    		BUG_ON(!hyperv_pcpu_output_arg);
>>>>    	}
>>>> @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>    	void **inputarg, **outputarg;
>>>>    	u64 msr_vp_index;
>>>>    	gfp_t flags;
>>>> -	int pgcount = hv_root_partition ? 2 : 1;
>>>> +	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
>>>>    	void *mem;
>>>>    	int ret;
>>>> @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>>>    		if (!mem)
>>>>    			return -ENOMEM;
>>>> -		if (hv_root_partition) {
>>>> +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>>>>    			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>>>    			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>>>    		}
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> -- 
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


