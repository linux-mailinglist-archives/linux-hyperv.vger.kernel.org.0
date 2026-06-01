Return-Path: <linux-hyperv+bounces-11433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBYLEGS0HWrKdAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11433-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 18:33:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336A6229DA
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Jun 2026 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C4E6300E93D
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jun 2026 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8992DC32E;
	Mon,  1 Jun 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MeWEz+8+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023136.outbound.protection.outlook.com [40.107.201.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A930296BBA;
	Mon,  1 Jun 2026 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330786; cv=fail; b=Ud3npDAqAyH0JGnlEPE7rcU0+0hN64ol36dyO3/a/kgrQyMX7FM83fDd0P238crumq+8j5pu6IZXXkMb1ra0X1BLiiRZAjwVH6uus09sKMaA6+XC7QOnj8D3g1lVdcCubIuAzjNa712HeNrw02JLOqQAkBMU9PFRQU7yA66VDko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330786; c=relaxed/simple;
	bh=JPuZGRSPXddJI/UhNusxU5r8wlO0+ih48P4CTD0I2qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TX7I1nzlT5q1Qkin/QgpfIqhBfwgPRsM091zpaypE78OP4+IkWtj/GPgBLWSqKZ3GwW7ETh55U9WzrZVXiMLjeD2JGTuvSgJ6vsI+7xOubxwNj2pJb1EoRpm5CsZknVk7sKIp1JTpgrr9hVYtHoLkHjJJA8/BKejiTrdks2Pdvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MeWEz+8+; arc=fail smtp.client-ip=40.107.201.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct8XokKFHLQoAUyYi1Uu/x0j3Dxi+YuzqZr4Gmov8P9razLdhoUr/S131YZPZlkc7Py+qz4XSPGAdpVYUv4t+GSmqUWA0sjwHyT0FQDVl3V4yS23T+10ELYGt5DcbHZmMG3Qn8WayWCX4NcQ5P1NCqkXGNyPjx1qyEhxk8n2z61iFQFb1usvnVWsfycx4FzN9H2ZyHeELZMkBWb4CZRPj3RCvI6r8ndBxjUjuJLF9eI6mkQIHHjfNAg+ke4YgVtv88PgQ9DtbFatw+osjkD7vh8PVUAFspNU2jrJ7mECENJ/iMEMy1G/saySfjZEHmC0OwSFdR9NMTEGdgW1XAuQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laoOn6Od5qAUxVl658s/ZizYuxYR/H0yEeHLyiVv36Y=;
 b=uXxvfQ+7gwrYi79j3FQ+e6UrvGgl9XJ4SWBj/9DV0Y9ToH63eNrBmeZ/nh+cgznI8zfwbg3KPKlxxdZRj2nycr9utoMF6zf0sOZKydJMpYdOUlabuzEiqG46d6icFJIw4FcAQ3ADRZJZGg70QG2TuBwvPX40tJTMWFMBcVLEts54/4v2PmzbFet+WqUEMW4jt7uH+sxeK08mo35rY/BRE8kgG30ltZmcMIsYaYLdaq+I5SDPymmtOTY+7Pe22Uc0PQZVlfu1v7ag/9PufbD6dzDCkQ/4uIR/+uCVPDpXcccqDBbK0nOV+WCcR15lelvia/3sbIAiVy5aCItfrB5w2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laoOn6Od5qAUxVl658s/ZizYuxYR/H0yEeHLyiVv36Y=;
 b=MeWEz+8+IN+axwICATUIXqhesIM3J1AgDA+AggqBTmDICa/wm/oLoyhBu8RpdtsUpESUMjalSpgLiRScJ161dl89YGCoz3GDQRV1bCihby6J8AtTXCblHUb7KB3j+dNPmVTBJOpKSteBtz/5sq7Rp6fRYU2Oapxd6GoYatHUtFo=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV2PR21MB6523.namprd21.prod.outlook.com (2603:10b6:408:34f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Mon, 1 Jun 2026
 16:19:41 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%5]) with mapi id 15.21.0071.001; Mon, 1 Jun 2026
 16:19:41 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Long Li
	<longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Add Interrupt Moderation support
Thread-Topic: [PATCH net-next] net: mana: Add Interrupt Moderation support
Thread-Index: AQHc8G2wzWwnMCA2Hk+hkfQN6TBI4LYpdBoAgABudZA=
Date: Mon, 1 Jun 2026 16:19:40 +0000
Message-ID:
 <SA3PR21MB38676164579B0C3379B8A022CA152@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260530194957.1690459-1-haiyangz@linux.microsoft.com>
 <PH0PR11MB590230F0CEBE8B1DEAA15F82F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB590230F0CEBE8B1DEAA15F82F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8b24fd2-b5b6-4b47-b245-c98271cc09f9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-01T16:14:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV2PR21MB6523:EE_
