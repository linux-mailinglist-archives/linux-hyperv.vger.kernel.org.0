Return-Path: <linux-hyperv+bounces-2202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B028CA108
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1042810A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A9137933;
	Mon, 20 May 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="imZ7DWQo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC9DDDA;
	Mon, 20 May 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224898; cv=none; b=FFnCTb+8OwXS4xq6pNHQa2PJfWKZJPYzNL2sNjCHlthabCeuqDaV3Ut2+8JJP1CJDZphfSk/34TKZFmeAUAFE8XSPKys0vcAj2KXBYSNAy5CGCr3LU+Btb54oFagAUoWFquRejqaCvHHuM60XbqV33eBDQF/zv31ia2GtuafWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224898; c=relaxed/simple;
	bh=uPMjsLMozajBPSJTyhd4iDCEer3F8Wdvp88398QviRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jp6SmC3xtqRfY6U72hUC6P/KCob/fb9yOmZtTST//qiXdOrtx134znXXyJd5egDxsWWXk+xQa3ytbAF0jti1dI9LLbBKvqa9e13ixQDz3hKW2YEd+pNLKGOwtR8/vNwL7s+c2kNy7Yi2JCwvHEz1Sjz6yVNxbnFx79YkNEhSgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=imZ7DWQo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id EEB1E20B915A;
	Mon, 20 May 2024 10:08:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEB1E20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716224897;
	bh=xI3TWCgM02Foi5NE2z4SLoXv1z0LJ61GQ+DfUWRJeaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=imZ7DWQoDhpJ1xPLtHujr01ye9/Dc7i5EmHXjVsRXed4ny6hfSRP+u+oKBw//ChI0
	 j8SJtb2yr9Ju1Sm63pw32VbAVj8qQcHinpW0Pw93vD2Nz8cxQrn95eDCV5R3v5ZXwI
	 2WD0VFBE56RBy49ORbKcm4QiZpgg3xYNtuzQU13Y=
Message-ID: <2c2ddc03-cf2e-4503-ba3b-7c221de666c2@linux.microsoft.com>
Date: Mon, 20 May 2024 10:08:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64/hyperv: Support DeviceTree
To: Easwar Hariharan <eahariha@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
 <20240510160602.1311352-2-romank@linux.microsoft.com>
 <46eae37e-0c0d-4963-a39c-c9f1d2318c85@linux.microsoft.com>
 <c3b2d76e-c0d2-4745-935d-14cb74eb772f@linux.microsoft.com>
 <f52893ae-8dd1-421f-9943-cab3ef6974f0@linux.microsoft.com>
 <976901c1-1f16-464d-8e65-5b2425c8b05c@linux.microsoft.com>
 <e6f9761a-e542-417a-a2af-ba9f2bd253c4@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <e6f9761a-e542-417a-a2af-ba9f2bd253c4@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/14/2024 5:00 PM, Easwar Hariharan wrote:
