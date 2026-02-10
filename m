Return-Path: <linux-hyperv+bounces-8776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MwxBuyzi2m1YwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8776-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 23:40:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC18411FC74
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 23:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24E2301454E
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745930DD3C;
	Tue, 10 Feb 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HuOAdwho"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013043.outbound.protection.outlook.com [52.103.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAF2ECE9B;
	Tue, 10 Feb 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763241; cv=fail; b=aKsbZQB3AG/h+ugXgcWXr1kDyVlk2TXYGwox0rbnQkQ2TLAUaUDCapF5KgyruNs2rrd7sDRgiDsdiHhxDdqSKCXvw2Sw0Z8BPCwyUEYAiD3hgw1ZmHCzYLJf/d0ISQqChkOKpeAgnmMQ0V+2m8fu6YgizDhfLbOnskdOm5D/ajU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763241; c=relaxed/simple;
	bh=64BmQ5r0vPcSCnj+PORNveSJ1a7r10pM0WtOselFcZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqccN9QjztCdSuyK/41jxsbPuhuX+WD1LAESVZzQ/vXo3HEuIjzRkn5TWh4ExlKoOeyyr2Kndm1zkEr3UdhXXbeUqngPdyWCk3pWeE+7fms1eup7xEFco2fsfq5OCfQM6ztHKLb+CImOEd3zXCmoYAQ9I/sk+J/9XeoHQnssfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HuOAdwho; arc=fail smtp.client-ip=52.103.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrKzfl6NejzD2Ox7t1iGB6vJ2K6n5qgdwpzNLxTLQT4Dw6YBW/n9WpHmlJn8vBqFKo/T7rr2wCdbgPHoe07RY1s9vYD7TlKVEjzGJsAmid2Y2AcFLeeSeIj3k4ClsjhHQm4Xhjdi9zS88m9sAD4w7svqF1tyZZspb7mVq7VIL1GEUOVYgEamaxOCFJsU/5dY1NaPlJmcVo4Jmzi9f6knfHyeltPBV9LWWzssGMhzZADXbWiNFiiPIPe9hsA4lCtWXFhkVEeyLg9b4mQRAf3OXT/wqQ+FMWoPXaq3CGtNhyWsfufmxxFQwwmS7ksoEhlQeJ3Q8x/IjauvvUogyfuZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwFFU42yU92znHZwWM75t6ZVoqGUDZKbnS8aJZzd6WU=;
 b=skye4iBgkBCsQjI2+kx4yk4+G2yBszqBPafbOoSPajmUuokIWC21Ixfl6fj+t6RaHulpTRH48eAgCxz9ltvn1Rn7/9tUQc2A4CktbiirpRGTwVzZMuiG2fm35oA5xWNUpPztU6zYedK1ToU4coSwWxlEkcUbqhnvsJX0PPK1AgLoy2h7rSZavwaAWfOWTIvS96j+Nl25JKC7o4N90FXDSkWcacwfctFtkKGFEAcS2nYgQ404IBqgCoYjWC7ENNThW4egIv72Wwvx6o2paQ+NVZGRpVAYiAvKzUqnigAhHvs1KNOjosEao8VYwkLVRO3vfa8Pp8HupY9ww/hFqxYCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwFFU42yU92znHZwWM75t6ZVoqGUDZKbnS8aJZzd6WU=;
 b=HuOAdwhoSiB9pLmT89LKVTGXKJJR1DREp4QbkCWt1CnCBn33fIHsvwYrUIIKBOSziA0Q4QezG+xkOmL69oJfSoOL+Aujhj+ebgVGLFviH9c+UGF4zw42gez9rm4J1Bw1o/NngmYgTEKwm8j6R9pVziBFeL5OnPyJ1IoP+iPY9i2hSsYRvxpXNdq0o/+yuSfNzOYWx4NrtRhGfTKTrp0U2k8APysoAspkjVIUmSF4/ZcHub9lnKPDmnt8wr5tFsMHp5W8tWaykTQkHemrricpyTYXWWicou//xPGp2krLHVlHzs7GT27hO2RiDD/eXzhzhUlUVdKMMOws6mH7Y/TbEA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6771.namprd02.prod.outlook.com (2603:10b6:a03:200::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 22:40:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 22:40:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Uros Bizjak <ubizjak@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei Liu
	<wei.liu@kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: RE: [PATCH v2 2/3] x86/hyperv: Use savesegment() instead of inline
 asm() to save segment registers
