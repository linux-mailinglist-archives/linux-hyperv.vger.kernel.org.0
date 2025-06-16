Return-Path: <linux-hyperv+bounces-5923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C3ADBB14
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 22:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622FF3ADAEF
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D43E28982C;
	Mon, 16 Jun 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uy/ZSae8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF720E007;
	Mon, 16 Jun 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105143; cv=none; b=mkAHEo9cpBLSosvZlgD929OMP7U6ANG3iMWbXVQN/NoA8xGS8WT965kHeRRagraLTiitUovgsQnlXIcbLJXfhGMP4GWKjumwZKIHJeI51bSf7/r0Djb7shTn9X9aY+/ChW7y56dZgaGFx1imCpSqfUkMgcz0e/6Zm6R7Gl0P9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105143; c=relaxed/simple;
	bh=JoY1txm2Gs+qWF6Wyw7hOPo0Qn5fVdrYqia6eleRENQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwKRfbXW5/uqgOV88R787gmMTB4l5c3N+KCHa7IR9m5r423OnL9vfL+3jPCpTVCsuM5aZ+hiu6gsbCwHPFNVGhoNK4KE6zAzCcK1nkpcDMyv5soHe+zu99IyqIicSDFt1P//ZuxJB2mXI2+qmIASi0auVzIr4Z7t8ozYSQhJf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uy/ZSae8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.1.24] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B6D621176CE;
	Mon, 16 Jun 2025 13:19:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B6D621176CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750105140;
	bh=DbAhr6fPGcBENjeomk3ETvZLQrm+55Psk62o0Fe4twI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uy/ZSae8z9fTKK5NtdGhuaGY2Ohz7+rqLU5+RHq/3RsGfXiOSMdDW2+fwYU8EWAab
	 +tS5gDCkSpCxGo4eEaO5AGThhUg4+orlQGLpx6rM6jOJRsKPN6xN+b9aNw9vItrIts
	 cAjE46Kq8X99ud5PRLLhMSuuBmuOYLRVSs5VRoRg=
Message-ID: <92ea0ddb-3813-42f8-8191-1a1f8fae5220@linux.microsoft.com>
Date: Mon, 16 Jun 2025 13:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Drivers: hv: Use nested hypercall for post message
 and signal event
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157ECC740A762C9C3B9EA6AD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157ECC740A762C9C3B9EA6AD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2025 4:06 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June 10, 2025 4:52 PM
>>
>> When running nested, these hypercalls must be sent to the L0 hypervisor
>> or vmbus will fail.
> 
> s/vmbus/VMBus/
> 

Ack

>>
>> Add ARM64 stubs for the nested hypercall helpers to not break
>> compilation (nested is still only supported in x86).
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/arm64/include/asm/mshyperv.h | 10 ++++++++++
>>  drivers/hv/connection.c           |  3 +++
>>  drivers/hv/hv.c                   |  3 +++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index b721d3134ab6..893d6a2e8dab 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -53,6 +53,16 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>  	return hv_get_msr(reg);
>>  }
>>
>> +static inline u64 hv_do_nested_hypercall(u64 control, void *input, void *output)
>> +{
>> +	return U64_MAX;
>> +}
>> +
>> +static inline u64 hv_do_fast_nested_hypercall8(u64 control, u64 input1)
>> +{
>> +	return U64_MAX;
>> +}
> 
> I think the definitions of hv_do_nested_hypercall() and
> hv_do_fast_nested_hypercall8() are architecture independent. All
> they do is add the HV_HYPERCALL_NESTED flag, which when
> implemented for ARM64, will presumably be the same flag as
> currently defined for x86.  As such, couldn't the definitions of
> hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
> be moved to asm-generic/mshyperv.h? Then stubs would not
> be needed for ARM64. These two functions would never be
> called on ARM64 because hv_nested is never true on ARM64
> (at least for now), but the code would compile. And if either
> function was erroneously called on ARM64, presumably
> Hyper-V would return an error because HV_HYPERCALL_NESTED
> is set.
> 

Good point - letting the hypervisor return the error is fine.

>> +
>>  /* SMCCC hypercall parameters */
>>  #define HV_SMCCC_FUNC_NUMBER	1
>>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index be490c598785..992022bc770c 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -518,6 +518,9 @@ void vmbus_set_event(struct vmbus_channel *channel)
>>  					 channel->sig_event, 0);
>>  		else
>>  			WARN_ON_ONCE(1);
>> +	} else if (hv_nested) {
>> +		hv_do_fast_nested_hypercall8(HVCALL_SIGNAL_EVENT,
>> +					     channel->sig_event);
>>  	} else {
>>  		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
>>  	}
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 308c8f279df8..99b73e779bf0 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -84,6 +84,9 @@ int hv_post_message(union hv_connection_id connection_id,
>>  						   sizeof(*aligned_msg));
>>  		else
>>  			status = HV_STATUS_INVALID_PARAMETER;
>> +	} else if (hv_nested) {
>> +		status = hv_do_nested_hypercall(HVCALL_POST_MESSAGE,
>> +						aligned_msg, NULL);
>>  	} else {
>>  		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
>>  					 aligned_msg, NULL);
> 
> Are HVCALL_SIGNAL_EVENT and HVCALL_POST_MESSAGE the only two
> hypercalls that are ever expected to need a "nested" version? I'm
> wondering if the function hv_do_nested_hypercall() and
> hv_do_fast_nested_hypercall8() could be dropped entirely, and just
> pass the first argument to hv_do_hypercall() or hv_do_fast_hypercall8()
> as <hypercall_name> | HV_HYPERCALL_NESTED. For only two cases, a
> little bit of open coding might be preferable to the overhead of defining
> functions just to wrap the or'ing of HV_HYPERCALL_NESTED. 
> 
> The code above could then look like:
> 
> 	} else {
> 		u64 control = HVCALL_POST_MESSAGE;
> 
> 		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
> 		status = hv_do_hypercall(control, aligned_msg, NULL);
> 	}
> 
> Again, ARM64 is implicitly handled because hv_nested is never set.
> 
> This is just a suggestion. It's motivated by the fact that we already have
> three flavors of hypercall for HVCALL_SIGNAL_EVENT and
> HVCALL_POST_MESSAGE, and I was looking for a way to avoid adding
> a fourth flavor. But it's a marginal win, and if you prefer to keep the
> inline functions, I'm OK with that.
> 

I like the suggestion to open-code these cases.

There are several places we need to get/set nested MSRs, but as for hypercalls
it is just these 2, so far. When I consider it from that angle, it feels cleaner
to just open-code them, and remove the existing '_nested' versions of the
hypercall helpers for now.

Thanks
Nuno

> Michael