> On 5/14/2024 4:17 PM, Roman Kisel wrote:
>>
>>
>> On 5/14/2024 3:46 PM, Easwar Hariharan wrote:
>>> On 5/10/2024 10:42 AM, Roman Kisel wrote:
>>>>
>>>>
>>>> On 5/10/2024 10:04 AM, Easwar Hariharan wrote:
>>>>> On 5/10/2024 9:05 AM, romank@linux.microsoft.com wrote:
>>>>>> From: Roman Kisel <romank@linux.microsoft.com>
>>>>>>
>>>>>> Update the driver to support DeviceTree boot as well along with ACPI.
>>>>>> This enables the Virtual Trust Level platforms boot up on ARM64.
>>>>>>
>>>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>>>> ---
>>>>>>     arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>>>>>>     1 file changed, 29 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>>>>>> index b1a4de4eee29..208a3bcb9686 100644
>>>>>> --- a/arch/arm64/hyperv/mshyperv.c
>>>>>> +++ b/arch/arm64/hyperv/mshyperv.c
>>>>>> @@ -15,6 +15,9 @@
>>>>>>     #include <linux/errno.h>
>>>>>>     #include <linux/version.h>
>>>>>>     #include <linux/cpuhotplug.h>
>>>>>> +#include <linux/libfdt.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/of_fdt.h>
>>>>>>     #include <asm/mshyperv.h>
>>>>>>       static bool hyperv_initialized;
>>>>>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>>>>>         return 0;
>>>>>>     }
>>>>>>     +static bool hyperv_detect_fdt(void)
>>>>>> +{
>>>>>> +#ifdef CONFIG_OF
>>>>>> +    const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>>>>>> +            of_get_flat_dt_root(), "hypervisor");
>>>>>> +
>>>>>> +    return (hyp_node != -FDT_ERR_NOTFOUND) &&
>>>>>> +            of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
>>>>>> +#else
>>>>>> +    return false;
>>>>>> +#endif
>>>>>> +}
>>>>>> +
>>>>>> +static bool hyperv_detect_acpi(void)
>>>>>> +{
>>>>>> +#ifdef CONFIG_ACPI
>>>>>> +    return !acpi_disabled &&
>>>>>> +            !strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
>>>>>> +#else
>>>>>> +    return false;
>>>>>> +#endif
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Could using IS_ENABLED() allow collapsing these two functions into one hyperv_detect_fw()?
>>>>> I am wondering if #ifdef was explicitly chosen to allow for the code to be compiled in if CONFIG* is defined
>>>>> v/s IS_ENABLED() only being true if the CONFIG value is true.
>>>>>
>>>> In the hyperv_detect_fdt function, the #ifdef has been chosen due to the functions being declared only when the macro is defined, hence I could not rely on `if IS_ENABLED()` and the run-time detection. For the compile-time option, `#if IS_ENABLED()` would convey the intent better, could update with that.
>>>
>>> In patch 2/6, just under the diff you have, we already `select OF_EARLY_FLATTREE if OF`, so the declarations (and definitions)
>>> of the functions being present is already handled, AFAIK. Are we thinking there may be some weird config where neither OF nor
>>> ACPI is selected? If so, we should set a `depends on ACPI || OF` for config HYPERV to prevent that.
>>>
>>> I don't know if I'm missing something obvious here, so please correct me if I'm wrong.
>>>
>> I just sent out the v2 of the patch set, and (un?)fortunately missed the change I had for the #ifdef's in this chunk (to use #if IS_ENABLED() and remove pre-processor directives from the ACPI-related function).
>>
>> I am making the point that the change you are suggesting (as I understand) is this conditional statement
>>
>> if IS_ENABLED(CONFIG_OF) {
>>      const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>>                  of_get_flat_dt_root(), "hypervisor");
>>
>>      return (hyp_node != -FDT_ERR_NOTFOUND) &&
>>                  of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
>> }
>>
> 
> That's right, that's the suggestion I'm making.
> 
>> and for it to link successfully, one needs of_get_flat_dt_subnode_by_name defined. From the source code, that needs CONFIG_OF_EARLY_FLATTREE as there is no stub available when CONFIG_OF_EARLY_FLATTREE is not defined.
> 
> We agree that you need of_get_flat_dt_subnode_by_name declared and defined, and it's not available, stub or otherwise, if CONFIG_OF_EARLY_FLATTREE is not defined.
> 
> In my mind, I believed that either ACPI or OF had to be selected for some sort of firmware handoff to occur, but I did some experimentation and ended up with an
> x86_64 kernel config that has neither enabled, but nonetheless has CONFIG_HYPERV enabled. The kernel builds with such a config, whether it's useful for anything
> is another question. ARM64 requires CONFIG_OF so that side of the equation is clear.
> 
> That's where my question above came in: Are we thinking there may be some weird config where neither OF nor ACPI is selected? I thought that was not a reasonable
> config, thus my prescription to set `depends on ACPI || OF` for config HYPERV. If there is a use case for an x86_64 kernel that has neither ACPI nor OpenFirmware/FDT,
> but nevertheless sets CONFIG_HYPERV, feel free to ignore this comment thread entirely.
> 
Thanks for laying out the details so patiently for me! I believe I 
understand your concerns better now. In the V2 of the patch series, 
Michael Kelly suggested rethinking how the Kconfig change is carried 
out. Appears natural to try out what your suggesting alongside with the 
Michael's suggestions.

As for your other point, I wouldn't think, too, the system could boot or 
be useful without some coordinates of the environment passed via ACPI || DT.

> 
> Thanks,
> Easwar

-- 
Thank you,
Roman

