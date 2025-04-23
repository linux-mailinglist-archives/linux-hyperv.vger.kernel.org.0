Return-Path: <linux-hyperv+bounces-5062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799BBA992A2
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D591BA4E9E
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3E29CB4F;
	Wed, 23 Apr 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DWnJtxpk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187429CB54;
	Wed, 23 Apr 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422042; cv=fail; b=sqeeG/1f3ssIuTCyobMQ3FpE34OnGcq4zbUzPPPd22fn2Rs/IiyopVB1fccp2zWpLh0ZyU2tM8ekW7j/B572kdWqCEbkI20dGM4Oaf2/nhVBidku7vNsmrfv2CZZlXkjexX1ylmG04AaBjIquBaTVI1LsAX5peArYimQ9VyZd8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422042; c=relaxed/simple;
	bh=0Kh5btQNvIzoHGB3fHvcoF9LvoGba4vfgcO/WrQ+2xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGs+/nmcfexkLCNa1Vq8KzIgJjBt2ziIZKwoageMcleIzhtwTXyuQslQaL/AuFTJfz1aDsWBNjd9hdCs8P8vw/2tmbKlM1kEOlbBJaYT0IWQmkKL0I/pv0dZeDpxNO3ALCoFxyGS9Je0JqPKj6FzlL3wvn3qnzSsv+3yfS0tF7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DWnJtxpk; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3hquIkstXtyIQUGhZWJA/dBdmQXuaUaqZa2Y81zC/yOBngh9zuqTR+L+YillxyW6vjVGCIuHPikvpEqeCeLy3Xy/f5ahoDpDL4NFWPDL9e5lBCs+WmstzMXmpiY2xoVpprCt30fEMNq8yZoOzTaFT1W7mghReEqc727aenlwQX+XX0fi34gM3IKLeMvjHvd+w/2aWF/Dr55Jl2hUN/49i+4FJSOuJejQSVAJbWuMYSXC5xv3rq+RLGJstLjyAh4unQLfwvjq5dVoCF3AV10hYttYbWgNxiGB1Tw3VhvpKLctyScxctw1AnhKp83f18rEE+9VYhvVHxy88XJ4j+mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kh5btQNvIzoHGB3fHvcoF9LvoGba4vfgcO/WrQ+2xc=;
 b=wUX27MRD0yKFW0f3IVxRRH4hlM/N9ALpABqSzIEkX1cN2/kR5dvIEE69i8l0VRsCSzAiuPKeRwneZXaSl8KCo9ROobVqA3Vs0XLut1kJmthqjktHJq69Due63ovnCiMx8dWVjDmesPQA67YIIOVfZdd+aA9id2kEOOiPvBccI/BwplwMaOiE+cU1gslU0JyRiYanHOl+qimkdWapaBE84xB8tMy0VhpYAUidk6Ors7YlU7TYNPPeu9T+Vn45eturBlqByv2voQfv9CJSf96oAEinYT06ASVZSpuc0CLA0NWvtwGwjSY84XZ4ppWahkkUpJA+XdDbYUN5gW+aGZoq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kh5btQNvIzoHGB3fHvcoF9LvoGba4vfgcO/WrQ+2xc=;
 b=DWnJtxpks4ufy62/I5rjKhyCA5icJx1ew4ACZKI+CI/vVxp9bzY2Pj8LCAKTtzukYvuqTx8QUJ4vo3fvYTZ8M45ZEiW3Mmhq2c4YFkiWI4cjh2UrdyW81+u8wknP89faCSnsRvWzFwCeTif1L7U6TVy4v1/6+i9zzhNOmD5a67c=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3041.namprd21.prod.outlook.com (2603:10b6:208:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.12; Wed, 23 Apr
 2025 15:27:16 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%2]) with mapi id 15.20.8699.003; Wed, 23 Apr 2025
 15:27:16 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "mhklinux@outlook.com" <mhklinux@outlook.com>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"rosenp@gmail.com" <rosenp@gmail.com>, Paul Rosswurm <paulros@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/3] net: mana: Add sched HTB offload
 support
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/3] net: mana: Add sched HTB offload
 support
