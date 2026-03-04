Return-Path: <linux-hyperv+bounces-9125-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB20Dnh3p2kchwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9125-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:06:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5B1F8AF9
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7D531CEDDC
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B131DE8AE;
	Wed,  4 Mar 2026 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cp4kEFxX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022107.outbound.protection.outlook.com [52.101.53.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA14C92;
	Wed,  4 Mar 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582467; cv=fail; b=WU//0IGsThRHAcUjjgMdNAl2DioC+5ECntb6iiHcj84VnYxSQwZDkX2Brqz7H1ye83/RUgBxHI9Z0lbwZahVaBv2pQu1JFW505jqGrRzokTUT6bVFoBaLHB+MxD3kXyT4IPMv5HdrkDVIM/KnUnaoIuA7VUfYm/LarlirPNYTo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582467; c=relaxed/simple;
	bh=7tB0j26ifuZwAuUCDx9/sYrT71PdRq32WcfvVt5uuQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jqJrcASO1G9gubanM5+LK3mubUyqUSWmBgk/e9aWYA3nTcybVEorVyTFTPgWaxRD1KRTKgfuswzNrZH1Q9wQFse7OX7Mx7h+H6KyHnnQSTFA9TlxgHo5oUlN2l2mZPVQdr602Ma7d7UoDK/XR7ICZAtR6hu53GLKWYd72V4mv20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cp4kEFxX; arc=fail smtp.client-ip=52.101.53.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccz5EQtE4w7qXodQPb/fMc+eOGWJ38V2PnVu3SrAAZupx/rNF5up8Ttj2T4HV9e+pRhpBxKy1V76BFWZxn5gSrxEyr374PjPgM3oyo2f1nKUwqLnw1Eq7NcIHaAUHZipL6xq0AAe2/c2XLhSJsY1ilHqRadr5j7JuqZntIim/adB5eFXqRiRU5ktgmicmHSSzdPOsqT8qABQHykaJxiTOtHLAH2+2kaD2kJYXmKkdzZEhD87wsVdDKxqYRtS6K1wiXWO97PMAYM+PijfnlEhmdhqOuqYqC0gP6X2QWAsXMej2PrwHhwSegJ1QfHq/qZbku9eVafLPiLk+J1okEGfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tB0j26ifuZwAuUCDx9/sYrT71PdRq32WcfvVt5uuQo=;
 b=Ao5w8O1e1i+J3mUbVmKsfVE89SA+6cRYnpOWAmR6CKnXwHDQooIYzph8/Rf2hkXLyi9nvHv38vqa6bu2SM1mjIbcNSH6kP5JVt9tjb/YHkCp0xk7SHUr00DTYRh9X1RewcUwUg7wqOYlGGkLhlY6NRscJu81LaqV7R4EXa3kuYtO448obgzlTK5j9exGkW/Vh3LMAEZpGOT+Iydz5946xiLeCjP59oezPGyEc6UI0g/e1gKcV6OctCkvtqCOroZSlzWVcI0+Czqo21LbFW7skQxP2PQJnUwPD2aQ5lku93utPPpBOSBxM2DtnQP1OP0KK6LGgB+7xU5ZOzmdgfJGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tB0j26ifuZwAuUCDx9/sYrT71PdRq32WcfvVt5uuQo=;
 b=cp4kEFxXLSEcPfFDZpR5fiwT+2BUBB3wGPh6DSeEo3ktY2C6e9uD2dO70E+L8GplxirAw9xddbqwMc8JHpIMG/eZjP15HVlgmXPeowN1K0lqOV2+ySXKsqnnDv3ObWtdDIsbbX5dPKMU2SunrfaTY+P7+zAPSoh6hA7FbrNODzM=
Received: from LV2PR21MB3374.namprd21.prod.outlook.com (2603:10b6:408:14c::21)
 by LV9PR21MB5406.namprd21.prod.outlook.com (2603:10b6:408:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.3; Wed, 4 Mar
 2026 00:01:00 +0000
Received: from LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46]) by LV2PR21MB3374.namprd21.prod.outlook.com
 ([fe80::f2b8:576a:8c2f:ae46%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 00:01:01 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next 0/6] net: mana: Per-vPort EQ and
 MSI-X interrupt management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next 0/6] net: mana: Per-vPort EQ and
 MSI-X interrupt management
