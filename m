Return-Path: <linux-hyperv+bounces-3391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5A9E2AEC
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA62166C8F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442641FC7E4;
	Tue,  3 Dec 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JvCxKZSE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022107.outbound.protection.outlook.com [40.107.200.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33A1E009B;
	Tue,  3 Dec 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250748; cv=fail; b=pYFhRfJZGeEY4QtQFnSXtQnqehPdqqT77J3hrM2UAmDLF3Jx9L8MZu+tNsisTEaBd0uYwZO2+ruO65B0mApDmw3RxkaGGJo0kPZvH7a1ds4wE9pWZip1LkUkBuh6QqkG6txoZbXlRfFQ8iaZnoZVmC6VzdY/PcwcDQJvqK2reAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250748; c=relaxed/simple;
	bh=bWZn169maYe9oCp/ZvoOIaxMuxJpUCzDluTDKEqj538=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m8bLZ73IQk5g5yIjLDawj19zZ0tmxl0AAJVYGJJjOSyl+f9z/RFfedO+F3WOvF1LGIfP54RD8N4zNNWWas8X+AbCqHjXtCnDT+h1rRKL1WrEpg6p3iX32WV1+syCtRlwdOcowArSpKGpUBStv0xhqBf6ALR4PbODL4PHjmkONY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JvCxKZSE; arc=fail smtp.client-ip=40.107.200.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C97vYMyummi8cFD1u9tZqvsRWKEaZ4jVcmub4lVkxQn4qpQqTbjA0/s10H6shyQPdXIcQm5z5iVglQXqlQpYhsGPioSrJegG3LMMyw8xO3Uq6hT5da9OceVo/wEqXRE9UWuhe6w5cga9Ntua+M7a43PVQ46yRfawc5tdhWmfSEVgoZrhwMhdTRTmWacJsqm5UnYGIKCcvkh1emt6YTvbP0Ovo0MGWYv2dLrXPgp2rUhGVEz6JxiXGyznY3LtzK4ixuOb/QEqCmnIg6rbPKnxNYVACF4wqaMfAXWp8t6xY36EW8OGKHqr1jaPptv+DkuicA4ul5KAsxL/Bwzr+Zv9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHuUSR1u8WLRr8MnesHnuQM322/5ssBKTyUmcuf0h5Y=;
 b=RMoAq6xiptNHtfwLS28yFBopb+kO9xtbNNsbmkTvPqr41ZG2cMlMj8Gq38Ygw/UYWmYURhVb1QAZSLZrxoNzVK7lqWwi4auKyiGQR1L7k2Uuc0u7aiKwlOmeyyIBbZ8pZCOt32e6jUUDuHS/iMLBAPaujKY2jhCf9qkbx8hBPA/K+pZRqa1ecU55XpOQ+Uo05r9ROhghtp0bTpcx1NLhIS3CP7U05DNbm99kmVdtw50Sq5rHHH5tsAYTFPsFfoHA0AoGAEP8Hw6RScQfIMCM8uMmUKFTEeoHDWddqozFmcJPZYHk5l8OFG2ipuK9dV6VjysNDOW3+DdY45xnttNcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHuUSR1u8WLRr8MnesHnuQM322/5ssBKTyUmcuf0h5Y=;
 b=JvCxKZSEB1R95tlRE8l+lK+OLm2PdRqofMZgl/FXt1ZpfZgvhO5LqTjHx2BOoylxeURSnzbhbkoHjDBeJovFi7+p4GBlk8VGD8F4awPBZi3nyUbqRT2fejYE4I+yxwxC9p4PPObA7kdvJxmB0X/H0XGFuOe0MtDsr6I3pEY9rKo=
Received: from CH3PR21MB4398.namprd21.prod.outlook.com (2603:10b6:610:21b::6)
 by CH3PR21MB4447.namprd21.prod.outlook.com (2603:10b6:610:218::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.4; Tue, 3 Dec
 2024 18:32:23 +0000
Received: from CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d]) by CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d%4]) with mapi id 15.20.8251.000; Tue, 3 Dec 2024
 18:32:23 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Parav Pandit <parav@nvidia.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>, "open list:Hyper-V/Azure CORE AND
 DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Thread-Index:
 AQHaxupwGAu99WXsuk6CZeFbpa7lGLHZiusAgAA3HoCAADQIAIDnyovQgAdWm4CAAEchAIADHbcwgADpCICACG/HUA==
