Return-Path: <linux-hyperv+bounces-5439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC62AB0403
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0371B23763
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0328B510;
	Thu,  8 May 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NT8Qtevk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3B289823;
	Thu,  8 May 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733382; cv=none; b=ASBDsLjWKNSKjrSg5SEM5fuS0GGGwSOwUBCUPuWTtTO1PNvNSJAJtyPoyduU8U0v1QCt6UnVokQqjMfMamIMFxATsd64H+JsxVIoehD47cMhTGDdlWWvOqMr5RCyTxmw7l+yUeGynlAz7ec5WrqL87r/7vlrNDsTXV+YIt0eIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733382; c=relaxed/simple;
	bh=wQh7YJYaTQeuZiEbkG14qwz3hRC1WEAPqpNkDOCHEws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHWFZbZDVaXWp0FnIVR4tDk1PN1NA0bG/xe3vdpzNkNjyZm8uiRTJ0dMXf6rY2ic+XRJluOuTLYS0W1FfZC7Ld6sWT8IRDmq0pbpt4fPPFh4fyLhK7wYW1874MV8ZD3Nb3aoi5/JN8MsuiQnCOn0ZT2uGusd8+8nH2OyxkkLdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NT8Qtevk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B9152109CD4;
	Thu,  8 May 2025 12:43:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B9152109CD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746733380;
	bh=/bkDXJzs7WfC41R7agsNEU8kGRw1YLDtQ55PG1+pZh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NT8QtevkSHegbtHOvVef+m1tHO3tvfr1yDq/O9C32S/g6sEcockztN2lkMVKi/xwB
	 Y4VA/oWH+PVSktj3r7U/s6EHZ89VUcA6Yu9awSDHWhy5jn3waHENw3+mpQVm9xj0fR
	 316wPqaq43rIt5NzJBQnGIyvR/OwZuUAiCw0ON/E=
Message-ID: <7e9dc568-c685-4530-b2b8-669a58adc3fc@linux.microsoft.com>
Date: Thu, 8 May 2025 12:43:00 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the
 AP startup
To: Wei Liu <wei.liu@kernel.org>
Cc: ardb@kernel.org, bp@alien8.de, brgerst@gmail.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, dimitri.sivanich@hpe.com,
 gautham.shenoy@amd.com, haiyangz@microsoft.com, hpa@zytor.com,
 imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org,
 justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
 kys@microsoft.com, lenb@kernel.org, mhklinux@outlook.com, mingo@redhat.com,
 nikunj@amd.com, papaluri@amd.com, patryk.wlazlyn@linux.intel.com,
 peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
 sohil.mehta@intel.com, steve.wahl@hpe.com, tglx@linutronix.de,
 thomas.lendacky@amd.com, tiala@microsoft.com, yuehaibing@huawei.com,
 linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250507182227.7421-1-romank@linux.microsoft.com>
 <aBz6Vuv9w4uRjaG_@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBz6Vuv9w4uRjaG_@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/2025 11:39 AM, Wei Liu wrote:
> On Wed, May 07, 2025 at 11:22:24AM -0700, Roman Kisel wrote:
>> This patchset combines two patches that depend on each other and were not applying
>> cleanly:
>>    1. Fix APIC ID and VP index confusion in hv_snp_boot_ap():
>>      https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/
>>    2. Provide the CPU number in the wakeup AP callback:
>>      https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/
>>
>> I rebased the patches on top of the latest hyperv-next tree and updated the second patch
>> that broke the linux-next build. That fix that, I made one non-functional change:
>> updated the signature of numachip_wakeup_secondary() to match the parameter list of
>> wakeup_secondary_cpu().
>>
>> Roman Kisel (2):
>>    x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
>>    arch/x86: Provide the CPU number in the wakeup AP callback
> 
> I queue these up.
> 
> Just so you know I'm experimenting a new setup. These have been applied
> to hyperv-next-staging. It will take some time for them to propagate to
> hyperv-next.

Thank you very much! That's exciting news about the new staging setup!!

> 
> Thanks,
> Wei.
> 
>>
>>   arch/x86/coco/sev/core.c             | 13 ++-----
>>   arch/x86/hyperv/hv_init.c            | 33 +++++++++++++++++
>>   arch/x86/hyperv/hv_vtl.c             | 54 ++++------------------------
>>   arch/x86/hyperv/ivm.c                | 11 ++++--
>>   arch/x86/include/asm/apic.h          |  8 ++---
>>   arch/x86/include/asm/mshyperv.h      |  7 ++--
>>   arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
>>   arch/x86/kernel/apic/apic_noop.c     |  8 ++++-
>>   arch/x86/kernel/apic/apic_numachip.c |  2 +-
>>   arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>>   arch/x86/kernel/smpboot.c            | 10 +++---
>>   include/hyperv/hvgdk_mini.h          |  2 +-
>>   12 files changed, 76 insertions(+), 76 deletions(-)
>>
>>
>> base-commit: 9b0844d87b1407681b78130429f798beb366f43f
>> -- 
>> 2.43.0
>>

-- 
Thank you,
Roman


