Return-Path: <linux-hyperv+bounces-705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0897E26DE
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 15:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1E1C20B73
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124928DA4;
	Mon,  6 Nov 2023 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9828DA7;
	Mon,  6 Nov 2023 14:33:04 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F859BD;
	Mon,  6 Nov 2023 06:33:03 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-582a82e6d10so1012453eaf.0;
        Mon, 06 Nov 2023 06:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281182; x=1699885982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdHOkDDDq2uDsqnfkV1g2ITyJ/uBNt8L8qaNucWn9Lg=;
        b=mok4LGaGi7OIvm5KmMRRjX7+qy9KKC3eAB9+DupJ6U0lyEXxUUlByepiaB8sslymVm
         7n6+TiwirzMO9gbq/oGeQ5z+fvOSMoPMRwAdcfXj9cY+OhUHjzERkbqlFUXT6aykHiZk
         QzqVvZh1lp9TiZxFpXCvUlM6BwcJfH7Ci4GMGuczSnssytKPApYaGJgA2dflWGAsM3rp
         JjxPJc5cF+ockZPGkhkmD5SvzDdNsDNKd1JtOyfcqyuo0+4Qhg2U1+gUMq+xPT5+oyGt
         wBpqE4EukcD0rXgrdWMUSyFHk3o/g60N+wFHFc+uV97+rnbtHVmHNvX9vulCm2ASZjWO
         Dbeg==
X-Gm-Message-State: AOJu0YzMFf4TI2+ysrPEt8vRjBECazKqYkhuk1HRk3TGjaQR0fph882X
	q87VQBkapYjLdT0RKf3tzDBgJRxgRRiDaZNLjbY=
X-Google-Smtp-Source: AGHT+IHyHB4kzvcjkEhTb+3sUVIPXXX0cO5Y7IiQxSg2gu4OXnnfVIuOscNqmkEqJcDtSiyYa7NRTI4+Cg8Mb+uLm9Y=
X-Received: by 2002:a4a:d68a:0:b0:584:1080:f0a5 with SMTP id
 i10-20020a4ad68a000000b005841080f0a5mr31132550oot.1.1699281182420; Mon, 06
 Nov 2023 06:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com> <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:32:51 +0100
Message-ID: <CAJZ5v0hepKO0QKuBF3d38r=7nG0tjTtEwXdPNPv_2jYPnToUsg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
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
> Nothing needs this pointer. Return a normal error code with the usual
> IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a6891ad0ceee2c..fbabde001a23a2 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1562,8 +1562,7 @@ static inline const struct iommu_ops *acpi_iommu_fw=
spec_ops(struct device *dev)
>         return fwspec ? fwspec->ops : NULL;
>  }
>
> -static const struct iommu_ops *acpi_iommu_configure_id(struct device *de=
v,
> -                                                      const u32 *id_in)
> +static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>         int err;
>         const struct iommu_ops *ops;
> @@ -1574,7 +1573,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>          */
>         ops =3D acpi_iommu_fwspec_ops(dev);
>         if (ops)
> -               return ops;
> +               return 0;
>
>         err =3D iort_iommu_configure_id(dev, id_in);
>         if (err && err !=3D -EPROBE_DEFER)
> @@ -1589,12 +1588,14 @@ static const struct iommu_ops *acpi_iommu_configu=
re_id(struct device *dev,
>
>         /* Ignore all other errors apart from EPROBE_DEFER */
>         if (err =3D=3D -EPROBE_DEFER) {
> -               return ERR_PTR(err);
> +               return err;
>         } else if (err) {
>                 dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -               return NULL;
> +               return -ENODEV;
>         }
> -       return acpi_iommu_fwspec_ops(dev);
> +       if (!acpi_iommu_fwspec_ops(dev))
> +               return -ENODEV;
> +       return 0;
>  }
>
>  #else /* !CONFIG_IOMMU_API */
> @@ -1623,7 +1624,7 @@ static const struct iommu_ops *acpi_iommu_configure=
_id(struct device *dev,
>  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>                           const u32 *input_id)
>  {
> -       const struct iommu_ops *iommu;
> +       int ret;
>
>         if (attr =3D=3D DEV_DMA_NOT_SUPPORTED) {
>                 set_dma_ops(dev, &dma_dummy_ops);
> @@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enu=
m dev_dma_attr attr,
>
>         acpi_arch_dma_setup(dev);
>
> -       iommu =3D acpi_iommu_configure_id(dev, input_id);
> -       if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER)
> +       ret =3D acpi_iommu_configure_id(dev, input_id);
> +       if (ret =3D=3D -EPROBE_DEFER)
>                 return -EPROBE_DEFER;
>
> +       /*
> +        * Historically this routine doesn't fail driver probing due to e=
rrors
> +        * in acpi_iommu_configure()
> +        */
> +
>         arch_setup_dma_ops(dev, 0, U64_MAX, attr =3D=3D DEV_DMA_COHERENT)=
;
>
>         return 0;
> --
> 2.42.0
>

