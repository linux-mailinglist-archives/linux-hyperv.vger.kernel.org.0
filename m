Return-Path: <linux-hyperv+bounces-10460-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGgsH5jW8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10460-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:59:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9B49279D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE4430C12CA
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A03C1973;
	Wed, 29 Apr 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E05q9a42"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8E3C063B;
	Wed, 29 Apr 2026 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456520; cv=none; b=Mx0K0ZLhDOmCJ8idqzQO3sy+nNwoLspIgFBtE6TfM2oV5ktK0nNTDxFn7Ov6QKENlPTI+FrxOXiBqFtfLsFkw77ZOqmVR1BGqhpWJ8CjdxxkHmVtuoV7lIzu0+T85f5kl40gQaltCa6bmvlGp8/nP3raPSceC9VwHuUpV3uHPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456520; c=relaxed/simple;
	bh=e2iU8tsVRtHKEbKnXfsa1M6VKEiOaYh54i4Hs8Qi+r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9upei89EYXZ2RpxeRZ/SGNRGU/RZRQCwjN5kgbwNMrTG79eg4a1Vs8u7Hr0wGtuvZsRWkxpGfZQDKRmJtrOZKUfb6YlcVdQb0df+accUi70nk0q9k8zUA7WBiZ78CXk09CYsaFs6gjK5LejCm3MylOlyGpQluSFrrM4cUfiL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E05q9a42; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F23720B716C;
	Wed, 29 Apr 2026 02:55:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F23720B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456514;
	bh=iLG5Xdzg5UMWeGId8TT8BIKIR6ihO3btgl5r+mmYztY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E05q9a42/LyIAQVrLn1ZujBoyIrLBtA0Dsi5O0BcMjj74yvtObGzz6jRdHIwHYdvs
	 X+1N28PIKVapL5OsFaly+I7NY/OkqaSSPMg2XLyNbg/zs+rJbX2iL7RGGQK+NpvU0l
	 EfkTepa71AsDZ+AT2tWhep4vOOEOvbRuSEVWEqts=
Message-ID: <f8a15328-b084-4d5f-a089-57fcf743afbf@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:25:03 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] Drivers: hv: Move hv_vp_assist_page to common
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
 <20260423124206.2410879-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157BEAF5480D931C3756B7DD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157BEAF5480D931C3756B7DD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7D9B49279D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10460-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]



