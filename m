Return-Path: <linux-hyperv+bounces-11689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k1guI2J6PWor3ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11689-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:58:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3275C6C84CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:58:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=IHdxQvxE;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11689-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11689-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97CFD303CEF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F13375C5;
	Thu, 25 Jun 2026 18:58:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011028.outbound.protection.outlook.com [52.103.13.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5B25785C;
	Thu, 25 Jun 2026 18:58:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413920; cv=fail; b=TzqaOXPhu5ilqwDfYGw2Rk6zwRhjOP1h1MkqFD4xKTpuFCkGpoilEzweD4VIJ0Pc5TJ63VM766p7g9z9tNfP1avV7pe/x1a7vfwaZ81Z5SciLfTWcNBMTXTWUTWzUdX2FXubUKJQKZ2g6lNvt9Nyc04LQrInt0t6quASmC/gvAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413920; c=relaxed/simple;
	bh=wEiFPRVRcqXjh56oPl8rGUAUZ8D6M0uwGIQ6SOWs52A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6AuxIxdd4ZievE8GUeCVC+RgNN68WhKnwWiuVhZMCEQa71DsQ6HyfzCF58QdxU8svFCStr3DbJWE4VOec19DUZRCuzMkWUKdJi2IAri9J0HyBPBTdOMDpQxPwtoP+LRaE7wvo5lx0vIyEf24K0a0AQ1Kcr9rlpkVAEo/IeYTLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IHdxQvxE; arc=fail smtp.client-ip=52.103.13.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrtRNq5+ejRnIfJj5HdP21YaG/6L+3R/1LRIAbn7uj3A4D9aH5za9RdXG17in9MJ4umWdTQpykjClwAcYt6NBaCKvZ9KMGGVTYeMnQXTCoU6bFbSstLIen5pDVs214XlE7MHcFPVttGxy29zysdece4JQjdFeLuWHSvFoSDYjoFDzTQmKOFFWJieXfzEdbxdb51VUHtGfbCnBAukXY2ZfAqUoXt2+eUnehZXqSW0EjOMg6dM6FkaFlkIeGWLIU+CHuN81p++03IxqAOdBGqu8k3mgUz18iDqnFyOpJcvHi3K+zF5nHaVqkfWVnbw7MDIq0x2mnxx/pLjesFKcim8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKRb2Te4+TTC8h04sElQabyuzL3xj0Lof6n5W4jQyXw=;
 b=JLbLAJgFewwtKC4ixMjRB15PrZB5F3YutDcqKxV5R61sVStW2Q4daH5g0nnv8xnXE07mAM4sX1eE8bz6YHDc4kAhOyXYMkY7UyWSv1Wneu2b+fv9EJqIWAoPZ7dAGtqZrcQObh49dKvNJfnWKt+P+TNFFcBkQ++jC/cKcFdCksMcAK7N1JWsEX6k44iLm/ng33hTA8w/OYyz+7Gz/CVfIEiw89MSjELD7i3N15S96syG8MLktgo5xtBXXtIy6qNFt0TxiJu42xXsxh3rrh04a1tbISvESIqHgC17md02J+tGoFD1uop7/AVnhA8yyL1osUb0g/oEK1KVOChgzT2Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKRb2Te4+TTC8h04sElQabyuzL3xj0Lof6n5W4jQyXw=;
 b=IHdxQvxERkgbvw9hBZHOWrkkeVwA12o9lnU+40jgngN7SvdaL4v4G8iI2RLCKSiHOEYerhmEtBC52dqRQDNw4UIdXLMQFkohve61Kmux0KdffEBOaaRi4tUDnbugsx1MkYgLnutIFfSQvddHC06D5eHBbvhQCYnijqP7j0rz/9TpCvYdJRcFK3+Q48z/AZp+3JEgZWWYB4lj6cf3B6sJp7P+CzDlEPTClQu/xbflLZsw9uQ0VtBhCAtfNGeDz0SnefO7SCzIeKW5jpxOVkXSFjpOoXnzPyYd4zF6K65Sv0kt9c2tnt/831rlWAmdxa4D6SBKaNioU5nqmj2BkDb4Xw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV9PR02MB10808.namprd02.prod.outlook.com (2603:10b6:408:2f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:58:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 18:58:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Topic: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Index: AQHdBMj4p7vUSbVMmE+fvPgM94V6W7ZPn6qA
Date: Thu, 25 Jun 2026 18:58:34 +0000
Message-ID:
 <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV9PR02MB10808:EE_
x-ms-office365-filtering-correlation-id: 4c763697-2660-4fa0-df91-08ded2ebc1cc
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOF1PXm9A0ZeLXlonzuv4zShWHoLxy+yb4jG48AWNRbLqK5F7bjFuuAlHBu9m5lByTPe1M49V1EsKDigMfNjwBmt21b+Pz1GNlTMSsZgiWwvKMw7venhi4TbDb7kWSY3dAnT/+iX9FYlsokrfP+i/yfc6zzo07nWWt/wqxEDYRr4YO2TUQV5WYyIkoGVZ0bOYsLeqgsCXe+jOGf7GE7Y+OqA7o6+bQR/ucmTPDK3SRIkvAT6nGoN42t2yAhR+dh2ClnLtZpgqJKdnZ576rXCibx8y8AG+vXMI926cAxb2io4or+eZKn6N61Ny0FMmEs0UcTiB+Py8kE9k8n4GzAcY81OdHmKslYYaKkNapPPJpvWDcFmicrcU6fUJKyZP4fpOfTNFRcFaJ3vV3ZIaxyp+vHrmTlyLszBfaNLP9hYV0MXiC59Oto1vzS1SwdJyingtBq6mNHMMrPzZFnx8q/wYfB0rk2ExWGiiQsdFn7l5ZVZ7Aayk4RySfzW2AMw8A7mJo8adFooGneSlsO8GW362Vv9n8UhS3FHY8jT4iK0+lUJNOQ11XpPoGdaWNX7AZHhN6msfesDdqyQ/MTn9DAe3DNt+7JOb8VyWUNcnOFeWLKmVZVctp2IONHKcvCygMKyJKO/PW4FQH8gyWwdRkbInN2/zn3l4RqTG3pre242+8J5wtfw0cfxqrqBP3UHWErn2NhE4ICR0JjpC5uU+rw1pCY0Z4k6AuqiELHmYdtKlxsVM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|8062599012|19110799012|25010399006|41001999006|13091999003|51005399006|15080799012|19101099003|37011999003|102099032|40105399003|3412199025|440099028|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SCKgesLeJYlPhR1eLEfjJeObHWPrHjmwe6+wtnmTwlnveRPm8Kk7+y1WWIIw?=
 =?us-ascii?Q?V4YKkPz7dZQJxyV4iJn05mHyS13aU2PLSs/mvpAASTR7Jf+YrHFJcpgLqubA?=
 =?us-ascii?Q?lERpUnHNfEAzvfzyPBkmNL6RRGPJeNfkLCHaikrQtk4IqIRA0NsjWQMPE/qc?=
 =?us-ascii?Q?mHAzWcS3u7qVZtDIPzVmNpIi56x+dpbJZwkvBwtkY/vd/xATCwNN8YM7F6zV?=
 =?us-ascii?Q?9OSjVN+DbpgL8OzyO80FfEZyZKtL/HCgKw5Hh6+eQGXfo15KmBs1BjhITDID?=
 =?us-ascii?Q?LUePAyWmBrlqwIgtMiwkGLtNCU1vIGZ/5nWCrfh73itjoLDNi4gY5cpcuxFe?=
 =?us-ascii?Q?l2qMQMVNQLtQQ7Fn+t6cNKHv9qx5Oo62eNoySvn8dpqQunOtmyfWXhKXhtLI?=
 =?us-ascii?Q?tMe5VwqcBSUUyNho2MRuNGaBMTHmX+z3zC5J05VTy3bgs9JiqAOjKVzEeV4c?=
 =?us-ascii?Q?Mw7cANuoC+GGYsqVyktbTDGGh/qyJX7yCbdHQCacXKst25ncpc2JL7mLciK0?=
 =?us-ascii?Q?kfERmTam3p+Q5khoeqL3V5X9AUZ6IS0XDGh7hKYeKEaBYxujLM5CfuT5EmbR?=
 =?us-ascii?Q?AeJJM15oIFHYbRtRvjJDUeO2Y9zl8C4xQ/a6bQ5FL4dx1NB9CUpl9ZJ9iZIY?=
 =?us-ascii?Q?/P6EXdfcILoTWGPDyeg60Tt2q6oQNrcibrKup4D9GWez0R45CbKrFVgCt9vQ?=
 =?us-ascii?Q?adHCkyTAwPrjqXRe3XhCQdSyzL+gGMht0GyPnVobSvSRw7tz1tltC1VYi3LO?=
 =?us-ascii?Q?gJwlNWp2Ekg3mjF5/FEZEsfod4JkN+u7KuRapX4bqon4uO2Ss7Bv2vgf/GMG?=
 =?us-ascii?Q?zMy8++9gG3M5dyEmqMMJ54Gz+oS/zmS0h8nHCt1C+0ksucuMzOwNxRw5z92a?=
 =?us-ascii?Q?nWy74t7n1lQsytvR3sz88c5Ped6S8Rbhq9uWA2B/fh4yP3I0CixjxUvHiq2M?=
 =?us-ascii?Q?Xhmmnr6o/0RFf1I5t9oJlYu5imR8oxH8/ua6sKNFwMLoa52Ze6fUWIXu8lPA?=
 =?us-ascii?Q?mjcuWHgejqxLpev9ufd1oZ3+MUo5dwpBxYCdYH/bvQEZOBtJq4WP54iwXvEJ?=
 =?us-ascii?Q?X2xfgiz9ixB8roNHI7I8LClXl4818Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OQudI4QR7iVLnlKSJ/4/M20z8m/Jaqd3GE7FF58bdGr9XIrIQUQhv8pLtk8q?=
 =?us-ascii?Q?CLh8W+wbPGTdBlDUJzLgX5/SXq8fAbAHRrGnhfNkJ/P2txOhb+NJd7z6v9tR?=
 =?us-ascii?Q?j1/IpFMRmGXh3nrp6ECBHA1Bx0twpjf9owXAqSoIyHMTdNlbq5+YjmCd1cHY?=
 =?us-ascii?Q?vODV7KY4O+BqWX0oVspjLnDSd48w6ioH2v5PjwPfK+UASMzVOM+XqhghNM7l?=
 =?us-ascii?Q?3ZBb3977pH8s8to9L688IIpZfg6ckyLQFPiNxAcZkVjDkkmbMl1XusPplCeH?=
 =?us-ascii?Q?Q3R958oQM4Vg3EPUcy/X4eN+YADxjqdGqh4hQ98EQMrKtFMPdbnb2BjssonQ?=
 =?us-ascii?Q?/s7zkVeVkAn4nRM0kBgWha8xG6ywe3yBaNkxKHu4C5lw3toP8mkJPmp5Issu?=
 =?us-ascii?Q?R9g/+yVgFqus9/6vUPnnrekEiti5S5fwgkdHkVlZffilVjKTsraRLXPmb3rb?=
 =?us-ascii?Q?9WN8ARvOGy+9RKX9jwjcBphfSjFTHNjF/SGdlnfF3ZO+aAX6kaIM2wMZIN3O?=
 =?us-ascii?Q?gH0k+YFBplN0Wzz4uBZl6pFYys3JpxSynRuihVQCDtAekHeZGUnvsKb4g9Wn?=
 =?us-ascii?Q?b/yrjvtNh8I3kFkWLXOaOpVr1xTBb8BafQwpz8VmHpMoiafOowrQbN2N987m?=
 =?us-ascii?Q?uJ6Wxb5Gn2QTLb/s9SuIY1IUZxIYn5DkPtROkZlghVdRfWg58oyD9S03oM3f?=
 =?us-ascii?Q?GwE20qvyshtQWZ+QCMQnN7q/ADCZu/HIf4YiOLOjktvXEdNrV+ngfDiGPHTx?=
 =?us-ascii?Q?HV5s+5jYiG8MYRzkUgzk4DXwLiqJeDp74Xuhw32GGPBOuC9RoSHurzQh6zXw?=
 =?us-ascii?Q?CbrbGysJctdyRsavKl2QN91aDFYeEoMasmboLatrsHT7Xgv8TbRF6ex5Ly4+?=
 =?us-ascii?Q?bBx/flzCMtLGKNBbjB+W14yhY0SCLW4Q1JhExc3/0JUTHI+nUNo5k77yEGpJ?=
 =?us-ascii?Q?x5MEwLBSEsDnykyZiRiLvM2VYVjiACRMcZuU52dAOxTpUr4PsON8wRuKuZsM?=
 =?us-ascii?Q?1uSXyWPfJuarknayxbYcC2dd6eihoDYMGxYzmfDkle7Au689JzHj7r1B3Irp?=
 =?us-ascii?Q?hu7GK8agF8bLC6+qnp6lgwZXJ4IYVaF7jMgwxIuq6Oy3AFFTwDafBylc7L+9?=
 =?us-ascii?Q?zY19dR3PM+Xby/GGRLX6PXqlLcg3/s4DoAzZ8jnmv1QNee4zqjlXtLP9AO/h?=
 =?us-ascii?Q?rssENvvcGAvFjsWPjBxNm5r1+XFaAfRsfa4YaLOeVlQ0YwUfh/2puXTqqaAh?=
 =?us-ascii?Q?9C+69aUBr7QULgHkJFG3ivE8FE8+xD7g1K25XH7DCwVvWUO/KvvLBjhgbmK2?=
 =?us-ascii?Q?Z4RQ+SKFgu3tlge9+yMX5ZFbS72WuTw3WUYSeKqzV4XRYGyNW591z5GX+Oti?=
 =?us-ascii?Q?Oh7X/Rk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c763697-2660-4fa0-df91-08ded2ebc1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 18:58:34.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB10808
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11689-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3275C6C84CA

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday, June 2=
5, 2026 10:35 AM
>=20
> In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
> to be marked as decrypted (shared) for confidential VM isolation types.
> This is already done for SNP and TDX isolation; extend the same handling
> to Arm CCA Realm guests so that the host hypervisor can access the
> shared hypercall buffers.
>=20
> We need to round up the memory allocated for the input/output pages to
> the nearest PAGE_SIZE, since set_memory_decrypted() requires the size to
> be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that are
> using PAGE_SIZE larger than 4K.

I think this change resulted from a Sashiko comment. My understanding is
that the ARM CCA architecture only supports CCA guests with 4 KiB page
size. Is that still the case, or has that restriction been lifted in a late=
r version
of the architecture? I'm in favor of handling the larger page sizes, if onl=
y for
future proofing. But I wondered whether your intent is to always support
> 4 KiB page sizes even if CCA doesn't support them now. Another way to
put it: In reviewing code, should I flag issues related to page sizes > 4 K=
iB?

>=20
> is_realm_world() is only declared in arch/arm64/include/asm/rsi.h, so
> using it directly in the arch-neutral drivers/hv/hv_common.c would
> break the x86 build. Introduce a Hyper-V-specific helper following the
> established hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.
>=20
> On architectures other than arm64 the weak default keeps the existing
> behaviour.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c   |  5 +++++
>  drivers/hv/hv_common.c         | 17 +++++++++++++----
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 7d536d7fb557e..8e8148b723d9c 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -164,3 +164,8 @@ bool hv_is_hyperv_initialized(void)
>  	return hyperv_initialized;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +bool hv_isolation_type_cca(void)
> +{
> +	return is_realm_world();
> +}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac6167891..17048a0a18729 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> +	const size_t alloc_size =3D ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, P=
AGE_SIZE);
>  	void *mem;
>  	int ret =3D 0;
>=20
> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
> +		mem =3D kmalloc(alloc_size, flags);
>  		if (!mem)
>  			return -ENOMEM;
>=20
> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
>=20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {
> +			ret =3D set_memory_decrypted((unsigned long)kasan_reset_tag(mem),
> +				alloc_size >> PAGE_SHIFT);

I don't know enough about KASAN or the tag situation on ARM64
to comment on this change. But this same sequence of allocating
memory and then decrypting it occurs in other places in Hyper-V
code. It seems like those places would also need the same
kasan_reset_tag() call.

Michael

>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
>  				return ret;
>  			}
>=20
> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +			memset(mem, 0x00, alloc_size);
>  		}
>=20
>  		/*
> @@ -666,6 +669,12 @@ bool __weak hv_isolation_type_tdx(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>=20
> +bool __weak hv_isolation_type_cca(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb9..1fa79abce743c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64=
 input2);
>=20
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
> +bool hv_isolation_type_cca(void);
>=20
>  /*
>   * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> --
> 2.45.4
>=20


