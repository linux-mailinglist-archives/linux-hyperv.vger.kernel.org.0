Return-Path: <linux-hyperv+bounces-860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEF7E91D7
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C78B209CA
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8A156F5;
	Sun, 12 Nov 2023 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF02156CC;
	Sun, 12 Nov 2023 17:44:23 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2D259D;
	Sun, 12 Nov 2023 09:44:20 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c9b7c234a7so32907595ad.3;
        Sun, 12 Nov 2023 09:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699811060; x=1700415860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvhxjJJa/Ci/xiREQjeS8Wq0K4FF0IBEX2F6g2Az9kA=;
        b=NbTOwLHVjRywrph6w1jwMws/9TqSrzzZAiFhJxdIEBIodAf4zTtG2pz29d5X40oRe6
         P1clbtS51Gd3bEK0EIiKBzERnY7Nnhpzk6UaDGsQnkwZJ0H8/lFFPpuBM6yeSYDdWBJR
         W72whS6+G+p/ovNgecdKq8zDTkCA9Ii+4yKDRS5j8TTyxU73+YEm1eeQtg5Y+t6Az7Kk
         rZfSyBQBRdjjcQar8dcdsUN8wpKYRVlzNoO49RNKwFPbCJG/jzYgxCzSMvDdKUNtPtEt
         LdFxuDeXMRj7qT9gmdtPZdAQcFZ8L4gebX1m/Rc5i/z3obMj4nguUauX+HNpN+MjLB89
         EP6g==
X-Gm-Message-State: AOJu0Yx/I2p/s5un9x5ecOo1YxBi0R5eW+MMPQy5SlqcX/1b7V1NfFwx
	KAOwVes6z1p9UMSSpxJE1OY=
X-Google-Smtp-Source: AGHT+IGW/6opwcX0FKkXoXOWhN/xe80DDhDI51xBwA9NGI/6J99Nej7hImFcEeW3SS6pkD9vP0+f8A==
X-Received: by 2002:a17:902:c10c:b0:1cc:41c5:adfd with SMTP id 12-20020a170902c10c00b001cc41c5adfdmr5540408pli.49.1699811060025;
        Sun, 12 Nov 2023 09:44:20 -0800 (PST)
Received: from localhost ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001c5fc291ef9sm2777542plg.209.2023.11.12.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 09:44:19 -0800 (PST)
Date: Sun, 12 Nov 2023 09:44:18 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
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
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	virtualization@lists.linux-foundation.org,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 10/17] acpi: Do not use dev->iommu within
 acpi_iommu_configure()
