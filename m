Return-Path: <linux-hyperv+bounces-5071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D7A99810
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D5A1B865F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF028DEE8;
	Wed, 23 Apr 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GAuvZlHY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020134.outbound.protection.outlook.com [52.101.46.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B428CF61;
	Wed, 23 Apr 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433592; cv=fail; b=XgC0sAMhgKBs4IQQYThe1c3Uv/8twGCst07EL/2txeE6nA/fNv7nmFdSssWGjKpARpe3snk1Zll2TsxVGTBO0pw7w1jmzX1zf1+NkUmwXTfhrpVFy8sJePM+l0VvYRvQJO+m3F09dWXIk4385lsyIwzTn0ca3DNtnYV8XwSg2CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433592; c=relaxed/simple;
	bh=W+nMUIybesYaN2kONgACqpb6c2c/3sqyOEdYsl8xt4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBBEfO7pTcyqnOhbZ1jc7j+VzonbggWI5N2AaYLR0VP/SF9qcRn+Z+NpqB28toK94sxZ4qEhuUGnie0efdACHCQLJcp7yWFEFgolcGlQ9v2yr7E14Ofx07Dx8zRjy58Pg/DihbQ+bqyd8LlCJ1CaDv87WKAKlSgl7jj36DEr74w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GAuvZlHY; arc=fail smtp.client-ip=52.101.46.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYyHwSlek5BGq5DEYfax8nk+v7b7HEPE2Vai40IfH6Px3AoExBdrretPddUN2ykpxYZGsjzKP/3S5xRhXhy9xsCrcpU2hHeC8gk6j5+4bKYl3bm3JP6QEnps3Qy97j2QyG254OI3eeVIJAZ2T4oLRCu2Ua0DwwkSoQZiSZYjJU1xqsyPah3z9gYt+ewacvoegzgvq0wXkW1K6mppTqjAuIFE90wxQ/BsFhpppVv3RYDZPpN0DRsecZ5xIiPbJqu/PBv9H0+ASea1TaNTiaWFu7Dn3lo/EXhbjDZk/2Z1XGAAZJJ9yDpufxcNF056jLBeenkF3v037NR2KqP1U5T68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWPyDTwjD0XihZEJvRk833d2xM9zfQHudJhZz+xsG6E=;
 b=yHlIdWj8eJh+PMZ4al71vDAvLSxDt7mD6lAfZRjTlupSzU3SxZSm0rrB1UCg8LWEogkCIWocgIlueSEllCf9AHqUmduuVdQV5bjde0GVIeOLA9KrCHqCf8Ue6DsN4szmo6lsHz9sQgub6hn0PScB5fk/OO5gQdXpMTtsuBdH/kU/wfvlm1Vj9eA8qx0IdR5uIPKQs7p7JHSHjGqzsYMdKPTwZE/v5SaFqU8163xiEAHmYpox09JdjQ7HO5ux3qMD/nQIu2qmHN01jb125T+z7vI15verCFwnceqvKVijtZh0ye5TvUDsNh1X89EGVgP+Jq69OY9ffpc+mZgLfFKdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWPyDTwjD0XihZEJvRk833d2xM9zfQHudJhZz+xsG6E=;
 b=GAuvZlHYjRVSug/rloPoeC0utVhns/LuNOF5sNqQdWrfYdThmPtEVxbVJ7Ar0Q1q/WxAM6i7mgZwKkgSH+7dMgkSn8/spVj6X19Attfjyz49a/n0c8pYsAIAw9LgkU6x1oVw+OIwHFRsCHJWZVqGpspiaraE1+aI0qqP6x3gv4k=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA3PR21MB3865.namprd21.prod.outlook.com (2603:10b6:806:2fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.14; Wed, 23 Apr
 2025 18:39:44 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:39:44 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbslAN1SqaOO3nYkicekgCdOGZeLOxmB3Q
Date: Wed, 23 Apr 2025 18:39:44 +0000
Message-ID:
 <SA6PR21MB4231F82E3042311244A8A101CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-2-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB414817742F4B15AB928450E6D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB414817742F4B15AB928450E6D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2bfdd413-4300-4f6d-a850-8a697434bd94;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T18:34:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA3PR21MB3865:EE_
x-ms-office365-filtering-correlation-id: ef2a88b8-aa7a-4e37-550e-08dd82963752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LUYtOp8DG9lSc/iqYVwuVyqKnJSJCghAiRygQZOCbiM3srqc7/u59cZXs5mc?=
 =?us-ascii?Q?e9VMKmZ9strx6TwUZYKg1v7uyKt/GdKZHGbciXJ3RAzJBe+aICf/AwT51ucH?=
 =?us-ascii?Q?RJv8X7L1aK/X9QvGYcPCAKlit3S0Ic6oKZ68yC7wNUZ0GQpfY3bZtNziU2aJ?=
 =?us-ascii?Q?xGB6IefEjSnaEGi8WGAQh7CkEYqI+iXbOG26QOMnBJf7zHHTsZM8mExvCr/r?=
 =?us-ascii?Q?kYBKj5O81vL+tC0uLBopxdckEPjs2sZGy+Mt5ZO/Z9kAkwM3q80Df8kJSz4z?=
 =?us-ascii?Q?JuNCMEXwnGS8pdA4vD4e3TV0ZRvZLaVho/Iv0DXIqxnFLFzxLxkCV9ipm17y?=
 =?us-ascii?Q?fu8s8UAy+9DHHGjtJ8Y07/lDgJFKY+PDztHJcuTO+Qx4srSpunw0Z0mCxwMS?=
 =?us-ascii?Q?ZYW3GnYwOj2G4So5kLpan/zlSQew/L6WgzZ7HhM4KtUQTbrYJXQFczrpB6Yw?=
 =?us-ascii?Q?RbYojY60S2Bel/rMCIm8nai2MALIozhVA+CndSbV+8Kftjh0H3VB+loDcLGk?=
 =?us-ascii?Q?VWHteielOhtoGZEbgunweSL560/w7+SehFhIT2GtHb6qUa6vu7pmFKvr9BBJ?=
 =?us-ascii?Q?8nNbHCzQuKf+LPQj5htTk/scRVFWvvcgHozk3/xIIRAU85a5Uh7mbthvmamK?=
 =?us-ascii?Q?rlX9+KII09nw+MDDC9+5Budar+uw68cZ1VoYzLnfG8tB6kxmSMlFqrblFZLs?=
 =?us-ascii?Q?H/lTToGRNqdVXif25apbWKrtPvso/lmhHQHcznogUEYpc123OZmWCNk8PnZ/?=
 =?us-ascii?Q?CsCdWAOLGwBwDQsearNXdzFrAspu3/PssoE1DY183rvP+rruHloj5/6vVPpL?=
 =?us-ascii?Q?5xPJ/xYEW10m7/V42ZOurmDX93ixdSuUujCd7ets2F+TswCiqI6ZHlD9Aeon?=
 =?us-ascii?Q?ZlhvKafTbDHGHnFgJX8cEwbBI34qC8rivmXCGAvaYIGFTNe1o56ycqvDfMwG?=
 =?us-ascii?Q?uKZ+E2wgSQOYHGJY79F9sVDxZhWISPR6q/C6AvQDybcJY/fdTObJOrsqYKw7?=
 =?us-ascii?Q?nYQSfQWd040WagagGH5ixqI8CXepG8lWWz2TTD0EBSGA7gPKd0H1ezI48oWL?=
 =?us-ascii?Q?2h90VLdZfd/T/8MRcZnRc/HFmCs7YYEOnriJMgPQugWYfwt9wV9UOqnW7/GV?=
 =?us-ascii?Q?D2c2DDjwXydMHx8PUCo9+aa1FzdC8xlvVv615pJ6QyQakdQHXqTWgogrJcfI?=
 =?us-ascii?Q?OwX50Zg/u1C3LUPswOMo0pBJTBA6HpcO+5Ae/qdLwUpPJ/3XVPi9ydegQMOt?=
 =?us-ascii?Q?AkYEV4x0eGRz9JYCDGwrsjisVB4cST37ZznHBd0jMQZcudpEeBFsnx9sL0tt?=
 =?us-ascii?Q?q24CasHubBAIQYZqp9lFMRMOkIeDDd3+N51bOrTDpufN2qUjYr5HpM4kkkcs?=
 =?us-ascii?Q?WiZGiTdtuV5d1OohVhDOl7Z6adnA19jH6vLVXtlfI527pzc++WA9D8+8P7MK?=
 =?us-ascii?Q?Fll6Bi1LV8PCF0gcwDBti64W1pt/7DIAie2rHRU38ooHzrRprcU+xReJ9mpO?=
 =?us-ascii?Q?D6YHX2asgROFjx4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fibusq1uaow+otUQ+ZwDIGR4wKfU9icKX2FakAch2oQCwT+X0yKFyvL21qpu?=
 =?us-ascii?Q?8WMZDpq1HoIRv0cnbs1c0loqCbx9NCliBMk3WN1OgsAh6oA/HLJXpA5gPIwS?=
 =?us-ascii?Q?jx1kki2G8wwHWkA1FI5sMmJlb0J8UI0t3qwj3EgMyVj7TsCDMjVJDK6wlmPs?=
 =?us-ascii?Q?8PCPg9avY92je8o8eVautBOcaWSuG/MUws7MPn4DOXdcdMoRSxTkbsTZL87G?=
 =?us-ascii?Q?im6NIdLuU2h75lVTCfc1Zms3yksmksRU42l5Isb1gSLODys9mXmpbht+QhMT?=
 =?us-ascii?Q?Q7gUjBjL0boX1wf+YZeB6ZDfBUIEdh0RqMvuaflnt5QqpFVzwvynLcuRZpS+?=
 =?us-ascii?Q?YoUQ9mWwEkOOSRXSb74spmkgGvML4Yzaqc/yHDkJrRFrKopbsX30j4RsZF2h?=
 =?us-ascii?Q?3/prVvf2U5421F36I7dCxWcRE6I+05K3KSDJWXNBk7ysQROBJPd3TE7mtHXY?=
 =?us-ascii?Q?yJtEmW5ip0uV/IkFKVig8Tsl60dOn1duZ89AAXGEHOoUunnfzZPWFUy4KQ7+?=
 =?us-ascii?Q?sWqSKZlL1cetttEvvGp59b6XtJdxG8fUAs2S4tKOQQ8eGWoAJS/IykH2Rmwv?=
 =?us-ascii?Q?W2Zs+dmXAEWkQzv1p3uyuyW/fwDaLVVYk2nWzBZe73nqGTQZVr1eF4Ucd+Kq?=
 =?us-ascii?Q?mP5wGisSsrnPkWyI2snPhLAdi0xeBasfn8xLSOTvm4KWRolBK4YFtfprrmmT?=
 =?us-ascii?Q?XGC0ZnUZLWsIhocsmRBqMz+ecsmZR7Ekq3/XE0lLpqQfMnzSCurHjfDRnULV?=
 =?us-ascii?Q?JZ/eoD193PPAspQXoTcQEizh5BPe/DB/GdWmbv3YSqO07b8AKcG5E4CuAJOB?=
 =?us-ascii?Q?db4yZHfMlF2skJbAqh/gqg0cvCcj2PElZzpTRgG8H3RgnXLypndLc1B97cn+?=
 =?us-ascii?Q?nAlsL3E7bGZmgN/wSEUHmqOajHTIiu/fmkviVAryxp/9rVDHTNtbMFr/E1ko?=
 =?us-ascii?Q?qgyDd3R59/f87cl05E5QHlSjuuRdJ/JhKkC5STpUXySZMmDifzmVjjFqKRE2?=
 =?us-ascii?Q?iCIn1xJ/l2Uo9WAmuqJGe7O0PpygFVxf69iPAC+sppDq7CM/OiUqPgaCvYLr?=
 =?us-ascii?Q?EjLt+XzVOC/7q482UljwnwfgKnOh8Lx1hWweLDvTi4SZM5qt97c8bzXSrt8S?=
 =?us-ascii?Q?J2uf88C80yeDLa2+l5VT08gpx1VsJiDYjQcIhrkXo5lASSqTPOqWtmiRzae4?=
 =?us-ascii?Q?flqeOlbHsZn+lq76d7AWq2SnYs+slIyVPA53MuUOiEQIEi8OQ0Vcpu+kMAaE?=
 =?us-ascii?Q?SGH3G0q9XPB2tfj/0vTPl1QoabQCSVLTxII3j+56Gw0wv2EprICvbrTNO1hO?=
 =?us-ascii?Q?aFMbfgUByVxlGBDdirQJqrYkNZCKKiMhP7SCyRgnhl4PMa2QL+cEZJCtc/7j?=
 =?us-ascii?Q?sJJz0t+688Q32CdoX9ieMLt+F74oOaewZVx5RA47DX22NvGXEIk5W+lnzvyV?=
 =?us-ascii?Q?Qm9MGqd35qlk0UPus3WgpouYrEp7riNZ+AAWhmhQVbhxAGjMvoC/QmF0DL7Z?=
 =?us-ascii?Q?JPj628DElggY1poEwE9zVhEzixGPMVj3oCh4VWbhZ2SQTevVh1cOeN4FVMRr?=
 =?us-ascii?Q?EKPZv/LMusnCxa8gtnrqqIMfZ91bHYw+oU1KXxmV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2a88b8-aa7a-4e37-550e-08dd82963752
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 18:39:44.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvFE8yKq34WW48bVzaDeoAsqlTSkj1YTsKkFbfwtYGAHX2v3Ig0gv4QRqdXzjubabvAzLAwVnne6jBvVQVHiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3865

> Subject: [EXTERNAL] RE: [PATCH 1/2] Drivers: hv: Allocate interrupt and m=
onitor
> pages aligned to system page boundary
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday,
> April 17, 2025 5:43 PM
> >
> > There are use cases that interrupt and monitor pages are mapped to
> > user-mode through UIO, they need to be system page aligned. Some
> > Hyper-V allocation APIs introduced earlier broke those requirements.
> >
> > Fix those APIs by always allocating Hyper-V page at system page boundar=
ies.
>=20
> I'd suggest doing away with the hv_alloc/free_*() functions entirely sinc=
e they are
> now reduced to just being a wrapper around __get_free_pages(), which does=
n't
> add any value. Once all the arm64 support and CoCo VM code settled out, i=
t
> turned out that these functions to allocate Hyper-V size pages had dwindl=
ing
> usage.

There is a BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE) in those functions, b=
ut it probably doesn't do anything.

If there is no objection, I can remove these functions.

Long

>=20
> Allocation of the interrupt and monitor pages can use __get_free_pages() =
directly,
> and that properly captures the need for those allocations to be a full pa=
ge. Just
> add a comment that this wastes space when PAGE_SIZE
> > HV_HYP_PAGE_SIZE, but is necessary because the page may be mapped
> into user space by uio_hv_generic.
>=20
> The only other use is in hv_kmsg_dump_register(), and it can do
> kzalloc(HV_HYP_PAGE_SIZE), since that case really is tied to the Hyper-V =
page
> size, not PAGE_SIZE. There's no need to waste space by allocating a full =
page.
>=20
> Michael
>=20
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator
> > to arch neutral
> > code")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/hv/hv_common.c | 29 +++++++----------------------
> >  1 file changed, 7 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c index
> > a7d7494feaca..f426aaa9b8f9 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -106,41 +106,26 @@ void __init hv_common_free(void)  }
> >
> >  /*
> > - * Functions for allocating and freeing memory with size and
> > - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > - * the guest page size may not be the same as the Hyper-V page
> > - * size. We depend upon kmalloc() aligning power-of-two size
> > - * allocations to the allocation size boundary, so that the
> > - * allocated memory appears to Hyper-V as a page of the size
> > - * it expects.
> > + * A Hyper-V page can be used by UIO for mapping to user-space, it
> > + should
> > + * always be allocated on system page boundaries.
> >   */
> > -
> >  void *hv_alloc_hyperv_page(void)
> >  {
> > -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > -
> > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > -		return (void *)__get_free_page(GFP_KERNEL);
> > -	else
> > -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> > +	return (void *)__get_free_page(GFP_KERNEL);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> >
> >  void *hv_alloc_hyperv_zeroed_page(void)
> >  {
> > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > -	else
> > -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> > +	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> >
> >  void hv_free_hyperv_page(void *addr)
> >  {
> > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > -		free_page((unsigned long)addr);
> > -	else
> > -		kfree(addr);
> > +	free_page((unsigned long)addr);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> >
> > --
> > 2.34.1
> >


