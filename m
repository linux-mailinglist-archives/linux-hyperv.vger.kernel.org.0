Return-Path: <linux-hyperv+bounces-6259-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73116B06371
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC883580E24
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7B13AA2D;
	Tue, 15 Jul 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e0tO8rWq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023111.outbound.protection.outlook.com [40.93.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428020E710;
	Tue, 15 Jul 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594598; cv=fail; b=ZU7REgF+E6fLGCATPbFqfldt4pJrYQPWrFCRV6ugix+pa6qheYwhyDeALOq7h6295iVv0IKRq283aZn5qjC86wbwpMhfBEMKL7MKSSlnU2RhGlOMQlGxPDaBDSyH1OnwRFrYuczH+RRv3w2psFN5IUt/kEBBBQT4mvzt/MrZtW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594598; c=relaxed/simple;
	bh=8/vXEyweDMyiuDF9TKDveqPtQ6QqOY4YcSy7GKZFGX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IagIInvSbvz7TzwDKYxUZFVmiYLQgJl3XIMEFWPfOmBhjfh7TjvD9kKdudT2ilXT4gQF6EHm5f7eyewL3dxj8y24W9M5f+QOLM7ZQGpW+cEgGLJIgLJ2zZPLxGrlEHsYSfbarq/9FXic8HPvRfObshrXrvVGdtPpj7bR8VofoZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=e0tO8rWq; arc=fail smtp.client-ip=40.93.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ+hJv/nMmvFS2zNegfDVk9eTvCTJHmqITtbpJ+26bSJ0XwEYSwZB78hqDUn0+EVrsuya7blgSyBmAJcDBdBcwiXTUK7R/XO048IUIlm5BBqUw7gFFyPLAJkTujI8SwxMwCMYsagvmp/3WcF7AXSGOEC9Fw/EylQUmDD/U84bwCQr9R9P+RXn3kMQpk7+MwfvyDRWBioeXDEjSA82K21e/OpFuGusWZDSBD9SECpGDp6qjQ33lR9XQVaokOdZfAnulQxnvwGKyAVabi+VyCuB1n5eS2F6AwgXGPN5DnSyCVGKvbhOQxqJRrNCQOjCTaykgRwYzoNxHICM23qjSPHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/vXEyweDMyiuDF9TKDveqPtQ6QqOY4YcSy7GKZFGX4=;
 b=IqdFk6BVODX60KAX5yv7W9/4Z/eyd10nxgSHe4ZHqIJJLbaMPnn5D+ESUAppdU+Jn/IceHJlHj0Eavl1IC6LoMEPBNxfW8IQ4FVRQMtVMnnueE+lv9c1AvdWHVqvwGbStjnJ3aG0+/sMiY6JkagZrUcr+AP1spbhHcZIDp6TwA9KxdFF4IVbzAgCiz7lY0Wrp8pApJ+GtarQbBPw6YLo0EJQSBrXZkkLxSyzj+03dOio1B4st6HCJa6UbTxA8Gxw7Lj+YvUwdF8v0c7ZrfjbJWjnX1FWfF5B2vTz2AVTPP3sLrg7Ieb+ODv6L19RAOUBmVpxC99hsvo+acdyP9/jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/vXEyweDMyiuDF9TKDveqPtQ6QqOY4YcSy7GKZFGX4=;
 b=e0tO8rWq3Z/l2qAdb88e0gEODW5Tofn2myCxWXDjI+Np04dFTd5kqabH4KYvchhPXef8oVwoLgwsaswSgjHYHA+d5lAy46vgr8PkWKavvYPhGhU3akcf4YvjXuclH6HWgm17TctG0TqBT/6XN7xstRuLUUNM5yCwxoeiUw28oUU=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by SA0PR21MB3037.namprd21.prod.outlook.com (2603:10b6:806:153::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.11; Tue, 15 Jul
 2025 15:49:52 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%5]) with mapi id 15.20.8964.004; Tue, 15 Jul 2025
 15:49:52 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] hv_netvsc: Switch VF namespace in
 netvsc_open instead
