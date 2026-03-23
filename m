Return-Path: <linux-hyperv+bounces-9708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGxIwKfwWn+UAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9708-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 21:13:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45092FD064
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C3BC30E1FB2
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D4364E8E;
	Mon, 23 Mar 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JlilEfkt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020122.outbound.protection.outlook.com [40.93.198.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39F3624B0;
	Mon, 23 Mar 2026 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296115; cv=fail; b=bIOFpYcNtB7DnTq7FcR/QGTv4Vc+CbKlhOMwqUYahj+fd4KdAelzpg2/G6TGt6YCvYRuZx5uAzlbURuCv9q0VWlWoycopAvaNe77dyPFVhmwghYioxyOqDuDHFcPIpeeLzCUGxg3PoZBfsxhaGR++O9dyWWLzvC9fwgXcGM/Xic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296115; c=relaxed/simple;
	bh=itursPQNE68YODraeDpsrYNxwUvMcQvb4po6YtE81+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SEt5Ri8FH0zZja//OZY8J2rBx3TM1tqGiIrGRSL9yAukgn7ROiBN1rViZeowwP64veUJnfrElrXkh7u/Izy3PfHti1F1H5dhzsfBTumMVkJhRukv15010U1HZjTqIZ9FbWld/go38Le/hdFQ8dZAT8xv6dA1gx7D02bnjE+aCzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JlilEfkt; arc=fail smtp.client-ip=40.93.198.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKWASgvfMxTJFseZ8GVw6v6NFO1t95lzzdtNkO0KxMMT9owXHBU7q6+I2hKnIAfUvNhnaAdtAj0p9fEXVFzzup58VsLpsVRMvuyZ0DZqo+ALIlpW87BDRzyCbo5f8KBTFdLkfwMM5/2wUrX1jSOV/n2x27JtjucJZyBEDiKsEdGW7FhLWuix7LtfAx2ZoWIRd5+nncMP/Rt9AmwW0l29AwFaHx1bfMVie6OSz6prjunvW1E/RUV2V+uz9ggyPOqPmKtwrSHxCtxcbb/vpdDWSIZTm6U+2QjxlONw3ENIsdx0aNtSFSHam0WH8TP3AeZz33EWlftHzO1lfqfFNxn3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itursPQNE68YODraeDpsrYNxwUvMcQvb4po6YtE81+8=;
 b=g+fu8TZ4kbZ7Mv9Udb7qCkklyqnF74IbHaN8II1A8ZWJ0GWW97sJ6eTccxQHADzBk4jbL3WhFq6LAULnawrKAwMXmFy6/0nguEqCmQcbO/XeBT/j2eHT7ByTlvWs55sh8cdue4dk5woERsRxgjiq5TQCCPPScIznhzM8UPGEF6XyGyzjvpoCKMvQ1NzFZxcjp3xsWHIS9A2U6gXFsZ83wMq8CZtTvDC18WseyUCPgE+Yuhb3W4/CGGEtC70Y+hRnTFmlXDl+lqY67wyQwQF1dt05nHeDk5Lq+Bd3cBC91sI+OxOTJvsV8TuLZD1smeBL9Xq/IKWTMFzyXUlBTKACbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itursPQNE68YODraeDpsrYNxwUvMcQvb4po6YtE81+8=;
 b=JlilEfktHhkmpW9xD1mSG8mUwwoTYNnHgU1y+/He9ajQyTdEjN7giTD6Re1fLtCeACT94Jip4jWbXOXS+0pWS046rpCZQ1coFH4LYtCJSCywkS/asUyR0SXvSV1d1/SekS+6/7f8WTbkxJOUBK7ylQ+DeRfC6Kl2uNBp77vVoLw=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS0PR21MB6115.namprd21.prod.outlook.com (2603:10b6:8:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 20:01:50 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.004; Mon, 23 Mar 2026
 20:01:50 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4 0/6] net: mana: Per-vPort EQ
 and MSI-X interrupt management
Thread-Index: AQHcuMTnedUleAu/2ESp+Glq+cVJj7W8JI+AgABpTbA=
Date: Mon, 23 Mar 2026 20:01:50 +0000
Message-ID:
 <SA1PR21MB668340F399D28158B8C38C6ACE4BA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <cover.1774049761.git.longli@microsoft.com>
 <20260323134337.GA69756@horms.kernel.org>
In-Reply-To: <20260323134337.GA69756@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5c72a64d-7a5c-4080-a7e5-66cb7ed2cd80;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-23T20:00:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS0PR21MB6115:EE_
x-ms-office365-filtering-correlation-id: 54cfd0c2-4914-4c61-24fd-08de8917055b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 4PG1/187VGTyzdI52ZvNobp0no/vRLasN9Wv9W2Rgr9cA5xN/cEXBHVF2ZFS13FEgoUpUTXvqoVQ5G9l8jpk/0pMgbHfep3smLfFiTnQbWwUQ9Hjf8HTB01qesfCGfYPFLcC5bBtWh2uD+rXLMPc+qz02kY9WnUVmnYahn3casqZDVMqLvnWkJleIU3+5AyicdkyS817j6gu0P7szf9q2N4oVDGkmVO8ucegPuNuBGMH7wFa0WtGUqUzEL5DgxHVXOhIZIs6Bj0QbIeQ3oTUCNJsGb0ByAVLr8ECG6X2iK+l6VEw9ELLPEC4o1YdxXGMG/U0rj1hTQTN//Wto5sDgWLSo78j3KH4/YQUqvUSuZSt7mQu/fBVJbNEgaFkXGGGmeJ54yjRkaS4joJhDxc0gjelpH99s4/Kn03q36bhP4uJ249iDFYDHlGO0Zal48AcFLavoY3UT4aJWqOybWxByG98yMPS9kClqtRVbeoTTGwDaDZMOnV5DHp2PTDZCLouKOv/kmmpP6hTLgJoQ8JpLKWtosh4xV/KG2fw6+dNPb5sLgwhhvJp7o0Y+5BrV8k1e/2ZfUJi4RlJ03qK41nTin1GLZK24i/KGxfSIni2IVSTu7bn9DlSsWyHR2VYrEq0T7kzqIkiHuGeso6FYZBoQ1OXs0nED0a/i9jComzyG8XwRY9rIaSeBRjHKc/UfAVEK6ZCgxHN9Bx2TkZO5JPxCHpFaEUmVORdmeShJtswKiGtwOIfzRgAvjPVErMO8JVqCGAA5N1uDt1y8tRSZRtESdY2Vu0yH08/6eYeKoFk40I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CYuMqwDgGY3tn/iKWwB+ny9LAtv8Cyy3rIfTvlwJwkR5DvMLEU3QUobex0lC?=
 =?us-ascii?Q?QwSsB4vT0JdFZVgcohcpmyUB0cyZIJhdy/K90VCo+0spN4U39pQzGqvCqoLV?=
 =?us-ascii?Q?lio2SaHgatdbFR0GZieUahCO++CtuWxpMK1bCdXSSYs0215amafGI62iiuWz?=
 =?us-ascii?Q?NO3430pEgtjPpIdvJrNMVKiciM8keFV/CvfQDjjFFXiKDpSjWZzeQbeuEGHI?=
 =?us-ascii?Q?mfrlWPYox0Vg6Dbd9ZDctuj/hUBJaMGVvNspwGflkAsA9lc6u923bKo7xvGY?=
 =?us-ascii?Q?9ulo4UpkHWXXoDejYwnfAiSqgdDpbjzX55m5PvY8hxaNCxcG5+15LI8b4P5L?=
 =?us-ascii?Q?dtVw4SwjGjbyVGFx2kNwuHCN79I+Xi0OKcCJT13KrmcGwP6Vns9V8EU8VsI1?=
 =?us-ascii?Q?PlGUUjUiF4eaucZeqadVtMjUqLaVLWbxRr6whh6CjzWgj0z29+XMBA+lnM6a?=
 =?us-ascii?Q?S+/fTOV37laddpaGGECPOyuRCHBRe+7RDKiqlNg9izPN5fuSdx+Sx/nMaOmS?=
 =?us-ascii?Q?oiSa/QOYZ+hI+khO7fzUM1u21BTpWrKuVCqEDIKasIeBHy9fC0Njj4Coxnx1?=
 =?us-ascii?Q?noDfUTg4rTgEfdK7a8a7OQL6MHUpkHuWNiO0h0Y5C0sRY9C0kUHylaCW6FmF?=
 =?us-ascii?Q?Qdk4TZVhYryMndcqbz3OWAmrXghquA9IhA9ohoDLyQPt1Vxvei3PKioPAlV5?=
 =?us-ascii?Q?pzb/uTXmVhePyMt5kZJFRioGCCm9Of/WChL5nyp13jvgRpgNE9rQi/F015ud?=
 =?us-ascii?Q?MOf0D0lVlILdcd/3SiN6xrfQpRbhVGtmIDVz0fQrchZ5xns75HOlbV2QMgjv?=
 =?us-ascii?Q?WL/j2RFoGwzeejntbXTubwmQBMLgkW6n/8RCdSF9VhMdGn0y/LPbvLOKPkOR?=
 =?us-ascii?Q?zurO2bSGg56JBtndLyLtr/roehZYCDjiZLRgVVmC5GR3xfU/1ZuswW6mrXmq?=
 =?us-ascii?Q?O1jmmNlok7uX56t8i0Fkgy0vTPrLS2vfJtJClKfRjkbIsfwxZM1kcfJIK8lr?=
 =?us-ascii?Q?WWUR0RG9TKoOs/1Hk3agkbl3bUE9eRHvE8wttuk9zdptYE/mp0jMOwicWVEE?=
 =?us-ascii?Q?+zs+b01V48bPXvWMSU0ytd+vHR1ju69xZkXTNYIGaNX6++OcxHFfFY3rFNi2?=
 =?us-ascii?Q?1tGI5JqLqcSkOgkS2OrlPD7B14QnZbLUsd8Jc5UgCwLd6wlqzbsThA86+Lip?=
 =?us-ascii?Q?chV8VrBlrfLpKTOPjQPvXCOvS1Oi4OtpW4ftxK9LmAxcrIE9CehEkjzBQgO5?=
 =?us-ascii?Q?e0cLDo3XWQ05nIZKVxlQcp0ovU3h1y8Od5CCLoEC2nnKExYlciXISGtxQhAQ?=
 =?us-ascii?Q?90R3WiM1IatwUvpHGcdDCf0lPWoDwefeJnBVHPVYSekTk+oVTj0uoj2SVSqd?=
 =?us-ascii?Q?hqTPTUWap2h3XdV38CuBqXVqAW3hiP9ihXx/30aPvfPvHM1Tg4TPr/I4TovT?=
 =?us-ascii?Q?cw/yHsAfqghZR6+XZHXKSU0AB3ddPgXBInRNbW7HZrKRZ++PDNJoUCb1JJzc?=
 =?us-ascii?Q?JHrFDI/UoA2oM+ZoYnPVYuW7FWg7/9nq9pHNaCusjM6jSnAtSoKlueTmiUIO?=
 =?us-ascii?Q?cMZdzgX5h8j996FOxJUM1ZJzrGV95BmWRqlB+fteuULbM1sO7wA1cSAKCUQG?=
 =?us-ascii?Q?dnLZbr9FTTXVyJhF3GiJ1ob88upf5bOK7Yj0cnrtCq+iPh7kryUxAh5oufKo?=
 =?us-ascii?Q?uqzDCrrv5z1vHFkdUYXO6rZiG1ZGVSHUJiQk3jrWw/cHlWro?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cfd0c2-4914-4c61-24fd-08de8917055b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 20:01:50.0228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx+FpPED2Zl0FUm0ZoHiOPxVq3vGGPRuaP1FALV4IAXvFppR57OiZy8xdvEioqXz7h8Y+HZUB4iNjYmEqEiydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6115
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9708-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,ziepe.ca:email,davemloft.net:email,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E45092FD064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, March 23, 2026 6:44 AM
> To: Long Li <longli@microsoft.com>
> Cc: Konstantin Taranov <kotaranov@microsoft.com>; Jakub Kicinski
> <kuba@kernel.org>; David S . Miller <davem@davemloft.net>; Paolo Abeni
> <pabeni@redhat.com>; Eric Dumazet <edumazet@google.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky
> <leon@kernel.org>; Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; netdev@vger.kernel.org; linux-rdma@vger.kernel.org=
;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next v4 0/6] net: mana: Per-vPort EQ a=
nd
> MSI-X interrupt management
>=20
> On Fri, Mar 20, 2026 at 04:54:13PM -0700, Long Li wrote:
> > This series adds per-vPort Event Queue (EQ) allocation and MSI-X
> > interrupt management for the MANA driver. Previously, all vPorts
> > shared a single set of EQs. This change enables dedicated EQs per
> > vPort with support for both dedicated and shared MSI-X vector allocatio=
n
> modes.
>=20
> ...
>=20
> Hi Long Li,
>=20
> Unfortunately this series did not apply to net-next cleanly.
> Which breaks our CI.
>=20
> Please rebase and repost.
>=20
> Thanks!

I have sent v5 of the patch set.

Please apply the patch set after this patch "net: mana: Set default number =
of queues to 16"

Thank you,
Long

