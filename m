Return-Path: <linux-hyperv+bounces-2118-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72D8C5E13
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FD9B2162C
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 May 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1C17F387;
	Tue, 14 May 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jx/n6ETL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD84C9B;
	Tue, 14 May 2024 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715728647; cv=none; b=YDGDjMevU1RBkJrKTZVK4tixjA3NRo4nxLB5uZoZ2nRQqFcV36K/0tBHUYpjyS4jb6a0qgUWOh3ovhnwPXCxMGaxo0I8BXIf8PIoYwc6wTcGnXdSQbJq5+I5Zy5kguy3EyWXB4MTw91C2erkw4oppgg61Uq1XVaNzAldhMEwBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715728647; c=relaxed/simple;
	bh=JjQu7uSlmx2MY5qr833kxk+ABul2AaIS9iZ8V44gVN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5GPnkMvuPLQ4u4ys7fTm6J2cACEXE2B0BuomDWrTvpDZcwsZW5JbxMU7SX7b1r/zOBJkMHhuxQjegKSUNnpKRrRMxiGReKLDYJwNOgSbFdfPnWC82MJINroMv0mXllKO/BrOC9nX/lSr48GQ+5OPw6/3E0eGiNpXFikBKXi+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jx/n6ETL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9EB32095D0B;
	Tue, 14 May 2024 16:17:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9EB32095D0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715728645;
	bh=wUryKYCmXtV3TQTYYyc4nW4b/MHv2vKgC3lgEgZWHso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jx/n6ETL4+mJCRhCwGRsnYt+nMm0BnDgJPpeMwJYFxhtttfX7no5DmYf6zyl4DhNX
	 ndJnIgGGd8SHEwHfWDfIXnYlIzHhHiHoOcqb624aIR/khJAk94SjtkCHqdUPaUbyGc
	 PrY0P/2MAHfS5+gV27Jbj8MlfBjeMzARi2jyNpMQ=
Message-ID: <976901c1-1f16-464d-8e65-5b2425c8b05c@linux.microsoft.com>
Date: Tue, 14 May 2024 16:17:26 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <f52893ae-8dd1-421f-9943-cab3ef6974f0@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/14/2024 3:46 PM, Easwar Hariharan wrote:
> On 5/10/2024 10:42 AM, Roman Kisel wrote:
>>
>>
>> On 5/10/2024 10:04 AM, Easwar Hariharan wrote:
>>> On 5/10/2024 9:05 AM, romank@linux.microsoft.com wrote:
>>>> From: Roman Kisel <romank@linux.microsoft.com>
>>>>
>>>> Update the driver to support DeviceTree boot as well along with ACPI.
>>>> This enables the Virtual Trust Level platforms boot up on ARM64.
>>>>
>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>> ---
>>>>    arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>>>>    1 file changed, 29 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>>>> index b1a4de4eee29..208a3bcb9686 100644
>>>> --- a/arch/arm64/hyperv/mshyperv.c
>>>> +++ b/arch/arm64/hyperv/mshyperv.c
>>>> @@ -15,6 +15,9 @@
>>>>    #include <linux/errno.h>
>>>>    #include <linux/version.h>
>>>>    #include <linux/cpuhotplug.h>
>>>> +#include <linux/libfdt.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_fdt.h>
>>>>    #include <asm/mshyperv.h>
>>>>      static bool hyperv_initialized;
>>>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>>>        return 0;
>>>>    }
>>>>    +static bool hyperv_detect_fdt(void)
>>>> +{
>>>> +#ifdef CONFIG_OF
>>>> +    const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>>>> +            of_get_flat_dt_root(), "hypervisor");
>>>> +
>>>> +    return (hyp_node != -FDT_ERR_NOTFOUND) &&
>>>> +            of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
>>>> +#else
>>>> +    return false;
>>>> +#endif
>>>> +}
>>>> +
>>>> +static bool hyperv_detect_acpi(void)
>>>> +{
>>>> +#ifdef CONFIG_ACPI
>>>> +    return !acpi_disabled &&
>>>> +            !strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
>>>> +#else
>>>> +    return false;
>>>> +#endif
>>>> +}
>>>> +
>>>
>>> Could using IS_ENABLED() allow collapsing these two functions into one hyperv_detect_fw()?
>>> I am wondering if #ifdef was explicitly chosen to allow for the code to be compiled in if CONFIG* is defined
>>> v/s IS_ENABLED() only being true if the CONFIG value is true.
>>>
>> In the hyperv_detect_fdt function, the #ifdef has been chosen due to the functions being declared only when the macro is defined, hence I could not rely on `if IS_ENABLED()` and the run-time detection. For the compile-time option, `#if IS_ENABLED()` would convey the intent better, could update with that.
> 
> In patch 2/6, just under the diff you have, we already `select OF_EARLY_FLATTREE if OF`, so the declarations (and definitions)
> of the functions being present is already handled, AFAIK. Are we thinking there may be some weird config where neither OF nor
> ACPI is selected? If so, we should set a `depends on ACPI || OF` for config HYPERV to prevent that.
> 
> I don't know if I'm missing something obvious here, so please correct me if I'm wrong.
> 
I just sent out the v2 of the patch set, and (un?)fortunately missed the 
change I had for the #ifdef's in this chunk (to use #if IS_ENABLED() and 
remove pre-processor directives from the ACPI-related function).

I am making the point that the change you are suggesting (as I 
understand) is this conditional statement

if IS_ENABLED(CONFIG_OF) {
     const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
				of_get_flat_dt_root(), "hypervisor");

     return (hyp_node != -FDT_ERR_NOTFOUND) &&
				of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
}

and for it to link successfully, one needs 
of_get_flat_dt_subnode_by_name defined. From the source code, that needs 
CONFIG_OF_EARLY_FLATTREE as there is no stub available when 
CONFIG_OF_EARLY_FLATTREE is not defined. I'll check on successful 
linking with the config without CONFIG_OF and the above snippet. Do feel 
free to provide the code you have in mind.

>>
>> In the hyperv_detect_acpi function, using of the #ifdef appears to be not needed, will remove that in the next version of the patch set. Appreciate your help!
>>
>> As for combining the functions into one, the result looks less readable due to more if statements and is mixing the concerns to an extent. That said, unless you feel strongly about having just one function here, perhaps could keep the both functions.
> 
> Agreed on the readability, let's keep both functions.
> 
> Thanks,
> Easwar

-- 
Thank you,
Roman