Thread-Index: AQHbs7+MDaAWSp8m9E2qtHNhepkBALOwYw8AgAD7tnA=
Date: Wed, 23 Apr 2025 15:27:16 +0000
Message-ID:
 <MN0PR21MB3437359D91F059D83AF929F0CABA2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
	<1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
	<20250421170349.003861f2@kernel.org>
	<20250422194830.GA30207@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250422171846.433d620d@kernel.org>
In-Reply-To: <20250422171846.433d620d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ebbd3991-deb6-45f7-a4ba-19718000510b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T15:19:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3041:EE_
x-ms-office365-filtering-correlation-id: 5ab0272f-d8e4-4a67-eba5-08dd827b5430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/RIiLQkWohROl/sa5Wd9cBZpql/bEaYgthmxM9AzmioS7Y0w/9vQfA8KisAZ?=
 =?us-ascii?Q?7u91Pn9Jxz508pp7pzcK9XdAClXyX3BYZVX0VD9zf/4RG4JXIH/Ee9ouBpFd?=
 =?us-ascii?Q?lPI21gFKg6emdVHNh1KMR7tYT8sTWC+awdlvnIIwLfC7He5tOqviFZLe1Xap?=
 =?us-ascii?Q?rzHtzEZ09jhP5EKfDkBCCynG8m4Q4qcLTTdaL+gKgu8ThONJYd71kZtAGVVn?=
 =?us-ascii?Q?xu8wdkFk8w7IkPdnT4mLWLeFoDYE9H1VjfREhdyaG2eOSLvzeA44nnDf902Z?=
 =?us-ascii?Q?V89WkHt642y4OJWY+PakF2fzkKcj0iCLvMxS/pp3aGIVZRBP8HFzvhJltaSy?=
 =?us-ascii?Q?4vbL9kG1RtYr9a2NzpPRAEBkzNs8DI/d+Yp4T1QKhmI+5V2Lxzbl8IlPap1y?=
 =?us-ascii?Q?o6IWKi9kBDjQVbvpI3lyFPUeYzouovB9k7kl/SQ4mhXB32rbgFztqOWGGFpJ?=
 =?us-ascii?Q?rM9IfYUn8gsL3aTKeq+QtKCKWJSMe/fo2hpgGg0HWBxar/yVJcWLX+/dbVad?=
 =?us-ascii?Q?U4zM0aVZFanTOglMUVb7fNXmY+Ws8pcMHy9kY/4FQb2klUiblQt67O3F4cFl?=
 =?us-ascii?Q?ASvIW6HXEE5cNdpYd7GtzaZgYmdU6pbBfdI8GAjQxIv0g3fvGATs7ZaJOuIw?=
 =?us-ascii?Q?7dDAbkRhrQhofQXBsEp3KeTVhODFPaGoXw0Wga2M0XZe6PEYWFfVKf62e4Kb?=
 =?us-ascii?Q?15A3fFisc182lXEC9Afzm8KNl8rCl6UYWQtlCcN4Y+4NiW5mR6Dr6q1O8R30?=
 =?us-ascii?Q?Xxhs83PRRMHZUNI21hgMNwdVkjFsbGbt1qvrrwZ52TzjkNhhZfxuYTPAGfGK?=
 =?us-ascii?Q?RexIgETsVtN7aU4+o28fNkpfcRS3U0yMdwcQMsFicBLBtebufRGQ1mKnYExm?=
 =?us-ascii?Q?AK/YVjuXve5Li3m9+67v/nBWZdq8JcismO2jLGmgHA+sgEhqxPFMrIXYj0YP?=
 =?us-ascii?Q?2Qm4HVj20en5eSn9EspKv55glC5qIin5m4bQU6pc+buElJlIonuPHsdaZsno?=
 =?us-ascii?Q?0L3HRhHvU+4nVoR1UtyMDHYjnYrI+Jy6ul/MzkY5eCKZ5PyxhXn7rmZW12mG?=
 =?us-ascii?Q?jQtR+xWKIsyCI0GAiV0OHmumJQiDPHbMwOneNEQxP1JLGjRHwgbxpleP2gar?=
 =?us-ascii?Q?eB+IM7ZcGYwrJ9u99cLuxV5MHVjk5R4WiItjgYAH4vYau4ry/9vUPQNCIOBk?=
 =?us-ascii?Q?SryRiY1oCO0dph+wGdqN04WvObGBBeLJ8tY0RcvDycQDpsGTFfacZV6hx6PG?=
 =?us-ascii?Q?ILpe/OPsiKw5e00ykqzPyfkobnk6CYJ/egXV5wXEkzAVF1doJ/4lRtAaG9bF?=
 =?us-ascii?Q?ZOFAilsDdY4AwfcuYShHHRsMXgEpoZpsVpSidh0OMJgaJh/0ET+tGNplbWuW?=
 =?us-ascii?Q?wlxaJPYgo2LC0JcCcrJUopR/5jqlUCxV8xF7ZaMkskZgf0uTU1/4/b+NnpxS?=
 =?us-ascii?Q?7PdeMXF31VThScDeaUoiPKMJ4DZZx/5lDJsU4OhJINf3bX8OwLSZzg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z57EVH0+BEYTxdiuN7D0V8ROz2CCdfVN1lb0KBYugD/628rCWlLZM2RvJG1X?=
 =?us-ascii?Q?KGw6Cc3pqC9D/IfAwpnseokNz3dLcMLW5wZUObqXQcKEvrKvhS7/vRRK6acU?=
 =?us-ascii?Q?Y5pd6mJOqZtd/xuJK4x/HcZKY4ahtrABqgQdQOJxOwjh6ADj85DFRYV2gBxB?=
 =?us-ascii?Q?YCpiv3XQ9iFwjbR6l5gVLnpv7xWslvJHwbAOIuXuz46WJavncw9CzJWzWDiL?=
 =?us-ascii?Q?9NN1YmVAZHiQ+K1Vi7rS+VXgfdyt/V7Wq9gFJHvTIWdIbJFcYOpGADJPL6Xk?=
 =?us-ascii?Q?EeMwLSwvlV2pIfwRfZJ1/Ufft++Y8BSRW4D3lr4p8GtpAVAa2EaYBimRyGNX?=
 =?us-ascii?Q?bAdEG6uy2B9pYRa0TYd9zXncKVvpqy/7KOJtqZSACP1HlCbrXCpjCsH2NSjB?=
 =?us-ascii?Q?Vonefy/XMlB9rWdt+42Ey/rodfFGQ5XPxVGaPXngKCLh+Z3jXaHl5UpAWU8Z?=
 =?us-ascii?Q?I44tJpw5UCIs65zMX+XO1KZ4ZpuJBQqdbBv3Iax+3isIUloZ8uQVgPrxIEYK?=
 =?us-ascii?Q?I5+O13vw0vaCjHZbSBsAF4em5Kv6GXYM2mfWIjfba1vaTZWwygioSEew6xTw?=
 =?us-ascii?Q?7PpUxxqA0AA2q7eLFyxZSZPZBXAsaGcX82qcPPQrcUZbf7EAvDsqgmP05Mff?=
 =?us-ascii?Q?rrGqVTR1Qvw7xjAxcHxbDdSZQwpVtZXW69QKsKG4rgEVOwHNzvftcv84f9oz?=
 =?us-ascii?Q?cuYakc4Sj/EHii1dytXBvhIHfoS/euBG2VTeBRsSs5kP4CdnHs9P23j+YkWu?=
 =?us-ascii?Q?IohmzH8RoUG1Bvza/i+c3jsfA84rmi5n/Nj+jWwgbWTF6WXbQjJFMolzgvdt?=
 =?us-ascii?Q?OwE57t6uM4zNev1Qkele3eRlNDH/V+S/17rfDV6yvwZltkxMPQSU2cY7EW7L?=
 =?us-ascii?Q?YHX1liJkbDMUp9yZVvspO+csd040w9ATeuWNxSA33jju0ySBrkeqNSckA0PM?=
 =?us-ascii?Q?l/3V7gUt8OMPysveQXcDxo+gtKtZiwJMa3UzQ9IhyzpUrdzinKp50NDdjvlS?=
 =?us-ascii?Q?+3+NzJD5DVZLx15VFtRSpQiI7MtcAWGS8C1yXMQJsO1kPoLOZBOXzpH1FKYb?=
 =?us-ascii?Q?qExWpdCzbQngs2rT9xEYIwgR19h5albwQ7jKFKG+ZTN9cWGCP1Kra/14OdvR?=
 =?us-ascii?Q?aJ/dv6WKHxlqDmsfm5Iuyec+OnJEMCRL6zd+fq1EX0eIQ6mzKkdwbKBuNwE2?=
 =?us-ascii?Q?2xR4oS+ZyH01yfONd2ADhYT7otGH1B135BZ3NSDuT1xP6UfImDbpV++dPvaH?=
 =?us-ascii?Q?l2oz6zzF3wfs8ChZmeyiaOHHW9QIHvqEQr0ANOgHxh43wnuEzevfJHk9Y96Z?=
 =?us-ascii?Q?qGu7HqhmlLzl8FYAR1R1zgfndnMHNKkY4cyauNY7PW5yI/e8+W/ozXxviDbs?=
 =?us-ascii?Q?vBN3Bk6I82yYEF1tGfTzGgc7/MXeFIWUbT8TJRIaTN7d9HR+8XSHAa9SltF3?=
 =?us-ascii?Q?6khTI34fth5R5zX1GlPcIMgRlTmPi4BZU7O7Lh4bsLCxVNEDHQHay24/neE+?=
 =?us-ascii?Q?G6Yl+VuLp9B3E3+s9A5LV9+lrhItg8QXbwOByc/y/JyNb+x78E8VmI3CRZwq?=
 =?us-ascii?Q?QmEKX4RFX4NQDzhmx5f1MfY/Ye+oEQc+5RI8RIIg?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab0272f-d8e4-4a67-eba5-08dd827b5430
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 15:27:16.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNUzXwKkc3SY8UO66Nnt6ftS8hpxPLDpyIDWYKytp1RrSLqVGprqNlKRnfcm6zFWbm2srzVZ/Lrn0S1vj0KOaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3041



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 22, 2025 8:19 PM
> To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> Konstantin Taranov <kotaranov@microsoft.com>; horms@kernel.org;
> mhklinux@outlook.com; pasha.tatashin@soleen.com;
> kent.overstreet@linux.dev; brett.creeley@amd.com;
> schakrabarti@linux.microsoft.com; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; rosenp@gmail.com; Paul Rosswurm
> <paulros@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 2/3] net: mana: Add sched HTB offload
> support
>=20
> On Tue, 22 Apr 2025 12:48:30 -0700 Erni Sri Satya Vennela wrote:
> > On Mon, Apr 21, 2025 at 05:03:49PM -0700, Jakub Kicinski wrote:
> > > On Sun, 20 Apr 2025 23:33:39 -0700 Erni Sri Satya Vennela wrote:
> > > > This controller can offload only one HTB leaf.
> > >
> > We selected tc-htb for our current use case because we plan to support
> > multiple speed classes in the future.
>=20
> Which net-shapers also support.

Thanks for pointing that out...
But for easier usage with existing tc tool for customers, can we still
use tc-htb offload? Does using tc-htb offload for speed clamping break
any coding convention or API specs?

Thanks,
- Haiyang


