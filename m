Return-Path: <linux-hyperv+bounces-974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E777EE2FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9441F273B0
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2866328CF;
	Thu, 16 Nov 2023 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C7D4B;
	Thu, 16 Nov 2023 06:36:33 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d67d32adc2so453120a34.2;
        Thu, 16 Nov 2023 06:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145392; x=1700750192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQe83AHexfh3GazMLDTY5AyEL167MohegfRBMKLl7I8=;
        b=gNgC8dPRqLpw2x9mM5EFEyinbYSiySY+yTYN5Cu0s8Bap4S+L5cfNbYGyTh9YixSso
         sLdKjQOqZyNphUb5EAIJSkEOtBu37K7JkAeBUcZB92nPzMXLT3dm3enWGxXQeixZXGyN
         PiKol+kvyAtt0NmCupHw4grxx7aizpbEdPIEbiuSei039njKHok+Ja1oWK9o17bom+2m
         bfVMzzzOLVb7invMry6VkDlmfZZff0C22pFj7INoJ1vibbfj5FrrE9FxeDZieAJcbyId
         5aPr5n2jAU1325SdWHLtxbT6BW/ZqsXtpD2h41lhNPJdA+M73cmUdh/pKdKn023c7EDV
         YGcA==
X-Gm-Message-State: AOJu0YzZwOPeuoAheeJhryleNtZZTA97BCQnndpTQNQJXCW5s/WXFjLo
	DIDdY19R4xTkyCrZ39zLw8M=
X-Google-Smtp-Source: AGHT+IHU4Lxx+/myT+H5YB5iQwSXHLDIA41zmD2u+pjBktk3mb+GPBhIH+yVJJ2/AO7NCTzQtZy56A==
X-Received: by 2002:a05:6830:10c7:b0:6c4:ae52:9599 with SMTP id z7-20020a05683010c700b006c4ae529599mr9476568oto.7.1700145392505;
        Thu, 16 Nov 2023 06:36:32 -0800 (PST)
Received: from localhost ([2600:380:7a60:430d:7a98:972a:884d:31ff])
        by smtp.gmail.com with ESMTPSA id l2-20020a9d7082000000b006cd099bb052sm912460otj.1.2023.11.16.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:36:32 -0800 (PST)
Date: Thu, 16 Nov 2023 06:36:30 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 12/17] iommu: Make iommu_ops_from_fwnode() static
Message-ID: <ZVYo7s_dV9HDm1qU@archbook>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <12-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>

On Wed, Nov 15, 2023 at 10:06:03AM -0400, Jason Gunthorpe wrote:
> There are no external callers now.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  include/linux/iommu.h | 7 -------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5af98cad06f9ef..ea6aede326131e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2928,7 +2928,8 @@ bool iommu_default_passthrough(void)
>  }
>  EXPORT_SYMBOL_GPL(iommu_default_passthrough);
>  
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> +static const struct iommu_ops *
> +iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  {
>  	const struct iommu_ops *ops = NULL;
>  	struct iommu_device *iommu;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 72ec71bd31a376..05c5ad6bad6339 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -831,7 +831,6 @@ static inline void iommu_fwspec_free(struct device *dev)
>  	dev->iommu->fwspec = NULL;
>  }
>  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>  int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
>  
>  static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
> @@ -1187,12 +1186,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
>  	return -ENODEV;
>  }
>  
> -static inline
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> -{
> -	return NULL;
> -}
> -
>  static inline int
>  iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>  {
> -- 
> 2.42.0
> 

