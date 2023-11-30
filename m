Return-Path: <linux-hyperv+bounces-1163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F697FF15F
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E4C1C20F13
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F0495D8;
	Thu, 30 Nov 2023 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1662383;
	Thu, 30 Nov 2023 06:10:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1940F143D;
	Thu, 30 Nov 2023 06:11:43 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 107D53F5A1;
	Thu, 30 Nov 2023 06:10:49 -0800 (PST)
Message-ID: <2e0f0aac-6287-45d1-ae96-6549c15a8418@arm.com>
Date: Thu, 30 Nov 2023 14:10:48 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] ACPI: IORT: Allow COMPILE_TEST of IORT
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Danilo Krummrich <dakr@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Woodhouse <dwmw2@infradead.org>, Frank Rowand
 <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
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
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, nouveau@lists.freedesktop.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vineet Gupta <vgupta@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Hector Martin <marcan@marcan.st>,
 Moritz Fischer <mdf@kernel.org>, patches@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <10-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:48 am, Jason Gunthorpe wrote:
> The arm-smmu driver can COMPILE_TEST on x86, so expand this to also
> enable the IORT code so it can be COMPILE_TEST'd too.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/acpi/Kconfig        | 2 --
>   drivers/acpi/Makefile       | 2 +-
>   drivers/acpi/arm64/Kconfig  | 1 +
>   drivers/acpi/arm64/Makefile | 2 +-
>   drivers/iommu/Kconfig       | 1 +
>   5 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff195a..3b7f77b227d13a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -541,9 +541,7 @@ config ACPI_PFRUT
>   	  To compile the drivers as modules, choose M here:
>   	  the modules will be called pfr_update and pfr_telemetry.
>   
> -if ARM64
>   source "drivers/acpi/arm64/Kconfig"
> -endif
>   
>   config ACPI_PPTT
>   	bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f1760..4e77ae37b80726 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -127,7 +127,7 @@ obj-y				+= pmic/
>   video-objs			+= acpi_video.o video_detect.o
>   obj-y				+= dptf/
>   
> -obj-$(CONFIG_ARM64)		+= arm64/
> +obj-y				+= arm64/
>   
>   obj-$(CONFIG_ACPI_VIOT)		+= viot.o
>   
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c1e..537d49d8ace69e 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -11,6 +11,7 @@ config ACPI_GTDT
>   
>   config ACPI_AGDI
>   	bool "Arm Generic Diagnostic Dump and Reset Device Interface"
> +	depends on ARM64
>   	depends on ARM_SDE_INTERFACE
>   	help
>   	  Arm Generic Diagnostic Dump and Reset Device Interface (AGDI) is
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a9d..71d0e635599390 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
> -obj-y				+= dma.o init.o
> +obj-$(CONFIG_ARM64)		+= dma.o init.o
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 7673bb82945b6c..309378e76a9bc9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,6 +318,7 @@ config ARM_SMMU
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
>   	select ARM_DMA_USE_IOMMU if ARM
> +	select ACPI_IORT if ACPI

This is incomplete. If you want the driver to be responsible for 
enabling its own probing mechanisms then you need to select OF and ACPI 
too. And all the other drivers which probe from IORT should surely also 
select ACPI_IORT, and thus ACPI as well. And maybe the PCI core should 
as well because there are general properties of PCI host bridges and 
devices described in there?

But of course that's clearly backwards nonsense, because drivers do not 
and should not do that, so this change is not appropriate either. The 
IORT code may not be *functionally* arm64-specific, but logically it 
very much is - it serves a specification which is tied to the Arm 
architecture and describes Arm-architecture-specific concepts, within 
the wider context of ACPI on Arm itself only supporting AArch64, and not 
AArch32. It's also not like it's driver code that someone might use as 
an example and copy to a similar driver which could then run on 
different architectures where a latent theoretical bug becomes real. 
There's really no practical value to be had from compile-testing IORT.

Thanks,
Robin.

