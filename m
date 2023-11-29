Return-Path: <linux-hyperv+bounces-1138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF07FD739
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 13:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABBB1C20EAE
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDAF1DFDC;
	Wed, 29 Nov 2023 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7LzFukE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0067CED0;
	Wed, 29 Nov 2023 12:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E359C433C8;
	Wed, 29 Nov 2023 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701262523;
	bh=EjcKHBcdIRPeS1Jr3Xl1RByJy2jdZRnaeHgtLca5xvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7LzFukE5dLDnjFimKjS9MzsDlyjw2TystsfEqKZQoF3X0ypDR27ShYPrtl8a4hDA
	 NJpjxQGGyxZWEsXW8iuNcZhKohbcA/aqSnTm0M4FaNA2iGO+NYSrUn6Py4Nri/ePlp
	 6q+xpqSCX/D4UrdrxiaqNtzCTiHavix0EiBQCRhmLqMpgR0ZYgs/JzAEoWb+9i5JTB
	 Oe+1+75v5eXMmJzgFHrdDl81TfuAg+2NbIX93el81U7iGTeg6IV4SGN5q4PuHW91Kd
	 ubXJDdo+ZPM5cWSGL7AsbHeYdmv+aYCsKzrJkAOks6DDY5k/SnNe6msZhjyp96wYb4
	 GEiHLnbD5cmcA==
Date: Wed, 29 Nov 2023 13:55:04 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Airlie <airlied@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Karol Herbst <kherbst@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lyude Paul <lyude@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	nouveau@lists.freedesktop.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Hector Martin <marcan@marcan.st>, Moritz Fischer <mdf@kernel.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/10] ACPI: IORT: Allow COMPILE_TEST of IORT
Message-ID: <ZWc0qPWzNWPkL8vt@lpieralisi>
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
 <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>

On Tue, Nov 28, 2023 at 08:48:06PM -0400, Jason Gunthorpe wrote:
> The arm-smmu driver can COMPILE_TEST on x86, so expand this to also
> enable the IORT code so it can be COMPILE_TEST'd too.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/acpi/Kconfig        | 2 --
>  drivers/acpi/Makefile       | 2 +-
>  drivers/acpi/arm64/Kconfig  | 1 +
>  drivers/acpi/arm64/Makefile | 2 +-
>  drivers/iommu/Kconfig       | 1 +
>  5 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff195a..3b7f77b227d13a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -541,9 +541,7 @@ config ACPI_PFRUT
>  	  To compile the drivers as modules, choose M here:
>  	  the modules will be called pfr_update and pfr_telemetry.
>  
> -if ARM64
>  source "drivers/acpi/arm64/Kconfig"
> -endif
>  
>  config ACPI_PPTT
>  	bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f1760..4e77ae37b80726 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -127,7 +127,7 @@ obj-y				+= pmic/
>  video-objs			+= acpi_video.o video_detect.o
>  obj-y				+= dptf/
>  
> -obj-$(CONFIG_ARM64)		+= arm64/
> +obj-y				+= arm64/
>  
>  obj-$(CONFIG_ACPI_VIOT)		+= viot.o
>  
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c1e..537d49d8ace69e 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ACPI_GTDT
>  
>  config ACPI_AGDI
>  	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM64
>  	depends on ARM_SDE_INTERFACE
>  	help
>  	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a9d..71d0e635599390 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>  obj-$(CONFIG_ARM_AMBA)		+= amba.o
> -obj-y				+= dma.o init.o
> +obj-$(CONFIG_ARM64)		+= dma.o init.o
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7673bb82945b6c..309378e76a9bc9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,6 +318,7 @@ config ARM_SMMU
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
> +	select ACPI_IORT if ACPI
>  	help
>  	  Support for implementations of the ARM System MMU architecture
>  	  versions 1 and 2.
> -- 

I don't think it should be done this way. Is the goal compile testing
IORT code ? If so, why are we forcing it through the SMMU (only because
it can be compile tested while eg SMMUv3 driver can't ?) menu entry ?

This looks a bit artificial (and it is unclear from the Kconfig
file why only that driver selects IORT, it looks like eg the SMMUv3
does not have the same dependency - there is also the SMMUv3 perf
driver to consider).

Maybe we can move IORT code into drivers/acpi and add a silent config
option there with a dependency on ARM64 || COMPILE_TEST.

Don't know but at least it is clearer. As for the benefits of compile
testing IORT code - yes the previous patch is a warning to fix but
I am not so sure about the actual benefits.

Thanks,
Lorenzo

