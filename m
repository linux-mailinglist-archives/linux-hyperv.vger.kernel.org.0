Return-Path: <linux-hyperv+bounces-997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A367F25EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 07:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4404AB216B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACA1BDFB;
	Tue, 21 Nov 2023 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="yBZ7Udel"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEDF90;
	Mon, 20 Nov 2023 22:48:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id EDDAF42137;
	Tue, 21 Nov 2023 06:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1700549281; bh=ujaYq3QQkb3U4N6JNFFQq4uH4QKQpO8RJp9aJVbB0w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=yBZ7Udel893+M2pzDMgdTushmaUgXq0nIf/5xxASROF107adcyenfoQIJKpJop3QE
	 1+yTIUhVbWxOP7swSXHE/1waIz+ytnfqIeOR+pXsrjnxJ9YDy9OcehudknnZZfDU0W
	 yBoxtsLq/eITHB2A8C7zHMk/QpuQDhn54/ueeppNZr5bacp1NBly8id6vI/+HcZLF9
	 Y3o89xan9Av9novKYwloiJeRxCXK4RdvbSm3KrREtUx62PnuC+h7WkJf1goRn4PDd/
	 8BaauSYV42Ok4T8UBbrfnw8aItI789XfEb5enuqF6bZ2I7QNWWCAUkdCy2CTlvEfD+
	 wJAB4I2ql495A==
Message-ID: <90855bbf-e845-4e4d-a713-df71d1e477d2@marcan.st>
Date: Tue, 21 Nov 2023 15:47:48 +0900
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
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20231119141329.GA6083@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/11/19 23:13, Jason Gunthorpe wrote:
> On Sun, Nov 19, 2023 at 06:19:43PM +0900, Hector Martin wrote:
>>>> +static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
>>>> +				     struct device *dev,
>>>> +				     struct fwnode_handle *iommu_fwnode)
>>>> +{
>>>> +	const struct iommu_ops *ops;
>>>> +
>>>> +	if (fwspec->iommu_fwnode) {
>>>> +		/*
>>>> +		 * fwspec->iommu_fwnode is the first iommu's fwnode. In the rare
>>>> +		 * case of multiple iommus for one device they must point to the
>>>> +		 * same driver, checked via same ops.
>>>> +		 */
>>>> +		ops = iommu_ops_from_fwnode(iommu_fwnode);
>>>
>>> This carries over a related bug from the original code: If a device has
>>> two IOMMUs and the first one probes but the second one defers, ops will
>>> be NULL here and the check will fail with EINVAL.
>>>
>>> Adding a check for that case here fixes it:
>>>
>>> 		if (!ops)
>>> 			return driver_deferred_probe_check_state(dev);
> 
> Yes!
> 
>>> With that, for the whole series:
>>>
>>> Tested-by: Hector Martin <marcan@marcan.st>
>>>
>>> I can't specifically test for the probe races the series intends to fix
>>> though, since that bug we only hit extremely rarely. I'm just testing
>>> that nothing breaks.
>>
>> Actually no, this fix is not sufficient. If the first IOMMU is ready
>> then the xlate path allocates dev->iommu, which then
>> __iommu_probe_device takes as a sign that all IOMMUs are ready and does
>> the device init.
> 
> It doesn't.. The code there is:
> 
> 	if (!fwspec && dev->iommu)
> 		fwspec = dev->iommu->fwspec;
> 	if (fwspec)
> 		ops = fwspec->ops;
> 	else
> 		ops = dev->bus->iommu_ops;
> 	if (!ops) {
> 		ret = -ENODEV;
> 		goto out_unlock;
> 	}
> 
> Which is sensitive only to !NULL fwspec, and if EPROBE_DEFER is
> returned fwspec will be freed and dev->iommu->fwspec will be NULL
> here.
> 
> In the NULL case it does a 'bus probe' with a NULL fwspec and all the
> fwspec drivers return immediately from their probe functions.
> 
> Did I miss something?

apple_dart is not a fwspec driver and doesn't do that :-)

> 
>> Then when the xlate comes along again after suceeding
>> with the second IOMMU, __iommu_probe_device sees the device is already
>> in a group and never initializes the second IOMMU, leaving the device
>> with only one IOMMU.
> 
> This should be fixed by the first hunk to check every iommu and fail?
> 
> BTW, do you have a systems with same device attached to multiple
> iommus?

Yes, Apple ARM64 machines all have multiple ganged IOMMUs for certain
devices (USB and ISP). We also attach all display IOMMUs to the global
virtual display-subsystem device to handle framebuffer mappings, instead
of trying to dynamically map them to a bunch of individual display
controllers (which is a lot more painful). That last one is what
reliably reproduces this problem, display breaks without both previous
patches ever since we started supporting more than one display output.
The first one is not enough.

> I've noticed another bug here, many drivers don't actually support
> differing iommu instances and nothing seems to check it..

apple-dart does (as long as all the IOMMUs are using that driver).

> 
> Thanks,
> Jason
> 
> 

- Hector