Date: Tue, 3 Dec 2024 18:32:22 +0000
Message-ID:
 <CH3PR21MB4398BF1EFC9294701C7B0D7ECE362@CH3PR21MB4398.namprd21.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241125201036.GK160612@unreal>
 <CH3PR21MB4398E0C57E7B6BC73B1A8F04CE282@CH3PR21MB4398.namprd21.prod.outlook.com>
 <20241128093947.GG1245331@unreal>
In-Reply-To: <20241128093947.GG1245331@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dbbf2f3b-0651-4d0a-b913-c43d319630a2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-12-03T18:29:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR21MB4398:EE_|CH3PR21MB4447:EE_
x-ms-office365-filtering-correlation-id: a55e14b9-32bf-4970-9a3a-08dd13c8d424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?npiSIqqNUm3dFze1udW7Sgx4HFkY75xld/Moh7CPdjhc/j2WEHZlvJnCbBV8?=
 =?us-ascii?Q?H3D9uelMrB5DY2kL5cRAqtSos1UNTJVmzz5cZHSwF3GkehW44+GM6wZt5v0L?=
 =?us-ascii?Q?3E9o6ElzRioHx8XZMsyu8ZaCojUl5PedL4sDrpzQE8BjkbC+KaC/TYbLa2+n?=
 =?us-ascii?Q?vdvxhjS0gfbM1L1tYCtybA0ggLQsdxX2c5xB8XBYk/dxOev6pVmlZFCMgErr?=
 =?us-ascii?Q?aL3/dqScx5EISeKDbzxSLno6xzRdnw0FPkYdjtNlzLLhWnwQw8y0RQcqb3N6?=
 =?us-ascii?Q?qI/PefCo0jNdB6kT629ZZm0cJvixVsh0NKeTjFXBUP8odyTJxYNn0H7SHspt?=
 =?us-ascii?Q?Btq4IXXQa0RqxIC+rKspu1tvfh+8q4b7/gpngVyP1xriHa62O789kTLvgr6y?=
 =?us-ascii?Q?sw35sLPjNoxoKItrz19dX7nqHJ0ZY1Ga4xiF00IBpUxL+g1gluhmUJRh6Fv4?=
 =?us-ascii?Q?NbMerPoiDlgAWBtWvGUTjk8G/5XwMgfllswS+V+zDWVFAexPlaW9rVhKTQgv?=
 =?us-ascii?Q?SZtu2fZpaNKXhaL5Wy1laTEm1i0GNVf88kvvg6gyfOu3Qnm/1sqUIKC9Id7e?=
 =?us-ascii?Q?oqZr/5jYhBoBo5QQQ0Cf75KKdXhHuoqDSVtgLIElN7/Cv4p6LOvi1UwhRE1m?=
 =?us-ascii?Q?Dcmt4eLvRQc8GPj+Rbtaaq5QxYCIgFFBuBlAJ1K4do+QcBMtwsW5Ma8qMY4o?=
 =?us-ascii?Q?60SMVSjY7azdHgWbkX9/DaMQiJS9zK8e8gBJNV1Mwo34t7oTb70Cag18dZBm?=
 =?us-ascii?Q?vbuQmjmJXcb6oBuUL+EAIvr9iz2vL5nIURUKDpUcHLFz0ek/ev+Uykak298F?=
 =?us-ascii?Q?hUNVuuaWgkI1G2o9pWU/CXV/HvEvS570I0qaGGPoIwKfMvcenbUerXS29Ypj?=
 =?us-ascii?Q?jhMfKlYOD3R+7seVwrAfFojyB42XiE37YM8+/JZRI/Sq8IVhFSjcLTU/IpZ2?=
 =?us-ascii?Q?iNaQTD3EqKL6jEx2Th+rjsjZnqYvzY/Md/L2OrJgz1JmgNDGGT3qloX0uFWl?=
 =?us-ascii?Q?g7e1h5Rlh7t/hCVj624kPOX5wSrWGw5d/fRbF+P3c4mTLa1uVGml59yFPRVI?=
 =?us-ascii?Q?j4tP4Y5ofhf1JblYsTrUNNR7VUMWKHbWfQTbRwLQOmbvMSeC4sjGuBQcHodD?=
 =?us-ascii?Q?xss8LY9IwMdjewZ3M25HC9PPTxhRjvuH3vnbD470PZFrg9QkmT20M88BhNPv?=
 =?us-ascii?Q?nsPJoLVAWOBFpp2f5IB6pWQeN9o7OXtNaa8PhqUOYwczNq7uyJiO6VELWCyH?=
 =?us-ascii?Q?PSXpByTUzWezksMNl45oDEkXS//3uJ/5LSRLK7SMamKknYZJIXhcFv+6jAMj?=
 =?us-ascii?Q?H39dG5Zeqv/vGqKFTa1WbXsJFqgvXVM33uLQW9rJhsOnGy9zJft50E8hWTrQ?=
 =?us-ascii?Q?+lpvC+36/7nwlbghWOh9JtnqM7HFSvUECU1LCuhHfwbNw+ah7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR21MB4398.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VMcl7oNt94WYmczCEnV59SpZ0S9Lxb/Hdjc4sVq1zRym6jW35xt64REKRJm4?=
 =?us-ascii?Q?TLuiLbjMiyp5YL0aTtPgKIp6gUNYtMqfaimCVZ/8alScg3VdGyXeHZr8LnAs?=
 =?us-ascii?Q?U639RrJAjcAyN9QjnXtr7NIFjfuQpOwjtv3qsrf9xcM8l4Ux3Q4BQ6eM5ZnM?=
 =?us-ascii?Q?rtmKJWJnI3Y/DeCPQKQouCbObfe/GxWvF7LzYFOArGL/jpCmn8TpjOXXpoi3?=
 =?us-ascii?Q?n8lkgfd3f7pgw8C6LrRubZAgtyksK2WMAndDSozdpRA3VZoSJACtupfFePCH?=
 =?us-ascii?Q?9kekq4bzgGUGydiz/E3YqffTk0IZBwFoToR6RLc0oAQnk8sHuVz3DjOTHiRd?=
 =?us-ascii?Q?a9EzsEjFKmyXa+OYloOB9bq71TdpznH24Jj0AevyUl2u0mRAZ7Z9aqWxZ5a4?=
 =?us-ascii?Q?6GDUeKVD+1zuEl3FuQyPaeXndmDVnNQlpWTUcNG9pyzgKNJAHjGTwN5gQl9I?=
 =?us-ascii?Q?GY5iZvoZx/wbz5ahHMhzc7Wu9B28oQC/w8lfvmnveq/9CrzkC5KptnGlKanz?=
 =?us-ascii?Q?biduXA+4EdkIxKp75PHwX8VY/I/rhkz3v2ItO4enCAo6s1cSZpjT9/DH3KXm?=
 =?us-ascii?Q?C/Loq4vrL+BzQqDwR0hln6a8oA3AnlDrCxW6ZSRB0VdGacFLeExRuDoqzgf4?=
 =?us-ascii?Q?cJj8WT+/zYo0aHLnCTxcKaPt1yac6JA4j6lvYgKleiKdKix2ZcSc+uXiY9Yr?=
 =?us-ascii?Q?3RPdlOUifXCgxin3mADhgDlTDnbqBjyWJWCTEwzpT9YHNEHvV8P14dZXTawr?=
 =?us-ascii?Q?KVS+vDWW0z+esQxt3UJ4KxvOesylU1hXECHtHH+sHcIQMpXtns9zUzr4zKjb?=
 =?us-ascii?Q?xm5HrJy41j/pigUbgU92C+SjgnfGt2vDSoqUOJQQQu4kBQ8okKaxUlQ5RWUL?=
 =?us-ascii?Q?9f4+xYxL4EucOiU5WzzC7kvdZpy6SKvx0EdL8k4MYjXuTsFsqcVFotk5OPzP?=
 =?us-ascii?Q?f7HvvOOR9+Zsi8zFsVMj6RLk7ptQPH3lZlM3Yc+vMx2df2CfPHSd4vjficGF?=
 =?us-ascii?Q?N/wjhTMVDPRfRgGM6hwKyKSxlSn7bBVK6uOullFVhZASAsrLPt0N+YBaZkRw?=
 =?us-ascii?Q?+3ciEE0kPf+wCErC2k/8TCwYviK2BPfzQs8LzJkGVJtfFnVf4uLIDuo/2nj8?=
 =?us-ascii?Q?1ULBKuw4k1IOK2uZS7WbwS6BkvqZ8DUE7jlYFM13n/auSlMRujKGIkeDjvDN?=
 =?us-ascii?Q?8nxJoUq/7CjqGlr8KZcwhueflabFVu+OA76CV1LtkmtzrRuPzw7S7/+2Eihx?=
 =?us-ascii?Q?tJadxq7W68jgNeenzwgzzNVCyHEiHHLrJsRXv2BGSlY2qrcugBcDZCktTHoy?=
 =?us-ascii?Q?YyuhgY2BL95oc/tl+T8CzqawUh0UDXh9o4skcWucRP9pXr4TGohUxg74YEQY?=
 =?us-ascii?Q?k1tP7+IQ/lNWIukgDZBLPqK++zdtHaiyrzbDcr7frzXj6Q+ObRH27hHv9ewB?=
 =?us-ascii?Q?EiSX9ke/m266+aAsM93YcEDqW7XIAR6VqskGGwNBbUAVKqDKiBR39UhMqvOv?=
 =?us-ascii?Q?PHXczyg3zSN3GT1+9KGKh4KUs58xLMpZekCpCHYzUrNuTy1b0i9mbSnBuH+X?=
 =?us-ascii?Q?vMQXAlIelxWRfEkJevZVU7B7gRcIIpjm3NUx1rx/?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR21MB4398.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55e14b9-32bf-4970-9a3a-08dd13c8d424
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 18:32:22.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muyf1am+wsmMdRUUD+lROXhbAHHZNc60VazjZT1UANErlKTKkJpD+ayZ7sqAxdNRt/hfajpugY+i0uhY43cdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4447

> Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set corre=
ct
> device into ib
>=20
> On Wed, Nov 27, 2024 at 07:46:39PM +0000, Long Li wrote:
> >
> > > > > I think Konstantin's suggestion makes sense, how about we do
> > > > > this (don't need to define netdev_is_slave(dev)):
> > > > >
> > > > > --- a/drivers/infiniband/core/roce_gid_mgmt.c
> > > > > +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> > > > > @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct
> > > > > ib_device *ib_dev, u32 port,
> > > > >         res =3D ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
> > > > >                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, rea=
l_dev) &
> > > > >                 REQUIRED_BOND_STATES)) ||
> > > > > -              real_dev =3D=3D rdma_ndev);
> > > > > +              (real_dev =3D=3D rdma_ndev &&
> > > > > + !netif_is_bond_slave(rdma_ndev)));
> > > > >
> > > > >         rcu_read_unlock();
> > > > >         return res;
> > > > >
> > > > >
> > > > > is_eth_port_of_netdev_filter() should not return true if this
> > > > > netdev is a bonded slave. In this case, only use the address of i=
ts bonded
> master.
> > > > >
> > > > Right. This change makes sense to me.
> > > > I don't have a setup presently to verify it to ensure I didn't miss=
 a corner
> case.
> > > > Leon,
> > > > Can you or others please test the regression once with the formal p=
atch?
> > >
> > > Sure, once Long will send the patch, I'll make sure that it is tested=
.
> > >
> > > Thanks
> > >
> >
> > I posted patches for discussion.
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flinux-rdma%2F1732736619-19941-1-git-send-email-longli%40
> >
> linuxonhyperv.com%2FT%2F%23t&data=3D05%7C02%7Clongli%40microsoft.com%7
> C4
> >
> 20bac91521e414ff34c08dd0f909cf6%7C72f988bf86f141af91ab2d7cd011db47%7
> C1
> > %7C0%7C638683835975667120%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU
> 1hcGkiOnRy
> >
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D
> %
> >
> 3D%7C0%7C%7C%7C&sdata=3D7vTTi%2FilkYdEKNG1qwpgYYDriOPPUF%2Bp8Zh91
> 60CEVE%
> > 3D&reserved=3D0
>=20
> Please resend these patches as series with cover letter and don't embed e=
xtra
> patch (the one which is not numbered) into the series.
>=20
> Thanks


I will resend those as a series after addressing the other comments on bond=
ing.

Thanks


