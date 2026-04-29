Return-Path: <linux-hyperv+bounces-10463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF6BH97W8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10463-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:01:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB576492807
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295583014BC4
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B83B8955;
	Wed, 29 Apr 2026 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j3t1KqCo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485931AC44D;
	Wed, 29 Apr 2026 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456619; cv=none; b=VCL9Su0kKEsFP1PocCGXua0P4BkDzjvTjH+ypqQwwRt4AwUkKLMheB3ZxKc1gMJQ74l0NQE1MiZ21I7OkXuVD7fqxbgsdeh7SoBNBJhas9265L30L4ndYqklaO3UdwKlvguDLVoyBEk4F66SC3wvEIfF2NJYf+mLQFtjQ7JOXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456619; c=relaxed/simple;
	bh=S4Ys+ZR/A3fxX+pYyXStcLU1VTVHaP0MC1rIdwbZbGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMsFCLmbyL3jGgJc23dKtNf2GQ0ylJ5HBTnJEPgJ9o0s5aVkS2wtC66PU0FMTvGCZC6ZBHATIxQVaNsWS1lK573KZJj9lKLY7/G7qJUE/04oWpK23kNH+EOUA5wfU92oA4uZz5xPLy7kQwyXZtZxQZnHI+FSu9daiKuNaHxvzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j3t1KqCo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 022BB20B716D;
	Wed, 29 Apr 2026 02:56:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 022BB20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456615;
	bh=QgIpyU8QZGJkXf492lXwNUttCaD3J45IhKenqaCb8JU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j3t1KqCo0xfeLFi9dtOHcVl1enYVvkTTCWZf/S6+1njDs+5WLIKxyCr+MaZT+dX6s
	 1GtfPpoCrizCdwBgAuRmIgUqS6cRpZ84PZrt9W+C1tH19AeqXBBCOSZB5ScCq91arB
	 2ycNK80H4Ji9sx2/5Zebo999PZQBXpkGPAZqdQ58=
Message-ID: <516a4e65-3a4d-4e09-b445-28cb740b5653@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:26:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sascha Bischoff <sascha.bischoff@arm.com>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "vdso@mailbox.org" <vdso@mailbox.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-8-namjain@linux.microsoft.com>
 <SN6PR02MB4157C147A1B915F9B45D3B74D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157C147A1B915F9B45D3B74D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB576492807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10463-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]



On 4/27/2026 11:08 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
>> driver on arm64. This function enables the transition between Virtual
>> Trust Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <vdso@mailbox.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/Makefile        |   1 +
>>   arch/arm64/hyperv/hv_vtl.c        | 158 ++++++++++++++++++++++++++++++
>>   arch/arm64/include/asm/mshyperv.h |  13 +++
>>   arch/x86/include/asm/mshyperv.h   |   2 -
>>   drivers/hv/mshv_vtl.h             |   3 +
>>   include/asm-generic/mshyperv.h    |   2 +
>>   6 files changed, 177 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/arm64/hyperv/hv_vtl.c
>>
> 
> [snip]
> 
>> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
>> index 585b23a26f1b..9eb0e5999f29 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -60,6 +60,18 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>   				ARM_SMCCC_SMC_64,		\
>>   				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>   				HV_SMCCC_FUNC_NUMBER)
>> +
>> +struct mshv_vtl_cpu_context {
>> +/*
>> + * x18 is managed by the hypervisor. It won't be reloaded from this array.
>> + * It is included here for convenience in array indexing.
>> + * 'rsvd' field serves as alignment padding so q[] starts at offset 32*8=256.
>> + */
>> +	__u64 x[31];
>> +	__u64 rsvd;
>> +	__uint128_t q[32];
>> +};
>> +
>>   #ifdef CONFIG_HYPERV_VTL_MODE
>>   /*
>>    * Get/Set the register. If the function returns `1`, that must be done via
>> @@ -69,6 +81,7 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs,
>> bool set, b
>>   {
>>   	return 1;
>>   }
>> +
> 
> This appears to be a spurious blank line being added since there
> are no other changes in the vicinity.

Acked.

> 
>>   #endif
>>
>>   #include <asm-generic/mshyperv.h>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 08278547b84c..b4d80c9a673a 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -286,7 +286,6 @@ struct mshv_vtl_cpu_context {
>>   #ifdef CONFIG_HYPERV_VTL_MODE
>>   void __init hv_vtl_init_platform(void);
>>   int __init hv_vtl_early_init(void);
>> -void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>>   void mshv_vtl_return_call_init(u64 vtl_return_offset);
>>   void mshv_vtl_return_hypercall(void);
>>   void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>> @@ -294,7 +293,6 @@ int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set,
>> bool shared);
>>   #else
>>   static inline void __init hv_vtl_init_platform(void) {}
>>   static inline int __init hv_vtl_early_init(void) { return 0; }
>> -static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>>   static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
>>   static inline void mshv_vtl_return_hypercall(void) {}
>>   static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
>> index a6eea52f7aa2..103f07371f3f 100644
>> --- a/drivers/hv/mshv_vtl.h
>> +++ b/drivers/hv/mshv_vtl.h
>> @@ -22,4 +22,7 @@ struct mshv_vtl_run {
>>   	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
>>   };
>>
>> +static_assert(sizeof(struct mshv_vtl_cpu_context) <= 1024,
>> +	      "struct mshv_vtl_cpu_context exceeds reserved space in struct
>> mshv_vtl_run");
>> +
>>   #endif /* _MSHV_VTL_H */
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index db183c8cfb95..8cdf2a9fbdfb 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -396,8 +396,10 @@ static inline int hv_deposit_memory(u64 partition_id, u64 status)
>>
>>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>   u8 __init get_vtl(void);
>> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>>   #else
>>   static inline u8 get_vtl(void) { return 0; }
>> +static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
> 
> Is this stub needed? Maybe I missed something, but it looks to me like none
> of the code that calls this gets built unless CONFIG_HYPERV_VTL_MODE is set.
> See further comments about stubs in Patch 8 of this series.
> 

Config dependencies would handle such cases, and this is not required. I 
saw similar stubs added in the code, so I thought this is a norm that 
should be followed, and not rely on config dependencies.
I can remove it.

Regards,
Naman


