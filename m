Return-Path: <linux-hyperv+bounces-3250-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EB9BB5FB
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 14:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E121F2279B
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Nov 2024 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A83224FA;
	Mon,  4 Nov 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6M9zpgg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D0111A8;
	Mon,  4 Nov 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726738; cv=none; b=oyJTY1LRLkUKznARzWSc/xodL+lgQd3ogPyvJy4boX52eli9svNlbgZuG4Qim8A7b7wpKPZPEP8nHmyYcM519tqWeS+V+9gKTC7EolY3WulvkqkiuI9Z8hadKimzqig5IJyYl45igL2t0o/Q9ellCAyvr49JfMpPCu8MwLA8Nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726738; c=relaxed/simple;
	bh=oPBklUbvKL8bSKRIlaEBq6Ena9N6JHRIUOBA6mqrZ6c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ms9sUT3HFzOAlu6wH76v4GIo5JPQx0XTjONKbQ47BlriN2pLIMwJAo5252ZIX2Ppql95twB+dvHHo0JbJtqCgjcyX2H3UlIYI1BKJrU7RHPRHEftWLATKG1jY16RiPjfo+n8+4AEr7sGFKHHVOmY3+hnC+TMt2bINuK6GPmhicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6M9zpgg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726736; x=1762262736;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oPBklUbvKL8bSKRIlaEBq6Ena9N6JHRIUOBA6mqrZ6c=;
  b=V6M9zpgg7MJtwljFRnQo2x+DXoviRvspP0NVDmRyAtFeIj1U6uUBzGB6
   q7dNJz0Mm05awQeWH8RA0JBJ3xtkyAbcFrqW9EEV304wTBZGFMtiITI3O
   jwn4ciqJCJu3V5LPn0sWATTqONxaNJs3BWl/sJ6S/8fUL5bIcvGYGqivl
   /uATz2ZiJN8IG4KzLVgHrDm3hJHXWeT+ZFOZK2sISMZ49yW53xM/tz2jb
   UG2dFYBlKmezQ9IrfIzt6ks+mBSCGwhXg+5rLE8axKJ6g70k/yaZpkdB3
   JgUxVFXUX+CYe0er6i/JI7A100P/ObQ3VrnZh2f0Ov104dcp7n3gAI7Qv
   Q==;
X-CSE-ConnectionGUID: r5aOVlEITJe0ReUEquHbsQ==
X-CSE-MsgGUID: DbG8CzipQOGfdLFcg6HSdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30275394"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30275394"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:32 -0800
X-CSE-ConnectionGUID: v9JmlMoUQFaNhWF7H45gGQ==
X-CSE-MsgGUID: 4K1oV5FuTuelLKT3nBONXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83542204"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Nov 2024 15:25:13 +0200 (EET)
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
    Davidlohr Bueso <dave@stgolabs.net>, 
    Jonathan Cameron <jonathan.cameron@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, 
    Alison Schofield <alison.schofield@intel.com>, 
    Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, 
    Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, 
    Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
    Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
    Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    "David E. Box" <david.e.box@linux.intel.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>, 
    Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
    Logan Gunthorpe <logang@deltatee.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Dan Williams <dan.j.williams@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
    linux-cxl@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
    linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 05/10] sysfs: treewide: constify attribute callback
 of bin_is_visible()
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
Message-ID: <65f4dc4e-3b48-2baa-a13b-3cc34dd51ce1@linux.intel.com>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net> <20241103-sysfs-const-bin_attr-v2-5-71110628844c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-559502379-1730726713=:989"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-559502379-1730726713=:989
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 3 Nov 2024, Thomas Wei=C3=9Fschuh wrote:

> The is_bin_visible() callbacks should not modify the struct
> bin_attribute passed as argument.
> Enforce this by marking the argument as const.
>=20
> As there are not many callback implementers perform this change
> throughout the tree at once.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/cxl/port.c                      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
>  drivers/infiniband/hw/qib/qib_sysfs.c   |  2 +-
>  drivers/mtd/spi-nor/sysfs.c             |  2 +-
>  drivers/nvmem/core.c                    |  3 ++-
>  drivers/pci/pci-sysfs.c                 |  2 +-
>  drivers/pci/vpd.c                       |  2 +-
>  drivers/platform/x86/amd/hsmp.c         |  2 +-
>  drivers/platform/x86/intel/sdsi.c       |  2 +-
>  drivers/scsi/scsi_sysfs.c               |  2 +-
>  drivers/usb/core/sysfs.c                |  2 +-
>  include/linux/sysfs.h                   | 30 +++++++++++++++------------=
---
>  12 files changed, 27 insertions(+), 26 deletions(-)

> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/h=
smp.c
> index 8fcf38eed7f00ee01aade6e3e55e20402458d5aa..8f00850c139fa8d419bc1c140=
c1832bf84b2c3bd 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -620,7 +620,7 @@ static int hsmp_get_tbl_dram_base(u16 sock_ind)
>  }
> =20
>  static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
> -=09=09=09=09=09 struct bin_attribute *battr, int id)
> +=09=09=09=09=09 const struct bin_attribute *battr, int id)

Hi Thomas,

This driver is reworked in pdx86/for-next.

--=20
 i.


>  {
>  =09if (plat_dev.proto_ver =3D=3D HSMP_PROTO_VER6)
>  =09=09return battr->attr.mode;
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/int=
el/sdsi.c
> index 9d137621f0e6e7a23be0e0bbc6175c51c403169f..33f33b1070fdc949c1373251c=
3bca4234d9da119 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -541,7 +541,7 @@ static struct bin_attribute *sdsi_bin_attrs[] =3D {
>  };
> =20
>  static umode_t
> -sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, =
int n)
> +sdsi_battr_is_visible(struct kobject *kobj, const struct bin_attribute *=
attr, int n)
>  {
>  =09struct device *dev =3D kobj_to_dev(kobj);
>  =09struct sdsi_priv *priv =3D dev_get_drvdata(dev);

--8323328-559502379-1730726713=:989--

