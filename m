Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059402E14F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2019 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE2Pk7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 May 2019 11:40:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34622 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE2Pk7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 May 2019 11:40:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so2159629wrt.1
        for <linux-hyperv@vger.kernel.org>; Wed, 29 May 2019 08:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=OI3Jy/JrWiMzHeNTOD5NNihuGI91P2IEqFwXVIq1WNY=;
        b=UdgfJoyWQG9D/nB7YBszocuaElICS41iJxApNfpAHGPlnruDqWUoryGZurQXb8UBPx
         iNurlUXWkIZWkgnA6kIF03mamtDFqpgxjlWT4Sg81pf8cRxA3QLsnLyPaeQa18VgJMQD
         Zbx6T0bYCDAXovc3ntNDEaSJLC5F2M3o6oE5uuNJ2P3g7SUCNdwqcS+Ahlzi5OIvyNQY
         A5ELk1xDf4+MuD6xFmSmw0zEaAyYNpSIlEWVzqKwQrhGIjkwEL+7HIcKtR0d1Vhgkb3W
         v1zf4FRkbMuXgZZK4sCZnfxxrAZavqPEQQrsz052n0Lkk6vAwn/SWE57O+wIGnmTKBNc
         Q8QQ==
X-Gm-Message-State: APjAAAVGXdcpP8UoGUr9brS4W6LGACJyRalq08xmAjY4ZcIMDEs7WTD4
        u95kSMrkbw0wpKJIpIdVLWWvtA==
X-Google-Smtp-Source: APXvYqxaQxnsVNEKgj8MQ464Hm1KuMOdf7uPK43mmqaBRnRgbux0C+DSc1ZX2T2bTs8jkMUSOKKfvw==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr12559927wrr.234.1559144456936;
        Wed, 29 May 2019 08:40:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z65sm9507093wme.37.2019.05.29.08.40.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 08:40:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "apw\@canonical.com" <apw@canonical.com>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Break out ISA independent parts of mshyperv.h
