Return-Path: <linux-hyperv+bounces-1140-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D17FDCEC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB892828DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879B3AC20;
	Wed, 29 Nov 2023 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4cmTLl6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D0D6E;
	Wed, 29 Nov 2023 08:23:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9b5e50c1fso25831781fa.0;
        Wed, 29 Nov 2023 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701274997; x=1701879797; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE4DN2NIJid+M8TUF/vMVc9hXeYzBXdHSi7xojD4wk4=;
        b=O4cmTLl6QBc6pJNGiHjiiSuJ4biDjlMAMFUhGxxNCtex+BDHhQG1eUHWXl3DOfZbLi
         Y8PzIeyy9VonlB6G6qR1GZ/RscEKyWoWPHbvrNRNF1ldR4QKOKaf43nVBhv8fJ6Rzu8z
         JJWRW6D4ROLQQyXhGzavjFwxEU7cOFjFnGu0sTG6BbJ4YP0aFo7AH8WF2nCFqFeS7of6
         /hpbklK5QJbEfpj8W7r/7NN2fito64byko1KpPBC0UYcqo+y6JdpXQa5Z/zKoaFEgXpw
         2I2I+YnAYF1nM07IgxY0nM5lPA6VUsAQyTZVHnG17OyYuLQHCub3oVKOVQeDVytQ6M+u
         dUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274997; x=1701879797;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE4DN2NIJid+M8TUF/vMVc9hXeYzBXdHSi7xojD4wk4=;
        b=qxtVNo8AJxsZOiREvpQAVr8VQISaK/lTfRTrH4Hn3zUC/pk71SsMH72RptecNiGNh3
         0USDm7B3Lnpn6Yx1CasBhasVOfmZLXhVbeYrUU2mphtCrNiAQRF1XNuxrbDMwoMJ6JE6
         KM2nlKFzCSrlpysz7PrJy9UmIPTdYUtBhQYt1yMLLaXu9ROEJ64D6214rQJbygMCItB3
         h8+TvsAEjyocupguonxWLI2X1GZfv2PEcZq3h1ghZQTxcXjLhduAvLEpcM1yxU47ipAe
         6X5Lqh08riu/ts+HhMLxlh/NkE2/ahz5kbWV/Ahy2T3c3ByQz0Gnr/zpKdJsorju24jr
         mOdw==
X-Gm-Message-State: AOJu0YyW5huD//ZIKJD71/qQi0XL1D4yJMeBbXWuELg68uQwTOJX5xWX
	AAPcqcFJMvGXOOXx8T0ID6o=
X-Google-Smtp-Source: AGHT+IFpkXFRA9JtjkMulyQU+vE6lllIuj8DaTvHOgPc7kkDjVJCH1EZdgBzk/x+Nxw/nDpm1ZgC3Q==
X-Received: by 2002:a2e:9557:0:b0:2c9:b623:ddf1 with SMTP id t23-20020a2e9557000000b002c9b623ddf1mr3708530ljh.51.1701274997225;
        Wed, 29 Nov 2023 08:23:17 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b00407b93d8085sm2743768wmr.27.2023.11.29.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:23:16 -0800 (PST)
Date: Wed, 29 Nov 2023 17:23:13 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Airlie <airlied@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Karol Herbst <kherbst@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	nouveau@lists.freedesktop.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Hector Martin <marcan@marcan.st>, Moritz Fischer <mdf@kernel.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/10] iommu/tegra: Use tegra_dev_iommu_get_stream_id()
 in the remaining places
Message-ID: <ZWdlcboM4Xzs38NI@orome.fritz.box>
References: <0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
 <8-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OR6CuieIvqboqm08"
Content-Disposition: inline
In-Reply-To: <8-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--OR6CuieIvqboqm08
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 08:48:04PM -0400, Jason Gunthorpe wrote:
> This API was defined to formalize the access to internal iommu details on
> some Tegra SOCs, but a few callers got missed. Add them.
>=20
> The helper already masks by 0xFFFF so remove this code from the callers.
>=20
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c                  |  8 +++-----
>  drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c |  7 ++-----
>  drivers/memory/tegra/tegra186.c                 | 12 ++++++------
>  3 files changed, 11 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dm=
a.c
> index fa4d4142a68a21..88547a23825b18 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1348,8 +1348,8 @@ static int tegra_dma_program_sid(struct tegra_dma_c=
hannel *tdc, int stream_id)
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_dma_chip_data *cdata =3D NULL;
> -	struct iommu_fwspec *iommu_spec;
> -	unsigned int stream_id, i;
> +	unsigned int i;
> +	u32 stream_id;
>  	struct tegra_dma *tdma;
>  	int ret;
> =20
> @@ -1378,12 +1378,10 @@ static int tegra_dma_probe(struct platform_device=
 *pdev)
