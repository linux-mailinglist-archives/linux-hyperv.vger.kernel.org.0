Return-Path: <linux-hyperv+bounces-5280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F8AA5A8B
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 07:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040824C63EF
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 05:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994C262813;
	Thu,  1 May 2025 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dGkjM88O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2070.outbound.protection.outlook.com [40.92.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A725A35E;
	Thu,  1 May 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746077278; cv=fail; b=cbwsYCIWu7oUblXwkoT+eEMh3zwB5XWXDLwKtwFy08mXu+rSPmat82Hdg0m3CUie7RsODlvAtM6gR3qaVVmrgbzbipWrR3P7OUhVepNsTvBvJv3L9h1z7uJGUVOQFMp+qgv8SIssdkQZAfjaQVFym4/JXbpKmVCTBuBvkVjwDhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746077278; c=relaxed/simple;
	bh=thoBZYox6aBbaI2YyaHmQRGTVRmNstBhmyvXlx8zxeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+QYleEnIxqGnxxjsexTx46KLzQU9CMX/0qSpicSC7lyN+lZFS2+rCPcKGESTK5WcxRIGuWK7JhGf2aV5h8vMUn6xxadfF5KwnOq8Zz55UIHForWqMqOtpCzb2wCdfmQNvZFY0cvYUTxHLVuzD6Ez/jedkDRccNpgjK8JLymUjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dGkjM88O; arc=fail smtp.client-ip=40.92.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Almb1skZ1X8yUBJJXT6oQf2VIqmv+Y7KaThWfBBQmjVOgcFkjEahpxFhMX8JzobYOizOFJTUrGeJln5EMFuvEokYKm/nbejDP2BzJL9dQCG7lXFoVfWW+BhIhNB8WY48D+n3BoTbiBkYI4HH47TNItG+hA+A8xtV/S5KsnfegcsvR85R1HwDJEdI01Vw5K69tdgYIqAImzg2wpNmynecA4uaZfWD4uZ9Wu6J5PqpXQXaizU4EAlVgqbADds8wttu6bg308UaH/1VBJxjlXugXDlYj7lSyte0najjjgFBy7Jzm6idiuesqhH+AruMdlyPswQnXrOKUHEg6OOeNL42Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyp9X6JMReWdrBG3KWYfMXKF8KztrRDpNbuaR2osKig=;
 b=V/eA8k5xqlyoeVMV2ZtlxSnJ6+zCN2MmznFUGt381HZL2S8djAydmntG5jI03n2Q2U2M5x5ULvUxdJo8uY+wNipSXqTCk0d8JFYMdzS3nXMSF+nzSOc9O+Lb2DGgiZ2jr3S2rGqiE5It72MmPv/aLR8AATUkzBRfBd+HSbRwCDAirxfI1NgH1o4OD5gYVmEbxgpDdtzhYxKv++2yjWZdkHnk0nLti5H9TJMP/0Ul1O15oPpDiuy4TRz7N4HrOLdBK20HKifDN71o2ngxCW3FilDJyIeZa+0o2ipPE7wDFwxZ1rDfnwM/Y1YaOtt0tJWfeCJOr2v5TMMTN1Pu5inQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyp9X6JMReWdrBG3KWYfMXKF8KztrRDpNbuaR2osKig=;
 b=dGkjM88OVU6Nccyhl6ELBdOLNB8ifE/SnBNosCjPMDI+18h2rx9FG6fH162AL6/6DPadNYFcyilaXHpHHkJnP6aHXpAc00gDHtcUcLCx0G1P2DO+CNMFyQaS25ufIdhpht/GPRG5jli8cA0PdRYBDBreBsB5IpNBrYImi6OR+J96mB2KQRM6udyb87eUjeKTLXIc6DPxCqdnqhh+aGXFBLDz8GrqNCcFQtaKHxmt2ujXtiBC3IqYZlKrZ1/0rhl2S9SUs5iY5+ebk2X8Ms0K5AcNDeeHKrlbIIzz+vQ5OjNZJ8ER4MGWLJDKoH17WyEPcJty4E10jLpdNzSsnFXHrQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB8978.namprd02.prod.outlook.com (2603:10b6:510:1fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 05:27:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 05:27:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long
 Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Dexuan Cui <decui@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
	<peterz@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
CC: Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Thread-Topic: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Thread-Index: AQHbtdCa+2CaoQUHl0GxlQrhegIb5rO319gQ
Date: Thu, 1 May 2025 05:27:49 +0000
Message-ID:
 <SN6PR02MB4157FF2CA8E37298FC634491D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB8978:EE_
x-ms-office365-filtering-correlation-id: c26a5839-d9bc-4c29-fe9c-08dd8870e9ee
x-ms-exchange-slblob-mailprops:
 0wLWl8rLpvv/dfWT6unGWbRi7AvTEDs/65T7t36xaDyEsNbveHIWoBqBuAi4cHApQnJDlcdk3wRhg2Y0UsnyCYFTIABMYHo+svcu5Jtx3h2HFZOio83acxlj8Kir0QgpIxl+xktQ/QAlBBJDoMgfMVTBk7kKkid++u9BFgJKb8PEv6yMr5Dz7ioZS9tjkxcl2QU6VdviVeuZnM4+5M9FtMcPqc+QAMrXw/nDaZDOtJErRUcqt2Vi1CP/5tjTxlZZaK9clah3K+kSS/6uj+ej5HHk0lPLfCVM15KKUFgVwb9G5WlpZGYZLW5oFbceiFznxz8w4c7VF5jL8xCi2EcFmyIGRfheYrnwwR4muUTHAzueFlTeEHFHA9EDzGFyopTfctgPVhPH/PckMqVCJuawig6RLZ5vBJ2J9V8PPyrbpe5g+9oggU/2T5ws7HHn2fnmv0W//BgNYxfQ0w3NSy1YkKBW/Rahz0O13lpVgUUY+xSrN1hFJcdn5qLsqyBgCHWXfrETLcC28JyuZSESGcGXfGN0XqJtjMVvdtSxH8dsj8aDpGkgVR0wyLZcdS0feZQepWMT9ujaR66QjbZR0YPuxMesH351IV5le2YIWuFCjH8097Cd1/XpsPCAIHIE4SmUx85WbRTxjeOdw+NpBqkCq43t2Gt0YaOIY1gRG8oV/jCa1H65fgWH2MhGERvet8UlufFxuAH/t9rzVHzH7CrVUCBuDYT4ewUMW+mggw66S8y03XDu6wwv8e14enoDzCmk5YbEp5rCsdE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|15080799006|461199028|8060799006|3412199025|440099028|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?j5xEy3AReovSMS6QWzYEQeuiHbkuB+ycogtHSRpdomBKZte7L2eGJhb4ed?=
 =?iso-8859-2?Q?AdNcmOEplgMbuyYB4hF/smBJagFnzH8bIzTBrcVW5RZ578xM7OGSDTiOoH?=
 =?iso-8859-2?Q?SR/0tdOG4jlkjCji+dcgGmXGUxIxbYJAuYpl0BgWHE7X6BbRX/+S/7rocN?=
 =?iso-8859-2?Q?M5P3GJbri4KoWYrY0XoG/oMpVvdOqpLJnetZ2Niwy0URhGTBlhK7pSvfHa?=
 =?iso-8859-2?Q?Q5xDMFEBEIrD781G/KnpKJOtwLnuv62ULyvpHXgCEWDL6rcUXbwomIJgiH?=
 =?iso-8859-2?Q?lAs1l6ofcFRCCTRkrmLp4VINaSHxuPlJrc91sHiyz0OHJbt9Sal4HBQJxJ?=
 =?iso-8859-2?Q?7vKE2kMMmCGZKldfzr3s+mui/nok8zZQxEKTxR9iGyPeh87tUR601eGpwa?=
 =?iso-8859-2?Q?KM+qxS5ASdnNQuH/P6YW2WyK0AyWLCecDF/SdLjCRRG4azUlpr5VKy2aUd?=
 =?iso-8859-2?Q?is8FFEsk0aJ/60m0im6RhXpbLPAtHKZHvQnwA9/LSB7AiSPQD/iEiaVB9U?=
 =?iso-8859-2?Q?+Lw1vO8kj4dHzACv3KAb+9e61jhHjXHZvmwwQRZNGknn7FaYUb3su+SROJ?=
 =?iso-8859-2?Q?Ey5t5aJO4+9zezIQkkQE3R9696W52M6tFwqxHpto5TXbWsI3kxgOvRt94F?=
 =?iso-8859-2?Q?I2D3oRKksTaHgj4KolZ7uzrw0cy9kDw6VY5O8cSTAQWq12RoYTQa/mbJgd?=
 =?iso-8859-2?Q?diLtAYsdUk56mTXBGzhTeLCYoD5s1i/P3nBxxZIhTd4AulcUJc0z3xLHzx?=
 =?iso-8859-2?Q?PgRjRK5sF8kxL3zpYDHUI9vS7vwvmtDQEWV/8iJicqGX7kFScsjLUrc6DQ?=
 =?iso-8859-2?Q?ZwKjVobwvn9RnjQXxxXhtfA0Mkz5S7lMAHlT+84gY16P7i56x+XHH9a7I8?=
 =?iso-8859-2?Q?ejkLT6OqtGfBCPtkuGr20yfWIxJW2K3yq/Ni8sXE29+3beH0+4i4arKmeX?=
 =?iso-8859-2?Q?BzWPdEhlG+e0mQoXHV/2gCYrejqExO4MXqwGgFc+G0EST5SWyH8tUELA+N?=
 =?iso-8859-2?Q?x5F37JQSCGjnAJ80f+8/bI5ElfuPff8P5TZnO4bgmf9JnVrGhbGDctAGgF?=
 =?iso-8859-2?Q?GKhaopTZCPgZMSKGHCHG/S1We42TfIKYoV0/o58zZWJvW3oyTdTm+fe7A+?=
 =?iso-8859-2?Q?bcxMkP1v07z5pomR6vPH5V3o3Sxdct1IfBpCM55fCOy6H/hfcMasYoniSU?=
 =?iso-8859-2?Q?8tpYDinXs3BLEw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?xnBV24Z/sZgOJmbnOSDG3rVYTFFwgcP/8njKuWfzHbVN1tXZl0c2hZgaKF?=
 =?iso-8859-2?Q?n9m6U7M54UjKyY4GpH55ZeNV3LIiZPVepFpnaOxvAsdgkzAhBKgOALbQEi?=
 =?iso-8859-2?Q?ST6XRl423GiTJZVqVLXne2fB+CgNYW7aMqHKICn8C47XN1OP77UNq76Ot6?=
 =?iso-8859-2?Q?cD5FElhSoRPZ4ZWb4ypqh6OBSo8n6dJB/IfgW65FzMC2Zp2VAxw71nPyMq?=
 =?iso-8859-2?Q?mO6tfEnT/GdlhwoSwnwr/puxWTbDGl+aSVa0Nnx6ujGcey9fyX1oM8ppfe?=
 =?iso-8859-2?Q?CcLR1HC8K9RjMAtQSq7alXbUhw56QfWtf7NNosbgJEdk+vD63Au/BnX5bC?=
 =?iso-8859-2?Q?ScJqdLCqMCGZ6IGneR7vMqUFidVN25WDMlwM2N9Cc/Rx7GSrFPqbrSbvY5?=
 =?iso-8859-2?Q?cZ3l201Undm9EBPALqtKU0eBtzDb2DyYC/m/VpJ19BiL378lZGqKIO4yuN?=
 =?iso-8859-2?Q?k03NxWKmTpWLNqvStFGULVp7lhjr7g1/kTzUxLZotq9pkVVKmfswnQIlqW?=
 =?iso-8859-2?Q?vPCHV5hr1gDyZqaw7ppCzLW9FG1e6oHDeb2nnmxnj1EfZUp1NOXcm3CmQB?=
 =?iso-8859-2?Q?gTzYuzSSg45K/A2JU3DokxZBzVKIdh/mlZZMcVliT0wQmffwvgTKmaRTyB?=
 =?iso-8859-2?Q?qrXSBslNSEHTUgaCo9ONyqgNEs4XPJEua07q1X2aiGYjKAViB3Mf7z0cIc?=
 =?iso-8859-2?Q?MABY8vP8iBhANX6BELGadj86xqJ7UQRpx8VvIhD8kadt+FFVJ9DUn01PQH?=
 =?iso-8859-2?Q?CH7VtFRYifJnktalgWVxCFWO0TSbsQLZfA9Ps7eMMoWd43J0UXBvDAOM5y?=
 =?iso-8859-2?Q?sedXwRE9YOtcAm85zytJ7N9h5q+xTuX373rN66bJ7XyhDrxcgxcGDpxaHZ?=
 =?iso-8859-2?Q?Gteg0GEX5phVky8Q4UjXgfbz9NOP6OySFhtRY4ThETnf+zyyjpYX3w4X+L?=
 =?iso-8859-2?Q?qqSAAjZPpuCBsu7xRpYnaSIi3Tlb4p0PkbgJ4b0ZctSZklTnFlj5bd/k8y?=
 =?iso-8859-2?Q?NQ94X5iAZm7LruQMxYgkHV/ZoK3exTK8DEM1K/HqQ/hya+wiiw0PgRliXt?=
 =?iso-8859-2?Q?76hcy1Id0V9WAHwVAtLMctPbnXeDIchkdHiEoxPscZUc+FT7DQWmREkHHA?=
 =?iso-8859-2?Q?D6PjJhzfMJl5eL6bCJlAVE08sOSWak2UlKaL6uIOjAd/KHPjGraeYk5BVG?=
 =?iso-8859-2?Q?/sZJZrl6bsi8R2RaoKN0i4golU4+TvlnYs6q95Y2bQ/6SWNKFd8LRGyvVn?=
 =?iso-8859-2?Q?BBP2eMtoYGfPVBHw9Ig9Osy6VauJf7uNYcjCtmN6M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c26a5839-d9bc-4c29-fe9c-08dd8870e9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:27:49.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8978

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, April =
25, 2025 3:55 AM
>=20
> Currently, the MANA driver allocates MSI-X vectors statically based on
> MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> up allocating more vectors than it needs. This is because, by this time
> we do not have a HW channel and do not know how many IRQs should be
> allocated.
>=20
> To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> after getting the value supported by hardware, dynamically add the
> remaining MSI-X vectors.

I have a top-level thought about the data structures used to manage a
dynamic number of MSI-X vectors. The current code allocates a fixed size
array of struct gdma_irq_context, with one entry in the array for each
MSI-X vector. To find the entry for a particular msi_index, the code can
just index into the array, which is nice and simple.

The new code uses a linked list of struct gdma_irq_context entries, with
one entry in the list for each MSI-X vector.  In the dynamic case, you can
start with one entry in the list, and then add to the list however many
additional entries the hardware will support.

But this additional linked list adds significant complexity to the code
because it must be linearly searched to find the entry for a particular
msi_index, and there's the messiness of putting entries onto the list
and taking them off.  A spin lock is required.  Etc., etc.

Here's an intermediate approach that would be simpler. Allocate a fixed
size array of pointers to struct gdma_irq_context. The fixed size is the
maximum number of possible MSI-X vectors for the device, which I
think is MANA_MAX_NUM_QUEUES, or 64 (correct me if I'm wrong
about that). Allocate a new struct gdma_irq_context when needed,
but store the address in the array rather than adding it onto a list.
Code can then directly index into the array to access the entry.

Some entries in the array will be unused (and "wasted") if the device
uses fewer MSI-X vector, but each unused entry is only 8 bytes. The
max space unused is fewer than 512 bytes (assuming 64 entries in
the array), which is neglible in the grand scheme of things. With the
simpler code, and not having the additional list entry embedded in
each struct gmda_irq_context, you'll get some of that space back
anyway.

Maybe there's a reason for the list that I missed in my initial
review of the code. But if not, it sure seems like the code could
be simpler, and having some unused 8 bytes entries in the array
is worth the tradeoff for the simplicity.

Michael

>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v2:
>  * Use string 'MSI-X vectors' instead of 'pci vectors'
>  * make skip-cpu a bool instead of int
>  * rearrange the comment arout skip_cpu variable appropriately
>  * update the capability bit for driver indicating dynamic IRQ allocation
>  * enforced max line length to 80
>  * enforced RCT convention
>  * initialized gic to NULL, for when there is a possibility of gic
>    not being populated correctly
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 323 ++++++++++++++----
>  include/net/mana/gdma.h                       |  11 +-
>  2 files changed, 269 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4ffaf7588885..753b0208e574 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -6,6 +6,9 @@
>  #include <linux/pci.h>
>  #include <linux/utsname.h>
>  #include <linux/version.h>
> +#include <linux/msi.h>
> +#include <linux/irqdomain.h>
> +#include <linux/list.h>
>=20
>  #include <net/mana/mana.h>
>=20
> @@ -80,8 +83,15 @@ static int mana_gd_query_max_resources(struct pci_dev =
*pdev)
>  		return err ? err : -EPROTO;
>  	}
>=20
> -	if (gc->num_msix_usable > resp.max_msix)
> -		gc->num_msix_usable =3D resp.max_msix;
> +	if (!pci_msix_can_alloc_dyn(pdev)) {
> +		if (gc->num_msix_usable > resp.max_msix)
> +			gc->num_msix_usable =3D resp.max_msix;
> +	} else {
> +		/* If dynamic allocation is enabled we have already allocated
> +		 * hwc msi
> +		 */
> +		gc->num_msix_usable =3D min(resp.max_msix, num_online_cpus() + 1);
> +	}
>=20
>  	if (gc->num_msix_usable <=3D 1)
>  		return -ENOSPC;
> @@ -462,12 +472,13 @@ static int mana_gd_register_irq(struct gdma_queue *=
queue,
>  				const struct gdma_queue_spec *spec)
>  {
>  	struct gdma_dev *gd =3D queue->gdma_dev;
> -	struct gdma_irq_context *gic;
> +	struct gdma_irq_context *gic =3D NULL;
> +	unsigned long flags, flag_irq;
>  	struct gdma_context *gc;
>  	unsigned int msi_index;
> -	unsigned long flags;
> +	struct list_head *pos;
>  	struct device *dev;
> -	int err =3D 0;
> +	int err =3D 0, count;
>=20
>  	gc =3D gd->gdma_context;
>  	dev =3D gc->dev;
> @@ -482,7 +493,23 @@ static int mana_gd_register_irq(struct gdma_queue *q=
ueue,
>  	}
>=20
>  	queue->eq.msix_index =3D msi_index;
> -	gic =3D &gc->irq_contexts[msi_index];
> +
> +	/* get the msi_index value from the list*/
> +	count =3D 0;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> +	list_for_each(pos, &gc->irq_contexts) {
> +		if (count =3D=3D msi_index) {
> +			gic =3D list_entry(pos, struct gdma_irq_context,
> +					 gic_list);
> +			break;
> +		}
> +
> +		count++;
> +	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> +
> +	if (!gic)
> +		return -1;
>=20
>  	spin_lock_irqsave(&gic->lock, flags);
>  	list_add_rcu(&queue->entry, &gic->eq_list);
> @@ -494,11 +521,13 @@ static int mana_gd_register_irq(struct gdma_queue *=
queue,
>  static void mana_gd_deregiser_irq(struct gdma_queue *queue)
>  {
>  	struct gdma_dev *gd =3D queue->gdma_dev;
> -	struct gdma_irq_context *gic;
> +	struct gdma_irq_context *gic =3D NULL;
> +	unsigned long flags, flag_irq;
>  	struct gdma_context *gc;
>  	unsigned int msix_index;
> -	unsigned long flags;
> +	struct list_head *pos;
>  	struct gdma_queue *eq;
> +	int count;
>=20
>  	gc =3D gd->gdma_context;
>=20
> @@ -507,7 +536,23 @@ static void mana_gd_deregiser_irq(struct gdma_queue
> *queue)
>  	if (WARN_ON(msix_index >=3D gc->num_msix_usable))
>  		return;
>=20
> -	gic =3D &gc->irq_contexts[msix_index];
> +	/* get the msi_index value from the list*/
> +	count =3D 0;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flag_irq);
> +	list_for_each(pos, &gc->irq_contexts) {
> +		if (count =3D=3D msix_index) {
> +			gic =3D list_entry(pos, struct gdma_irq_context,
> +					 gic_list);
> +			break;
> +		}
> +
> +		count++;
> +	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flag_irq);
> +
> +	if (!gic)
> +		return;
> +
>  	spin_lock_irqsave(&gic->lock, flags);
>  	list_for_each_entry_rcu(eq, &gic->eq_list, entry) {
>  		if (queue =3D=3D eq) {
> @@ -1288,7 +1333,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size =3D 0;
>  }
>=20
> -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> +		     bool skip_first_cpu)
>  {
>  	const struct cpumask *next, *prev =3D cpu_none_mask;
>  	cpumask_var_t cpus __free(free_cpumask_var);
> @@ -1303,9 +1349,20 @@ static int irq_setup(unsigned int *irqs, unsigned =
int len, int
> node)
>  		while (weight > 0) {
>  			cpumask_andnot(cpus, next, prev);
>  			for_each_cpu(cpu, cpus) {
> +				/*
> +				 * if the CPU sibling set is to be skipped we
> +				 * just move on to the next CPUs without len--
> +				 */
> +				if (unlikely(skip_first_cpu)) {
> +					skip_first_cpu =3D false;
> +					goto next_cpumask;
> +				}
> +
>  				if (len-- =3D=3D 0)
>  					goto done;
> +
>  				irq_set_affinity_and_hint(*irqs++,
> topology_sibling_cpumask(cpu));
> +next_cpumask:
>  				cpumask_andnot(cpus, cpus,
> topology_sibling_cpumask(cpu));
>  				--weight;
>  			}
> @@ -1317,29 +1374,99 @@ static int irq_setup(unsigned int *irqs, unsigned=
 int len, int
> node)
>  	return 0;
>  }
>=20
> -static int mana_gd_setup_irqs(struct pci_dev *pdev)
> +static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> -	unsigned int max_queues_per_port;
>  	struct gdma_irq_context *gic;
> -	unsigned int max_irqs, cpu;
> -	int start_irq_index =3D 1;
> -	int nvec, *irqs, irq;
> +	bool skip_first_cpu =3D false;
> +	unsigned long flags;
>  	int err, i =3D 0, j;
> +	int *irqs, irq;
>=20
>  	cpus_read_lock();
> -	max_queues_per_port =3D num_online_cpus();
> -	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> -		max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +	irqs =3D kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
> +		err =3D -ENOMEM;
> +		goto free_irq_vector;
> +	}
>=20
> -	/* Need 1 interrupt for the Hardware communication Channel (HWC) */
> -	max_irqs =3D max_queues_per_port + 1;
> +	for (i =3D 0; i < nvec; i++) {
> +		gic =3D kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> +		if (!gic) {
> +			err =3D -ENOMEM;
> +			goto free_irq;
> +		}
> +		gic->handler =3D mana_gd_process_eq_events;
> +		INIT_LIST_HEAD(&gic->eq_list);
> +		spin_lock_init(&gic->lock);
>=20
> -	nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> -	if (nvec < 0) {
> -		cpus_read_unlock();
> -		return nvec;
> +		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
> +			 i, pci_name(pdev));
> +
> +		/* one pci vector is already allocated for HWC */
> +		irqs[i] =3D pci_irq_vector(pdev, i + 1);
> +		if (irqs[i] < 0) {
> +			err =3D irqs[i];
> +			goto free_current_gic;
> +		}
> +
> +		err =3D request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
> +		if (err)
> +			goto free_current_gic;
> +
> +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
>  	}
> +
> +	/*
> +	 * When calling irq_setup() for dynamically added IRQs, if number of
> +	 * IRQs is more than or equal to allocated MSI-X, we need to skip the
> +	 * first CPU sibling group since they are already affinitized to HWC IR=
Q
> +	 */
> +	if (gc->num_msix_usable <=3D num_online_cpus())
> +		skip_first_cpu =3D true;
> +
> +	err =3D irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> +	if (err)
> +		goto free_irq;
> +
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> +	cpus_read_unlock();
> +	kfree(irqs);
> +	return 0;
> +
> +free_current_gic:
> +	kfree(gic);
> +free_irq:
> +	for (j =3D i - 1; j >=3D 0; j--) {
> +		irq =3D pci_irq_vector(pdev, j + 1);
> +		gic =3D list_last_entry(&gc->irq_contexts,
> +				      struct gdma_irq_context, gic_list);
> +		irq_update_affinity_hint(irq, NULL);
> +		free_irq(irq, gic);
> +		list_del(&gic->gic_list);
> +		kfree(gic);
> +	}
> +	kfree(irqs);
> +free_irq_vector:
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
> +	cpus_read_unlock();
> +	return err;
> +}
> +
> +static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
> +{
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	struct gdma_irq_context *gic;
> +	int start_irq_index =3D 1;
> +	unsigned long flags;
> +	unsigned int cpu;
> +	int *irqs, irq;
> +	int err, i =3D 0, j;
> +
> +	cpus_read_lock();
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +
>  	if (nvec <=3D num_online_cpus())
>  		start_irq_index =3D 0;
>=20
> @@ -1349,15 +1476,12 @@ static int mana_gd_setup_irqs(struct pci_dev *pde=
v)
>  		goto free_irq_vector;
>  	}
>=20
> -	gc->irq_contexts =3D kcalloc(nvec, sizeof(struct gdma_irq_context),
> -				   GFP_KERNEL);
> -	if (!gc->irq_contexts) {
> -		err =3D -ENOMEM;
> -		goto free_irq_array;
> -	}
> -
>  	for (i =3D 0; i < nvec; i++) {
> -		gic =3D &gc->irq_contexts[i];
> +		gic =3D kcalloc(1, sizeof(struct gdma_irq_context), GFP_KERNEL);
> +		if (!gic) {
> +			err =3D -ENOMEM;
> +			goto free_irq;
> +		}
>  		gic->handler =3D mana_gd_process_eq_events;
>  		INIT_LIST_HEAD(&gic->eq_list);
>  		spin_lock_init(&gic->lock);
> @@ -1372,22 +1496,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pde=
v)
>  		irq =3D pci_irq_vector(pdev, i);
>  		if (irq < 0) {
>  			err =3D irq;
> -			goto free_irq;
> +			goto free_current_gic;
>  		}
>=20
>  		if (!i) {
>  			err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
>  			if (err)
> -				goto free_irq;
> -
> -			/* If number of IRQ is one extra than number of online CPUs,
> -			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
> -			 * same CPU.
> -			 * Else we will use different CPUs for IRQ0 and IRQ1.
> -			 * Also we are using cpumask_local_spread instead of
> -			 * cpumask_first for the node, because the node can be
> -			 * mem only.
> -			 */
> +				goto free_current_gic;
> +
>  			if (start_irq_index) {
>  				cpu =3D cpumask_local_spread(i, gc->numa_node);
>  				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
> @@ -1396,39 +1512,108 @@ static int mana_gd_setup_irqs(struct pci_dev *pd=
ev)
>  			}
>  		} else {
>  			irqs[i - start_irq_index] =3D irq;
> -			err =3D request_irq(irqs[i - start_irq_index], mana_gd_intr, 0,
> -					  gic->name, gic);
> +			err =3D request_irq(irqs[i - start_irq_index],
> +					  mana_gd_intr, 0, gic->name, gic);
>  			if (err)
> -				goto free_irq;
> +				goto free_current_gic;
>  		}
> +
> +		list_add_tail(&gic->gic_list, &gc->irq_contexts);
>  	}
>=20
> -	err =3D irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
> +	err =3D irq_setup(irqs, nvec - start_irq_index, gc->numa_node, false);
>  	if (err)
>  		goto free_irq;
>=20
> -	gc->max_num_msix =3D nvec;
> -	gc->num_msix_usable =3D nvec;
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>  	cpus_read_unlock();
>  	kfree(irqs);
>  	return 0;
>=20
> +free_current_gic:
> +	kfree(gic);
>  free_irq:
>  	for (j =3D i - 1; j >=3D 0; j--) {
>  		irq =3D pci_irq_vector(pdev, j);
> -		gic =3D &gc->irq_contexts[j];
> -
> +		gic =3D list_last_entry(&gc->irq_contexts,
> +				      struct gdma_irq_context, gic_list);
>  		irq_update_affinity_hint(irq, NULL);
>  		free_irq(irq, gic);
> +		list_del(&gic->gic_list);
> +		kfree(gic);
>  	}
> -
> -	kfree(gc->irq_contexts);
> -	gc->irq_contexts =3D NULL;
> -free_irq_array:
>  	kfree(irqs);
>  free_irq_vector:
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>  	cpus_read_unlock();
> -	pci_free_irq_vectors(pdev);
> +	return err;
> +}
> +
> +static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	unsigned int max_irqs, min_irqs;
> +	int max_queues_per_port;
> +	int nvec, err;
> +
> +	if (pci_msix_can_alloc_dyn(pdev)) {
> +		max_irqs =3D 1;
> +		min_irqs =3D 1;
> +	} else {
> +		max_queues_per_port =3D num_online_cpus();
> +		if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> +			max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
> +		/* Need 1 interrupt for HWC */
> +		max_irqs =3D max_queues_per_port + 1;
> +		min_irqs =3D 2;
> +	}
> +
> +	nvec =3D pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
> +	if (nvec < 0)
> +		return nvec;
> +
> +	err =3D mana_gd_setup_irqs(pdev, nvec);
> +	if (err) {
> +		pci_free_irq_vectors(pdev);
> +		return err;
> +	}
> +
> +	gc->num_msix_usable =3D nvec;
> +	gc->max_num_msix =3D nvec;
> +
> +	return err;
> +}
> +
> +static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
> +{
> +	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	int max_irqs, i, err =3D 0;
> +	struct msi_map irq_map;
> +
> +	if (!pci_msix_can_alloc_dyn(pdev))
> +		/* remain irqs are already allocated with HWC IRQ */
> +		return 0;
> +
> +	/* allocate only remaining IRQs*/
> +	max_irqs =3D gc->num_msix_usable - 1;
> +
> +	for (i =3D 1; i <=3D max_irqs; i++) {
> +		irq_map =3D pci_msix_alloc_irq_at(pdev, i, NULL);
> +		if (!irq_map.virq) {
> +			err =3D irq_map.index;
> +			/* caller will handle cleaning up all allocated
> +			 * irqs, after HWC is destroyed
> +			 */
> +			return err;
> +		}
> +	}
> +
> +	err =3D mana_gd_setup_dyn_irqs(pdev, max_irqs);
> +	if (err)
> +		return err;
> +
> +	gc->max_num_msix =3D gc->max_num_msix + max_irqs;
> +
>  	return err;
>  }
>=20
> @@ -1436,29 +1621,34 @@ static void mana_gd_remove_irqs(struct pci_dev *p=
dev)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	int irq, i;
> +	struct list_head *pos, *n;
> +	unsigned long flags;
> +	int irq, i =3D 0;
>=20
>  	if (gc->max_num_msix < 1)
>  		return;
>=20
> -	for (i =3D 0; i < gc->max_num_msix; i++) {
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +	list_for_each_safe(pos, n, &gc->irq_contexts) {
>  		irq =3D pci_irq_vector(pdev, i);
>  		if (irq < 0)
>  			continue;
>=20
> -		gic =3D &gc->irq_contexts[i];
> +		gic =3D list_entry(pos, struct gdma_irq_context, gic_list);
>=20
>  		/* Need to clear the hint before free_irq */
>  		irq_update_affinity_hint(irq, NULL);
>  		free_irq(irq, gic);
> +		list_del(pos);
> +		kfree(gic);
> +		i++;
>  	}
> +	spin_unlock_irqrestore(&gc->irq_ctxs_lock, flags);
>=20
>  	pci_free_irq_vectors(pdev);
>=20
>  	gc->max_num_msix =3D 0;
>  	gc->num_msix_usable =3D 0;
> -	kfree(gc->irq_contexts);
> -	gc->irq_contexts =3D NULL;
>  }
>=20
>  static int mana_gd_setup(struct pci_dev *pdev)
> @@ -1469,9 +1659,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	mana_gd_init_registers(pdev);
>  	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
>=20
> -	err =3D mana_gd_setup_irqs(pdev);
> +	err =3D mana_gd_setup_hwc_irqs(pdev);
>  	if (err) {
> -		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
> +		dev_err(gc->dev, "Failed to setup IRQs for HWC creation: %d\n",
> +			err);
>  		return err;
>  	}
>=20
> @@ -1487,6 +1678,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	if (err)
>  		goto destroy_hwc;
>=20
> +	err =3D mana_gd_setup_remaining_irqs(pdev);
> +	if (err)
> +		goto destroy_hwc;
> +
>  	err =3D mana_gd_detect_devices(pdev);
>  	if (err)
>  		goto destroy_hwc;
> @@ -1563,6 +1758,8 @@ static int mana_gd_probe(struct pci_dev *pdev, cons=
t struct
> pci_device_id *ent)
>  	gc->is_pf =3D mana_is_pf(pdev->device);
>  	gc->bar0_va =3D bar0_va;
>  	gc->dev =3D &pdev->dev;
> +	INIT_LIST_HEAD(&gc->irq_contexts);
> +	spin_lock_init(&gc->irq_ctxs_lock);
>=20
>  	if (gc->is_pf)
>  		gc->mana_pci_debugfs =3D debugfs_create_dir("0", mana_debugfs_root);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 228603bf03f2..6ef4785c63b4 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -363,6 +363,7 @@ struct gdma_irq_context {
>  	spinlock_t lock;
>  	struct list_head eq_list;
>  	char name[MANA_IRQ_NAME_SZ];
> +	struct list_head gic_list;
>  };
>=20
>  struct gdma_context {
> @@ -373,7 +374,9 @@ struct gdma_context {
>  	unsigned int		max_num_queues;
>  	unsigned int		max_num_msix;
>  	unsigned int		num_msix_usable;
> -	struct gdma_irq_context	*irq_contexts;
> +	struct list_head	irq_contexts;
> +	/* Protect the irq_contexts list */
> +	spinlock_t		irq_ctxs_lock;
>=20
>  	/* L2 MTU */
>  	u16 adapter_mtu;
> @@ -558,12 +561,16 @@ enum {
>  /* Driver can handle holes (zeros) in the device list */
>  #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
>=20
> +/* Driver supports dynamic MSI-X vector allocation */
> +#define GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT BIT(13)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>  	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
>  	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
> -	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
> +	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
> +	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT)
>=20
>  #define GDMA_DRV_CAP_FLAGS2 0
>=20
> --
> 2.34.1
>=20


