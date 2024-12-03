Return-Path: <linux-hyperv+bounces-3392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCCD9E2C66
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2024 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95215165672
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2024 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B2202F86;
	Tue,  3 Dec 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H2h8FiwZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8B1E1035;
	Tue,  3 Dec 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255576; cv=fail; b=sTQ02pUGhLjKU0b4T3pqVWJH4rp5icF8ATIn/PAJ66TRLpYSbtFaXmiOxvV51ITIslRQfu32PVEZ8E6i5sTp61QcBWONMN1GhL8xCwemcZhNyAKhRvZ/yYDsj08B13ipDtQJI5kk+tfUjIB5Z3fjT3qu/6/Lsuen6pxU7pBJIzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255576; c=relaxed/simple;
	bh=PhwZaSUxNhgZdAc7rmpyAQp12hoOuOWzpoTLaQFt0/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oeKiltvdtHqSFUVnu+VzgBchJNAs8aqC7qq9B4UjNKYNoQ6spL/0l+kKKOqPJPKdSyVXc/FntBKERrL53e0PB58VrUQIKHqY8y+BSizR9fYsRMGqd+n08z0DVfd6WgxH1rUcwkLyw68mTSYA2zPbUOX2pSvfTGr+Xfyv5F7RzLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H2h8FiwZ; arc=fail smtp.client-ip=40.107.237.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz0eFQezw/5ZkinjSh2/UwkG+alC/PUCHbGbgTIUkGXbrMjyUbZv+I5zTwP3+y43HycN4DikDqWeCyLYVTZHTmOMOPCOhiMntYg7U60XmjZci+mL5yaytUeXlKLPGgklhFTOKNARII47hZ9e13ciR9Xj3CAERzzQt0C4lzP5ttaVJKM3ZqY2VbB/O2Hl8XYBJSMCtC5RiQL48yAKfCM2oHL7WALoy29xl9qMvEgDrk157IZ9M1uQsBSOKZ97O3ZC6lg5AM0o9WBYq33CuqtdLznB5wWt6LB8wxp1WXwgC3d2aKn+mYVq+hsd8l+KAgWwEyXwZe0cG5rDyloFS16etQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhwZaSUxNhgZdAc7rmpyAQp12hoOuOWzpoTLaQFt0/k=;
 b=r871bsRgQVrE1OTyxmRWEbHPkI5Zoh1QlL9E/0GNICl9BsHEyJw2XpcVJmBzXL4aA8TBckJHFyGmBkPZ+yrxnPGYpobWHYoQYHDyiRRTx2J/U59pkCQWFR0gKYWyAPgHzAhFaGGcSjgoRgsIBlPRQDD4dM+hsd1ZQsLfljWJsVHqAqGIpVd5eR7t/sxGtP8Kbxney1ixz05gDwmmcVArynoGTj8Xd5EsaNPNtzaDnOjLcr5/2GdPUh9TbbirNpA1xq3IR7YsMizp7oFRH64UpMvB+DNlwl7y6A8JHCc4JiE2VTV/LlHzquTw5D68JOlliMrYTVbCs/cHZWKupE88cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhwZaSUxNhgZdAc7rmpyAQp12hoOuOWzpoTLaQFt0/k=;
 b=H2h8FiwZa1CMFHiRg3Yt+uhUQmjqEVIA4wcnHxmoXiXa/3zYbRsHpww2/ZjdtFdTnvj/WwB7hWOqMBTQt9XZ2etGGBusK59GCnro6wuNSWf7vRKT/L2usClucybNuGmVmRRaYlhNlU99RCth8TaBg0XdWbACx123cB4goW2jZC8=
Received: from CH3PR21MB4398.namprd21.prod.outlook.com (2603:10b6:610:21b::6)
 by CH4PR21MB4170.namprd21.prod.outlook.com (2603:10b6:610:22c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.4; Tue, 3 Dec
 2024 19:52:52 +0000
Received: from CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d]) by CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d%4]) with mapi id 15.20.8251.000; Tue, 3 Dec 2024
 19:52:52 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Index: AQHbQ3OobFEVpZbbJEukMRDwXTGZE7LU7Gvw
