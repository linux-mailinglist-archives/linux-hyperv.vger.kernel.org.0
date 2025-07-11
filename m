Return-Path: <linux-hyperv+bounces-6197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1EB02495
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE143A70E6
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52718DF6E;
	Fri, 11 Jul 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c7F0cRza"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2061.outbound.protection.outlook.com [40.92.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3E1D618E;
	Fri, 11 Jul 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262121; cv=fail; b=NiL4ziceGyPttYQjP2leBOEZ5ALaKHe6c4KxQIBnyecRCF9YOzuiVkJK8TZvXXH6ZVQ8L1F6iU0OUZEy/wnyycKex5ZR+iGbrh8y8XQ7iq1BLcpRCby9C8L0ec7lwD5IdOwrKrDs5yrmjBnfwhGXtqBC9WhSz105ErRWEai08Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262121; c=relaxed/simple;
	bh=VWVFictk24Q2vkKWHWB57z7MUAfTpKnzHPF7lYNEuOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZHs3ZxBzSCAMg52y//CG5Bgf+s4+EP/2Y2utRPcQrvUDiHmOd1uBY4bKzeEP55WlxnmjixqC0/1NlcgXPZuj2kcymXmRNM5Y/IQ5BWG/1bZdzfdWCjlibDuVTdALkzDXu7JCnOUJBaJxAEPLMhc+DJYe2tCiwbMYdU542wCuLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c7F0cRza; arc=fail smtp.client-ip=40.92.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5jXbK0wqvRLA1BUDwfGqhh5Bzh8laER7fW8g57CP6QXd5Oga9dGnM8MEgaRXMCb/UpNHfyehGkIMLnvnLqDTIabRJUfHri0pXcR1cXMoqAv7s2d8024ZmqYBYXatzGOT3aSmok/Hs1SBnbP3pLSiHNxKFnXEkTb/sC2SHycw3k1sxw8LFmwFPDrwcbZt9MK0eX17/ycfUE7dcE0Iyp2YRrQTn1KLF/vX8DJ0j76yEKkbpyZD3UKkzZ36NsSUhVPNKlpi2FiI+HCAyMGZ1KV+ebLggzFKr+SzEhhF2Nl9DMX7XARiJ+S7gWvg3dXbUKclGYGb+BS968O966zl/hiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6eEqxdlS7au+ll4VY587lLQtXZ+4M+vreLOc16BM88=;
 b=OFpxsMp/twvuot/MYTIShlowJP26VbjkcFgkLPshYONIS+vRuAZXFgZUF1/AcmGoc3pXSwiGF7FCgZ9I7d61nMT1Rq1yZGLVVIP95OZj8786e2zF6KwAg8XVdXRWZ7XoSDhLkIFarAl+e0tTp16R3frj+nMpS+1OxDOpP7RJ8VmVJREbNy8WdtEQGN2l1Cw1gJTVeVWRzdgbIKDvTMVFtSqd7EM7csLanSXyUM1VAU0fkVMnWmzPP/X5HpxWtmlC8JCEixtir3EWov1rsVmPvs0PLWborPB4Y7ZwlkFBa9uqIYMjAx29sWRCqLs9571PtwMRqoCClEUXXn83WiRisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6eEqxdlS7au+ll4VY587lLQtXZ+4M+vreLOc16BM88=;
 b=c7F0cRzaeHjxdCjHJEXjYzuzMMQTz0NmXQ+goneSVBWjIg8XzTNy32Sl2I8RrNew0m3G+mrl5vG1ue6bVOX/mup1B3MIpMcE7XuSyTKT1PUkmQVIptsBkX0Fm8dCPzPLjybL7dsVcAEa29BBByi4DYO942V7X8fw6dytzgOl8GKXD4hoGh3yiKculkMk+4VdMGSHHYm9FjhIzjGM2l33P9T+zkMV4EojDUNpsBGl7BpnVL2r0q4QOVpR+IF1RC8OdZlukwRooNaBTP1Xjs7JePXLKbvGAYBJYfURqrypiNcIA8ZgDVHt5w9RpR3n3easXZJgt7NepKdwC13FGHYuPQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8058.namprd02.prod.outlook.com (2603:10b6:610:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 19:28:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 19:28:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 2/3] x86/hyperv: Expose hv_map_msi_interrupt()
