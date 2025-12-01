Return-Path: <linux-hyperv+bounces-7908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3BC98662
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52E793432FC
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C820A5EA;
	Mon,  1 Dec 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ocBngyn7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC231813F;
	Mon,  1 Dec 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608560; cv=none; b=pXqQcBav6uzxOB88G50LjI8OOlN2XLeMb5nAggvrxJqhLz/lrG8g+A8+Jl0wPUaxK9YTqS91VLVQ2DjS4JxgqhgdeB/ynPcwPfaeDtpST8yo13orp2hT3vP0L1yLyTblH+A0SbHWbIWZgw7yAtmPLcaHCFwe52NwTWT1+unlGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608560; c=relaxed/simple;
	bh=WLpD+RRCzV7xXr0u2vnAC9n8c5SgO/HTZuNbtGP/2pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxyEAYbgt44rlcbf44IXuRO4LPLlwQwuS9HaTS7DZfb8VtV8rdlEry6KCYAZy2aSsNqrmqXsWzgXPa0RIQCudkJohbLxjAnl7Uo30K78v430U4dPpxS8Gqu19TIpf/JrCdKwvIha4RMacpJq6cESv+AZ8g1axN9QVbJclqUF0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ocBngyn7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BA4B200DFDA;
	Mon,  1 Dec 2025 09:02:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BA4B200DFDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764608558;
	bh=m9XK8kCGVvEB3B14mxr4XttoBHtZX1jF5xZg1TGlW8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocBngyn7Dg+Xp+vUEfMH5blg6xdbI3TpNNk5DM9zQsoZ8W6pVlLujHTV/z3+YaD6j
	 xh0t6SPL7Q/y7aszvRE7/1/XqhVkTyvGvbqrF/nY4Xls4x9zEimGTyMntMp2+r0kde
	 PNdG9UfQKIrRgIb96ZFurxH4u4apJyH21TnAID64=
Date: Mon, 1 Dec 2025 09:02:35 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v6 2/3] hyperv: Use reboot notifier to configure sleep
 state
Message-ID: <aS3KK90Aef87C7aW@skinsburskii.localdomain>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126215013.11549-3-prapal@linux.microsoft.com>

On Wed, Nov 26, 2025 at 03:49:52PM -0600, Praveen K Paladugu wrote:
> Configure sleep state information in mshv hypervisor. This sleep state
> information from ACPI will be used by hypervisor to poweroff the host.
> 

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  1 +
>  arch/x86/include/asm/mshyperv.h |  2 +
>  drivers/hv/mshv_common.c        | 80 +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e28737ec7054..daf97a984b78 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -555,6 +555,7 @@ void __init hyperv_init(void)
>  
>  		hv_remap_tsc_clocksource();
>  		hv_root_crash_init();
> +		hv_sleep_notifiers_register();
>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 10037125099a..166053df0484 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -182,8 +182,10 @@ int hyperv_fill_flush_guest_mapping_list(
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
>  bool hv_vcpu_is_preempted(int vcpu);
> +void hv_sleep_notifiers_register(void);
>  #else
>  static inline void hv_apic_init(void) {}
> +static inline void hv_sleep_notifiers_register(void) {};
>  #endif
>  
>  struct irq_domain *hv_create_pci_msi_domain(void);
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index aa2be51979fd..f1d4e81107ee 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -14,6 +14,9 @@
>  #include <asm/mshyperv.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/export.h>
> +#include <linux/acpi.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
>  
>  #include "mshv.h"
>  
> @@ -138,3 +141,80 @@ int hv_call_get_partition_property(u64 partition_id,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
> +
> +#ifdef CONFIG_X86_64
> +/*
> + * Corresponding sleep states have to be initialized in order for a subsequent
> + * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
> + * ACPI 6.4 chapter 7.4.2 is relevant, while S1, S2 and S3 can be supported.
> + *
> + * In order to pass proper PM values to mshv, ACPI should be initialized and
> + * should support S5 sleep state when this method is invoked.
> + */
> +static int hv_initialize_sleep_states(void)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_set_system_property *in;
> +	acpi_status acpi_status;
> +	u8 sleep_type_a, sleep_type_b;
> +
> +	if (!acpi_sleep_state_supported(ACPI_STATE_S5)) {
> +		pr_err("%s: S5 sleep state not supported.\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	acpi_status = acpi_get_sleep_type_data(ACPI_STATE_S5, &sleep_type_a,
> +					       &sleep_type_b);
> +	if (ACPI_FAILURE(acpi_status))
> +		return -ENODEV;
> +
> +	local_irq_save(flags);
> +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(in, 0, sizeof(*in));
> +
> +	in->property_id = HV_SYSTEM_PROPERTY_SLEEP_STATE;
> +	in->set_sleep_state_info.sleep_state = HV_SLEEP_STATE_S5;
> +	in->set_sleep_state_info.pm1a_slp_typ = sleep_type_a;
> +	in->set_sleep_state_info.pm1b_slp_typ = sleep_type_b;
> +
> +	status = hv_do_hypercall(HVCALL_SET_SYSTEM_PROPERTY, in, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * This notifier initializes sleep states in mshv hypervisor which will be
> + * used during power off.
> + */
> +static int hv_reboot_notifier_handler(struct notifier_block *this,
> +				      unsigned long code, void *another)
> +{
> +	int ret = 0;
> +
> +	if (code == SYS_HALT || code == SYS_POWER_OFF)
> +		ret = hv_initialize_sleep_states();
> +
> +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> +}
> +
> +static struct notifier_block hv_reboot_notifier = {
> +	.notifier_call = hv_reboot_notifier_handler,
> +};
> +
> +void hv_sleep_notifiers_register(void)
> +{
> +	int ret;
> +
> +	ret = register_reboot_notifier(&hv_reboot_notifier);
> +	if (ret)
> +		pr_err("%s: cannot register reboot notifier %d\n", __func__,
> +		       ret);
> +}
> +#endif
> -- 
> 2.51.0

