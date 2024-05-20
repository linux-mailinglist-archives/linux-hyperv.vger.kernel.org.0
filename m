Return-Path: <linux-hyperv+bounces-2201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0458CA0FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D64A281AC4
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D29136E06;
	Mon, 20 May 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iK2X41DA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E711184;
	Mon, 20 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224433; cv=none; b=f9KMNoTWw0duUz1nGhgBmS5Aop7U6J7wbeL1TUn3vzS4MpYX1RFV5x+Fp6VTHHKQHbU+rLDylMXTJx+DlMqMQw23OMbErt0JAfZSgYoi97XFpik0tbWOK2F01P0NGWWHLR9+koyIwj3np/vd+n6FqRHBF+ohtwm4Yo/K2Zk1qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224433; c=relaxed/simple;
	bh=SSr0iqCN967wg9xSh/dmtFStkNZtgnoB0ZddYfjq7DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr6qrJzSwIe3hZ2RwOkQkOSNjOOWrR9J2iKbzqGxHElBF14y678Se9tqOOsLoezS0gR8825ubxQNuw6/A1B9gu4qC8QOWIbwEEHvElVU+E8zAF5oy9wDUsHMb59eQQx/30hk2rSWNTaP7TTlOrOj3JG7j6VF1n0sKFpVXrByS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iK2X41DA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 237F72054219;
	Mon, 20 May 2024 10:00:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 237F72054219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716224430;
	bh=14hBKGlp/aZ8eRrezaPMNcslh3LNzRHCxMHh4SE9seA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iK2X41DAV7YHCH001cHbfIyCdgAG/LQWNL4yEOLCrfLRYVDrcSS0U/Gu+gTtL7ccr
	 I4EtXQ955OZX/BrRBTs+Aj/7/GcJ/uGWBYFdUWAw2ew7LNhkKn5qDmuW8KPdtkOCxv
	 ZHQ5WvRvxz+uHBClRAQ9cV0jWcVi0SApMsFMePBA=
Message-ID: <41c0c98f-35d6-49c6-988f-476cee1d86d1@linux.microsoft.com>
Date: Mon, 20 May 2024 10:00:30 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drivers/hv: Enable VTL mode for arm64
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, ssengar@microsoft.com, sunilmut@microsoft.com
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
 <20240510160602.1311352-3-romank@linux.microsoft.com>
 <ZkRnnM1f5lUo7OLB@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <ZkRnnM1f5lUo7OLB@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 12:43 AM, Wei Liu wrote:
> On Fri, May 10, 2024 at 09:05:01AM -0700, romank@linux.microsoft.com wrote:
>> From: Roman Kisel <romank@linux.microsoft.com>
>>
>> This change removes dependency on ACPI when buidling the hv drivers to
>> allow Virtual Trust Level boot with DeviceTree.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 862c47b191af..a5cd1365e248 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>>   config HYPERV
>>   	tristate "Microsoft Hyper-V client drivers"
>>   	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>>   	select PARAVIRT
>>   	select X86_HV_CALLBACK_VECTOR if X86
>>   	select OF_EARLY_FLATTREE if OF
>> @@ -15,7 +15,7 @@ config HYPERV
>>   
>>   config HYPERV_VTL_MODE
>>   	bool "Enable Linux to boot in VTL context"
>> -	depends on X86_64 && HYPERV
>> +	depends on HYPERV
> 
> As Ktest bot pointed out, this change broke the build.
> 
Appreciate your help! I've sent out v2 with the base commit set, and so 
far, robots have been fine with it :) I haven't noticed an alert of a 
broken build due to this change.

> Thanks,
> Wei.
> 
>>   	depends on SMP
>>   	default n
>>   	help
>> @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
>>   
>>   	  Select this option to build a Linux kernel to run at a VTL other than
>>   	  the normal VTL0, which currently is only VTL2.  This option
>> -	  initializes the x86 platform for VTL2, and adds the ability to boot
>> +	  initializes the kernel to run in VTL2, and adds the ability to boot
>>   	  secondary CPUs directly into 64-bit context as required for VTLs other
>>   	  than 0.  A kernel built with this option must run at VTL2, and will
>>   	  not run as a normal guest.
>> -- 
>> 2.45.0
>>

-- 
Thank you,
Roman

