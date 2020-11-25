Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01022C36ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 03:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKYCtm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 21:49:42 -0500
Received: from gateway30.websitewelcome.com ([192.185.152.11]:17655 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgKYCtm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 21:49:42 -0500
X-Greylist: delayed 1284 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 21:49:39 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A2727AA24
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 20:28:14 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hkXWkCncSuDoAhkXWkpPOa; Tue, 24 Nov 2020 20:28:14 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eTrs+O4vxGs2pPWuBH47WLBs2m5bgACrtzR1JYvI1WU=; b=VXPeu3JscoNy9rehwY38Gja48T
        IYE8WsaGqTGnQFC6OcRur0R4rU5IpidJxR+S2DT33tzllrAASms9scXXb3TZt9bf9S0sZKPlx6T/d
        LdV7YQTi0kc2bwVcv5icCMIz0H2PqK3oQiZFFyWcE+yvr+eGxAEiOowMMlbO5+sSNlBBe2vtH7WCk
        YSiztdgKqh5X/ZwFQEVzsB9kpE/BM5N1bF0JVA4Fx+C33Qb96HVQsRKGFa4dK7UO8fe8NJjl5QNGv
        oNZLa31k3HKeweVwMgCT7z8t0D2eQAkd7rCapE6GPuoVd9NGgOqIxbAQEwO50fKmnLfQTgpS/cxR6
        UiyCBDEg==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:53939 helo=[192.168.1.69])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khkXW-002pJL-AS; Tue, 24 Nov 2020 23:28:14 -0300
Subject: Re: [PATCH] x86/Hyper-V: Support for free page reporting
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <715c7a82-7e87-4d0d-5e33-ba58185e9c64@castello.eng.br>
Date:   Tue, 24 Nov 2020 23:28:13 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1khkXW-002pJL-AS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br ([192.168.1.69]) [179.197.124.241]:53939
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Sunil,

first thank you very much for your work here. I am using this patch in 
the latest mainline releases with WSL 2 and it is helping me a lot. Let 
me know if you're still interested in continuing to work on this patch. 
It would be great to have it included in the mainline. If you need any 
help let me know too. I'm including my test tag. Thanks!

