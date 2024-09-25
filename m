Return-Path: <linux-hyperv+bounces-3070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0298670D
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 21:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A75285EAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C05145336;
	Wed, 25 Sep 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JEuDOks+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020133.outbound.protection.outlook.com [52.101.56.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBD14373F;
	Wed, 25 Sep 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293152; cv=fail; b=t6pTRiOv3raGOwbAGi6W/yKRmElbbhcD9i0VMt/oQzXhw+F96YkR7TYgq5q97m+qEyPfYUh3OZsHrU4JTZ/Qn9psJxihpB21pD4tcv1hx3p20+JuVaBqOw6jij1cL+3Tvxi5xc5s4yptW+mhSHLLpAUi4+ZvNC9qYhcMZ/mkOo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293152; c=relaxed/simple;
	bh=YVdTc/NIflMXarBWb19J9rqGFwxkzZ95elAQLBrGIUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcfwnkyyDVVskAr7Sqvav8AoTp9jvZawnneXvZ0/SN7ldABGhxXMV5/30aJlpFalzVCrY/xE33n0lafXKBeN3NI9r7wa7aDgXFCja0g2v+0kWSgp/4k4W5xhOrutJWurbtlZrQgb1cQGMR+3cAh3TZ2yBl2W0ZiX10dAXnw5KFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JEuDOks+; arc=fail smtp.client-ip=52.101.56.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGfE74Yum9WkhkbNrYqz1iviF8OKAD9wAKR34jT3LJ4uUYpAGFpf8fmqheewCdDqvTSPtBODRY5RdbxZwi9Kn0YUeO0v5ULMS8LYMQrx88Ha8D/bdkRxZ/0EvC0Jqipr0eAMozjFXLtPT+PHCV9DdY/yoKO5E8VUNC55n+j/7AFV4A9qRiNHR40rulMEr8JyZONcD9tftvnyVCqyp5YcwQrn7WqRWgSjsVL1hx0avOCPnYizlq6KVn2mIf4VS7PG/YLhD56Eoui2OnEY0TCDrQXwZX/GeNu1YdzgSCAZVscBB2RCo68shwSb3c+iTkltnRdL8kV0YlVOzaxxQ5cNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV/24npNCxG4lILhYTcrGlo7jVa0wGZbiP4uCT+MpIE=;
 b=lT3Y+kzs72WSwfP45b1nWR5w8WFEos+PC0KgeERRjmUQXp9+2nMiF5mPaJAL2ZIz64LUcefh7AUWZcucBrUpi+jjXEPcx2lGysChLLNxn9LmjTVGuK3NJVKh28/549rMyRRlzfFr1PgAaOJPS2qiDX6fF/12IfGoaJ4d5L6zUWe3jaFWasqzWhSJ6QSQuQjSeCQA0++RDOPDhGzaFIToIX9Fbq53CF0TQ7E80QiWoVx+mmG0MIMKMSAEKibwLSu/oHW4exYyhkgh8JjZin/SdRyvDQ8eIuleC3eW/2CQGI32IRHdaC6N2jEpl86C+OcP27y4u0C+lVIoJYW60m782Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV/24npNCxG4lILhYTcrGlo7jVa0wGZbiP4uCT+MpIE=;
 b=JEuDOks+7zQmSBO4sB2tEzIrNE3oYDaYZdcYX8Al0soP/vTHglXGbWhr5DwI7kQoZsuGQeRH2k4BrUmc7fdj/5tWGC147abk81iOno81tPiVvpOvdumDYKbwFlAQxkjLsjKsn7gZE7AvSm7ysG/xyMh5clMW0H0iD3a7dTMOFHI=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by MWHPR21MB4356.namprd21.prod.outlook.com (2603:10b6:303:27b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Wed, 25 Sep
 2024 19:39:03 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%4]) with mapi id 15.20.8026.005; Wed, 25 Sep 2024
 19:39:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>, Erni
 Sri Satya Vennela <ernis@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Topic: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Thread-Index: AQHbDtyDLnpN2WTv30usPP8o3/gudLJo5syA
