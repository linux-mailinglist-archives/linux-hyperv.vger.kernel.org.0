Return-Path: <linux-hyperv+bounces-5941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E1ADE0B0
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B818994D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B7190472;
	Wed, 18 Jun 2025 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dX4Ih+N+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020114.outbound.protection.outlook.com [52.101.56.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97C4A1D;
	Wed, 18 Jun 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210568; cv=fail; b=eWsM3gUT38IiQxeVAy0nST/K/MM04xigLUJdMJWcYJ5cCgZ9lFUmCnguQwSV9ZbDej08IzrZm3SOz8OeV42cft0tP5TbtWeA2kShUrd8mfPQagPSfbatrjMWU/wwZOjxpSC1qoCbbu9tp+1ZRlDJw2S+erek1lYevogOsMPKh74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210568; c=relaxed/simple;
	bh=u5+Q2JCPdmaHB9til7VdikntRFE2PkfuRzaJFmnfoQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J5vskqJrVrrkjmT6GQJMDZ+ONLJTqFo1BkOfwII7mIB/HyWKfiac0TQUO/hKvlRr7wckZTuRza0rGSAOm9zq6drNB9T0SpjA0fLlCN4cw+88gVTnICChzUC7XYck+/FGTXJNaKAa0tDaOx00wBZoGVUwyRrXZo6r9htqIYNJPWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dX4Ih+N+; arc=fail smtp.client-ip=52.101.56.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNBp498HgdrO4B8tbwFqQ7UtlUVakXlZYwRnL/xWvcTQ8M5SZ669cOKothlUwhfTx8gSqKtkgm5UvAAZpgsukPed+uhLLgn60SwZb5bRlppc8iQ5NGFDjOt62lW5hB4OqAO5mwFclTDXU6oPGQVmOTCfJhz72FDwY+RB5pdV+PWVCDHhZ4W4YuJOa4O/LxssDikXzNz7A9Hs5ozS08WLMUKDhULGy8y78ZRPPz2eK7+l+bRanOaO5dQGSaS0UtxwUE3SOUVTQ/6x9DEETeV51Gdzp67ZyJsuScbAUshJUWRgTlD7cjs5RhDuuVJfZG9NSeYGMPF68QMKzMMKIVbrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5+Q2JCPdmaHB9til7VdikntRFE2PkfuRzaJFmnfoQs=;
 b=ME4Kp3CeuWK5D2K1bmABa+fLmM3DxtbToRY/bKGl23iwabQTq0PGVvmojQt68lzt6r7L8C2qZaBtR6jrROQaE8LXtLN/6/BXu38KAvhvnK2Gws18cujBztTHmxlnqJEGVpH2jkiyUG77ZMyK0FjdILwTpXHVlyaYk/YjxEcMQ1qONrrI9ROYIYBCpLP8XCVNlqH1iAQ5igBREbeQkMyOKV8p1DxJr9Eh5HHiy9JoqjjdsDjWnN70EbK0Xp9mdrIT7H5KJKkb/6aGtYxljT7nWVcrqr9C38dFD1m5O8c3sP1O4lolur4H0dQ4cmF30soej1FCTNd6fjR7O3edK70Gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5+Q2JCPdmaHB9til7VdikntRFE2PkfuRzaJFmnfoQs=;
 b=dX4Ih+N+/ZfeC/5jEcGRok40EPWx6n/SlRQoVczavk8HOMuVei8O+8JBoz+X6pR8pPJEsVzaxsvuysmh1wv42ws4bGjH91iML0M2ubZTKBDis6ffFH9yORPraaQDPkINYm+5a7Vf+A9Y7CC0MeFtTy0DzZNODI6ZlwB3YiVk5vk=
Received: from DS7PR21MB3102.namprd21.prod.outlook.com (2603:10b6:8:76::17) by
 DS0PR21MB3861.namprd21.prod.outlook.com (2603:10b6:8:121::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.6; Wed, 18 Jun 2025 01:36:04 +0000
Received: from DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f]) by DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f%3]) with mapi id 15.20.8880.004; Wed, 18 Jun 2025
 01:36:04 +0000
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch net-next v2] net: mana: Record doorbell
 physical address in PF mode
