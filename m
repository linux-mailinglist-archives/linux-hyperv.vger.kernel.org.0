Return-Path: <linux-hyperv+bounces-706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD147E2717
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200E8281638
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06127701;
	Mon,  6 Nov 2023 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039728DB1;
	Mon,  6 Nov 2023 14:36:42 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9933BD;
	Mon,  6 Nov 2023 06:36:40 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-587af6285c0so207707eaf.1;
        Mon, 06 Nov 2023 06:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281400; x=1699886200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cdR2/VKi6UPuhkYIfGhIxLOEjAPCEY76bcIkQ8v+Ms=;
        b=RCTVWamgZHMhUORLL/HbExKK8f9zfPx3pf5W2I8weRW4xax+VGA/p8Dv23FgHivjJT
         yX138rAXskRr/6fnaPhy8LI1h9tP1tykhPndrSuVWIcxOofG+dl6hWHf3O/Flp03+vWG
         KRhjOToCY9jH5gvlZuHg8xOdW8L68W6w9Anj4WVGZGdHVGE8ef4KYAqQKFuL+zBfr/uY
         1yk1bqf8jFyV7Losawh3LHshRbKgsi96ZVc8pk4I1ecuLts3nh7UxRAQ+kG6y7fqkkzV
         hWFYenedfotNUKPsQdKnvtk+xccDJ7DM0frWgm0x1NvdT++LBpql4gOWcJn8jSBIRciD
         XhRQ==
X-Gm-Message-State: AOJu0Yx7HYcQi7jCHqTjDE9mQOxcuDB8Flo6m6dV6N4g/ZB5nxiUMJ8S
	3afc2mCMmkkvF+6BuQVPxLAyWtYvS/3kYbSBk8Q=
X-Google-Smtp-Source: AGHT+IHbe2zI3U23b+PVzNucg829Wp6e2Bcxf0uK0hh0lJZt2GaAY1e0EjSPEFsMQ2ih3YgyFNGuBSiBcA14YA5OhH8=
X-Received: by 2002:a4a:3390:0:b0:587:947b:31f4 with SMTP id
 q138-20020a4a3390000000b00587947b31f4mr5630046ooq.1.1699281399853; Mon, 06
 Nov 2023 06:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com> <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:36:28 +0100
Message-ID: <CAJZ5v0hh4xUDxWOjDhdczAuMVS-1HneukrqoDvMQgQ6EmeXejQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/17] acpi: Do not use dev->iommu within acpi_iommu_configure()
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
	Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
	virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 5:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> This call chain is using dev->iommu->fwspec to pass around the fwspec
