Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9548D34689A
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhCWTLG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 15:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233237AbhCWTKu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 15:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03ED76192B;
        Tue, 23 Mar 2021 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616526650;
        bh=HKThLRU7tSqFL2igaQ2btQbUDtkOEI8IOyDImWbkN+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWvztOCk/WOBeSO/R7ci3r9uXTEnUpk+hvF3HoiFVG9bBr9b2EKj2RAAOuqlxkVOu
         b7vDi/EEUseEro/hTAQP5kL4TKK5QjREv09H/HIaufdiLqDm67x4/+eSvPanDvOh20
         5WqSwfOEy9vXw54pcUFGYVVEd/QgljydBfYKnP49V25YWeyBGMMz4V/OwXQpOCQYUx
         cv6w/F4QtPXvjDeFjCQaoY4poHq4SYwIbkSpipqvzjAPwWGcM/1nOSG7yX48U8Xhck
         dXKhXx3z9GX5xha5z6TbpQdkci8+q2m3BI50jfNDkmZjc7T95lSv9MGx05lrSONpZt
         9hGKzWEn/Y+MA==
Date:   Tue, 23 Mar 2021 12:10:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v5] x86/Hyper-V: Support for free page reporting
Message-ID: <20210323191044.d6yccymy72pekjra@archlinux-ax161>
References: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR2101MB0880121FA4E2FEC67F35C1DCC0649@SN4PR2101MB0880.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 23, 2021 at 06:47:16PM +0000, Sunil Muthuswamy wrote:
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> In V2:
> - Addressed feedback comments
> - Added page reporting config option tied to hyper-v balloon config
> 
> In V3:
> - Addressed feedback from Vitaly
> 
> In V4:
> - Queried and cached the Hyper-V extended capability for the lifetime
>   of the VM
> - Addressed feedback from Michael Kelley.
> 
> In v5:
> - Added a comment clarifying handling of failed query extended
>   capability hypercall to address Michael's feedback.
> ---
>  arch/x86/hyperv/hv_init.c         | 51 +++++++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c    |  9 ++--
>  drivers/hv/Kconfig                |  1 +
>  drivers/hv/hv_balloon.c           | 89 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 35 +++++++++++-
>  include/asm-generic/mshyperv.h    |  3 +-
>  6 files changed, 180 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9d100257b3af..7c9da3f65afa 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -498,6 +498,8 @@ void __init hyperv_init(void)
>  		x86_init.irqs.create_pci_msi_domain = hv_create_pci_msi_domain;
>  #endif
>  
> +	/* Query the VMs extended capability once, so that it can be cached. */
> +	hv_query_ext_cap(0);
>  	return;
>  
>  remove_cpuhp_state:
> @@ -601,7 +603,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>  
>  enum hv_isolation_type hv_get_isolation_type(void)
>  {
> -	if (!(ms_hyperv.features_b & HV_ISOLATION))
> +	if (!(ms_hyperv.priv_high & HV_ISOLATION))
>  		return HV_ISOLATION_TYPE_NONE;
>  	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
>  }
> @@ -612,3 +614,50 @@ bool hv_is_isolation_supported(void)
>  	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
> +
> +/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
> +bool hv_query_ext_cap(u64 cap_query)
> +{
> +	/*
> +	 * The address of the 'hv_extended_cap' variable will be used as an
> +	 * output parameter to the hypercall below and so it should be
> +	 * compatible with 'virt_to_phys'. Which means, it's address should be
> +	 * directly mapped. Use 'static' to keep it compatible; stack variables
> +	 * can be virtually mapped, making them imcompatible with
> +	 * 'virt_to_phys'.
> +	 * Hypercall input/output addresses should also be 8-byte aligned.
> +	 */
> +	static u64 hv_extended_cap __aligned(8);
> +	static bool hv_extended_cap_queried;
> +	u64 status;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if the
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return false;
> +
> +	/* Extended capabilities do not change at runtime. */
> +	if (hv_extended_cap_queried)
> +		return hv_extended_cap & cap_query;
> +
> +	status = hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL,
> +				 &hv_extended_cap);
> +
> +	/*
> +	 * The query extended capabilities hypercall should not fail under
> +	 * any normal circumstances. Avoid repeatedly making the hypercall, on
> +	 * error.
> +	 */
> +	hv_extended_cap_queried = true;
> +	status &= HV_HYPERCALL_RESULT_MASK;
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("Hyper-V: Extended query capabilities hypercall failed 0x%llx\n",
> +		       status);
> +		return false;
> +	}
> +
> +	return hv_extended_cap & cap_query;
> +}
> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index cebed535ec56..3546d3e21787 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -265,12 +265,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> -	ms_hyperv.features_b = cpuid_ebx(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.priv_high = cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> @@ -316,7 +317,7 @@ static void __init ms_hyperv_init_platform(void)
>  		x86_platform.calibrate_cpu = hv_get_tsc_khz;
>  	}
>  
> -	if (ms_hyperv.features_b & HV_ISOLATION) {
> +	if (ms_hyperv.priv_high & HV_ISOLATION) {
>  		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
>  		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
>  
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
> index 2f776d78e3c1..58af84e30144 100644
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
> @@ -563,6 +564,8 @@ struct hv_dynmem_device {
>  	 * The negotiated version agreed by host.
>  	 */
>  	__u32 version;
> +
> +	struct page_reporting_dev_info pr_dev_info;
>  };
>  
>  static struct hv_dynmem_device dm_device;
> @@ -1568,6 +1571,89 @@ static void balloon_onchannelcallback(void *context)
>  
>  }
>  
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
> +	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
> +	WARN_ON_ONCE(sgl->length < HV_MIN_PAGE_REPORTING_LEN);
> +	local_irq_save(flags);
> +	hint = *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (!hint) {
> +		local_irq_restore(flags);
> +		return -ENOSPC;
> +	}
> +
> +	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> +	hint->reserved = 0;
> +	for_each_sg(sgl, sg, nents, i) {
> +		union hv_gpa_page_range *range;
> +
> +		range = &hint->ranges[i];
> +		range->address_space = 0;
> +		/* page reporting only reports 2MB pages or higher */
> +		range->page.largepage = 1;
> +		range->page.additional_pages =
> +			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
> +		range->page_size = HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
> +		range->base_large_pfn =
> +			page_to_hvpfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
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
> +	/* Essentially, validating 'PAGE_REPORTING_MIN_ORDER' is big enough. */
> +	if (pageblock_order < HV_MIN_PAGE_REPORTING_ORDER) {
> +		pr_debug("Cold memory discard is only supported on 2MB pages and above\n");
> +		return;
> +	}
> +
> +	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
> +		pr_debug("Cold memory discard hint not supported by Hyper-V\n");
> +		return;
> +	}
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
> +
>  static int balloon_connect_vsp(struct hv_device *dev)
>  {
>  	struct dm_version_request version_req;
> @@ -1713,6 +1799,7 @@ static int balloon_probe(struct hv_device *dev,
>  	if (ret != 0)
>  		return ret;
>  
> +	enable_page_reporting();
>  	dm_device.state = DM_INITIALIZED;
>  
>  	dm_device.thread =
> @@ -1727,6 +1814,7 @@ static int balloon_probe(struct hv_device *dev,
>  probe_error:
>  	dm_device.state = DM_INIT_ERROR;
>  	dm_device.thread  = NULL;
> +	disable_page_reporting();
>  	vmbus_close(dev->channel);
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
> @@ -1749,6 +1837,7 @@ static int balloon_remove(struct hv_device *dev)
>  	cancel_work_sync(&dm->ha_wrk.wrk);
>  
>  	kthread_stop(dm->thread);
> +	disable_page_reporting();
>  	vmbus_close(dev->channel);
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 9cf10837d005..515c3fb06ab3 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,9 +89,9 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_MANAGEMENT			BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
>  #define HV_ISOLATION				BIT(22)
>  
> -
>  /*
>   * TSC page layout.
>   */
> @@ -159,11 +159,18 @@ struct ms_hyperv_tsc_page {
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
> @@ -408,8 +415,10 @@ struct hv_guest_mapping_flush {
>   *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
>   */
>  #define HV_MAX_FLUSH_PAGES (2048)
> +#define HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB		0
> +#define HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB		1
>  
> -/* HvFlushGuestPhysicalAddressList hypercall */
> +/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
>  union hv_gpa_page_range {
>  	u64 address_space;
>  	struct {
> @@ -417,6 +426,12 @@ union hv_gpa_page_range {
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
> @@ -774,4 +789,20 @@ struct hv_input_unmap_device_interrupt {
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>  
> +/*
> + * The whole argument should fit in a page to be able to pass to the hypervisor
> + * in one hypercall.
> + */
> +#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
> +		sizeof(union hv_gpa_page_range))
> +
> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {
> +	u64 type:2;
> +	u64 reserved:62;
> +	union hv_gpa_page_range ranges[];
> +} __packed;
> +
>  #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 2d1b6cd9f000..63c0e579bf6d 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,7 +27,7 @@
>  
>  struct ms_hyperv_info {
>  	u32 features;
> -	u32 features_b;
> +	u32 priv_high;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
> @@ -179,6 +179,7 @@ bool hv_is_hibernation_supported(void);
>  enum hv_isolation_type hv_get_isolation_type(void);
>  bool hv_is_isolation_supported(void);
>  void hyperv_cleanup(void);
> +bool hv_query_ext_cap(u64 cap_query);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
> -- 
> 2.17.1
