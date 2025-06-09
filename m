Return-Path: <linux-hyperv+bounces-5815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA39AD2787
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 22:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DD5188278B
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F121FF59;
	Mon,  9 Jun 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gECh56s6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023072.outbound.protection.outlook.com [40.93.201.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73E20EB;
	Mon,  9 Jun 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500853; cv=fail; b=jGYSL5hD8NhtAANwKidGVX9iObzlbYVdLCUAMfxb9DWD84Xk/YxGHSJcDOV77XM7C2LH7KUZxgvs2tKnx330iQd1ywb1B5ayQ7UKCAMqlRbiJFzjj7fjYROMYeEXJYRjUPVcgSn4hMFwFmlzCMLx0VFlLOdMZatlUlinfHpyEg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500853; c=relaxed/simple;
	bh=v7zbMYBIekAQO9fR3nUNecuM6EB+S0vE20wMmpw1VNA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuWLBO+BkN3C10OZne/lrBObADrTSm93MVfc+rZ4PiH9RgCJNdOsTOYmaCUpQ9BnjN8AfOET3Wp+baAH2c1z99uRUswWtb7Enoyn9071gC8AVmEPIxvjnRqShoPTnw3Qvoc9OqkLW/RTd2dLgNkQXc8Lm4VqRoUkGH4xb8RU4Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gECh56s6; arc=fail smtp.client-ip=40.93.201.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXsFk/OEtIHghwldl7tOflCmCVgWXVuvUuV4IsaPgkwtNWRsdP97rADkAIXTyyZcmQW3ngOXEYWCQcLJrgqVtB3W+m1Zlb/51hPkmWj3SKnXvDPHU6dGblXKFtYoNyRqHIdW4NhCPr+RkQgVAeTixaYx2xcSGntlz0N9TBlsherNsALcNSQ0aNIkYmem31XXvvjSngfozWvfyAxlE1qCNNFIWsmykDOjukzM15zNiXiRWXFHwlGhFkjlmSvOauXmTbEsqTLy9lf3mbfyhVwHzmdyzJWcQq2EUBQJiEEsnlZy8mi5/NfxjP1lKHtsO6CDUAP/HOz0mn1HT1TjZTjAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7zbMYBIekAQO9fR3nUNecuM6EB+S0vE20wMmpw1VNA=;
 b=TbotS7LPKP8PMgMdO8HF+vyKFTs87ev2ixYa2tpcg/zcdrvl/ryT5JHeO3z2wGCmZELGw0J5a1Wi6nColM3+smtJqPIPwIpTOGl5e7K/IsizViA82BiZv+53QCtkdlydEX5DmjzwPtKCVFjqhhxFGst1lBH+CemZ/PD5lvaL5AvTi8pQF8WnLLsrWUoZVyZ1JKmSzQ2N7ES4DQqptBsWoQ1rpP5Hyc7uCa0CkV7z6GcoDc6E20OUHPn+dwlmRfDhdsOdlzVXDaqXlvh7ywOMOhJjj4azlZjhzPRQfy0yKoYXSF2/GuQNFFWtThhK3d1l43QXDmn7iEqPyyJFmgsD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7zbMYBIekAQO9fR3nUNecuM6EB+S0vE20wMmpw1VNA=;
 b=gECh56s6WYdnwg/w6tjCqUCNVdHWjoGD/KCPvEUkwh27Kg42xYVBC7tj+O7o6//+cIwaiJR1UNWEzJsTzfgjCWmdM/oU/CNrrnm9Qk6e1i+4cnDsoKaebK96AaPgaYGgcWSQBGLO4XxXkjVLz4hmISLkTyHHWprfT2Dfs8Ky+bo=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by DS4PR21MB5128.namprd21.prod.outlook.com (2603:10b6:8:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.16; Mon, 9 Jun
 2025 20:27:29 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8835.015; Mon, 9 Jun 2025
 20:27:29 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, "andrew+net@lunn.ch"
	<andrew+net@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@microsoft.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"rosenp@gmail.com" <rosenp@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Expose additional hardware counters for drop
 and TC via ethtool.
Thread-Topic: [PATCH] net: mana: Expose additional hardware counters for drop
 and TC via ethtool.
Thread-Index: AQHb2SVt94JsebuHT0O1cu1SJfWCrLP7RwNQ
Date: Mon, 9 Jun 2025 20:27:29 +0000
Message-ID:
 <SN6PR2101MB094371F71B98FE8E3D0652D4CA6BA@SN6PR2101MB0943.namprd21.prod.outlook.com>
References:
 <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49a82560-6bc0-4fdf-8efa-7098101083f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-09T20:25:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|DS4PR21MB5128:EE_
x-ms-office365-filtering-correlation-id: 3ea8851b-86e2-4444-3bee-08dda7940e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|7053199007|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sjAsTqbyC9g/OQLcUF4DryEjhs6Nw0vXtkhk6b7mxHDQnDwnmb2kQqDuaALh?=
 =?us-ascii?Q?9WLcPwRqwUTfgdcSSMn6rpqDm/I3uAip5/hXKE7Mo4PzhaehxTmve+AAwL0w?=
 =?us-ascii?Q?0SpaLQIj+c/DxPqYT4FMarGI2A6ZQMXY93Eav6vO9jTuvdnslHIz6MeNJJzx?=
 =?us-ascii?Q?Tc2XoftQcuAoNJTfpLKhoVf0xUkbDzyClhlxGTetFj3a8T1/DuImtAhr3M0E?=
 =?us-ascii?Q?CLRiu+xrjesqnMoSbuDFM9kzI2++4hYdlql8QukBeLeE33c8u+/ynlcApHNn?=
 =?us-ascii?Q?Rk41gDip3wny4BRFZ//rHMxHlCXoEdqDW+fLIyXA6J8ggiGLp9EdP6JQOPoX?=
 =?us-ascii?Q?5Rwln0ILGOFnRZzJuaVU4kyC6GQvTMQehSFOBPz1elAo+PUD1s2CljWlM0g8?=
 =?us-ascii?Q?Gtb9JylhiYlY7Ta36q36mQTZLsPzXVyBRZSBeuVJccGxi6MyBNhF65jgAxfD?=
 =?us-ascii?Q?6XkbXmRCjjzn6PSH35dHyVb0m6ILZIcBTLtUHPdmGOm0ODDjrOTgvEt7BcCe?=
 =?us-ascii?Q?xrB07fPjgOSvHyPeNkK1r+XBdqbGv+9V10YWn47HJas21HDSYENhn2K/s8Fw?=
 =?us-ascii?Q?KtdGwI+38P+4VstO5OhIcl7YqF0GJWAJgH+bWXZMLL2IIoKPHnEwKe5qxaXr?=
 =?us-ascii?Q?eKAHuLGoxeqSGhYGbT3hwednbTwgAL0LvUyIlTO1d/ySf1BJvXdfRQsuf1pE?=
 =?us-ascii?Q?2n2LgLMrh3tOkNjOU/gSxZnvMImG3uH0IpiHgwyiC2FWDBjcMngVhVIlH3cq?=
 =?us-ascii?Q?QjI2Ox1yuRp9uOpmOFfQkwCsdZyJFGpzukweCNel8MKsdOKFPfDTKf1ENOuC?=
 =?us-ascii?Q?dgTN0X+znrys12WtHdqYx/9HA5CeBmMV6dZT/ifga9UVmnC0hLsIAqOlfwVy?=
 =?us-ascii?Q?4PiD5Od7RSWW5MWTAiyeW0Qw3wQHSWjbe8N2PWKtwr/PVgoHTtD1AyZ6nJIp?=
 =?us-ascii?Q?iRbMIhsfcRflpbgzVmvzvLYAmdNiwg49m07QDeVzt8iOjdfDodTu9+vZHBOq?=
 =?us-ascii?Q?Pqs7IgzFYYb8ir3vl6R8kcEDcW2/iPhqvZRymmfxf88A2F4AEGke5OsBQeGj?=
 =?us-ascii?Q?lrvrUs1Jkl3YLAN/FDSBGjc6mtVKuY4O3feVjS4TwLEUOGzfpLlNqqAjNv4e?=
 =?us-ascii?Q?lC6hfzEC6n4tfuPwZyQLJFplRVUIOD4mjT7vEyFe53hzyXBqWmea/DVylJbh?=
 =?us-ascii?Q?0Qg/EjcTmi1GEIxQiz2hfIWjrWSd0kNdpjaB0R+kvv90ZM+WwDPzWZYHvGW+?=
 =?us-ascii?Q?yFpEVUTo67Uh7n/7BpIrCQ+o9qCKpCBeSaB2YnDx6ooLarUdh5nb7D26t0Yr?=
 =?us-ascii?Q?ZvYoBQS0PCQ5nD+Z7tNAMOYxnv34z/fbGbcAAcbwAEgWu2FL0bYZl3yb+H+1?=
 =?us-ascii?Q?Ttbosn3r3IfAMMOINfY9BmhRWGo7BLyFzykon2IK/4fEGlCEwojaOvE63GYp?=
 =?us-ascii?Q?tbOIE3Mbq9w+6cSE+zlZ07JzM56YUmgTKfdZpJzDKqype1TmreHXrGMWu1lG?=
 =?us-ascii?Q?KzCofTnr4UbzQlk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(7053199007)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FsTAurv2PIkiQeFFnL1Ec5pSnbbLgClpiTJrSKFLY6PhoWF9YGtD7YIKNLDt?=
 =?us-ascii?Q?3ERTOYQyWHaUEdjiw5g0aNtsgS4R00GDYqtBU3fYwPBMwYoBjFW4vEveEQoW?=
 =?us-ascii?Q?gKa1GDR3B9Vuvb8+xdeHup0jW5p8BovlWY6qQAhRNq74fTfXC9v3GFm4vhtD?=
 =?us-ascii?Q?e3XbLjbRRYMgZz9e00H08YaJ44UdzfvPQnGClj4lFI0EUf37EYO4zWBrOOEZ?=
 =?us-ascii?Q?QgznxF1b8IsKU1C5W4yc1bQoBs0tJdsP3qmIbFilDqpL8z2gX5IMRbKz7pmb?=
 =?us-ascii?Q?7dlTmqEZCF9KAorF9DVxTfpZmk/uw3z/0q0qgH/+xgS1pSkpa3UovTetLyCc?=
 =?us-ascii?Q?SM0ItcNWqZUiIVNxxnzGlor1C9QYwQcbL2lB7z1g6YUMlB9xqNambSsPG8cY?=
 =?us-ascii?Q?sS56tHJ1MR3OVlpEIvH9VBE6LWkvr59qf/EHTRQXXi2rjGe0QekYbslM7lDZ?=
 =?us-ascii?Q?vipGn7/URMkhlipM6Sz9soKckeTDXC5S4hNabY7W1atZpimcI3sLxBV1fM3c?=
 =?us-ascii?Q?T9K3IDIY+PcL9EAne+P1Egyvqz5XwQGAib/Z+2DDljg8nR2SSYB6f2v1laSR?=
 =?us-ascii?Q?QfaymRuI2n3kn24ACFo79gm49KEfHxk1hxxUMBOAR1m2nw5nTpEQh/Yr3iwZ?=
 =?us-ascii?Q?NI+wPnZYE7d9pvIAHZpr2zQfqKkz4fsDmskHvR2zqWI6vgj97xtBMJpK4Q0x?=
 =?us-ascii?Q?W2eUQBGQKysnCs0tRz4zpfdrjBJKUri8/fomENHJ9vNBIzY4WvcLdY6+lLAB?=
 =?us-ascii?Q?oZhED+TuqoXwIiGndouE2bRbD6OyKpxLH+M0NeU/Qz5tRFQwDaVUCSDILx+b?=
 =?us-ascii?Q?Ho23ups3PwKL6TaWsEBtr7HxP24hWTNZGjfgM+RZc/l1+CP8SoqvSwMdPGp5?=
 =?us-ascii?Q?q+VWI7Cxxz9HBAu5b/AF4e4vEqmVVMKnogYI6J5l6YwbiH5siX1xOwQKXFBj?=
 =?us-ascii?Q?YbrN2nikcnE7sFxKRPxJqVuXU9IHiopes45cWjKKUtsrPPkxdDREYkq2okBg?=
 =?us-ascii?Q?qKK2kuAq6NiIlwtqGzXUjj133Rca6vvmJe2TO4hsLCx91YNzzdnzwvF94wwj?=
 =?us-ascii?Q?1ioY0iuJjDgdUHtug7Wy+GLpb6+K5C+UeQ9xujYF03gF4DIkrLiCCyS/dygE?=
 =?us-ascii?Q?jd20r0omh38ze2kgY9sQc+d1YTQ+a44uzWQJxTKO3CqueY23/3+V0pVHTlP1?=
 =?us-ascii?Q?qyuSvDNT+W5t2L/boE+eslvK4EftgYpyy4oBclk8yVA3p6m2wyPoWdjcTuPg?=
 =?us-ascii?Q?vcAEnt7on0Qy+vfDMKxzstXtPtmUf3514OaQJWxIMusBu7GQPnp/Xg0A4/ld?=
 =?us-ascii?Q?S1IXxFHvuXyHJnbq3cTsQaTqhzrXKi9+K44+oknLOkPdRXd5KH3ifg7p9snu?=
 =?us-ascii?Q?g2xo0v5DqRF6pZ/noEzxR2VnG9Aj6sXk8jP5NmLS5VfunrX+DRmu01fcrbQH?=
 =?us-ascii?Q?pYQd0AYyMSlZsEaU4BpCKiblHW9F0YHYCIkXcd+whgNu90UM9mYycRi1rp3T?=
 =?us-ascii?Q?doGkvu4uXPGHScsspGKXOnYYdQY693ToFVAOlIPKXjuYwbDwDhp5jrsKZ0qw?=
 =?us-ascii?Q?0D1CQEvAjqHux3v6ECd5RWFA7FJmHNotIn/hibEf?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea8851b-86e2-4444-3bee-08dda7940e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 20:27:29.1013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+KLpwy1Q/7rKEL8RVIfMuBsvImj1nslljCP7qW1znPP6/m8mcj6EuOsUz2Grc5fUQi8O51cB0p8u904FuP6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5128



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Monday, June 9, 2025 6:01 AM
> To: andrew+net@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org; mhklinux@outlook.com;
> ernis@linux.microsoft.com; Dipayaan Roy <dipayanroy@microsoft.com>;
> schakrabarti@linux.microsoft.com; rosenp@gmail.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [PATCH] net: mana: Expose additional hardware counters for drop
> and TC via ethtool.
>=20
> Add support for reporting additional hardware counters for drop and
> TC using the ethtool -S interface.
>=20
> These counters include:
>=20
> - Aggregate Rx/Tx drop counters
> - Per-TC Rx/Tx packet counters
> - Per-TC Rx/Tx byte counters
> - Per-TC Rx/Tx pause frame counters
>=20
> The counters are exposed using ethtool_ops->get_ethtool_stats and
> ethtool_ops->get_strings. This feature/counters are not available
> to all versions of hardware.
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



