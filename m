Return-Path: <linux-hyperv+bounces-7657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF3C66945
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 00:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6003E29712
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A81E376C;
	Mon, 17 Nov 2025 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NnF3tT+v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD2D531;
	Mon, 17 Nov 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423141; cv=none; b=XnJ7ulpgbWNqEzq20s1MQIwjBsuQACmiBdiA0msEZeWGGxqTSXliV4QEGvfC5N18iZU4ge0sQPC3b9ud8mk7Hd9JT7Ik34mftFpjmffG0e/2DNaE4POrBR31zF5rro+He6LKf9lmPqTHbKztKABGdj0WkikCSyDLtkwSQwMj8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423141; c=relaxed/simple;
	bh=QRvh8xr+0Olnivt6nadyzd+WyRZKFQNN2cVUauvcNDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awCFjmwO+JB09J2OpCt1VIjJNuP6EHscXQ+RRBqKt5faJftvNYh/doRjWc6ZST5QsZd35mYkNxHZouOduBtqSiANAt++e9tdCa4MWzXMRRB9oJkQ3AaTKtO4/7VOmF+N4XhjlnlZ6dtCNV1Yd/V43DeEbQGDznF2sL4UMeb7gOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NnF3tT+v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 385172013355;
	Mon, 17 Nov 2025 15:45:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 385172013355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763423138;
	bh=d0k2tn8GPmvZ573ftacpb5eenGX7JglA+0NO8ojZKcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnF3tT+viXylffHOA1MvIigYRfxhHdq+ucn3IS5QlsHRuzbIFGMA7u+jtHuDBQKmk
	 Jb/SXJFHewCG8Z26JO61I9nw16OFtcRCZTiDrzndy81UVL5rjlCNxfne642zozNu9W
	 t1w9fqdPnVgqUzPkF4XfWNupIvz2pdTlkoEqwq74=
Date: Mon, 17 Nov 2025 15:45:36 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v5 3/3] hyperv: Cleanly shutdown root partition with MSHV
Message-ID: <aRuzoDGxVp-PjI5o@skinsburskii.localdomain>
References: <20251117210855.108126-1-prapal@linux.microsoft.com>
 <20251117210855.108126-4-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117210855.108126-4-prapal@linux.microsoft.com>

On Mon, Nov 17, 2025 at 03:08:18PM -0600, Praveen K Paladugu wrote:
> When a root partition running on MSHV is powered off, the default
> behavior is to write ACPI registers to power-off. However, this ACPI
> write is intercepted by MSHV and will result in a Machine Check
> Exception(MCE).
> 
> The root partition eventually panics with a trace similar to:
> 
>   [   81.306348] reboot: Power down
>   [   81.314709] mce: [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 0: b2000000c0060001
>   [   81.314711] mce: [Hardware Error]: TSC 3b8cb60a66 PPIN 11d98332458e4ea9
>   [   81.314713] mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1759339405 SOCKET 0 APIC 0 microcode ffffffff
>   [   81.314715] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>   [   81.314716] mce: [Hardware Error]: Machine check: Processor context corrupt
>   [   81.314717] Kernel panic - not syncing: Fatal machine check
> 
> To correctly shutdown a root partition running on MSHV hypervisor, sleep
> state information must be configured within the hypervsior. Later, the
> HVCALL_ENTER_SLEEP_STATE hypercall should be invoked as the last step in
> the shutdown sequence.
> 
> The previous patch configures the sleep state information and this patch
> invokes HVCALL_ENTER_SLEEP_STATE hypercall to cleanly shutdown the root
> partition.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  2 ++
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  drivers/hv/mshv_common.c        | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 645b52dd732e..24824534ff8d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -34,6 +34,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  #include <linux/export.h>
> +#include <asm/reboot.h>
>  
>  void *hv_hypercall_pg;
>  
> @@ -562,6 +563,7 @@ void __init hyperv_init(void)
>  		 * failures here.
>  		 */
>  		hv_sleep_notifiers_register();
> +		machine_ops.power_off = hv_machine_power_off;

It looks more natural to me to gather all the machine_ops hooks in one
place (meaning in ms_hyperv_init_platform).
It is better moving this assignment there and do the branching on the
partition type in the power_off callback instead.

Thanks,
Stanislav


>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 166053df0484..4c22f3257368 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -183,9 +183,11 @@ void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
>  bool hv_vcpu_is_preempted(int vcpu);
>  void hv_sleep_notifiers_register(void);
> +void hv_machine_power_off(void);
>  #else
>  static inline void hv_apic_init(void) {}
>  static inline void hv_sleep_notifiers_register(void) {};
> +static inline void hv_machine_power_off(void) {};
>  #endif
>  
>  struct irq_domain *hv_create_pci_msi_domain(void);
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index ee733ba1575e..73505cbdc324 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -216,3 +216,21 @@ void hv_sleep_notifiers_register(void)
>  		pr_err("%s: cannot register reboot notifier %d\n", __func__,
>  		       ret);
>  }
> +
> +/*
> + * Power off the machine by entering S5 sleep state via Hyper-V hypercall.
> + * This call does not return if successful.
> + */
> +void hv_machine_power_off(void)
> +{
> +	unsigned long flags;
> +	struct hv_input_enter_sleep_state *in;
> +
> +	local_irq_save(flags);
> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	in->sleep_state = HV_SLEEP_STATE_S5;
> +
> +	(void)hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> +	local_irq_restore(flags);
> +
> +}
> -- 
> 2.51.0

