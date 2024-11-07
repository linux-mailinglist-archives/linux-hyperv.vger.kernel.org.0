Return-Path: <linux-hyperv+bounces-3284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB89C0CC0
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F51C2472D
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C552170D4;
	Thu,  7 Nov 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uirXLcMy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A2216A3D;
	Thu,  7 Nov 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000046; cv=none; b=KL9YtFCH28bzxEf2osqHXgYgeJnEz0G7dL/+51SWnjahq9Sah9GLbHDLRPsB0AuMcGS3dOJL2Zjp5KlHTPSBjicy/PG3+4VTcvpqETK+Pp8Ep+vxIQq8juLvCTjPG2Ycdpctzo+EpJyJUC0kstoFKTraBcyXMLC6v8CJkGsng1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000046; c=relaxed/simple;
	bh=cADn4ARQkTOhflqlIHhNxtca9L54H5LHvOrTgQwQP8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UT2Tkse7N2/fMJXyzMZIfnDM/7LJFyO7c7WniqZH1xaXzCEvDeIWJWld3fJitl5CFCJdLF70brs2TYA+H3VB8UNRSe8IRlXXUIXhdEBdE53bXbGCBvNpZRTHsyK7h91XXAxh6+mWNmWBGDe5B124QKO9/FcA0BIzjkj0SktJdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uirXLcMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DA9C4CECC;
	Thu,  7 Nov 2024 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731000045;
	bh=cADn4ARQkTOhflqlIHhNxtca9L54H5LHvOrTgQwQP8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uirXLcMy1Qn//p7lSBnbOlzSbCL5aIT0TqEnGpIZm6Rx23BQJKj1JIwJAP4R6CQ3Y
	 BGW5ysKmLw5HxKe9TW2Kb0/MrhrtH+FEMuRdl+3jaHMQQkHCavjZQ9xWr31Ghy5ARf
	 J2TiGOLT8c6IMr+E/gnELx0660oj7VCoNS9utcB0Gb41g2oymp/+1G/7KVgOzIPwxq
	 q5/0lzC969ZrJFg9aKvlY1ckSKQVQp4pt0o8irIOJAq56q9MDR85uEDv3iCGEqltvk
	 QeOfANjQFk8pt3o4hyDqn3DINTzEn9s+ZnpBLM2/xaYcEN2lpP63yM+3MX3zh3CiMr
	 Amp7lQpjSOJ2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Jonathan Cameron <jonathan.cameron@huawei.com>,
  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
  Xinhui Pan <Xinhui.Pan@amd.com>,  David Airlie <airlied@gmail.com>,
  Simona Vetter <simona@ffwll.ch>,  Dennis Dalessandro
 <dennis.dalessandro@cornelisnetworks.com>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Naveen Krishna Chatradhi
 <naveenkrishna.chatradhi@amd.com>,  Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>,  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,  "David E.
 Box"
 <david.e.box@linux.intel.com>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Matt Turner <mattst88@gmail.com>,
  Frederic Barrat <fbarrat@linux.ibm.com>,  Andrew Donnellan
 <ajd@linux.ibm.com>,  Arnd Bergmann <arnd@arndb.de>,  Logan Gunthorpe
 <logang@deltatee.com>,  "K. Y. Srinivasan" <kys@microsoft.com>,  Haiyang
 Zhang <haiyangz@microsoft.com>,  Wei Liu <wei.liu@kernel.org>,  Dexuan Cui
 <decui@microsoft.com>,  Dan Williams <dan.j.williams@intel.com>,
  linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
  linux-cxl@vger.kernel.org,  amd-gfx@lists.freedesktop.org,
  dri-devel@lists.freedesktop.org,  linux-rdma@vger.kernel.org,
  linux-mtd@lists.infradead.org,  platform-driver-x86@vger.kernel.org,
  linux-scsi@vger.kernel.org,  linux-usb@vger.kernel.org,
  linux-alpha@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 05/10] sysfs: treewide: constify attribute callback
 of bin_is_visible()
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
	("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Sun, 03 Nov 2024
 17:03:34 +0000")
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
	<20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
Date: Thu, 07 Nov 2024 17:20:37 +0000
Message-ID: <mafs08qtv7yfu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03 2024, Thomas Wei=C3=9Fschuh wrote:

> The is_bin_visible() callbacks should not modify the struct
> bin_attribute passed as argument.
> Enforce this by marking the argument as const.
>
> As there are not many callback implementers perform this change
> throughout the tree at once.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> index 96064e4babf01f6950c81586764386e7671cbf97..5e9eb268073d18e0a46089000=
f18a3200b4bf13d 100644
> --- a/drivers/mtd/spi-nor/sysfs.c
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -87,7 +87,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject =
*kobj,
>  }
>=20=20
>  static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
> -					    struct bin_attribute *attr, int n)
> +					    const struct bin_attribute *attr, int n)

Acked-by: Pratyush Yadav <pratyush@kernel.org> # for spi-nor

>  {
>  	struct spi_device *spi =3D to_spi_device(kobj_to_dev(kobj));
>  	struct spi_mem *spimem =3D spi_get_drvdata(spi);

--=20
Regards,
Pratyush Yadav

