Return-Path: <linux-hyperv+bounces-5276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC505AA5982
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 03:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB614E5501
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 01:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3E22E00E;
	Thu,  1 May 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KxRFTNLp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011032.outbound.protection.outlook.com [52.103.7.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6C22E3FC;
	Thu,  1 May 2025 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746064564; cv=fail; b=OZIK4DqVYh9HEPxZqKW3i2ePCMmeznodqyN7tnOJeemn4wPhO7iPnGgYMh6ElCrD64PgC8jyy53aRNd6X6ES4cgP+DG8mZTPD9PDwAfZk5kkqwqQU89c2U0CYgpw/QR8gU1dBlKOcbv4H1E9jBcr/a1wanI7ZXSzbitnQiWfb0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746064564; c=relaxed/simple;
	bh=MKNAX1dxThbv2bjr22Cvk7ClS/Hbhoub7etCoA4HvSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwPpW9f48CJxNU7TfMaE2wWpSixCtsPMa+kwQMWV3/3ZEXomLYESBWeG+N0ukFRQTADaFE6+P73TC3VgofOXEA33/0sBxX54+4HLNbgUltRIbrRPhGWEZ9h6EJlFZwc39J5RhY6awsYdzBJo9sNX7vu25UZ3oOLEaBngQtJN9n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KxRFTNLp; arc=fail smtp.client-ip=52.103.7.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkva3YqE8WvSGe8oeNRtfnl2gtY3RgjJZiRZtwcpyo3ptUapCgKU07SoX5oN4OQymIliwIvd2MNFokvx884L70K/YOlkMZTMlNSk3nuMBgSeCacygzX+wssHkhMRupZCA/ARV87Yeh99Y9FyICZIguSf9gSaw7FUY5zuKvdlhyMAr7/yN8pSuaWCviCj+YwZgRML61iNXARQtyhsdbx27bIao2wyNi2KVPziIAfE8PuJqkgVDfNtmSSCUnM7GdPZ8vFeNO5vbM856eO/Fp9N+2BmL6Ma0kQiBzqWf08ya365KnpZMWCCGrW9LgmcM7J4PtFUDcwi5E8fzpy0pDqwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NO80FFJmkvt3Xy2aTrFO2F2pHem4q/USenPWXqOmdY=;
 b=izEtDUIdppKGF29L4KDVl16iWKUPawvSnJDg6R9stfqiA0o2RXJQ0HexIzlcQj8m4ylkzvSjLZhFdD30UjOqEvREV9zuV1zXkgOh2KaBz4hWd62Pb4W69sxvSa1FYQLOc69Odc6VUO2aMXaonWCaBcs5Z9iXOsS6wVeiSXEUd3ve4QHofuw403/cbSoN0l+uGqEj5aSZGW6MXmBfn7p2H8DzlSP7UEf0DnY2qs0v9HjKqsbg7zYqqWMkhuVPFrDhSEaw5yq1dt7yc8mrjsHtsb3ydCJO3zov0SKSNETXlC5OqyBpX0fkyRPBjEtxHnhzmqGRNPkJoFhUy2yC+HuOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NO80FFJmkvt3Xy2aTrFO2F2pHem4q/USenPWXqOmdY=;
 b=KxRFTNLplfSR2pM4xjie1gdVCvvgRYfSQvyfiXDE23sD6Jvh5HAl1bwR3B/slu4085dUMXrK0ZsoKCwBe2IzCsC37ral+nb0rjWaSI0N0AofgT0ij+USVzziq63TzeEwZhaCj5ZY/EPAiZjwBPKXeJRfzCSBGIdw9mXQFZjPaG4vo6xpWffbYJ7SB+ZNTPImxr/N+nKj64fqDzSvMNYNODY9h5wwLjy2rL3HSeq9Q6N2N7H+PQPMjJ9hU+/v0EBkqyPqwIRycAfLqEvj0cy5A3k0VHykOFGfTyzmz4ZP2LNPDhYSV7rRNtPwHaZycGEtmgOdWreHCRu20WQub2gYgw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9568.namprd02.prod.outlook.com (2603:10b6:930:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.15; Thu, 1 May
 2025 01:56:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 01:56:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v2 3/4] uio_hv_generic: Adjust ring size according to
 system page alignment
Thread-Topic: [Patch v2 3/4] uio_hv_generic: Adjust ring size according to
 system page alignment
Thread-Index: AQHbuhwoM6FXPwOcrkKT4HVol7d/PrO9AzBw
Date: Thu, 1 May 2025 01:56:00 +0000
Message-ID:
 <SN6PR02MB4157012E94E1C90609860357D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
 <1746050758-6829-4-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746050758-6829-4-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9568:EE_
x-ms-office365-filtering-correlation-id: caff6fea-a7b5-4160-f6cd-08dd885352ad
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VZwo4mpOER2r1tzY7KfIDgGEW53B9MIY2MMJHwUzXsjmA2hrCFUF5ANkNSmoixLA1QyR7zZ4q8MO9FTUlZBYlWFyYXMLwFTDs8mkD7a2LcPJlqHytsjL1ONsJsWbTbiaNJwPuSWL6PE8ngnUDrDeQJoIpu8obMVmt8VGDWNj841/57c5nAWNun1fmeVBjJDd3fVCAZ3Wxk8i76MEpzVEBraJzgn96cGa8sVAZ6rCNqJ1ZTcMIXw/kjaN3C+Cl/vY58H7pQ3MIixJR8EkepTM2pcuQEOwprWVHhJj72NbyDciA/1xt1MNq0Zmpm9WmXnNYaZa2/ekAOfpByo+8Qrg3nm8Pv//tZZwFhyI/iOxS45w5FO3/MsXXbQ8UMiCWEUc/19fWsZoFN6d8OkkeXwtmgdB42giNHzxDlKF/pdCPbMXXMZDgEsVnkKWRROyJFDHubvBW5BaP/KKOJfAPynA6cnzN3qRn+3BDM8pov4ysgjzuJgcLQZfuWWWTSiOReL5jJoM9Hv48x/WFpsr9rhVogzYlMxE8ar/qzbhjk7OW+DcsA9tmevPMuggm6RauQA7x8P7OPiMkNPikXw3eQHLbDeHzQuWExwvUQeB4e4FUTggsCC0R/2BNVmmf8oWNNEOSbhQknjjQabikQQWOZcPkvKo+KDgL/vTXMlba5yhM9CZfHVX/Qsyha5WAlVS6AEMg8TgQy+GSe11Q==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8060799006|8062599003|41001999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X1JUgAtejzYhIckgIxWFzXmJ1TynBFUKJlpF5waT84JHyBor8preWKXWFaGK?=
 =?us-ascii?Q?EBjbsDK3y4Ch4NC/xaDNbFi1sHoRk9+G5mHzjyToiQ5DIFNVeP09Pl8F0vle?=
 =?us-ascii?Q?5mBZ0f4MBLxs6qfRS+/ci48isw5h4jMZeo33q7pGAWH5mOjfyj9dWgBIHG72?=
 =?us-ascii?Q?84WmgiR3Ay23nWnnJKQ08HqB7vhrMo1vMXFF+xU9EwpkeLoA4RLiyG4pXFlM?=
 =?us-ascii?Q?3ABDlqWxAFzaiRaO0QUn9eCuFBshH4kn2DKgz/yNYYYfuImK63HysFvKU4sE?=
 =?us-ascii?Q?NZvVYUI9CfbdTZP6YP9BN2ZyW7yIcQ+yn4PMLf6Kn7/Oiw2YSZRuSwS+THXz?=
 =?us-ascii?Q?OKt4V6HhKGky+vhyabIdXX94taMsi8SKRsW6G+0weB3uXZ8JMQ+5vVIXa6pX?=
 =?us-ascii?Q?bcMOkRkltf4a26qiuAlEmNfbhQaIMLvSGux4sWEI6wrQ6ZgHaqWhMsldAs65?=
 =?us-ascii?Q?4xObMSpCM6KTO5gkZy2+aKc4nOEjydq7+jYmoE/gqVqV1/YbLXbsr+PA22tr?=
 =?us-ascii?Q?2ixGYLjK66Fh/h7GKCdmj8QZ4XQSmUp5wMRpy3fEaCqwMNZbneyAQ2bY5jEA?=
 =?us-ascii?Q?Ch1Zajl8OEWmGBVpItlqPVLuflMWsblL8eaodC8xkTb7WLyjb8MYGDCD4+iI?=
 =?us-ascii?Q?n0egtrUAA1YTZja8Q2zigbIDSQzQkFh+QwF/TQQu3ik/MevqfBzizG+P/o6C?=
 =?us-ascii?Q?GJFrVsYhdi53JOrxVUCshfPPm8H54Sdv4a8KADLQKLndMmTFc9nmrYTvWmg6?=
 =?us-ascii?Q?p+Xu9S5uVKWIZ2wjsuD0I9wvWZqLP4CyegPQHnbvPjZPF+AICkQPscelRMRw?=
 =?us-ascii?Q?DivO5lHKHoIFzIZhUOp2P72C21q3sLyuxY46frUSnbeRpwwVmpdmnDOHkY7f?=
 =?us-ascii?Q?+kyk80HN7eu5l4o2d7z3VTDNc38TzmiCfVus2x1+mvnIIC1iehdfz8qSI1NE?=
 =?us-ascii?Q?1UguEf2UWLxNlJr19UTAKlClXEfWofr9qqBWDAUi+/wvHhD9sxCk93cSHi3d?=
 =?us-ascii?Q?iDdpazleC64uGKW5QKFLstztbzsbDSAsX9oXuUNrPC6/z/dPEL9BvU7HQtOR?=
 =?us-ascii?Q?p+rk29NKAqzAwx+bzYR1vIw6BsG6YjmZgefibqOFUXEfLDFFeSM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YxCh8DqkIBoYc3+UXB119dY33qr/9/mST/MygJr0KtVJJ50jFfcbk6mRpG6u?=
 =?us-ascii?Q?hmPbbn1H18rUTYqKsGnUpTdoPf0j5hz9Ks8kTxKidU5hIfrej+S93dTp0/pX?=
 =?us-ascii?Q?fV7PVwZnaK5ItY6eLjoYxSxnNSvBlqhVokhmbW6pruhKswZav9/GRm0CURBL?=
 =?us-ascii?Q?nrauDMnd/eHBXvgLKWDpI1Lpm4t8m0BCsttGBYBVgFntDJFsGEQ91iz+F0hf?=
 =?us-ascii?Q?wnVxJrdKktSfwPhpQCE+uto4wxhUOnRnX/jiBLstKS9vN3veOtMWGOrEPRZ+?=
 =?us-ascii?Q?+ztb8XR0fPk5yBAlS+d6QZg4fyzCTAtjP/3+aUi1lHXcvYIUbCXGnaYM/BRA?=
 =?us-ascii?Q?+cdwPG2xkyjg0Qlkd7/HrtoXslXf1zzg6SaUHbjRETb/RGWGv0as7uqfgxMX?=
 =?us-ascii?Q?Xd5dEir4zWBN3Ro0w8lJrRhu5G8rt/gJcnzq0fPT3/uJfDqhEgfpsFjsqlaJ?=
 =?us-ascii?Q?YedKacFK2ZdVs5i2771W5IERmOTZpleZF/zUEnLmtdBg3OnCzkDfUDxnIp/a?=
 =?us-ascii?Q?mGGk1jQtZkRh7XzyCQukF3jOPKiRzAP6QYndY+DbFsM8lYeaaT23Fx4GD1tF?=
 =?us-ascii?Q?1hEv9SCQg4CwA7Fg144PAJkA7zgFreWPJnFJp4gm2EZ+fljl50A2falmF/L/?=
 =?us-ascii?Q?08X5ogBGYDPar0Et7JoFpwT5+sM3SbOIE0lfHKz9We/fTlhUURe+bw/6NC/C?=
 =?us-ascii?Q?J0JzGoOu6t6Kbh77Zw7Ra6KNObjJGsLE8FXtsca4+uTvZtMhC/YTev6SxWAE?=
 =?us-ascii?Q?0mcndyTZxXqZZvL4eD06+OqcJXBUGSqhWzQ/BqL2hZc89sQa4DZ9PCztI7KF?=
 =?us-ascii?Q?fmOkCh57OLnyoLnjLDrMuuCs1IlWkdEEUlQSSn3dYR8feaA/E2f2urE/97wA?=
 =?us-ascii?Q?gwxQC7yXo+I4yG18tkI1xsJCDaWi4cR+8AQnxab5mYxbbyo6JPuK0k+Q74cN?=
 =?us-ascii?Q?KBJlVJmQJWzUDwmlrgzrstxLCibCF5Ta1wsqZa27vfABVGTFxg+rCc38F9Jz?=
 =?us-ascii?Q?jAz+qqO/G3lSYeDrOmnKcUHdsR7vibt687/ZUs5Zuds7Ykk9LXMQ227os5fm?=
 =?us-ascii?Q?n40yrixAfFI0XcTbcAUS0qvbmpWCFRMqVzrlRyNca4ift4JCGYuPGDqUqyLa?=
 =?us-ascii?Q?ofmHrd/lQqTmTlDjnvo/q24P/nU5s1xBsTIkQQE3FvoFSAZdizLypfHN1VUB?=
 =?us-ascii?Q?jw/6IlHsiZAqi52OnD+JwzU32AJWePOZdbmrLMb4tACSyKKBYZzOPTEfnyE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caff6fea-a7b5-4160-f6cd-08dd885352ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:56:00.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9568

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
April 30, 2025 3:06 PM
>=20
> Following the ring header, the ring data should align to system page
> boundary. Adjust the size if necessary.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 08385b04c4ab..dfc5f0e1a254 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -256,6 +256,12 @@ hv_uio_probe(struct hv_device *dev,
>  	if (!ring_size)
>  		ring_size =3D SZ_2M;
>=20
> +	/*
> +	 * Adjust ring size if necessary to have the ring data region page
> +	 * aligned
> +	 */
> +	ring_size =3D VMBUS_RING_SIZE(ring_size);
> +
>  	pdata =3D devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

