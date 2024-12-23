Return-Path: <linux-hyperv+bounces-3516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8879FB54F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Dec 2024 21:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5351161F51
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Dec 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7321AE01E;
	Mon, 23 Dec 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uzkaglws"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B81CF5CE;
	Mon, 23 Dec 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985817; cv=none; b=ea4YFCW26Spwi9qBeBRPsbEbmPZ37/+8qOSkarO52Ko/dq/SkJyArx1c4XiTPfIZFcZJHb849y7Qin0z8v10fXgrTyHktEaLHwiHVzEYz8rayC9PgfIVrFFKjio/moTDA+F8JYZoZOfSeXBkrnnpxpUDVhMBOwMxWpTg7OEtQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985817; c=relaxed/simple;
	bh=JbRzSdH2HWqF52wlH+Wb5jZ1GnB5zYCJKm7FI3T2Oog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcc/pmHtDOYkUOa14eHi6vLj4mH7UOwJ6pbI9QqEUhQEsFmBiA+qZOIS3VngAtMLyTiNHnJeig1or5TZI5j+Ownwkny8etrcWLHSN42Y7ERuM/bDINlkuRMZq+L0iZw40hd9t826RJZHtZzs0L8EIOQWVpCYXwxO5mqsFZ0k2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uzkaglws; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3ACAA206ADCE;
	Mon, 23 Dec 2024 12:30:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ACAA206ADCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734985809;
	bh=YINZEJ7CoiSXQbsX4OVrGNQAl+Ag/pQOemb6Nmp0o94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UzkaglwsPQxkG+uETtP8nnAQ2rrk1Tl4OELPCEf/MXheA0dFDvOAXP8BiJ1DatouP
	 ibYBDP6IXUZUvbYoWncT5QebkQJf7/9B1Lakj452NlUG9xaX3lGs2cKn9nzCt6YvHy
	 UltJG/yGQYpGeLGoK67cegKgKGFBTpeHdfsXiaHM=
Message-ID: <ff359a3e-a275-4146-8e99-a06fea69b7a9@linux.microsoft.com>
Date: Mon, 23 Dec 2024 12:30:09 -0800
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
 <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
 <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
 <eba74adf-4891-46f8-a3ef-e116000dd566@linux.microsoft.com>
 <SN6PR02MB4157FD829416A7ACA2FF9300D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157FD829416A7ACA2FF9300D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/2024 2:42 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, December 20, 2024 11:14 AM
>>

[...]

> 
> I will not object to your preferred path of allocating the
> hyperv_pcpu_output_arg when CONFIG_HYPERV_VTL_MODE is set. For
> me, it has been a worthwhile discussion to explore the alternatives. I do,
> however, want to get further clarification about the spec requirements
> and whether our current Linux code is meeting those requirements. More
> on that below.  And allow me to continue the discussion about a couple
> of points you raised.
> 
Thank you, Michael, for helping me explore the options! From where I
sit, we both seem to agree that an update is needed, and where our
opinions diverge is whether we need to spend another per-CPU page or
not. If at any point, you start believing that your "Nack" is the best
option going forward, I'll put this patch aside.

[...]

> I see three uses in current upstream code. And then there are close to
> a dozen more uses in Nuno's year-old patch set for /dev/mshv that hasn't
> been accepted upstream yet. Does that roughly match what you are referring
> to?
> 
While compiling my arguments and making sure they're worth the readers'
time, I did miss to provide references to the code. Yes, that patch set
might be a good illustration of the direction, thank you very much for
pointing that out!

Another reference might have been the kernel used with OpenHCL (6.6.x):
https://github.com/microsoft/OHCL-Linux-Kernel. Azure Boost runs that, 
and the kernel is delighting our customers with the rock-solid
foundation.

It contains lots of mshv code, and it is the code run in Azure as the
VTL2 kernel; we're working towards upstreaming, e.g. here :) It uses the
hypercall output page, and the performance folks beat the hell out of
the code, and found it being up to snuff. There were few findings about
memory consumption out of which I remember the perf folks tuning SWIOTLB
size and tweaking the kernel memory layout to save on padding and
alignment. As for the per-CPU data, nothing allowing to save that much,
perhaps would be nice to be able to compile out more. Yet, as I
understand, x86_64 systems might not always be envisioned as the
commonplace foundation for building embedded systems so while we're
looking to save few KiBs in hyperv, there's likely much more to save
elsewhere.

>> * dom0 and the VTL mode can share code quite naturally,
> 
> Yep.
> 
To me, this has been the ever-shining light in the dark maze of other
arguments. It provides a corner stone to building the generic well-
tested code, hence developers will rest assured when introducing changes
that the changes are robust even when not testing the myriad ways the
hyperv code is used in. That is, the validation wouldn't need all the
permutations of conditional statements and all #ifdef's that would be
needed when special-casing.

>> * Not using the output page cannot acccount for all cases permitted by
>>     the TLFS clause "don't overlap input and output, and don't cross page
>>     boundaries",
> 
> This is what I don’t understand.
> 
I meant that when implementing a generic case, not using the output page
prohibits from being able to receive a page of output when supplying a
page of input. I agree that we can special-case to save a bit of memory
as it appears we don't need that ability (4KiB of output in response to
4KiB input) right now. What I question though if that specialization is
needed at all since it will lead to more code, more parameters for the
functions, more comments and if statements therefore more validation
work and more cognitive load, and more maintenance costs.

