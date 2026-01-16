Return-Path: <linux-hyperv+bounces-8336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC8D372B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C47E300079E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485728C009;
	Fri, 16 Jan 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZHHJ1HJO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010019.outbound.protection.outlook.com [52.103.7.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20518E1F;
	Fri, 16 Jan 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583925; cv=fail; b=DfuatTlgXUDyKxBI5M1djs4XjAItFbMN4O7kXLRiwhPb0pPvPs73+uLPc2oDB+3iWE3J389pJX38Hy9G0AT0UKPWEFK5iOypE8ovNeKeYnYp2czp827BhfdOwNvOokSHlecssjVchF1ilOI8VM6ez1Cm68lRttHfPS0iruMZJzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583925; c=relaxed/simple;
	bh=qHedPZ1+vmJ7xM5U7a85HCUSo6qRsBreTK8A55r6eoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkEAr7rggusgBrsXzNjww0/WVH+AOoXg6vQmlPufre3mYbk9gN0ZdEAAp08QAmvhlKXlvgQVuhSu80Dloy4GeME5VQ1kyGnuOXHzPw1fQY4F2YsoD/ZJOdm3WrJCbGJ9c+WRbHHH1I2hx+Il9Aa4zSL6xqVwwp9AGuce29tM9RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZHHJ1HJO; arc=fail smtp.client-ip=52.103.7.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C90xqvdL68fnETFH8on5X/DOvIZEzNdsjsoNJW4whv5kLSkNcicckTwPJ7ZpGTZ6DNjxnzSSxCvzDSbuuxt+nNbQ7DFF4KsV2qDG5kgeHFm++4i2x+pN0mgwScpCuCtEvld0QYtVZQmneTgepnAmyDXpkOE0mB9Yb27/74o1ml1chFOdcD24RuH2+k40XqOaj9kPPULViJRysUPUJMW6Vmnts+FmZK+5+CRffOVkueddF8G+iRCMZ8EYSZu/ybAxN1qkd0T+Dx4cPtxi4qR74YnDmCU7Rjd6hKc3sMuR/4c/9aYWb7icYyr5bWTDeG1GHcLMDKXgIjb4zskuTW0qLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKYAzt05Qi5B0NEFLgsrB37FtgPr7xWeGcsm6hdjGas=;
 b=l+aOFQrrmreM/deLKLP/mbKC82g8EZwy5m2uPyYGZSa5J006DK/Fo4qq80sihs3ZaJMmNoeGQDbNdIyZXPFCdI/EFZ6+O6K8OwAv+396Bfksc1AFRhRaY9WcZaVSw7CTA6m493VNNq3hdY/vKqL6EFleetD9I90dA8NOr5b4HoJFQKmbBIaKtEp5MOhna72xfj2L6/5rdPtKCngrpTmL4jvh36SijbnIUgZP6IeJ195eo97NvX2Dl983B+v0HGT8AcU7VvTrpaycje/n7GgYttBImzSEMu6K8iP9SDiuwkxn44NK3txcdY26p+XFiF3iQoZe4QuY0WvuvM3YC87anQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKYAzt05Qi5B0NEFLgsrB37FtgPr7xWeGcsm6hdjGas=;
 b=ZHHJ1HJO3dbSxYBxnZ18iGVvqy3csN5FcNcJCj4cjnzFnYDfwq8kv/1R2cHRLBlwsS97y6viSO7cnTSt6Pmdw6RvDvGJHd9pmmarO9Z1RMWpBjY0bJuS3+4IQevfFadWtVPJXpv6Ii+aNwYK1CQrJP38M+1QHTp2wijVSuMy6NpKlSD1NmwVD700bl6goqWspFGjY0DnCQ1yza6XlUkPetU4nIohpkvp/X0OcXObb1aIH5KLKrJPv1ctPiyUSx5f3rHdMDrnLQ36vu6FyWxo20Hks7iDftdfXsTtuapYCg4/jsgi2iA5o1Hj1iDSicfUzS2ZVM8NMFylTEmuMig20w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9149.namprd02.prod.outlook.com (2603:10b6:8:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 17:18:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:18:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>, "decui@microsoft.com"
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, Helge Deller <deller@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] drivers: hv: vmbus_drv: Remove reference to hpyerv_fb
Thread-Topic: [PATCH 2/3] drivers: hv: vmbus_drv: Remove reference to
 hpyerv_fb
Thread-Index: AQHcdukiW7V7J9pkmEC7Z/gNYeylzLVVKQsA
Date: Fri, 16 Jan 2026 17:18:41 +0000
Message-ID:
 <SN6PR02MB4157835733E027C3BBAD0366D48DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1766809486-24731-1-git-send-email-ptsm@linux.microsoft.com>
 <1766809622-25388-1-git-send-email-ptsm@linux.microsoft.com>
In-Reply-To: <1766809622-25388-1-git-send-email-ptsm@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9149:EE_
x-ms-office365-filtering-correlation-id: a78c1404-4d06-475f-eee8-08de55234c04
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmqhcEBlXno9HJGOoZcx42eNIVwP+OxIit7tZkh6SzmV42Wdl6Sn5TYCMGseqW2uOnN2iKoFUtnHZuiIhSKvH9fRwWneSB0ccBuMwxvreiyxTrhZVTOnVkMI+pfvB4fBgswm4d47MSuPQt9s9WWChrzXuebKh/HWjSX+bEEKAQk9LVLFXLAwXHcWsk267jh5s4OBP6t6sHQIr/GqGwiUlgFlbGhV2Ikj4jUNEp6uw/ZYH8+RsmW6NaRszCeMKiJ147nrFB0/5nlCrQWlILW3vG8hG+yUDd/bRx8tI0sILMFOl5C1OgPOxNFo5/XUcKkHq1DScqyFcMXn/X8oqbC7wzHrdwubo8MCTzxZPIBHjEymY2MLRGheNeJPLJ7XUUmD1NWgLDM/qwaE4jhM5dEqGop2DmlAFPfsy5r0/S11YPXTlg29w/YknTK6GAalgprIDG7PNryQ0J3tnsrakl4UhNXEFbXoK8ghvrwBI1610TjugXGbo3/GLcdmxPQND9V1sxXLSOs07Aa3VlYhw4mMsLN3BLdzPib+dHWG3ByYfsaLLnb+0CRmWL0INXDigX6Cr0h7I5cGL5Tb2HwUz2+NQ/P/644pPyagislx+5C16iJVas9rzPW5Gv/WYLt67Cg4dKC/JlbJCopiqwz8voRTiFX8EHHDCwEf45y8MByLkTvtDDY33uhIW9KnHlCF6SAFW3qmQip7LOKQcDA7eMErgeGKdwguBnqf2wh4rEfkGCmLoOR3U6zr9O9WVOC3OulTpdo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|13091999003|8062599012|19110799012|51005399006|31061999003|461199028|15080799012|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YPVoTYIcTMhv4TOdgdz/n8Nxm5pqpx8jktiXGudvIVdIyABIdEMR2hZkOgmi?=
 =?us-ascii?Q?CVN03hCfyBRFF9xmN1rZ6srtD9sflGTLo2ByIYvPx+F1FTw0vRpXnvqmyU8/?=
 =?us-ascii?Q?mhcNp0CNHulzHfsWGRb4vvBTxNRaelV5NZeUdLxtyElifLhVbOVnwiT0vCo3?=
 =?us-ascii?Q?LkgRJ+wbfS0+FZ6pPcx8sdNmzFgJ9pr99R+qhIhqLLHpKsgEVs9pLVi9tXRN?=
 =?us-ascii?Q?rxWXBjlQpv767CLkOsKpDhzL+Snd4njahEOHwoBIBotQR7NQFKfOO0seKpcI?=
 =?us-ascii?Q?KIgbYRYutWvgFUySz325Oiqm21jjcCIlLND/RXwqxnawoVC50FpZc4TfjBGX?=
 =?us-ascii?Q?FkElNzLRLJ/IstAachq+yLzsRyp/UTL+AZnhx1DQyK6BXe3JFpJOd+u8Txp3?=
 =?us-ascii?Q?xAtZM85enCH/Y5fVlY6fqCmh/E/li6UNVvb7tnvXl7bd728bKiyhEiUgaFEg?=
 =?us-ascii?Q?j+hSIEGyYGsNbMebGVejUnSKV0bANClnl7QgPXFxEpPfhJst7TyhBh8pFU63?=
 =?us-ascii?Q?efe/t+nGqHKdRNA22a+96wtIgIFhqyRDil/uVoqaaPlAKenkQ7c9S8L/jiPt?=
 =?us-ascii?Q?8c+rzi/fRBq2VDNZGc9OA0devmN52cfdDP7IGV4WOL/zU9emhsdbsyPqdMkZ?=
 =?us-ascii?Q?Hop+yzHqcSB4jtYXiMCnAzUdzcXiFg1+DMYQijAGVJ1HE/XCWiflWqfLtcE2?=
 =?us-ascii?Q?s7SY8lstPFS7F2SDIwZGUo3T4QWhZ/oT3vWgkAsoqGcf1p9Kc4o+c84UCuWq?=
 =?us-ascii?Q?HXOWkkdpd8QRk+pRWs+5O87srMVlO7iC00bejq/0dwT6Fz0Cx06OTuKqA4KG?=
 =?us-ascii?Q?3TylSrZNof/GUxPBycEkCiFSztPUHXqef3lArwrvnN8uLbpoEBZqFF4dyMuP?=
 =?us-ascii?Q?xTADPrGM/CVuLbij2WWCLxM0TqcGeOuuedfGhKynlf4vMQ0TAnVlniDNlwnZ?=
 =?us-ascii?Q?wNEGHKFA+feXiTcQcI3vQ/UX67PHscoMjItdvzwcQr6S8vsseMrIKqj/wch5?=
 =?us-ascii?Q?jex3j10TIfJAJjCq/fHdcM/IMh8GLmwHVz8/jj2Bty2GLO9NGRgv/y5GwTO7?=
 =?us-ascii?Q?Empv7cKpKgRcHLY4vpEG3rNerBM4/mYmx5tee0ohsj286ikkR9hkcNoXDpnB?=
 =?us-ascii?Q?2Yhf/JsMQSQOFP1Z16hK4o6QAPvP523+efVAvUsCqqK2eaMdzzL0sAJgEljE?=
 =?us-ascii?Q?qAV3iEbcYd9+BSHY6s/AT3cs20hEO8+36pkaGQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VZZRTVoJeunqOJU6aWbV/SjPni0V10co86jnYI5cQWTOYPRZLRvsTJXMxXTG?=
 =?us-ascii?Q?Be5Uo5QXJfteGl7vkFaf9NluXD2epLaRoqj/+MQl9phfxSwjPluoW1HBAmnN?=
 =?us-ascii?Q?hixnP0mKm0hXqVFAmxPvO5O4mNhYyjYiiGqAt8e6mPMYKzcXSCjuel6Ml2Xr?=
 =?us-ascii?Q?3VQEVHCjb0nT2Uib619VjLR7zVVQumh6aUflVU3MKlwoNr6rOLiUZ4Sweup5?=
 =?us-ascii?Q?w0uxrwiTgku/qYZIui6/PmVtO5Mwzl8JIX63RUk+LmBWv4wHrDx2VR0Qx1qb?=
 =?us-ascii?Q?s8P2iChmtfeJ0UXZW1KGO7R/x8fjZGr6zH7kk6PYUNh6SsXBueQ0kKEejOhd?=
 =?us-ascii?Q?gn1DBqFL+PDSoKENfEEuhyBZeGpg/BtR9+siei3Tp2fGEZGuU9bYm4+CjGyK?=
 =?us-ascii?Q?/FaDb6G4eWHVboTT5AtxRHjRuid8EqNn72Ks/SKVraVov3IAcJdUmMH6pp4P?=
 =?us-ascii?Q?gRJkrlvNVW0xyg+tRk/Hmciit9r5Z3m+L43Y0i9bvbFU9z2V2sNthJ3b4Wsl?=
 =?us-ascii?Q?+DRDxmW8n5DDC+bAOOQSO4kaWkC/Tjrzn6F6E7aQkGAXeBijh4HUomGRIBIk?=
 =?us-ascii?Q?nk7hzHIogmG7P0whXrBTAre+kRUIhfUFcd21mN49GxJb0tErU6EZ9uDMs5kS?=
 =?us-ascii?Q?h5bp2I84LrMC59Ti9+EGlblR8gz+A8XLIzrag1oxfZ0WLeUH2iuTUQWXvepj?=
 =?us-ascii?Q?X4WYU9Q7670DpcBfgUV29vnblCV83eRFppluxSGwvoAcQmSoLZY17jmtmac/?=
 =?us-ascii?Q?sdhtG3Bgs4qThBcr+cuiWkhwXqyHKCERgI+Yg4mOkZNTig6u+yE+pvCJB5L5?=
 =?us-ascii?Q?O/FJjANbEaRaPHzgQitnstxhss9mTniq6D6+Sb674BZdEuZSvEcBv9vpYaQa?=
 =?us-ascii?Q?nDLXhvN9XgDb8/YIf/uBDTUEyrLAAVwaNpZasdRTwrd65u1dCQxDAaLtVusB?=
 =?us-ascii?Q?9ZaN9D0u8cm+3giiZsCbOYe3E2W8cjnd4T14lKLpANRyAPTiWyLD+lKDaKvU?=
 =?us-ascii?Q?QeGuycvra/ibpfTa4UMt+7h2vKKJTLANRSQtmiZoWcR2EIFjhHu4i7glOQg7?=
 =?us-ascii?Q?PbJMEEmVnHPyX0sjBjuF5EPWX7X3ZdQgA8h8IZF7xAf/DMqIeKBH+U+6+TUc?=
 =?us-ascii?Q?JO1vxZJksjxwvYlakPxjrOL8EIijSD3hjCK+aEwGeR+cdtXmNZu7fbToYYxq?=
 =?us-ascii?Q?m2oP5pskhbjNTCUKsXCF5YEUdaDiOqyG0GLb6C+Q4FnCjZmVjUBr8J+9Rr0c?=
 =?us-ascii?Q?IINUMFeYlmePC+0CwAzEvaWO0ED5FD+5WHvca74EvfhGAmc8BzzabPxM12Ca?=
 =?us-ascii?Q?nKCj0j5qVMSVMO9lzejTPFVVl0KUnm/xTICIwSue9wqWM2v7ET/JOi6N4A9p?=
 =?us-ascii?Q?c5Q5Rco=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a78c1404-4d06-475f-eee8-08de55234c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 17:18:42.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9149

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com> Sent: Friday, Decembe=
r 26, 2025 8:27 PM
>=20

Helge --

I don't know why I'm just noticing this now, but this patch that you picked=
 up
also has a "hyperv_fb" spelling typo in the Subject: line. To match histori=
cal practice,
the Subject: line really should be:

Drivers: hv: vmbus: Remove reference to hyperv_fb

If it's something you can clean up easily, that would be nice. If it's a pa=
in,
don't worry about it.

Michael

> Remove hyperv_fb reference as the driver is removed.
>=20
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index a53af6fe81a6..7758d7e25a7b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2356,8 +2356,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  		}
>=20
>  		/*
> -		 * Release the PCI device so hyperv_drm or hyperv_fb driver can
> -		 * grab it later.
> +		 * Release the PCI device so hyperv_drm driver can grab it
> +		 * later.
>  		 */
>  		pci_dev_put(pdev);
>  	}
> --
> 2.49.0
>=20


