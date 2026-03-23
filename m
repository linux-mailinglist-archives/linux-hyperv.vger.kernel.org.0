Return-Path: <linux-hyperv+bounces-9699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM0SFnOEwWnqTgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9699-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 19:20:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22122FB2BF
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01EE23047DC6
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F363C9EC1;
	Mon, 23 Mar 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XaeKKwUY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022122.outbound.protection.outlook.com [52.101.53.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40493C9EE0;
	Mon, 23 Mar 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289036; cv=fail; b=pQJhxo+75s+UVsI6KJB6S7qIEW70yMFrjlWqS5WcWKfrhOrMTDBNEZwnUNJpSyaDMl0EHqX5OGe28AiZPyQMIjajNkkkGQPBXN9GqoQ3Q3suNeXVxpL8mkqMVPz0zE2pM4X8e9R4spJ7kU4hRTSYACfxqDtuVlDr/bO1ih11zCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289036; c=relaxed/simple;
	bh=IC3Zt6jZ8RbBGiTa092uzQGXH5ruuKbocVAFpR2EM3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5ZWBdzxHQHNoT21hWXckk2t4iXf03ElXCjVHUZAMUEYSK2OZB2o5dy1HOfV6eC0t01kbiAeC9V245ubOkkY99NKzTWY4LPNQMMR9PluHyyW1q7s9Q9KvSP3b3kXW765w7MCm+eaY/4FOlcRYjkilH674gWxt3ORiVOh78TViAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XaeKKwUY; arc=fail smtp.client-ip=52.101.53.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvJyFvBmcvyZsedJ6urlWWwhwzZe31RLxM6Nr9FIQ2JAR2iBgqRlpY1ee0yJqDjzuzxJMGyPCj0wRDbCFsVkjaL/We+kZHL5UwbOjHV+eZCiKIQa6crw+DcKODfym5IOX3XzzqAZV79DbrXdp7AHPUoNftXjQ198w5M5BBzvbb90+YKskgpZ8YlyGu5YEqhuzk1PqoXIYiZzvFwbg5L1lCrpKKA16832MCy4Sap1MjAAE4/rcXZQc1enQK+12BLMpF/4lXhElNXHu+10C6Bsmf2xV7e0fO7rofD2OqhaqyeGgiqjFWMIcGrjCC4ESf92wmKU6KdIwDIS0dSgeBIUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uCPFQpGX35syGPzECbbpnomSHuxKfUuEoQbI/toJ5s=;
 b=ShKalBsOEJTHE/UyjZkzvyhO/C/jmQo4CvGdLvJAZ5VC08XFM5FvhcTdmCgY15FC2mqxXiJzPJxIF23lKNA1CbWNMwiSLJBA1s40Mb10cMGBJwlTDiiNAeSj+qpKpKJWYRV2VBKPx/7Yp6hZ9jE/l6oJeloNM4mwvVp255ij0J2C+JJdhW6Y3ilh16hCllLLvz+KOZlID4Df4cXtm0J8uWJTO17JNq7O9H973qqgiRwdMgkbJXiUxVQr96SP0HHJOLrtfa5voj6uTig3iVidu1j4dnjnmH1RX+wOLua3gzyuYHGMeHNpmCypx6nxxqyIDslvRolv15vpDB8Aah4PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uCPFQpGX35syGPzECbbpnomSHuxKfUuEoQbI/toJ5s=;
 b=XaeKKwUY6F55fOO7pbJaqjEA8zxvavNiGasHPUOZp5lohM1DWMTGITOHL+k89CRjF96Vy/OCDdnxXMil/Oep46NpgAzZ9pjzL79Dj4iEssIax9J0jvLGuGtJCydZLLTQGjHpgDsdqrLk2gtsRbDO/t/GBA5QXx8kDkGDRnIyKl4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6634.namprd21.prod.outlook.com (2603:10b6:806:4a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.5; Mon, 23 Mar
 2026 18:03:51 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.004; Mon, 23 Mar 2026
 18:03:51 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma] RDMA/mana_ib: Disable RX steering on
 RSS QP destroy
Thread-Topic: [EXTERNAL] Re: [PATCH rdma] RDMA/mana_ib: Disable RX steering on
 RSS QP destroy
Thread-Index: AQHcuMmzZYdhNaefSkOhy1v7huhDC7W653UAgAGFgzA=
Date: Mon, 23 Mar 2026 18:03:51 +0000
Message-ID:
 <SA1PR21MB668362600130B8167EEE32E4CE4BA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260321002842.1607179-1-longli@microsoft.com>
 <20260322184848.GC814676@unreal>
In-Reply-To: <20260322184848.GC814676@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e6e683a7-5f5f-463b-a2ef-1dc09abed4bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-23T18:02:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6634:EE_
x-ms-office365-filtering-correlation-id: c20106c2-3902-4640-a45e-08de89068a04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 K6ow/RpMGz0EjcUzzKMYS/ugOCrZmaamqC1gm1yXj+8fwBwY3YdQtXDllRkuNm4sThI0Jcfikt58A/Lly/v44hAQI6xin34bFYxmGN4tQlopJzf81Imsm+q+lPEXckV1yY9klO6dgc9zZoI/sc81TFBvKKDaTNvXLQMfXbT8m2Hpe3JthmmqLbFtz3Qyv9i8vnIhqk8gUslVwkOAb5KHJ5pwme0nD4ru/7BmdZ4Zhbl5vBVoPsZYtLCcG3tNyaUAvSl1+8douWLF237DZh5FPvrR9pLI1I0FaSnenFlfpt2L2fjS773lEjx7HJ1ioPts9aT+sqFKMElb9iWr7AcvBF9zKkXxQBpBdjoUd7xt89rhVe3CFV3Pn8H0s44xROZ6hSeFi3i69CRQU9p6gGzb3D1IfFkzjmjdSzD4jY2Y/bHGnbnEhANre1SqyMXsFYTosrlBpvYHYAYMGCvW9jvy9UZ64OY8FOy30PNUwLdEyhGmAe9Rxs/ll7/XaLJqm+rqZ22U3EZ1sKUX5P4vVf2zFYEi6adwlOB8IaqQIuwUghAdUkKL0VKOoG7+zfda0E1p+ZwtiDVllpFfrFOsfDTy1BCQpDity3DqMlmf2Z1RC4xL8y/EhN3En+XMcAH7+TtEHWlt1AiHfYAoFnk7oQ5DVsW+nBWqld/6dVRsy19MvKWLveJene7iyod0DVk3ziQp8aBB9ep3LrAR0Qg4pnmfpgemFkqT/mdDrqnTGwDB24w4JMn5wthTnL02Yrsm2qK944e7mhrsqI8tDOoZbnHdPxdYFU4OGn0d2oiiUnEzQAM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c6NW0XtOhTou1+DCoxo4RHoCa7wQ/W5fgPAL6XwSpj0VmuG/eMIWPB2Z3Soe?=
 =?us-ascii?Q?c8g20zMy05s3YPm5wiQu7M+B+uwd3BTacRIDhWKAYakwgYoBAoGuh43vzOnn?=
 =?us-ascii?Q?t/wadVNWi8FoUPgeick+eAEmCw3WCoOBifWpLFvzcQXx4Y+wSQlJPZqe6JA2?=
 =?us-ascii?Q?CINrGEW1VTZLmW4fr8z32ytEs6hyl5jYf9Ghl0lRb/MZyoozCn57tAu6Is8A?=
 =?us-ascii?Q?qb13ZRZl++2YEcU59sXJoRbrUbELRGDUcZRCH4Xqoypv0m6su/8xvQf+cSX4?=
 =?us-ascii?Q?xXedquNtrx1H2pXZPHy/pI21ECGLc+Fah6c2BvNcqOV3g1KZpOfvUxItAvi1?=
 =?us-ascii?Q?fcCEFSZfH3sQeNe7EORoUUW6cObD8wsVH+VRsG3/Lo5Dy67Bl7ZMQSg7xTJJ?=
 =?us-ascii?Q?OJaUtSA6fGvYJI7gK2RUfbgwUhmu7UVLMh//Bbe2b+Fo35gi5KuopYLSGpNn?=
 =?us-ascii?Q?9aiuLl6ucuLYvS02bl8xRs2ZhBcviKxyOWfsKZoBUFQm9Jj0Q/s4Svbi+Gk+?=
 =?us-ascii?Q?PMtvVM0HHNqCvuhE98zFdoftDm4zE7pFzNBqhqj+y/cxeQWGqsX5kGhzn/7H?=
 =?us-ascii?Q?R1MhePOxp3RfGntZqQZ3+kCKU6AE23HOuNyng0x6isug/swMQ72tYO0VhpNK?=
 =?us-ascii?Q?bHdexZXFhOGj7EKA/1vtSWK8oKHxYzK+MIAgy9cdr6hHktBSQykz4TmXw+YU?=
 =?us-ascii?Q?9uLysyLTmjpD0c1nBeLEV3jbysiIUvfJwFGA/i0cpHh9keXi/PVoR+MGjPMy?=
 =?us-ascii?Q?lBryWBZ56CrvThHUtyzSpp+AnZYNtj6p6MtUxdYYybYhh+X9CstUP8YEENiA?=
 =?us-ascii?Q?cz4aws1rSORHowsMMCWojaiAjoHGipvAD1mV5XuqhjIeivrQnpdbckmNkqtB?=
 =?us-ascii?Q?zj3Bghhot7o/KpQEXiCYVkni7S8+kqkhOE7ts23Fr+90eJoHobtYm2cXL5Gj?=
 =?us-ascii?Q?51s4JkduTaGMwkmf4DwTvPcXUga8RbrsuOsnABa3YMq1oVx2bZxN9lO5TR2u?=
 =?us-ascii?Q?373toiGcjCHoLuahuqlmln8JrTGxInHlRqNyrJH27elorwJ6Yn/Nw09PCJ+x?=
 =?us-ascii?Q?eIa403csk+vUwAVWfzd7w+eRhoZRG8fENyIHczm/742CpPCJqfKLk4W7Ez2s?=
 =?us-ascii?Q?l6yABkPjQ3tKMankvfVwUKjWCX9xHLPMlOLq8h2BRjHdXq4Ce1Fnt+/JvG7j?=
 =?us-ascii?Q?7tccHWPxRp5P0y4JEx6+YKhu4IbG5CNLna3hJZqSIRU1byieYNq7vap7Utrg?=
 =?us-ascii?Q?OmnancCHG+0mbflxkDLpE/aD49gF551i0pLOrg8Mf6FQ7U/qeElYmMop1bTL?=
 =?us-ascii?Q?o0M8LksO+w252rUA/pAGzuGQkNBD7LmyK30mDzndGR5u3hDab8m1MZgGaudG?=
 =?us-ascii?Q?wD0pp1r44EpuHObww8uNs1+heQ3Mu2vtwkPxttYM1eBDx/X5fP18R+Y5seUf?=
 =?us-ascii?Q?REM8FkZwwgX+4V1Z1Y2cbNDN79PSDx2XxI92IQJ+svt3KUTlwG1d4FycgDhS?=
 =?us-ascii?Q?eJ8Cnq/pn79pwqH8vK4w3jHEkcuIdhjtqJcyX3co2jVEhZON8UXHlcHbhXo6?=
 =?us-ascii?Q?ViLHRn4JcdeGo/1XVqNpRoNz9KWb1YTJndjBB0MSsF9RVmHwkVNTg3GDGA2X?=
 =?us-ascii?Q?jY9QUXM5NVmtXGDSwKh++qQXJ59QJxWc6/DlEFV52R6jk03MLsrxded0EzP/?=
 =?us-ascii?Q?b2lIWDApCDUkwVGJJ4Er7XedmPoO5h24uPW87Td/ZGP02zCN?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20106c2-3902-4640-a45e-08de89068a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 18:03:51.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyZPq525mtEX71w2xdSZ7wRssAoDHD9Z6RNhg3lpCY5+QPGS4luQh45OhIxZ+tzKodld2kbYHK03Mn9+Ibzhaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6634
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9699-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D22122FB2BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Mar 20, 2026 at 05:28:42PM -0700, Long Li wrote:
> > When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
> > destroys the RX WQ objects but does not disable vPort RX steering in
> > firmware. This leaves stale steering configuration that still points
> > to the destroyed RX objects.
> >
> > If traffic continues to arrive (e.g. peer VM is still transmitting)
> > and the VF interface is subsequently brought up (mana_open), the
> > firmware may deliver completions using stale CQ IDs from the old RX obj=
ects.
> > These CQ IDs can be reused by the ethernet driver for new TX CQs,
> > causing RX completions to land on TX CQs:
> >
> >   WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq =3D=3D false)
> >   WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup
> > fails)
> >
> > Fix this by disabling vPort RX steering before destroying RX WQ objects=
.
> > Note that mana_fence_rqs() cannot be used here because the fence
> > completion is delivered on the CQ, which is polled by user-mode (e.g.
> > DPDK) and not visible to the kernel driver.
> >
> > Refactor the disable logic into a shared mana_disable_vport_rx() in
> > mana_en, exported for use by mana_ib, replacing the duplicate code.
> > The ethernet driver's mana_dealloc_queues() is also updated to call
> > this common function.
> >
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/qp.c               | 17 ++++++++++++++++-
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
> >  include/net/mana/mana.h                       |  1 +
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c index 80cf4ade4b75..b27084c53a14
> > 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -829,11 +829,26 @@ static int mana_ib_destroy_qp_rss(struct
> mana_ib_qp *qp,
> >  	struct net_device *ndev;
> >  	struct mana_ib_wq *wq;
> >  	struct ib_wq *ibwq;
> > -	int i;
> > +	int i, err;
> >
> >  	ndev =3D mana_ib_get_netdev(qp->ibqp.device, qp->port);
> >  	mpc =3D netdev_priv(ndev);
> >
> > +	/* Disable vPort RX steering before destroying RX WQ objects.
> > +	 * Otherwise firmware still routes traffic to the destroyed queues,
> > +	 * which can cause bogus completions on reused CQ IDs when the
> > +	 * ethernet driver later creates new queues on mana_open().
> > +	 *
> > +	 * Unlike the ethernet teardown path, mana_fence_rqs() cannot be
> > +	 * used here because the fence completion CQE is delivered on the
> > +	 * CQ which is polled by userspace (e.g. DPDK), so there is no way
> > +	 * for the kernel to wait for fence completion.
> > +	 */
> > +	err =3D mana_disable_vport_rx(mpc);
> > +	if (err)
> > +		ibdev_err(&mdev->ib_dev,
> > +			  "Failed to disable vPort RX: %d\n", err);
>=20
> mana_cfg_vport_steering() is already prints in all failure scenarios.
>=20
> Thanks

I'm sending v2 with this message removed.

Thanks,
Long

>=20
> > +
> >  	for (i =3D 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
> >  		ibwq =3D ind_tbl->ind_tbl[i];
> >  		wq =3D container_of(ibwq, struct mana_ib_wq, ibwq); diff --git
> > a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 22444c7530a5..51719ef1c09b 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -2934,6 +2934,13 @@ static void mana_rss_table_init(struct
> mana_port_context *apc)
> >  			ethtool_rxfh_indir_default(i, apc->num_queues);  }
> >
> > +int mana_disable_vport_rx(struct mana_port_context *apc) {
> > +	return mana_cfg_vport_steering(apc, TRI_STATE_FALSE, false, false,
> > +				       false);
> > +}
> > +EXPORT_SYMBOL_NS(mana_disable_vport_rx, "NET_MANA");
> > +
> >  int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
> >  		    bool update_hash, bool update_tab)  { @@ -3339,10 +3346,12
> @@
> > static int mana_dealloc_queues(struct net_device *ndev)
> >  	 */
> >
> >  	apc->rss_state =3D TRI_STATE_FALSE;
> > -	err =3D mana_config_rss(apc, TRI_STATE_FALSE, false, false);
> > +	err =3D mana_disable_vport_rx(apc);
> >  	if (err && mana_en_need_log(apc, err))
> >  		netdev_err(ndev, "Failed to disable vPort: %d\n", err);
> >
> > +	mana_fence_rqs(apc);
> > +
> >  	/* Even in err case, still need to cleanup the vPort */
> >  	mana_destroy_rxqs(apc);
> >  	mana_destroy_txq(apc);
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> > 204c2b612a62..2634e9135eed 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -574,6 +574,7 @@ struct mana_port_context {  netdev_tx_t
> > mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);  int
> > mana_config_rss(struct mana_port_context *ac, enum TRI_STATE rx,
> >  		    bool update_hash, bool update_tab);
> > +int mana_disable_vport_rx(struct mana_port_context *apc);
> >
> >  int mana_alloc_queues(struct net_device *ndev);  int
> > mana_attach(struct net_device *ndev);
> > --
> > 2.43.0
> >