On 4/27/2026 11:07 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> Move the logic to initialize and export hv_vp_assist_page from x86
>> architecture code to Hyper-V common code to allow it to be used for
>> upcoming arm64 support in MSHV_VTL driver.
>> Note: This change also improves error handling - if VP assist page
>> allocation fails, hyperv_init() now returns early instead of
>> continuing with partial initialization.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <vdso@mailbox.org>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c       | 88 +-----------------------------
>>   arch/x86/include/asm/mshyperv.h | 14 -----
>>   drivers/hv/hv_common.c          | 94 ++++++++++++++++++++++++++++++++-
>>   include/asm-generic/mshyperv.h  | 16 ++++++
>>   include/hyperv/hvgdk_mini.h     |  6 ++-
>>   5 files changed, 115 insertions(+), 103 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 323adc93f2dc..75a98b5e451b 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -81,9 +81,6 @@ union hv_ghcb * __percpu *hv_ghcb_pg;
>>   /* Storage to save the hypercall page temporarily for hibernation */
>>   static void *hv_hypercall_pg_saved;
>>
>> -struct hv_vp_assist_page **hv_vp_assist_page;
>> -EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>> -
>>   static int hyperv_init_ghcb(void)
>>   {
>>   	u64 ghcb_gpa;
>> @@ -117,59 +114,12 @@ static int hyperv_init_ghcb(void)
>>
>>   static int hv_cpu_init(unsigned int cpu)
>>   {
>> -	union hv_vp_assist_msr_contents msr = { 0 };
>> -	struct hv_vp_assist_page **hvp;
>>   	int ret;
>>
>>   	ret = hv_common_cpu_init(cpu);
>>   	if (ret)
>>   		return ret;
>>
>> -	if (!hv_vp_assist_page)
>> -		return 0;
>> -
>> -	hvp = &hv_vp_assist_page[cpu];
>> -	if (hv_root_partition()) {
>> -		/*
>> -		 * For root partition we get the hypervisor provided VP assist
>> -		 * page, instead of allocating a new page.
>> -		 */
>> -		rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -		*hvp = memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> -				PAGE_SIZE, MEMREMAP_WB);
>> -	} else {
>> -		/*
>> -		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
>> -		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> -		 * out to make sure we always write the EOI MSR in
>> -		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
>> -		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> -		 * case of CPU offlining and the VM will hang.
>> -		 */
>> -		if (!*hvp) {
>> -			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>> -
>> -			/*
>> -			 * Hyper-V should never specify a VM that is a Confidential
>> -			 * VM and also running in the root partition. Root partition
>> -			 * is blocked to run in Confidential VM. So only decrypt assist
>> -			 * page in non-root partition here.
>> -			 */
>> -			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
>> -				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>> -				memset(*hvp, 0, PAGE_SIZE);
>> -			}
>> -		}
>> -
>> -		if (*hvp)
>> -			msr.pfn = vmalloc_to_pfn(*hvp);
>> -
>> -	}
>> -	if (!WARN_ON(!(*hvp))) {
>> -		msr.enable = 1;
>> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -	}
>> -
>>   	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
>>   	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
>>   		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
>> @@ -286,23 +236,6 @@ static int hv_cpu_die(unsigned int cpu)
>>
>>   	hv_common_cpu_die(cpu);
>>
>> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>> -		union hv_vp_assist_msr_contents msr = { 0 };
>> -		if (hv_root_partition()) {
>> -			/*
>> -			 * For root partition the VP assist page is mapped to
>> -			 * hypervisor provided page, and thus we unmap the
>> -			 * page here and nullify it, so that in future we have
>> -			 * correct page address mapped in hv_cpu_init.
>> -			 */
>> -			memunmap(hv_vp_assist_page[cpu]);
>> -			hv_vp_assist_page[cpu] = NULL;
>> -			rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -			msr.enable = 0;
>> -		}
>> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> -	}
>> -
>>   	if (hv_reenlightenment_cb == NULL)
>>   		return 0;
>>
>> @@ -460,21 +393,6 @@ void __init hyperv_init(void)
>>   	if (hv_common_init())
>>   		return;
>>
>> -	/*
>> -	 * The VP assist page is useless to a TDX guest: the only use we
>> -	 * would have for it is lazy EOI, which can not be used with TDX.
>> -	 */
>> -	if (hv_isolation_type_tdx())
>> -		hv_vp_assist_page = NULL;
>> -	else
>> -		hv_vp_assist_page = kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
>> -	if (!hv_vp_assist_page) {
>> -		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> -
>> -		if (!hv_isolation_type_tdx())
>> -			goto common_free;
>> -	}
>> -
>>   	if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
>>   		/* Negotiate GHCB Version. */
>>   		if (!hv_ghcb_negotiate_protocol())
>> @@ -483,7 +401,7 @@ void __init hyperv_init(void)
>>
>>   		hv_ghcb_pg = alloc_percpu(union hv_ghcb *);
>>   		if (!hv_ghcb_pg)
>> -			goto free_vp_assist_page;
>> +			goto free_ghcb_page;
> 
> Seems like this should be "goto common_free". The allocation of
> hv_ghcb_pg has failed, so going to a label where hv_ghcb_pg is
> freed seems redundant. It works since free_percpu() checks for
> a NULL argument, but it's a bit unexpected since the common_free
> label is already there.

Thanks for catching this, I'll fix it.