Date: Tue, 3 Dec 2024 19:52:51 +0000
Message-ID:
 <CH3PR21MB43989123B48D11E16B78802FCE362@CH3PR21MB4398.namprd21.prod.outlook.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
 <20241130140307.3f0c028c@kernel.org>
In-Reply-To: <20241130140307.3f0c028c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=827a8984-035a-436a-9b2a-42cc6703233f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-12-03T19:29:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR21MB4398:EE_|CH4PR21MB4170:EE_
x-ms-office365-filtering-correlation-id: cf9b5763-00d3-4636-fef0-08dd13d4126e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9n/MT+cyTWzPW0VSvgIJrohu/UCEIgR6OBvST5blkQOXNQctzoVrUj7S7Gii?=
 =?us-ascii?Q?1io4QaN5WQj9cVbRyzeYQdZE32otZIQJzLXTpoFMnI7aMyETdPY8aj1MslhK?=
 =?us-ascii?Q?1E+faBQt+phwiRMz3uBZDECVPrF3KOb1TByRmoM8mFUOM0eLn0xHuspX97bR?=
 =?us-ascii?Q?6CHHGkxkOQ9M2/+5Ph3tcB+yf4+KWXJiuK7X8F73sxYfSpN5qAMyrKjYWN4w?=
 =?us-ascii?Q?k37LM1wC2N4DrLGvY30a5VxSjHOPVMOF0IwE4bu0Y2Q0oR2X5COfIgCHbFKm?=
 =?us-ascii?Q?uwCck93rQvf1g9gty8dJ+XVpt5gDFelC+mL6bksjLlw+dc9NGfr2W2HJ4WyQ?=
 =?us-ascii?Q?NmBA1eqd56D/xKnR/rhZz+bzD+R2EKI63GfS6hE4FCtpa+6LLvovdtll/81P?=
 =?us-ascii?Q?7tPUPEZ2wIzpCmI8w6kXU6hYUzGUZo9j4kcq7x2sIYrkRYpvix/nNYD2iNvr?=
 =?us-ascii?Q?GpFCtbTm5kQ79eljHRxW0STi+a8kFiyksTBVAwTAtDfwoER4/jBcuEWQHeS5?=
 =?us-ascii?Q?oIvIpg6syKYXq/ICwuVHaa0VfubJD95zdWYa8Km82Ci+dCcNNeaMYQ2jg/e1?=
 =?us-ascii?Q?9j/SdGPy8udptjGK+Z//B09NuEVbC8a0MG2kWM43c5rNtPPr3G1mZp6YAZSE?=
 =?us-ascii?Q?IjqEETx56FsPncCUAERascO5H8Z8iaQlIYzsw8UItY/Fo5aA3YWjIP5T8rQb?=
 =?us-ascii?Q?RJd4nGVfDvJcI+RIFvqQsTb7e9Ug+F2dBQ1siGyRz8/xCqcC9TrMwSvHG0hm?=
 =?us-ascii?Q?NVjlMJ+fO/fQEIi7CCLw9e+NLZs9rqAuT5Iq3EHpfUquOu9+Dn3E2xOwp5aD?=
 =?us-ascii?Q?UcCDJhv808LgjS5WjtDIVDmTBf4i1B6R+BJBx1imvUfwzT3c/alYhk08v+GO?=
 =?us-ascii?Q?TpQUZqOGRacOfUQIQf3SrCTWYhRFL/FzostXD1QpV7ClKu3e0pyQNxRKu98L?=
 =?us-ascii?Q?NSjbYN8qGaB5Oc7SFfen1OCFS0oMiuK6D883DG2c/xIwXuXERx24bnQFJR+m?=
 =?us-ascii?Q?9Z7b38paOwl89WYh532mxXjR+vYMtjj0laoys4+CgnE+k2czIUBNVbJs2P9U?=
 =?us-ascii?Q?DBlZThBGjat2nu4XG1A/BBQzxCYcGjtJ6o+vsVAAp7WXteoEsnin/Mc8qx1j?=
 =?us-ascii?Q?8UOxi4a98lmWs6dCgwAtkhKSjKrSHdgplOpISl9X9LAJy3Z1xcLp8gQWQnU0?=
 =?us-ascii?Q?/p/tgY9R+f72DoT/Ig4ieYZ5wRu2XW0/w1T9NopWPhhnrtdUwNylC2pEHtyd?=
 =?us-ascii?Q?lSsz0rJBHzTv3OWbRWE7RqGMuoOdYO7haMUZL+FP+XmTzn4GSPYBgFpO7wh8?=
 =?us-ascii?Q?Hd11SYmrvRXQ2mjU0g4vcgjbCzPVOuCKnbKfL+dxD+X+Z176gJh6Q6MCRIGB?=
 =?us-ascii?Q?F5CiAK/ukWUgLvtxhvpgDSTSzQ+Zc5c/ChmPc540vxT/OfooMQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR21MB4398.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XM1pFruSbV7gDzTuhMs/moItm6m0+w8+Gf/YAbwHCLl9nvlB209dMoCJPrUt?=
 =?us-ascii?Q?/WNEcSiA9LPUd0ufS1BPHkpmCQ4HcuB8nW8g5W75r+fyS8BUuKUJXl0pJMoE?=
 =?us-ascii?Q?ZBx8+S47oN1xxcJFBqoBAlDR4dAX4zEmVu8fTkk+4YQY1k+Kxumc5ieoOA19?=
 =?us-ascii?Q?VjTl7VrAVgQ/xJ9wRNFXv8jR2Uw7vc/dYSnouQeFOcyRthpUGHrsN6kT50m6?=
 =?us-ascii?Q?n6ZpjsBGjskMEm9bCeBdkN9Ql9oSH8UZRVF50hOTdr3Z1zMVYvG1XISs8zjZ?=
 =?us-ascii?Q?EOJU6luzQDc1zH+C7z8//nxCl1gWjGJc/uPMzqEGX21HZoWAylvfRhzItCnR?=
 =?us-ascii?Q?DHa+WBSEQ009B09aNHIrBZiVunWxSPgc8HNAhsuXut7G4OllG6/OLD+20v+8?=
 =?us-ascii?Q?tnvgxmierbOw6KAZaLWxE+xrC1pCGOjQHrEilxctMP8ho7trLt0hdYG8sZ16?=
 =?us-ascii?Q?U2iF+gHaC3bko207AsUPojBfn07tp+OEmaljib7EYH+Fcxx16M0BH81NI5qU?=
 =?us-ascii?Q?x2V2baGCkZ/YCxFZEZm2QffZ/WBxI/Fu4I/kEK+/nex5od5nDwK9CF/sa6h7?=
 =?us-ascii?Q?Ql7ThrPFpQW6eWzWM9UTjL678DCjdSv8K9Ls8MX5xxL1WAFRrZ7Kxy/9oHef?=
 =?us-ascii?Q?TXc4l6SypHwKvoX6CiBW51AESGpArb5YE88qorXCbpAexp/1idyNtTO2Jj2u?=
 =?us-ascii?Q?34tQ4afYl0MVxVspVxFDHUl8lRITa6y8941RZUuPBNardHfTXNSvRn2OPX3q?=
 =?us-ascii?Q?1YLkRe6ownjrJM7RJ6qxOOag+64BbTfUoomznV/ckXZGHv0PmCusDCM2+Cr/?=
 =?us-ascii?Q?7aGj7rNZE2SEeNPsK+iDPjbPScNtyRbodH7VJ67giNIU7D19LPAwI98ZfV0a?=
 =?us-ascii?Q?eUdYi6ov5DmwOYPO5V+Xh6tDhNUR+cjlKwOtFd54vM9Z/aX/TKVAcMraMB37?=
 =?us-ascii?Q?7BREVXL2ZWJhMDzrQndctDyT8U4dZFG93F7XCOiypoNgyqu2Kw9+RhYg8e3r?=
 =?us-ascii?Q?h/76kXWN13B3ZSTaN0AhbbjLZebjxsDTua46jX5l+rAVUN8ZI5b3Dw52vl/G?=
 =?us-ascii?Q?blTfRUwr4kUtc/QkpcMhHZpkCawxdbohea3HrCLNzBj19tPztbKQatP6tZ55?=
 =?us-ascii?Q?lYjRVPxnwnItK/7B1g/b0T3VdNg6p2R1oWBmZUeArwG7fdC7rMhyWF3P2Pwn?=
 =?us-ascii?Q?JPonZ3rqQXwYS3be/XuMYjTli26+by/XCMGSQjrWyOLKhcmfub9pUOD7u6Sf?=
 =?us-ascii?Q?W0jQSyUnA2nApT+o5LKHzGagyJqvUGN9hNvHjiqxL4fzjYs6Y9k+h4gWmKt6?=
 =?us-ascii?Q?Jz7b8Nr6g0aPDDWD12EXWf4LYPhVAqbekS2+w4lrke0qHSqAkmHY9VeCbpUN?=
 =?us-ascii?Q?f9lWwPW7+Qur54kXm0+0RxAkNNpIm4d5YZkTpw7yJ16DBhtfOE6Kqof6C7Pc?=
 =?us-ascii?Q?Q2kpZ3TAaPo1B8KKUwLh2GAuOMDBUwo7FuL8kr1F0rPwTyH5tLNltvZk9ATA?=
 =?us-ascii?Q?xAMJWFTvdPUiE+FPGt8e2M8sPWcT412gh2kC5ATvK9moEDHLgSSKKGI6Syge?=
 =?us-ascii?Q?pOxJbS0kShZ3EkfZDxAO8H311TxTsnoqe+elr1WM?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR21MB4398.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b5763-00d3-4636-fef0-08dd13d4126e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 19:52:51.9199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5puJaMfqk3pQOwgUOMg2ru1r/+aCdxFaY5tzNruFESemP/oNspU/tfqzFU5pxtyT9B/awag2bNZwUQqk0ZNuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4170

