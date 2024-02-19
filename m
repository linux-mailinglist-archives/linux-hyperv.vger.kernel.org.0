Return-Path: <linux-hyperv+bounces-1576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100D85A149
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3101C21656
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8542C19B;
	Mon, 19 Feb 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHjMUYLu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D228E39;
	Mon, 19 Feb 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339669; cv=none; b=nEwqS5X96ucPNlUJuotvBr7XvooyfmUQ3fmEHz7t1vh82SzaJlO890bPCTJvNPjutRkUfocvoPTOy6ezIhneMCs3GrTYk10oqz0PnYJwoS3HTIpJww4NlVj+6m+dcL4GGBa7+saxtc/Feo6TXJcl6K8154xefTBfjVwxLW2Oz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339669; c=relaxed/simple;
	bh=J76nWNpLPlCdb2/zC3wLiltJ7TgkL/vEOtz2wj3rw5Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=diHbzu54Dgdec3MIY5A+O0UoTCt71o/nVNiJUKqEGnbUsSFA8yH0+OpWlNVzMfIB2p2yf5d7qz6gZ7QSSj2naBA4uEGaWmg8ru1rUqJkg+E/6Er4oGCIq+banKO3y+AjfaoCUq2vlFn/HquGGV4amW+r2nBcy6jJ7wMrgDGV4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHjMUYLu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708339667; x=1739875667;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J76nWNpLPlCdb2/zC3wLiltJ7TgkL/vEOtz2wj3rw5Q=;
  b=HHjMUYLueXl0HAW/+4iX45N5/PKfwIHniT2imWutWgAm14y9B2qadsJ/
   bM/wWa1YmGuAHDjXnmTnVfZNp/NvDU9nRBEVuUjeLm2jd98gGS89eZ9Xb
   Wm0fq2z6qLnJREXXp2SS+k+YF0DoeSMIo1ru3HLC8lUVQy5N+JiB6HhT4
   gntvENNgxOARBEsgY8ZY1zI5c6mxUagDbDr9C2KsLN5sEOBDF1kYgn3Kb
   uGnCLDeox3OjFLEliFUAsfMN8MlUxCFVOAgoou8dxcwKDSacfdjRrPqdH
   4W0ob3NIY4qpSz2t4KB39zKcup0R1T17LBAp6hde2ZKAD9nUIfJe/h4Bu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2850781"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2850781"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4817735"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:47:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Feb 2024 12:47:33 +0200 (EET)
To: Michael Kelley <mhklinux@outlook.com>
cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
    "wei.liu@kernel.org" <wei.liu@kernel.org>, 
    "decui@microsoft.com" <decui@microsoft.com>, 
    "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
    "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
    "bhelgaas@google.com" <bhelgaas@google.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] PCI: hv: Fix ring buffer size calculation
In-Reply-To: <SN6PR02MB415749788D7DEA3D1D792913D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <0a680c72-0c30-d3e7-5c67-a0aefe752be2@linux.intel.com>
References: <20240215074823.51014-1-mhklinux@outlook.com> <0802ce88-c86d-3a74-501f-28393d6112f3@linux.intel.com> <SN6PR02MB415749788D7DEA3D1D792913D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1499309722-1708339653=:1174"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1499309722-1708339653=:1174
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, Michael Kelley wrote:

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> Sent: Friday, Febru=
ary 16, 2024 6:46 AM
> >=20
> > On Wed, 14 Feb 2024, mhkelley58@gmail.com wrote:
> > >
> > > For a physical PCI device that is passed through to a Hyper-V guest V=
M,
> > > current code specifies the VMBus ring buffer size as 4 pages.  But th=
is
> > > is an inappropriate dependency, since the amount of ring buffer space
> > > needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
> > > size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ri=
ng
> > > size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
> > > is used for only a few messages during device setup and removal, so a=
ny
> > > space above a few Kbytes is wasted.
> > >
> > > Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> > > Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
> > > header is properly accounted for, and so the size is rounded up to a
> > > page boundary, using the page size for which the kernel is built. Whi=
le
> > > w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> > > 64 Kbyte ring buffer, that's the smallest possible with that page siz=
e.
> > > It's still 128 Kbytes better than the current code.
> > >
> > > Cc: <stable@vger.kernel.org> # 5.15.x
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > Reviewed-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > > Changes in v2:
> > > * Use SZ_16K instead of 16 * 1024
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/contro=
ller/pci-
> > hyperv.c
> > > index 1eaffff40b8d..baadc1e5090e 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -465,7 +465,7 @@ struct pci_eject_response {
> > >  =09u32 status;
> > >  } __packed;
> > >
> > > -static int pci_ring_size =3D (4 * PAGE_SIZE);
> > > +static int pci_ring_size =3D VMBUS_RING_SIZE(SZ_16K);
> > >
> > >  /*
> > >   * Driver specific state.
> > >
> >=20
> > Hi,
> >=20
> > You forgot to add #include <linux/sizes.h> for it.
> >=20
> > With that fixed:
> >=20
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
>=20
> Fixed in v3.  I mis-interpreted your previous comment about
> adding the #include "if needed".  It's not needed to compile
> correctly, as sizes.h is indirectly included through some other
> #include.  But it's better to directly #include what's needed
> lest some unrelated change cause a failure.

Yes, we try include the headers we use in the .c file. I used "if needed"=
=20
because I didn't check if it was already among the #includes in the file.

Our tools are lacking to enforce/check a file has correct set of #includes=
=20
so it's currently based mostly on reviewers noticing something is wrong=20
with #includes, hopefully some time in the future, the tools also catch=20
up.


--=20
 i.

--8323328-1499309722-1708339653=:1174--

