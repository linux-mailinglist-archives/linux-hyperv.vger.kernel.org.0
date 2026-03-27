Return-Path: <linux-hyperv+bounces-9811-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBIpDxgBxmk/FAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9811-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 05:01:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF27533EFF9
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 05:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13E46301F48C
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573A2359A63;
	Fri, 27 Mar 2026 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Up0KOwIW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020126.outbound.protection.outlook.com [52.101.193.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EA1F5437;
	Fri, 27 Mar 2026 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584036; cv=fail; b=kwXskXaznah1Cu5SXVplCbECstbKzQVd78MyIIuePEea0YMvCAEujJrszBh+xGJJfnX49/Ht71iWZt3byKo80I9+uWWOwxYQx/obJtdqM4+ZjKmWropOcBb2lDprm/Vs0Ia9h9X8lXsnFu3B3g4au8IoOCeYXBnFJ5qZM6w0DOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584036; c=relaxed/simple;
	bh=cTgPobA8wU6+guJYk0RbtWRRcMztS8mpFrEH25uhzTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuOIOXc7Qu9f+jABNYWLW2CgRbQY5TTpT69rQBklaxmvtfnbVplGg/XR1WB7A5a0UcUlIKRgxxkPHrxEvB0VtTSZl7ZVHh8GW6TVD05ZelBc0OFOgIowLMjwPKpNW+JeZENbRjTLjW4QQkvkijjVWt+aTG16T6xMSpj3G/ldF5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Up0KOwIW; arc=fail smtp.client-ip=52.101.193.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbzM1hETNNE4QX77jNGG+dgjmbjNJyCzcKloHIkeXdoBBSsJnOikwCGxzCtXY1NP3MR0mIChpTJvw+h1oZbqeSB7uZGEJQkt3exHvi5vtoEkqTW8yM2yHFoN2PYTjl7k5LRr3BzLb0OOXCk3CzoTKK/Pcv9E9mrkbzJT6HC/qS2oGs7amtDfiIwm55L9j2w/m49wiUY3GI3njYzmXoOmKTp1A8Jg+gKj15YoX3euGyQXAzu4xavUCrXtBTdnhzdu6E5XS7c3bpLr2049KmNimzYyfETxk5TwF08F9QxgdkwuGKIxh3f+pk1HV5LDfBJbAsxVO078WGaUdIvauL9ivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiQAqCRA9bviS37fztDiD99q3GJMWXhDFGYpLgUym3s=;
 b=X5QMKipc0/+DOB/5v+cPubzR0t+sFlkYgOaXxxkdPnJQq7zMEyVHERAelUZp7WbOlFq9v1dZa+cqW0Qfg3gj6yxqUTPN0Yv4FdMNpOyBqYA4gm/oPx9aRVpqLHZ664whAw05PtYulJUiyqwciWFO9CkYOYoPBQVWChf9+pQIIcYOSE8kQHEeXUnZnRFteneqpXCTFylddFqZxMbkA7+MOPoptheQlTUXMHKK5L80tDFUo+8A6dtGvSUK4FkpAvmE+7xOZ2B24rEfdtDB/Lx1FtzeJPExyPMrmZ2YPn8THJmYVbyduGpan+DwQjbcOFg1adPlJYD2rYLCEw69QEYhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiQAqCRA9bviS37fztDiD99q3GJMWXhDFGYpLgUym3s=;
 b=Up0KOwIWqfVjB0Y+ipLjyI22rCEvfnZTuXU/Wam6rYSUUrYLpxmrX4Dw6V/WKMWb48cD4ffdORx+kA542JzhK6Xl97pjLlMMOQerWUw5ux0cCLp4vX64Ko+ldAQmeF3eiz/+LaWkVwFW1pZE/vUywLwKVnJw2Rp822HvVha5bzA=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV0PR21MB6123.namprd21.prod.outlook.com (2603:10b6:408:33a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 04:00:31 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 04:00:31 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Set default number
 of queues to 16
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Set default number
 of queues to 16
Thread-Index: AQHcuv4vlEAYdkyNzEesZ1PA5JW747XButWAgAALNQA=
Date: Fri, 27 Mar 2026 04:00:31 +0000
Message-ID:
 <SA1PR21MB668314B1AF002E40B379F1C0CE57A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323194925.1766385-1-longli@microsoft.com>
 <20260326201841.3b7e5b78@kernel.org>
In-Reply-To: <20260326201841.3b7e5b78@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1fcfff7-8029-455d-b2af-61e6e94db08b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-27T03:58:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV0PR21MB6123:EE_
x-ms-office365-filtering-correlation-id: 82cf4427-c767-4584-ed5c-08de8bb56404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 o/1ZRAYx2AsbGU7iyBDL31NjGTZi1GUPbycMJrHgl0jblX2H6dylsExyxhLt1DxuLAKODKcLTwAuwNI1gvpM62ywUT7aPexgQRICZ69C+7WShk3X3WnkVIgI56cNi2OJRK8qtqurPB2y/W0HxsVCwdedRut+uBTvkLp6yvI9gDL/QKkwm/ggjXAnO7o9Wb0fzTS35D+8UsDV4H0b5/kCKg4sL7hHAUZeFNwDJflaaGI0kg2qYcf+aYkNy3ONStAovKqoGHznatDXNlIDjVmA9Pcpb4QvZvz4/Ak6BBV6ExIGppf+o5XkS1lp9S5xsIZUCItAGqIp9kdwBqzfQGNLC1+FrTNrk1sGObN4Eh51VPo1fMm1B9Wl+2flk7NhcfH32PP2A+F3/QCVp64CEV61dVGa4UIVFZiMSh65Imqtrw5QHFppHUG49hnE8NO9p/5ik5RpRaBKp2RFaQu+R5p5+0+0rwcLmQ7K4Jj+YT7bjfHPK8mYleYcD5XbsoOaXRzG1YHssKChNFzn7/Jya79c+sNlYD1/AcvBvIL24n772rGveWpW9/ImPB7FFWyqxonDPS0DJ+ZESH5b+nxA8EvqgQU75c83wHVfXXGNL7VO31njPZd5o3QIa7q09ZeAqbSLlXyGLvvXR43QnxAESwlLaOyj6D7Zuy5IkkAgS7kJLxlxitI+W/L/cjjhEii+13rb1nepGaXeeIR/PQZ5D8RZ5MaCfZaJPfIcoLo/ewGfO4Y9/yfY2Jm6RvXqAR8vK1akj3UzXDp341O/ertseEZdUA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4IK/cw/MQ+YwxEts2rzDFh7J2crrcQVpPw4zbaUmS2AseaA3pLDeEROZgqaL?=
 =?us-ascii?Q?XY8HpRHtLfP0WwL/nVtO1P0pWkrKrzCRGlf26T5dOzmC3iAYvkmsCrYRrMZC?=
 =?us-ascii?Q?W9CseRH9FhSs2AXqfNZaVgDkTy+pwxrazgEhnoX/bNqK1i0MgJx/U8UlQV4a?=
 =?us-ascii?Q?fawuEwGA2BNE4V8NKG+N7Fas1EhheuQAYHv30Tn9PXcNl/K10oAnxmDUBDNN?=
 =?us-ascii?Q?F4767EP7v7c18JVCtqjq1wXlZTgHOmW9FxE/fz9y3d/zCvWB2VbkJM1OXvAf?=
 =?us-ascii?Q?6ceB6o2SFK5FscS4Zz4PG07K4YwSiWJOdMNWiTT+W5hcE7d3Y3hskLpVl21i?=
 =?us-ascii?Q?78y1kRl7e1Mrh7NjdQVhWaLuJrfT44Pkq1f+TATlYvPDg81SCfXDknxk3HD4?=
 =?us-ascii?Q?kUEfXYxK835me4ixR7OqQdL5Sk9gvUQUpYPEEB6Cp1RlitPfUlg8R0kC1d4r?=
 =?us-ascii?Q?WiwR6U5kQc85de+qWEyQXEp1B+QWqHT0FTjZauBO+oyEq+C0iZk5TT60OXrk?=
 =?us-ascii?Q?iWSSGHU4jE8EM2E9xh7YEnwwV0UZ5NdNcMtb13H6XFmATkcR5T/9GawYUHQ7?=
 =?us-ascii?Q?iYMQKwXYfo5CMiZknFb+o9x0+7PcRKsPervekU2kqcTSSWX+YCKaEfI5c7t6?=
 =?us-ascii?Q?IUV7+VOG1PJ+F/twMBk/4l9sBoDF4NPz4rXmJEeQcvgZaJtNvnDxueWgarPY?=
 =?us-ascii?Q?EvQvbg0rGiWr/oqwA4okIJwlNa4fv9NLT+3usnfUvggJqM41AdmbHKilI9Ny?=
 =?us-ascii?Q?cFW+0EDDLVNyBB/df1CO9wzQl7MPydFR6z5NKMJU0+CsgqncRdmVXRzQlpbO?=
 =?us-ascii?Q?0BaA1NmApc9raxZVZnyxsWrexYU0PsyGCa6h3UGKuRTXt2w22/XPnQLADRaF?=
 =?us-ascii?Q?o6u8v4yc7uMbUqIDqPzTrH2J32dXyHIqmFwyx6beOTontD/Ix2JCu9ZYYpji?=
 =?us-ascii?Q?ZevuR8LRWK0XlCfSt+OKElcvYRwkPtQVnSGDKiLzkP5fQ0A0dSTCm6LyYxo6?=
 =?us-ascii?Q?Zyr0xsnT4zjlYcYeTnM27fAMX/+4/YzOYBOKVXrz6QYlL2XzUJuG46wwnSN3?=
 =?us-ascii?Q?tgpZYCYNGxr6ITURA8p2owpo7RiVqFJaKPA6PvEz+Kc8zYhEioneG6nql3EA?=
 =?us-ascii?Q?lS/uDK8fgybBE2wFiaSJphpGC/F1sSO88yzviyjtfpVQvylQHoyCYkc1vxdl?=
 =?us-ascii?Q?C7Xcd5ujtoaiu39Y0eJg31TFtLxAi3aEhJmFYPaqiGuSDmH2D8J/M8NonEoz?=
 =?us-ascii?Q?p3bpOvdQxGii/rzT+PzQ61LgSKpmocQa9qpNGa2Nc4KXLsw94Kvr4ElwqSLN?=
 =?us-ascii?Q?mOFxoIKxvyfiIN2Kee1sw2qKux+2+9B6sDvCbZOvROOWRosfuA/tOdNwrui8?=
 =?us-ascii?Q?nKzGNqhy4VKr7IjRrkg59J3dUyUB2B5RiqjXt00rEacIXpfbLxWc16uC+qJt?=
 =?us-ascii?Q?Xt65E5Ai9AlE+y/1FZgXU7woyjL8U2TlLG3y2B/p0NF5yadkkupnNcXqtOTQ?=
 =?us-ascii?Q?BM9UUDcKdym6dZV7IPrM1HhVGXEd4GvoBc0ZfkC2263KfaHYqRSxSs7eqEdC?=
 =?us-ascii?Q?5LBMaQ7i1u0h3fqfPnrpLk2qH1k1x3aNWWn1oBoznxGjVRobAnX1F27VD/Bo?=
 =?us-ascii?Q?++jQMW+spI8JKOwbtEMfAIMyx+g0ePeXwh6ad3SJ0CZ0G8nIK3ZgjIl/r0oD?=
 =?us-ascii?Q?1MPfxctIU0036PKOL2xVCCxZC4Ynbg1MFZugRpZXa0pInvyX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf4427-c767-4584-ed5c-08de8bb56404
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 04:00:31.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aicgrPLZCOmlvKHO4hAUG2pXEU3QwyQSKH3eSTkeQOx0UMY+oBVl5jSC3s2ebFVDE1OIrMoNdB2KlV5QTIc2AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6123
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9811-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AF27533EFF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, 23 Mar 2026 12:49:25 -0700 Long Li wrote:
> > Set the default number of queues per vPort to MANA_DEF_NUM_QUEUES
> > (16), as 16 queues can achieve optimal throughput for typical
> > workloads. The actual number of queues may be lower if it exceeds the
> > hardware reported limit. Users can increase the number of queues up to
> > max_queues via ethtool if needed.
>=20
> Sorry we are a bit backlogged I didn't spot this in time (read: I'm plann=
ing to
> revert this unless proper explanation is provided)
>=20
> Could you explain why not use netif_get_num_default_rss_queues() ?
> Having local driver innovations is a major PITA for users who deal with
> heterogeneous envs.

  Hi Jakub,

  We considered netif_get_num_default_rss_queues() but chose a fixed defaul=
t based on our performance testing. On Azure VMs, typical
  workloads plateau at around 16 queues - adding more queues beyond that do=
esn't improve throughput but increases memory usage and
  interrupt overhead.

  netif_get_num_default_rss_queues() would return 32-64 on large VMs (64-12=
8 vCPUs), which wastes resources without benefit.

  That said, I agree that completely ignoring the core-based heuristic isn'=
t ideal for consistency. One option is to use
  netif_get_num_default_rss_queues() but clamp it to a maximum of MANA_DEF_=
NUM_QUEUES (16), so small VMs still get enough queues and
  large VMs don't over-allocate. Something like:

   apc->num_queues =3D min(netif_get_num_default_rss_queues(), MANA_DEF_NUM=
_QUEUES);
   apc->num_queues =3D min(apc->num_queues, gc->max_num_queues);

  For reference, it seems mlx4 does something similar - it caps at DEF_RX_R=
INGS (16) regardless of core count.

  Do you want me to send a v2?

  Thanks,=20
  Long

