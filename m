Return-Path: <linux-hyperv+bounces-3402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264459E6484
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Dec 2024 03:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92C216A447
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Dec 2024 02:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3E91553A7;
	Fri,  6 Dec 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pW6fyLbW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2034.outbound.protection.outlook.com [40.92.20.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9B140360;
	Fri,  6 Dec 2024 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453911; cv=fail; b=Z1bRZmjWhBkF91d535Of1K/B6ooM4QQzOsdDRZiSlbZZKCHrlnDG/SgfjEgoenhlSSBPs8QHo4w5puW/Xqspm2YcKxzjceApdz+nMRrlAtKLsC6ODuFzWbR58KF730ZjRdyNTiNf+k1R3EhH0rc6cqpgg8faJczGB08NdpCuve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453911; c=relaxed/simple;
	bh=lvHY/UG8kXWW2HYS3Q+eK02KLYzUJ1MasG7Y1G92okY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jC223dzgOdF1Lz7kGSmy2InX/JSowcKqIWAd7zfF4CLxJG8FgFlfCqdeooSdPUOqA/y3ODbBQJrvjga48q2FUz2ImV6UFj5A+qn1g6vFlVm7e3BLaVXy9WTw7qv3pyxZmDMP0wXLrg055wKBi8Mmv67MEerqaJA/rZoqv+ZwPQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pW6fyLbW; arc=fail smtp.client-ip=40.92.20.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANoWApbAV8TvYYo7qipaszeba8xG5qhg2Q35+w/xn/ZorXzl65Z7umZWQ/YJQTx+8yLw0TSjJdt/RwzooJTDa3SG2uW1anz21oacis8dJrI/CulWra4yXeALo8HkpclrOQTCSFBbkIp5FoJtJDsIOOyKE4m/mH6N5JwD37GynUFa8Q0O2dUfAUu865mxHVGub2Nbmr1vIMldJw1rQds5pGyfrswGUmu/3BH4LOnDGTbVdGxrTesDxKILnyiivk3ZsUdwJ+Kn+WeBP/GDWprCcX8c3tBHKeJLt0PZdEcrfyDSEaAw7mCbjWAzgg364/TqIgixpvOk9F9dZZe/IwDXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG0vYjJufnnEu7cfXbWryNdU09eiFepI7hvNqXZJ9/k=;
 b=pgMm2BPJ0/Ku5sR2gzr+rIWkEkDiD81OkHb0Fa3Uf2kaBtXe25JYTfR8LVJr0WMpzMTc8ZwjrIrxcWnlBoFXTgscq7S2r5tF0OPyjVpCmO5PcIhRUSjQaRItold5MoLKv9ppuNDpMk8XmdW1gybICtThSyuAQKu+yQoVFVChkk3df59oeXA7dEYwsynFeRX2rvjTVZ7+O7ZY20fAXe1csXdgdbXZOQpVYwDB1Rk3w+L//izbbUk3ekU4bCjzUGqIM5jwty3p42OUhTkmyOBcyLdkGPIhdUAUr2220Vk9KevMNMfvRboK0w6d3BN0RVVPO1LCtOfWI5IjXDIhq/M48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG0vYjJufnnEu7cfXbWryNdU09eiFepI7hvNqXZJ9/k=;
 b=pW6fyLbWoPP21hTAppNDrKMtEl23HRrhSA7JG6hx/Y5fQE7bxoPPlzeD1mxeQSRpZV0NVvw5DPY/VV1g1pJwVuSOBMdKLNfj+xspodXPbiNH0XhALa3uuEnLcoVmPm+DVMAcTqfBwXrCEP334e/eXZC9R+ylhsrlwKZL7iq7VCSvUPTMPlPXrAnHPd8ArG2qemW3a50aJK/omQix6JNPMQad92+I1PvdNpoYxcpROuBH0xz8PqZNzuS4D4/SMRGJnZP1BvYd+g7S4xUo0ib17UNq83Wc4UzL1TH8EflTBr4LwHx7P3Ou4iuZA7ATmEOauJw/Cz64/h7HvsYWrCIrRA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DS0PR02MB10757.namprd02.prod.outlook.com (2603:10b6:8:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 02:58:26 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 02:58:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH 4/5] scsi: storvsc: Don't assume cpu_possible_mask is
 dense
Thread-Topic: [PATCH 4/5] scsi: storvsc: Don't assume cpu_possible_mask is
 dense
Thread-Index: AQHbFUgsnCanOGEBdEax4hrU0daX6LLY6FYw
Date: Fri, 6 Dec 2024 02:58:26 +0000
Message-ID:
 <BN7PR02MB41487D12B5D5AA07FE7236B6D4312@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
 <20241003035333.49261-5-mhklinux@outlook.com>
In-Reply-To: <20241003035333.49261-5-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DS0PR02MB10757:EE_
x-ms-office365-filtering-correlation-id: 584cd335-c172-466a-f5da-08dd15a1db08
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|8062599003|15080799006|19110799003|1602099012|10035399004|102099032|440099028|4302099013|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LFW6uST6B0c1GlzKmvmzXxtNpxgiZHwiesgj64Yu/BNKbpcMbLTeiinISxRU?=
 =?us-ascii?Q?URMNI9fGP5owcVWYzimN2LSYP5nD1qHXWkiWcQvFXNz1AVgWG/W5IVEomurs?=
 =?us-ascii?Q?ekZuTLnYmxskqRKd3uepigQlfGe+5GhN2JYO2GIp1pR8tfi3rTx3X+vNe/Qk?=
 =?us-ascii?Q?/HbWe/ERmQCwPDd5CSeeFdcIrRHq6xnWX2aVXre8XDtiVF5kVRYh1UBvk6dy?=
 =?us-ascii?Q?62KTUssB4Cw+uCAvoantyLRq5I9Hp1XjF0Xk4GsX4MlHputKeuA/MgtU48u+?=
 =?us-ascii?Q?ZttIqnPMM1Y83nzbfgg5wPsn2sdlPYgddAOAeZ6EdnoZaQ0WOW7+Nuzx+Xro?=
 =?us-ascii?Q?c73+a9fLOkEwygrxnDRwahjp5p/9YanxhY3V7TOCge5EG8d7eLu3BTVrAJJ9?=
 =?us-ascii?Q?68R5Du3/4tMmitTXFdozNquisXWUbE3t7cwUg1FW17A5unA8F9idwpYB2IBi?=
 =?us-ascii?Q?vRiO0tMSTgI1OZJ9CV6LPOkGIIAVsu6RSKU9kzboc8EpFQXVBr1fGpWvoGVe?=
 =?us-ascii?Q?IDPf135AADDdQKsHkPJunS0xh9+7L7Qzjr+NboBk0zVhEKqWGb8AMluvDkHV?=
 =?us-ascii?Q?U+P9i87XbrKaRFT3wbIvYbEQuy+qxBYHAi8rE3UWNDggK21FJY90C6D50NJU?=
 =?us-ascii?Q?aYBdScC1PORiZTlKPguFV8mIugWgANxWSuNmfJANLTDObUqXhU1qtTuMXikI?=
 =?us-ascii?Q?nCRilejrdVy5TgA+I9pt/ydsMHXaWnVUVm2p5bdnCpUUgaErpCrR0vlhuO/d?=
 =?us-ascii?Q?IaDJZiMPtude7PUvpG134Al32Ltj6Z6jgU7TsLi7bvafVFFUeFPjiJEobcrM?=
 =?us-ascii?Q?hUJjJjKJ2RJL5MVP+0Tt4LWa4cl74OJjwAjfGZq9zAMoIRDdW9GEE0Bilyn0?=
 =?us-ascii?Q?YkoN0cZZKTAKk7Wc9F26mSNzMKjvNg1YH48wf2iDwJJe406nNyWMnU76OZzk?=
 =?us-ascii?Q?fPrT7R0bfk4/5Kio9DvXFNJhkLKBeOP7uVeADq89w+bpkdiOqo35nLF5ZXj3?=
 =?us-ascii?Q?RNPmUSFhWAOyXN5AJbDXKC1dVP8Iqx2n+d0+pnLBIsVfx5P/u3e0lIT6msYA?=
 =?us-ascii?Q?Q7PP3FmGkHhxixb3/EzDshDrH0mI6fofPxFIM7vh44we+N8qNKgQY+3cJkFf?=
 =?us-ascii?Q?yeoc4XZMPBJ/qvR7NdcLaGEjmVS8Uo9jilnofYI0HnbxITrQbBIWZ14CxIOn?=
 =?us-ascii?Q?m/w3Y63537BMrRIw1/x/HqGWPeKzXFZUbIHXmw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?roXUiKoCMFXTyQgWIDfKF2wqfqOyQfMx8t/vuoQUI6X0a4xzPilnLGu8mxys?=
 =?us-ascii?Q?QmA7K2zxfyxj0rPax1wVDK1GCItOVPRUfZAwZXH5WnwiYYOZsPD0jLto+aCq?=
 =?us-ascii?Q?IMOqQ3F95VB6ieeAvdYgT9ECTJXVVZGU+JkctZyL/UbqGIIgDkFyjkLrSAFC?=
 =?us-ascii?Q?Z237Gelyhr9zjUq2sFw2CD60ZSgw9jFjK+zdyhXYGPP4aVOprsRdcdfdaVsP?=
 =?us-ascii?Q?lVCwDiTKgR0YrfkL44aASTdEqjhYozXzXHuQ9DdC96E9QMOdAKEQZOYi99Il?=
 =?us-ascii?Q?yeQjt/doJqNrtnXUuwpptxb5EbPBBiZHqSxmOl1wUGUi/M6xXTf0Fd9zFPGi?=
 =?us-ascii?Q?tvjQNtkwe1GdR2ChYLjqxcztHz+uWbCSSA4vz3oTSURjk5TaK1AGd0RB+BP8?=
 =?us-ascii?Q?mv0fHFJ16mGExvGT9dfRa2PoQIN6c6UgZ8YdhigYK8+83QL3iVEB9MQ1+Bti?=
 =?us-ascii?Q?cR5iCkYG1xWau23AOV8GInhC1SbKHNhDjescZsCONmagWxz+o1VZjl0UXBhK?=
 =?us-ascii?Q?azlHrdDvMocQKmBHen6/Rux0L56G70TgmeUIKtnDoynf1w73RMWflFxRx6Pt?=
 =?us-ascii?Q?IWTmSn+QSqumClsbbCbAa+MUpoANDtHDZEI2q5ScHAAkBbCIoA9PrDku8Tu6?=
 =?us-ascii?Q?D0sIL87mK1OmuFszEynJKKdX3Hm7GMyOLV1e2ScTVJRQRZuVkT4SfPIox1nB?=
 =?us-ascii?Q?dNjNgXmLtw4SWW3fqAR7dUkpr6S7JWzwzWDUZ/UXE80x2VokWy9Tzyr1NVY3?=
 =?us-ascii?Q?iyLgif3uj16xHNml1qQz7USvsnxkDkBvpYGqTnOnfR2Z5awB8O6I2mBrrCnT?=
 =?us-ascii?Q?/7ElamDndoYTwimvUTXyD/8cQtF9eMfJwQDN1l53ZdP8WGrGXFpZyy1DLFC9?=
 =?us-ascii?Q?Q5sOVQbDlQBvBJRj8Blqjg9SQqkD8m0qhQ6+Xjwrdm+WhSX46+Q/KJuTSTyv?=
 =?us-ascii?Q?0VX4UraWQBmYK2NAjqX8VYUo0Z4Hwv5elEttJUqX/3xoRdrgOBW/cdNCqgc/?=
 =?us-ascii?Q?ol4D5B+RgNfAYFHC03B+GHMQ1HE0rXR4WsAdN3q72pt4+a+G8iwPd4Ev5DSN?=
 =?us-ascii?Q?6f0u4aFx01DNTuPLT26a3/pluDRFsEUdPuv9T3bEOZrQRGThn+HbL9js9LtS?=
 =?us-ascii?Q?lbKA6xdc/pbx2qze/eLtmfpCjWNBGU6mTVozIyybRc9eohbZj8ptOkZGWb9F?=
 =?us-ascii?Q?X2xWCYHzXU7Bi031nLpao60CtrkBtU9jkJjk0oK1ZLHGOoc9EQJqT0rodQY?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 584cd335-c172-466a-f5da-08dd15a1db08
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:58:26.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10757

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Wednesday, October =
2, 2024 8:54 PM
>=20
> Current code allocates the stor_chns array with size num_possible_cpus().
> This code assumes cpu_possible_mask is dense, which is not true in
> the general case per [1]. If cpu_possible_mask is sparse, the array
> might be indexed by a value beyond the size of the array.
>=20
> However, the configurations that Hyper-V provides to guest VMs on x86
> and ARM64 hardware, in combination with how architecture specific code
> assigns Linux CPU numbers, *does* always produce a dense cpu_possible_mas=
k.
> So the dense assumption is not currently causing failures. But for
> robustness against future changes in how cpu_possible_mask is populated,
> update the code to no longer assume dense.
>=20
> The correct approach is to allocate and initialize the array using size
> "nr_cpu_ids". While this leaves unused array entries corresponding to
> holes in cpu_possible_mask, the holes are assumed to be minimal and hence
> the amount of memory wasted by unused entries is minimal.
>=20
> [1] https://lore.kernel.org/lkml/SN6PR02MB4157210CC36B2593F8572E5ED4692@S=
N6PR02MB4157.namprd02.prod.outlook.com/
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Martin or James --

This entire series was Acked-by: Peter Zijlstra [1]. Patch 5 of the
series was picked up by the net-next tree a few weeks back and is
in 6.13-rc1. Do you need anything else to pick up this single patch
in the appropriate scsi tree?

I'll separately pursue getting Patches 1 thru 3 of the series
picked up by the Hyper-V tree. There's no interdependency
between the patches in the series, so they can each go
separately.

Michael

[1] https://lore.kernel.org/linux-hyperv/20241004100742.GO18071@noisy.progr=
amming.kicks-ass.net/

> ---
>  drivers/scsi/storvsc_drv.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 11b3fc3b24c9..f2beb6b23284 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -917,14 +917,13 @@ static int storvsc_channel_init(struct hv_device *d=
evice, bool
> is_fc)
>=20
>  	/*
>  	 * Allocate state to manage the sub-channels.
> -	 * We allocate an array based on the numbers of possible CPUs
> -	 * (Hyper-V does not support cpu online/offline).
> -	 * This Array will be sparseley populated with unique
> -	 * channels - primary + sub-channels.
> -	 * We will however populate all the slots to evenly distribute
> -	 * the load.
> +	 * We allocate an array based on the number of CPU ids. This array
> +	 * is initially sparsely populated for the CPUs assigned to channels:
> +	 * primary + sub-channels. As I/Os are initiated by different CPUs,
> +	 * the slots for all online CPUs are populated to evenly distribute
> +	 * the load across all channels.
>  	 */
> -	stor_device->stor_chns =3D kcalloc(num_possible_cpus(), sizeof(void *),
> +	stor_device->stor_chns =3D kcalloc(nr_cpu_ids, sizeof(void *),
>  					 GFP_KERNEL);
>  	if (stor_device->stor_chns =3D=3D NULL)
>  		return -ENOMEM;
> --
> 2.25.1
>=20