Thread-Topic: [PATCH v2 2/3] x86/hyperv: Use savesegment() instead of inline
 asm() to save segment registers
Thread-Index: AQHcWvFNUsSKxIYzS0m5CS9YZuhMErV9BdbQ
Date: Tue, 10 Feb 2026 22:40:35 +0000
Message-ID:
 <SN6PR02MB4157A2BE3BF643B9E8CB2B0BD462A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251121141437.205481-1-ubizjak@gmail.com>
 <20251121141437.205481-2-ubizjak@gmail.com>
In-Reply-To: <20251121141437.205481-2-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6771:EE_
x-ms-office365-filtering-correlation-id: 10bf9cbf-a1e8-4373-79b4-08de68f56818
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|461199028|13091999003|41001999006|8060799015|15080799012|8062599012|19110799012|40105399003|440099028|3412199025|102099032|12091999003|11031999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xTCHS5hD8/izVqViXysJ3bIB7DhNwVpc74uzLGkBnZp0MD8fa3u0iUeme1E6?=
 =?us-ascii?Q?QscSTNoe76DC4hBEbNtgbudfgVgb7ay4IjhUEDIA4RE+thJGfh0rh2Lnfwdc?=
 =?us-ascii?Q?PuYB3lBkmmld1b64+zXoayL7kaTciG/YxO83bafbBuzZafQZHxapJX8CM4vt?=
 =?us-ascii?Q?Jv3EiurQT25whCN1HEf22DqXm0/vPSICFLbQJQXbGR9dKt/irV+TAUHO4ZKi?=
 =?us-ascii?Q?B2pEZKxE40TFaAGY/0v6JbWSFldaE1YvNqwcXuKDOxuGmDECNQb42UcNNqmP?=
 =?us-ascii?Q?Bg/5NvAI0KAyARKGc3xIiLIuPHSczXmGHdRB4da1wq1CSnVOhfBdHOQiZWOM?=
 =?us-ascii?Q?ks7lM/p45n/hQLipUH5U61RlSJY+Cw2j6LAflgEHiyl1sv33CLYA5U4spx+7?=
 =?us-ascii?Q?BQWqzPWMHnHlriUURQzuRDKF3dQqgNUM6H8i2GyfVamqnJMMJNGhaXmD3ubJ?=
 =?us-ascii?Q?ROpNENJhgV8CHBhdY1KYMkHzewnEk7muU3LMbgw6RA73y48wb6Dv92OU3bQ6?=
 =?us-ascii?Q?gI59i3edJDb42x3eGQ5dbVepugXqgwBBN37AEwaNRXtBcu4bsou+zE8tfcuB?=
 =?us-ascii?Q?GRm/j5qpSWDDHLPBL4l5bEkRBoTOospRfvIjrK8CLhAKiTUl5mcfnZB9Bi1g?=
 =?us-ascii?Q?Ho8rjhSn5+kWfWBn/3ji5tdhQQU6P1sZGogdGSLJ9YZ4HpaNM4ixnAJN2qrT?=
 =?us-ascii?Q?TQ5i8IVAajAH9+8mmNvjziav0mYUQnxLfMKDBgs9TpLY6Ua3J5F0k9q2lqM4?=
 =?us-ascii?Q?Oc6F4KzKNxSIvj9minWNZRaffZGD5znBw4Q9V3n5W5RT47q4WwZ3sA69EP+8?=
 =?us-ascii?Q?bVAQlDqu1YRGMCF7j2W7UKYdQqqIaKJiZupC23sKisICOkx66YOvN/+sKJSW?=
 =?us-ascii?Q?gQv9hKuZl3yPCybWui1robHOYBS/waa5H3zmmRfGhco+98ia+Dvejf01PWcZ?=
 =?us-ascii?Q?KkkvB1JSJhqhF+jWE+AGevWqsTDrZF2fXd3I19LlyhpVocKTl3+EVNvw1911?=
 =?us-ascii?Q?JuQSZAWish37sjjGypJXLzL3/h53udMmyujeXPrG/5ByNsh4klXRkt3fZXTY?=
 =?us-ascii?Q?1kBKXmo9qyfnDxcocKOqoLhr4Zh0j/NDC8N0CVSiVQOQ132JWgQfho4BUs1o?=
 =?us-ascii?Q?01rCQQgI1HeHIkfggh9uo0DASgpHrLzLyAVHXl2KBqQnExMVo1qnPIEo1rt7?=
 =?us-ascii?Q?YCa2dFiXXnJ2/g4928eSwicr3QZkwl5Om52XtyJSsXj/VEZLo5On/2mKTSDl?=
 =?us-ascii?Q?FazA2fV1WMEqY55f+y8ePQpxvHr0kKoaPrB8xGaFJ6VC1pVJN+Ix1STWut4N?=
 =?us-ascii?Q?WIBm0e3WZYRpkx7WFeqj15OC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7+k12W7akDCOKMlrlbjLe56eeVTbc85oOfDl9SvSuJSr7AHGAHKV/K5ME4cI?=
 =?us-ascii?Q?wDqUY4zI3k6p0c8kFq3Vj0zNHrTqDeMYrLzNUx7XHGsgGiDemFSOcq7LNK+H?=
 =?us-ascii?Q?z40G8kuPt1WeVjptzP4BIrU0gOaVhBrIWLXLgNSC+4/HkfpWd0VhbEQYhA4o?=
 =?us-ascii?Q?I57ycKHiWY3q3c3uCRjdPmPlZnKJLxco+W4KrOzpYLdwwjZUBCH3NmxphAMG?=
 =?us-ascii?Q?vkFWI4octnbd6DGLqsLt9w8FE142baiKWn1uoR45gA6TKHVVIP3REOvJqLGE?=
 =?us-ascii?Q?expkDeyDgHszawdEzhKs5EEjxLyAm5G193+BFLJ1uuS4zvYzMvMOBAkczt2f?=
 =?us-ascii?Q?FJMzeyfgOlyLaQ1Q7dTzevJfUJnmT2jitWt78NIXoYndRe+4Nx7hhj6oAo+3?=
 =?us-ascii?Q?6yaHt+Ancie03dBKu99UEJhejzbFiY7n8Vc1PGxycRJXsIeAdJAn1rNsXwLk?=
 =?us-ascii?Q?MsKjys6B9lJ/VVPo4G8K1CqG0YN65Pvi3XN6A+Ahe13UWggYIHXI0rXyMoYv?=
 =?us-ascii?Q?Y3LdfkowrLO9DEmL3+c+6p/mv/UKxHwY7g6+wQztY5Xj4dJVtXdzORhQe7Ps?=
 =?us-ascii?Q?tu1qqnXgFyOyExtBVrFKftk1AzoGAKBh4nrFdhr0YDNcf4EsCDtAgnrUAwvM?=
 =?us-ascii?Q?7qOg0dT5LBHyBn1X9vKTbSmr78a1fWe4AMM1wc1j3ksgUW7NulvPDuDox8nI?=
 =?us-ascii?Q?o0ExaGKpj4Qav0snvjYGg+Kjd2FYBxhuB7vTmU2xTzR5GiEvcsOg0SyB47s1?=
 =?us-ascii?Q?UrxfGsNY6m6gE8G+sghkBx7/py7F7r83DvQzCdk61el8TE/fkkCp0myzpT1G?=
 =?us-ascii?Q?uU8UFwFTdWIzobE2yKQaWuxWiNizzZ+Z+Z1vfjSH7yg6Z9WcQxmOirjfQ5xW?=
 =?us-ascii?Q?GKP/7Tb9bW28yDxL6I4pMUBWlgOpR4hQcuCGokY14yGdmd4vR80Sgxl9w5da?=
 =?us-ascii?Q?9AJtrlf/MoVICRa54vr8j/bl2C1aKjZu8GJGEH2oOVbWOi23qap2FwI+xkvS?=
 =?us-ascii?Q?KghPXRVLlVOiHmCXQkWsWy03G5QxAiJ2I12E7SYor0yPNJD9Ibvz8QuVmNsu?=
 =?us-ascii?Q?6uyiHdF79gVkvsMkhiNkC+aJmiTVynwsBWVTsl05eXvnm50DsZBGlgrLag5L?=
 =?us-ascii?Q?//WkmS22BcowBQxCeQTeLfDRK6VYk2pDEaCiXMprfogzvcOs0DgPcFrVfzg6?=
 =?us-ascii?Q?+XjjT+WpBICe6IIWWtxzNPqyrU0k4ew+xHbMG8Zya6Jrr/7t2mypluecV+Y2?=
 =?us-ascii?Q?tphUtSFekTwh9IlvefhsbL48v5lkbwhqi4crFlNX3hQOyGpeYfM5E3hhE3ZO?=
 =?us-ascii?Q?uaYUanBACmd0CGVHgYBo5kNF8EPUxOcj0oJIoMrsCEp3edtc2fGIkmLJajAK?=
 =?us-ascii?Q?BwHybb37SIt/2yXs5lkBbLoJtPqc8GvlQmbI6sVo7dgbbiE3sRToKwjxT31l?=
 =?us-ascii?Q?6G5wFUKqXRJJl3CFbKDKuAaJjWz7nWYw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bf9cbf-a1e8-4373-79b4-08de68f56818
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 22:40:35.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8776-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: EC18411FC74
X-Rspamd-Action: no action

