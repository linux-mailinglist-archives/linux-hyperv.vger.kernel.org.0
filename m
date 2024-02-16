Return-Path: <linux-hyperv+bounces-1550-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367EC8586BC
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 21:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C78282023
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0A13957E;
	Fri, 16 Feb 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F81Y3JNM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2053.outbound.protection.outlook.com [40.92.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46478135A6F;
	Fri, 16 Feb 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115290; cv=fail; b=RZWmICzGaauBg5IaOBfJXfZY4tkb9DDaqVbOXVu8o9ZfdCsqWfq0Jz0yB9lNv9EAAGT0u/XAg+I2fWrMzZsQsqysaI2woq8V4ikeACrZ419yvjqbb1qsBRiEVnwLhwCyZOVI4Xiaywg0pUQJRGJHyXAwq3Mt9fGeXd8Ru9aEH4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115290; c=relaxed/simple;
	bh=SJDyL0Y5Hw+hB9zEgGZ3gsfZrZ3gE6Mx/9PQlYCdfL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=haRW7Kn1tbxwKHujJa0m+Z4QxaRfdeVSxqbdU1vBxF9Lca1saoYmU966obLkGIMuw/r1NIHu6QlQBKr3z7GqQPSgAtjoK9ZdE+VE3r24SWqPd3D85lILIQY76bAt85dfUSVnBJ6NtS1r7nToB3ENbZKQpT7Edbj6DWwX7BMRXmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F81Y3JNM; arc=fail smtp.client-ip=40.92.15.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/egTgn1FRBHoeZ1PcjNE+kMkb4vH+i3EE6JLVf2iTbgk1AgIm1WeSxyo+IXYcNvk/HXXNxaOEaKRDOKSr64YGWPRlQrEtIQoHrwp81Hfazppq+QcjwybUa0ZgbpcXA5OXkgO73LWSPDUkWwCN2SJkLRTObzCjywVQH5hL5LjSOfVBAWixe1JFtbDQEO+AgnvrGJU334+KIKmDPtXs4o7ZWq5hdK3npsCNwWSbMiXbQ3uEe3Qtb4MFwJuCXK2KR/Sii04OBa6kyTMY6w3W9TJpB7wN20nWjETU8vPYHF3CZh1izuTFJna1Xb0ic8XZ12AeFF+kFQKNl58AP/MKs6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2McgmiSpt92YvfCZE/pQXZ4K8469yCZ7Qyr0GEiLRqM=;
 b=YFLvws0fylenDC5111LrSXlFxp1kqQ/IkB9yQyq4JpgOLlIWcboBZZ9vVbQyRvbVDHujm5Atb2sKuYKIBQ9QAojyHCWTZEbEKoScUU22IuFUndLEYL3CzL+R4jLRUGAE1uugrIM6bbPO8RHMFNdXEbAdseMH0ogHg5qGcYN27jzptVzhhHGizfEioUWWxUKj1GRUQYQE1+6KsbSTBSMlGWB6THfGYIYFXYnnOSqtpDw1chXMmVNE5k5xcPHTmJDDW8+wcI9hFydklJp7niNoqN6uCYkjNpePC1Z+en3PCW8zCeAPpvufTfMvdZ1vwNy/2y3KK46qi9rUwytbAnv/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2McgmiSpt92YvfCZE/pQXZ4K8469yCZ7Qyr0GEiLRqM=;
 b=F81Y3JNM4LCCUnfEeGYDCtMxPD/UzJk5iqc242wapfjiosPvuhNT8FCleO7AFhA2vG8BaOFw7UgscZOHnhm/8O/8miTnA3gTmyRvDzlGQBPgG7AG4ErlOpWG2ntal6MdQegCNdXZP3uF3cgeT6iO5Dgl4Z9UCq2D/SAyKO5VccR4Ru7p0x/8D65petHR3CcWBdACtn+WZNuw2monCDNwt/+Ib5tDHjdaSeEv1qhvZHOBjrjhQvEuF7Z2ZMvtA6TXcHQMNRg6uDFggLnHi8tFEgZE0r4z5yzAnFEz9WH48qmp+BIrRyluWPwQ2P74+n1WL60pT4HkMb98nucVUAs6wA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9943.namprd02.prod.outlook.com (2603:10b6:510:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 20:28:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 20:28:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Topic: [PATCH v2 1/1] PCI: hv: Fix ring buffer size calculation
Thread-Index: AQHaX+NrV9kpOA7q8kKo52FVqq7NobENDfiAgABebnA=
Date: Fri, 16 Feb 2024 20:28:04 +0000
Message-ID:
 <SN6PR02MB415749788D7DEA3D1D792913D44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240215074823.51014-1-mhklinux@outlook.com>
 <0802ce88-c86d-3a74-501f-28393d6112f3@linux.intel.com>
In-Reply-To: <0802ce88-c86d-3a74-501f-28393d6112f3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [bWeSa/l7ppB/jlQWtSALD2fEwot7yriq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9943:EE_
x-ms-office365-filtering-correlation-id: faf18e99-8d82-41e6-2e5f-08dc2f2dc73c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4wD33byVVtvdJnor6cY2LnE7rLbubY42LnLmODLaZpSlasXEriWdwE1I/gIeJpO4YLTTqihSa/FTdJo9Lgsq4pDvIF3M5HzouZI+OSGbMK73MVpMT4H0yrfCSisDjA9kWiOQsVQW8JtlxarDOTW6izNoWXtdBAzZbUC6Pas4m0GCvgMhgwBCNYurAwwCL5FVjZG7sLtq5tR/XYr7gYzNMukFFn1kQr8L0fFxXYutubzwZUHRVJCDrxFWjP01RY1eYXJ3+wLPsN9GVpsI1YwvJgXLLCo2hbC1ZIzyCu/NgYJYIlr+GqJ7PiBqMGo5zy3O6x3I4szrVrjgNYrs3hs50eI/KbArA0R4aCkDi+mV4h+yENYug0T5Hruc/T5HwrpSeKP2LqLGSeQVq3pMlxpI46GPdZTIDJhURqOyzP11+hL1OnRELuHw+mCRawoUFQcmifJDywjfOk7ITDvh5tzUbjD+ORaiJmyQfxxpdrntXymA8D4+y5uS4B2HQZWYeI2/CAkwZz8JyxJpLLVVkaPfFGq3rZ73MM+mI5257S1aSw1A3QhlmZGioBPpmUCzm38+
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qewd65Gc/ycHisuj0ElAd9/6wtomJsRBdY5swJwt4/czV+B0XvdIURCj6A?=
 =?iso-8859-1?Q?5qUoR4kMiojuufhYZrUUTgEjqjGxerLQLFEyDWOE2u+fFRX1sCSIPCdLT9?=
 =?iso-8859-1?Q?c1bm6FF9pvWf9MZ1UK5JWO0V/FNm9BJJxaVhkhYHrPusJkUQBBWIXxF0dK?=
 =?iso-8859-1?Q?jK7z3rTBGmRHG8+b/KCMkPxBx2GQQysAMD3iUEhUEgk19JvDFPmMNvbLoJ?=
 =?iso-8859-1?Q?QDeUlboSbHBEBY6NFunN92kRxhTp+w4wcN6dOiGXrVVX2froqDV38QCMpe?=
 =?iso-8859-1?Q?B0CrpIW9JG1wXRPxlpgTF/hyfQ5xHii2p2lqKinLSV3WrOFWRuXX1tHxvk?=
 =?iso-8859-1?Q?jBBrzDgkODVUAw3MUNuBGyxcpdRHL3mkKz+yJQVWl/I6zJ8Xj0ZJutV8m5?=
 =?iso-8859-1?Q?xbUk+VTZUqQy+lnjtApdwPp2lZmu84B0QQtHh6SAJOVUaRgBQtsqL21DT/?=
 =?iso-8859-1?Q?ZeboFRK66MDnZxT2TCv2fEj5dgjPFn+JdQ8dA14H72dLL4RNyvd1SH/evq?=
 =?iso-8859-1?Q?y/gWIxmiGdXpRIJpRst4iONKbd/NG0BIrcH1Tx/MJhKPsCaIUjVXHdztVX?=
 =?iso-8859-1?Q?FRHT9fPs+4nnN+b5WQBs679sfUAd525/xkuVj8tjjF/O+J2znNp3FxSYjG?=
 =?iso-8859-1?Q?BkfD30vsIPgmIebNymetPu2SHb7ketTz6mW/gtTTELTdA94gJ+BxekgS7+?=
 =?iso-8859-1?Q?V7nGKxm0XxDzBb6lOLgrqpJsk6AC3saCzF4BQYrJWZqD7qgClEPy5WxJEc?=
 =?iso-8859-1?Q?rNkcUJHpnKmv6MwwLY0y+mBxspbBFYnBOg4bRVnAQGYptyQWnlZOq7pYbe?=
 =?iso-8859-1?Q?iXo5uhWJBLxFrRjn0O5kirEGDiMYjii2cXY3JsOhzsro7eGwTnpmpOD20O?=
 =?iso-8859-1?Q?fwzbd49cPPGS5E2VpubSFPomy//7vYLpYbqAHI/YseAewlLI45Gf2ducUn?=
 =?iso-8859-1?Q?f3IdxipPBKLsOIzoiO8ejfn6ckRxMVOGXR899MjMyKYmUBKb5hDcsrOPw7?=
 =?iso-8859-1?Q?4tj2Pc+hYwaB/46UstF3viHMsnNodvHkr0OEfxcTiWTlz3bCQRGGLgmtdE?=
 =?iso-8859-1?Q?Ts9cDMqTOgVXBU/8l4Zb3L/O+/EDylihxNkeCGMaPbuNtHLO1aGQ7eC2a1?=
 =?iso-8859-1?Q?1+qUKLw9+6q7VNYnP+QXFxXuse3mv6d/JDL1jUYky9U4tC0Ny8WJofA/If?=
 =?iso-8859-1?Q?wDVUmz1XDtaokSlhU+ucRDOyExo7DtqITL1kTk2Keb+sRKKRMozGFSEl/A?=
 =?iso-8859-1?Q?PmpN6xZj2VWcTac1CRy6qKQFBdY7nzj+N8uDF1fWY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: faf18e99-8d82-41e6-2e5f-08dc2f2dc73c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 20:28:04.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9943

From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> Sent: Friday, Februar=
y 16, 2024 6:46 AM
>=20
> On Wed, 14 Feb 2024, mhkelley58@gmail.com wrote:
> >
> > For a physical PCI device that is passed through to a Hyper-V guest VM,
> > current code specifies the VMBus ring buffer size as 4 pages.  But this
> > is an inappropriate dependency, since the amount of ring buffer space
> > needed is unrelated to PAGE_SIZE. For example, on x86 the ring buffer
> > size ends up as 16 Kbytes, while on ARM64 with 64 Kbyte pages, the ring
> > size bloats to 256 Kbytes. The ring buffer for PCI pass-thru devices
> > is used for only a few messages during device setup and removal, so any
> > space above a few Kbytes is wasted.
> >
> > Fix this by declaring the ring buffer size to be a fixed 16 Kbytes.
> > Furthermore, use the VMBUS_RING_SIZE() macro so that the ring buffer
> > header is properly accounted for, and so the size is rounded up to a
> > page boundary, using the page size for which the kernel is built. While
> > w/64 Kbyte pages this results in a 64 Kbyte ring buffer header plus a
> > 64 Kbyte ring buffer, that's the smallest possible with that page size.
> > It's still 128 Kbytes better than the current code.
> >
> > Cc: <stable@vger.kernel.org> # 5.15.x
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> > ---
> > Changes in v2:
> > * Use SZ_16K instead of 16 * 1024
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controll=
er/pci-
> hyperv.c
> > index 1eaffff40b8d..baadc1e5090e 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -465,7 +465,7 @@ struct pci_eject_response {
> >  	u32 status;
> >  } __packed;
> >
> > -static int pci_ring_size =3D (4 * PAGE_SIZE);
> > +static int pci_ring_size =3D VMBUS_RING_SIZE(SZ_16K);
> >
> >  /*
> >   * Driver specific state.
> >
>=20
> Hi,
>=20
> You forgot to add #include <linux/sizes.h> for it.
>=20
> With that fixed:
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20

Fixed in v3.  I mis-interpreted your previous comment about
adding the #include "if needed".  It's not needed to compile
correctly, as sizes.h is indirectly included through some other
#include.  But it's better to directly #include what's needed
lest some unrelated change cause a failure.

Michael

