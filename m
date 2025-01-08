Return-Path: <linux-hyperv+bounces-3614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF3A063D9
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2D018899EE
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1706200B95;
	Wed,  8 Jan 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JoZNc9E3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5B200B8B;
	Wed,  8 Jan 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359092; cv=none; b=GgaO0zIUNTxu3/hcSWkTCcCmbjrf0w4/FnL4cYpRKxFZx170KVMfobuwdbKgtqf+sdSc27fXsMShj/je/BPETro2Z3DCYoCHejy8vBfqq5s3I+jam3jbfqC4inh80k0pYqe39sLNl+J4Oor0+J8BkgjnlUZjasSgbnzXYpZo840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359092; c=relaxed/simple;
	bh=wrumU0brEuGkmeUcPpaoZOPx2T5t0d7sEE9W42XUVuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxZvAn7xdWr+2aAdkNxORrIY9GyjcgmhH2/6XES8Yr9NtkR4as2a1MSxhWDh6J9yDeZ2sUS5uiN88Mbzp6+77BaR7hc8ZGeisG0ZtpAmf+CIWq0GS5zv7fCCgFWIMxnerdvzOqBIFJE3NIJCwX8Bwec9GJz2taAappnYWtfzW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JoZNc9E3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63C33203E3A4;
	Wed,  8 Jan 2025 09:58:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C33203E3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736359090;
	bh=tgyN1P/JfaeXS6+96yKJZD3mGrUaCl1iWgQTOqO+kPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JoZNc9E3ma0qe+EqyuagBgbI/SstfGYF6LhGtQhPcyi8yBIQ5dG44eX8HZ2SVkaEw
	 x0V9+TnP2bVlL6ATPkvOs7VxlF6dkwhwDIAP0Ly2XfQLqjJVVVdfvQB5xKD0VUjOca
	 eFKx9QdpteHyW3oLRz1Yi7VyqfFl8AtffHvugVPs=
