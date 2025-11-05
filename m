Return-Path: <linux-hyperv+bounces-7410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65665C37252
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2436A18886B9
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31211338920;
	Wed,  5 Nov 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DI9CEdtj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010028.outbound.protection.outlook.com [52.103.23.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA875339B4D;
	Wed,  5 Nov 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364475; cv=fail; b=XqO4AtvG3Jn1qqOfh8Wy4sGu7/Qp1tBBTW6EEZ5mCMnxiE6x40gMafPy5v75PtSrSArC0tmVCSEvd5KoDDhyL8TG38bbhlUCmUCx01a2l2YZlVGLkc89Bh12Og3HkZ5KSBuD2szd5wS0XSH4NFZ4Z6VEG55+LX8vcPHv8KTAIUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364475; c=relaxed/simple;
	bh=Lm+9zzXLGB6iffyD5JXX5I2DxoHYJldUM7eAlf28NQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFQEmXLtlmboMnmk8OC1gaJAN4zP1VuRU1c8rhaCn5UA4qiEZ8rTZAxIAtksuuI9w8wIcqpeqsJdt3vcHsYxRxz5hqXl+LceGVhWE4DqrvH4sM3RC20T9w+842AH24uvNnlb4mYWqGH1qYRtVjiC0s6lDzH+kvEm3UYyaabL71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DI9CEdtj; arc=fail smtp.client-ip=52.103.23.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUEHVCh8hrq96NpCeF2cmwe7tqg3Gmi7dTG8gvq2+NISsBIJT3B4lGWfM5v5dYZ5NLYYAdKGOzwHruZ5MRzjkdNH8bNbe/MT5YJXHkiOVAJSUZ4BfZmJfJrSNyyvCczewAdj4Gq/eUacOgoqe/lLk9A5Y+XyU7PkcSvi+Lq0Y+Rge/qW8rhSyn0/fKG3RaPo8GK/Ze75U3zNfpD+4y/cTBGc1ywxurZur73lHUPEB+mzDeAwy3MP5NOf6Q7l1J20mztL/qY2k5j8vCkZd9PhkSUYIrpFXk1ra86OD2brHUNX/5bONm3SRPVLLrFgtA590cw1JwM0UlEEcGUailyzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1/T/taoAAW2A9slenidGvRt9aAdEbsAC5gQQVJ4smc=;
 b=kRDDxemVDge4+mYGQxTtC2koJQ+BR/gTgxf/LH29H6ygScSZjneYMIGzgE8JAtPjG7xhk2gi9D4vxTQsZX6kldNmcPD9N3QeqPzrdd6Y1gsH6FCmUjSoTidjP1WP3JJxEIJ41T971gqaE6HcqbogMb0Z2HzLLoRS6Bm78l8VeKj5A2jZoi6G65XnE4+MlEmWkPPQnY+Pr1TVRqSxygoY/C0KBYxmcZIgnU3A1x3iiiCth1rbTeEKYXWsUT/DapXcShTUa/+gYpCRu09Dn8GxhkXeoYDQ3loOSXIGU64UUBQT82/5NmhB3SImVRdu/PN0n5PYgVxJPrSjAoH0yFHBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1/T/taoAAW2A9slenidGvRt9aAdEbsAC5gQQVJ4smc=;
 b=DI9CEdtjmsdMzn3lHLK6Bf9Ff5SmN1eDgEiIOijMTIillaV+G85ksgswh63bUAjmsCTawHo5J06kXYwULB0zVrglynsxIH5mKtt8P7Yh5Sy4AFvoVqg/mR5OpY+7HF/n8ctucasaA/vgePH2Zb0Xvo/IdEE29DVcGClwBeAquf4uP2ikHfclD1IMUfJEgW0UTGCaGQPb/O4fK3pe5HqdAcptDppd9YBJLkeXdwBrjgt14qD5iY/yeyb0oYhwF1ehM4dKWTn5DPSlmJfTZDypWlt7uPDyNbsDeqHesUu+A+bND57PG3/ooe3kenHXL5jAwzr8GvtTAM/ZvWagG9fA6w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8564.namprd02.prod.outlook.com (2603:10b6:a03:3f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 17:41:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:41:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"romank@linux.microsoft.com" <romank@linux.microsoft.com>, Jinank Jain
	<jinankjain@microsoft.com>
Subject: RE: [PATCH v3] mshv: Extend create partition ioctl to support cpu
 features
Thread-Topic: [PATCH v3] mshv: Extend create partition ioctl to support cpu
 features
Thread-Index: AQHcTdSdUwjKNQ889UGRDbaquU6AarTkU+Qg
Date: Wed, 5 Nov 2025 17:41:08 +0000
Message-ID:
 <SN6PR02MB41571FC666D406397858A377D4C5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1762292846-14253-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1762292846-14253-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8564:EE_
x-ms-office365-filtering-correlation-id: d7897f18-fd31-4bb1-4ded-08de1c9280a5
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|13091999003|31061999003|19110799012|12121999013|15080799012|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XgjLnAYbLen5XysXl6AS5o/Z7Z4O89xnnEsWmFgx4ipsyCWnD0sOcGc6yjS8?=
 =?us-ascii?Q?EmSE1tJMOkz0wHske63UZKRpsjZoZSoAfEv/sY6NxALQ1d4jEuh/gs6LVv6g?=
 =?us-ascii?Q?askjRwRGyaVIycVrZxjsyE789K/7cm8TwsnHTLWaH46TQtA6QDMmKKfQLO7M?=
 =?us-ascii?Q?n5DKPAxtWhEI3XeVDK///FBkHNfpvuSs6IRt4fxr/jh9xpGBhK6l6R9V7ndE?=
 =?us-ascii?Q?G5XJrrhyW0V1l+XMUv+9viLkwwAUaQKduP9es3IlG/LajkBQfQ64pioQH4rH?=
 =?us-ascii?Q?Cg7gOw9z+1EvggAHJbGQDP5teuIkzV3OXQ98Kj6EWXmTVClqetGMHbNw3FcC?=
 =?us-ascii?Q?RzNPF2XsoOOtviuJZWy8hCOUkdfrH0Fq8jSMxRuBxrW1TWB87D1chy9nb2KL?=
 =?us-ascii?Q?iry+Se6hMt14K+x1m0R9oggDEwqwGd7Lnb5ZfQmA7L5zmD7O5TEEiT80AM4v?=
 =?us-ascii?Q?4UNXRJmBxZtkUeypxoW1Lji2Qg1iEq64reczTLeNfEgX4av6pHsmgxFQeXdY?=
 =?us-ascii?Q?rG6pGGxl4c06PJUnWseULwfD3yDsEfc5NwKlMf+9RnpsO8UfA9SM7Jg4vb2T?=
 =?us-ascii?Q?ToVfkfSu2rg3av722dLTh8UHfRqwNRZvaUS89jE66jm+6GkI7LMoumBlEdsB?=
 =?us-ascii?Q?6BVL2exFOLCMJITAUh0ravbIze2zEC7swHF+D0VM2M57lRIf5DS2uIXAK2u2?=
 =?us-ascii?Q?qcm8QaXMDoG+Wh0d2qTsIqH9pQoETLr+xle4xcAyFndMgfU6VJ5EI3GZ+dS9?=
 =?us-ascii?Q?iLrEDCulExaw4SeVGWe3UIEAuH+1wIw2sygJX6A73IxJvAE4juCOBZtwFYsR?=
 =?us-ascii?Q?zeOwGRZgY1vahtCqYdRZNWE3d8xoou8tkLaO2fJA0JB7GHvgxR+u0Hb/iupJ?=
 =?us-ascii?Q?SmVjvNv/w3jkD043f5SpHJz9RM1++DEJcDXkA1x6+PCi25U7diLaUWFXKNt2?=
 =?us-ascii?Q?/ez6XB5scLW+yHw7ew5ab/VZ0HCrTN36RV5wQSiy3MCqEo2VbvZlEc6P/bbK?=
 =?us-ascii?Q?xEgjWHzkJCU2LGjaWdmOTGzK/mdDUTe70aG+lCBAQZTsFxhIYqiXavvd2Aek?=
 =?us-ascii?Q?FTC03NfPrq9C7KK2nYgGKA8XwFyacwz+GsuMvONj/ib4Rp4Tw+pqMituj93U?=
 =?us-ascii?Q?uQ/im4xFk687jRgHvExzE7297wwwzYin8DMyKcsEb2lYsW7f7Ee1Who59ont?=
 =?us-ascii?Q?EWYyoBRYteS/DzWIlLCaS78xS1w8jINbGWBPfma1xpbPLqu7VmOQPNh3lv6V?=
 =?us-ascii?Q?qPPbhd1hq5F25EcDmORn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fIQ1B27NRbm1HSS/spwqXGsgHifA1ty9/gG9W90hbtpsPgRgF57eQk6wydGT?=
 =?us-ascii?Q?YaUNAbEkPSxKGn5sHTFQQcCu43U9rCA45LLm2S9bMvI2b9xiWsUaZfs0Bxyp?=
 =?us-ascii?Q?u7uYNLyDXTTV53Zf/naJ95LOXxyTq45Mi0Nk3NSAjnzNgt1Lv/nIzYLhGwqJ?=
 =?us-ascii?Q?m3s2iZunPxYSQxDHCgfiXGx0gNPe4MBsaELapRh1wllxqIWkvveSlzb7YeVi?=
 =?us-ascii?Q?izFpWMq4H9QDD+mVZvlUQRQBcRYZNwhF99YT7xWsUhadvcHBL0a1OesUai4M?=
 =?us-ascii?Q?gm3tUJNpxNOlSboE2/h0f+WMrAvRrvN4Bbo+6D4WdtZFx64Vr1TbpDklDMWW?=
 =?us-ascii?Q?qrMigXzXtZUttrKrQuezgeUnGB6iZRtHbyV4e5Lw0pxn5JfCvEhyXHPvqQO4?=
 =?us-ascii?Q?kz416AA1o1YFfzIe7PSQ50hOVxxRH+OOZXndjZJ7KG/qHkVg38HKTCiOLiXq?=
 =?us-ascii?Q?bqSxwUUVGTxnykt6jAhppNIByYbTwA1hKutOUUJcMS1tFZDNcLYqMYZTUyWu?=
 =?us-ascii?Q?Ic56lX6tEzKMN0CDI48iHAdcmMITwPqV7BuqlzeGnh67ARgTJV4AmPFnirQ0?=
 =?us-ascii?Q?RXVqCNWJozFAAN54/GiXgMwnPSaZbjTguDmtflJAsST6ou0DzoA6BHQw73Rj?=
 =?us-ascii?Q?BYN9ohFFrIAmMj2Y1JEd47ymMEOFPh0Iv7VaHY3hzrHWSe6Tc1OuipOirP2s?=
 =?us-ascii?Q?n5kwfl3dqsO/f+uq+9XiyrpgmHW/v9LHo+lgAoDjhnJVCMa1muzQ+/CppFyj?=
 =?us-ascii?Q?Yq9VrWQyiFhVh4GJRWDiweYPcWRCEeGbeQBqbgoR0SRTOhIullhgN8Ss4lQl?=
 =?us-ascii?Q?NZJ123yWLnFppB5lhFE9ne2mu70ZPgrhkMu3LUCpYYe/lNNDgwdNCkqFKGs7?=
 =?us-ascii?Q?nl40TYC/hjvoCithf6gvgxaKS0ZzVWn9r9vhz/NvW05EoZfdpWmYBH4iB8Ln?=
 =?us-ascii?Q?s7U3c2TwPJy5TigWaHs4SNfC+50Ao+xZNXHqV7vpq5HAyVKD4kEiCRfczoL8?=
 =?us-ascii?Q?pNOWxdWN1HNaoylI5m64fWLCTTUx4g2kmalnLax+ODqRj51UwpEb1d+/0y5H?=
 =?us-ascii?Q?qgk2a7QRQdc8S9xtZrC/QwS7DE8mK/LraCG8oUI8JD4tHAoS1P1rbAch4tcM?=
 =?us-ascii?Q?2kcdAiLBnXzAnoMQWxo0fcig3ZIboDGU8b/78SQcvGAVeUlwulcpg9KVNd8/?=
 =?us-ascii?Q?MrkDbw/+jwNZrjgoFSb3Y6fAW8qsE6XmeUtwnkscdP4BzKcnzRoDjZcjB4o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7897f18-fd31-4bb1-4ded-08de1c9280a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 17:41:08.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8564

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Nove=
mber 4, 2025 1:47 PM
>=20
> From: Muminul Islam <muislam@microsoft.com>
>=20
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. Instead, it
> attempts to enable all features and those that are not supported are
> silently disabled by the hypervisor.
>=20
> This was done to reduce unnecessary complexity and is sufficient for
> many cases. However, new scenarios require fine-grained control over
> these features.
>=20
> Define a new mshv_create_partition_v2 structure which supports
> passing the disabled processor and xsave feature bits through to the
> create partition hypercall directly.
>=20
> The kernel does not introspect the bits in these new fields as they
> are part of the hypervisor ABI. Require the caller to provide the
> number of cpu feature banks passed, to support extending the number
> of banks in future. Disable all banks that are not specified to ensure
> the behavior is predictable with newer hypervisors.
>=20
> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
> the new structure. If unset, the original mshv_create_partition struct
> is used, with the old behavior of enabling all features.
>=20
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v3:
> - Remove the new cpu features definitions in hvhdk.h, and retain the
>   old behavior of enabling all features for the old struct. For the v2
>   struct, still disable unspecified feature banks, since that makes it
>   robust to future extensions.
> - Amend comments and commit message to reflect the above
> - Fix unused variable on arm64 [kernel test robot]
>=20
> Changes in v2:
> - Fix exposure of CONFIG_X86_64 to uapi [kernel test robot]
> - Fix compilation issue on arm64 [kernel test robot]
>=20
> ---
>  drivers/hv/mshv_root_main.c | 94 ++++++++++++++++++++++++++++++-------
>  include/uapi/linux/mshv.h   | 34 ++++++++++++++
>  2 files changed, 110 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index d542a0143bb8..814465a0912d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1900,43 +1900,101 @@ add_partition(struct mshv_partition *partition)
>  	return 0;
>  }
>=20
> -static long
> -mshv_ioctl_create_partition(void __user *user_arg, struct device *module=
_dev)
> +static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=3D
> +	      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
> +
> +static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_f=
lags,
> +					struct hv_partition_creation_properties *cr_props,
> +					union hv_partition_isolation_properties *isol_props)
>  {
> -	struct mshv_create_partition args;
> -	u64 creation_flags;
> -	struct hv_partition_creation_properties creation_properties =3D {};
> -	union hv_partition_isolation_properties isolation_properties =3D {};
> -	struct mshv_partition *partition;
> -	struct file *file;
> -	int fd;
> -	long ret;
> +	int i;
> +	struct mshv_create_partition_v2 args;
> +	union hv_partition_processor_features *disabled_procs;
> +	union hv_partition_processor_xsave_features *disabled_xsave;
>=20
> -	if (copy_from_user(&args, user_arg, sizeof(args)))
> +	/* First, copy orig struct in case user is on previous versions */
> +	if (copy_from_user(&args, user_arg,
> +			   sizeof(struct mshv_create_partition)))
>  		return -EFAULT;
>=20
>  	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
>  	    args.pt_isolation >=3D MSHV_PT_ISOLATION_COUNT)
>  		return -EINVAL;
>=20
> +	disabled_procs =3D &cr_props->disabled_processor_features;
> +	disabled_xsave =3D &cr_props->disabled_processor_xsave_features;
> +
> +	/* Check if user provided newer struct with feature fields */
> +	if (args.pt_flags & BIT(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {

Should probably be "BIT_ULL" instead of "BIT" since args.pt_flags is a long=
 long field,
though it really doesn't matter as long as the number of flags is <=3D 32.

> +		if (copy_from_user(&args, user_arg, sizeof(args)))
> +			return -EFAULT;
> +
> +		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
> +		    mshv_field_nonzero(args, pt_rsvd) ||
> +		    mshv_field_nonzero(args, pt_rsvd1))
> +			return -EINVAL;
> +
> +
> +		for (i =3D 0; i < args.pt_num_cpu_fbanks; i++)
> +			disabled_procs->as_uint64[i] =3D args.pt_cpu_fbanks[i];
> +
> +		/* Disable any features left unspecified */
> +		for (; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] =3D -1;

I'm trying to convince myself that disabling unspecified features is the ri=
ght
thing to do. In the current hypervisor scenario with 2 banks, if the VMM ca=
ller
specifies only one bank of disable flags, then all the features in the 2nd =
bank
are disabled. That's certainly the reverse from the current code which
always enables all features, and from the hypervisor itself which in the
hypercall ABI defines the flags as "disable" flags rather than "enable" fla=
gs.

Then in a scenario where a new version of the hypervisor shows up with
support for 3 banks, the old VMM code that only knows about 2 banks
will cause all features in that 3rd bank to be disabled. Again, that's the
reverse of the current code.

I guess it depends on how the hypervisor defines any such new features.
Are they typically defined to be benign if they are enabled by default? Or
is the polarity the opposite, where the VMM must know about new
features before they are enabled? The hypercall interface seems to imply
the former but maybe I'm reading too much into it.

A code comment about the thinking here would be useful for future readers.

> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +		disabled_xsave->as_uint64 =3D args.pt_disabled_xsave;
> +#else
> +		if (mshv_field_nonzero(args, pt_rsvd2))
> +			return -EINVAL;
> +
> +		disabled_xsave->as_uint64 =3D -1;

Does the arm64 version of the hypercall do anything with this field?
Or does it just ignore it? I would be more inclined to set ignored
fields to zero unless there's an identifiable reason otherwise.
(especially since the VMM is required to pass in zero on arm64).

> +#endif
> +	} else {
> +		/* v1 behavior: try to enable everything */
> +		for (i =3D 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
> +			disabled_procs->as_uint64[i] =3D 0;
> +
> +		disabled_xsave->as_uint64 =3D 0;
> +	}
> +
>  	/* Only support EXO partitions */
> -	creation_flags =3D HV_PARTITION_CREATION_FLAG_EXO_PARTITION  HV_PARTITI=
ON_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
> +	*pt_flags =3D HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
> +		 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
>=20
>  	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
>  	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
>  	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
> -		creation_flags |=3D HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED=
;
> +		*pt_flags |=3D HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
>=20
>  	switch (args.pt_isolation) {
>  	case MSHV_PT_ISOLATION_NONE:
> -		isolation_properties.isolation_type =3D
> -			HV_PARTITION_ISOLATION_TYPE_NONE;
> +		isol_props->isolation_type =3D HV_PARTITION_ISOLATION_TYPE_NONE;
>  		break;
>  	}
>=20
> +	return 0;
> +}
> +
> +static long
> +mshv_ioctl_create_partition(void __user *user_arg, struct device *module=
_dev)
> +{
> +	u64 creation_flags;
> +	struct hv_partition_creation_properties creation_properties =3D {};
> +	union hv_partition_isolation_properties isolation_properties =3D {};
> +	struct mshv_partition *partition;
> +	struct file *file;
> +	int fd;
> +	long ret;
> +
> +	ret =3D mshv_ioctl_process_pt_flags(user_arg, &creation_flags,
> +					  &creation_properties,
> +					  &isolation_properties);
> +	if (ret)
> +		return ret;
> +
>  	partition =3D kzalloc(sizeof(*partition), GFP_KERNEL);
>  	if (!partition)
>  		return -ENOMEM;
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 876bfe4e4227..9091946cba23 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -26,6 +26,7 @@ enum {
>  	MSHV_PT_BIT_LAPIC,
>  	MSHV_PT_BIT_X2APIC,
>  	MSHV_PT_BIT_GPA_SUPER_PAGES,
> +	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
>  	MSHV_PT_BIT_COUNT,
>  };
>=20
> @@ -41,6 +42,8 @@ enum {
>   * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
>   * @pt_isolation: MSHV_PT_ISOLATION_*
>   *
> + * This is the initial/v0 version for backward compatibility.
> + *
>   * Returns a file descriptor to act as a handle to a guest partition.
>   * At this point the partition is not yet initialized in the hypervisor.
>   * Some operations must be done with the partition in this state, e.g. s=
etting
> @@ -52,6 +55,37 @@ struct mshv_create_partition {
>  	__u64 pt_isolation;
>  };
>=20
> +#define MSHV_NUM_CPU_FEATURES_BANKS 2
> +
> +/**
> + * struct mshv_create_partition_v2
> + *
> + * This is extended version of the above initial MSHV_CREATE_PARTITION
> + * ioctl and allows for following additional parameters:
> + *
> + * @pt_num_cpu_fbanks: number of processor feature banks being provided.
> + *                     This must not exceed MSHV_NUM_CPU_FEATURES_BANKS.
> + *                     If set to less than the number of available banks=
,
> + *                     additional banks will be set to -1 (disabled).
> + * @pt_cpu_fbanks: disabled processor feature banks array.
> + * @pt_disabled_xsave: disabled xsave feature bits.
> + *
> + * Returns : same as above original mshv_create_partition
> + */
> +struct mshv_create_partition_v2 {
> +	__u64 pt_flags;
> +	__u64 pt_isolation;
> +	__u16 pt_num_cpu_fbanks;
> +	__u8  pt_rsvd[6];		/* MBZ */
> +	__u64 pt_cpu_fbanks[MSHV_NUM_CPU_FEATURES_BANKS];
> +	__u64 pt_rsvd1[2];		/* MBZ */

I presume this is for future expansion of the number of banks?
And that the choice of 2 additional banks is somewhat arbitrary?

Michael

> +#if defined(__x86_64__)
> +	__u64 pt_disabled_xsave;
> +#else
> +	__u64 pt_rsvd2;			/* MBZ */
> +#endif
> +} __packed;
> +
>  /* /dev/mshv */
>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct
> mshv_create_partition)
>=20
> --
> 2.34.1