In-Reply-To: <1559101942-4232-1-git-send-email-mikelley@microsoft.com>
References: <1559101942-4232-1-git-send-email-mikelley@microsoft.com>
Date:   Wed, 29 May 2019 17:40:55 +0200
Message-ID: <875zptmfp4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Break out parts of mshyperv.h that are ISA independent into a
> separate file in include/asm-generic. This move facilitates
> ARM64 code reusing these definitions and avoids code
> duplication. No functionality or behavior is changed.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  MAINTAINERS                     |   1 +
>  arch/x86/include/asm/mshyperv.h | 147 +-------------------------------
>  include/asm-generic/mshyperv.h  | 182 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+), 143 deletions(-)
>  create mode 100644 include/asm-generic/mshyperv.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf2a5b7..521192d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7308,6 +7308,7 @@ F:	net/vmw_vsock/hyperv_transport.c
>  F:	include/clocksource/hyperv_timer.h
>  F:	include/linux/hyperv.h
>  F:	include/uapi/linux/hyperv.h
> +F:	include/asm-generic/mshyperv.h
>  F:	tools/hv/
>  F:	Documentation/ABI/stable/sysfs-bus-vmbus
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f4fa8a9..2a793bf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -3,84 +3,15 @@
>  #define _ASM_X86_MSHYPER_H
>  
>  #include <linux/types.h>
> -#include <linux/atomic.h>
>  #include <linux/nmi.h>
>  #include <asm/io.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  
> -#define VP_INVAL	U32_MAX
> -
> -struct ms_hyperv_info {
> -	u32 features;
> -	u32 misc_features;
> -	u32 hints;
> -	u32 nested_features;
> -	u32 max_vp_index;
> -	u32 max_lp_index;
> -};
> -
> -extern struct ms_hyperv_info ms_hyperv;
> -
> -
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
>  		void *data);
>  
> -/*
> - * Generate the guest ID.
> - */
> -
> -static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
> -				       __u64 d_info2)
> -{
> -	__u64 guest_id = 0;
> -
> -	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
> -	guest_id |= (d_info1 << 48);
> -	guest_id |= (kernel_version << 16);
> -	guest_id |= d_info2;
> -
> -	return guest_id;
> -}
> -
> -
> -/* Free the message slot and signal end-of-message if required */
> -static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
> -{
> -	/*
> -	 * On crash we're reading some other CPU's message page and we need
> -	 * to be careful: this other CPU may already had cleared the header
> -	 * and the host may already had delivered some other message there.
> -	 * In case we blindly write msg->header.message_type we're going
> -	 * to lose it. We can still lose a message of the same type but
> -	 * we count on the fact that there can only be one
> -	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> -	 * on crash.
> -	 */
> -	if (cmpxchg(&msg->header.message_type, old_msg_type,
> -		    HVMSG_NONE) != old_msg_type)
> -		return;
> -
> -	/*
> -	 * Make sure the write to MessageType (ie set to
> -	 * HVMSG_NONE) happens before we read the
> -	 * MessagePending and EOMing. Otherwise, the EOMing
> -	 * will not deliver any more messages since there is
> -	 * no empty slot
> -	 */
> -	mb();
> -
> -	if (msg->header.message_flags.msg_pending) {
> -		/*
> -		 * This will cause message queue rescan to
> -		 * possibly deliver another msg from the
> -		 * hypervisor
> -		 */
> -		wrmsrl(HV_X64_MSR_EOM, 0);
> -	}
> -}
> -
>  #define hv_init_timer(timer, tick) \
>  	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
>  #define hv_init_timer_config(timer, val) \
> @@ -97,6 +28,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  
>  #define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
>  
> +#define hv_signal_eom() wrmsrl(HV_X64_MSR_EOM, 0)
> +
>  #define hv_get_synint_state(int_num, val) \
>  	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
>  #define hv_set_synint_state(int_num, val) \
> @@ -122,13 +55,6 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  #define trace_hyperv_callback_vector hyperv_callback_vector
>  #endif
>  void hyperv_vector_handler(struct pt_regs *regs);
> -void hv_setup_vmbus_irq(void (*handler)(void));
> -void hv_remove_vmbus_irq(void);
> -
> -void hv_setup_kexec_handler(void (*handler)(void));
> -void hv_remove_kexec_handler(void);
> -void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> -void hv_remove_crash_handler(void);
>  
>  /*
>   * Routines for stimer0 Direct Mode handling.
> @@ -136,8 +62,6 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>   */
>  void hv_stimer0_vector_handler(struct pt_regs *regs);
>  void hv_stimer0_callback_vector(void);
> -int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
> -void hv_remove_stimer0_irq(int irq);
>  
>  static inline void hv_enable_stimer0_percpu_irq(int irq) {}
>  static inline void hv_disable_stimer0_percpu_irq(int irq) {}
> @@ -282,14 +206,6 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>  	return status;
>  }
>  
> -/*
> - * Hypervisor's notion of virtual processor ID is different from
> - * Linux' notion of CPU ID. This information can only be retrieved
> - * in the context of the calling CPU. Setup a map for easy access
> - * to this information.
> - */
> -extern u32 *hv_vp_index;
> -extern u32 hv_max_vp_index;
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>  
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
> @@ -300,63 +216,8 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>  	return hv_vp_assist_page[cpu];
>  }
>  
> -/**
> - * hv_cpu_number_to_vp_number() - Map CPU to VP.
> - * @cpu_number: CPU number in Linux terms
> - *
> - * This function returns the mapping between the Linux processor
> - * number and the hypervisor's virtual processor number, useful
> - * in making hypercalls and such that talk about specific
> - * processors.
> - *
> - * Return: Virtual processor number in Hyper-V terms
> - */
> -static inline int hv_cpu_number_to_vp_number(int cpu_number)
> -{
> -	return hv_vp_index[cpu_number];
> -}
> -
> -static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> -				    const struct cpumask *cpus)
> -{
> -	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
> -
> -	/* valid_bank_mask can represent up to 64 banks */
> -	if (hv_max_vp_index / 64 >= 64)
> -		return 0;
> -
> -	/*
> -	 * Clear all banks up to the maximum possible bank as hv_tlb_flush_ex
> -	 * structs are not cleared between calls, we risk flushing unneeded
> -	 * vCPUs otherwise.
> -	 */
> -	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
> -		vpset->bank_contents[vcpu_bank] = 0;
> -
> -	/*
> -	 * Some banks may end up being empty but this is acceptable.
> -	 */
> -	for_each_cpu(cpu, cpus) {
> -		vcpu = hv_cpu_number_to_vp_number(cpu);
> -		if (vcpu == VP_INVAL)
> -			return -1;
> -		vcpu_bank = vcpu / 64;
> -		vcpu_offset = vcpu % 64;
> -		__set_bit(vcpu_offset, (unsigned long *)
> -			  &vpset->bank_contents[vcpu_bank]);
> -		if (vcpu_bank >= nr_bank)
> -			nr_bank = vcpu_bank + 1;
> -	}
> -	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
> -	return nr_bank;
> -}
> -
>  void __init hyperv_init(void);

