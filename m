Return-Path: <linux-hyperv+bounces-715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB3A7E51CE
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 09:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1744C1C20CCC
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC9DDAE;
	Wed,  8 Nov 2023 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM5ggnqu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0CD531;
	Wed,  8 Nov 2023 08:18:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDEBD40;
	Wed,  8 Nov 2023 00:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699431526; x=1730967526;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4b+vqtKY9OOVsB1rEVpRTkAptYNaJoA44xLfvE+DI0=;
  b=aM5ggnquRc4JfgBaSl4uxeHgeNly12r4MhEqiy0Sr6loV1tZ9mWmA0bi
   XwwY6PePnnxvz8lp1wzVhVGS2o/ovsOqVdztnRGKoB8fs/Sis1bh2EPXv
   DV6fICVz6BJwYK/mWl40m82OZFclqC0nAujgRBnkKI+YJ9VB8rMG0mJgN
   nCgPQQrV8FplNTCvnxu71u2WdscYq/NdngkSA5y95REyjvZUmRJDn0VAO
   BLxCRK9oQPMCO53mPmIsoeenrOUJPX1j8hFRfa3fX7Y0TqmiCyrt+VZOA
   +h8NESp350gggYUuEZliFOFKrLOU1yRS+CYjCghTbyQvu2TEySefRp9xk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420823085"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="420823085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828883803"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="828883803"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.63]) ([10.254.215.63])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:18:32 -0800
Message-ID: <f7e69801-e651-471d-9768-43ddf1702f91@linux.intel.com>
Date: Wed, 8 Nov 2023 16:18:30 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 17/17] iommu: Mark dev_iommu_priv_set() with a lockdep
Content-Language: en-US
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
References: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/4 0:45, Jason Gunthorpe wrote:
> A perfect driver would only call dev_iommu_priv_set() from its probe
> callback. We've made it functionally correct to call it from the of_xlate
> by adding a lock around that call.
> 
> lockdep assert that iommu_probe_device_lock is held to discourage misuse.
> 
> Exclude PPC kernels with CONFIG_FSL_PAMU turned on because FSL_PAMU uses a
> global static for its priv and abuses priv for its domain.
> 
> Remove the pointless stores of NULL, all these are on paths where the core
> code will free dev->iommu after the op returns.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/amd/iommu.c                   | 2 --
>   drivers/iommu/apple-dart.c                  | 1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 -
>   drivers/iommu/intel/iommu.c                 | 2 --
>   drivers/iommu/iommu.c                       | 9 +++++++++
>   drivers/iommu/omap-iommu.c                  | 1 -
>   include/linux/iommu.h                       | 5 +----
>   8 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

