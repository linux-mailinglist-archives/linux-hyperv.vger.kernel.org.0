Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CD2F9DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2019 11:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfE3JsR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 May 2019 05:48:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfE3JsQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 May 2019 05:48:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so3527241wmm.2
        for <linux-hyperv@vger.kernel.org>; Thu, 30 May 2019 02:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ieBreYqn74TE4VVKVG76q3gXbE8UVws6L1EIn4PkLWo=;
        b=SYG46yzmeOSLxrO6i5/PArxGFefWMJ7SxhbWobWbe7JcBSJwKOVDT/hFJWVqMXraox
         Iar+Xr5kqtJavQCzc4LA6/giTgSZ0V9djz3wvIn9J/k/7mE3ABbfeKHkN2prtrfrEUiO
         avlX8Lw5IGJWCcq6NT+TOioCcOOW4/0wpn1/Ii3PHppxMePFMjcGQswGMbVuT3MQQZ88
         gRwamYzYkvxOfquTbHYIDHsIHokr48BngZsdeCDCT9N+3F041hMGCYyuO4TU47c9VQvy
         4MfrljOTrdHfAHhvv0BesWc/Dp8PSlGplt0fa7k0GX+pxnJokCCgVmYFPdLdMoH+ZUal
         Iahw==
X-Gm-Message-State: APjAAAV9E55Z9YHXhP2SGc6eWlzYr0DNW8KJKGEA+Ullha80hHyTVY3r
        EDJDx8IPsKahv+InSl11/DPlRQ==
X-Google-Smtp-Source: APXvYqwC4qmvkkAwaPy+mAdn3u79acI1wL8OUviaj6zXVUioYKFa2fz2TZJcnHZVYG0bqBX0irgYbg==
X-Received: by 2002:a1c:a6d1:: with SMTP id p200mr1552381wme.169.1559209692028;
        Thu, 30 May 2019 02:48:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (cst-prg-69-174.cust.vodafone.cz. [46.135.69.174])
        by smtp.gmail.com with ESMTPSA id a2sm4996198wrg.69.2019.05.30.02.48.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 02:48:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "catalin.marinas\@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "will.deacon\@arm.com" <will.deacon@arm.com>,
        "marc.zyngier\@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "apw\@canonical.com" <apw@canonical.com>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v3 2/2] Drivers: hv: Move Hyper-V clocksource code to new clocksource driver
