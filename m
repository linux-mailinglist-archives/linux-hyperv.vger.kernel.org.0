Return-Path: <linux-hyperv+bounces-10468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MBhKNHZ8WmLkwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10468-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:13:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7C492B2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55931301A148
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52588347518;
	Wed, 29 Apr 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pmZBcQL5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF330B529;
	Wed, 29 Apr 2026 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456844; cv=none; b=kSyeRZpBOw3f01b9ayov7PBbbQpoOMySeIG4e6lGX3Zfpf1wKg0OTHuGHFpmYDFjzHY6LDNq5MExmDpbHjHkFlNjP+yjjeZ3xuy64+l4eUiryjRq5ZpmxYlror7PDAkWUJAP628DuEOwt9xlCpfxwe6kzAwLOa6ergMzkfi/uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456844; c=relaxed/simple;
	bh=nKq21MWKpJ9JRF+8U25wGOhHT9RcuOxZrDC3uu6+8yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhRUCbZk0reMixHho2qNs4rNl2CVJ6KmdGix7GVL7qz6z1xuxgB71pFflWOXJHklnK06aSwzJ7igwtfU5D3WjxzSJa3J8lBmsTx++3fUPRdASqH+pEatEMFqNgMJ2GYR1kgw2xB7BCukFzeELxJQjhqeMqrQOf+cPlslpKbdqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pmZBcQL5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 78CBF20B716C;
	Wed, 29 Apr 2026 03:00:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78CBF20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456842;
	bh=BLsXGKx0T3J/8O/IzlEtJAB/hh15qSfJxIj3wYO8c+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pmZBcQL55VntaOUwjnbe7yQ613XZmm0eAELWs4e8kqgjMJ/vAx5wINzKEINE6T6UF
	 pC5sHNK0ET3Ppsu6Mk/rPZK3QdO80LceWGSGMUPMiwIGjuBfBDdVmyC9Xz/qG7ve0z
	 56Quia5hZp6RFqg7rp2xfw51fkC4J20f80jRQnBA=
Message-ID: <e47c0bbc-f46f-426d-bf3a-675df5b872d0@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:30:31 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] mshv_vtl: Move VSM code page offset logic to x86
 files
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
 <20260423124206.2410879-13-namjain@linux.microsoft.com>
 <SN6PR02MB4157E0525DDDD153888F5AFBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E0525DDDD153888F5AFBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7C7C492B2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10468-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,vsm_pg_offset_reg.name:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]



