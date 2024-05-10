Return-Path: <linux-hyperv+bounces-2095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DD8C2975
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 19:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BA7286C46
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BF118EA1;
	Fri, 10 May 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s0v4mLOS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F213D97F;
	Fri, 10 May 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362926; cv=none; b=SOPfF23nPFCkT8CC1G56sSUcOFlUaaHhH8ZPhFYi3uBlxuluvq9rnmJ4mk+ITJtbxuBi0FI8VxMh780kxfDONsP0SkV0rh+izsBw9MhHkf6LKZEQNTqNPsG1FI+M9ocCjOwgqOSf5lXBsqCM4Nvw9W0dp4vtmlM5jv/5CCATcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362926; c=relaxed/simple;
	bh=eqEO/R8HsX5SPhLuAodILCTWPLOkHZ1de83Sb91bJtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeZH/GKWo3b/OWs7QQED/9UZrbxfoGt+SOdXZk+Pb4bLnTdFFaQkMeocqF7VXbMDsX/xtZKdqPnFXlRJqUhSrXvXI22mdMdHs5kZf2MbUZ4FO+IucP3gqFO5OcaLHsw8wp8isrKeItSSMLmVS7UjRgfT5Bz/4Y1D3cO49oK4k/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s0v4mLOS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8952C20B2C87;
	Fri, 10 May 2024 10:42:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8952C20B2C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715362924;
	bh=jpcl2q3NsOGVxCvSVhCdY+UrwwMIoRTP5oIP3XwDPoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s0v4mLOSCVj5XCREzE2vEleT98F6mWWQW8cvI+DrHPeMctCLxppjelqrW+pwIF0H+
	 Gef1R6oWYmf2U2QGIzYBYqqX1rRnRfbjUgyDQyqZigNYhiJKImCFZrZsLvCqWD+zHW
	 qt8h22kSbMtm5HjIDuQq8L+cnlyGcRf9qi48sYnk=
Message-ID: <c3b2d76e-c0d2-4745-935d-14cb74eb772f@linux.microsoft.com>
Date: Fri, 10 May 2024 10:42:05 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <46eae37e-0c0d-4963-a39c-c9f1d2318c85@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/2024 10:04 AM, Easwar Hariharan wrote:
> On 5/10/2024 9:05 AM, romank@linux.microsoft.com wrote:
>> From: Roman Kisel <romank@linux.microsoft.com>
>>
>> Update the driver to support DeviceTree boot as well along with ACPI.
>> This enables the Virtual Trust Level platforms boot up on ARM64.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index b1a4de4eee29..208a3bcb9686 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -15,6 +15,9 @@
>>   #include <linux/errno.h>
>>   #include <linux/version.h>
>>   #include <linux/cpuhotplug.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>>   #include <asm/mshyperv.h>
>>   
>>   static bool hyperv_initialized;
>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>   	return 0;
>>   }
>>   
>> +static bool hyperv_detect_fdt(void)
>> +{
>> +#ifdef CONFIG_OF
>> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>> +			of_get_flat_dt_root(), "hypervisor");
>> +
>> +	return (hyp_node != -FDT_ERR_NOTFOUND) &&
>> +			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>> +static bool hyperv_detect_acpi(void)
>> +{
>> +#ifdef CONFIG_ACPI
>> +	return !acpi_disabled &&
>> +			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
> 
> Could using IS_ENABLED() allow collapsing these two functions into one hyperv_detect_fw()?
> I am wondering if #ifdef was explicitly chosen to allow for the code to be compiled in if CONFIG* is defined
> v/s IS_ENABLED() only being true if the CONFIG value is true.
> 
In the hyperv_detect_fdt function, the #ifdef has been chosen due to the 
functions being declared only when the macro is defined, hence I could 
not rely on `if IS_ENABLED()` and the run-time detection. For the 
compile-time option, `#if IS_ENABLED()` would convey the intent better, 
could update with that.

In the hyperv_detect_acpi function, using of the #ifdef appears to be 
not needed, will remove that in the next version of the patch set. 
Appreciate your help!

As for combining the functions into one, the result looks less readable 
due to more if statements and is mixing the concerns to an extent. That 
said, unless you feel strongly about having just one function here, 
perhaps could keep the both functions.

> 
>>   static int __init hyperv_init(void)
>>   {
>>   	struct hv_get_vp_registers_output	result;
>> @@ -35,13 +61,11 @@ static int __init hyperv_init(void)
>>   
>>   	/*
>>   	 * Allow for a kernel built with CONFIG_HYPERV to be running in
>> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
>> +	 * a non-Hyper-V environment.
>> +	 *
>>   	 * In such cases, do nothing and return success.
>>   	 */
>> -	if (acpi_disabled)
>> -		return 0;
>> -
>> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
>> +	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
>>   		return 0;
>>   
>>   	/* Setup the guest ID */
> 

-- 
Thank you,
Roman

