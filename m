Return-Path: <linux-hyperv+bounces-3514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3639F9A09
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Dec 2024 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BA167142
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Dec 2024 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111201632DD;
	Fri, 20 Dec 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ckcAzYLw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30482210D0;
	Fri, 20 Dec 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722020; cv=none; b=Kz8rA7Tdtp7bsEtoYU8mmfPEehMEdL342Ui/ljhcTjw4O4CGaYQYJee9CQmZNqheOXY3k9crKMiiMEIPM1qVusE+wyfwyNF2vlyPr2bKcbObz5WA2EOmmTL7VcwuA78q4ihPLEhJTx5A4YfBPZGFv2Mk0My0WUGGQ/mdgZyszcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722020; c=relaxed/simple;
	bh=+tawYnLWE4zDBdx9k1eNI3ewrKxXjvECwTJ6hCgPayg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPOPdMZAVjg8OoF8TxwORM41DxHzkFGtijVuqSK6eyJn4pzzcPr2cnReLOrnopM7zyWYIOOtS8+myD8yYCOqkRwRbtLTCzbxjeR4Sem6Qmp6RmfjRFJUkIHJmehWmf/S/AL0cgh+C0X0eQ414O5LTfDeDVM7rRfbnWccLLpliRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ckcAzYLw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7D6B2042982;
	Fri, 20 Dec 2024 11:13:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7D6B2042982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734722015;
	bh=yGeF2VGkzlater34YiM2LZbXqVv2HKyEhptGaqHEzXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ckcAzYLwDaDsK7nUXdN8IMYFT7T+q8yG413E2cprbRkDe5A199BDZyiIPJBHfeeHM
	 ErrxFtSx0F7P/pl9p2mccHJwZnPU47y3L5oay8kMMWKHwG0Egvzpd+TfX3hMvIafux
	 7/UR0x2LAeQ3F0LasBwG7V+fP6WLz1x6PA9e8D3Q=
Message-ID: <eba74adf-4891-46f8-a3ef-e116000dd566@linux.microsoft.com>
Date: Fri, 20 Dec 2024 11:13:34 -0800
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/2024 6:01 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, December 19, 2024 3:39 PM
>>
>> On 12/19/2024 1:37 PM, Michael Kelley wrote:

[...]

> I would agree that the percentage savings is small. VMs often have
> several hundred MiB to a few GiB of memory per vCPU. Saving a
> 4K page out of that amount of memory is a small percentage. The
> thing to guard against, though, is applying that logic in many different
> places in Linux kernel code. :-)  The Hyper-V support in Linux already
> has multiple pre-allocated per-vCPU pages, and by being a little bit
> clever we might be able to avoid another one.
> 

[...]

We will also need the vCPU assist pages and the context pages for the
lower VTLs, and the data don't currently occupy the entire pages. Yet
imho it is prudent to leave some wiggle room instead of painting
ourselves into the corner. We're not writing the code for MCUs, are
working under different constraints, and, yes, reaching to use a page as
that's the hard currency of virtualization imho. The numbers show that
savings are negligible per-CPU but these savings come at a cost of
making assumptions what will not happen in the future thus placing a bet
against what the specification says.

It's not even the hyperv code that is the largest consumer of the per-
CPU data, not even close. Looking at the `vmlinux`'es `.data..percpu`
section, there are almost 200 entries, and roughly one quarter is
pointer-sized so who really knows how much is going to be allocated per-
CPU. The top ten statically allocated are

nm -rS --size-sort ./vmlinux | grep -vF ffffffff8 | sed 10q

000000000000c000 0000000000008000 d exception_stacks
0000000000006000 0000000000005000 D cpu_tss_rw
0000000000002000 0000000000004000 D irq_stack_backing_store
000000000001b5c0 0000000000003180 d timer_bases
0000000000017000 0000000000003000 d bts_ctx
0000000000015520 0000000000001450 D cpu_hw_events
000000000000b000 0000000000001000 D gdt_page
0000000000014000 0000000000001000 d entry_stack_storage
0000000000001000 0000000000001000 D cpu_debug_store
0000000000021d80 0000000000000c40 D runqueues

on a configuration that is the bare minimum, no fluff. We could invest
into looking what would be the cost of compiling out `bts_ctx` or
`cpu_debug_store` instead of adding more if statements and making the
code look tricky.

> 
> I agree that a hypercall could produce up to 4 KiB of output in
> response to up to 4 KiB of input. But the guest controls how much
> input it passes. Furthermore, for all the hypercalls I'm familiar with,
> the specification of the hypercall tells the max amount of output it
> will produce in response to the input. That allows the guest to
> know how much output space it needs to allocate and provide to
> the hypercall.
> 

> I will concede that it's possible to envision a hypercall with a
> specification that says "May produce up to 4 KiB of output. A header
> at the beginning of the output says how much output was produced."
> In that case, the guest indeed must supply a full page of output space.
> But I don't think we have any such hypercalls now, and adding such a
> hypercall in the future seems unlikely. Of course, if such a hypercall
> did get added and Linux used that hypercall, Linux would need to
> supply a full page for the hypercall output. That page wouldn't
> necessarily need to be a pre-allocated per-vCPU hypercall output
> page. Depending on the usage circumstances, that full page might be
> able to be allocated on-demand.
> 
> But assume things proceed as they are today where Linux can limit
> the amount of hypercall output based on the input. Then I don't
> see a violation of the contract if Linux limits the output and fits
> it within a page that is also being shared in a non-overlapping
> way with any hypercall input. I wouldn't allocate a per-vCPU
> hypercall output page now for a theoretically possible
> hypercall that doesn't exist yet.

Given that:

* Using the hypercall output page is plumbed throughout the dom0 code,
* dom0 and the VTL mode can share code quite naturally,
* Not using the output page cannot acccount for all cases permitted by
   the TLFS clause "don't overlap input and output, and don't cross page
   boundaries",
* Not using the output page everywhere for consistency requires updating
   call sites of `hv_do_hypercall`​ and friends, i.e. every place where a
   hypercall is made needs to incorporate the offset/pointer at which the
   output should start, or perhaps do some shenanigans with macro's,
* Not using the output page leads to negligible savings,

it is hard to see for me how to make not using the hypercall output page 
look as a profitable enginnering endeavor, really comes off as dancing 
to the perf scare/feature creep tune for peanuts.

In my opinion, we should use the hypercall output page for the VTL mode
as dom0 does to share code and reduce code churn. Had we used some
`hv_get_registers` in both​ instead of the specialized for no compelling
imo practical reason `get_vtl`​ (as it just gets a vCPU register, nothing
more, nothing less), this code path would've been better tested, and any 
of this patching would not have been needed.

I'd wait for few days and then would likely prefer to run with Wei's
permission to send this patch in v2 as-is unless some damning evidence 
presents itself.

> 
> Michael
> 

[...]

-- 
Thank you,
Roman


