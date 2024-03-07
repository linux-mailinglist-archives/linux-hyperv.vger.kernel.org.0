Return-Path: <linux-hyperv+bounces-1674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377887540F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 17:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F2E1C21257
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA212F58D;
	Thu,  7 Mar 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lud09GyV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EFD12EBE0;
	Thu,  7 Mar 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828284; cv=fail; b=X6+lXGLoxMICd7/AtBtKXqoMZqLNvm+7867n//mb8tJxzrQB4CN1Eyywuad0lAVgMRRluD7oce/dQDOmOCn0ZRGej29kw5Xnd7MISZMBPBppN/ccobmlYHh7olvrKE1N/LhT3q4aI8sGHcdFhzdetN9XeAGKQcBA1c+kUzwOTjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828284; c=relaxed/simple;
	bh=6KDMTSNkMGMvTOYHuqcySlnbmtBPZYIGoLY+b5kCCgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tw5JYj7H64MxqehpcS+SMebFz5Ba28S2L0KM1aMqUMd0YGY1gLU5vpZWIwXQ3V3LrU6WGBRTQmXqHIVopEdfYgeXzcWk6b2RjyW4n4pEhl2JknIk+mnrATxvoOU41rY2uB8dzblwsRNehOqCOsS9/yrJx/x9GXwZZAN/dQwb4jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Lud09GyV; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIo0qocbM6PfV9C4jk7ZwwZTC+kWS1WVgvqmzXqnzGMkhVE211WC3sj9d+MA5IrSjBNylM93IftQTgRC9VNORP3XN8RMf/7Yiu8qpq6vfbUCs+yDu0xWjQkqjImV5yWJASCw4G9ImDJcX173kNA2RIe3JfTao5e8HaV33kzciv/QlCBiSaIpvZR9Pxl+V3NECwDgwg304TNsYp9UZClp1dKCf415WLTnQoaQHNrxthEY8jHYuZxi89UxvF1mctZIVsl4KdEthbul6n/0IhNd9hTWI8Jje2A7R2aNHgHF3g4MYTwRqG2WTt0OYDOWYncMTJUeIcG1VtYZEhwvBxzmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKEu9GUBiU/PCd6VFfhUCFU6ObzaEpPJxuzl4mQ5To0=;
 b=JiSJaffqlMKTgc70rAfTiSFPtANwlld9YS7PYDK+PaMb7gL4rtTZ+xh85qzQhOiEYGrQsjOGDG9Rc0LdgtUNSea/oLR9g3GPCkGcs1nzbw8kHHpK287NSXF7/rBV21jAk+aCKj+qpkN97dZHkVqiFxwMvqVN+OE2PNEKLy6ZMp8gkhXUVsC5K5Csnb9U79iArBMB2b89t24gsSw7TrYd03aQCJ9Qes8+5z2sZxPHvuKT90LiesVeqmBPM3Nr0JGSGKcuRx7yoKnDw5qnijtVr37W+5/wzY1D4wg0gTHpoG3jrga5IRrOQW9k97OIcuocdVR5Lmtbsw3Nsg5lKteJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKEu9GUBiU/PCd6VFfhUCFU6ObzaEpPJxuzl4mQ5To0=;
 b=Lud09GyVfUeEToIsrlODjWXUw3FfP0RJ9ehOXDUo5F9E12ZP4xCP9yp7ZZeAMJPNmtnBP5CxRO50fF2rH3ZRkPhmNAnwsyEHEm0X9fNy3MHHStw5p3JvPvd0N40ldoKsgIYla84OQeGX2QE5dJDp1GnTUnJ7nTEWlDQbddyuMY4=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 PH7PR21MB4043.namprd21.prod.outlook.com (2603:10b6:510:208::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.9; Thu, 7 Mar 2024 16:17:59 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e352:f8b9:4805:c9da]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e352:f8b9:4805:c9da%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 16:17:59 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Index: AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsctXQ
Date: Thu, 7 Mar 2024 16:17:59 +0000
Message-ID:
 <DM6PR21MB1481E60F25B7A379FE8AFC75CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6909631d-84c7-43bd-bd96-3c3f2658feff;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-07T16:10:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|PH7PR21MB4043:EE_
x-ms-office365-filtering-correlation-id: 9f4d481d-3f83-4649-9377-08dc3ec227d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7u4nQuFeANry/UnU/Yz8kAeHtZvQYzdLWViJlOSMyE1oBhQQMG42ejh0rkRCvG0Yzs3aollpApCmz5qDrwkAVqFB8CRQV/+aMn7uNWo3xYlHt4QYnj4MiLSISfz6RlWxqK+F1cKyxhm33jA78spEPngqycOGChgVsAhRaZb/iQUicUzu99WQaClCsGB5KyS7Oesl7Ne9QX52r30IeEEeYh8oY1X7cGutUtHXZpqxcW3b4wcgyvuagVyUOPUMUC/SU5H0khZLbHuBObKxYBaHdQCWhJySST27/WzSFkDFbmgc89ETmZVSHbC1G3/t5apIX8p7D6Q61XG4xrXWE7TCbueCKAsxHngYSH8V6z6BQyenaNavUBxe7JVhK3qN8K9xVg3fDkAQr4SlIaxLuBK5aUyg2SnpKIzaYAN7my/gZgauP91isQoucOVljmsRsAIDEfKXuGorH0TQfOWmgNKxR5k83Pry1vf+Tnc71SmzzOfFajX7t6/MroqctH5erozK2c2HV5Sekx0o4THajFJOEFQWRnWqFM/cZKiS7UCoDR2WT/5b+jogZ7dX9rVzcT4I56mrVD77ZwuPbtWwBx0BUZB1WQq91tjz7RPWO+mxdHCq/DGdfxgwLUeYpbFklwKAN1dr5VzasK+lL6Pcs7Vnp/FvvAgbzekoSFGHTbgR9aXBl18wKMYayieILgVRLYPmFD08PIA/OWo4L8lit9MhEQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?75u+gOYjoAb/pUglTqsg8OLNW5hSS1DlbyfzPYdVuJdeuATnPACVKw8oVhq+?=
 =?us-ascii?Q?CxHNBqXKBz2dNF+ONfmZQpy5rN4vb7P4gkmH8lJzAW4zh/mGFWtba8HqRHop?=
 =?us-ascii?Q?vwcK2mVS9VF47xSgn30uCNe43E4HugGwlCN0DDgViVSTmXRE65qEWycui8pe?=
 =?us-ascii?Q?APE29pAriWVWTL7C5XCwwtw0Z7KXEPMMd2o/6KI8vx3z3nVJpTbTSqGL+8HW?=
 =?us-ascii?Q?Fn7LgxltcFdqogzT6wZg5ctzWCWoD0zHhN5xBlybTAVSBzvHNdoiR5EJfZsh?=
 =?us-ascii?Q?4hhEdU/4NJZoGnhA4NRwc42bJ/2/K1lA8wuJIiTVN4JK/jOJIt9ykbHdvPBY?=
 =?us-ascii?Q?LBqWrxbmds7RUYTQSarlZiM7lcCgWe2z35TuqJOEDJ3dSjJVJ8od87P4fw7s?=
 =?us-ascii?Q?M3mwRCssKoQlYo67kGTWJ9UHnazlCoxP0y0JVW9hK2vizI48GQdKk7erx8dk?=
 =?us-ascii?Q?3Gi61HkvXvXQpXDKs81SQvbC04a5vJxSqB/Vzff6mstOo4K8T6/7zfe88Pcb?=
 =?us-ascii?Q?dX1rDqRecTYysQKZE/ZrDRBkZv3uh9q+4L2BQQroDCW1v6gH15SW9iIdC4dz?=
 =?us-ascii?Q?cEpAa/irYjdY2xoG1YE99AVII88cfEpXmcFWqzal5Xra7+zFqAO++UCCRMTY?=
 =?us-ascii?Q?TAhRaf1C22Bk2P5W5E9mUm98/+dFMc1RKAEVrs0hVBesLQiifE6Fu1/oPB3A?=
 =?us-ascii?Q?mhBYducz08fI89wsPMvPk0aOgIXZ3UR3G3fi08Ly6MImnBuwE67Dy43+rSI+?=
 =?us-ascii?Q?4+L2y/SiEcBdD3cHWNdAI+ZYnsyTgJ6uPsdM4iHOO7wIdyRceo6ck3mxZ4uS?=
 =?us-ascii?Q?UAQex/ZO6GtkgF+WRrDoOo7X7vAq0QD/2SYzABk6xOfvTNdv6Z1ekAlX/kwt?=
 =?us-ascii?Q?GdZJvYUSduS6Ilmgcup0FssAlNrtbGb+wQdRpEgmEST/BtzSBqqpJtymFUSs?=
 =?us-ascii?Q?hyuUIqT8a93bMAwYLQSIqex7SCokju7C5a+eJj3tZq3ImxvBH2YLH1MMN0f/?=
 =?us-ascii?Q?sSgfRn/eoJ3GfqWm1zIWpdUhxvB0dmHVObbYPp+TxLfNrSukKdvA9iTNcHGi?=
 =?us-ascii?Q?nTxXOhSi8gto49Jo92kx3WraLNk9QbByeMrXzXQiKJ2y/dkYAWIssB6ECfg9?=
 =?us-ascii?Q?SjSMfRHRn9YH8cvP2/BOTsb03coB85g+Q7shU8J4ns5VRjMGDAV3j9ZkYPaR?=
 =?us-ascii?Q?dvH3G8Xht6pB6laLFDdMz0pAb2R3jA3CCmGLlEz7PMgi5EGad2X8N6v6pTHh?=
 =?us-ascii?Q?Mihdcb7uV2Hsv5st0QdRJYQBbz/gNQ/M97qlJe21GWu7TaAJKfDZ2qbGgy5A?=
 =?us-ascii?Q?gFfeEL+7zCQF3xh8yOhWCXXfFw6hXlEqzp+oTM6deGpjV6WBS20yRIDPqKJ4?=
 =?us-ascii?Q?xEH0YAuNLq/+JoUmbBQ7ttfSTqcfp0ze1dxSEKHXvOa13a78Mfk7ib+4YNlY?=
 =?us-ascii?Q?GKpzG75PG6sxI9C/ZDvbKUwMYuhUJjlpMXJlBt4QyCe22hpbl609L/Yfhtl/?=
 =?us-ascii?Q?cerrnBL3zR51Kv+2ctFJ9cweq2mXhiHHWqzyD/AuZ3A1Xm6U+lEssZay7tkM?=
 =?us-ascii?Q?p2Bt6hCaQM23I2Nxzv5R0hJf0BqeZL05IXi9nEwg?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4d481d-3f83-4649-9377-08dc3ec227d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 16:17:59.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKLWLLPkGaMWEu63oIVnnSVABf76t3UYlqr7ib7J1YRE/XbZkgA545+oahn3dqkXNKsR1DV11XLy6Lic3ckvNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4043



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Thursday, March 7, 2024 9:52 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Long Li
> <longli@microsoft.com>; Michael Kelley <mikelley@microsoft.com>; Shradha
> Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH] net :mana : Add per-cpu stats for MANA device
>=20
> Extend 'ethtool -S' output for mana devices to include per-CPU packet
> stats
>=20
> Built-on: Ubuntu22
> Tested-on: Ubuntu22
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 22 ++++++++++
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 40 ++++++++++++++++++-
>  include/net/mana/mana.h                       | 12 ++++++
>  3 files changed, 72 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 59287c6e6cee..b27ee6684936 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -224,6 +224,7 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
>  	int gso_hs =3D 0; /* zero for non-GSO pkts */
>  	u16 txq_idx =3D skb_get_queue_mapping(skb);
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
> +	struct mana_pcpu_stats *pcpu_stats;
>  	bool ipv4 =3D false, ipv6 =3D false;
>  	struct mana_tx_package pkg =3D {};
>  	struct netdev_queue *net_txq;
> @@ -234,6 +235,8 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
>  	struct mana_cq *cq;
>  	int err, len;
>=20
> +	pcpu_stats =3D this_cpu_ptr(apc->pcpu_stats);
> +
>  	if (unlikely(!apc->port_is_up))
>  		goto tx_drop;
>=20
> @@ -412,6 +415,12 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
>  	tx_stats->bytes +=3D len;
>  	u64_stats_update_end(&tx_stats->syncp);
>=20
> +	/* Also update the per-CPU stats */
> +	u64_stats_update_begin(&pcpu_stats->syncp);
> +	pcpu_stats->tx_packets++;
> +	pcpu_stats->tx_bytes +=3D len;
> +	u64_stats_update_end(&pcpu_stats->syncp);
> +
>  tx_busy:
>  	if (netif_tx_queue_stopped(net_txq) && mana_can_tx(gdma_sq)) {
>  		netif_tx_wake_queue(net_txq);
> @@ -425,6 +434,9 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb,
> struct net_device *ndev)
>  	kfree(pkg.sgl_ptr);
>  tx_drop_count:
>  	ndev->stats.tx_dropped++;
> +	u64_stats_update_begin(&pcpu_stats->syncp);
> +	pcpu_stats->tx_dropped++;
> +	u64_stats_update_end(&pcpu_stats->syncp);
>  tx_drop:
>  	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
> @@ -1505,6 +1517,8 @@ static void mana_rx_skb(void *buf_va, bool
> from_pool,
>  	struct mana_stats_rx *rx_stats =3D &rxq->stats;
>  	struct net_device *ndev =3D rxq->ndev;
>  	uint pkt_len =3D cqe->ppi[0].pkt_len;
> +	struct mana_pcpu_stats *pcpu_stats;
> +	struct mana_port_context *apc;
>  	u16 rxq_idx =3D rxq->rxq_idx;
>  	struct napi_struct *napi;
>  	struct xdp_buff xdp =3D {};
> @@ -1512,6 +1526,9 @@ static void mana_rx_skb(void *buf_va, bool
> from_pool,
>  	u32 hash_value;
>  	u32 act;
>=20
> +	apc =3D netdev_priv(ndev);
> +	pcpu_stats =3D this_cpu_ptr(apc->pcpu_stats);
> +
>  	rxq->rx_cq.work_done++;
>  	napi =3D &rxq->rx_cq.napi;
>=20
> @@ -1570,6 +1587,11 @@ static void mana_rx_skb(void *buf_va, bool
> from_pool,
>  		rx_stats->xdp_tx++;
>  	u64_stats_update_end(&rx_stats->syncp);
>=20
> +	u64_stats_update_begin(&pcpu_stats->syncp);
> +	pcpu_stats->rx_packets++;
> +	pcpu_stats->rx_bytes +=3D pkt_len;
> +	u64_stats_update_end(&pcpu_stats->syncp);
> +
>  	if (act =3D=3D XDP_TX) {
>  		skb_set_queue_mapping(skb, rxq_idx);
>  		mana_xdp_tx(skb, ndev);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index ab2413d71f6c..e3aa47ead601 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -83,8 +83,9 @@ static int mana_get_sset_count(struct net_device *ndev,
> int stringset)
>  	if (stringset !=3D ETH_SS_STATS)
>  		return -EINVAL;
>=20
> -	return ARRAY_SIZE(mana_eth_stats) + num_queues *
> -				(MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
> +	return ARRAY_SIZE(mana_eth_stats) +
> +	       (num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT)) +
> +	       (num_present_cpus() * (MANA_STATS_RX_PCPU +
> MANA_STATS_TX_PCPU));
>  }
>=20
>  static void mana_get_strings(struct net_device *ndev, u32 stringset, u8
> *data)
> @@ -139,6 +140,19 @@ static void mana_get_strings(struct net_device
> *ndev, u32 stringset, u8 *data)
>  		sprintf(p, "tx_%d_mana_map_err", i);
>  		p +=3D ETH_GSTRING_LEN;
>  	}
> +
> +	for (i =3D 0; i < num_present_cpus(); i++) {
> +		sprintf(p, "cpu%d_rx_packets", i);
> +		p +=3D ETH_GSTRING_LEN;
> +		sprintf(p, "cpu%d_rx_bytes", i);
> +		p +=3D ETH_GSTRING_LEN;
> +		sprintf(p, "cpu%d_tx_packets", i);
> +		p +=3D ETH_GSTRING_LEN;
> +		sprintf(p, "cpu%d_tx_bytes", i);
> +		p +=3D ETH_GSTRING_LEN;
> +		sprintf(p, "cpu%d_tx_dropped", i);
> +		p +=3D ETH_GSTRING_LEN;
> +	}
>  }
>=20
>  static void mana_get_ethtool_stats(struct net_device *ndev,
> @@ -222,6 +236,28 @@ static void mana_get_ethtool_stats(struct net_device
> *ndev,
>  		data[i++] =3D csum_partial;
>  		data[i++] =3D mana_map_err;
>  	}
> +
> +	for_each_possible_cpu(q) {
> +		const struct mana_pcpu_stats *pcpu_stats =3D
> +				per_cpu_ptr(apc->pcpu_stats, q);
> +		u64 rx_packets, rx_bytes, tx_packets, tx_bytes, tx_dropped;
> +		unsigned int start;
> +
> +		do {
> +			start =3D u64_stats_fetch_begin(&pcpu_stats->syncp);
> +			rx_packets =3D pcpu_stats->rx_packets;
> +			tx_packets =3D pcpu_stats->tx_packets;
> +			rx_bytes =3D pcpu_stats->rx_bytes;
> +			tx_bytes =3D pcpu_stats->tx_bytes;
> +			tx_dropped =3D pcpu_stats->tx_dropped;
> +		} while (u64_stats_fetch_retry(&pcpu_stats->syncp, start));
> +
> +		data[i++] =3D rx_packets;
> +		data[i++] =3D rx_bytes;
> +		data[i++] =3D tx_packets;
> +		data[i++] =3D tx_bytes;
> +		data[i++] =3D tx_dropped;
> +	}
>  }
>=20
>  static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc
> *cmd,
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 76147feb0d10..9a2414ee7f02 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -51,6 +51,8 @@ enum TRI_STATE {
>  /* Update this count whenever the respective structures are changed */
>  #define MANA_STATS_RX_COUNT 5
>  #define MANA_STATS_TX_COUNT 11
> +#define MANA_STATS_RX_PCPU 2
> +#define MANA_STATS_TX_PCPU 3
>=20
>  struct mana_stats_rx {
>  	u64 packets;
> @@ -386,6 +388,15 @@ struct mana_ethtool_stats {
>  	u64 rx_cqe_unknown_type;
>  };
>=20
> +struct mana_pcpu_stats {
> +	u64 rx_packets;
> +	u64 rx_bytes;
> +	u64 tx_packets;
> +	u64 tx_bytes;
> +	u64 tx_dropped;
> +	struct u64_stats_sync syncp;
> +};
> +
>  struct mana_context {
>  	struct gdma_dev *gdma_dev;
>=20
> @@ -449,6 +460,7 @@ struct mana_port_context {
>  	bool port_st_save; /* Saved port state */
>=20
>  	struct mana_ethtool_stats eth_stats;
> +	struct mana_pcpu_stats __percpu *pcpu_stats;

Where are pcpu_stats alloc-ed?
Seems I cannot see any alloc in the patch.

Thanks,
- Haiyang

