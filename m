Return-Path: <linux-hyperv+bounces-3556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEB9FE920
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 17:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02123162438
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E619C552;
	Mon, 30 Dec 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iv6B/7XQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9326518C31;
	Mon, 30 Dec 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735577357; cv=none; b=krodfIG74ejbKDKe24UAO2feBtnp+97K8WpKod5rPiFvnmg53OWfbzcZZq7SvDOE6rexMecXLfWxtOCzs8b+ZLPzCelXjduVgArjAw6x9tL96Kisddp4Fh7/hojnQUa4tdfO8kuTK/wnBn2JswlBjqUTv+4qIFSrwuoiG8CxtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735577357; c=relaxed/simple;
	bh=cDNK2H1IQY4XeX/TMS1i93OXVMwQERqtbPpod98Muq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcbQVjf/S68mRCWmbtfeRuCeJtkUEzIzyJqEd2VnkkC56qqHhzYt34hNBSD2IArQxEbw5scwNIo9KOrBhdhb8FTB9Sz2PNegKC5fwQH9EgIQUHxQY9IuSsZfEHbdHe19ysMi+EpeB6ooJn+9nwYTKW8WBp1+B1wOebAzvqKG8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iv6B/7XQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B9A35205A74C;
	Mon, 30 Dec 2024 08:49:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9A35205A74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735577348;
	bh=bpf02qkxo1CS277MtZONqNwjPnb2xIqLfSF7Pmcp98U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iv6B/7XQEgIYi+GZMwmdbh8lErUIyWnpBjne1XXLpNz5gIp9miOi/DgYGDZO4KfpR
	 LDRo6SmPYorI96Aa9DpGyuI8Q0yz/ESPzngi3AMveArFTM/uY3d3APGlUW2guZisk+
	 ZaEkGVONj2K6bFNrZ48T8OQg93qhiuxFCyAZ+3Ww=
Message-ID: <69ef42c1-c4de-4d50-a3fd-ece18bd5a8f3@linux.microsoft.com>
Date: Mon, 30 Dec 2024 08:49:07 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Michael Kelley <mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
 <20241227183155.122827-2-romank@linux.microsoft.com>
 <SN6PR02MB4157B61822D138A0E0401C1AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157B61822D138A0E0401C1AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/2024 9:46 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, December 27, 2024 10:32 AM

[...]

>>From a thread [1] with Nuno, my understanding is that the
> include/hyperv/* files should *not* use #ifdef <arch> unless
> strictly necessary because a structure or symbol is used in
> arch neutral code and has a different definition for each arch.
> 
> When the structure or symbol definition name contains "x64"
> or "arm64", such conflicts won't occur, and the #ifdef isn't
> needed. This does means that when compiling for either
> x86 or arm64, the symbols from both architectures will be
> visible in the symbol namespace, but that shouldn't cause any
> problems.
> 
> So it looks to me like none of the #ifdef's in this patch are
> needed. Nuno -- please jump in if I have misunderstood.
> 
Understood, thank you, Michael! From the thread you linked,
it appears that there were other approaches with other trade-offs
to be had, and this route was considered to be the most beneficial
one.

Let me spin up another version with these guards removed.
Thanks you all for bearing with me so far!

> Michael
> 
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157AA30A9F27ECCAE202BC2D4582@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
>>   struct hv_x64_segment_register {
>>   	u64 base;
>>   	u32 limit;
>> @@ -807,6 +809,8 @@ struct hv_x64_table_register {
>>   	u64 base;
>>   } __packed;
>>
>> +#endif
>> +
>>   union hv_input_vtl {
>>   	u8 as_uint8;
>>   	struct {
>> @@ -1068,6 +1072,41 @@ union hv_dispatch_suspend_register {
>>   	} __packed;
>>   };
>>
>> +#if defined(CONFIG_ARM64)
>> +
>> +union hv_arm64_pending_interruption_register {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 interruption_pending : 1;
>> +		u64 interruption_type : 1;
>> +		u64 reserved : 30;
>> +		u32 error_code;
>> +	} __packed;
>> +};
>> +
>> +union hv_arm64_interrupt_state_register {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 interrupt_shadow : 1;
>> +		u64 reserved : 63;
>> +	} __packed;
>> +};
>> +
>> +union hv_arm64_pending_synthetic_exception_event {
>> +	u64 as_uint64[2];
>> +	struct {
>> +		u32 event_pending : 1;
>> +		u32 event_type : 3;
>> +		u32 reserved : 4;
>> +		u32 exception_type;
>> +		u64 context;
>> +	} __packed;
>> +};
>> +
>> +#endif
>> +
>> +#if defined(CONFIG_X86)
>> +
>>   union hv_x64_interrupt_state_register {
>>   	u64 as_uint64;
>>   	struct {
>> @@ -1091,6 +1130,8 @@ union hv_x64_pending_interruption_register {
>>   	} __packed;
>>   };
>>
>> +#endif
>> +
>>   union hv_register_value {
>>   	struct hv_u128 reg128;
>>   	u64 reg64;
>> @@ -1098,13 +1139,33 @@ union hv_register_value {
>>   	u16 reg16;
>>   	u8 reg8;
>>
>> -	struct hv_x64_segment_register segment;
>> -	struct hv_x64_table_register table;
>>   	union hv_explicit_suspend_register explicit_suspend;
>>   	union hv_intercept_suspend_register intercept_suspend;
>>   	union hv_dispatch_suspend_register dispatch_suspend;
>> +#if defined(CONFIG_X86)
>> +	struct hv_x64_segment_register segment;
>> +	struct hv_x64_table_register table;
>>   	union hv_x64_interrupt_state_register interrupt_state;
>>   	union hv_x64_pending_interruption_register pending_interruption;
>> +#endif
>> +#if defined(CONFIG_ARM64)
>> +	union hv_arm64_pending_interruption_register pending_interruption;
>> +	union hv_arm64_interrupt_state_register interrupt_state;
>> +	union hv_arm64_pending_synthetic_exception_event
>> pending_synthetic_exception_event;
>> +#endif
>> +};
>> +
>> +/*
>> + * NOTE: Linux helper struct - NOT from Hyper-V code.
>> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
>> + * a structure and have at least one more member besides
>> + * DECLARE_FLEX_ARRAY.
>> + */
>> +struct hv_output_get_vp_registers {
>> +	struct {
>> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
>> +		struct {} values_end;
>> +	};
>>   };
>>
>>   #if defined(CONFIG_ARM64)
>> --
>> 2.34.1

-- 
Thank you,
Roman


