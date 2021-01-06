Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36C42EBEA8
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAFN3y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 08:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbhAFN3w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 08:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWVRRpIfsVXRXGAlBvNp8rHmroLKl6eh8db5i/Vd/Lc=;
        b=f94d6Aw5X+GnDS9cQJqVJ6OTXlbuYW6/uXSwmwFP7S5lAeFEzziyDZkxx9Yf8kShNiunbJ
        Jhlvnptph8r9uey5ANBQV8OgtbXWbyXnlXwk+hpm+Lxi7nECM22dg4i/raoerD/tTMWqKQ
        62qGagv0mz0vOxSSyNAAROoT5Hjoszc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-RXheI2pRNlO9aIwAquq0cA-1; Wed, 06 Jan 2021 08:28:23 -0500
X-MC-Unique: RXheI2pRNlO9aIwAquq0cA-1
Received: by mail-ej1-f69.google.com with SMTP id ny19so1290145ejb.10
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Jan 2021 05:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wWVRRpIfsVXRXGAlBvNp8rHmroLKl6eh8db5i/Vd/Lc=;
        b=IbtiiQ0qNLYCwx+heQXMSVJYNjEibTdZWMbs9v0Ue9xA8cKROsskcjq4DGUAs7TbTf
         LgpYySL0qY4R0i7zhFVUzGWHOG8qmOuD4nizChg/UVSktcj+QKXqLOIoQYMu0PxnBHrL
         /3AE66Z5uvvrCYPi2Xf2ri4UEDLRimcSP4n1ArdVF/JdeJkDSahjI7HUdnGv+FlWyHHb
         Gqw1jRCnk0fu1IaK3+vaiXfL+8R+BpoM59FyykbWQAPUfweWCIhd4Wgk9HgmuMhA8nU0
         FU4OzMxWCs14ckU32ykJbtlHforXItAuDc8ib4Blu/vKr2g2y1YwsTcseDLFKTrsZXEL
         H/ig==
X-Gm-Message-State: AOAM533jKMUy2c4BvwXmRV5vhOCFqIW46HlUgqQGdkrnUkSgi/+ueab9
        wmlQJzbzM8ocp3cDymRG7jSJvFCCIM55nzE3FJyGVBos9cGjgenG2huPK78mxGVG9a3cbJrWIMU
        4Aac5Qc1w3Oq5D5b1LWylgsQe
X-Received: by 2002:aa7:cfd7:: with SMTP id r23mr3924455edy.298.1609939701581;
        Wed, 06 Jan 2021 05:28:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwegwkTf4i1Gmhpy+blST9zgDakDNGiA6ttzn7bx2XDoK09HFOie7xNkviFJKwPmjCAduDuFA==
X-Received: by 2002:aa7:cfd7:: with SMTP id r23mr3924442edy.298.1609939701282;
        Wed, 06 Jan 2021 05:28:21 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s12sm1470967edu.28.2021.01.06.05.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:28:20 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] x86/Hyper-V: Support for free page reporting
In-Reply-To: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
Date:   Wed, 06 Jan 2021 14:28:20 +0100
Message-ID: <87v9cagpor.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
> Tested-by: Matheus Castello <matheus@castello.eng.br>
> ---
> In V2:
> - Addressed feedback comments
> - Added page reporting config option tied to hyper-v balloon config
> ---
>  arch/x86/hyperv/hv_init.c         | 31 +++++++++++
>  arch/x86/kernel/cpu/mshyperv.c    |  6 +-
>  drivers/hv/Kconfig                |  1 +
>  drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 32 ++++++++++-
>  include/asm-generic/mshyperv.h    |  2 +
>  6 files changed, 162 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..1ed7ba07e009 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -528,3 +528,34 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +// Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx

Please don't use '//' comments in Linux (here and below)

> +bool hv_query_ext_cap(u64 cap_query)
> +{
> +	u64 *cap;
> +	unsigned long flags;
> +	u64 ext_cap = 0;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if the
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return 0;
> +
> +	/*
> +	 * Repurpose the input page arg to accept output from Hyper-V for
> +	 * now because this is the only call that needs output from the
> +	 * hypervisor. It should be fixed properly by introducing an
> +	 * output arg once we have more places that require output.
> +	 */

I remember there was a patch from Wei (realter to running Linux as root
partition) doing the job, we can probably merge it early to avoid this
re-purposing.

> +	local_irq_save(flags);
> +	cap = *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) ==
> +	    HV_STATUS_SUCCESS)
> +		ext_cap = *cap;
> +
> +	local_irq_restore(flags);
> +	return ext_cap & cap_query;
> +}
> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 05ef1f4550cb..7a7735918350 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -225,11 +225,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.priv_high = cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: features 0x%x, privilege flags high: 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +		ms_hyperv.misc_features);

Even if we would like to avoid the curn and keep 'ms_hyperv.features',
we could've reported this as 

"privilege flags low:%0x%x high:0x%x" to avoid the misleading 'features'.

