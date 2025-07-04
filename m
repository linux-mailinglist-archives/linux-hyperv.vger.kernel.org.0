Return-Path: <linux-hyperv+bounces-6102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE7AF8594
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 04:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1517B8616
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 02:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B671DE3BB;
	Fri,  4 Jul 2025 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mVv8QM/E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2069.outbound.protection.outlook.com [40.92.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F31DB924;
	Fri,  4 Jul 2025 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751596027; cv=fail; b=uU51TsHy85rSf+IqI4aBINYny3cYdCmnezlTnuO2bCsJZ43il00eggZ8Sw0nIUjWDbA3vJ4ORjEoiqZdX4DVM6QWYuqEZVAxgb4hQ8QLy7TSa3TmfPKJW93/bf5sZhI7qxZpNxqVmiuDGz2QyKaRPIn/RaOE8chtZP28QTYwrWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751596027; c=relaxed/simple;
	bh=PnSj0CTeLDN78q3mGMjHQ5LpSovbUii36RtZJYBppDc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vbxj1OgDeS6CDxd98/tDp5SYmuCwk6J8QQavExTdVDA4mqxfwy1Jyx6Czz065U6nfl5g7FMK8njyVmnE6ucrZCFxvTZYhkojilndhsRC7VCXkS2G9xzJvt9ptjYlTT4iMK2eXTudhC5ORBhY/CRfWynKAeBYKi1W3PPJm0YGtTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mVv8QM/E; arc=fail smtp.client-ip=40.92.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5Up7riwTdA2EnHrKpYIYufq15OW2fr2FUit8mT4poLoCKr1YkMd/TsqzdrbM25oOuTcyUSD8je4TblQF1Ap4K9e8/P3tEnpiYbjYfqg0MaR6K2+Y3hvacxFb7GcsMWO0VdWTGQ/x6fxLs5XrPBC0lMMrAiezKx3B916qVKVgFft5Te4vmROGEhPaODP6ZgufbJEep0QsI+hY/NfsJt/XoGMpDeN5Zvi9MpDe6QGBy82GW61WWC/jUgHKKG0h8WlgAglBUqCIi5f+jRiKYEFY7CL+vCRZPUrSO5V6zpjPBKZIK+xnf7m5vtDsabJHpdHLuUdD6qejVM2iZjnzYdQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEAchNnHTjfJZz7xmqGKQ14ehV27FmxNPNcExLuDz58=;
 b=qgvOb41I7ifBmtVbBU9MsFbz+P5Pi6Mjh8MYnqWbCw54OtjWkG/wKGbUjL2qb5ot8GzvVHloDUKzxgNspQIkI/9RXYLs0ImD4laHFJbxMTHtEadEJLZMdzAauO0lmKIPlJeDb04bCSRsoq+nV+i8JGdzB9b3IKFzD8Xnw/8UzPJc2SIkIIKQjTv7CzQPJTNNW0dRauHr5v0THEbFO1oEA1XDNLC6guscwXFNNMV028Bujb5nWz/SF6ACWRTkRe8S3/4O32w9CqKtCfmlPkjq7iRcCCKCzmFfPbkZ3ImSU+rKtioNYt8Tigdgu6WN3pkAHFwHnWtxqbrHXcwYsgzQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEAchNnHTjfJZz7xmqGKQ14ehV27FmxNPNcExLuDz58=;
 b=mVv8QM/EavOit/pH/X19SwFU5wU4MJirwhMoheNTFL/wgVFcz6Dd+45+6/IIzjpYJJm4/xITEoXhZ6kxk+r8QwLKykasllJnG2jmwdt+aF3qG/ir0eZKy9AVv8x9M5dT75SLep/IJnZluYPl1PMH85IajRZpaw/6Kx6ovgyGMxrS8WzKiV59eDKQJ4Z0dQjD7YoTf9B2OnBzKL0RqyZQ+f60UrW+Zbgr8HMGbTCryG008MFx26FesDwE7c17XOe0IXnme/O0WaioTpo6qeEAGBG50PPLBMQT2uHRAMi2ZjxTeRpmUrbwK5R5pXF9/ah5qoSg4hZedpbmmxHzn4SuOg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6700.namprd02.prod.outlook.com (2603:10b6:5:218::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 4 Jul
 2025 02:27:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 02:27:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>, Marc
 Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Thread-Index: AQHb5qqGWI9T0Ene10yNxUr1s0p/CbQgsvtAgAAprgCAAAJH0IAAFK4AgABQraA=
Date: Fri, 4 Jul 2025 02:27:01 +0000
Message-ID:
 <SN6PR02MB41573141969F6B3028099C65D442A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyaht595.ffs@tglx>
 <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87zfdlrmvr.ffs@tglx>
In-Reply-To: <87zfdlrmvr.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6700:EE_
x-ms-office365-filtering-correlation-id: 255da9f1-fb15-4ee6-92e9-08ddbaa24272
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|8062599006|19110799006|461199028|3412199025|440099028|4302099013|40105399003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?X/f6hURZNm29sHa1SfUnxxSG8tB6T/1X8f42BRrOrAjHAciaNG/UvKSia9?=
 =?iso-8859-2?Q?tj3PTSmhMZslzPan5VKHZl2qXI/IIJF/fXSIkHVwLuCacQfHiNolG6LVVy?=
 =?iso-8859-2?Q?C5DnpHGJQVnToLEpf+KckwXQ1B2aDQhn1BltfB12u8V40S2YyY5EEWNhYw?=
 =?iso-8859-2?Q?QWgo9bCacOOyen/oh2l0VDTk9/l4Ucv5l/RLGPbBY3z2jf5edIp2+yxanc?=
 =?iso-8859-2?Q?f4M6TSDFh904IV5nwg4wQ2LW9WPyrymWglSjzNRYpFV7FVvHUHBy+zCY8t?=
 =?iso-8859-2?Q?CRlRl6wt+UgnphHi7WJmB4vAzT+UErDqToVlF9QHP3BKaK++7QHjUjNS9U?=
 =?iso-8859-2?Q?z72wJxFvHvRGLIxv4LDl9cPF9LwzbOqY0fX5j8dmqElVq/CjMHyOtXy1is?=
 =?iso-8859-2?Q?dp63mlw7LIyjxbJE83rLE0dQMXzcH2IogEGz1MA2zxM/nAGJq5HWQEwnh9?=
 =?iso-8859-2?Q?gGOuPWVMItlDnUNiG8Ej0XRnbXESNmboMRcmZpXYwQHM2KVthCPMHusNX1?=
 =?iso-8859-2?Q?62NdBfiJZmIWFbxYe8iO/pdI7BX4kp08TiAuo0cqyUZn/zDnrOaMqYIScT?=
 =?iso-8859-2?Q?/K+H4MbW2b8ggmtNZ3jWM+iMzkVHmhEQLeRoZKl+JjHkR1qHaMN5Y6WuVj?=
 =?iso-8859-2?Q?TA9Jjwbn6hVrFSuNtUALYqD2N+FINd7igtCDKS92e/utH0QAJZO5ikXn7y?=
 =?iso-8859-2?Q?OA6k9NcNBPuBJLNqp1BZw15vNKJJTNsogOdexH1GysqEG63bilrE7uCgWz?=
 =?iso-8859-2?Q?F+T6pHtDUg3jP+gSBktCxazpH/P05NuWXPNYTYx2MVqwOsXENZfAg2WUrm?=
 =?iso-8859-2?Q?4jJbN/gwL5auWdSavEVPIF+cOZf04u9OVMe17bj7SkluitaUzt3wvR4BrW?=
 =?iso-8859-2?Q?/nr3goKXI5ZSsJcGEI6lo++QdMMhN6c621KDRmnCc2dBfMzLHMWdluSFQm?=
 =?iso-8859-2?Q?4MPJEqahNDFzqZ5xeD63Lm8jrurkfEGJ+CXTT35Hw9/IJ3rDTJmgqzaTt/?=
 =?iso-8859-2?Q?lqscNpTQr1R8kNHJAazjjsWHOg0CDHwzKRqFkVGwt5b6DB+u4Uid5zO8xv?=
 =?iso-8859-2?Q?PYCDkG4mG3CrIAnLA6fgE3dAZ4kS9oJfV63IlQfqq/caQfloN5m9Gavn0/?=
 =?iso-8859-2?Q?aryOOQHufALq6yxqhzuoPUPafVDOHH0u55YTJA2YlCZ+H37NF0eaC7IKNa?=
 =?iso-8859-2?Q?xpeHTU77VKx3twOsxpesDX9EFVtrCH6GLC3uJx/OI5wdP874SOYpWJzyIv?=
 =?iso-8859-2?Q?Zg0tBFVweLY+9AbqScTkPWZ1bvaKHrSlcHlMv4WS+JRAEARMtnKBgkm1av?=
 =?iso-8859-2?Q?+9sX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?WkNcNhLA6SsJiLTlpwLgF9SAOFKK9MLqcyTB5M4NhhtxnBmJl07YSSk8un?=
 =?iso-8859-2?Q?UVCzv2I6RFID7NeNP5gU4YY2q06F51q6NsK+aTb5XnUtk+2Q4G7rZNwHg4?=
 =?iso-8859-2?Q?Vl96l9S0GMPTaSJS6/62jULhRnIPB7wbvibgAD+hSzXeD0bkze1M/NOMRU?=
 =?iso-8859-2?Q?USLULAk6V1fP8uBHLds1Ord4cjVNNJLjzZ2Yb3tEt2Mc5ud0itCuz3Q0jl?=
 =?iso-8859-2?Q?AzQMXhMl0RfNwGXcNZIWS5EpMt+nqX12O7RLUlAKlpb52LrikeNRsBAxx/?=
 =?iso-8859-2?Q?h/C/5GVP3W5fUA/53RwZIa2VSbP1/vFn5goNKIHYohKmxK+GnI0vLGgOd8?=
 =?iso-8859-2?Q?NjNJNedknuLma1pYGm+h1DrzdQkZBmn5JscCZMsQiT2xmzfJ0YdED+a0Jp?=
 =?iso-8859-2?Q?Ge/uUe4csaxxAbGwFVlv4RuuX7m80FTOZCKlUF/KaxyveH5tobm2IAvuqQ?=
 =?iso-8859-2?Q?Av6P47Bcm3ANinOJnzAHDmb/OEMFHEskVZCUO/tQp+seCUsfqLr4BZj/y6?=
 =?iso-8859-2?Q?ouVSHIpsX6IWKP3+H+GasJyJVKCX/XplT/H9DqvP/ivO5ylp8vj0rNBbw/?=
 =?iso-8859-2?Q?88SXggdaD1xw6yWqMD5g0dl68p8XVOSWNySYN3yb7fr1CtDkb2syIX3jxQ?=
 =?iso-8859-2?Q?hibY4nSc+1loTthTl+r4OtjgP7lPrCC/N4MVphkNsyjAkFBDQp/tD3We2q?=
 =?iso-8859-2?Q?vO8VkIgFV0Rq9eMRvztMj48kPS0pL2dCykv2rs1FWdnmGSCA7oN1tZ9zUp?=
 =?iso-8859-2?Q?AAiO5nwx7BJLub8Lq/KfGfVGZRmo6g23Kdp8ed1aETf5rws/9uKqsuunUx?=
 =?iso-8859-2?Q?U+I2tyUYcj2Cst6rQ+lgYn33b9S62sY1oQ0hKx1H/EjgOgEghnO1Z3+D80?=
 =?iso-8859-2?Q?hpZ6RdgekzJLHhPrc+M208DN1k7SWO2PFx67M8hcuLIm1CtPaWaBiU1UgU?=
 =?iso-8859-2?Q?nCRoVZTyKmAazaEjIVs3nZlj8ZmKuSVFcCNO64pvIreI+LBCC8tU6a94FO?=
 =?iso-8859-2?Q?3+D8UxO/6366/L+waR2XfKfOvK4QgJU7zlIxxlxZjTl8LZiC+IRUwhseeT?=
 =?iso-8859-2?Q?/iTvaBzZ49FmnLUAPnHaZFid7qe8LOFNrkrm7m9o/8MrRYt7bAeKHULP3L?=
 =?iso-8859-2?Q?BDmx3APcrqW7nzW0GlXSLc7f/Sxj8NLX0aokCp5WbrUuqWGCVHLVMjYZuQ?=
 =?iso-8859-2?Q?5iyPRHdRfBzdKK+PI+KzSLiUdqWdkJ30PQewPuurWE4Woif4GT6zBxumOG?=
 =?iso-8859-2?Q?o82LM1CaT0kfTP5M1N3uQDIs80nljfzcL7uoPidHk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 255da9f1-fb15-4ee6-92e9-08ddbaa24272
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 02:27:01.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6700

From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, July 3, 2025 2:2=
2 PM
>=20
> On Thu, Jul 03 2025 at 20:15, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, July 3, 2025=
 1:00 PM
> >> Does it conflict against the PCI tree?
> >
> > There's no conflict in the "next" or "for-linus" tags in
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/
> >
> > The conflict is with Patch 2 of this series:
> >
> > https://lore.kernel.org/linux-hyperv/1749650984-9193-1-git-send-email-s=
hradhagupta@linux.microsoft.com/
> >
> > which is in netdev/net-next.
>=20
> That's a trivial one. There are two ways to handle it:
>=20
>   1) Take it through the PCI tree and provide a conflict resolution for
>      linux-next and later for Linus as reference.
>=20
>   2) Route it through the net-next tree with an updated patch.
>=20
> As there are no further dependencies (aside of the missing export which
> is needed anyway) it's obvious to pick #2 as it creates the least
> headaches. Assumed that the PCI folks have no objections.
>=20
> Michael, as you have resolved the conflict already, can you please
> either take care of it yourself or provide the resolution here as
> reference for Nam?

