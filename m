Return-Path: <linux-hyperv+bounces-6120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0FAFAA0F
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 05:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3AD7A61A9
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 03:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C6722655B;
	Mon,  7 Jul 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mltz3/lX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2058.outbound.protection.outlook.com [40.92.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E2219EB;
	Mon,  7 Jul 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858062; cv=fail; b=o9KSxOrgyaN/q4Td1OQU0PDwg4pxmqqu9rtKg/sNDkxzhVR7R4sAHIiY7QNmcg98nDNJlM2LtfSgmK4zx9en1502ZZVMZruZrqkbvGHPtL2k5QCKMLQth5T1PEtNdOkpcA3/M+UdTFeWX1DqGCk/2sfsAqB0Um4JOJPGiKgh4n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858062; c=relaxed/simple;
	bh=ECa9Yi8Zx7V0JGvbR/fVe0aN4NpHull4Dsr4WQ4g2g0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5R2XcugQXU6hI7/sVxbL6Fk6W/Lj/JwMx+FNWU4HZMJrvEc+vF9eCqSuEXLvR+9XmxTUdPSEn3+g8TedV92C3TXOnmB7odX4lg7OZOLDgjBXRfhFrf/6LhEcsmYDFqjrc7mdKxN8DNbypDHolKrGy2nQaDaYxfEyx7jQi3QFvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mltz3/lX; arc=fail smtp.client-ip=40.92.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFwmKXr6DDmBD3WlljTx4paLounRqz6pFRpPLe/4U/5sURw7l/9GpkjMn6Zjnd5WKPYu5XXWb9b0qVGUxBg+LpHYHxvskFcVfjtRpZzIMmHEru6SK0RBTotH/VG/aMSfDmMOMADkarN5GZJqfGuO4t8G1z3FHcm5ipvfSNNMMn0y9+VrjjL5/dNk8/9y2GH7FCpCVFU+3mvRBVvdwDY8LfjPxcU+MNVj5dAQd4TMXXv7uklsC/ecuBtua2XVVFhigq8T3R3ogB5zMOQaj1pyl+1vJ6IuJtb2fXtBywpTraSsynP+rINeJjNyTlQRqdIreDOhxsmpqDn0txgJgCjE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOEpC/7Kwr6mW12MaFKqzClwMAld4ASpuID5Z3E5BEw=;
 b=wKq6PPp/dn5AiIft2PU0wG5uNDLuAaP6YN8kAzpBqE3lY9yWMu3M546zZ6kcbI2DL//aqKfHPBoiD6gDtUaGNIRwelwlX+zybMoSRskRIf22/yXTbXXe7dPE0kDDa8DbuV12TRr9RajfD81/O8tIIcgyOwNc0pnHH49mCAauwod84Ln4C36xG2QOvPoiBqgFqv2qJiQvwKI5OcADSJBX6I/RbvUCIGGOSFlr/9vkuct4uR86NqwUkWEqoFYuegnVjwyWCjtrqfwWSe3GOuw4HRPpsiI0Pjs65tj2kVjZifcxUmV5eL5QhZjy+Xx65t0b34I2wZUm4PWJSbpmZJP5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOEpC/7Kwr6mW12MaFKqzClwMAld4ASpuID5Z3E5BEw=;
 b=mltz3/lX4De3KVlIDwsYCa05P7vw406kr5U3c/4Pj+CXfuO9KplKlIeVMRNTWDTU/TTyT+D6Zfz67rbpWESKWpiM6A5Ht8fZ7lFGGTla2Y/1SxuxfzMAmtOhToqN8bxQnRr/E6d9JyXqqrFt1YUt2ydS/x2GXGJOS2QPkIUSzlJPrISM4X0fz6woGViz2fSyE1rvvmQc7b5sh57lA1vQ9OBcymj1dICxAM8N2pab6GwrFGp5HVsCB8wmdUUF40L/BuEJoA0MGC/OE8QEyTzov/yXABEwB1f1Gd/Cx8rYU5CH5WcXvW+7+zZOekN4CASyH2HketYudh9RbP2rCFyW1g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8543.namprd02.prod.outlook.com (2603:10b6:806:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 03:14:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 03:14:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [PATCH v2 5/6] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Topic: [PATCH v2 5/6] x86: hyperv: Expose hv_map_msi_interrupt function
Thread-Index: AQHb7GwZjIWk0jsfE0GXm/clYwUqsbQkGppA
Date: Mon, 7 Jul 2025 03:14:16 +0000
Message-ID:
 <SN6PR02MB4157AAF735DD432EED00C945D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-6-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1751582677-30930-6-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8543:EE_
x-ms-office365-filtering-correlation-id: 2e8fc401-d855-4272-30cd-08ddbd045b69
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|41001999006|19110799006|15080799009|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ssV7BAC1QDPhwC2zIAUxgm0UOp89+Y/mR1rxfXXXU7oQqTAvVZAALTBRv7CX?=
 =?us-ascii?Q?7dW3RyVDDPmyJttPjSXJQErcvZFqS3vfGhvs+dAFcWSU4yRqTx3nCckcCPCf?=
 =?us-ascii?Q?3Zl0NFmvSKdmff/NixDLTqiZPQsjO/8URl1U35dcnn/znjxTUlaf/JS9qT0z?=
 =?us-ascii?Q?WnYJ1l2ioOwKkrdVP7vZvK5TUmNgHsxbrg1DbuBM94AlpWy1fOa34VghjxYy?=
 =?us-ascii?Q?Gp4+lp1CvVlH8m2MbkBwMvjLmbCRHfpmj3PI+xcBZ0eeJxqYHAgDkmh+kKJA?=
 =?us-ascii?Q?952WkgfOjy5O4efZtMRNc1i6CtQYeU3UNxD7Yh9rLywDLRGme2Z5+bjxjMeK?=
 =?us-ascii?Q?zisTWrafLawdn1WNAztt73+b8WxpkcwSbQNAc6YqMA85PyvpGCyRM0EtxOcZ?=
 =?us-ascii?Q?FjoQXx3u7vZ+M8bKtuSTX0H7BzBixhvsiRCvVKL1fm7adHyoOaWpZuF9h0mz?=
 =?us-ascii?Q?zLaCTfvs7EMyLWztFdKu8PQUMX3F+HO9gFDmm0DD0UmAqi+SPPmDw20ggTyP?=
 =?us-ascii?Q?+SZzLZ9VYNaJEap6BFtsSPLLvzDD67XjwsJRqL5Rlmf/molpHI936T+Jy58K?=
 =?us-ascii?Q?sVSHwmPWwdNqJIeplY5xjQ/RQ2NpibwJEuvDYfdnSQKgbXC4y1ZHb5bcYxmv?=
 =?us-ascii?Q?t/i02IH4Hbbemt3Wr3uT+mikCHD/fPfeEhhTUNycMaM0nXsV2o2a8NAGp5ZK?=
 =?us-ascii?Q?0j8buFzoUvNczVgca6QGUgsSTgOy1Mui/tiZCHH8KC7LDbXPqGYZJLFcMhAY?=
 =?us-ascii?Q?dZ+CRk2luR9YBKkoHqlxpWlclAYLop7wENUB60XiXGzpqe+vjgwIn44js25u?=
 =?us-ascii?Q?vE/sMReQ0jhVNaAocaeUy514OLf8IMVN6qHN2g/Tt0zJiraq3sr9U9JUNoty?=
 =?us-ascii?Q?anrtxDFnhXXg4pN4Y/uTWB9+Vt0lcXc+ERBFv+wOUre87iSJWiQEhhzP9wNf?=
 =?us-ascii?Q?LboOomjf0DFM0QwfFTBbcfk0siRY5BdngBl37+3n2s6Z3TTEpJm+pIfvsK09?=
 =?us-ascii?Q?Z133bBb51BECIpSQLEl39lLnT2ubDu0s9uTX5CrHRz3RWJ0flss0cBU1PxiP?=
 =?us-ascii?Q?clAbLU8iOO/vXGfqlLvyqbqd+KJPoyxYbpjg4ynLxcqCOtBXnNx+gSR5jd4F?=
 =?us-ascii?Q?rmFd4cyC14/paMo7q8KPJN1whu2zR4zjvg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FXQwAlMPHbB984gh/GT/c2hgoscpckbHcYVxakOVjOA8AxutRsPDW6c9NqfF?=
 =?us-ascii?Q?MpuYmdNMFETn5kXngzH/F9AUU3jKsk5LYC4qitAV0LGBW/0nQmynplzCyYYD?=
 =?us-ascii?Q?eLQeNjQ4nUgtwaQg+qR0vSZM05KmfO9Sazh84s29WnACEc7wW4zzqB35HSXf?=
 =?us-ascii?Q?eWhMldVWdDNI7Wpbf72Uu/YgdBZK80uMRGAGpeXfNf2hLwp3kagfSnVohBwL?=
 =?us-ascii?Q?jjMyc9YyaXC5Z9ANqtZtKfEqOqMQxnyl765uk8DYypcMOjjisKV6HkmfyJyQ?=
 =?us-ascii?Q?x1awFvQFX9uPcDwKqpfm8C2BUi+nurdnslmOk+xT7Gj2M/nl4rWzpU7IV5Vl?=
 =?us-ascii?Q?QyObzYkoGyMk38UtOW46y/LrSFoKb+KS9PLy7JN8SDIJKfaprbjXNH0iYvH7?=
 =?us-ascii?Q?csU+B7em/r/qoEgDHwcnkrMV00fZBU5BYMZ9RVQpD2Ao1AS0NlQm1n/RK8Wn?=
 =?us-ascii?Q?fBL7t79lJHr0B+nCpy4lBFp/HnbnMG2By/hZBdYvFzoH2W+9U5rbm3fAGzYn?=
 =?us-ascii?Q?/QOIcjEdS11mE6vItdfefjaAqvdLXdyduSmxWk3QqBpdzZXhkbWdMwtQWLIU?=
 =?us-ascii?Q?EuXv4kXL0/2f1oj/ZTqEKlCUPC9hGklUbWAO2GRVclRLR5v1CK/09oVyMJC0?=
 =?us-ascii?Q?aLTaFpwq42fyjOUShQMzVsVeVPN/oRbhZqBHYcmeiP2fjiHSw5df34xubuEd?=
 =?us-ascii?Q?jd23FlNxDMUB/UzZjNDj3ZDSBqzHugdmNSTDK1FLha6Xq0/JVzA/958v00Xl?=
 =?us-ascii?Q?iXy6MyRfVybR6hMtTDS0PcckWGDnL72fWx+Yf8l8HbDPcqUKz+VTi9a68UFN?=
 =?us-ascii?Q?6sTipQ9ArGuIUC/w8u+pBMP3V5u4mnhEb7V0NeI5kUX7ujkhjUvjOa0MTI6w?=
 =?us-ascii?Q?j4ymJGouJB5i+ZLgyeln68AQgY3G7KmL4+pTLJmb67VD1iJ9DllPU+nEHjBL?=
 =?us-ascii?Q?oqRnz0Pjh0Oy4Yu6NC/4MDgft+gfz6iLaxLGpYxxUQtOLmGwZ5A/DSFYG8eo?=
 =?us-ascii?Q?Kt7nvq3pohbNPQt4gD8gCY/MrJZhX5mXCCbt4ofNdL0iYknndSQOPajgcue8?=
 =?us-ascii?Q?w7ivMBJsiaLysolbvl03qGx1JCBhmMTC7tJfqKYgIKOSmDi5U5+h36RncsaU?=
 =?us-ascii?Q?Jf5JVrdTNsNLhoILUKieNtR0m1wcljrjiWiPj0uqDRy62VP/zo3vtNrV25dI?=
 =?us-ascii?Q?o2xoPoRAGFYsTNmky8Z+5U92FwRwK+7Hyp7OAy7Z12MMu/4NNgql8ZcRI1I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8fc401-d855-4272-30cd-08ddbd045b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 03:14:16.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8543

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Jul=
y 3, 2025 3:45 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> This patch moves a part of currently internal logic into the
> hv_map_msi_interrupt function and makes it globally available helper
> function, which will be used to map PCI interrupts in case of root
> partition.

Commit message still has "this patch". See suggested wording
in my comment on v1 of this patch.

>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 38 +++++++++++++++++++++++----------
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  2 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 75b25724b045..eca015563420 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -172,13 +172,32 @@ static union hv_device_id hv_build_pci_dev_id(struc=
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

Also document the return value?  At least to say that success returns 0,
while a failure returns a negative errno.

> + *
> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hyper=
call.
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
> @@ -191,11 +210,11 @@ static inline void entry_to_msi_msg(struct hv_inter=
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
> @@ -205,8 +224,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *d=
ata, struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(data));
> -
>  	if (data->chip_data) {
>  		/*
>  		 * This interrupt is already mapped. Let's unmap first.
> @@ -233,15 +250,14 @@ static void hv_irq_compose_msi_msg(struct irq_data =
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
> index e00a8431ef8e..42ea9c68f8c8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -241,6 +241,8 @@ static inline void hv_apic_init(void) {}
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

