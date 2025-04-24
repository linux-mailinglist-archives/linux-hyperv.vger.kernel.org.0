Return-Path: <linux-hyperv+bounces-5093-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBEA9AFAB
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9331947F30
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383CC1A8409;
	Thu, 24 Apr 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LcTvzRB1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AF1A9B29;
	Thu, 24 Apr 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502524; cv=fail; b=NP10bYaIRQIl6b17BeqQEE9TVZ/Y5wy2UtEgOdxFueNjG7jrzP8Pf9d3s6GrKTQZsiu9LTBNDDSeiOPQeqEqXfGlZBkdhmFMLvHtU/I7Lsy09PjlLy/fq4Q3ldDQJWJzykdaZsJKNat5002G3iJ02d+k9c/maJtPH96IwHABxYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502524; c=relaxed/simple;
	bh=gfusUIMgZdNVW6slfHVDA4++A+tIRrwJDxxL/vlKNcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSvlWvKE592sjJUrliYiHXbdg0tDUZvyUSNacxIE1UDPwY7Rdboj/o7VHPQlHu2NHsR2DX0KcGFsTc0ZqdekLqoMtsYDvH75gfI6ByUKUZ/UOiDEtZ1XQZGFXidmz0IuSVA7sEjprvBQAtfyQcd2a3Bm713xBILEmMDcNR0KWoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LcTvzRB1; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHy5APFtSKsBoEPGs1xeDnTt7Qe1V/orilixwRlevWyVw7gPbtQBygsKTH3Qah6U8Kkpn7tEiVIO+Bg4n30E6b693NXM5aMP4BDuG5c0cD6K11RTzA9jY+jJEXIm0gGuPxGmatkjXU9trhcJlwPhNp4Q/WtYaUChWDjU74HdqvF3hybTg6p78i8j9qE8DrUBhXxlpjc3wugM/LxogLs3b4u+FLEXsgcjr5vl3ldcmtB2XyfvqlhgDyHODmCzZ2Q97N/92znIViKRwQiMSGnZOqCOKIAurY3OIzyA4oY+qZMcxLTAdDYf+4knSXOGEmNwAk9n82m0+cvKpOYQp5biyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIOPVUpCEm3+nRwc3+DcYkH5NKOjOTbURlmaScVb94c=;
 b=Lppz6M4wYBzHvo7BuamjVjLIG8SvY1vbAhED/tTXz30wsr7nZS9JXP8lZy6GPFMu3V66dOWOqQepmRdaEfepbVlbi65ksgF1hnL+NECiPMQp1SW9EUNVZFzn65CgI5rGrdP4euX1ytLOkEhIJ9p3jvGbcXFAWVRktH7SAhS/ZJvdTTRGvaJ4hbCwbo8a+1eeSX9yGx75Q/t9UwONQrmngHJTz/xl2nDHp6IuXooNnXTSxa3uufqKDVXAox188g7CgkXJVOPUCt+XAczuwhq7rCZuWHir6dFs9LqRXSSz2q1uMLrvXscj1YT3IQeNisxAUQMNAu4/gwxon8LCxFDlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIOPVUpCEm3+nRwc3+DcYkH5NKOjOTbURlmaScVb94c=;
 b=LcTvzRB1YJ03QRHUeVBGvy/d3d3CBiumgCWMw9Xyk+h2yilK9Q65sRoVfj1P23KQ0DhI8ScVdg4waHZ223IZY1R4VSvSqDOJOkJSaIMcXwMJPbM+3VSNbLKB0A441BQ+PP4ob/SMbVYHSqyBcQh0drlL71tN6+3ITCmtHtn2Oqj61WpNqT2BfTICXEbrJZVlXSsfgbLmnodwtrxh1ivq8dqkJ9r+wU/qf681Wuy5JgDT5N1WTRtXT6VF3IVvYfFmPAtmfn5w2NLbshcjNwIHt6OyS/rDUYykV0rH9mKIvjuV5hpWH+1lsZ8MowwOljsboH7BQYdhDDw4PEyY/EOBeQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYYPR02MB9825.namprd02.prod.outlook.com (2603:10b6:930:bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.19; Thu, 24 Apr
 2025 13:48:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 24 Apr 2025
 13:48:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Thread-Topic: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Thread-Index: AQHbtNq0cr/h2nAp6Uaq+yUzZjBCvrOy1Bfg
Date: Thu, 24 Apr 2025 13:48:38 +0000
Message-ID:
 <SN6PR02MB415788B8A1C18603497A9653D4852@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
In-Reply-To: <20250424053524.1631-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYYPR02MB9825:EE_
x-ms-office365-filtering-correlation-id: de3be7a2-2b30-4e53-6536-08dd8336b758
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3gr+YHKmSMzj5jlTHKVEqRiDfwhIf6ekDOfCz0b1/JvA03VrEDoyLRG8aGmAf2XYdK7VpPkd2GcIHq1mxBB5pEmCH+QmTGYtobYP/LKrWS9O2/RpSxDg0TEKe27BcoKjijd9UTggsGXjqzPGVfqgsgsxDJobh6zByGKkhIdvfbQLMkgyquqYOVZxy3bXmigXP7pGxvREfkGLNOXjnJN73v24YsPiV0bEt16Eqqefv0xo2nQxdvQmKG/4Dfh94bSock9dup1Y3ROQHKZ/KwEfu41+gH55eKCzkvPFhHB4aMnXyF/hOoHg9Tm9h1UZ9Z6AuZ4hw5PrD5iUgPPXhkW31tu+ksMTsKuuQxLsMfmj05wajv1XQVr7QeranBOka4tpwDvpwQ4gY9DYjXo+ep0Be5CcOFdGnx07fRzIYAztZc6NhKmDt+YVx3ss0tJ7c2zV2uZ8o9QfOvd9Iy+QX57BU98y9GYSlT7RvXdxsRhTYPeJ5wVhCd7hmRgUB+S3nxbvEJFtjKAEWrcIXY4UGHXm45H/O3khrbRjAnmCn/68zYJxGkqncaeLyzPgeUu6bfd7BPaNX3FnmIFg/CqQ7JZUu0+NK7qxKAi8VZ0MpYwC7uvfUAZEEaCZr8+tUQJVA99zWcaus3bqziTXmRE8m97QtTw5PZ69vgQleoujJxpTAE1EweAW7XIfmI0GFUZN/SRMskDbb2zxP8+EQG40GLc2nO7cZ8p/wz/vlnT2XLxR+S0vSqkfH5oG42i1zZw1lyyoY/3A2d46TWoVIJ1fcIUy5VB/UFgcsKgvKI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|10035399004|3412199025|4302099013|440099028|41001999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JW71PjcypIASZioK73YNbZxANWy7OUXjNpBoxw0Wntfgdaz/T2acpRu+RStY?=
 =?us-ascii?Q?RoNrjlj1yqnK6T/fgGdVdhDkewmUmCw+B7+7bdKELAgg1JW112kk8DPwlh5c?=
 =?us-ascii?Q?+0LDWKQ9WShTQTs0hW/no2fBPNmwurMhycn78jmNErEoXsnRbcQoJcSMt6xV?=
 =?us-ascii?Q?EaW6zXvm38O/MNxkApJKI+WnuBH4VciN1G+LTq2797mATCdOAQDJhf4HuJjg?=
 =?us-ascii?Q?74utvzlkiFZDy+0+g9QqQLn4L3dLVlWy7jEJbUkY5qn7+7mRK2G0s/uHM5RU?=
 =?us-ascii?Q?HAH5mrtScv6QNZgFIswga01+NzFvOJFqvqe8O3WEMJw8fqrAyja31vBpKVgZ?=
 =?us-ascii?Q?Wsqll2CfPK8l59Fi0vGKDV+ulAvQyfdrNi0I4uv4vs90FsMhTOdbinxj4xD1?=
 =?us-ascii?Q?uHXcLzLrlIMgoTrFuSWjwWhFMIKKJJtnE4HTUWLnfPKTQipZqifuYtmPHJnf?=
 =?us-ascii?Q?MYmGqWGwGxCTcuZGioq/nAXptFxJ23hvRD12Fjt62rk2t0GSo3WrgsLVwTUt?=
 =?us-ascii?Q?xs072UFw9awUjkHbqZlM1JzQwo+yiLFRAhASp01M6HLMozI82880YSQ1Ujd0?=
 =?us-ascii?Q?KA4PxIKKABXoLVYy83DYSpK/RuWrGB2vqjgrCJXCjwL9sa+Sok/J2VZ8fLQ0?=
 =?us-ascii?Q?9Xtu9FKULCnMnpP2bfW0ZUIZOA1lE3OAjtUw/GZ/xadwfCLaac0TOpbM4jyG?=
 =?us-ascii?Q?zYq6uJMvr8EnwlWRo5vctup1pfWv5ZYvLQN0P5lk9WYST1hdWeT+lD2MR7SW?=
 =?us-ascii?Q?1d661NjVf6eVcCzCbPIQRQRUQcuWwyqapGBFE7K6I9hG5ggrxgAb2HWyIJt7?=
 =?us-ascii?Q?F6+yof2FxpOAV6Ktx1dSuAWVKgpm64Khnq1YLASgjCcC9wQ8WTdSlqoMw3v2?=
 =?us-ascii?Q?+88b/tchyjOxE4tntdt9t72FGKOax0QEOKHX7NkNhnSt3tkVm64yhebLMlGB?=
 =?us-ascii?Q?fgmRNelvzKGPsZidU6z9z+96Vf6DCCS0FIj5AP9cKRnIa/9guFb8P/ApLcwE?=
 =?us-ascii?Q?1leHQQwi6n/C95oouTFvu79numHQjxT8lo7CN40Sczs9bIG3Q0OI4PWtxYQK?=
 =?us-ascii?Q?ou/Az7LDohIZwq2G4+Swo3+Gn1n5OBWEsAwOU2zbNxNTjwX8pbg1Pydkhiiy?=
 =?us-ascii?Q?LxboUBuAOIR23pAbnlqQgWVVyfIUaq7PvAzk75mZAnEan1yL1e0Vamj9EIOv?=
 =?us-ascii?Q?Ha7Joyj2B6iXzjlPlRCnI4lolOZxS9dG84lK+O+RY5x2EgYtUPKNTSlGmDx1?=
 =?us-ascii?Q?2jQDGfQ3CQhAJymf0NZlhhJE8yRBhsmwcthD4nl61A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jq7jgtoVDOZh+KyPt16I/y4wSaG/hAIutw59vo2s8TMR5rotqtemnn/yqMoA?=
 =?us-ascii?Q?MQJ65kFNwGCZQoUBRVj34PlOob0ujyg5kzSS4vLnFJnefC2r0ghhQaxoZY5K?=
 =?us-ascii?Q?f4+rRlgttrMg9VjNFLBgx/MVGNosFEPXH05qWsp6sOqJBxVBUsKTrllmp09u?=
 =?us-ascii?Q?sQlEaBcZGB95qr3QmXuLSz3eoI3OpA6s072ChIGErlZJSwXd6+/veinrdx4n?=
 =?us-ascii?Q?4tevNC1wHdzIN/glLQ/Z+syH8dSopX3ekaM18fQcgdpQ4xf5NNzSw8jb6vsE?=
 =?us-ascii?Q?/2vDzM1qVArCA4zGPpKD/UwT+VcEsFDB0kuUW4W4nPePI6s0HGymMx3VbxNI?=
 =?us-ascii?Q?6W9Tqk69w2ka2Yec0EMgVxJoWuYFNNhMOjWOs/i5HzIhuy7UNpJkOVlKJvpY?=
 =?us-ascii?Q?hKQIt7GZjv8i2q4WcsMbxHhI19d7sQWjVjPPncyd6/lf5KJHxznI5ogYkUC/?=
 =?us-ascii?Q?Q+/dlS2LyaxVoh1LscVMhWK65SMVGSarKrhJxczenEKtVUPi48gI3XjYXlKN?=
 =?us-ascii?Q?0w7EP6nHF6HmisHbIY2vVwdXsY5YManyfPryGSl7h2eraPr5Tc3OFflCYx3B?=
 =?us-ascii?Q?/ybdtEySfjSwlpBnS9FFZbevRpKqpoqM92D8uBsGXySbxq5VrYhpKwW2AyiT?=
 =?us-ascii?Q?J4sBSRroROxE3ihXLvaTzQzRw9AUFqGL1jdVCzhfDmUjtaWhk+E51DUpXyC6?=
 =?us-ascii?Q?J8bItw7nyaUdQlO5c7elcqZfeMcT8we/fagCM1u4TZ+JWDVWtHRoY9KMc6nB?=
 =?us-ascii?Q?76VWrDrE83d1jfKLsYEH9LHxmXvKWu9W5CW7VvC5gNUs2MLsw1TN0Hh4ZVPy?=
 =?us-ascii?Q?2EnWP92ovnV1AAkq8urefReGdmgD3gTzmvzJnRXG1ogJOpHUP7ocNL2Mh9ne?=
 =?us-ascii?Q?46VD3y61HebBOJkCCX8OdLyjj/E9LyRyvAB6HZPkQ+UEsP/TbuHlJnquJYjQ?=
 =?us-ascii?Q?lQ96Ttk+XHKLBYwS/OXkijQTqQ7ECZZo8Rj7KZ0Yoyu2gOa6iwiBiKrnBxmW?=
 =?us-ascii?Q?NC7iK592vlsqRSOQi2HoMGf6EA3+azpgA0rCN68OT29ELA49e4AT4CTxvNx5?=
 =?us-ascii?Q?k3uJ3+QDV+I4pfzPIASGR9oul9cbxoc0qoL8DALBXxvIO8sJs2l51b3Zm1Xr?=
 =?us-ascii?Q?bo0MBhl7a6bDkU9gle8G7nP9JGYcle604dL7V9h0ScaXahXjJod5kFuCtv8V?=
 =?us-ascii?Q?EUbsjCKwGTDkvDatTFSiK6wpvSumF6Z/WXjEnBj4LC2v3WKDdfafA8GeQhQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de3be7a2-2b30-4e53-6536-08dd8336b758
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 13:48:38.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9825

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 23, 2=
025 10:35 PM
>=20
> Hi,
> This patch series aims to address the sysfs creation issue for the ring
> buffer by reorganizing the code. Additionally, it updates the ring sysfs
> size to accurately reflect the actual ring buffer size, rather than a
> fixed static value.
>=20
> PFB change logs:
>=20
> Changes since v5:
> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microso=
ft.com/
> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>   commit msg of both patches.
> * Missed to remove check for "primary_channel->device_obj->channels_kset"=
 in
>   hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>   now.

Ah, OK :-) I thought you had decided to leave the test in, and I wasn't goi=
ng to
argue further, as it didn't hurt anything. But the test is superfluous, so =
the
code is better without it. It won't mislead a future someone into thinking
that it solves a synchronization problem.

Michael

> * Changed type for declaring bin_attrs due to changes introduced by
>   commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") whic=
h
>   merged recently. Did not use bin_attrs_new since another change is in
>   the queue to change usage of bin_attrs_new to bin_attrs
>   (sysfs: finalize the constification of 'struct bin_attribute').
>=20