I would actually expect to see hyperv_init() on all architectures so it
can probably go to 'generic' too.

>  void hyperv_setup_mmu_ops(void);
> -void hyperv_report_panic(struct pt_regs *regs, long err);
> -void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
> -bool hv_is_hyperv_initialized(void);
> -void hyperv_cleanup(void);
>  
>  void hyperv_reenlightenment_intr(struct pt_regs *regs);
>  void set_hv_tscchange_cb(void (*cb)(void));
> @@ -379,8 +240,6 @@ static inline void hv_apic_init(void) {}
>  
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> -static inline bool hv_is_hyperv_initialized(void) { return false; }
> -static inline void hyperv_cleanup(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
> @@ -397,4 +256,6 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
>  }
>  #endif /* CONFIG_HYPERV */
>  
> +#include <asm-generic/mshyperv.h>
> +
>  #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> new file mode 100644
> index 0000000..d4eaa07
> --- /dev/null
> +++ b/include/asm-generic/mshyperv.h
> @@ -0,0 +1,182 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Linux-specific definitions for managing interactions with Microsoft's
> + * Hyper-V hypervisor. The definitions in this file are architecture
> + * independent. See arch/<arch>/include/asm/mshyperv.h for definitions
> + * that are specific to architecture <arch>.
> + *
> + * Definitions that are specified in the Hyper-V Top Level Functional
> + * Spec (TLFS) should not go in this file, but should instead go in
> + * hyperv-tlfs.h.
> + *
> + * Copyright (C) 2019, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + */
> +
> +#ifndef _ASM_GENERIC_MSHYPERV_H
> +#define _ASM_GENERIC_MSHYPERV_H
> +
> +#include <linux/types.h>
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/clocksource.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <asm/hyperv-tlfs.h>

This seems a little bit too much, in particular, I think we don't need

 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>

we'll need 'struct pt_regs' definition but I'd suggest we use 

 #include <linux/ptrace.h>

or even

 #include <asm/ptrace.h>

