Return-Path: <linux-hyperv+bounces-8958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOM+HkeUnGnRJQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8958-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 18:54:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D917B23B
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 18:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E62305BFE7
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCD8339847;
	Mon, 23 Feb 2026 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lCxOOiPe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010043.outbound.protection.outlook.com [52.103.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869278248B;
	Mon, 23 Feb 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869187; cv=fail; b=OcDReTrhNhYzU9pF5SaPnNKbdd6KSmXUkyJ6qQrlNAedOy3ztqolgvOvtoAYxAxt2dNqGLI/hqAerLkSBvMPHaDE0nQVQymkGmzQezNXV9ADKxAZICsBV0Et43H0hkBT1G+K/IYnfOKN/UW6qzeukkroed94QMkUly2L5/GcePI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869187; c=relaxed/simple;
	bh=BoUyO0BIKvaa8OMW022vL8CDgPOR7NBpV2Ylg3CV02A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O6mx14FKyEz5wBOeG+J+D6txjzmP9qEQUvm0HhqPzVhxgYPdlBbpXsmPgHdMJQRuH1cDSIwBpMNBzerR37kfRjhjFNRrqUt1v0mV+Ag85DBVfJju0AqwucTg/pfiyJkbYAEg9fKs/HFi0gxe/R1hNod548Z71TXLsRTlTwEw9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lCxOOiPe; arc=fail smtp.client-ip=52.103.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URtm5Lnl/vRsTosOh4ZnF/CqAbZgcRnp8yFwsRwLBWMCL+O9UTzGMmDB0lrilbqhzAWSYEvEaY6R+I2ch/3pLTsBMK5L82thj6DOrUVwDwa7onkgcvyYP5ZqNbqRGJAfJnwggcOd+UXdgSmXVZ5RvuscX3ayZCJGiw08Fai6HzofOk4gCMA+gVZ97ac/Dsdnx0sEk7WaZgkzUEyLhPldMrnOayAs5AtK1I9adU3INDns4ONxhhfAPyIrhL8/3CLquhPChGFEk/lMsZdxTnJZFfPc/iP9DCHcy8PUAI+wOuMkbNOLsGZ4iswMPhdse9xRxtNsDGztiWHgC2ha9/Fodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miD2tumJsfIEWzeU47LM5YIyq4PbdjKVarYbdO9Qn1o=;
 b=JMomk6ZA/71Wk7QDksPcusBXpD6nke9/WoFEFvjxwL4R2LMwRD2Y956/pwSKAT6iGaqwNkX2sAjBuTfLMDcntLoGnclo1sZskhKpjd/zEAUsmw+8MwnwJ3r2F7WT8cN54YKP3mtFkD328O3NSmGML8JMcXyjZZ6iOpBbbt8ZW2336qBfyxoNMnCxqyspSDlnFUfXGRQjzeiCWpLJoyXTnf57qdJf6VoG6zbsDhWQHRVW3s3J4bGzmsuE6CahPt/KEdJjLZWqYi+vgV8kDrrchR++JTB78Cj1rUy3jKzZRViMFQeqquVYVjPMnaohAR6eXFV3L4IOzWZvJFNSD4r8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miD2tumJsfIEWzeU47LM5YIyq4PbdjKVarYbdO9Qn1o=;
 b=lCxOOiPe4e0DoS5yLI3rgExM8JpUVV3p1fuEihbjZaLRh6JYQfa3fPZZEHak3YE+ehOK+I1RbGGK2v2edH/3D9qt+UIMVgS5jfoZpeU2047je/PTrJbtea4GNnA1J/ACopuRgarI23Um5vbJJdldP81RBOs332MpcxZnXCtyPj0uZ+VeqttfUqKsB2hG8jzwsgk7P7kX/nRaiITf3rTE4llewvwmWMbR0H4wtRrK0g721lwm+ybeu8pisrgNN2NKUwU85BES9/i92Vb3DXDZ3IMC+YahtJHJ4K7XG+O/seT296DnpzDS4BfoV/syVqceLNGFklkH0K3MNn6Zm/KANQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8222.namprd02.prod.outlook.com (2603:10b6:408:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 23 Feb
 2026 17:53:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:53:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Topic: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Index: AQJTDlaDOFo3gBQj34wHN+dR2dNA6QJF0vEbtJGLkgA=
Date: Mon, 23 Feb 2026 17:53:03 +0000
Message-ID:
 <SN6PR02MB4157FCA3268094CFAE5BA9D4D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260223140159.1627229-1-anirudh@anirudhrb.com>
 <20260223140159.1627229-3-anirudh@anirudhrb.com>
In-Reply-To: <20260223140159.1627229-3-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8222:EE_
x-ms-office365-filtering-correlation-id: 3a9afc1f-dc71-4b3a-7a56-08de730464c4
x-ms-exchange-slblob-mailprops:
 5fu/r660v9OFyJ+CxyO6ueseEO2yHaMVcD6rA5FbAUHecKx/RUt+ExyYYjFZmBdHbHEZGYFIvohUnjsULyjH6mw9AHi6AbdlquzrSinmd4XjbxcAVJ0GLs6uz4Vnn4CKtlGg7xHUd036prbIETWmvqnKordwSpqCiErwT58JSHEsW7p8d3eczWLhZIbLzXURYTiYYBjwk9BlRMRtondCpSC7tD2izY83nlmGNgKOIaYi0piM10NexsjsdBFc7Dz7YGKGdFQhhEzOtRrI93g7JoNzG4/1lF+21BD1Uie4Hlqm/+X16HudPoSA/EI3kLlHRSzbft84A+XLrucer9EuMoOBVVrvcthnOGYw6kt/K0YVVJ5Wn3P2kL9ZgDlPNQ62cNjFhUbd8LzClE7LfPrMGLkd1tvg3ypb9v7Gzr1lTBRKoTZi1oAE3W0kq10xzf/SSKsrr4W3XyWrLb3N2q2dkE67I80u2ozIkHP6ik/9xfYNpnmYVhs1Ci5OBR8EZlA4FWbaavKyXr+Se3WwXo3TU/A1WhDRqrB9XtrO3vWue6pPWlV+4QLMtuPYa2OwDPEHEjcjBZUFMMUvhBHw1Yllukulmwc3GmI+W/1hg9lT9N1R0PRybbRp4g35R9DnFTzy+UOIJM2kbL6oatI15q2oN9ynuIcPs9mbz5Bj7MpM1RKc4J++XeKpITbhxSRQ0JGwbkZ7+jIHsbyXot60cMh9BCBosZCSqRHtkpNz7e0ozbs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|15080799012|51005399006|31061999003|461199028|41001999006|8060799015|8062599012|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q4SGG76TttpbVRWBm0JPz4TpKuy7sf+Ag+rKKyEAznKq2SGBdJ4mY6BkYZoV?=
 =?us-ascii?Q?c01ya0S8vGgY72dgCXY3hr8YnxcZQL3FCTJiMQhBJhYIECsDYiA4dn2qBDc2?=
 =?us-ascii?Q?vNzl1NzD8LT90Yw8sZOQbGabNt2grk0eWvOxw4B93+WuvWJlcyb4K7Vaprb6?=
 =?us-ascii?Q?p5rZh5AhfqT7bIYKyM+7on7ecAHoSV2UT24/QmhA0JjOiBuRIWzmrNtzt4Ez?=
 =?us-ascii?Q?e24JQJv7oV4C4BKUi/DnlhfZVbvZaiXByK4SlWSfm5Wxxz29bN2MO4uueiA3?=
 =?us-ascii?Q?5y8U8yZyVhl4klmDhp6U+z7Xu0Zp7Lxo0Z3o7sJrQMIZ0rQkCtj+VsLvijvb?=
 =?us-ascii?Q?hQTN9RDYw/W5QY2HfSOdzF/3nzdosMJo0L5URcjY24LPce62X+/m+S5x0NCA?=
 =?us-ascii?Q?oNG89iEOeB3xQoHnGV8Xq+HDKA3Bfa5TKFKFWXgK9qzsaT4eAHUO8+LCURK2?=
 =?us-ascii?Q?LMobsIZ1zY4P952w91VGENkX0DCyDwc7edqx5k1QIabtvugoYliPyjxr5Evg?=
 =?us-ascii?Q?5Cgys9sTk5bZjlFtXGVK6BZvyxlExQnVcqOIc1wRBjETjftOdsgm/dmCS3Iu?=
 =?us-ascii?Q?SyCHUDNw+0ETwg4Gf8G7LLu0BUolTmbv55yknYWAPkNZsw+9+yW+puDNbSbd?=
 =?us-ascii?Q?wG50IjZau7Z+xFhhzrTWbWgZIXBAvVF4UzYZv2BTtYPUoGPhriny/jpMi1q4?=
 =?us-ascii?Q?GNuvu1i745v0QSbPnMKwXVY9s0OBMkJyC35oB9H1YxtYAxxuz+aKTrhP4t2F?=
 =?us-ascii?Q?s8+3iZ0xwOe/k5E1QjrNbUFhXKnxtyWcS7n9pXKAcVT8CbCY+cWfSXyzuzir?=
 =?us-ascii?Q?K/uY7zDwuh3wum1Rw7jOdt+PvUlyfA+HxS4+CKIfiLPCj9HrXaH4lCd2+UCB?=
 =?us-ascii?Q?ZGJNXp4i2G4OZtgvV0xy+ZAEW+8DUlVKFUdWYJH9LcHniI6GMoKwZRIU0DZF?=
 =?us-ascii?Q?33crdUaohKzThM2vWcYC+kwYNvIbwtw2ssbE9SsJF3KHQVhynCHUHIpjEiLF?=
 =?us-ascii?Q?TMxm2HcktPqWM343Jay3G6QVUEt6QhEattVJlabkAgeL87Os5OKrVTpLAHx+?=
 =?us-ascii?Q?38RmMvGcr12QTCs0ODDxRByM2jr7nJhaa3uzR8lceW5f+MRtjZNCZIoZqVjn?=
 =?us-ascii?Q?VWzJgD+bqiM+AwIVonzhIWtILa9jEiQR3+tSzVprfxxzzHHVpGZ1aS1MFDAd?=
 =?us-ascii?Q?9BnP2h/yMqiincxNzoCrvI8Jxeeqc0Wu6++e93eNmenqK5KlcN/uvAoYU1up?=
 =?us-ascii?Q?yyYM3cFTT12oK5svuq4DkACcwHxz+7YbPvjU2L9ESg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SCPar1s3ikdv5Wr/H/naTGsMiNt0ksVpFR5QlcNOAjm8D05lu0/Cx5kFJ60D?=
 =?us-ascii?Q?P+2jux9qGFJKlKDK4QEw0rzlH6LVEEzgsXuoxrn1Ykwrcud4APQRWix5Jc1u?=
 =?us-ascii?Q?ZMwwXhvSTsTQe2BSjiMbz6BtHpkKH7W+2d+hK243XhCvS0jHR3rojpKIy/qL?=
 =?us-ascii?Q?vjoxEJ9oX6x4gWgPMTtu5yloSGoWATS0qCqGzIrUZwgfTt0QkWub6h3D/7Yz?=
 =?us-ascii?Q?gtT4PRtvIlnHxdPPq27o7ZJ2vwZF7TUmQvr1lnRykJ3h1OaGh7Rq3fVqneLZ?=
 =?us-ascii?Q?S+rVIPtfsUAXI/wEPpau8zxXNgebaFCnbYIRu0ih6Y2GXcfYuxirwWooiTR1?=
 =?us-ascii?Q?/cmnx/aX4B5VSZ71serui6VG922EdcC9+XI2foODepP/khNfrEgc+WUNrG2n?=
 =?us-ascii?Q?N3F3i4xP0YJ8pg1JidWuX6V6+E0+YUswTvf1YHy0FuSFDYtiyJ6vuGwEgIf1?=
 =?us-ascii?Q?zs/yjJ0mzwEoWnPD0mXT1IL0eTIeBNcgheQiQQ5Ehh7bqCxiN+8Qi8lNZOXu?=
 =?us-ascii?Q?2M6UA7LhAdajvMuJcQoImutkOiZaIkjQ+KY0IJZYXnoiUvrq+xR0x4xw3ZE+?=
 =?us-ascii?Q?6LgbGr88WEO7Z5fztfYkiFRLQ5qO1Bu/voSRvNwgjZJvB3AMy0REXufsa+oC?=
 =?us-ascii?Q?7ih37HK06ki4+yF75JSa+hNX1bro33ph0CKEGB6B+gnFZb6wRfKmK/6rHBzm?=
 =?us-ascii?Q?FG/8INA682tUbwaNDLPpXw2mlICBqw62PKeXGgmLl+0VuhwSdswF+4I6lohN?=
 =?us-ascii?Q?VPI5RkTmWvcAPQOZvdTQiK+M1daBNLGiDrRN0kOQQ2HSxr1gWpIWlEQyVYGe?=
 =?us-ascii?Q?Fi8R2bZhOw4atWvkkVfnpLgTrQNr4tCG84Xbd6RW8HU7ZihSJ9AoFwj+k7Hs?=
 =?us-ascii?Q?EUEGJoXP53Of8i8SZRyPS0FZzOYLIAzh+cq5GmyevBF++UDBU9yXCIxUntxg?=
 =?us-ascii?Q?cS1dx13p2oJP4FY5seoiVLLy4N50/h8fYIlpwRmyTUfQSGhs7GVQDCSh6QQ1?=
 =?us-ascii?Q?oKRiRDDSL3LpgbO1qfCqUrm8HWoWpZMi0ftBf8oqQ2fmn6vah4XQf9P53Y8n?=
 =?us-ascii?Q?Nv2bDP8okoaUzf7zJoL7+cuSF2V6CDqKACUxrOhKU+gPsHJK18BwacxxKBFC?=
 =?us-ascii?Q?rFKGKlPQnjHsdgLwjcV+EdqaqW7azERk+fjKVm7ArR+whtVs1B3MVQLFQs3H?=
 =?us-ascii?Q?0/p8iTn7hOfJ3z1/YSa3YLLYC9w9WGNFAhPvTrX37/6vMT9q6yZt65qSu4G1?=
 =?us-ascii?Q?KLnhbJQhw46soNP8nz3bAYGKLeHhvyErZ9rmZtya+s9ZWGBzIP+u9RPnH0zN?=
 =?us-ascii?Q?bvkYERVxfn72hl7xiyoGt+/YMTs9jWederPsi3vhp+ZAttXJ5/3R+1L7Khmg?=
 =?us-ascii?Q?UYttzwU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9afc1f-dc71-4b3a-7a56-08de730464c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 17:53:04.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8222
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8958-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim,anirudhrb.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E67D917B23B
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Monday, February 23,=
 2026 6:02 AM
>=20
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
>=20
> On arm64, the hypervisor exposes a synthetic register that can be read
> to find the INTID that should be used for SINTs. This INTID is in the
> PPI range.
>=20
> To better unify the code paths, introduce mshv_sint_vector_init() that
> either reads the synthetic register and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_synic.c     | 120 +++++++++++++++++++++++++++++++++---
>  include/hyperv/hvgdk_mini.h |   2 +
>  2 files changed, 112 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 074e37c48876..75ef2160b3e0 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,17 +10,22 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/reboot.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>

I don't think this #include is needed now that you've switched to getting
the INTID via a hypercall instead of via an ACPI device.

The rest of the changes look good to me. You have a place carved out
to put the DT setup of the mshv_sint_irq, and the scope of all the
variables and mshv_percpu_isr() is correct so that there won't be any
"unused" warnings generated. Nice!

Modulo the unnecessary #include,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> +#include <linux/acpi.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>=20
>  static int synic_cpuhp_online;
>  static struct hv_synic_pages __percpu *synic_pages;
> +static int mshv_sint_vector =3D -1; /* hwirq for the SynIC SINTs */
> +static int mshv_sint_irq =3D -1; /* Linux IRQ for mshv_sint_vector */
>=20
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
> @@ -442,9 +447,7 @@ void mshv_isr(void)
>  		if (msg->header.message_flags.msg_pending)
>  			hv_set_non_nested_msr(HV_MSR_EOM, 0);
>=20
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> -		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
> -#endif
> +		add_interrupt_randomness(mshv_sint_vector);
>  	} else {
>  		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
>  			     msg->header.message_type);
> @@ -456,9 +459,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
> @@ -501,10 +502,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>=20
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	if (mshv_sint_irq !=3D -1)
> +		enable_percpu_irq(mshv_sint_irq, 0);
> +
>  	/* Enable intercepts */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_sint_vector;
>  	sint.masked =3D false;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 +
> HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -512,13 +515,12 @@ static int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	/* Doorbell SINT */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_sint_vector;
>  	sint.masked =3D false;
>  	sint.as_intercept =3D 1;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>=20
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -573,6 +575,9 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>=20
> +	if (mshv_sint_irq !=3D -1)
> +		disable_percpu_irq(mshv_sint_irq);
> +
>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled =3D false;
> @@ -683,14 +688,106 @@ static struct notifier_block mshv_synic_reboot_nb =
=3D {
>  	.notifier_call =3D mshv_synic_reboot_notify,
>  };
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +static DEFINE_PER_CPU(long, mshv_evt);
> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static int __init mshv_acpi_setup_sint_irq(void)
> +{
> +	return acpi_register_gsi(NULL, mshv_sint_vector, ACPI_EDGE_SENSITIVE,
> +					ACPI_ACTIVE_HIGH);
> +}
> +
> +static void mshv_acpi_cleanup_sint_irq(void)
> +{
> +	acpi_unregister_gsi(mshv_sint_vector);
> +}
> +#else
> +static int __init mshv_acpi_setup_sint_irq(void)
> +{
> +	return -ENODEV;
> +}
> +
> +static void mshv_acpi_cleanup_sint_irq(void)
> +{
> +}
> +#endif
> +
> +static int __init mshv_sint_vector_init(void)
> +{
> +	int ret;
> +	struct hv_register_assoc reg =3D {
> +		.name =3D HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> +	};
> +	union hv_input_vtl input_vtl =3D { 0 };
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF=
,
> +				1, input_vtl, &reg);
> +	if (ret || !reg.value.reg64)
> +		return -ENODEV;
> +
> +	mshv_sint_vector =3D reg.value.reg64;
> +	ret =3D mshv_acpi_setup_sint_irq();
> +	if (ret <=3D 0) {
> +		pr_err("Failed to setup IRQ for MSHV SINT vector %d: %d\n",
> +			mshv_sint_vector, ret);
> +		goto out_fail;
> +	}
> +
> +	mshv_sint_irq =3D ret;
> +
> +	ret =3D request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> +		&mshv_evt);
> +	if (ret)
> +		goto out_unregister;
> +
> +	return 0;
> +
> +out_unregister:
> +	mshv_acpi_cleanup_sint_irq();
> +out_fail:
> +	return ret;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +	free_percpu_irq(mshv_sint_irq, &mshv_evt);
> +	mshv_acpi_cleanup_sint_irq();
> +}
> +#else /* !HYPERVISOR_CALLBACK_VECTOR */
> +static int __init mshv_sint_vector_init(void)
> +{
> +	mshv_sint_vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	return 0;
> +}
> +
> +static void mshv_sint_vector_cleanup(void)
> +{
> +}
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
>  int __init mshv_synic_init(struct device *dev)
>  {
>  	int ret =3D 0;
>=20
> +	ret =3D mshv_sint_vector_init();
> +	if (ret)
> +		return ret;
> +
>  	synic_pages =3D alloc_percpu(struct hv_synic_pages);
>  	if (!synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto sint_vector_cleanup;
>  	}
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -713,6 +810,8 @@ int __init mshv_synic_init(struct device *dev)
>  	cpuhp_remove_state(synic_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(synic_pages);
> +sint_vector_cleanup:
> +	mshv_sint_vector_cleanup();
>  	return ret;
>  }
>=20
> @@ -721,4 +820,5 @@ void mshv_synic_cleanup(void)
>  	unregister_reboot_notifier(&mshv_synic_reboot_nb);
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	free_percpu(synic_pages);
> +	mshv_sint_vector_cleanup();
>  }
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 30fbbde81c5c..7676f78e0766 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1117,6 +1117,8 @@ enum hv_register_name {
>  	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	=3D 0x0008007A,
>=20
>  	HV_X64_REGISTER_REG_PAGE	=3D 0x0009001C,
> +#elif defined(CONFIG_ARM64)
> +	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	=3D 0x00070001,
>  #endif
>  };
>=20
> --
> 2.34.1
>=20


