Return-Path: <linux-hyperv+bounces-10218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLWeLkNd5ml6vQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10218-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:07:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 183AB43094A
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6291831381E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5D2C11D9;
	Mon, 20 Apr 2026 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EKDaPGdA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544F264612;
	Mon, 20 Apr 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698646; cv=none; b=l4vrol9tGPiQ23OjuTz+WVaOnjAahsxCOS3i/v1fWh0Mt/mV2XSo4SaaBehx6dNtnjhKqO98P3qRNP0eNh4aIrFoldClFuUYS9Qk2BZQkny2K9ri0eupYLTqCUN5egYggBhNKfb/NdMGeNx2HbCHilGwJGMkWRVKoe+m6uevfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698646; c=relaxed/simple;
	bh=hGEpknEa6Qajz03BQPFs8Cy8qK9qbhJNKT8ep76SRS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLv9y8OfmFzKLeCH1gYTW53g7EsQAc2qhuM35cqVN28AMdwTi/aZ76nsSWwNJ+118a5bIFRIKLfcl93DYRbRPqKoYRy0G6OuA9CrObAWOr9XDd4QXSraf0PrX2Nv0myvL2qx5tMBysS4BDB/DOCtNqyZfIH81SnZUdqLLHjcvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EKDaPGdA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.139] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3185520B6F01;
	Mon, 20 Apr 2026 08:23:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3185520B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776698644;
	bh=LhFF/SBzp1A+cCKneDwHe2aLrFxKC7aKXTjGNPpdPAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EKDaPGdAqLHVz1a5CyfYXpHqzs6ksNPQEXqRVqDxQRLSaYzRpD4E+NiIYH5cPa8+7
	 jUkiaUHBGvUyB8OEgqAcpA12gKBnBNUutoqcxToky7RmMQOLUL4J77kem+yS5uO6/5
	 2a6iuUmJpDS3BKgFX/RP3AxcPUxA40iptRfXQmT0=