x-ms-office365-filtering-correlation-id: 0db80d8f-01e5-43e3-534f-08debff99597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|6133799003|18002099003|22082099003|38070700021|921020|7053199004|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 77OPTAj5dwWZ5/Py5swVsOeZu2QqOIfN+MKKNeSRTypxHXN/6QmG+MDox/nb3wMX7sIsb51GJEg5772ZJR6wH4mU5wjxZjXROSVp9T5tz+B3UZlC2ZLCaY7T2FdtWqQ/a/vfTWc+h1sLslC0khzeBSD4F+ulNV/CBwF4bT1Mj3Rq9rubt3YYWtmj1OgbgGRnk6JWSxBy7G4vgb1i42vRFNkkRyfZ+beMvS6cBXGAdLIhnMmikk1Mrh7gjrq7T4g+3m0hYRHpdjVleU6WYdywfT4fF3Rv76NjHxY++qtIEYO+8i+I/sEWDWEQp/M2g1nGyP8BoSzaa9V3B6E7P9l48qOdwP6U9WSRpgo3FjkSDZW1JQpsWHMDxwIHIFfmoGzwASEHaZBSXUJt+2rBkzPEmomBUo1ZWGjbwhd2BQIZv5EtVD6FBYRTAecU10SEXErmyaUH6Bn4hJKrKTgsaV+Gg6cPzz9gPRA4cM9AEYh1rKndfrBZHcE3EFPWXvbOZ2LPaWLXvTWQc8ZR0FL0B42qa9Gnw1CWXprkp4r6OtDuJIA57sRc7pr4ptHbrX5ac4kEAjo5cOjzsm/Km+Z71X8YFcxZleKiKd7+T/sRsfl+TLNEcS/P29dcx+i5nRDvngUxpfjp8C8QWlJ6nN2KRb8v4wCwEDG67nHOImjy312RL1Zbw+SxZEqCKTA+rKZ/47kDcG0OaqJ+UEThqDcDQCYn7KrccDfACHMEbpnzmIaCq/FLzzAqb5/XUq02EAgBbsQABFikBaO7oEpN9xRYfmLkaA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(921020)(7053199004)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jf7/NRq6HZxCrYCsJ6WhA+grUywnQv6PKjPz+yVa8dXmBdzK2QOUIvrcPXGr?=
 =?us-ascii?Q?G6soK3e/SWTTt76YlyihMc6NNzbI2FDpYAC4twaEI6qywYojm4r80cxTQ/ff?=
 =?us-ascii?Q?q0VWZ+0GokB//3vGvuEDCmUkTVjPIs9d4UhSiL87WS6R20aOs4M9WShDjPAJ?=
 =?us-ascii?Q?hVplYbcLKDxrlbn6rIp/nDieg2vpN8Onrp74wb4LAG9/lVslLkNydh+2Xcez?=
 =?us-ascii?Q?OtiniRg7Z8N+MKyMIBLcfJMTdqPra/tlvRhX1mq1Liw0WxGaXSpiUI0TZPqp?=
 =?us-ascii?Q?JsGdXwObpVT6kM2xY1tlo8JKE2V7eFR360QRcCZxBS0+tk4yVrD+jKGuILQg?=
 =?us-ascii?Q?nC8ndQEppcrsCmrSTqaIGqBVdjo+18S35g4YKt/nUhHu+3uS1RN1PaVfuSGH?=
 =?us-ascii?Q?bY5RlIcPcW5yxkSUtWarT3TwLiJhxOY4FCfZdqvjBY61YK0Zoh64gnGqKJLo?=
 =?us-ascii?Q?JC156jMkGixkKZDCPGvZDz9vRKtmD8+TqAa4H+ayxi0NjpQukNPpgGeV6Sf/?=
 =?us-ascii?Q?uRoXDDSFYAVCuu/RIiaVciojbDUFON+iVRvCpIGBsuAmkk6RbVKc0+icZbyd?=
 =?us-ascii?Q?WVz4XCrtU2NmPUo5u749Zx1xMTejMJ5rY5Tmp7lDXvcXtw21veXh9wA2KEqt?=
 =?us-ascii?Q?tOICs/t9mK05A4ulyYKZkQyqvTaSB6ooOrbiAM5Li+9SZ7VaEh6G4dZtjzvx?=
 =?us-ascii?Q?KFMxjPY7AcG7/cxccsIPt8CS9o924XMQ2lWSLpj75Fhio21hDEacI1ncU8On?=
 =?us-ascii?Q?hJifY2w5MW0iOWjwIO6yG26E+x/QPt0c72mxAz8kqwj9HOLXhPO1gIJGs6mS?=
 =?us-ascii?Q?WfkhbOM3CUzEZipJ07/eVPQSvxXFNIYfVKq0tpOLdgb3NR10tjTS1IENtkNE?=
 =?us-ascii?Q?iqmoHs5EMg8tgEKKHy7qlFOwMvshcC4dOa6ifayc2kEQJwWMl3NILEe0I5O1?=
 =?us-ascii?Q?we0t3YP1FJLflhUqsD8LI0xf5mJiTlBAlbjG2lqoBezayQBvQzXju/CjeuIP?=
 =?us-ascii?Q?IzSBa+e3w4JnNqp6zuHiXnt5ltPrJXeNSnl50QA0V42jKmaaeNogsFRrUYZA?=
 =?us-ascii?Q?BrkpFPiQ9vL1wkGh5HSV0p2eoLP3vQ0lMJEePGIrPgPzEmVySKvMd48pudbr?=
 =?us-ascii?Q?TqNyv0IUgIMcyW/C28F0SrkW3zv7JciPlH+HcKf+jgyk9PPWSgbJ6D2IWCZC?=
 =?us-ascii?Q?RDiuDbUkR7L1KCRtwNXHIokKUf7ZDJL+/ewpVAEqmizHiEvCzpG/gF20Bemq?=
 =?us-ascii?Q?78vnkXMdJi2f5bnAK9KCghJ+7+cr+m/SutqazCd6yudHkbxGOsvEdfig8VwT?=
 =?us-ascii?Q?eHHB+QE/eChhwprydleF8/xwkWAuLqhflH4E0/HeHzdkNE1ZOwRLyoIt0nG7?=
 =?us-ascii?Q?2d47XYDXeYPQnXMibWpTj6zwJFCt1Li2XSF958rJa33ob+AONUIRXNhGLpVi?=
 =?us-ascii?Q?z4Z+aa84GLnjSYUFbzw2LzWJkR79YZ/8OwHVblSvTQqpAwzGpjOLF1Sc8twq?=
 =?us-ascii?Q?ud+Qb4CSOOfRqtOMEgsAIl6ndHJHU9cnGzARNutQoqaO8HJqRKAi5xo58mUN?=
 =?us-ascii?Q?ttgWhjbXY++CFArb+oe3pWniVxf2XwIC9tT6Re1UzGty9OMjTmjannzehtIE?=
 =?us-ascii?Q?vUt560q8J8vPtVdDJ/Zu/wCA3IJIeCcGh+vCIggOIKnospGYbADC1ls16AJ8?=
 =?us-ascii?Q?570PZu9LaTnlPS1anwrjr+/z7OgHdiRH22cXrWsZZkhIsBxoMj402IbF99/i?=
 =?us-ascii?Q?uJgRoosbNA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db80d8f-01e5-43e3-534f-08debff99597
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 16:19:41.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnwZBKLwVEwas8wzzGuXgwxpt6RWFf+5ZYXyWq3pDFMW7Wvs4B5m6g3S8Cq0gLciJRzocR4buF96Xs05rkZy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB6523
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11433-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3336A6229DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Sent: Monday, June 1, 2026 5:39 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Konstantin
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>;
> Shradha Gupta <shradhagupta@linux.microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Kees Cook <kees@kernel.org>; Breno
> Leitao <leitao@debian.org>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] RE: [PATCH net-next] net: mana: Add Interrupt
> Moderation support
>=20
> [Niekt?re osoby, kt?re odebra?y t? wiadomo??, nie otrzymuj? cz?sto
> wiadomo?ci e-mail z jedrzej.jagielski@intel.com. Dowiedz si?, dlaczego
> jest to wa?ne, na stronie https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Sent: Saturday, May 30, 2026 9:50 PM
>=20
> >From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> >Add Static and Dynamic Interrupt Moderation (DIM) support for
> >Rx and Tx.
> >Update queue creation procedure with new data struct with the related
> >settings.
> >Add functions to collect stat for DIM, and workers to update DIM data
> >and settings.
> >Update ethtool handler to get/set the moderation settings from a user.
> >By default, adaptive-rx/tx (DIM) are enabled.
> >
> >Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >---
> > drivers/net/ethernet/microsoft/Kconfig        |   1 +
> > .../net/ethernet/microsoft/mana/gdma_main.c   |  27 ++++
> > drivers/net/ethernet/microsoft/mana/mana_en.c | 101 ++++++++++++++-
> > .../ethernet/microsoft/mana/mana_ethtool.c    | 120 +++++++++++++++++-
> > include/net/mana/gdma.h                       |  24 +++-
> > include/net/mana/mana.h                       |  42 ++++++
> > 6 files changed, 309 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/microsoft/Kconfig
> b/drivers/net/ethernet/microsoft/Kconfig
> >index 3f36ee6a8ece..e9be18c92ca5 100644
> >--- a/drivers/net/ethernet/microsoft/Kconfig
> >+++ b/drivers/net/ethernet/microsoft/Kconfig
> >@@ -21,6 +21,7 @@ config MICROSOFT_MANA
> >       depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
> >       depends on PCI_HYPERV
> >       select AUXILIARY_BUS
> >+      select DIMLIB
> >       select PAGE_POOL
> >       select NET_SHAPER
> >       help
> >diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >index 712a0881d720..5aa0ea794a00 100644
> >--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >@@ -405,6 +405,7 @@ static int mana_gd_disable_queue(struct gdma_queue
> *queue)
> > #define DOORBELL_OFFSET_RQ    0x400
> > #define DOORBELL_OFFSET_CQ    0x800
> > #define DOORBELL_OFFSET_EQ    0xFF8
> >+#define DOORBELL_OFFSET_DIM   0x820
> >
> > static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index=
,
> >                                 enum gdma_queue_type q_type, u32 qid,
> >@@ -445,6 +446,16 @@ static void mana_gd_ring_doorbell(struct
> gdma_context *gc, u32 db_index,
> >               addr +=3D DOORBELL_OFFSET_SQ;
> >               break;
> >
> >+      case GDMA_DIM:
> >+              e.dim.id =3D qid;
> >+              e.dim.mod_usec =3D tail_ptr;
> >+              e.dim.mod_usec_vld =3D tail_ptr >> 15;
> >+              e.dim.mod_comps =3D tail_ptr >> 16;
>=20
> please use defines instead of magic
Will do.

>=20
> >+              e.dim.mod_comps_vld =3D num_req;
> >+
> >+              addr +=3D DOORBELL_OFFSET_DIM;
> >+              break;
> >+
> >       default:
> >               WARN_ON(1);
> >               return;
> >@@ -479,6 +490,22 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8
> arm_bit)
> > }
> > EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
> >
> >+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool
> mod_usec_vld,
> >+                    u32 mod_comps, bool mod_comps_vld)
> >+{
> >+      struct gdma_context *gc =3D cq->gdma_dev->gdma_context;
> >+      u32 dim_val;
> >+
> >+      /* Convert the DIM values to doorbell parameters */
> >+      dim_val =3D (mod_usec & MANA_INTR_MODR_USEC_MAX) |
> >+                (((u32)mod_usec_vld & 1) << 15) |
> >+                ((mod_comps & MANA_INTR_MODR_COMP_MAX) << 16);
>=20
> i believe FIELD_PREP if preferrable in such cases
Will do.

>=20
> >+
> >+      mana_gd_ring_doorbell(gc, cq->gdma_dev->doorbell, GDMA_DIM, cq-
> >id,
> >+                            dim_val, (u8)mod_comps_vld & 1);
> >+}
> >+EXPORT_SYMBOL_NS(mana_gd_ring_dim, "NET_MANA");
> >+
> > #define MANA_SERVICE_PERIOD 10
> >
> > static void mana_serv_rescan(struct pci_dev *pdev)
> >diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >index 82f1461a48e9..f1a16f8aca66 100644
> >--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >@@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context
> *apc,
> >
> >       mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
> >                            sizeof(req), sizeof(resp));
> >+
> >+      req.hdr.req.msg_version =3D GDMA_MESSAGE_V3;
> >+      req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
> >       req.vport =3D vport;
> >       req.wq_type =3D wq_type;
> >       req.wq_gdma_region =3D wq_spec->gdma_region;
> >@@ -1559,6 +1562,9 @@ int mana_create_wq_obj(struct mana_port_context
> *apc,
> >       req.cq_size =3D cq_spec->queue_size;
> >       req.cq_moderation_ctx_id =3D cq_spec->modr_ctx_id;
> >       req.cq_parent_qid =3D cq_spec->attached_eq;
> >+      req.req_cq_moderation =3D cq_spec->req_cq_moderation;
> >+      req.cq_moderation_comp =3D cq_spec->cq_moderation_comp;
> >+      req.cq_moderation_usec =3D cq_spec->cq_moderation_usec;
> >
> >       err =3D mana_send_request(apc->ac, &req, sizeof(req), &resp,
> >                               sizeof(resp));
> >@@ -2253,6 +2259,66 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
> >               xdp_do_flush();
> > }
> >
> >+static void mana_rx_dim_work(struct work_struct *work)
> >+{
> >+      struct dim *dim =3D container_of(work, struct dim, work);
> >+      struct mana_cq *cq =3D container_of(dim, struct mana_cq, dim);
> >+      struct dim_cq_moder cur_moder =3D
> >+              net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>=20
> RCT; here and for following
Will update this and below.

>=20
> >+
> >+      cur_moder.usec =3D min_t(u16, cur_moder.usec,
> MANA_INTR_MODR_USEC_MAX);
> >+      cur_moder.pkts =3D min_t(u16, cur_moder.pkts,
> MANA_INTR_MODR_COMP_MAX);
> >+
> >+      mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
> >+                       cur_moder.pkts, true);
> >+
> >+      dim->state =3D DIM_START_MEASURE;
> >+}
> >+
> >+static void mana_tx_dim_work(struct work_struct *work)
> >+{
> >+      struct dim *dim =3D container_of(work, struct dim, work);
> >+      struct mana_cq *cq =3D container_of(dim, struct mana_cq, dim);
> >+      struct dim_cq_moder cur_moder =3D
> >+              net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
> >+
> >+      cur_moder.usec =3D min_t(u16, cur_moder.usec,
> MANA_INTR_MODR_USEC_MAX);
> >+      cur_moder.pkts =3D min_t(u16, cur_moder.pkts,
> MANA_INTR_MODR_COMP_MAX);
> >+
> >+      mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
> >+                       cur_moder.pkts, true);
> >+
> >+      dim->state =3D DIM_START_MEASURE;
> >+}
> >+
> >+static void mana_update_rx_dim(struct mana_cq *cq)
> >+{
> >+      struct mana_rxq *rxq =3D cq->rxq;
> >+      struct mana_port_context *apc =3D netdev_priv(rxq->ndev);
> >+      struct dim_sample dim_sample =3D {};
> >+
> >+      if (!apc->rx_dim_enabled)
> >+              return;
> >+
> >+      dim_update_sample(READ_ONCE(cq->dim_event_ctr), rxq-
> >stats.packets,
> >+                        rxq->stats.bytes, &dim_sample);
> >+      net_dim(&cq->dim, &dim_sample);
> >+}
> >+
> >+static void mana_update_tx_dim(struct mana_cq *cq)
> >+{
> >+      struct mana_txq *txq =3D cq->txq;
> >+      struct mana_port_context *apc =3D netdev_priv(txq->ndev);
> >+      struct dim_sample dim_sample =3D {};
> >+
> >+      if (!apc->tx_dim_enabled)
> >+              return;
> >+
> >+      dim_update_sample(READ_ONCE(cq->dim_event_ctr), txq-
> >stats.packets,
> >+                        txq->stats.bytes, &dim_sample);
> >+      net_dim(&cq->dim, &dim_sample);
> >+}
> >+
> > static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue=
)
> > {
> >       struct mana_cq *cq =3D context;
> >@@ -2271,7 +2337,13 @@ static int mana_cq_handler(void *context, struct
> gdma_queue *gdma_queue)
> >       if (w < cq->budget) {
> >               mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> >               cq->work_done_since_doorbell =3D 0;
> >-              napi_complete_done(&cq->napi, w);
> >+
> >+              if (napi_complete_done(&cq->napi, w)) {
> >+                      if (cq->type =3D=3D MANA_CQ_TYPE_RX)
> >+                              mana_update_rx_dim(cq);
> >+                      else
> >+                              mana_update_tx_dim(cq);
> >+              }
> >       } else if (cq->work_done_since_doorbell >=3D
> >                  (cq->gdma_cq->queue_size / COMP_ENTRY_SIZE) * 4) {
> >               /* MANA hardware requires at least one doorbell ring ever=
y
> 8
> >@@ -2303,6 +2375,7 @@ static void mana_schedule_napi(void *context,
> struct gdma_queue *gdma_queue)
> > {
> >       struct mana_cq *cq =3D context;
> >
> >+      WRITE_ONCE(cq->dim_event_ctr, cq->dim_event_ctr + 1);
> >       napi_schedule_irqoff(&cq->napi);
> > }
> >
> >@@ -2345,6 +2418,7 @@ static void mana_destroy_txq(struct
> mana_port_context *apc)
> >               if (apc->tx_qp[i]->txq.napi_initialized) {
> >                       napi_synchronize(napi);
> >                       napi_disable_locked(napi);
> >+                      cancel_work_sync(&apc->tx_qp[i]->tx_cq.dim.work);
> >                       netif_napi_del_locked(napi);
> >                       apc->tx_qp[i]->txq.napi_initialized =3D false;
> >               }
> >@@ -2475,6 +2549,10 @@ static int mana_create_txq(struct
> mana_port_context *apc,
> >               cq_spec.queue_size =3D cq->gdma_cq->queue_size;
> >               cq_spec.modr_ctx_id =3D 0;
> >               cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
> >+              cq_spec.req_cq_moderation =3D apc->tx_dim_enabled ||
> >+                      (apc->intr_modr_tx_usec && apc-
> >intr_modr_tx_comp);
> >+              cq_spec.cq_moderation_usec =3D apc->intr_modr_tx_usec;
> >+              cq_spec.cq_moderation_comp =3D apc->intr_modr_tx_comp;
> >
> >               err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_SQ=
,
> >                                        &wq_spec, &cq_spec,
> >@@ -2509,6 +2587,9 @@ static int mana_create_txq(struct mana_port_contex=
t
> *apc,
> >               napi_enable_locked(&cq->napi);
> >               txq->napi_initialized =3D true;
> >
> >+              INIT_WORK(&cq->dim.work, mana_tx_dim_work);
> >+              cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> >+
> >               mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
> >       }
> >
> >@@ -2543,6 +2624,7 @@ static void mana_destroy_rxq(struct
> mana_port_context *apc,
> >               napi_synchronize(napi);
> >
> >               napi_disable_locked(napi);
> >+              cancel_work_sync(&rxq->rx_cq.dim.work);
> >               netif_napi_del_locked(napi);
> >       }
> >
> >@@ -2780,6 +2862,10 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
> >       cq_spec.queue_size =3D cq->gdma_cq->queue_size;
> >       cq_spec.modr_ctx_id =3D 0;
> >       cq_spec.attached_eq =3D cq->gdma_cq->cq.parent->id;
> >+      cq_spec.req_cq_moderation =3D apc->rx_dim_enabled ||
> >+              (apc->intr_modr_rx_usec && apc->intr_modr_rx_comp);
> >+      cq_spec.cq_moderation_usec =3D apc->intr_modr_rx_usec;
> >+      cq_spec.cq_moderation_comp =3D apc->intr_modr_rx_comp;
> >
> >       err =3D mana_create_wq_obj(apc, apc->port_handle, GDMA_RQ,
> >                                &wq_spec, &cq_spec, &rxq->rxobj);
> >@@ -2815,6 +2901,9 @@ static struct mana_rxq *mana_create_rxq(struct
> mana_port_context *apc,
> >
> >       napi_enable_locked(&cq->napi);
> >
> >+      INIT_WORK(&cq->dim.work, mana_rx_dim_work);
> >+      cq->dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> >+
> >       mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
> > out:
> >       if (!err)
> >@@ -3432,6 +3521,16 @@ static int mana_probe_port(struct mana_context
> *ac, int port_idx,
> >       apc->port_idx =3D port_idx;
> >       apc->cqe_coalescing_enable =3D 0;
> >
> >+      /* Initialize interrupt moderation settings if supported by HW */
> >+      if (gc->pf_cap_flags1 &
> GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION) {
> >+              apc->intr_modr_rx_usec =3D MANA_INTR_MODR_USEC_DEF;
> >+              apc->intr_modr_rx_comp =3D MANA_INTR_MODR_COMP_DEF;
> >+              apc->intr_modr_tx_usec =3D MANA_INTR_MODR_USEC_DEF;
> >+              apc->intr_modr_tx_comp =3D MANA_INTR_MODR_COMP_DEF;
> >+              apc->rx_dim_enabled =3D MANA_ADAPTIVE_RX_DEF;
> >+              apc->tx_dim_enabled =3D MANA_ADAPTIVE_TX_DEF;
> >+      }
> >+
> >       mutex_init(&apc->vport_mutex);
> >       apc->vport_use_count =3D 0;
> >
> >diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> >index 04350973e19e..a90216eba794 100644
> >--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> >+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> >@@ -419,6 +419,15 @@ static int mana_get_coalesce(struct net_device
> *ndev,
> >           !kernel_coal->rx_cqe_nsecs)
> >               kernel_coal->rx_cqe_nsecs =3D MANA_RX_CQE_NSEC_DEF;
> >
> >+      ec->rx_coalesce_usecs =3D apc->intr_modr_rx_usec;
> >+      ec->rx_max_coalesced_frames =3D apc->intr_modr_rx_comp;
> >+
> >+      ec->tx_coalesce_usecs =3D apc->intr_modr_tx_usec;
> >+      ec->tx_max_coalesced_frames =3D apc->intr_modr_tx_comp;
> >+
> >+      ec->use_adaptive_rx_coalesce =3D apc->rx_dim_enabled;
> >+      ec->use_adaptive_tx_coalesce =3D apc->tx_dim_enabled;
> >+
> >       return 0;
> > }
> >
> >@@ -429,8 +438,28 @@ static int mana_set_coalesce(struct net_device
> *ndev,
> > {
> >       struct mana_port_context *apc =3D netdev_priv(ndev);
> >       u8 saved_cqe_coalescing_enable;
> >+      u16 old_rx_usec, old_rx_comp;
> >+      u16 old_tx_usec, old_tx_comp;
> >+      bool old_rx_dim, old_tx_dim;
>=20
> how about using some sort of struct instead of declaring a number
> of params for bookkeeping? imho would be cleaner
Will consider this.

>=20
> >+      bool modr_changed =3D false;
> >+      bool dim_changed =3D false;
> >+      struct gdma_context *gc;
> >       int err;
> >
> >+      gc =3D apc->ac->gdma_dev->gdma_context;
> >+
> >+      /* Both static and dynamic interrupt moderation (DIM) rely on the
> >+       * same HW capability advertised by the PF.
> >+       */
> >+      if ((ec->use_adaptive_rx_coalesce || ec->use_adaptive_tx_coalesce
> ||
> >+           ec->rx_coalesce_usecs || ec->tx_coalesce_usecs ||
> >+           ec->rx_max_coalesced_frames || ec->tx_max_coalesced_frames)
> &&
> >+          !(gc->pf_cap_flags1 &
> GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)) {
> >+              NL_SET_ERR_MSG(extack,
> >+                             "Interrupt Moderation is not supported by
> HW");
> >+              return -EOPNOTSUPP;
> >+      }
> >+
> >       if (kernel_coal->rx_cqe_frames !=3D 1 &&
> >           kernel_coal->rx_cqe_frames !=3D MANA_RXCOMP_OOB_NUM_PPI) {
> >               NL_SET_ERR_MSG_FMT(extack,
> >@@ -440,6 +469,47 @@ static int mana_set_coalesce(struct net_device
> *ndev,
> >               return -EINVAL;
> >       }
> >
> >+      if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
> >+          ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
> >+              NL_SET_ERR_MSG_FMT(extack,
> >+                                 "coalesce usecs must be <=3D %u",
> >+                                 MANA_INTR_MODR_USEC_MAX);
> >+              return -EINVAL;
> >+      }
> >+
> >+      if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
> >+          ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
> >+              NL_SET_ERR_MSG_FMT(extack,
> >+                                 "coalesce frames must be <=3D %u",
> >+                                 MANA_INTR_MODR_COMP_MAX);
> >+              return -EINVAL;
> >+      }
> >+
> >+      if (ec->rx_coalesce_usecs !=3D apc->intr_modr_rx_usec ||
> >+          ec->rx_max_coalesced_frames !=3D apc->intr_modr_rx_comp ||
> >+          ec->tx_coalesce_usecs !=3D apc->intr_modr_tx_usec ||
> >+          ec->tx_max_coalesced_frames !=3D apc->intr_modr_tx_comp)
> >+              modr_changed =3D true;
> >+
> >+      old_rx_usec =3D apc->intr_modr_rx_usec;
> >+      old_rx_comp =3D apc->intr_modr_rx_comp;
> >+      old_tx_usec =3D apc->intr_modr_tx_usec;
> >+      old_tx_comp =3D apc->intr_modr_tx_comp;
> >+
> >+      apc->intr_modr_rx_usec =3D ec->rx_coalesce_usecs;
> >+      apc->intr_modr_rx_comp =3D ec->rx_max_coalesced_frames;
> >+      apc->intr_modr_tx_usec =3D ec->tx_coalesce_usecs;
> >+      apc->intr_modr_tx_comp =3D ec->tx_max_coalesced_frames;
> >+
> >+      if (!!ec->use_adaptive_rx_coalesce !=3D apc->rx_dim_enabled ||
> >+          !!ec->use_adaptive_tx_coalesce !=3D apc->tx_dim_enabled)
> >+              dim_changed =3D true;
> >+
> >+      old_rx_dim =3D apc->rx_dim_enabled;
> >+      old_tx_dim =3D apc->tx_dim_enabled;
> >+      apc->rx_dim_enabled =3D !!ec->use_adaptive_rx_coalesce;
> >+      apc->tx_dim_enabled =3D !!ec->use_adaptive_tx_coalesce;
> >+
> >       saved_cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> >       apc->cqe_coalescing_enable =3D
> >               kernel_coal->rx_cqe_frames =3D=3D MANA_RXCOMP_OOB_NUM_PPI=
;
> >@@ -447,10 +517,46 @@ static int mana_set_coalesce(struct net_device
> *ndev,
> >       if (!apc->port_is_up)
> >               return 0;
> >
> >-      err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> >-      if (err)
> >-              apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enabl=
e;
> >+      if (apc->cqe_coalescing_enable !=3D saved_cqe_coalescing_enable &=
&
> >+          !modr_changed && !dim_changed) {
> >+              /* If only CQE coalescing setting is changed, we can just
> update
> >+               * RSS configuration.
> >+               */
> >+              err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false=
);
> >+              if (err) {
> >+                      netdev_err(ndev, "Change CQE coalescing
> failed: %d\n",
> >+                                 err);
> >+                      apc->cqe_coalescing_enable =3D
> >+                              saved_cqe_coalescing_enable;
> >+                      return err;
> >+              }
> >+              return 0;
> >+      }
> >+
> >+      if (modr_changed || dim_changed) {
> >+              err =3D mana_detach(ndev, false);
> >+              if (err) {
> >+                      netdev_err(ndev, "mana_detach failed: %d\n", err)=
;
> >+                      goto restore_modr;
> >+              }
> >+
> >+              err =3D mana_attach(ndev);
> >+              if (err) {
> >+                      netdev_err(ndev, "mana_attach failed: %d\n", err)=
;
> >+                      goto restore_modr;
>=20
> i see there is already such pattern in the mana code; how about
> creating a helper?
We are planning to update this pattern. So I keep this part of code like
other functions. And we will refactor/update them in separate patch set.

>=20
> >+              }
> >+      }
> >+
> >+      return 0;
> >
> >+restore_modr:
> >+      apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;
> >+      apc->intr_modr_rx_usec =3D old_rx_usec;
> >+      apc->intr_modr_rx_comp =3D old_rx_comp;
> >+      apc->intr_modr_tx_usec =3D old_tx_usec;
> >+      apc->intr_modr_tx_comp =3D old_tx_comp;
> >+      apc->rx_dim_enabled =3D old_rx_dim;
> >+      apc->tx_dim_enabled =3D old_tx_dim;
> >       return err;
> > }
> >
> >@@ -574,7 +680,13 @@ static int mana_get_link_ksettings(struct net_devic=
e
> *ndev,
> > }
> >
> > const struct ethtool_ops mana_ethtool_ops =3D {
> >-      .supported_coalesce_params =3D ETHTOOL_COALESCE_RX_CQE_FRAMES,
> >+      .supported_coalesce_params =3D ETHTOOL_COALESCE_RX_CQE_FRAMES |
> >+                                  ETHTOOL_COALESCE_RX_USECS |
> >+                                  ETHTOOL_COALESCE_RX_MAX_FRAMES |
> >+                                  ETHTOOL_COALESCE_TX_USECS |
> >+                                  ETHTOOL_COALESCE_TX_MAX_FRAMES |
> >+                                  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> >+                                  ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
> >       .get_ethtool_stats      =3D mana_get_ethtool_stats,
> >       .get_sset_count         =3D mana_get_sset_count,
> >       .get_strings            =3D mana_get_strings,
> >diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> >index 70d62bc32837..0a0cc7b080d3 100644
> >--- a/include/net/mana/gdma.h
> >+++ b/include/net/mana/gdma.h
> >@@ -47,6 +47,7 @@ enum gdma_queue_type {
> >       GDMA_RQ,
> >       GDMA_CQ,
> >       GDMA_EQ,
> >+      GDMA_DIM,
> > };
> >
> > enum gdma_work_request_flags {
> >@@ -126,6 +127,17 @@ union gdma_doorbell_entry {
> >               u64 tail_ptr    : 31;
> >               u64 arm         : 1;
> >       } eq;
> >+
> >+      struct {
> >+              u64 id           : 24;
> >+              u64 reserved     : 8;
> >+              u64 mod_usec     : 10;
> >+              u64 reserve1     : 5;
> >+              u64 mod_usec_vld : 1;
> >+              u64 mod_comps    : 8;
> >+              u64 reserve2     : 7;
> >+              u64 mod_comps_vld: 1;
> >+      } dim;
> > }; /* HW DATA */
> >
> > struct gdma_msg_hdr {
> >@@ -484,6 +496,9 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8
> arm_bit);
> >
> > int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type
> type);
> >
> >+void mana_gd_ring_dim(struct gdma_queue *cq, u32 mod_usec, bool
> mod_usec_vld,
> >+                    u32 mod_comps, bool mod_comps_vld);
> >+
> > struct gdma_wqe {
> >       u32 reserved    :24;
> >       u32 last_vbytes :8;
> >@@ -629,6 +644,9 @@ enum {
> > /* Driver supports self recovery on Hardware Channel timeouts */
> > #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
> >
> >+/* Driver supports dynamic interrupt moderation - DIM */
> >+#define GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(27)
> >+
> > #define GDMA_DRV_CAP_FLAGS1 \
> >       (GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
> >        GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> >@@ -643,7 +661,8 @@ enum {
> >        GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
> >        GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
> >        GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
> >-       GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
> >+       GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
> >+       GDMA_DRV_CAP_FLAG_1_DYN_INTERRUPT_MODERATION)
> >
> > #define GDMA_DRV_CAP_FLAGS2 0
> >
> >@@ -679,6 +698,9 @@ struct gdma_verify_ver_req {
> >       u8 os_ver_str4[128];
> > }; /* HW DATA */
> >
> >+/* HW supports dynamic interrupt moderation - DIM */
> >+#define GDMA_PF_CAP_FLAG_1_DYN_INTERRUPT_MODERATION BIT(15)
> >+
> > struct gdma_verify_ver_resp {
> >       struct gdma_resp_hdr hdr;
> >       u64 gdma_protocol_ver;
> >diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> >index d9c27310fd04..57868a79f23d 100644
> >--- a/include/net/mana/mana.h
> >+++ b/include/net/mana/mana.h
> >@@ -4,6 +4,7 @@
> > #ifndef _MANA_H
> > #define _MANA_H
> >
> >+#include <linux/dim.h>
> > #include <net/xdp.h>
> > #include <net/net_shaper.h>
> >
> >@@ -64,6 +65,16 @@ enum TRI_STATE {
> > /* Maximum number of packets per coalesced CQE */
> > #define MANA_RXCOMP_OOB_NUM_PPI 4
> >
> >+/* Default/max interrupt moderation settings */
> >+#define MANA_INTR_MODR_USEC_DEF 0
> >+#define MANA_INTR_MODR_COMP_DEF 0
> >+
> >+#define MANA_ADAPTIVE_RX_DEF true
> >+#define MANA_ADAPTIVE_TX_DEF true
> >+
> >+#define MANA_INTR_MODR_USEC_MAX 1023
> >+#define MANA_INTR_MODR_COMP_MAX 255
>=20
> used as a limiter and mask - for mask case i believe
> GENMASK cand be used
Will do.=20

Thanks,
- Haiyang

