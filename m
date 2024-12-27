Return-Path: <linux-hyperv+bounces-3537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D351C9FD691
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733941629B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1751F8689;
	Fri, 27 Dec 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZPBUY4ta"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5B1F4E4B;
	Fri, 27 Dec 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735320325; cv=none; b=QvBmBJOuEgENMn9rYxpA/0Ukd+UI572FaGRpyyCJxfIZVy9GZvxQ7oOUsiFkfrUaau+pfKdNR0XyAgZ+yj6yGCAqND8qE+pJxfPXhzeDBrs2NPcQdwrts+Nbq2OumU/ooEVzHaL/EcntqjGw4OeuwCUBUv2ZaJ9MKVnYOaat2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735320325; c=relaxed/simple;
	bh=NGjPBCFc0D0IpbuAxSYr+epRPGpt2adMU6YQv/LVje4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTUQNxzbwsOAhiuZzzjmXVJEgyMvDkO05mHdKe/tDyIqzMgaV8SesdS7MV4AKgqQjSC+1BYa0pg1vNqkyWFRKWgzq4xjKfm65Qp1wrL5pHI/31ieBdTaO5n4NoAGRifnxjXHC/W42i/Dolk9KCqAuoF8fz8VLX4IXqHrAU0DcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZPBUY4ta; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B34D203EC3A;
	Fri, 27 Dec 2024 09:25:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B34D203EC3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735320317;
	bh=0SWo4xLcCJwCd8Vi2R3/oJYW3OO80FrjBbcUw7G/mpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZPBUY4taOI5ir3HZUfDfkQsIbay2t+e3lZO0ARHMx3+P2WH2cr5MNxM3RFeIpcW8U
	 SkQg6oI6L8G2VWRJZ8xxFVjmT8IFBF9l9xr72+JncGr9yIp+LL3rluS3WcJVOIHjEb
	 uIKhyQgmnKqQQQTtJ/tyP4clZsHWJmgaTHeRb4DA=
Message-ID: <3b545c1e-dd86-4ca7-b3fd-6f6ff87bddb3@linux.microsoft.com>
Date: Fri, 27 Dec 2024 09:25:16 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 nunodasneves@linux.microsoft.com
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-2-romank@linux.microsoft.com>
 <1bf0ce72-a377-4c3f-b68a-0f890f8b5d09@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1bf0ce72-a377-4c3f-b68a-0f890f8b5d09@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/26/2024 2:11 PM, Easwar Hariharan wrote:
> On 12/26/2024 1:31 PM, Roman Kisel wrote:

[...]

>> +#else
>> +	#error "This architecture is not supported"
>> +#endif
>> +};
> 
> I don't love the #error for unsupported architectures when Kconfig takes
> care of that for us, but I suppose it's for completeness since the arm64
> members have to be conditioned on CONFIG_ARM64?
> 
Felt right to do that, but because it raises questions, it should carry
a comment or be removed as, if you pointed out, Kconfig is in charge of
that kind of validation. As Kconfig permits Hyper-V on the correct set
of arch'es, the best choice would be to remove I think.

>> +
>> +/* NOTE: Linux helper struct - NOT from Hyper-V code */
>> +struct hv_output_get_vp_registers {
>> +	DECLARE_FLEX_ARRAY(union hv_register_value, values);
>>   };
> 
> I'm not super familiar with DECLARE_FLEX_ARRAY() but it appears this
> needs to be wrapped in an anonymous struct at the least per this comment
> for the definition of DECLARE_FLEX_ARRAY()
> 
>> * In order to have a flexible array member [...] alone in a
>> * struct, it needs to be wrapped in an anonymous struct with at least 1
>> * named member, but that member can be empty.
> 
> Nuno, since you seem to be more familiar, can you provide some guidance?
I will wrap the struct member of the documentation requires, not to
make the code look suspicious.

> 
> Thanks,
> Easwar

-- 
Thank you,
Roman


