Return-Path: <linux-hyperv+bounces-1567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F0859B84
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 06:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F5D1F2211E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 05:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FE200AA;
	Mon, 19 Feb 2024 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eX1QG6NB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6592200A5;
	Mon, 19 Feb 2024 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319263; cv=none; b=o0IcCwLrQke3jRic4SqT20X43j5wODJNu2ILyBQmJONkBBK90K78MbFKuHGkvfEFodosK7rfN70cIu03JGaxnxWj2hQ6+/rJHYo/2bSR3isLp/OPwsVg4yLc7fZkJGSFMmOFRhWoEVUzS91YKr2XVZ7ZrqlAqrsEE6mzO9DudT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319263; c=relaxed/simple;
	bh=w/57Q6ViACrAs5v87KnPuIhEM9z9CIbmcbv3D6hnStY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avSqTg75syHrHEMlv01g1zzmhQQRRT8WLl00g4Sv93XlpJ52/JkpDzY1mscB46EsefMS0S0cB3ceNGxdQHHB6BnlHhFz+uwVM50/JS/2fDSab9nIehHow1avMa0wcyycn0fUsS8hn+36LsT6uE6v/m3kqzbrIpH7XLxIfvX9J2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eX1QG6NB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.10.0.135] (unknown [103.163.191.245])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF28F20835FA;
	Sun, 18 Feb 2024 21:07:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF28F20835FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708319255;
	bh=9ckmFXGd+kBfCNaMSlEmhj1yDgc8H+6mbo2mOcE5h70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eX1QG6NBDh38Y1ba1r4IQcXzXjvy/3IC/YB3ONYiwh+fA14Ey3JEnkXNGAG10SNi+
	 ry3QIbOIHSLts87CmuCmoma3yGBV1T9diKhs5asSI8RqEnH884oRqPsz36NLwdz2vr
	 di8/Le7KPXNsR/FGHfNqmQPvdTtg0kte0xrdp6m8=
Message-ID: <0b3e157d-0c3f-40eb-a8a0-df4c5ae0b93a@linux.microsoft.com>
Date: Mon, 19 Feb 2024 10:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs
 to HV_MSR_*
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <1707389540-6655-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157199AA51C64FCE17695D2D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157199AA51C64FCE17695D2D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/2024 2:37 AM, Michael Kelley wrote:
> 
> Overall, this looks good to me.  It cleans up the mess I made five
> years ago when first separating x86 from ARM64. :-(
> 
> See one comment below, but otherwise,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 

Thanks! Responded to your comment below.

>>  #if IS_ENABLED(CONFIG_HYPERV)
>> -static inline unsigned int hv_get_nested_reg(unsigned int reg)
>> +static inline unsigned int hv_get_nested_msr(unsigned int reg)
>>  {
>> -	if (hv_is_sint_reg(reg))
>> -		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
>> +	if (hv_is_sint_msr(reg))
>> +		return reg - HV_MSR_SINT0 + HV_MSR_NESTED_SINT0;
>>
>>  	switch (reg) {
>> -	case HV_REGISTER_SIMP:
>> -		return HV_REGISTER_NESTED_SIMP;
>> -	case HV_REGISTER_SIEFP:
>> -		return HV_REGISTER_NESTED_SIEFP;
>> -	case HV_REGISTER_SVERSION:
>> -		return HV_REGISTER_NESTED_SVERSION;
>> -	case HV_REGISTER_SCONTROL:
>> -		return HV_REGISTER_NESTED_SCONTROL;
>> -	case HV_REGISTER_EOM:
>> -		return HV_REGISTER_NESTED_EOM;
>> +	case HV_MSR_SIMP:
>> +		return HV_MSR_NESTED_SIMP;
>> +	case HV_MSR_SIEFP:
>> +		return HV_MSR_NESTED_SIEFP;
>> +	case HV_MSR_SVERSION:
>> +		return HV_MSR_NESTED_SVERSION;
>> +	case HV_MSR_SCONTROL:
>> +		return HV_MSR_NESTED_SCONTROL;
>> +	case HV_MSR_EOM:
>> +		return HV_MSR_NESTED_EOM;
>>  	default:
>>  		return reg;
>>  	}
>>  }
> 
> This function is x86 specific, but you are using the generic HV_MSR_* flavor
> instead of the x86 specific HV_X64_MSR_* flavor like in other x86 specific code.
> Both flavors work, but I wondered if there is any reason for using the generic flavor.
>> I remember debating myself the merits of one approach vs. the other, but I
> don't think there was a solid argument either way.   Given that you are
> doing the work to get this all fixed like it should have been originally, I would
> argue for being consistently one way or the other.  ARM64 specific code is
> *not* using the generic HV_MSR_* flavor, so I suspect x86 code should not
> either.
> 
> Michael
> 

I see your point about keeping it consistent within the file.

My thinking was that hv_get_nested_msr is not inherently x86-specific, even though it
lives in arch/x86 today. However, I realize that even if this function *is* moved to
generic code in the future, at that time it could be changed to the generic prefix.
Doing so in this patch could be confusing since it introduces an inconsistency.

So, I will take your advice and keep it HV_X64_MSR_* for everything in this file.

Thanks again!
Nuno


