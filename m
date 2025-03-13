Return-Path: <linux-hyperv+bounces-4492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C96EA60257
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 21:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401BD167915
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5B1E8353;
	Thu, 13 Mar 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rSY5PbuG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010002.outbound.protection.outlook.com [52.103.11.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77313CF9C;
	Thu, 13 Mar 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897212; cv=fail; b=Iqxk8MvpXH2+IJOlKqAVnlDODxcWiT6NVXwHDeXwppPKr9q0znkWAjxjAZd12X0H/QNm4jP21e05j1Xo2opRadRy0cXjAScWeqgOT5dENcwpLIN6m2GG0n3pWXlvEmL9KMFeA33VALdLbh+R4xwFuTNPV2DJm6gjm4NPaAK1SoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897212; c=relaxed/simple;
	bh=9yNqWnqrLGSugIrwQKaUg/rY0LF5BwaUNxIaTjMA+j8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7Myn/WdXXLJJKkhVAnE/GrTsb+cPCztiPNyEeTuI34ihjdvibLROtU0c2ZAmS6eZ9edtcLYd0E/o/jLR8uNMkSYKIpmi+ptWDkBaHhysT5mx9HdxWKci2CsDkCh9EsN0Xx+P6VdESCIWi+db5sHwvt2nGwokownXR8tgBf9ZBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rSY5PbuG; arc=fail smtp.client-ip=52.103.11.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlVynop3bBv6kzJiUoQ8mvpNlCNiNDpdpCjYgxbNnLsaFLkU/ZW7kkKlwzYLyvjOFMvQ3m33RenRIP+RaQAKVQcJwyt+ZjNm20RfFXoBH0eAmW607O65zb7pzulu8xNjyedj97W+5R7ixJHgZIVaTJDCLgFuudD1d5X1iSwtGrmPggw+xo8aKxuD6aUC2393ybbrGKnEXoqQ2LrEUnZ6w1VYvUHmfzcDkPCvzbmO1O546nfsmdqIlHoyEevgnZKh9jFVKF4LWoIMMk7ieVKzhpszamI3jmoJaTWd9lRLuYszlgsXXmGTOYBbLg28CfQy6SWUJ6sBd6d0+Mij87b48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwRxqM7/cG7mHRxRn+TSaLl0BIzMY2NczCFIHbKk/ms=;
 b=yxOSwrDzgOgwRoUMdQZ/pXAWOlq9vBom+Yh5b9oDKgPGjvAm83yqdt6PwEZPGOkrvi/QLuCjenQqIGED2IE4UkxfXRAjv1/S5KuQOCj8rw/PDLWvydNAEzE5dLYUD+B8OZxORsvavz+HIHWqN3lRRnSHiESQOAeSC9ArqR7A2pqZM85nYKEVJZFuPdOV22QNbmu+eXO0J+M24vXujm1O16wqJevkmRbVHyGLmZywJ+QRb/0QJDPqV2nz3L6tvPKzv0GFwDB60RLPDV/VFWBTzMUxfEpp/S7w1EeLJlBAHaO7iIT4jYsBVpwpnduUngt0l6OkMf3qjJVSKMtPOq9NDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwRxqM7/cG7mHRxRn+TSaLl0BIzMY2NczCFIHbKk/ms=;
 b=rSY5PbuGF6eLzeCDpqwRa/ws7PJaFFhXmAGyEgEKvYJ0RwPWD8h5qruLv5ESeUAFaKwIiD4LZPVbPMVXFg5iLc6yQqeVCShN+kwbjrxZTHQDvzd47bRcb4CWkzvE/V8qXBk5TJqyK71vahCJKczIZkhvPOvpJdHEPtuBR4o8kMLYYRzbN5rDqy5/8+SxL12E+M5slZpRzuDxe+42/MWQEUBOtXlfeB9PddTfAgYawl/8YgZlZ+8P+TkcVJt67tE1I/YaGF/mbu/QoSOe5HHAZTz8BeqikCTcSOdBjypKQUJdPe0HmAt7VfzgTbf4trSBnMjwoQiXIOivA0WiWq7Tbw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS1PR02MB10564.namprd02.prod.outlook.com (2603:10b6:8:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 20:20:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:20:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] x86/Hyperv: Fix check of return value from snp_set_vmsa()
Thread-Topic: [PATCH] x86/Hyperv: Fix check of return value from
 snp_set_vmsa()
Thread-Index: AQHbk/VKyYJHzU0pnEqUrqDt1okwxbNxgiPA
Date: Thu, 13 Mar 2025 20:20:08 +0000
Message-ID:
 <SN6PR02MB41577FAB4DD56699D48B8106D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250313085217.45483-1-ltykernel@gmail.com>
In-Reply-To: <20250313085217.45483-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS1PR02MB10564:EE_
x-ms-office365-filtering-correlation-id: ffcab00e-ae71-43e6-e978-08dd626c72fc
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3gr+YHKmSMzj5jlTHKVEqRip3XkekR4BD+6ukwZujgCrEu8JtAoPIuA0k+xV0wdoFm+lLuFLRIvi0gU9J2Di312TfHEZoieueSDfv7h5IOfxcQYa+VDISH1VAwgb4Ek0uqiyKxYkE/nCf2appowAdr3fJP/+42bDH1CLtXM3s9BmDX2lp0Eg29jC6BnPBpurvTJZWgb5NuJs4LynX0EPFyWHZ+OSSIKcUGBdgciEyGWK627G5j+l7tpDGOaEOvf8JuWFlw2eS99Fzzc9NOEERVI17H+aPVHSfUxm2qEIi51GP3OBQTnIEuXymUcNf6ZuoF9FGTK/+MrUon3IebzbYtnVQ9QxD/pkkTFpdV924qPvY7f8Zb47j556CuBL7tFdG8ONbthI25b6ELlKvOW4d5/aMiJcKbdO6cr5Z7xVbFQ9l+RTJS1/sWjES7RkVK6vb25baSpOIz34wn1tQjiY5Dsz5O3T6OMlG9W0+HCthafHXyukyhbI0nZyBih1gVXOT4+rgRDMWonba7QGABNxtPMMIGNNcMui8yvzR21IQfGIplv1K3IPIrXHKy6Ny4Vl2Go01e6Xhn1yFph/BQROG85A8mDe42ZuowDzcU4iEbOoUUpBGJHnZsmosIKGfrYfY5yG12BLmBM2MQyAhKX1cdazAt9u/S6CywLbkatePWrP1xZlkaYbNBTIUeELyWBlhgTJVkLW0Po4Q1Tc+T+HqEAlZn87+XK4Guf+eXFycWHyJURB54jtq66NMMksOgjAMVKXe2g4pjYSHiQqEvRDsMPS5W6uMquWX0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|461199028|8062599003|19110799003|440099028|13041999003|3412199025|102099032|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FkAtDk8Vf+Wdi61t7KmgWqWrm/5u4/2tgZeIPlyPmTXab2I8NrEzgI0ufZTv?=
 =?us-ascii?Q?mY5A2sH8ILl+5UYy4936hkD+DlXk9KyUgZn+DfcyLfVPj8bIAofAuu+NAZMK?=
 =?us-ascii?Q?z4Ed2jClbC7G6s37XXYLwn/tDsb6u2xjd71q6cGNBbZSP8FqEPNJCJFBrZM3?=
 =?us-ascii?Q?Ai8sCT1bylnGEW2AQwx6mdFVVWBg1SIyPHjGRRoV68CrXCr/0E84jFwtFF0N?=
 =?us-ascii?Q?dSzovZ2QuuNXxuNG9t9WFBE0nuN+z0dcO9ENaPeNL2igBpSlU8OHFOdzpdF/?=
 =?us-ascii?Q?TRiPDj+Cy+SQyo7bIdOaeSvyR+p8C26JT6Pp3yx9ozT9yxdCBgdINfBvi+Qo?=
 =?us-ascii?Q?0szkqmMUttwiYS7jZE2MYJRG3RIsvZfGa4q+gSqkmRhXlpBaIJR4hX8nRH9H?=
 =?us-ascii?Q?rKNcm8JRvnNUR3xeB4qP54s1Bj+rcX8AP5eSpwxoLjJii3ku6XKtmfLsPDxv?=
 =?us-ascii?Q?GDwXoZfty+w7wb0ujCcZSfP8D0YrnDz+5KYyUsbKvj+CDt2oZtLalANLVkTc?=
 =?us-ascii?Q?ZkrEdEanPvNSCekj2Iw2j87uim21kqhrmYHwyog0SfDj/iQitFRjpvMyokg5?=
 =?us-ascii?Q?JRljB9Cn3bhp7DZrVt2GjrPrJKZmKxKm5+KgDkWaGnC624qBfSaC0lgDgWyJ?=
 =?us-ascii?Q?TD3Bucj3Z1A4B5p2Uvjd7wys6KPhc3SMqNdkHrYCR2xrm1AMMtzPbTFmIXvN?=
 =?us-ascii?Q?Awo2VepLIS7t6jRgl+9UZT8Vhk3sskPj1vbCcRwZjHXc4AjEpF0oWu4GCEzl?=
 =?us-ascii?Q?Ugwqjg160XDqTFOXjNV39WeHO27wVzEiih5RmZxQqvOS24n5CAW7JkGWq/ys?=
 =?us-ascii?Q?nbT0Ptpj+8snjHUsBpY8P+XXE2SVWgbetctPcnEwBmLXAMXvSV9lNRbf0w2M?=
 =?us-ascii?Q?jOmrOOzSUKH2iE1UO7la8swzObWnMWDajH1QjrhK/X6ihFhK+87KIr41b/hd?=
 =?us-ascii?Q?gc14GX5d4DEpOHScXwmEtWTuYwLSIspKv3JkvphPnomV4vjjntfhHIqAoq3z?=
 =?us-ascii?Q?I0rTQAYUE3+GrMyuXY4ba68fE8dBpPEMm1sZQ6NFBoYvEq8CRQa1Q5xH9gJW?=
 =?us-ascii?Q?UIVz151NFNgww771tPhDgcgwAfYkbTQqgFjnbWFPEs4twkfsR2LkBjF9GW/n?=
 =?us-ascii?Q?2cJMYT+MwcMJtNrse/imvMRvxQ/D76yAwHoxlfreYSLRTglU48CGpX8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/fj+shSYDHIGy6eAHtR5JYYC3iHd2z7U9HuH5gb5nPujrydxnwOitHrYGPJ/?=
 =?us-ascii?Q?Ad8HgkBJ62W23YABIzMrDKbaTmgXi2tvtc6duzF8J3yeD6E6lEy1YN1ngQ7p?=
 =?us-ascii?Q?iL05lpQio1G6WijipDfkLRUlmgRHTZWPYgFAxak322PjRAlrfRVeb6EVcfiF?=
 =?us-ascii?Q?2XtzUDQ8diSI+P4XE4JE8+TSlNrnuDkR/5CcPejF296skLx3dF46H30Nd2Tf?=
 =?us-ascii?Q?oC09L9WFGY1cgv0zPLTnbj6hgVXB/HyxFIhPU7GCIdiLk8D0NkvqgLv79N2J?=
 =?us-ascii?Q?vl430/jVmtQE6Vb602fRuWrfuGCHHgLGfEZ4brZpPDzDac2oSHBiqFb8+Qfn?=
 =?us-ascii?Q?Xxeuz93PJfJmTbwovOKpYMbC6G3hNSYoG4bMKLCF8fu3d0zm1ncIqYY+FZUP?=
 =?us-ascii?Q?aI8rCLr3QrFWrGjKjgxAfL/uTgK4JKLzNxus3HXw67NqAxw3u9GAsEtStG8k?=
 =?us-ascii?Q?X+PH6SAFxjEpC6PDiOVYlYB2/Vw6RqN8eUykWGOg89rLJgrr4DV9hOARATAo?=
 =?us-ascii?Q?+z9EamcTUPyX5lh73C7/puYs4Ro93d8+qAweSs+gbHOMkfxoF5rdHl07Nzsf?=
 =?us-ascii?Q?YGgw//7nNKifMvs/Dy4LLlb+an3lqFw5eS/gX9Y0L8vLdAWttr1rQhWtg3bB?=
 =?us-ascii?Q?65YYEaI6hx7uc1FWpThbc18hiRSRaicX8WKSEw1LkHUsY3olMtdvVlAGvX3L?=
 =?us-ascii?Q?yXBaS0AhYN+5Q0CHu4ElS0QVkFbxvXdN2RjdgZAuPjK7LUHmRZ/rX9ys4SIc?=
 =?us-ascii?Q?4cI7+KRBJ0B3xccbD/Gk9O/4+KW3/JJ3n1UzgfKC4c4AgNlCh9jsrXCeZ5Px?=
 =?us-ascii?Q?23tRelP1Nl6LRBgPQKmRecjimpUIBaOnyU12oM6wftQsZT0kfpPyb/GJA2Gt?=
 =?us-ascii?Q?uQW6YSpDcf+YVg2CMAZpzX6OdX7ul7Zvc/2EqKZ3LVBJCuyz1W3JzDaJI9Xu?=
 =?us-ascii?Q?ngVs9qeFctgBGn9dApM46pDJABa0m7Ev6sur9y0DGrTMWWpWDmAczfswtZbR?=
 =?us-ascii?Q?JNhM9zqIrLa8ZrrRwALXxSUSPHVRAdP/7c/WgEjL2vytUIdiGsYV9qGN2Q7b?=
 =?us-ascii?Q?jGayHO9hN6GASSyIg5R4L0atleRs3IdV62xzN3tqhL/AIDqCJcaxhW4d04X3?=
 =?us-ascii?Q?YKaiK4eQyn0bnoT6kAoaxukOKc925O+bVLx6wGYCyeQ1kmYCrKM5AH2yDCuJ?=
 =?us-ascii?Q?IphSngSnUHBPDrkygXr0lcv96PzLmGgTPnWTdz2BBTCpeUUSAT5EXwqkdsc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcab00e-ae71-43e6-e978-08dd626c72fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 20:20:08.1130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10564

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, March 13, 2025 1:52 =
AM
>=20
> snp_set_vmsa() returns 0 as success result and so fix it.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index ec7880271cf9..77bf05f06b9e 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -338,7 +338,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	vmsa->sev_features =3D sev_status >> 2;
>=20
>  	ret =3D snp_set_vmsa(vmsa, true);
> -	if (!ret) {
> +	if (ret) {
>  		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
>  		free_page((u64)vmsa);
>  		return ret;
> --
> 2.25.1
>=20

Yes, with this change the code is now consistent with other call sites for
snp_set_vmsa() and for direct invocation of rmpadjust().

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

