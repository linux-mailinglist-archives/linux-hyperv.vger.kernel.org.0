Return-Path: <linux-hyperv+bounces-7909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBEC98677
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 18:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF924343120
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A4334C06;
	Mon,  1 Dec 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sa/8CcZB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33732D0D4;
	Mon,  1 Dec 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608759; cv=none; b=tpSs5cChwLdRCDSACCembc+7zseyQoEeFvhQ9OriW3PPopgQu0N8cg7QJhnYgr4HCYJL1b/qvbrKb938mToqbdT2L7oxaivoQ/ah2iOim0Bzk4pKIf4NF3fuI57T35q2ZIxWs9hIUZU3QJFOSdAPIZ5ihj/TMwFUnQVKC5phds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608759; c=relaxed/simple;
	bh=p4UoQ46q883HdXYyNa/Xv7qlzhDiz3s5GJruHmWTyK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJkx24o3MObgA26AEZpjkZ9QLi4kBE0GJcwg3vlQULIFuBVKJCXoWQSeMFWxRayp34/Pf4nyNF9yFDAXx6HSBL3Knj/RifhY06KtPUYZeJ57JpYMWYdmcIARJNj+qN1Q3EywP2tR18nXTyOkj5DB6F+zcsRKbeSFL5TN1QG5Ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sa/8CcZB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E5C6200DFDA;
	Mon,  1 Dec 2025 09:05:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E5C6200DFDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764608757;
	bh=pSbTPYuk7USYMdJHqeMGfqFk+uhe4xz7erbBkr29E78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sa/8CcZB9upXOY0S2GsX1arE2lPlVVMEVDHFV9zv4CM3EwYVr2CQmO/OB4KKHDOlW
	 pF7Nxa9qkIhDLoCBM74e31AUkxpsI7pUkj7sLVgtr9/P9Go3/83OdXObWRtFACaBu1
	 z27nd6b80QBSIv13vkkaEl/dS85dYSucBzCnDx2c=
Date: Mon, 1 Dec 2025 09:05:55 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v6 3/3] hyperv: Cleanly shutdown root partition with MSHV
Message-ID: <aS3K898vD31Qi8mE@skinsburskii.localdomain>
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-4-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126215013.11549-4-prapal@linux.microsoft.com>

On Wed, Nov 26, 2025 at 03:49:53PM -0600, Praveen K Paladugu wrote:
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
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c  |  2 ++
>  drivers/hv/mshv_common.c        | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
> 
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
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index fac9953a72ef..579fb2c64cfd 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -621,6 +621,8 @@ static void __init ms_hyperv_init_platform(void)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
> +	if (hv_root_partition())
> +		machine_ops.power_off = hv_machine_power_off;
>  #if defined(CONFIG_KEXEC_CORE)
>  	machine_ops.shutdown = hv_machine_shutdown;
>  #endif
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index f1d4e81107ee..28905e3ed9c0 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -217,4 +217,22 @@ void hv_sleep_notifiers_register(void)
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

Should this the error be printed?

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> +	local_irq_restore(flags);
> +
> +}
>  #endif
> -- 
> 2.51.0

