Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C21DAE2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2020 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgETI7b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 May 2020 04:59:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37964 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETI7a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 May 2020 04:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589965168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3K31+CkjqsWja9VmAxfy2jggT3g//RvDqRvf75ZIamg=;
        b=i+kOztJHpza1ArtAXwgMy7cF0O2bKaM+/oxKc+Sn8lpkDVTKHKJTGPEJxmpZ4Xl9LC5fXt
        Yy08Z9hr6m5Vbonu5IZM4yF6J8N4DEDoJp6JBw/mp0onLh8E1nylo1O3iRfAsCACbdQE3o
        hTMDYJo1LCwTDAL3OM7HqjKePOndIvw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-V2d1HT8bO6KrkM17u2c7OA-1; Wed, 20 May 2020 04:59:26 -0400
X-MC-Unique: V2d1HT8bO6KrkM17u2c7OA-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1134263wrs.2
        for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2020 01:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3K31+CkjqsWja9VmAxfy2jggT3g//RvDqRvf75ZIamg=;
        b=pKEjUVsrxiYSuiw5rOV3rBc9fi7FqFhLHjEQJtcPLRS3VVJH4Xc9yI0EKzOLTnJhBY
         Ykjn8SIaKrD1CEx1XjzQ5kUFLGBb5FCV9riojjqq69iKrLlTE6/G8EtzwmlS+p3G/y04
         Y7dQw4VVKCS70xlwyiDUIJlSWRiP+A55Yd8iwzC8CS2bOhmrMWrynIfxtYGskkPCGSws
         2PcrPe5m1vxzrKoDWAA/A2aYw6s7+ZgfyBE4LOXobWs1Y0YWj2D8KZ5YAkR0CmLBW7de
         lP+g2vOaFAMfmUYB+5znJmTskgCjVU0HnYb8tXb0eZIg6IbKkCz5NQrsF5ukg1xp+X8A
         q07A==
X-Gm-Message-State: AOAM532lj0L0CefmXbblWBNtn9vSON7d86CQukJSddbOs108boA8eN4s
        yu52gtqY9x7L8ZPGqMvbHWtxeaCPGuNqC1Bv9YSnB7h4RcFkzNXvKHM17OTUT+yF+9eLB4OTlMm
        FPlo4SpcbvROpF0fBCW9Fx5zk
X-Received: by 2002:adf:ed06:: with SMTP id a6mr3161453wro.8.1589965164670;
        Wed, 20 May 2020 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQNbF8H6oN3p9RIlNTE0m0OOP48hs2rXQdUo9XPRTFzxTM8zDzi9KCcVKAuKx0qAU+7wYq5A==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr3161428wro.8.1589965164321;
        Wed, 20 May 2020 01:59:24 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r9sm2320590wmg.47.2020.05.20.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:59:23 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] x86/Hyper-V: Support for free page reporting
In-Reply-To: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
Date:   Wed, 20 May 2020 10:59:22 +0200
Message-ID: <87ftbvt21h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sunil Muthuswamy <sunilmut@microsoft.com> writes:

> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> First patch mail bounced backed. Sending it again with the email
> addresses fixed.
> ---
>  arch/x86/hyperv/hv_init.c         | 24 ++++++++
>  arch/x86/kernel/cpu/mshyperv.c    |  6 +-
>  drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 29 ++++++++++
>  include/asm-generic/mshyperv.h    |  2 +
>  5 files changed, 152 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 624f5d9b0f79..925e2f7eb82c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -506,3 +506,27 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +u64 hv_query_ext_cap(void)
> +{

As the only usage of this function looks like

if (!(hv_query_ext_cap() & HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT))

I would've change the interface to 

bool hv_query_ext_cap(u64 cap)

so the usage would look like

if (!(hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT))
...

> +	u64 *cap;
> +	unsigned long flags;
> +	u64 ext_cap = 0;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if the
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.b_features & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return 0;
> +
> +	local_irq_save(flags);
> +	cap = *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) ==
> +	    HV_STATUS_SUCCESS)
> +		ext_cap = *cap;
> +
> +	local_irq_restore(flags);
> +	return ext_cap;
> +}
> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index ebf34c7bc8bc..2de3f692c8bf 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -224,11 +224,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.b_features = cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
> +		ms_hyperv.misc_features);