I haven't resolved the conflict. As a shortcut for testing I just
removed the conflicting patch since it is for a Microsoft custom NIC
("MANA") that's not in the configuration I'm testing with. I'll have to
look more closely to figure out the resolution.

Separately, this patch (the switch to misc_create_parent_irq_domain)
isn't working for Linux VMs on Hyper-V on ARM64. The initial symptom
is that interrupts from the NVMe controller aren't getting handled
and everything hangs. Here's the dmesg output:

[   84.463419] hv_vmbus: registering driver hv_pci
[   84.463875] hv_pci abee639e-0b9d-49b7-9a07-c54ba8cd5734: PCI VMBus probi=
ng: Using version 0x10004
[   84.464518] hv_pci abee639e-0b9d-49b7-9a07-c54ba8cd5734: PCI host bridge=
 to bus 0b9d:00
[   84.464529] pci_bus 0b9d:00: root bus resource [mem 0xfc0000000-0xfc00ff=
fff window]
[   84.464531] pci_bus 0b9d:00: No busn resource found for root bus, will u=
se [bus 00-ff]
[   84.465211] pci 0b9d:00:00.0: [1414:b111] type 00 class 0x010802 PCIe En=
dpoint
[   84.466657] pci 0b9d:00:00.0: BAR 0 [mem 0xfc0000000-0xfc00fffff 64bit]
[   84.481923] pci_bus 0b9d:00: busn_res: [bus 00-ff] end is updated to 00
[   84.481936] pci 0b9d:00:00.0: BAR 0 [mem 0xfc0000000-0xfc00fffff 64bit]:=
 assigned
