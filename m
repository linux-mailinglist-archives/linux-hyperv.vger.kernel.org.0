Return-Path: <linux-hyperv+bounces-9880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBmALmlQzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9880-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:05:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB037E61E
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA4083057C65
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6047D92C;
	Wed,  1 Apr 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bJPseRZp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012058.outbound.protection.outlook.com [52.103.2.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635A47B420;
	Wed,  1 Apr 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062726; cv=fail; b=RJ+z98oxglwyingnYrs3F9aUC5CPjZpBvby1NJDv9P5E9TZZL3e381vaHR548VL8ypMfuA3/tWieRm3wztA9cU5D5GolhE6AquP/huPW1Na6l+j/VRG0hLZ+9y4Qz9A/Vzv6QsNH9DMm5SMKZAQvvLIIfN2WrXu3TIZBfhFNN0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062726; c=relaxed/simple;
	bh=ucGHyzr0Gkv7/LyNMIC/WZZQLluA8OGG44UtGw2Hz8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ni0KMY+h/S6A32UocXjR+gTO8ntcUpfZVejgXIRzKWycwUKZjfOIzFapvT0dtOPhqTIiLa+VQFOn/WvxRqftyQnzWXoVvSmzDUy0oecZaKkNMfmlii/gUBXFAH/5muAAUKVeA+5mfiXLtI0xXahrzIDfJQReNths1fF4yC1NGB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bJPseRZp; arc=fail smtp.client-ip=52.103.2.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1+Iah7XkDUKPRw51SWnpwJUg6IUbQh4a06C8At5Dcp/c5myUMms1zkdiVbKiA5acn9M0XhFNaLFkQPeVTIzCyW6NcD8rySRJZkGaafPn88Pw5lkLiQkLdzCYiCDgkjG7R1oJU/Hb8bz6zRIwCQe+gIxOGenfTRZg3rawG5RUhL9VB5Jp3mawZg/uAwgBr+wG4w6pA/d2OH2bhaGRr6ur3DA2XQYgvzGS2oBy+y8U2R2RUXGq+h6bjtJQ1HPnK6zzOBNM5R5dJW6BusoEwSRVX+mdVfvV6PIZL89M/363P/7Fcm3Op829Uke9O0IV4+vUulXFGwmgIfORsUz5+Gdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuYbXsgTI6Hc7fnhfVHyXLMPJKKxpXE5mkn/FmUp/Hs=;
 b=WSCSWeJmmMZ6FGKdEbyK1Psxg43Tk9wvVl7qUWBYJfpgBXXETdDtRxPTd3agn6caq/HjSDI1qL89Ddhor+27nUACsZETJ7orT1ez/boIUl4MtCSu+F5nmgFoLb5xy+RbMfvJDuZUAx2lB6K+jpW9iKKpYeA0WAKHDrRLJ0mz7yJiJX6RjHF/al54zsY8I80khufBSuYrS9nWKLpSzbykW+lKe3d1tJ6PZUaYV0i41Sx0MMz++IdmoXvDJ8jN6HBiCBKVmoljoNLhVylXtNzeCcU5IYRreTM14d2tlH/mBrJXSV113kwOlAOaKQoYt3sIOeKjibBJwpF0hWUrjK5IXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuYbXsgTI6Hc7fnhfVHyXLMPJKKxpXE5mkn/FmUp/Hs=;
 b=bJPseRZpkYmd5kNA0WPkuSMYzbNiiMzZeiD4uEuRhGw8FeD7Kz76u3Xpb3a9KcEtsRKFkuPTUntRAla04cC0aIaqm5XywL6I1iD4+57IlZy+QLn5rMa4a6z+b2J64owd/qHj0ZwKJ5vBpwJjnO1duqwyLPi6UXveywO/aLgctfaTpd8S5irX7bac6m9gzC4xPZeQgzF4qGd08ur/xg1FRz2f7GB1c0/LFtMVBxyh1aR5ZImVG2TkG10lEgIYk9sC6NmouxBM7rNkKnU7hpbtJiYfBKkK8wDaDhi0O/KQF+6/nbrjI57JtWsglMa3CGKOWMYiBl3YGJHALmDuwPSGNA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8808.namprd02.prod.outlook.com (2603:10b6:806:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:58:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:58:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 10/11] Drivers: hv: Add support for arm64 in MSHV_VTL
Thread-Topic: [PATCH 10/11] Drivers: hv: Add support for arm64 in MSHV_VTL
Thread-Index: AQHctT5myuhC166WSk29PbKebDTp47XKhxZw
Date: Wed, 1 Apr 2026 16:58:40 +0000
Message-ID:
 <SN6PR02MB41576766C5FB291952CC58E8D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-11-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-11-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8808:EE_
x-ms-office365-filtering-correlation-id: 3ad41ab1-c5f8-466d-99db-08de900fed17
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SNFP2mjjNQO/W1TUB9EtXkkZX4LgdPCUwI6MgeRtd+tGAC9+JhLOiEMlN/qhrPGCvGmW/HtiyLjtN6nK5oxan09GU5Ukp+Fb0Ti3hbEwTpyQzcrLAmM1bZfZh42IsGgz1IK/pGzt3+aotb9hwtfNkNR3BcauZE2313JAuLOnuvwsLi7AcjMovMVEZMtvjvkrLoYXN/6deZwpHFkkJ1Z/AZA69DVAHh3fCkwsuTovk/0cdSzvB/EyPSYTMTjE0ub/dXT5BExE+KDXhaslRb5mqjY8kJWE7M+zexCjfNakfJtj2i0HCqipMJG0uDWV11pcL9mdFpRg+VEQ8BOWfXktZmhoi6SuOyK/UrUajD1YiJaPwpehkwRWwUQM0+B0IaIjH95SrmBKieTxxfR8G4dJsA1s7FK7ZNDUNfAFKpz3t4XxrvINtXfPOmI9ejvZTYI76ohUQdpBm7ZomQ1+lD13Uu8b0vnElLteZ2IVADv5ouxoIisH7ggTo06I37cmDg9K+ZVb+zO5n8tItCkcNQJ/Fm8sZghgtCqWti55RTW0MMPcwaYeIrjvqOn9wvKnvPow1gKALo3XTRQLTLmU5Lwb0uFhDJNkuVFlt70TjcNFBkgpJlh7Pv/AVIcWId/u+sCyQagJCG6CZelVJvhxM1JtYXqx2C5iF5n8tXsVQyzPQ49cq38SdwZ4mZZQvG+LOSoLALBReLd3PmpjiIDOR+thwi+M76OhM4tn/P6FDv66Kas4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|37011999003|19110799012|41001999006|8062599012|8060799015|15080799012|461199028|51005399006|40105399003|102099032|440099028|3412199025|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j7VBNWdYd4orb4gOOQPmGziV3mn7HjojrASjMc4gfympmw4Xd33vuSzk80G1?=
 =?us-ascii?Q?IRI1/l0sEvQaqDmHd4hs2aDXZfophPYa66mYEvpjf/vxRKwQO4xAf7U+wS18?=
 =?us-ascii?Q?D7I07bEMK7PAzVpinTTW1sBPSF19BnIXcfyshY3D2BOFsfxLY3iyooxF4TBi?=
 =?us-ascii?Q?ZR70381OtY8F1f9WGM96aIzPyX0vS2V+r5bTgThx0cpxB0Dtq1/rg2GkMAST?=
 =?us-ascii?Q?UtSfIEjlyKYsH58zy07ye2klRktHgNzD/yQCK2DBM25aRDQ66QUVHPDQlJX+?=
 =?us-ascii?Q?Kmg9mWbfzHI/yIdN7/8XQmW/6vGQ5+QK3CW61F2ItWfiG6/7ftL8Ub2gVw37?=
 =?us-ascii?Q?RkXUdtkc34iCUZjHFIsM1xDb9UO/rkQkRxpVCr0VuODna51y1qW5SvIq13f+?=
 =?us-ascii?Q?snZ0bZykn7bwYvxhOeTMOmgkLYMOqFZvAStTSuUbFmMhG2pFcMQqFOspHOhW?=
 =?us-ascii?Q?8Zlzl5Isai82Ub6oEM6aHI8mYPFqtXfbO0Lrglc4/iK1P8eib/OFzT8fxO8j?=
 =?us-ascii?Q?OtmjH8RuUtv90l9agKwZtC34ICaF5tQumKGlCcr5fQS/gv8FZU+zPvwEHPXd?=
 =?us-ascii?Q?MCfsEMK68iZtuh0STVmNcWCqRsLNyKPLxplBQfjfyucqo/i4Q3fZ6b4xq8Ny?=
 =?us-ascii?Q?VO+7QdKli4Aqz8xuA7uXY/8iaswzXKmzB+UN9UZWa8NDvO9XjAyIVtGyVOGT?=
 =?us-ascii?Q?Kk41QdzLXIYC7Mrub4RxaofIxVazS6PKJjTT7aYL8+vYyOePxEt3P6XIsWXY?=
 =?us-ascii?Q?mLzUDHFqwiI2Dnvw4gW8rU69G2F/eave30VKVR+f7BRu5hTVBnRZE3rpNlAA?=
 =?us-ascii?Q?lO0SfOKSXsPblHuhvT5wMiAY4BmicAsLpntAp6lme5PKBz3ZQvvNcyvyuQA2?=
 =?us-ascii?Q?TmPaZkXKRzN//7PKEj37tDcNyepi4W1i5qkEmgSoxh4xrd7rZijCQYWGe9t6?=
 =?us-ascii?Q?54IzMt9V28NzMmCr7Uoi9+G21+moOyX4pVKy8GZuZSdfi9NU4h8BoAluJadO?=
 =?us-ascii?Q?DCOvSB9U5ssqZ1ooNKy69IVDICk4ZAPOEdgrN+AXoEUsSwselq5onK2Z8PH8?=
 =?us-ascii?Q?MNLGZ9CC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?diLEq1gz9ZXnkVBXhKNLhNHyqLaVhER70inmPZjnfSDBoyu986JEyfaLJjEq?=
 =?us-ascii?Q?tlpvQ5afp8cfVJihGNIzrVrp3VG3KO43YRwebQwckdB4fWvqoP5FHHSQgyuW?=
 =?us-ascii?Q?R1eNH5E6XCMgmgI6h9RWbwBxS/YItivkZmR3ngZdj8GykfplKWoS+3w58TYY?=
 =?us-ascii?Q?wKu7HYbO1AEhJFkXd/ZjKVYFKux+oR45UunVjUL02bM9cxBaJrComZho6T20?=
 =?us-ascii?Q?7eERzp95v8xrJk2y2+B+8LCoGf50dE/Oofq13Dn+JSh8RvpUVMcINWEawg2T?=
 =?us-ascii?Q?DWG+CMxR4uqIxGmlvzaFqCQRsG8fpSvh9DDCnxN1ErkHD33NLD5ApSrdUZvL?=
 =?us-ascii?Q?UdGoTHwVSANy8arwSJ7RGUBtGjqPAvobcn4pv515VprwVkTR3G74ILe26wuX?=
 =?us-ascii?Q?BJCUSXtH6bd/EGYedXeBYna1eCu0hwrAsxhjOmzja0FJrovM4ScdmHO6MkdY?=
 =?us-ascii?Q?qVRJMF7KNGjaCUGGmPJUfuINil2qvKBIyZid3K0jPDgkKRD5a08VC4R+vrW9?=
 =?us-ascii?Q?hsmN9ZsedANz/AWbMjbCTq2wSbSUBd+K0wgX62quIiZQ0t9Ya4hFa+jrZgs2?=
 =?us-ascii?Q?QKfg+t7yLLjPHQ+hHjFllBWJ3tgeYXgfDUkSzYcqqdNoP6zUX3oYrkfXb69v?=
 =?us-ascii?Q?fUq49LkAlTjb75z1RkX7tdcSLsQXyttx9Ulmt/5cW4y3TRR0fY8oUwyX76Lg?=
 =?us-ascii?Q?WMFNzeuc03TqxQlBjTJ2R0jvWnvlRoU4+UxjmMrTT1KU7JBKCDgMr0vIkRSk?=
 =?us-ascii?Q?fQ61jkDhfTv+nz9tb4TLTAhcvTXgFaK9Agg7Xk+zIyuVN5xEHT3gyAw1Sn7j?=
 =?us-ascii?Q?R98aJf48cpq2KGqN0pCKIekiZE2EQEk/6AQs1mjAZthHPOZNY1jN7ibqOpDc?=
 =?us-ascii?Q?v7WvUmzhDZha1rysrbKLk9Y1r2pJrvK8Uk5Lp9Jt1NlWbweFl65mylYu4l3J?=
 =?us-ascii?Q?guHj9fT9Se/sAOagmbZjZG5JZa1LyRkchRWuKY6nWYFzn3dWZ8gFS2O1rDjJ?=
 =?us-ascii?Q?UUiW7vROjVst4fxaLc4txLTN92p83bNV1LQ0rMs8w2Nfu8PDvWJdlpJBBUKj?=
 =?us-ascii?Q?Cnv0u4h5H3+PRrprUWSJNFusRAII3Dle1b+qYbgRKPFM53FX9rEKinfbGBLI?=
 =?us-ascii?Q?0pRV+wTU1nFGOIrRjwTQ9EexnKFkH6V1+GkD+SXk2L8RCxxiZY2TAizH60iV?=
 =?us-ascii?Q?GPGgDesGrUiYBEn7XhNKZcQ4DpvslvI0mIet7EDkOgoyEaG+KVf5iG7lqdB9?=
 =?us-ascii?Q?n4Ig4LelcxskYTax+wcoBRf1256NUUYbPL4sS0uiI3u+5HoEY+ZBj+fIUanL?=
 =?us-ascii?Q?b/hoh0RTThA41PI1rW5qdgJLw1/37ztS3JZk3FGz99vzJ7afRpaeOxavVIOP?=
 =?us-ascii?Q?qruSZao=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad41ab1-c5f8-466d-99db-08de900fed17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:58:40.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8808
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9880-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 31CB037E61E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Add necessary support to make MSHV_VTL work for arm64 architecture.
> * Add stub implementation for mshv_vtl_return_call_init(): not required
>   for arm64
> * Remove fpu/legacy.h header inclusion, as this is not required
> * handle HV_REGISTER_VSM_CODE_PAGE_OFFSETS register: not supported
>   in arm64
> * Configure custom percpu_vmbus_handler by using
>   hv_setup_percpu_vmbus_handler()
> * Handle hugepage functions by config checks
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/mshyperv.h |  2 ++
>  drivers/hv/mshv_vtl_main.c        | 21 ++++++++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index 36803f0386cc..027a7f062d70 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -83,6 +83,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register=
_assoc *regs, bool set, u
>  	return 1;
>  }
>=20
> +static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
> +
>  void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>  bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
>  #endif
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 4c9ae65ad3e8..5702fe258500 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -23,8 +23,6 @@
>  #include <trace/events/ipi.h>
>  #include <uapi/linux/mshv.h>
>  #include <hyperv/hvhdk.h>
> -
> -#include "../../kernel/fpu/legacy.h"

