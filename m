Return-Path: <linux-hyperv+bounces-1130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906317FCD44
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 04:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39249B213A7
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D625243;
	Wed, 29 Nov 2023 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHHsfnmj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C27C4;
	Tue, 28 Nov 2023 19:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701227501; x=1732763501;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AFgY7sxn3CNPZK+1LW7PN8hahu/sESx2ATRSHU4pdQk=;
  b=YHHsfnmjrutA6rqxIvt5fcrwsUDJSRZJzEw3pJnO8LKM2IXO6yygaK0K
   09MGURNSkX4Aj3YVf1wzSgvFKkAsaWrrsstdJ0v4NLTog29GaFuphLBj/
   iHCuZHGWoehP5jjka3IJHeLHcfE/fviJZ2yGJ9YvmAMqVVSDRaOfzMJD+
   2Cs4MvaLHs6qgiUS9sNL4eOgfRU9z7EkJA7/nB/oGdSJ3nzGd7XsX7qp+
   vlaikpKU5LY6h06p0x5VNrMT2Nz7Qhz6wx/L1jFxAGOSSDVQeVjb4AzCy
   IwAKbbhUTxpsWn/+JhmJYojpYU6bywzYF07TmLCLxbIKvYh2gcDouqwU9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="383476185"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383476185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834859960"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834859960"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.119]) ([10.254.211.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:11:27 -0800
Message-ID: <13db755e-682e-4550-9da2-a18628fc041c@linux.intel.com>
Date: Wed, 29 Nov 2023 11:11:27 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Hector Martin <marcan@marcan.st>,
 Moritz Fischer <mdf@kernel.org>, patches@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 04/10] iommu: Mark dev_iommu_get() with lockdep
Content-Language: en-US
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
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vineet Gupta <vgupta@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>
References: <4-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/29 8:48, Jason Gunthorpe wrote:
> Allocation of dev->iommu must be done under the
> iommu_probe_device_lock. Mark this with lockdep to discourage future
> mistakes.
> 
> Reviewed-by: Jerry Snitselaar<jsnitsel@redhat.com>
> Tested-by: Hector Martin<marcan@marcan.st>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

