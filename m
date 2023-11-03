Return-Path: <linux-hyperv+bounces-688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87977E0AC4
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 22:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32109B21482
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A621351;
	Fri,  3 Nov 2023 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlAxRz3a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C223773
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 21:42:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FBD61
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Nov 2023 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699047724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kZEfbVDRZWYaeV8fUpM6RCBCDL9qHVSAnBx2A/2LQY=;
	b=GlAxRz3aA+yVdEASoN2hD33r68ZRvuxuESxMOesRN6j5FWPEYQuruVvDcnvdI7RWusR7fa
	Gr36qrC5V1O55zoEAhl+RkMsd5F8mokubsqddJdO2xOK1nOytnCFqOy9cBEU9XpiL1XEa/
	kmQx0Y8bhdTfK9LJXR0QK/vVaH2NBr4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-0wl7_dcPNGKCdKBzFfVzdg-1; Fri, 03 Nov 2023 17:42:03 -0400
X-MC-Unique: 0wl7_dcPNGKCdKBzFfVzdg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3447c72c4so3648424b6e.1
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Nov 2023 14:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047723; x=1699652523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kZEfbVDRZWYaeV8fUpM6RCBCDL9qHVSAnBx2A/2LQY=;
        b=rnIp44yT/iAP8xjzhkET7GYQye3Dywi/IV1V2l7WpP9VwN498og+YkXFCANfUXPKCj
         UUJKXHK7cqBEM8M+PoPBS5cfmNi+CqW34JGFizENruM/qfP/iM9ElWrr79gJR89y7JdR
         xVcfGcVZaAFUOupS/eGR6zo+cXvIhO+qrAmjxehsnZYqRcdCvuwRU97mkOAP6d1U8oIE
         gnHJHA9RHt1JvBXxBariy9WoyohAoaSJtSHrZNRO6+mEDoobj96FHOMv546wkqATlbhc
         Cq5kp1bLEHveJZufQQ6IlAMOGsxRQIqT7iN16fChcP93z1qPuIjylyohrU+XTe1kTcYD
         KIYg==
X-Gm-Message-State: AOJu0YxnmXE5UR6pk/zR7/y5YlzqJ8br8c6dMT+DTE941CVkkPq3qXVJ
	yFqiVERl2cL6HsdU4alENy2FcWs74pwa1+jHEhZGYYwlUL2zSBBizgs+zh48X4wHVJe5mA+9JvZ
	+E8IFJjxyq0dLHthIiG7iOmMf
X-Received: by 2002:a05:6808:19:b0:3ae:501e:a645 with SMTP id u25-20020a056808001900b003ae501ea645mr23275054oic.50.1699047722994;
        Fri, 03 Nov 2023 14:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8CbIeTp1KbCoYxz0JbEv5CEOEPYpkRMvorwNXwSkDHUSj0XHfQL9HeaymHNNOyFjtaX5TA==
X-Received: by 2002:a05:6808:19:b0:3ae:501e:a645 with SMTP id u25-20020a056808001900b003ae501ea645mr23275015oic.50.1699047722718;
        Fri, 03 Nov 2023 14:42:02 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w19-20020aa78593000000b006b4ac8885b4sm1917578pfn.14.2023.11.03.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:42:02 -0700 (PDT)
Date: Fri, 3 Nov 2023 14:42:01 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 02/17] of: Do not return struct iommu_ops from
 of_iommu_configure()