> =20
>  	tdma->dma_dev.dev =3D &pdev->dev;
> =20
> -	iommu_spec =3D dev_iommu_fwspec_get(&pdev->dev);
> -	if (!iommu_spec) {
> +	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>  		dev_err(&pdev->dev, "Missing iommu stream-id\n");
>  		return -EINVAL;
>  	}
> -	stream_id =3D iommu_spec->ids[0] & 0xffff;
> =20
>  	ret =3D device_property_read_u32(&pdev->dev, "dma-channel-mask",
>  				       &tdma->chan_mask);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/ltc/gp10b.c
> index e7e8fdf3adab7a..b40fd1dbb21617 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c
> @@ -28,16 +28,13 @@ static void
>  gp10b_ltc_init(struct nvkm_ltc *ltc)
>  {
>  	struct nvkm_device *device =3D ltc->subdev.device;
> -	struct iommu_fwspec *spec;
> +	u32 sid;
> =20
>  	nvkm_wr32(device, 0x17e27c, ltc->ltc_nr);
>  	nvkm_wr32(device, 0x17e000, ltc->ltc_nr);
>  	nvkm_wr32(device, 0x100800, ltc->ltc_nr);
> =20
> -	spec =3D dev_iommu_fwspec_get(device->dev);
> -	if (spec) {
> -		u32 sid =3D spec->ids[0] & 0xffff;
> -
> +	if (tegra_dev_iommu_get_stream_id(device->dev, &sid)) {
>  		/* stream ID */
>  		nvkm_wr32(device, 0x160000, sid << 2);

We could probably also remove the comment now since the function and
variable names make it obvious what's being written here.

>  	}
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra=
186.c
> index 533f85a4b2bdb7..3e4fbe94dd666e 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -111,21 +111,21 @@ static void tegra186_mc_client_sid_override(struct =
tegra_mc *mc,
>  static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *=
dev)
>  {
>  #if IS_ENABLED(CONFIG_IOMMU_API)
> -	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>  	struct of_phandle_args args;
>  	unsigned int i, index =3D 0;
> +	u32 sid;
> =20
> +	WARN_ON(!tegra_dev_iommu_get_stream_id(dev, &sid));

I know the code previously didn't check for any errors, but we may want
to do so now. If tegra_dev_iommu_get_stream_id() ever fails we may end
up writing some undefined value into the override register.

I'm also unsure if WARN_ON() is appropriate here. I vaguely recall that
->probe_device() was called for all devices on the bus and not all of
them may have been associated with the IOMMU. Not all of them may in
fact access memory in the first place.

Perhaps I'm misremembering and the IOMMU core now takes care of only
calling this when fwspec is indeed valid?

Thierry

--OR6CuieIvqboqm08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVnZW8ACgkQ3SOs138+
s6H3xA/+PnJPzNAATgGeEaxpY8VPfo7h0kY98vc1QYnUCiV46yzQPUq+/nVkkq24
ybBtQ8hr0vl4ZxtflekHYxb0WsXO560ODmmckXEYPWRfVyxckFz+CRyvDx+zxyxJ
d/TtD8p0l6DGFlZGume2h/cDafF5+3td2JEJ2vEfu0tMmRLIFC7L+Pj2IB4/Fz21
2M6M6T0Al7obecinfW9jzg00G20RybQSrdPq+H9z3BNhOXGKy+1fjIzCsnr4H0gD
kE4WooU9uLbMdpEYYZ8idqC1OieIr6p2IF802/4/TAvWHreHlH7uPcDRry8rxkwQ
j0CAwBlcvLLtLj2pw7kYgxMpXwahgXSuhxX42CXDWsUUW4mxiZkvG0o8Cv2EGtSD
emTIMrC3w1R2MSemI8+RQdOHhOnTNC0sADGo9EyurPrYC9TzwqTOPI35kNqJ8ZAw
zCmhDKieZM9dxlOdFrpC+eLz8eVEjo5oV+OchMT6k8nw7TkD6dGHBOJlDhQeJNWZ
tZBnlBamoEmlD5Kz/Oe90S47MnYtx8EX7o9bpEV6/ZO13P+F07rasP3l6hCJuybO
c2YAeCxY8cuwHLnIJZTm3hR7UU9PQwPn4utolLuSqaXkL5wSdVr+1eZyTye25W0J
CSzMCL3SkMgfKaZ7L6ptSRFtOWxiH6943ahvYpDBXlgEp/R9aVg=
=ORi/
-----END PGP SIGNATURE-----

--OR6CuieIvqboqm08--

