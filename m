Return-Path: <linux-hyperv+bounces-859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3D7E91CF
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 18:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489451F20FC2
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E579154BE;
	Sun, 12 Nov 2023 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A631548F;
	Sun, 12 Nov 2023 17:35:26 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0595D211B;
	Sun, 12 Nov 2023 09:35:25 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1cc4f777ab9so26246275ad.0;
        Sun, 12 Nov 2023 09:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699810524; x=1700415324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoHWK6gINi+EEwKTGP1Dg7yIjtZGVaNrtn4vb+1P0Pc=;
        b=fqSD7VGKbfWxci9Tr/tCTUhiRZutfr1bbi0M0yqzqJT9HTcf8uNJS0cRKm5EOhL0LI
         7Ixh6IxqVX71ODB9qVFPb6iOxa8mnVcdurFKh+N+W9XL7n5Ou3GJrXdxip25sTrgXbf/
         oVnHy7sE1ILzcZdUSXZoF1s+4gXdYEMuGByVVMXvHHAhxIYa3vME5skzwYjzUPA82rFI
         f+QkMglQ1Fl429L5fGyhsYuwPHClAROLV0VmJ771lJs9yELqNFAboOb3WXqYIf7ZEkXC
         AVcDCIqSNaHTZ/7rVAMN1BjgpfPMS5+Lxphj8Pgx6laj+VrdL9bH4e83DENHly6pkxFc
         6+rA==
X-Gm-Message-State: AOJu0Yzc914Lv5i0bm+S9ZjYowbav/3ZQghCkUnP5cWFIu5RMuhH+DnY
	cOdy1RHLxn4kShITR8vb0zE=
X-Google-Smtp-Source: AGHT+IFd+7BefBv/n/fSSGw7xmysLeuCAiNT7/refCQp1UZ16kLfECcyF3DpQcfnxFHM4Pm1w5+ajw==
X-Received: by 2002:a17:902:b618:b0:1cc:138a:287b with SMTP id b24-20020a170902b61800b001cc138a287bmr2491072pls.3.1699810524296;
        Sun, 12 Nov 2023 09:35:24 -0800 (PST)
Received: from localhost ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001cc32f46757sm2761359plh.107.2023.11.12.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 09:35:23 -0800 (PST)
Date: Sun, 12 Nov 2023 09:35:23 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 01/17] iommu: Remove struct iommu_ops *iommu from
 arch_setup_dma_ops()
