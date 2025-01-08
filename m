Return-Path: <linux-hyperv+bounces-3612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BCBA063AF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB6B1888CC4
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77171F76D1;
	Wed,  8 Jan 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fc2joVgB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B901A256E;
	Wed,  8 Jan 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358482; cv=none; b=c8VKGe8qPRJjcGxDdtp8IxmWWF7prXf3XLKX0Iw48Mwg8lcdXrsLFzm2TUddh2NnnaQNUki9RgfDm9qo+nlJHVrJxd9HIAfuYVyHyzTKfhN+7Qn6dV3ASpl2WQsseBYgLtbcku1zAWwQg4TgqYzAWzU06sJLhVRSeuoImt5/pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358482; c=relaxed/simple;
	bh=VD2IExA+mvdHJIyGpEB06GtRZKCS5yg4rZSRJ148Xyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2FMz9Pt47keBFXmQ+q+67sVPQZqbLIEfT3E5hkq75w1J8T8qShuT6mVfJN5iFDFMygwaz9aH6VTLqJVgU043UOvClKPTOIDE/1+r0ujpQ0HqRn/oF/zHMQclo9jjTduAbo+4c6LQmjRpCOKGg4BUcl40CLwicjz59z6U2CxqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fc2joVgB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C2B4203E3A4;
	Wed,  8 Jan 2025 09:47:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C2B4203E3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736358475;
	bh=tnXGIrioZ1PdjcrjytHUrj/Y4uTUa9qYeG+aQqArfAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fc2joVgBqeY0FP0JvWJq7Kwnhnsmp1xrRc7Ys2pqeRXOEQad+Q86EJ4q/jF01baSs
	 bZbPeJ3qgg/RIxCFSOodSOqCjHUeOYnlAr+nJGx7V0FoY0wlEA2Tt8aFz/vRZJsVjM
	 wRaUdVTnA+E2MsjqdN37DbrQx7pz14H0tW776/dY=
Message-ID: <04e97a7e-efee-43e2-b4f4-6df169ed51a5@linux.microsoft.com>
Date: Wed, 8 Jan 2025 09:47:55 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] hyperv: Do not overlap the hvcall IO areas in
 get_vtl()
To: Wei Liu <wei.liu@kernel.org>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-5-romank@linux.microsoft.com>
 <Z34rF2wzToTZRgem@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z34rF2wzToTZRgem@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/2025 11:36 PM, Wei Liu wrote:
> On Mon, Dec 30, 2024 at 10:09:40AM -0800, Roman Kisel wrote:
>> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
>> disallows overlapping of the input and output hypercall areas, and
>> get_vtl(void) does overlap them.
>>
>> Use the output hypercall page of the current vCPU for the hypercall.
>>
>> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
>> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
>>
>> Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> You forgot to pick up Tianyu's Reviewed-by tag in the previous version.
> In the future please make sure to collect all the tags you get from
> previous review rounds.

Apologies, my bad! Will collect tags in the future.

> 
> Thanks,
> Wei.
> 
>> ---
>>   arch/x86/hyperv/hv_init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index f82d1aefaa8a..173005e6a95d 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
>>   
>>   	local_irq_save(flags);
>>   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -	output = (struct hv_output_get_vp_registers *)input;
>> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>>   
>>   	memset(input, 0, struct_size(input, names, 1));
>>   	input->partition_id = HV_PARTITION_ID_SELF;
>> -- 
>> 2.34.1
>>

-- 
Thank you,
Roman


