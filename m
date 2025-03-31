Return-Path: <linux-hyperv+bounces-4753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C6A76F85
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 22:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD63AAB93
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8921B91F;
	Mon, 31 Mar 2025 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="WafMnNSj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3387218EB1
	for <linux-hyperv@vger.kernel.org>; Mon, 31 Mar 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453708; cv=none; b=J/v4DN67wm2Z1VJK3+l+lHY2cliq7lOGCdQ97yZwzjmW1AQjdQKRx2NqIwomTKEPaRAiB1CtO6NDTL4IeIN9h9/DmE/SdfTURl+3yNNOMv4nnh/vrV86vKaF5aKDN5v5ifT3MU9cxyFZLYtt2W2BCo5Bas7cfSv47PZKyW0jRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453708; c=relaxed/simple;
	bh=281CTHNc0Yoohn4OzLyEWIKCtbnzk6BtpsrO75OnLdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsT2dxvMfvEEx57HlZMrDLIJKZtYtkVQOSaV9zzbF74zDWnWGmLq+fy4pZrmhr31uYux/U7YwCj8Y75W9FBu9lVF1LkN7EomTeuaHNKI3jqk21f8v2Y65N9pZ8A1EB9xYwFGzo2QzrSnmjDTQWdPZiKKujvUDvFHm4zFt0PQJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=WafMnNSj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4668104f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Mar 2025 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743453704; x=1744058504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rGJAe0UQZxK4zMdJovc/1efMoUHDDD05RrKDXkqIC1k=;
        b=WafMnNSjVr02J5wVJuxWjLCpEmfG2f+6lKrXHAx4PBaEx8bM5U/yh7tlzpxOkpEoer
         HdIOzttKJAcuENLIaZBO85ShS5Q20XrptmErz2gf9aTqCIo3H6GGL029Je84e6nvP+ce
         fL66rt0W0S8pYQLGfUcaUY+QtIKPiad/Lz+Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453704; x=1744058504;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGJAe0UQZxK4zMdJovc/1efMoUHDDD05RrKDXkqIC1k=;
        b=QGzx8R5P7L4USPtZ2ERQnqtpILG4CH/Tt/BCwNH8GXN7YLrLNW604vFh/6TUihRFOo
         lrSKQlgVlNJl3LPBdoxH9iMFzAzy4uzE3CSRmhB3FKwa3gkJukbi1PEOdFXzEs5Og0wh
         YDpl5CqgjiUcYxLXwcXo/DEBDfKFOsW7oUG2xYNL5UTv5QJxx8Udng4TD3KJ59rAwngm
         MUJSKdF9UHc8I2WXAYSsB9xQuZgl60UOwlDBheaBT8yW2k+ETvFmxM5btjlJ9B39I6Mm
         baptd1yCYCS2W7XGEKiniw6VXYUw0xMvb8ebPTNv+ea7i+H5AvjWpCB/fD1RHO4QP/+l
         8MIA==
X-Forwarded-Encrypted: i=1; AJvYcCXhzM+LjimA5ImRX+78TqWOpFqRT+1frvegpdydzSqZg5r0H3k6N3sXVXkMEIIYoY/zH/68T2gGwystGoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBf1z2RRQhOlD29tJIP1Ks6j1IBpwbqp7ylqH2ju0I3f7psPZ+
	cPV2HjREMjMEb0HwHRCceG4wQyM3qc/+je7cgokPVvP56j8Ipt3GWYEw+kybloM=
X-Gm-Gg: ASbGncsKZgB8sF8BzOPhJ7f9tq7dtELy0uUyf/9McBBcwyP4XATVOOekbYpyATZOqRj
	nAO5ZX2iZE6N+yWfxooKaqEFRYY9nkYYISXazKGtuoXbh2nhwcZa0qnGbh3dmGFoC12O4HSDxkb
	Ev6bmjus9lGOKUDFlwAl26tZLeq03Tz+I/h7kck0m1pRhaIJPxrrvR9PqLPfD5JDT3jZwC5Swk1
	yjemjG0r+CZkMGzt87FpLv/297muCFktCMNaz+vazuacH+RktP4TSwCeO8PYKlI+huD85AZLQf8
	gp2kSj0geypQ5GVA9Ck9LEuScd/hF7rLyP1zvi0rSot+PMiWOJkoiXC6dwL7n9qRCwFQGQ+lUre
	NtfgJoe7S3Q==
