Return-Path: <linux-hyperv+bounces-5400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F12AAD61C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CF1BC6FFF
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 06:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6472A2101BD;
	Wed,  7 May 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/xrHCBP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4C2101B7;
	Wed,  7 May 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599540; cv=none; b=rtXwNf1c8DbU7Q8KYmSFf2iWGs73EkW50ltHs0+LCO8uXN/nVr7GUIrilqKqFZc+ugwVjQTdirf8h3nHbU666RjNgMPMdi7hzNNGZ+f7EU9qyP11rfIv9RIFI5mJk65GJMZ6UOhh66DQTkI6mbvP4pQknVYM1mpHZzEwdeI9rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599540; c=relaxed/simple;
	bh=9mH49n6y8hGryj6ZWG7X7oVmRZ0eXICKJkB/ldTi3G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyNrfUBMdiOU5Av+QeRJ2FnPuVGlLo88w4ONoLY4rmoDXCA8tPxXiKoafU5a30/EU4cByDxMy+Am01XIMnB+G7rWL+eZHCZ3116j8JS4CfKqsYucRoBc7vxq+TNPzXJ3CsN7r9Pq5mt+X5kaMhzkC65sP2sNsxCZgpXcw1A+gUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/xrHCBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D205C4CEEF;
	Wed,  7 May 2025 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746599538;
	bh=9mH49n6y8hGryj6ZWG7X7oVmRZ0eXICKJkB/ldTi3G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/xrHCBPur0fjnZWkvrRoTU2aNXfJQeiNFv+bPfMUnpM6v0Ygo8uGQqRakz51gtZ8
	 MKU7VFkJB8YrxP5o7I5AZo022xbWXDb7+WsGqo6nRpZz9/ZE451OEtYnynOcvMtYTm
	 v8nGgVpcDQ1XQSB+KRpbZbnoY7RGduP4O90IDBQzmFCRQJDMp3ssRqZET0wZeQHutI
	 2E5Mt8l5EXVeSFr00ktxkHtmn9siOBC2VFeb8yGkjieaVGP3b2677Rb+YcXk6hdAXN
	 Pjmcd/xiORD4LkWlaRmp/2J9Jkk1Q36mH6tr/3FLXeMz5yvT8qo1WlqskGc7HV8FTq
	 CTeu8jwBOKx1Q==
Date: Wed, 7 May 2025 06:32:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v4] x86/hyperv: Fix CPU number and VP index
 confusion in hv_snp_boot_ap()
Message-ID: <aBr-cScjbkhyoBFA@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250506174249.11496-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506174249.11496-1-romank@linux.microsoft.com>

On Tue, May 06, 2025 at 10:42:49AM -0700, Roman Kisel wrote:
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that START_VP hypercall but passes the CPU number to it
> instead of the VP index.
> 
> As those two aren't generally interchangeable, that may lead to hung
> APs if the VP index and the APIC ID don't match up.
> 
> Use the APIC ID to the VP index conversion to provide the correct
> input to the hypercall.
> 
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
> When merging this change to other trees
> 2d2d4d8bb00 ("arch/x86: Provide the CPU number in the wakeup AP callback")
> is needed.

This is dropped from the tree because it breaks builds.

Since this needs to be backported, it makes more sense to apply this
patch first before the other one (assuming that one doesn't need to be
backported).

Thanks,
Wei.

