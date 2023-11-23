Return-Path: <linux-hyperv+bounces-1038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281D87F5ACE
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF42B20D55
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF011D6A5;
	Thu, 23 Nov 2023 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="bEylMheX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015610E;
	Thu, 23 Nov 2023 01:08:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 9BDB241EF0;
	Thu, 23 Nov 2023 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1700730528; bh=tKvmM8VauJ2SKlC76Ts+IMS9Y0f1D93gbN6PS2aS1RQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bEylMheXkP1AY7uDhyUgpvOvmafAgnH8kYOyGsGvzSEm3AG0TuKGO12XpHG7pIpPk
	 7DWjDpQ/2UVGkEBlWmpkMsK+kkFSTbFl2mNZf+evyauyJJjLkxYiIMvQnQZccc7GYl
	 eyA+fRFKB/4nH2lfKLFZ7jOWf+ZnhEEAdxplIRYiCSC8oH9YCENIvFOPHr97tQOVpS
	 vFMyIE8sCHGbUWmMQTW6+kNNQZA2kAYPQ/d2k1mzDzQUzP4vU581SpL8b4NQXqoDyL
	 Nq2SuV6KB6PtAtBepsn6kZamgJlbVvwi56sMxTDqNBWGfHkerXitbj24KAHWAlJH6q
	 nnb+VrbjJRB5A==
Message-ID: <ab23469f-19ce-4681-afc9-65518730b51b@marcan.st>
Date: Thu, 23 Nov 2023 18:08:33 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] iommu: Add iommu_fwspec_alloc/dealloc()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frank Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
 virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
References: <6-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <20a7ef6d-a8ca-4bd8-ad7e-11856db617a2@marcan.st>
 <1eb12c35-e64e-4c32-af99-8743dc2ec266@marcan.st>
 <20231119141329.GA6083@nvidia.com>
 <90855bbf-e845-4e4d-a713-df71d1e477d2@marcan.st>
 <20231121160058.GG6083@nvidia.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20231121160058.GG6083@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/11/22 1:00, Jason Gunthorpe wrote:
> On Tue, Nov 21, 2023 at 03:47:48PM +0900, Hector Martin wrote:
>>> Which is sensitive only to !NULL fwspec, and if EPROBE_DEFER is
>>> returned fwspec will be freed and dev->iommu->fwspec will be NULL
>>> here.
>>>
>>> In the NULL case it does a 'bus probe' with a NULL fwspec and all the
>>> fwspec drivers return immediately from their probe functions.
>>>
>>> Did I miss something?
>>
>> apple_dart is not a fwspec driver and doesn't do that :-)
> 
> It implements of_xlate that makes it a driver using the fwspec probe
> path.
> 
> The issue is in apple-dart. Its logic for avoiding bus probe vs
> fwspec probe is not correct.
> 
> It does:
> 
> static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
> {
>  [..]
>  	dev_iommu_priv_set(dev, cfg);
> 
> 
> Then:
> 
> static struct iommu_device *apple_dart_probe_device(struct device *dev)
> {
> 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> 	struct apple_dart_stream_map *stream_map;
> 	int i;
> 
> 	if (!cfg)
> 		return ERR_PTR(-ENODEV);
> 
> Which leaks the cfg memory on rare error cases and wrongly allows the
> driver to probe without a fwspec, which I think is what you are
> hitting.
> 
> It should be
> 
>        if (!dev_iommu_fwspec_get(dev) || !cfg)
> 		return ERR_PTR(-ENODEV);
> 
> To ensure the driver never probes on the bus path.
> 
> Clearing the dev->iommu in the core code has the side effect of
> clearing (and leaking) the cfg which would hide this issue.

Aha! Yes, that makes it work with only the first change. I'll throw the
apple-dart fix into our tree (and submit it once I get to clearing out
the branch; the affected consumer driver isn't upstream yet so this
isn't particularly urgent).

- Hector

