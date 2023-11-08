Return-Path: <linux-hyperv+bounces-714-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D57E5189
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9693C1C20D92
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AAD531;
	Wed,  8 Nov 2023 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGv830VZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF1D536;
	Wed,  8 Nov 2023 08:01:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0ED199;
	Wed,  8 Nov 2023 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699430474; x=1730966474;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=waktInfzOKtDW0E1oxAKk3EhbspNu0YVHIgYOQNzgfM=;
  b=eGv830VZu/h48EEjXQoZ1P5X0i07nYT87xghWfqFuh2aS0yFIK/67CRF
   Do0F40Nwz8o5PkWkHK1ObKgE+MLjf4BR1+FBT9mEW79kZN6NQ9Gp40di7
   dxRWHTBUFaEYEa5e6sb6Y7EiEy4Dxhm6l0FXxSnr06Kc0KA4XoqCbmgou
   cLLlYGcW54YtHLCwoD8d/w66oRuYs5jrrkDM2CNrQuR57dTnUzeaHwtVu
   Sv/HcQzFaonYUhah7EwIAwIsbf85gL/kmnLyhuKI/1hjp3XpsmOXB2W4a
   dL1b3yRQ1n8CwcrR3ORPqg9dJX7JD5G6FoZOJn0+VJ8fcOa91h3dIz7dW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369050180"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="369050180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="833411924"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="833411924"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.63]) ([10.254.215.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:01:01 -0800
Message-ID: <99edf0cf-a570-43de-a79a-a040a403607e@linux.intel.com>
Date: Wed, 8 Nov 2023 16:01:00 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 01/17] iommu: Remove struct iommu_ops *iommu from
 arch_setup_dma_ops()
To: Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linuxfoundation.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Frank Rowand
 <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin
 <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
References: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/4 0:44, Jason Gunthorpe wrote:
> This is not being used to pass ops, it is just a way to tell if an
> iommu driver was probed. These days this can be detected directly via
> device_iommu_mapped(). Call device_iommu_mapped() in the two places that
> need to check it and remove the iommu parameter everywhere.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   arch/arc/mm/dma.c               |  2 +-
>   arch/arm/mm/dma-mapping-nommu.c |  2 +-
>   arch/arm/mm/dma-mapping.c       | 10 +++++-----
>   arch/arm64/mm/dma-mapping.c     |  4 ++--
>   arch/mips/mm/dma-noncoherent.c  |  2 +-
>   arch/riscv/mm/dma-noncoherent.c |  2 +-
>   drivers/acpi/scan.c             |  3 +--
>   drivers/hv/hv_common.c          |  2 +-
>   drivers/of/device.c             |  2 +-
>   include/linux/dma-map-ops.h     |  4 ++--
>   10 files changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

