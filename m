Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41C83C23D2
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGIM7f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 08:59:35 -0400
Received: from foss.arm.com ([217.140.110.172]:52420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhGIM7d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 08:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DFFED1;
        Fri,  9 Jul 2021 05:56:50 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258A53F66F;
        Fri,  9 Jul 2021 05:56:48 -0700 (PDT)
Subject: Re: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more
 flexible
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
        kumarpraveen@linux.microsoft.com,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "open list:INTEL IOMMU VT-d" <iommu@lists.linux-foundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-4-wei.liu@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
Date:   Fri, 9 Jul 2021 13:56:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-4-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-07-09 12:43, Wei Liu wrote:
> Microsoft Hypervisor provides a set of hypercalls to manage device
> domains. The root kernel should parse the DMAR so that it can program
> the IOMMU (with hypercalls) correctly.
> 
> The DMAR code was designed to work with Intel IOMMU only. Add two more
> parameters to make it useful to Microsoft Hypervisor. Microsoft
> Hypervisor does not need the DMAR parsing code to allocate an Intel
> IOMMU structure; it also wishes to always reparse the DMAR table even
> after it has been parsed before.

We've recently defined the VIOT table for describing paravirtualised 
IOMMUs - would it make more sense to extend that to support the 
Microsoft implementation than to abuse a hardware-specific table? Am I 
right in assuming said hypervisor isn't intended to only ever run on 
Intel hardware?

Robin.

> Adjust Intel IOMMU code to use the new dmar_table_init. There should be
> no functional change to Intel IOMMU code.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> We may be able to combine alloc and force_parse?
> ---
>   drivers/iommu/intel/dmar.c          | 38 ++++++++++++++++++++---------
>   drivers/iommu/intel/iommu.c         |  2 +-
>   drivers/iommu/intel/irq_remapping.c |  2 +-
>   include/linux/dmar.h                |  2 +-
>   4 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 84057cb9596c..bd72f47c728b 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -408,7 +408,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>    * structure which uniquely represent one DMA remapping hardware unit
>    * present in the platform
>    */
> -static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
> +static int dmar_parse_one_drhd_internal(struct acpi_dmar_header *header,
> +		void *arg, bool alloc)
>   {
>   	struct acpi_dmar_hardware_unit *drhd;
>   	struct dmar_drhd_unit *dmaru;
> @@ -440,12 +441,14 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
>   		return -ENOMEM;
>   	}
>   
> -	ret = alloc_iommu(dmaru);
> -	if (ret) {
> -		dmar_free_dev_scope(&dmaru->devices,
> -				    &dmaru->devices_cnt);
> -		kfree(dmaru);
> -		return ret;
> +	if (alloc) {
> +		ret = alloc_iommu(dmaru);
> +		if (ret) {
> +			dmar_free_dev_scope(&dmaru->devices,
> +					    &dmaru->devices_cnt);
> +			kfree(dmaru);
> +			return ret;
> +		}
>   	}
>   	dmar_register_drhd_unit(dmaru);
>   
> @@ -456,6 +459,16 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
>   	return 0;
>   }
>   
> +static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
> +{
> +	return dmar_parse_one_drhd_internal(header, arg, true);
> +}
> +
> +int dmar_parse_one_drhd_noalloc(struct acpi_dmar_header *header, void *arg)
> +{
> +	return dmar_parse_one_drhd_internal(header, arg, false);
> +}
> +
>   static void dmar_free_drhd(struct dmar_drhd_unit *dmaru)
>   {
>   	if (dmaru->devices && dmaru->devices_cnt)
> @@ -633,7 +646,7 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
>    * parse_dmar_table - parses the DMA reporting table
>    */
>   static int __init
> -parse_dmar_table(void)
> +parse_dmar_table(bool alloc)
>   {
>   	struct acpi_table_dmar *dmar;
>   	int drhd_count = 0;
> @@ -650,6 +663,9 @@ parse_dmar_table(void)
>   		.cb[ACPI_DMAR_TYPE_SATC] = &dmar_parse_one_satc,
>   	};
>   
> +	if (!alloc)
> +		cb.cb[ACPI_DMAR_TYPE_HARDWARE_UNIT] = &dmar_parse_one_drhd_noalloc;
> +
>   	/*
>   	 * Do it again, earlier dmar_tbl mapping could be mapped with
>   	 * fixed map.
> @@ -840,13 +856,13 @@ void __init dmar_register_bus_notifier(void)
>   }
>   
>   
> -int __init dmar_table_init(void)
> +int __init dmar_table_init(bool alloc, bool force_parse)
>   {
>   	static int dmar_table_initialized;
>   	int ret;
>   
> -	if (dmar_table_initialized == 0) {
> -		ret = parse_dmar_table();
> +	if (dmar_table_initialized == 0 || force_parse) {
> +		ret = parse_dmar_table(alloc);
>   		if (ret < 0) {
>   			if (ret != -ENODEV)
>   				pr_info("Parse DMAR table failure.\n");
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284a2016..a4294d310b93 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4310,7 +4310,7 @@ int __init intel_iommu_init(void)
>   	}
>   
>   	down_write(&dmar_global_lock);
> -	if (dmar_table_init()) {
> +	if (dmar_table_init(true, false)) {
>   		if (force_on)
>   			panic("tboot: Failed to initialize DMAR table\n");
>   		goto out_free_dmar;
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index f912fe45bea2..0e8abef862e4 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -732,7 +732,7 @@ static int __init intel_prepare_irq_remapping(void)
>   		return -ENODEV;
>   	}
>   
> -	if (dmar_table_init() < 0)
> +	if (dmar_table_init(true, false) < 0)
>   		return -ENODEV;
>   
>   	if (intel_cap_audit(CAP_AUDIT_STATIC_IRQR, NULL))
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index e04436a7ff27..f88535d41a6e 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -106,7 +106,7 @@ static inline bool dmar_rcu_check(void)
>   	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
>   		if (!(tmp)) { continue; } else
>   
> -extern int dmar_table_init(void);
> +extern int dmar_table_init(bool alloc, bool force_parse);
>   extern int dmar_dev_scope_init(void);
>   extern void dmar_register_bus_notifier(void);
>   extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
> 