Message-ID: <ZVEM23qFzLnnXiEz@archbook>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:46PM -0300, Jason Gunthorpe wrote:
> This is not being used to pass ops, it is just a way to tell if an
> iommu driver was probed. These days this can be detected directly via
> device_iommu_mapped(). Call device_iommu_mapped() in the two places that
> need to check it and remove the iommu parameter everywhere.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  arch/arc/mm/dma.c               |  2 +-
>  arch/arm/mm/dma-mapping-nommu.c |  2 +-
>  arch/arm/mm/dma-mapping.c       | 10 +++++-----
>  arch/arm64/mm/dma-mapping.c     |  4 ++--
>  arch/mips/mm/dma-noncoherent.c  |  2 +-
>  arch/riscv/mm/dma-noncoherent.c |  2 +-
>  drivers/acpi/scan.c             |  3 +--
>  drivers/hv/hv_common.c          |  2 +-
>  drivers/of/device.c             |  2 +-
>  include/linux/dma-map-ops.h     |  4 ++--
>  10 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 2a7fbbb83b7056..197707bc765889 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -91,7 +91,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>   * Plug in direct dma map ops.
>   */
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			const struct iommu_ops *iommu, bool coherent)
> +			bool coherent)
>  {
>  	/*
>  	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index cfd9c933d2f09c..b94850b579952a 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -34,7 +34,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  }
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			const struct iommu_ops *iommu, bool coherent)
> +			bool coherent)
>  {
>  	if (IS_ENABLED(CONFIG_CPU_V7M)) {
>  		/*
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 5409225b4abc06..6c359a3af8d9c7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1713,7 +1713,7 @@ void arm_iommu_detach_device(struct device *dev)
>  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>  
>  static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -				    const struct iommu_ops *iommu, bool coherent)
> +				    bool coherent)
>  {
>  	struct dma_iommu_mapping *mapping;
>  
> @@ -1748,7 +1748,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
>  #else
>  
>  static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -				    const struct iommu_ops *iommu, bool coherent)
> +				    bool coherent)
>  {
>  }
>  
> @@ -1757,7 +1757,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
>  #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			const struct iommu_ops *iommu, bool coherent)
> +			bool coherent)
>  {
>  	/*
>  	 * Due to legacy code that sets the ->dma_coherent flag from a bus
> @@ -1776,8 +1776,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	if (dev->dma_ops)
>  		return;
>  
> -	if (iommu)
> -		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
> +	if (device_iommu_mapped(dev))
> +		arm_setup_iommu_dma_ops(dev, dma_base, size, coherent);
>  
>  	xen_setup_dma_ops(dev);
>  	dev->archdata.dma_ops_setup = true;
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3cb101e8cb29ba..61886e43e3a10f 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -47,7 +47,7 @@ void arch_teardown_dma_ops(struct device *dev)
>  #endif
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			const struct iommu_ops *iommu, bool coherent)
> +			bool coherent)
>  {
>  	int cls = cache_line_size_of_cpu();
>  
> @@ -58,7 +58,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  		   ARCH_DMA_MINALIGN, cls);
>  
>  	dev->dma_coherent = coherent;
> -	if (iommu)
> +	if (device_iommu_mapped(dev))
>  		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
>  
>  	xen_setup_dma_ops(dev);
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
> index 3c4fc97b9f394b..0f3cec663a12cd 100644
> --- a/arch/mips/mm/dma-noncoherent.c
> +++ b/arch/mips/mm/dma-noncoherent.c
> @@ -138,7 +138,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -		const struct iommu_ops *iommu, bool coherent)
> +		bool coherent)
>  {
>  	dev->dma_coherent = coherent;
>  }
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index b76e7e192eb183..f91fa741c41211 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -135,7 +135,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  }
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -		const struct iommu_ops *iommu, bool coherent)
> +			bool coherent)
>  {
>  	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
>  		   TAINT_CPU_OUT_OF_SPEC,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 691d4b7686ee7e..a6891ad0ceee2c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1636,8 +1636,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>  
> -	arch_setup_dma_ops(dev, 0, U64_MAX,
> -				iommu, attr == DEV_DMA_COHERENT);
> +	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
>  
>  	return 0;
>  }
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ccad7bca3fd3da..fd938b6dfa7ed4 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -489,7 +489,7 @@ void hv_setup_dma_ops(struct device *dev, bool coherent)
>  	 * Hyper-V does not offer a vIOMMU in the guest
>  	 * VM, so pass 0/NULL for the IOMMU settings
>  	 */
> -	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
> +	arch_setup_dma_ops(dev, 0, 0, coherent);
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>  
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 1ca42ad9dd159d..65c71be71a8d45 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -193,7 +193,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	dev_dbg(dev, "device is%sbehind an iommu\n",
>  		iommu ? " " : " not ");
>  
> -	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> +	arch_setup_dma_ops(dev, dma_start, size, coherent);
>  
>  	if (!iommu)
>  		of_dma_set_restricted_buffer(dev, np);
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index f2fc203fb8a1a2..2cb98a12c50348 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -426,10 +426,10 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -		const struct iommu_ops *iommu, bool coherent);
> +		bool coherent);
>  #else
>  static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
> -		u64 size, const struct iommu_ops *iommu, bool coherent)
> +		u64 size, bool coherent)
>  {
>  }
>  #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
> -- 
> 2.42.0
> 