> 
> [V4]
>     - Rebased on the latest hyperv-next branch, and updated the
>       title and the commit message as some changes were superceeded
>       by 2d2d4d8bb00 ("arch/x86: Provide the CPU number in the wakeup AP callback").
>     ** Thank you, Wei! **
> 
> [V3]
>     https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux.microsoft.com/
>     - Removed the misleading comment about the APIC ID and VP indices.
>     - Removed the not sufficiently founded if statement that was added
>       to the previous version of the patch to avoid the O(n) time complexity.
>       I'll follow up with a separate patch to address that as that pattern
>        has crept into other places in the code in the AP wakeup path.
>       Fixed the logging message to use the "VP index" terminology
>       consistently.
>     ** Thank you, Michael! **
> 
> [V2]
>     https://lore.kernel.org/linux-hyperv/20250425213512.1837061-1-romank@linux.microsoft.com/
>     - Fixed the terminology in the patch and other code to use
>       the term "VP index" consistently
>     ** Thank you, Michael! **
> 
>     - Missed not enabling the SNP-SEV options in the local testing,
>       and sent a patch that breaks the build.
>     ** Thank you, Saurabh! **
> 
>     - Added comments and getting the Linux kernel CPU number from
>       the available data.
> 
> [V1]
>     https://lore.kernel.org/linux-hyperv/20250424215746.467281-1-romank@linux.microsoft.com/
> ---
>  arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
>  arch/x86/hyperv/ivm.c           |  8 +++++-
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  include/hyperv/hvgdk_mini.h     |  2 +-
>  5 files changed, 49 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3b569291dfed..9a8fc144e195 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -672,3 +672,36 @@ bool hv_is_hyperv_initialized(void)
>  	return hypercall_msr.enable;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +int hv_apicid_to_vp_index(u32 apic_id)
> +{
> +	u64 control;
> +	u64 status;
> +	unsigned long irq_flags;
> +	struct hv_get_vp_from_apic_id_in *input;
> +	u32 *output, ret;
> +
> +	local_irq_save(irq_flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = HV_PARTITION_ID_SELF;
> +	input->apic_ids[0] = apic_id;
> +
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
> +	status = hv_do_hypercall(control, input, output);
> +	ret = output[0];
> +
> +	local_irq_restore(irq_flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("failed to get vp index from apic id %d, status %#llx\n",
> +		       apic_id, status);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_apicid_to_vp_index);
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index cc8c6817f704..3d149a2ca4c8 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -211,55 +211,23 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
>  	return ret;
>  }
>  
> -static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> -{
> -	u64 control;
> -	u64 status;
> -	unsigned long irq_flags;
> -	struct hv_get_vp_from_apic_id_in *input;
> -	u32 *output, ret;
> -
> -	local_irq_save(irq_flags);
> -
> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(input, 0, sizeof(*input));
> -	input->partition_id = HV_PARTITION_ID_SELF;
> -	input->apic_ids[0] = apic_id;
> -
> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> -
> -	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> -	status = hv_do_hypercall(control, input, output);
> -	ret = output[0];
> -
> -	local_irq_restore(irq_flags);
> -
> -	if (!hv_result_success(status)) {
> -		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> -		       apic_id, status);
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
>  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip, unsigned int cpu)
>  {
> -	int vp_id;
> +	int vp_index;
>  
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> -	vp_id = hv_vtl_apicid_to_vp_id(apicid);
> +	vp_index = hv_apicid_to_vp_index(apicid);
>  
> -	if (vp_id < 0) {
> +	if (vp_index < 0) {
>  		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
>  		return -EINVAL;
>  	}
> -	if (vp_id > ms_hyperv.max_vp_index) {
> -		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
> +	if (vp_index > ms_hyperv.max_vp_index) {
> +		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_index, apicid);
>  		return -EINVAL;
>  	}
>  
> -	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
> +	return hv_vtl_bringup_vcpu(vp_index, cpu, start_eip);
>  }
>  
>  int __init hv_vtl_early_init(void)
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 30aa76974a3a..71918817129e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -297,10 +297,16 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
>  	u64 ret, retry = 5;
>  	struct hv_enable_vp_vtl *start_vp_input;
>  	unsigned long flags;
> +	int vp_index;
>  
>  	if (!vmsa)
>  		return -ENOMEM;
>  
> +	/* Find the Hyper-V VP index which might be not the same as APIC ID */
> +	vp_index = hv_apicid_to_vp_index(apic_id);
> +	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
> +		return -EINVAL;
> +
>  	native_store_gdt(&gdtr);
>  
>  	vmsa->gdtr.base = gdtr.address;
> @@ -348,7 +354,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
>  	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
>  	memset(start_vp_input, 0, sizeof(*start_vp_input));
>  	start_vp_input->partition_id = -1;
> -	start_vp_input->vp_index = cpu;
> +	start_vp_input->vp_index = vp_index;
>  	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
>  	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 3bfc066aeccc..5ec92e3e2e37 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -307,6 +307,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
>  {
>  	return __rdmsr(reg);
>  }
> +int hv_apicid_to_vp_index(u32 apic_id);
>  
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> @@ -328,6 +329,7 @@ static inline void hv_set_msr(unsigned int reg, u64 value) { }
>  static inline u64 hv_get_msr(unsigned int reg) { return 0; }
>  static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { }
>  static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
> +static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
>  #endif /* CONFIG_HYPERV */
>  
>  
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index cf0923dc727d..2d431b53f587 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -475,7 +475,7 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
> -#define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> 
> base-commit: 1b019573c9662c17a33419367a217abe1f5e8060
> -- 
> 2.43.0
> 

