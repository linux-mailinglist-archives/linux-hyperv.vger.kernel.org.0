Return-Path: <linux-hyperv+bounces-5409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07FAAE567
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F201C44DB6
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19628B7DC;
	Wed,  7 May 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UKX/sveG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF128B7EA;
	Wed,  7 May 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632919; cv=fail; b=QbLx83ANHsNxveOFWnPyQu3T808e03xBbjkoMlBjCiV+t0Hb3KF5BMQA8cYBXTvk6xI6RdgmG/+UqOeAjOGU2F8B6EVAGiLcg5CyQv4tgqJ8CGpn0u5DgwiaLvB4u5lIiTDwWBRo5Flkt5zxl/9QyzbyzAGRVVYnTWf1jy1Z4LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632919; c=relaxed/simple;
	bh=7D3MtoBOttwya8XHw6Kwx6+VSvDDTSoVlghpIJ+Nhng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kInJ+D0k3wjM9q35r6QCNflQGAPpzV11HU8ir1nxfaX0Tgxwj+3Ia2skPj5Sqhi0hXsJaHeR08+e9W49edDnW2uuj0gdB3nBHBg4qezbbc3MHUJejJrj5G9hRchKwA1CjZpCgqa2dNBBEsVqSWf3rIRvSfFoLg4E2BKYfpAmfMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UKX/sveG; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD7+1a5VHSpwFwftVxCVBgLq3LSgq1Z8jBpiqNorQA1tOfo8ykN4tsj6V/+uxQe37cOvdW/uYh4inKUZhxPh6IlL1b8sKwQC98+yf7XBEW32+FSvcyVElT5VgOeNteKQeAAURfp0Vlc8CPRISCp3F8S8ZJlwKC8pelswSaPiBGcChG7fkT4LluqH4TkzaYj15gF+Oji/6Juk0Ey+ED9DYzKbDI86R4C6SzINCwXZVHxlWuURwalGNucFiaZDp/KWMvZ+ev71OpQ2huStGS+1yhIoEf1BNvV4HlGlDd/nM7hjjLHcXwGcP4yMw15y8RXvFpgPnMsdThVitgo4oG2cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVmDibu8DEbhpfXQOM7lA5wHpOfhAxCF6lMHcPFy+Ss=;
 b=aeOm/PtyjqskAAVBeWk/8eAlAgbdmLAHKa4KKhoA9+/nsDCeqWL+mb5wBhiSBxDjJotutBhWAbnfOYMMU1Lm93PQp9GfTK9ZYEWUko9D/RZHLaf8JMjTiDTH9AULuqVEkCW02BEEqAdL+/MVCNEs51qpCoJu3JLXcmNWOVHHVY/kdq78O5IbcLYzvzv6rwRUfb/5aA1Yn1/BHz6Udh3ZIj7hkgAPL6z8BzxTpvGhBWXMXGAz1xdqYJVbasbc9fLAg999plPHXoC1A5HwsbGOqZe34+edkongwak8mzHZ/XfnKNTgMafe3J+6jS5ChiDJvsH0ujb/g2euug0r0r+Spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVmDibu8DEbhpfXQOM7lA5wHpOfhAxCF6lMHcPFy+Ss=;
 b=UKX/sveGER8f5gXb4rJD4Wmrv7mlcdD8DWHsdwWvQXfd6rqybjhH8HDaxsC5gl7hC6QGQEMTw/Ye8CIZi5JTY5sa/TVU8PGVEXUblLtGiLJhBLrKGAL929cL/XXr5jOSeB3uhVhFvl87TObQIXUchx9pMthECyV3sY/fBs3emRPsjvJzfL0sdEQrhyUxDp4lzcjmGXWzaFVQOP6baRVEmPrsg4RQAOt0Mqj8o5/vmCeokKAxQmYluZBu0yjsuEN8a4xW3lzVwVDckZAV3pNbFlA/BQ1jYRjL4iwXW7uUJ75cdyj+buUoIHaMzo5qACbq5R9OSBGlP6jwlQKKeWn17w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8989.namprd02.prod.outlook.com (2603:10b6:930:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.13; Wed, 7 May
 2025 15:48:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:48:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch v3 4/5] Drivers: hv: Use kzalloc for panic page allocation
Thread-Topic: [Patch v3 4/5] Drivers: hv: Use kzalloc for panic page
 allocation
Thread-Index: AQHbvlF5ljoWdAI+x0a8prtdFaq/97PHUj/Q
Date: Wed, 7 May 2025 15:48:35 +0000
Message-ID:
 <SN6PR02MB4157723E965FAF4C0A60CA57D488A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <1746492997-4599-5-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746492997-4599-5-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8989:EE_
