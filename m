Return-Path: <linux-hyperv+bounces-11947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1t5WOPeGUmqKQgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11947-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 20:09:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C0742758
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 20:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=h9FU2Zj0;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11947-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11947-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D52301A72B
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jul 2026 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550472BDC05;
	Sat, 11 Jul 2026 18:09:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012077.outbound.protection.outlook.com [52.103.11.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AD270545;
	Sat, 11 Jul 2026 18:09:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793397; cv=fail; b=LbEf6PTq2t9SUdhSZiPZ9hdIf8daBntzV1UAaBepItJhoF5OZd2bGEvKqYo4pABWQFhZ0/On5kG1MRekZWv/dt6kP+eevvmnCTu42Jg/lBZVPS4BZmnU6sLjY4XaHrQNGvG9tft+ViMECdxel7t+vmH50sWHLUDv7idDBVem81g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793397; c=relaxed/simple;
	bh=UHGuqXFsN36Oh2sgjQY/WJufzn4+FGFaqGDvEfkxC9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDmYnQNc/r06KWiZ3KnD+uBjslckrynmFGWMlP4jCv6smINo4hhQlJn9zElMTD/QO1TcFVt64hHee/0J+VpFSQslhs9mrXbCHUEG9qonuHW/B3reSKWZXZHinwx1C7Vn56jA73r1kCr8eyJHiGOPyRcuR0r+uEQu+JnhyLWzeNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h9FU2Zj0; arc=fail smtp.client-ip=52.103.11.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJuMHHESshL3BRpxsF5CuQgeaLdAp4JD2nzUuQs18OythGdLSsMgrhZE/+KYDwiKuEO5M4Ww5F1NgjCObKIW5KmCs6cr2W+z8RgNpn2QcYTTlhQ0kX7VhrLUy8pk7AYx7V50ayw3ZK4p/N99ixI9yxi+qvE41ISnEkTAPIxoq6bL6IQsHdCEXHMb9QYWBICQN+/svRc6nKkB01BPogV+IVjjHLQtilKTWhq66stWmhxUIObrq+WbkmGvDAsHX9eWCKCLq2IoQjimFUjQH1cR1glbWdUhbqmLFkh3QR7GP1N8G7efC1cfD5pu1nvVGdogPIdPG3No0/alzKMkQ03kMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y86NpvNnCW6YE8XiYPmkfMP/1MEWZ0CIAbhuqguUDCs=;
 b=jPPtm3SIg8Wpp5KBDY/Z5U14egRNTkWqoE4LvFljGrjr8o8UXlD72blCmianli+e92yBSdY3s8u1p1foa6NIR8o4Tz66uhbL2GpOMAxXg7HFvvMt16/WQxFx0YVa6FcyRn3VOVD9zEH27MGrc0dC92bMR+s3qs74C4zMm4bUtR0tuXLz5Uiz1FyJy2oldHenf/Fs0OV1uhMmCGFoga8gbXVgRk+QhnSZBNfWzEPuEcvYHrR9rzzigfbgHe/Gphh3dykyLxLMM7DJgDHkikFFrekgZQoVyqm6kQG0ZxtnRDUht2qmrrP5HlqJMLWfjeOtjS0jIp/9IL+vuWa5kkaFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y86NpvNnCW6YE8XiYPmkfMP/1MEWZ0CIAbhuqguUDCs=;
 b=h9FU2Zj0zTqyp7jVDhhMLoczg+0H4Y+1TJlbWcMuAp5OuprrnNEEabUAzwX5jab4CFbBrauey3tmn3kq68mA0Ol8FlN9daFpV1yePvrp6Q2shsM3cG0tRcHVDdD+uh+fyhPOCYY1jAMkjaQKEkqeZ8NmYpy7xKvRDHo8V3pdB7f4wuMfCwGNYdXAyKNl56RB2Tqm61cYTl665kAyTEjMRO339g/MIitQuxEGb6aFHpK3wBjSUOA5pM4yNQy2rmqps8AKYyuOuJw6A9eoEsjKt5YRMQdTIrz23fM8BIEyPrzfX0P1Zjp9QjKcFd90t5ZtZ4jOfjas0I+9c0D1cS+MuQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SAWPR02MB11439.namprd02.prod.outlook.com (2603:10b6:806:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 18:09:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 18:09:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, "kys@microsoft.com"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hv: hv_balloon: validate unballoon range count
Thread-Topic: [PATCH] hv: hv_balloon: validate unballoon range count
Thread-Index: AQJeSRpY6Zp0LnMXzvgY0v8L+2C2mbVmLdQA
Date: Sat, 11 Jul 2026 18:09:53 +0000
Message-ID:
 <SN6PR02MB4157893628C03F09EB14697BD4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260710022914.3740453-1-michael.bommarito@gmail.com>
In-Reply-To: <20260710022914.3740453-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SAWPR02MB11439:EE_
x-ms-office365-filtering-correlation-id: 3c0450cb-3e83-419f-19cc-08dedf779b69
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|51005399006|37011999003|15080799012|31061999003|8060799015|13091999003|19110799012|24021099003|8062599012|41001999006|12091999003|18061999006|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1s8LnYdYOaGJ2Sagt4rQOj1SjsW+yFAsq3xqTMoOE0hvt32YfLYyv2e0zB3G?=
 =?us-ascii?Q?tKFndKe6aF7c5gh8nEa5LYU+x+xl+pvisa/HmVehblHl71s2tgPPpJ2LHgSv?=
 =?us-ascii?Q?DSneAj/acTUgTIWogHAgwSUMxxFeZsH79fR8FhbBPMAgwmrXTcI3dgCQ84+O?=
 =?us-ascii?Q?ciw0OOFsMZIYJI8OG3LmBEB4QvsrlBHAKMwV0hwLi9inZb9q9llYnXH/kSwI?=
 =?us-ascii?Q?KD6Z6E8WhOX6PeEG+yyLUd7KL5uFodxB35wLsOrhNhn8ElUdjm0QlMbOLgWH?=
 =?us-ascii?Q?etQgAKCwqvkzoHqz2VLcceWEtMirfjFSBhZp6xDcNAzraJcXKXl4VHPFeeO8?=
 =?us-ascii?Q?cM+WbQ/IQXc3HKu+a54r4WcSg/tyrzQwgNoXUQwHx0AKCXOH8X1fTu297J0F?=
 =?us-ascii?Q?h52ZeB68IC9rF4bdCzFsdGlN5Vv++gmr6xE5eBuZmdgSSkt9vnB3MJaKI/R3?=
 =?us-ascii?Q?irJ40QLTm5K36oBakcEDXcVvaqY0TKqGRcpySa9hnw/uf0ProrzBLwvf6PCH?=
 =?us-ascii?Q?8oSAwQ8QxXSHzCnMbEp/XAm4wj/GAMkrQsdXKljCT4Ar5ceI18rtp+gtEmQt?=
 =?us-ascii?Q?ridGaL8aoIAL9SqwBVdsUnYUvVwJviq4yT90RilCZua+v6fQzew1+C1vIeI4?=
 =?us-ascii?Q?e3nSw46HeSlOYnSRqYZlqbzcPlWJtUkeST4bzvKf2jEztTpg6xUAEqi3HArE?=
 =?us-ascii?Q?TZao6dmQzW6n23yd91x28Ya+yKnUw+lKlq/ikT1DyNr8DuqvrZUv1wkm5FdB?=
 =?us-ascii?Q?yWOcwWGxkAY/eo0mybGObk8as9QXUzsFStkbBPisoTDU9LVd57nAZiZ0VT8y?=
 =?us-ascii?Q?sZlGpX+2KLxFGtXQ5Oz51/LDyevZylLxDbNz5HXeDCHB3KeEjqG45XEshe4E?=
 =?us-ascii?Q?s2kE9/92aBu86Rs54jDbhizSqg81WkSH6KlT1gHtMt26PivFjT2WSkwQ881J?=
 =?us-ascii?Q?sF6ID1kcy+AT0n11i9MFUuVO89CiepD838mST+kQTAw7wBGugyslwM96XjEi?=
 =?us-ascii?Q?S7Oge+enYW2J0EJrE67+iJSjUUznXVb/hbIgNZmXfEczXlXrgcrkRO8hrNB0?=
 =?us-ascii?Q?1YbTb+aN/Xe5aWut37Q9ymhIhQwUgJPHEahL9nr9XaIB92yUKoA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aObex6lWcDG3LVP8GLOX3MvY2n5sRTXd/Rpmmu/pemJk/H6k/nGQwabRpiqz?=
 =?us-ascii?Q?fIIH+HhaK4+h8eHhCAt6wefDnvLl6LgFL3wwtFgBJRr1YVe1K7i7ojU1MZih?=
 =?us-ascii?Q?TGNLk5nc7uqj/T3FdHOhYbvVf8TAdlXvBf5Ur9bYQkYjZf1YwbOqRPr/JfY3?=
 =?us-ascii?Q?qiZJhQKob1tPkKdbLbmYenJ8ufbwZM/2fGIErpR9H/L3/wCSY71MaF7QCpyB?=
 =?us-ascii?Q?x5g3UhNji1nAUcbqwCRwDzN5SYTUCzUkLy44jhWw+XAQzdCfikfLS1jWSsmu?=
 =?us-ascii?Q?NsqX3tM8wBxykMepcqYsipOqXuOV99nSU8X6M9xloFGObbjI4qJTEGDEJZ+H?=
 =?us-ascii?Q?71hFSWBe0n9kWiIATlAUNCxSYeOUQuGao9A7pyFBVU3NaKBNRqPbTjJBSEn1?=
 =?us-ascii?Q?TFFSLR2zlOZqB5gdUnqlFMjSYqjaRTYwQMo84XTu9QCBlySN7a5Pc7GusSfR?=
 =?us-ascii?Q?THdhhwNBGOlADNfxuyffdmRjry7icBAI+t3JE+7gb+jpq7CXGtiIzhMoDSIu?=
 =?us-ascii?Q?67aKnJGT4jNIZGZxvNTpczy7jJNGuXrlOqYwI1n6lykrr+RGkvwCCf7eWUIG?=
 =?us-ascii?Q?aOEXcXqJN02YhXdhNQvBBBP6h35m/WGYvFPzU5GKE4xXjaw9g1Ndb7fdupiz?=
 =?us-ascii?Q?hCi5XsCCQYo8WbKNGe5S4jnFVaMBZdKaJ/YI+O2izsLb4vt8Kmv0lN4SsGB2?=
 =?us-ascii?Q?JFxpALpPuN8uSe8rWy9Q7XIDbuxiU0UThh9PSmpCLEXYPexgMy6QAhY7vt0w?=
 =?us-ascii?Q?UTECD8guDY6SjmgDAJc8LM/HzzzbIY5ywWMGuQ9pUE7a7oJivEtcXpiw11ik?=
 =?us-ascii?Q?kgJDxByybey9UZGbcdEr84D6Rnw+sLgoolabwxmPA1wGommHv8Sd2HG7W4cr?=
 =?us-ascii?Q?Awc3vvi7euGCq4Q6auHxSJwMexNMKiXF6Y7yxRz+ERSTb4zVXJaQ6/3cPR/1?=
 =?us-ascii?Q?H0VT8QHb1rB2yfqExgmKsNTDEvDyyknYRJNH3Tm2PI/pRY2caDtmDvHLY98+?=
 =?us-ascii?Q?jhZupUPfUIsZR2U/JWYsIOdg7WXYkMag0rW6nKhB51PboCtLOpY/TzQJWbUU?=
 =?us-ascii?Q?xLXIeNXl/0ct9WUVaY/MPbpJ2oxSmcrgipPw5gDbvughxgvPLZLDQs/5PjDX?=
 =?us-ascii?Q?DQRkEfgu6u4zrUOQVaKd8lE4ZMMRh1vIpcl/hcoD2UbZ2UIdnMdonMVAJHt/?=
 =?us-ascii?Q?bEcjGtoJBsXfjrw+F/WBcJW56JySN/lZB2nL9mTJ3gLbFcr0/dHkjI0q9mGS?=
 =?us-ascii?Q?uS7VxSRv/LNxBsWUSQF9R53S36D7d1NIhhwGsqcP1LMgpQkdzlJd5cjx5GNC?=
 =?us-ascii?Q?vNUoYLZPetCWCJ4vwB73g5lTfZ8+GjKE/0ZdH4/aAg11I53xWkD4WHTs/4gV?=
 =?us-ascii?Q?AP22Gr8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0450cb-3e83-419f-19cc-08dedf779b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 18:09:53.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR02MB11439
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11947-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:gregkh@linuxfoundation.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:from_mime,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 376C0742758

From: Michael Bommarito <michael.bommarito@gmail.com> Sent: Thursday, July =
9, 2026 7:29 PM
>=20
> The Hyper-V dynamic memory host supplies DM_UNBALLOON_REQUEST messages
> with a header size and a range_count field. balloon_down() trusts
> range_count and walks req->range_array without checking that the received
> message contains that many ranges.
>=20
> A malformed host or backend message can therefore make the guest read
> past the received VMBus packet while freeing balloon ranges. Validate the
> received message size and reject range_count values that exceed the
> present range array before walking it.

Same comment applies here as I wrote for your proposed validations for
the Hyper-V mouse driver. The balloon driver also has .allowed_in_isolated
set to false, so it isn't loaded in a CoCo VM and it hasn't been hardened
for the "untrusted host" threat model.

Michael

>=20
> Impact: A malicious Hyper-V host or backend can crash a guest by sending
> a short unballoon request with an oversized range_count.
>=20
> Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/hv/hv_balloon.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index a848400a59a2d..f5bc8c9fea7b9 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1337,8 +1337,23 @@ static void balloon_up(struct work_struct *dummy)
>  	}
>  }
>=20
> +static bool unballoon_request_valid(struct dm_unballoon_request *req,
> +				    u32 msg_size)
> +{
> +	u32 max_ranges;
> +
> +	if (msg_size < sizeof(*req) || req->hdr.size < sizeof(*req) ||
> +	    req->hdr.size > msg_size)
> +		return false;
> +
> +	max_ranges =3D (req->hdr.size - sizeof(*req)) /
> +		     sizeof(req->range_array[0]);
> +
> +	return req->range_count <=3D max_ranges;
> +}
> +
>  static void balloon_down(struct hv_dynmem_device *dm,
> -			 struct dm_unballoon_request *req)
> +			 struct dm_unballoon_request *req, u32 msg_size)
>  {
>  	union dm_mem_page_range *range_array =3D req->range_array;
>  	int range_count =3D req->range_count;
> @@ -1346,6 +1361,12 @@ static void balloon_down(struct hv_dynmem_device *=
dm,
>  	int i;
>  	unsigned int prev_pages_ballooned =3D dm->num_pages_ballooned;
>=20
> +	if (!unballoon_request_valid(req, msg_size)) {
> +		pr_warn_ratelimited("Invalid unballoon request: size %u, header size
> %u, range count %u\n",
> +				    msg_size, req->hdr.size, req->range_count);
> +		return;
> +	}
> +
>  	for (i =3D 0; i < range_count; i++) {
>  		free_balloon_pages(dm, &range_array[i]);
>  		complete(&dm_device.config_event);
> @@ -1527,7 +1548,8 @@ static void balloon_onchannelcallback(void *context=
)
>=20
>  			dm->state =3D DM_BALLOON_DOWN;
>  			balloon_down(dm,
> -				     (struct dm_unballoon_request *)recv_buffer);
> +				     (struct dm_unballoon_request *)recv_buffer,
> +				     recvlen);
>  			break;
>=20
>  		case DM_MEM_HOT_ADD_REQUEST:
> --
> 2.53.0


