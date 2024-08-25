Return-Path: <linux-hyperv+bounces-2859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB695E0C3
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 04:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8965A282394
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Aug 2024 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9B4A2C;
	Sun, 25 Aug 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FQttCHVQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2087.outbound.protection.outlook.com [40.92.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F3163;
	Sun, 25 Aug 2024 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724554633; cv=fail; b=kDS77q3rFC+ZgQ/y1l21UqrQi7GTjZr1QZe1samnsp63hMJy3jexFpAL77SMxL5M6UU6UFRZwhEXh88EPJa9JvfMgH+K/vCRHY5xJZOgFXSUvlbD/DVZjl/aGXkw7UVuJw67IpjgoebUnaPyrAwtiOkTdZB0MM9rYm5BWyr1p0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724554633; c=relaxed/simple;
	bh=3BCFKituJ2eBylbxyuVs4AGmEsIl9Gq9UoP1Pbpc3o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SBKHQKXiC9dM49Nt9socmB8H0KwYUG9ztvcuQBbKlNZmSAsCqUj7OaMSxlRyyK9CRaC4GXO8esKM/D9htLOpuzDkn6L/acKafZOIunuRA2huXKIi/7Gzo8mJHrHmVhqT1dPwTHZbVmfrE1gP52+iIxC4nr19snAFsOXNaAoA4+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FQttCHVQ; arc=fail smtp.client-ip=40.92.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLQ+LBgJtFJOJx1uLnP6YPZI3DCzgCFXzl1Y34+5jvINBpUonThC9rebki0PK/1V8pZEVC+u66AehPUwe5AZzrF/E+tpfJIbPEai5gkz7a8Ut4VV46Bwu7OxvIR39QZqojECisbdF4dyXkOTfHyk05zVkMc97kI8gNIQ3VFilagf9piEhHd5d6g73KvZvRc3SQ90qSBmRH03H00oj9Q3lvQu0eknFL4u6unvWkoz01/PLIvx8KsEPEx7fDfBM/i4WaujtTRNdpDuTAQi6f25ugbKx82nvkZNx2r4ROfoNBSRJQnLu0bHN359oJCBZiEg9b/26xug3l0RHrapkSP8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIzDNNdPQSuaWt+BRbg28Gl8diozw6Ls0hDgG1PuqGw=;
 b=aMpyWXeWMQk79KabYggnjNS5++4qFcSQH0Cdc524wwlgIJIF+2FqV1Ov2PlrpDNVw1DVqr5B3Uf4e2KiUEo0+vjjUw+hw5rhd4/1Fc+c4NaBzTHulBiORjup1wPJFyrG696DJd374iY5niceed0US/BJtzptClxw8GeKzWF57cv7KKEcbRSZ7J6aM3FtXfhwOkUl3jUtGOFbAcCLMk4Z6TWZRuF9Ct6gXAP9auAf1KpW/6Evvq9t4WEO440VHI8rItfQCwI6Shh6a5xCiVZjNO79dTveAEFpzgvtrJNvURwxVyJhAgpq1ob1KSKmbJmUCKVQ3nU1q1ZVa2qDYpk3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIzDNNdPQSuaWt+BRbg28Gl8diozw6Ls0hDgG1PuqGw=;
 b=FQttCHVQi9zo+BzRVPaBw5x8TE8FQ8ki81fTFEWU9L113+CkE/D06NLFFEyz/lfGuhzOyglO10XL496/cxFXugES9QytzoaqLC94EJJqRStxtsYhdbg8Gst5ic69NnTQVER/Bbmfvu9wR2gJChyxxMCz4rcDjFMfj+TUUXH/XvadvuNw3sqK6ionM00uLCS3tNavXRad0BT3HQnvEc1Im5ydoCkr+x62M+NJ/Rfjs6WIaUDPiXzmhdyYPO11Ytod2zUtf8DNpbu89zdwp7PnHZ5+oqiia6yTTpb1YiwZ4CafipC9wQi8OlPmMeAsgvgbc6uaxZo/80UtXNlPEKjOVw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6620.namprd02.prod.outlook.com (2603:10b6:5:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sun, 25 Aug
 2024 02:57:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Sun, 25 Aug 2024
 02:57:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Index: AQHa9IPP2ZEuiKarEkiNA338VE6Og7I3Smgw
Date: Sun, 25 Aug 2024 02:57:08 +0000
Message-ID:
 <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
In-Reply-To: <20240822110912.13735-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [tt93zZYV+YF7v5Kf/cyhyoFIPs2/KYEC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6620:EE_
x-ms-office365-filtering-correlation-id: aae2fd50-01af-4573-27f7-08dcc4b19c32
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|461199028|102099032|56899033|440099028|3412199025;
x-microsoft-antispam-message-info:
 ddQiSlGDxpeZI1DZz3UdF4V5PbBEsNJSlYRNS0T+OBEORTs2But9cgGVh0g382xaftF6xuaCVsrlhZT7yqTMpQoK12Ptmuy3E9cmIuRykn7nLoHatfapoX68h26NkLvwXznym+deoiklt6un7cgAc62PaxFUMiYjLfaTdDMs0OX65UmH9BiKT4wNPxlf7oOBb8c5aqg2879uTYgWwAvwtEGEpZ6IvYVpEBtFFVIN457jhP0uffn+YHJ3R4SSdU+XOBU12Dt5BYXyUAXynHpJkfQVaBlSucB1uL86AGwjlVEV+MtFd7rYWc3Scss2wXf+wu1hh4bA8zUPArAqUmkblfKCBKVvm6wbhQGKXDIteZS7TRlpT4qMC7RCKicGTdl9aLcCVdleLD8tpL4YPfegPWL62SFkF+/mdN7C9jDgr7T0w13IO6hwWoU/bBinXfpIsbwB16HUi8BWC2pMX9+3120qcmYgeyQDZ34coAqJr+w4n48cMzrbPJ+afJpRo9RnCGQPYHmOsjemqzskA4ii9gY4tS0vcEzekE8dYVckqW4rMpmw+SBQnT1q16zzfaSjoH6AbH8HF+wyOsuAR8UsQvUBgiz0Rgf53xeOlduJSOyMTIDoSjci/cUVEoGnUJTvviVJDsXjXvWMbHfBhCgYr0jJ5PnvWn1QLnBd0sWgrmbdQV9pe/AH2a3rxeVTy5Gq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xm/GAaCiDrZrjL7lAQaQ1Ga0RRJz/TtwcyLe3bvDJ+xCvnDTMVkxrfWCk568?=
 =?us-ascii?Q?59Rctz/HX6MZhW11d2KyNUOBSVt+NdFvTQaDl4oo2F/OPEo3e/0I/Z2ppToC?=
 =?us-ascii?Q?OiQohmL7Sto7S6hFUZxh4gCzlqIPiGXGDpfIWxOJS0x0wqsP4N/kB3x2iMdE?=
 =?us-ascii?Q?snQjusErt+t7LhEPb4GoL3nRL4qdhrca7dZLfwzzMjI/+jB7VCj8U2xHQSvX?=
 =?us-ascii?Q?YubPMabuD6mWNjLLSf+jszrlbuIZBpHSNe1gig883vp3gWvcmQjJht9DmPkh?=
 =?us-ascii?Q?gnaJFwxv1I68vuVKNiqZE2nipzK8lFjur2ylCtSc2/i2VCn0PoroD1RvABeZ?=
 =?us-ascii?Q?6GSsF4V7bZb8Q3M4P0bowvCzmudz0lvJx5rwOZ+5FRJMRq00EUWP1zmOlTga?=
 =?us-ascii?Q?3vXgIBDrEGn4kU4SsbHnKoDMP0aRsUoPP4erWfn9Uzto44aBaR8UnOZxBioF?=
 =?us-ascii?Q?W3U02PTfSCDpAM5w01c+UfOmd0tiCzT1ArmnTyC1k0oeQVzLD6eUDcyPwdA+?=
 =?us-ascii?Q?Abe/ZzNM1V7BZdfZkWzHi7mqW5cey2AnJw9m3TfnBsH+53MTsO5aea3DNI1d?=
 =?us-ascii?Q?POXlPKuf04LvB37KQXM93t/Z0SC0pKX60q5B8uE34qsSnhxb9VRHXZVU74hp?=
 =?us-ascii?Q?/hks8P66jPzPgoFRuIpyAbC/tdCbJhgwDKuihpcprS35bkDv3F0ZxepvP6Kf?=
 =?us-ascii?Q?yTdmSNbHp4QWt4Fag2r/MwGRwmj5HdYN7GHz+O35b02V6ycRO6qzIhWoCl/+?=
 =?us-ascii?Q?05if/+h4FJttDN/+moR1HMDzTGRRiaVAOrspANkWPcBgIqzRO91fuUpIxe36?=
 =?us-ascii?Q?9uu3p+alkNDrjSxRDlIvVo/aMJqBtGwdYvGiMX+GEUHNlAAHi1F83tyXjw6b?=
 =?us-ascii?Q?p0/3Es4H/CYmJ6ctd9R3yKIh7pur6SZVbFflh8qsY+tZcqNJyNu0J1RmCtWP?=
 =?us-ascii?Q?iYC1jVfRCx5ES25L2PPKK1hhsE7XMsXEBrQOd5bYL+LczKvLgg4emCIF96en?=
 =?us-ascii?Q?HLdxs8OZMGXUjNpgSmZGBggO0U/AGXk1XA49eOuk3zYbS6b42IREShu5dXXk?=
 =?us-ascii?Q?PQHehb/uuKpTOofxRUBvmelkVz1GLbo+GnK1ZWCsuyj28cPlxFy/dT5Znd61?=
 =?us-ascii?Q?T2DOy03uiQ8xN+DWnaldsaXiHth4zVQwuOye7h3I0aPZdCKTrbFinNqMKQQu?=
 =?us-ascii?Q?y2KZm6FN4sTbYwV1aNx4sCA/xubhPK5FipmaL8C/KxVVYiWJycsXZHufceI?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aae2fd50-01af-4573-27f7-08dcc4b19c32
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 02:57:08.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6620

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 22, 2=
024 4:09 AM
>=20
> Rescind offer handling relies on rescind callbacks for some of the
> resources cleanup, if they are registered. It does not unregister
> vmbus device for the primary channel closure, when callback is
> registered.
> Add logic to unregister vmbus for the primary channel in rescind callback
> to ensure channel removal and relid release, and to ensure rescind flag
> is false when driver probe happens again.
>=20
> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c       | 1 +
>  drivers/uio/uio_hv_generic.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c857dc3975be..4bae382a3eb4 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1952,6 +1952,7 @@ void vmbus_device_unregister(struct hv_device
> *device_obj)
>  	 */
>  	device_unregister(&device_obj->device);
>  }
> +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
>=20
>  #ifdef CONFIG_ACPI
>  /*
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index c99890c16d29..ea26c0b460d6 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -121,6 +121,13 @@ static void hv_uio_rescind(struct vmbus_channel *cha=
nnel)
>=20
>  	/* Wake up reader */
>  	uio_event_notify(&pdata->info);
> +
> +	/*
> +	 * With rescind callback registered, rescind path will not unregister t=
he device
> +	 * when the primary channel is rescinded. Without it, next onoffer msg =
does not come.
> +	 */
> +	if (!channel->primary_channel)
> +		vmbus_device_unregister(channel->device_obj);

When the rescind callback is *not* set, vmbus_onoffer_rescind() makes the
call to vmbus_device_unregister(). But it does so bracketed with get_device=
()/
put_device(). Your code here does not do the bracketing. Is there a reason =
for
the difference? Frankly, I'm not sure why vmbus_onoffer_rescind() does the
bracketing, and I can't definitively say if it is really needed. So I guess=
 I'm
just asking if you know. :-)

Michael

>  }
>=20
>  /* ysfs API to allow mmap of the ring buffers
> --
> 2.34.1
>=20


