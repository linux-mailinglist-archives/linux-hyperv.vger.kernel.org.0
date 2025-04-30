Return-Path: <linux-hyperv+bounces-5252-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19EAA4FFB
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CFB9E165E
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598781C5F10;
	Wed, 30 Apr 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y2Y7v2S4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E417C21B;
	Wed, 30 Apr 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026332; cv=none; b=ndQ8OxBUcCGuEt1TPW7TlikcwdEHsLZCt2HoIiPLittCqIDdIwlEaYYNquSr+7AUlDPo5MmPJFH2aztP02QDu/IgiDXzTew8oPgaLaj5d2zFE8iYHc2wNu7NrYy+nej9a17TYM+bo7XwACmoh1MGEhWr8VJgHy7GIvzDAp90+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026332; c=relaxed/simple;
	bh=nrJiV7sgfoqobeFu2c5QT8+ttTCIBuCCcpHrEeGwo98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Anz/wAqsNAYeQRtR4nTyJyv6ezbY8Hi9BzAat6V+u9znih1n0Ox8lLbbZDUaqW+1ncPoih3Ki56Tgl90QDE+o5PSHHGdiMOFSR/lKxnjxl8NRqVD2L1gZf0wYKVI9VpEW/M2RNWI7TasrDPlbK8va81c/6g8/HkJquFjf5x4Q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y2Y7v2S4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E4DF204E7EF;
	Wed, 30 Apr 2025 08:18:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E4DF204E7EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746026329;
	bh=HNltF6UYzDOWYGrDmfXEvIuEhL7RmRKUuY9prprlfqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y2Y7v2S4dbUqt5Tno4WLb/AcCl187l1X/VZsI+BqIF15l48W8h47S6zHSbYD0Sykb
	 8bnhOaxe17uN8KUakzxE1JoTBSdVSdwlGHZyS8kdxvKH20fsY/EP/KrzZSW0MojZ8F
	 FGdIf2HSW21QydaGLmEILertBGDA6/HNMhVGk5h8=
Message-ID: <5b74ac52-c5fb-4182-8bc7-df65092fb9d4@linux.microsoft.com>
Date: Wed, 30 Apr 2025 08:18:49 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next] arch/x86: Provide the CPU number in the
 wakeup AP callback
To: Michael Kelley <mhklinux@outlook.com>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "dimitri.sivanich@hpe.com" <dimitri.sivanich@hpe.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "imran.f.khan@oracle.com" <imran.f.khan@oracle.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "justin.ernst@hpe.com" <justin.ernst@hpe.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "kyle.meyer@hpe.com" <kyle.meyer@hpe.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "nikunj@amd.com" <nikunj@amd.com>, "papaluri@amd.com" <papaluri@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "russ.anderson@hpe.com" <russ.anderson@hpe.com>,
 "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "xin@zytor.com" <xin@zytor.com>,
 "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20250428225948.810147-1-romank@linux.microsoft.com>
 <SN6PR02MB4157D83C50EC47D816DB9574D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D83C50EC47D816DB9574D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 9:05 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 28, 2025 4:00 PM
>>
>> When starting APs, confidential guests and paravisor guests
>> need to know the CPU number, and the pattern of using the linear
>> search has emerged in several places. With N processors that leads
>> to the O(N^2) time complexity.
>>
>> Provide the CPU number in the AP wake up callback so that one can
>> get the CPU number in constant time.
> 
> This patch aligns with my original suggestion and brings the expected
> benefit in runtime and in code simplification. But to me, introducing
> struct wakeup_secondary_cpu_data seems a bit unnecessary. The
> secondary wakeup functions currently have two arguments, and
> increasing that to three arguments is not problematic. I usually see
> structures introduced when the argument count gets into the 6 or
> more range, and there are multiple call layers that need those same
> arguments (such as the TLB flushing code, for example). In those
> cases, adding a structure makes sense.
> 
> But in this case, quite a few lines of code get added to define local
> variables and to pull values out of the structure and into those local
> variables, all of which would be avoided if the three arguments just
> remained as individual arguments. Adding a structure perhaps makes
> it easier to add a 4th argument should the need arise, but that seems
> unlikely and could be dealt with when and if it actually happened.
> 
> So I'd say drop the structure, and just pass "cpu" directly as a
> 3rd argument.

Yep, I designed that to be future-proof :D

I do agree with your take on that: likely too much for now, and it's too
early to invest in that. I'll drop the structure, thanks for the
discussion!

