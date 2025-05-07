Return-Path: <linux-hyperv+bounces-5419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1DAAEC19
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B4352727A
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D728DF21;
	Wed,  7 May 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jt2wteTC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56B1EB5DD;
	Wed,  7 May 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645638; cv=none; b=Ry7a4l8cp7ZIXmpnOBSF/YTp+JlTbnTVCSLdkJt12vfWSHCtciv03XXWPzcMTs09i2uehrZSjjD/MT6viPsl6c6iOycLecB2u2nr8ZYEm9KNBdjs3VWrKehm1hSVuHrmYyYB1P33+EdrrTRjEUq8OxuzcSgMZWB6WHMYb6Zoz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645638; c=relaxed/simple;
	bh=IgOLCp37TSVnOTXTJc4SonWQNyGNeuLHUT/onPi9Tj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlTMJQdOojEdINooSQOCbOy+YCrg499bpyzWozJfh9d2fcL0PIDeDKhvJdq2flC5X9VurlPDkfd3dqIGd69ukpzzeIOyTIt3TN8BGMejeMxl6CwnL8WSmkIKse1DooPjr/UihOabQ8OY25KBaOTm1VJHjZWfciG1zVzkkCAjJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jt2wteTC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8462021199D8;
	Wed,  7 May 2025 12:20:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8462021199D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746645636;
	bh=JtfQWDqJfbEmwByxdcYhrzlafR0B/2iyaNcatZCowcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jt2wteTCe7PJJUIGt7CzTAWMTckLa3SRA1v80wVJ38GfKqZyBGuWFOsheoXwUPWe8
	 wxmve/tsstfthQgBLbJCYy8m9eq6bNIFeqO1Q8mpCRmj8yfiN+pIWjqUPNqPUxht9v
	 jY8+RQgV5ZVJ5k+FFUEREEAqch14VIZrWMqXTF1A=
Message-ID: <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
Date: Wed, 7 May 2025 12:20:36 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 6:02 AM, Saurabh Singh Sengar wrote:
> 
[..]

>> +	}
>> +
>> +	local_irq_save(flags);
>> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +
>> +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
>> hvcall.input_size)) {
> 
> Here is an issue related to usage of user copy functions when interrupt are disabled.
> It was reported by Michael K here:
> https://github.com/microsoft/OHCL-Linux-Kernel/issues/33

 From the practical point of view, that memory will be touched by the
user mode by virtue of Rust requiring initialization so the a possible
page fault would be resolved before the IOCTL. OpenHCL runs without swap
so the the memory will not be paged out to require page faults to be
brought in back.

I do agree that might be turned into a footgun by the user land if
they malloc a page w/o prefaulting (so it's just a VA range, not backed
with the physical page), and then send its address straight over here
right after w/o writing any data to it. Perhaps likelier with the output
data. Anyway, yes, relying on the user land doing sane things isn't
the best approach to the kernel programming.

If we're inclined to fix this, I'd encourage to take an approach that
works for the confidential VMs as well so we don't have to fix that
again when start upstreaming what we have for SNP and TDX. The
allocation *must* be visible to the hypervisor in the confidential
scenarios.

Or, maybe we could avoid the allocations by reading the first byte
of the user land buffer to "pre-fault" the page outside of the
scope that disables interrupts. Why allocate if we can avoid that?
Could set up also the SMP remote calls to run this on the desired
CPU.

Summarizing for the case you want to change this:

1. Keep interrupts disabled when reading/writing to/from the Hyper-V
    driver allocated input and output pages.
2. If you decide to allocate separate pages, make sure they are
    visible to the hypervisor in the confidential scenarios. I know
    we're not talking SNP and TDX here just yet but it would be
    a waste of time imho to build something here and scrape that
    later. The issues with allocations are:
        a) If allocating on-demand, we might fail the hypercall
           because of OOM. That's certainly bad as the whole VM
           will break down.
        b) If allocating for the whole lifetime of the VM,
           let us remember that we avoid using hypercalls
           due to their runtime cost. We'll be keeping around
           2 pages per CPU for the few times we need them.
3. Consider reading a byte from the user land buffers to make the page
    fault happen outside of disabling interrupts. There is no
    outswap (maybe could have disabling swap in Kconfig) so the page
    will stay in the memory.

If you're not changing this, feel free to keep my "Reviewed-by".

> 
> - Saurabh

-- 
Thank you,
Roman


