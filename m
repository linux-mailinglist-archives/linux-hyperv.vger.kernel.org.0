Return-Path: <linux-hyperv+bounces-5251-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F3AA4FEA
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE023BA28D
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B11C173C;
	Wed, 30 Apr 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mUkVmkxJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7081525A355;
	Wed, 30 Apr 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026125; cv=none; b=P2j0LhvbZjE+U0UEZjhX1KHPR34mqE3ixYrAcDY/LoS3/gkmSJB/T4Mx3CmCucKIwGOCb8J7iWBIs2JuwF5O77wLJdGCJLo27r4HlOTLP7af8cixc6JZvvIpFX15DhGQjSlcP9RowuSVJ6U9KH8KaWvZPUbncRaDbG7W4GOCmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026125; c=relaxed/simple;
	bh=jubYPsJzd+H1RTCRdZIk+1nms8xnduYNChhUwp+FvVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDVxeUJCMwnReXlQroz1itsokvM0WZQ3juCG3yGXTA8/G8B6mbULnkHigqeUx0cl5/oLc3eg5BA45bI9DuFuHUbgGR8LM1kWV3/EKmoPiQORGT57oyzElixBgFUxrJ2GjiNA0CjvAySoF9e33StPc1rN2v9JS7vWEQ8fGYt3BE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mUkVmkxJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF48C204E7ED;
	Wed, 30 Apr 2025 08:15:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF48C204E7ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746026118;
	bh=/aktgTobyPAcbV95qdvhU8MApa9HEEMHftbIxEqr9ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUkVmkxJTAGRbCxoIVBT7p/2uea4l4yxlym03yNjdLpbUEZCvFsuSZVSXMG//aXxJ
	 xzfq18AkYXiqv70frdVzYQFWB4W5bCLS9W7RQ3/XqmVnTgr7MWnkCFn/TSvhOOAtZg
	 TDkhTZUAmW3Qs7BoqNyiegR4GyAsYHzxlNcv6Va0=
Message-ID: <50dd72d6-6e12-4b0e-954d-5b7e57fd02fb@linux.microsoft.com>
Date: Wed, 30 Apr 2025 08:15:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20250428182705.132755-1-romank@linux.microsoft.com>
 <SN6PR02MB4157F5E0375016711820D2FBD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F5E0375016711820D2FBD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 8:42 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 28, 2025 11:27 AM
>>
>> To start an application processor in SNP-isolated guest, a hypercall
>> is used that takes a virtual processor index. The hv_snp_boot_ap()
>> function uses that START_VP hypercall but passes as VP index to it
>> what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>>
>> As those two aren't generally interchangeable, that may lead to hung
>> APs if the VP index and the APIC ID don't match up.
>>
>> Update the parameter names to avoid confusion as to what the parameter
>> is. Use the APIC ID to the VP index conversion to provide the correct
>> input to the hypercall.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>> [V3]
>> 	- Removed the misleading comment about the APIC ID and VP indices.
>> 	- Removed the not sufficiently founded if statement that was added
>> 	  to the previous version of the patch to avoid the O(n) time complexity.
>> 	  I'll follow up with a separate patch to address that as that pattern
>> 	  has crept into other places in the code in the AP wakeup path.
>> 	- Fixed the logging message to use the "VP index" terminology
>> 	  consistently.
>>      ** Thank you, Michael! **
>>
>> [V2]
>> 	https://lore.kernel.org/linux-hyperv/20250425213512.1837061-1-romank@linux.microsoft.com/
>>      - Fixed the terminology in the patch and other code to use
>>        the term "VP index" consistently
>>      ** Thank you, Michael! **
>>
>>      - Missed not enabling the SNP-SEV options in the local testing,
>>        and sent a patch that breaks the build.
>>      ** Thank you, Saurabh! **
>>
>>      - Added comments and getting the Linux kernel CPU number from
>>        the available data.
>>
>> [V1]
>>      https://lore.kernel.org/linux-hyperv/20250424215746.467281-1-romank@linux.microsoft.com/
>> ---
>>   arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
>>   arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
>>   arch/x86/hyperv/ivm.c           | 22 +++++++++++++++--
>>   arch/x86/include/asm/mshyperv.h |  6 +++--
>>   include/hyperv/hvgdk_mini.h     |  2 +-
>>   5 files changed, 64 insertions(+), 43 deletions(-)
> 
> Thanks for fixing the terminology, in addition to fixing the bug that is your original
> purpose for the patch.

Thanks for your support and feedback :)

> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

-- 
Thank you,
Roman


