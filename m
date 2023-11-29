Return-Path: <linux-hyperv+bounces-1132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3B7FCECA
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 07:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ADF1C2110F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727579D6;
	Wed, 29 Nov 2023 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YC8Z/MJg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E81FE3
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:05:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ccaa0da231so84971817b3.2
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237903; x=1701842703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WO7CXB1mNGxZSEafQP2SArLxdW3co4lj0A5pbLIXeXc=;
        b=YC8Z/MJgWsD7+kRI5X7617QDZNem31VfuQDJHZLwZkhbOunqySfMHXFcN9pEZM3Swf
         K7f4mpb2M2zUY8pmscdoJ/ct6X47+MYlT5r0Ktiv5DYzV/FQbyXKEJJSjcPlbZPvzwHP
         clYR/15TXb5zQ4OLDJEUtFJTITDwcLWelth8F8sgd1Db0j+ocpYF/2AArjg7mWNhSqGm
         xsERRX5HK49/gIsx3+jPxhwRaxD6R0e7f9cAC02TmB4sogn1SdRl3zC4A3A73JBLIVlu
         ww0jFyFNBR4Z6PW85xsJtGsQfAHRM8w3Bf9v5K1WkwC2Uh68oX+2jxoaQJwC4TNrRtBx
         Zz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237903; x=1701842703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO7CXB1mNGxZSEafQP2SArLxdW3co4lj0A5pbLIXeXc=;
        b=T6tTj01nBcMiYMnoxGvBFm2LZz47FwvSu330yU6Gttdw6F/O4QPAmTSMls/SP6+cE1
         DuhUJfmYO0mZkPqzhMvkGZ1hVZYwTrfdBwpoWHFoN4FEcr3fLtUEL0kfx64cGQPDJOmF
         ryRegfgvDfnn9Zk17JaTdkQgR/kLbOOkI5SzZIGksej+UqvSZO6vMqnMfnBllQnyd9Xh
         QYBLeMtLHiO9Rp0/ke7TEhbqn7Wm8kbkE77g8GiuohliDD/A2cVLjE/jCm0MDLvX2dJD
         LbJs+PFZUDlw9yNurycFRb6Q3un263YsmlKl4jOZI9W1X26dBDqTybNSREn2SlTrulWd
         iTTg==
X-Gm-Message-State: AOJu0YzaTwf/sSfGclYwPwJkkjA1N9cgcPmSsNvT3jH7D/UuraeEc7Yl
	AG8Q3YwP3ekQX1Rg1OCpVyd+zFqiBi+I
X-Google-Smtp-Source: AGHT+IHL7hgboFJ1jDI8fHK0ttAzMEfTsQjA7vmjwBnF03SxrfXdHuhYyFsTgeIfr3cTonrW5FaGXfJVhISd
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:903:b0:59b:eb63:4beb with SMTP id
 cb3-20020a05690c090300b0059beb634bebmr584543ywb.7.1701237903050; Tue, 28 Nov
 2023 22:05:03 -0800 (PST)
Date: Wed, 29 Nov 2023 06:04:59 +0000
In-Reply-To: <3-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com> <3-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Message-ID: <20231129060459.gcunam3msksainng@google.com>
Subject: Re: [PATCH 03/10] iommu/of: Use -ENODEV consistently in of_iommu_configure()
From: Moritz Fischer <moritzf@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich <dakr@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev, 
	Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Karol Herbst <kherbst@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Laxman Dewangan <ldewangan@nvidia.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, nouveau@lists.freedesktop.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>, 
	Jerry Snitselaar <jsnitsel@redhat.com>, Hector Martin <marcan@marcan.st>, Moritz Fischer <mdf@kernel.org>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Tue, Nov 28, 2023 at 08:47:59PM -0400, Jason Gunthorpe wrote:
