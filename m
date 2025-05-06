Return-Path: <linux-hyperv+bounces-5361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47EAAB8E5
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CC01C28173
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417A297A69;
	Tue,  6 May 2025 03:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K1m9oqPx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020114.outbound.protection.outlook.com [52.101.85.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6C2980AE;
	Tue,  6 May 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493116; cv=fail; b=bVq9RLSBeJRaogTN29jOoKI4Ne6Xc5flzqaltKexloWi5P6XSzozqU9PosaiIcYCZPdefXuBs5cEWp3990asAvXF2dfwwJx0wm8geeq4/9BS+Yxv9+Xy/hEX0uM+a9JsckQftEPBelDzv2yeeQ1MgPiGVA7gbkBBisoQctp3F1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493116; c=relaxed/simple;
	bh=KU94t1EmBwcKae1syOY4Enwpn0uYrgOoKFURqpYGCCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UpjwddYDlJfD2WJBCjX+AZYdU2bo7Xcg/6O6mWU76VJ1j5DDqDNwguf5P5EPaL57+7Eu1B6ubufYMXNGg6eq3+kpxI+oX6XXrkFM06gnWWxKrKU0Z0VgbgyIFP+XE4dqXTV5qWyL5SjqXBMgfR8cDvnQtsb834MEnokMJXcC2KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=K1m9oqPx; arc=fail smtp.client-ip=52.101.85.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkqQBEwrJfmCrn7QRH/TOPPippC7g901uyPcDTBFm88BSOG9N3VhP/CHp22X0X7NXpZigKbQ9QNDFHM8rMJ9JvicXaN8LWy5Wy02wsirTEKNtvMSHt8OwoMMCrZtR5qN93eqOMDQhbMIXXI3AYgBVJ49AVpy4QtkSgYqfG7Emdp1Q52N8rtNPkwGkJz2Yb5l9tNFR8Y0D7iNdjPAsgP15CYLwSqm0irdiuK/unDyQziwaLqVUAwvmzkL2ndoh22eUaWT+qSGbhbuNnQimEj8j3oafzg3unJ24gd/5l75TZ+8I+/apE+TDSNC6W8xFNMmyr3DNILbXBYIrDNmALAJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU94t1EmBwcKae1syOY4Enwpn0uYrgOoKFURqpYGCCQ=;
 b=AzSLId78GSb/8p8uak7PaBkaEMKSSQ1UxNt51VZEEU1H0bGQGENKBVQJ13ZJ4g/npt49+AY74T5ka4lbgdnnvTjkzFMu06cqm9bdgdd+Tn5Cm/6ixMB0wzLnA3YYGKlFIi5Hrs9Lf4Xm/ZLR6IljV/x249UN+Y7WMMPBsms84L0Sw+nkhfBkwgDwCqu6BGVq44+W16frFCWrXvN+gHtQQwoQcLH58fi+tZec65Dw2qflya2DdIMkX3jmWOHDjb4kOtOaEiG81aZWmrm2CVeTtwO5qyRHuw1z8aOW3fuzDcPMc4L4egSsxwDW1W36bV7HifmAq2lxA3s4azzD8CezdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU94t1EmBwcKae1syOY4Enwpn0uYrgOoKFURqpYGCCQ=;
 b=K1m9oqPxRcWWqC2N/GuXrSmcvjAbmUFPANPJMR1RiQO/7JpLHIG+dDcw38Pjk1j4PHqFn7X01dJMmqiHziN051dUA7MVOUBYHlI42MDnRwgOx3K5q97FcKd5FgO0v2+HLb4+MqLOCJuuoMP1OoSgZJnAr0XHDKP+s/2V7vi0OVA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA3PR21MB3934.namprd21.prod.outlook.com (2603:10b6:806:302::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.11; Tue, 6 May
 2025 00:58:31 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 00:58:31 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v2 1/4] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [Patch v2 1/4] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbujwoYg+9s60/wky4OwIZJHyS5rPEz1Jg
Date: Tue, 6 May 2025 00:58:31 +0000
Message-ID:
 <SA6PR21MB423107B78D442AA07B586169CE892@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
 <1746050758-6829-2-git-send-email-longli@linuxonhyperv.com>
 <SN6PR02MB41574E031668E0F27AABB978D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41574E031668E0F27AABB978D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d289c044-6cfb-420f-acca-c8ee4afc69c3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-06T00:57:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA3PR21MB3934:EE_
x-ms-office365-filtering-correlation-id: df0e3123-3b73-401f-8aaf-08dd8c391e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wyOewsqEa9+ed09v0XnI1EU8FGpwzOCY0jOm/Z+VvVzoGNVSdIbSxjNPoCDF?=
 =?us-ascii?Q?9QccTw7HmntgkQNl4U+HA4tiObvp89rbMunZHlkRkQlL4pqS5jaLDwpda88L?=
 =?us-ascii?Q?BhgpIuTESpSW7yJ+e6AZ1Xgz/Vn00MidGOkTEr84cdy/tNs9wd0fenjQ4wPn?=
 =?us-ascii?Q?1sI7d74th+9CGrQ/FJasLKHnszM/v6GtQ8a9lltsTYnuaO3deUJc1j8U88Li?=
 =?us-ascii?Q?4z/tMnCp5eCddfx3z8nHIvbrMGTvrHEhatwRzOmLXwAlsmAbZ+UHzAtG07Lg?=
 =?us-ascii?Q?69iTfY6PzPPhna++nLURsBqKUayP22QtuEFxT5UEhBkAGD0mipSywzs7KXhy?=
 =?us-ascii?Q?aLnSc0Bho09bW/E+Eu9RbWLHEHjbEnmjc/XnvbJupYjzt0lzvyT6b0EOy0qN?=
 =?us-ascii?Q?lpJu2j7yoqBgCOYcO6gccsa5SrEA6zh97EJxZqHlQQvFKTClkh5AoBfmWfh7?=
 =?us-ascii?Q?6fPQa/IU1934ZLeUe+EiFdTSUYgb3tO1JFe7SGizGoOy8h5szYceBtJAwupN?=
 =?us-ascii?Q?4v2QuehO+L/bYLJM4edncGodyYik4dm/Uty5VpXEwYnKVwgOCSr5voilvqvJ?=
 =?us-ascii?Q?KXxJrMewA41bYaKNzN44dWbj0NrQWonS/7iHghUrDDlafZ12ZOFEAm1QcRkJ?=
 =?us-ascii?Q?ydPYi86tb97drR5AY02M3rfz6iKRINB1dNTfyWYlhjeknHPadYwtMqvRbR0S?=
 =?us-ascii?Q?y6BGIyYCgry9NZOBrEPK0t2BkCpCWGaTF8UcqGfkT6r+7fyRwhc04Sy/OWC+?=
 =?us-ascii?Q?C7b+VNAlQhcfrly3J5WvQhxWW3kTVJ6Yi//JkT4lF5hty3NFgkbuYXz7oMX1?=
 =?us-ascii?Q?vzKsa3OkBaZV0eVPBfCRSqvPeWCGdL186uPxAAkBa79up0yYpWmG7db6SIP9?=
 =?us-ascii?Q?ktsrkASQoA7/6KccQLwGAoHTozpKURUMMZUG7o0FHLBFD/DyEFRrUZsnVO7g?=
 =?us-ascii?Q?4sXYhf0d8kW+ANNpQ5yJ6LJFn3zUN5wL61nq+5+IVHjADa/RFGypYqWKH06P?=
 =?us-ascii?Q?vg7ZcFJvgVfCIcI7O8HBfli9r0owQOkhaXCsd24doSSSDLp7WnUWF54vFPGx?=
 =?us-ascii?Q?49B5tmeVdwAwWvrLt3IyCRnE1h+VVtImldDjzI/hXUZhkuPPsUZX0L3w+kQm?=
 =?us-ascii?Q?y618OGzhsMOCM5Myp8EM2SFJPcbKIE1J2iDgsq2T8zstaMkbJBAJH8qCAcM+?=
 =?us-ascii?Q?evSffUB20+Cavw5elhfWtvS6A1OFF3J4FZQ8gw2g6qnFKKTH0sVkI4tfEus9?=
 =?us-ascii?Q?LQmbWtDP0a6rsqmaW72rTes2Q1bC/FZ16D91pISAsEQWdKEjUwhbuW1f85eV?=
 =?us-ascii?Q?RWqOYyR/fKJZ6iq0ydiV8NMxejBUcPBXLprKQDh0x1phY8ZjBNTB+OU+Dnnv?=
 =?us-ascii?Q?HnM8JQ+YgH4Idi4rSLZ9CPa8AbXp6/vzW5qmxMu3xbAumj+XlLLZMAVe10iE?=
 =?us-ascii?Q?p6Xa5+EjLtNcjaxJcy7aKkBG30Jwc2GttNZ5VGaHAj5CqLyDvQ5wMA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IWsaI2cMCRlq9ZPXvpS6Vt9ZbzZ52naNj/QnkXBULYvhEAZm/zZermEgEoc+?=
 =?us-ascii?Q?7TlNzrY6PupyeS44viSdAMGoKquDfNH731jdXK1hVgrXCrSt3z/GlNR/68Kr?=
 =?us-ascii?Q?Zt8UePa9kCsDgiEXJpQ6H9tLZASZv7N4rosU78Bc5MfmP0gvhNtUJCNamcAE?=
 =?us-ascii?Q?gAgLqQRTA/hVYTBvUxymeiZV3v3QxGDfyNLO+cn3Voo8MidCDWUpEc0Nv1kO?=
 =?us-ascii?Q?Yy0degGBRplSvlEXioGG6GEfQuzp8xaA/eR4dpgApy7G28zyzVYiKsFS5hxb?=
 =?us-ascii?Q?/AONa3P0czj+EtHvDQ2z8ezm5SN45phqxA+NS12rGhGBzy9mQ78qYTfEyaA4?=
 =?us-ascii?Q?k1KRX90PCb94riDOweaTdY9zGha3ojgxahdR/iebB+4ip7Otb0SR3le9nzSs?=
 =?us-ascii?Q?ZM6s7E5YD8r7avjrIjYPUGWEN1E8D2b99rLjXr7qCN/TzrAvJAXRw0bgBPwJ?=
 =?us-ascii?Q?QYbw7xrMK+JQpqtGWj11iYCnT6fQcqsC+Hl9ieQcw2DnveaU4eTcU22SAA7q?=
 =?us-ascii?Q?bMQAXPZfMJcjIVrwcsM6mNSuyA/vLk8jIS+nplB0jdxZUjg/wdZL8rv0y8k2?=
 =?us-ascii?Q?//ZHaDIzn+lCCkx26bhotqjaEVwVvKjF5Jm9mTtONdFfHd9zSxUeNpi8c3d4?=
 =?us-ascii?Q?KQ2zjprfsj+KfufoZT04XebKa5QJug8Da7fmDN4Tkvcta/JRzSMDlfsJK+7Y?=
 =?us-ascii?Q?owtptrHEqGuL9NpyH51uzezCw/MLzNwczzq3VoJVpgYnYgqqQs8Ulg2FITTJ?=
 =?us-ascii?Q?fb1dagm94ByOvZaCorAIBG7c5nJoTAKJdhWpDhukEqGwOS69yeHn/0aYgK0S?=
 =?us-ascii?Q?O2kXxRcs70AmFQQaCKgj9McuFzsGYsLP3J3icXafmGgUSHxx/JZ7m8afeGHH?=
 =?us-ascii?Q?2sthBMshrjAQkPZhO9Iui7nNbYV+Dbl44dqCDbxdOoqI68druJlwhwV6MWAq?=
 =?us-ascii?Q?ZBlkCrtIzn2+X+p1alpjzpJd5nHfAWCJtqArc0k4IgL26H4yqNd1OPc65Frg?=
 =?us-ascii?Q?R3VODY788o1WPNVGDPTvxgxEs6BDAl6PexfRYt6b4Go7MwVKgFR47jXyKnAc?=
 =?us-ascii?Q?rUZGDR7Kc0I5yhDItyvCPiSNgbHxLtlY8Mn7KZOGClxH3w3Ytst+E6nsVR2G?=
 =?us-ascii?Q?yH7ivitksBHkvZ3QIOYcGEXST2DmoYBPuvMTg6wMEja2/rEzoD7W5hw0TRQ0?=
 =?us-ascii?Q?EiugZAZ1//y9es/xdVaqRmnWWT6KGADqmn3ZRpdVyFDNrqQiV0+Shqv7cZXY?=
 =?us-ascii?Q?oSvaAHKnzD5i9ZCFUa/iFZf3OqbiexDP39Y+Rive2DtSuLEXlX+G3H8+FyMP?=
 =?us-ascii?Q?x4wXi61Gq4V0Qd0cRUs+6JoTtF8vmfiUWprdM1fOXu6jb1t//cX7+sEAvzNb?=
 =?us-ascii?Q?/+xazuDfwEeokiTWptuKYGbB5X8EE7/TugfC2CqQVqUsHWLAChyYZpd4V63B?=
 =?us-ascii?Q?JPDKlDQOCUqqedO1m/+eBu00Smba/Jrqbwrj/PsqhR/jybo+Of1VOt9Mzgy/?=
 =?us-ascii?Q?QcYVMG2/Uvq8TalGQYViN1ldv0PHMOFtck4PKusgy9utDa6yNr0n7rk1mCIH?=
 =?us-ascii?Q?xgxeX/c6tn4rupcu+5SY7vJk3ydaADcszm5YWr/6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e3123-3b73-401f-8aaf-08dd8c391e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 00:58:31.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBF8IytuREfrCsaWGaRkE4IT1GoLi3xf9gezW8R+VkUjODiyET0QS++rHra+VWmieBJZAwEAHia+q+wq+kXw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3934



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, April 30, 2025 6:56 PM
> To: longli@linuxonhyperv.com; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>; stable@vger.kernel.org
> Subject: [EXTERNAL] RE: [Patch v2 1/4] Drivers: hv: Allocate interrupt an=
d
> monitor pages aligned to system page boundary
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Wednesday, April 30, 2025 3:06 PM
> >
> > There are use cases that interrupt and monitor pages are mapped to
> > user-mode through UIO, they need to be system page aligned. Some
> > Hyper-V
>=20
> s/UIO, they/UIO, so they/
>=20
> > allocation APIs introduced earlier broke those requirements.
> >
> > Fix those APIs by always allocating Hyper-V page at system page boundar=
ies.
>=20
> This patch modifies hv_alloc_hyperv_page() and friends. Then Patch 4 of t=
he
> series deletes them, including the modifications. It would be less code m=
otion
> to do the first part of Patch 4 (i.e., the use of __get_free_page directl=
y in
> connection.c) here in Patch 1, and leave hv_alloc_hyperv_page() and frien=
ds
> unmodified. Continue to make the change to hv_kmsg_dump_register() here
> in Patch 1 as well.
>=20
> Then have Patch 2 simply delete hv_alloc_hyperv_page() and friends becaus=
e
> they are no longer used. The modifications to hv_alloc_hyperv_page() and
> friends would not be needed.
>=20
> Patch 3 and 4 would be the additional changes in uio_hv_generic.c.
>=20
> Michael

I have sent v3 of the patch series.

Long