Thread-Topic: [PATCH v3 2/3] x86/hyperv: Expose hv_map_msi_interrupt()
Thread-Index: AQHb8pisAH1CleqopUKIWstiRwr8yrQtTfEQ
Date: Fri, 11 Jul 2025 19:28:37 +0000
Message-ID:
 <SN6PR02MB415777CAF9BE041EF070DEBED44BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1752261532-7225-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1752261532-7225-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8058:EE_
x-ms-office365-filtering-correlation-id: 7a312c21-8d10-480d-f80c-08ddc0b1222e
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pxjFI0+tAFX96Xh+grJ7PyVp75hyxv4UR6Rrp/BQ8zonse+8NgUyCHDPcSTS?=
 =?us-ascii?Q?3HV9CdN7mZyzapX02wKqP6SOs5v3ptPSdGjleR9rQtNYGrM1ZUPOCKBerjOE?=
 =?us-ascii?Q?5Da8svyzkZOOtm+9LyAjLOOl/a6TW0AsDOzwAMNOnMlIIZZUyygIvP0hOWbE?=
 =?us-ascii?Q?cH5RwCx6s1hqqzDFSf66SDoHWUSESHMW4f3TNeoMGgHjEk+NF/vtCBMmXr6p?=
 =?us-ascii?Q?8tHpKz3y0kieAEaur8DZEOTbges1gyYgw5FCNLaWHkimnsTzz8SBpjQAAHrB?=
 =?us-ascii?Q?QatPzw0PnO4eG9majT9PK9oS95lZ4k0nfgpfIiCaZ18IGRuAIRSyG/v0VzJ8?=
 =?us-ascii?Q?Tb1wSUC+UYhxTbr2i6vabCOBbOUY9KDWF43sIFLGFEq2hJKeAe9PCy2E2xAz?=
 =?us-ascii?Q?awp8GJJdj1TTPOzKu+206y1dAAFjO+PsLyXc6XCXRmRXNt+lG+AwGbxgAXLy?=
 =?us-ascii?Q?5yPO7Mky8ufJaaKV0cHvy+MF5d8VQbKlQ5PKD/hCLQzHTJpdtoXlXEV74CWb?=
 =?us-ascii?Q?veBbcHovuClrcqSwn9qwLTg1t+evCeTT73k1zUOZNVfsS9ZHdQxMrwQbKRFM?=
 =?us-ascii?Q?E3QF3wL4zowG/4xdkdW90cUNYjh6oYTF+RuHlrpjHGtLOtdEMhsbdn+S8HfV?=
 =?us-ascii?Q?zDJwjZv9fYpLOL5MLDeCeHannFP8bYBfrVmM5Qv8uXpawO5PsFD7POwv/vwz?=
 =?us-ascii?Q?TXd84I7c3gHyj45nK/jjoPkcEAn2j8DIKdUu8gHlnORWfqT7HfSCCu0UKQyi?=
 =?us-ascii?Q?gHzO6YVECg2ebxA3UNQ10OmmeeTeslYw9RcA1W73Yu9iUY4/QsI5QrBNkdG3?=
 =?us-ascii?Q?o4br+panSuTKTMamv9IZ+TqnEejnxgEIWUhM04VmBb0hSMPvR5fWnjwUX0Tx?=
 =?us-ascii?Q?OqEdWK02jp/x/PYiSmhxxF0e7ZkUwtjYdKA5vPhUb4b2VBrPY0F+HCVc+pfU?=
 =?us-ascii?Q?3hkxVDkbgVmA0vJEH+3qbI55WDu+Y/WMD38c5YFPFsfzfsrV31bNRUfUGLeF?=
 =?us-ascii?Q?EP4IYp6sNIE42lCepiHGW/zecsNXPlu0dscau3Dcs7w9ntw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uHybegCGe9jzGxtpjrXRBCdbi5ZGfr8joGuvmalXGvt/vBYF3xUF/B0WrvqP?=
 =?us-ascii?Q?SsbaEpMf5AibPvKYxnnCXL6U72ObdBaNhsdZ3+80b+JmTF8UHCaAcvP+k2Ie?=
 =?us-ascii?Q?StWE+nWqaEgNPlsJccT/KlTStrN5ZpgIBC43HsRpa6wutlIyRmLw9sWFCza0?=
 =?us-ascii?Q?1SMlMbgdvDrBbVJtcY6nikF0LNqaUXBtKUI/4kUCjfx/R4/5gwOT74r9Mr9Q?=
 =?us-ascii?Q?VpekGxEqLWfeQMBC9lwiI4RRQr21bQulkpG66/tFqchnM6qbVaoghs5+2OWB?=
 =?us-ascii?Q?yMgNMLqwPtv97uaym+Y8NAGXfQngU2bYZxMvPrXkRMudgS+7UEBDjHKi6L6m?=
 =?us-ascii?Q?9UmoG9acqLTh8ez6tYcjfpb/HvoTPy/49NT7s8hVh8i6cORYIlZ55aMHy+WC?=
 =?us-ascii?Q?tD1sE9l+RkRir6KjYryq4/0fJCj091OO+s83Et1B8NS/6xixt0xHDnOTNgrE?=
 =?us-ascii?Q?+i2K9JXSIeGmO8Bu0yuKJCafAs+AVGunRy2lRMkfd4Z94vUHyGEbvKDHwgoG?=
 =?us-ascii?Q?vr273iHI1b801erj2tyb8gVPyGU1hBOvaVi7+XWobIvLMyt2Hl60aXFnEEde?=
 =?us-ascii?Q?AdWNhz5z13vV8Dnk1Cn8CHM6A/jM7WYsWQ6Lpj5eDZ9CsbhWuIet/DNq065a?=
 =?us-ascii?Q?AhuqG7Lm0gMP47uhZLA//2CRmFW3hhKzqJUfz0hKCroC5xF/YZWuJ8DDD8JD?=
 =?us-ascii?Q?FgnVXSMUm6IjgeErVzv5drdC0c7u0RRWfJjAsG87CJ1G7BhE9NtQVZG4xJ/O?=
 =?us-ascii?Q?0pLcnsHSR6R+lBOeZJsKm2d0uG0fNP3elMkIgzSNl0XcuGW4LkO3YK0N7Cop?=
 =?us-ascii?Q?0rpayMHZAbO4b8XigfL38xk79/DkAZ0tgNUx88UsvxwYvp9N8BS0lf4SHswp?=
 =?us-ascii?Q?EuuszLcU0ffZ675+ioFtcDCtCX68XelSIVrlv8ZiqvMzxF2/T4vQkRR1Lwq0?=
 =?us-ascii?Q?4jsbou2uWOnYh1I7Gm6yCZfUu3FNbBlbi4A1WwK5WO+j15WmX1RTFnv7r9SD?=
 =?us-ascii?Q?hYG5j7qr7yA+0pnIcHA6eKKoHh3arzSeMn0Ka657fS9GEnGH/tGKCJoBLttw?=
 =?us-ascii?Q?Rngute7/h5IOvYoESxDJICKQWyEyR1RYbGcIqZCm9KEODBwGsuG+fjLRm/sz?=
 =?us-ascii?Q?5lZejdXzvBnQfPCEuHvKHZpjkSyTmM3+hr0bBbqGeaT2qS0Qv0B5dsu7ZcPm?=
 =?us-ascii?Q?jup/aSPtrWarhgTRDsj2hB0l1O9Y7E6kX0ZO4evKycnJ65uVzB8xE3EVp98?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a312c21-8d10-480d-f80c-08ddc0b1222e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 19:28:37.1299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8058

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, July =
11, 2025 12:19 PM
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> Move some of the logic of hv_irq_compose_irq_message() into
> hv_map_msi_interrupt(). Make hv_map_msi_interrupt() a globally-available
> helper function, which will be used to map PCI interrupts when running
> in the root partition.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 40 ++++++++++++++++++++++++---------
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  2 files changed, 31 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index ad4dff48cf14..090f5ac9f492 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -173,13 +173,34 @@ static union hv_device_id hv_build_pci_dev_id(struc=
t pci_dev *dev)
>  	return dev_id;
>  }
>=20
> -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector=
,
> -				struct hv_interrupt_entry *entry)
> +/**
> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
> + * @data:      Describes the IRQ
> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
> + *
> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hyper=
call.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int hv_map_msi_interrupt(struct irq_data *data,
> +			 struct hv_interrupt_entry *out_entry)
>  {
> -	union hv_device_id device_id =3D hv_build_pci_dev_id(dev);
> +	struct irq_cfg *cfg =3D irqd_cfg(data);
> +	struct hv_interrupt_entry dummy;
> +	union hv_device_id device_id;
> +	struct msi_desc *msidesc;
> +	struct pci_dev *dev;
> +	int cpu;
>=20
> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
> +	msidesc =3D irq_data_get_msi_desc(data);
> +	dev =3D msi_desc_to_pci_dev(msidesc);
> +	device_id =3D hv_build_pci_dev_id(dev);
> +	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(data));
> +
> +	return hv_map_interrupt(device_id, false, cpu, cfg->vector,
> +				out_entry ? out_entry : &dummy);
>  }
> +EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
>=20
>  static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, st=
ruct msi_msg *msg)
>  {
> @@ -192,11 +213,11 @@ static inline void entry_to_msi_msg(struct hv_inter=
rupt_entry *entry, struct msi
>  static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interru=
pt_entry *old_entry);
>  static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg=
 *msg)
>  {
> -	struct hv_interrupt_entry out_entry, *stored_entry;
> +	struct hv_interrupt_entry *stored_entry;
>  	struct irq_cfg *cfg =3D irqd_cfg(data);
>  	struct msi_desc *msidesc;
>  	struct pci_dev *dev;
> -	int cpu, ret;
> +	int ret;
>=20
>  	msidesc =3D irq_data_get_msi_desc(data);
>  	dev =3D msi_desc_to_pci_dev(msidesc);
> @@ -206,8 +227,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(data));
> -
>  	if (data->chip_data) {
>  		/*
>  		 * This interrupt is already mapped. Let's unmap first.
> @@ -234,15 +253,14 @@ static void hv_irq_compose_msi_msg(struct irq_data =
*data, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	ret =3D hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
> +	ret =3D hv_map_msi_interrupt(data, stored_entry);
>  	if (ret) {
>  		kfree(stored_entry);
>  		return;
>  	}
>=20
> -	*stored_entry =3D out_entry;
>  	data->chip_data =3D stored_entry;
> -	entry_to_msi_msg(&out_entry, msg);
> +	entry_to_msi_msg(data->chip_data, msg);
>=20
>  	return;
>  }
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index ab097a3a8b75..abc4659f5809 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -242,6 +242,8 @@ static inline void hv_apic_init(void) {}
>=20
>  struct irq_domain *hv_create_pci_msi_domain(void);
>=20
> +int hv_map_msi_interrupt(struct irq_data *data,
> +			 struct hv_interrupt_entry *out_entry);
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vec=
tor,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *=
entry);
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