Thread-Index: AQHcqFeZz2SNG5qLzE29P18avz8EgLWcIrEAgAFggYA=
Date: Wed, 4 Mar 2026 00:01:01 +0000
Message-ID:
 <LV2PR21MB3374FDC7C873E611735F8F48CE7CA@LV2PR21MB3374.namprd21.prod.outlook.com>
References: <20260228021144.85054-1-longli@microsoft.com>
 <20260302185902.5a778bb4@kernel.org>
In-Reply-To: <20260302185902.5a778bb4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87e35bb7-46c1-4cf1-8d78-cbcc8f78c74d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-04T00:00:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3374:EE_|LV9PR21MB5406:EE_
x-ms-office365-filtering-correlation-id: 207ec469-32f7-406f-4b87-08de79811f3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 wDvP7+BsKZ3DDRqFt6AIdbBqG/avmfYiwl9BL3DWP3xUj9lT8grNsoiKeudcVBvLS+Xuy5B501yxhWzeM4wTc/BPxMhyPAggdxaZur3LcMBRsWr3/rvsLPqvOf4ifwX8YaKuA1loyi35/906oaHE4HptumVPM4r0UR2jvNDnXgdAewl7IQVqgAoTHpsq4aLLFPKSU522q+dgDDCb6eydFEnvSkcHOE5j3mLgK2ias/v54aPR5HutVAPkH6Sfd1bDxFxoi0jKgmsf2w+EV3Dfm7JztINPZevvWQhem10eJxGKZhlzvpijB1uITJ2oV0pheeZQtqGaGPmGBSACrpPrL6MDwtqFEvKReXubESoI05Z+CaxNcqGAC+/Ic5hBP0QBTqsgUtF7NxkU4MdFUubZzzJ6yf+iCV/krlb1/OEhkef7kO0t0XMrKzVbZU+gC3xywUZ9Qm3s3JXwtcFyL2xf+WBwLeao+6g7/AZi+Hx1W/z2tXPcMpkdZsLdao1hBr5VfYzEaWf3oxeSfDswt5++k1A5vsFLFzoykEZ1Avbqh+ZnVFc/skkpx0cqbc8/w5iScOA0B4LX2f7r+cBbvn4FbFpprrv+6aWAZ1l311NM9RsAXSWmIzaobvxRZBAN1JYtL6OlXM00v2G6qqk75veB2xqkbbl7jf35F/scXoqpHR98svbhDFhw7OWVTLTE2ykKBHgE96FlbL9GaumjW2gw4NZmjFt5xLk64eFC4fM4232S0hKL+hi6eYp/cslrYKWTERti7xbE/cgB5KsscyRUIHaZIx3K0JhEyOmOdIKCqWY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3374.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zy5b97FkPNzmHKYqE8yi1E3V8CSJuBIrgq9/lvR5wb1eglvzrzU9uFlp2ZKC?=
 =?us-ascii?Q?56/VAe3Vqhkhh9aKWL4j4sh/Qzi8+YSs9Q8654o8jL9HZfVit2IsLCNzdVR7?=
 =?us-ascii?Q?jX/N77hHDKu4jzHA81k2yP5DrS97+/JyNFVaVsj1Q3dqsf6FBey6kPaNvK0d?=
 =?us-ascii?Q?XMA2BRz1kKgANNtrGAWLZlZZpEjyhYMKgBpMXa1MIAwCaCvGrMFKEXHkJ7S/?=
 =?us-ascii?Q?MgCeP0zWwpovgxI9zDAxcdDgYhQg5xyp1O9SQ535NLysQFNKoLCIbTqTkOhi?=
 =?us-ascii?Q?J5wYl0tliBD+m+gxi7aexNCb94VEZqVdhZYF//t/RHgVAVxXeHQeAousq0sX?=
 =?us-ascii?Q?Keg3C5zWbRfQl6okOIVKBwZ0/EOLi8YWiUJtZsx8LtpHcJu7sLyuXGvnibUQ?=
 =?us-ascii?Q?rxel33PfbES9m/8PbKD0vJPwQ6mm9f7VXuOnPoccJviyuIY4bcJMb7IdnKgW?=
 =?us-ascii?Q?z3GeyjXJRhCU9nrB4aI08fzxqjrfDt/WHaanFpV85Pt35PFBFS/Glu5O4Gmn?=
 =?us-ascii?Q?nxyx4F79/FChqCFm7Ud/kXxnCMKBnhBoQBVzMEOjLm5f5uGqWgB1hW1ld+zc?=
 =?us-ascii?Q?sFNed30APAlmQaDj81yYK1F0BLji/vOh2BZNhOAcDzZ0bk+B8ShJPsF0UG7F?=
 =?us-ascii?Q?85ZJ7oemvyvVqs53mfGy3gJ6pWAO7Mi0uokkvmp7ACKcyCXeGGQ6oWm7RV9n?=
 =?us-ascii?Q?f6YXnlJ8UEOPBE5Vbq9EU0icOZCrQBbSjoZHBXu1Xzd+ayDBUnL32Hn4BJQU?=
 =?us-ascii?Q?1LRT1EEBGSvhPjxPk7+tWEY4nPsitpe4hrh0cscQ6udAk9aC2ku7uUPwuaPp?=
 =?us-ascii?Q?mGEmBEEegD8pc1JLhaeoXV/7MB5JzJ4dMl6hM4i514LLrIJE0lXK0+Vx8qm0?=
 =?us-ascii?Q?7YvhHSThL21orGiXXw3N0SQ1gF/BqztH+9aJX3rUa06MpBtrx6a19gKQ0xtR?=
 =?us-ascii?Q?HLy7qM43NawI/MmWKAP5H9WqbSqhtDp6m9tr+HmaFyHa5vrSNRdzs0VkwsRN?=
 =?us-ascii?Q?18U3zqzc/nEFMA2GkCF8Xv4WPtPkgkzW+KgObv9CsMIFjuYhgd8Hqllu/Geo?=
 =?us-ascii?Q?RGBachiFbJz9Tg3+8K59El0J6VfWR38lPJM343queE3b31yBGwIP9JDI/4pC?=
 =?us-ascii?Q?pIwHEUC7Ial5JbtmAEhlnPw8NuW/972V8suq/tKopgcUWJ2Xf4UUuQUEO2R2?=
 =?us-ascii?Q?u14bmyrhaF8mDiU19yrNEaOG17FE7J5fx8pi3F1HKAZHkCGzkWnVbobnBoxw?=
 =?us-ascii?Q?PeCjrA3dOjGEPTsYNpSdX3qCQIm1UFOvayBg7wqUFgF8hN08/YjkJciF0D74?=
 =?us-ascii?Q?c0bSRjqG+ai22g5jCviR3yRTzYi4Es5zuEA2I9V+koj4VJOUzjFYYtjMgO8E?=
 =?us-ascii?Q?PH57hN0AWiPhHmHuBF2Q8LVqA6MqFiimqt62lLGEFMGx0qinqTUtUMy7z8iQ?=
 =?us-ascii?Q?uYyyjbMnD9TnyIJdaU0m1siT9h40wX/bZ+DH8RuAio9PFJIYTgGIDx7NQ/mu?=
 =?us-ascii?Q?c5e5ZMWPZr9dB2LXoTh2O26hoH7BBwgXKT2YPdritYZDXIVABv4hhNgnP/Iw?=
 =?us-ascii?Q?Rku3Q5Gq28oSlQ/s+rjU5P99J0R05a1URX+g50h5j8eTISTq29rZrIz3OWoL?=
 =?us-ascii?Q?qZnZmkLXoXp19+xSO2U8HAKbeg1d82usmPnrrwuvl4G40k+SvC32klmtf25C?=
 =?us-ascii?Q?vkOUkCz55CJBGup8DEBvr9kRu+dSvZ3rskBrbJetvq+t+M5t?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207ec469-32f7-406f-4b87-08de79811f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 00:01:01.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CjYCSMMKqaJuLXKDmeYp77bvs4Z8hLbB92CZ3lhWgpbDRCwOXYVP0JnL/olFthWRJZRFNjxrfjww9El1hoBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5406
X-Rspamd-Queue-Id: 94C5B1F8AF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9125-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> On Fri, 27 Feb 2026 18:11:38 -0800 Long Li wrote:
> > This series adds per-vPort Event Queue (EQ) allocation and MSI-X
> > interrupt management for the MANA driver. Previously, all vPorts
> > shared a single set of EQs. This change enables dedicated EQs per
> > vPort with support for both dedicated and shared MSI-X vector allocatio=
n
> modes.
>=20
> Does not apply to net-next, please rebase.

I have sent v2.

Thank you,
Long

