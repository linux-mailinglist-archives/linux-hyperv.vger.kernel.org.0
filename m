Return-Path: <linux-hyperv+bounces-3753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA641A19DE7
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C863A60F5
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F711537B9;
	Thu, 23 Jan 2025 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZL1gHOuZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2109.outbound.protection.outlook.com [40.107.236.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C713596B;
	Thu, 23 Jan 2025 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609427; cv=fail; b=fKqGWVXZ0ihAIbxkw6qNYLiuu8dc5e+3saQzdQ58OXKkFO0qpwWsIVw0XKguT/gH7M3Cm0JFTiXqwv3UTySAyyckVu/ifmNNxAxQgnclDKC6RatT48aCvlFItjdV5fpUJKBpNLSjDGrgqQUAdojQfR7Z9KHDDiN51yWp8PuasOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609427; c=relaxed/simple;
	bh=t1CBnBPnY1GhM6/WUXzHUa/DVrai9mHfRjCbGYm63n0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/P8F4PfVLxVHHIvWvD3s+f2uC5GxHFmhNsGT1dj0N2wEnJW3XP0P5qsmRSgvc8efqOtaCoFC+qUHll0V920/YH+eVhQ7326tQBfYNKgY4tVpRB9/M573rLsraEzDlA1rjYuREeHx6H8CHPxBiNuu8EkoeDbuvM98PK8cG64YOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ZL1gHOuZ; arc=fail smtp.client-ip=40.107.236.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFn7LJ/slHtK1AqUgYBYNCCh37MZWMsda+mNCpV6ZEWt+HTrgpIOQVrW+bd0ueEmb833sjpCqPJJUus7YC7aCmPhcebO3sA63WoFrO5tAymX3B81XtDUNPQbn0IEnZKgkitzjCzIiNzt8pP+eIvr2ddMus+hPIqya8EkJEvleR0If+/cIIjVgYYUfA7qGzhGinZKD+BmxRqVGzbUm721jC6gDegkGJfSskAgB9KCZ3YaWYhlEhjCg/besz2ix+9+FOqTmp7xSqt6QOvXtA7Vc6X3+LZ2k/fpWr6Q0Sg2X6PKsOhg6XekNhf0QPCBy0PBbrXh3XJXwCa0BKl8kd2y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHBQTUhQEYX6uADhDEbpkAJc0d33lYyfXz5x7WTOOaA=;
 b=Obk3j9Edy0zko5lfF6PfB/TFxZ6m/OcWt3+vkuax0JyU+7nBDjCQb4NFo0qU32XBymxsR9gBdihukA45JpMvCIWxxzidWY1lcqn8XThWCUc0wF/0fdhN4LECug8doFSmAwh2D8f9EHa9oxxmpIb6qNNmpTAvyqY1b7qqh8kBIvkvv7SEQawfwOHOYeGuTgnD2KFFTI83A+BoIICQQHyNSk+oC94bo3ytmJXBhtfjcVgAdgS9jDNPSg9JKWirrOOg0oYHo/tSGbgWjSq3Prbdj9cB0v44JtY/xgDvN0Ke5vHgszR99GNNWUzg76jMTfC0HdqUuwXYROaHFreGsfPO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHBQTUhQEYX6uADhDEbpkAJc0d33lYyfXz5x7WTOOaA=;
 b=ZL1gHOuZP0mATww7HHAufibSZBBmAkbHkBvI0TwDclP7upXjPqAmY+zDHaLtYRHX8kimUuJV54GIYtGeEIhvCVzg6g3Xq2IpEuXPAbT+uDnD9CZlRqQoRbQfWpk41C1F7ZuwPkjye+Q7CdzixNmAZQfcj7Yvkw9Q3sfZw+hWLmY=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4302.namprd21.prod.outlook.com (2603:10b6:806:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 05:17:02 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:17:02 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 01/13] RDMA/mana_ib: Allow registration of
 DMA-mapped memory in PDs
Thread-Topic: [PATCH rdma-next 01/13] RDMA/mana_ib: Allow registration of
 DMA-mapped memory in PDs
Thread-Index: AQHba2CVaMl2TmeRG0O5ev1nFYViF7Mj1TfA
Date: Thu, 23 Jan 2025 05:17:01 +0000
Message-ID:
 <SA6PR21MB4231B2C714A7944F39BD464ECEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d60f2d3-cc08-4f5d-9ee5-c33eaccff85b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:16:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4302:EE_
x-ms-office365-filtering-correlation-id: 9e5cf17e-9100-482b-f836-08dd3b6d2b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1pmVHKwGTMl1ez3hYHwUmBNat56PWMC/Q4sCsL7mCtx4w3CtTPGyMCymaAwL?=
 =?us-ascii?Q?rx/5eHESbZWnClUQ50bzA4a/4IvDvpHTlky5wkXIzNcfOnWqZJzYuKgLesKe?=
 =?us-ascii?Q?i7dNPYQ/wzQI8A47JxfGKnGzsJJo5NN8GN9kgoqxKbNu1AISNl/N7dHYuumr?=
 =?us-ascii?Q?wT1m/x79XSJXoItdapiuFfdWo3a45AdT+9Ftph+salbAAdCA+46zNhZCJVSS?=
 =?us-ascii?Q?ruiTzUzRw/biZHUNkTjZ5GAJjezgbvaVv/wWeAqDVwOLlMRSy9la0LH4YDkx?=
 =?us-ascii?Q?tSssGWdT5KDl76Gkeh2ffgnO0aaNDjN6RowBpI4tQK6GHm2nJm1TcCrAdIIh?=
 =?us-ascii?Q?mvEdPz3YVmbdzCpqeZNQo9dnon7NQDV1nma643khyjsGrnvhhUdx5hpLVWHz?=
 =?us-ascii?Q?tlvH0bqjuRLnDO5SSwJXHVRsuRU/B3VFuqAILrIF+sxQIBX6xZBzqoJL8hkB?=
 =?us-ascii?Q?E30/udPdFr0tUVcgwjDothTHlfPT920lcLNYG6SlCBRUGIDupAd8nNn5QCo7?=
 =?us-ascii?Q?XP89+Rv0X4blPqvjGxAb5euAwkgs8zhtHgPUuyj0YJYKdcnPc+nMjuMpfxrL?=
 =?us-ascii?Q?+JlZgECq+0IqxglyQZ1VsRZEQfBqUim1OfPU1jmP5dkFQOJdrvmAOvOCiQT6?=
 =?us-ascii?Q?pnXJd90wsex93CZ+Ail0WMCgIyrSJuqNI/C+wAJX2olyLCs669svB9z/5zla?=
 =?us-ascii?Q?a73q27Jy5hzxqSsv7S8NHP34ctSwv0K8felaDWgYOcsSMDTu3H4bFxGRv/pK?=
 =?us-ascii?Q?YlywSpDSsQkqgPjkw2W7ZB+YHdNCKqYwPubjTsWa79IQkiV1njoXEIngarX9?=
 =?us-ascii?Q?fh07GMpsDy/PpYr4RQPwAHKxUmWRFPSiwGTeLzpwa+2iIQE22Q+CJXW/gii9?=
 =?us-ascii?Q?il5gNUOih4UM1XVftS8GW1Qmg9vh1zQDn/8ktws5Vprusp0mAIgi4wCAlZc5?=
 =?us-ascii?Q?rGTcCM+BfH2xk+Nrd7/4ntoBRtTe9oPoDdMKKliMSgBY6K1pC/DLQnVmnLeK?=
 =?us-ascii?Q?4phXLo5h4bI1UVQIzIHu8e5IJvIkZWoEc6oE7fdRda1j/yOmTU/huw2+jBTO?=
 =?us-ascii?Q?igctoEOxB94GXS5GnKvK6n8a1qA/SlGAmvytu/7p4XAjghYLVJWZEGpfioci?=
 =?us-ascii?Q?iMN/+G0Gc2BR7g8r26LUmm/6EFOpG4krtfNA+CxD3VrejXGck9+dEMyeG4ki?=
 =?us-ascii?Q?/BHv+nQoRfJ2VOhHTL4GlXThw9QZYoHCCfIFCn5/K0wz5miCcJTb+vIme/QV?=
 =?us-ascii?Q?y0vyJP3beWAsCCObSq3Nevd7+h39G2P+JuIqOE8aA7GtVgbaJjdH/OaSAYFP?=
 =?us-ascii?Q?nxY4bjtuwtufj2ErbFlHnjkdeTzhYKGfNsQj/6BtVkKmMS94riXiU/4SyNYz?=
 =?us-ascii?Q?yYYQRmDNYD+eXP8s40GK9UbEj1r0+SMD9v0rDDVFo4deWcOnBG40LsBltx9x?=
 =?us-ascii?Q?C1sR3zSD7jAv9Xt1wq5FZj97GBK3CwGzJrxBucIxuxRJ9AOWO0agFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sNVjVtkQ2g/lXNvdA+F6JxEhj9BBTxXAgWDPH71qbFJ0cxUr1hJ2vNnXesEQ?=
 =?us-ascii?Q?GpETm098Hn/BqpFS8YNbynBvPdNrCft3RwidqjerOjm0DuPvrwbhm9WktSPO?=
 =?us-ascii?Q?kwUUPj/ZVTvajTXYPk0QLOHJ2dq/saT6QrtXqrkjTdcOrkZiAU3wqvHHITLr?=
 =?us-ascii?Q?AjAd0FY1sXZYBAMX+sOgQ4x36uRSjB14JlrveAXPY84kInRolDtifqwaWwTM?=
 =?us-ascii?Q?duvPc+oJ7y0cgqHcBSEm+uvWzdpY/9cwXbj7FBs6f62W6xXqTgcy9+kTiBrb?=
 =?us-ascii?Q?mhKkRRzpYP90GtT+yOAurN1VN3arW8DmZ43OfEX7kCWrOx3ugPX9n01VG6mQ?=
 =?us-ascii?Q?gmf9TTm1cU1GFTdUtQrD4lgYdkOCosq/ffB3xA25Al7UVpvDWViT1IVXsld5?=
 =?us-ascii?Q?OHN1JdKhNLGJAaqGqyDN8yw/i/Ivwq4VLZazOPGMO6e+78HSPeVrb2/8bSgX?=
 =?us-ascii?Q?ZofCVSMjOdxN0nZgEHXpMq5CLQjXzHvuMRZVGk5i7+vyXpFBkwm3VtbrKOzO?=
 =?us-ascii?Q?N3l1nxEysOqyeIKoXh7vwQKXUpjzhsX5uqmdEzJA9Y0Ex0+eG85gbhP27Iki?=
 =?us-ascii?Q?28C9OcanW0QTMUpl7NweYQq7bBskAfBbhRm4ycl6151qe+REkCSLiB23+Ep6?=
 =?us-ascii?Q?hiVxG/htqrFg0qCbeMBb+yZf9pgKgAsjU0vKErsNEnBCNAVAPNV1I3xZ1mNv?=
 =?us-ascii?Q?6IreLfDUEOmZ1DyE3ofBPmwpRweCXvw33bO8fOXgjEpgweHXGaxTkmenZfzV?=
 =?us-ascii?Q?to+4t00YPRjCslT9+ouNdPulmffB+mY4D+czhyeKEb9t/2NXbBvTF6qSdb59?=
 =?us-ascii?Q?RG8BLauAKBrGyro4IPfMUUaPKFH+626tL0m3bhQX/mae0nW0E1pkshwvkmX7?=
 =?us-ascii?Q?cDaCPcKT8KdRO/pPlr9VfcNMhTl6XbGyfvzCASZ1W+I6AMA8vhrw2nG8IGc4?=
 =?us-ascii?Q?015BdlY3qSaKj/+NCDv3r84YBif8Uwywj52X46B10X/J+F36KQKjv5TOgaWL?=
 =?us-ascii?Q?eP7qQqBdS5PtcnMATDS2Xl6Y8qvCwAb1gsmrSw6hDh5/iZSkIJ//LZhn6kSH?=
 =?us-ascii?Q?SHj5qAQmoCuyDJ2+ONNYPSV2BRyqzb9isjS/Q1eVg9lElaFCOUME1wCEFQ3s?=
 =?us-ascii?Q?I4j99AKqT6MogI5m38kTtNtP6mPLrYYiR6bT30yGSl5sFXysvvQzCWv5j2kz?=
 =?us-ascii?Q?wl7oOk1UJGHZzsfrgrQGmYgVL+Hre3Oq394XH2mEV4c1PdxMMpaaryzP3OPV?=
 =?us-ascii?Q?mJC/UhsOZn3gDPI6/24Dxk2wSJhcMbChX4fX1CLHMtfrT07jgG5/ij54Zpaf?=
 =?us-ascii?Q?R/61jOekckGEowSoDTUk7N1iZ0QiZ0tK0DbQE0jSMmnZZIKW9cFjf2Ucx999?=
 =?us-ascii?Q?EOb4XOJADAMNGPAZ8CXhlDs3G/i9iUWnzo2/FsOFY4aO0CTfSg7PyNTPD+td?=
 =?us-ascii?Q?1E6D2wTZzlotpkl5EuYW3ExK1E9VzvsQbp33ZJ9UDfDyhCnuDvXTQEaYQ4UF?=
 =?us-ascii?Q?FmMqj4M5bJjbLD8cZOFMyHeMuep34H1qAGKjWmZrpPTnorMV34co6FQHYwDt?=
 =?us-ascii?Q?XN2Ub7cR5sQalOXeO1A/lJNvsMwAoUCTAZXwUV2p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5cf17e-9100-482b-f836-08dd3b6d2b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:17:01.9572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGP2C1g8Uau214sqlPh09XYoWsBdkc3wMNzyYafeff0wQaQWDM9WcAbfwhT5KhEIb749H/EP2JOnGUu5uZcmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4302

> Subject: [PATCH rdma-next 01/13] RDMA/mana_ib: Allow registration of DMA-
> mapped memory in PDs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Allow the HW to register DMA-mapped memory for kernel-level PDs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c | 3 +++
>  include/net/mana/gdma.h           | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 67c2d43..45b251b 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -82,6 +82,9 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udat=
a
> *udata)
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
>  			     sizeof(resp));
>=20
> +	if (!udata)
> +		flags |=3D GDMA_PD_FLAG_ALLOW_GPA_MR;
> +
>  	req.flags =3D flags;
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req,
>  				   sizeof(resp), &resp);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 90f5665..03e1b25 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -775,6 +775,7 @@ struct gdma_destroy_dma_region_req {
>=20
>  enum gdma_pd_flags {
>  	GDMA_PD_FLAG_INVALID =3D 0,
> +	GDMA_PD_FLAG_ALLOW_GPA_MR =3D 1,
>  };
>=20
>  struct gdma_create_pd_req {
> --
> 2.43.0