HYPERV_CPUID_FEATURES(0x40000003) EAX and EBX correspond to Partition
Privilege Flags (TLFS), I'd suggest to take the opportunity and rename
this to something like 'privilege flags low=0x%x high=0x%x'.

Also, I don't quite like 'ms_hyperv.b_features' as I'll always have to
look at what it's being assigned to understand what it holds. I'd even
suggest to rename ms_hyperv.features to ms_hyperv.priv_low and
ms_hyperv.b_features tp ms_hyperv.priv_high. Or maybe even better, pack
them to the same 'u64 ms_hyperv.privileges'.

>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..77be31094556 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -21,6 +21,7 @@
>  #include <linux/memory.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/page_reporting.h>
>  
>  #include <linux/hyperv.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -563,6 +564,10 @@ struct hv_dynmem_device {
>  	 * The negotiated version agreed by host.
>  	 */
>  	__u32 version;
> +
> +#ifdef CONFIG_PAGE_REPORTING
> +	struct page_reporting_dev_info pr_dev_info;
> +#endif
>  };
>  
>  static struct hv_dynmem_device dm_device;
> @@ -1565,6 +1570,83 @@ static void balloon_onchannelcallback(void *context)
>  
>  }
>  
> +#ifdef CONFIG_PAGE_REPORTING
> +static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> +		    struct scatterlist *sgl, unsigned int nents)
> +{
> +	unsigned long flags;
> +	struct hv_memory_hint *hint;
> +	int i;
> +	u64 status;
> +	struct scatterlist *sg;
> +
> +	WARN_ON(nents > HV_MAX_GPA_PAGE_RANGES);
> +	local_irq_save(flags);
> +	hint = *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (!hint) {
> +		local_irq_restore(flags);
> +		return -ENOSPC;
> +	}
> +
> +	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> +	hint->reserved = 0;
> +	for (i = 0, sg = sgl; sg; sg = sg_next(sg), i++) {
> +		int order;
> +		union hv_gpa_page_range *range;
> +
> +		order = get_order(sg->length);
> +		range = &hint->ranges[i];
> +		range->address_space = 0;
> +		range->page.largepage = 1;

Why is largepage always '1'?

> +		range->page.additional_pages = (1ull << (order - 9)) - 1;
> +		range->base_large_pfn = page_to_pfn(sg_page(sg)) >> 9;

What is '9'? Could you please define it through PAGE_*/HPAGE_* macro?

> +	}
> +
> +	status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
> +				     hint, NULL);
> +	local_irq_restore(flags);
> +	status &= HV_HYPERCALL_RESULT_MASK;
> +	if (status != HV_STATUS_SUCCESS) {

Nit: you could've just used

        if (status & HV_HYPERCALL_RESULT_MASK != HV_STATUS_SUCCESS) {
        ...

> +		pr_err("Cold memory discard hypercall failed with status %llx\n",
> +			status);
> +		return -1;

-EFAULT or something like it maybe?

> +	}
> +
> +	return 0;
> +}
> +
> +static int enable_page_reporting(void)
> +{
> +	int ret;
> +
> +	if (!(hv_query_ext_cap() &
> +	      HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
> +		pr_info("Cold memory discard hint not supported by Hyper-V\n");
> +		return 0;
> +	}
> +
> +	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MAX_GPA_PAGE_RANGES);
> +	dm_device.pr_dev_info.report = hv_free_page_report;
> +	ret = page_reporting_register(&dm_device.pr_dev_info);
> +	if (ret < 0) {
> +		dm_device.pr_dev_info.report = NULL;
> +		pr_err("Failed to enable cold memory discard: %d\n", ret);
> +	} else {
> +		pr_info("Cold memory discard hint enabled\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void disable_page_reporting(void)
> +{
> +	if (dm_device.pr_dev_info.report) {
> +		page_reporting_unregister(&dm_device.pr_dev_info);
> +		dm_device.pr_dev_info.report = NULL;
> +	}
> +}
> +#endif //CONFIG_PAGE_REPORTING
> +
>  static int balloon_connect_vsp(struct hv_device *dev)
>  {
>  	struct dm_version_request version_req;
> @@ -1710,6 +1792,11 @@ static int balloon_probe(struct hv_device *dev,
>  	if (ret != 0)
>  		return ret;
>  
> +#ifdef CONFIG_PAGE_REPORTING
> +	if (enable_page_reporting() < 0)
> +		goto probe_error;

Why? The hyperv-balloon driver itself may still be functional and you
already set dm_device.pr_dev_info.report to NULL.

> +#endif
> +
>  	dm_device.state = DM_INITIALIZED;
>  
>  	dm_device.thread =
> @@ -1728,6 +1815,9 @@ static int balloon_probe(struct hv_device *dev,
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>  #endif
>  	return ret;
>  }
> @@ -1750,6 +1840,9 @@ static int balloon_remove(struct hv_device *dev)
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>  #endif
>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 262fae9526b1..75aeea0e7f9b 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,6 +89,7 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
>  
>  
>  /*
> @@ -149,11 +150,18 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  
> +/* Extended hypercalls */
> +#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
> +#define HV_EXT_CALL_MEMORY_HEAT_HINT		0x8003
> +
>  #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>  #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
>  #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
>  
> +/* Extended capability bits */
> +#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)
> +
>  enum HV_GENERIC_SET_FORMAT {
>  	HV_GENERIC_SET_SPARSE_4K,
>  	HV_GENERIC_SET_ALL,
> @@ -371,6 +379,12 @@ union hv_gpa_page_range {

There is a comment before this structure:

/* HvFlushGuestPhysicalAddressList hypercall */

which is now obsolete.

>  		u64 largepage:1;
>  		u64 basepfn:52;
>  	} page;
> +	struct {
> +		u64:12;

What is this unnamed member? Another 'reserved', 'pad'? Let's name it.

> +		u64 page_size:1;
> +		u64 reserved:8;
> +		u64 base_large_pfn:43;
> +	};

Please name this structure in the union.

>  };
>  
>  /*
> @@ -490,4 +504,19 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>  
> +/*
> + * The whole argument should fit in a page to be able to pass to the hypervisor
> + * in one hypercall.
> + */
> +#define HV_MAX_GPA_PAGE_RANGES ((PAGE_SIZE - sizeof(u64)) / \
> +				sizeof(union hv_gpa_page_range))
> +

The name HV_MAX_GPA_PAGE_RANGES sounds too generic and I think this is
specific to the HvExtCallMemoryHeatHint hypercall as other hypercalls
may have a different header length.

> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {
> +	u64 type:2;
> +	u64 reserved:62;
> +	union hv_gpa_page_range ranges[1];

Why '[1]' and not '[]'? If it was '[]' you could've used 'sizeof(struct
hv_memory_hint)' in HV_MAX_GPA_PAGE_RANGES macro definition instead of
'sizeof(u64)'.

> +};
> +
>  #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 1c4fd950f091..c664af4a7503 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,6 +27,7 @@
>  
>  struct ms_hyperv_info {
>  	u32 features;
> +	u32 b_features;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
> @@ -169,6 +170,7 @@ bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
>  void hv_setup_sched_clock(void *sched_clock);
> +u64 hv_query_ext_cap(void);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }

-- 
Vitaly

