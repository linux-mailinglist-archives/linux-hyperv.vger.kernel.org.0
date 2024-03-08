Return-Path: <linux-hyperv+bounces-1691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD8876B3C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F278A282E60
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75B5A7AF;
	Fri,  8 Mar 2024 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RiGfyZb4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023015.outbound.protection.outlook.com [52.101.51.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AA56479;
	Fri,  8 Mar 2024 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926343; cv=fail; b=C/+Nn5/sjneDCN5QFuRZ7HWB9aoOsePauImo4FLeM6iUTEXqMb+dMcdPwDbsJ/gA+bbay/eLUXeB2b23ZjArF8Bu0i6y+Rmngy8qeC5numWvRq8/Wb4rv/jwDLC5p56JbQq1J4qjad0S3JzEd/G88F+WytisCQsoNqOotrYbrPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926343; c=relaxed/simple;
	bh=Dhm8vBwfSOpnPM3psOZoJPvLfRFSBPtRot3NHDiyEYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m22nw9UwsUFEiIydESCS5RQWocNuazeeq05uNPRNsgRnIBNDFNGaPM+GMd+E4W3bjYIU/HeoPEUIkHqTy5POpovKlgwtdk559mlflv2KpynamhJaG5dVUD4nDDigQNermImzRkcrjkVeCL8t7E3mvCpBpAfidXcD159ndhKRVGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RiGfyZb4; arc=fail smtp.client-ip=52.101.51.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRYbRzuKaO0iQA9ErmzDeTpoh0ir3PAcZsCqpF/7ovGPK02fIb7w2R2qgL5l2DYXhCDNZuVsO/vTlvI+QQl1FnqqO/h7NwRHlm9ss3X5ybXnuNmeEV2EMDPX0YbwQ4JhB/PnphZqcGlqaT+NTbPFp02AXR9811oFM1bUKtAW2Hwy0M0cZN3MJ/uE4XxguVvf93s2N6ZLhT3+eXiRbxFhmvnV7m1iatIYhBF1fkR3bXGHXKhWidVpjjwL9ahnjp/EuCHcEtS4ZZDeq/D9Clc9/I3krsYGW/jzexDm8FVqzjsrA5xrDssNQPYPtV3o1WyySNJXdw6wQKLJM/d494zV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH47peTn7o+tlhJ+j8PJ/TllzAdCDbf2sUaLguysu64=;
 b=bRfHKEL2ptu3bme/B9lMfqzJYzrT5XsjTpQl3+z2mkBfszO9MntIFsqbzxTso49PydsbBsEcHXZ6H0h1qh7IK7D2HQLbshZLi04yzCD/ISipMDIBn+uDbHQE4K8bAVq6gbkOF/JWznNhkpHY1e592BvcYlCOqb/VEJWCMC5gfTfeeLJ8or8+ImRHFN6B8P9YiRdbsCiSDlATWOHKZLGFCShKB9p7ug2csc1b3l82xQJ538VWhC3hw0hXzsN4C2io/ex8dnaxaBmr0+1FIgXSKdNv5ijSJROYMV1P3dnpW/SidGs6FoM8OeyHxpDCO/7id7cjGCIBmXQ33GO/d5aGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH47peTn7o+tlhJ+j8PJ/TllzAdCDbf2sUaLguysu64=;
 b=RiGfyZb46utwFK6p+ihsYHzBzXHxNUELrRVlbqFCbuhjrsUQGwAvsFrhm6ZFkoGDPOyno1yLYG7pc/PpVXXVBvxUvwsRxJlER65iT3vuuH9eOVFSE2G9CNAOLB9qoyM8bm3Yq/d+xibFVKB3RVzKJsL2KCsxrQrln2sYcihJgVw=
Received: from CH2PR21MB1480.namprd21.prod.outlook.com (2603:10b6:610:87::22)
 by DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10; Fri, 8 Mar
 2024 19:31:17 +0000
Received: from CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401]) by CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401%4]) with mapi id 15.20.7386.011; Fri, 8 Mar 2024
 19:31:17 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon
 Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH v2] net :mana : Add per-cpu stats for MANA device
Thread-Index: AQHacUWfk2HeYZCfmEiJ39aQbYx317EuNjXA
Date: Fri, 8 Mar 2024 19:31:17 +0000
Message-ID:
 <CH2PR21MB1480ECD5D7F0105B736703B4CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
