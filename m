Return-Path: <linux-hyperv+bounces-5882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD5AD63A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 01:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AFA1889B95
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C224DCE7;
	Wed, 11 Jun 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eNjhHKqV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012010.outbound.protection.outlook.com [52.103.14.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97022248F5F;
	Wed, 11 Jun 2025 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683266; cv=fail; b=I5iIkBo5fcAkRFrZIk248SlGI6/H4sW3/vcnZCCm8sLifvb5vpVWFGB9EIRqP0yDU+FM+MZv/AOvx0GqHrOkKZsWRBeSzmD3eUH0ZDebZD1NywPV/Rt6ok7PKapOUc8U8lLPnGU9pyRENeAzjayowMUEDyiZk/1TQL4IK2OlM+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683266; c=relaxed/simple;
	bh=jInEFBS8QB9F9n7zSSqbnkQIH6UdgkX3DmA6LW3+g1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HN4eaI9M6Ua7/5oxr5NPE2S8/aH846A1MUmEuiPTDIFLK0khn6cSBPUlyJpKkbDF6jPQDiaR69TSbpnIeucPAPSKMSKUXaSPMY7IEctkDzkPN1Am2pJF2loG5wDc6nsL2C1EeeQ2djCqH3Q6KOYumrvWbck4XGYjFsI7KocnDP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eNjhHKqV; arc=fail smtp.client-ip=52.103.14.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCAggcBKLyfYOuNeesWzxepky9BMmp6v9le6dGrB+H8mcRvYAdn2JmoOI5z4wOSbQEDnfmZleNJqiCn9T3UvMqH967vOhp623JnvRS6apImrp0JSpY7Lk5PjmFmg8j+9fucbGak7djG+kFyeJXI4s6zvwT1GGgqrdIqu+9Ae6pe8lk8T5y9kzNjTXqbXEk1bQ+aENlwFgr127gAZrQlCJ04La57PpfMIuUZ72yT+PXXMcGGJ8GiS6hMB4WEW6gKGURBbW9/l1TS9CBqCWpUqpIgYA9nnOVxHBDNlm3jjGY/8Aul8jPZBUAN6hJPi6jVg+JrQzxymz2zleUxcSDB5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+hSlwPv+nMXubnDV3WeC8rb5i4ZitEMQi484XkxoBs=;
 b=GVfZj67oUYprduqDZ3c6Q65DMMQkOi+fDK1CCyqkoiQ3sC83gjWjq3mAjmCPPz/Ln4IjMYEloDHAlNaGWW37+fMYxeR6y1PIVhAFuXg3qnlWZvy5YXGxafVrOh3r8kpvH45zUxm5iaty9haF1pj3SOA7P8iHKYoUgcoitbMcNC9U9TIGWMB3+IfVvgDfPlREG6HyFMYzrmf+cbTwMQPx0nHh8evvVX7RPAsjhZmGwvpQnuBvOUgKQkZ+sj8T6zzxdCXit7z0/RqzeLlY8lvul4Y5doIr4TDMOxLzG/nk5svQ68TpNT9PwdJZxEH/vtmRyvbqC3l6Fp/SevtsHWEjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+hSlwPv+nMXubnDV3WeC8rb5i4ZitEMQi484XkxoBs=;
 b=eNjhHKqVsJ1zuz/Y6Lq2OkSbhQtfbgqiC2TAg+aHWnSE+2LD4O7eCP49iJ8PNWelHIVOSTWhk3Iayz9HVm56r7lajDsMLOoTw/15b+CyCdN3rymfTcUpEOj+RTc7pgZSm2oL4DrPC9HX1/QH7o8AYigEvhrGGcgLF3iI+l5IECxuNoOj2WauUTAtY6Ass5kIlqGoNENXus5uPgy3W4+ReWzTFtsDfPhJrJYuT86FKsvx8tv/8tJzNVMCyu5gLNFr+3Ga8zAEN8qPfEeMP6w4y0C22gWgxql8r+7e69fFQ62i5ACj87NPep7EjlkQu2PfEyHU9QcyI9Ze7aikBlM6Bw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8488.namprd02.prod.outlook.com (2603:10b6:510:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 23:07:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 23:07:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 4/4] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Thread-Topic: [PATCH 4/4] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Thread-Index: AQHb2mKviDH/rIOH3Uy8jPuHbgJWT7P+khsA
Date: Wed, 11 Jun 2025 23:07:40 +0000
Message-ID:
 <SN6PR02MB4157BAE54D3BBD4CD8065722D475A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1749599526-19963-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8488:EE_
x-ms-office365-filtering-correlation-id: 52f0c832-c252-449d-e584-08dda93cc3cd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|461199028|8060799009|15080799009|8062599006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ubYfJ/BVU9MvDpghAHcmVO6+EJpgAa7ZMtO3v2OohfRbUKKUtst8nBJsXr3z?=
 =?us-ascii?Q?bUsD0TozcBube5s8ePsNzcw0FanHW0pvl4ZmY5MpBaU4VG0g1VcwQgedO2hQ?=
 =?us-ascii?Q?jE6zMTAd2+h08C+xjkTV6ErA6zBoSgTA6haszA9A69wmbmKyGYsfY2IXstlL?=
 =?us-ascii?Q?aaXs6iAx0Ojm5OSliKgJ/ujCln1PGvq8+PQE5IKDjI4mTb01ec5lqpjIHpo3?=
 =?us-ascii?Q?6Inl1Nr/LTfWFb2UxQDjNWicG5ybsLI0HH9InSoAbKMHQg/4RdRVE41Cyilf?=
 =?us-ascii?Q?6eT+f31iWI7BPHpV62ZJZ3NvsZdzShROCLe5Y0lkAk9p6OWJYthJnz2buFvZ?=
 =?us-ascii?Q?MKIQEpPX0ri8bp+hlc67kLWB2wgomy4AnL7UCHdXjPhsgYlqFLtICRYTUVeJ?=
 =?us-ascii?Q?7/SYu69eqhHuPTU7Qcaw+GphBqVIpinzHgpVJFN5mCy6yX8sctc0NMHmUVwJ?=
 =?us-ascii?Q?eRg+GDFG6vxcM+epvFnYV6lQBlQnDUcFFb7xEtV4BBdljlulc7+HqoR1cZXD?=
 =?us-ascii?Q?xQ35NKaUVV6UsbM0T01nM+W2ci6vbnV8ezjaM/vfNX8WZVrgzqMLI08PupOA?=
 =?us-ascii?Q?xEjNSaoNJ1DnIReDIiqiasfTPsuulgNeahaUkK9hM9Yak2oA2q+qpIhtYSn7?=
 =?us-ascii?Q?9FBu2CQO1T58W1iNU/GZaVuOCR09NpVenqcnilCLscFqkZxeRaLwEjeTVvrt?=
 =?us-ascii?Q?4Z+vBHKzQvTfWDLOd9j2JKe/yPhPxiIU7OgnrLxUmYuv8YVpkO3OAiLBgAOf?=
 =?us-ascii?Q?9r7Yme8UzhYxdmS0ZC9XpjIrwIJoKo1PiKvdgiAbEMVqZhYV5d/w0bhlV3Y2?=
 =?us-ascii?Q?GAxjZlWayXEd7O3riKpbAUj9NLJj12HdOSJoZuS84SgeIWKtoQWtzp2+s+C4?=
 =?us-ascii?Q?Pvt26Fb+hM4xBUMwAY3xJ6HuMR+EOupc2WlX5biAeBe7k/881HCtoL0ekS+C?=
 =?us-ascii?Q?k7p6NCbfiZt/6Jgp7vZcfbkRgf6JquukrvGnym+N8n6hwDpeGgzXtwr2zQob?=
 =?us-ascii?Q?Nz/qAfX2rIvVt45o1X9KqFQSEpV2vddV57sc/rvGkvDQUB+iNWlDoG+ruFx4?=
 =?us-ascii?Q?nCEmc9bASYLANVhEdN47S7xwGAELtw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4TScLCB7kC1/3Xi8rQ2aA3zIe7e5ottFfPzr3Subr6PBXL9FjwrRV/UpLaJh?=
 =?us-ascii?Q?/JQS6TxWgWtQA0zkOKWAHppEiscaPaZ7PgYe8TzAI3H0e0FsvndXKFU/zEQk?=
 =?us-ascii?Q?8AtSLm7QfFcv6P16pPq2wrdNHWMXHZ675QSNGoYRVAkjLVwfypbLAQGMAgw7?=
 =?us-ascii?Q?hcyKrT385cAM8KFj5jJ56DgAkFgZYw+65qaB7USR/OMSJG/nrhRh0Qp6jyUE?=
 =?us-ascii?Q?7ZRpBZv99pujp/brjSqcJCGU4Gy1EJC1dhpsOD3gR3Sh9xWVoPdKn5U0M8I4?=
 =?us-ascii?Q?AytjujNgxg9f0ZGPAzeMshgtsbKUJen07p5DKOlOFyJqboroPNAIjvJ3TgZb?=
 =?us-ascii?Q?mT6UcWhyOtbpGtK/kU2K9sJxeiQEBJt8WwlAK3ftr0dEAAbjNW3ueG+Ec1Tp?=
 =?us-ascii?Q?sa3+z1XVURIS2QYglPvkjj9aJy9OX2ExX0NEUQy/vhjH3SBdIi9cT7IxHHHi?=
 =?us-ascii?Q?NWXKBsQZlzQ7CAtnzdHvukk9D1nCskyqbeIYqu34pL3d1gIlYguilyGMfBxf?=
 =?us-ascii?Q?lq5RFv2FeeDdct+QDOfoMB2Zkjyiz/zaE9eh0CK3D4I4500mEexJFsqopODz?=
 =?us-ascii?Q?etNL/eQuFF0YvU6G9VnlLueyCE2Cdi289cOvjVXHjf+bz0rWdTHDZkt/pQwY?=
 =?us-ascii?Q?NhkT71x6HinBi3v09MWWcY91eQq5dAxtXmlpy38RYBegvQfkpFaA60xskghp?=
 =?us-ascii?Q?vSDfSh6Dy9jExnwCuJhNeZBs/ou1rvTlA6X+eiyoiZ3YaJCXCpxtuWuOz+4+?=
 =?us-ascii?Q?K2yd7JgScfo+LrsvWzzZAQRVyeEtYfCGUiqMJ8r4P3yptJrNJK0jQFqTSD7k?=
 =?us-ascii?Q?hbjlgrPcvZ7NKochFjduxNPtz839hISyaPa31oaOMdZGTKf858Z1IIpemqlr?=
 =?us-ascii?Q?MG0OKzvxp5a83qwCE0VoZkVuuzwjWLouA6Neo/G5iDyuAdpkHMKRyQawCuhm?=
 =?us-ascii?Q?ZCKopRYnww2lPFEdO+8PvmytQbHpVkZdG9yHdANFXysbkMBaILeTwBqZXvy4?=
 =?us-ascii?Q?gRn267jfOzYfKpDwC7assfv40B5HhjKX8WL/zRqGczERb/3Egi5YPokdTF8p?=
 =?us-ascii?Q?wdcaufRyao/gXSVha5IMJn1abU/WJUEYu1AlRV9BSYPHWJw7nFDkDLYVgTTY?=
 =?us-ascii?Q?+7F7UcjeBbYdxGO0GyEtRUn67RZ8RfsidwrVE/KkvFVUUFq+UY1WSqH+aVug?=
 =?us-ascii?Q?ZD4wa0lxaJ8y6ltqmxh8LhAKwfhK212V830O1ifP+gX2mpJMm4I0O3ccg2A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f0c832-c252-449d-e584-08dda93cc3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:07:40.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8488

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June=
 10, 2025 4:52 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> Running as nested root on MSHV imposes a different requirement
> for the pci-hyperv controller.
>=20
> In this setup, the interrupt will first come to the L1 (nested) hyperviso=
r,
> which will deliver it to the appropriate root CPU. Instead of issuing the
> RETARGET hypercall, we should issue the MAP_DEVICE_INTERRUPT
> hypercall to L1 to complete the setup.
>=20
> Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().
>=20
> Co-developed-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 4d25754dfe2f..0f491c802fb9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -600,7 +600,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_=
data *data)
>  #define hv_msi_prepare		pci_msi_prepare
>=20
>  /**
> - * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> + * hv_irq_retarget_interrupt() - "Unmask" the IRQ by setting its current
>   * affinity.
>   * @data:	Describes the IRQ
>   *
> @@ -609,7 +609,7 @@ static unsigned int hv_msi_get_int_vector(struct irq_=
data *data)
>   * is built out of this PCI bus's instance GUID and the function
>   * number of the device.
>   */
> -static void hv_arch_irq_unmask(struct irq_data *data)
> +static void hv_irq_retarget_interrupt(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
>  	struct hv_retarget_device_interrupt *params;
> @@ -714,6 +714,20 @@ static void hv_arch_irq_unmask(struct irq_data *data=
)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>  }
> +
> +static void hv_arch_irq_unmask(struct irq_data *data)
> +{
> +	if (hv_nested && hv_root_partition())

Based on Patch 1 of this series, this driver is not loaded for the root
partition in the non-nested case. So testing hv_nested is redundant.

> +		/*
> +		 * In case of the nested root partition, the nested hypervisor
> +		 * is taking care of interrupt remapping and thus the
> +		 * MAP_DEVICE_INTERRUPT hypercall is required instead of
> +		 * RETARGET_INTERRUPT.
> +		 */
> +		(void)hv_map_msi_interrupt(data, NULL);
> +	else
> +		hv_irq_retarget_interrupt(data);
> +}
>  #elif defined(CONFIG_ARM64)
>  /*
>   * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leavi=
ng a bit
> --
> 2.34.1


