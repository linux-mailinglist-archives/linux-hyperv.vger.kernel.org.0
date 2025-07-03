Return-Path: <linux-hyperv+bounces-6088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66375AF7F38
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267843A90C8
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72704288C9F;
	Thu,  3 Jul 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="alaFhBs1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2105.outbound.protection.outlook.com [40.92.47.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7C2BEC5C;
	Thu,  3 Jul 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564488; cv=fail; b=eyboA3vdwQXC8rXGY9AxVKFThhEqn8Ec2+QfRWDiIWvqs9NydalPcJ7qLeUr5XoyzOl2aEWqhF26ZTiHGBrNVpg9cZGS2TxcFAkU65LRUSMAhdPT5Acf/At2Q/798muxJ4UkgFn0PWqb5CBIm8y7pDIl08q0Fe6cGBaxsqP+HeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564488; c=relaxed/simple;
	bh=bL8S4UxS7TzaIoK9G1IEPIlc1lz6KGlUQp/UZip9fmM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVq5lwvG58QXZOV30UahykBwxLpMO4B/mJjJblclP5sn28VkINWMcQm1k92UF1mCqoAJJsqRW4QopFhj86o3OfpWwm3znO5FzQ/NsMvKw3CVcIKhzKDET/aTA/4DHy1ZpFUiyp6eLpv2C83Np7ENCgiiPVUSRNBkKT77q6ZGTx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=alaFhBs1; arc=fail smtp.client-ip=40.92.47.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGPCVbFH6ZiceRcrKJW09A02H79EcZ9mjyndzEgCMO9cd5TzDRPRUmRoTok5eWr6bWjzcUQAkGQohv+BSqnV8dv3MhbxSyGH4NPrcIJ0S7wDwLzbdN41Tim/FivOOploRArOZbh4h/l0NRPtLFNBDwMw2PrRuRimNU9784PH0/SnOrEPS9E/kOMmNBQ7yZhmIbHAiAPBzNiqcL9InOMHt4mWJ4AShw7PTq5yIGRwnix5ww5rH3+pR7uswuUu/9h/ztK9d6F/zlCwXxe4MM/9KSf4xAd707X/1s4qyb7IWxaho0F5LE3OiP1rgqLCO5qBnHsUA/lCpx5mC4aXA9IecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAFSTBpM8aaRN1aRNspaAZrjHQIotwTq1huwaSnwso=;
 b=CkFjUY5/NByi/0U8guzlcuyGST2SvDXbL0hdrN5bgArNkvFvsGnnASKYDdAe59/aj/5k580RtBgtZWc05rGhD+BcDpvWsuGbWyQC2K7SWd2AnZdXbM3lg1LV/PhHbo2s1G237KzHUcKNwyvRrbkEwXgzS7VPcXmH7aA2SdZ0uM/b4+snCNqVbROsO/1xRZQo4RUb3Edmwws8FkzeOt6ATBssATM+6GSl2DH9VDu31dLU13CYzXUaCpvJCmv8dLr0LQwuLUAU8T/NOq96VzJhVogEpoLvfGxODKHVp0fAWaJB/Vyab/ClwCuZDS9ukbNkOluXK9xhDvHDktswSxhowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAFSTBpM8aaRN1aRNspaAZrjHQIotwTq1huwaSnwso=;
 b=alaFhBs1BDu/Ojvfg4v4Gd/qqZ2jLccYF9CpF3X0bXKB9EF6BryDPIR6SyqEiBkH3BE43KCW/pBW8j+vGC85WhbReIV6g/D7Vu8BWXBnvPxeyCJuoBFcqD5Ys28Pm9P/Qo1O0ytLzqbjejfa8EeeWo2rc09X2G5NrYGWRVGD0x9Y44snq8BiMqeZrXAfPvLM3AEZ3YTZTAn4z2IYWLHjatk5YgL++2NOqf8CuhTaKL2Ukx4d2pivz3fAHO+vN7KOtVD+k6nqFwySmG5ue0LFdEdmybveQNevhn2e/HAB2n2ffnZTJzKa7BouRAKFkwc4lOCK2cRz7+8c8llTOEh2iw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB10177.namprd02.prod.outlook.com (2603:10b6:806:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 17:41:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 17:41:19 +0000
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
Thread-Index: AQHb5qqGWI9T0Ene10yNxUr1s0p/CbQgsvtA
Date: Thu, 3 Jul 2025 17:41:19 +0000
Message-ID:
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
In-Reply-To:
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB10177:EE_
x-ms-office365-filtering-correlation-id: 1a7b9f80-e47d-4e33-f013-08ddba58d183
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|461199028|41001999006|19110799006|15080799009|31055399003|440099028|53005399003|3412199025|40105399003|19111999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?yVAYVYitFHJhgU8knHDpuxs0gE4/2cnNKt9w6DFAxOG6VaR5isSNaUXlCF?=
 =?iso-8859-2?Q?lQBaqzfAgD0+nx4VuUBXOh4FtEu0dmMaLhprG/hVaFlSFkWI0FUCt0ahkn?=
 =?iso-8859-2?Q?9GvdXSeTWn2FZR+goYSa7TynEXPp74j0uHN8X9ddGs2BonDD9WEMaMg3bA?=
 =?iso-8859-2?Q?2NmQtMwLfgRSdwV/KyU40SYhPNFN9ndpj2SrBJWRaZLXneuZf3ib3kQImZ?=
 =?iso-8859-2?Q?QIbbR6Gsv61FpVjSDzhJ/fmCD2y14h/4r/iukcz9sIAcRYEYqwd2nAWoXs?=
 =?iso-8859-2?Q?wRYVcz2wMzf8sbC9y01mR6UhMck61fQDqbHa16BV1KmVszp7tK4bi4n91s?=
 =?iso-8859-2?Q?pADnY9duYy81T0BWyyWiI8vtZWFCAcrtVU8ouu/2cBgTFTULlqcp0YQNXh?=
 =?iso-8859-2?Q?Zt7D6t9UoEmqGbSL2a9jb54dBU4ONWwUWwo7caH2zUlsXmYCLE/imEqLoM?=
 =?iso-8859-2?Q?d4/Y/Rb3Ad0A62gUxtIGLCaa4Eg3/DLxT892M1WjyD2T1H3d82rPgg8x66?=
 =?iso-8859-2?Q?/htLovYMx6LV23p/JbZ4aW9k27zuf2qQt++ebS42fzVo5xhW1wk6LQoZMM?=
 =?iso-8859-2?Q?+0rRfgUBs+wpHKE0eiYAGIMNAsvjv76HfFF5uW69fVOMj7RieU7bnaFFEc?=
 =?iso-8859-2?Q?PmOttx+krYVVTJae+WwCMxV1Brzq7Q/qUl8xGf58kiQ7F1uw5vVG3CyTN0?=
 =?iso-8859-2?Q?Dwgez2m8U+fiKX0xHMszvjJvgi1hGbc1ZbLXfZNA3Peasp19PmHNkLzNw1?=
 =?iso-8859-2?Q?NKIHuaPhtQSQiVo3eaTel4GDpfx2I3aYDYxbs3x35M6lz0cwuMe7wAg0Ni?=
 =?iso-8859-2?Q?XmiKIL1+uGSi+tkQTY70GPUfv2YZ/XCpOpQIg9Qy14IUeRecE4XFHDnGbe?=
 =?iso-8859-2?Q?7ccdicByrejhQrcaIGOcqYRH0W9upu3a0gpvK8sb+2eUd/caeszAs91TII?=
 =?iso-8859-2?Q?aIB2X4PKS6WZDixtdzeUJR7XaUEbefNtSz1p3R3JhOFxbuwWj2lA1idvb0?=
 =?iso-8859-2?Q?/0hgUhqYAlKRQBzner+5+RFT47+z5+FguoIY7+fPBQmBISQOsaGjNNrlNz?=
 =?iso-8859-2?Q?5cKgfbpNz69f6YUa/ra1XDXdVTenIQSvqNoVEKvZlAIpV0mXkGxt1623bf?=
 =?iso-8859-2?Q?TFbT76NVsrSBiBAjjrUXQtB2kBl90=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Z59M2Z+eP8SHsbWZjgdDZJ4vTSM6uchbZKh9qeD0dtqkqhvuBRiQdSosIQ?=
 =?iso-8859-2?Q?XKTg7FLr4KY4WGh+HzsMDwomc8JbOv1uJd3UdlodF0Q4NN8d6QK3MG3qlb?=
 =?iso-8859-2?Q?0mxhZxN9gyFZ6/fQcE+X8IdLucZ8AL8iL+Udp9BFshbh+uaolQAeVkWVgx?=
 =?iso-8859-2?Q?RiP811I7+cxEz0kEhWMMsA9pHA26KNHSJ81AWBOJHchUvtir5zyj5bqqrO?=
 =?iso-8859-2?Q?m8HRN8hWPtWf7O1gq2eg079LPYq8FBAxwO2QG2+MEJ0zvBIGpVhmJ5cqTD?=
 =?iso-8859-2?Q?UgwL3nIjt1xUhDtjkzODd9KzDxskCxb73bb59zU6iVLkL70mmbjHfgNRjD?=
 =?iso-8859-2?Q?kL4kiyR4sNQJADbQZzrwzoTQ3jTFrKO6VETMJpRMW66/hlkOBAKY3ilxeh?=
 =?iso-8859-2?Q?J4YT70KxTm5onE8DwscZ6Y7Cu9JZbks4R5m3Mhd3F4EaGe9IiIWX56+vwj?=
 =?iso-8859-2?Q?UpSLRf5P6XXREt/koUMRtsNc5QPOj3ZWRQ6uzk7Qen0xS2oPTW/jdxAM7e?=
 =?iso-8859-2?Q?qDC39UVG3QFR23i0sQufNZ0+GSkFbdy4VOX0oWvn+5ynBXnDms57RoFNHr?=
 =?iso-8859-2?Q?rQPqbicI0J6dAjMgqqlSkhSheKLUjMmzcas3hP5wRUBSkGuApjkSOjZZic?=
 =?iso-8859-2?Q?ggV29dVFG96a4lbSCjFXGibVq6GklU27CnBW810rIwlwXYF/9M5UM97Ki1?=
 =?iso-8859-2?Q?lFe/DoQKc2n7HVLEh8CtbmfNsNSTtNn0ob9irStykUB0TW+/Z46IQygrNX?=
 =?iso-8859-2?Q?XJZFKT65WxqY+xDWUlQDAJlm/UMhH4lmo3zvIVcUQiE6OvWLkjpIy4tvpk?=
 =?iso-8859-2?Q?XXCPPjC2fE1o+RLG5vLNv4cW2ZZgMiJGLP2KQS0qMo4wqc8XyK7k6N21Qr?=
 =?iso-8859-2?Q?4lqxPOelUeKTy4uHlFtwhWyAjEwiTo2iZwng9/xX1NTXba03wcAgfMEX9N?=
 =?iso-8859-2?Q?gCme2jfUS5I7IPnje+67dr50Se+0lRWXn83d6hzrYT7E1UlXo3tWpwroDj?=
 =?iso-8859-2?Q?meZ7uWeR0PKGuMBj35LwnVFcIrrTf0vlNLhrBJ112A6CnI/hYhISSzQhkd?=
 =?iso-8859-2?Q?WpOlqTT9rLQNmww55LX9rcMXQSB1sYD0QCXIt/PQl3AG5gklmNv+6tbC9H?=
 =?iso-8859-2?Q?cm9uTJvidVAfs6m2Yosz2z4ijePtFA1CsiiZKnz5PEU1J2imjZlDseuT9a?=
 =?iso-8859-2?Q?sU06bN0/1JZELfuNQ7lK+SP++WTikwdQQxjZeD16foY83jhd45NLBNAPSo?=
 =?iso-8859-2?Q?Hy7QVQryY8bVNpD46yFNfxMAvwTFCUUneMbsTCTHM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7b9f80-e47d-4e33-f013-08ddba58d183
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 17:41:19.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB10177

From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
>=20
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().

From a build standpoint, this patch does not apply cleanly to
linux-next20250630. See also an issue below where a needed irq
function isn't exported.

At runtime, I've done basic smoke testing on an x86 VM in the Azure
cloud that has a Mellanox NIC VF and two NVMe devices as PCI devices.
So far everything looks good. But I'm still doing additional testing, and
I want to also test on an ARM64 VM. Please give me another day or two
to be completely satisfied.

Michael Kelley

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
> +#define HV_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS
> 	| \
> +				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
> +				    MSI_FLAG_PCI_MSI_MASK_PARENT)
> +#define HV_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI
> 	| \
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

This code can be built as a module, so irq_domain_free_irqs_top() needs to =
be
exported, which it currently is not.

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


