Return-Path: <linux-hyperv+bounces-1939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F189CC8E
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 21:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAA91F23337
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA172146592;
	Mon,  8 Apr 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OUANTQeM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9A145FE6;
	Mon,  8 Apr 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605375; cv=fail; b=M1dbzhg232iIgrLlE5UnU+262DeqPBjeW/k4PeIS1F9QMlC/v4KpPjFnGR8Exd6DHMUCM3A7tslYOXpoBhFpuUxJdiFrOX2t2KPK1wBM4IdPaOTcX6/PXmD7eOzM2u5BIzAbQqcyJuzPfomiV2i0u/yDNkoO8pM0P/d8botBwmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605375; c=relaxed/simple;
	bh=9Ub22+ldcMvokOxRFgxXTjWOx2Im+r5I4KhfCGCXaf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=boMDbOaA7Z38T4Ll7spnK8vI2ieVU7EdEovy15GyWyAMXryqX9yHr+HrQnNk9zoPmMNjGqQxLB/wf7lsNrgD3hWM/dq68UJGEFsCvlgm0vGMRQceqTNj7MLGoDD8fbIccvYpKTTT3suvEK5BLkPPVuMcwLQcO3PH+q5igEFTsVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OUANTQeM; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhp0R3Bvd98DS7jrIdEbx7uxGzWY5IDgGHrZZZRXTeAUOor3449/dW/LpNgVgx5tH6gO+yXQsrG580w1xgzk75Jw5PiXjVJXP5bNHAn7Criv4eCwUJkI1xVBRty/OnhUBsXd48z5FkGjDXf+o4QEUtrQ0Re/QADZthGgO/rUJI0fheSHS8i1D8k2HQC2y5lsgOr5ivjjJyYdQOVzmSzOcz4wCIq0phWGfkZiu+eaHBkbgXcUas5PIPRCx//l1Xxq/VIslbzVApoaf6cdCv43a1hiDJnqx7Sqs1bJITzczk5d/9W0Jd4H6YxAaIXCvPSjhV4o6qUIZ8PPMfvEb830Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzJs73rluC2b3xVS7oqEjzxQXigEB9CqXzyENuCNVFs=;
 b=DUcDSjxTv/KBV8qHdFlcsKskzu1Fk+10GZDFWj+jcw4iRP2uKsgZIQ0v/u5xyTYVLugNfxuJSolY7c8Ak2W5QVvBzNgVFugpHQcKSZo7jkn774Xr4x710jQDFKcTlXo5o5nme+J4Me9v785zttXD8xZjzrMLYUCCG+3Q1A2zWCbOI40e2mGgMWLtqJbQ3toG8yFv55/lkWTuKUZ8ft7fQcjY9WgD49qMUX+nRk6LhJT7zd7WMtEHK/r3RAquEebi24yz/ejK30ZvEYtqfceKf9lETSV1R6xb6UZEwO7dNzNGCDnK0/Z+2J3IcGL8pNldAE6MJE9rGNTQsne2daJTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzJs73rluC2b3xVS7oqEjzxQXigEB9CqXzyENuCNVFs=;
 b=OUANTQeMvjapibSE0cj3D7iWAfWEwRez7CkBhhddr9aR/zPXAeSxWneZMnNy/y8AZixCqGXd6AYMUy2j/CfGKFpo4zhY/PLVlF7xxwsi5GgKZelXLC2NijtOtKdXZVuPa/eKheXUX+Sqx6Hw/wuMNypaw+2Gd/G0xHqCCvFpP5I=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by CH2PR21MB1527.namprd21.prod.outlook.com (2603:10b6:610:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Mon, 8 Apr
 2024 19:42:49 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7472.007; Mon, 8 Apr 2024
 19:42:49 +0000
From: Long Li <longli@microsoft.com>
To: Erick Archer <erick.archer@outlook.com>, Ajay Sharma
	<sharmaajay@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v3 1/3] net: mana: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Thread-Topic: [PATCH v3 1/3] net: mana: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Thread-Index: AQHaiDOxmehv1Adolku0sGiR7pmhV7FeyWFg
