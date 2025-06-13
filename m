Return-Path: <linux-hyperv+bounces-5910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37680AD936F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2243E18815C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CB22330F;
	Fri, 13 Jun 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KiwF4eBV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022086.outbound.protection.outlook.com [40.93.200.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BE1FE444;
	Fri, 13 Jun 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834249; cv=fail; b=tNgwKqbSeV4jzyT9S11LMSKM+ZDA/cntQV6iOGGDVhGcWQyuzxbWC9H3lPhi7eGero9M+SzoB3etqemfQb+4A4TlJ/K7mQ+KbtsDGl59xke0N5txoZdOHuHeKWVB0Fy54lIw3n8Cjq/lonxURk5ve+3WUUX6fAPhEXH9J70LtOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834249; c=relaxed/simple;
	bh=8Gng6ulvyn5rmgbnqER3lv/QMtDUauvtAw7Cn6aAaMY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYMGptZk1hKsXgN+75BYcRng9V8hN77IJn/W6iK0uIHFhcRtZZxHdYcIGLFcLd1jhwULYWOsdazEP5xGHYjhuQNGivBEf+v5Tdx65xmNH82FqVd9cnhV6mIl7ZCexl96wEJP4/T+SsQ3g2QnJK0UO8foSo+NbQFJB01k4S/fha4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KiwF4eBV; arc=fail smtp.client-ip=40.93.200.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKnTyJi+x3TagF9/w2mUjLYy0+xaRxf4N9e+gViiGS8P5HYKecrQ6r/O/2SKWbRs2cRtdh2ITn40cxKbJjaFO/W078qW47Kl+FSRn4jdtCuTnapO3DRAmtHRDXLctaKkx+5sQRKcQFSmRevVFz89ONDXkgBNWYpkHZncBG8LtWxH1QKe7H9QiUoDrJE+QCUPKvlR8O3/Ssl5frzGyujm2KwWmSKZGbx9ZG9fqEK5O6Y57MSKAZk5GiyelNeyuWs/krBi08+lj2KQpPEpr64YfGZwxu+yywFgPiTOPWzjsvd759fh6lYIC5nZFVi20GGhBQpd+lu2tY0E0b1x9cc95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4n7dm3WtcqdeLhOaJaph9t/cI/LDbWUBdXvWxWQKI4=;
 b=Pcve59CRaL6i9kbwTW1IczQI8leUlEhI0tUE1QTL5vUIieqDuTn4MzaSXNBEuO4PxGwj5hgu2Nsw3jv2sxxAehtAqm/qAy9nFKUVZUnR9kTdugEz9cymBOMqfAp6IUeTq86shGJzV4o3WH82VevCv85dN6vBr28ep0Q3XU8IvWYC/3929A1JD8NYPfA6cndXSlStPfBfRJzchzOVFBFBh0gZAHEbl71dOM3hjWgt3bmF7cDCYD/WK2+1IP621t4gYluOUO6CE6WM3x9/mzpl7YqnyqzgbyClLRpwAAL4jftDgmvkp/JQvuvGMj8//FJgR6LvxWZ8e+O0nQVo1xkjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4n7dm3WtcqdeLhOaJaph9t/cI/LDbWUBdXvWxWQKI4=;
 b=KiwF4eBVB8vZ+/LUsrspA8Ixhzryc/I6xVG6lGT6Z5nVHAWJfomLQyuHQNv3dT+4H6v/2QsaDMC86yfMwh/tV3oPEQRMmRNbf7A1QS1MjQZhaTvFZKWsMs3GELYRajPwpKdkEAdXWa3sSN0aCT1FoySUXvcRklod/0Um7cpOd/Q=
Received: from DS7PR21MB3102.namprd21.prod.outlook.com (2603:10b6:8:76::17) by
 DS7PR21MB3646.namprd21.prod.outlook.com (2603:10b6:8:91::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.26; Fri, 13 Jun 2025 17:04:03 +0000
Received: from DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f]) by DS7PR21MB3102.namprd21.prod.outlook.com
 ([fe80::b029:2ac5:d92c:504f%3]) with mapi id 15.20.8857.013; Fri, 13 Jun 2025
 17:04:03 +0000
From: Long Li <longli@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "gerhard@engleder-embedded.com"
	<gerhard@engleder-embedded.com>, "rosenp@gmail.com" <rosenp@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/4] net: mana: Add support for net_shaper_ops