Was there a particular code change that made this unnecessary? Or was it
unnecessary from the start of this source code file? Just curious ....

>  #include "mshv.h"
>  #include "mshv_vtl.h"
>  #include "hyperv_vmbus.h"
> @@ -206,18 +204,21 @@ static void mshv_vtl_synic_enable_regs(unsigned int=
 cpu)
>  static int mshv_vtl_get_vsm_regs(void)
>  {
>  	struct hv_register_assoc registers[2];
> -	int ret, count =3D 2;
> +	int ret, count =3D 0;
>=20
> -	registers[0].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> -	registers[1].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +	registers[count++].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +	/* Code page offset register is not supported on ARM */
> +	if (IS_ENABLED(CONFIG_X86_64))
> +		registers[count++].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>=20
>  	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
>  				       count, input_vtl_zero, registers);
>  	if (ret)
>  		return ret;
>=20
> -	mshv_vsm_page_offsets.as_uint64 =3D registers[0].value.reg64;
> -	mshv_vsm_capabilities.as_uint64 =3D registers[1].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 =3D registers[0].value.reg64;
> +	if (IS_ENABLED(CONFIG_X86_64))
> +		mshv_vsm_page_offsets.as_uint64 =3D registers[1].value.reg64;
>=20
>  	return ret;
>  }