x-ms-office365-filtering-correlation-id: c62a6931-b8bc-42db-ca1e-08dd8d7ea0a7
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6FzHtS0SyPzE5Nr7iRLok+PkQInqgTbCauTK7MTNTPCDz7llTB8nh7f9DvNLAa1bLDMyPFEmGKbUnt1mi1L9i1YIIjdnw816To0ggV438ZBp2sd7wZBuF/CjaNlzm9PrSxPcaFR0omJqBWcC6EzTVdAWaiPDBoZ1gETS/X6axR7wi48TjbqkgS9Nzs6EiL+/MahZw6qPUPsxh+vxOdGxAS3aK1yX4IKzA2zxJGQkOUCj4B/AU6UFmCaBkpk9cGS9J0zDARm+DANP9ZY6k74P3tFr7pFDr/WUH10RDiKzC+nXct3reURpCXg8Mkmlf5p0/q5OFl1LGPhpz+fNMej2RNNhACaOSdw/kQtcgfL/rCkRfdygOYa5tLVipfXLUV4GMArpbMAa1TAS6N8JZCDN/zeSmtyvuo/iIvcU145feB7j7vLuCZQ1Ts7vYvNh8C/KqVz4zNgL9HtRrlgC/uj8udSCvmxX584oW6wXMstUzfZ0ETbBOiQ75xIR0tF+sScbjSdToS8NnspUINCqKWhGS3T742wGefjm/VQp98JVCM6Ucl7mpLhKbt3Hmc7HJ355crBCDwwo7W1o7F66x4ptMB2+aTAwaaWXHF/77ThwXEynl8j0qVGwPsO9aq26r61LUrDNrsBFqxKRAPGR4WQmYZAeHhL3xHL2eF99Unp/TnQbda3Od/exRzoGPYYhKZDVW0oUrMPvhyj0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8062599006|8060799009|19110799006|102099032|3412199025|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/VICyabivMgNSAXX2JZ0ytbIug5ZaS8Cvojqrp9pKDdpnyn2EUp8yxdx4Cp4?=
 =?us-ascii?Q?Dwbul20lV3b0kXBaMaxupocb4lHejG6c1MSo9TqoABDZ4SAcqvHtZrDKwvek?=
 =?us-ascii?Q?jD2zU0MW+dUFC2jYGYRjGZJNnc2LYRiNi2YlzbeYdzIzrwbup7P766kymr5C?=
 =?us-ascii?Q?an/ixPuqranloaJMl/pxzPBwJOIgaHeJgA/FNZOrAF+r1/7cTV+t1mURxWsz?=
 =?us-ascii?Q?DSkfNM7UKWAbR++/535Jwsub1+ygCVjx5NUaRiFt2eClRS3S3pGp+y7/hCGF?=
 =?us-ascii?Q?SJyfIA1wQHnlU+3IBTRZJ7z3HAl904SfY7wLJDoKjX7bqwjg0l2WA0HqV087?=
 =?us-ascii?Q?A9irwyaYNoank5UoKei9H3g0XcIJHWwfVgvCpbrnqhJ1cYOvJ5fhHpkXRR4K?=
 =?us-ascii?Q?/JJQDIcWUC1tjFX2CeOM/nqiw94yX2OdgfrmmAwp/gTujbRfqssG1Y4SbjLa?=
 =?us-ascii?Q?LFIsxxFvr4JT7urMd7cyQKMSdnzz7tGFqXim9ZendG9zOIa6PpM4RByzbMiZ?=
 =?us-ascii?Q?L/AeuQlqsthD91jJZAIOMJDjmdkzgCJc/x3vXEF06nv95wVqvgi751gbkWVP?=
 =?us-ascii?Q?RlT+n6U3WqlFT6Fajh8dOOIh1Bs3Zf8sybnS+cyf4uUnJMVHYinkjG5OFNuY?=
 =?us-ascii?Q?8zD413H1CP1PZ4uBbkkB66Cu/CVaNZtcrCcSQ/QTFaKfz5oAl+g0LhfDlZgg?=
 =?us-ascii?Q?qznjfG9QW8Emb6neZl49p58w+AYNRJWGEAGOOIigRuhjPi6EpnLYg5HYzoUL?=
 =?us-ascii?Q?ADdyUQ5TRKaZ4y9bl+n40SMP8bnt8OB8fjnk4nwTXNlJwXq9voGt/wQ15DQE?=
 =?us-ascii?Q?h5QYb4YUqzf4O4/idPS6aler9BtINhLrJfPxE0ZKHFksoEw7hwai/caaDWzZ?=
 =?us-ascii?Q?OWWzrfQGqCW8PRta2Thadn1oqIIG6mXPyNMOV71sB+FoW+RoQh7Af5xn/jxW?=
 =?us-ascii?Q?96qKUQevT0IBomovOE4Q8crPLm2IbPvDEHUnYc50OxWRxuL6AdPNcRV3HJ7k?=
 =?us-ascii?Q?fTwC2dlkIJ2CdDxs/OuiXr+c/Oy+M0qunYPuRS435oqJOvMJzdt4JtMGBUhd?=
 =?us-ascii?Q?gQANQK/RKjHTQ+iPdkN2hopFCj/4OZlBpApohUFOg10oDCK+Q/exzWuvZnut?=
 =?us-ascii?Q?SjDq6+619kU0lwkgnM5aUNSQby9jobjlag=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YSlqsvhAnbO/Eq2IAADmhulvGrYQn2dnAvSODUtw9I3UfVwwJIJ67QGNyj4M?=
 =?us-ascii?Q?grrF8Y3GoZ/ETGO7kmP6QW3XUDvldStQRDgf/nGHQ9mGKXcg+b44+hzHxbQP?=
 =?us-ascii?Q?6piRIc/H8BOzTounOVvl6okvDadKU1aFixLg9eFcwPM0dh17KZ/8lW4eZS41?=
 =?us-ascii?Q?ZoE7jTYhfPDY3JCM+DC0Os3c/hFy9JWD8nnNHYtm1W6LQ5OrjLVN00RLrnuO?=
 =?us-ascii?Q?mcd/4PHVLOjjj2I0IowHU+yMpYn/sSp2juWubfu1mNnzPOm0t1WV+bic89C5?=
 =?us-ascii?Q?1EPSXIN0bZ79ElNoFBRnL76rUfIds2ER2Ax3SL8f7OSpcYwR6BA/2wZQgMbY?=
 =?us-ascii?Q?lH6gFpjfiAc6ETuCXCRrKhec0beOX1Hhe6fd1eRHA9u9PyR10bWhhQJL7BJp?=
 =?us-ascii?Q?fwnkv0l8/pw7HzJChV87sSaJAGxo+KZZnHv32GJfsHTV6cMIT5eLggBhkzlQ?=
 =?us-ascii?Q?9kOl23/obZVgSQJyjmZZVD8t7r63GIbL/+T6OveJOhNCO4xqgeJr34vFcHvB?=
 =?us-ascii?Q?rJyZ0VdklLJHSkdeHo5VOq7lmwwRYrYknJO8gWxYQmn+d93ewFxoV3Zg5VMj?=
 =?us-ascii?Q?X2yeOG22DBvxn5/4Y0SKzpi4jieBit7RwZsj1tCkN88w6c2oJZ2vZRyx/IQ9?=
 =?us-ascii?Q?CiHpiZ8gLvzG7hIMK10k30YV0ycYZvp8gkj0SAmrIhIOdfmgUmHNv4cgxpq4?=
 =?us-ascii?Q?dZx8l3DGQlM26qgZS1be1UVbBbbbk76+lfjMyLH2MFubkcFQT2eaCVAmDYe1?=
 =?us-ascii?Q?u7YXTa/3gcKIjKj4IVz747hBYIPNdkIsrr+Kxv1SSSmxp+0jez/pJDFOJ3/Q?=
 =?us-ascii?Q?F5Zxg6HU/zBHhKgd0xWYEgmn5wgx3YRuqu0oHWrVgUdpylIrL0eBC8urofxW?=
 =?us-ascii?Q?UKZtph/kX2qisnsqET6tnekfTFMTvab6HUPuratVLewGHeciNvQiumVXik5W?=
 =?us-ascii?Q?UKWL7gKOcluIm6AVcOj8URU6fWJ3xgE/kT8o+xvxFalgus7aQRpPswLsxjzO?=
 =?us-ascii?Q?PnLlKUxLIrH0qpJ0NpOfuMbdnwgNatPFjvlWpF+9M6Am3BtaK+vF9UyuC/Mf?=
 =?us-ascii?Q?7zmbM1818ALHcb0yC2xfAgAkIdHZSs6T6NM7sxJiHyFdDoh9z7gTbPwTPqKc?=
 =?us-ascii?Q?RFr7LKnvBk426mlEJqvX/bszqw9bmYEwuekY4BzFyh7jDmueKuG37gTjvLv9?=
 =?us-ascii?Q?IjX/DKDNT2+n9MMFBmDIgc3trJEe9418DVPi6cmUATAFtfbONN3gvuPXqVU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c62a6931-b8bc-42db-ca1e-08dd8d7ea0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:48:35.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8989

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, May=
 5, 2025 5:57 PM
>=20
> To prepare for removal of hv_alloc_* and hv_free* functions, use
> kzalloc/kfree directly for panic reporting page.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/hv_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a7d7494feaca..a5a6250b1a12 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -272,7 +272,7 @@ static void hv_kmsg_dump_unregister(void)
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &hyperv_panic_report_block);
>=20
> -	hv_free_hyperv_page(hv_panic_page);
> +	kfree(hv_panic_page);
>  	hv_panic_page =3D NULL;
>  }
>=20
> @@ -280,7 +280,7 @@ static void hv_kmsg_dump_register(void)
>  {
>  	int ret;
>=20
> -	hv_panic_page =3D hv_alloc_hyperv_zeroed_page();
> +	hv_panic_page =3D kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!hv_panic_page) {
>  		pr_err("Hyper-V: panic message page memory allocation failed\n");
>  		return;
> @@ -289,7 +289,7 @@ static void hv_kmsg_dump_register(void)
>  	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
>  	if (ret) {
>  		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> -		hv_free_hyperv_page(hv_panic_page);
> +		kfree(hv_panic_page);
>  		hv_panic_page =3D NULL;
>  	}
>  }
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