Thread-Topic: [PATCH net-next v2 2/4] net: mana: Add support for
 net_shaper_ops
Thread-Index: AQHb3FUyowyZ4ZN6qUu5dDxZoGsqa7QBUYUQ
Date: Fri, 13 Jun 2025 17:04:03 +0000
Message-ID:
 <DS7PR21MB3102B97C4255CD9417983F7ECE77A@DS7PR21MB3102.namprd21.prod.outlook.com>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
 <1749813627-8377-3-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1749813627-8377-3-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1874098f-e946-4dd2-a359-daa131598f1a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-13T17:03:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3102:EE_|DS7PR21MB3646:EE_
x-ms-office365-filtering-correlation-id: 5ebc6e79-bda9-427d-56f6-08ddaa9c4c84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wiL1E6xehtlVEMqMNOE2InkESLddEQ2xeu6NT52+8DnOUujtoCEaO0pUpUYb?=
 =?us-ascii?Q?oX34Fqk0X5FT9LaiNlnGAjhtNjXygNqpSm3SklgSSTfxDvZNhJ8B68WTVGW/?=
 =?us-ascii?Q?EMK3E/8jWUtarSd33qGvhpKwPWeh6foK3Nhyn8vfwtU+UqbDOCtrGVX0rI9R?=
 =?us-ascii?Q?vLkOAX1q8tHjfwbGGj0v5LqBj9bARo91DvQkcGYZP9Lx9sMIp/oHPBLCGLdq?=
 =?us-ascii?Q?bJpFd28WixaleSqahw17dS/4TvS0aodz4UjTT5j8jU1DfjLHi0SB5Sq1Xq/b?=
 =?us-ascii?Q?PUICHjatu5bH5xlQsXgW+6iLLZCI4UFf5t2Chj3cpieWRkDad14eGsUiI55i?=
 =?us-ascii?Q?8WGmm7YD1ThlpdWsnk9gc9pUZ2kk5uyRnzTQkgJN76oqywyIzitS6a3b6m2p?=
 =?us-ascii?Q?uT48ri1F/9HxuZiMdnX4UE8pcUsjGM48YKAK7tGR5MX85lWEfsO7nIbjTR+2?=
 =?us-ascii?Q?ZBwy0iEYr1gZwE7lQa+hC1FGVcP1ubLoqQDrvUr33gI8JFVOpu3Rn16t2mTh?=
 =?us-ascii?Q?g3VEJJGnCGzkFRQTq7fYWy4U/dIsllfHBmpOJGPV0dnXnziHUZeJVJODRGGt?=
 =?us-ascii?Q?q1D5N/9hCrmYyavl6UaalZ2uOCtYzzgXo8ARo767GSnN0mJFuqKJPViD1cSq?=
 =?us-ascii?Q?AVhO8wz/Ol7jMjinyrFEvFjfe7YuimbF5tuE0MuW3EK+HokETtI7J6I/vgen?=
 =?us-ascii?Q?v132GO0UMHJwbkHcF7vuIlCaA2uszoWQmUGPwmvcEWl0LmyRHA8h+ci17A0r?=
 =?us-ascii?Q?yhE6oYm14Xb/akUFBVQmg9VmbtO0QjK1GDvJ70TOfyOnJnh1CYZxcFkKWs/a?=
 =?us-ascii?Q?PMa5kC10n1R0krv2fpzM8/9UF60s8YWgenOa3AstXXAa7yDYlBRhLS12/nFn?=
 =?us-ascii?Q?6zcsJvcbQHmazGvjtbdr7XJ9MTbR5kzpmwofDqN/ZqpkjgeEENS1Lysl2doz?=
 =?us-ascii?Q?UBLPYkxfHR1+8P0Z6jkSOyCeh53PVuFWH3sWnedMC9ne/JWtNKH1HQrgFUl3?=
 =?us-ascii?Q?WQr6/R6IsYiVOqtx3eiHKhVKtymWhekgj407gtwQmGIa3do1q3zZOa03bEQ/?=
 =?us-ascii?Q?lvM7NkoEV9ni0IuimWO8Q4a4A4Wmx/Lp9BktJ/0HZ0D32q+IekC04c3HtM27?=
 =?us-ascii?Q?UTDNP7H4ghHnie+OoBox3+wMg1N66yR/GOYioKVHhQqGCrikMxDhbX3JIQJq?=
 =?us-ascii?Q?s04l41ImRR2LZ7VVmxvXw/5kesCqbm9g3jvr/xzy3gHGiCPARV2GjRKobYWZ?=
 =?us-ascii?Q?5vCN9s4BQrb5FNybBMmdSVDoo5rXY0eVUVANm6xr7DE5a8h5E1iSys6h0FPk?=
 =?us-ascii?Q?62le/hU3mMCplpiIigV6sSBcaVL8xjhx72ygHwOPWgEuH9zOrAMW7wS2zbXB?=
 =?us-ascii?Q?+OMncGHVYWcd0oIfQKkTaL4XKpVHpFncUGrndz/gbzy3jqxc60opOCpvrdOv?=
 =?us-ascii?Q?i9qL/s1e8r/Cfn4VLhyuNpvLPQmhVoxDUmxeQtvnZutGVev10fIOKktSI58W?=
 =?us-ascii?Q?Q+/EcnHnIV4ORdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3102.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QHgjl04c/FLCH5/A8Aelosrxopmf58EOz2wvlttgENMB+Gem8t+L3TIYhK+1?=
 =?us-ascii?Q?GGPF4jMOo1NSFhf0HnlrDMZTi49KsjD8bKHZIVBpCLQE5MLERkcYCfWvv5Sa?=
 =?us-ascii?Q?Z7RXUU4ldciiWyGXxuCPl2QuW/QAxl1Ht/5aR4AHC2uvbkb2wCkP1HqAuVmo?=
 =?us-ascii?Q?xazADKzuhLZu4tBRk9+izZdtdb+sODFYxj0Lj4NdBRx7b9ffjCpkhSODoypN?=
 =?us-ascii?Q?YZkoL2QHWkeCE3S+FnuNdpFBRpeI7w0oYDVCF7cIkBM24wsDEjGzTTLN/Ww5?=
 =?us-ascii?Q?VmSIUCcbQ4a8brf7o2rCr3CgjjGOwi/OYewWGondsvOzwZCZou8BH8/ZYQ0d?=
 =?us-ascii?Q?MKa7OJ8XBrkDDAMnVnka4clVkXeOP+0foSg/elMlRxKE4ARZQAwpGhXRqQxQ?=
 =?us-ascii?Q?7ufDi4/XqKZT2xJuM7BUQGfu6Ij0/mWSZvkH7zuzT00577Ekqld608hdF2U+?=
 =?us-ascii?Q?Ok8hXViHS9M3IdRlkWZ4W+6c0umCBbQ6Qq48faAMrEjjC7arV1asrUV76buq?=
 =?us-ascii?Q?BuK/kdrJtVu2lByLa6fKiWxUEQH1PsyCyQ5O+jyQSxlQwIEF7QSFL4HYA3I1?=
 =?us-ascii?Q?w2WWri0lFSaucrd1qMVoVQu+HLDNRFdKVl8J02GZoqPSZ6gPVQoFZFjjyTB2?=
 =?us-ascii?Q?OGcmiwyZpuM6EMpylqjR2jwQMUQNeLkjuKJCDMiiTZZ3W3e8MonHGXn/KfSn?=
 =?us-ascii?Q?E2LceZuiGMhp2X9UJ9UuXS4t5a/q3QouO9p6hXi6Dpr7NpSiDEl4YsDRFTOj?=
 =?us-ascii?Q?P36C9RnEqdyD+hSN71YIxtbu5MqYLeXDBjhsCSB+7C5IDSDvyocZTQykw5IO?=
 =?us-ascii?Q?wXvfRvs5ibty+87dlFpD+nx/o12rA63Q+75Z9xukVlkUD+L/uKBw60d+NezW?=
 =?us-ascii?Q?DVpyMq1A1/UkYgvj9w+4vU+W20I6vyJ5P8YPMBSSXNnPa3a0MfadFDzBLPPE?=
 =?us-ascii?Q?SS01ArFjydCzfTaPB8JOGMlsBjIXI3U6zix/mO8+rgoTzhh3GXCyJmb2oGxU?=
 =?us-ascii?Q?dOhL2X+JKlCmkEj91OU1mPvcldriRj96sLNMKbuyT8cWjBQUAP2NEY1r1jcH?=
 =?us-ascii?Q?hi6TEu/vBb8/96pFf8fSEKjCO7hcaF6I95uMTqje7mupqqj+JjafFrsNoOfu?=
 =?us-ascii?Q?qoRLxvYo/hF2Eft5Op/0nBCG8TBG6/IwE5+fNK3liViUD8QvRFx9kFNCezhL?=
 =?us-ascii?Q?QOSwPMz0gvPZf+/iLHEioIEpnOKGSHqPTf2C3q8kYiUpeAAFN3nir0APY9HT?=
 =?us-ascii?Q?UN7yvjBKhxIvnjTyxAdtJMCsx7okS/YIxr3owF3LPO1iRF/elxDksV3RAHJ7?=
 =?us-ascii?Q?Vm5a6q1nQYdKkNyj6+BQSnP9unG7IAEukADoCFEQKtgdPl2S5wcKS5BiyYnv?=
 =?us-ascii?Q?XO4uzdSiYo7Gy2NZL1eqk9xLC8nZVZOFJM9knBd//e9bKQFcMrRYMFgbfh2k?=
 =?us-ascii?Q?JRiI3fYWerIhh7AtoQR7RvZx5V93/IUhWNpfNyrUKLZa99gm8iVKblZGNGWH?=
 =?us-ascii?Q?slwQLMQUQWLfCjIKpaNplQWZj9vsoogJOWxn5QAL1ixc+5FmD63eGuPWO2o3?=
 =?us-ascii?Q?acbPso/FZn+9W0tvhMR8gHCs3dy9lxWdJu8sdexK?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3102.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc6e79-bda9-427d-56f6-08ddaa9c4c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 17:04:03.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q586ipA3V6KD8uubCDX/G6ceatC9lK7n7rHNjjqN2kY3Qf7jztOUbxns40sHY2YnPzcE+BhRI/NYLfP5kfDB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3646

