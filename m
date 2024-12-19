Return-Path: <linux-hyperv+bounces-3504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4C9F8416
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA9188573A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD401A9B47;
	Thu, 19 Dec 2024 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kemgBn3g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1CF19E985;
	Thu, 19 Dec 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636222; cv=none; b=pEjYD+CUH0gQ+Q8JFXm3QnE3GKoQJPhsqMmWVei5Srmu/ze4bB2SjIvOahWdu7Ev3U25Ql9hT32BjkfK9GU18mkTwPFf1+qY6/JTdwJAh4t6FBMX5ptw6ioxABjjQhluQrte/mP5EeBl1O/ga2sA4aWJMdHa7kud9EsRaAin9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636222; c=relaxed/simple;
	bh=ZtLH46A3QbFZSSmlZAv/DybtCujBl+meUFbISoEdwEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1j1SsljqzE/rM0Y/rORQ17h0R8NSb7CU3CZUha/3KLqdCzHEVgvBixyV+TU2zMLvI2LVKlxZJtqHvw5lvQmBHi5A9iin5uVcc2lHHIRw/3w710bG8douQ6PIQbB6gVVJ07iVAUNEkJ9C1BwChRMTbAT5ej1MmWhLpuWGT4uSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kemgBn3g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E003C203FC92;
	Thu, 19 Dec 2024 11:23:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E003C203FC92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734636220;
	bh=W8jaleRT5bUHjtz/TMEaivJ5xBVoEl/VqGOuKa+pKwU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kemgBn3g1jXQvQwCl5QagtYld/DVotR+dMvZU5NhIoE+rQiuyvdrVYfBM1n/ltfef
	 +PPDAB6UOSAE0cwWfzgf9S7S7CBrvNFzWoeyNpAS4iHJkcP89AA5Sc++wVfJSkWEHN
	 Y8X+UEyUxgG7sQOwhGReFnlEEJfKxLOvLczLA3MU=
Message-ID: <ed70560d-9901-4859-9bc0-6fa368636438@linux.microsoft.com>
Date: Thu, 19 Dec 2024 11:23:39 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
 <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/2024 11:13 AM, Easwar Hariharan wrote:
> On 12/19/2024 10:40 AM, Nuno Das Neves wrote:
>> On 12/18/2024 12:54 PM, Roman Kisel wrote:
>>> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>>> changed the type of the output pointer to `struct hv_register_assoc` from
>>> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
>>> and leaves the system broken.
>>>
>> My bad! But, lets not use `struct hv_get_registers_output`. Instead, use
>> `struct hv_register_value`, since that is the more complete definition of a
>> register value. The output of the get_vp_registers hypercall is just an array
>> of these values.
>>
>> Ideally we remove `struct hv_get_vp_registers_output` at some point, since
>> it serves the same role as `struct hv_register_value` but in a more limited
>> capacity.
>>
>> Thanks
>> Nuno
>>
> 
> I had much the same conversation with Roman off-list yesterday.
> 
> The choice is between using hv_get_registers_output which is clearly the
> output of the GetVpRegisters hypercall by name, albeit limited as you

If it's desirable to have a more 'friendly' naming here, then I'd be okay with:
```
/* NOTE: Linux helper struct - NOT from Hyper-V code */
struct hv_output_get_vp_registers {
	DECLARE_FLEX_ARRAY(struct hv_register_value, values);
}
```
Note also the name is prefixed with "hv_output_" to match other hypercall outputs.

> said, and hv_register_value which is the more complete definition and
> what the hypervisor actually returns, but does not currently include the
> arm64 definitions in our copy of hvgdk_mini.h. hv_get_registers_output
> and hv_register_value overlap in layout for Roman's purposes.
> 
> FWIW, I'm in favor of adding the arm64 definitions to hv_register_value
> and using it for this get_vtl() patch.
> 

> This could be accompanied with migration of hv_get_vpreg128 in arm64/
> and removal of struct hv_get_registers_output, or that could be deferred
> to a later patch.

I'd be happy to submit a followup patch to update the arm64 code to use
hv_register_value, or a new struct as outlined above.

It is a pretty small change though, it might be easier to just include it in
this series.

Nuno

> 
> - Easwar


