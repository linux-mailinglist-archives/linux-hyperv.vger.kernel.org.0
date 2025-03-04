Return-Path: <linux-hyperv+bounces-4202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F85A4D14D
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 02:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39EC3A6A29
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 01:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE613AA27;
	Tue,  4 Mar 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vbq8SUx/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020096.outbound.protection.outlook.com [52.101.46.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1F1A260;
	Tue,  4 Mar 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053485; cv=fail; b=Thmp8T/WlYrD6Zhk83nLFu9jVEBEjB+qbn06f4s1CnpaSXFCj5jyALFku8mJSTKuiCVeGX6R2hErroP5onILi5iTZToAfVRFMabE9vnUo1S1ubAeIPSLG1Ol6WKkE1TiPaZr43RwVc1gfXlOwUI45qKr1wHE4bIn/KN81u6FV0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053485; c=relaxed/simple;
	bh=03w4EjM/MsnzWBKlaTexutREko60REQtW8Mo43nu8NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhPvCtfdinYg2A1I0OiLv33YR/PaAMYhAxPbr6pEAZEh72zjGzhn4zKJ9y1f1M6/fhYV75RxeMeMxXcD6INytmyYd8avU+91fn9917r/YoB2tt6hMAb2yMQecQc5pDdEqD7n33NA864p3kp5tl89DnEl4bcbwXGEYKBhA7NgJ94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Vbq8SUx/; arc=fail smtp.client-ip=52.101.46.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCOYcx9xyWKG+PKGdJ3EL2n3mvgtPtFPXGy0d+28oAN4nfdZcJIt/g+1qTeHXMb4hoWkTurCXpg2D4UrmNkyimROk4xn4uhWYnpvIIcG7v7slZNXa5ZuwabUjkGo7BlBgw47IeJkhY48VscGXGMBtu4ZKyqB1r4yrJr6lbys7AMZ3SeB9NSqcAlEhiL2pjAkUzyPFP/RGKbTS3xqEErqf4akXP8AQeFSwxMfc1NlkzqqcgA1QPOdev8aPZuuNNTkMdvzHN+pETk7irHww0p+HvNfTQJECQyUpNuqNbJMTyHF3nX9PHiawp1cR8SpII4HzxDYHlOBxFoXLu4v0qPWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0kCDnE3NaPKO24VAfmiYcuZNXTj4a/4y4hTG1OuNxk=;
 b=lwm7dCr90XetnAnZ4XL1aH7h8Q4nala95NJNyZFQci+C5om3KWuLqqYvYlaEo4VbAz+MrpDEKcXtG588b0b7tkteFgV7S4yRGLmj7/iBXdD4ZI1aZ7ItyfSdIiSSuEWtc2K4ALswtM/00JLUbjZxGinIw4FYzlLL4dtnKnC5x9MP+JSWFDfebNX9732BLsI3n67CJA8gtzUifUiJ/2AksRSNvUKNk6wXBIDkwXCoojB6tE2ZqDIdbAT5l0QbLBGVFCV0rYw01/fgc0AaViyBQ8sM2vWLKXWV8FpWvucvy8fw+Mz8V2hRW9wsNgxd8vgrvvaiiHQaOaFmKXLm+qv2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0kCDnE3NaPKO24VAfmiYcuZNXTj4a/4y4hTG1OuNxk=;
 b=Vbq8SUx/h8Ih2bvBiSrn6EvVNOV1w7qZAC9eR2bszw9iI1McE69MKRaIlBrCLtQ2v5eYWD3LHIRHHZAZPj1hb/ghSVXNxJwkFfFrzRi6wx3KMYKUM19R8jJX1yFz5G43WeW64htw1/g6A/tSVBtEc841P/YwQY58FmqMsyHE3aM=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4153.namprd21.prod.outlook.com (2603:10b6:806:41e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.4; Tue, 4 Mar
 2025 01:58:02 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Tue, 4 Mar 2025
 01:58:02 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Topic: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Index: AQHbikCIA4yRkbkqtkKGI9f1ozBrrrNiOljQ
Date: Tue, 4 Mar 2025 01:58:01 +0000
Message-ID:
 <SA6PR21MB4231E3DC3F2D88ADFBD0F74DCEC82@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
 <20250301002604.GN5011@ziepe.ca>
In-Reply-To: <20250301002604.GN5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff2580ac-24d7-4f63-9f7c-ab0ca9f67371;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-04T01:47:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4153:EE_
x-ms-office365-filtering-correlation-id: 82b39317-1546-44cb-2f85-08dd5abffee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?E2W//ZvnRbHvrAw6Eg+HMXG9G6ZCR9D1cPyEc3o8Zrtgq02kQAHtvJHbmz1t?=
 =?us-ascii?Q?fuaN+X5aAskAItImCUXalik23bwk2EVOM7CcsM1r2/7SG1IoGq0LYrjMnM0R?=
 =?us-ascii?Q?Gu74lDgkTanTuGVm/HvUJEcuLOu8hoMIiR3u3SrDt3kdShPlrBXyNXsSuTsI?=
 =?us-ascii?Q?RPhg6kA7TpMwNrjzJ60gU55VwQCEvcjaTwu1TQYuH7baTGP6Rizg0paEwVsY?=
 =?us-ascii?Q?rqj7LyfsrNLAzHQ2m0q+pe9t4WM4PlTpKqlfCGbUrxx344gaqsMRUF+MFsbH?=
 =?us-ascii?Q?2HYcdwVuCGG2coMVAwMekmwxZ+QnTI0uiXpeUGecFICX/T6Yg0N5hVEX6UEN?=
 =?us-ascii?Q?yjNP3pQ1zfiyiWookZBfdlqKCeNZtKS6xipWEfCsUn3fpPvFmu3jKoMfC+Wl?=
 =?us-ascii?Q?Ycu/ovnlmehzBQ7bc2QKjnGrxv8iKCzeSfdVrvL/Tyc3DG9XLaU4LXKlET6b?=
 =?us-ascii?Q?Yk683s9Z4T5aMTIvNPhqj487A/pXXMmoVnWY3CgLvkdCtg2RMlMm/Zx4ziys?=
 =?us-ascii?Q?aOWtFWMGLlzjxi3cUKJRIdU52gZb0WWtobdCdaaXokgYeDRwYcehpVu0i50C?=
 =?us-ascii?Q?vegUEY7FxhjF93URXgmmGBRvd/xaQVDN9KAgKw/yAiWwp/ct/lvUppYjC3tJ?=
 =?us-ascii?Q?Ryi455kxfheofIiUCh8m4zhExrzsIyNfEGG0Ihk+vyFLXQpv6cxvqBir/pVq?=
 =?us-ascii?Q?sRNlUcs0JSXi/1WHiANnw3iEzSM9YBcGaTKImqKG3fnB1w9PmE8RdRfXyU4W?=
 =?us-ascii?Q?F1AtEW+bp4cYk8SwlQ+SWjfMc7JRRXI4aMqB1oWyFYuFVejLUTTDg67ZSyM6?=
 =?us-ascii?Q?9BDrt6yFDVUPi5mjVXdOMiVJBJeeKuWn3QZXpTcDcnb5QX7aNOI+MsOG6iKy?=
 =?us-ascii?Q?07kXdjMGHFx5d2kTC3wvXNZ/2z4Us5p8CrXFDFnQzgYRx1M3aJtpUODAIWpD?=
 =?us-ascii?Q?H6K2iidYGxvB9bokxLLHk115RXj7hGEsa4W/BMueJnz4ja0AyotqaOPbbgun?=
 =?us-ascii?Q?L3Hz8TMYCX2H3iDBCqvpISqHFl0n5YbEfWeSD0c3hoKsXUsgR4OxQF21a448?=
 =?us-ascii?Q?Ok5mbl30/mIUY1JwGTLMG1B3jlWvqZU5ljaUz/eJ4PfTea4tMzdu6n/dGqwz?=
 =?us-ascii?Q?y5Bq7VAuIcAWQ+Imj8XML72qlfQ4TgvTbcm/sxOKdo9oxxSXdZbsqfkmQanJ?=
 =?us-ascii?Q?Ern3WcQWKB9jbyhN2RtGoIikLBri9SZqx5Wi6RkTPnTNdqyXZjF8fMnEWU2C?=
 =?us-ascii?Q?mwkw5sJLnQo4ZPvRCyXQ8HQVbGzCMuT8sPmJjq2Y9hn7KKURSvBD2hv6tG+z?=
 =?us-ascii?Q?FMXP3B3WUW+8Yk7Ou5/WNh8BxMyawEUVktkmqJb/AB0xPk4tPBzzsrYJ4KpB?=
 =?us-ascii?Q?54meXBX8us102w78zkCcarCHwN6eZ/W4RKYy3uhTnVlYifNe8oQMd71ZWdip?=
 =?us-ascii?Q?QLIw4HrgTQSe88ukEzZS8VC2SOucgUv0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jb7bqat5SAYpZgdhOSi3FAEJ3tbgdhs1/ZOPgh1S0BuFxBTZQKlZtDsrVo2T?=
 =?us-ascii?Q?YRZ2tNTOSFZeILwJnt1EwSD6GA+UUfKPJXIkDOJ0GmUoETWshYzlPcS7Er2V?=
 =?us-ascii?Q?aOc6WcXNih4+6FsR68hR2iQ+Pc/lHwFfdX+enlyG6EYM7BBqVllKfqeQvxjd?=
 =?us-ascii?Q?2iTnL3eCbmR4QDq7fvPQ8VwKjn4dBQlpe9fEypbHmMymytzPIu71PVwp/oUH?=
 =?us-ascii?Q?yLmwAFR7QY2nmCpYQRpRcFOkRHL6mVDHGoHo5ngwCmpjhuEfyDBpXBMelsNW?=
 =?us-ascii?Q?bcVvDjnNoqy/3crpKYdOgOqWtIdnQQ7oRjOLyQJ2av2DgwOIhs7uxrcGA3f5?=
 =?us-ascii?Q?01+aMaNDEbjw64V/hvxPMuPHfYlkwyKItrhYhtfjrcpNSxEi9Frt1y0h5elv?=
 =?us-ascii?Q?sbIStrATNK1ALxfIlSZEq2WQr+YpZok/E8ec0f3rKcuL4fE/cAxf2g10CXvo?=
 =?us-ascii?Q?NH9SWYkZUI5ONcbuQE+w6u/eOJ2rPVFrpoHlIQv4PaVNd3bqgOkTWfYCP6V3?=
 =?us-ascii?Q?PCOKF4ZSO6l1o9h1ZQGpIHngjCRFhEOad3K+Im7gJPQiCi/1QmaUkGLOwejG?=
 =?us-ascii?Q?tp2wEh5F3MtpUYo+XuvPIsl+qmcmrMw1MwiEsXepsrXumTYm+3AWR7mAkLpA?=
 =?us-ascii?Q?xWz1VjLuWqa9oM36PDTEzPdiHSY671t7AxH4iqWj//5Ixnlks011m22vuPm9?=
 =?us-ascii?Q?vxdNckMaGNxLOPnBoEXyUQWhBuW7wsycx8LjIL3P1GBPHL7ml2htjzRNewrn?=
 =?us-ascii?Q?bXTCilOJ9DxxV62akiJa94JXhpmedL/W7nzpmDMianoYfocpxNysnv3pp7ld?=
 =?us-ascii?Q?ed/qhrZYgsBSUT7kEjPYtNFYQ7SYzIpWGvXM+erHfoovgaq091jG7cNeyKlD?=
 =?us-ascii?Q?EnLDXDKpBukmMCfddAgNR4pTpT5MLwLemEA8j3lCacwv+63gRq2vn5Mjs29X?=
 =?us-ascii?Q?mwgta6sEp2TTwRd0WBhpdQob6Mfq1mB8qQiTsd8g1Nw9iRb6U2rUa0Tr2E/5?=
 =?us-ascii?Q?zuDNCfk5UpoboI6s6y/rQpyX0qccsr27LFNhelsEm4CmHhcQggOIrZnL9QGh?=
 =?us-ascii?Q?6rqj6rLXUbrndBLHZD+spUKeaAwS8pvE2JzsTFEs77hVFLZsfS7BxSzjqALu?=
 =?us-ascii?Q?+CYuieYBd8oH0KdmCrbMTKkBBl9EIFuMGBWD5GC+5W3zHWA7gLHBEEsQE7w4?=
 =?us-ascii?Q?v25fWkwj0ErUIC1CTJu+QeamNnHqa6OAIXyOfyjM/28Bw0cR32/WYAluRUG2?=
 =?us-ascii?Q?4dhVhK2PVJ+yOSM9WI2KEB5X4y13T9/B+lXGozXRzhRAsLD0wWINA2/p8Gxu?=
 =?us-ascii?Q?et9b4LTGu2fyYvnUdq+AWBXYVdc84lwP4bG0a2bmYPzNayR9mso0gzkWC+UN?=
 =?us-ascii?Q?Jk7qGr5B+fOeD8+FQwxoOXig8AiH8WNoxK63TO4x1LBUOsynXVNB2Gr9KXr+?=
 =?us-ascii?Q?ZkZs6f96QIu0bFIQLFkEOUQs/kigIT6OrxnNEBT36NGSpO4wYg6DQB+NgOJ8?=
 =?us-ascii?Q?wZB01yi+N0ovFawzjfwF5yojhz6aDxbXVg3zove0G0/1hE7ifxP9vOKR9cp3?=
 =?us-ascii?Q?T/rtLghzvWaSJxcFwrDX/Bb/Cdsu+mduIS/VfackB8HMrGBURPOhvGupY/XR?=
 =?us-ascii?Q?0GIOJi6+AxEcYk4S3xW5YjKH0PJHOISHLLCJdgtVURfa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b39317-1546-44cb-2f85-08dd5abffee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 01:58:01.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nynMQqRV80d3AFIYTCwL10Azc4ICbB6doxBQ30qq5Kfp8cYNhO9eoHN0bUnQiOm22tQBYc/Y6sww9eTbJFTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4153

> Subject: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
> for pointing to the current netdev
>=20
> On Fri, Feb 28, 2025 at 02:41:59PM -0800, longli@linuxonhyperv.com wrote:
> > +	struct mana_ib_dev *dev =3D container_of(this, struct mana_ib_dev,
> nb);
> > +	struct net_device *event_dev =3D netdev_notifier_info_to_dev(ptr);
> > +	struct gdma_context *gc =3D dev->gdma_dev->gdma_context;
> > +	struct mana_context *mc =3D gc->mana.driver_data;
> > +	struct net_device *ndev;
> > +
> > +	if (event_dev !=3D mc->ports[0])
> > +		return NOTIFY_DONE;
> > +
> > +	switch (event) {
> > +	case NETDEV_CHANGEUPPER:
> > +		rcu_read_lock();
> > +		ndev =3D mana_get_primary_netdev_rcu(mc, 0);
> > +		rcu_read_unlock();
>=20
> That locking sure looks weird/wrong.
>=20
> Jason

I think the locking is necessary as mana_get_primary_netdev_rcu() requires =
a RCU lock. It's safe to nest rcu_read_lock() if it's already held.

I have sent v2. v1 is from an earlier branch and is missing some error hand=
ling code.

Thanks,
Long