Message-ID: <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:47PM -0300, Jason Gunthorpe wrote:
> Nothing needs this pointer. Return a normal error code with the usual
> IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
>  drivers/of/device.c      | 22 +++++++++++++++-------
>  include/linux/of_iommu.h | 13 ++++++-------
>  3 files changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 157b286e36bf3a..e2fa29c16dd758 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
>  		      of_iommu_configure_dev(master_np, dev);
>  }
>  
> -const struct iommu_ops *of_iommu_configure(struct device *dev,
> -					   struct device_node *master_np,
> -					   const u32 *id)
> +/*
> + * Returns:
> + *  0 on success, an iommu was configured
> + *  -ENODEV if the device does not have any IOMMU
> + *  -EPROBEDEFER if probing should be tried again
> + *  -errno fatal errors

It looks to me like it will only return 0, -ENODEV, or -EPROBEDEFER
with other -errno getting boiled down to -ENODEV.

> + */
> +int of_iommu_configure(struct device *dev, struct device_node *master_np,
> +		       const u32 *id)
>  {
>  	const struct iommu_ops *ops = NULL;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	int err = NO_IOMMU;
>  
>  	if (!master_np)
> -		return NULL;
> +		return -ENODEV;
>  
>  	if (fwspec) {
>  		if (fwspec->ops)
> -			return fwspec->ops;
> +			return 0;
>  
>  		/* In the deferred case, start again from scratch */
>  		iommu_fwspec_free(dev);
> @@ -163,14 +169,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  		err = iommu_probe_device(dev);
>  
>  	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err == -EPROBE_DEFER) {
> -		ops = ERR_PTR(err);
> -	} else if (err < 0) {
> +	if (err < 0) {
> +		if (err == -EPROBE_DEFER)
> +			return err;
>  		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);

minor thing, but should this use %pe and ERR_PTR(err) like is done
in of_dma_configure_id?

> -		ops = NULL;
> +		return -ENODEV;
>  	}
> -
> -	return ops;
> +	if (!ops)
> +		return -ENODEV;
> +	return 0;
>  }
>  
>  static enum iommu_resv_type __maybe_unused
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 65c71be71a8d45..873d933e8e6d1d 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -93,12 +93,12 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>  int of_dma_configure_id(struct device *dev, struct device_node *np,
>  			bool force_dma, const u32 *id)
>  {
> -	const struct iommu_ops *iommu;
>  	const struct bus_dma_region *map = NULL;
>  	struct device_node *bus_np;
>  	u64 dma_start = 0;
>  	u64 mask, end, size = 0;
>  	bool coherent;
> +	int iommu_ret;
>  	int ret;
>  
>  	if (np == dev->of_node)
> @@ -181,21 +181,29 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");
>  
> -	iommu = of_iommu_configure(dev, np, id);
> -	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
> +	iommu_ret = of_iommu_configure(dev, np, id);
> +	if (iommu_ret == -EPROBE_DEFER) {
>  		/* Don't touch range map if it wasn't set from a valid dma-ranges */
>  		if (!ret)
>  			dev->dma_range_map = NULL;
>  		kfree(map);
>  		return -EPROBE_DEFER;
> -	}
> +	} else if (iommu_ret == -ENODEV) {
> +		dev_dbg(dev, "device is not behind an iommu\n");
> +	} else if (iommu_ret) {
> +		dev_err(dev, "iommu configuration for device failed with %pe\n",
> +			ERR_PTR(iommu_ret));
>  
> -	dev_dbg(dev, "device is%sbehind an iommu\n",
> -		iommu ? " " : " not ");
> +		/*
> +		 * Historically this routine doesn't fail driver probing
> +		 * due to errors in of_iommu_configure()
> +		 */
> +	} else
> +		dev_dbg(dev, "device is behind an iommu\n");
>  
>  	arch_setup_dma_ops(dev, dma_start, size, coherent);
>  
> -	if (!iommu)
> +	if (iommu_ret)
>  		of_dma_set_restricted_buffer(dev, np);
>  
>  	return 0;
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 9a5e6b410dd2fb..e61cbbe12dac6f 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -8,20 +8,19 @@ struct iommu_ops;
>  
>  #ifdef CONFIG_OF_IOMMU
>  
> -extern const struct iommu_ops *of_iommu_configure(struct device *dev,
> -					struct device_node *master_np,
> -					const u32 *id);
> +extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
> +			      const u32 *id);
>  
>  extern void of_iommu_get_resv_regions(struct device *dev,
>  				      struct list_head *list);
>  
>  #else
>  
> -static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> -					 struct device_node *master_np,
> -					 const u32 *id)
> +static inline int of_iommu_configure(struct device *dev,
> +				     struct device_node *master_np,
> +				     const u32 *id)
>  {
> -	return NULL;
> +	return -ENODEV;
>  }
>  
>  static inline void of_iommu_get_resv_regions(struct device *dev,
> -- 
> 2.42.0
> 