> Subject: [PATCH net-next v2 2/4] net: mana: Add support for net_shaper_op=
s
>=20
> Introduce support for net_shaper_ops in the MANA driver, enabling configu=
ration
> of rate limiting on the MANA NIC.
>=20
> To apply rate limiting, the driver issues a HWC command via
> mana_set_bw_clamp() and updates the corresponding shaper object in the
> net_shaper cache. If an error occurs during this process, the driver rest=
ores the
> previous speed by querying the current link configuration using
> mana_query_link_cfg().
>=20
> The minimum supported bandwidth is 100 Mbps, and only values that are exa=
ct
> multiples of 100 Mbps are allowed. Any other values are rejected.
>=20
> To remove a shaper, the driver resets the bandwidth to the maximum suppor=
ted
> by the SKU using mana_set_bw_clamp() and clears the associated cache entr=
y. If
> an error occurs during this process, the shaper details are retained.
>=20
> On the hardware that does not support these APIs, the net-shaper calls to=
 set
> speed would fail.
>=20
> Set the speed:
> ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/net_shaper.yaml \  --do set --json
> '{"ifindex":'$IFINDEX',
> 		   "handle":{"scope": "netdev", "id":'$ID' },
> 		   "bw-max": 200000000 }'
>=20
> Get the shaper details:
> ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/net_shaper.yaml \  --do get --json
> '{"ifindex":'$IFINDEX',
> 		      "handle":{"scope": "netdev", "id":'$ID' }}'
>=20
> > {'bw-max': 200000000,
> > 'handle': {'scope': 'netdev'},
> > 'ifindex': $IFINDEX,
> > 'metric': 'bps'}
>=20
> Delete the shaper object:
> ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/net_shaper.yaml \  --do delete --json
> '{"ifindex":'$IFINDEX',
> 		      "handle":{"scope": "netdev","id":'$ID' }}'
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes in v2:
> * No change.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 155 ++++++++++++++++++
>  include/net/mana/mana.h                       |  40 +++++
>  2 files changed, 195 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ca5e9c3d374b..7e8bc2c6a194 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -719,6 +719,78 @@ static int mana_change_mtu(struct net_device *ndev,
> int new_mtu)
>  	return err;
>  }
>=20
> +static int mana_shaper_set(struct net_shaper_binding *binding,
> +			   const struct net_shaper *shaper,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(binding->netdev);
> +	u32 old_speed, rate;
> +	int err;
> +
> +	if (shaper->handle.scope !=3D NET_SHAPER_SCOPE_NETDEV) {
> +		NL_SET_ERR_MSG_MOD(extack, "net shaper scope should be
> netdev");
> +		return -EINVAL;
> +	}
> +
> +	if (apc->handle.id && shaper->handle.id !=3D apc->handle.id) {
> +		NL_SET_ERR_MSG_MOD(extack, "Cannot create multiple
> shapers");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!shaper->bw_max || (shaper->bw_max % 100000000)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Please use multiples of
> 100Mbps for bandwidth");
> +		return -EINVAL;
> +	}
> +
> +	rate =3D div_u64(shaper->bw_max, 1000); /* Convert bps to Kbps */
> +	rate =3D div_u64(rate, 1000);	      /* Convert Kbps to Mbps */
> +
> +	/* Get current speed */
> +	err =3D mana_query_link_cfg(apc);
> +	old_speed =3D (err) ? SPEED_UNKNOWN : apc->speed;
> +
> +	if (!err) {
> +		err =3D mana_set_bw_clamp(apc, rate, TRI_STATE_TRUE);
> +		apc->speed =3D (err) ? old_speed : rate;
> +		apc->handle =3D (err) ? apc->handle : shaper->handle;
> +	}
> +
> +	return err;
> +}
> +
> +static int mana_shaper_del(struct net_shaper_binding *binding,
> +			   const struct net_shaper_handle *handle,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct mana_port_context *apc =3D netdev_priv(binding->netdev);
> +	int err;
> +
> +	err =3D mana_set_bw_clamp(apc, 0, TRI_STATE_FALSE);
> +
> +	if (!err) {
> +		/* Reset mana port context parameters */
> +		apc->handle.id =3D 0;
> +		apc->handle.scope =3D NET_SHAPER_SCOPE_UNSPEC;
> +		apc->speed =3D 0;
> +	}
> +
> +	return err;
> +}
> +
> +static void mana_shaper_cap(struct net_shaper_binding *binding,
> +			    enum net_shaper_scope scope,
> +			    unsigned long *flags)
> +{
> +	*flags =3D BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MAX) |
> +		 BIT(NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS);
> +}
> +
> +static const struct net_shaper_ops mana_shaper_ops =3D {
> +	.set =3D mana_shaper_set,
> +	.delete =3D mana_shaper_del,
> +	.capabilities =3D mana_shaper_cap,
> +};
> +
>  static const struct net_device_ops mana_devops =3D {
>  	.ndo_open		=3D mana_open,
>  	.ndo_stop		=3D mana_close,
> @@ -729,6 +801,7 @@ static const struct net_device_ops mana_devops =3D {
>  	.ndo_bpf		=3D mana_bpf,
>  	.ndo_xdp_xmit		=3D mana_xdp_xmit,
>  	.ndo_change_mtu		=3D mana_change_mtu,
> +	.net_shaper_ops         =3D &mana_shaper_ops,
>  };
>=20
>  static void mana_cleanup_port_context(struct mana_port_context *apc) @@ =
-
> 1162,6 +1235,86 @@ static int mana_cfg_vport_steering(struct
> mana_port_context *apc,
>  	return err;
>  }
>=20
> +int mana_query_link_cfg(struct mana_port_context *apc) {
> +	struct net_device *ndev =3D apc->ndev;
> +	struct mana_query_link_config_resp resp =3D {};
> +	struct mana_query_link_config_req req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
> +			     sizeof(req), sizeof(resp));
> +
> +	req.vport =3D apc->port_handle;
> +	req.hdr.resp.msg_version =3D GDMA_MESSAGE_V2;
> +
> +	err =3D mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +
> +	if (err) {
> +		netdev_err(ndev, "Failed to query link config: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
> +				   sizeof(resp));
> +
> +	if (err || resp.hdr.status) {
> +		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
> +			   resp.hdr.status);
> +		if (!err)
> +			err =3D -EOPNOTSUPP;
> +		return err;
> +	}
> +
> +	if (resp.qos_unconfigured) {
> +		err =3D -EINVAL;
> +		return err;
> +	}
> +	apc->speed =3D resp.link_speed_mbps;
> +	return 0;
> +}
> +
> +int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
> +		      int enable_clamping)
> +{
> +	struct mana_set_bw_clamp_resp resp =3D {};
> +	struct mana_set_bw_clamp_req req =3D {};
> +	struct net_device *ndev =3D apc->ndev;
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_SET_BW_CLAMP,
> +			     sizeof(req), sizeof(resp));
> +	req.vport =3D apc->port_handle;
> +	req.link_speed_mbps =3D speed;
> +	req.enable_clamping =3D enable_clamping;
> +
> +	err =3D mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +
> +	if (err) {
> +		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u,
> err =3D %d",
> +			   speed, err);
> +		return err;
> +	}
> +
> +	err =3D mana_verify_resp_hdr(&resp.hdr, MANA_SET_BW_CLAMP,
> +				   sizeof(resp));
> +
> +	if (err || resp.hdr.status) {
> +		netdev_err(ndev, "Failed to set bandwidth clamp: %d, 0x%x\n",
> err,
> +			   resp.hdr.status);
> +		if (!err)
> +			err =3D -EOPNOTSUPP;
> +		return err;
> +	}
> +
> +	if (resp.qos_unconfigured)
> +		netdev_info(ndev, "QoS is unconfigured\n");
> +
> +	return 0;
> +}
> +
>  int mana_create_wq_obj(struct mana_port_context *apc,
>  		       mana_handle_t vport,
>  		       u32 wq_type, struct mana_obj_spec *wq_spec, @@ -3013,6
> +3166,8 @@ static int mana_probe_port(struct mana_context *ac, int port_i=
dx,
>  		goto free_indir;
>  	}
>=20
> +	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,
> +&apc->speed);
> +
>  	return 0;
>=20
>  free_indir:
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> 4176edf1be71..038b18340e51 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -5,6 +5,7 @@
>  #define _MANA_H
>=20
>  #include <net/xdp.h>
> +#include <net/net_shaper.h>
>=20
>  #include "gdma.h"
>  #include "hw_channel.h"
> @@ -526,7 +527,12 @@ struct mana_port_context {
>  	struct mutex vport_mutex;
>  	int vport_use_count;
>=20
> +	/* Net shaper handle*/
> +	struct net_shaper_handle handle;
> +
>  	u16 port_idx;
> +	/* Currently configured speed (mbps) */
> +	u32 speed;
>=20
>  	bool port_is_up;
>  	bool port_st_save; /* Saved port state */ @@ -562,6 +568,9 @@ struct
> bpf_prog *mana_xdp_get(struct mana_port_context *apc);  void
> mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);  i=
nt
> mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);  void
> mana_query_gf_stats(struct mana_port_context *apc);
> +int mana_query_link_cfg(struct mana_port_context *apc); int
> +mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
> +		      int enable_clamping);
>  void mana_query_phy_stats(struct mana_port_context *apc);  int
> mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int
> num_queues);  void mana_pre_dealloc_rxbufs(struct mana_port_context *apc)=
;
> @@ -589,6 +598,8 @@ enum mana_command_code {
>  	MANA_FENCE_RQ		=3D 0x20006,
>  	MANA_CONFIG_VPORT_RX	=3D 0x20007,
>  	MANA_QUERY_VPORT_CONFIG	=3D 0x20008,
> +	MANA_QUERY_LINK_CONFIG	=3D 0x2000A,
> +	MANA_SET_BW_CLAMP	=3D 0x2000B,
>  	MANA_QUERY_PHY_STAT     =3D 0x2000c,
>=20
>  	/* Privileged commands for the PF mode */ @@ -598,6 +609,35 @@
> enum mana_command_code {
>  	MANA_DEREGISTER_HW_PORT	=3D 0x28004,
>  };
>=20
> +/* Query Link Configuration*/
> +struct mana_query_link_config_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t vport;
> +}; /* HW DATA */
> +
> +struct mana_query_link_config_resp {
> +	struct gdma_resp_hdr hdr;
> +	u32 qos_speed_mbps;
> +	u8 qos_unconfigured;
> +	u8 reserved1[3];
> +	u32 link_speed_mbps;
> +	u8 reserved2[4];
> +}; /* HW DATA */
> +
> +/* Set Bandwidth Clamp*/
> +struct mana_set_bw_clamp_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t vport;
> +	enum TRI_STATE enable_clamping;
> +	u32 link_speed_mbps;
> +}; /* HW DATA */
> +
> +struct mana_set_bw_clamp_resp {
> +	struct gdma_resp_hdr hdr;
> +	u8 qos_unconfigured;
> +	u8 reserved[7];
> +}; /* HW DATA */
> +
>  /* Query Device Configuration */
>  struct mana_query_device_cfg_req {
>  	struct gdma_req_hdr hdr;
> --
> 2.34.1


