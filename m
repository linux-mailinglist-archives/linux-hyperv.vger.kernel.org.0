Return-Path: <linux-hyperv+bounces-4213-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C8A4EBEC
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F8E16FCF9
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F22780EC;
	Tue,  4 Mar 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SDgUvDYp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020100.outbound.protection.outlook.com [52.101.46.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0081FE45C;
	Tue,  4 Mar 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112769; cv=fail; b=PftEoaP7QIQtJnXMHBqkCycZ558iBGZOKjawDCXY1HAzyZad6juSg+i2am0mLMQD79aMXPQH7PsVV8hwNVXv9XS9RF3yiWk5vWuqRmlcOUWinBVM8xTYX08OVUq4Mgt9WjXdo9SYjvW+hEppxi9SDLXzeSz8JUC8u/SaM85lOXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112769; c=relaxed/simple;
	bh=5LPL2fg8M2ClTK8Sk4muSnkt8iPA5m3bLvBGZmXBrs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJAGwQzliM7bZgotzGwFX5a+YCRBDxQtzvMLoq4rM4Lel0qImDOW6omR+YMQxxmcmdcTomJSV0lLaCjkN34VEFwqB0jLjji4SehOSMR/5dUd4rRomdoPYQv4MhX1HJUQr2EtuEmrtp4vMDsYfCDmwxTIb8ncNPBBi8hLHtpMu+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SDgUvDYp; arc=fail smtp.client-ip=52.101.46.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGePU7SzBRPy3PLeXdHwPhlWUVTHPUFW2wFH+h2UyJTcFwVD2QBgl+OBpXn8qOTwbB2xha74n/YBFfLyre+3snY76fBX0c5I0vnXUc2C2z1lD1M48JVvhbqSpxOJbjJFReutJO+NCMDKHkYG7z5GGhlzRvwRc/o/xhS4rt93gqHKlOk3syYf/pYe3reQBEPkDFOc6BqxLIPbiDzFuaLq/J1cNNb9dUlc270SqG2VrUWwyty5DGFLfHuyect13s7S3GCmkW73Lcy/Km9za3htpbuU/Spd5VUyNeJBbio4HAe7s6q6WrWKui4s8HOs1Rijl9ExDptOH4yCmz3AXwtQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtwAJ+2+oY+8YsjsPbdvoZu6nLEi+ybqW6ggqUbNgCw=;
 b=SaSuvropmI12weIo5pGugnAYXBpY0SMpto7/uu+cXHuwD3BhuJG5DptfMyfhio3msvzu/wvJWihD1EpqzE9s5jiTYa0ioNsHWr5QUtKbet3qbsHmw9cPFI03pThpqDnrmjrOyNqbMxyuiWySFtOrKrXJJwMqbi1APwvjXtVZoD/k+G6LHAut/BhNg0/FTGhApzFnMIMcqZtqY3ETPUGqHKTF3L1fkLZzVQNNOI71GTjjzPwJnTRd2TmgEwZBJzsiWhjpOLcbF9URfDJem6DQjxlqfMRDnPvL+i5OOn8sM60ydaeCFSIXTJTHAHuAzT8S53zwYTvo7JyLVx03+EKzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtwAJ+2+oY+8YsjsPbdvoZu6nLEi+ybqW6ggqUbNgCw=;
 b=SDgUvDYpQt8g/mxVgmNKASf+MG0/csIBgLhCHWcuclE8De8M7XBqJdx2s/THii1EBLFyfszU0tVPsMyNhdAZugK8j84V3zTT5/mLs8N6/bpZ513CRRd/0Ie+zGYlA7Sx6aw/wWwPvBNgTD8gmG155sQDHrHPQS9PMMfI4faPYEE=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4439.namprd21.prod.outlook.com (2603:10b6:806:428::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.13; Tue, 4 Mar
 2025 18:26:04 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Tue, 4 Mar 2025
 18:26:04 +0000
From: Long Li <longli@microsoft.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Topic: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Thread-Index: AQHbjNA/zhmjkp3O9UuGRnLmVPtXL7NjSSPQ
Date: Tue, 4 Mar 2025 18:26:03 +0000
Message-ID:
 <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
 <20250304063940.GA2702870@maili.marvell.com>
In-Reply-To: <20250304063940.GA2702870@maili.marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e0cafc18-9a06-4504-97de-274a04cf1e0e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-04T18:15:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4439:EE_
x-ms-office365-filtering-correlation-id: 33bae6f3-fa22-4b65-d921-08dd5b4a05ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pNLzfBR/7YquYankzf6ej14YBFR/J4wp7EJ2HT4deA1Jj8FH9u2fNR5gt8o9?=
 =?us-ascii?Q?H3psbLDJbJUL+o6BTyr5EgfSZT59Sq5f2AGYKkXgJPaS0hN4zImA6CDmw/66?=
 =?us-ascii?Q?+RsY18mD0JIb8RJFNPZYA/xhMkMLa0oW6vStBKC9jD+2PzTX56gwzug73Bfy?=
 =?us-ascii?Q?4Ls0h8pyrJbSTeOzhfktz5QmOB1W/X/Ly+BajwdZ9vEj1ejStWseejQjLazN?=
 =?us-ascii?Q?plEQde+r3/w2flhoPnDdnllsgpedpluz/sn650/QLy+w2ZGhrFKLH43APY0q?=
 =?us-ascii?Q?wUq1yU9WZz3yoa+Pj7renv7IvM78RRPuurydj0VY/t4kwMjlcOyykjRUjmLc?=
 =?us-ascii?Q?dtCltwLQfSho79A7t8i1wu2dn7HK/yDUdR4byHpfd5QrJtD2M2yAi2fjRoEe?=
 =?us-ascii?Q?L3AYC1SsXaCYeO3bOUcoLt4y4ID4MpsdLDlgFQtpIjilvFkkvmsva1Jai2/l?=
 =?us-ascii?Q?tIDnJ1jVEEoIuBY9X8jiQmqyjn8jOz7kyZWx5P52pCveOGNkEe30qUehQWsb?=
 =?us-ascii?Q?R7hBZkTiiu+T8AasN9H8uZyIisy7rSBzxaRW6LXwUkxAns4nFiydj9DhSXnr?=
 =?us-ascii?Q?ouKJJC/WISDg4xog8n0p2gCGDgN9qkOYW6IEtEXVD0xZ1w6GfwKwuD3KHINT?=
 =?us-ascii?Q?8LDKbKgQ2AUzIQ8jdzR7EmSAZt04MYI3LMmnxEyrQmOH7LNn6qAw5KjJGtev?=
 =?us-ascii?Q?QFyJCaNoDuy7tRayixD5xTuMA/h1a5jusKRAZ5GJIUiot+TM8DDAtt2LToxv?=
 =?us-ascii?Q?8znwmIRLp2RowRIQcD53qbEWFeRXWi+RFqNHxPo9G8YS+i/SyNFI+sbXtopH?=
 =?us-ascii?Q?3FsuUid3prbxDmaESyUZkQg80WAOpTtLP0gKrEMy/C8fWXhOb6hnXwhdzObi?=
 =?us-ascii?Q?Y6kZvUKLzWI4iPyi6k6P0UNGCgINH3F1v2+khlLErIGDvATK/Zkf0J1lCT9y?=
 =?us-ascii?Q?8XrYlDmaHN+sKmw3J0QNo+/ridMeztSu+Vn/MlqP+BsrlYR+7vFiy81eay+g?=
 =?us-ascii?Q?8d1AhQQETzT561kk/OZpBClrOIuAtWKLT6FPZr/hcduiUTGXVr3uhMYZnSnV?=
 =?us-ascii?Q?o9e5pMP2zsQQK380VZzBf71tJkbeQe5QPiHdAy25RlffmucmirzpUQw3OWLR?=
 =?us-ascii?Q?/bpjgUPD5vaITkN38qVV6SrHlc/JnCxpiXNEYeR9S5vNoi/KEVjbjzmkvCGE?=
 =?us-ascii?Q?/tIyQPbLpgJqtA3aAjsD4xkZcRAqbFAj81u+7jt94UyjxropaGjY/K67OI5r?=
 =?us-ascii?Q?GzTzQeBe3y3zWZVDjtmCkXHO0Cymc+nwXe+qSB93qXLOGBJwTHmpJ7dQHjd+?=
 =?us-ascii?Q?LN2dq3iNB1HMYqlHaBxmjjk9H7CBlu7nU2SNvVYFLjYZggWXKXxD07cyOjIz?=
 =?us-ascii?Q?pyC7V0QI1PdMII+F16Uz4VgVWgM/hEF5yzL9tZ6KwL15i9UOzJqoYiP6u2Eo?=
 =?us-ascii?Q?KOLRFb11EJmCZihDayi9v9lCI/rcrnXr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UkocbT32WGMKC//WUIZaMCPP7In0zk8NXxtXl8yxiMHVuCf2T6Vax6sZCe4g?=
 =?us-ascii?Q?QK26sD2P1ctdIlQVnE70Rg0SZc1GG/yPELNgGfXsf/vu5X58Al9qq/kYJsLX?=
 =?us-ascii?Q?m2waRS6OHBcE07fwW4M8EFAmdUfLwAfmCCZvO2ULi/NiulfRaailUn38KeR/?=
 =?us-ascii?Q?ZhcMre8i0fkQv4MCQ3Dr/ZHLWeUYcCkdFg/TE6frlKqqI6tw+H7P4uCP4Cs+?=
 =?us-ascii?Q?jAZ7V/Y0h5eKJczUvzMjGjMj78iN6xTtyUUgzl5WYxVcJtrEn7zKhz04/3XH?=
 =?us-ascii?Q?oRu6CI3UzUXoh009di+UNJvuxAk/+PNnNdelH4iLVG/sXHIeNtEzEA91XUX9?=
 =?us-ascii?Q?n4zu6S6eu4qlIGz3gdWSh0+cF10pKz8HhGQGy78TrTMkW6G2y67PzH351/oG?=
 =?us-ascii?Q?29Zgyc0k+nCv0xKw8VnYHIr+FyZeDKOFhuTjDvuwC311/MrJPlKzv851DD+1?=
 =?us-ascii?Q?uHc8grTgd6012kgOecGIdeI5uHezokfwCh3qXyRrqNRZ/MY6vC/2jsd1isq2?=
 =?us-ascii?Q?2F34UHFy08t8QW9wL8X1+4Am/keRiR8ruIQjGCRIwNDVTpt5XQ7JpQiMhq2w?=
 =?us-ascii?Q?hi22naLhCGdaoRYuKuVAPIo9ynFOCPFhO6AlkE0JV7hTaTn8sC6MsA6H5Gy8?=
 =?us-ascii?Q?rtDQhR79P43KrvPAb2oH0XlWXbBoTSEh6OyzD5tHtlelSztRaeoZOa55Yoj4?=
 =?us-ascii?Q?G4yPIHiDdGcXqepMghOTxLe2XxjS7pRgm+W4gqADTZll4vwhE2jXJOzhwhKT?=
 =?us-ascii?Q?Kevkc1yWHoDrR/zU6eGDU39v6Kjp1Gm+L7lDpg8SyPjwIHithVgpaf+SGgwi?=
 =?us-ascii?Q?N2B4F20zcChXod06r/8K9J3am1RJjPipvJBx/2oqoboMFJKiGbvn9+nis2D0?=
 =?us-ascii?Q?C0XkRlCewlDLdWOROVwSySpKGL4QGGpkr6meDKbAI6Gy5C9BDhD3hmUebTnr?=
 =?us-ascii?Q?AGiv0hmpSBXWugH/WBA6wEnGPzydGBGvlCpgt58eEZmNI4gl/7zGKrnoxWx3?=
 =?us-ascii?Q?89i27AnwJU+n/q6vgdUpWqM8Ka8MHM/Skx4YoxO2+NGJIs/EYLW0bD75sFsJ?=
 =?us-ascii?Q?CLgzyTU2tEdSTwkNBz8UCyVe1JpLB2HPBxTB+YnedUpvyF9Lsi1RrTby1UIM?=
 =?us-ascii?Q?jkYvRiw6/bI9jsueKsmohP6Um7ybc3JL0BLKWPYlybW3Uui5qXArrMfZ08Tx?=
 =?us-ascii?Q?Fmynivr+YZVC+GATo9Wdhqca/jPO5NtqCOuTksNB6iVsMy8XuM7mH2Rt2CVj?=
 =?us-ascii?Q?9Y1gD3Wu6nQAJCQFnljMescjoNBs2wRYPXk+ZAwYSrMef5axH50kx5DLIvtw?=
 =?us-ascii?Q?KVxHudAhx/RXUA9c3VnHaEbUoyjbYE15vEC6Yz+ZVU4FChYXquzQ+LbD94em?=
 =?us-ascii?Q?TtEesL5jd6Rr7AHb0HUrVykes8SIW+3WDGJiOHs+jQVIDuQ5DfbIq7uH9K+0?=
 =?us-ascii?Q?YHJVDQvW9pd/T7mkV+fg2DiPJ/3x636JrKVrlvJSelCQ6/dVaZcZDxLOMRvz?=
 =?us-ascii?Q?ljePklDWPS8Uv/1x/6OSvPXVldpur/Oa0Op2pGla4G+w/rSe6gQv0Qx0wzlB?=
 =?us-ascii?Q?ehhb9oOSDhTeJYHy67S306kxDl0rmX1u25+CZmrpde5hEd/Ahsi3U9rtXqxU?=
 =?us-ascii?Q?krhyugy2QoFD0S1nQiVGt7jaTYVKlIQA4+BRJX5YfcVe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bae6f3-fa22-4b65-d921-08dd5b4a05ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:26:03.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACpWZttNJP8x4ZAZQfZpVdeoBoKhFya9mI+f3Hy7kUOAE32mdQP660o9l5X5Xue/+brVjEuiTgs+cEBskGpLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4439

> On 2025-03-01 at 04:11:59, longli@linuxonhyperv.com
> (longli@linuxonhyperv.com) wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When running under Hyper-V, the master device to the RDMA device is
> > always bonded to this RDMA device if it's present in the kernel. This
> > is not user-configurable.
> >
> > The master device can be unbind/bind from the kernel. During those
> > events, the RDMA device should set to the current netdev to relect the
> > change of master device from those events.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/device.c  | 35
> > ++++++++++++++++++++++++++++  drivers/infiniband/hw/mana/mana_ib.h |
> > 1 +
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/mana/device.c
> > b/drivers/infiniband/hw/mana/device.c
> > index 3416a85f8738..3e4f069c2258 100644
> > --- a/drivers/infiniband/hw/mana/device.c
> > +++ b/drivers/infiniband/hw/mana/device.c
> > @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops =
=3D {
> >                          ib_ind_table),  };
> >
> > +static int mana_ib_netdev_event(struct notifier_block *this,
> > +                             unsigned long event, void *ptr) {
> > +     struct mana_ib_dev *dev =3D container_of(this, struct mana_ib_dev=
, nb);
> > +     struct net_device *event_dev =3D netdev_notifier_info_to_dev(ptr)=
;
> > +     struct gdma_context *gc =3D dev->gdma_dev->gdma_context;
> > +     struct mana_context *mc =3D gc->mana.driver_data;
> > +     struct net_device *ndev;
> > +
> > +     if (event_dev !=3D mc->ports[0])
> > +             return NOTIFY_DONE;
> > +
> > +     switch (event) {
> > +     case NETDEV_CHANGEUPPER:
> > +             rcu_read_lock();
> > +             ndev =3D mana_get_primary_netdev_rcu(mc, 0);
> > +             rcu_read_unlock();
> ...
> > +
> > +             /*
> > +              * RDMA core will setup GID based on updated netdev.
> > +              * It's not possible to race with the core as rtnl lock i=
s being
> > +              * held.
> > +              */
> > +             ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> rcu_read_unlock() should be here, right ?

It can't.  ib_device_set_netdev() is calling alloc_port_data() and may slee=
p.

I think this locking is okay. This event only comes in when:
1. the master device has changed to netvsc. In this case ndev is guaranteed=
 to be valid as this notification is triggered by netvsc.
2. the master device has changed to itself (the ethernet device parent for =
the IB device).  In this case, ndev is valid because mana_ib is an auxiliar=
y device to ndev and it can't unload itself at this time.