> +
> +struct ms_hyperv_info {
> +	u32 features;
> +	u32 misc_features;
> +	u32 hints;
> +	u32 nested_features;
> +	u32 max_vp_index;
> +	u32 max_lp_index;
> +};
> +extern struct ms_hyperv_info ms_hyperv;
> +
> +extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
> +extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> +
> +
> +/* Generate the guest OS identifier as described in the Hyper-V TLFS */
> +static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
> +				       __u64 d_info2)
> +{
> +	__u64 guest_id = 0;
> +
> +	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
> +	guest_id |= (d_info1 << 48);
> +	guest_id |= (kernel_version << 16);
> +	guest_id |= d_info2;
> +
> +	return guest_id;
> +}
> +
> +
> +/* Free the message slot and signal end-of-message if required */
> +static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
> +{
> +	/*
> +	 * On crash we're reading some other CPU's message page and we need
> +	 * to be careful: this other CPU may already had cleared the header
> +	 * and the host may already had delivered some other message there.
> +	 * In case we blindly write msg->header.message_type we're going
> +	 * to lose it. We can still lose a message of the same type but
> +	 * we count on the fact that there can only be one
> +	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> +	 * on crash.
> +	 */
> +	if (cmpxchg(&msg->header.message_type, old_msg_type,
> +		    HVMSG_NONE) != old_msg_type)
> +		return;
> +
> +	/*
> +	 * The cmxchg() above does an implicit memory barrier to
> +	 * ensure the write to MessageType (ie set to
> +	 * HVMSG_NONE) happens before we read the
> +	 * MessagePending and EOMing. Otherwise, the EOMing
> +	 * will not deliver any more messages since there is
> +	 * no empty slot
> +	 */
> +	if (msg->header.message_flags.msg_pending) {
> +		/*
> +		 * This will cause message queue rescan to
> +		 * possibly deliver another msg from the
> +		 * hypervisor
> +		 */
> +		hv_signal_eom();
> +	}
> +}
> +
> +void hv_setup_vmbus_irq(void (*handler)(void));
> +void hv_remove_vmbus_irq(void);
> +void hv_enable_vmbus_irq(void);
> +void hv_disable_vmbus_irq(void);
> +
> +void hv_setup_kexec_handler(void (*handler)(void));
> +void hv_remove_kexec_handler(void);
> +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> +void hv_remove_crash_handler(void);
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +/*
> + * Hypervisor's notion of virtual processor ID is different from
> + * Linux' notion of CPU ID. This information can only be retrieved
> + * in the context of the calling CPU. Setup a map for easy access
> + * to this information.
> + */
> +extern u32 *hv_vp_index;
> +extern u32 hv_max_vp_index;
> +
> +/* Sentinel value for an uninitialized entry in hv_vp_index array */
> +#define VP_INVAL	U32_MAX
> +
> +/**
> + * hv_cpu_number_to_vp_number() - Map CPU to VP.
> + * @cpu_number: CPU number in Linux terms
> + *
> + * This function returns the mapping between the Linux processor
> + * number and the hypervisor's virtual processor number, useful
> + * in making hypercalls and such that talk about specific
> + * processors.
> + *
> + * Return: Virtual processor number in Hyper-V terms
> + */
> +static inline int hv_cpu_number_to_vp_number(int cpu_number)
> +{
> +	return hv_vp_index[cpu_number];
> +}
> +
> +static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus)
> +{
> +	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
> +
> +	/* valid_bank_mask can represent up to 64 banks */
> +	if (hv_max_vp_index / 64 >= 64)
> +		return 0;
> +
> +	/*
> +	 * Clear all banks up to the maximum possible bank as hv_tlb_flush_ex
> +	 * structs are not cleared between calls, we risk flushing unneeded
> +	 * vCPUs otherwise.
> +	 */
> +	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
> +		vpset->bank_contents[vcpu_bank] = 0;
> +
> +	/*
> +	 * Some banks may end up being empty but this is acceptable.
> +	 */
> +	for_each_cpu(cpu, cpus) {
> +		vcpu = hv_cpu_number_to_vp_number(cpu);
> +		if (vcpu == VP_INVAL)
> +			return -1;
> +		vcpu_bank = vcpu / 64;
> +		vcpu_offset = vcpu % 64;
> +		__set_bit(vcpu_offset, (unsigned long *)
> +			  &vpset->bank_contents[vcpu_bank]);
> +		if (vcpu_bank >= nr_bank)
> +			nr_bank = vcpu_bank + 1;
> +	}
> +	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
> +	return nr_bank;
> +}
> +
> +void hyperv_report_panic(struct pt_regs *regs, long err);
> +void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
> +bool hv_is_hyperv_initialized(void);
> +void hyperv_cleanup(void);
> +#else /* CONFIG_HYPERV */
> +static inline bool hv_is_hyperv_initialized(void) { return false; }
> +static inline void hyperv_cleanup(void) {}
> +#endif /* CONFIG_HYPERV */
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +extern int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
> +extern void hv_remove_stimer0_irq(int irq);
> +#endif
> +
> +#endif

With the nitpicks above,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
