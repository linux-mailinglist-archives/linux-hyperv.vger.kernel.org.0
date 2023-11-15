Return-Path: <linux-hyperv+bounces-960-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A27EC70F
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3268F1C20BA1
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A6381CB;
	Wed, 15 Nov 2023 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D7381CD;
	Wed, 15 Nov 2023 15:22:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05BD6AD;
	Wed, 15 Nov 2023 07:22:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F4BB1595;
	Wed, 15 Nov 2023 07:23:07 -0800 (PST)
Received: from [10.57.83.164] (unknown [10.57.83.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E023F641;
	Wed, 15 Nov 2023 07:22:11 -0800 (PST)
Message-ID: <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com>
Date: Wed, 15 Nov 2023 15:22:09 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] Solve iommu probe races around iommu_fwspec
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linux.dev,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Frank Rowand
 <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin
 <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>,
 patches@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
 virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh@kernel.org>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-15 2:05 pm, Jason Gunthorpe wrote:
> [Several people have tested this now, so it is something that should sit in
> linux-next for a while]

What's the aim here? This is obviously far, far too much for a stable 
fix, but then it's also not the refactoring we want for the future 
either, since it's moving in the wrong direction of cementing the 
fundamental brokenness further in place rather than getting any closer 
to removing it.

Thanks,
Robin.

> The iommu subsystem uses dev->iommu to store bits of information about the
> attached iommu driver. This has been co-opted by the ACPI/OF code to also
> be a place to pass around the iommu_fwspec before a driver is probed.
> 
> Since both are using the same pointers without any locking it triggers
> races if there is concurrent driver loading:
> 
>       CPU0                                     CPU1
> of_iommu_configure()                iommu_device_register()
>   ..                                   bus_iommu_probe()
>    iommu_fwspec_of_xlate()              __iommu_probe_device()
>                                          iommu_init_device()
>     dev_iommu_get()
>                                            .. ops->probe fails, no fwspec ..
>                                            dev_iommu_free()
>     dev->iommu->fwspec    *crash*
> 
> My first attempt get correct locking here was to use the device_lock to
> protect the entire *_iommu_configure() and iommu_probe() paths. This
> allowed safe use of dev->iommu within those paths. Unfortuately enough
> drivers abuse the of_iommu_configure() flow without proper locking and
> this approach failed.
> 
> This approach removes touches of dev->iommu from the *_iommu_configure()
> code. The few remaining required touches are moved into iommu.c and
> protected with the existing iommu_probe_device_lock.
> 
> To do this we change *_iommu_configure() to hold the iommu_fwspec on the
> stack while it is being built. Once it is fully formed the core code will
> install it into the dev->iommu when it calls probe.
> 
> This also removes all the touches of iommu_ops from
> the *_iommu_configure() paths and makes that mechanism private to the
> iommu core.
> 
> A few more lockdep assertions are added to discourage future mis-use.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_fwspec
> 
> v2:
>   - Fix all the kconfig randomization 0-day stuff
>   - Add missing kdoc parameters
>   - Remove NO_IOMMU, replace it with ENODEV
>   - Use PTR_ERR to print errno in the new/moved logging
> v1: https://lore.kernel.org/r/0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com
> 
> Jason Gunthorpe (17):
>    iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
>    iommmu/of: Do not return struct iommu_ops from of_iommu_configure()
>    iommu/of: Use -ENODEV consistently in of_iommu_configure()
>    acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
>    iommu: Make iommu_fwspec->ids a distinct allocation
>    iommu: Add iommu_fwspec_alloc/dealloc()
>    iommu: Add iommu_probe_device_fwspec()
>    iommu/of: Do not use dev->iommu within of_iommu_configure()
>    iommu: Add iommu_fwspec_append_ids()
>    acpi: Do not use dev->iommu within acpi_iommu_configure()
>    iommu: Hold iommu_probe_device_lock while calling ops->of_xlate
>    iommu: Make iommu_ops_from_fwnode() static
>    iommu: Remove dev_iommu_fwspec_set()
>    iommu: Remove pointless iommu_fwspec_free()
>    iommu: Add ops->of_xlate_fwspec()
>    iommu: Mark dev_iommu_get() with lockdep
>    iommu: Mark dev_iommu_priv_set() with a lockdep
> 
>   arch/arc/mm/dma.c                           |   2 +-
>   arch/arm/mm/dma-mapping-nommu.c             |   2 +-
>   arch/arm/mm/dma-mapping.c                   |  10 +-
>   arch/arm64/mm/dma-mapping.c                 |   4 +-
>   arch/mips/mm/dma-noncoherent.c              |   2 +-
>   arch/riscv/mm/dma-noncoherent.c             |   2 +-
>   drivers/acpi/arm64/iort.c                   |  42 ++--
>   drivers/acpi/scan.c                         | 104 +++++----
>   drivers/acpi/viot.c                         |  45 ++--
>   drivers/hv/hv_common.c                      |   2 +-
>   drivers/iommu/amd/iommu.c                   |   2 -
>   drivers/iommu/apple-dart.c                  |   1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   9 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  23 +-
>   drivers/iommu/intel/iommu.c                 |   2 -
>   drivers/iommu/iommu.c                       | 227 +++++++++++++++-----
>   drivers/iommu/of_iommu.c                    | 133 +++++-------
>   drivers/iommu/omap-iommu.c                  |   1 -
>   drivers/iommu/tegra-smmu.c                  |   1 -
>   drivers/iommu/virtio-iommu.c                |   8 +-
>   drivers/of/device.c                         |  24 ++-
>   include/acpi/acpi_bus.h                     |   8 +-
>   include/linux/acpi_iort.h                   |   8 +-
>   include/linux/acpi_viot.h                   |   5 +-
>   include/linux/dma-map-ops.h                 |   4 +-
>   include/linux/iommu.h                       |  47 ++--
>   include/linux/of_iommu.h                    |  13 +-
>   27 files changed, 424 insertions(+), 307 deletions(-)
> 
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

