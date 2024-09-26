Return-Path: <linux-hyperv+bounces-3075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07AD98759C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC21F22D39
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355D7BB15;
	Thu, 26 Sep 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g4ZWBhP4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020092.outbound.protection.outlook.com [40.93.198.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873C2AF1C;
	Thu, 26 Sep 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360998; cv=fail; b=PfeeiBZZ0w7ljrF7uOC/foGN02jOZwf5CphVNLe72RPkYQjBFeAY3xElZV6RuG4BscN5oqcul5umQ1FQdjq3zU5ATjiH8w/VU9Kib0WrO5V6W0t00MoGFpyb47Aak+tyiFWoT57GXshV6bR8j9ZEBEoMYH4cMpS4/pEqkwDOaCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360998; c=relaxed/simple;
	bh=iTPkmI7mZcqZuSrGFDCDiyXG/mm4b6aKrsviwR4HR00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmkwOttFf55plrBycMomY5Jbr8Vn0bQtrOqiGVQAr16h9ut/3bRMyCUqulzWYi2JwEcgUqq8VIgQYWwahN7SNtd553FO9kI9tTCjgcuAHj6LSHhgAgpzZZmGzYUHiNkeEBzIKRO4hwTxP66hpVKfWH538MiwvJp92Ac6+plu3vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=g4ZWBhP4; arc=fail smtp.client-ip=40.93.198.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW4CecFF6tB0NDBWm3Yc2fHbyjg0Ze3VG+S9Lttz6YdVU9PiJ6S6LcSw/1XZpLKXy9Z69WKLRQlV9fu9zi9wuFZ74Nl09Bt8UKyHeC5Qlx9zssx18p6ceOFjf5B+v0i27RjvnouVqkvr8HxeNRKsTk7La94n8pjO04B0GZh0XlXXbyoPBnegyq2tiSzg2FpyriMvA5coQhHOXQ/izOyH0OUGeayhVgSEiB5I/wYhoV02dxe6rSkPnfGbMeHDt6iez+t+n+YF+GLu0lSjhkS9UpTz97VTBUmZD0YZiWPIYXuKZnIdPPnq7RQXnn+UyuA9AeZIzpY5M0bgBVxjC7LpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTShzk2RgeCdZ3gXNi3pPLmOaHsVTlO50QWSCbEkqfE=;
 b=rrTl8xmZnASsBr0GpKKJBqCTa0u2MNAQ6dUnyx7R7jXLKh9JRXT2kEWNS8YciaP/BzSsCA5KaFl+9dIJmnBLQrkxV86JBHEy9TCc+VzKhxehfW0a2LBmbwvVdR4g+glRvOxKyzOi2BdioWDIGds24Pof6iVaSY+aSHHAbD7zmrQ54YmRy0C/qsD4ej8RBG/Vio3pgyFZjMWNr87Yem6c/Rz6xxciYJfpQXlAQwgm7H4BhYUZ5ehGXLd+2RZs4b9tIBnd1E1SVIxxy7vDI7jU0+nezvBFb5Q9sMqh1oOGSebr5T2Q36eyF8wRZESjguyZOK3zIj07FjapRxoarG3L6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTShzk2RgeCdZ3gXNi3pPLmOaHsVTlO50QWSCbEkqfE=;
 b=g4ZWBhP46MZYdI0jpmEoSB3ZqTn3evYsaNczLKkP8XTJpSkjPPKhP49faCULT4KjsroUGWEoRlxvuJ6/8bCZv3p1ituRWnJhS/PUUvnSx6hYDtQ1xGMprSxFqitUoi7809TMDvT6TIeAOL9O7mQPITICfhfWSTYKsTtpe5zrK/g=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by MW4PR21MB2057.namprd21.prod.outlook.com (2603:10b6:303:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Thu, 26 Sep
 2024 14:29:54 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%4]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 14:29:54 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>, Erni
 Sri Satya Vennela <ernis@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Topic: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Index: AQHbDtyDLnpN2WTv30usPP8o3/gudLJo5syAgAD64ICAAEF9cA==
Date: Thu, 26 Sep 2024 14:29:53 +0000
Message-ID:
 <MW4PR21MB185960C6EF7800171E5D8877CA6A2@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
 <20240926103443.GA3014@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240926103443.GA3014@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7369f3f-d47a-4386-967c-c9230815b33b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-26T14:29:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|MW4PR21MB2057:EE_
x-ms-office365-filtering-correlation-id: 41ed2196-ce7e-408e-4e10-08dcde37b027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J9u0pKCalkztuFba/kIlSW22WurEK7JcsHFR9Ko0SiR2VjSPVglkZubVeI+U?=
 =?us-ascii?Q?TzQFo2q5Sl6b/Wh9wxNk9pj8bLO4/92fG+mP28K2tf5I1aSeoM7d04/O3zoT?=
 =?us-ascii?Q?TEOPZdwez/9Mb3wB5clYnPibMJHwyUqjsPS7D+8cntci+DotYVUhwzjW/iPE?=
 =?us-ascii?Q?dm3b3Vu7U62T+0i5GjFWARSwVEsl3qzVi0KFP/omhmqggWpOVx0jG7b9+Ike?=
 =?us-ascii?Q?pTthXIhvZRwyTLttgJhHtSPpkKd8B4cY1ORwCCsFXLP5JL5OgwPiD66PffB7?=
 =?us-ascii?Q?igUd1oeh+rwYdnfj9DeUW5vg0FzbunEcr1Utr0wj04HV9z0KlG5sY2eMKFm7?=
 =?us-ascii?Q?KQyyPyKXH/FnJgLVIZMsPVS6BcPRi6e8L0y4Ztrbb5qIwtdGvg5yUQ+XX7Vk?=
 =?us-ascii?Q?IAmADLRzxzduPh3dVie41CyYhD+dQofpcupdPPbVpz+Ui7L0Rhi1bpeapdnM?=
 =?us-ascii?Q?/Gc1y9y2673JRnoAue7saZSLQazfCU6DQNNXb4mVoGIyO1ubIBo1iOZgKFKt?=
 =?us-ascii?Q?r3kRd4PMWRGYoWW6kx66RSrGAUhr4Q3Z7ksVI+K5/J/iOhL1lgkJBXJiXYxI?=
 =?us-ascii?Q?MX07kse7YBIvUFwDOKbfaQ6YtZo+LfjbwTa+IY4Lj3vSpItV9QcUgAMDXYXY?=
 =?us-ascii?Q?wiPNPa+LIz0Z/5mk921HgPWxwqLXqNy2o0McGw9oH/JaQ/J/G+pF5yigI9e3?=
 =?us-ascii?Q?a3OKGLfEXE/6OeRDAUJn2IsAkxSot1BtnSq0FXqUYL2zeLRJerWkaOI9IT+X?=
 =?us-ascii?Q?xJi0Cag4BF56IWYBdnsI8GccwBBvVb1oX52wdfMOjBa9IuQ61hs5UNoSFIoZ?=
 =?us-ascii?Q?GYZapdsOnN2DuIUVeQZBJxgduYDR88Ak9BspIDfdPaDtpQo8wgubEoNDgRCL?=
 =?us-ascii?Q?pksEGWTCg7iZv+slCO7KbcS8lSoXRqJLzM+gD3vmBEBz3OtQ7w7BgtL05qtI?=
 =?us-ascii?Q?yTpQtktu3pmlk64y9+0qqeUHJkOoxMQOAG8dTCaJ3u25lvZ+HgPkCv1nqhC5?=
 =?us-ascii?Q?X3hgAFGHzamz7pUn+F0C/b7w8s4ilwdUnJu2qU46pDdTN77GtepF+Ohw8xVs?=
 =?us-ascii?Q?TwbqKkdvHFq1G1m3LFmP5+l3l07uDYuMjcrbR5Uejy3SDhm5UlPuhh3fXj+s?=
 =?us-ascii?Q?/Vh3f5zudQvdc1iaPfD6Zqo+fHvCPMaJ36nFxphb967imSeso7ji3TGMB8x6?=
 =?us-ascii?Q?VbFeWpKpXzcXrmLlJFe0ibsLH8aQRdAi5774aFCfddMROeDQNtxqz3X8DSSY?=
 =?us-ascii?Q?SaJ+1+m53eC+D4yV9Awz0aD1j5TC2hhAEe4RbyXIKhi37vMes5385Yr431Kd?=
 =?us-ascii?Q?wNYbHiLb5mE1JyTfqM4dnqxEz8r8nsGiaUJnQf54M/uzlw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BdFlWkv13EQQ89uGC8BGMhQARLlTZ31Apr2GHMSbyW9YshCI6HjcNOXP9ypZ?=
 =?us-ascii?Q?PBvaGxtoueTlgfXCR9R0qMCoUZjOcdC/Ne0DP35MMuxhSJjMZC5n8B4KBO0X?=
 =?us-ascii?Q?BWNVqQAzeg/baLVY1Ue2oemby1zQF1nclyDdHnKkHWNlF+SITsFUtaPaDph1?=
 =?us-ascii?Q?xhWI+VN+kLFA7//qe1h+bSNR3lRT+dK/oEaLlgLAm0vRDKpHxHM0BhUelhGo?=
 =?us-ascii?Q?an8Ze7e5AyUQ4FVe/o27kP65+HhYKEXaULh/VG9kO1tK1q12EvPrS1xoWK1k?=
 =?us-ascii?Q?bcbJ9v0WX+uJlIhTKo36pvobvyhKedIoskWeUb3OPx/gpB1ZNabq4PbYp+OK?=
 =?us-ascii?Q?lXCBH6o8MaPryDimKAzIvu5twkGt5BnO2T2H1iQLyuFqot6SwlVv++P7e8SN?=
 =?us-ascii?Q?pERPUXTdaHcmhU7kAJC9U7JfqjIlwfqkjT+jqOVTWdIdkBRa80CX0ZbOM+VE?=
 =?us-ascii?Q?35nQ3PvEleEDaB/rk//0RsIpJURV+2HUBvRlvhy6GVZMzH3mkGbZhBuZl9Ep?=
 =?us-ascii?Q?mACiJg+CX8qqbyG+WRDYnrfW1Rm/7QtRpXvXUmFmVYbi2rqoW/DSzR1nZlYo?=
 =?us-ascii?Q?eJmTsaUQI/2TsaJh1KUnebdR3DCN8Sat/GX7BrvcQ6g/4dDIFAHGvC4GAkCu?=
 =?us-ascii?Q?1C+CVATdGDMfoevcuGl+UHMm6pre0mDnUMBs2EoCE0riiZj1PZP+Xdl60zmD?=
 =?us-ascii?Q?mUu+jQys5U3El6h5sc/F5n4w3t219vv3OaMNg6ZNnjk9igtAfd8DMUe4VPuw?=
 =?us-ascii?Q?Awe93tVvZCaQ1NxJlkUAwJeCtZ31pe0nA/IAmg80X/dpMNI6PWEttLBB/Gqw?=
 =?us-ascii?Q?+cGODcLTDvP5Vrkfo2pNCJ81t6tMVFQ71Dmkigt2F1WSi6ASVlURktBiB6Xg?=
 =?us-ascii?Q?fQ3imCAJ6wWX5Gy5V6MWq2O9sEFgLAO1/RItAcLmL/QGtl8rziqczJqgI5zP?=
 =?us-ascii?Q?HFaN0tRnGa5pZNiSpTMAaoxSgGwhC1Mgwqote8+0oE6p7wxNGXz4ovwVOq+H?=
 =?us-ascii?Q?A1d07FxYTPJzwof90/yjnJ72qHm/TlqITnyowkfD0EpSY/61zuDkv0dVBGzJ?=
 =?us-ascii?Q?KwpbcU8KO0/PIenUOHIXiE/1jw8I9dwUwPMqfTrBaIxvG7XUL9pXBbXMMP6s?=
 =?us-ascii?Q?3r3tPO0+DrPVUNSJXjtQz5qUjnK8IsH9W3aR+NAID4ByPsszFJOlvh/17hry?=
 =?us-ascii?Q?E10f+1bjxtrABHy8HIoB3ZWVxbORpVVn0wVL3BC2XZYioSKiuHitj2jKACcu?=
 =?us-ascii?Q?A2DLMFbvAErHAmqmIHHq+Rj2/qSKhfNDe12jp6m0v/xFOmAC705wE7fggP36?=
 =?us-ascii?Q?FvGAKBGNYTxyeaZnZ9Pw0gcZYHE6RcmNHRA8bPmXUMXgkvzgdmjQLmKkGWye?=
 =?us-ascii?Q?sbm8/YbQ3S1enE6lkT7VMFFcOEq/NOmHw4kdl9Ov0r2cZmR3Hg5Xq+nYiZfp?=
 =?us-ascii?Q?s59tKJINz2g3P5l4hPgeSbeKCNK2qRuY73sPzVaLktTiMVm2sMn2OfTNC4DB?=
 =?us-ascii?Q?FAT5i+kQotNxhNo549ue54grlh8OeLiFg7jHvNi9yuh/0OMquERiPejxCQ/u?=
 =?us-ascii?Q?m/ywZw8xgMkhlN27jY62x7VJhZ4KxLycOkC6nrXO?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ed2196-ce7e-408e-4e10-08dcde37b027
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 14:29:53.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuIMf+YKfwI1bMUavrnnIOtiWPugUVhbrrtld2fl52zCcjNgs+BxZNmHC+iVJxTBZToURQTeTBxzkzMuYrz16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2057



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Thursday, September 26, 2024 6:35 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Joe Damato <jdamato@fastly.com>; netdev@vger.kernel.org; Shradha
> Gupta <shradhagupta@microsoft.com>; Erni Sri Satya Vennela
> <ernis@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; open list:Hyper-
> V/Azure CORE AND DRIVERS <linux-hyperv@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
>=20
> On Wed, Sep 25, 2024 at 07:39:03PM +0000, Haiyang Zhang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Joe Damato <jdamato@fastly.com>
> > > Sent: Tuesday, September 24, 2024 7:49 PM
> > > To: netdev@vger.kernel.org
> > > Cc: Joe Damato <jdamato@fastly.com>; KY Srinivasan
> <kys@microsoft.com>;
> > > Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> > > Dexuan Cui <decui@microsoft.com>; David S. Miller
> <davem@davemloft.net>;
> > > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > > Paolo Abeni <pabeni@redhat.com>; open list:Hyper-V/Azure CORE AND
> DRIVERS
> > > <linux-hyperv@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> > > Subject: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
> > >
> > > [You don't often get email from jdamato@fastly.com. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Use netif_queue_set_napi to link queues to NAPI instances so that
> they
> > > can be queried with netlink.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> > >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/hyperv/netvsc.c
> b/drivers/net/hyperv/netvsc.c
> > > index 2b6ec979a62f..ccaa4690dba0 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device
> *device)
> > >         for (i =3D 0; i < net_device->num_chn; i++) {
> > >                 /* See also vmbus_reset_channel_cb(). */
> > >                 /* only disable enabled NAPI channel */
> > > -               if (i < ndev->real_num_rx_queues)
> > > +               if (i < ndev->real_num_rx_queues) {
> > > +                       netif_queue_set_napi(ndev, i,
> > > NETDEV_QUEUE_TYPE_TX, NULL);
> > > +                       netif_queue_set_napi(ndev, i,
> > > NETDEV_QUEUE_TYPE_RX, NULL);
> > >                         napi_disable(&net_device-
> >chan_table[i].napi);
> > > +               }
> > >
> > >                 netif_napi_del(&net_device->chan_table[i].napi);
> > >         }
> > > @@ -1787,6 +1790,10 @@ struct netvsc_device *netvsc_device_add(struct
> > > hv_device *device,
> > >         netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
> > >
> > >         napi_enable(&net_device->chan_table[0].napi);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
> > > +                            &net_device->chan_table[0].napi);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
> > > +                            &net_device->chan_table[0].napi);
> > >
> > >         /* Connect with the NetVsp */
> > >         ret =3D netvsc_connect_vsp(device, net_device, device_info);
> > > @@ -1805,6 +1812,8 @@ struct netvsc_device *netvsc_device_add(struct
> > > hv_device *device,
> > >
> > >  close:
> > >         RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
> > > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
> > >         napi_disable(&net_device->chan_table[0].napi);
> > >
> > >         /* Now, we can close the channel safely */
> > > diff --git a/drivers/net/hyperv/rndis_filter.c
> > > b/drivers/net/hyperv/rndis_filter.c
> > > index ecc2128ca9b7..c0ceeef4fcd8 100644
> > > --- a/drivers/net/hyperv/rndis_filter.c
> > > +++ b/drivers/net/hyperv/rndis_filter.c
> > > @@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct
> vmbus_channel
> > > *new_sc)
> > >         ret =3D vmbus_open(new_sc, netvsc_ring_bytes,
> > >                          netvsc_ring_bytes, NULL, 0,
> > >                          netvsc_channel_cb, nvchan);
> > > -       if (ret =3D=3D 0)
> > > +       if (ret =3D=3D 0) {
> > >                 napi_enable(&nvchan->napi);
> > > -       else
> > > +               netif_queue_set_napi(ndev, chn_index,
> > > NETDEV_QUEUE_TYPE_RX,
> > > +                                    &nvchan->napi);
> > > +               netif_queue_set_napi(ndev, chn_index,
> > > NETDEV_QUEUE_TYPE_TX,
> > > +                                    &nvchan->napi);
> > > +       } else {
> > >                 netdev_notice(ndev, "sub channel open failed: %d\n",
> > > ret);
> > > +       }
> > >
> > >         if (atomic_inc_return(&nvscdev->open_chn) =3D=3D nvscdev-
> >num_chn)
> > >                 wake_up(&nvscdev->subchan_open);
> > > --
> >
> > The code change looks fine to me.
> > @Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test
> this?
> >
> > Thanks,
> > - Haiyang
> >
> >
> Hi Joe, Haiyang,
>=20
> I have verified the patch on a VM with netvsc interfaces and the seems
> to be working as expected
>=20
> CLI output after applying the patch:
>=20
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'tx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'tx'}]
>=20
> The code changes also look good.
>=20
> Tested-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>=20

Thank you for the testing!

- Haiyang


