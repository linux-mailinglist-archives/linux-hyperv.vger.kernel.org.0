Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585652F98E
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2019 11:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE3JhQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 May 2019 05:37:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50344 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfE3JhQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 May 2019 05:37:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so3518633wme.0
        for <linux-hyperv@vger.kernel.org>; Thu, 30 May 2019 02:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ShwOJ60aRZAjC2iH5L7KlF/UIaNmpEDMLO46DG/ENXU=;
        b=HI54Rw+cEf9FSSt7I9k5CL+MsvNII86dHzvJPz3MIL7Z5lHQM8Hs/NaQMgleuuT4qa
         i9ryYwV63uL2lJgFRChYxq2/bWwOh62COSAjZJE4A+fpGHcmtBNAUHIgVkktRDX+m4G7
         i6ng7Ebn1DekMLwV9vBrWfCv0o8P4VszLIWZ8nv7Y5Ocrv8FKnGkAIaDHIeDXyd4oRsU
         soUeKkPgbOfiGSDtCuXIwwuKKQHp0cZU8igT7y01wVafQVVCh/MZhITnjj3y/Zdyz1g/
         o+ozqiJYDDfeJKQQBe2ILTb+qyp5D1RuaHbrRWApUi5Nbp8e+BdwfytKkWv/xVdx119R
         v1EA==
X-Gm-Message-State: APjAAAXE4sy35SlHQ6EpgKhA0NGQG3uoFjxL1JKNchJjcnYSMPPTDg5v
        r3pbiwBLtC6JVH+tK2KiDg7Izw==
X-Google-Smtp-Source: APXvYqyJT5BQUJnkMj7gYs0OS/1B1z2wO9NPorW/umLNElUumMxIOTbaUgMD4s/RsWHzenS5ubXDRQ==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr1685130wmc.29.1559209032212;
        Thu, 30 May 2019 02:37:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (cst-prg-69-174.cust.vodafone.cz. [46.135.69.174])
        by smtp.gmail.com with ESMTPSA id f65sm2374755wmg.45.2019.05.30.02.37.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 02:37:11 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/2] Drivers: hv: Create Hyper-V clocksource driver from existing clockevents code