> between the three parts (acpi_iommu_configure(), acpi_iommu_fwspec_init()=
,
> iommu_probe_device()).
>
> However there is no locking around the accesses to dev->iommu, so this is
> all racy.
>
> Allocate a clean, local, fwspec at the start of acpu_iommu_configure(),
> pass it through all functions on the stack to fill it with data, and
> finally pass it into iommu_probe_device_fwspec() which will load it into
> dev->iommu under a lock.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> @@ -1218,10 +1218,9 @@ static bool iort_pci_rc_supports_ats(struct acpi_i=
ort_node *node)
>         return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
>  }
>
> -static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *n=
ode,
> -                           u32 streamid)
> +static int iort_iommu_xlate(struct iommu_fwspec *fwspec, struct device *=
dev,
> +                           struct acpi_iort_node *node, u32 streamid)
>  {
> -       const struct iommu_ops *ops;
>         struct fwnode_handle *iort_fwnode;
>
>         if (!node)
> @@ -1239,17 +1238,14 @@ static int iort_iommu_xlate(struct device *dev, s=
truct acpi_iort_node *node,
>          * in the kernel or not, defer the IOMMU configuration
>          * or just abort it.
>          */
> -       ops =3D iommu_ops_from_fwnode(iort_fwnode);
> -       if (!ops)
> -               return iort_iommu_driver_enabled(node->type) ?
> -                      -EPROBE_DEFER : -ENODEV;
> -
> -       return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
> +       return acpi_iommu_fwspec_init(fwspec, dev, streamid, iort_fwnode,
> +                                     iort_iommu_driver_enabled(node->typ=
e));
>  }
>
>  struct iort_pci_alias_info {
>         struct device *dev;
>         struct acpi_iort_node *node;
> +       struct iommu_fwspec *fwspec;
>  };
>
>  static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *da=
ta)
> @@ -1260,7 +1256,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev=
, u16 alias, void *data)
>
>         parent =3D iort_node_map_id(info->node, alias, &streamid,
>                                   IORT_IOMMU_TYPE);
> -       return iort_iommu_xlate(info->dev, parent, streamid);
> +       return iort_iommu_xlate(info->fwspec, info->dev, parent, streamid=
);
>  }
>
>  static void iort_named_component_init(struct device *dev,
> @@ -1280,7 +1276,8 @@ static void iort_named_component_init(struct device=
 *dev,
>                 dev_warn(dev, "Could not add device properties\n");
>  }
>
> -static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *=
node)
> +static int iort_nc_iommu_map(struct iommu_fwspec *fwspec, struct device =
*dev,
> +                            struct acpi_iort_node *node)
>  {
>         struct acpi_iort_node *parent;
>         int err =3D -ENODEV, i =3D 0;
> @@ -1293,13 +1290,13 @@ static int iort_nc_iommu_map(struct device *dev, =
struct acpi_iort_node *node)
>                                                    i++);
>
>                 if (parent)
> -                       err =3D iort_iommu_xlate(dev, parent, streamid);
> +                       err =3D iort_iommu_xlate(fwspec, dev, parent, str=
eamid);
>         } while (parent && !err);
>
>         return err;
>  }
>
> -static int iort_nc_iommu_map_id(struct device *dev,
> +static int iort_nc_iommu_map_id(struct iommu_fwspec *fwspec, struct devi=
ce *dev,
>                                 struct acpi_iort_node *node,
>                                 const u32 *in_id)
>  {
> @@ -1308,7 +1305,7 @@ static int iort_nc_iommu_map_id(struct device *dev,
>
>         parent =3D iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_T=
YPE);
>         if (parent)
> -               return iort_iommu_xlate(dev, parent, streamid);
> +               return iort_iommu_xlate(fwspec, dev, parent, streamid);
>
>         return -ENODEV;
>  }
> @@ -1322,15 +1319,16 @@ static int iort_nc_iommu_map_id(struct device *de=
v,
>   *
>   * Returns: 0 on success, <0 on failure
>   */
> -int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *=
dev,
> +                           const u32 *id_in)
>  {
>         struct acpi_iort_node *node;
>         int err =3D -ENODEV;
>
>         if (dev_is_pci(dev)) {
> -               struct iommu_fwspec *fwspec;
>                 struct pci_bus *bus =3D to_pci_dev(dev)->bus;
> -               struct iort_pci_alias_info info =3D { .dev =3D dev };
> +               struct iort_pci_alias_info info =3D { .dev =3D dev,
> +                                                   .fwspec =3D fwspec };
>
>                 node =3D iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>                                       iort_match_node_callback, &bus->dev=
);
> @@ -1341,8 +1339,7 @@ int iort_iommu_configure_id(struct device *dev, con=
st u32 *id_in)
>                 err =3D pci_for_each_dma_alias(to_pci_dev(dev),
>                                              iort_pci_iommu_init, &info);
>
> -               fwspec =3D dev_iommu_fwspec_get(dev);
> -               if (fwspec && iort_pci_rc_supports_ats(node))
> +               if (iort_pci_rc_supports_ats(node))
>                         fwspec->flags |=3D IOMMU_FWSPEC_PCI_RC_ATS;
>         } else {
>                 node =3D iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> @@ -1350,8 +1347,8 @@ int iort_iommu_configure_id(struct device *dev, con=
st u32 *id_in)
>                 if (!node)
>                         return -ENODEV;
>
> -               err =3D id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
> -                             iort_nc_iommu_map(dev, node);
> +               err =3D id_in ? iort_nc_iommu_map_id(fwspec, dev, node, i=
d_in) :
> +                             iort_nc_iommu_map(fwspec, dev, node);
>
>                 if (!err)
>                         iort_named_component_init(dev, node);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fbabde001a23a2..1e01a8e0316867 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1543,74 +1543,67 @@ int acpi_dma_get_range(struct device *dev, const =
struct bus_dma_region **map)
>  }
>
>  #ifdef CONFIG_IOMMU_API
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -                          struct fwnode_handle *fwnode,
> -                          const struct iommu_ops *ops)
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *d=
ev,
> +                          u32 id, struct fwnode_handle *fwnode,
> +                          bool iommu_driver_available)
>  {
> -       int ret =3D iommu_fwspec_init(dev, fwnode, ops);
> +       int ret;
>
> -       if (!ret)
> -               ret =3D iommu_fwspec_add_ids(dev, &id, 1);
> -
> -       return ret;
> -}
> -
> -static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct devic=
e *dev)
> -{
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> -
> -       return fwspec ? fwspec->ops : NULL;
> +       ret =3D iommu_fwspec_assign_iommu(fwspec, dev, fwnode);
> +       if (ret) {
> +               if (ret =3D=3D -EPROBE_DEFER && !iommu_driver_available)
> +                       return -ENODEV;
> +               return ret;
> +       }
> +       return iommu_fwspec_append_ids(fwspec, &id, 1);
>  }
>
>  static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>         int err;
> -       const struct iommu_ops *ops;
> +       struct iommu_fwspec *fwspec;
>
> -       /*
> -        * If we already translated the fwspec there is nothing left to d=
o,
> -        * return the iommu_ops.
> -        */
> -       ops =3D acpi_iommu_fwspec_ops(dev);
> -       if (ops)
> -               return 0;
> +       fwspec =3D iommu_fwspec_alloc();
> +       if (IS_ERR(fwspec))
> +               return PTR_ERR(fwspec);
>
> -       err =3D iort_iommu_configure_id(dev, id_in);
> -       if (err && err !=3D -EPROBE_DEFER)
> -               err =3D viot_iommu_configure(dev);
> +       err =3D iort_iommu_configure_id(fwspec, dev, id_in);
> +       if (err =3D=3D -ENODEV)
> +               err =3D viot_iommu_configure(fwspec, dev);
> +       if (err =3D=3D -ENODEV || err =3D=3D -EPROBE_DEFER)
> +               goto err_free;
> +       if (err)
> +               goto err_log;
>
> -       /*
> -        * If we have reason to believe the IOMMU driver missed the initi=
al
> -        * iommu_probe_device() call for dev, replay it to get things in =
order.
> -        */
> -       if (!err && dev->bus)
> -               err =3D iommu_probe_device(dev);
> -
> -       /* Ignore all other errors apart from EPROBE_DEFER */
> -       if (err =3D=3D -EPROBE_DEFER) {
> -               return err;
> -       } else if (err) {
> -               dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -               return -ENODEV;
> +       err =3D iommu_probe_device_fwspec(dev, fwspec);
> +       if (err) {
> +               /*
> +                * Ownership for fwspec always passes into
> +                * iommu_probe_device_fwspec()
> +                */
> +               fwspec =3D NULL;
> +               goto err_log;
>         }
> -       if (!acpi_iommu_fwspec_ops(dev))
> -               return -ENODEV;
> -       return 0;
> +
> +err_log:
> +       dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +err_free:
> +       iommu_fwspec_dealloc(fwspec);
> +       return err;
>  }
>
>  #else /* !CONFIG_IOMMU_API */
>
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -                          struct fwnode_handle *fwnode,
> -                          const struct iommu_ops *ops)
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *d=
ev,
> +                          u32 id, struct fwnode_handle *fwnode,
> +                          bool iommu_driver_available)
>  {
>         return -ENODEV;
>  }
>
> -static const struct iommu_ops *acpi_iommu_configure_id(struct device *de=
v,
> -                                                      const u32 *id_in)
> +static const int acpi_iommu_configure_id(struct device *dev, const u32 *=
id_in)
>  {
> -       return NULL;
> +       return -ENODEV;
>  }
>
>  #endif /* !CONFIG_IOMMU_API */
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index c8025921c129b2..33b511dd202d15 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -304,11 +304,9 @@ void __init acpi_viot_init(void)
>         acpi_put_table(hdr);
>  }
>
> -static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *vi=
ommu,
> -                              u32 epid)
> +static int viot_dev_iommu_init(struct iommu_fwspec *fwspec, struct devic=
e *dev,
> +                              struct viot_iommu *viommu, u32 epid)
>  {
> -       const struct iommu_ops *ops;
> -
>         if (!viommu)
>                 return -ENODEV;
>
> @@ -316,19 +314,20 @@ static int viot_dev_iommu_init(struct device *dev, =
struct viot_iommu *viommu,
>         if (device_match_fwnode(dev, viommu->fwnode))
>                 return -EINVAL;
>
> -       ops =3D iommu_ops_from_fwnode(viommu->fwnode);
> -       if (!ops)
> -               return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
> -                       -EPROBE_DEFER : -ENODEV;
> -
> -       return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
> +       return acpi_iommu_fwspec_init(fwspec, dev, epid, viommu->fwnode,
> +                                     IS_ENABLED(CONFIG_VIRTIO_IOMMU));
>  }
>
> +struct viot_pci_alias_info {
> +       struct device *dev;
> +       struct iommu_fwspec *fwspec;
> +};
> +
>  static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, voi=
d *data)
>  {
>         u32 epid;
>         struct viot_endpoint *ep;
> -       struct device *aliased_dev =3D data;
> +       struct viot_pci_alias_info *info =3D data;
>         u32 domain_nr =3D pci_domain_nr(pdev->bus);
>
>         list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -339,14 +338,15 @@ static int viot_pci_dev_iommu_init(struct pci_dev *=
pdev, u16 dev_id, void *data)
>                         epid =3D ((domain_nr - ep->segment_start) << 16) =
+
>                                 dev_id - ep->bdf_start + ep->endpoint_id;
>
> -                       return viot_dev_iommu_init(aliased_dev, ep->viomm=
u,
> -                                                  epid);
> +                       return viot_dev_iommu_init(info->fwspec, info->de=
v,
> +                                                  ep->viommu, epid);
>                 }
>         }
>         return -ENODEV;
>  }
>
> -static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
> +static int viot_mmio_dev_iommu_init(struct iommu_fwspec *fwspec,
> +                                   struct platform_device *pdev)
>  {
>         struct resource *mem;
>         struct viot_endpoint *ep;
> @@ -357,8 +357,8 @@ static int viot_mmio_dev_iommu_init(struct platform_d=
evice *pdev)
>
>         list_for_each_entry(ep, &viot_mmio_endpoints, list) {
>                 if (ep->address =3D=3D mem->start)
> -                       return viot_dev_iommu_init(&pdev->dev, ep->viommu=
,
> -                                                  ep->endpoint_id);
> +                       return viot_dev_iommu_init(fwspec, &pdev->dev,
> +                                                  ep->viommu, ep->endpoi=
nt_id);
>         }
>         return -ENODEV;
>  }
> @@ -369,12 +369,16 @@ static int viot_mmio_dev_iommu_init(struct platform=
_device *pdev)
>   *
>   * Return: 0 on success, <0 on failure
>   */
> -int viot_iommu_configure(struct device *dev)
> +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev=
)
>  {
> -       if (dev_is_pci(dev))
> +       if (dev_is_pci(dev)) {
> +               struct viot_pci_alias_info info =3D { .dev =3D dev,
> +                                                   .fwspec =3D fwspec };
>                 return pci_for_each_dma_alias(to_pci_dev(dev),
> -                                             viot_pci_dev_iommu_init, de=
v);
> +                                             viot_pci_dev_iommu_init, &i=
nfo);
> +       }
>         else if (dev_is_platform(dev))
> -               return viot_mmio_dev_iommu_init(to_platform_device(dev));
> +               return viot_mmio_dev_iommu_init(fwspec,
> +                                               to_platform_device(dev));
>         return -ENODEV;
>  }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 15dbe2d9eb24c2..9cfba9d12d1400 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2960,9 +2960,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struc=
t fwnode_handle *fwnode)
>         return ops;
>  }
>
> -static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
> -                                    struct device *dev,
> -                                    struct fwnode_handle *iommu_fwnode)
> +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device=
 *dev,
