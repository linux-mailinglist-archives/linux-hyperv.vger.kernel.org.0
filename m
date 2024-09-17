Return-Path: <linux-hyperv+bounces-3032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B697B17E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF5B29901
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB20179647;
	Tue, 17 Sep 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gE7dhgyG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020103.outbound.protection.outlook.com [52.101.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E5171099;
	Tue, 17 Sep 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583727; cv=fail; b=Dno8BRbANi+KyhhtJBh02LWl5pulj5NcAQFRQ6XWcOwWtCC9tVLbJMyScymzo+X5B/qix2H9OaYF89SWVdY3567G5/jBAr+CO6v8KtOY8SnOJ4WCraoibjVbgFnsoLi4w6lSCzCUdb+ipeihFiJ6OsAuMmdl+F0rNfkTufYgH1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583727; c=relaxed/simple;
	bh=xZ/wepqkaXLZxuDxO2wZ/VLQGhSiMzNg3APiJDS1kDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJwied7WwwHhkP/wkWYB3KvVLTgD6SO/n6i+qJMlqOj8pp1T79cmlGG44vsMVX4Th5jmxkic9vdBlzV2vWPVBHtTkpNRBrvBWXeXK7pW2UPiJ3A3QwIvDl926l2JITG5/SdstuvGp7HCW1LlreGDGuZgYVJmgueV1avOTGVuX5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gE7dhgyG; arc=fail smtp.client-ip=52.101.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFZWL3BW4WViiSX4/oNG14XJVcHmHCO2h5H3Miqw+/MicOL673eWAozcS0pVKo46Dv7TSJJJ9mJKD/veaCjxhpVIBMwHJ5HKMrf+ggnJv014V6SAmMqZlOOfmayj08gLw/yJOQ4B/07CJeuNf/YVR/QZRHfEw1yxsqpzAnf/QYZOuFf7/9mHKDzRhWPqs5fEF6nJUb7YuUU1I5nl4llyDy5WxMmgHduQCMwA8hwPgGqa/sx0o+rn6Ezy8lcyGUn6QFvHoanQoM7yJ1GpN3+q9E/TWjmI11QTR2fWX3f//Ayh5cERHkrzQ9uq/6znAsp+SCOAg+cY5mwnyjjpX2gKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLAVh3jBZxFzWHhKNW4XIA1ZGwiDduVz/SvSIEsb6cI=;
 b=aRnSdNI/UEvgP0MvtJExIY8jVlzIltOuGHMCWGadsBmyeo5Dr2hTdyN+TRwskyqLlPCDE6nmH+ygcGls1QHh+2xrwgPyKxBz25cI35dj4WaDsp5mL9zT8TC5e8CE1/AsovxwoN3wQ3uWxNrHqZQVij1x30QhKwNUM7pzPBnuFV0/VmiuqyuUyu289RTmVp59irf2vZTZd5Vq1gN05/TaoVF+0j573l7XHaI/KnfPvpNEUGt8tNNj5bUelqwCo7DQaiPPRJ5FR4yXfg1YdI2+5vthsTnAhPjU9dyiH2zkLjE3Mqg6u/ymdjvjHWT1P9A/J3wWsSuUINPYMdfVOUhhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLAVh3jBZxFzWHhKNW4XIA1ZGwiDduVz/SvSIEsb6cI=;
 b=gE7dhgyGIYCrsQMjL0nmUELHrkJTK+wNKkyJ7zuucwpwsk+yCKH0J2AbzTr2xsxHRr0ylgN3tZfhU99dwBl5zUnrSSWDIzUlNaGk86DnErMDKQ9VGYifQZYSS3Hg6mv/evO7jACPPut9DJ3fCzBre/9LerqZkU1pKDl95aNRA7Q=
Received: from PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15)
 by MN0PR21MB3510.namprd21.prod.outlook.com (2603:10b6:208:3d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.6; Tue, 17 Sep
 2024 14:35:21 +0000
Received: from PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0]) by PH7PR21MB3260.namprd21.prod.outlook.com
 ([fe80::a4dd:601a:6a96:9ef0%3]) with mapi id 15.20.8005.001; Tue, 17 Sep 2024
 14:35:21 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ahmed.zaki@intel.com"
	<ahmed.zaki@intel.com>, "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Add get_link and get_link_ksettings in ethtool