[   84.482413] nvme nvme0: pci function 0b9d:00:00.0
[   84.482513] nvme 0b9d:00:00.0: enabling device (0000 -> 0002)
[   84.556871] irq 17, desc: 00000000e8529819, depth: 0, count: 0, unhandle=
d: 0
[   84.556883] ->handle_irq():  0000000062fa78bc, handle_bad_irq+0x0/0x270
[   84.556892] ->irq_data.chip(): 00000000ba07832f, 0xffff00011469dc30
[   84.556895] ->action(): 0000000069f160b3
[   84.556896] ->action->handler(): 00000000e15d8191, nvme_irq+0x0/0x3e8
[  172.307920] watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [kworker/6=
:1H:195]

Everything looks normal up to the "irq 17" line.  Meanwhile, the device pro=
be path
is waiting with this stack trace, which I suspect is the first Interaction =
with the NVMe
controller:

[<0>] blk_execute_rq+0x1ec/0x348
[<0>] nvme_execute_rq+0x20/0x68
[<0>] __nvme_submit_sync_cmd+0xc8/0x170
[<0>] nvme_identify_ctrl.isra.0+0x90/0xf0
[<0>] nvme_init_identify+0x44/0xee0
[<0>] nvme_init_ctrl_finish+0x84/0x370
[<0>] nvme_probe+0x668/0x7d8
[<0>] local_pci_probe+0x48/0xd0
[<0>] pci_device_probe+0xd0/0x248
[<0>] really_probe+0xd4/0x388
[<0>] __driver_probe_device+0x90/0x1a8
[<0>] driver_probe_device+0x48/0x150
[<0>] __device_attach_driver+0xe0/0x1b8
[<0>] bus_for_each_drv+0x8c/0xf8
[<0>] __device_attach+0x104/0x1e8
[<0>] device_attach+0x1c/0x30
[<0>] pci_bus_add_device+0xe0/0x188
[<0>] pci_bus_add_devices+0x40/0x98
[<0>] hv_pci_probe+0x4b0/0x690 [pci_hyperv]
[<0>] vmbus_probe+0x4c/0xb0 [hv_vmbus]
[<0>] really_probe+0xd4/0x388
[<0>] __driver_probe_device+0x90/0x1a8
[<0>] driver_probe_device+0x48/0x150
[<0>] __driver_attach+0xe8/0x1c8
[<0>] bus_for_each_dev+0x80/0xf0
[<0>] driver_attach+0x2c/0x40
[<0>] bus_add_driver+0x118/0x260
[<0>] driver_register+0x68/0x138
[<0>] __vmbus_driver_register+0x70/0x98 [hv_vmbus]
[<0>] init_hv_pci_drv+0x1b8/0xfff8 [pci_hyperv]
[<0>] do_one_initcall+0x4c/0x2c8
[<0>] do_init_module+0x60/0x280
[<0>] load_module+0x2318/0x2448
[<0>] init_module_from_file+0x94/0xe0
[<0>] __arm64_sys_finit_module+0x228/0x3e8
[<0>] invoke_syscall+0x6c/0xf8
[<0>] el0_svc_common.constprop.0+0xc8/0xf0
[<0>] do_el0_svc+0x24/0x38
[<0>] el0_svc+0x40/0x1a0
[<0>] el0t_64_sync_handler+0xd0/0xe8
[<0>] el0t_64_sync+0x1b0/0x1b8

I'll try to figure out what's going wrong.

Michael

