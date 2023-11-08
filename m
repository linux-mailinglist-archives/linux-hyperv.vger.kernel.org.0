Return-Path: <linux-hyperv+bounces-771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2007E5AD7
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EB01C20943
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981330CF1;
	Wed,  8 Nov 2023 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F830CE4;
	Wed,  8 Nov 2023 16:11:42 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18519A5;
	Wed,  8 Nov 2023 08:11:42 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b6a837a2e1so1343991b6e.0;
        Wed, 08 Nov 2023 08:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459901; x=1700064701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egO/3A8usR47pYsFMHy7at49a3WUUkqONQqbQuU8j7Y=;
        b=uQod2uDabayaXs6n7pwKDCysCHgfTd9wESlvdVVu/fkWxQyzZ9A7WLlQiagmCnXVy/
         MNk/dfTd9iTDPTgBL00944LlP6QON7nPmmuq6LNrkUX7/e4U9gzyWnp1z3GAR2zMWrmT
         zI52HfydorbUqrEvI2Zgor+S7ZfCLWBUWUY0Ksgfq4m88rsSgp6NtcbyASZOpWQrHTx8
         XWvZUvMZgA7Oul39qQeb+WAVbH8PdIBbD458O6GhsqXkAqrOnAmj02lMwbJnSREPqkH4
         Fp61PR25gxnM72SeSV4M7hSutG/7if41F9ZPNLUfw8egVvxrZK6hiXb7mHCoKprIVKQz
         /bOw==
X-Gm-Message-State: AOJu0YzG5Ll5iELF/d99pw9llmLPrWJhhm49rzpE2822eRK/aVpabPXv
	lumrtbvPV7jeErhKVyjQjA==
X-Google-Smtp-Source: AGHT+IFG1ydbraxTf3qUlkUHE402Zq2u5RjAY4fdhcYCPQiBAZE+mNt+Ni+JkQlZMBRuNIEkL2d3Ow==
X-Received: by 2002:a05:6808:15a8:b0:3a9:cfb5:4641 with SMTP id t40-20020a05680815a800b003a9cfb54641mr3241896oiw.48.1699459901513;
        Wed, 08 Nov 2023 08:11:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05680817aa00b003afc33bf048sm1959000oib.2.2023.11.08.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:11:40 -0800 (PST)
Received: (nullmailer pid 2284755 invoked by uid 1000);
	Wed, 08 Nov 2023 16:11:38 -0000
Date: Wed, 8 Nov 2023 10:11:38 -0600
From: Rob Herring <robh@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
	virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 03/17] of: Use -ENODEV consistently in
 of_iommu_configure()
Message-ID: <20231108161138.GA2254211-robh@kernel.org>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:48PM -0300, Jason Gunthorpe wrote:
> Instead of returning 1 and trying to handle positive error codes just
> stick to the convention of returning -ENODEV. Remove references to ops
> from of_iommu_configure(), a NULL ops will already generate an error code.

nit: "iommu: of: ..." or "iommu/of: " for the subject. "of: ..." is 
generally drivers/of/.

> 
> There is no reason to check dev->bus, if err=0 at this point then the
> called configure functions thought there was an iommu and we should try to
> probe it. Remove it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 42 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)

