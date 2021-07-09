Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3D3C25BD
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGIOUT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 10:20:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:35272 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhGIOUT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 10:20:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="207882068"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="207882068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 07:17:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="488060340"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.213]) ([10.254.208.213])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 07:17:28 -0700
Cc:     baolu.lu@linux.intel.com,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC v1 4/8] intel/vt-d: export intel_iommu_get_resv_regions
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-5-wei.liu@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
Date:   Fri, 9 Jul 2021 22:17:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-5-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021/7/9 19:43, Wei Liu wrote:
> When Microsoft Hypervisor runs on Intel platforms it needs to know the
> reserved regions to program devices correctly. There is no reason to
> duplicate intel_iommu_get_resv_regions. Export it.

Why not using iommu_get_resv_regions()?

Best regards,
baolu

> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++--
>   include/linux/intel-iommu.h | 4 ++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a4294d310b93..01973bc20080 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5176,8 +5176,8 @@ static void intel_iommu_probe_finalize(struct device *dev)
>   		set_dma_ops(dev, NULL);
>   }
>   
> -static void intel_iommu_get_resv_regions(struct device *device,
> -					 struct list_head *head)
> +void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head)
>   {
>   	int prot = DMA_PTE_READ | DMA_PTE_WRITE;
>   	struct iommu_resv_region *reg;
> @@ -5232,6 +5232,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   		return;
>   	list_add_tail(&reg->list, head);
>   }
> +EXPORT_SYMBOL_GPL(intel_iommu_get_resv_regions);
>   
>   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
>   {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 03faf20a6817..f91869f765bc 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -814,6 +814,8 @@ extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
>   extern int intel_iommu_gfx_mapped;
> +extern void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head);
>   #else
>   static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
>   {
> @@ -825,6 +827,8 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>   }
>   #define dmar_disabled	(1)
>   #define intel_iommu_enabled (0)
> +static inline void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head) {}
>   #endif
>   
>   #endif
> 