Message-ID: <ZVEO8li-WnQMXaLc@archbook>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:55PM -0300, Jason Gunthorpe wrote:
> This call chain is using dev->iommu->fwspec to pass around the fwspec
> between the three parts (acpi_iommu_configure(), acpi_iommu_fwspec_init(),
> iommu_probe_device()).
> 
> However there is no locking around the accesses to dev->iommu, so this is
> all racy.
> 
> Allocate a clean, local, fwspec at the start of acpu_iommu_configure(),
Nit: s/acpu_iommu_configure/acpi_iommu_configure_id() ?
> pass it through all functions on the stack to fill it with data, and
> finally pass it into iommu_probe_device_fwspec() which will load it into
> dev->iommu under a lock.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 39 ++++++++---------
>  drivers/acpi/scan.c       | 89 ++++++++++++++++++---------------------
>  drivers/acpi/viot.c       | 44 ++++++++++---------
>  drivers/iommu/iommu.c     |  5 +--
>  include/acpi/acpi_bus.h   |  8 ++--
>  include/linux/acpi_iort.h |  3 +-
>  include/linux/acpi_viot.h |  5 ++-
>  include/linux/iommu.h     |  2 +
>  8 files changed, 97 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 6496ff5a6ba20d..accd01dcfe93f5 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1218,10 +1218,9 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>  	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
>  }
>  
> -static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
> -			    u32 streamid)
> +static int iort_iommu_xlate(struct iommu_fwspec *fwspec, struct device *dev,
> +			    struct acpi_iort_node *node, u32 streamid)
>  {
> -	const struct iommu_ops *ops;
>  	struct fwnode_handle *iort_fwnode;
>  
>  	if (!node)
> @@ -1239,17 +1238,14 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>  	 * in the kernel or not, defer the IOMMU configuration
>  	 * or just abort it.
>  	 */
> -	ops = iommu_ops_from_fwnode(iort_fwnode);
> -	if (!ops)
> -		return iort_iommu_driver_enabled(node->type) ?
> -		       -EPROBE_DEFER : -ENODEV;
> -
> -	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(fwspec, dev, streamid, iort_fwnode,
> +				      iort_iommu_driver_enabled(node->type));
>  }
>  
>  struct iort_pci_alias_info {
>  	struct device *dev;
>  	struct acpi_iort_node *node;
> +	struct iommu_fwspec *fwspec;
>  };
>  
>  static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> @@ -1260,7 +1256,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  
>  	parent = iort_node_map_id(info->node, alias, &streamid,
>  				  IORT_IOMMU_TYPE);
> -	return iort_iommu_xlate(info->dev, parent, streamid);
> +	return iort_iommu_xlate(info->fwspec, info->dev, parent, streamid);
>  }
>  
>  static void iort_named_component_init(struct device *dev,
> @@ -1280,7 +1276,8 @@ static void iort_named_component_init(struct device *dev,
>  		dev_warn(dev, "Could not add device properties\n");
>  }
>  
> -static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
> +static int iort_nc_iommu_map(struct iommu_fwspec *fwspec, struct device *dev,
> +			     struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_node *parent;
>  	int err = -ENODEV, i = 0;
> @@ -1293,13 +1290,13 @@ static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
>  						   i++);
>  
>  		if (parent)
> -			err = iort_iommu_xlate(dev, parent, streamid);
> +			err = iort_iommu_xlate(fwspec, dev, parent, streamid);
>  	} while (parent && !err);
>  
>  	return err;
>  }
>  
> -static int iort_nc_iommu_map_id(struct device *dev,
> +static int iort_nc_iommu_map_id(struct iommu_fwspec *fwspec, struct device *dev,
>  				struct acpi_iort_node *node,
>  				const u32 *in_id)
>  {
> @@ -1308,7 +1305,7 @@ static int iort_nc_iommu_map_id(struct device *dev,
>  
>  	parent = iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_TYPE);
>  	if (parent)
> -		return iort_iommu_xlate(dev, parent, streamid);
> +		return iort_iommu_xlate(fwspec, dev, parent, streamid);
>  
>  	return -ENODEV;
>  }
> @@ -1322,15 +1319,16 @@ static int iort_nc_iommu_map_id(struct device *dev,
>   *
>   * Returns: 0 on success, <0 on failure
>   */
> -int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
> +			    const u32 *id_in)
>  {
>  	struct acpi_iort_node *node;
>  	int err = -ENODEV;
>  
>  	if (dev_is_pci(dev)) {
> -		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> -		struct iort_pci_alias_info info = { .dev = dev };
> +		struct iort_pci_alias_info info = { .dev = dev,
> +						    .fwspec = fwspec };
>  
>  		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>  				      iort_match_node_callback, &bus->dev);
> @@ -1341,8 +1339,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
>  
> -		fwspec = dev_iommu_fwspec_get(dev);
> -		if (fwspec && iort_pci_rc_supports_ats(node))
> +		if (iort_pci_rc_supports_ats(node))
>  			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> @@ -1350,8 +1347,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  		if (!node)
>  			return -ENODEV;
>  
> -		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
> -			      iort_nc_iommu_map(dev, node);
> +		err = id_in ? iort_nc_iommu_map_id(fwspec, dev, node, id_in) :
> +			      iort_nc_iommu_map(fwspec, dev, node);
>  
>  		if (!err)
>  			iort_named_component_init(dev, node);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fbabde001a23a2..1e01a8e0316867 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1543,74 +1543,67 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>  }
>  
>  #ifdef CONFIG_IOMMU_API
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops)
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> +			   u32 id, struct fwnode_handle *fwnode,
> +			   bool iommu_driver_available)
>  {
> -	int ret = iommu_fwspec_init(dev, fwnode, ops);
> +	int ret;
>  
> -	if (!ret)
> -		ret = iommu_fwspec_add_ids(dev, &id, 1);
> -
> -	return ret;
> -}
> -
> -static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	return fwspec ? fwspec->ops : NULL;
> +	ret = iommu_fwspec_assign_iommu(fwspec, dev, fwnode);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER && !iommu_driver_available)
> +			return -ENODEV;
> +		return ret;
> +	}
> +	return iommu_fwspec_append_ids(fwspec, &id, 1);
>  }
>  
>  static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>  	int err;
> -	const struct iommu_ops *ops;
> +	struct iommu_fwspec *fwspec;
>  
> -	/*
> -	 * If we already translated the fwspec there is nothing left to do,
> -	 * return the iommu_ops.
> -	 */
> -	ops = acpi_iommu_fwspec_ops(dev);
> -	if (ops)
> -		return 0;
> +	fwspec = iommu_fwspec_alloc();
> +	if (IS_ERR(fwspec))
> +		return PTR_ERR(fwspec);
>  
> -	err = iort_iommu_configure_id(dev, id_in);
> -	if (err && err != -EPROBE_DEFER)
> -		err = viot_iommu_configure(dev);
> +	err = iort_iommu_configure_id(fwspec, dev, id_in);
> +	if (err == -ENODEV)
> +		err = viot_iommu_configure(fwspec, dev);
> +	if (err == -ENODEV || err == -EPROBE_DEFER)
> +		goto err_free;
> +	if (err)
> +		goto err_log;
>  
> -	/*
> -	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * iommu_probe_device() call for dev, replay it to get things in order.
> -	 */
> -	if (!err && dev->bus)
> -		err = iommu_probe_device(dev);
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (err == -EPROBE_DEFER) {
> -		return err;
> -	} else if (err) {
> -		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -		return -ENODEV;
> +	err = iommu_probe_device_fwspec(dev, fwspec);
> +	if (err) {
> +		/*
> +		 * Ownership for fwspec always passes into
> +		 * iommu_probe_device_fwspec()
> +		 */
> +		fwspec = NULL;
> +		goto err_log;
>  	}
> -	if (!acpi_iommu_fwspec_ops(dev))
> -		return -ENODEV;
> -	return 0;
> +
> +err_log:
> +	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +err_free:
> +	iommu_fwspec_dealloc(fwspec);
> +	return err;
>  }
>  
>  #else /* !CONFIG_IOMMU_API */
>  
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops)
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> +			   u32 id, struct fwnode_handle *fwnode,
> +			   bool iommu_driver_available)
>  {
>  	return -ENODEV;
>  }
>  
> -static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> -						       const u32 *id_in)
> +static const int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
> -	return NULL;
> +	return -ENODEV;
>  }
>  
>  #endif /* !CONFIG_IOMMU_API */
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index c8025921c129b2..33b511dd202d15 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -304,11 +304,9 @@ void __init acpi_viot_init(void)
>  	acpi_put_table(hdr);
>  }
>  
> -static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
> -			       u32 epid)
> +static int viot_dev_iommu_init(struct iommu_fwspec *fwspec, struct device *dev,
> +			       struct viot_iommu *viommu, u32 epid)
>  {
> -	const struct iommu_ops *ops;
> -
>  	if (!viommu)
>  		return -ENODEV;
>  
> @@ -316,19 +314,20 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
>  	if (device_match_fwnode(dev, viommu->fwnode))
>  		return -EINVAL;
>  
> -	ops = iommu_ops_from_fwnode(viommu->fwnode);
> -	if (!ops)
> -		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
> -			-EPROBE_DEFER : -ENODEV;
> -
> -	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
> +	return acpi_iommu_fwspec_init(fwspec, dev, epid, viommu->fwnode,
> +				      IS_ENABLED(CONFIG_VIRTIO_IOMMU));
>  }
>  
> +struct viot_pci_alias_info {
> +	struct device *dev;
> +	struct iommu_fwspec *fwspec;
> +};
> +
>  static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  {
>  	u32 epid;
>  	struct viot_endpoint *ep;
> -	struct device *aliased_dev = data;
> +	struct viot_pci_alias_info *info = data;
>  	u32 domain_nr = pci_domain_nr(pdev->bus);
>  
>  	list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -339,14 +338,15 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  			epid = ((domain_nr - ep->segment_start) << 16) +
>  				dev_id - ep->bdf_start + ep->endpoint_id;
>  
> -			return viot_dev_iommu_init(aliased_dev, ep->viommu,
> -						   epid);
> +			return viot_dev_iommu_init(info->fwspec, info->dev,
> +						   ep->viommu, epid);
>  		}
>  	}
>  	return -ENODEV;
>  }
>  
> -static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
> +static int viot_mmio_dev_iommu_init(struct iommu_fwspec *fwspec,
> +				    struct platform_device *pdev)
>  {
>  	struct resource *mem;
>  	struct viot_endpoint *ep;
> @@ -357,8 +357,8 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
>  
>  	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
>  		if (ep->address == mem->start)
> -			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
> -						   ep->endpoint_id);
> +			return viot_dev_iommu_init(fwspec, &pdev->dev,
> +						   ep->viommu, ep->endpoint_id);
>  	}
>  	return -ENODEV;
>  }
> @@ -369,12 +369,16 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
>   *
>   * Return: 0 on success, <0 on failure
>   */
> -int viot_iommu_configure(struct device *dev)
> +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev)
>  {
> -	if (dev_is_pci(dev))
> +	if (dev_is_pci(dev)) {
> +		struct viot_pci_alias_info info = { .dev = dev,
> +						    .fwspec = fwspec };
>  		return pci_for_each_dma_alias(to_pci_dev(dev),
> -					      viot_pci_dev_iommu_init, dev);
> +					      viot_pci_dev_iommu_init, &info);
> +	}
>  	else if (dev_is_platform(dev))
> -		return viot_mmio_dev_iommu_init(to_platform_device(dev));
> +		return viot_mmio_dev_iommu_init(fwspec,
> +						to_platform_device(dev));
>  	return -ENODEV;
>  }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 15dbe2d9eb24c2..9cfba9d12d1400 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2960,9 +2960,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>  	return ops;
>  }
>  
> -static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
> -				     struct device *dev,
> -				     struct fwnode_handle *iommu_fwnode)
> +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
> +			      struct fwnode_handle *iommu_fwnode)
>  {
>  	const struct iommu_ops *ops;
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 254685085c825c..70f97096c776e4 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -12,6 +12,8 @@
>  #include <linux/device.h>
>  #include <linux/property.h>
>  
> +struct iommu_fwspec;
> +
>  /* TBD: Make dynamic */
>  #define ACPI_MAX_HANDLES	10
>  struct acpi_handle_list {
> @@ -625,9 +627,9 @@ struct acpi_pci_root {
>  
>  bool acpi_dma_supported(const struct acpi_device *adev);
>  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops);
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> +			   u32 id, struct fwnode_handle *fwnode,
> +			   bool iommu_driver_available);
>  int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>  			   const u32 *input_id);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1cb65592c95dd3..80794ec45d1693 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -40,7 +40,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
>  		       struct list_head *head);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
> -int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
> +			    const u32 *id_in);
>  void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> index a5a12243156377..f1874cb6d43c09 100644
> --- a/include/linux/acpi_viot.h
> +++ b/include/linux/acpi_viot.h
> @@ -8,11 +8,12 @@
>  #ifdef CONFIG_ACPI_VIOT
>  void __init acpi_viot_early_init(void);
>  void __init acpi_viot_init(void);
> -int viot_iommu_configure(struct device *dev);
> +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev);
>  #else
>  static inline void acpi_viot_early_init(void) {}
>  static inline void acpi_viot_init(void) {}
> -static inline int viot_iommu_configure(struct device *dev)
> +static inline int viot_iommu_configure(struct iommu_fwspec *fwspec,
> +				       struct device *dev)
>  {
>  	return -ENODEV;
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c5a5e2b5e2cc2a..27e4605d498850 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -688,6 +688,8 @@ void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
>  int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
>  			  struct fwnode_handle *iommu_fwnode,
>  			  struct of_phandle_args *iommu_spec);
> +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
> +			      struct fwnode_handle *iommu_fwnode);
>  
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
> -- 
> 2.42.0
> 

