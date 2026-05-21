Return-Path: <linux-hyperv+bounces-11134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJVWHzI4D2rTHwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11134-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:52:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEE5A9A07
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3C03051D00
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49C368D6E;
	Thu, 21 May 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tC56GEPx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010006.outbound.protection.outlook.com [52.103.12.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F934A3D6;
	Thu, 21 May 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379011; cv=fail; b=bkNCtp6hnmI7XTbiZA2rmnnpaIdH6TQJcMQOD290+tczW4Ngfpnc6GQqfTR1YEiSwzvX0pMCEX7aEg7ncay3pa8pN+TZplH7jkfDpMb9Gh3qYHArbkCaMxVhZ74Qfi7/W+3Sksh5BKQhlHJUAB8SDRVPVaOdjJMxt837ecuzE6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379011; c=relaxed/simple;
	bh=16LAMsLaVDK1cEW0q1qtOARF3h5vnCplq30F2Vt0yEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ft0FJaqwdyJDdmrI0ITh/ThvpB5vPODuRaPYaT/Ms2xwP2Dl8tP+Uz8GL7GwZjrKLyWCvXWGdqXN0Xxhfq6pHfyRCZwcMNAfoTPlVSgXJJs1uuQNyletliw3pdyKtBRvfv0g6znsuhFkVkGDIsOs5SMA0TIJJ9mKIWSn7geFchY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tC56GEPx; arc=fail smtp.client-ip=52.103.12.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5GPuNjnJMr5ribMri4uQH7KVOK2svsahT74oAtBW2+0lciuuOgB3ceWOLryCazUTN3PcwAU4uZWrZSBHRWOiQwuIhPJvMqybq62TJAwMhC6Kd4BDkUjgRKVO5JcL7O1DOU72PwSBcGqi0krS9VZDLTtJ7MnS7W8LNmdZfPfkrZ+HXllAtcfuo8jqWyblmg3Embi+kjp1K1xmhqtCDkWzxWTjTk0FUmj5rZuJuay8wooLTjVhsG3flOXQxBgqdP8+u/flQLxzrPDgLim7ZMGGtI17nv7RObN8MYCLezspEKGmorFxITvB0kEBpgwt/NPfGi1esV7HuLCS+IBLuowkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsLohKO26Wpmq3w7YBMoDZ6EPfRo6++RcvuurWpINJs=;
 b=fIhLHk2h2GtvVIllzFaRS2v1R+rmKwDkbIXpRSQnbKzUHuTJ4fCyq4atT60qWsYmoxia/1rk0710dst25M9JPiN2K94TrZDMsatSPpXcdhgeRwsA6HNkKPfADa+wERGbU88rWYRuVGkGL7JBKeyzvS0is/YIocAIMTqhoxtbWgUiXJPiTAitYdfxTiOlbtlnJJlnAmfp/aMzXZ94KbS80GQBjKwUJ1xG0FD3vYqXdQEbviZH9qT+zqh/dDBMMUcEODQEm9A07NtfCM2A7aAmmyzo2IOkRsjQayN1prnkbVdRiY8Lp5B1l3Elleb8KeT4zOGlJeljboMJUAk8KByhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsLohKO26Wpmq3w7YBMoDZ6EPfRo6++RcvuurWpINJs=;
 b=tC56GEPximBKGWFr8Ouzo8IgYeTQovAjfpFAqyw0ihyHwy48Qy/lg3TtV83RiQgZJTDEHB2lpTVwaq3119suSSlPBv9P6blAvOQ5g1xJ8rmoTbZcX4T+FCNER+inLVeyKtkakYkkCD3n9kOxciwJ+96cnDvKxirD1b+Xu7Vk9k+dU63j2xuBLp3Dklv2GV4l+ceXWRMf41CsAX9Zh2YtIpmDViMZdkqmlGaQ1N0V+WXpfjjML83i0mocfonLKdsBvM3W1Q8/vLzlo4TUxTc6JjBTsd06nICpZjbfidqO1NabpaZLiNsL0FYzJlwcZXkQg9qJ/UlTGgzYwQoT0oQrvA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS4PR02MB10820.namprd02.prod.outlook.com (2603:10b6:8:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:56:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:56:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jork Loeser <jloeser@linux.microsoft.com>, Arnd Bergmann <arnd@kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, "Anirudh Rayabharam
 (Microsoft)" <anirudh@anirudhrb.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: add vmbus dependency
Thread-Topic: [PATCH] mshv: add vmbus dependency
Thread-Index: AQMqr82JznkC2EbJbGYN+Tz224qT+QJoZ69Ps2nPqpA=
Date: Thu, 21 May 2026 15:56:46 +0000
Message-ID:
 <SN6PR02MB41573C843614F345C42E6923D40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260520074044.923728-1-arnd@kernel.org>
 <52a29c5-715e-8ea-af1-dafebfca7a84@linux.microsoft.com>
In-Reply-To: <52a29c5-715e-8ea-af1-dafebfca7a84@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS4PR02MB10820:EE_
x-ms-office365-filtering-correlation-id: daafd5d7-05e3-4f90-b4b9-08deb7519013
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|37011999003|16051099003|19101099003|8062599012|8060799015|19110799012|15080799012|13091999003|31061999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5O9MAk0LZFhuWwvrd+oIkafep1SqEuP4eslaPIKlZJ7+VtT/rzGPxJkvm5SV?=
 =?us-ascii?Q?ZhQA0JN6Fw1JoLpXuREJK6TZZoXXWM/sgnAtTGdQUqgpmPJ9OmGrdxRMcJND?=
 =?us-ascii?Q?FEZNMzA0G2fKZx/P6VqgpyI9/HjO+Hg1ZivNqTwVsGVubP1S6zvBS5Qxyp4G?=
 =?us-ascii?Q?kDdViN6vgI4JpJoyuopAg9psHxnVipz+u/cXjy3YBiLf6qnL5pjwq7tJxTwk?=
 =?us-ascii?Q?7TY1PKUS7WNdq/LJFBDbbFoKEN3WJocf6pYyn2g6dgkcE0cMFSyrx6pyUu/x?=
 =?us-ascii?Q?V/qnGuyd/YQ/gsXg395jSmlY+oqDJSdFAQm7TDGJI3gB7uBjPJbBonHyWpRN?=
 =?us-ascii?Q?TGBtbYp2cDdq1J9Mw3UZA7wMkoVED54EKmL7MFeTr0uCg97YgogTG6NSdDkN?=
 =?us-ascii?Q?/zwjDYXVdZAyuU6Eov9mRiaGQW9oBvlhK6W+GOm1I9CbyKL5+flD91xFPa91?=
 =?us-ascii?Q?py4LI10OGcT2hYdjMFZfMLqnBDYtLQHc807eprrKIoUWKamjqVfGErMYQJdq?=
 =?us-ascii?Q?zDSunfrQbvQeDFtP6OEQokfrw+nB1+5XvfAfXEIYR4YO7t/BCYr1WDlkrk1O?=
 =?us-ascii?Q?SPbs7f0uKHZuSnEtvsxWaHl9xWiab8VcMo8PgbPkpnpVENjCaGNk8U2CEMVg?=
 =?us-ascii?Q?KtPHurSDL08Vdzapd7BM8EzNnDtNh7I5H4qMNSBE2XpzGwr1nuxCQsrotEWj?=
 =?us-ascii?Q?CZVUgrUJtwK0pK3cmY56xHwfGW9On1wl/ueLY8W52PBIcaNURMiZBb9EUIZ/?=
 =?us-ascii?Q?oEdDGy/6l5VfQZXJWRTqtCEF0uEpby79cbC7k3dNA8AzPdIMUtAAppigh9yM?=
 =?us-ascii?Q?UvBBpnl1eGYvGt8325WNVQeXMw+KmEmP5MNTViASgCyccpfWedOV7JmycF7F?=
 =?us-ascii?Q?9AzbnKcdY/yl/Bvo2tTVxkAgtJcW7HA6mEGNUSt571PVIpTJOBn+2T5pMEOK?=
 =?us-ascii?Q?IXxpDdrftceYIFPZ9VwUBj49NR6Io6Q1HQMYka4ktCRKHVI4L158xxAR3DsZ?=
 =?us-ascii?Q?p9i5iWQ30VPtQNTE8RRQD+sxeTrzRUT68MDSZL7efFEDZ1I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iluNbZjjXJYPxyWEUsLQlaYyZFBSGMWjwHQvCtNLnf+fEbaCdxny4NIJnKvx?=
 =?us-ascii?Q?Yyz4Gkm0CaWAcuI11RBnOfYFH5gHF21QxIssy5Ld8uliBCJaeavFV72mBe49?=
 =?us-ascii?Q?JXRAcv5x4PM14S1czar8kELPQ/jHaNdodA5cCeYPxOq2JtdLcKvzlJBjNKp8?=
 =?us-ascii?Q?3aLZx+V6EFtvk6yiUwqxHzw7G9uhSY80tzwi7DuL1bQKhZ63fFFvG0nFf9+J?=
 =?us-ascii?Q?K3590im8XAvkrq5XhCZOZM3Z31aj4EidzHp2Di5UhL1H6ax8lZtD75zK68po?=
 =?us-ascii?Q?ESOSMtRn/DWi6rdt7KRci8P2z2EBaNian0jt/cSgJiR169kKx56v6OR55XIt?=
 =?us-ascii?Q?8DCjTveyJ4zOGH6dhFnBMWV0WKD/FaYKsQkTvapt4P4GC4m1vqkO/9LuzCmf?=
 =?us-ascii?Q?W6c8creOxdJeVFPUEmHKjNs8d/0rbrp146QzsgA0Ua8hzm4dped+ocxZcE4q?=
 =?us-ascii?Q?onNkDBq9TyWTtTlWW3xaFHdd4P7MYJY36+pdmvVEhEnYgCWhOIxrUziEYGlk?=
 =?us-ascii?Q?m/JzhWWFahvrjeUKfaMJlfklgXR72zQccotiKrWPt71B+HmO/E7alvYcw9Yq?=
 =?us-ascii?Q?i4dxQUKxvGuP6MSu18+exf4sea7dJ9Eny+Ce0RM4kpEv3BGP1cGm+hSm9xpF?=
 =?us-ascii?Q?02SRwQ4R9IMA5+8Dt0RY0i4w5QL4UoflEY5MJzstISlml79OOon/9MObDPc5?=
 =?us-ascii?Q?S5DpIiwEPhGvDPdq5v+qnZdiFxKtmr1itRWgggB4FRcg2ZYf3y/4F9MJQdH+?=
 =?us-ascii?Q?odwCs1JGZ0GWXm5/gt6r1qM0R+ULU2jU3wSigr8YDVviW3JINr9cKqOHwYFp?=
 =?us-ascii?Q?bjgRZhMjPtnqboLdDewJx7G6P+TNvD2DIt+viSDx/4bacajoO5wvN2399q3w?=
 =?us-ascii?Q?8tN1la3P8G81WSrFDq+6NSgYvC7nk6MYQaK+5xnJvMf8frY/yRYHG+o3m4f9?=
 =?us-ascii?Q?dqn+j+6mo4fj3dAoM2mLUalsoDQSp4LkPDps7KALRc17DsASplWn2vH4Cl+g?=
 =?us-ascii?Q?SB6yif1DrxFj2sBug9hY6pjVNBIh3A7YWVgfvPIfbQ/A2SoTUDc/C/Z8bhPN?=
 =?us-ascii?Q?3MNlQZ8FIVXRAzGoTzkSD5EQ35OHtXPWUDxZPPhewDIOe4W1WttbqiOK9ri+?=
 =?us-ascii?Q?lU8ohnLz6qGuRXjpD3hLSMroL2PGK4NLsfgPokqROrKRljBOWfqgLiiyPfny?=
 =?us-ascii?Q?8bbD1mG3HqBm2rWuQZzTNFuTgs365a6oeihdHXceLXzsWJC6rLmtwtpxShH0?=
 =?us-ascii?Q?G/DZy0eUn7AI/Qsh1Un/KHAu0QBCksE0kf3EwapL6opeKo5Z6n3Cqps/+qtK?=
 =?us-ascii?Q?D+tLE4vdm9y7oNZXcniBFxWFZkGCQhdpZIU3PTCpzocFg3LMcsgd+f6LL+Nw?=
 =?us-ascii?Q?zX8SKow=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daafd5d7-05e3-4f90-b4b9-08deb7519013
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 15:56:47.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10820
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11134-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D3DEE5A9A07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Wednesday, May 20, 20=
26 10:16 AM
>=20
> On Wed, 20 May 2026, Arnd Bergmann wrote:
>=20
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When the vmbus driver is not part of the kernel, the mvhv_root
> > driver now fails to link:
> >
> > ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
> >
> > Avoid this by adding an explicit Kconfig dependency. Note that
> > stubbing out the hv_vmbus_exists() based on configuration would
> > also work for some cases, but not with MSHV_ROOT=3Dy and HYPERV_VMBUS=
=3Dm.
> >
> > Fixes: f1a9e67c1138 ("mshv: limit SynIC management to MSHV-owned resour=
ces")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > drivers/hv/Kconfig | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 52af086fdeb2..21193b571a80 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -75,6 +75,7 @@ config MSHV_ROOT
> > 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > 	# no particular order, making it impossible to reassemble larger pages
> > 	depends on PAGE_SIZE_4KB
> > +	depends on HYPERV_VMBUS
> > 	select EVENTFD
> > 	select VIRT_XFER_TO_GUEST_WORK
> > 	select HMM_MIRROR
> > --
> > 2.39.5
> >
>=20
> Yes, this is the right short-term fix. We will need to solve the root cas=
e
> (no VMBUS required) with a separate SYNIC driver abstraction.
>=20
> Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>
>=20

I have what I think is a better way to fix this. It preserves the
ability to build MSHV without VMBus, while also guaranteeing
that VMBus loads first when present. And it is relatively simple --
hv_vmbus_exists() does not need to be moved out of the
VMBus module. Later today I'll post a separate patch for
consideration.

The separate SynIC driver abstraction can still come later
and improve things further.

Michael