References:
 <1709894671-1018-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1709894671-1018-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2b8cfc48-fc88-43d4-aaaf-335176f641b1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-08T19:11:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR21MB1480:EE_|DM6PR21MB1451:EE_
x-ms-office365-filtering-correlation-id: 46eabb28-11ee-467f-694b-08dc3fa6537d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZtrvSazl6zpYMHl3CeDiPAwu5krlxIlfLauaEhEvCW9XmQMMJZ/7cOE8rY97FLAen9OPuDoIn6PJQVutg7oasyLTnxi5nbKzsb3MhgZSgLLG+eMkx3zzsN+3mRwgx0SGfwbLxAGnFUwEsiUkyn+2OlceXW7/jSuvKDK05A1BaltcHjA9NGjH4XF21ELLwurXNTgIC72vNMhvwgX3wIoG6stp/kH4SRjIkgJgLY+v9hOlE17dRWlKxdKwBKJYbSGtKGyc2etJeQ5UpO0t06C6Jkgll64craGd1c0D0d1JOCaTpWl+SX7rAej52dGJoVAxH5xKXySYXyQ9gHI/WxwWeK67eOUvwRd0AgR1cnNwwOdy/jIgmA6EQ/yxlCuLwyUk1UqTXk9A8MfIxohBQEUKb6c5Ocirc7vQW+9eWB2l7koFMpGZjJvXRwN+sAAGd0rKDi23EPPuI3eyjEbE6tjmlXDR2jYuK9oaH8Sm4Xhy0gLfS9n0urqv8BGsX4qltiJdIgzT2GY+0JEr5I91z61Ml4lqTn4RijKruNekjbfGb34605roslDscet4KSUd7VbNrDxdpHUjgsZ0Xoe8Twwk3P7bWQ+kdoiqyY8XxSwxG+59G4PziyHtZrsIxie1DpkQUvqFMucMPXPssar+aYVxvZm+yClgpjCEdKlgnofSBFnURVUghHcuHQAYlqipJeKcLuoVD4AE0jJHP4+QRg/ln9Byab4vEgp3C9Aahw4tOb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1480.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p9LLeiQqebGd4b3a8ZEujT1jX3zYH6VuwyUi9tD+aQUdLrHLAfN+4/pXPlhy?=
 =?us-ascii?Q?ZAdrHv28xo/RGeT5MewChNo8QNS5FpkEf+DHMDvuUDx49nkEwZ/2HDug9iMF?=
 =?us-ascii?Q?tH8U9Nf6BDdZuqDXarWrayjk927bfVmExw8Aqww5svNf5xTJT/Vro29EU3XQ?=
 =?us-ascii?Q?MYgjiZaOvuQvzBE7DovQKEYVc9eMQ6IUexUcIKaYi9bINeFemEj3xH6/+Sdh?=
 =?us-ascii?Q?cOckBHUVQEsv/YT0JSABWc76/HqBlC0ZUFVoipx73C2rfB03AbBymdRrIr2O?=
 =?us-ascii?Q?gKH3C2iRuJOic5YKG10oq5QkAAcTPVacc7XpjKXnpX0a/rFMfBpGEXfNeNX9?=
 =?us-ascii?Q?VpdhEbEAObgGDvGmhxvnd1q3o20JpOifiBtDizmuNFeVByMbyGltFTBvSd6u?=
 =?us-ascii?Q?SqHbQITKmVHl5n/jXdln6lbClUCGYelZQyDw71wqy4rlD2Rm0Z3/AR/QILt1?=
 =?us-ascii?Q?nt6W67L5tiJlqw/ipicmCodU5ZSH7jMa1tIXRBPt8xkPCA/9Qru/dwlyndac?=
 =?us-ascii?Q?m2Z3Lmj+6loSmiEvBdR0e2uDVJ7f0GAdgIGJyVKgHUf3QtpnudrZbMa83eXq?=
 =?us-ascii?Q?OqfTwdq0EcGUbFJV3rylQoWr3R222D6rw99toyFOccPMCmVnlM0SBCnHwDeQ?=
 =?us-ascii?Q?J6huXpQWoa+ndeTrNHJp1GtpcBH8he6+ObmtaTyEw9ow8wdg7PRY5ij8LsvP?=
 =?us-ascii?Q?pGsoaWKK2bRQnX3OSZYMz9Qz7xgwj521FGuD2WEkSDJLEK5dMNoZDA0xl2Ff?=
 =?us-ascii?Q?xFuRw5eAsd1PNJTvc0HdqtqVAOptc8RNjnmSPrRZ2wexe/qsaNmVaSTx8Iz3?=
 =?us-ascii?Q?56XqEkcKusoDXogFdrHbUiT9rAIaZtzhGr++dMARq0MhSg/TkFyhZsPsJrt/?=
 =?us-ascii?Q?WHHkA+aZHetHXHubEgmXY+oeXXF+aaRdtjA+SVJzwn01NAxdBPPJFA9r/1ed?=
 =?us-ascii?Q?CiXHKbvhmAZjfYkGu5h+kzPF7ayza1rICk7ePkbsuJ5+yPDSZzhV2S3rimJ+?=
 =?us-ascii?Q?qphZbT1uZAZpi3ptjT7UcyMo4ghUgp3cFY95EGbE3byVpgG92tlN9fAyJxII?=
 =?us-ascii?Q?ykiRRjt5RdPG++BZ50gBl0KPpJYY7+NXnyCBODJ1iSYc9rqCMh2JOt0TZ4Oa?=
 =?us-ascii?Q?zgd7nkEC4tnvgMnf6iXKFFgIOSsQVF3jhBDYlqAZ0Wo5BGcnn8j4XBPZ8zjR?=
 =?us-ascii?Q?sFseNsIplyWI4rABogR1oMnQap7CzZt0NJ+1/9cA5KD4zebnOyXAb9efSz1B?=
 =?us-ascii?Q?WuH4GG187ODWe3RrWvR4U+N2n1m1LLRsZhxo5nA/0xsR/M+iV9IlPQE7P+47?=
 =?us-ascii?Q?ASX++sNSUgVV6IqPEAOa8GvvubF8sK/NxGFwXgAiTmmoWeqSE6bQhBa6b35u?=
 =?us-ascii?Q?kg8qeEgeNmVI5SIe/Pm2jzpYWKwlRcm1bJho7jf0dOzoO5sEwGFk+iXTWf2q?=
 =?us-ascii?Q?QmT2fe7xp1F86kCSgsTpPm0Mfm1KhxaD1+uQf0AWDiJ2QKjUr9MMM3gBPplU?=
 =?us-ascii?Q?WL0PBItg6OLYv+9qo9+8+3XPjm1+Dcue2sbpM+FaupW3MRSqcLhfDQoPVZNv?=
 =?us-ascii?Q?btyYS8wWE0+FhcacPNqhmchFKf2jGt0kIusACs+S?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1480.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eabb28-11ee-467f-694b-08dc3fa6537d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:31:17.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uVOp1rPgwJXVS+5iL3bc9KB6L1XRv/A6afwjd8lpbdIbUFbgrf7UMr1Yp2D9HibKEMlm2rsNzpy/sypicBqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1451



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Friday, March 8, 2024 5:45 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Long Li
> <longli@microsoft.com>; Shradha Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH v2] net :mana : Add per-cpu stats for MANA device
>=20
> Extend 'ethtool -S' output for mana devices to include per-CPU packet
> stats
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes in v2
>  * Corrected the patch description to remove redundant built and
>    Tested info
>  * Used num_possible_cpus() as suggested
>  * Added the missing allocation and deallocation sections for
>    per-CPU counters.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++++
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 41 ++++++++++++++++++-
>  include/net/mana/mana.h                       | 12 ++++++
>  3 files changed, 81 insertions(+), 2 deletions(-)


> @@ -2660,6 +2682,7 @@ int mana_detach(struct net_device *ndev, bool
> from_close)
>=20
>  	apc->port_st_save =3D apc->port_is_up;
>  	apc->port_is_up =3D false;
> +	free_percpu(apc->pcpu_stats);

Mana_detach() is called in multiple places like changing MTU,=20
#channels, etc. After that you will use freed ptr.

This should be in mana_remove() before calling free_netdev():=20

                rtnl_unlock();

+		free_percpu(apc->pcpu_stats);
                free_netdev(ndev);

You should test with multiple changing mtu, #channels, and=20
reloading driver to ensure the stats are working correctly, and no=20
panics/errors in the dmesg.


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
Move these defines just above struct mana_pcpu_stats,
so people will remember to update them together.

Thanks,
-Haiyang

