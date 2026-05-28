Return-Path: <linux-hyperv+bounces-11311-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI7NKAJ0GGq4kAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11311-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 18:57:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA35F54D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 18:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03FC03074849
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BC3F888D;
	Thu, 28 May 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iZB2yKA+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011033.outbound.protection.outlook.com [52.103.13.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFE3F7882;
	Thu, 28 May 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986854; cv=fail; b=NkAsaiZEEqrkjf6MQ+l3wWbVn4pDs1qwrK57yc9PJzhjjDHYQQLZY0DO9RwtHsYuXwmyfWPgnFoucOnGXiCJ3R7xkZXtnJ6Wlmy/wSQ5hKXgxx7PXZvp7vJXWkaSBY4/+XYLlqWewoyDesYtw9BC0xnTtUOkDkGzwacbUVWSYcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986854; c=relaxed/simple;
	bh=lt8LT2UQ9GXPtyInK9wBJAWKPbhOBhYdm6B8A7B5dTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmzGrKcfxNfVTDhSxtcUqIFFzHnuTX56mIS50qZR95CIXQJOmsSjvnRkh4d23r2HCjE6bM5ItiIkBdm7cjHW6KPWuU8BQ9FIjHX5aO3B5OCwARshn0Dk1JF1wfRs0XFfcBYXAi1S/uK9216qfI45cRUup+iz7Trl/ggiYfZ2jW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iZB2yKA+; arc=fail smtp.client-ip=52.103.13.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm2OJpBsMMulBEE/xfv+gn227Rw857VnyGJ4UQwlnHlxz4kWLhQ4u2rhqv6+UmMe3gymB7PMW8w5KY83o3aXBZjY8vnZf7UziFtgMMsR1oMh0WrcoiArGdNPxxxOCysg/xoqE07hDGEM83E3C8XnQTypnwA2DzdVx/2RAQM87sCUA+FfKagx3RXtqzeGk8bo3/g+djgJerrcTHPwx1/2jtkjJ8exoAm2vdPSiOgSfpk00bWzUSZSYWaeMfL6HPpMmm80e4Lti5/2Oy2U8NaIiKJyv+bxkQwyD7A+LTuVrqAuNbT+cQXmc83InIRad+Vs/qvt7JN2zYRn80GFku44KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbgRav/HWaX2oNTGIeENhzI92Jz35dHYMBO7mYxiYWc=;
 b=eQIJF1YoJNzQ9to7qJ6Arw+w7b9iQO6yZNsMUPGgyGB6mAHjzgECuVdq6x8l1guDTYwrfh7mX0GQLadQbfSc1U9cagWXomXZSfbLj0kQwSdGnUWx98h/1gnD6syyZH++7GeCiCoM4CH/EfhzhLVAkl9/BmZcFuwDmNWobuMDLYnSVJDaFePWG/Nj9A9IQCtMpf+8sKl2ZI/vYLGHlhUfVybkDZpAi4qaAyfxMg/JGOdSalvWpTaZwYJEUV3gvRiwELTOjEdJEH92Cw/q8//1CbH/9QMd/imS5ve8007NUrtiqJ46Jt1/NHAYYBdx87DjD94KFa/orgqOJvGK7Ep1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbgRav/HWaX2oNTGIeENhzI92Jz35dHYMBO7mYxiYWc=;
 b=iZB2yKA+EbNdpMGqjM/Tf7jYtnzS6kIkwJftLs+MNloItqQpz9TJCifi7+UDPAJ8g2RW84WjmiOhPeOfukFitrNnA1/swtES4yHW71QN+44MPxPNcGca1XZTkCt9wbzGfF8DyjN1B2Ga1lJq0Ft+JzJmXMMTLB6n/kifUKIo98RZwObIc7s4r2eKBPcCFwxnu+KRdVdgjrvr3ncWYAl63DT0JXqV2G+31uPsy1/Of7Rv2J1r6hYhII/mKhNev7CS4BmMJwuQd6vuGlma/u/yGsgBdj+D2wZuQ4zF8DbY44HKv0rd4+FL70E71TS14/u8mvwYyuq5CJoQky1Vn+XY5w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8473.namprd02.prod.outlook.com (2603:10b6:303:158::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:47:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 16:47:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: David Woodhouse <dwmw2@infradead.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, John Stultz <jstultz@google.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Marcelo Tosatti
	<mtosatti@redhat.com>, "Christopher S . Hall" <christopher.s.hall@intel.com>,
	Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/8] clocksource/hyperv: Implement read_raw() for TSC
 page clocksource
Thread-Topic: [RFC PATCH 2/8] clocksource/hyperv: Implement read_raw() for TSC
 page clocksource
Thread-Index: AQHc7WRU87pVGB1DykmPwn6q6AeeLLYjqIkA
Date: Thu, 28 May 2026 16:47:29 +0000
Message-ID:
 <SN6PR02MB4157D116CE958158638A2DC2D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <to=b6d2173312b8d0469774846eb18b9799832d9cfc.camel@infradead.org>
 <20260526230635.136914-1-dwmw2@infradead.org>
 <20260526230635.136914-2-dwmw2@infradead.org>
In-Reply-To: <20260526230635.136914-2-dwmw2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8473:EE_
x-ms-office365-filtering-correlation-id: e2acae83-a95f-4a08-3f1a-08debcd8ce9b
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|51005399006|13091999003|19101099003|19110799012|8060799015|31061999003|41001999006|8062599012|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y82bsAe1fmshgJIqUwrQCUjWAKqqYyx5ar16+2SYelO5CzbQy21A7Bcnz8uG?=
 =?us-ascii?Q?V/aPk0knmi0d+bvmDaGZuHKx+G/wCYO4BWV2MRc5jz/irNmW04jOgMxASHkP?=
 =?us-ascii?Q?o63dHpl0U4g/sv/YBx0rqlkr97Fsv+3xh5UR1t/Y+QGBEcxudMMaGB4T7QEn?=
 =?us-ascii?Q?RYlH8ae1kKleo9jV1TQeRXQo6FFg/4O0ZHr36MCeo1T+WZYYnLSvejHBz0X5?=
 =?us-ascii?Q?r+CiF8CeXjJSyZWK0s3qFMdb5brX4hoX+z4R45aKuscN+Ft5la7gH7mQ+2XL?=
 =?us-ascii?Q?/SryHf/VWIpaE1t2p/r0T9kMJcnLYOFiTFWeQMW96FGlxh18i8E0sU+DRy98?=
 =?us-ascii?Q?Jse+IqpIvtVwVsNr1HAmUTQmrfT0FCXj2ivE+O2LfmIIvMqkSnJi4pvbQcvc?=
 =?us-ascii?Q?QNKSrLl42JQwRptchjU9HrMoagaXdld5WzfAwQp1g9xtEtVV+CGsH2wvRt5r?=
 =?us-ascii?Q?5r9HTBOlz0GFrg3EAnauZYgU4i/AMHXmnaKvYhFfIXt6w7LrY/rmH3DuLTJW?=
 =?us-ascii?Q?UgdxMJVPeIZ4kEUtY6Nm8CMtIi9SstmGapoS2QhSEw7gAEqwMD8UatKdWT6i?=
 =?us-ascii?Q?peVQKvrSm7LJRzpnLPw806dvlpPiRm05pD5skHMvTQwPxbxp3GZMMgf1iyRR?=
 =?us-ascii?Q?KUMB7FMYpZQeVZUGokiRhvjLmHf5vGFhq4lr39cQYXHDu4K2V2M3uDeovy7x?=
 =?us-ascii?Q?nobsVRJeKgAp+hvlWg4q0J7zDd2CZZOqR+LfSSYqT+ac8rHvtGbdazoee0v2?=
 =?us-ascii?Q?Leq2BZcu8H0H6ukAGm3e8qGyguuzBkLAAawlJGnjayXbQsETpJGbW/3qJ+oL?=
 =?us-ascii?Q?l/2bR6/Xc5FhQ/G2D6DEaq7f7mNJaPjDvw5J3eXh5pvqyGuvbleIRss98I+m?=
 =?us-ascii?Q?IURYs2Lh0Tx1fWrFycWay+HUKWcdvACFWq348wHhn2ouS3I/cdVzoxcQ89LR?=
 =?us-ascii?Q?Ybnq5zwrMO+DuQUCR3QkSOUVZMiJCQQr4dgSVh64ANKI14u7nYZLlQCvXWc0?=
 =?us-ascii?Q?0k3mEpkFTU/9mrfAMnn1qz+U/kDWpjVZl531sIpD/HHl6OyaG67sMxzD2zzP?=
 =?us-ascii?Q?wZVgmRfX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CYJsY1rwN5MqqH8LF+HUcN0wRrPDMmy06WuAD4rokIt9UX27A6TOE5xcVjdQ?=
 =?us-ascii?Q?XhscWon2HG7iNimSNQVA50H35p1bAzvp7Z836XJHq3oa4LHDqnclJn3xnmyn?=
 =?us-ascii?Q?I/ECGRy7KrcyNgWYAV74BfLpBy+MWj+iyRkZ8T0v+w4ypmrN1hFQgSxa2OLN?=
 =?us-ascii?Q?PmhbpR3dccbyagmXV2SSBC4vVpUyS19/hdVbkJ6a1zpUG90aMGW+5e6tUVFL?=
 =?us-ascii?Q?SQt5+cSBEJ8V25Hcm9ENh/UhmiVWpDJGtgdqxJWW64bqiCuVg0qpRa5ZDLyJ?=
 =?us-ascii?Q?COo66Ku4na0MlExB9gK5CaUR5Bg5p0hNH6hA2n40eFYshOzLGN6boTcpjiDC?=
 =?us-ascii?Q?I5L0RqlKWbDCIl19Ks2EOFwI2glzETY5BzjsUJ+BycN4GyaHnjBqonGwzOa8?=
 =?us-ascii?Q?LUPbg3oCZeWbRPZ3ljF/X4v4upif8Kbqj2niTefmlmAnJuy/Eg/uR8Td49AN?=
 =?us-ascii?Q?WOc6n1D4eUr/aP3aqv1p68N1QaGFyLaiutLY1l8hUGvR7PL2oa7MMgwYVPDp?=
 =?us-ascii?Q?oV5d3veOdssRM82Y/7pYK3lAVvcqTB6x1HmcChOV1aqsUK5vyZngsNJkF5by?=
 =?us-ascii?Q?b31uopdlqNDAyT4kN4qcQd7cloblhbKfSEE7p9Pk79EEQAmlTXlasfup7Shy?=
 =?us-ascii?Q?RTYMKLw3IqqUhW5DKpuUuMSxdNYNRvT0zIhYbe/eK9TqU7jh57xfoBtg6b+g?=
 =?us-ascii?Q?EAx3bHPx2B55zZrg145JNit/gKZAAuJpoVQQMPFoOFqnN0vut1ZO3S1/6Hu4?=
 =?us-ascii?Q?VA4ZIW65cRCvccI4mGGrGHoPwTOq1T1saM58c1+tJs57nlY8Q5kh+3Lgh7P0?=
 =?us-ascii?Q?1QCWSme+wbj6VFs0pBoPYKP616/PrOejzXCkayyeI9iWhj3/8hAVblYVio5M?=
 =?us-ascii?Q?y6XPXGcQCe1hbUhG7yPYaBfd1sow3N+dRysU5L8sx8JHkE1pQkL0wjVdQCcF?=
 =?us-ascii?Q?uVXJyRFW4vqaKwRNfpkCzF9dWpEIJScwuaHsu120WcHngL3PAqeTLBFnF2Kx?=
 =?us-ascii?Q?DcuzcqjNqiz5hLvela4AiNfD7Iol9YN/8QMiZBzbq2gGWnAZM11n8sYNCmv1?=
 =?us-ascii?Q?4PUUVJIBZCSNKKnCcVG9jLhLNcxTcUiQvRGR/VOC+u3D6jQovlk/cRpWwbqp?=
 =?us-ascii?Q?eFLk5YWP1TslbuIicqDtNZL4qasNDUNIMSkRx1jUaMHi16YOzNZr87g9+jSm?=
 =?us-ascii?Q?om7Pp0VXyUt+BO07aih9WQ9VaefAS4IYIKvXcy35pl1RkXG6K7Ufcy68hII4?=
 =?us-ascii?Q?W56bVFdcPGDCszpSMFKtlYDuOyxx75LROvjmghlCocHZd0aQHgw7Mblajt2+?=
 =?us-ascii?Q?P6SqlSbVOZ5PZJmIrna76a/UEjiC2ytOg/htIGGG9G9epsfTUIVQJMTpDjFC?=
 =?us-ascii?Q?uF1mUVs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2acae83-a95f-4a08-3f1a-08debcd8ce9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 16:47:29.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8473
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11311-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[infradead.org,google.com,redhat.com,kernel.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim,infradead.org:email,amazon.co.uk:email]
X-Rspamd-Queue-Id: 49AA35F54D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw2@infradead.org> Sent: Tuesday, May 26, 2026 4:0=
6 PM
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Implement the read_raw() callback for the Hyper-V TSC page
> clocksource. This returns the derived 10MHz reference time (for
> timekeeping) while also providing the raw TSC value that was used
> to compute it.
>=20
> When the TSC page is valid, hv_read_tsc_page_tsc() atomically
> captures both values from a single RDTSC inside the sequence-counter
> protected read. When the TSC page is invalid (sequence =3D=3D 0), raw is
> set to zero indicating no value is available.
>=20
> This enables ktime_get_snapshot_id() to provide the raw TSC to
> consumers like KVM's master clock when running nested on Hyper-V.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Assisted-by: Kiro:claude-opus-4.6-1m

Looking narrowly at just the Hyper-V clocksource code in this patch:

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index e9f5034a1bc8..c5ae01fdbd8e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -444,6 +444,18 @@ static u64 notrace read_hv_clock_tsc_cs(struct clock=
source *arg)
>  	return read_hv_clock_tsc();
>  }
>=20
> +static u64 notrace read_hv_clock_tsc_cs_raw(struct clocksource *arg, u64=
 *raw)
> +{
> +	u64 time;
> +
> +	if (!hv_read_tsc_page_tsc(tsc_page, raw, &time)) {
> +		time =3D read_hv_clock_msr();
> +		*raw =3D 0;
> +	}
> +
> +	return time;
> +}
> +
>  static u64 noinstr read_hv_sched_clock_tsc(void)
>  {
>  	return (read_hv_clock_tsc() - hv_sched_clock_offset) *
> @@ -495,6 +507,8 @@ static struct clocksource hyperv_cs_tsc =3D {
>  	.name	=3D "hyperv_clocksource_tsc_page",
>  	.rating	=3D 500,
>  	.read	=3D read_hv_clock_tsc_cs,
> +	.read_raw =3D read_hv_clock_tsc_cs_raw,
> +	.raw_csid =3D CSID_X86_TSC,
>  	.mask	=3D CLOCKSOURCE_MASK(64),
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend=3D suspend_hv_clock_tsc,
> --
> 2.54.0
>=20


