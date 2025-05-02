Return-Path: <linux-hyperv+bounces-5317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D9CAA78AC
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165CE7A81BD
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A331ABEAC;
	Fri,  2 May 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9MbOnBT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2619DF5B;
	Fri,  2 May 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207180; cv=none; b=Rvszdk2xXO28JSDsEKUnCnmYCDCdibNJNYittuVob5lhZxhsEAIlnBGh7bnPmWHrnhkH9pWuqjRvzJ1Jf3HpeL0txTWYJ0R+3X07G73nLzoQ/bFqksU78RTw1C2oognbEt/GQ2Sqs4hpo2R98F66biqpNpN0Et08vBQ3CLmsHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207180; c=relaxed/simple;
	bh=Im5xGaDvrPfuEOqU8Rk8ElrZ/HrvjBhJLUzFELeba3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVzCeXVGqri90BV6N6If4p6yfHpuFns/PshUSTmzTGmvFlG+gtaVd4JmFrg4zKgPAgQrVWbOvBe9dZEqDYXwJ+mzlVi3ZDhPcBpE1alQ142CQa9Wziz4wDAT56CH5lCMfYlepd2waYazo7uTf1ETPGP4nf6hCUre4VQYPwJS+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9MbOnBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9540DC4CEE4;
	Fri,  2 May 2025 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746207180;
	bh=Im5xGaDvrPfuEOqU8Rk8ElrZ/HrvjBhJLUzFELeba3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9MbOnBT0Y+Wd3VC1KxHANpC/6Mx4dlJB8LhzyJv2ckS8Wfw3WSnUNEwjC6sIw9gr
	 Ib8187DqzClwPRRU3DoLMUMvk7jXG2DE4WGDtgds5/JMs4K6tms3NdpU0bQjqSpBzC
	 vI97M21xWovcmFHxitwBXZCRzU3c8opzLp3555CwacfFZUSyfQ9rM8Wj4xOZdG5PUM
	 mUjIToDHBk4q9S+bOpgUhAmhP1OBMf74m9FpRBucmNrsVR9CXt6ePP7wZJu+9qHmvo
	 2H/1Xb/NNSggIQ089d25YxACVQVrCfWIyjqg7Tdbddy6DdnW8pIqabU9eqernNrqEx
	 eXmMPPpO3se+A==
Date: Fri, 2 May 2025 17:32:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jgross@suse.com,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
	nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com,
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com, tony.luck@intel.com, wei.liu@kernel.org,
	xin@zytor.com, yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430204720.108962-1-romank@linux.microsoft.com>

On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
> 
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> The diff in ivm.c might catch your eye but that code mixes up the
> APIC ID and the CPU number anyway. That is fixed in another patch:
> https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux.microsoft.com/
> independently of this one (being an optimization).
> I separated the two as this one might be more disputatious due to
> the change in the API (although it is a tiny one and comes with
> the benefits).
> 
> [V3]
> 	- Fixed the cpu nummber to be unsigned int within the patch and
> 	  in the do_boot_cpu() function.
> 	** Thank you, Thomas! **
> 
> [V2]
> 	https://lore.kernel.org/linux-hyperv/20250430161413.276759-1-romank@linux.microsoft.com/
> 	- Remove the struct used in v1 in favor of passing the CPU number
> 	  directly to the callback not to increase complexity.
> 	** Thank you, Michael! **
> [V1]
> 	https://lore.kernel.org/linux-hyperv/20250428225948.810147-1-romank@linux.microsoft.com/
> ---
>  arch/x86/coco/sev/core.c           | 13 ++-----------
>  arch/x86/hyperv/hv_vtl.c           | 12 ++----------
>  arch/x86/hyperv/ivm.c              |  2 +-
>  arch/x86/include/asm/apic.h        |  8 ++++----
>  arch/x86/include/asm/mshyperv.h    |  5 +++--
>  arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
>  arch/x86/kernel/apic/apic_noop.c   |  8 +++++++-
>  arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
>  arch/x86/kernel/smpboot.c          | 10 +++++-----