From: Uros Bizjak <ubizjak@gmail.com> Sent: Friday, November 21, 2025 6:14 =
AM
>=20
> Use standard savesegment() utility macro to save segment registers.

Patch 1 of this series was included in the tip tree. But this patch (Patch =
2) and
Patch 3 have not been picked up anywhere.

Wei Liu -- could you pick these two up in the hyperv tree?

Michael

>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/hyperv/ivm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 651771534cae..7365d8f43181 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -25,6 +25,7 @@
>  #include <asm/e820/api.h>
>  #include <asm/desc.h>
>  #include <asm/msr.h>
> +#include <asm/segment.h>
>  #include <uapi/asm/vmx.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> @@ -315,16 +316,16 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start=
_ip,
> unsigned int cpu)
>  	vmsa->gdtr.base =3D gdtr.address;
>  	vmsa->gdtr.limit =3D gdtr.size;
>=20
> -	asm volatile("movl %%es, %%eax;" : "=3Da" (vmsa->es.selector));
> +	savesegment(es, vmsa->es.selector);
>  	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
>=20
> -	asm volatile("movl %%cs, %%eax;" : "=3Da" (vmsa->cs.selector));
> +	savesegment(cs, vmsa->cs.selector);
>  	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
>=20
> -	asm volatile("movl %%ss, %%eax;" : "=3Da" (vmsa->ss.selector));
> +	savesegment(ss, vmsa->ss.selector);
>  	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
>=20
> -	asm volatile("movl %%ds, %%eax;" : "=3Da" (vmsa->ds.selector));
> +	savesegment(ds, vmsa->ds.selector);
>  	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
>=20
>  	vmsa->efer =3D native_read_msr(MSR_EFER);
> --
> 2.51.1


