Return-Path: <linux-hyperv+bounces-7957-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC20CA1E0D
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 00:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF9330062E6
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD62E8882;
	Wed,  3 Dec 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KbCNFed0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D382EC0AD;
	Wed,  3 Dec 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802827; cv=none; b=AZ47/yUGtQfRwALnY7ZQBrDkP3NKCGQb/3UiWwWhhzt2mEaKasB9TWrBVh83KiZmzFp9C4rFQd4RCZuXAwd3/R2Gg3fmD2LSpLvU3v8+DNi42YrMqGh6N93+4GWQTANAnuGqdGERGdu1uM8W2u6WbPhdmxzOPB//KxHg+p1+nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802827; c=relaxed/simple;
	bh=7T60wRZIfD5Sx1Pojx8ekqwLfkYfZd1HyNk9NLcJ8wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9dhGhU4O5AFvWHAgEKUOD4E3kiHM+98h5LLpk+8gXfXsq5+n4Ub9ru6YQFWfgjRHBR56/hovG3/9O1xRQX8JBaMfgtqTU2FFfqFGom8vZFzX9xUqR1H2/cWvItZ4aQBK7e+qBN6VUKsDOH4vGCSPZTuP9cpR7RC/ep/+QVpPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KbCNFed0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC6972120E87;
	Wed,  3 Dec 2025 15:00:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC6972120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764802819;
	bh=Kf0tnPgRuner7Am1JOG6OGI2+GxtDV8u9Lksp9Mn98g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KbCNFed0KkEXuBIUEwi02whCDOc+4JmgQdYLUlagoueFDMxo4YS8cZWkNotXWhnNA
	 Y/yuMkf+QhhIYpC8bUZw9VCj8Z6ryHRReH3+0cvjDhQVuLpjMNdWlPN8ZjIt8z1QIu
	 fYVCZ+EHAqZY41ceMUSxj1C+fyWEbz8r0zZHS5Kw=
Message-ID: <68979e92-6494-4c10-8c92-a89f6ab6ae3d@linux.microsoft.com>
Date: Wed, 3 Dec 2025 15:00:18 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] hyperv: Cleanly shutdown root partition with MSHV
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc: anbelski@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 skinsburskii@linux.microsoft.com
References: <20251126215013.11549-1-prapal@linux.microsoft.com>
 <20251126215013.11549-4-prapal@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251126215013.11549-4-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/2025 1:49 PM, Praveen K Paladugu wrote:
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

Avoid statements like "The previous patch", since these patches may not
always follow each other directly once pulled into other trees, ported, etc.
You could explicitly mention the dependency on calling
hv_sleep_notifiers_register() before HVCALL_ENTER_SLEEP_STATE will work
correctly.

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
> +	local_irq_restore(flags);

We don't expect to return here. If we do for some reason, it is surely
a bug.

I suggest either:
- fall back to native_machine_power_off(), or
- BUG(), since the machine shouldn't continue running

> +
> +}
>  #endif