> Instead of returning 1 and trying to handle positive error codes just
> stick to the convention of returning -ENODEV. Remove references to ops
> from of_iommu_configure(), a NULL ops will already generate an error code.

> There is no reason to check dev->bus, if err=0 at this point then the
> called configure functions thought there was an iommu and we should try to
> probe it. Remove it.

> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 49 ++++++++++++----------------------------
>   1 file changed, 15 insertions(+), 34 deletions(-)

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c6510d7e7b241b..164317bfb8a81f 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -17,8 +17,6 @@
>   #include <linux/slab.h>
>   #include <linux/fsl/mc.h>

> -#define NO_IOMMU	1
> -
>   static int of_iommu_xlate(struct device *dev,
>   			  struct of_phandle_args *iommu_spec)
>   {
> @@ -29,7 +27,7 @@ static int of_iommu_xlate(struct device *dev,
>   	ops = iommu_ops_from_fwnode(fwnode);
>   	if ((ops && !ops->of_xlate) ||
>   	    !of_device_is_available(iommu_spec->np))
> -		return NO_IOMMU;
> +		return -ENODEV;

>   	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
>   	if (ret)
> @@ -61,7 +59,7 @@ static int of_iommu_configure_dev_id(struct device_node  
> *master_np,
>   			 "iommu-map-mask", &iommu_spec.np,
>   			 iommu_spec.args);
>   	if (err)
> -		return err == -ENODEV ? NO_IOMMU : err;
> +		return err;

>   	err = of_iommu_xlate(dev, &iommu_spec);
>   	of_node_put(iommu_spec.np);
> @@ -72,7 +70,7 @@ static int of_iommu_configure_dev(struct device_node  
> *master_np,
>   				  struct device *dev)
>   {
>   	struct of_phandle_args iommu_spec;
> -	int err = NO_IOMMU, idx = 0;
> +	int err = -ENODEV, idx = 0;

>   	while (!of_parse_phandle_with_args(master_np, "iommus",
>   					   "#iommu-cells",
> @@ -117,9 +115,8 @@ static int of_iommu_configure_device(struct  
> device_node *master_np,
>   int of_iommu_configure(struct device *dev, struct device_node *master_np,
>   		       const u32 *id)
>   {
> -	const struct iommu_ops *ops = NULL;
>   	struct iommu_fwspec *fwspec;
> -	int err = NO_IOMMU;
> +	int err;

>   	if (!master_np)
>   		return -ENODEV;
> @@ -153,37 +150,21 @@ int of_iommu_configure(struct device *dev, struct  
> device_node *master_np,
>   	} else {
>   		err = of_iommu_configure_device(master_np, dev, id);
>   	}
> -
> -	/*
> -	 * Two success conditions can be represented by non-negative err here:
> -	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
> -	 *  0 : we found an IOMMU, and dev->fwspec is initialised appropriately
> -	 * <0 : any actual error
> -	 */
> -	if (!err) {
> -		/* The fwspec pointer changed, read it again */
> -		fwspec = dev_iommu_fwspec_get(dev);
> -		ops    = fwspec->ops;
> -	}
>   	mutex_unlock(&iommu_probe_device_lock);

> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * probe for dev, replay it to get things in order.
> -	 */
> -	if (!err && dev->bus)
> -		err = iommu_probe_device(dev);
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err < 0) {
> -		if (err == -EPROBE_DEFER)
> -			return err;
> -		dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
> +	if (err == -ENODEV || err == -EPROBE_DEFER)
>   		return err;
> -	}
> -	if (!ops)
> -		return -ENODEV;
> +	if (err)
> +		goto err_log;
> +
> +	err = iommu_probe_device(dev);
> +	if (err)
> +		goto err_log;
>   	return 0;
> +
> +err_log:
> +	dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
> +	return err;
>   }

>   static enum iommu_resv_type __maybe_unused
> --
> 2.42.0


Reviewed-by: Moritz Fischer <moritzf@google.com>

