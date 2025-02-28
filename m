Return-Path: <linux-hyperv+bounces-4176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8199A4A62F
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9570C3BC00F
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D41DF263;
	Fri, 28 Feb 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DTrTBNuJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022131.outbound.protection.outlook.com [40.93.200.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08923F372;
	Fri, 28 Feb 2025 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783102; cv=fail; b=S4JkR2RERi6jhfc9CewX+AEtadLgTjsdT46B/IuMnYc2la5B32A9KA2yEWWEb12nOoPx8DMuSFFP6wPmPsWJip1cVcv7oZf4WIVRMtZo5TcPtsOAb3yHVadc8uAEzugPr9RKuNJV7vhJ1fAT87Tz/VeBlsoQopbi2MejZzdzbZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783102; c=relaxed/simple;
	bh=pXJOl3CmUC5yDMwDIHLnX/NuZOY9LImMXKwMWvWYWDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRZTJMyr8mQZngVLDXiSJOmbEif69JBHBeQveIrM4TniT9DHLabDckkHhDuguvNZFD/VidboMsZU3cWoyOyGjIsnZoVx5YREy92MgJFQSxLrO0Njtm33H/R0qktsXJj9Sx1lHRRX6Q/08aKJ4z4ZAsHTbptUt7p+lv5DnqFZ0zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DTrTBNuJ; arc=fail smtp.client-ip=40.93.200.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc5t+NTJ3GKU5hScI6BsOZoTO3lF3fU6dsoyx3wq50rwYNpVZhtjxdbxQqyUeax+UheqIEst/RINaIaoPhKHr8918EkHLvlOkmETtUZNCOttIUvriGN++fdy3P/hNqkQmKpcxrj6VsvDj9vw6CKLdE5VJGL+van3EDcBCkoXoPepTo0JkWgIqoRzdiWx1hNwFW19E5yoZLBcBavT4eEZ5r2Vffp71yNFJlyyghnd3ScxqvetoCrW02VIA5SeseY9OisUCFWx71aLANtBNE5kuxL+LjTO21+90rbEPPBuK0Hl2ueQeJ/UUr0W1Q+9W42GQXc+tJyT47FZaXRJpXOKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5F77DX2QYrxOj6CSU+GgQDXsjuVKbSAs+zcMiHKHuo=;
 b=oVAIX5US8lq+wxqF2dQV/3dLTOezxE1ELXVBIE4W0lKUflWkWjjAOd9w75FHya5Bm61xl4L3fl7dqUTZkCWXNAQq6+g2z6DwvsN1nc0lJltgtuN4xNf2yJliS41N9xYfukzPvhFzW5iSuuLo3Ur3aVyCh9NSRU3qu1VcjjLZbVJvtV6P3qnbjA6rMMcuVRlQQkCl3wWmEfBC6WoMYpby9YvB1JIMq9xqNy/UAA2s2uN6hgDXMr1db7OhAuQxdAtsZyOHCYHgBCMRaIC+cmfEKFCaFCYJ5M+cO/Mfue80RnkxEwY2GjpulknLgdSFJVkk3pj57K4F309RmoKmUxOPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5F77DX2QYrxOj6CSU+GgQDXsjuVKbSAs+zcMiHKHuo=;
 b=DTrTBNuJDFExOuIiEn+UuKuiqM2x8e8/aV7LBXRq4+Fp5M4TIzDQJ4Qe92LQj26huZ/gp2zHw24K6PlqHn/B4psTmeE2VNjEWf9jGzcrD0n07Wqfs5AxOpwYFwOXv/VHKdE8/lcEcuW5vg13KzPL+9DULeo2bA/ayzZfObOH2Dk=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by BL1PR21MB3113.namprd21.prod.outlook.com (2603:10b6:208:391::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.10; Fri, 28 Feb
 2025 22:51:37 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.011; Fri, 28 Feb 2025
 22:51:37 +0000
From: Long Li <longli@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [Patch rdma-next] RDMA/mana_ib: handle net event for
 pointing to the current netdev
Thread-Topic: [EXTERNAL] [Patch rdma-next] RDMA/mana_ib: handle net event for
 pointing to the current netdev
Thread-Index: AQHbijIBFXytyRVF00yaTQ4hdlFtq7NdUfhA
Date: Fri, 28 Feb 2025 22:51:37 +0000
Message-ID:
 <SA6PR21MB423151709BCD182E0C13969BCECC2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=224b221f-066b-46e9-9889-61f6799a43b8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-28T22:50:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|BL1PR21MB3113:EE_
x-ms-office365-filtering-correlation-id: b7d4030b-b446-42f2-63b4-08dd584a753b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CX6HFwOqg7l9VCqZJNcxNFiMCJ8D3IkiVzqrC6mp30ez901Qntcb4fg4evwF?=
 =?us-ascii?Q?d8NhKdCzJWZ1Pa+xsJP7KVDFYy4EM9RfDdmjjs9/OdnOZiQ25v7aOfYTsyO7?=
 =?us-ascii?Q?Yige87+HDolyXJGc7S+KAGV0FFTZ3IfRq/mAo+Fz8fWp5m2akQ1XAXDCj5Z8?=
 =?us-ascii?Q?PT4WiA+Lo1pSC9qD6Mw1R1xzlXNF7650W5z3Mw8SikWxOVmVvnq25pzvBCNV?=
 =?us-ascii?Q?zHLld15vpQl0DXXADd53ACS+7N2TZx7S0IPWRjSaIkYnxiIRtDSgF8ngvs2d?=
 =?us-ascii?Q?jHGCBcwNpcb1v/KQnZbR9lAflDFEyTOVJv+oY5dQ4KlOpoCKwUZHu7gzId9T?=
 =?us-ascii?Q?M2sjQwnwleom50+3QIfbJgowYm5Hh/mzsWDXj2bF1REVBzTp3E1V6SDhWoRJ?=
 =?us-ascii?Q?LBr9yfCUKZqSUgNPjNPhk/pXBDz9AtVPNH/V9nrJiO7l3QZEbYlY3NP5EW5a?=
 =?us-ascii?Q?DuxdO4ZJMW3ufCk4LNFM7Ek+uX8lGNjNgIeMcI067zt7+aaxFsXBM9Hxv3qj?=
 =?us-ascii?Q?z97EgcEl8AokIMBJWcIZR292qpc2I3YCNuU3l1AEypR2F9dTmDp6SZEM0HJa?=
 =?us-ascii?Q?6vgoz8R38Gmp0V4YlGtwnCryza/KKEcgf9rot26LmYaY24/WmVp59mltsqPr?=
 =?us-ascii?Q?fkT2r9V1AED7pUdxBO1SoTQqxXsUDqIO9uYNgKj7jyqGaGGvxKE22bE/JcmE?=
 =?us-ascii?Q?8/W4mZQyZcerizKB6QQyrM1k7nlqx7x/rT4nRNkvaVGrVBFDw3vdrH5/JVz/?=
 =?us-ascii?Q?Qz/Z6DEHqWmkwWl+3XM9C69LY3j5OsLWh3haJcHwqvI7LTkevyffHYKiwrQ8?=
 =?us-ascii?Q?F1v7w7ZhdA5GKqHsuISD1kSZZ7te5+UqUnb9Y7psJSsIGgCOXvbWcZwEsecO?=
 =?us-ascii?Q?MduY7u0NuwGCbP6KFHp504EnGGtN2UE+mKtlLUnzBrhdiqTlvecjw/DckL2s?=
 =?us-ascii?Q?uBrCIMhEYYElK9lsl9dKMI2Y/C4kEA7IXz05OnoGMg/V5mcLLrlF0kd4uKpu?=
 =?us-ascii?Q?gMFn472lPLEszk9anaMt9iBHpTmGhwxIpy6CEhSydqEGofqdP8yf/bbhQtLL?=
 =?us-ascii?Q?nKw1DN98jpSNxQ/oeIy9NpPlDndQmFl4eqnqmeKek/aupqRO347AVsRIituF?=
 =?us-ascii?Q?Z1fHdnA/msAsJkMXB4Ru6dSVYjFEoz0zk47Eqcf/ARtg6oLm9Ri6qUhl++l4?=
 =?us-ascii?Q?hiu4vCq4QUr/Ka2Nvgrwdt6yGKrllPZUI1jAasYoYqLmKM4zX+zMzPWHrxbt?=
 =?us-ascii?Q?phTvytnfh+eMgTYHLpmx2xHAOVdqfyQIStG8xr6PZHb1sR8XE64Pjl01X+FX?=
 =?us-ascii?Q?DwsQABSpfcNQR37/yMUEpDszOapxvyNPeFfg3AyWG1On/pc3G+IkxjAWr6hb?=
 =?us-ascii?Q?zRGxaoramaJdfSWjIcs2ljUBYiRt7LCU6H9pi/7RSDysNQ2OuCiDVv4pN13c?=
 =?us-ascii?Q?fbtIUOY7+dM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e02Kfnl1vykDeHD1Q9sVgSyOTnhNiByP9hMUAkXxIq4SNF8vvmq2XsdeSagK?=
 =?us-ascii?Q?BqtFdpsgku7pClkUkEgizr4Z6UGkpPqCzTmaysbxlGr6QK8qVtLVhYsG7BA2?=
 =?us-ascii?Q?OguFL440j9htYv2dvX77iUSLB6BI9nmffZffOkZf5yIAg7odNHJUxhNbVu1g?=
 =?us-ascii?Q?aocmDZ/pjQmo0ufx21pb77aDuLkh8wQtH5pRPvp7g1V1ZC2EJms3i36lJZ2D?=
 =?us-ascii?Q?jb6jYD72YOZ9H2ycgbTKn5n7hsC8p1cIbSj+3mH7Qo4G1EsrKTG6/MrLf6T6?=
 =?us-ascii?Q?SIKX9aNMZdIUQog+13g7IUherhfToe5l+777YJ7e77bibdfPOgRzs1ef/gZK?=
 =?us-ascii?Q?EfiTzKdphuyboRlwF1RBQPK0M4yrEXCPxCFM9rJhoYWkI/cRhsV1ajzAvNtC?=
 =?us-ascii?Q?zLmCdbuIlhcsm8WAYgcqkGZ9y6dCiomfsgm7bMvzUx18j9MQdMx2yYKwCVN/?=
 =?us-ascii?Q?B9oyKw/mD8iFXgksOXJ5nSSSP9rirrRHCOeFAd7CiCKjDF1B4oaa2jUatTs+?=
 =?us-ascii?Q?YLcdAYGlnVihCVdhTOv2juMI+X/JhmNrdy4lJEs4aU/VWXK1zFC2I9TVJ54c?=
 =?us-ascii?Q?m1YCXsBBIGK+jPCCX1hRcGZah7QyErOI+A3tioPQF1zyWXVovITbDk/KZ8Ed?=
 =?us-ascii?Q?4jUSxm6bDNjVH8BvlU1OitEcFK95s9fFlKGLZIpnRZNliksk/IPYpwtmfbax?=
 =?us-ascii?Q?LZWYn/q1kkJbEl1hAXfvXs3+eZIizAlTz8LcJ9DZu/3wOaTlKSPLYKSA0mL/?=
 =?us-ascii?Q?iiisjC5F9gTopJwANmOwOD7MIHYEBZV27iJFCdYZsPnRAcBnwaVJox1erAN+?=
 =?us-ascii?Q?e1YOqgQgYD1T3Cmkq2maeLmVt+ZsfQpa00KRY0DRm3BpZH8B8DKCjTUHBUpi?=
 =?us-ascii?Q?VbmCyDJ/PZZ5xW3jf/UWGkFspaIVYgddI36zx4fZtycecV1s2CDRmzJSQj9C?=
 =?us-ascii?Q?9rvc7pO/EoF/C/kaP+MjxXFZLfEPHzPpJMYJR+2lxKdQcwRmnjgQ6DNsRspI?=
 =?us-ascii?Q?Nv6Lbkb2ToD9hkuM2hqXj6yPRlKGRai8glPaq1O8JSeZQfxWIUbC+8fGZEWh?=
 =?us-ascii?Q?qdCptz9EC+/dNfOJQ0/SMYsSOHYIoArBnT467YroNdNneHadEFfEVxsGCYNc?=
 =?us-ascii?Q?0mnM8uhsHu+hOu9NI0EGNgvSPKsEAOgRWDJt+yvNuH6HzdRFvb8DLPh1/1mX?=
 =?us-ascii?Q?2gvcPOSvzExFjZtIPAzkvtuyz5U8CuXaTQe0kykoTyTwoKtiveKLHulUR5W8?=
 =?us-ascii?Q?JnoFZpALH4oU5iFpH2W9rRMIjwIABlfzJ5SSFUKhNWz4HCeOaUxIHflKpKib?=
 =?us-ascii?Q?QCMIoa7lqIw8xVxL4rAOzLsLNZG2y0wPHkbOsxMmdw+uNFFBzL/pOEp0UXAw?=
 =?us-ascii?Q?O375jT0PRUY6pzlUrYmSrlBYoFWYI0wBg8AhuqI7ZRs71G5EzysamQleU0EM?=
 =?us-ascii?Q?ANe6G2ImDRTgBcscP/Qh3q+OSUNqpcMh9+FihSHClssP0GXbmfDAbYYVaM+o?=
 =?us-ascii?Q?KLgTMvO8NIKLy9GtpVcDyGZiBBJeF3a0nva1Jjo7UjOA1prfUA7ur9MLMlgM?=
 =?us-ascii?Q?KAdXk3BTgrBKhrxkLTcwlJ7gurXCcWaVyMQxfZwaDrMkyNbc1OD8zGuJR/s0?=
 =?us-ascii?Q?sFjMnt3cB7t7udOksI7E5bPG3JIP1JzgcpzwekV+QqKL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d4030b-b446-42f2-63b4-08dd584a753b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 22:51:37.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRi0fefWNBbueGYJH7/c1WWFmpttwVuyLp9xm0fv1cP08sSn+MxFLPTa0nvLSjaNi9xoz55qCvWm+63B8jUydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3113

> Subject: [Patch rdma-next] RDMA/mana_ib: handle net event for
> pointing to the current netdev
>=20
> From: Long Li <longli@microsoft.com>
>=20
> When running under Hyper-V, the master device to the RDMA device is alway=
s
> bonded to this RDMA device if it's present in the kernel. This is not use=
r-
> configurable.
>=20
> The master device can be unbind/bind from the kernel. During those events=
,
> the RDMA device should set to the current netdev to relect the change of
> master device from those events.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

This is not the correct patch. Please discard this patch.=20

> ---
>  drivers/infiniband/hw/mana/device.c  | 35
> ++++++++++++++++++++++++++++
> drivers/infiniband/hw/mana/mana_ib.h |  1 +
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 3416a85f8738..3e4f069c2258 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops =3D =
{
>  			   ib_ind_table),
>  };
>=20
> +static int mana_ib_netdev_event(struct notifier_block *this,
> +				unsigned long event, void *ptr)
> +{
> +	struct mana_ib_dev *dev =3D container_of(this, struct mana_ib_dev,
> nb);
> +	struct net_device *event_dev =3D netdev_notifier_info_to_dev(ptr);
> +	struct gdma_context *gc =3D dev->gdma_dev->gdma_context;
> +	struct mana_context *mc =3D gc->mana.driver_data;
> +	struct net_device *ndev;
> +
> +	if (event_dev !=3D mc->ports[0])
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		rcu_read_lock();
> +		ndev =3D mana_get_primary_netdev_rcu(mc, 0);
> +		rcu_read_unlock();
> +
> +		/*
> +		 * RDMA core will setup GID based on updated netdev.
> +		 * It's not possible to race with the core as rtnl lock is being
> +		 * held.
> +		 */
> +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> +
> +		return NOTIFY_OK;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
>  static int mana_ib_probe(struct auxiliary_device *adev,
>  			 const struct auxiliary_device_id *id)  { @@ -109,6
> +140,9 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	}
>  	dev->gdma_dev =3D &mdev->gdma_context->mana_ib;
>=20
> +	dev->nb.notifier_call =3D mana_ib_netdev_event;
> +	register_netdevice_notifier(&dev->nb);
> +
>  	ret =3D mana_ib_gd_query_adapter_caps(dev);
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
> @@ -159,6 +193,7 @@ static void mana_ib_remove(struct auxiliary_device
> *adev)  {
>  	struct mana_ib_dev *dev =3D dev_get_drvdata(&adev->dev);
>=20
> +	unregister_netdevice_notifier(&dev->nb);
>  	ib_unregister_device(&dev->ib_dev);
>  	xa_destroy(&dev->qp_table_wq);
>  	mana_ib_gd_destroy_rnic_adapter(dev);
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index b53a5b4de908..d88187072899 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -64,6 +64,7 @@ struct mana_ib_dev {
>  	struct gdma_queue **eqs;
>  	struct xarray qp_table_wq;
>  	struct mana_ib_adapter_caps adapter_caps;
> +	struct notifier_block nb;
>  };
>=20
>  struct mana_ib_wq {
> --
> 2.34.1


