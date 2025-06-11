Return-Path: <linux-hyperv+bounces-5881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432E5AD63A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58DE18880A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 23:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F652F4333;
	Wed, 11 Jun 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kuptzlr5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012015.outbound.protection.outlook.com [52.103.14.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20E2F4305;
	Wed, 11 Jun 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683253; cv=fail; b=QBvUnomu6YBwyZJ6/M1EMCxtDcVR7EwlTBV0SRkxKhEms6nNmeer34HwuiygxzX7OpKim+Q55tDVZ9ASw0BgK88/j7qfPTBj7/6d3kYTa9J4Ja7GSjTOCRiYwMmmiH6DBnpm4Vf0gkx5kdIq9r5D5xuAFCLjxFRyJwZ92xkIlu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683253; c=relaxed/simple;
	bh=KrVibL55EUwjSODgtm7xZNpFN+z2VKbPRqYqYMttvkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ijtch6eQAG0Tb1usVQLpBv+P12smkA2c47CT75iVfANPCxd0TkoDTBNSEBJnjQ+CWhjnQS4dC0FKlxzk7Yqt5pVgXyw4vN1Aj3h7nFVShXthfDRUkfZU9q4LtdI7sJEO9POSajKIyvuQq1DK3viw1bevX0k9IV4C1RsFWLC63hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kuptzlr5; arc=fail smtp.client-ip=52.103.14.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOidWUdQ7fKbrItsl7UtMbaXJ63L4884wWLMu+dpCdvZrIHkqu0EtXMgrAxPf8oj5M69Tx/z08YSiqiEi8d0bZHRgN60AmrVPR5IcEBTS+gDEye3hSJI+lve3nEo4s36tlAz1wfbqRzS6znl179+uxKXV9vZjlFUvfz63pMbDxpkMQbamARvDZqjJqqHOqF1TZbAA6DOzH+e3pJPspm3Y2DowHEOnuDOMYwKQsp0SI579fAGvVJBc9qwNsK8fvgsA0rMa10b/dIbwa8grq6VakGhFgCprHt0v+SBDp/Ts9XxNhHTm/4sJ1I41JswVfJ1t6wQLkjDZDPB98kOMVqT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/CnbLLHdSN6H5kR0cXOC+lSBWFo6Qcry67hJvjomvY=;
 b=Ac1C82fF5NVJPFW80CbERYXiWcoyJsx71NKGfBxmUe/0Q8XA4lvNQ/pzhthjNS/AoZwrQLWcxaCCNYfYqe40v4Nuvgawv7UVG0N+SB+HsotOANZruAKcedkzl7SZ3gM6spPGLljoKnREdAmTAZuHanfd56E5Ny/AryrVNVQc817MAM0xPtQXIlM+SbwadmYZVdb217yFTLhoNCKuVnDK8tw0H7YAej0ZnbgUsBNPrit91stqU8WRPpuuP7DCcKjAx2WXubsMgQkYUO29w/EQ7etBOF2Wj52NSc8hgTzdgFFPAjbe0thIWF8Nb5D5yudTkw30hE5byX4APU++nRlR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/CnbLLHdSN6H5kR0cXOC+lSBWFo6Qcry67hJvjomvY=;
 b=kuptzlr50mOloOzAPCaSJxH+P6N8ayTcHhkNzarqSpw1IEWDsC0OPPmrY7L02R9uVX5QnxDWs0fqIs/pUJAaR6yMWoB5IuQKcAtP6u0fLumQGVXSKNHBuFtwYIH3FEE0feMr4hZRbdI+8rD9MC9VpNzof7dvFBQPplg40cFyl1A1eoO7SQUyYG3qWMBL7c3kBY5gp7fo93QrO42hb9dekY+oimVZpRc0InximaFw0MbSt0YCrgvJID8tv9yJqetfiMSwyp32KnynLVRH33qGf++iOBZDj095RNlxbQ4E0djdoBgBpXBA6UC4pxpQ6dEteN6js/Qy09ADfcNq1GbabQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8488.namprd02.prod.outlook.com (2603:10b6:510:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 23:07:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 23:07:28 +0000
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
Subject: RE: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Topic: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Index: AQHb2mKvyYZ7kcH90E2KtA5yDTBR/7P9bWcQ
Date: Wed, 11 Jun 2025 23:07:28 +0000
Message-ID:
 <SN6PR02MB4157639630F8AD2D8FD8F52FD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8488:EE_
x-ms-office365-filtering-correlation-id: 7b5759e7-59bd-4a8c-906c-08dda93cbc8c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|461199028|41001999006|8060799009|15080799009|8062599006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/m3TJALpldQjq29ShbWHrkpfPfSdeT4K7Qfn0XKQuTRBmQAmPermgS6nSTqH?=
 =?us-ascii?Q?c0p8chYRY2IM4O/1dyNa1CqaJMYdsiGb2igUQaSvAJxZl8rlVIq3shbZroq/?=
 =?us-ascii?Q?/dPFEHHjAIJdQmXxlXooVEcZ/6wTsKB/2u0fgp4YER1Ff3Lr5N5WRU6jTZ7l?=
 =?us-ascii?Q?yWrXsM0dghEl+e16S6Fp5KJCNpts2BRQtColt4BFcKrpxzkJY0+zzmVidQhf?=
 =?us-ascii?Q?RQ8z96Y+6d1txq4vbWWwR5FBQr+PUMlZpd46JUI0qeo8gZPgVx4kFekxhk71?=
 =?us-ascii?Q?QhKATBE9TX16cP4nYSwcAIcv+xe0Rfm8J0F46Pk/pN2s0ztM6QRzwgsDApLC?=
 =?us-ascii?Q?Ok6aoE2lLYmGC6MQJTqXLTGUqFpxuOb7Ej2iX13+wP1BcKdZELGijQ/9koyH?=
 =?us-ascii?Q?eDiJM3XM4gA27KBf6yPzQngfLxxCHQFFrnG33pksHlY/RapTWMz2WV3sRnI+?=
 =?us-ascii?Q?K8g5jfcifEX3rPg/6/uWtwbJ9r+hFWLDQ2AzQc3DMKNzhZEJpoR6MOzL7Ztm?=
 =?us-ascii?Q?PGQ6AxCC5IgKsTYpUyNdydHGpR1z+v7nP1cEOabzGxR/DU2J2RPBXrB7TF2W?=
 =?us-ascii?Q?Q2WCuDYBEC3qo9hh6QoL108EMeVyJ/grHMAyHm8ObtP1fFxHLiZJaRNZ64O6?=
 =?us-ascii?Q?YZdCwLa3X4gUWXRdWcXXuPHL6EA+Fd3CgwzNgp/eE/bUOiK6JuPuO/w23NUi?=
 =?us-ascii?Q?LpFDlRqjPnXRh4vqxyvLE/AQ5wXS8U+3Q8119LUdkM7iKs/6BshYUzxSimhh?=
 =?us-ascii?Q?62yN/rnRFXV3ahkiey/nylTMjSJFyWQdtCRbcZwbM0oKGxYMxy1Mstrzc0db?=
 =?us-ascii?Q?3vTkhBZ7QT8uyJF2mtM2FT2ektj4+g6RwpNjZ05uBYllhSFLwyx4SqcTP0H3?=
 =?us-ascii?Q?/kpHWNRj+NFGqmTo02aU4og8VE7rMwE41W4v9NTIgpi9KSXsotkfZ60BiuUU?=
 =?us-ascii?Q?1/OP6SziKd+1DzrGL4dU7wi2xCVsMRcBPBRlpy2yRlO5eWrzBU1hicWXR0lN?=
 =?us-ascii?Q?cXoLsPTyra9Ltqo90LMIYs4bJfRF9qV0m8w6BgzKGljRb8xDvsgl48tZnYTL?=
 =?us-ascii?Q?nt9ptfTs8V21Jgi8fVt0+5Ww627FB8joNQS4/BnjIpaLZwzkVcc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jfBxmzNmQGDguwnzOOrxcxIU9VXCXsYiGuFXV30fv5wnvwNuwou5oSRcIYBl?=
 =?us-ascii?Q?CPhSUtna3zm0BtXwU1bRCKlyRJmt1wWvVqJZ64CnFuFuobXqiwQ657DaDDSG?=
 =?us-ascii?Q?nPgQbM+nSEQdKbbOCqKa8HQZqlBP3dtYBZh36G3hnya7z+77Cp1i5aB0oNKl?=
 =?us-ascii?Q?yKCISNXVwsz8VAfwMj0E0dApNlt7vVCbGdj1H5YrAINL3Zvot3ABrj71ShYP?=
 =?us-ascii?Q?GlwSNiGb7+dXB8JhD5jy/dfCvVFC4zpfnYkG8aPEXvQrguRsjpTb+AHteDkZ?=
 =?us-ascii?Q?V2XSInxD08tqTqxcnuK/DElIQaed7WbToDHjflP9b2/gGqvoWFt52XWzkOIu?=
 =?us-ascii?Q?DS2DPhvFvrOHnsiSFJ+To/OKJx7ql8NtPwvxqlRQJrwuuZdH7+h5dy1BIcdY?=
 =?us-ascii?Q?+zGWJNNutrZ8PwEn20oSeHWHRytIa9UVdkEdGWqLOXmuYkJDQM3M1/BDiO9K?=
 =?us-ascii?Q?nr3acirGWy7S+UGMKrvelNbmSb2TIaJFhm8stv6kFWcs+drSLkHJN3WcNDOX?=
 =?us-ascii?Q?NmSU3HG/YXQjtJqhWX3umBHLyrkxiM4HTtbOQ6GeoV9nE009iKuKD338AgZB?=
 =?us-ascii?Q?/I1q7onNSpZulWQO9pSNYw5M71wn5xzu1+uavkBO2tkBNiXxxNgVhuIj+SyQ?=
 =?us-ascii?Q?UbEL64UcOGAA79S5IY9FnTWDWTTnQm4AwzRks08PSOO6Ed04JZ0SzY+neZ4V?=
 =?us-ascii?Q?r9YEIXhQG+X8KhdLrmWrUzxY++W+WlPIBud9XgEaDc20vNxlgzE8RxFrn99q?=
 =?us-ascii?Q?z7WNvZK1EoL1OH29xXFvjGnir7boMOaf/4Qvu604X8IEPzTXDuiPhIA+6ILP?=
 =?us-ascii?Q?qrsAv2UgAoR78MUkQ/eK3LpYtw/CZv3pMIpvURXckIBvduR+6wZC9W6B02Qb?=
 =?us-ascii?Q?VxJhLw4/Hx5/UaV9bFkWn206RazBAjZEDumI7iBL1AXjpgTbQdCO+FSWC/Zg?=
 =?us-ascii?Q?kj+yhiYp9YvmaFr6yzTI6xNPnNR8YvJ+PU8T5CnYhcR9vR/xHN5+iAB0EK41?=
 =?us-ascii?Q?00jbNBvtKrad25OtKkuJD0KJ2+YE9Bg+54kf27k/onJdiPIkffTEWzY2C2/N?=
 =?us-ascii?Q?onLz2lnnLlD29ELef7pMA5ULTqkJi1g92GPNuYANJh2wcpySNrMFnhjJewdi?=
 =?us-ascii?Q?aEHH5Kw5IpNzOMGDsnxt/imMeNNMs1exy7OZXvL+S0CIwEPRisfWnGVN7C0k?=
 =?us-ascii?Q?g3glnGpmt4dLlnsOC5J3n5temSHFB+4rsZag/CLm2zacU00q9DAqZFI3XJI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5759e7-59bd-4a8c-906c-08dda93cbc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:07:28.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8488

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June=
 10, 2025 4:52 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

The preferred patch Subject prefix is "x86/hyperv:"

>=20
> This patch moves a part of currently internal logic into the
> hv_map_msi_interrupt function and makes it globally available helper
> function, which will be used to map PCI interrupts in case of root
> partition.

Avoid "this patch" in commit messages.  Suggest:

Create a helper function hv_map_msi_interrupt() that contains some
logic that is currently internal to irqdomain.c. Make the helper function
globally available so it can be used to map PCI interrupts when running
in the root partition.

>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 47 ++++++++++++++++++++++++---------
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  2 files changed, 36 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 31f0d29cbc5e..82f3bafb93d6 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -169,13 +169,40 @@ static union hv_device_id hv_build_pci_dev_id(struc=
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
> + */
> +int hv_map_msi_interrupt(struct irq_data *data,
> +			 struct hv_interrupt_entry *out_entry)
>  {
> -	union hv_device_id device_id =3D hv_build_pci_dev_id(dev);
> +	struct msi_desc *msidesc;
> +	struct pci_dev *dev;
> +	union hv_device_id device_id;
> +	struct hv_interrupt_entry dummy;
> +	struct irq_cfg *cfg =3D irqd_cfg(data);
> +	const cpumask_t *affinity;
> +	int cpu;
> +	u64 res;
>=20
> -	return hv_map_interrupt(device_id, false, cpu, vector, entry);
> +	msidesc =3D irq_data_get_msi_desc(data);
> +	dev =3D msi_desc_to_pci_dev(msidesc);
> +	device_id =3D hv_build_pci_dev_id(dev);
> +	affinity =3D irq_data_get_effective_affinity_mask(data);
> +	cpu =3D cpumask_first_and(affinity, cpu_online_mask);

Is the cpus_read_lock held at this point? I'm not sure what the
overall calling sequence looks like. If it is not held, the CPU that
is selected could go offline before hv_map_interrupt() is called.
This computation of the target CPU is the same as in the code
before this patch, but that existing code looks like it has the
same problem.

> +
> +	res =3D hv_map_interrupt(device_id, false, cpu, cfg->vector,
> +			       out_entry ? out_entry : &dummy);
> +	if (!hv_result_success(res))
> +		pr_err("%s: failed to map interrupt: %s",
> +		       __func__, hv_result_to_string(res));

hv_map_interrupt() already outputs a message if the hypercall
fails. Is another message needed here?

> +
> +	return hv_result_to_errno(res);

The error handling is rather messed up. First hv_map_interrupt()
sometimes returns a Linux errno (not negated), and sometimes a
hypercall result. The errno is EINVAL, which has value "22", which is
the same as hypercall result HV_STATUS_ACKNOWLEDGED. And
the hypercall result returned from hv_map_interrupt() is just
the result code, not the full 64-bit status, as hv_map_interrupt()
has already done hv_result(status). Hence the "res" input arg to
hv_result_to_errno() isn't really the correct input. For example,
if the hypercall returns U64_MAX, that won't be caught by
hv_result_to_errno() since the value has been truncated to
32 bits. Fixing all this will require some unscrambling.

>  }
> +EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
>=20
>  static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, st=
ruct msi_msg *msg)
>  {
> @@ -190,10 +217,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *=
data, struct msi_msg *msg)
>  {
>  	struct msi_desc *msidesc;
>  	struct pci_dev *dev;
> -	struct hv_interrupt_entry out_entry, *stored_entry;
> +	struct hv_interrupt_entry *stored_entry;
>  	struct irq_cfg *cfg =3D irqd_cfg(data);
> -	const cpumask_t *affinity;
> -	int cpu;
>  	u64 status;
>=20
>  	msidesc =3D irq_data_get_msi_desc(data);
> @@ -204,9 +229,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	affinity =3D irq_data_get_effective_affinity_mask(data);
> -	cpu =3D cpumask_first_and(affinity, cpu_online_mask);
> -
>  	if (data->chip_data) {
>  		/*
>  		 * This interrupt is already mapped. Let's unmap first.
> @@ -235,15 +257,14 @@ static void hv_irq_compose_msi_msg(struct irq_data =
*data, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	status =3D hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
> +	status =3D hv_map_msi_interrupt(data, stored_entry);
>  	if (status !=3D HV_STATUS_SUCCESS) {

hv_map_msi_interrupt() returns an errno, so testing for HV_STATUS_SUCCESS
is bogus.

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
> index 5ec92e3e2e37..843121465ddd 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -261,6 +261,8 @@ static inline void hv_apic_init(void) {}
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


