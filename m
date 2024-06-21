Return-Path: <linux-hyperv+bounces-2468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA89118F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB601F23B92
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259A64F;
	Fri, 21 Jun 2024 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lw8pn/87"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2040.outbound.protection.outlook.com [40.92.40.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F643687;
	Fri, 21 Jun 2024 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939725; cv=fail; b=fG3hRFtJEkjM8IQ1iL0DvsQPy55AynNHVbTftbnYXNh+PUZypkajIX/TcAYdUpuJSMD8AGhCuq96cHkNhF84Q61NXBAT9i+f4J7jTccheLwGdWe59joXcEB4t7EmsV6WAjRNke7vtpaTnXuiA4/2iEf5ROSbIBnboh/WyCXk3Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939725; c=relaxed/simple;
	bh=T+Svs2Pr8phNpd0qXh24s7IitOyPe+U/ESXBwoqDjjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmaAsE+6VsNl9Uy59MkHb6wtoDEG/vpRL+mXroq3vTsc3XfnMmhdFbIoSvRIhFIjj9V9mEcoGAMkzmcJXau4jhhvpWSYSK3xst7rDBpP4M5XkaHfxN6HRKRxEiD3d4Vi65F/kfC+HatHOoAY/bSFnoUUyufFsiu/G7pzR+/3fzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lw8pn/87; arc=fail smtp.client-ip=40.92.40.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXjxmcQhJfzTfljVk+Swa3788qiDYa9LVVHNG0/pM1TdbjS3T3Um3aEJC/V9njaKqLsDJ0NdAzXWX23l5tYiKb62NlVZyNKVeLYaaIzeWafHzrBkT7ryrkSBFRBrfrDWx8gEeTFA/TkdO0NIiLgM567gB5GQqNxuQs5ssXjprWK9y3AtXzF2NiYZyJARokGQsfxdjDaoX7wmW3wFr7PaYNFToL6p0AYNHeYJt9rtrNg/ByHnm4rjacGnthQk5Bylq7PboVaczjLQZxbazX9HvWTi1gU+KtSPTe4iBC1I7HQ4KP1gX0fF8BIBnobEu0cgsCNMDczquDxsXE9/hEroCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ikv+3V2XA8P7rcQFCwjt9DRYQY+gSwIQyaa7SfbXlE=;
 b=eKaNDOEunsNrYdsFzV97If0OcahASg3mq1PwzV90Fcg7/ct3mkHeBs780252KX91+nYmyaHa7PnIBTbFNoQYJ+lwIT2V+P5ghg69kt2GRkdtWCs/Zq1hgp6TzII+til9UoXpRnTcoBhYYssIjz+E7Ip2qhCPM9EKM3Xy+4UC0js8oFG8IG+m9oT8s71I70KC8jITSTmjpntpFz4jhKeroXimnYS84f14wsGoLVKhyUD2br8SaAYAz6nzM5vRuBjj44U/WhqcdSf3iiysIjTs/Pz8zZM+c+S+WjhaJwfHw9F3BnHbimC2D4PBJYKiZ4VPiiRftm37gIVEpajrR/tWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ikv+3V2XA8P7rcQFCwjt9DRYQY+gSwIQyaa7SfbXlE=;
 b=Lw8pn/871pte5+8ZZUZ6fiN8aEL84bVzsAF8v2rs/ufMV+Ce7Sn+9VsVeTeHM/SENeIj3VWs0T4ToXMzKRtLLAym/VokmGskw8hD3v5t5tU9ct8HoESZ6dewznjotzEbGjzctKKXQ18/pJ5MOePHCYGMEu31lDkJrM3W8ObCyPnDcIeeW50Uwsic1xHip3JIfEUJUQlF6LBpCWra3SKKFKNbh3jlNbN6cJxMNLUhEfbw5LAnNSCZHS9eZgeCbCCf8T8q95rtp+BaAPc666cMb4107XpZ9cW2y7woZrdabWybkl7EJWrxomM0BefhSCl5sE9qRTurN2HzEVolcdoPnA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB8970.namprd02.prod.outlook.com (2603:10b6:208:3ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 03:15:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 03:15:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
	<linux-hyperv@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT
 DRIVERS" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Thread-Topic: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Thread-Index: AQHaw30k6EbhYkH9eEC2TYxCEnOaS7HRiU/A
Date: Fri, 21 Jun 2024 03:15:19 +0000
Message-ID:
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240621014815.263590-1-wei.liu@kernel.org>
In-Reply-To: <20240621014815.263590-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [d/jofPCzOzGIXC7myc0KhYgVAJx8B5EF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB8970:EE_
x-ms-office365-filtering-correlation-id: 19640bc0-226a-4232-bc4c-08dc91a061a9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|440099025|102099029;
x-microsoft-antispam-message-info:
 WGcWRXxAyYBuEtqayRhPZFNHKSyN214hrVM7r2GqgY4I980UiiQrLZnFDijG6o9GNxlW7YvW4kb794w15/pcGXb84prLhXVa2gZCq9Or1OI4IzPujv7rt6FKO91UicAOoY/hEFxWHLiYRAbyYACqjpqXbtTGJ47mZX34mUZHYSOjLj+BV898+DfoPgEpeEetRLruGXycUMwEOONJFX20SZpdWWOfwfpbVQKAXNGJ+8IYijBDXpiddsC8sLyRCKQckkZUavV53P4PE4QRHis3NspV5rwF7UGPWuGRcFpAr3BkolWYsN1Ta4z4tvvogAlNDU6ce5PWd+FVkagVTQSGKvgSBzAM8GddFjHIqqqBwoNsBS/QYOYw8kCubV+l/ns0V+KdEDmT2rm+iw144KjFihFQqJk6bOiXtyUIEkLMr6Q1Hli42KR/E2ky/PLNqSQ2OkxSOJN0WWp7S/VPnP6lCGcl3yJ4xAFInK9KeLhtCn0jsixN2WhnEDrLor+SgH9kM/eT13kA9plwoGGZmfvhLgffshmSKYt3/7Ihu1RpZDJA8f5iAkNA8ACCvwc6WYDJ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wRV9nbgVXq7b8+P/hktWlQGMb0+uUeI6b48tCt0BfGxBuJztGeArBNXHlh?=
 =?iso-8859-2?Q?kDs4yaehUFU4yk1I7Ivke63ovjwV9NUt9Bt0EhdXdbC5qzIKHrZKIbEcHR?=
 =?iso-8859-2?Q?4BvP3SxlkP8E9DrvJ4y+o4wVX1EG2e6X1TUBKWVG9QHYOc70wNDvJSs6oM?=
 =?iso-8859-2?Q?9DTY+HyzSzetEaGBcA7x7Ya1cL9eqWM1DGCNIWY8kozMGS97KbaSBYnehr?=
 =?iso-8859-2?Q?mk+xNIlVIeUadnvqwtDp6r1UJqFV6gAaUPyzc3LAyfu9xJkDEX1vHT10iT?=
 =?iso-8859-2?Q?9ZchSlPPEyHNTmHYx6EaitDc10RRigY8AXK8an6r8N8ZzihRbPxkT+p3/J?=
 =?iso-8859-2?Q?LbNiMaKxnTt5gsnFDw+5OznSPkq6JJKt0HU2QwV5nLtsGIIjPkXZeFA+fV?=
 =?iso-8859-2?Q?99KZ51b2bpTuhXSWSst5XDtoFOBaWpc0WDESZWAuVu6xMjiOqFZIk9WEBg?=
 =?iso-8859-2?Q?Bhm0ZGbdDmey4S20zLLC42aImq6lB2//58YBvQsb11vrNlHBMNSu098LaR?=
 =?iso-8859-2?Q?S+zMN4fRaJw8/Q5Csr3lMRjbk9UifM6Q58JVnptNu8IBtPWu6yCcNY0zSe?=
 =?iso-8859-2?Q?LRnTgdDLhIWiS2ntB7GtPutDyiSnFdXb97LkD+hQDOeeCD0i1F6AN75uTX?=
 =?iso-8859-2?Q?5HBaWUCcJxcqJk2xx1ekVO7roc1wo+Qdhq9qjKC0UrMvzGICRRxJjHBx1I?=
 =?iso-8859-2?Q?o8KVINMplVGVT5KhTFTt1ZR7VV5yV293+yDQkkzGTiAqt1Kva6uWIOKVcj?=
 =?iso-8859-2?Q?iYHIlTNwgeZ0fYYVNE/4onlUDtreW8WRq+ntvFsbp6MtXRVvhYGnNb0CPQ?=
 =?iso-8859-2?Q?MuACCD1MlkmlO7jZ3ruzp36utGroEUoMUHl2jMpbbPvsNsK4Lp/eCQUWGv?=
 =?iso-8859-2?Q?zwbuSsFGQrgGR08qRNEtKv4xtiGMBSMCDrnFgyFNSjqjOEkmysF4NxOenm?=
 =?iso-8859-2?Q?jz4sw9gEd+9ADo/37UU1IVllvoOzuNUthrsnopWsgP2NOYYsOeIyJKJyMk?=
 =?iso-8859-2?Q?4graXqunqE85BThaBvKND+UsXkuE2TLIiH5pWSHpVe8R1yGmAKFkVqNNc6?=
 =?iso-8859-2?Q?aWJd6OCiwKh376nMqcHBt/LOg2e+2YSZy5bLeX0PaZMa/yyCut3zUVfZLr?=
 =?iso-8859-2?Q?sfAJG+GWm+J5BMAfJ1XulprCfZwIQidqPOevnopFdQXK+dF/vhi/X8S2dn?=
 =?iso-8859-2?Q?Jt6zZ5r9TsZcnaikDA1ZQl7tiG6UTMkUSr+rt05DbnDFgeGBFQILUAJjIi?=
 =?iso-8859-2?Q?vs0j03MfUrVB9T0n2xNtWW2SySDVtqUEGV+DZtXAY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19640bc0-226a-4232-bc4c-08dc91a061a9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 03:15:19.8591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8970

From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, June 20, 2024 6:48 PM
>=20
> The intent of the code snippet is to always return 0 for both fields.
> The check is wrong though. Fix that.
>=20
> This is discovered by this call in VFIO:
>=20
>     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
>=20
> The old code does not set *val to 0 because the second half of the check =
is
> incorrect.
>=20
> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microso=
ft Hyper-V
> VMs")
> Cc: stable@kernel.org
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 5992280e8110..eec087c8f670 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_=
dev
> *hpdev, int where,
>  		   PCI_CAPABILITY_LIST) {
>  		/* ROM BARs are unimplemented */
>  		*val =3D 0;
> -	} else if (where >=3D PCI_INTERRUPT_LINE && where + size <=3D
> -		   PCI_INTERRUPT_PIN) {
> +	} else if ((where =3D=3D PCI_INTERRUPT_LINE || where =3D=3D PCI_INTERRU=
PT_PIN) &&
> +		   size =3D=3D 1) {

Any reason not to continue the pattern of the rest of the function,
and do the following to fix the bug?

   	} else if (where >=3D PCI_INTERRUPT_LINE && where + size <=3D=20
  		   PCI_MIN_GNT) {

Your fix doesn't allow PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN
to be read together as a 2-byte access, though I don't know if that
matters.

I have a slight preference for the more consistent approach, but
don't really object to what you've done.  Treat my idea as a
suggestion to consider, but if you want to go with your approach,
that's OK too.

Michael

>  		/*
>  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
>  		 * because this front-end only supports message-signaled
> --
> 2.43.0
>=20


