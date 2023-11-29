Return-Path: <linux-hyperv+bounces-1134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E867FCED9
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719631C20F29
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE382DF41;
	Wed, 29 Nov 2023 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hz6Fo0z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27971BC
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:09:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d032ab478fso47749097b3.0
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701238147; x=1701842947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtrAPaslMvSrZFznq3cpY4nyS514mOCdxUhLK1bsTtI=;
        b=4hz6Fo0zr13+6MdTqERmKQ2VkYDymvvESL+rjVDOPONoVDKJ89JS5vZAr9cGWgmXeI
         iCe4Gr1jGA18zFyltB0mAD/LvIZELVoE4c6EchCPHovFaQBUpiekq7sj9kf+v7Wo8EJx
         Bm88PjF0fpSLVtBhcE5rMR6F2oPPd6VcEL7z3yoUssqZtKKmZXq1surFKjBwgpE7KTGB
         45g0aomlFJveBDLt1HtrdcU0h7pVzqQqVGdMrOL48/QkMYR4xYLFGf/1+0gDvqZJ/CB6
         Go1mLYlC8a6PciJgAAiTpf4CoQrR+BbzOfToCpWOsL7ZNwT+lyqyaGCbo+M6Eii4LMDn
         IpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238147; x=1701842947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtrAPaslMvSrZFznq3cpY4nyS514mOCdxUhLK1bsTtI=;
        b=KT1+SQ/kz079XE3J6hrVmwg0Lm2fRlv5BC+XmMltsQ+cpn0LKdMIflIPhg7+9upIFA
         DJanoQeYUyb6fwZsT7WYdpjzJIzUq+G7p/oh13E7ZYjhLIL3VRTSM4y4Csdi+ncvA9F7
         BokNDlCCf9N3AVQtBNo6qk8GQ0EyRmS4Y0LK6yn1rn0b+03ALmfb+CvwFY4dwX/6kT1P
         yOhKThIxHm2+81tk0k0ZPHdkuWmGW/RFIWIfNnHGqfr5Aplrr9pAiHNovR/CIasnU/GA
         3V2c71u8wN9OaGQDDpzStquyOjOfStBz366LO1MaminzAt5ptPFUASxf83CQj+FXpLDs
         DzUQ==
X-Gm-Message-State: AOJu0YxLgGp2VIQnDVrrsQeb13MORHdkmIT811Oy056+qB+T0pUoLgzR
	WQ9Ji4h39mxjxm4/lZbha7+sOSS1kSlk
X-Google-Smtp-Source: AGHT+IErKpR33sSuZDb458AGzbTTTl+rmkeUZNxvoUYyius6/ySrcsirHg/Fcs0NR9CFHutX0EyL3PHfE3h2
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:3741:0:b0:db5:2a4:aef1 with SMTP id
 e62-20020a253741000000b00db502a4aef1mr107973yba.13.1701238147290; Tue, 28 Nov
 2023 22:09:07 -0800 (PST)
Date: Wed, 29 Nov 2023 06:09:06 +0000
In-Reply-To: <7-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com> <7-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Message-ID: <20231129060906.qti7uztsk2u7ehlp@google.com>
Subject: Re: [PATCH 07/10] acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
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

On Tue, Nov 28, 2023 at 08:48:03PM -0400, Jason Gunthorpe wrote:
> Nothing needs this pointer. Return a normal error code with the usual
> IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/acpi/scan.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 444a0b3c72f2d8..340ba720c72129 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1562,8 +1562,7 @@ static inline const struct iommu_ops  
> *acpi_iommu_fwspec_ops(struct device *dev)
>   	return fwspec ? fwspec->ops : NULL;
>   }

> -static const struct iommu_ops *acpi_iommu_configure_id(struct device  
> *dev,
> -						       const u32 *id_in)
> +static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>   {
>   	int err;
>   	const struct iommu_ops *ops;
> @@ -1577,7 +1576,7 @@ static const struct iommu_ops  
> *acpi_iommu_configure_id(struct device *dev,
>   	ops = acpi_iommu_fwspec_ops(dev);
>   	if (ops) {
>   		mutex_unlock(&iommu_probe_device_lock);
> -		return ops;
> +		return 0;
>   	}

>   	err = iort_iommu_configure_id(dev, id_in);
> @@ -1594,12 +1593,14 @@ static const struct iommu_ops  
> *acpi_iommu_configure_id(struct device *dev,

>   	/* Ignore all other errors apart from EPROBE_DEFER */
>   	if (err == -EPROBE_DEFER) {
> -		return ERR_PTR(err);
> +		return err;
>   	} else if (err) {
>   		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -		return NULL;
> +		return -ENODEV;
>   	}
> -	return acpi_iommu_fwspec_ops(dev);
> +	if (!acpi_iommu_fwspec_ops(dev))
> +		return -ENODEV;
> +	return 0;
>   }

>   #else /* !CONFIG_IOMMU_API */
> @@ -1611,10 +1612,9 @@ int acpi_iommu_fwspec_init(struct device *dev, u32  
> id,
>   	return -ENODEV;
>   }

> -static const struct iommu_ops *acpi_iommu_configure_id(struct device  
> *dev,
> -						       const u32 *id_in)
> +static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>   {
> -	return NULL;
> +	return -ENODEV;
>   }

>   #endif /* !CONFIG_IOMMU_API */
> @@ -1628,7 +1628,7 @@ static const struct iommu_ops  
> *acpi_iommu_configure_id(struct device *dev,
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			  const u32 *input_id)
>   {
> -	const struct iommu_ops *iommu;
> +	int ret;

>   	if (attr == DEV_DMA_NOT_SUPPORTED) {
>   		set_dma_ops(dev, &dma_dummy_ops);
> @@ -1637,10 +1637,15 @@ int acpi_dma_configure_id(struct device *dev,  
> enum dev_dma_attr attr,

>   	acpi_arch_dma_setup(dev);

> -	iommu = acpi_iommu_configure_id(dev, input_id);
> -	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> +	ret = acpi_iommu_configure_id(dev, input_id);
> +	if (ret == -EPROBE_DEFER)
>   		return -EPROBE_DEFER;

> +	/*
> +	 * Historically this routine doesn't fail driver probing due to errors
> +	 * in acpi_iommu_configure_id()
> +	 */
> +
>   	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);

>   	return 0;
> --
> 2.42.0


Reviewed-by: Moritz Fischer <moritzf@google.com>

Cheers,
Moritz