Em 5/19/2020 3:37 PM, Sunil Muthuswamy escreveu:
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> First patch mail bounced backed. Sending it again with the email
> addresses fixed.
> ---
>   arch/x86/hyperv/hv_init.c         | 24 ++++++++
>   arch/x86/kernel/cpu/mshyperv.c    |  6 +-
>   drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
>   include/asm-generic/hyperv-tlfs.h | 29 ++++++++++
>   include/asm-generic/mshyperv.h    |  2 +
>   5 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 624f5d9b0f79..925e2f7eb82c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -506,3 +506,27 @@ bool hv_is_hibernation_supported(void)
>   	return acpi_sleep_state_supported(ACPI_STATE_S4);
>   }
>   EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +u64 hv_query_ext_cap(void)
> +{
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
>   	 * Extract the features and hints
>   	 */
>   	ms_hyperv.features = cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.b_features = cpuid_ebx(HYPERV_CPUID_FEATURES);
>   	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>   	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>   
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
>   
>   	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>   	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..77be31094556 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -21,6 +21,7 @@
>   #include <linux/memory.h>
>   #include <linux/notifier.h>
>   #include <linux/percpu_counter.h>
> +#include <linux/page_reporting.h>
>   
>   #include <linux/hyperv.h>
>   #include <asm/hyperv-tlfs.h>
> @@ -563,6 +564,10 @@ struct hv_dynmem_device {
>   	 * The negotiated version agreed by host.
>   	 */
>   	__u32 version;
> +
> +#ifdef CONFIG_PAGE_REPORTING
> +	struct page_reporting_dev_info pr_dev_info;
> +#endif
>   };
>   
>   static struct hv_dynmem_device dm_device;
> @@ -1565,6 +1570,83 @@ static void balloon_onchannelcallback(void *context)
>   
>   }
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
> +		range->page.additional_pages = (1ull << (order - 9)) - 1;
> +		range->base_large_pfn = page_to_pfn(sg_page(sg)) >> 9;
> +	}
> +
> +	status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
> +				     hint, NULL);
> +	local_irq_restore(flags);
> +	status &= HV_HYPERCALL_RESULT_MASK;
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("Cold memory discard hypercall failed with status %llx\n",
> +			status);
> +		return -1;
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
>   static int balloon_connect_vsp(struct hv_device *dev)
>   {
>   	struct dm_version_request version_req;
> @@ -1710,6 +1792,11 @@ static int balloon_probe(struct hv_device *dev,
>   	if (ret != 0)
>   		return ret;
>   
> +#ifdef CONFIG_PAGE_REPORTING
> +	if (enable_page_reporting() < 0)
> +		goto probe_error;
> +#endif
> +
>   	dm_device.state = DM_INITIALIZED;
>   
>   	dm_device.thread =
> @@ -1728,6 +1815,9 @@ static int balloon_probe(struct hv_device *dev,
>   #ifdef CONFIG_MEMORY_HOTPLUG
>   	unregister_memory_notifier(&hv_memory_nb);
>   	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>   #endif
>   	return ret;
>   }
> @@ -1750,6 +1840,9 @@ static int balloon_remove(struct hv_device *dev)
>   #ifdef CONFIG_MEMORY_HOTPLUG
>   	unregister_memory_notifier(&hv_memory_nb);
>   	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>   #endif
>   	spin_lock_irqsave(&dm_device.ha_lock, flags);
>   	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 262fae9526b1..75aeea0e7f9b 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,6 +89,7 @@
>   #define HV_ACCESS_STATS				BIT(8)
>   #define HV_DEBUGGING				BIT(11)
>   #define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
>   
>   
>   /*
> @@ -149,11 +150,18 @@ struct ms_hyperv_tsc_page {
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>   
> +/* Extended hypercalls */
> +#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
> +#define HV_EXT_CALL_MEMORY_HEAT_HINT		0x8003
> +
>   #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>   #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>   #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
>   #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
>   
> +/* Extended capability bits */
> +#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)
> +
>   enum HV_GENERIC_SET_FORMAT {
>   	HV_GENERIC_SET_SPARSE_4K,
>   	HV_GENERIC_SET_ALL,
> @@ -371,6 +379,12 @@ union hv_gpa_page_range {
>   		u64 largepage:1;
>   		u64 basepfn:52;
>   	} page;
> +	struct {
> +		u64:12;
> +		u64 page_size:1;
> +		u64 reserved:8;
> +		u64 base_large_pfn:43;
> +	};
>   };
>   
>   /*
> @@ -490,4 +504,19 @@ struct hv_set_vp_registers_input {
>   	} element[];
>   } __packed;
>   
> +/*
> + * The whole argument should fit in a page to be able to pass to the hypervisor
> + * in one hypercall.
> + */
> +#define HV_MAX_GPA_PAGE_RANGES ((PAGE_SIZE - sizeof(u64)) / \
> +				sizeof(union hv_gpa_page_range))
> +
> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {
> +	u64 type:2;
> +	u64 reserved:62;
> +	union hv_gpa_page_range ranges[1];
> +};
> +
>   #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 1c4fd950f091..c664af4a7503 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,6 +27,7 @@
>   
>   struct ms_hyperv_info {
>   	u32 features;
> +	u32 b_features;
>   	u32 misc_features;
>   	u32 hints;
>   	u32 nested_features;
> @@ -169,6 +170,7 @@ bool hv_is_hyperv_initialized(void);
>   bool hv_is_hibernation_supported(void);
>   void hyperv_cleanup(void);
>   void hv_setup_sched_clock(void *sched_clock);
> +u64 hv_query_ext_cap(void);
>   #else /* CONFIG_HYPERV */
>   static inline bool hv_is_hyperv_initialized(void) { return false; }
>   static inline bool hv_is_hibernation_supported(void) { return false; }
> 

Tested-by: Matheus Castello <matheus@castello.eng.br>