Date: Mon, 8 Apr 2024 19:42:49 +0000
Message-ID:
 <SJ1PR21MB3457B14701CEEEA83BAB7789CE002@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To:
 <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73069a5c-b5d0-42c9-95bd-e1385007e102;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-08T19:42:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|CH2PR21MB1527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 msV32u9Y9BDShc5t6IpgRb/ElFlTny3ERiljEj7pPAcHUqdoVBk9ZPuFL4Wckw6t4UadgkMrj+jj5LSDvp1ZnbD+VNHwMHV99Ks6w4yb3B9qiSIXDU7+u7crMY0FFdFxgjFSG0THVS4bSr3mZBe6bzA34kBJ+Qm+iKaPDXr56aIwrP6JQpHJpFLXneY8Dvpw3/I/yI8zDt2e8mHWvGviB7UM2V9dwk4Y7KpxYE1S/H2iOX4sXMcJaxWvJBOKypsxHDjKzfJH/h0WGLdMXaMCr2WiMNj0aE4eXcOPsAEqXhczWp3az0Ty+rYzk/zCel6xb5ewtL1Fj7TXaZ1577ngPvgbJeWw2UJcD81ktgJE95dy1NTgOpHV66TlYp1L/KhX+vqgSJLlJYhWFl1LOECz2gPWXWpuzmUjkWi0BQAoYcs+5D+7yQZi+TWH3umXJqlDQaRrDV7waN9J9IPLejmQILFFUBiYW8WDGZWY1XPOVSyqHLqrN4ZPnqYnejs7tcQzekaMl1dtgfkg0VqOmnlrtMpDa+gzEVpm/quPjT/mlmEb09qLZ2eB8Ue4SOTwW/H8ApZPkpDYwk8v81YBOU7+1HTGF1iOPjZEmcEmh1WwJNF0e4J9bin9n3o6477JoDWRSTOE+V9D+Rsr4olnJqa7RA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/qQHSgTtR4Ld1HC0B64jelX/CwmnrBU5sokhSWW6eP4P4PxWnRsmGKDdkSHx?=
 =?us-ascii?Q?gPcaN1d1khhfg4feEeOo1TWBYPwjWIr4nNBFqyo3APReyGj3FWmA1bMPW/8+?=
 =?us-ascii?Q?W66BuHt4j691gdRpHsgdsCiYmCutFbb+SR0QuSmVfyxlt0Xn6TIUEfm5Ddmv?=
 =?us-ascii?Q?Rsv22UF7TLL/rhx0xuXrZrJYwT4HBkx+EAqyPoYWqHlS2g3dqnZ6C+1dyZ61?=
 =?us-ascii?Q?TN9vxGhrg661NIJ4HWpweMHDd/JEjIBvYaDNdBUWvrfV5Ox0z7BzN73+UHVu?=
 =?us-ascii?Q?H7Xq5ZKlKeGTa6SIrTwPA+vNjedLw90S6/zrg2NuAM9UBJ1XKoSvX41U5Yzz?=
 =?us-ascii?Q?S4+scgY0r1wpRJA/SZowZFw2orphXqVtzu1PHqp9AW8D1WzzZpHJMUZT6U+g?=
 =?us-ascii?Q?fj3pW37CaCd2Axhy+zg4q/bNpWVioA5KzI4NNy4f6RRBHGkRRjEtnSGyQ6wL?=
 =?us-ascii?Q?ZlrjMwQ/1OuNK7Os2ACHOFmjgrxWz+NKxkzd1jK8TpAGJ0TExuOdzRKhLjQi?=
 =?us-ascii?Q?UpIV/MjED3a1qyAF7ujSrUkMKOH9mlRs0TTn3nbLPykQqiz4RTP5z4mP4HRh?=
 =?us-ascii?Q?mwhk6rztNcIpvxcn6Oj9eNa0o/chrwbg45DxOh+WY6sz6CN+HN2SlUpdfSId?=
 =?us-ascii?Q?FyfMC8SUa+7Lq6f3ejdjtDEa+mhvev7bZxwuhO4KIxbnZV2RvsuX01lGSH1O?=
 =?us-ascii?Q?dd4ETqCI0NW3Oa/rNeroGBJr5eCRgPEC9SXQQ2yhZ7Ongqxd9GC/yRt6swoU?=
 =?us-ascii?Q?pvL7nqXYV+JiGE9w38tsLKtCYVh/EA9afaiB7Pa/KmluJ5aIaa1w4sAUJ3nn?=
 =?us-ascii?Q?5w5wgtymr8uDILAfrx+P2YSDu/SQSq1nrdr73Pvk67blP9PVODJ99W0m68mS?=
 =?us-ascii?Q?ABhs8YbLs5BPuvjqHi70v+JAguEyDn3a2fyzTybqR2WrCrQhsmyf3KOcFHOE?=
 =?us-ascii?Q?9gTB791y/XcnthuF21yC9Piuk6S2HhR83dklykdzvoqdlgOFvfLOGHcl237D?=
 =?us-ascii?Q?eMEMGUSJVkWr0WTaql+JKcrYE19Vs+QXoa7cjtKrL/AJJ8EBFGB15HYqBrfs?=
 =?us-ascii?Q?4GCe+ePdDhgiyCmlp8JpHqpDJsQS4eahi5dWd3P+EjGzNSbQZj14ze1BhsPz?=
 =?us-ascii?Q?AD/FBO4AJCr08ZEyWmwkb1AnR0FCd961eEXGyT18uI5271jEyVgoH6tSzg0e?=
 =?us-ascii?Q?xfvX9FksZJU/2/qhyB2ecP+6dYgYrZj0xgXiw4u76e7VxYKUUgndrLG5v3UG?=
 =?us-ascii?Q?nPGzK5kHDa4aYD0WU7uKsKXHG6/3QOEeY6gpOEymTTljKFP6BQ3GkTkkgEk4?=
 =?us-ascii?Q?o/jBPexkIRhnkMpDIq6dDUWfpWUKVzIuYyvGRmMKNVAlpPcFdQ/VXao4uKqF?=
 =?us-ascii?Q?y2MeE011dImXBvnufDtoACrMrxjzUmmiJR2kj+R1hxUNRpG0uI6//NdbdfZ7?=
 =?us-ascii?Q?oQjZaHTFHxhg2zON17EDX6SmG1Q3GVmZIwgQ7ghzXf6hL7pXx/7Z8e0ORNm4?=
 =?us-ascii?Q?JOREIXLycBVrZ+Ni86qxYgqzuUBjHuDRDpF5kCvc/gXDFkg1FVqYtt0wF4J0?=
 =?us-ascii?Q?JpAGwCMUIEQADQmdE4wI7XDbWt+t1wjuIQPCIiZM?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea468511-08ff-4016-fd12-08dc58041292
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 19:42:49.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQaKimi4sQ9lTkcTfhMhbAkhlSKK2rc5I9mTbKj4GcC9SyhcUbnslKSpatMCgCE1LGvdRWfkg1T+UGSdApEb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1527