Message-ID: <7a60c96c-2fc1-411b-ac08-2b69f507af4e@linux.microsoft.com>
Date: Wed, 8 Jan 2025 09:58:09 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Michael Kelley <mhklinux@outlook.com>,
 Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
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
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/2025 9:37 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30, 2024 10:10 AM
>>
>> There is no definition of the output structure for the
>> GetVpRegisters hypercall. Hence, using the hypercall
>> is not possible when the output value has some structure
>> to it. Even getting a datum of a primitive type reads
>> as ad-hoc without that definition.
>>
>> Define struct hv_output_get_vp_registers to enable using
>> the GetVpRegisters hypercall. Make provisions for all
>> supported architectures. No functional changes.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>  include/hyperv/hvgdk_mini.h | 49 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index db3d1aaf7330..e8e3faa78e15 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
>>  	} __packed;
>>  };
>>
>> +union hv_arm64_pending_interruption_register {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 interruption_pending : 1;
>> +		u64 interruption_type : 1;
>> +		u64 reserved : 30;
>> +		u32 error_code;
> 
> These bit field definitions don't look right. We want to "fill up"
> the field size, so that we're explicit about each bit, and not leave
> it to the compiler to add padding (which __packed tells the
> compiler not to do). So in aggregate, the "u64" bit fields should
> account for all 64 bits, but here you account for only 32 bits.
> There are two ways to fix this:
> 
> 		u32 interruption_pending : 1;
> 		u32 interruption_type: 1;
> 		u32 reserved : 30;
> 		u32 error_code;
> Or
> 		u64 interruption_pending : 1;
> 		u64 interruption_type: 1;
> 		u64 reserved : 30;
> 		u64 error_code : 32;
> 

Agreed. In the spirit of matching the original headers, I'd prefer
the second one. But either will work.

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
> 
> Same here. Expand the "reserved" field to 28 bits?  Or maybe
> there's a reason to have two separate reserved fields of 4 bits
> and 24 bits. I'm not sure what the register layout is supposed to
> be. Looking at hv_arm64_pending_synthetic_exception_event
> in the OHCL-Linux-Kernel github tree shows the same gap of
> 24 bits, so that doesn't provide any guidance.
> 

Hmm..these should be u8 bitfields according to the Hyper-V code.
However that leaves a 24 bit gap as you pointed out.

In the Hyper-V code, these structures aren't actually packed,
which means sometimes the explicit padding is left out
(unintentionally).

Please add the 24 bits of padding to make it explicit here. I
suggest making the bitfields u8 as in the original code, and adding
another padding field after, like:

u8 event_pending : 1;
u8 event_type : 3;
u8 reserved : 4;
u8 rsvd[3];

>> +		u32 exception_type;
>> +		u64 context;
>> +	} __packed;
>> +};
>> +
>>  union hv_x64_interrupt_state_register {
>>  	u64 as_uint64;
>>  	struct {
>> @@ -1103,8 +1132,28 @@ union hv_register_value {
>>  	union hv_explicit_suspend_register explicit_suspend;
>>  	union hv_intercept_suspend_register intercept_suspend;
>>  	union hv_dispatch_suspend_register dispatch_suspend;
>> +#ifdef CONFIG_ARM64
>> +	union hv_arm64_interrupt_state_register interrupt_state;
>> +	union hv_arm64_pending_interruption_register pending_interruption;
>> +#endif
>> +#ifdef CONFIG_X86
>>  	union hv_x64_interrupt_state_register interrupt_state;
>>  	union hv_x64_pending_interruption_register pending_interruption;
>> +#endif
>> +	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
>> +};
> 
> Per the previous discussion, I can see that the #ifdef's are needed
> here to disambiguate the field names that are the same, but have
> different unions on x86 and arm64.
> 
> But on the flip side, I wonder if the field names should really be the
> same. Because of the different unions, it seems like they couldn't be
> accessed by architecture neutral code (unless the access is just using
> the "as_uint64" option?). So giving the fields names like
> "x86_interrupt_state" and "arm64_interrupt_state" instead of just
> "interrupt_state" might be more consistent with how the rest of this
> file handles architecture differences. But I don't know all the implications
> of making such a change.
> 
> Nuno -- your thoughts?

My main preference is to match with the original code unless there are *serious*
clarity, style or incompatibility issues. I don't see a big problem with gating
or not gating these. As you pointed out, it *may* make arch-neutral code a little
more cumbersome. But it's hard to say if that will actually be a problem.

Right now it seems to match the Hyper-V code and seems fine to me!

> 
> Michael
> 
>> +
>> +/*
>> + * NOTE: Linux helper struct - NOT from Hyper-V code.
>> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
>> + * a structure and have at least one more member besides
>> + * DECLARE_FLEX_ARRAY.
>> + */

See below - you can remove the second part of this comment and just
leave the first line clarifying this is a Linux-only helper.

>> +struct hv_output_get_vp_registers {
>> +	struct {
>> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
>> +		struct {} values_end;
>> +	};
>>  };

I missed this change from a previous version - the additional empty struct
isn't needed here.

Michael - The documentation comment you mentioned previously[1] is just
describing how the DECLARE_FLEX_ARRAY() macro works - it actually adds
the empty struct to placate the compiler.

See include/uapi/linux/stddef.h:47:

#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
	struct { \
		struct { } __empty_ ## NAME; \
		TYPE NAME[]; \
	}
#endif

So the definition should just look like:

struct hv_output_get_vp_registers {
	DECLARE_FLEX_ARRAY(union hv_register_value, values);
};


Thanks
Nuno


[1] https://lore.kernel.org/linux-hyperv/1bf0ce72-a377-4c3f-b68a-0f890f8b5d09@linux.microsoft.com/

>>
>>  #if defined(CONFIG_ARM64)
>> --
>> 2.34.1