>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 79e5356a737a..66c794d92391 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -23,6 +23,7 @@ config HYPERV_UTILS
>  config HYPERV_BALLOON
>  	tristate "Microsoft Hyper-V Balloon driver"
>  	depends on HYPERV
> +	select PAGE_REPORTING
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 8c471823a5af..bb0624bf615b 100644
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
> @@ -1568,6 +1573,84 @@ static void balloon_onchannelcallback(void *context)
>  
>  }
>  
> +#ifdef CONFIG_PAGE_REPORTING
> +/* Hyper-V only supports reporting 2MB pages or higher */
> +#define HV_MIN_PAGE_REPORTING_ORDER	9
> +#define HV_MIN_PAGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << HV_MIN_PAGE_REPORTING_ORDER)
> +static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
> +		    struct scatterlist *sgl, unsigned int nents)
> +{
> +	unsigned long flags;
> +	struct hv_memory_hint *hint;
> +	int i;
> +	u64 status;
> +	struct scatterlist *sg;
> +
> +	WARN_ON(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);

WARN_ON_ONCE() maybe?

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

This looks like an open-coded for_each_sg() version.

> +		union hv_gpa_page_range *range;
> +
> +		range = &hint->ranges[i];
> +		range->address_space = 0;
> +		/* page reportting only reports 2MB pages or higher */
> +		range->page.largepage = 1;
> +		range->page.additional_pages =
> +			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
> +		range->base_large_pfn =
> +			page_to_pfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
> +	}
> +
> +	status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
> +				     hint, NULL);
> +	local_irq_restore(flags);
> +	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
> +		pr_err("Cold memory discard hypercall failed with status %llx\n",
> +			status);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void enable_page_reporting(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(pageblock_order < HV_MIN_PAGE_REPORTING_ORDER);
> +	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
> +		pr_info("Cold memory discard hint not supported by Hyper-V\n");
> +		return;
> +	}

Which Hyper-V versions/Azure instance types don't support it? In case
there's something fairly modern on the list, I'd suggest to drop this
pr_info (or convert it to pr_debug) to not mislead users into thinking
there's something wrong. In case they don't see 'Cold memory discard
hint enabled' they know it is unsupported.

> +
> +	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
> +	dm_device.pr_dev_info.report = hv_free_page_report;
> +	ret = page_reporting_register(&dm_device.pr_dev_info);
> +	if (ret < 0) {
> +		dm_device.pr_dev_info.report = NULL;
> +		pr_err("Failed to enable cold memory discard: %d\n", ret);
> +	} else {
> +		pr_info("Cold memory discard hint enabled\n");
> +	}
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
> @@ -1713,6 +1796,10 @@ static int balloon_probe(struct hv_device *dev,
>  	if (ret != 0)
>  		return ret;
>  
> +#ifdef CONFIG_PAGE_REPORTING
> +	enable_page_reporting();
> +#endif
> +
>  	dm_device.state = DM_INITIALIZED;
>  
>  	dm_device.thread =
> @@ -1731,6 +1818,9 @@ static int balloon_probe(struct hv_device *dev,
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>  #endif
>  	return ret;
>  }
> @@ -1753,6 +1843,9 @@ static int balloon_remove(struct hv_device *dev)
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
> index e73a11850055..abffd27bd6cb 100644
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
> @@ -152,11 +153,18 @@ struct ms_hyperv_tsc_page {
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
> @@ -367,7 +375,7 @@ struct hv_guest_mapping_flush {
>   */
>  #define HV_MAX_FLUSH_PAGES (2048)
>  
> -/* HvFlushGuestPhysicalAddressList hypercall */
> +/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
>  union hv_gpa_page_range {
>  	u64 address_space;
>  	struct {
> @@ -375,6 +383,12 @@ union hv_gpa_page_range {
>  		u64 largepage:1;
>  		u64 basepfn:52;
>  	} page;
> +	struct {
> +		u64 reserved:12;
> +		u64 page_size:1;
> +		u64 reserved1:8;
> +		u64 base_large_pfn:43;
> +	};
>  };
>  
>  /*
> @@ -494,4 +508,20 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>  
> +/*
> + * The whole argument should fit in a page to be able to pass to the hypervisor
> + * in one hypercall.
> + */
> +#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
> +	((PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
> +		sizeof(union hv_gpa_page_range))
> +
> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {
> +	u64 type:2;
> +	u64 reserved:62;
> +	union hv_gpa_page_range ranges[];
> +};

Other similar structures use '__packed' but I remember there was some
disagreement if this is needed or not when everything is properly padded
(or doesn't require padding like in this case).

> +
>  #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c57799684170..93c1303f5e00 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,6 +27,7 @@
>  
>  struct ms_hyperv_info {
>  	u32 features;
> +	u32 priv_high;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
> @@ -170,6 +171,7 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
> +bool hv_query_ext_cap(u64 cap_query);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }

-- 
Vitaly