Date: Wed, 25 Sep 2024 19:39:03 +0000
Message-ID:
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
In-Reply-To: <20240924234851.42348-2-jdamato@fastly.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shradhagupta@microsoft.com,ernis@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4db87e7-9ea7-4180-bc63-40f37a756652;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-25T19:36:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|MWHPR21MB4356:EE_
x-ms-office365-filtering-correlation-id: cdb05772-fc3c-46f9-0ed0-08dcdd99b647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Loe1HFA8VCZLH2+1ZLGKoyzCr1IoGk1yJNJ6/TIDkMzUWuAMx4vgI8bm2vHm?=
 =?us-ascii?Q?lVKUv/2VJlLIyCLXkbIfczJplicFQBWCn4+gTxelGewbppekAAvKnZsaGIxu?=
 =?us-ascii?Q?7pvmtyNxttFCIdeWIobOHljPa+I0WvSNAvUXUU9O62ohXTbraIaz6zEaCgsi?=
 =?us-ascii?Q?awpTObI5v+jUg8nZVuEn4NQ7JAeTb0SCWFdNGT1L8Low5jaebJUuzuqcJSCw?=
 =?us-ascii?Q?991f711a8hAxetUK8qCEXJich3eIQgS1o8SjniU7A94RQIopq8uKRKqQI/vc?=
 =?us-ascii?Q?3zrGa70+dwdA+3U/K7pqPJO3qBgS/3YSdxLJrB4IdaCdeO9ScdJ6cWf2lIMv?=
 =?us-ascii?Q?PaZcjpOPzMRoLvJQfA6ydIXtcR4HbNGZMvULQ74KZw3iCwUtaLOzGhmwe52y?=
 =?us-ascii?Q?YuvkNX5vytDK8+iY0wedtr3sBoPcLFw1YCksVNSb81VSyt/u7vk61IpksRk9?=
 =?us-ascii?Q?T5DAhVexWdvteknZ4Yl7NpDQrFKGh4a7SjZqHhl3sWavi4P2m5K1lD1WqNma?=
 =?us-ascii?Q?kDw2Yi3MXkX4oWYoF97a/bvYEgowtHIFVPZNkk8EO31PyI25CyZoX8KLaF+m?=
 =?us-ascii?Q?yoKva0lt4s21OI+EXlGjve5NObBem0sHWdi4Wm6L0WGni1EIwex7Wh4JoFB4?=
 =?us-ascii?Q?wYtF9D2fYpa6ZhJhMu/NggsBfhNoVhZpxExwY/Y+59BDthdhvKhFmbgPMEzt?=
 =?us-ascii?Q?fdnHO2w9pO9WOuNYtauJ4Jh0LJ0wBH9l2WHF5pdnoDhj4YNJ2istqyq4GlUl?=
 =?us-ascii?Q?f5dzDkip8bMXzW5WE7C5mDC+qRXcPFD/Su/+/i+VPCY54etFb84Rigjly0G8?=
 =?us-ascii?Q?Fvx1R1Fqc3pLX4jfpdliMGGenA1+LYses8dv+nUXVLG+vWehLAegdaL1PiX0?=
 =?us-ascii?Q?Snj6rzDWNEKLqpBYiifL1lwWi+wmzTyI7tgsI+ht3MOAkP3EpgYdD3vA2R9m?=
 =?us-ascii?Q?sK/Gz7Rjpkqs9QeT6ZwuGRtx6c26S21zxfwohdQrBB8dWQlKk9T5xTbciml2?=
 =?us-ascii?Q?1g90tJLmmej3Jzd4g29LeKwHpBH7j0jeBO8m1Jx89N6nNY2TQL6qPIoAu2b/?=
 =?us-ascii?Q?AcOP7n8lYZdiS0wfI5GTpEJdqtATPJwROVfOewH1I/OWKYuHeRufQUCZQZCa?=
 =?us-ascii?Q?eIQOdB6XBub2t+W1G8M5NOiMBtXjkPSkFt/yPg6lre+sm2oKscK7xz24ydf5?=
 =?us-ascii?Q?CqMEfyi6rrAQra9WJVUagtp6O9ZnA3g52pufPRFpm2RB96q7AWYpFspFqiNA?=
 =?us-ascii?Q?ML0hMiAw33ccP0s8YEImuAvMEr/9h+/BGbmOGgKxmtcetp7DddSdEp1oRIvb?=
 =?us-ascii?Q?oykieOql32rwr8krfQmzII4Iad6+SFyttDx/6rm3dwu+CQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mWQYd8/TjwoH4lUyR9RqoH2U4xjGvMIeMR0pWHe3PZu38rI9T7QtIlBjGZ30?=
 =?us-ascii?Q?S+l02fufsbN1a34Az3gj31+1bacGEQVPo7HO8GWasRsIo9seFotoT1WSzFRY?=
 =?us-ascii?Q?VlWRIAfLIc6mz/5SNWTs1Tw6oHacNUhwI4beQuMDQOjbVr9olScOrC7h9kG0?=
 =?us-ascii?Q?fOQ90mT7QuZjKJKO8JUxIvYGmjckk/J6nrszjLu+UiBZ2nEV/0tT6yk6Gftk?=
 =?us-ascii?Q?gvHVCelL/L0qzrDBajsEQbHABMtQNknM3wqHZDXGZlQdieZmzMOCkDp2qKEE?=
 =?us-ascii?Q?MK3ucB28bhzME2O/1urVFGadrPT6wjeANH/t1Rhu2+Gqrc7Y3oAyWSSw7O9M?=
 =?us-ascii?Q?/G56W/8dNeaVvKRJ7On0hUPI3320ViXHSjWX1fEw0YVyiRIPDUqoMfHoGAoz?=
 =?us-ascii?Q?4rQWNaJmEpiP0tTa0o9c3AZF23ihDSo2KZyYBhnuaSlMexhugXMLtBWRk1ZM?=
 =?us-ascii?Q?2xZDOh7w4Bx5LRrDzD7Jy7o3BIqc6H/+zDsu52jv3uIrMZZEnMHHlSNnEiC8?=
 =?us-ascii?Q?Tu/msqjRPYaFeSTLiHcvdx+R1GCT9zYClezBLiPwPqC9OZR0ijV9gzmkqxFU?=
 =?us-ascii?Q?+tvhFb8xo5Fa9HjpMk3qgN/5MfBYgsOuST/XD9oO69h+llh9A+KlSTqTUSpB?=
 =?us-ascii?Q?jyjJ7tIN07rlDYN416mABdZ1D6740R2IVeqSEP1yotldSMA580OpQgV8eI0D?=
 =?us-ascii?Q?lvmUXihMirioBaLTFrwPsZVlmU4STKHi5yzAQ8Su8kVWaHZw42opDn4SrQQQ?=
 =?us-ascii?Q?5Ny11l3d8oXTF6QpLV8XFNvbvIOl/M2kWDCpxphLF58jyi5f9kd8eImJ4AXb?=
 =?us-ascii?Q?5u2IZ+fUgg9k+PH4M+6lZHRuQRd/OSwDVcPenDwcgKgFu9JS6gvrnFyN+hxA?=
 =?us-ascii?Q?UgWLk6mtr27cOGgu/b9YhvZt/Pg7kYTIJ8kYuFq49d1ZF9R/xiPWmFxkkTtL?=
 =?us-ascii?Q?XfmeYdsOtGWcmXjV9LDRdoyfFpsZPf5bnFsRfSBL7UIbJkPzWi6uiYZl98mF?=
 =?us-ascii?Q?UQEajTwuDnTx4NeiWwUmcznygdn3Jtxfor916228RP/ZUkNE0ZZgc3ZNjM7d?=
 =?us-ascii?Q?WGEi+PU9kyqOq10B+j3tjOqZdbEmO6iq7ZL0mB5ESaFfVGEOnw/MkZNOoWbq?=
 =?us-ascii?Q?gXEDHQegubs8RLT9AIPgnuzB5aSSYcSU92pgCPy8DBSDWtHDE/3/TCsSsShK?=
 =?us-ascii?Q?yRR5kO+l7S6yYqcuInm5XGdlIDPmPzD01QEsi1BOu3eED1qC/B6UFO+kXasw?=
 =?us-ascii?Q?gsaXuyBpreYVCFUEDid1+FTHjwffnaPcixrQpi/sfhBZgN7VklqXNVg0TblW?=
 =?us-ascii?Q?oSGFWH9zXPqVShb6uw5hX8q/Ah6HHl4vIDsZARowZ89GM0xvEdVfOuU9h75z?=
 =?us-ascii?Q?5d2L3I/JhwkIp3/9ipH6w5YPC5WUSvBC/vsNY4YBHVOpanWJ2KcMXD3hG2WA?=
 =?us-ascii?Q?IoZMYQSolSlJCojqN0JSzy/ayZTQsXCUq3SDHsG6Bc3lXV1YJ0husnaQ0y+O?=
 =?us-ascii?Q?3cjIe90qZs6N2X3OZYgv4FHZhi8EXh3Dp0TzzRusjUWBGhkPYdBP77AjwNfB?=
 =?us-ascii?Q?ViSE0MjCfMe4LaG5/ob4oJvrbfrdAnwQSzqr+UZq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb05772-fc3c-46f9-0ed0-08dcdd99b647
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 19:39:03.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoCMarQKt4ex/Zy/t2RRcOokTH8pIq/05Zzai7/k86PZ83QjYayQlblsSk7uOnRD2rMztxhy9dAcgBJFlWcNGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB4356



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Tuesday, September 24, 2024 7:49 PM
> To: netdev@vger.kernel.org
> Cc: Joe Damato <jdamato@fastly.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; David S. Miller <davem@davemloft.net>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; open list:Hyper-V/Azure CORE AND DRIVERS
> <linux-hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
>=20
> [You don't often get email from jdamato@fastly.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Use netif_queue_set_napi to link queues to NAPI instances so that they
> can be queried with netlink.
>=20
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
>  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 2b6ec979a62f..ccaa4690dba0 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
>         for (i =3D 0; i < net_device->num_chn; i++) {
>                 /* See also vmbus_reset_channel_cb(). */
>                 /* only disable enabled NAPI channel */
> -               if (i < ndev->real_num_rx_queues)
> +               if (i < ndev->real_num_rx_queues) {
> +                       netif_queue_set_napi(ndev, i,
> NETDEV_QUEUE_TYPE_TX, NULL);
> +                       netif_queue_set_napi(ndev, i,
> NETDEV_QUEUE_TYPE_RX, NULL);
>                         napi_disable(&net_device->chan_table[i].napi);
> +               }
>=20
>                 netif_napi_del(&net_device->chan_table[i].napi);
>         }
> @@ -1787,6 +1790,10 @@ struct netvsc_device *netvsc_device_add(struct
> hv_device *device,
>         netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
>=20
>         napi_enable(&net_device->chan_table[0].napi);
> +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
> +                            &net_device->chan_table[0].napi);
> +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
> +                            &net_device->chan_table[0].napi);
>=20
>         /* Connect with the NetVsp */
>         ret =3D netvsc_connect_vsp(device, net_device, device_info);
> @@ -1805,6 +1812,8 @@ struct netvsc_device *netvsc_device_add(struct
> hv_device *device,
>=20
>  close:
>         RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
> +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
> +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
>         napi_disable(&net_device->chan_table[0].napi);
>=20
>         /* Now, we can close the channel safely */
> diff --git a/drivers/net/hyperv/rndis_filter.c
> b/drivers/net/hyperv/rndis_filter.c
> index ecc2128ca9b7..c0ceeef4fcd8 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct vmbus_channel
> *new_sc)
>         ret =3D vmbus_open(new_sc, netvsc_ring_bytes,
>                          netvsc_ring_bytes, NULL, 0,
>                          netvsc_channel_cb, nvchan);
> -       if (ret =3D=3D 0)
> +       if (ret =3D=3D 0) {
>                 napi_enable(&nvchan->napi);
> -       else
> +               netif_queue_set_napi(ndev, chn_index,
> NETDEV_QUEUE_TYPE_RX,
> +                                    &nvchan->napi);
> +               netif_queue_set_napi(ndev, chn_index,
> NETDEV_QUEUE_TYPE_TX,
> +                                    &nvchan->napi);
> +       } else {
>                 netdev_notice(ndev, "sub channel open failed: %d\n",
> ret);
> +       }
>=20
>         if (atomic_inc_return(&nvscdev->open_chn) =3D=3D nvscdev->num_chn=
)
>                 wake_up(&nvscdev->subchan_open);
> --

The code change looks fine to me.
@Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test this?

Thanks,
- Haiyang


