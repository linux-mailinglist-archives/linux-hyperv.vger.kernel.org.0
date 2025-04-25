Return-Path: <linux-hyperv+bounces-5151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C982A9CE69
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C837F1BA3AC5
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3C19A2A3;
	Fri, 25 Apr 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e2Isvt01"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0A2701AE;
	Fri, 25 Apr 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599405; cv=none; b=UskSIRU2bmUwjQoyZv2yU+gznbHN6Tq6jiAZiahPI48kpeFBipCyAtIMHWv4mngySdRVG6L0RCMA6dVMcKz6RdzfVgVvuDEr1MGOZKaWltt9ctXOvcld+d8kJQLD9lEoP6HDuTTXoJzo0Lp4FibY3xYY69vz8lPSQqQDOefCdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599405; c=relaxed/simple;
	bh=0nePQQ4XmdqqCGIis7u2dnLV8W89M2J3s8kLeJCuzaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqfzojX1CLVuZa+klXelhJo0CXAQMjrzPaLmNjVhyF/UEo58GODKpPNGJ5+FgZT3TnFMYaVfVMyI4WnGYfFww3CtNtWxBPAuCN9/e4P3S2aPb2qMAqRXFOF+jw1Vqm/jX+PSgxqSvGxWtkJUH+/3+X3p33VXmKkgSdPSQPUwqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e2Isvt01; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.16.80.157] (unknown [131.107.147.157])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E5892020940;
	Fri, 25 Apr 2025 09:43:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E5892020940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745599402;
	bh=64nT0dPAvYSJyGupR1SMj+3koyYcXK23DHHScnd/PAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e2Isvt01azY9WJAx8bfWpapo8WSaB2WQQQ/xEZdq7O/VdvqEc/z5gG1gjwlvOZmMj
	 PCpGUnuKUAFlcpOg3KnIOOzbEUrAJVpASM1M+8umVCCL+D1J0LVDkCLQd7FPRoquni
	 uRmPiuQAFsQr4uB1+h3vmjYCxPPUDeKyFntwefps=
Message-ID: <8fa1045a-c3e9-48e0-86fe-ab554d7475c8@linux.microsoft.com>
Date: Fri, 25 Apr 2025 09:43:22 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <KUZP153MB1444118E6199CBED8C78E6D4BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/2025 2:14 AM, Saurabh Singh Sengar wrote:
>>
>> On Thu, Apr 24, 2025 at 02:57:46PM -0700, Roman Kisel wrote:
>>> To start an application processor in SNP-isolated guest, a hypercall
>>> is used that takes a virtual processor index. The hv_snp_boot_ap()
>>> function uses that START_VP hypercall but passes as VP ID to it what
>>> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>>>
>>> As those two aren't generally interchangeable, that may lead to hung
>>> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
>>> whereas VP IDs never are.
>>>
>>> Update the parameter names to avoid confusion as to what the parameter
>>> is. Use the APIC ID to VP ID conversion to provide correct input to
>>> the hypercall.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>
>> Applied to hyperv-fixes.
> 
> This patch will break the builds.
> 
> Roman,
> Have you tested this patch on the latest linux-next ?

Thanks for your help! Only on hyperv-next, looking how to repro and fix
on linux-next. The kernel robot was happy, or I am missing some context
about how the robot works...

What was your kernel configuration, or just anything that enables
Hyper-V?

I thought the the linux-next tree would be a subset of hyper-next
so should work, realizing that have to check, likely there might be
changes from other trees.

> 
> Regards,
> Saurabh
> 

-- 
Thank you,
Roman