> Subject: [EXTERNAL] Re: [PATCH] hv_netvsc: Set device flags for properly
> indicating bonding
>=20
> On Wed, 27 Nov 2024 11:42:50 -0800 longli@linuxonhyperv.com wrote:
> > hv_netvsc uses a subset of bonding features in that the master always
> > has only one active slave. But it never properly setup those flags.
> >
> > Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> > IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> > in a master/slave setup.
>=20
> I feel like this has been nacked 10 times already?
> IFF_BONDING means the bonding driver.
> There is more than one driver in the tree providing link aggregation and =
only
> bonding uses IFF_BONDING. If some user is buggy fix the user.
> --
> pw-bot: reject

Sorry I didn't know this has been discussed in other threads. As far as I k=
now, this is probably the 1st time it is discussed in the context of netvsc=
.

My understanding is that netvsc is a special use-case of bonding which is i=
mplemented as an emulated device in drivers/net/bonding. It is the only non=
-emulated driver that sets IFF_MASTER and IFF_SLAVE flags on netdevs. After=
 the master/slave devices are set up in this way, the behavior is very simi=
lar to that of the bonding device with a single active bonded slave.

There are code that use netif_is_bond_master() and netif_is_bond_slave() to=
 decide how a netdev should be used when it is in a master/slave setup. One=
 example is "drivers/infiniband/core/roce_gid_mgmt.c". Their use case is re=
levant to netvsc and its slave device setup.

I haven't found a good way to communicate the relationship of netvsc and it=
s slave netdev to those code. The best solution I can think of is to use th=
e IFF_BONDING, as it is the closest representation of this relationship. An=
other way would be adding a new IFF flag (e.g. IFF_PERMSLAVE) to netdev_pri=
v_flags. I feel this is not needed for this special use-case in netvsc.

Thanks,

Long