In-Reply-To: <1558969089-13204-2-git-send-email-mikelley@microsoft.com>
References: <1558969089-13204-1-git-send-email-mikelley@microsoft.com> <1558969089-13204-2-git-send-email-mikelley@microsoft.com>
Date:   Thu, 30 May 2019 11:37:10 +0200
Message-ID: <87tvdcl1vd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Clockevents code for Hyper-V synthetic timers is currently mixed
> in with other Hyper-V code. Move the code to a Hyper-V specific
> driver in the "clocksource" directory. Update the VMbus driver
> to call initialization and cleanup routines since the Hyper-V
> synthetic timers are not independently enumerated in ACPI.
>
> No behavior is changed and no new functionality is added.
>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  MAINTAINERS                        |   2 +
>  arch/x86/include/asm/hyperv-tlfs.h |   6 ++
>  arch/x86/kernel/cpu/mshyperv.c     |   2 +
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/hyperv_timer.c | 191 +++++++++++++++++++++++++++++++++++++
>  drivers/hv/Kconfig                 |   3 +
>  drivers/hv/hv.c                    | 156 +-----------------------------
>  drivers/hv/hyperv_vmbus.h          |   3 -
>  drivers/hv/vmbus_drv.c             |  42 ++++----
>  include/clocksource/hyperv_timer.h |  27 ++++++
>  10 files changed, 258 insertions(+), 175 deletions(-)
>  create mode 100644 drivers/clocksource/hyperv_timer.c
>  create mode 100644 include/clocksource/hyperv_timer.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992f1dd..cf2a5b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7294,6 +7294,7 @@ F:	arch/x86/include/asm/trace/hyperv.h
>  F:	arch/x86/include/asm/hyperv-tlfs.h
>  F:	arch/x86/kernel/cpu/mshyperv.c
>  F:	arch/x86/hyperv
> +F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> @@ -7304,6 +7305,7 @@ F:	drivers/uio/uio_hv_generic.c
>  F:	drivers/video/fbdev/hyperv_fb.c
>  F:	drivers/iommu/hyperv_iommu.c
>  F:	net/vmw_vsock/hyperv_transport.c
> +F:	include/clocksource/hyperv_timer.h
>  F:	include/linux/hyperv.h
>  F:	include/uapi/linux/hyperv.h
>  F:	tools/hv/
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index cdf44aa..af78cd7 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -401,6 +401,12 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
>  
> +/*
> + * The Hyper-V TimeRefCount register and the TSC
> + * page provide a guest VM clock with 100ns tick rate
> + */
> +#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
> +
>  typedef struct _HV_REFERENCE_TSC_PAGE {
>  	__u32 tsc_sequence;
>  	__u32 res1;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index faae611..b18ede4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -21,6 +21,7 @@
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
>  #include <linux/i8253.h>
> +#include <linux/random.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -84,6 +85,7 @@ __visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
>  	inc_irq_stat(hyperv_stimer0_count);
>  	if (hv_stimer0_handler)
>  		hv_stimer0_handler();
> +	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
>  	ack_APIC_irq();
>  
>  	exiting_irq();
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 236858f..2b65c5f 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
>  obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
> +obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> new file mode 100644
> index 0000000..30615f3
> --- /dev/null
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Clocksource driver for the synthetic counter and timers
> + * provided by the Hyper-V hypervisor to guest VMs, as described
> + * in the Hyper-V Top Level Functional Spec (TLFS). This driver
> + * is instruction set architecture independent.
> + *
> + * Copyright (C) 2019, Microsoft, Inc.
> + *
> + * Author:  Michael Kelley <mikelley@microsoft.com>
> + */
> +
> +#include <linux/percpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/clockchips.h>
> +#include <linux/mm.h>
> +#include <clocksource/hyperv_timer.h>
> +#include <asm/hyperv-tlfs.h>
> +#include <asm/mshyperv.h>
> +
> +static struct clock_event_device __percpu *hv_clock_event;
> +
> +/*
> + * If false, we're using the old mechanism for stimer0 interrupts
> + * where it sends a VMbus message when it expires. The old
> + * mechanism is used when running on older versions of Hyper-V
> + * that don't support Direct Mode. While Hyper-V provides
> + * four stimer's per CPU, Linux uses only stimer0.
> + */
> +static bool direct_mode_enabled;
> +
> +static int stimer0_irq;
> +static int stimer0_vector;
> +static int stimer0_message_sint;
> +
> +/*
> + * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
> + * does not use VMbus or any VMbus messages, so process here and not
> + * in the VMbus driver code.
> + */
> +void hv_stimer0_isr(void)
> +{
> +	struct clock_event_device *ce;
> +
> +	ce = this_cpu_ptr(hv_clock_event);
> +	ce->event_handler(ce);
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer0_isr);
> +
> +static int hv_ce_set_next_event(unsigned long delta,
> +				struct clock_event_device *evt)
> +{
> +	u64 current_tick;
> +
> +	WARN_ON(!clockevent_state_oneshot(evt));
> +
> +	current_tick = hyperv_cs->read(NULL);
> +	current_tick += delta;
> +	hv_init_timer(0, current_tick);
> +	return 0;
> +}
> +
> +static int hv_ce_shutdown(struct clock_event_device *evt)
> +{
> +	hv_init_timer(0, 0);
> +	hv_init_timer_config(0, 0);
> +	if (direct_mode_enabled)
> +		hv_disable_stimer0_percpu_irq(stimer0_irq);
> +
> +	return 0;
> +}
> +
> +static int hv_ce_set_oneshot(struct clock_event_device *evt)
> +{
> +	union hv_stimer_config timer_cfg;
> +
> +	timer_cfg.as_uint64 = 0;
> +	timer_cfg.enable = 1;
> +	timer_cfg.auto_enable = 1;
> +	if (direct_mode_enabled) {
> +		/*
> +		 * When it expires, the timer will directly interrupt
> +		 * on the specified hardware vector/IRQ.
> +		 */
> +		timer_cfg.direct_mode = 1;
> +		timer_cfg.apic_vector = stimer0_vector;
> +		hv_enable_stimer0_percpu_irq(stimer0_irq);
> +	} else {
> +		/*
> +		 * When it expires, the timer will generate a VMbus message,
> +		 * to be handled by the normal VMbus interrupt handler.
> +		 */
> +		timer_cfg.direct_mode = 0;
> +		timer_cfg.sintx = stimer0_message_sint;
> +	}
> +	hv_init_timer_config(0, timer_cfg.as_uint64);
> +	return 0;
> +}
> +
> +/*
> + * hv_stimer_init - Per-cpu initialization of the clockevent
> + */
> +int hv_stimer_init(unsigned int cpu)
> +{
> +	struct clock_event_device *ce;
> +
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +		ce = per_cpu_ptr(hv_clock_event, cpu);
> +		ce->name = "Hyper-V clockevent";
> +		ce->features = CLOCK_EVT_FEAT_ONESHOT;
> +		ce->cpumask = cpumask_of(cpu);
> +		ce->rating = 1000;
> +		ce->set_state_shutdown = hv_ce_shutdown;
> +		ce->set_state_oneshot = hv_ce_set_oneshot;
> +		ce->set_next_event = hv_ce_set_next_event;
> +
> +		clockevents_config_and_register(ce,
> +						HV_CLOCK_HZ,
> +						HV_MIN_DELTA_TICKS,
> +						HV_MAX_MAX_DELTA_TICKS);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_init);
> +
> +/*
> + * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
> + */
> +int hv_stimer_cleanup(unsigned int cpu)
> +{
> +	struct clock_event_device *ce;
> +
> +	/* Turn off clockevent device */
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +		ce = per_cpu_ptr(hv_clock_event, cpu);
> +		clockevents_unbind_device(ce, cpu);
> +		hv_ce_shutdown(ce);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
> +
> +/* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
> +int hv_stimer_alloc(int sint)
> +{
> +	hv_clock_event = alloc_percpu(struct clock_event_device);
> +	if (!hv_clock_event)
> +		return -ENOMEM;
> +
> +	direct_mode_enabled = ms_hyperv.misc_features &
> +			HV_STIMER_DIRECT_MODE_AVAILABLE;
> +	if (direct_mode_enabled &&
> +	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
> +				hv_stimer0_isr)) {
> +		free_percpu(hv_clock_event);
> +		return -EINVAL;
> +	}
> +
> +	stimer0_message_sint = sint;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_alloc);
> +
> +/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
> +void hv_stimer_free(void)
> +{
> +	if (direct_mode_enabled)
> +		hv_remove_stimer0_irq(stimer0_irq);
> +	free_percpu(hv_clock_event);
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_free);
> +
> +/*
> + * Do a global cleanup of clockevents for the cases of kexec and
> + * vmbus exit
> + */
> +void hv_stimer_global_cleanup(void)
> +{
> +	int	cpu;
> +	struct clock_event_device *ce;
> +
> +	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
> +		for_each_present_cpu(cpu) {
> +			ce = per_cpu_ptr(hv_clock_event, cpu);
> +			clockevents_unbind_device(ce, cpu);
> +		}
> +	hv_stimer_free();
> +}
> +EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 1c1a251..c423e57 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -10,6 +10,9 @@ config HYPERV
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
>  
> +config HYPERV_TIMER
> +	def_bool HYPERV
> +
>  config HYPERV_TSCPAGE
>         def_bool HYPERV && X86_64
>  
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4565302..bd6452f 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -29,6 +29,7 @@
>  #include <linux/version.h>
>  #include <linux/random.h>
>  #include <linux/clockchips.h>

(very minor nit, just an idea for future cleanup):

I think we can throw away

 #include <linux/random.h>
 #include <linux/clockchips.h>

now.

> +#include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
>  
> @@ -36,21 +37,6 @@
>  struct hv_context hv_context;
>  
>  /*
> - * If false, we're using the old mechanism for stimer0 interrupts
> - * where it sends a VMbus message when it expires. The old
> - * mechanism is used when running on older versions of Hyper-V
> - * that don't support Direct Mode. While Hyper-V provides
> - * four stimer's per CPU, Linux uses only stimer0.
> - */
> -static bool direct_mode_enabled;
> -static int stimer0_irq;
> -static int stimer0_vector;
> -
> -#define HV_TIMER_FREQUENCY (10 * 1000 * 1000) /* 100ns period */
> -#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
> -#define HV_MIN_DELTA_TICKS 1
> -
> -/*
>   * hv_init - Main initialization routine.
>   *
>   * This routine must be called before any other routines in here are called
> @@ -60,9 +46,6 @@ int hv_init(void)
>  	hv_context.cpu_context = alloc_percpu(struct hv_per_cpu_context);
>  	if (!hv_context.cpu_context)
>  		return -ENOMEM;
> -
> -	direct_mode_enabled = ms_hyperv.misc_features &
> -			HV_STIMER_DIRECT_MODE_AVAILABLE;
>  	return 0;
>  }
>  
> @@ -101,89 +84,6 @@ int hv_post_message(union hv_connection_id connection_id,
>  	return status & 0xFFFF;
>  }
>  
> -/*
> - * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
> - * does not use VMbus or any VMbus messages, so process here and not
> - * in the VMbus driver code.
> - */
> -
> -static void hv_stimer0_isr(void)
> -{
> -	struct hv_per_cpu_context *hv_cpu;
> -
> -	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
> -	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
> -	add_interrupt_randomness(stimer0_vector, 0);
> -}
> -
> -static int hv_ce_set_next_event(unsigned long delta,
> -				struct clock_event_device *evt)
> -{
> -	u64 current_tick;
> -
> -	WARN_ON(!clockevent_state_oneshot(evt));
> -
> -	current_tick = hyperv_cs->read(NULL);
> -	current_tick += delta;
> -	hv_init_timer(0, current_tick);
> -	return 0;
> -}
> -
> -static int hv_ce_shutdown(struct clock_event_device *evt)
> -{
> -	hv_init_timer(0, 0);
> -	hv_init_timer_config(0, 0);
> -	if (direct_mode_enabled)
> -		hv_disable_stimer0_percpu_irq(stimer0_irq);
> -
> -	return 0;
> -}
> -
> -static int hv_ce_set_oneshot(struct clock_event_device *evt)
> -{
> -	union hv_stimer_config timer_cfg;
> -
> -	timer_cfg.as_uint64 = 0;
> -	timer_cfg.enable = 1;
> -	timer_cfg.auto_enable = 1;
> -	if (direct_mode_enabled) {
> -		/*
> -		 * When it expires, the timer will directly interrupt
> -		 * on the specified hardware vector/IRQ.
> -		 */
> -		timer_cfg.direct_mode = 1;
> -		timer_cfg.apic_vector = stimer0_vector;
> -		hv_enable_stimer0_percpu_irq(stimer0_irq);
> -	} else {
> -		/*
> -		 * When it expires, the timer will generate a VMbus message,
> -		 * to be handled by the normal VMbus interrupt handler.
> -		 */
> -		timer_cfg.direct_mode = 0;
> -		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> -	}
> -	hv_init_timer_config(0, timer_cfg.as_uint64);
> -	return 0;
> -}
> -
> -static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
> -{
> -	dev->name = "Hyper-V clockevent";
> -	dev->features = CLOCK_EVT_FEAT_ONESHOT;
> -	dev->cpumask = cpumask_of(cpu);
> -	dev->rating = 1000;
> -	/*
> -	 * Avoid settint dev->owner = THIS_MODULE deliberately as doing so will
> -	 * result in clockevents_config_and_register() taking additional
> -	 * references to the hv_vmbus module making it impossible to unload.
> -	 */
> -
> -	dev->set_state_shutdown = hv_ce_shutdown;
> -	dev->set_state_oneshot = hv_ce_set_oneshot;
> -	dev->set_next_event = hv_ce_set_next_event;
> -}
> -
> -
>  int hv_synic_alloc(void)
>  {
>  	int cpu;
> @@ -212,14 +112,6 @@ int hv_synic_alloc(void)
>  		tasklet_init(&hv_cpu->msg_dpc,
>  			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>  
> -		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
> -					  GFP_KERNEL);
> -		if (hv_cpu->clk_evt == NULL) {
> -			pr_err("Unable to allocate clock event device\n");
> -			goto err;
> -		}
> -		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
> -
>  		hv_cpu->synic_message_page =
>  			(void *)get_zeroed_page(GFP_ATOMIC);
>  		if (hv_cpu->synic_message_page == NULL) {
> @@ -242,11 +134,6 @@ int hv_synic_alloc(void)
>  		INIT_LIST_HEAD(&hv_cpu->chan_list);
>  	}
>  
> -	if (direct_mode_enabled &&
> -	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
> -				hv_stimer0_isr))
> -		goto err;
> -
>  	return 0;
>  err:
>  	/*
> @@ -265,7 +152,6 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
> -		kfree(hv_cpu->clk_evt);
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> @@ -324,36 +210,9 @@ int hv_synic_init(unsigned int cpu)
>  
>  	hv_set_synic_state(sctrl.as_uint64);
>  
> -	/*
> -	 * Register the per-cpu clockevent source.
> -	 */
> -	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
> -		clockevents_config_and_register(hv_cpu->clk_evt,
> -						HV_TIMER_FREQUENCY,
> -						HV_MIN_DELTA_TICKS,
> -						HV_MAX_MAX_DELTA_TICKS);
> -	return 0;
> -}
> -
> -/*
> - * hv_synic_clockevents_cleanup - Cleanup clockevent devices
> - */
> -void hv_synic_clockevents_cleanup(void)
> -{
> -	int cpu;
> +	hv_stimer_init(cpu);
>  
> -	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
> -		return;
> -
> -	if (direct_mode_enabled)
> -		hv_remove_stimer0_irq(stimer0_irq);
> -
> -	for_each_present_cpu(cpu) {
> -		struct hv_per_cpu_context *hv_cpu
> -			= per_cpu_ptr(hv_context.cpu_context, cpu);
> -
> -		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
> -	}
> +	return 0;
>  }
>  
>  /*
> @@ -401,14 +260,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  	if (channel_found && vmbus_connection.conn_state == CONNECTED)
>  		return -EBUSY;
>  
> -	/* Turn off clockevent device */
> -	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> -		struct hv_per_cpu_context *hv_cpu
> -			= this_cpu_ptr(hv_context.cpu_context);
> -
> -		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
> -		hv_ce_shutdown(hv_cpu->clk_evt);
> -	}
> +	hv_stimer_cleanup(cpu);
>  
>  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>  
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index e5467b8..a8f8aee 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -151,7 +151,6 @@ struct hv_per_cpu_context {
>  	 * per-cpu list of the channels based on their CPU affinity.
>  	 */
>  	struct list_head chan_list;
> -	struct clock_event_device *clk_evt;
>  };
>  
>  struct hv_context {
> @@ -189,8 +188,6 @@ extern int hv_post_message(union hv_connection_id connection_id,
>  
>  extern int hv_synic_cleanup(unsigned int cpu);
>  
> -extern void hv_synic_clockevents_cleanup(void);
> -
>  /* Interface */
>  
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1cb9408..89aca5d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -43,6 +43,7 @@
>  #include <linux/kdebug.h>
>  #include <linux/efi.h>
>  #include <linux/random.h>
> +#include <clocksource/hyperv_timer.h>
>  #include "hyperv_vmbus.h"
>  
>  struct vmbus_dynid {
> @@ -968,17 +969,6 @@ static void vmbus_onmessage_work(struct work_struct *work)
>  	kfree(ctx);
>  }
>  
> -static void hv_process_timer_expiration(struct hv_message *msg,
> -					struct hv_per_cpu_context *hv_cpu)
> -{
> -	struct clock_event_device *dev = hv_cpu->clk_evt;
> -
> -	if (dev->event_handler)
> -		dev->event_handler(dev);
> -
> -	vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
> -}
> -
>  void vmbus_on_msg_dpc(unsigned long data)
>  {
>  	struct hv_per_cpu_context *hv_cpu = (void *)data;
> @@ -1172,9 +1162,10 @@ static void vmbus_isr(void)
>  
>  	/* Check if there are actual msgs to be processed */
>  	if (msg->header.message_type != HVMSG_NONE) {
> -		if (msg->header.message_type == HVMSG_TIMER_EXPIRED)
> -			hv_process_timer_expiration(msg, hv_cpu);
> -		else
> +		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
> +			hv_stimer0_isr();
> +			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
> +		} else
>  			tasklet_schedule(&hv_cpu->msg_dpc);
>  	}
>  
> @@ -1276,14 +1267,19 @@ static int vmbus_bus_init(void)
>  	ret = hv_synic_alloc();
>  	if (ret)
>  		goto err_alloc;
> +
> +	ret = hv_stimer_alloc(VMBUS_MESSAGE_SINT);
> +	if (ret < 0)
> +		goto err_alloc;
> +
>  	/*
> -	 * Initialize the per-cpu interrupt state and
> -	 * connect to the host.
> +	 * Initialize the per-cpu interrupt state and stimer state.
> +	 * Then connect to the host.
>  	 */
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
>  				hv_synic_init, hv_synic_cleanup);
>  	if (ret < 0)
> -		goto err_alloc;
> +		goto err_cpuhp;
>  	hyperv_cpuhp_online = ret;
>  
>  	ret = vmbus_connect();
> @@ -1331,6 +1327,8 @@ static int vmbus_bus_init(void)
>  
>  err_connect:
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> +err_cpuhp:
> +	hv_stimer_free();
>  err_alloc:
>  	hv_synic_free();
>  	hv_remove_vmbus_irq();
> @@ -2077,7 +2075,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
>  
>  static void hv_kexec_handler(void)
>  {
> -	hv_synic_clockevents_cleanup();
> +	hv_stimer_global_cleanup();
>  	vmbus_initiate_unload(false);
>  	vmbus_connection.conn_state = DISCONNECTED;
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
> @@ -2088,6 +2086,8 @@ static void hv_kexec_handler(void)
>  
>  static void hv_crash_handler(struct pt_regs *regs)
>  {
> +	int cpu;
> +
>  	vmbus_initiate_unload(true);
>  	/*
>  	 * In crash handler we can't schedule synic cleanup for all CPUs,
> @@ -2095,7 +2095,9 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	 * for kdump.
>  	 */
>  	vmbus_connection.conn_state = DISCONNECTED;
> -	hv_synic_cleanup(smp_processor_id());
> +	cpu = smp_processor_id();
> +	hv_stimer_cleanup(cpu);
> +	hv_synic_cleanup(cpu);
>  	hyperv_cleanup();
>  };
>  
> @@ -2144,7 +2146,7 @@ static void __exit vmbus_exit(void)
>  	hv_remove_kexec_handler();
>  	hv_remove_crash_handler();
>  	vmbus_connection.conn_state = DISCONNECTED;
> -	hv_synic_clockevents_cleanup();
> +	hv_stimer_global_cleanup();
>  	vmbus_disconnect();
>  	hv_remove_vmbus_irq();
>  	for_each_online_cpu(cpu) {
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
> new file mode 100644
> index 0000000..ba5dc17
> --- /dev/null
> +++ b/include/clocksource/hyperv_timer.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Definitions for the clocksource provided by the Hyper-V
> + * hypervisor to guest VMs, as described in the Hyper-V Top
> + * Level Functional Spec (TLFS).
> + *
> + * Copyright (C) 2019, Microsoft, Inc.
> + *
> + * Author:  Michael Kelley <mikelley@microsoft.com>
> + */
> +
> +#ifndef __CLKSOURCE_HYPERV_TIMER_H
> +#define __CLKSOURCE_HYPERV_TIMER_H
> +
> +#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
> +#define HV_MIN_DELTA_TICKS 1
> +
> +/* Routines called by the VMbus driver */
> +extern int hv_stimer_alloc(int sint);
> +extern void hv_stimer_free(void);
> +extern int hv_stimer_init(unsigned int cpu);
> +extern int hv_stimer_cleanup(unsigned int cpu);
> +extern void hv_stimer_global_cleanup(void);
> +extern void hv_stimer0_isr(void);
> +
> +#endif

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
