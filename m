Return-Path: <linux-hyperv+bounces-6106-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C534AAF9E3B
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 05:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4380D1BC6DDA
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EFC26F454;
	Sat,  5 Jul 2025 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pdvrNhn4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2029.outbound.protection.outlook.com [40.92.40.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D62E371A;
	Sat,  5 Jul 2025 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751687517; cv=fail; b=WJNukQnLhmyhXCW1VvmXePduzNTaQIGzrz2pZA1GUN/C4xUlyMIOOjVNP8a8XnYQl0kFiYx+4k4qvS5tuQ5zH1650+r+0GcAIJpmLm9ZsEUherZ3nDwGEEeknw3YOKc79RmzGE9tXyK4vGFtW/lnEWKz2s9vaU0zOfd5J/Z4b/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751687517; c=relaxed/simple;
	bh=3ncfukiz12QjtF+yj48ktc17rsmx75ZFxXfb1itW714=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2gMHf5WdkaZRAXiO4CR/YHymE1I1Qfl8yRnmrpSOTfRsYCCypd3O75qbCEexb67rwODuzwGFEjSrYnxjSl1K8FEE/cSCos2XFYPiBKsHkbSAJUZSPxnJbXZDofNItXrhfV5yB46Ck/LX/+ttFRCSiMeqylRC4E2mrLD8eISVPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pdvrNhn4; arc=fail smtp.client-ip=40.92.40.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3FSpm4GVcDhbmv0XH47+aODLXmexgnl6x53QfH2rcomH/hit8hxVVccp5O4CYA4puLVbRpWchDphoImWSPfSgdLJmILfdX6yCESroRa8ltyGacD1OTJEn/o/UJTZsZ723UBqcvsBPKDF5suTpfmUEU5TH/JsoHIOWphgBWJNgsdKNP192qWQyKbgqpkGt9yWYBGr0M0gssyNO9bQBtwUVBvoSt+FGrtcyeQx00mQWabSkmKa8ZUQxWbrEdavb0Ub6XPAb13JhPKdIeLAobBL1i01Lgev1Lx5rGHjSPMhDl+W4wUban8ciCcIZIwdJ44vw/XJ6f5TWYj61YHivwYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReiYvE2eoSLRsn+zknxkvcRKXqGxqigX5KlyvRTlkyc=;
 b=DBj326F07bhfk3AcTCjl3lBpQbm4694Mo7oQSbAR/6t+VA31nak/hEdM4FDegUsgdcfLXjcmhcjNA5qSrZ4bEY8pk+vODKl3ZJvTKoMU63jikvswZzPZ3nekHlvaNSTaXCu8MdpEqmnBP8b/IZLhO8jEfkXnR9whQSecsyapbTw2+ebooNQwkUzyeBmrpj0FLenPg2yKSvjWNIkUSwn1SDoEWpeZMg3zFGt+YyN0e4QM31W4oCUwUO8EwDZD4vG07AKIknCh9AD5UCDb9cnZe+54t9InIdgYWKL4exuvC597eZbBuVIY0ipKy0T0oU8kg40LkWZMKLS/cUOoF1Kgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReiYvE2eoSLRsn+zknxkvcRKXqGxqigX5KlyvRTlkyc=;
 b=pdvrNhn4eI3vt5S8kplrhovPV8bxZOr2bGLbqaaWpCyKQHNfgSIpGyzX37rkSn4MauNvdh8GaejmKCcjmP0ig2C7FN0ES0/l38j5G5goembyih/N4J4xyRToL1I0USvzR2owVJTtRAlTNmsZytnSrzCW7LMCyGujaYZ4waIhDEBsM0kR1WoemBhF8FnWFLldzbtw4F5iPPv1lFTvPZsckxYNp+E23T/GCMkNZ6hKl+vW4/XvgIOMiorD1/zVeaBglF8OmbauV1vV6V3hIdpgb66c2ICDERDnQNTFj4smKfnBbMJQMLmGy9rHz8Dr30CGCKuG3gE4Ff7A8t+VCxowsQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8579.namprd02.prod.outlook.com (2603:10b6:a03:3f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sat, 5 Jul
 2025 03:51:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 03:51:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Thread-Index: AQHb5qqGWI9T0Ene10yNxUr1s0p/CbQi5NWg
Date: Sat, 5 Jul 2025 03:51:48 +0000
Message-ID:
 <SN6PR02MB41571145B5ECA505CDA6BD90D44DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
In-Reply-To:
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8579:EE_
x-ms-office365-filtering-correlation-id: 5cf96319-8213-4a8e-2789-08ddbb7744cb
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKwiAlKx4YLPXQ2fmtO5dl6z1CaCf98YcYwjs4rlNJncG1iV82cG9OrU6ckM36+UPgK6rxKbsXlz/4KWYYfQ7OluGkNctJsnG+by3b3Pjxl8BWTfKux7rfChmpurMcdvZsWzjNfTNEqHIGqLT8MEl8byi8Rxqj9Nb47KRs6s5U8k/UN3BRXNCh2fcNOdQVtsTHCvz/HXrchjF5TZu6M4tfvUk9YMC6To9/3zVVeNA1CFQrpmo1VZ4v3ULY1nA2Y7I6qDeMe5uHsoBJvEy6Fv34is702ItTsoAOqBN5SGl5qsIFEHat3BgJQqV7r6iI6oVVRYgPI3OAS7MsFhCkrq0LIzHdch2vIiusG4Eqc0IYkcYkgp9LIzty+rYVO4YGrRizYywhPtiX0Nwf2fKw8bl2KtggJZ7EQVAtiFNcYuXZW1TYj4wPENCyHnOZq0TvOV1UknnpXF9X7R8KL6CFsLfnZjqHci6DRU/jhK2kttksGbCWcYKjLVo0EkL2PGu03hIESr6uzGwi7Lw8JVsx/CMbNYuBuk4xDO15qwE1PnR4zN5eoRr4e4Q0w45ZwN7R+K9xewjFoOAuYpWnjdA/YT5EpJKBxrw2ldichu5d5DVvyg34cUP8rTmnVcniebldABwgREfDixaNQcHBvxdZP+m5k0Svr5q2kpYJUgTipmw9+7OqSV8hp/vBFg7P0KVR+9owLpAaoSUlE/BV+soOa3V9HgNkDKc08WkwA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|8062599006|8060799009|15080799009|19110799006|102099032|40105399003|3412199025|440099028|12091999003|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?3Y/H5C3cILGr+lVmaJgB1Rcqeg++hFNr2w6O9/QxnBXIHUEpf8mdRECFNU?=
 =?iso-8859-2?Q?WnyMLRsvpf2ZfEDYpDE/MloXrYi4Mu2qk1YivZQaKBmeYEGm6/kRWLk8Pi?=
 =?iso-8859-2?Q?RFvsRPBRBL69cZbstYNASSt4qPWC+ZOUVZOoSyAYUDAiK2+CpWeDPUxkp7?=
 =?iso-8859-2?Q?o6hB+aWOhXOmv1+35rEfoygzRj2SWwvc3UzQdZqk0OdTiBx0I/R+JaBfFq?=
 =?iso-8859-2?Q?LGDkkqw9FRkwfWwDi9lU8gYBK40yxRqrRRlJZXMTY4Kj6PJfRNWjUC1/Tv?=
 =?iso-8859-2?Q?s6xKTpO6tugTbEILfjHw9QfwGQR/7NbjL48UqbyxQjtkwf5BMS/f2MMC4T?=
 =?iso-8859-2?Q?pG/YHkhHXzyPg9mU9axJ4LES4n0EmrXhiSHG3/9NjdAAaZNpRrxyJzI2x2?=
 =?iso-8859-2?Q?KXdTICASROD0F/Lc8NEzpW9xRGoZtmz2j4lB8QPUtfr9qpsACgoJZT5sNS?=
 =?iso-8859-2?Q?GRY5CHShCcVQ0bI529+sW8/KNwzUK/x703ZM/ruxvRRJiJtty/X0ojG1mZ?=
 =?iso-8859-2?Q?shjwTBnc9cxJ3145J+2Yd1wuDvdNO4vXRrXa+kFHmCrXmipf3Zb69y61Z4?=
 =?iso-8859-2?Q?xa4zLpSGk+4/Y4yYppODv80wjb7xfSDLIMslU9omTJoBSXeSxdfdXckapv?=
 =?iso-8859-2?Q?wIzTpVLuy9FT7o0oD4bzaqMLDxdARZtds1S+EfgBj43bx3ft4gJZv4xq0h?=
 =?iso-8859-2?Q?icAsyGK2o0TDYYu3J+MsgWELSpbbfUKzZkjS3HZ4pumDBKNmyA1rm4G0wL?=
 =?iso-8859-2?Q?9ApfoGnimTcpDxa3FaIqnoOG40uMi983X9YM+jlV/I2UFo6MOgj6IsFupz?=
 =?iso-8859-2?Q?d5+lCt0eNQd3dV5DTrvyk5sZQESM1GaWDdZa3tTW+h8L7W0XyLBV+02rQQ?=
 =?iso-8859-2?Q?QZGuwbtxGZSpf7P4OVpNJzhmAX2q6Wn7ddoCUsUZ+sg2mhhvjT8cHN5VSA?=
 =?iso-8859-2?Q?jNdOgRqLXDi2RqxigYcdeh4XCO7rhrTMxzArVENYnuDyIHA1dtP2lstswW?=
 =?iso-8859-2?Q?O8cLWl6PyRoHtns2gWEjpmZIKfDem1leg5sIuYdNf+lRkeAjusDFqqTk7y?=
 =?iso-8859-2?Q?GRHm/HqgOgVJQdbVpeN/o4pm4KCT9FA2w2k0i1GaunMecVnGB2Md6OC4KV?=
 =?iso-8859-2?Q?frRQdSxbUwaH86esHZWZ6+msYdAcZn6+pMXJ2vySi572YHki6ZnYRUFk3k?=
 =?iso-8859-2?Q?S0UfkrOztbWR4oxT9lKLk2sQjghP1I1A8isgAD/fn955VBqPe/dY4XWKaA?=
 =?iso-8859-2?Q?oM1Sh7/mHNd7YwyOUUhA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ZbhAlz7IH3jFq489xEMlKY5T58MZt/LLFXkLNrRTs/d/+ODBjIh3/E2cCa?=
 =?iso-8859-2?Q?QyKztG+24B+TXhV9hCFQkZ7/D4EntTvQ/PvFOMPG2fj2T3kDFyfMo8yE7Q?=
 =?iso-8859-2?Q?Gc26UMaoJckZfiz5NDsfUO8+v4+ky3WWon+ronZoiSIT1h3sWYeueA7Kqo?=
 =?iso-8859-2?Q?59RUV0OM8JJafIoDAbaaANqHRon1NMT63xgm2OKnj630sF1144l3K0ztSo?=
 =?iso-8859-2?Q?JRj9cKG2Hvr5p5ugVFsLJVAOtHQRPCoK5W9FjIWbyn2DNgm8KFQBS1OdV6?=
 =?iso-8859-2?Q?PuR63DkYY2DEijENEjR9ntFGfSGBSuIDnmg6f+XVfFie1I39KiO+/wrH59?=
 =?iso-8859-2?Q?9va4bX6vwD4swRO1a9QZWjfyVCW/+CE8N9jfL54irHOEuZJiXK1PnfXnkA?=
 =?iso-8859-2?Q?YHsL4pgI0u7fLkwUgPr30r4OWipcyxTue/EJLwH+7bu41PMn0QqgCgsbrm?=
 =?iso-8859-2?Q?rs/jm8TntLi2dtTb0vDcL0/hzL7Jx2w2mnSkwmrMYTiU3eCjE703eQT312?=
 =?iso-8859-2?Q?zPHO2xQHSpcn0FIPO/FBYwKi93o1/ymLgyf3STHQO+gts2PFHa6djELQ9k?=
 =?iso-8859-2?Q?Jkn+bFK8vjY4WL+JVpnETmprlxRTIE/yi7Q5nwQCr7mHJHRdbMkVIMpKJw?=
 =?iso-8859-2?Q?rm3mt9zUkRjTppvqpbyERoXE20UQdwtJXgx3xv0P+12Em+UHwdnHB17455?=
 =?iso-8859-2?Q?o1EjiHXrSGh4mT9139pq5LUVoh4iXImYd8flAugBMtb/qySRklOXGHnvG4?=
 =?iso-8859-2?Q?IBm6atACMdOzCkDmm7eDyAGqDtFulbbd2uXaxzArXOg3HPdTHzQLh9g4zs?=
 =?iso-8859-2?Q?jV0g+/2Nuj98TkN+wUpDYBgF6OFXvyXXuFcQfqZ8NnDAGeFQcbjfPITS1d?=
 =?iso-8859-2?Q?hwGorn/nFFqYBI5qYvHjbnExuexTpgrz/Xw8bRVU5brNl/9zWEpz/QlZZv?=
 =?iso-8859-2?Q?n+1HKneHjRhNs+0tQDzFOMfXaT82vkQM/NvlTaqSCqDQZjvloVajq8ufx0?=
 =?iso-8859-2?Q?sYJsMrLiwXl8nVQyh/zUMCPErM18QNiLf1TPeXU+KceL0lDErenwuCANzq?=
 =?iso-8859-2?Q?E8snqZ//6Ky4uYrF/rXPAFegw9Up6rpLNoeIQ6cB7JaobYVhWNSuf0agzs?=
 =?iso-8859-2?Q?oZ4VTH9AqfWSY0wR3yeCOiQCMI6VCm6i6HV5swmC250vGipKB7420L5QvS?=
 =?iso-8859-2?Q?59xUslGFg0PfF5wkdQfyIttvs8cNoNYi+o6ubt/kDRVkKxlN7KAaaie1fI?=
 =?iso-8859-2?Q?rmtmrb2hC5i+ZhsrgdZF+g9gts7KGExdFeQeeE/JU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf96319-8213-4a8e-2789-08ddbb7744cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2025 03:51:48.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8579

From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
>=20
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().

With the additional tweak to this patch that you supplied separately,
everything in my testing on both x86 and arm64 seems to work OK. So
that's all good.

On arm64, I did notice the following IRQ domain information from
/sys/kernel/debug/irq/domains:

# cat HV-PCI-MSIX-1e03\:00\:00.0-12
name:   HV-PCI-MSIX-1e03:00:00.0-12
 size:   0
 mapped: 7
 flags:  0x00000213
            IRQ_DOMAIN_FLAG_HIERARCHY
            IRQ_DOMAIN_NAME_ALLOCATED
            IRQ_DOMAIN_FLAG_MSI
            IRQ_DOMAIN_FLAG_MSI_DEVICE
 parent: 5D202AA8-1E03-4F0F-A786-390A0D2749E9-3
    name:   5D202AA8-1E03-4F0F-A786-390A0D2749E9-3
     size:   0
     mapped: 7
     flags:  0x00000103
                IRQ_DOMAIN_FLAG_HIERARCHY
                IRQ_DOMAIN_NAME_ALLOCATED
                IRQ_DOMAIN_FLAG_MSI_PARENT
     parent: hv_vpci_arm64
        name:   hv_vpci_arm64
         size:   956
         mapped: 31
         flags:  0x00000003
                    IRQ_DOMAIN_FLAG_HIERARCHY
                    IRQ_DOMAIN_NAME_ALLOCATED
         parent: irqchip@0x00000000ffff0000-1
            name:   irqchip@0x00000000ffff0000-1
             size:   0
             mapped: 47
             flags:  0x00000003
                        IRQ_DOMAIN_FLAG_HIERARCHY
                        IRQ_DOMAIN_NAME_ALLOCATED

The 5D202AA8-1E03-4F0F-A786-390A0D2749E9-3 domain has
IRQ_DOMAIN_FLAG_MSI_PARENT set. But the hv_vpci_arm64
and irqchip@... domains do not.  Is that a problem?  On x86,
the output is this, with IRQ_DOMAIN_FLAG_MSI_PARENT set
in the next level up VECTOR domain:

# cat HV-PCI-MSIX-6b71\:00\:02.0-12
name:   HV-PCI-MSIX-6b71:00:02.0-12
 size:   0
 mapped: 17
 flags:  0x00000213
            IRQ_DOMAIN_FLAG_HIERARCHY
            IRQ_DOMAIN_NAME_ALLOCATED
            IRQ_DOMAIN_FLAG_MSI
            IRQ_DOMAIN_FLAG_MSI_DEVICE
 parent: 8564CB14-6B71-477C-B189-F175118E6FF0-3
    name:   8564CB14-6B71-477C-B189-F175118E6FF0-3
     size:   0
     mapped: 17
     flags:  0x00000103
                IRQ_DOMAIN_FLAG_HIERARCHY
                IRQ_DOMAIN_NAME_ALLOCATED
                IRQ_DOMAIN_FLAG_MSI_PARENT
     parent: VECTOR
        name:   VECTOR
         size:   0
         mapped: 67
         flags:  0x00000103
                    IRQ_DOMAIN_FLAG_HIERARCHY
                    IRQ_DOMAIN_NAME_ALLOCATED
                    IRQ_DOMAIN_FLAG_MSI_PARENT

Finally, I've noted a couple of code review comments below. These
comments may reflect my lack of fully understanding the MSI
IRQ handling, in which case, please set me straight. Thanks,

Michael

>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/pci/Kconfig                 |  1 +
>  drivers/pci/controller/pci-hyperv.c | 98 +++++++++++++++++++++++------
>  2 files changed, 80 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9c0e4aaf4e8cb..9a249c65aedcd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -223,6 +223,7 @@ config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
>  	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
>  	select PCI_HYPERV_INTERFACE
> +	select IRQ_MSI_LIB
>  	help
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ef5d655a0052c..3a24fadddb83b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -44,6 +44,7 @@
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/irq-msi-lib.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> @@ -508,7 +509,6 @@ struct hv_pcibus_device {
>  	struct list_head children;
>  	struct list_head dr_list;
>=20
> -	struct msi_domain_info msi_info;
>  	struct irq_domain *irq_domain;
>=20
>  	struct workqueue_struct *wq;
> @@ -1687,7 +1687,7 @@ static void hv_msi_free(struct irq_domain *domain, =
struct msi_domain_info *info,
>  	struct msi_desc *msi =3D irq_data_get_msi_desc(irq_data);
>=20
>  	pdev =3D msi_desc_to_pci_dev(msi);
> -	hbus =3D info->data;
> +	hbus =3D domain->host_data;
>  	int_desc =3D irq_data_get_irq_chip_data(irq_data);
>  	if (!int_desc)
>  		return;
> @@ -1705,7 +1705,6 @@ static void hv_msi_free(struct irq_domain *domain, =
struct msi_domain_info *info,
>=20
>  static void hv_irq_mask(struct irq_data *data)
>  {
> -	pci_msi_mask_irq(data);
>  	if (data->parent_data->chip->irq_mask)
>  		irq_chip_mask_parent(data);
>  }
> @@ -1716,7 +1715,6 @@ static void hv_irq_unmask(struct irq_data *data)
>=20
>  	if (data->parent_data->chip->irq_unmask)
>  		irq_chip_unmask_parent(data);
> -	pci_msi_unmask_irq(data);
>  }
>=20
>  struct compose_comp_ctxt {
> @@ -2101,6 +2099,44 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta, struct msi_msg *msg)
>  	msg->data =3D 0;
>  }
>=20
> +static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_dom=
ain *domain,
> +				      struct irq_domain *real_parent, struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip =3D info->chip;
> +
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> +		return false;
> +
> +	info->ops->msi_prepare =3D hv_msi_prepare;
> +
> +	chip->irq_set_affinity =3D irq_chip_set_affinity_parent;
> +
> +	if (IS_ENABLED(CONFIG_X86))
> +		chip->flags |=3D IRQCHIP_MOVE_DEFERRED;
> +
> +	return true;
> +}
> +
> +#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
> +				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
> +				    MSI_FLAG_PCI_MSI_MASK_PARENT)
> +#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI	| \
> +				     MSI_FLAG_PCI_MSIX			| \
> +				     MSI_GENERIC_FLAGS_MASK)
> +
> +static const struct msi_parent_ops hv_pcie_msi_parent_ops =3D {
> +	.required_flags		=3D HV_PCIE_MSI_FLAGS_REQUIRED,
> +	.supported_flags	=3D HV_PCIE_MSI_FLAGS_SUPPORTED,
> +	.bus_select_token	=3D DOMAIN_BUS_PCI_MSI,
> +#ifdef CONFIG_X86
> +	.chip_flags		=3D MSI_CHIP_FLAG_SET_ACK,
> +#elif defined(CONFIG_ARM64)
> +	.chip_flags		=3D MSI_CHIP_FLAG_SET_EOI,
> +#endif
> +	.prefix			=3D "HV-",
> +	.init_dev_msi_info	=3D hv_pcie_init_dev_msi_info,
> +};
> +
>  /* HW Interrupt Chip Descriptor */
>  static struct irq_chip hv_msi_irq_chip =3D {
>  	.name			=3D "Hyper-V PCIe MSI",
> @@ -2108,7 +2144,6 @@ static struct irq_chip hv_msi_irq_chip =3D {
>  	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
>  #ifdef CONFIG_X86
>  	.irq_ack		=3D irq_chip_ack_parent,
> -	.flags			=3D IRQCHIP_MOVE_DEFERRED,
>  #elif defined(CONFIG_ARM64)
>  	.irq_eoi		=3D irq_chip_eoi_parent,
>  #endif

Would it work to drop the #ifdef's and always set both .irq_ack
and .irq_eoi on x86 and on ARM64? Is which one gets called
controlled by the child HV-PCI-MSIX- ... domain, based on
the .chip_flags? I'm trying to reduce the #ifdef clutter. I
tested without the #ifdefs on both x86 and arm64, and
everything works, but I know that doesn't prove that it's
OK.

If the #ifdefs can go away, then I'd like to see a tweak to the way
.chip_flags is set. Rather than do an #ifdef inline for struct
msi_parent_ops hv_pcie_msi_parent_ops, add a #define
HV_MSI_CHIP_FLAGS in the existing #ifdef X86 and #ifdef ARM64
sections respectively near the top of this source file, and then
use HV_MSI_CHIP_FLAGS in struct msi_parent_ops
hv_pcie_msi_parent_ops.  As much as is reasonable, I'd like to
not clutter the code with #ifdef X86 #elseif ARM64, but instead
group all the differences under the existing #ifdefs near the top.
There are some places where this isn't practical, but this seems
like a place that is practical.

> @@ -2116,9 +2151,37 @@ static struct irq_chip hv_msi_irq_chip =3D {
>  	.irq_unmask		=3D hv_irq_unmask,
>  };
>=20
> -static struct msi_domain_ops hv_msi_ops =3D {
> -	.msi_prepare	=3D hv_msi_prepare,
> -	.msi_free	=3D hv_msi_free,
> +static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq,=
 unsigned int nr_irqs,
> +			       void *arg)
> +{
> +	/* TODO: move the content of hv_compose_msi_msg() in here */

Could you elaborate on this TODO? Is the idea to loop through all the IRQs =
and
generate the MSI message for each one? What is the advantage to doing it he=
re?
I noticed in Patch 3 of the series, the Aardvark controller has
advk_msi_irq_compose_msi_msg(), but you had not moved it into the domain
allocation path.

Also, is there some point in the time in the future where the "TODO" is lik=
ely to
become a "MUST DO"?

> +	int ret;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(d, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (int i =3D 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(d, virq + i, 0, &hv_msi_irq_chip, NULL, FLOW_HANDL=
ER, NULL,
> +				    FLOW_NAME);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq,=
 unsigned int nr_irqs)
> +{
> +	struct msi_domain_info *info =3D d->host_data;
> +
> +	for (int i =3D 0; i < nr_irqs; i++)
> +		hv_msi_free(d, info, virq + i);
> +
> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops hv_pcie_domain_ops =3D {
> +	.alloc	=3D hv_pcie_domain_alloc,
> +	.free	=3D hv_pcie_domain_free,
>  };
>=20
>  /**
> @@ -2136,17 +2199,14 @@ static struct msi_domain_ops hv_msi_ops =3D {
>   */
>  static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  {
> -	hbus->msi_info.chip =3D &hv_msi_irq_chip;
> -	hbus->msi_info.ops =3D &hv_msi_ops;
> -	hbus->msi_info.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> -		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> -		MSI_FLAG_PCI_MSIX);
> -	hbus->msi_info.handler =3D FLOW_HANDLER;
> -	hbus->msi_info.handler_name =3D FLOW_NAME;
> -	hbus->msi_info.data =3D hbus;
> -	hbus->irq_domain =3D pci_msi_create_irq_domain(hbus->fwnode,
> -						     &hbus->msi_info,
> -						     hv_pci_get_root_domain());
> +	struct irq_domain_info info =3D {
> +		.fwnode		=3D hbus->fwnode,
> +		.ops		=3D &hv_pcie_domain_ops,
> +		.host_data	=3D hbus,
> +		.parent		=3D hv_pci_get_root_domain(),
> +	};
> +
> +	hbus->irq_domain =3D msi_create_parent_irq_domain(&info, &hv_pcie_msi_p=
arent_ops);
>  	if (!hbus->irq_domain) {
>  		dev_err(&hbus->hdev->device,
>  			"Failed to build an MSI IRQ domain\n");
> --
> 2.39.5
>=20