Thread-Topic: [PATCH] net: mana: Add get_link and get_link_ksettings in
 ethtool
Thread-Index: AQHbBOeybZTViwmNu0ClIJxwZ4fwXrJWoTWAgAVwXIA=
Date: Tue, 17 Sep 2024 14:35:21 +0000
Message-ID:
 <PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
 <20240913202347.2b74f75e@kernel.org>
In-Reply-To: <20240913202347.2b74f75e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=490717f5-3f4c-43bc-b835-32d71e7fd4e3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-17T14:27:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_|MN0PR21MB3510:EE_
x-ms-office365-filtering-correlation-id: 37ebe5c1-51da-4eb1-8d87-08dcd725f5aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MH/WdvlF7iAKweKvMBIvrSEozNQ14ugFZucIyN5V5XHQzh9YXu1E8FT6evkS?=
 =?us-ascii?Q?op+lXPLPc+FRtc57UrFCS+ciDRTXqFHZr9jQJXVtUsnE2zStsR9+P9FS+OLX?=
 =?us-ascii?Q?mKa5KBnP3Qup4TCTj4r4sT3Sn2D0TGhkWbaXWHC27QSD/82hX1xrWkSAzAb5?=
 =?us-ascii?Q?te99T3DR7BqfaT5hnSbt6Jhem5EdUqsFLCSDSY+zt7FSR3hv/w8/i4xIJDJ6?=
 =?us-ascii?Q?j66IlSNX2+fuylNroJ2Qw7jMqMv+w/vDcfjIxJprk59FBxFhXHefH7wGLgPk?=
 =?us-ascii?Q?qtccFFQyi3JM24gEia+s4k1ZHv0cMO8sHOSaAh8MEe6kSQ2HKsA/l5NlC/YT?=
 =?us-ascii?Q?wYHbCzPd50BBz0I8PsT2Gzf9XLCOslIbVIci1FtyorB2gQT2y8TMuj7Sk7Cb?=
 =?us-ascii?Q?bCNofi7xT2ZvOf8lkxFJm1NFj282cvQrgdcjB4KICX3nsDGMe08TOP1yC4Wk?=
 =?us-ascii?Q?5WYwkOkKjxX4YGeifCyhY9iOdLS0p4AgkrMDz7GeHfkDSkvHNooGFXdSNszU?=
 =?us-ascii?Q?FsaHTG0nJSTstLBYOWSxk/uIMRD5EwOc1HbiuRhKvJZd60Fzk38KsAiGtzjd?=
 =?us-ascii?Q?QgkOdRJTrn0LkdtZAejCADiWZAZG2xtyJ9D5Gfp+f69O5uAAZrFXJCMXy2tk?=
 =?us-ascii?Q?Xhryw5ztBfA8CKB3iI1KS8plmAjc09RfLohwxdpioZqWOStpOZwfSSfd+x2m?=
 =?us-ascii?Q?blfElqc6306SIrLyOzQ1Zt7Gpq7Y4YC/I40WXwDvIN5uPESd0+9q8zQ1lIPY?=
 =?us-ascii?Q?nE2wt0sBZ8+bu4+/e0kxUTi6+7UfMk1mH2RJNlZ+EMRO3XQZSfedeuGTx46c?=
 =?us-ascii?Q?JyHjO3kopJnc8FYNHVbbO/SFSKHdpi2FvrT2Qvsp0kJ/oxNvWXMj1OWx2/vR?=
 =?us-ascii?Q?Amlu+WEoA8RYZnsM5mH9TlYRUiFffbF/2YHGLatdW2d696JUreEAhSB8XCmd?=
 =?us-ascii?Q?royp8VdNAmRlNCLDRjRx1gP8kcCWQaDP1wdFIkaU+Ez2OXRU7+Vl06dQD2JU?=
 =?us-ascii?Q?7QwHiphEPyeCDOnjfPfsSSDrybJm3EdSGLrfC2Nxm9POaHtYXjEjJ+5VmzIp?=
 =?us-ascii?Q?TVi/PpdhTWAIT6vLEewiJHGRMOgXiKEhp6Y3S5+7FRViCIZDiRDv0Je1HScU?=
 =?us-ascii?Q?+CAJRrM3Vyz/RQHF+Tq4Q/L7BwQKD385S+qr6lv28kDEO/Gejq6+qKyiC59s?=
 =?us-ascii?Q?QKAqkP0bnT5QCuue3wLxbBVM3Pn2PRzvjBWeQmftH8RLsKTHmxUqizYEIe9Z?=
 =?us-ascii?Q?CzCxFq9/VN7Xe/dRzp0bjLrs11BofAu3pBTDxwHIhkU83ZlqIE718PranoOU?=
 =?us-ascii?Q?v1XZTLlEUZL363GHMA0T7CGJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3260.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sqswGb+TP8i9CnVBvtDW+RiODqMuCHC9Q04FntV0wBK0NdO2aaM6fsRSIDyH?=
 =?us-ascii?Q?pGtd2jxrODrNcJbwFHdep8MWg5hhP9Hu4htBAVk4cEL4LriTa97cL3aTCsCy?=
 =?us-ascii?Q?OnblrHEAuOU4i83nidlXovfF64ixqfcCtWGPkLMFBABrMfZgimD+jAI3sLTA?=
 =?us-ascii?Q?XrnwoR5YySIZO0X7EYTZrnJbfIXCGtFbNtVTNiFDYrcLFZB3opgm/h/R32fU?=
 =?us-ascii?Q?J4sz5BYz1rMhVSm1VIsrWBQaM/TpGN85qbrXWSp6sxwMrt19nBGiJrKpnr7A?=
 =?us-ascii?Q?U0l4JuAkKD7NPeCx1R2XAlel/nAJoBtv1jYQRev8HsyJ3dqvRxiCn/Mdd069?=
 =?us-ascii?Q?47lmTGHOIYmKVhKVqVWMaQUcalr294E3CA4pssPG9VdkQK/d1iRu1qWKy7fe?=
 =?us-ascii?Q?AMKpWSb+lPWJOJG1wDDXUAnFBeh9h0zZpY1fzQtt1USWkcA+BCS1Vv4ylap2?=
 =?us-ascii?Q?Xm/j0yvAVYAsozf1262e2my7hVRlM3OF11c2hsHME6zjlNzATScr85vvy0Ly?=
 =?us-ascii?Q?qgG1H0RDyDxeIWUzdeItXTvWDq7WQ0UTcp9MVcEnNEkyRe/Y/nHu7NUyYCXg?=
 =?us-ascii?Q?Y1kvkGHDE/VZsnnne7EB4BZGg7m4EHhQ7m+ZUeJo5eEhSAc1n/VHAJwVC+LV?=
 =?us-ascii?Q?ilkQkej/+2M4krUHkWO9k64foqIBySRB0dX+3X8dzaA0s4rROH8Wf0nvX6fl?=
 =?us-ascii?Q?0egnYuO+w16bb/uJbCo6ULmvBEQDRlj4TKmQYN/8O1JOvS2dY7qGziMTc6fM?=
 =?us-ascii?Q?+k96g/Hu5X/MXXGK/IEzaIjdn42sdhXFWbBEdebG3XuwFFG6XNjWg4it1gam?=
 =?us-ascii?Q?FKqrJ/8QkjhMJvTD/Y9urZCIvIy2XzULzRCQMrFWC/o+4qSdND3N6VEfxiGv?=
 =?us-ascii?Q?UZVxHs52IO9HIMtVSxZgKrG6jhngKlnZxoeV1Arv0WxjfLmDJdMmftethFsu?=
 =?us-ascii?Q?uMFTqAmbxRT07n6p7pVL8RYQOwgN8izgt9xoj7v91us9sby+vq31Y21IqIC3?=
 =?us-ascii?Q?ITRGkJ7jgGRVJLikMMVz/FGXqTUZ1HKe/v81VKrZnBZhX78GkZILu3gzMU3C?=
 =?us-ascii?Q?6cf4Fm/Yrz5tKUZONUwyvgxpwoL6r1bP9Qm1FaZE0VRHkyUSbRSE2Y5rZ05d?=
 =?us-ascii?Q?UpOthsHhvuR5pJ5b7YjwqcgvDjxsM/f7WjqiFngel1Ogb/Nt5mXQB8v3ey+V?=
 =?us-ascii?Q?eV9A70NfJr94AAxzdwFuGfzODbpG6cYhtwipaR+KPwVjgl6udB++bsi35z4j?=
 =?us-ascii?Q?dmW0+kDnvoaPfo/vXdkk2ZhwRy7io44pXxanokXi4JuL7RzmeKkwVTjTtF1d?=
 =?us-ascii?Q?rI7Su9OKZm0Ty0Iuet9EBm8KpStriaMIYlarEvkpJW6LJqCl2w7AJW4wbUkW?=
 =?us-ascii?Q?aMf2hoQMqH8JkoCGDd4gK9KrQXqVbtUyaj5lfo0r27aL6mts6eY7sKX0vZIw?=
 =?us-ascii?Q?NUR74siNpi20JEd30eXPUP+JoSWA10wPjeUTxFY6aGBqNGw7sh/nQpboQETU?=
 =?us-ascii?Q?v8lKWgRPxJWslBa5SQMfsx3Br6xpVNohjauzHLwUgmlO/QGeikyCecKZNlGM?=
 =?us-ascii?Q?8YV/yJ3h3Hz6DvkVUJy7athESbMpXPdPWmr397QX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3260.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ebe5c1-51da-4eb1-8d87-08dcd725f5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 14:35:21.5084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdEBaaHqUUgn0GBFKVNmSsqGqSKxUeiwlEygEzXfjzrLVTF4GimG2OzCGf/jMp1AebDN8BDHbwzogOA6luvhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3510



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, September 13, 2024 11:24 PM
> To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; shradhagupta@linux.microsoft.com;
> ahmed.zaki@intel.com; colin.i.king@gmail.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in
> ethtool
>=20
> On Thu, 12 Sep 2024 00:44:43 -0700 Erni Sri Satya Vennela wrote:
> > Add support for the ethtool get_link and get_link_ksettings
> > operations. Display standard port information using ethtool.
>=20
> Any reason why? Sometimes people add this callback for virtual
> devices to expose some approximate speed, but you're not reporting
> speed, so I'm curious.
Speed info isn't available from the HW yet. But we are requesting=20
that from HW team. For now, we just add some minimal info, like=20
duplex, etc.

>=20
> > +static int mana_get_link_ksettings(struct net_device *ndev,
> > +				   struct ethtool_link_ksettings *cmd)
> > +{
> > +	cmd->base.duplex =3D DUPLEX_FULL;
>=20
> make sense
>=20
> > +	cmd->base.autoneg =3D AUTONEG_ENABLE;
>=20
> what's the point of autoneg if we show no link info?
> DISABLE seems more suitable
We don't have strong opinion on this one.
@Vennela, you may remove the 3 items related to autoneg.

>=20
> > +	cmd->base.port =3D PORT_DA;
>=20
> Any reason why DA? I'd think PORT_OTHER may be better?
I'm OK with PORT_OTHER too :)

Thanks,
- Haiyang