On 4/27/2026 11:10 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> The VSM code page offset register (HV_REGISTER_VSM_CODE_PAGE_OFFSETS)
>> is x86 specific, its value configures the static call used to return
>> to VTL0 via the hypercall page. Move the register read from the common
>> mshv_vtl_get_vsm_regs() into the x86 mshv_vtl_return_call_init(),
>> which is the sole consumer of the offset.
>>
>> Change mshv_vtl_return_call_init() from taking a u64 parameter
>> to taking no arguments, and rename mshv_vtl_get_vsm_regs() to
>> mshv_vtl_get_vsm_cap_reg() since it now only fetches
>> HV_REGISTER_VSM_CAPABILITIES.
>>
>> No functional change on x86. This prepares the common driver code for
>> ARM64 where VSM code page offsets do not apply.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_vtl.c        | 19 +++++++++++++++++--
>>   arch/x86/include/asm/mshyperv.h |  4 ++--
>>   drivers/hv/mshv_vtl_main.c      | 24 +++++++++++++-----------
>>   3 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index f3ffb6a7cb2d..7c10b34cf8a4 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -293,10 +293,25 @@ EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
>>
>>   DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>>
>> -void mshv_vtl_return_call_init(u64 vtl_return_offset)
>> +int mshv_vtl_return_call_init(void)
>>   {
>> +	struct hv_register_assoc vsm_pg_offset_reg;
>> +	union hv_register_vsm_page_offsets offsets;
>> +	int ret;
>> +
>> +	vsm_pg_offset_reg.name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>> +
>> +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +				       1, input_vtl_zero, &vsm_pg_offset_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	offsets.as_uint64 = vsm_pg_offset_reg.value.reg64;
>> +
>>   	static_call_update(__mshv_vtl_return_hypercall,
>> -			   (void *)((u8 *)hv_hypercall_pg + vtl_return_offset));
>> +			   (void *)((u8 *)hv_hypercall_pg + offsets.vtl_return_offset));
>> +
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(mshv_vtl_return_call_init);
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index b4d80c9a673a..b48f115c1292 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -286,14 +286,14 @@ struct mshv_vtl_cpu_context {
>>   #ifdef CONFIG_HYPERV_VTL_MODE
>>   void __init hv_vtl_init_platform(void);
>>   int __init hv_vtl_early_init(void);
>> -void mshv_vtl_return_call_init(u64 vtl_return_offset);
>> +int mshv_vtl_return_call_init(void);
>>   void mshv_vtl_return_hypercall(void);
>>   void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>>   int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, bool shared);
>>   #else
>>   static inline void __init hv_vtl_init_platform(void) {}
>>   static inline int __init hv_vtl_early_init(void) { return 0; }
>> -static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
>> +static inline int mshv_vtl_return_call_init(void) { return 0; }
>>   static inline void mshv_vtl_return_hypercall(void) {}
>>   static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>>   #endif
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index 4c9ae65ad3e8..be498c9234fd 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -79,7 +79,6 @@ struct mshv_vtl {
>>   };
>>
>>   static struct mutex mshv_vtl_poll_file_lock;
>> -static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>>   static union hv_register_vsm_capabilities mshv_vsm_capabilities;
>>
>>   static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
>> @@ -203,21 +202,19 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>>   	/* VTL2 Host VSP SINT is (un)masked when the user mode requests that */
>>   }
>>
>> -static int mshv_vtl_get_vsm_regs(void)
>> +static int mshv_vtl_get_vsm_cap_reg(void)
>>   {
>> -	struct hv_register_assoc registers[2];
>> -	int ret, count = 2;
>> +	struct hv_register_assoc vsm_capability_reg;
>> +	int ret;
>>
>> -	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>> -	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
>> +	vsm_capability_reg.name = HV_REGISTER_VSM_CAPABILITIES;
>>
>>   	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> -				       count, input_vtl_zero, registers);
>> +				       1, input_vtl_zero, &vsm_capability_reg);
>>   	if (ret)
>>   		return ret;
>>
>> -	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
>> -	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
>> +	mshv_vsm_capabilities.as_uint64 = vsm_capability_reg.value.reg64;
>>
>>   	return ret;
> 
> Nit: This could be just "return 0".

Acked.

> 
>>   }
>> @@ -1139,13 +1136,18 @@ static int __init mshv_vtl_init(void)
>>   	tasklet_init(&msg_dpc, mshv_vtl_sint_on_msg_dpc, 0);
>>   	init_waitqueue_head(&fd_wait_queue);
>>
>> -	if (mshv_vtl_get_vsm_regs()) {
>> +	if (mshv_vtl_get_vsm_cap_reg()) {
>>   		dev_emerg(dev, "Unable to get VSM capabilities !!\n");
> 
> Why is this failure an emergency message, while the other failures
> here in mshv_vtl_init() are just error messages? When there's lack
> of consistency, I always wonder if there is a reason ..... :-)

It might be because I didn’t pay enough attention to the old code :)
dev_err() should work just fine, I'll change it.


> 
>>   		ret = -ENODEV;
>>   		goto free_dev;
>>   	}
>>
>> -	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
>> +	ret = mshv_vtl_return_call_init();
>> +	if (ret) {
>> +		dev_err(dev, "mshv_vtl_return_call_init failed: %d\n", ret);
>> +		goto free_dev;
>> +	}
>> +
>>   	ret = hv_vtl_setup_synic();
>>   	if (ret)
>>   		goto free_dev;
>> --
>> 2.43.0
>>

Regards,
Naman