Thread-Topic: [EXTERNAL] Re: [PATCH net] hv_netvsc: Switch VF namespace in
 netvsc_open instead
Thread-Index: AQHb8qZwEo+zpg1Bpky71Oo7+qJ8VrQyanIAgADsrsA=
Date: Tue, 15 Jul 2025 15:49:52 +0000
Message-ID:
 <SN6PR2101MB0943E6D0DB9E9D7906FDD54DCA57A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <1752267430-28487-1-git-send-email-haiyangz@linux.microsoft.com>
 <20250714182914.27c94a91@kernel.org>
In-Reply-To: <20250714182914.27c94a91@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=999cd5fd-7af6-48ac-9949-a551fcbcbfd4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-15T15:36:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|SA0PR21MB3037:EE_
x-ms-office365-filtering-correlation-id: 34ce18d2-b1b2-4ea5-4fd8-08ddc3b73cc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YGaz01IaJx8nir9Dpky/K5RtE+qQKQE92JfiE9nz+RmrCUbbAV8Cs2QhJzgb?=
 =?us-ascii?Q?ZJa75iU+a2CYOej25n9gPfTFTNRp1/M0qFmpHLQYg0x1WfVDavKT4jGYSqxD?=
 =?us-ascii?Q?ZxxlgL7Zcn0keJqTE5CUkMBEYuP0V2yFiXP9VGuZtNyDRhqXoFfEkJdlRX4/?=
 =?us-ascii?Q?38KmGtzzpPFsfEaCtQnvCOuNm8rChN+PeZhP7A3TYRef2wlI5BaRK0gzYAy1?=
 =?us-ascii?Q?APDR9L1u9i3omBtkC4rW5VM25wm7PF4iV4jY9O6y2BRd/v7uwuB03bqFtTU1?=
 =?us-ascii?Q?WHZ35qv5SsImdRLviE0HD2ZJL0NGYmVM/YyY4stvoF/7vShZkjK4lJFBh4MY?=
 =?us-ascii?Q?tX1C+0l2I/Ybas25amMvEAA9Cih9sPZFox0XezcPCN0Hr6aau9zjlKKuYXSL?=
 =?us-ascii?Q?2Qy8ahw5n6iGJ79WP6cgyx5m0KP+/q1r0YspbNrAndL8ywWYT3Me8AEvWgVb?=
 =?us-ascii?Q?362Z11X+mWNBEBlKrPUJYr8weNw782FXP3HgvdM7g0HDedQLJxNXbla+Axk+?=
 =?us-ascii?Q?jwUVg1aqXKTgD1SS8d9CAzaaamC0mMrrzgfoVVpYTAPAbCa5XWWt2Z3YKbJf?=
 =?us-ascii?Q?RtJS6dq5LE5hU3Dnvl1nJsrdH9gNrNOOSCB3whWmhXqYhd1NxXGZSWwgb1sv?=
 =?us-ascii?Q?J1l0eNwWZfVxl4TMxaBIPlat1y2Ww14l6+2wxQsZuxYsXIEd1k9Rqi4GNyRQ?=
 =?us-ascii?Q?BA5NZX37CQ44mfijqvAlpK/ndOUQtmiqzBl1xG4HgUjUCfzQ1FXpLM9Dsh33?=
 =?us-ascii?Q?VyEzBA/7Tz22IiGqHBpyb6NsTOZgxHoT9Tb+KdirubpZuYM8Z1oiEjGLuQF4?=
 =?us-ascii?Q?2ZGkN/PIzQaf4fymsLP4gvxLXhbYyo3CuXQKyqc8ogFr+OkJrpCCP2TgI3Ko?=
 =?us-ascii?Q?+f775fRHaZ2VnGuT+Rx5Qtl1gW9BpRmJ5MOyqFqEA7jcqiAXcHgQ5nlspExW?=
 =?us-ascii?Q?YuD7Q+tHrxkVm82yP9T9E129OdNDjOtBLNwSFsJiRDT0Z9MKnvFpoqyYHw6M?=
 =?us-ascii?Q?KblpYkbIT5rwZf88MohYWbxtmr/AWDDe8mlToZRbPU48Ebm8yHMQ3GRQ3D3n?=
 =?us-ascii?Q?Yak8Xhz2ii+IpebOOGUl+pSh2tKbHBrGOzmCN/bDwTzx8K2VkjmAxXaVTH8H?=
 =?us-ascii?Q?dtpHQJLGC54Hd6MxkqFfjZesrrWRdwdn2RkQvUnOTmtQ7rSEeQnt5kvg1bHu?=
 =?us-ascii?Q?SrnCOkleEEJEM/KTwt0SRr6Yw4jfhlY0tx4G0Weqy1H7isiZX1+NzCNKLZCR?=
 =?us-ascii?Q?W4V0IlDwWwINaPurqfsbc+D77+q8SkJ9HXojaQUbZwyBezVcm2Hw1YVJjhFV?=
 =?us-ascii?Q?Rl4pH4mDeMgZLddLssa3nHlXVme6U8ooO5XuZOD4a8qVHmZzPypto22jrOda?=
 =?us-ascii?Q?XOrqYJPFWKxe3ufHeL+4pja7NhTjMnEA49iUSqklwsA9xKcJfvuxsIpO9tkI?=
 =?us-ascii?Q?k8qpbv92ulVylMa0lTyvYlEbNiSx9AxSvZ/v8qJRXpBhMY4TE4EpGg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U/66ybjZjwZOywXahYmEHtRCaf0bm9YBV2tQ78BaGAvH3j3dP4KIBBExG8Wa?=
 =?us-ascii?Q?wAxfD0gGb+RS2SbhmwGh++NhutdQ76KlUQ8TvEL1Uo0RS1GSw2ZsxSlnuMlu?=
 =?us-ascii?Q?cSJhKsWR/XxXWE4eaMCS44vaX/NSj3mexpROur0mCWdcrJZVxA6fIWRFIQT3?=
 =?us-ascii?Q?ixQzB+4JgbzOogROtbjWf3CW8u/P6IxuSS6CuMTfMTAyYVlJvfntz62nWbQ1?=
 =?us-ascii?Q?S/FMElbi7H5tZBA1CD3YyT+wIQzLGnoTZWqhAhkDWkQw6xyVxBLUnnl2BoC4?=
 =?us-ascii?Q?Rbou6IZ5pHpywkPovrO/zWSxP/jCNiQi550t/BzUl1LS3yPh5zLjg+WsHb1m?=
 =?us-ascii?Q?HlGGNlzYNmO2jg9/+wyjMvHOwi8KLmuruJLwELvQvHI1RnuN9X1MdCFPvHp2?=
 =?us-ascii?Q?cQDl6tO+2phsnXPC6z0tay9pCG4lADjrHuDQgKh3ODOW4x69g1BmxcwJPfRT?=
 =?us-ascii?Q?jf8IUpMNNctSpdKBRpJJGAzONxHZZ/GrtcgFihugOdyP7ypaBMkjkvdLdmy9?=
 =?us-ascii?Q?PGv09uPamBLMllX3aV6F0LPSFgBNRnzvY2T3GeGIyVgFQqFhYTH/VW9mkH9i?=
 =?us-ascii?Q?0ZTTgJkVKxElxGknM0T/NflTx4nFvRQmygAQ1GHxt/ChQRQggds7Q6SUbK9D?=
 =?us-ascii?Q?0KG1RlfDciQgetyLc3GwYr0xCGq/98dhxFsPjL3zNbvr/tHO3krPovo5djgM?=
 =?us-ascii?Q?RNiKaLvzdi24JW8BCiFtVqC7H427iqEJxardvdMLUbIZSnL83LuImsmIXlnQ?=
 =?us-ascii?Q?huYg6dcljIuesjCxn/RdBvyxfOId2oPUnaR2Fjhd1ifAK6nQtrzfRa9UR+Y6?=
 =?us-ascii?Q?uwndkHBypLAWLR5PP7zcJBxxqjQdAggH4bwDCVij9U24OukDoz5lz3PXyWEE?=
 =?us-ascii?Q?NZRjJI2NI+i4PcTDZenjlHpUOR5CG/8cDSIHHUWIuKYToLeRHoTvkFdueK/s?=
 =?us-ascii?Q?+M5jjjQzgQsqMRbe92+cSjUYtUabuIoOaol6/yswBrR3XVbnJR/+PNApdval?=
 =?us-ascii?Q?Shh1j/3e8hwBa2fISo/Eb6fMBFIWXa4auYKlXn3fprBbFUXbyfrIEnEx1s06?=
 =?us-ascii?Q?DC+TFR/6NL05H9XAhPcRgje+b61dvanokWjFz4fcMT1kCTyOD4r/9VVwIsrq?=
 =?us-ascii?Q?K8kQtGFLI7WtsjEhW9n08rSNsGsQrBZHdn+TiSRV86sqEbgPkl1tQckx/ZiI?=
 =?us-ascii?Q?FJFK784SEMPz2xh7o/Bsxze+L0aSJ661usS6ghSUbGUF/THsr+n5TAfzHkd5?=
 =?us-ascii?Q?QV/RotP4WmqrX2gZW6ZN8/eFHAKyECumWhJNgtU5vodzAFv/PPaPQmc+J6Tm?=
 =?us-ascii?Q?lYfuLbR77p8woS5C5kdLSsFRtshOunMHoYNH3xxKaKDUQcynDfgmjQLnabA2?=
 =?us-ascii?Q?djoJIQVRSzzKIMn8A6/8qY9YbgjXYnSaRt5UML2fHoHZs3/GJf/J/nky6GGI?=
 =?us-ascii?Q?yqTDzTl5NIBYAB8kcrt/c52lg2GJ6t8urMWPo3hF/UVdJSbI0MEzCx08f+vG?=
 =?us-ascii?Q?lVUN60QKJ33sjAoFcREiwHuTvil5qoG1ak3Yzxa3+6QLMhDOxm1nJ70Qm+v3?=
 =?us-ascii?Q?wHrl2LaChSb+8FZ7ci0T6RRHtxSatli02Rc+5oK/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce18d2-b1b2-4ea5-4fd8-08ddc3b73cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 15:49:52.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXPpS/66Rj/i1xsP/zIGR93JoCQTstAEsBk2+BGnN1WEfpGa0J7HaJuMqkEDjRxXNgdEJ2BAkrEiX64Lvjsn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB3037



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, July 14, 2025 9:29 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; edumazet@google.com=
;
> pabeni@redhat.com; stephen@networkplumber.org; davem@davemloft.net; linux=
-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net] hv_netvsc: Switch VF namespace in
> netvsc_open instead
>=20
> On Fri, 11 Jul 2025 13:57:10 -0700 Haiyang Zhang wrote:
> > The existing code move the VF NIC to new namespace when NETDEV_REGISTER
> is
> > received on netvsc NIC. During deletion of the namespace,
> > default_device_exit_batch() >> default_device_exit_net() is called. Whe=
n
> > netvsc NIC is moved back and registered to the default namespace, it
> > automatically brings VF NIC back to the default namespace. This will
> cause
> > the default_device_exit_net() >> for_each_netdev_safe loop unable to
> detect
> > the list end, and hit NULL ptr:
>=20
> Are you saying that when netns is dismantled both devices are listed
> for moving back to default, but the netvsc_event_set_vf_ns() logic
> tries to undo the move / move the VF before the netns dismantle loop
> got to it?

netvsc_event_set_vf_ns() moves the VF to default ns before the netns=20
dismantle loop got to it, and causes the Null prt error.

> This needs a better fix, moving on open is way too hacky.
> Perhaps we should start with reverting 4c262801ea60 and then trying
> to implement it in a more robust way?

This patch reverts the 4c262801ea60, and moves the logic to netvsc_open().

I was thinking some other ways too... But seems I couldn't find a way
to know it's in the for_each_netdev_safe loop, and to skip moving the=20
VF in netvsc_event_set_vf_ns() this case.

Thanks,
- Haiyang



