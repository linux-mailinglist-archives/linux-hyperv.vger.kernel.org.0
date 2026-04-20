Return-Path: <linux-hyperv+bounces-10217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFA7O3lR5mkDuwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10217-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:16:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C75B42F3FA
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76A953148257
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E582D23A6;
	Mon, 20 Apr 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cCuME6yL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DA29BD88;
	Mon, 20 Apr 2026 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698570; cv=none; b=jqPdHTS60kvY2EH5/v5VFQ5wjPNPsY6aZyATfvPG/mpQxpEYyCCd5RjW10iQW6E9wf7C6zneac1PFBESXsEsx5A3PBNzif07ujzwy8JqB/nNBDiObgi6SeThCaEqafAP16sF8czo0TykhtqqoNuBoRhs8kDgrOA4Tpk+p08uCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698570; c=relaxed/simple;
	bh=7QN7pYVAaRnXCmyc2QtJTDw0jlPkRfSJWrfhJVxZbF0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GWjbYVKjFfaOhZG67H2Fn9+wweiW20WIOFJgrL3WV19RYoRwCHFl4qoHfYwBuxRj+B3OnEB28v8f+6iKs25tFscvSroSfrZuOF5xVMPqfiJh3kAkB51ITPs+yc4FEEHDO6I6NoLdCnT7aIrs6VLE5cJCTR1Z8Qp8j9tP2wH3Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cCuME6yL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.139] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88EB520B6F01;
	Mon, 20 Apr 2026 08:22:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88EB520B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776698564;
	bh=VR3kJETX6nmgkkseadQYtalJTtCNcqmr/GPBJqM06wM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=cCuME6yLKCY5ltAzA8+02aM+2qcQFd18QOMZFAGKkEP+hlMcjOcNQ5Hml+Mf17ahI
	 L1aNUNK1G+bl4/mGQ6IjcaDQKQoIYVSnIa1w/bpU9gxP0o6mZ4Ggz1D5IjpZOasWnX
	 vUCaK55I6M5yv0ZzPjS/cNCDTRGXcpyV1ZNnixXo=
Message-ID: <05b48f08-3096-40d1-9408-39f5a9e6a4df@linux.microsoft.com>
Date: Mon, 20 Apr 2026 20:52:24 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH 02/11] Drivers: hv: Move hv_vp_assist_page to common files
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
 <20260316121241.910764-3-namjain@linux.microsoft.com>
 <SN6PR02MB415790977DA40BAD0822DA54D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB415790977DA40BAD0822DA54D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10217-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 6C75B42F3FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:25 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> Move the logic to initialize and export hv_vp_assist_page from x86
>> architecture code to Hyper-V common code to allow it to be used for
>> upcoming arm64 support in MSHV_VTL driver.
>> Note: This change also improves error handling - if VP assist page
>> allocation fails, hyperv_init() now returns early instead of
>> continuing with partial initialization.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_init.c      | 88 +---------------------------------
>>   drivers/hv/hv_common.c         | 88 ++++++++++++++++++++++++++++++++++
>>   include/asm-generic/mshyperv.h |  4 ++
>>   include/hyperv/hvgdk_mini.h    |  2 +
>>   4 files changed, 95 insertions(+), 87 deletions(-)
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
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 6b67ac616789..d1ebc0ebd08f 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -28,7 +28,9 @@
>>   #include <linux/slab.h>
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/set_memory.h>
>> +#include <linux/vmalloc.h>
>>   #include <hyperv/hvhdk.h>
>> +#include <hyperv/hvgdk.h>
>>   #include <asm/mshyperv.h>
> 
> Need to add
> 
> #include <linux/io.h>
> 
> because of the memremap() and related calls that have been added.
> io.h is probably being #include'd indirectly, but it is better to #include
> it directly.
> 

Acked.