> 
> Michael
> 
>>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/coco/sev/core.c           | 18 ++++++++----------
>>   arch/x86/hyperv/hv_vtl.c           | 17 +++++++----------
>>   arch/x86/hyperv/ivm.c              |  8 +++++++-
>>   arch/x86/include/asm/apic.h        | 14 ++++++++++----
>>   arch/x86/include/asm/mshyperv.h    |  5 +++--
>>   arch/x86/kernel/acpi/madt_wakeup.c |  8 +++++++-
>>   arch/x86/kernel/apic/apic_noop.c   |  2 +-
>>   arch/x86/kernel/apic/x2apic_uv_x.c |  7 ++++++-
>>   arch/x86/kernel/smpboot.c          | 19 +++++++++++++++----
>>   9 files changed, 64 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 82492efc5d94..063f176854fd 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -1179,17 +1179,24 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>>   		free_page((unsigned long)vmsa);
>>   }
>>
>> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>> +static int wakeup_cpu_via_vmgexit(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>>   	struct sev_es_save_area *cur_vmsa, *vmsa;
>>   	struct ghcb_state state;
>> +	unsigned long start_ip;
>>   	struct svsm_ca *caa;
>>   	unsigned long flags;
>>   	struct ghcb *ghcb;
>>   	u8 sipi_vector;
>>   	int cpu, ret;
>> +	u32 apic_id;
>>   	u64 cr4;
>>
>> +
>> +	cpu = wakeup->cpu;
>> +	apic_id = wakeup->apicid;
>> +	start_ip = wakeup->start_ip;
>> +
>>   	/*
>>   	 * The hypervisor SNP feature support check has happened earlier, just check
>>   	 * the AP_CREATION one here.
>> @@ -1208,15 +1215,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>>
>>   	/* Override start_ip with known protected guest start IP */
>>   	start_ip = real_mode_header->sev_es_trampoline_start;
>> -
>> -	/* Find the logical CPU for the APIC ID */
>> -	for_each_present_cpu(cpu) {
>> -		if (arch_match_cpu_phys_id(cpu, apic_id))
>> -			break;
>> -	}
>> -	if (cpu >= nr_cpu_ids)
>> -		return -EINVAL;
>> -
>>   	cur_vmsa = per_cpu(sev_vmsa, cpu);
>>
>>   	/*
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 582fe820e29c..7ed3c639d612 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -237,17 +237,14 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>>   	return ret;
>>   }
>>
>> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>> +static int hv_vtl_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>> -	int vp_id, cpu;
>> +	unsigned long start_ip;
>> +	u32 apicid;
>> +	int vp_id;
>>
>> -	/* Find the logical CPU for the APIC ID */
>> -	for_each_present_cpu(cpu) {
>> -		if (arch_match_cpu_phys_id(cpu, apicid))
>> -			break;
>> -	}
>> -	if (cpu >= nr_cpu_ids)
>> -		return -EINVAL;
>> +	apicid = wakeup->apicid;
>> +	start_ip = wakeup->start_ip;
>>
>>   	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>>   	vp_id = hv_vtl_apicid_to_vp_id(apicid);
>> @@ -261,7 +258,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>>   		return -EINVAL;
>>   	}
>>
>> -	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
>> +	return hv_vtl_bringup_vcpu(vp_id, wakeup->cpu, start_ip);
>>   }
>>
>>   int __init hv_vtl_early_init(void)
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index c0039a90e9e0..6037cabc1ae0 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/types.h>
>>   #include <linux/slab.h>
>> +#include <asm/apic.h>
>>   #include <asm/svm.h>
>>   #include <asm/sev.h>
>>   #include <asm/io.h>
>> @@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>>   		free_page((unsigned long)vmsa);
>>   }
>>
>> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>> +int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>>   	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
>>   		__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> @@ -296,11 +297,16 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>>   	struct desc_ptr gdtr;
>>   	u64 ret, retry = 5;
>>   	struct hv_enable_vp_vtl *start_vp_input;
>> +	unsigned long start_ip;
>>   	unsigned long flags;
>> +	u32 cpu;
>>
>>   	if (!vmsa)
>>   		return -ENOMEM;
>>
>> +	cpu = wakeup->cpu;
>> +	start_ip = wakeup->apicid;
>> +
>>   	native_store_gdt(&gdtr);
>>
>>   	vmsa->gdtr.base = gdtr.address;
>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
>> index f21ff1932699..7e660125f749 100644
>> --- a/arch/x86/include/asm/apic.h
>> +++ b/arch/x86/include/asm/apic.h
>> @@ -262,6 +262,12 @@ extern void __init check_x2apic(void);
>>
>>   struct irq_data;
>>
>> +struct wakeup_secondary_cpu_data {
>> +	int cpu;
>> +	u32 apicid;
>> +	unsigned long start_ip;
>> +};
>> +
>>   /*
>>    * Copyright 2004 James Cleverdon, IBM.
>>    *
>> @@ -313,9 +319,9 @@ struct apic {
>>   	u32	(*get_apic_id)(u32 id);
>>
>>   	/* wakeup_secondary_cpu */
>> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
>> +	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
>>   	/* wakeup secondary CPU using 64-bit wakeup point */
>> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
>> +	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
>>
>>   	char	*name;
>>   };
>> @@ -333,8 +339,8 @@ struct apic_override {
>>   	void	(*send_IPI_self)(int vector);
>>   	u64	(*icr_read)(void);
>>   	void	(*icr_write)(u32 low, u32 high);
>> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
>> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
>> +	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
>> +	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
>>   };
>>
>>   /*
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 07aadf0e839f..62c64778ad01 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -6,6 +6,7 @@
>>   #include <linux/nmi.h>
>>   #include <linux/msi.h>
>>   #include <linux/io.h>
>> +#include <asm/apic.h>
>>   #include <asm/nospec-branch.h>
>>   #include <asm/paravirt.h>
>>   #include <hyperv/hvhdk.h>
>> @@ -268,11 +269,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
>> hv_interrupt_entry *entry);
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   bool hv_ghcb_negotiate_protocol(void);
>>   void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
>> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
>> +int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup);
>>   #else
>>   static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>>   static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
>> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
>> +static inline int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup) {
>> return 0; }
>>   #endif
>>
>>   #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
>> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c
>> b/arch/x86/kernel/acpi/madt_wakeup.c
>> index d5ef6215583b..5de1bd4e49ed 100644
>> --- a/arch/x86/kernel/acpi/madt_wakeup.c
>> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
>> @@ -169,8 +169,14 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>>   	return 0;
>>   }
>>
>> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>> +static int acpi_wakeup_cpu(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>> +	unsigned long start_ip;
>> +	u32 apicid;
>> +
>> +	start_ip = wakeup->start_ip;
>> +	apicid = wakeup->apicid;
>> +
>>   	if (!acpi_mp_wake_mailbox_paddr) {
>>   		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
>>   		return -EOPNOTSUPP;
>> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
>> index b5bb7a2e8340..dd4ba29042f9 100644
>> --- a/arch/x86/kernel/apic/apic_noop.c
>> +++ b/arch/x86/kernel/apic/apic_noop.c
>> @@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
>>   static void noop_send_IPI_all(int vector) { }
>>   static void noop_send_IPI_self(int vector) { }
>>   static void noop_apic_icr_write(u32 low, u32 id) { }
>> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
>> +static int noop_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data *data) { return -1; }
>>   static u64 noop_apic_icr_read(void) { return 0; }
>>   static u32 noop_get_apic_id(u32 apicid) { return 0; }
>>   static void noop_apic_eoi(void) { }
>> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
>> index 7fef504ca508..b76f865c31ef 100644
>> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
>> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
>> @@ -667,11 +667,16 @@ static __init void build_uv_gr_table(void)
>>   	}
>>   }
>>
>> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
>> +static int uv_wakeup_secondary(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>> +	unsigned long start_rip;
>>   	unsigned long val;
>> +	u32 phys_apicid;
>>   	int pnode;
>>
>> +	phys_apicid = wakeup->apicid;
>> +	start_rip = wakeup->start_ip;
>> +
>>   	pnode = uv_apicid_to_pnode(phys_apicid);
>>
>>   	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index c10850ae6f09..341620f1e1fe 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -715,8 +715,14 @@ static void send_init_sequence(u32 phys_apicid)
>>   /*
>>    * Wake up AP by INIT, INIT, STARTUP sequence.
>>    */
>> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
>> +static int wakeup_secondary_cpu_via_init(struct wakeup_secondary_cpu_data *wakeup)
>>   {
>> +	unsigned long start_eip;
>> +	u32 phys_apicid;
>> +
>> +	start_eip = wakeup->start_ip;
>> +	phys_apicid = wakeup->apicid;
>> +
>>   	unsigned long send_status = 0, accept_status = 0;
>>   	int num_starts, j, maxlvt;
>>
>> @@ -865,6 +871,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>>   static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>>   {
>>   	unsigned long start_ip = real_mode_header->trampoline_start;
>> +	struct wakeup_secondary_cpu_data wakeup;
>>   	int ret;
>>
>>   #ifdef CONFIG_X86_64
>> @@ -906,6 +913,10 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>>   		}
>>   	}
>>
>> +	wakeup.cpu = cpu;
>> +	wakeup.apicid = apicid;
>> +	wakeup.start_ip = start_ip;
>> +
>>   	smp_mb();
>>
>>   	/*
>> @@ -916,11 +927,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>>   	 * - Use an INIT boot APIC message
>>   	 */
>>   	if (apic->wakeup_secondary_cpu_64)
>> -		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
>> +		ret = apic->wakeup_secondary_cpu_64(&wakeup);
>>   	else if (apic->wakeup_secondary_cpu)
>> -		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
>> +		ret = apic->wakeup_secondary_cpu(&wakeup);
>>   	else
>> -		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
>> +		ret = wakeup_secondary_cpu_via_init(&wakeup);
>>
>>   	/* If the wakeup mechanism failed, cleanup the warm reset vector */
>>   	if (ret)
>>
>> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
>> --
>> 2.43.0
>>
> 

-- 
Thank you,
Roman