This function has gotten somewhat messy to handle the x86 and arm64
differences. Let me suggest a different approach. Have this function only
get the VSM capabilities register, as that is generic across x86 and
arm64. Then, update x86 mshv_vtl_return_call_init() to get the
PAGE_OFFSETS register and then immediately use the value to update
the static call. The global variable mshv_vms_page_offsets is no longer
necessary.

My suggestion might be little more code because hv_call_get_vp_registers()
is invoked in two different places. But it cleanly separates the two use
cases, and keeps the x86 hackery under arch/x86.

> @@ -280,10 +281,13 @@ static int hv_vtl_setup_synic(void)
>=20
>  	/* Use our isr to first filter out packets destined for userspace */
>  	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
> +	/* hv_setup_vmbus_handler() is stubbed for ARM64, add per-cpu VMBus han=
dlers instead */
> +	hv_setup_percpu_vmbus_handler(mshv_vtl_vmbus_isr);
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
>  				mshv_vtl_alloc_context, NULL);
>  	if (ret < 0) {
> +		hv_setup_percpu_vmbus_handler(vmbus_isr);
>  		hv_setup_vmbus_handler(vmbus_isr);
>  		return ret;
>  	}
> @@ -296,6 +300,7 @@ static int hv_vtl_setup_synic(void)
>  static void hv_vtl_remove_synic(void)
>  {
>  	cpuhp_remove_state(mshv_vtl_cpuhp_online);
> +	hv_setup_percpu_vmbus_handler(vmbus_isr);
>  	hv_setup_vmbus_handler(vmbus_isr);
>  }
>=20
> @@ -1080,10 +1085,12 @@ static vm_fault_t mshv_vtl_low_huge_fault(struct =
vm_fault *vmf, unsigned int ord
>  			ret =3D vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
>  		return ret;
>=20
> +#if defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  	case PUD_ORDER:
>  		if (can_fault(vmf, PUD_SIZE, &pfn))
>  			ret =3D vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
>  		return ret;
> +#endif
>=20
>  	default:
>  		return VM_FAULT_SIGBUS;
> --
> 2.43.0
>=20