>>
>>   u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>> @@ -78,6 +80,8 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>>   u8 * __percpu *hv_synic_eventring_tail;
>>   EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>>
>> +struct hv_vp_assist_page **hv_vp_assist_page;
>> +EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>>   /*
>>    * Hyper-V specific initialization and shutdown code that is
>>    * common across all architectures.  Called from architecture
>> @@ -92,6 +96,9 @@ void __init hv_common_free(void)
>>   	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>>   		hv_kmsg_dump_unregister();
>>
>> +	kfree(hv_vp_assist_page);
>> +	hv_vp_assist_page = NULL;
>> +
>>   	kfree(hv_vp_index);
>>   	hv_vp_index = NULL;
>>
>> @@ -394,6 +401,23 @@ int __init hv_common_init(void)
>>   	for (i = 0; i < nr_cpu_ids; i++)
>>   		hv_vp_index[i] = VP_INVAL;
>>
>> +	/*
>> +	 * The VP assist page is useless to a TDX guest: the only use we
>> +	 * would have for it is lazy EOI, which can not be used with TDX.
>> +	 */
>> +	if (hv_isolation_type_tdx()) {
>> +		hv_vp_assist_page = NULL;
>> +	} else {
>> +		hv_vp_assist_page = kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
>> +		if (!hv_vp_assist_page) {
>> +#ifdef CONFIG_X86_64
>> +			ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
>> +#endif
>> +			hv_common_free();
>> +			return -ENOMEM;
> 
> Given that "failure to allocate memory" now returns an error that is
> essentially fatal to hyperv_init(), is it still necessary to clear the flag in
> ms_hyperv.hints?  I'd love to see that #ifdef go away. It's the only
> #ifdef in hv_common.c, and I had worked hard in the past to avoid
> such #ifdef's. :-)

Yes, this particular block can be removed, and I will remove it in v2.
The other thing pointed out in Sashiko's AI review was having this 
if-def block in tdx case after setting hv_vp_assist_page to NULL. This 
is to maintain parity with existing code. That's the reason, I will need 
to add it back there.

> 
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -471,6 +495,8 @@ void __init ms_hyperv_late_init(void)
>>
>>   int hv_common_cpu_init(unsigned int cpu)
>>   {
>> +	union hv_vp_assist_msr_contents msr = { 0 };
>> +	struct hv_vp_assist_page **hvp;
>>   	void **inputarg, **outputarg;
>>   	u8 **synic_eventring_tail;
>>   	u64 msr_vp_index;
>> @@ -542,6 +568,50 @@ int hv_common_cpu_init(unsigned int cpu)
>>   			ret = -ENOMEM;
> 
> The Sashiko AI comment here about a bug when ret is set to -ENOMEM
> seems valid to me.
> 

I'm planning to simply "return -ENOMEM" here.

>>   	}
>>
>> +	if (!hv_vp_assist_page)
>> +		return ret;
>> +
>> +	hvp = &hv_vp_assist_page[cpu];
>> +	if (hv_root_partition()) {
>> +		/*
>> +		 * For root partition we get the hypervisor provided VP assist
>> +		 * page, instead of allocating a new page.
>> +		 */
>> +		msr.as_uint64 = hv_get_msr(HV_SYN_REG_VP_ASSIST_PAGE);
>> +		*hvp = memremap(msr.pfn << HV_VP_ASSIST_PAGE_ADDRESS_SHIFT,
>> +				PAGE_SIZE, MEMREMAP_WB);
> 
> The Sashiko AI comment about potentially memremap'ing 64K instead of 4K can
> be ignored. We know that the root partition can only run with a 4K page size,
> and that is enforced in drivers/hv/Kconfig.
>

I am thinking of adding this config dependency (PAGE_SIZE_4KB) in the 
Kconfig patch in this series, to MSHV_VTL as well. We are also using 
only 4KB as page size. This should prevent all of PAGE_SIZE Sachiko 
issues. I am also replacing PAGE_SIZE with HV_HYP_PAGE_SIZE in all 
places. Hope that is fine?

> HV_VP_ASSIST_PAGE_ADDRESS_SHIFT is defined in asm-generic/mshyperv.h.
> But there is also HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT in hvgdk_mini.h.
> Is there a clean way to eliminate the duplication?

Although both these architectures are using same value - 12, I was 
hesitant to use x64 register for ARM64. I will move arch based 
definition of HV_VP_ASSIST_PAGE_ADDRESS_SHIFT to hvgdk_mini.h and remove 
it from asm-generic/mshyperv.h.

> 
>> +	} else {
>> +		/*
>> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
>> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
>> +		 * out to make sure we always write the EOI MSR in
>> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
>> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
>> +		 * case of CPU offlining and the VM will hang.
>> +		 */
> 
> Somewhere in the comment above, I'd suggest adding a short "on x86/x64"
> qualifier, as the comment doesn't apply on arm64 since it doesn't support
> the AutoEOI optimization.  Maybe "Here it must be zeroed out to make sure
> that on x86/x64 we always write the EOI MSR in ....".

Acked. I will add it.

> 
>> +		if (!*hvp) {
>> +			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> 
> The Sashiko AI comment about using "flags" instead of GFP_KERNEL seems valid.

Acked.

> 
>> +
>> +			/*
>> +			 * Hyper-V should never specify a VM that is a Confidential
>> +			 * VM and also running in the root partition. Root partition
>> +			 * is blocked to run in Confidential VM. So only decrypt assist
>> +			 * page in non-root partition here.
>> +			 */
>> +			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
>> +				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>> +				memset(*hvp, 0, PAGE_SIZE);
>> +			}
>> +		}
>> +
>> +		if (*hvp)
>> +			msr.pfn = vmalloc_to_pfn(*hvp);
> 
> The Sashiko AI comment about page size here seems valid. But what are the rules
> about arm64 page sizes that are supported for VTL2, and how does they relate
> to VTL0 allowing 4K, 16K, and 64K page size? What combinations are allowed?
> For example, can a VTL2 built with 4K page size run with a VTL0 built with
> 64K page size? It would be nice to have the rules recorded somewhere in a
> code comment, but I'm not sure of the best place.
> 

VTL2 uses 4k page size only. This can be enforced with a Kconfig change 
in next version. As and when other page size support is added in ARM64 
for MSHV_VTL, this change can be removed.

Regarding support of VTL0 kernel page sizes, page size in VTL2 is of no 
impact to it.


> But regardless of the rules, I'd suggest future-proofing by using
> "page_to_hvpfn(vmalloc_to_page(*hvp))" so that the PFN generated is always
> in terms of 4K page size as the Hyper-V host expects.

Acked. Will try this and make the changes.

> 
>> +	}
>> +	if (!WARN_ON(!(*hvp))) {
>> +		msr.enable = 1;
>> +		hv_set_msr(HV_SYN_REG_VP_ASSIST_PAGE, msr.as_uint64);
>> +	}
>> +
>>   	return ret;
>>   }
>>
>> @@ -566,6 +636,24 @@ int hv_common_cpu_die(unsigned int cpu)
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
>> +			msr.as_uint64 = hv_get_msr(HV_SYN_REG_VP_ASSIST_PAGE);
>> +			msr.enable = 0;
>> +		}
>> +		hv_set_msr(HV_SYN_REG_VP_ASSIST_PAGE, msr.as_uint64);
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index d37b68238c97..108f135d4fd9 100644
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
>> @@ -299,6 +300,8 @@ do { \
>>   #define hv_status_debug(status, fmt, ...) \
>>   	hv_status_printk(debug, status, fmt, ##__VA_ARGS__)
>>
>> +extern struct hv_vp_assist_page **hv_vp_assist_page;
> 
> This "extern" statement is added here so it is visible to both x86/x64 and arm64.
> And that's correct.
> 
> But there is still some VP assist page stuff that has been left in the arch/x86
> version of mshyperv.h.  That other stuff, including the inline function
> hv_get_vp_assist_page(), should also be moved to asm-generic/mshyperv.h.
> Given that the VP assist page support is now fully generic and not x86/x64
> specific, it shouldn't occur anywhere in the arch/x86 version of mshyperv.h.

Will move the remaining code.

> 
>> +
>>   const char *hv_result_to_string(u64 hv_status);
>>   int hv_result_to_errno(u64 status);
>>   void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>> @@ -377,6 +380,7 @@ static inline int hv_deposit_memory(u64 partition_id, u64 status)
>>   	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>>   }
>>
>> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
>>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>   u8 __init get_vtl(void);
>>   #else
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 056ef7b6b360..be697ddb211a 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -149,6 +149,7 @@ struct hv_u128 {
>>   #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
>>   #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
>>   		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
>> +#define HV_SYN_REG_VP_ASSIST_PAGE              (HV_X64_MSR_VP_ASSIST_PAGE)
>>
>>   /* Hyper-V Enlightened VMCS version mask in nested features CPUID */
>>   #define HV_X64_ENLIGHTENED_VMCS_VERSION		0xff
>> @@ -1185,6 +1186,7 @@ enum hv_register_name {
>>
>>   #define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
>>   #define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
>> +#define HV_SYN_REG_VP_ASSIST_PAGE    (HV_REGISTER_VP_ASSIST_PAGE)
> 
> This defines a new register name prefix "HV_SYN_REG_" that isn't used
> anywhere else. The prefixes for Hyper-V register names are already complex
> to account to x86/x64 and arm64 differences, and the fact the x86/x64 has
> synthetic MSRs, while arm64 does not. So introducing another prefix is
> undesirable. Couldn't this just be HV_MSR_VP_ASSIST_PAGE using the
> same structure as HV_MSR_STIMER0_COUNT (for example)?
>

Will rename it to HV_MSR_VP_ASSIST_PAGE in all places.

>>
>>   #endif /* CONFIG_ARM64 */
>>
>> --
>> 2.43.0
>>


Thank you so much for thoroughly reviwing this Michael.

Regards,
Naman

