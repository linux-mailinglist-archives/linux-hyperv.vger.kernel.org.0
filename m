Return-Path: <linux-hyperv+bounces-6135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE52AFBB52
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF243B5EC1
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 19:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016C12C544;
	Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oJs4fRJe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2075.outbound.protection.outlook.com [40.92.41.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1D263C91;
	Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915062; cv=fail; b=AsWgGy63AOx5jCOtZ5DO9XI0qoZYGTVThO10MLRIut3v347tohXb1jOnHrx3uHn9NSq4sqbFrI3/Oo7vvuJ9dcHrQ/sfyfB8+ZpOCGVveARejPb7W5lLZ4UZb+Kh0A0ImkNklp3v1jv+osF7/ZP1zLkqxmvHB1AW2kyzfGPBBbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915062; c=relaxed/simple;
	bh=SJwK6YgqsM4stkQe7Tu92yomLR5YFC9vOoAX5n5n9vY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gs3HErioN98Tpu9TvtuHQytKOsKEuK8rybxMDSLs20qN1WvqC9pLegQGIDR/XT89h5cVsdpWZlKFn7Wz4Eng84LIxmoENxbJPIHiVaP2dM1RHP4VmXlyg7H5OngFMhb6SZFsoKJTvKluMTkab+R4Io5LdbwQCDbgBEevqb6eYwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oJs4fRJe; arc=fail smtp.client-ip=40.92.41.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKHexP14x7QFhLukBf5GeXxOkTx/zhTjaK1XuOUhhE7o9OPNQz5zbyqhZfy0iTbeLlBrrxBccmi8F0/POCGCKvVqmYw9m+VU4cQeqItO+vDeQS8iCx88tqA139P91NbDsClnP+UOEKqA2mjuqaVya21GWyKY1MowgVERljPwCADO952Gk8NZWc36Zmm8WdR3hspOJ2AG/wHAKMOvTOr+rYCc+RtjgQlq1pxKutfCPKff4pdHpX0G70EoD/kxRwgCDqOWReBJtcJNU1TkRMlaoeEznpQlaIBJbWF5fTLzNqo3aCxdbv/0vf5O0OQp2IcrSmqZH38HFebu/NZMJCPUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJwK6YgqsM4stkQe7Tu92yomLR5YFC9vOoAX5n5n9vY=;
 b=T9pS0zKmTK4fx5LOiE8PzeuGeuZRIYMhU51eEGumr2mtc2FFfTw7CP2pbJnd7/BzUvrLuvQTtBB4vRIKswNb6IPSWjreMhn/LWjiJFKCmT1H+32pztOSyFPf1fwPOm2KodYXmIxdyUhInI7zgguLqZtDyWw7mMPc/SArpAKoPU3bfGsTUDvULsSTxgPYjL78zbVuHJKv+rAbdS3G+/Sgfhv3HZpqiJMwKx2zGaS/+u/MZFUnDY9UiwFeGeKBN0dXuzmb53bloUtxI7WgfsGFZzY1Wj6FbPrc5DoNkN193r1pUzHLy6wdFKKogy2Z7ov1A876NK3Ee4Jue8TIGP0Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJwK6YgqsM4stkQe7Tu92yomLR5YFC9vOoAX5n5n9vY=;
 b=oJs4fRJer36qz4JZYE02rz7Gr1HYHUoFW4564dwK3HDILAqOP0ma6mR16oEs8ZKL5Crtr/fWiX66sbAFLjHFWUQg5gkki+MjTW+ALv7YETLf4b/X69sH1mcskVpnY8DKrv07LXWVJN/G9I0LaCg84yUcUezXK8+k6owAVifZNKXikwFf7U869jNhtAIbPDtm8UE+ushyvhNogAX9yqq8D+FhKMfUOj8MUD0pc0O09hizrJqThl29o/Mwu+vKNWDtMxt+yHR/QGYsddGg4olWEUlf3tfsnPA6E1jSiY+tDn7zytgvY8yB9qd+Eo0nhjHM8j7pcR9GIcSOUacSTPBOXw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9564.namprd02.prod.outlook.com (2603:10b6:610:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 19:04:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nam Cao <namcao@linutronix.de>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Karthikeyan Mitran
	<m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, =?iso-8859-2?Q?Pali_Roh=E1r?=
	<pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan
	<jim2101024@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, Jonathan Derrick
	<jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org"
	<linux-rpi-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Thread-Topic: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Thread-Index: AQHb5qqGWI9T0Ene10yNxUr1s0p/CbQi5NWggABxUYCAAAREgIADuHVQ
Date: Mon, 7 Jul 2025 19:04:17 +0000
Message-ID:
 <SN6PR02MB4157200C58AF0AB4A809ECD9D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB41571145B5ECA505CDA6BD90D44DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250705094655.sEu3KWbJ@linutronix.de>
 <20250705100211.8Lcszko3@linutronix.de>
In-Reply-To: <20250705100211.8Lcszko3@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9564:EE_
x-ms-office365-filtering-correlation-id: b8b302f7-98b1-4102-4027-08ddbd89129d
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599009|461199028|8060799012|102099032|1602099012|40105399003|440099028|3412199025|4302099013|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?6/moQj09QuneH/gLa1VE1zawmIerm85paVT6Bhsl+wHJsUU32688eExyxY?=
 =?iso-8859-2?Q?6D3aBXJGcHqdZzqL6oTHEDPKewW6MdKwzzEGsHTXicv5uE4oBcBKfZa73H?=
 =?iso-8859-2?Q?z3IgWnDgt3P3fycGSL90vDwfsizN+5qO2SU9GpbMU78pNmCloHxAhjAL5q?=
 =?iso-8859-2?Q?pkNM/JHoETdMCyMM1WUR18jrCjXeKBKb70qcdS9Yvs4rvHR4QAmKdBCDAv?=
 =?iso-8859-2?Q?1Ecw8ws18AByY9H1kdwYk5mMcjVX/T0VAvUq+IljbGPGBIvbaBY7K4+v27?=
 =?iso-8859-2?Q?F5fJgFiKn4bco+c1gWv+TP4401UUg1q6vygnwg4wRoEUynHAsC0/y10h0M?=
 =?iso-8859-2?Q?lbsSl2xbsH9htvq2rzBRmunUTlHMiYP48uIGi+nwXZ5xRcRfLEDfa5nwTI?=
 =?iso-8859-2?Q?iclszbufLWTNEA+g0uHm4+2+5TT4qnqOA0P+Nboo2WECfpx9guX8RcWFMh?=
 =?iso-8859-2?Q?Ju6jwMb2TpwSEFmxomjWyN6do1uNKCjAt/JyhK1BelIaJGw6bzSyYXBZv+?=
 =?iso-8859-2?Q?lQaMHeixvs9koDmfChjj0w7RlNlaOQMXDs3VMDPX71/y+KiFS1u0tMSq8W?=
 =?iso-8859-2?Q?kBaQnulsYL9uCkB9fph0q0vxm7GZNWox8AG+X+GmjGSDnKLMbfoco6bCSu?=
 =?iso-8859-2?Q?0vDKHgBXe6288AsnU1lwsVDn/cnFgSi4lDfPSHrhxWUOoAA34UvVRrp+fe?=
 =?iso-8859-2?Q?PA9Pbz7Bv9nU2B157iUiITr9o4Ed4k82uUdOf0ZEM6JRU44xxWHuT3ACU3?=
 =?iso-8859-2?Q?EyOYtWCGov9MqnZ67XcK6nH3uFOc6F2KbmzQQM5m46j7Bj3DjSygX7mxV0?=
 =?iso-8859-2?Q?0FdA2/hLOJ9v5VYSQ5j1roKPcrUDsGpy4S9xKL17m78WsndiGb3Mhj616b?=
 =?iso-8859-2?Q?v7YLUXr+l6/Fhtl6gRqDS3TmC8qng36fCUy4Z/CEBSUbVTO4rpAuCmZLAh?=
 =?iso-8859-2?Q?2IvZjJjrCOQaOkOfMHAYBBjvwQndDXmI2Q70d+A1BksIMkJrj+eDR3EP39?=
 =?iso-8859-2?Q?fBXFzLes4hRqo6Clnh8SG4PUjHTttPCGCL4N54TiYzxwprsuZfnaPfxoR6?=
 =?iso-8859-2?Q?NbgcdCcTX0ddR7Grpe0Wmgija+iffA4gHykDgF4ho/3U5ciXTrClCKCxYB?=
 =?iso-8859-2?Q?PhDmujqXjW7YRafCg5LjE7QEROW6JGmHCC8CipCWnI8If51xM1HlVeGXCt?=
 =?iso-8859-2?Q?G5GfMm/i/OQISNBTn3PGXd6aFvaM3ivB+UyzGE22QCBFxKVDGZQk2KYg?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?B06H8nIeYCea0Q5P9dPinGipdB0PvtV7GisfUQz5k82ZQTuSndLFm99tBb?=
 =?iso-8859-2?Q?lVyOxevYWutwWvwTyTDXDX+Z30WbcBpu58ymcSt7HEcy436eej521UCg/u?=
 =?iso-8859-2?Q?tjCqAxzxZ0EE9W/94Y6ZhoP+xLrc0j26OFJeH/S+B40pZBUFXz8Y9aS4VA?=
 =?iso-8859-2?Q?kchFBqAyyUE8GfeJOKwSrXW6QKnCZ6yX/Tn8fe4fRktTeOruuwZLnPowtc?=
 =?iso-8859-2?Q?mfWuRDluj6d33xgwIHbg9OpihdBupG/tEMuupaXQQ4VVHg6/JOdy2wv79r?=
 =?iso-8859-2?Q?tRgW6XqA0DkDGKIUjQHSfhGpf7mfYASJ9nTxdJ3A0CmGfb/v4KbYXHK7IZ?=
 =?iso-8859-2?Q?UeuyTGHLUM8Pckx+0JhbdHWTqfFzKR1QnZoHskLyzK/zyG/nnc9bKfkHZG?=
 =?iso-8859-2?Q?TVJ06ZJeImoHuraEsRiqOzyRiCRxErPfieE//gee4dIGPvnF8aZzeXxnGL?=
 =?iso-8859-2?Q?LSykhxBUBJlW3D8GUccpjMpS6mpq2+vz3uYuti0Uf1cGgjHDAYGgCbkMLZ?=
 =?iso-8859-2?Q?nBZn17KeoIn9gT+7gjmY31zM4atyrrfKUpV1zkKCWJs4ALKJHq7rVXzfJT?=
 =?iso-8859-2?Q?Sfrlrq1gR4De3tzh9ptcqtKuR6A3KCn1CTCYlzsvcsgL1b8s9cLFCjU15U?=
 =?iso-8859-2?Q?mJVLYzNf0bIGSHU8pJB6HIRMfMDlCmbMEJxbv45HQogkmvuIFxP2mHRrkK?=
 =?iso-8859-2?Q?mF4Anc4H7fheMKOqiu+L4ersMDOXNGlOthnrkGVtu0mH2KOCrHXTRPFYc3?=
 =?iso-8859-2?Q?+a9cytTZBTHDmCcrIIPdi1l85w9BETDjt82Z0U5G4t5Z5R7e6YyzSXjqrN?=
 =?iso-8859-2?Q?OpFnRa5F88jsyfOAjv3F3AuRcz6SPamtuOSuI3EZDv8mS0eYs8dC5N2g0T?=
 =?iso-8859-2?Q?f0QHgV4AE5D+5ekljDXpgf9Z8+WMKYmpdWQ3su+COiqQORtM78oZIthhPi?=
 =?iso-8859-2?Q?fvrXybWoAIqO6SsrSKFakaQ8DrWhknkjM9QRFUn9DW+AnPaTKU46v83WgY?=
 =?iso-8859-2?Q?QCBkqwOjLULvAgw1HzZWgGtvjdBq8YOGRKbGjS6r22tpwj6o34coiUnkXB?=
 =?iso-8859-2?Q?3nO9HhCu3XznxIj/54sQRIpBxj7NR1kEFTiCQoEWhjUfG7Dn4mOnkT059S?=
 =?iso-8859-2?Q?IT4hOgdBwb/i1sjh5jbtfFuCapbNKhCe4TwhwgsGX3Xrk/9qL0eZqhj8TS?=
 =?iso-8859-2?Q?bLz6g/o96/AmHmEqm7+whgAlwOoQFaxyJqjF8o9OPbIUrxVGqwgsb3q/nJ?=
 =?iso-8859-2?Q?FRycf8PEVmZNpsAhdl3qf6pg2N6vX7tWHa0ZeWxt4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b302f7-98b1-4102-4027-08ddbd89129d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 19:04:17.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9564

From: Nam Cao <namcao@linutronix.de> Sent: Saturday, July 5, 2025 3:02 AM
>=20
> On Sat, Jul 05, 2025 at 11:46:59AM +0200, Nam Cao wrote:
> > On Sat, Jul 05, 2025 at 03:51:48AM +0000, Michael Kelley wrote:
> > > From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:=
48 AM
> > > >
> > > > Move away from the legacy MSI domain setup, switch to use
> > > > msi_create_parent_irq_domain().
> > >
> > > With the additional tweak to this patch that you supplied separately,
> > > everything in my testing on both x86 and arm64 seems to work OK. So
> > > that's all good.
> >
> > Thanks so much for examining the patch,
>=20
> Btw, you probably would also be interested in
> https://lore.kernel.org/lkml/cover.1751277765.git.namcao@linutronix.de/
>=20
> which does a similar conversion for the other hyperv driver.
>=20

Thanks. I had seen this other small series for the driver used by Linux
when running as the root partition (i.e., "dom0") on the Hyper-V
hypervisor. Unfortunately, I have less familiarity with that configuration,
and I lack access to hardware needed to run and test it. Someone at
Microsoft would need to look at the patches and give them a basic smoke
test with Linux-as-root.

FWIW, I was a Microsoft employee for many years, working on Linux
guests on Hyper-V. But I retired about 2 years ago. Though I've kept my
hands in Linux kernel work, my access to hardware configs is more
limited than when I was an employee -- now it's guest VMs on my
personal laptop and Azure VMs.

Michael

