Return-Path: <linux-hyperv+bounces-1135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38EE7FCEF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 07:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314451C210EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 06:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92992FBE6;
	Wed, 29 Nov 2023 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bu9LKCMw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A218F
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:18:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db402e6f61dso7437437276.3
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 22:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701238707; x=1701843507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4qMZXxn7dMNLyiBgKsZSJFUlenzauaBGTwqmqEkBs=;
        b=Bu9LKCMwAEyeZhjFEjzQZAlQfeHblnds9mH52MAD5JFR7alspWp6uCO28vfpqAXMJl
         3okcUl7pFCmP6O5iYoBxTSrgFkyZ+wqu6qMJZVok7v5Sns4gwZxlHhhbVmsHSxMIleyO
         eyAdGQnYYXbXjtXhlXEpJVSj+lkq1EvSK4DamzesU/mmmWBSIMbX2Wet38KdpAbpTimf
         0qAhKpMkoty3wx/yu4lixkJffB+wXXClIydIcMwx3YNlWzQFYyyJX7hEHSbM/+ezAlNN
         SLLYZCpsdUolK/k8yYGi/2bmJcW/HQ1O91oLpXORi1fczVZ94VM2hzeMlCClJL618xpP
         qXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238707; x=1701843507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4qMZXxn7dMNLyiBgKsZSJFUlenzauaBGTwqmqEkBs=;
        b=nDK7yBon/Mf7ZSw/3zoZV3pdlw1YqAew+sdp2dJUHoqZ0SElKI9eSexNvfrpb9TKj5
         kYq0OTmgr3XexP4zCs6tUcFjwy9o6UX5xU+7IKQOWqI9p3fwzK1Lz0oN/1bNmRDsOKfn
         6ZNlw5QfHJFa5uoa5ZyKFY4KmE/Ln8ZQwdgIs3WS9iC3CS8Q5mupXv9ZF53+FVYgKG8g
         bN6a+3ekaIZw/ccJVgx60jTo/qJEonz+hMh8VmZRGd0RMwFi+YsHLQ3MHmjJvmO+5X2N
         Z5dl4yo4SKQGbkLERKiWOwyhVbVWUSh7gicUO/Xdw56SGjS24UPAGQqorcSwRB4bjNus
         GXLw==
X-Gm-Message-State: AOJu0YwrRMfI3jRHMjsP80WGiGTy6/mmAyRMYt3y/MAdMlC3BNYwxiGx
	w/PpAwX+lLI4tNVk/BWcMcLFVuVCFEo3
X-Google-Smtp-Source: AGHT+IFcUygGdfS95PQxvEDzLlpossLvNyVov+P9EiIyJqoPwhfNYT1rdzAgRP7ca8iJPDCSOmBZ7cELCldp
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:d287:0:b0:db3:8b00:22eb with SMTP id
 j129-20020a25d287000000b00db38b0022ebmr482941ybg.6.1701238706756; Tue, 28 Nov
 2023 22:18:26 -0800 (PST)
Date: Wed, 29 Nov 2023 06:18:25 +0000
In-Reply-To: <9-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com> <9-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Message-ID: <20231129061825.altvhmgltws2bvhh@google.com>
Subject: Re: [PATCH 09/10] ACPI: IORT: Cast from ULL to phys_addr_t
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

On Tue, Nov 28, 2023 at 08:48:05PM -0400, Jason Gunthorpe wrote:
> gcc on i386 (when compile testing) warns:

This is a weird test. The Makefile for drivers/acpi/arm64 is conditional
on CONFIG_ARM64. How does this happen?

> 8->8
obj-$(CONFIG_ARM64)		+= arm64/
> 8->8


>   drivers/acpi/arm64/iort.c:2014:18: warning: implicit conversion  
> from 'unsigned long long' to 'phys_addr_t' (aka 'unsigned int') changes  
> value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
>                             local_limit =  
> DMA_BIT_MASK(ncomp->memory_address_limit);

> Because DMA_BIT_MASK returns a large ULL constant. Explicitly truncate it
> to phys_addr_t.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/acpi/arm64/iort.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 6496ff5a6ba20d..bdaf9256870d92 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -2011,7 +2011,8 @@ phys_addr_t __init  
> acpi_iort_dma_get_max_cpu_address(void)

>   		case ACPI_IORT_NODE_NAMED_COMPONENT:
>   			ncomp = (struct acpi_iort_named_component *)node->node_data;
> -			local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
> +			local_limit = (phys_addr_t)DMA_BIT_MASK(
> +				ncomp->memory_address_limit);
>   			limit = min_not_zero(limit, local_limit);
>   			break;

> @@ -2020,7 +2021,8 @@ phys_addr_t __init  
> acpi_iort_dma_get_max_cpu_address(void)
>   				break;

>   			rc = (struct acpi_iort_root_complex *)node->node_data;
> -			local_limit = DMA_BIT_MASK(rc->memory_address_limit);
> +			local_limit = (phys_addr_t)DMA_BIT_MASK(
> +				rc->memory_address_limit);
>   			limit = min_not_zero(limit, local_limit);
>   			break;
>   		}
> --
> 2.42.0


Cheers,
Moritz