X-Google-Smtp-Source: AGHT+IELgOL2ZFTcYBUrFSIuo2rwMKxJQe2rD/asVJqxQr19K+w0UzLYi4yoZPeCFXyQFMNepUNBpg==
X-Received: by 2002:a05:6000:420a:b0:391:487f:2828 with SMTP id ffacd0b85a97d-39c120cd1d0mr8781705f8f.10.1743453704261;
        Mon, 31 Mar 2025 13:41:44 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e0d1sm12187246f8f.70.2025.03.31.13.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 13:41:43 -0700 (PDT)
Message-ID: <fde11fbb-4b3f-44f1-90cf-6aaefb6bb7c1@citrix.com>
Date: Mon, 31 Mar 2025 21:41:41 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 10/15] KVM: VMX: Use WRMSRNS or its immediate form
 when available
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-edac@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-ide@vger.kernel.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
References: <20250331082251.3171276-1-xin@zytor.com>
 <20250331082251.3171276-11-xin@zytor.com>
 <Z-r6qxmk7niRssee@char.us.oracle.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z-r6qxmk7niRssee@char.us.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2025 9:27 pm, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 31, 2025 at 01:22:46AM -0700, Xin Li (Intel) wrote:
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>  arch/x86/include/asm/msr-index.h |  6 ++++++
>>  arch/x86/kvm/vmx/vmenter.S       | 28 ++++++++++++++++++++++++----
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index e6134ef2263d..04244c3ba374 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1226,4 +1226,10 @@
>>  						* a #GP
>>  						*/
>>  
>> +/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
>> +#define ASM_WRMSRNS		_ASM_BYTES(0x0f,0x01,0xc6)
>> +
>> +/* Instruction opcode for the immediate form RDMSR/WRMSRNS */
>> +#define ASM_WRMSRNS_RAX		_ASM_BYTES(0xc4,0xe7,0x7a,0xf6,0xc0)
>> +
>>  #endif /* _ASM_X86_MSR_INDEX_H */
>> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
>> index f6986dee6f8c..9fae43723c44 100644
>> --- a/arch/x86/kvm/vmx/vmenter.S
>> +++ b/arch/x86/kvm/vmx/vmenter.S
>> @@ -64,6 +64,29 @@
>>  	RET
>>  .endm
>>  
>> +/*
>> + * Write EAX to MSR_IA32_SPEC_CTRL.
>> + *
>> + * Choose the best WRMSR instruction based on availability.
>> + *
>> + * Replace with 'wrmsrns' and 'wrmsrns %rax, $MSR_IA32_SPEC_CTRL' once binutils support them.
>> + */
>> +.macro WRITE_EAX_TO_MSR_IA32_SPEC_CTRL
>> +	ALTERNATIVE_2 __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;		\
>> +				  xor %edx, %edx;				\
>> +				  mov %edi, %eax;				\
>> +				  ds wrmsr),					\
>> +		      __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;		\
>> +				  xor %edx, %edx;				\
>> +				  mov %edi, %eax;				\
>> +				  ASM_WRMSRNS),					\
>> +		      X86_FEATURE_WRMSRNS,					\
>> +		      __stringify(xor %_ASM_AX, %_ASM_AX;			\
>> +				  mov %edi, %eax;				\
>> +				  ASM_WRMSRNS_RAX; .long MSR_IA32_SPEC_CTRL),	\
>> +		      X86_FEATURE_MSR_IMM
>> +.endm
>> +
>>  .section .noinstr.text, "ax"
>>  
>>  /**
>> @@ -123,10 +146,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
>>  	movl PER_CPU_VAR(x86_spec_ctrl_current), %esi
>>  	cmp %edi, %esi
>>  	je .Lspec_ctrl_done
>> -	mov $MSR_IA32_SPEC_CTRL, %ecx
>> -	xor %edx, %edx
>> -	mov %edi, %eax
>> -	wrmsr
> Is that the right path forward?
>
> That is replace the MSR write to disable speculative execution with a
> non-serialized WRMSR? Doesn't that mean the WRMSRNS is speculative?

MSR_SPEC_CTRL is explicitly non-serialising, even with a plain WRMSR.

non-serialising != non-speculative.

Although WRMSRNS's precise statement on the matter of
non-speculativeness is woolly, given an intent to optimise it some more
in the future.

~Andrew

