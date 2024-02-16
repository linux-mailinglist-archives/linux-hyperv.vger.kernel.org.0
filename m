Return-Path: <linux-hyperv+bounces-1548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB02857FA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC71C21635
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBA12EBEE;
	Fri, 16 Feb 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V69mhdu7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394512EBE9;
	Fri, 16 Feb 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094779; cv=none; b=IZ1xTF5qDnXzU1z/pBdX5Q8Aa+EAa4zXNM2954WHNKXdbkdtp0Z8F7dt44g21vLrr8wOk6xRnArOK4bZonA5NOnzxYtxd3ERXpPPwjIUgd4T+5DISi1cCE6twylg8yN15iYActEC3/3ec6XThmX7Uj8hYUo+sGx6vTYc6FzdYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094779; c=relaxed/simple;
	bh=qpObp0ul6hu3c011R08+9bpizKiA9lCo1BIBPS8Ynjw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S+NTFK47O+jOdd+ABXpY2SHIblz0qIPP6694tC02xpkQ+kBr+qc0XGl2L+VpnXkjycM1hr3utHS7r5p++4oLPphU6lJ1/6+dfZtY6Y/UFpcMi/Cunl366K09L+aJWb+mC/Kvh79J4seAR8U1z6VZvtCyH/hMKjkLDK/GEtFeFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V69mhdu7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708094777; x=1739630777;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qpObp0ul6hu3c011R08+9bpizKiA9lCo1BIBPS8Ynjw=;
  b=V69mhdu7ZVV/jBMI/6E1q9glAC3tKlUwqj0kjKiVHMsdXkZp4GTGckTN
   bhzH+evHc0tpppXSEgCrYXNxTQtjmNkZEg4qtle0QNcmFNJoatFcbiE7j
   JTpozt3U34kDhnZQMID/bm68EyAbayA65kQCTYzs5hjxWjUDHGk+XyZLN
   DQOEBAsozPDzHuHve+zHQSuoq2Of/IYzpX/ioXf7Do1l93PWOuwlI6PjH
   HbzYwwseU2lYx8eRi+zxPl4bg09/OjgYSIxfSsT4ocZlQSYDdhWFqa1Fh
   KCiRR93NdEyjM0EgjvNY5FA32olH2pnu2z/3zjFyv3OgAMbwx/h8S3Qg5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12767873"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="12767873"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="41341349"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:46:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 16:46:07 +0200 (EET)
To: mhklinux@outlook.com
cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
    lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: hv: Fix ring buffer size calculation
In-Reply-To: <20240215074823.51014-1-mhklinux@outlook.com>
Message-ID: <0802ce88-c86d-3a74-501f-28393d6112f3@linux.intel.com>
References: <20240215074823.51014-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-277225830-1708094767=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-277225830-1708094767=:1097
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 Feb 2024, mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> For a physical PCI device that is passed through to a Hyper-V guest VM,
> current code specifies the VMBus ring buffer size as 4 pages.  But this
> is an inappropriate dependency, since the amount of ring buffer space
> needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
> size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
> size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
> is used for only a few messages during device setup and removal, so any
> space above a few Kbytes is wasted.
>=20
> Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
> header is properly accounted for, and so the size is rounded up to a
> page boundary, using the page size for which the kernel is built. While
> w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> 64 Kbyte ring buffer, that's the smallest possible with that page size.
> It's still 128 Kbytes better than the current code.
>=20
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
> Changes in v2:
> * Use SZ_16K instead of 16 * 1024
> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 1eaffff40b8d..baadc1e5090e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -465,7 +465,7 @@ struct pci_eject_response {
>  =09u32 status;
>  } __packed;
> =20
> -static int pci_ring_size =3D (4 * PAGE_SIZE);
> +static int pci_ring_size =3D VMBUS_RING_SIZE(SZ_16K);
> =20
>  /*
>   * Driver specific state.
>=20

Hi,

You forgot to add #include <linux/sizes.h> for it.

With that fixed:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-277225830-1708094767=:1097--