Thread-Topic: [EXTERNAL] Re: [Patch net-next v2] net: mana: Record doorbell
 physical address in PF mode
Thread-Index: AQHb3w1I8Nwp1g0iV0m6wt3fwe2eUbQIJIAg
Date: Wed, 18 Jun 2025 01:36:03 +0000
Message-ID:
 <DS7PR21MB31029FD3D38063D4F6F5ADA0CE72A@DS7PR21MB3102.namprd21.prod.outlook.com>
References: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
 <20250616152318.26e1ea3e@kernel.org>
In-Reply-To: <20250616152318.26e1ea3e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ad6352a-bf26-4765-800c-dc21f13f28fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T01:35:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3102:EE_|DS0PR21MB3861:EE_
x-ms-office365-filtering-correlation-id: 4ef2a7c2-696f-47f1-349b-08ddae087d34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0lQ3B3igbOB8VGDbEQp/KYADbBmzVUpq79s7yl0tKgFN8gfszPui9isAuaxa?=
 =?us-ascii?Q?8v+QWlbn9nbJARMxhPLJs8Ort9Dq5mAYQsL1Wh6pvdS11cLqIAXscSE8EstS?=
 =?us-ascii?Q?OaEXLZZqyRVLz9e1ob1QkoLhW6J3c0dGxOArfFUm6DInDvgGqdK0U8hDQzJF?=
 =?us-ascii?Q?d8eD0pBvNGh95rn8WKIJy/GEaNUg4ntYLd+puXM4VNPDdN59dbyYnfuvMUBp?=
 =?us-ascii?Q?aSZlhyDbUX7UG2SKVh1bVfyZdIAFOzyHt9SqHOtttVxvjgTyfmVYhJa+usD3?=
 =?us-ascii?Q?2smCaXnFbhanE2nM/kmDdmK2y0Rmp/bg9xHBiwC95p8PgaRmd7kv2ZMEHGlB?=
 =?us-ascii?Q?RL7N8L9jqUJ+37kclmKuG8ZMdsg3A4/kMcbNWDrMFMpwrhukUYzj+ArVaV2t?=
 =?us-ascii?Q?rvaLFR/PrmGa6oTbY/6uasvXv3O0bR9SXDrVWywmTnhQc30HzOF134FErnjp?=
 =?us-ascii?Q?SzdjaIJ62yp2hilJQ9drghEXITG8k0RWIef+sQqNNKs5o17rlGahn7WhlEfT?=
 =?us-ascii?Q?uOeKrNnhCkJjcCc0clDxACyYIyZJjKdQaeX/y0fRs0lZ7kBrz5l2p35vQHs7?=
 =?us-ascii?Q?98EdYPrMpqCQnJ69ZjrZRNvukstdqYzIRN+VCuPmC/NUSaveF568GzDM+/18?=
 =?us-ascii?Q?Zem8V9nf3M6ZC2/lMiknCtgFrI3sqXeZ6PE3CSCy2PGsOS4yZ7YN/AUaH8Xt?=
 =?us-ascii?Q?EaP0P2eZsQt6eKkNco3f2T0HOYIrk5f6CvyW8dYX2KJaof53i3j0/hbPm7WL?=
 =?us-ascii?Q?bil260p6z8rhmIw+i0UXENAk8imcTYKMwtXuj39mRkFboqBw8gxRytSnN0Ja?=
 =?us-ascii?Q?rXgroOXfORa9MB0PomzOncNXMQY1OmcbylQzxgAvM4k20kiabA2Gkm7pUcnH?=
 =?us-ascii?Q?hKPyDC+kB0e26zIS3lqUTDhIcfVFQh5+CnK/sR7FKgq4huHmCHEypbCtDHxB?=
 =?us-ascii?Q?Oo9BbqpV+um1oYak2dnHbL0gCqlhFTBoGRekoJxhYvTUOFez62Y8LKzUyhgK?=
 =?us-ascii?Q?TAkxWQot2tud7ojueK57wmNtTUUKVIUFcuM/cQ91u+OOw5bAQoynuYLLgMiV?=
 =?us-ascii?Q?BCyfsLAR87sC0dtPLibRjQNLXGJ0l1QqDxKPw2YCA0A7Fqd7rTvd2tZkXtCb?=
 =?us-ascii?Q?dCQACTfy8EED4GOHa5SZ6Oh6H9b4q5m4Drcy3u799L80i04OzloXUR0d0soN?=
 =?us-ascii?Q?LGEhpX3lFZGR/kAwAISNXoOjlDHS1dIH2vxQw+rfTG+rGDqyQ+hwsVj9pVUh?=
 =?us-ascii?Q?oQhbYA+sKMZYtOm9v2wbjTvD265/RgviIRaqQifWZGRNJoBXFIIx/JMLgCvu?=
 =?us-ascii?Q?3skI/J0e/1rM8VZe0p0t043wuFNmyNGpMHtCgShVc99uyEJxBOX8coHN8Enf?=
 =?us-ascii?Q?XU4w4pe0ugBlA9xNWMD1kZ2Purowa3gJs9D9pKBfgJUOChXbIJT/0qzML99k?=
 =?us-ascii?Q?Ddg9fR8WJHgo0gqx5ISBfpbvYE1xzCSmM1z3CteYLh2l4idwLMXMJw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3102.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IhIE4QkUASck/sIJRYUrsI9KR6ObjhqAEDD4WkpuidjCiLjIJo+37KDGAMYs?=
 =?us-ascii?Q?eqquv5X7pzqBpiq6lvHR7IYPWZQFQ/7w5xboAwMxn60SsbIarrK/WKmw9ETK?=
 =?us-ascii?Q?sBJ89X4izgG1+rW8mCqsFdZUaAL3MOsKAbMOjnF3XJsF9pC7zADSUT7twXoP?=
 =?us-ascii?Q?0QLGhYQr5voSQWBFMa+/rgRdDhtfvgsFn+e6MeB+bOxQvbOjkusOdm2aMJ8Q?=
 =?us-ascii?Q?Vt9hQZAapmQfUnsGqP65qlEO1wJkzmDc4M43rZRIBhngaKsCuDNej0Xb0l9D?=
 =?us-ascii?Q?4OStf/daFJSrhs7gQKSzMegYq4IkLt6h8n/tcLDnsqtazaOJak6vLPnZi2ib?=
 =?us-ascii?Q?FufinPQLcXCCLHB+Gg0b5HOMVW+L7C3fjAt6HX4XfCFG+lvdaqjUVBmAXrpv?=
 =?us-ascii?Q?XCeUNqM9/hGVYIpXduvitPyWau0S/396Cvdt85Ac95A+s79SEUTRDg98sGie?=
 =?us-ascii?Q?M+ayjWmQ2j4/9j0WSd7XGro8X0u8xXEqQpGLFtLXu1CH05eGCbJaxiW3BpKD?=
 =?us-ascii?Q?Edk7uFSfH5VUUZOpBiAmIUaT0oCQcjm23ywEvy6QEqP+SKi8+OVYYzNgZY3x?=
 =?us-ascii?Q?RN13+jSmogR9gj+nWV9l7DrdWDmRKfyc0QzpBjX3PtGWBWilxFPBpt3TMxiu?=
 =?us-ascii?Q?OqTQeOtI4AbEPJu/uevIO3kff2pI0QjdiyC3ek3lEcSG8DuVC2WYr7NXywhK?=
 =?us-ascii?Q?XZW5J/tA1Jq9qHtc98nrT2lXlKmB+oSuTexw3JOncMU5hGWJA/QNldmFiHH9?=
 =?us-ascii?Q?C4SLsjOFjmH83u9nQUoHrfKYt0lxH9P1yzv732zepqo80ROuvJaRNstgd5x5?=
 =?us-ascii?Q?b+0yyoMHAVtCbBCU/A7Fl1LRGd9KoGEjTXBdF3VcKgmU0uH3g2gOuYvUIkxM?=
 =?us-ascii?Q?7eujTuyWORC1YyqdZ7nEncchDR9YgD8LlMNUxPkA9+fnL9cawLOvVrRWKUhI?=
 =?us-ascii?Q?bzEu5WWl4SnEEDh+PWeAbvSl1QTXaKQKUpn2VaNaj7MhAcheGv6YIGpKJSLp?=
 =?us-ascii?Q?MYFQnWJ88QSQQDt2LuCmPBWe7bNGNoNks+cdWcoSbOsXESZPw2yogR0w58wc?=
 =?us-ascii?Q?I9fhkT0HapanKME8Y13deQTxqkFguGlBsVRv9f+9gAWlEXkwYwEw+pT5CEgp?=
 =?us-ascii?Q?jOWzdHjvE6A7aFBSmz0W++erRWBHBPZw9RfFu4W/iqIn8A++oPEakm/fp84i?=
 =?us-ascii?Q?3JZC6MlCF5LIns6Im1J5GAknF7AZWNwU7KtvKaW7a34/th2q16Fn5RyfqCnC?=
 =?us-ascii?Q?Bf6SiAw/ZheyzTd/0Dk59kam3vUjbLNRdTQs42u2Ina9Hcx9qDKOWKLrJx7N?=
 =?us-ascii?Q?hACV3jxqW1LsWW4stGLWCJ/TPOl/2+rYif2mksdLEWf2GJsXEBJcQzndF1bF?=
 =?us-ascii?Q?bA7SRpXrcsKO+6I4MY4kn9/w2STyCuW1FFtRGJDQqOg6NQtGPvNuZNmreqYH?=
 =?us-ascii?Q?4y20vMaHnAYw1jVp9rIioP8dSVc3HuOmPSer+1HSjMxLNyFOmmplOuUmpgZi?=
 =?us-ascii?Q?h9i8YYTJUcssouYsuIg3x94TR92JIn+fWriTNrKJeJrilR2TTdwfRjQ5mi5L?=
 =?us-ascii?Q?OXW+ji6/ZcT5l3YjMn4u7Uf3e7PjFlQZBEnbhVLZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3102.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef2a7c2-696f-47f1-349b-08ddae087d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 01:36:03.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QwIDzqat+YbVcqICHdgGhOM3dWoX67SJDaNS16l44ZHHIgL29Saoqj8irSahr+LJ4Nd0JSPInYWFtslFYO/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3861

> Subject: Re: [Patch net-next v2] net: mana: Record doorbell physical
> address in PF mode
>=20
> On Fri, 13 Jun 2025 10:46:05 -0700 longli@linuxonhyperv.com wrote:
> > MANA supports RDMA in PF mode. The driver should record the doorbell
> > physical address when in PF mode.
> >
> > The doorbell physical address is used by the RDMA driver to map
> > doorbell pages of the device to user-mode applications through RDMA
> > verbs interface. In the past, they have been mapped to user-mode while
> > the device is in VF mode. With the support for PF mode implemented,
> > also expose those pages in PF mode.
>=20
> It'd be good to indicate if the PF mode support is implemented as in read=
y to be
> posted to the list, or implemented as in already in the tree? If it's in =
tree then
> please quote the commit. If upcoming please rephrase.
>=20
> This commit msg is much better, thank you, but to a person handling backp=
orts it
> will still not be immediately clear whether this is prep work for a new c=
ode path,
> or a bug fix.
> --
> pw-bot: cr

Thank you. I'm sending v3.

Long