>> * Not using the output page everywhere for consistency requires updating
>>     call sites of `hv_do_hypercall`​ and friends, i.e. every place where a
>>     hypercall is made needs to incorporate the offset/pointer at which the
>>     output should start, or perhaps do some shenanigans with macro's,
> 
> In my musing about getting rid of hyperv_pcpu_output_arg entirely, the
> call signature of hv_do_hypercall() and friends would remain unchanged.
> There would still be a virtual address passed as the output argument (which
> might be NULL, and is *not* required to be page aligned). The caller of
> hv_do_hypercall() must only ensure that the virtual address points to an
> output area that is large enough to contain the output without crossing a
> page boundary. The area must also not overlap with the input area. Given
> that we currently have only 3 uses of hyperv_pcpu_output_arg in upstream
> code, only those would need to be tweaked to split the hyperv_pcpu_input_arg
> page into an input and output area. All other callers of hv_do_hypercall()
> would be unchanged.
> 
Your approach appears being solid to me! Again, going to be beating on
my drum :) I believe here we are deciding not only on the small
optimization which is a clever way of saving a bit of memory, and it did
bring a satisfying "wow, nice" to my mind.

We are drafting the constrains for the future code as it appears;
without knowing better, perhaps it is the wisest not to constrain. As
the quote goes:

"... We should forget about small efficiencies, say about 97% of the
time: premature optimization is the root of all evil. Yet we should not
pass up our opportunities in that critical 3%. A good programmer ...
will be wise to look carefully at the critical code; but only after that
code has been identified. ..."


>> * Not using the output page leads to negligible savings,
>>
>> it is hard to see for me how to make not using the hypercall output page
>> look as a profitable enginnering endeavor, really comes off as dancing
>> to the perf scare/feature creep tune for peanuts.
> 
> There would be some simplification in hv_common_free(), hv_common_init(),
> and hv_common_cpu_init() if there was no hyperv_pcpu_output_arg.  :-)
> 
Agreed!

>>
>> In my opinion, we should use the hypercall output page for the VTL mode
>> as dom0 does to share code and reduce code churn. Had we used some
>> `hv_get_registers` in both​ instead of the specialized for no compelling
>> imo practical reason `get_vtl`​ (as it just gets a vCPU register, nothing
>> more, nothing less), this code path would've been better tested, and any
>> of this patching would not have been needed.
> 
> FWIW, the historical context is that at the time get_vtl() was implemented,
> all VP registers that Linux needed to access were available as synthetic
> MSRs on the x86 side. Going back to its origins 15 years ago, the Linux code
> for Hyper-V always just used the synthetic MSRs. get_vtl() was the first time
> that x86 code needed the HVCALL_GET_VP_REGISTERS hypercall because
> HV_REGISTER_VSM_VP_STATUS has no synthetic MSR equivalent. There still
> is no 'hv_get_registers' function in upstream code on the x86 side.
> hv_get_vpreg() exists only on the arm64 side where there are no synthetic
> MSRs or equivalent.


> 
> In hindsight, hv_get_vpreg() could have been added on the x86 side, and
> then get_vtl() implemented on top of that. And I made the get_vtl() situation
> worse by giving Tianyu bad advice about overlapping the output area with
> the input area. :-(
> 
> I once had a manager at Microsoft who said "He reserved the right
> to wake up smarter every day."  I've had to claim that right as well
> from time-to-time. :-)
> 
Michael, thank you very much for your efforts! At that time, no one
knew otherwise iiuc. You had the willpower to make things happen and the
vision to bring the solution over the finish line, and imo the Hyper-V
community just cannot possibly thank you enough for your incredible
work. It is my genuine hope that putting the Fixes tag didn't overshadow
that fact for anyone as these five letters don't tell any of the story,
most assuredly.

>>
>> I'd wait for few days and then would likely prefer to run with Wei's
>> permission to send this patch in v2 as-is unless some damning evidence
>> presents itself.
> 
> Again, I won't object to your taking that path.
> 
> But regarding compliance with the TLFS, take a look at the code for
> hv_pci_read_mmio() and hv_pci_write_mmio().  Do you think that code
> violates the spec?  If not, what would a violation look like in the context
> of this discussion?  If current code is in violation, then we should fix that.
> 
Appreciate your advice! I don't think they do. The code doesn't overlap 
input and output, and to my eye, the arguments are sized and aligned 
appropriately. That does not violate TLFS. I'd think the
`hv_pci_read_mmio` might've used the output page as it is supposed to be
used for output to stick to one pattern, much similar to the `get_vtl`
in question.

Now, it seems the functions run in the VTL0 only (but I'd leave that to
someone else to judge) where we currently don't allocate the output
page, and `hv_pci_read_mmio` is the only function doing that input page
split so special-casing might be justified, perhaps adding a comment
would seem appropriate. Unless there are prospects to merge that with
dom0, I'd leave the code be.

> Michael

-- 
Thank you,
Roman


