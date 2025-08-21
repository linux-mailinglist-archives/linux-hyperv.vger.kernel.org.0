Return-Path: <linux-hyperv+bounces-6574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EFB2FF25
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174887B44C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396027CB04;
	Thu, 21 Aug 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qXp9w+HM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2091.outbound.protection.outlook.com [40.92.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A41273D6D;
	Thu, 21 Aug 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791115; cv=fail; b=Wa7s5jK4Jz0/4GQ2P3TbdbzDwIyeMOI6UMWnkP9ONfp7ic7SNgXJDm5l3gHQYMukNNPaoQj4GkyNHHzq5g0qILFvNHf5h6rF1zKtv61uEJle1KSfwR3+KTDHfVBTNvRWSYzjPciTDSj8NOeyMYd81GOvmvCumIolwQAtLa+OP7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791115; c=relaxed/simple;
	bh=Yp5s+IAJ2sRsG+vBQ7ZKiN2/7XTHlRM3uZ+ooPLK+4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K689AmArIh6KeHdrUwLFEdPwu7RC6PfV/FVwlZQBZmPhZBIOuNqnkUZIL85xfxfOK2qBpNwGqiQcoB9frcGcEWP66Ify6rR+2bhuFgH76oY7ioqelNL92A8bdOgGTpCnBrfh62rz6YxotGISS6vKIDueGqcVOQhGyh/ABOQenvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qXp9w+HM; arc=fail smtp.client-ip=40.92.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUgAYOzTPhtsAO8ceEcq6Ysq5/4H5kAQce1DM1IQNc0vW7S5OuqgBoGSq0DSrTJB9NbmVCAX/22FAwB29FjMX0rpRW6gxo+62mV/as351DQx9eVjnkjdNMnstW72N/2RkdnMJhdm8U6unXi2ariTu+Dzhfki6gREQgHycqMm25F04UPyQeNrvgDdc/pXARN0e7JabBhjfaNAP0HCzIAQRvZHMVBb+iRTYDngL2ai3CHgVnAKmh4p2EQ0DRerEV1PLbmChXiHl59sUoS4HaZm241WOo069O2W7feuAU9EUJA5RvzVUFhxYne8Rjx8c4aDQRzJlRUXzwG26Xsrhdleww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtOaFm5m+7tyfMSGw+Kj2nnW5Gpm6jFjV0+musFE3p8=;
 b=Yhl/mG0MWjdmnNf2Q80s0kjDlI7UKD5w7Oi4GADcI/jf04lqk1jLPFKoYQgFrbt2OJjiKLl1/4mZ55otKCPsKuIgdMh8Er1pef2iThdGGdu8s1Mk8nVBOiDCubSpViGhSqUqTqwfFuvgNJwpdZZL3IGlbaOGcS0+n60+9jWyDymSJbHj2yfNHd1mdnIxl3HRGBau38VDFQtA+bDCKiVxE0JtTft9gwD4zv+tB0IGADlEQxq6cuMitZwPso4MLXuZh+vbIkQHlQdQIOMRk3xVZwNmmm0X4YlRPVFPucERMCQueIBaR64goxKq1R+8Fj+JgpjdihBjaou7JUq/9c4Yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtOaFm5m+7tyfMSGw+Kj2nnW5Gpm6jFjV0+musFE3p8=;
 b=qXp9w+HMMkxlMLylYG8WQMhflY5gXgoZLgn4kmev3qxWstjmMwpD02dO7vgrGdf5F7/MBPjA1xoTZNce/YVLNSqxp/OZ7ppD/YpTdeEiAueI664eKRzTJcBs8363Ogo7furtfN3MPYesVpdJfcutbXTPaqxYVipSYD4I8PTdnqNBHDKrIYkDzdDDjH39OT9BYZ4QEfJP8+gsrx3KJi8GLfZpeBzPWQ7bv3FzIuubwhoDsR3AfRW/olEz350fPbUI46VOR51M0MkslTMzrH2JWblJS8lLRSGD1Oljg3GsLcuRQba9/QipLAPN896qmWh5mTnG7GonoiMY17H7exi+gA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9821.namprd02.prod.outlook.com (2603:10b6:a03:549::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 15:45:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 15:45:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, Li Tian
	<litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Subject: RE: [PATCH v2] x86/hyperv: Fix kdump on Azure CVMs
Thread-Topic: [PATCH v2] x86/hyperv: Fix kdump on Azure CVMs
Thread-Index: AQHcECYPQKX4fiH3e0mckaF4ks/rN7RpR5TwgAOWZACAAGSO4A==
Date: Thu, 21 Aug 2025 15:45:10 +0000
Message-ID:
 <SN6PR02MB41573CB5E4B2F3E35501934BD432A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250818095400.1610209-1-vkuznets@redhat.com>
 <SN6PR02MB415738B7E821D2EF6F19B4E1D430A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <877byxm2x3.fsf@redhat.com>
In-Reply-To: <877byxm2x3.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9821:EE_
x-ms-office365-filtering-correlation-id: 6d7c664c-d395-445a-5873-08dde0c9b677
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|15080799012|8060799015|13091999003|31061999003|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G4JdksLKZBPKlslw3vcIa/2R6ZSxMQHvtGuHKZmYwtGGQIEfXrfy/tTn1MDf?=
 =?us-ascii?Q?1CCsWJFuuV5F25vuPX/NFkoKg2wxnS9Bo3IA4zn4XGXOeAysgvzrE3NgdLpu?=
 =?us-ascii?Q?hlxuVD5yiIHKzZrAhxTUvUJgjA9x0nMATmM28me0mf2YJ3E7oQ35g+PH+nA7?=
 =?us-ascii?Q?4xOTcsY2YU5S2AhTkWMCSF+sHM7iPAnAQXkOWaWtKU3rqCbUGMoVN8AvPPmI?=
 =?us-ascii?Q?oC7HYendcL9PqMLesLK/GKekzShPAJ1w9ug7g58hBESqutL4fUubj+GMilt1?=
 =?us-ascii?Q?D2MqGOoPYzz+JCGkvuVGEt0aFuKbk/W/OSzxrJLZg4DYW2S91YSO4XD9RfrU?=
 =?us-ascii?Q?UISxhm4qRl3y6K5bhtDCAfWaKctqg+ASCKE2JsN/JqMEYZAWQqUPi8g0eAe9?=
 =?us-ascii?Q?EIHMtp/QbLqCF6NnIYDSYyFrnehMK1OddCQsNYruoZmmy6SekK8Uj/LFGEHF?=
 =?us-ascii?Q?iwzuaz9AYbNBKtIAAzBitvG5SV2w6SWTEjns5L/10m309dOylhh6PtqjwWT/?=
 =?us-ascii?Q?qQnDx5RODlt70nQfDcqJjzxcNdKJAzL454Q6hr47vipEJApxsvge9E7TrC1+?=
 =?us-ascii?Q?YXYb9c6a2X61p4IxrNI4orjLF8Kxghu7tLZMqi+K5MQVPAqD1Ss6lMWSCG7F?=
 =?us-ascii?Q?CcOsVSIbKFJiThuQPMqEHGcU2BQp3SWLf1fnbC9BMGKLAygMQVQLDYllNCV1?=
 =?us-ascii?Q?QHa6JiZoEL/L1J5owXxXwJFdjyNqglOVijT1BYoeKZmqC2Khy3nlOflUh+W7?=
 =?us-ascii?Q?fTRPsykyqrPTrYratVqlJfdEr8/XVNdfSYMQ3qAbBviJjjNMVr44pL5RRA6P?=
 =?us-ascii?Q?oQSu6sG0gOUMMGQOZO6kLd9ypieNx3W4BXA7fEYxch/mfhrIwcF0uKseF0Gj?=
 =?us-ascii?Q?HGT+W0wJzb3B5Ev+x6fpUKe6J3U9JebwKZNUpyLwWFnQ0KZzMfvvuF5CdV5z?=
 =?us-ascii?Q?1YbJjyhniVvs/o5+VhLndY6AmZiezTCzkFXX6peRefkKGrNsfjbgr+sO1vgk?=
 =?us-ascii?Q?dz2EKQxWKBrqPyDz5iwyjhooZyKGY/lHyIA3M1OaFsFFTieRKW5DGDkq6SHi?=
 =?us-ascii?Q?2+l/AmFZAqvnktECcEPlrZu5iH61Z0MEByS+iFhRdUijQgWXkKUfk3NsWr+j?=
 =?us-ascii?Q?ep/Gx4BJ54zza2DIQriRYsVbK5BoH2myEZesajTNDhRhWB3XC3LH8wo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nlrQ4JBpCE8WjuAu/FoB2yLwr9QwbS/bsD60FDvF47ifZzPKHUjpod6CyGTg?=
 =?us-ascii?Q?FtQPthiUvdhbEdwUV5BL/0LbrdIosSv+LuRy+GIOIJvuLzAN4rvSclwpeFHV?=
 =?us-ascii?Q?29t+cma7sVw7DSMjFRZsRt8JRuDXF0dyWvXmoNT92g3YUZPfzHA4DIiOEH8w?=
 =?us-ascii?Q?0W4dyMDFPlzp83nIqKCq7Ae49SJAkCv0f/LADj1H3BHlVCmvJge8Yp2xPo2h?=
 =?us-ascii?Q?DMsZBwhP+uMMYSltn1c0TrVF5S03BQv/m7IL8svgvwNWWH/vMKfuaRAjy3/b?=
 =?us-ascii?Q?K8n50T6Ypby9IUYBdxF1bHVFtejxTxM10YIO3dHEmeAQPZvdyqNeuY9eZwca?=
 =?us-ascii?Q?rjGMmLWPYHw6SlLlo9pKE9pStexVS82h9nHA5KQSd+14aFwhwD7/pdGcNob+?=
 =?us-ascii?Q?FOXWOJtidWGthDxx37ZWo/k7LOI9kuwN/XZgLm3GY+capkz0Wupb9DL0ib2n?=
 =?us-ascii?Q?GQ9hdDkLTaQh/rxFF+hKKYzn/TvVHCiupNCdMVQT7zCoYeOkFNoUMnk+NtLu?=
 =?us-ascii?Q?W5WF31QmxGNGytvvBslhMzeeDQekxO3YdT5//e+duFAhKjlfS23LC85fLW/q?=
 =?us-ascii?Q?jav26oUyqD2cFCetDMHLzbS6Qur9qu+/LD4LI4H/idJzNvpxAwKwOvuEV1RD?=
 =?us-ascii?Q?Y/lexi+BukKuaVWMYkuPAJ3zwJChbwApF854Mg0jKQe4FpbiF/lkiMByE2Fd?=
 =?us-ascii?Q?C/m+XCvvT+3ThKsGU9v0gpBCD/IWTyM2KNNZJpMzKj7LficB11WC+HnRQ3L4?=
 =?us-ascii?Q?Ds4jzP0Kjyjy0bDPjpR69ex5VxXTPlEQ5TOKKDrCR9g+79XMzHKJvobJauVs?=
 =?us-ascii?Q?65Z1n18/BEpWE4W/6PObY+r7OvyTxOX/pL4vpb28XcFzICkaMiYohVsvqI4c?=
 =?us-ascii?Q?KMxKlc0Jks9WGWkgSvBcEbGT4ACG1coL6rvOuBdX8wf7A8Dfs+B7+Ap/O9Yk?=
 =?us-ascii?Q?cLoTPHHnD5lN0sBmjRhhL5CRSWEBFBYFkAOw/jnJfZwb36swTAcVcyFeC27b?=
 =?us-ascii?Q?OueThv5aF7UxXGM3OulfO9kbvB+822HxVZzynPWs2lQvQ/p/YOgPnW0633CW?=
 =?us-ascii?Q?4apslCNw6BrRemLAWz5URJ0jcHXWD6WcTsXbzLy190K9fvwQJ3Zyz2MYKZax?=
 =?us-ascii?Q?/0Io5NTJ6wyhC3p8QFoFFYDHD7VQ4EmUQO/P0tWylCaQvjMQPp0yhpq6R1va?=
 =?us-ascii?Q?VTx2fHlYuX8TDsj3A+YRm0kfu42lHTSLccwJetN1UAw2KCtV4d+1QYV1TRM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7c664c-d395-445a-5873-08dde0c9b677
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 15:45:11.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9821

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 21, 202=
5 2:37 AM
>=20
> Michael Kelley <mhklinux@outlook.com> writes:
>=20
> > From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, August 18, 2=
025 2:54 AM

[snip]

> >>
> >> +/*
> >> + * Keep track of the PFN regions which were shared with the host. The=
 access
> >> + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
> >> + */
> >> +struct hv_enc_pfn_region {
> >> +	struct list_head list;
> >> +	u64 pfn;
> >> +	int count;
> >> +};
> >
> > I'm wondering if there's an existing kernel data structure that would h=
andle
> > the requirements here. Did you look at using xarray()? It's probably no=
t as
> > memory efficient since it presumably needs a separate entry for each PF=
N,
> > whereas your code below uses a single entry for a range of PFNs. But
> > maybe that's a worthwhile tradeoff to simplify the code and avoid some
> > of the messy issues I point out below.  Just a thought ....
>=20
> I thought about it before I looked at how these regions really look
> like. Here's what I see on a DC2ads instance upon kdump (with debug
> printk added):
>=20
> [   37.255921] hv_ivm_clear_host_access: PFN_START: 102548 COUNT:8
> [   37.256833] hv_ivm_clear_host_access: PFN_START: 10bc60 COUNT:16
> [   37.257743] hv_ivm_clear_host_access: PFN_START: 10bd00 COUNT:256
> [   37.259177] hv_ivm_clear_host_access: PFN_START: 10ada0 COUNT:255
> [   37.260639] hv_ivm_clear_host_access: PFN_START: 1097e8 COUNT:24
> [   37.261630] hv_ivm_clear_host_access: PFN_START: 103ce3 COUNT:45
> [   37.262741] hv_ivm_clear_host_access: PFN_START: 103ce1 COUNT:1
>=20
> ... 57 more items with 1-4 PFNs ...
>=20
> [   37.320659] hv_ivm_clear_host_access: PFN_START: 103c98 COUNT:1
> [   37.321611] hv_ivm_clear_host_access: PFN_START: 109d00 COUNT:4199
> [   37.331656] hv_ivm_clear_host_access: PFN_START: 10957f COUNT:129
> [   37.332902] hv_ivm_clear_host_access: PFN_START: 103c9b COUNT:2
> [   37.333811] hv_ivm_clear_host_access: PFN_START: 1000 COUNT:256
> [   37.335066] hv_ivm_clear_host_access: PFN_START: 100 COUNT:256
> [   37.336340] hv_ivm_clear_host_access: PFN_START: 100e00 COUNT:256
> [   37.337626] hv_ivm_clear_host_access: PFN_START: 7b000 COUNT:131072
>=20
> Overall, the liked list contains 72 items of 32 bytes each so we're
> consuming 2k of extra memory. Handling of such a short list should also
> be pretty fast.
>=20
> If we switch to handling each PFN separately, that would be 136862
> items. I'm not exactly sure about xarray's memory consumption but I'm
> afraid we are talking megabytes for this case. This is the price
> every CVM user is going to pay. Also, the chance of getting into
> (interim) memory allocation problems is going to be much higher.
>=20

OK, make sense. The entry above with 4199 PFNs is probably the netvsc
receive buffer array. And the big entry with 131072 PFNs is almost certainl=
y
the swiotlb, which I had forgotten about. That one really blows up the coun=
t,
and would be 262144 PFNs on bigger CVMs with 16 Gbytes or more of memory.
So, yes, having an xarray entry per PFN almost certainly gets too big.

Michael

