Return-Path: <linux-hyperv+bounces-3862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE28A2D701
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Feb 2025 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619A47A3A66
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Feb 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030E1C5F2E;
	Sat,  8 Feb 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jTRhGSW6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013084.outbound.protection.outlook.com [52.103.2.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AF154C0D;
	Sat,  8 Feb 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029532; cv=fail; b=oKW8nMLdy7ZafcrFBOl0LJs/yWlrkQwU7TaRGNFNXCd2Bc+fcB0TolunOCnc/NGVd23rBhqzLVDPTwbUwwgZOThZYOj7kQUMlf81DZ4pies3CtUQ0OgpZRYJBjvxw17sqky1DurTNAUDnODbqAQAMP2MwfZ9S75NqMlkIdUNglM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029532; c=relaxed/simple;
	bh=7HOn+3uoGKIeDRyDz5jriQ73hgyf2uA8tQ2bl6cYKu8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCgNAYsJewm0AEwH8N3lHCOZ9d5663YU9O4XT4ihBwU+6IiwnB4v2Uc22E0En7NomEiDCQuMUNG6pdo67/Mk4yVQcpTvY/BQIil27CFN5ElOx+lVY8Qt90lu82XHDUusUcPKv1RZ6kAKD+xzLSO+qo/dT9mKkZ6JPp4ceGLbqEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jTRhGSW6; arc=fail smtp.client-ip=52.103.2.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOLq2Bmp7UK0Bj9YEEfHNkcH6sxc5xni7ACBiN/4DZqsglz2kJVweqBlibTJLsLEUJfG5wQ4xk/mC270BQEMuXdEnrvqCcVXMkqCJJ+u/cvCmQa8GP+TRlVdXgnrr+86sxVwl/h825qc2lsHMGcP6WYQPmwqKSkldfpRRJp52N0zFzRgFn4jnDenNCUvDP3+VI1yypoclhHIh8P2NE/4oYH2VEfYpydwcNLYoFtlaKAq00FwqKmsoilcDYU1E4guYQjNkHCdD5YKhlT4UVzgy9NbdGzCedaWtnWp82Glm9E5YY99HtAg99k3ztr3VD/4QHJj7E4BYBdwPy8sVX1Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=speSJo4o9U6GK9eBe9QT8dk1TLPvPEgCVWmKTrODfGw=;
 b=IXpa6AVBib/yl2vTkalJ5sxbAIByqUwhGBmCg6rB84ZfAggJwcMUNNoVrxFFiISCfDY/NReiLQDOG/hs3XeTdsLp+gColFA4yEg/isHylls5XC1UohrHjWi7xUpLIuoC2xJbit2YNYXPnbHsjIbRgsUbpbxiH2S63IbJpm+n/Q5rM6hLQZFSCjETw+9QoIqrH4GxhElj3bTNesKJDjYyeMW7WgtikrxvdmBkJi0Yayv1weSBfnnnGzlD6KapqyXo9DWF3ahK52rEwNtVp2qujjkiYa0ddEL6iYYhEkzxHFY25+B3TIdHTDkofIASSdd1XmEfk6ramentWjI+PQyWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=speSJo4o9U6GK9eBe9QT8dk1TLPvPEgCVWmKTrODfGw=;
 b=jTRhGSW6f0lp4xJsKnzwQMq+wHe0DaPFN6vh88nxWfOPdDnrNyqQpkF9E6tMnZC1NnTe4MCThLGzvzAnyvOh+ony5SBG91riQGgoSNa7LfASidS6c9um/gNrAYKbJf1XjbmEZ3ZZkFN/Tca3LFCUTlvv/d5R33U+/CYaerT2b3mrCN4Tqc0REEl0gV+NeoJSWoD0oycdExQCQsTgyPsmWgv/pHljJ5k1jBhiG97EanydWQFoiOuoYcyHydXbafkjNiJ7p9vCo8FrRWssxZG6z6f5631kI08uL6pBCIz8efH7UrkxuZQWpvC2/hVubYr8py+H5EEGXE4/jf/uxqOBsg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7216.namprd02.prod.outlook.com (2603:10b6:a03:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 15:45:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 15:45:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
	<linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Hyper-V/Azure@web.codeaurora.org" <Hyper-V/Azure@web.codeaurora.org>,
	"CORE@web.codeaurora.org" <CORE@web.codeaurora.org>, "AND@web.codeaurora.org"
	<AND@web.codeaurora.org>, "DRIVERS@web.codeaurora.org"
	<DRIVERS@web.codeaurora.org>, "\"status:Supported\"@web.codeaurora.org"
	<"status:Supported"@web.codeaurora.org>, "PCI@web.codeaurora.org"
	<PCI@web.codeaurora.org>, "NATIVE@web.codeaurora.org"
	<NATIVE@web.codeaurora.org>, "HOST@web.codeaurora.org"
	<HOST@web.codeaurora.org>, "BRIDGE@web.codeaurora.org"
	<BRIDGE@web.codeaurora.org>, "ENDPOINT@web.codeaurora.org"
	<ENDPOINT@web.codeaurora.org>, "SUBSYSTEM@web.codeaurora.org"
	<SUBSYSTEM@web.codeaurora.org>
Subject: RE: [PATCH v2] PCI: hv: Correct a comment
Thread-Topic: [PATCH v2] PCI: hv: Correct a comment
Thread-Index: AQHbeZOPTbepn/kxw0S6yEZY8HxUM7M9jWIg
Date: Sat, 8 Feb 2025 15:45:28 +0000
Message-ID:
 <SN6PR02MB41570947C2A84614FAFCF8EED4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
In-Reply-To: <20250207190716.89995-1-eahariha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7216:EE_
x-ms-office365-filtering-correlation-id: 00399910-083b-4029-d42c-08dd48579c91
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|461199028|8062599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?RXg1a7znmKYJPYT8KAFpnakE8Jkb9BD8qeS6pjJBvp9sW7J9bbDQjrD8S0?=
 =?iso-8859-2?Q?nBuygVzjcjNScT+4W3NBstgLwEsxkCwnNC0tb+yF/ehmGnPHnorjWJ0ZGh?=
 =?iso-8859-2?Q?3S8TOyPdEAN7rPZ5dhOvb8j418ARWO6fOUSAX5UinYYQEp/ITOW2+3sFXF?=
 =?iso-8859-2?Q?QJoJQuXxg5+me5khP+I5d0jlyEwwS63vBILmPwobTX+ub4sKmGWP20Fo3f?=
 =?iso-8859-2?Q?m7uYir9i5RHjNDaLjn406+8QynsaYHtQymemUpQmxjYNyudd+6DYFMFva0?=
 =?iso-8859-2?Q?so91mck/2LH3BJgUxxxSERL7K1iIv9nNgQqo9Ahyk+aSxhh3ngcStXE/ds?=
 =?iso-8859-2?Q?wsIiwj01QaNvCTzC9nRqB4ZojOS4UeqsQILYD7ohgyJGJS4MCEUiQAW253?=
 =?iso-8859-2?Q?VGjOGCWNhBEk9SnZXA7C8xA7jkt1WvbqTwHy1b3qQgqBdZF5lZrnjo6zR9?=
 =?iso-8859-2?Q?VrZEOal2VRkuCWMZVSsXvgfc7W/hVzb+yVlDOEXHNU980sVF+BwiGBG240?=
 =?iso-8859-2?Q?hF8sMVdgeEd49xrZpGaI23rVkiha+shCQzYQ1ZruQBnI0Ma6pmMinfukqq?=
 =?iso-8859-2?Q?C9Ou9fA6Qq1liRpvbiJhSuh6TPt/JbD8OU3uy4Lk4wcA0POPlsct7Ikz5O?=
 =?iso-8859-2?Q?KpgcZ571U0w+66/lf1yRm4HIxvbuXKymlI0rZPKrhgXpJchwNy+pizKxa0?=
 =?iso-8859-2?Q?iJzHpVPDcXajmXDM4KfcjdF6QxX0dxYffP7hJrit4Rqn4oe1EiYdYmuCZy?=
 =?iso-8859-2?Q?C5SlUYtlWuwAsx+FdsYDAyg0xCZ209fLGd4vHEFLMR2clo1kSF55rB1V1Y?=
 =?iso-8859-2?Q?AfqZFKrtLboymjQdjkimPfzY014zdZpQnpJ1DRKiZ+IqjFBQNqE877XgsO?=
 =?iso-8859-2?Q?HGf+FtB8dGk2QRIDXYNJRjYGG0GVCML3+QnZey4bUCq87y1b03/y+6l+Hv?=
 =?iso-8859-2?Q?n2vArafaBOMGb8fUEx8MO7mGHh4DLtlTNSMsAvq1zIkLgAcmqOorf1kzY3?=
 =?iso-8859-2?Q?YPOzBHYEi3FMyXPx9KVf77uwtbkkYYl5yYW6tM5olDwLkFT26yrIObrMMC?=
 =?iso-8859-2?Q?1yuSJr1mCXTtP8/lZAopoDg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?DDQeJxscfpVKG9BgGDUFngsGK64PHujWk5W7ecSB0Cth7YnLjSyNB3LYv/?=
 =?iso-8859-2?Q?jh4QqPCqGwdRsNO+x71/MjBaFR12g8+DCNssnOaHDrFAVKLP5JucKun45D?=
 =?iso-8859-2?Q?uB4lMjqUBqddAWaLBdVjaIk4APHdwSr2ul81bJohJ4lo34Omr+PV5GFgTO?=
 =?iso-8859-2?Q?GtaozYlplz1gAxPTpJSDsxU4oawmkGQ359tbDREr9PdhG8cfB/qPTdYrHG?=
 =?iso-8859-2?Q?jOhSQWDE97wzaQeat3GjDcIGUgVUvLZCmzoz/EdetS3gEiX31dkZ4robZd?=
 =?iso-8859-2?Q?0pmTPEl3DGFc6KHxGgRRUYbY175W2nfsqE/AnxNd34OeBadN6kJpu9BKVf?=
 =?iso-8859-2?Q?mQ7DHSbyx8ml5ZJwW0++cO+KtP6XcT70j6QNcDttHxbW+rkNDcabY3tr7K?=
 =?iso-8859-2?Q?wtPOqrJ324mVBqtvfDoMxE/YCFZXyfHp5WgdkL+gEVEKCIHsYRguajE5S7?=
 =?iso-8859-2?Q?1a83+hIbd4jkMD9i3ENmWIpH/YNpzuHtuS7o1mADsA2zf0XHdyVmcy/ZAx?=
 =?iso-8859-2?Q?4IeBsRfdndNV+jyVJWFG937r+OFLZr23ENCf1ZYlngN4WnEwCsjw1wvXwl?=
 =?iso-8859-2?Q?/ODy1YxUp27yQSudK3xyTfTbZklwnAkC9DW1vpfLFJulSiBx1u5Uve9OMF?=
 =?iso-8859-2?Q?g3eLBQAsjvefNlwtzQZaFIKnucP7DzysCKKhjt+CsZQhaPWEArP2GWkFrv?=
 =?iso-8859-2?Q?OkUADwF669WiSUPnqnzw/Or9sDn12FOYfO1buQl2RiOzOKGIo72wvOf9pL?=
 =?iso-8859-2?Q?7PBQCxttc+7/j16gCimv+tLEiOntJiQTTUc7RlC7peAJGaVozeTguk+X1b?=
 =?iso-8859-2?Q?FYKYrAfU0Y9AzFVEkkHpVaSm12CcABPiz02wiShp7fpix4apjKeVkP8r2k?=
 =?iso-8859-2?Q?vdxmM/mVIdIMUKzNKnEBPx7Pe53hJBdp1HZqsnYknlaxXY8+Tra90FzUrJ?=
 =?iso-8859-2?Q?FZUFYAuvFb9Wwy6aF4sIEISQ4Ilwgz9ee9k5zOD0VTQFbPT2Exbs/LUVdw?=
 =?iso-8859-2?Q?4YnO4Cpc7wGxkjT8qdBS5DXtpJAKXPNgzWkTiwJKhRiuXKwB4r8y4ipD+K?=
 =?iso-8859-2?Q?86nw5tQexpeubIQoMJSTL0sPNWnr7YhErqsR4wZSTwtyjWdmpwV27TpegA?=
 =?iso-8859-2?Q?/bD2OR36gVoIa/HFZaob9B8ZEcMiOgA0khD6Hpe+jlrTxYZ8ipAY26D6lF?=
 =?iso-8859-2?Q?QqnrTHcgQ0ld4Inu4gNEGD44kT1wyxgcFJzf28hSZHSVzNCUyck/wtqVd4?=
 =?iso-8859-2?Q?4GYFQoXHx5lrCfupTK8DJeZiekh2iZk38iG4DAkts=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00399910-083b-4029-d42c-08dd48579c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 15:45:28.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7216

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, Februar=
y 7, 2025 11:07 AM
>=20
> The VF driver controls an endpoint attached to the pci-hyperv
> controller. An invalidation sent by the PF driver in the host would be
> delivered *to* the endpoint driver by the controller driver.
>=20
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6084b38bdda1..3ae3a8a79dcf 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1356,7 +1356,7 @@ static struct pci_ops hv_pcifront_ops =3D {
>   *
>   * If the PF driver wishes to initiate communication, it can "invalidate=
" one or
>   * more of the first 64 blocks.  This invalidation is delivered via a ca=
llback
> - * supplied by the VF driver by this driver.
> + * supplied to the VF driver by this driver.
>   *
>   * No protocol is implied, except that supplied by the PF and VF drivers=
.
>   */
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