Message-ID: <0686416d-4eb7-4287-b846-3570b7a0896a@linux.microsoft.com>
Date: Mon, 20 Apr 2026 20:53:44 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] Drivers: hv: mshv_vtl: Move register page config to
 arch-specific files
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
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-9-namjain@linux.microsoft.com>
 <SN6PR02MB4157CF364DA2C0CC657A6DCBD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157CF364DA2C0CC657A6DCBD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10218-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[reg_assoc.name:url,linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 183AB43094A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:28 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> Move mshv_vtl_configure_reg_page() implementation from
>> drivers/hv/mshv_vtl_main.c to arch-specific files:
>> - arch/x86/hyperv/hv_vtl.c: full implementation with register page setup
>> - arch/arm64/hyperv/hv_vtl.c: stub implementation (unsupported)
>>
>> Move common type definitions to include/asm-generic/mshyperv.h:
>> - struct mshv_vtl_per_cpu
>> - union hv_synic_overlay_page_msr
>>
>> Move hv_call_get_vp_registers() and hv_call_set_vp_registers()
>> declarations to include/asm-generic/mshyperv.h since these functions
>> are used by multiple modules.
>>
>> While at it, remove the unnecessary stub implementations in #else
>> case for mshv_vtl_return* functions in arch/x86/include/asm/mshyperv.h.
> 
> Seems like this patch is doing multiple things. The reg page configuration
> changes are more substantial and should probably be in a patch by
> themselves. The other changes are more trivial and maybe are OK
> grouped into a single patch, but you could also consider breaking them
> out.

I will split this patch into 3 patches.

> 
>>
>> This is essential for adding support for ARM64 in MSHV_VTL.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/hv_vtl.c        |  8 +++++
>>   arch/arm64/include/asm/mshyperv.h |  3 ++
>>   arch/x86/hyperv/hv_vtl.c          | 32 ++++++++++++++++++++
>>   arch/x86/include/asm/mshyperv.h   |  7 ++---
>>   drivers/hv/mshv.h                 |  8 -----
>>   drivers/hv/mshv_vtl_main.c        | 49 +++----------------------------
>>   include/asm-generic/mshyperv.h    | 42 ++++++++++++++++++++++++++
>>   7 files changed, 92 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
>> index 66318672c242..d699138427c1 100644
>> --- a/arch/arm64/hyperv/hv_vtl.c
>> +++ b/arch/arm64/hyperv/hv_vtl.c
>> @@ -10,6 +10,7 @@
>>   #include <asm/boot.h>
>>   #include <asm/mshyperv.h>
>>   #include <asm/cpu_ops.h>
>> +#include <linux/export.h>
>>
>>   void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
>>   {
>> @@ -142,3 +143,10 @@ void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
>>   		"v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
>>   }
>>   EXPORT_SYMBOL(mshv_vtl_return_call);
>> +
>> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
>> +{
>> +	pr_debug("Register page not supported on ARM64\n");
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index de7f3a41a8ea..36803f0386cc 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -61,6 +61,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>   				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>>   				HV_SMCCC_FUNC_NUMBER)
>>
>> +struct mshv_vtl_per_cpu;
>> +
>>   struct mshv_vtl_cpu_context {
>>   /*
>>    * NOTE: x18 is managed by the hypervisor. It won't be reloaded from this array.
>> @@ -82,6 +84,7 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs,
>> bool set, u
>>   }
>>
>>   void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
> 
> I think this declaration could be added in asm-generic/mshyperv.h so that it
> is shared by x86 and arm64. That also obviates the need for the forward
> ref to struct mshv_vtl_per_cpu that you've added here.

Acked.

> 
>>   #endif
>>
>>   #include <asm-generic/mshyperv.h>
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 72a0bb4ae0c7..ede290985d41 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -20,6 +20,7 @@
>>   #include <uapi/asm/mtrr.h>
>>   #include <asm/debugreg.h>
>>   #include <linux/export.h>
>> +#include <linux/hyperv.h>
>>   #include <../kernel/smpboot.h>
>>   #include "../../kernel/fpu/legacy.h"
>>
>> @@ -259,6 +260,37 @@ int __init hv_vtl_early_init(void)
>>   	return 0;
>>   }
>>
>> +static const union hv_input_vtl input_vtl_zero;
>> +
>> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
>> +{
>> +	struct hv_register_assoc reg_assoc = {};
>> +	union hv_synic_overlay_page_msr overlay = {};
>> +	struct page *reg_page;
>> +
>> +	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
>> +	if (!reg_page) {
>> +		WARN(1, "failed to allocate register page\n");
>> +		return false;
>> +	}
>> +
>> +	overlay.enabled = 1;
>> +	overlay.pfn = page_to_hvpfn(reg_page);
>> +	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
>> +	reg_assoc.value.reg64 = overlay.as_uint64;
>> +
>> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> +				     1, input_vtl_zero, &reg_assoc)) {
>> +		WARN(1, "failed to setup register page\n");
>> +		__free_page(reg_page);
>> +		return false;
>> +	}
>> +
>> +	per_cpu->reg_page = reg_page;
>> +	return true;
> 
> As Sashiko AI noted, the memory allocated for the reg_page never gets freed.

These are present in existing code, I'll address them in a separate series.

> 
>> +}
>> +EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
>> +
>>   DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>>
>>   void mshv_vtl_return_call_init(u64 vtl_return_offset)
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index d5355a5b7517..d592fea49cdb 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -271,6 +271,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg) {
>> return 0; }
>>   static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
>>   #endif /* CONFIG_HYPERV */
>>
>> +struct mshv_vtl_per_cpu;
>> +
>>   struct mshv_vtl_cpu_context {
>>   	union {
>>   		struct {
>> @@ -305,13 +307,10 @@ void mshv_vtl_return_call_init(u64 vtl_return_offset);
>>   void mshv_vtl_return_hypercall(void);
>>   void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>>   int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u64 shared);
>> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
> 
> Same as for arm64. Add a shared declaration in asm-generic/mshyperv.h.

Ditto.

> 
>>   #else
>>   static inline void __init hv_vtl_init_platform(void) {}
>>   static inline int __init hv_vtl_early_init(void) { return 0; }
>> -static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>> -static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
>> -static inline void mshv_vtl_return_hypercall(void) {}
>> -static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>>   #endif
>>
>>   #include <asm-generic/mshyperv.h>
>> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
>> index d4813df92b9c..0fcb7f9ba6a9 100644
>> --- a/drivers/hv/mshv.h
>> +++ b/drivers/hv/mshv.h
>> @@ -14,14 +14,6 @@
>>   	memchr_inv(&((STRUCT).MEMBER), \
>>   		   0, sizeof_field(typeof(STRUCT), MEMBER))
>>
>> -int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
>> -			     union hv_input_vtl input_vtl,
>> -			     struct hv_register_assoc *registers);
>> -
>> -int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
>> -			     union hv_input_vtl input_vtl,
>> -			     struct hv_register_assoc *registers);
>> -
>>   int hv_call_get_partition_property(u64 partition_id, u64 property_code,
>>   				   u64 *property_value);
>>
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index 91517b45d526..c79d24317b8e 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -78,21 +78,6 @@ struct mshv_vtl {
>>   	u64 id;
>>   };
>>
>> -struct mshv_vtl_per_cpu {
>> -	struct mshv_vtl_run *run;
>> -	struct page *reg_page;
>> -};
>> -
>> -/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
>> -union hv_synic_overlay_page_msr {
>> -	u64 as_uint64;
>> -	struct {
>> -		u64 enabled: 1;
>> -		u64 reserved: 11;
>> -		u64 pfn: 52;
>> -	} __packed;
>> -};
>> -
>>   static struct mutex mshv_vtl_poll_file_lock;
>>   static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>>   static union hv_register_vsm_capabilities mshv_vsm_capabilities;
>> @@ -201,34 +186,6 @@ static struct page *mshv_vtl_cpu_reg_page(int cpu)
>>   	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
>>   }
>>
>> -static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
>> -{
>> -	struct hv_register_assoc reg_assoc = {};
>> -	union hv_synic_overlay_page_msr overlay = {};
>> -	struct page *reg_page;
>> -
>> -	reg_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
>> -	if (!reg_page) {
>> -		WARN(1, "failed to allocate register page\n");
>> -		return;
>> -	}
>> -
>> -	overlay.enabled = 1;
>> -	overlay.pfn = page_to_hvpfn(reg_page);
>> -	reg_assoc.name = HV_X64_REGISTER_REG_PAGE;
>> -	reg_assoc.value.reg64 = overlay.as_uint64;
>> -
>> -	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>> -				     1, input_vtl_zero, &reg_assoc)) {
>> -		WARN(1, "failed to setup register page\n");
>> -		__free_page(reg_page);
>> -		return;
>> -	}
>> -
>> -	per_cpu->reg_page = reg_page;
>> -	mshv_has_reg_page = true;
>> -}
>> -
>>   static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>>   {
>>   	union hv_synic_sint sint;
>> @@ -329,8 +286,10 @@ static int mshv_vtl_alloc_context(unsigned int cpu)
>>   	if (!per_cpu->run)
>>   		return -ENOMEM;
>>
>> -	if (mshv_vsm_capabilities.intercept_page_available)
>> -		mshv_vtl_configure_reg_page(per_cpu);
>> +	if (mshv_vsm_capabilities.intercept_page_available) {
>> +		if (hv_vtl_configure_reg_page(per_cpu))
>> +			mshv_has_reg_page = true;
> 
> As Sashiko AI noted, it doesn't work to use the global mshv_has_reg_page
> to indicate the success of configuring the reg page, which is a per-cpu
> operation. But this bug existed before this patch set, so maybe it should
> be fixed as a preliminary patch.

Acked. Will address them in a separate series.

> 
>> +	}
>>
>>   	mshv_vtl_synic_enable_regs(cpu);
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index b147a12085e4..b53fcc071596 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -383,8 +383,50 @@ static inline int hv_deposit_memory(u64 partition_id, u64 status)
>>   	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>>   }
>>
>> +#if IS_ENABLED(CONFIG_MSHV_ROOT) || IS_ENABLED(CONFIG_MSHV_VTL)
>> +int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
>> +			     union hv_input_vtl input_vtl,
>> +			     struct hv_register_assoc *registers);
>> +
>> +int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
>> +			     union hv_input_vtl input_vtl,
>> +			     struct hv_register_assoc *registers);
>> +#else
>> +static inline int hv_call_get_vp_registers(u32 vp_index, u64 partition_id,
>> +					   u16 count,
>> +					   union hv_input_vtl input_vtl,
>> +					   struct hv_register_assoc *registers)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int hv_call_set_vp_registers(u32 vp_index, u64 partition_id,
>> +					   u16 count,
>> +					   union hv_input_vtl input_vtl,
>> +					   struct hv_register_assoc *registers)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
>> +
>>   #define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
>> +
>>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>> +struct mshv_vtl_per_cpu {
>> +	struct mshv_vtl_run *run;
>> +	struct page *reg_page;
>> +};
>> +
>> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
>> +union hv_synic_overlay_page_msr {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enabled: 1;
>> +		u64 reserved: 11;
>> +		u64 pfn: 52;
>> +	} __packed;
>> +};
>> +
>>   u8 __init get_vtl(void);
>>   #else
>>   static inline u8 get_vtl(void) { return 0; }
>> --
>> 2.43.0
>>
> 
> Sashiko AI noted another existing bug in mshv_vtl_init(), which is that
> the error path does kfree(mem_dev) when it should do
> put_device(mem_dev).  See the comment in the header of
> device_initialize().


To avoid this series bloating up, I am thinking of taking up these fixes 
in a separate series.

Regards,
Naman

