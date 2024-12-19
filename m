Return-Path: <linux-hyperv+bounces-3512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3789F8894
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Dec 2024 00:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50220166AA3
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB21CCB21;
	Thu, 19 Dec 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FlavPDtU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5D1853;
	Thu, 19 Dec 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734651553; cv=none; b=d3jvkD6+vwMHMBtUnJS3CaxGU/EBcoqwOIdfAIVedJAHynCr+/mM3JngqyKPkR/S+hRi8Qnhx9ZgDq/DSs0JVgIkpNX7Wyu0IZT1u+Yq2chW7IkAgV20dDzI2SnowO7BzjlDbRWQI3LtiqaXl7RX6Z+5hSIq4ouMJDKiHRbizXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734651553; c=relaxed/simple;
	bh=m7ieS6/BE5aNF0anHnV49OiY8tG5nvX7qisUlHWvILM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvGLoOT0FYTQ0SCnxa9jEfMDYstjqarCe6lv5TgJUw40DWUsA+qKSTid0UJcU1OrAXRtogwZaMqkKDK6eRdE/BaSP/A2r6fnqw3fV8aZlM2pvWqEzl2S/SdVHaSXf1O2bcF8h/H3IA46D20E0+KMtdUswU7YD+ylU8XxA+KG43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FlavPDtU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83A17203FC96;
	Thu, 19 Dec 2024 15:39:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83A17203FC96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734651550;
	bh=op7cDy+fZZogSIB/4pzaQ1eLMEV+I/47llf7A5kOdpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FlavPDtUrBkuJitxgxhNTCpXTULaPbHItsqsjwjQirrihZjHbERoDYEfyuNAyyH97
	 cAcpBtSTKsnMjqORIwgotVGHsMUwVwriTiXKwiWVZlSpW9gqtF+xwtxEXb4Fvz+wHv
	 RNH/ZfRLD5+aug31lpkAAAa19N88gH7ROM2zhQMI=
Message-ID: <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
Date: Thu, 19 Dec 2024 15:39:10 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
To: Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/2024 1:37 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December 19, 2024 10:19 AM

[...]

>>
>> There will surely be more hypercall usage in the VTL mode that return
>> data and require the output pages as we progress with upstreaming the
>> VTL patches. Enabling the hypercall output pages allows to fix the
>> function in question in a very natural way, making it possible to
>> replace with some future `hv_get_vp_register` that would work for both
>> dom0 and VTL mode just the same.
>>
>> All told, if you believe that we should make this patch a one-liner,
>> I'll do as you suggested.
>>
> 
> FWIW, Roman and I had this same discussion back in August. See [1].
> I'll add one new thought that wasn't part of the August discussion.
Michael, thank you very much for helping out in finding a better
solution!

> 
> To my knowledge, the hypercalls that *may* use a full page for input
> and/or a full page for output don't actually *require* a full page. The
> size of the input and output depends on how many "entries" the
> hypercall is specified to process, where "entries" could be registers,
> memory PFNs, or whatever. I would expect the code to invoke these
> hypercalls must already deal with the case where the requested number
> of entries causes the input or output size to exceed one page, so the
> code just iterates making multiple invocations of the hypercall with
> a "batch size" that fits in one page.
That is what I see in the code, too. The TLFS requires to use a page
worth of data maximum ("cannot overlap or cross page boundaries"), hence
the hypercall code shall chunk up the input data appropriately.

> 
> It would be perfectly reasonable to limit the batch size so that a
> "batch" of input or output fits in a half page instead of a full page,
> avoiding the need to allocate hyperv_pcpu_output_arg. Or if the
> input and output sizes are not equal, use whatever input vs. output
> partitioning of a single page make sense for that hypercall. The
> tradeoff, of course, is having to make the hypercall more times
> with smaller batches. But if the hypercall is not in a hot path, this
> might be a reasonable tradeoff to avoid the additional memory
> allocation. Or if the hypercall processing time per "entry" is high,
> the added overhead of more invocations with smaller batches is
> probably negligible compared to the time processing the entries.
The hypervisor yields control back to the guest if the hypervisor
spends more than ~a dozen 1e-6 sec in the hypercall processing, and
the processing isn't done yet. When yielding the control back, the
hypervisor doesn't advance the instruction pointer so the guest can
process interrupts on the vCPU (if the guest didn't mask them), and
get back to processing the hypercall. That helps the guest stay
responsive if the guest chose to send larger batches. For smaller
batches, have to consider the cost of invoking the hypercall as you
are pointing out. On the topic of saving CPU time, there are also fast
hypercalls that pass data in the CPU registers.

> 
> This scheme could also be used in the existing root partition code
> that is currently the only user of the hyperv_pcpu_output_arg.
> I could see a valid argument being made to drop
> hyperv_pcpu_output_arg entirely and just use smaller batches.
In my view, that is a reasonable idea to cut down on memory usage.
Here is what I get applying that general idea to this specific
situation (and sticking to 4KiB as the page size).

We are going to save 4KiB * N of memory where N is the number of cores
allocated to the root partition. Let us also introduce M that denotes
the amount of memory in KiB allocated to the root partition.

Given that the order of magnitude for N is 1 (log_10(N) ~= 1), and the
order of magnitude for M is 6..7, the savings (~=10^(N-M)=1e-5) look
rather meager to my eye. That might be a judgement call, I wouldn't
argue that.

What is worrisome is that the guest goes against the specification. The
specification decrees: the input and output areas for the hypercall
shall not cross page boundaries and shall not overlap.
Hence, the hypervisor is within its right to produce up to 4KiB of
output in response to up to 4KiBs of input, and we have:

```
sizeof(input) + sizeof(output) <= 2*sizeof(page)
```

But when the guest doesn't use the output page, we obviously have

```
sizeof(input) + sizeof(output) <= sizeof(page)
```
on the guest side so the contract is broken.

The hypervisor would need to know that the guest optimizes its memory
usage in this way, limiting what is allowed by the specification when
implementing any new hypercalls.

> 
> Or are there hypercalls where a smaller batch size doesn't work
> at all or is a bad tradeoff for performance reasons? I know I'm not
> familiar with *all* the hypercalls that might be used in root
> partition or VTL code. If there are such hypercalls, I would be curious
> to know about them.
Nothing that I could find in the specification. I wouldn't think that
justifies investing in creating specialized/special-cased functions
on the guest side without solid evidence that more code is needed. In
this particular case, one day, I'd love to replace `get_vtl` with
one generic function `hv_get_vp_registers` that works both for dom0 and
VTLs, plays by the book and does not require much/any explaining what is
going on inside it and why. I believe this will make maintenance easier.


> 
> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB415759676AEF931F030430FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com/

-- 
Thank you,
Roman


