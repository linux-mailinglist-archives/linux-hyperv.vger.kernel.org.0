Return-Path: <linux-hyperv+bounces-3765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D14A1AA3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A31889B5E
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E471885AD;
	Thu, 23 Jan 2025 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PiqA9yw6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2124.outbound.protection.outlook.com [40.107.102.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3591BC4E;
	Thu, 23 Jan 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659905; cv=fail; b=vEZmuk6Ko/vqiz9THtCwUT1zRsPLbDXf+oaHxRipMT5wcL3xaI6AKmncAUnGDHJmpBvmJVLJSbemDvYata2VzUiut0nKzQaeEDIFfDbVsP4rseO9vZKHcVr8fmRL/bUz8xBG/aw/EgePt6JH9S/qoXPN8x8p1kBWVoDaax8FJ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659905; c=relaxed/simple;
	bh=QbqUuubartmDV4+nXcLZs8SKJep0/xyLIMc5aJwzCeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ijrq4HawrJN/Cd9vVGHHMaOQcJab6rNbQyU/7pVWvmsGkSg31QXvlvPDD1SZdqHfnR3Uo11yMDEPv5bsEzsaOkq0jciHUMrtae0TOmnDD+4fdKjSp8sx3r7gAXyYNfyrP5vuJl3LicGETrwfRbJ+wxgjTyh17/ZSdQKjBF9odFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PiqA9yw6; arc=fail smtp.client-ip=40.107.102.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za3kbaqPb30xhb6T7KjK6taCHZcahILq2Hn2zrBhnXaYYykn+QGVVjvlsjt9/quCClbZdTQ0c6qaqbYalaF4KpgJ4ieUFXul3lmkvtreKTDklmQ2UApx1qKS1TA96Cx9VauomsOUv5Qv9Gd9IuJTvHFgPnME4csOleL4G6Xj7ootWQ00YF4ctsUSmdGU05vwSrlkGMk1Y52WayDa7Y+ZBHt7q5ivrrKn6sjDZ/mzhKNJOay3nhkj28z0fW1/4zKVKn8ZpAyyx6mZ1W807j5GWb0NSqwJQ5eX/90dfo+ymwo43N4P+gwvsoT1QayR14ZM7ZGhjDlzqfnPekyg6wUuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMKoRr5T8sOWTmajHUM6oxwDpOwVw93wA9xr9PoKwOo=;
 b=Y0aeWyOj7uorS30yElZj0U2TUk7hwo4vp1JAhQxx4E2qiBwB57bXeMELCXpVwvih3EXjkecAFzbEfzVg4KU8v7kLieXJQ8q9O1R5ajG2M0PSIxBfjBVCoFQA2K09892pmMZfukLl6jcSD7Uqdzc22YMTzMohbw2fcgwJ+5BsvlOgVONx9j+OZ30NC9me9scZ+YonEZR+4uwuct0XyhFzirdZVjXTiy7wwA8kGdtYIPDlQSROPkAs9vzZ8m0BaIq+SkOFKjoLcUSiPiy/cOUAHdDyOgdWXyavCOIBJzdCnmzE70V8iTm2fFy5xF557P6908zVGUwLTolovrA2WU8f/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMKoRr5T8sOWTmajHUM6oxwDpOwVw93wA9xr9PoKwOo=;
 b=PiqA9yw6vtBSt+CFMNnzWPI8QUYiP5t6S5EvDG8eMmZsjM0K754R1/SsNMRIXqEiEv3sGSVuCr1H0ev6mn4FCm4wH1wlzQWNmV/glfxOoIDPcIxKhjGD31Y1GkDz6HbWL1Yca4VqaZDChwXLTTDwFltAG5ddG3BoxIHsPlV/FFs=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4152.namprd21.prod.outlook.com (2603:10b6:806:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.11; Thu, 23 Jan
 2025 19:18:21 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 19:18:21 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 13/13] RDMA/mana_ib: indicate CM support
Thread-Topic: [PATCH rdma-next 13/13] RDMA/mana_ib: indicate CM support
Thread-Index: AQHba2CV8NtvfNp+KECuSNw6ayDCK7MkwFLg
Date: Thu, 23 Jan 2025 19:18:21 +0000
Message-ID:
 <SA6PR21MB4231771D2E2B5EBA2ADF3951CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-14-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To:
 <1737394039-28772-14-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8a301ac-1f70-4d22-8b1b-4cd141d2157f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T19:18:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4152:EE_
x-ms-office365-filtering-correlation-id: 69042548-c65f-46e8-1298-08dd3be2b374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qUuXCoczX8eJ1RKAvlyBgs1+OXsGL2s1LlXJz4pFgMdZVATQoN9+m5lcM+vg?=
 =?us-ascii?Q?UtUlrd5R25og4SliS341qXwfijAVpjRFPpAkCsl+TYGCssHotsv7Q+5SHip2?=
 =?us-ascii?Q?Kqc+wW5DBAESgkbpZv7OKcgMypzuSqK+BlnbZYVHwUgTZA1bTspCH/ypzuIp?=
 =?us-ascii?Q?LayE5oRs0HvxmluA0s5gWMlJJebhTO46vg7ibeekpfFqDzimn4h29LF4fDYP?=
 =?us-ascii?Q?6g+UOdQpE1ZvNS7/pYAEA3Pze9QSmQqSdBoA9boVB0DZ89UFRQ0tTIXCzuI4?=
 =?us-ascii?Q?11F6YjlgQ7uc6TDL1UrzmRn4RrU2CkIRCs7AhE2gsdX8nDKHqzD/atUbNEiK?=
 =?us-ascii?Q?HvnKek3jJLe/AoViKVr7B83yZetTzU0pGp3MABzaZfFrqH+3KTDTNSuI04jZ?=
 =?us-ascii?Q?N2V5w5alf+spGeQSPHbeKAHtloftER4zyVU4caPvNBEXk7DPNCU7jwWdWM9e?=
 =?us-ascii?Q?ANeMzwqaK+Ggjod4mcrbsNbvchLKRFF1CJZ+a6M6IP+vNgpLkm4DED3xnTU6?=
 =?us-ascii?Q?2gasVwPcZMKEQTVeaiL3r30f5xlLF9sGH+isKE6XQbxATywRBZOS4LtpHQAl?=
 =?us-ascii?Q?VIFLacDlZixpWATPG0m5IZ04dsipuOqEjjiqTydxnuGffGTOnYVBhFvoRJSj?=
 =?us-ascii?Q?cm5zHCC/x/YVJTe1f4vL2jvKdDBucuxkhYLiMr8u+QPZylXFW+VWeOR3Ixa9?=
 =?us-ascii?Q?SGZ1Pf42T+Qb9rNDSjoAS2aGTJflJiDaIv+qbj0QbCGoM9ROFmwvXhcjaXze?=
 =?us-ascii?Q?oIgOtGwt+hkBXh6ggdOK2mYBLjJiMwOwpkiBv/0UNFGj/seiwwE2yDPBCVqr?=
 =?us-ascii?Q?lbytEAaCEJi3MVV9TbxfTQDS4vdBee2He4TUZONEfkgyRtq7Dcq5dAu+3yhf?=
 =?us-ascii?Q?bBlEmIlYmceNKuTBMzWKPqbVv9O9oQuOukUyt3GoDyYh7jX6my9urJv1JBGm?=
 =?us-ascii?Q?z/x5rjxNwY5KJ8txvrgH+nhSgB+M/MgYx01oimOS9c/6Jp+k/QuKP7yogJNS?=
 =?us-ascii?Q?iatSHMMzfCm4wI/YUAD5CzCnY2n6qXfEeJBrNLHRgeRCZ8Gh8rzmL8E7UtTD?=
 =?us-ascii?Q?aiCcyyaFr+KbV6Gjm7grHg/k5z/pUeM2Rn1LUtM6stQRNRi3eFIUeokhuASM?=
 =?us-ascii?Q?OELDow6y0mvmd9EdQ7fmJsBUf2jjvppNJ4nR+QQ4s6JESd0x9Sqwp3GnZ/qO?=
 =?us-ascii?Q?n3HxVfKn4ScBKc1zuH/anczZ1Qq5fJGL16DsZ8dClJf+8IB0D+sm8FwgPKS0?=
 =?us-ascii?Q?sOnveZrMbiNf6eV8K2QOMhpOsp44UEg3ZryG72ffqYxirg338KkOko/kpYiM?=
 =?us-ascii?Q?5ujyluXmqzticK4bFgH/u8CNlX4flZGxPFjLgtWC8Q6Ay8EK5Iy8C9IZ8wfZ?=
 =?us-ascii?Q?gEkRhQFg/995W0pP+vfJHOrz+2Ke5rSrdAPNYBNhqstPT18ScP4jDjTAUuZn?=
 =?us-ascii?Q?9IUQ552lmZ3VrfHxAhmRzfTeU3pQ/9XkeKaga5MlmG2uNp3kLd7edQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9djBCEa07X1diyZ738CaBi6EiyU/qhbSmW6dr3krvv/pMA9/Bst/lt7I/jjd?=
 =?us-ascii?Q?jHJy9D9IJafB92ShO64SqhsdoLFjN0ZoCt9cGo1H+BqgnXingFuSwQ0H9j9b?=
 =?us-ascii?Q?ijlZqzq47/aPm2TR5IVPrXWVFpeyh1/JRZm+SxYwu7SEN/djaIzwdLn2wSy3?=
 =?us-ascii?Q?xCBiLlv7T67agLNtekD/JMBy6vGFWzqbU7VONs+gbQuphbG4Ek+CuDwk+2eG?=
 =?us-ascii?Q?C/qAO27nWvlpHBbbdNoj8QM9Qcib1q6xaapd0gFP8hThiF+xZaa59hXpp0fe?=
 =?us-ascii?Q?tz2LT/DEMvKA+rtSJSun/qW7d08o7QpTNsz60/bl9sG/NbsKV777Tt0XW/Ob?=
 =?us-ascii?Q?sRN9lkqRqmwGKtZQ9BKGWYk50+bFXhJIe5h+T/m0osQU/cSnxLSk48uTcfid?=
 =?us-ascii?Q?pvJ/ri8uj5TzUrouKlqlywClbiNHaVwayEYEYBCyvzxSyZkoh2h9V93QYCtw?=
 =?us-ascii?Q?jWOV0008FBEtlfU94xKPaQo59wpoeMGrI97cFZTf2HiDUjlMGfcCKXgZwPuM?=
 =?us-ascii?Q?xOJCY1vL1x7CLejry8yZYIJF8hhSLO0uZ1p0hEY4jVAEpEJmLS/zvvI4rII5?=
 =?us-ascii?Q?8Ul4IgUzs3wlvR8VYyj/5bmofP+dFrfe5oTbXx3aIMRssg1AMHesYA3K2Qy7?=
 =?us-ascii?Q?m3eJityNk3PplfVSblz2weOeITaWDsqVangDMew/QsBWkIvSr71E6NfaK9C/?=
 =?us-ascii?Q?PcXxQTcV9sn3h+SF3+Hctlnt5t8Z8xr8fJY9lrwQEdeCJxBTnlUGnb01whQv?=
 =?us-ascii?Q?A+i026escxAcFd1vNGNuXtVXOBenR5ZPQzJ8r50nSd1lLGwg1csUXloHAINu?=
 =?us-ascii?Q?P8e1HyOk5AeAQTrlGCH7+71V1puonbC9t97530CvjlB4PmaYMzAmA054rXm/?=
 =?us-ascii?Q?VzzrlYSJCFJfmxWjb3SGeGl4ZHCy+x+n11BtMHlZrrqn7ythtRh6JGp6lmby?=
 =?us-ascii?Q?fVMqKIigEJz3k0sNFc+cUsErs29ZcJx5lwCIleJ4QKluMDxBxsINIf06NQ8L?=
 =?us-ascii?Q?koiqQ1NN8Ubjo4IZozCqI7im4407hllZRwiLm791cuRxqrQ7G3WmPmFyNOUp?=
 =?us-ascii?Q?RjxEnNg9kbt6YVtn4Qq8bItAnnCiXvzcvS8XPcFrvkXmlxLB/p6F4B3gIBzw?=
 =?us-ascii?Q?csNVtRWooFQiafYVPuFo58+q2O0EM0YX1D38HBbPLLtxZ7NpJymBYXIDGXWo?=
 =?us-ascii?Q?Xdvvt9kDlDfrHdbafs6pcBG+pNlWh/suKEqX4NrjunvhgHFrMGomPnWX2xqg?=
 =?us-ascii?Q?Lot/Aw45yJ5BfIvmQ7jrWpBdpgpPVF3g8n2H7JMicOsdS9VodMZlOraptUW6?=
 =?us-ascii?Q?KTwj1wWfsztvKq8nHjsHGativCmmXO2gJHrhSj1ptwz0UnEfGxhrHWXNB7yu?=
 =?us-ascii?Q?va9vacTtxpWnT7sKhPbz67DaFruUqn2AnJIyHIkIqBt9z/aca+cyZ4n+LYJq?=
 =?us-ascii?Q?YKZtbgZp7QO/YK48YXUxBNozFS1cizQInx3IVjK1cCd/qdw/9vwsFo9RO9B5?=
 =?us-ascii?Q?bAf/7QA2SinFNqr2wck1gSsdGKqE+arSu8WiWj/BstTeMVd8CELVY4dekFs7?=
 =?us-ascii?Q?KYRIja9Sjowb1D2dLXJo53pQqSsTTqO7HlpvHXl9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69042548-c65f-46e8-1298-08dd3be2b374
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 19:18:21.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cGk3H/2vnSeRcqh/KdP5fqXvC7Ge2zNM0ZhmBeLFaJGY9jgO+BV2uehWCcyx1CAn5ME12ecoaFfhD/H31p0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4152

> Subject: [PATCH rdma-next 13/13] RDMA/mana_ib: indicate CM support
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Set max_mad_size and IB_PORT_CM_SUP capability to enable connection
> manager.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 114e391..ae1fb69 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -561,8 +561,10 @@ int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,
>  	immutable->pkey_tbl_len =3D attr.pkey_tbl_len;
>  	immutable->gid_tbl_len =3D attr.gid_tbl_len;
>  	immutable->core_cap_flags =3D RDMA_CORE_PORT_RAW_PACKET;
> -	if (port_num =3D=3D 1)
> +	if (port_num =3D=3D 1) {
>  		immutable->core_cap_flags |=3D
> RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
> +		immutable->max_mad_size =3D IB_MGMT_MAD_SIZE;
> +	}
>=20
>  	return 0;
>  }
> @@ -621,8 +623,11 @@ int mana_ib_query_port(struct ib_device *ibdev, u32
> port,
>  	props->active_width =3D IB_WIDTH_4X;
>  	props->active_speed =3D IB_SPEED_EDR;
>  	props->pkey_tbl_len =3D 1;
> -	if (port =3D=3D 1)
> +	if (port =3D=3D 1) {
>  		props->gid_tbl_len =3D 16;
> +		props->port_cap_flags =3D IB_PORT_CM_SUP;
> +		props->ip_gids =3D true;
> +	}
>=20
>  	return 0;
>  }
> --
> 2.43.0