In-Reply-To: <1558969089-13204-3-git-send-email-mikelley@microsoft.com>
References: <1558969089-13204-1-git-send-email-mikelley@microsoft.com> <1558969089-13204-3-git-send-email-mikelley@microsoft.com>
Date:   Thu, 30 May 2019 11:48:10 +0200
Message-ID: <87r28gl1d1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Code for the Hyper-V specific clocksources is currently mixed
> in with other Hyper-V code. Move the code to the Hyper-V specific
> driver in the "clocksource" directory, while separating out
> ISA dependencies so that the clocksource driver remains ISA
> independent. Update the Hyper-V initialization code to call
> initialization and cleanup routines since the Hyper-V synthetic
> timers are not independently enumerated in ACPI. Update Hyper-V
> clocksource users KVM and VDSO to get definitions from a new
> include file.
>
> No behavior is changed and no new functionality is added.
>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/entry/vdso/vclock_gettime.c |   1 +
>  arch/x86/entry/vdso/vma.c            |   2 +-
>  arch/x86/hyperv/hv_init.c            |  91 +-----------------------
>  arch/x86/include/asm/mshyperv.h      |  81 +++-------------------
>  arch/x86/kvm/x86.c                   |   1 +
>  drivers/clocksource/hyperv_timer.c   | 130 +++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_util.c                 |   1 +
>  include/clocksource/hyperv_timer.h   |  78 +++++++++++++++++++++
>  8 files changed, 226 insertions(+), 159 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index 98c7d12..7983ca2 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -21,6 +21,7 @@
>  #include <linux/math64.h>
>  #include <linux/time.h>
>  #include <linux/kernel.h>
> +#include <clocksource/hyperv_timer.h>
>  
>  #define gtod (&VVAR(vsyscall_gtod_data))
>  
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index babc4e7..99b38e9 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -22,7 +22,7 @@
>  #include <asm/page.h>
>  #include <asm/desc.h>
>  #include <asm/cpufeature.h>
> -#include <asm/mshyperv.h>
> +#include <clocksource/hyperv_timer.h>
>  
>  #if defined(CONFIG_X86_64)
>  unsigned int __read_mostly vdso64_enabled = 1;
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e4ba467..79f626a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -27,64 +27,13 @@
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> -#include <linux/clockchips.h>
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> -
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -
> -static struct ms_hyperv_tsc_page *tsc_pg;
> -
> -struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> -{
> -	return tsc_pg;
> -}
> -EXPORT_SYMBOL_GPL(hv_get_tsc_page);
> -
> -static u64 read_hv_clock_tsc(struct clocksource *arg)
> -{
> -	u64 current_tick = hv_read_tsc_page(tsc_pg);
> -
> -	if (current_tick == U64_MAX)
> -		rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
> -
> -	return current_tick;
> -}
> -
> -static struct clocksource hyperv_cs_tsc = {
> -		.name		= "hyperv_clocksource_tsc_page",
> -		.rating		= 400,
> -		.read		= read_hv_clock_tsc,
> -		.mask		= CLOCKSOURCE_MASK(64),
> -		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> -#endif
> -
> -static u64 read_hv_clock_msr(struct clocksource *arg)
> -{
> -	u64 current_tick;
> -	/*
> -	 * Read the partition counter to get the current tick count. This count
> -	 * is set to 0 when the partition is created and is incremented in
> -	 * 100 nanosecond units.
> -	 */
> -	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
> -	return current_tick;
> -}
> -
> -static struct clocksource hyperv_cs_msr = {
> -	.name		= "hyperv_clocksource_msr",
> -	.rating		= 400,
> -	.read		= read_hv_clock_msr,
> -	.mask		= CLOCKSOURCE_MASK(64),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> +#include <clocksource/hyperv_timer.h>
>  
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> -struct clocksource *hyperv_cs;
> -EXPORT_SYMBOL_GPL(hyperv_cs);
>  
>  u32 *hv_vp_index;
>  EXPORT_SYMBOL_GPL(hv_vp_index);
> @@ -353,42 +302,8 @@ void __init hyperv_init(void)
>  
>  	x86_init.pci.arch_init = hv_pci_init;
>  
> -	/*
> -	 * Register Hyper-V specific clocksource.
> -	 */
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
> -		union hv_x64_msr_hypercall_contents tsc_msr;
> -
> -		tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> -		if (!tsc_pg)
> -			goto register_msr_cs;
> -
> -		hyperv_cs = &hyperv_cs_tsc;
> -
> -		rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
> -
> -		tsc_msr.enable = 1;
> -		tsc_msr.guest_physical_address = vmalloc_to_pfn(tsc_pg);
> -
> -		wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
> -
> -		hyperv_cs_tsc.archdata.vclock_mode = VCLOCK_HVCLOCK;
> -
> -		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> -		return;
> -	}
> -register_msr_cs:
> -#endif
> -	/*
> -	 * For 32 bit guests just use the MSR based mechanism for reading
> -	 * the partition counter.
> -	 */
> -
> -	hyperv_cs = &hyperv_cs_msr;
> -	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
> -		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
> -
> +	/* Register Hyper-V specific clocksource */
> +	hv_init_clocksource();
>  	return;
>  
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index cc60e61..f4fa8a9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -105,6 +105,17 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  #define hv_get_crash_ctl(val) \
>  	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
>  
> +#define hv_get_time_ref_count(val) \
> +	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
> +
> +#define hv_get_reference_tsc(val) \
> +	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
> +#define hv_set_reference_tsc(val) \
> +	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
> +#define hv_set_clocksource_vdso(val) \
> +	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
> +#define hv_get_raw_timer() rdtsc_ordered()
> +
>  void hyperv_callback_vector(void);
>  void hyperv_reenlightenment_vector(void);
>  #ifdef CONFIG_TRACING
> @@ -133,7 +144,6 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
> -extern struct clocksource *hyperv_cs;
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  
> @@ -387,73 +397,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
>  }
>  #endif /* CONFIG_HYPERV */
>  
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	u64 scale, offset;
> -	u32 sequence;
> -
> -	/*
> -	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> -	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> -	 * reference time we must do the following:
> -	 * - READ ReferenceTscSequence
> -	 *   A special '0' value indicates the time source is unreliable and we
> -	 *   need to use something else. The currently published specification
> -	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> -	 *   instead of '0' as the special value, see commit c35b82ef0294.
> -	 * - ReferenceTime =
> -	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> -	 * - READ ReferenceTscSequence again. In case its value has changed
> -	 *   since our first reading we need to discard ReferenceTime and repeat
> -	 *   the whole sequence as the hypervisor was updating the page in
> -	 *   between.
> -	 */
> -	do {
> -		sequence = READ_ONCE(tsc_pg->tsc_sequence);
> -		if (!sequence)
> -			return U64_MAX;
> -		/*
> -		 * Make sure we read sequence before we read other values from
> -		 * TSC page.
> -		 */
> -		smp_rmb();
> -
> -		scale = READ_ONCE(tsc_pg->tsc_scale);
> -		offset = READ_ONCE(tsc_pg->tsc_offset);
> -		*cur_tsc = rdtsc_ordered();
> -
> -		/*
> -		 * Make sure we read sequence after we read all other values
> -		 * from TSC page.
> -		 */
> -		smp_rmb();
> -
> -	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
> -
> -	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> -}
> -
> -static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
> -{
> -	u64 cur_tsc;
> -
> -	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> -}
> -
> -#else
> -static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> -{
> -	return NULL;
> -}
> -
> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
> -				       u64 *cur_tsc)
> -{
> -	BUG();
> -	return U64_MAX;
> -}
> -#endif
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 536b78c..3fbaac0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -70,6 +70,7 @@
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
>  #include <asm/intel_pt.h>
> +#include <clocksource/hyperv_timer.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 30615f3..274614d 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -14,6 +14,8 @@
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/sched_clock.h>
>  #include <linux/mm.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -189,3 +191,131 @@ void hv_stimer_global_cleanup(void)
>  	hv_stimer_free();
>  }
>  EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
> +
> +/*
> + * Code and definitions for the Hyper-V clocksources.  Two
> + * clocksources are defined: one that reads the Hyper-V defined MSR, and
> + * the other that uses the TSC reference page feature as defined in the
> + * TLFS.  The MSR version is for compatibility with old versions of
> + * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
> + */
> +
> +struct clocksource *hyperv_cs;
> +EXPORT_SYMBOL_GPL(hyperv_cs);
> +
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +
> +static struct ms_hyperv_tsc_page *tsc_pg;
> +
> +struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> +{
> +	return tsc_pg;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_tsc_page);
> +
> +static u64 read_hv_sched_clock_tsc(void)
> +{
> +	u64 current_tick = hv_read_tsc_page(tsc_pg);
> +
> +	if (current_tick == U64_MAX)
> +		hv_get_time_ref_count(current_tick);
> +
> +	return current_tick;
> +}
> +
> +static u64 read_hv_clock_tsc(struct clocksource *arg)
> +{
> +	return read_hv_sched_clock_tsc();
> +}
> +
> +static struct clocksource hyperv_cs_tsc = {
> +		.name		= "hyperv_clocksource_tsc_page",
> +		.rating		= 400,
> +		.read		= read_hv_clock_tsc,
> +		.mask		= CLOCKSOURCE_MASK(64),
> +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +#endif
> +
> +static u64 read_hv_sched_clock_msr(void)
> +{
> +	u64 current_tick;
> +	/*
> +	 * Read the partition counter to get the current tick count. This count
> +	 * is set to 0 when the partition is created and is incremented in
> +	 * 100 nanosecond units.
> +	 */
> +	hv_get_time_ref_count(current_tick);
> +	return current_tick;
> +}
> +
> +static u64 read_hv_clock_msr(struct clocksource *arg)
> +{
> +	return read_hv_sched_clock_msr();
> +}
> +
> +static struct clocksource hyperv_cs_msr = {
> +	.name		= "hyperv_clocksource_msr",
> +	.rating		= 400,
> +	.read		= read_hv_clock_msr,
> +	.mask		= CLOCKSOURCE_MASK(64),
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +void __init hv_init_clocksource(void)
> +{
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
> +
> +		u64		tsc_msr;
> +		phys_addr_t	phys_addr;
> +
> +		tsc_pg = vmalloc(PAGE_SIZE);
> +		if (!tsc_pg)
> +			goto register_msr_cs;
> +
> +		hyperv_cs = &hyperv_cs_tsc;
> +		phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
> +
> +		/* The Hyper-V TLFS specifies to preserve the value of
> +		 * reserved bits in registers.  So read the existing
> +		 * value, preserve the low order 12 bits, and add in
> +		 * the guest physical address (which already has at
> +		 * least the low 12 bits set to zero since it is page
> +		 * aligned). Also set the "enable" bit, which is bit 0.
> +		 */
> +		hv_get_reference_tsc(tsc_msr);
> +		tsc_msr &= GENMASK_ULL(11, 0);
> +		tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
> +		hv_set_reference_tsc(tsc_msr);
> +
> +		hv_set_clocksource_vdso(hyperv_cs_tsc);
> +		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> +
> +		/*
> +		 * sched_clock_register is needed on ARM64 but
> +		 * is a no-op on x86
> +		 */
> +		sched_clock_register(read_hv_sched_clock_tsc,
> +						64, HV_CLOCK_HZ);
> +		return;
> +	}
> +register_msr_cs:
> +#endif
> +	/*
> +	 * For 32 bit guests just use the MSR based mechanism for reading
> +	 * the partition counter.
> +	 */
> +	hyperv_cs = &hyperv_cs_msr;
> +	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE) {
> +		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
> +
> +		/*
> +		 * sched_clock_register is needed on ARM64 but
> +		 * is a no-op on x86
> +		 */
> +		sched_clock_register(read_hv_sched_clock_msr,
> +						64, HV_CLOCK_HZ);

I'm not sure about ARM, but MSR-based clocksource would be a really bad
choice for sched clock on x86, this will slow things down
significantly. Luckily, as you're validly stating above,
sched_clock_register() is a no-op on x86 as we don't define
CONFIG_GENERIC_SCHED_CLOCK.

Can we actually *not* do sched_clock_register() in case
TSC page is unavailable (and revert to counting jiffies or whatever)?

> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_init_clocksource);
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index f10eeb1..9eff85e 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -29,6 +29,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/clockchips.h>
>  #include <linux/ptp_clock_kernel.h>
> +#include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  
>  #include "hyperv_vmbus.h"
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
> index ba5dc17..e17e8a2 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -13,6 +13,10 @@
>  #ifndef __CLKSOURCE_HYPERV_TIMER_H
>  #define __CLKSOURCE_HYPERV_TIMER_H
>  
> +#include <linux/clocksource.h>
> +#include <linux/math64.h>
> +#include <asm/mshyperv.h>
> +
>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>  #define HV_MIN_DELTA_TICKS 1
>  
> @@ -24,4 +28,78 @@
>  extern void hv_stimer_global_cleanup(void);
>  extern void hv_stimer0_isr(void);
>  
> +#if IS_ENABLED(CONFIG_HYPERV)
> +extern struct clocksource *hyperv_cs;
> +extern void hv_init_clocksource(void);
> +#endif /* CONFIG_HYPERV */
> +
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	u64 scale, offset;
> +	u32 sequence;
> +
> +	/*
> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
> +	 * Top-Level Functional Specification ver. 3.0 and above. To get the
> +	 * reference time we must do the following:
> +	 * - READ ReferenceTscSequence
> +	 *   A special '0' value indicates the time source is unreliable and we
> +	 *   need to use something else. The currently published specification
> +	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
> +	 *   instead of '0' as the special value, see commit c35b82ef0294.
> +	 * - ReferenceTime =
> +	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
> +	 * - READ ReferenceTscSequence again. In case its value has changed
> +	 *   since our first reading we need to discard ReferenceTime and repeat
> +	 *   the whole sequence as the hypervisor was updating the page in
> +	 *   between.
> +	 */
> +	do {
> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);
> +		if (!sequence)
> +			return U64_MAX;
> +		/*
> +		 * Make sure we read sequence before we read other values from
> +		 * TSC page.
> +		 */
> +		smp_rmb();
> +
> +		scale = READ_ONCE(tsc_pg->tsc_scale);
> +		offset = READ_ONCE(tsc_pg->tsc_offset);
> +		*cur_tsc = hv_get_raw_timer();
> +
> +		/*
> +		 * Make sure we read sequence after we read all other values
> +		 * from TSC page.
> +		 */
> +		smp_rmb();
> +
> +	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
> +
> +	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
> +}
> +
> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
> +{
> +	u64 cur_tsc;
> +
> +	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
> +}
> +
> +#else /* CONFIG_HYPERV_TSC_PAGE */
> +static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> +{
> +	return NULL;
> +}
> +
> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
> +				       u64 *cur_tsc)
> +{
> +	return U64_MAX;
> +}
> +#endif /* CONFIG_HYPERV_TSCPAGE */
> +
>  #endif

With the (theoretical) question above answered,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
