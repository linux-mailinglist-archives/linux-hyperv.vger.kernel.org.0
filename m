Return-Path: <linux-hyperv+bounces-5155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C1A9D06B
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B6D9C81DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81CC216E24;
	Fri, 25 Apr 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NCQ0Mw5F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB6198E75;
	Fri, 25 Apr 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605330; cv=none; b=Euy93h9zto296+95RmZ3yXtXmiCSroNSGjZqA3m+GSqqD/fFAV/QtRngUzRmDFeblGy+cGbrHlsfZeQOAYK6QztTVyY4J12dROdc7OqhAeCy21S0QXT3mpQmIQw8BsVfwzdw7EUp6mKFN/3HSZppJ1xPh314O7DSc0pSTbgOy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605330; c=relaxed/simple;
	bh=h/4Eajx1BB93vPcjQ+W2ynlD2GoC8tcFi87iz9uYlDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjAfIMVWXBiqxB1UUfqt5uGNI4XvfU4pDwN+SZCMAq6I2kWREFuD40vkx3rEM7NDrMSp5R5EKpdV84USREGM+4+P0WBNisi0eLcIQmrqmTcajrZcj9X284jkSIq3VyjVBEZj21TK3Axh0Txy96o1NEeOnfW9dhIWShq+o+nDFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NCQ0Mw5F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.16.80.157] (unknown [131.107.147.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89D1120BCAD1;
	Fri, 25 Apr 2025 11:22:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89D1120BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745605328;
	bh=GQxtF7jZT692Xg2kvpz9fFHAy7AjVV3zrXUfHqtyLPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NCQ0Mw5FVpqSQI6GuSPdLS9Cl4TmaROvR7+mdZmykj1KFoZTIgITHgeZJ4zHMt8A4
	 oF36azBo8C3/PbZaSz/tyqEH0Wu9Dsyk/ebsTARvufmGayBSwsDXgw7OSjfZrbBFgF
	 4l721r760DtJtIeNBkyirOQQk3qW/xwV6jPAvfKk=
Message-ID: <c57c6ce9-6ff8-431c-ab77-fa2c727fee09@linux.microsoft.com>
Date: Fri, 25 Apr 2025 11:22:08 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP
 ID confusion in hv_snp_boot_ap()
To: Saurabh Singh Sengar <ssengar@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Allen Pais <apais@microsoft.com>,
 Ben Hillis <Ben.Hillis@microsoft.com>,
 Brian Perkins <Brian.Perkins@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <KUZP153MB1444118E6199CBED8C78E6D4BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8fa1045a-c3e9-48e0-86fe-ab554d7475c8@linux.microsoft.com>
 <KUZP153MB14448BEFA81251661433CE33BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <KUZP153MB14448BEFA81251661433CE33BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/2025 10:18 AM, Saurabh Singh Sengar wrote:
>   
>> On 4/25/2025 2:14 AM, Saurabh Singh Sengar wrote:
>>>>
>>>> On Thu, Apr 24, 2025 at 02:57:46PM -0700, Roman Kisel wrote:
>>>>> To start an application processor in SNP-isolated guest, a hypercall
>>>>> is used that takes a virtual processor index. The hv_snp_boot_ap()
>>>>> function uses that START_VP hypercall but passes as VP ID to it what
>>>>> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>>>>>
>>>>> As those two aren't generally interchangeable, that may lead to hung
>>>>> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be
>>>>> sparse whereas VP IDs never are.
>>>>>
>>>>> Update the parameter names to avoid confusion as to what the
>>>>> parameter is. Use the APIC ID to VP ID conversion to provide correct
>>>>> input to the hypercall.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP
>>>>> guest")
>>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>>
>>>> Applied to hyperv-fixes.
>>>
>>> This patch will break the builds.
>>>
>>> Roman,
>>> Have you tested this patch on the latest linux-next ?
>>
>> Thanks for your help! Only on hyperv-next, looking how to repro and fix on
>> linux-next. The kernel robot was happy, or I am missing some context about
>> how the robot works...
>>
>> What was your kernel configuration, or just anything that enables Hyper-V?
>>
>> I thought the the linux-next tree would be a subset of hyper-next so should
>> work, realizing that have to check, likely there might be changes from other
>> trees.
>>
> 
> 
> hyperv-fixes is broken too, here's the log for your ref:
> 
> https://dashboard.kernelci.org/log-viewer?itemId=microsoft%3A20250425085833916790&o=microsoft&type=build&url=https%3A%2F%2Flisalogsb15850d3.blob.core.windows.net%2Flisa-logs%2Fdefault_default%2F20250425%2F20250425-085110-393%2Fkernel_installer%2Fbuild.log%3Fst%3D2025-04-25T09%253A09%253A35Z%26se%3D2025-05-02T09%253A09%253A35Z%26sp%3Dr%26sv%3D2024-11-04%26sr%3Db%26skoid%3D14b53b1d-f4fc-442e-a437-4989376b1754%26sktid%3D72f988bf-86f1-41af-91ab-2d7cd011db47%26skt%3D2025-04-25T09%253A09%253A35Z%26ske%3D2025-05-02T09%253A09%253A35Z%26sks%3Db%26skv%3D2024-11-04%26sig%3DZHfA7%2FC174KR6HT8zhchCb47NE1aceqw8h0APzKxsII%253D
> 
> The hv_snp_boot_ap() function in arch/x86/hyperv/ivm.c currently fails to compile.
> It looks like the function's argument was changed from 'cpu' to 'apic_id', but internal
> references to cpu were not updated accordingly.
> 
> This might have gone unnoticed during your testing if CONFIG_AMD_MEM_ENCRYPT
> was disabled, in which case this function wouldn't have been compiled.

Must be the case! I did run the command to merge the CVM specific config
options but I didn't check the result.

Yep, I see the issue. Will resend the patch.

> 
> Regards,
> Saurabh

-- 
Thank you,
Roman