Since this is tagged as a hyperv-next patch, I'm happy to pick this up.

Some changes should be acked by x86 maintainers.

Thanks,
Wei.

>  9 files changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 82492efc5d94..8b6d310b61b9 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1179,7 +1179,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
>  		free_page((unsigned long)vmsa);
>  }
>  
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned int cpu)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> @@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
> -	int cpu, ret;
> +	int ret;
>  	u64 cr4;
>  
>  	/*
> @@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  
>  	/* Override start_ip with known protected guest start IP */
>  	start_ip = real_mode_header->sev_es_trampoline_start;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apic_id))
> -			break;
> -	}
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;
> -
>  	cur_vmsa = per_cpu(sev_vmsa, cpu);
>  
>  	/*
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..4d6e0e198041 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -237,17 +237,9 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	return ret;
>  }
>  
> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
> +static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, unsigned int cpu)
>  {
> -	int vp_id, cpu;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apicid))
> -			break;
> -	}
> -	if (cpu >= nr_cpu_ids)
> -		return -EINVAL;
> +	int vp_id;
>  
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id = hv_vtl_apicid_to_vp_id(apicid);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..6025da891a83 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>  
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
>  {
>  	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index f21ff1932699..33f677e2db75 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -313,9 +313,9 @@ struct apic {
>  	u32	(*get_apic_id)(u32 id);
>  
>  	/* wakeup_secondary_cpu */
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsigned int cpu);
>  	/* wakeup secondary CPU using 64-bit wakeup point */
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, unsigned int cpu);
>  
>  	char	*name;
>  };
> @@ -333,8 +333,8 @@ struct apic_override {
>  	void	(*send_IPI_self)(int vector);
>  	u64	(*icr_read)(void);
>  	void	(*icr_write)(u32 low, u32 high);
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsigned int cpu);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, unsigned int cpu);
>  };
>  
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 07aadf0e839f..cab952f722e4 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,12 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
> +		unsigned int cpu) { return 0; }
>  #endif
>  
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index d5ef6215583b..f48581888d53 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -169,7 +169,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
>  	return 0;
>  }
>  
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned int cpu)
>  {
>  	if (!acpi_mp_wake_mailbox_paddr) {
>  		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
> index b5bb7a2e8340..58abb941c45b 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,13 @@ static void noop_send_IPI_allbutself(int vector) { }
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
> +
> +static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip,
> +	unsigned int cpu)
> +{
> +	return -1;
> +}
> +
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 7fef504ca508..15209f220e1f 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
>  	}
>  }
>  
> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip, unsigned int cpu)
>  {
>  	unsigned long val;
>  	int pnode;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index c10850ae6f09..b013296b100f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
>  /*
>   * Wake up AP by INIT, INIT, STARTUP sequence.
>   */
> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip)
> +static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long start_eip, unsigned int cpu)
>  {
>  	unsigned long send_status = 0, accept_status = 0;
>  	int num_starts, j, maxlvt;
> @@ -862,7 +862,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>   * Returns zero if startup was successfully sent, else error code from
>   * ->wakeup_secondary_cpu.
>   */
> -static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
> +static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
>  {
>  	unsigned long start_ip = real_mode_header->trampoline_start;
>  	int ret;
> @@ -916,11 +916,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  	 * - Use an INIT boot APIC message
>  	 */
>  	if (apic->wakeup_secondary_cpu_64)
> -		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
> +		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
>  	else if (apic->wakeup_secondary_cpu)
> -		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
> +		ret = apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
>  	else
> -		ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
> +		ret = wakeup_secondary_cpu_via_init(apicid, start_ip, cpu);
>  
>  	/* If the wakeup mechanism failed, cleanup the warm reset vector */
>  	if (ret)
> 
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> -- 
> 2.43.0
> 

