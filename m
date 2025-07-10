Return-Path: <linux-hyperv+bounces-6182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDFB00CFD
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 22:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597F2567BCE
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF52FD870;
	Thu, 10 Jul 2025 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DtmNnVqW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020092.outbound.protection.outlook.com [52.101.61.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68521CC63;
	Thu, 10 Jul 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179071; cv=fail; b=B2Ar0l5rkjuRD0+Ez+LSATZ3lhKg4uyzzsu94yVmNskRmQIPq0j2FDDMWUr7PBazJ9Hk0mKHeju/0KxHs8hB0ri9rHWG1oEpMg0LL/jrk2RGid5YPioTBxUu2AjhfXeNlcF8d1RlB2hR6/5JutkOvGBLXnp87RBhC48QvcxEsHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179071; c=relaxed/simple;
	bh=1SNu9U5qJZEBgNrv0husWSnv3Deu4DwnNX7OBwm6p9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDKsj+9kJCWx6+k1U2eVq840BrWwP4qfpuLAcCRxj2joaHYuDZy8Gc6xjL8WppsH7nEXI3yMqwnxnOG+FnfBHnlDs50ISQK7Br/bqVjDuUyxcQWHxiMO+MY3/Ows3htDBSx5jtrQZP2gYCeAwnnXpB/OV/gDdEUdDgvGJMrnbAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DtmNnVqW; arc=fail smtp.client-ip=52.101.61.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1lka7rK41ClEJzZ380J/+LPf47NbY99RMHy9vTWrnNLjPv5tEBo1oxjpXhkkDrTuKumKYlDprSLDtWavYVvn74rvegmBiqP37HPvVuM6GVA6LlBhIvt0eIENaaTJ+EDlCNoeqz+btzHnHASLfk/eCrqQXtjfvwfKM8mzIQpWoFy6HY9PHmAZ2PYxXtRWkXAWB0AAr68b9S01u5uvEyBDDjSHcJ+R+BBj4QQ8K5Hpt9GBszFRmmq2ro6szWIStkQlYd4WRIBsbvFHD7wxJbLupdljOzM9l98k8Yvb+XkV6bpXI5c9s1Rb3Zt8rAsxfRg79OryleyKLinAMRpdC0nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0q+Tiivc/wWRqdgBib7VacU4UG4WktdT2uzudtbPW0=;
 b=NF7TKXahU9aC7prgIFQ8k9acHUUEmPQi9Gsa4WpUzzb9k+AwdA7lJDK6fwuNUg/yysTFEcDlceBFXGCR1IilkiYewIQWQlSmkRih/3ofKg94dLCZ7KO4sTgGVb+84WkPW2hdHPhArILJNegoB9udhnOjLCUVP4fjStZq9xgWxFsKsY4trrMhcwmSlRr0PmEsyMHv/EtQl9lI8/UXr1smXUn8lXSbxSznRquhZXbBggEXsWb8++pqEqhtVTUjJyWLJH1b7H/65y5NvAF1TevBdJMFIW0RipLvKCZpx7wkEOGfY+F5R063ow0hu1OmWwzMaWllAOxJAXRj5WVSEk4qtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0q+Tiivc/wWRqdgBib7VacU4UG4WktdT2uzudtbPW0=;
 b=DtmNnVqWK/N3pX1VvRYLg7ptUKumaEJKM/1vCiztMWmDOJWdJlMI8/MRp4DJ7Q2u8jSZG1AoGH5u0diCYdevyK+UB0aOYZrAYkZg1LnGVLfP98ebG+Ez9r3GsJ0ZEayoV65Y1UhLQwoUjXy8wnJ1fn1Hw7pBwQuZo6OGUi7Pp7U=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by LV8PR21MB4109.namprd21.prod.outlook.com (2603:10b6:408:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.6; Thu, 10 Jul
 2025 20:24:26 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8922.017; Thu, 10 Jul 2025
 20:24:26 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Li Tian <litian@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Long Li <longli@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open  to prevent IPv6 addrconf
Thread-Topic: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
 IFF_NO_ADDRCONF before open  to prevent IPv6 addrconf
Thread-Index: AQHb8UTQKz28xLpGTUyYQJQOnUq/tbQrzMdg
Date: Thu, 10 Jul 2025 20:24:26 +0000
Message-ID:
 <SN6PR2101MB09432681A39CCFACE2689BEBCA48A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References: <20250710024603.10162-1-litian@redhat.com>
In-Reply-To: <20250710024603.10162-1-litian@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: longli@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f05b6ecc-ec16-4fac-a54a-05d73bdcf483;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T20:17:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|LV8PR21MB4109:EE_
x-ms-office365-filtering-correlation-id: f09bef2f-d9bb-4861-b723-08ddbfefc438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c0ihhmFf03qOhSxzrIP88zKstTzKY21+FAA2t/L0puvC7kUro6GAnd//KmgJ?=
 =?us-ascii?Q?nsQ74q1wUYxODZirEJcApmwH9J8xqP0AUMynOqnNa7lGaOMKKrtzIjefhp9f?=
 =?us-ascii?Q?lwpV2egB7+0vuDkivAXX6Rcgw0GgEG44fQqOCvNVUz/HwinsJuXJAc0dw8eh?=
 =?us-ascii?Q?dyEL2FLsGwSutNlcpUP6aOJ/9BHmyqDNcglklshVDj3KQ3g3/Ah2vv9GZC0Z?=
 =?us-ascii?Q?Si8eigUfJitocPO+Xc/byAS6ARvU4IF9vsdplUZyu1xzGSj74yyt4VrLrRwL?=
 =?us-ascii?Q?KhmQkbphcH6xiuRmnZVmIEdua3KXXSB6NeFDlkc1EUUDyWFKK41O2at1gBc7?=
 =?us-ascii?Q?e9nJa2/2R77mq8DPlfaBvLx/Oaed+7hSNZdYptDCWTQakeJpsRa8aU2aLNse?=
 =?us-ascii?Q?1gOvS55c+dfhj7yfS7etrXZJqyjdwDBQzBHJhZRRjOSDW4eXkzHMgmLUdrhQ?=
 =?us-ascii?Q?MMEzNFI4Se6iM0VBVwuOyKf2oJ7iVkZ8y+sFzPXbRwKHrIUwtPF41X53tiHW?=
 =?us-ascii?Q?MVhlZWVAd9wyoMya1AiGXgjq9j7MQM6xNV1uBatbDXz/Vc4dhTPT5aQXtmc0?=
 =?us-ascii?Q?vef2DkTH5O849oCOWNEmfFGjdI7v6cIfkiWm6HIM/GKuFjqTRyceACK3cly6?=
 =?us-ascii?Q?sOZWGRn0engtWjxuNCIlpNTPozRVKTa2cw4a5WSrR4E7TOC4/ReZZUgn5spR?=
 =?us-ascii?Q?OwqnvVj+RGaJfcIpufe3gDVhoTwL8hyDJp+jb9z4zjctQmD+O28cCX92Phog?=
 =?us-ascii?Q?37zpzg2nY3XJ6XYum0e6d4FU3fZIVeUfAo8dnaaDDaYb6uJGs7Muq/vfOBCw?=
 =?us-ascii?Q?Qh4MrfwoEcFo+wm3/xxhiizNSdivOJESO0yKJ5/N4ytT4X5EXAf4b9c6MUTq?=
 =?us-ascii?Q?6ALAIC3EBUmin13eAI00EKFUCfkTqvHOd6fezvNJPW4VxZTQezvDbPzLOs3Z?=
 =?us-ascii?Q?UZ6l1IiHjcskEqHSmopT1R3Hk5oT4fZaHJxuiCU6d6TYhnfnwWoMBXeTXoJ6?=
 =?us-ascii?Q?59+lEcApar/mHHnVD/hxsnmLXl3f2Z7OHZFOjm1gckkkdkJXZbw8ZoKdYAUi?=
 =?us-ascii?Q?j6n8UFEQNrBVxxNi8ztjartiiPH41jfajZoVkOwfW8n0dfc814CUO9vMUo+E?=
 =?us-ascii?Q?oQJekpFG9jcngkmVFwyiTvfi6XvXpWwECTBea1/nRhaSueetwwU9Ft516Fno?=
 =?us-ascii?Q?xgEEDLpzrzJcBfolqGkKFcj9hj3J7rqGQSSP6NGCyiX0+D3rtoxpvgI/E/Le?=
 =?us-ascii?Q?xUzzJ4HILY5cDe87KsvwjcR7Ut7vFAM06jBdiD87/o4Sic5tZbdLIvoa1AIX?=
 =?us-ascii?Q?Vu5kq2W9NUwzxIZO3MKPjge3sAWgkkpVycEGhBLoONNKLIZdYltqzr1+GPsT?=
 =?us-ascii?Q?FEdF2W/ZG1+CAucERz/+hV1IcdK/PEUrmP4b9jlP8W2fjA0udmx0FCp6KHeW?=
 =?us-ascii?Q?kI2oAH0U2S1Jh8TCXx/DrfybxtHpoHxNnTxF0+12rkBKY1nWjSTHFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ECtz5BLKoU/Ph5KxQxMKA/j/3BbxYB9faz96DPh/NSwIq71IO3jj3WSAJJd?=
 =?us-ascii?Q?91B+s/f2DhhNezfGuRNyFGNmwBtD8yfZzmQGZUexwASH0Df9zmGpSlePij1M?=
 =?us-ascii?Q?IuzILqOspgNwqmOn4lz9ebhCwYR0+6f04PHApETuKC8HjVaWlpTBceo0JL0p?=
 =?us-ascii?Q?z+/nJ5NDW5ZPb27nNMbfARl2EbXO8RwtiJCGsNOdBYzb01l+KfDRrp/rdPDp?=
 =?us-ascii?Q?UMp2c8JLfM5qFKGvMQbOKpSCIjfRYP9QkbKHwFkAg1HychZ7zbsSBIWzCvDH?=
 =?us-ascii?Q?jgDbk6R1kiWloi+RNKR6fybzJrcYvQgz27TDOQlL8puLVGMcb878JV3UBgb1?=
 =?us-ascii?Q?kIg3qBz5AxWO5EbBYibWfcRuwkOZQUyyRo0Wu7ODdnP1W4qPgexOzW9s8UeV?=
 =?us-ascii?Q?FiiyF9fOpUF0xvFCHJ67bk1hyBnRnp8FPqNVsP2fEhkBLJUrn46oScRrwLk1?=
 =?us-ascii?Q?gAeeXENHsxhvme2Tc41FSV4AEv49AzZKy79+L7037ShSJk55rF2Eutk75QrW?=
 =?us-ascii?Q?s/RQGGmOEqhvc4kTmFEWY1lAZOfo7nv4NpspaLVsjSsJR/6fWggdxNHMZD7o?=
 =?us-ascii?Q?M2Wh8sWjDXV8kNEUjVOWtkGbV+Q+YSCEp3REfcf3uEekaBUVO3K/hjrud6mT?=
 =?us-ascii?Q?ctom4BF8UIbNeaHXrn5EZFyD7KiCuMKHrz22oO2Yrn69Zz9ja2FULslW1e3q?=
 =?us-ascii?Q?a4tjC0G0dj33ylyI946xYe6rQC0US9g//yfUodp7dNjN5evT6I9He12PliOK?=
 =?us-ascii?Q?b8ZjlxCwm4BqVucrPBlRq0acJePEahOOifo03TdHFYMblTzh/yAEog4CQNFw?=
 =?us-ascii?Q?K8RCX0o78/mbMhG3D3H+dau9EoT6zJAhavWkK8FXpOp4vIhn5hYwaIMgkTHT?=
 =?us-ascii?Q?YD7ndvywXD6JOgvK5CHmzv3b9S+hM2SP/6c3BA78euxV9QBPyqFjojoD16FQ?=
 =?us-ascii?Q?reUjZb4F04C73SXBdvyBnKhc8rfv0GtTV4y64HQUn8k+zh19APt2kGP5iWAM?=
 =?us-ascii?Q?/qZjsG6eU77WLMVvaTxrW49L1iG9/f+bIv8yYKVu+q3s0jb35axeWsNr/ozz?=
 =?us-ascii?Q?VwGE7j6KIlIXsOmpEYXtBngdzr0Akc0243H6rN/wIcElyRZLhFiNyZnwjZot?=
 =?us-ascii?Q?Md04JQonahWbbjvfv6EjDOkmWByg8Bnw4dekYPZIusjQxD3oZWCMlm4WHTLT?=
 =?us-ascii?Q?dPCIkYiqmGdwQnybzv451Ibx/tsWUVgNfHg1T6mtkpONw92qK+3ck0iM+8dz?=
 =?us-ascii?Q?0c3cpn3DXks7tJiI9JioTtLWybZmndvWOjCDaiKC4xGJnqfnmh9gJXsEbSM6?=
 =?us-ascii?Q?gr8jXqJGZvwOMQjlKasgwEbeGGgHUtT8WCS+bt2VavCq/Iipu801uSmuWQ1p?=
 =?us-ascii?Q?1qHrHcLTg4XIyCABtj2ffnY6MASTATL68uYAm2Lp56MVjJlYVRgJJgSncZQ0?=
 =?us-ascii?Q?pliYKvml/SXK7bid8rw9b2Nb1Cp7QpDFTQkb+gMww/KzM8fD867LZbdCCUXQ?=
 =?us-ascii?Q?3hIYazJsTtUvtnjkBhTF1atnHjKoGF1tyJI5QMSH+7D1GFEEAB8MnbHn4mDS?=
 =?us-ascii?Q?RZZdZhSEiGxXkGnyRgUOiqdTqkOJ/dtY1r4Nz0TV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f09bef2f-d9bb-4861-b723-08ddbfefc438
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 20:24:26.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqwoO9KOY14yv0eYlDd0UoIlXisk8hKbj64jIURvgWDDZ6FEv1rSr/JnxivNKfxZdDxHcwzJ1xux7cYy8+ySlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4109



> -----Original Message-----
> From: Li Tian <litian@redhat.com>
> Sent: Wednesday, July 9, 2025 10:46 PM
> To: netdev@vger.kernel.org; linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>;
> Dexuan Cui <decui@microsoft.com>
> Subject: [EXTERNAL] [PATCH] hv_netvsc: Set VF priv_flags to
> IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
>=20
> The use of the IFF_SLAVE flag was replaced by IFF_NO_ADDRCONF to
> prevent ipv6 addrconf.
>=20
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6
> addrconf")
>=20
> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
>=20
> Suggested-by: Cathy Avery <cavery@redhat.com>
>=20
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> index c41a025c66f0..a31521f00681 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2317,8 +2317,8 @@ static int netvsc_prepare_bonding(struct net_device
> *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>=20
> -	/* set slave flag before open to prevent IPv6 addrconf */
> -	vf_netdev->flags |=3D IFF_SLAVE;
> +	/* Set no addrconf flag before open to prevent IPv6 addrconf */
> +	vf_netdev->priv_flags |=3D IFF_NO_ADDRCONF;

The IFF_SLAVE flag is still needed for our user mode, and udev rules to wor=
k.=20
So please keep it. (you may update the comment though).

cc: Long Li <longli@microsoft.com>
@Long Li

Thanks,
- Haiyang