> Subject: [PATCH v3 1/3] net: mana: Add flex array to struct
> mana_cfg_rx_steer_req_v2
>
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of tra=
iling
> elements. Specifically, it uses a "mana_handle_t" array. So, use the pref=
erred way
> in the kernel declaring a flexible array [1].
>
> At the same time, prepare for the coming implementation by GCC and Clang =
of
> the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
>
> This is a previous step to refactor the two consumers of this structure.
>
>  drivers/infiniband/hw/mana/qp.c
>  drivers/net/ethernet/microsoft/mana/mana_en.c
>
> The ultimate goal is to avoid the open-coded arithmetic in the memory all=
ocator
> functions [2] using the "struct_size" macro.
>
> Link:
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Fnext%2Fprocess%2Fdeprecated.html%23zero-length-
> and-one-element-
> arrays&data=3D05%7C02%7Clongli%40microsoft.com%7Ce75134553ebf4bca87bd0
> 8dc564acf8e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63848012
> 6558204741%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D%2B8k08
> SWrKXJiDfQ2cal65b1K1sElRB8x0oA5EFeUqbw%3D&reserved=3D0 [1]
> Link:
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Fnext%2Fprocess%2Fdeprecated.html%23open-coded-
> arithmetic-in-allocator-
> arguments&data=3D05%7C02%7Clongli%40microsoft.com%7Ce75134553ebf4bca8
> 7bd08dc564acf8e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6384
> 80126558211762%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dh0
> wsUICWnJwn1Nd5fr%2B0z8SXZIqXQrNWKTEbVlB%2BNI0%3D&reserved=3D0 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>