> 
>>   	}
>>
>>   	cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
>> @@ -613,10 +531,6 @@ void __init hyperv_init(void)
>>   	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>>   free_ghcb_page:
>>   	free_percpu(hv_ghcb_pg);
>> -free_vp_assist_page:
>> -	kfree(hv_vp_assist_page);
>> -	hv_vp_assist_page = NULL;
>> -common_free:
>>   	hv_common_free();
>>   }
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index f64393e853ee..95b452387969 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -155,16 +155,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>>   	return _hv_do_fast_hypercall16(control, input1, input2);
>>   }
>>
>> -extern struct hv_vp_assist_page **hv_vp_assist_page;
>> -
>> -static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> -{
>> -	if (!hv_vp_assist_page)
>> -		return NULL;
>> -
>> -	return hv_vp_assist_page[cpu];
>> -}
>> -
>>   void __init hyperv_init(void);
>>   void hyperv_setup_mmu_ops(void);
>>   void set_hv_tscchange_cb(void (*cb)(void));
>> @@ -254,10 +244,6 @@ static inline void hyperv_setup_mmu_ops(void) {}
>>   static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>>   static inline void clear_hv_tscchange_cb(void) {}
>>   static inline void hyperv_stop_tsc_emulation(void) {};
>> -static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> -{
>> -	return NULL;
>> -}
>>   static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
>>   static inline int hyperv_flush_guest_mapping_range(u64 as,
>>   		hyperv_fill_flush_list_func fill_func, void *data)
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 6b67ac616789..e8633bc51d56 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -28,7 +28,11 @@
>>   #include <linux/slab.h>
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/set_memory.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/io.h>
>> +#include <linux/hyperv.h>
>>   #include <hyperv/hvhdk.h>
>> +#include <hyperv/hvgdk.h>
>>   #include <asm/mshyperv.h>
>>
>>   u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>> @@ -78,6 +82,8 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>>   u8 * __percpu *hv_synic_eventring_tail;
>>   EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>>
>> +struct hv_vp_assist_page **hv_vp_assist_page;
>> +EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>>   /*
>>    * Hyper-V specific initialization and shutdown code that is
>>    * common across all architectures.  Called from architecture
>> @@ -92,6 +98,9 @@ void __init hv_common_free(void)
>>   	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>>   		hv_kmsg_dump_unregister();
>>
>> +	kfree(hv_vp_assist_page);
>> +	hv_vp_assist_page = NULL;
>> +
>>   	kfree(hv_vp_index);
>>   	hv_vp_index = NULL;
>>
>> @@ -394,6 +403,23 @@ int __init hv_common_init(void)
>>   	for (i = 0; i < nr_cpu_ids; i++)
>>   		hv_vp_index[i] = VP_INVAL;
>>
>> +	/*
>> +	 * The VP assist page is useless to a TDX guest: the only use we
>> +	 * would have for it is lazy EOI, which can not be used with TDX.
>> +	 */
>> +	if (hv_isolation_type_tdx()) {
>> +		hv_vp_assist_page = NULL;
>> +#ifdef CONFIG_X86_64
>> +		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> +#endif
> 
> I realize that this #ifdef went away for the reason I flagged in v1 of
> this patch set, but it's back again for a different reason.
> 
> Let me suggest another approach. hv_common_init() is called from
> both the x86/64 and arm64 hyperv_init() functions. Immediately after
> the call to hv_common_init() in the x86/64 hyperv_init(), test
> hv_vp_assist_page for NULL and clear
> HV_X64_ENLIGHTENED_VMCS_RECOMMENDED if it is. No #ifdef is
> needed, and x86/64 specific hackery stays under arch/x86 instead of
> being in common code.

Acked. Thanks.

> 
>> +	} else {
>> +		hv_vp_assist_page = kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
>> +		if (!hv_vp_assist_page) {
>> +			hv_common_free();
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -471,6 +497,8 @@ void __init ms_hyperv_late_init(void)
>>
>>   int hv_common_cpu_init(unsigned int cpu)
>>   {
>> +	union hv_vp_assist_msr_contents msr = { 0 };
>> +	struct hv_vp_assist_page **hvp;
>>   	void **inputarg, **outputarg;
>>   	u8 **synic_eventring_tail;
>>   	u64 msr_vp_index;
>> @@ -539,7 +567,53 @@ int hv_common_cpu_init(unsigned int cpu)
>>   						sizeof(u8), flags);
>>   		/* No need to unwind any of the above on failure here */
>>   		if (unlikely(!*synic_eventring_tail))
>> -			ret = -ENOMEM;
>> +			return -ENOMEM;
>> +	}
>> +
>> +	if (!hv_vp_assist_page)
>> +		return ret;
>> +
>> +	hvp = &hv_vp_assist_page[cpu];
>> +	if (hv_root_partition()) {
>> +		/*
>> +		 * For root partition we get the hypervisor provided VP assist
>> +		 * page, instead of allocating a new page.
>> +		 */
>> +		msr.as_uint64 = hv_get_msr(HV_MSR_VP_ASSIST_PAGE);
>> +		*hvp = memremap(msr.pfn << HV_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> +				HV_HYP_PAGE_SIZE, MEMREMAP_WB);
>> +	} else {
>> +		/*
>> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
>> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> +		 * out to make sure that on x86/x64, we always write the EOI MSR in
>> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
>> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> +		 * case of CPU offlining and the VM will hang.
>> +		 */
>> +		if (!*hvp) {
>> +			*hvp = __vmalloc(HV_HYP_PAGE_SIZE, flags | __GFP_ZERO);
>> +
>> +			/*
>> +			 * Hyper-V should never specify a VM that is a Confidential
>> +			 * VM and also running in the root partition. Root partition
>> +			 * is blocked to run in Confidential VM. So only decrypt assist
>> +			 * page in non-root partition here.
>> +			 */
>> +			if (*hvp &&
>> +			    !ms_hyperv.paravisor_present &&
>> +			    hv_isolation_type_snp()) {
>> +				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>> +				memset(*hvp, 0, HV_HYP_PAGE_SIZE);
>> +			}
>> +		}
>> +
>> +		if (*hvp)
>> +			msr.pfn = page_to_hvpfn(vmalloc_to_page(*hvp));
> 
> Your Patch 0 changelog mentions adding a comment about vmalloc_to_pfn(), which
> I didn't see anywhere. I'm not sure what that comment would say, so maybe it
> became unnecessary.

I think I mixed up two things. Changelog was about your suggestion to 
add "x86/x64" in above comment about GPA Overlay Pages.
I also changed this function to page_to_hvpfn(vmalloc_to_page(*hvp)) as 
per your suggestion.
Apologies for the confusion.

> 
>> +	}
>> +	if (!WARN_ON(!(*hvp))) {
>> +		msr.enable = 1;
>> +		hv_set_msr(HV_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>>   	}
>>
>>   	return ret;
>> @@ -566,6 +640,24 @@ int hv_common_cpu_die(unsigned int cpu)
>>   		*synic_eventring_tail = NULL;
>>   	}
>>
>> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>> +		union hv_vp_assist_msr_contents msr = { 0 };
>> +
>> +		if (hv_root_partition()) {
>> +			/*
>> +			 * For root partition the VP assist page is mapped to
>> +			 * hypervisor provided page, and thus we unmap the
>> +			 * page here and nullify it, so that in future we have
>> +			 * correct page address mapped in hv_cpu_init.
>> +			 */
>> +			memunmap(hv_vp_assist_page[cpu]);
>> +			hv_vp_assist_page[cpu] = NULL;
>> +			msr.as_uint64 = hv_get_msr(HV_MSR_VP_ASSIST_PAGE);
>> +			msr.enable = 0;
>> +		}
>> +		hv_set_msr(HV_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index d37b68238c97..2810aa05dc73 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -25,6 +25,7 @@
>>   #include <linux/nmi.h>
>>   #include <asm/ptrace.h>
>>   #include <hyperv/hvhdk.h>
>> +#include <hyperv/hvgdk.h>
>>
>>   #define VTPM_BASE_ADDRESS 0xfed40000
>>
>> @@ -299,6 +300,16 @@ do { \
>>   #define hv_status_debug(status, fmt, ...) \
>>   	hv_status_printk(debug, status, fmt, ##__VA_ARGS__)
>>
>> +extern struct hv_vp_assist_page **hv_vp_assist_page;
>> +
>> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> +{
>> +	if (!hv_vp_assist_page)
>> +		return NULL;
>> +
>> +	return hv_vp_assist_page[cpu];
>> +}
>> +
>>   const char *hv_result_to_string(u64 hv_status);
>>   int hv_result_to_errno(u64 status);
>>   void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>> @@ -327,6 +338,11 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
>>   {
>>   	return HV_ISOLATION_TYPE_NONE;
>>   }
>> +
>> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> +{
>> +	return NULL;
>> +}
>>   #endif /* CONFIG_HYPERV */
>>
>>   #if IS_ENABLED(CONFIG_MSHV_ROOT)
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 056ef7b6b360..c72d04cd5ae4 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -149,6 +149,7 @@ struct hv_u128 {
>>   #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
> 
> Can this X64 specific definition of the shift be eliminated entirely,
> and a single common definition for x86/64 and arm64 be used?
> As I understand it, the MSR layout is the same on both architectures.
> The one gotcha is that kvm_hv_set_msr() would need to be updated.
> 
> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK defined below isn't
> used anywhere, so it could go away too.  (The KVM selftest usage has
> its own definition.)
> 
> I realize these are changes to a source code file that is derived from
> Windows, and I'm not sure of the guidelines for such changes. So maybe
> these suggestions have to be ignored ....

The VP assist page definition is common to both x86 and arm64, so the 
address mask and shift can be shared. Also, I don't see the shift and 
mask definitions in the Hyper-V header so seem to be specific to in 
kernel usage.

> 
>>   #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
>>   		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
>> +#define HV_MSR_VP_ASSIST_PAGE              (HV_X64_MSR_VP_ASSIST_PAGE)
> 
> This is the correct file for this #define, but it should be placed down around
> line 1148 or so with the other HV_MSR_* definitions in terms of HV_X64_MSR_*
> 

Acked.

>>
>>   /* Hyper-V Enlightened VMCS version mask in nested features CPUID */
>>   #define HV_X64_ENLIGHTENED_VMCS_VERSION		0xff
>> @@ -410,6 +411,7 @@ union hv_x64_msr_hypercall_contents {
>>   #if defined(CONFIG_ARM64)
>>   #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
>>   #define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
>> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT 12
>>   #endif /* CONFIG_ARM64 */
>>
>>   #if defined(CONFIG_X86)
>> @@ -1163,6 +1165,8 @@ enum hv_register_name {
>>   #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
>>   #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>>
>> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT
>> +
>>   #elif defined(CONFIG_ARM64) /* CONFIG_X86 */
>>
>>   #define HV_MSR_CRASH_P0		(HV_REGISTER_GUEST_CRASH_P0)
>> @@ -1185,7 +1189,7 @@ enum hv_register_name {
>>
>>   #define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
>>   #define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
>> -
>> +#define HV_MSR_VP_ASSIST_PAGE    (HV_REGISTER_VP_ASSIST_PAGE)
> 
> Nit: This definition is slightly mis-aligned. It has spaces where there
> should be a tab to match the similar definitions above it.
> 

Acked.

>>   #endif /* CONFIG_ARM64 */
>>
>>   union hv_explicit_suspend_register {
>> --
>> 2.43.0
>>

Regards,
Naman


