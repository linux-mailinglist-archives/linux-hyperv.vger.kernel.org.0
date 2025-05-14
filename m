Return-Path: <linux-hyperv+bounces-5508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F655AB702E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 17:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542F43B2133
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0F21FF31;
	Wed, 14 May 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mg0BoZuu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2013.outbound.protection.outlook.com [40.92.41.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C952F88;
	Wed, 14 May 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237480; cv=fail; b=Bd7EfaLSVxiVQ7/ciplFBezwOZqeF02mDIvv9kEUDJ5KvYs4fkr8DXjlla+Olk1BGqXmjRSCInMtnc2S2tXcAqzZi3QQaIENEPGtK/uZCrqDUknbRRiPGGmpMR3nyNGwvdXd4xQkD8YuBZ2ZGWqmLh1KYhrvSDqeqpSXH53T2Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237480; c=relaxed/simple;
	bh=/gL8RNd165p8qjwxYfUlGHGWnlDmfCTrHHD8riGIT20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G53qG/piA9vF2ur+yCuZrUNQbUWzLkuHWnltIaFiVBIRMtcPpEL++aykUp7DgQAShVPk2uBZDrV5s89Huac/NqDB17p5J6oLf8+QHrpN0X+pLSr+C6wscFQ+TvaOBK+V3KdGPNwluiC9MJF7uTtaIn52LvnnJwQPlkcQDsiUjCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mg0BoZuu; arc=fail smtp.client-ip=40.92.41.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT+o4tFXhNiPuM5V1ccxVtVVDRHCumhLUzCgD/7qRWLQYQKurAew/8grFFsNnAmgkHNCL108pfA9uXWP662HGuDW+07nWtM6KkMHH3cwYfwJAXhSRIgZcIRl9kCh7efVP4t2oVyKB/fjBHwuD3nO67WXCuxrjl5MI/W4zz1x4cUf8v4NebNJSFelb2XokzizWk47XPvyy1+T3Zec7wTHlNSmPXf/F1LJoTdm96lmpo7mOnxvjeCnkLk+KglILR2c7ojx9FCJVX/cvweVZDkiU9uo+Ya4vH/fCoLXGZopLPJw7L5w/pdeusPWWbDJfurhIeaZ0xduZYmD+Osp5G5WCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36EvbjMO7A5iu+dsPXByPRA0+7Ej+b/B1jFvfv4QVLk=;
 b=ReKkzIe46DeEru+s08lqq5s5xafUSZfsKuOHbKwlwGaeiS/rJ2U89DkxmIMhEEV47gJgWIHUziugOL6aURKAQ7Pkpp1ujMi3dzCPPeyDckbMnOkm5HxKMNsCvn0Dld49VFr36iVRpLBE+L6YCP62s4I9yAaVn+Hr2uMXc+Fbf4Q8iEGRd5ADc8a01sWMZ6RBGOzmTIWdAbV+ExaBPGPyqsKiNQAKxpEMk9x9EVrvunIPwRX3gCG9ou2oqKar6BRUhYPB8Ksdm9SLlWETEZh7Emtqm5UXIfBSUauvMBoFO7AE7FJbHmWbq79C+8iqlNcLyJ53xBMBJRxWf/fTCx4fjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36EvbjMO7A5iu+dsPXByPRA0+7Ej+b/B1jFvfv4QVLk=;
 b=Mg0BoZuuPKnm8GqHRuzOHoTp2aEq5OPf7TuhH91QZih93x9Njdk35iYRpOcuvOxs61FpAy3GAuqDqqOEZXYt9zjsK6AL1JaerEMhhVf8orEbR4V8ZUk4JWU39k4XpwoRPkxat/B6AM6VStnH3HJnnUdpcJ0XDkzTbJJu8QWivusQqHCSoiAGD2cTNaY8IdZp1tn0n9emXL2ZxUFpdX7PHSphOdhyWquW+il2Ccb9PbygAXlYL5LnLmUHCmNyQeHxpQbc9va5zIgkX8yur5ADwb5n+9INY2piWTh0NmffV9YmwXNRH8UKSPzxMdWzybCo+/+0u9jKVptjWDN57Fs3eA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8393.namprd02.prod.outlook.com (2603:10b6:303:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 15:44:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:44:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Simon Horman <horms@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to
 send VMBus messages
Thread-Topic: [PATCH net 2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to
 send VMBus messages
Thread-Index: AQHbw5sTz1balt96ikm347u6SRKF5rPR4IKAgABjSiA=
Date: Wed, 14 May 2025 15:44:35 +0000
Message-ID:
 <SN6PR02MB4157C9EC51BEC1EBCB2B7DC5D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-3-mhklinux@outlook.com>
 <20250514093751.GF3339421@horms.kernel.org>
In-Reply-To: <20250514093751.GF3339421@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8393:EE_
x-ms-office365-filtering-correlation-id: 97b71ded-7cbd-48f4-349d-08dd92fe3a99
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlxfSUkC2U66YG0lyCtUFgmyRu0lssGrjlpk/WHw/slHAURD9rbyxAMCODLDptyYbqfYt1HDp50CSbYQ2dFOqO8s/WQtQeu8qgaM3CB90ONovPk5FEhVyGVMuZ2GlFTpiNRNvhKAkSG0ddMysfSWvkIqCIz2HBOyFKHFOXzdQ2ZqWFU9QAAmEPvjRB4P46g12Zc4ezTs39P5THdyDCGG98qQqfpdiN41wiEHf1pmUn1O2nP3Xd2fJBBxbBBYcjrewuDNDQq5Ll4Ub4TCQY2WE3NOh5ONlFaPIw1a0uRSqEsLzNpxoh4+HzxUNN2wHfQq38iJxlhR+T3oTtvAAL/IaMs9JL1ptzNcoeO4MJy9RqfHndbea3+gK6rKR8Qx77+ZJqa4Uva91J7EqrZKsUgxuDnf1g3CXSvPcb+BN9OPEKNTJwnRonZI310clLoGloUX14kBMfC4qjiWfS0nRwxO5fqGaJnz1Uv4GDVCBSRXW/fgEiVADXNCC/RI4PknhnRnZSrGitXULoa5YecEkxxYdqOkhT/cV0XBeFBlmZfMpJ/WU1Poz6KYWLncTIRW/DCMe9l5wKRKug5eGePb9hPcT4PPWYdfqnoZjvrUeFfCt1gMTAzQJX62Qx499iG2CMG+BxLC8hFtvlcrRmwngMZ6dJqrA3ptUDy1YylTiukZgaP2pFOe2Dq0PbEUUv1p7OF85YyoqdSPdetbiZCEqS2gmB24GGlm6zFeqKdPvLu1icXdNY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|461199028|41001999006|19110799006|8060799009|8062599006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CJsk+PjaP3D+wWTG5UEzE190Gyaa8uOeyRk025t0WIjhmVFjdU2xhrWj7OPw?=
 =?us-ascii?Q?UMrd+VI1BUcFonibxO5CG9zZ/pLynqC4+yd7w0hQBIsfazsfZ8E51v+jPPyV?=
 =?us-ascii?Q?GTWro8iqW1XqbcSukZsvvN0CFPIAztYKzxY4kflVPllYfPI4uqhcveFrk5aU?=
 =?us-ascii?Q?LFhFFk6scD312JNQ2ToWNRCAfORkcq7OIr6G7x1pzUEW6Gt7+NAdeV8ozESj?=
 =?us-ascii?Q?NBnQ+0dK1GDdxEUl+dvDGdY+3jflcLsxxX0N+jB0SIPpozUoIUiMqRlJdI6S?=
 =?us-ascii?Q?QnF6oIioiPQ5pZGx/Kq4D7DOp1iE1H46jmZYiBUtgUkiBBFbtjJxioktDvHd?=
 =?us-ascii?Q?t+QflkPOs2i/7RngXwygc3aV8qMZyCIOa1z0TAJa/NJyQqtz0yHxmeN+x/hP?=
 =?us-ascii?Q?SmAGBwq3h7SpW3sYkLmVAh5LtzZz4grvVNpEyFy+5PH5ifsFgWGGCQ7EExRr?=
 =?us-ascii?Q?2575RqRTmhOomDS54t0FkEpUfxZoxVtRWrpgUi2HT062MEHopAE4tSnUA3hS?=
 =?us-ascii?Q?wq5ej0Py6tB6aQuLVi6pFGJVVXcJBAN550H/ydofxtruz9hAKk3C9umvcLUr?=
 =?us-ascii?Q?c9tFsKJzaCk7YKfh/o4Jj4xlK1qrKqwBbIES2EBvn1J5mcWxR0V2J+gPSCto?=
 =?us-ascii?Q?o+UbL+HyXYryd3I5W/izpNkMaNmduTu5lH1lFkBJIziJjFBPe8sSDKmwLDce?=
 =?us-ascii?Q?avYhmFHQf/wDPh3G7PAnnjoBiGCR85spq4M2SfGspDb3NIpu54P5dd9kAxk1?=
 =?us-ascii?Q?UosEfSm+AzfsiLEX0a3wYj5RVuYWHA/It5oW8xDyvnoV00r9H/1qzQTwRJs2?=
 =?us-ascii?Q?aMtyJ1X/jg6mOPM8r/2v6UbGIIZyrMh29bfdSlij0L+VMLyEjdqJ+aKjBU5l?=
 =?us-ascii?Q?czd2nhi6kXGoOxecdmJmvLBsgp9SJpzvVPBAXJ/stizEup5VKFF8Usy+dywL?=
 =?us-ascii?Q?9RsyAJs84d4pimk03l7mgH4SBBLje4hk8YB6ov7bfmHFc+0N7SLonIvrcbKk?=
 =?us-ascii?Q?7zq2Htvxta+F16Cw+3wA2a4s/JqObl0KwpCRvjNClA68p6vm1whsBgdnvNvy?=
 =?us-ascii?Q?1AEbCarO4La6m2rEOb+VINA3TXdIK5H6UA0UK0OgzlzAueppkvAKiXVfYjrX?=
 =?us-ascii?Q?ac70W4VG0YG4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N3cJ1Trc3W8buBBv44yGxho/7p80fTiarVB278S264XkBAwb7OcmwaFFZe08?=
 =?us-ascii?Q?QjtkTkLZIYvxaFiRVGbXFCBoiFgPggpF/EMAA597aAphglK/GCJZSNMbfAXP?=
 =?us-ascii?Q?kkzXbElrfJUz7ZTmy49LmbNvJKSCC7Ezqob3E3Tlb4SfQOsFnNTpr/Bt1Mu9?=
 =?us-ascii?Q?nOTQTCQr875u4ED3YAYoN6WHPedPcmuqbhdHVAt1nB/w/56xNdffFQ8W4voa?=
 =?us-ascii?Q?XdXrhaFvjF1EM6BOhMgRUBCbFUGuwjTzBoUE6nmMGWaSOduAQVBHagn/fOCs?=
 =?us-ascii?Q?lZzfWhOs4C+DhJ5RaZTwDUyBdbWjI2HPsxjqmdC44l5V9EvoYVPkGrE/fNzM?=
 =?us-ascii?Q?TssvwJKgBTJBM9BnkpKRCTlWkM1VYSOLRVVJLD1XGMftRlym1RbJKT4bmpxO?=
 =?us-ascii?Q?+ElZR8lKtutTPDhfte1fVvo1dxsqEN1K6BiHlfUMH/WFU3aT9pMlX3Tb7xTn?=
 =?us-ascii?Q?zjZPFjmpghqA1QCrCPDcAPCA8TO2err5cioz0ONpKSl5J2pEJ0piJaEguaQG?=
 =?us-ascii?Q?j3akq18lPtdakuIrX8jxImnLcmcSXRqGhUmKmUcIovLq/sv83IVrh1oUFWUB?=
 =?us-ascii?Q?hWniGafz/RK8QdmP5Zve+EPeSG3NqsRWhdLw2VJCXqJrUuSeeu5L1Vo6EoDM?=
 =?us-ascii?Q?1eLZPhbTPn64sT1jLuhyWzErr0QOSUjzrifPWnfGRQzQcdKAvieiXAu5FHOF?=
 =?us-ascii?Q?PwESIDiZPSmArc/T6+MO1wReBFor/edl4vTu4P9nLXhO9g2qqDa33TuvkSCL?=
 =?us-ascii?Q?WWLQD+hH2OxSJKtJIyO/YSFqoOFHPc6+m5iNy+LBYPJZC2hsQaCQW2axlyzU?=
 =?us-ascii?Q?EN0sQpJ3IgZ6Nu9GjYDwbl88Wkiv49uNUXy7bskv10GtXSHKE0cplnbB7Esy?=
 =?us-ascii?Q?4dQW7YyZ4HCxdd49sMAXtiFyXVPLSonECwyeajMi2BuP8zMrYiHGbvlqcnds?=
 =?us-ascii?Q?Kd3t9oHbBZ/ycdZbnkoCWYyUf3t4ehsOHNT3e/qYeqrC+r2oeToT5L3LUYTE?=
 =?us-ascii?Q?GXFJbrxAWoOn6a43xGSKj+DfPec/i2IqpsyYJgPbqcRLCdqefDKU8CLcPVFq?=
 =?us-ascii?Q?Az2V8+7l5QcxUXQEQf6tD5QyGRB37L0RFckgYwuH98sll35K8Q4c4MH+QRzs?=
 =?us-ascii?Q?bzzAc36hY/BjfhriMPVhVqBl/r1s2v/Rm4GCxreoGt/KoqVOms/EJmNSqDkK?=
 =?us-ascii?Q?xW6PyeCCpfFkp3gQaJnxnbGZunr2qsnN/RAOm8ZxlBk1M5e5reFx+2Iy894?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b71ded-7cbd-48f4-349d-08dd92fe3a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 15:44:35.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8393

From: Simon Horman <horms@kernel.org> Sent: Wednesday, May 14, 2025 2:38 AM
>=20
> On Mon, May 12, 2025 at 05:06:01PM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > netvsc currently uses vmbus_sendpacket_pagebuffer() to send VMBus
> > messages. This function creates a series of GPA ranges, each of which
> > contains a single PFN. However, if the rndis header in the VMBus
> > message crosses a page boundary, the netvsc protocol with the host
> > requires that both PFNs for the rndis header must be in a single "GPA
> > range" data structure, which isn't possible with
> > vmbus_sendpacket_pagebuffer(). As the first step in fixing this, add a
> > new function netvsc_build_mpb_array() to build a VMBus message with
> > multiple GPA ranges, each of which may contain multiple PFNs. Use
> > vmbus_sendpacket_mpb_desc() to send this VMBus message to the host.
> >
> > There's no functional change since higher levels of netvsc don't
> > maintain or propagate knowledge of contiguous PFNs. Based on its
> > input, netvsc_build_mpb_array() still produces a separate GPA range
> > for each PFN and the behavior is the same as with
> > vmbus_sendpacket_pagebuffer(). But the groundwork is laid for a
> > subsequent patch to provide the necessary grouping.
> >
> > Cc: <stable@vger.kernel.org> # 6.1.x
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/net/hyperv/netvsc.c | 50 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index d6f5b9ea3109..6d1705f87682 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -1055,6 +1055,42 @@ static int netvsc_dma_map(struct hv_device *hv_d=
ev,
> >  	return 0;
> >  }
> >
> > +/* Build an "array" of mpb entries describing the data to be transferr=
ed
> > + * over VMBus. After the desc header fields, each "array" entry is var=
iable
> > + * size, and each entry starts after the end of the previous entry. Th=
e
> > + * "offset" and "len" fields for each entry imply the size of the entr=
y.
> > + *
> > + * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hy=
per-V
> > + * uses that granularity, even if the system page size of the guest is=
 larger.
> > + * Each entry in the input "pb" array must describe a contiguous range=
 of
> > + * guest physical memory so that the pfns are sequential if the range =
crosses
> > + * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
>=20
> Hi Michael,
>=20
> Is there a guarantee that this constraint is met. And moreover, is there =
a
> guarantee that all of the entries will fit in desc? I am slightly concern=
ed
> that there may be an overrun lurking here.
>=20

It is indeed up to the caller to ensure that the pb array is properly
constructed. netvsc_build_mpb_array() doesn't do additional validation.
There are only two sources of the pb array, both of which do the right
thing, so additional validation seemed redundant.

An overrun is a concern, but again the callers do the right thing. As
described in my response to Patch 3 of the series, netvsc_xmit()
counts the number of pages ahead of time, and makes sure the count is
within the limit of the amount space allocated in the "desc" argument
to netvsc_build_mpb_array().

Michael