> +                             struct fwnode_handle *iommu_fwnode)
>  {
>         const struct iommu_ops *ops;
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
>  #define ACPI_MAX_HANDLES       10
>  struct acpi_handle_list {
> @@ -625,9 +627,9 @@ struct acpi_pci_root {
>
>  bool acpi_dma_supported(const struct acpi_device *adev);
>  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -                          struct fwnode_handle *fwnode,
> -                          const struct iommu_ops *ops);
> +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *d=
ev,
> +                          u32 id, struct fwnode_handle *fwnode,
> +                          bool iommu_driver_available);
>  int acpi_dma_get_range(struct device *dev, const struct bus_dma_region *=
*map);
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>                            const u32 *input_id);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1cb65592c95dd3..80794ec45d1693 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -40,7 +40,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwno=
de,
>                        struct list_head *head);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
> -int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *=
dev,
> +                           const u32 *id_in);
>  void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead);
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
> +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev=
);
>  #else
>  static inline void acpi_viot_early_init(void) {}
>  static inline void acpi_viot_init(void) {}
> -static inline int viot_iommu_configure(struct device *dev)
> +static inline int viot_iommu_configure(struct iommu_fwspec *fwspec,
> +                                      struct device *dev)
>  {
>         return -ENODEV;
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c5a5e2b5e2cc2a..27e4605d498850 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -688,6 +688,8 @@ void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec=
);
>  int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *de=
v,
>                           struct fwnode_handle *iommu_fwnode,
>                           struct of_phandle_args *iommu_spec);
> +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device=
 *dev,
> +                             struct fwnode_handle *iommu_fwnode);
>
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fw=
node,
>                       const struct iommu_ops *ops);
> --
> 2.42.0
>

