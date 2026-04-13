Return-Path: <linux-hyperv+bounces-10127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOxiM5Ct3GkBVQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10127-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 10:47:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91C3E94CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6B13040238
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8943ACA52;
	Mon, 13 Apr 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G2mKo/tA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010015.outbound.protection.outlook.com [52.103.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631483ACA6F;
	Mon, 13 Apr 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069824; cv=fail; b=BPc+vFf4Iuqo1VnnofINM+Jdc6JfjuKymSpl1/e07/kzGgkYEVCXvUaClrZjH29Z93Jtl0O/sLQfdZN7K9V7ZwSHS7DR87AwTNB0vfwoiRJRa93gdEEiAatdX6lnsae0d+aIVpvaiTf8m7pjP9xb9Ky9AFXrrajzxqCHAyMYS1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069824; c=relaxed/simple;
	bh=Jp1+xiliacoivZHxscInKIQz8kTQvnUSZ8dQcFJoXBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaxaYz12ux0/xjiQ1o88WzBnfx2EUflVCVqFa+ar0Y2OR52jx6vcoH0VGHinHt/BMuEs9LFd646nWs42ktfdxo8Mu3omWvxfRmGbS+l3NKR7TJI2PDmAKoYw2IO1SVAVV4RN9H3wb3sAR06MPtuLV/eZFBFIGacnTY1uHqsaYFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G2mKo/tA; arc=fail smtp.client-ip=52.103.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COizYLcOaKLPAH1Ev8AYy/yLRr6rNFQJmBCFJ8P1Cf0cwbD0wMQ8hgmMMU0H8dixBd+UVauTzLSwOjLZeJkN21jQL2ey5cAwqi0GtR1HP6rfBwXLNPj5h57XaRETN1IGI4k4fR3GYYIxKFVqNfVmvS3iAN/UqlacrChHiCfpb+8VUCYwwohLV3qn4h980BZQNZfu9UtPx8IHGQnn0uTJ5AxFDhzEmceCubQcq8lRtN4khoxgG7mp7GV5hR/gYuByjyhAZc1OX5pZ2lSBbV9Hu0QAP2Ox0GWEgz9adaOIbcVAKHhAb6TMsZmi79iiVe24spxegxEIrW/vMJZ+WbvbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLhJQLaH737B3o/YVOG/Bxi3cerC65ZcyjpZrNmzMM=;
 b=LI+0NkSTt/B4d9sNMBbzLoeyo61ESLoVxSOG5pDpod5vIP1DDw/GU6HxZXI0X6chSe1yDMEdVSgYQgu/YGki7hxeUGHu+TpqNJabG2WmVSd1gR/uIsYCkNMj0u5ED3ZezYpl49kqv+qexJg2cwvvgfSxwlo9nNbSpVK9c46D4eDFVuUK49fp7vy7+gT906zGkJ/honNFK+8xr6BDa8fG0f1+rlcyNhCjdygcszWKZslV9WOGbiHi9uZBYuaO9NxjVzkfd0vBNslXS66bT8jDBvLBv7OQSO/RDqGiH5GuqVfJS2lplYatUy87EykIQkZ5sIXImdusKPS8ZO0+Jf1Gjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSLhJQLaH737B3o/YVOG/Bxi3cerC65ZcyjpZrNmzMM=;
 b=G2mKo/tAAsUnKvT8Z4lZmnfi1qVgYGmN/WStKLpLgySC1iygXkUiOgekyoei6WmvzAC0gOzkqtF4CcQw0KNBqNe1O9SfdYkjwEFtU6G2614bLd925MxBfpdZhbUu5M1xK9rljkNEWDDDuaBFAQRuHoZkQrKBug4+0zDgkLu8/5AVLj3Y8kNUNncW74g9u2nQdEcA5DrXKY2Dag43U21+KIZPNES8uond+czHezHc4SLah10tONzldGTjwK1hL1u1ooTDrVN2yuE8/CKJwZkZtZnp7X55yGHRC/4gslz/J+bi5hit551eeiqlQwEpUrljV0RuaQZEcnVqnUl/M+5iuA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB10711.ausprd01.prod.outlook.com (2603:10c6:10:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:43:37 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:43:37 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: "vdso@mailbox.org" <vdso@mailbox.org>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>, Praveen K Paladugu
	<prapal@linux.microsoft.com>, Jinank Jain <jinankjain@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Topic: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Thread-Index: AQHcvpRNbg/7iVrB0UyyX/rVQKTUD7XMcrMAgAs+NQCAAbOYgIADYYUA
Date: Mon, 13 Apr 2026 08:43:37 +0000
Message-ID: <19EDB8B0-A6F4-460F-8ABA-E9D3E239511B@outlook.com>
References:
 <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
 <89730D18-D9A3-4A18-87DD-E7A51625FF69@outlook.com>
 <319614096.43465.1775883935863@app.mailbox.org>
In-Reply-To: <319614096.43465.1775883935863@app.mailbox.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY7PR01MB10711:EE_
x-ms-office365-filtering-correlation-id: 7ab42bb3-d6bb-4331-3d93-08de9938c15b
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|24121999003|22091999003|12121999013|15080799012|461199028|19110799012|31061999003|8060799015|8062599012|41001999006|40105399003|3412199025|440099028|102099032|26121999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DQgtO39d1YJ+wqqqVQSsSXc7H6zZJLdKIxxcHB4SseukTpeo0HarWOART//Q?=
 =?us-ascii?Q?TWAv5y5glchb7DUoD+zyBGYhE61Gcpqb260xefQQnvrufdQSw1bwkD8of7gK?=
 =?us-ascii?Q?amXEwPTB46T07oTG0aH2KJ14H96pw79VeAHDfVDcfu8G6tkiMTHB89MEzVtN?=
 =?us-ascii?Q?Oa1cvj/C5lcbQEMCeYdwxf9ely89Or5bV5eQRx4Hej1/CKC3Y/MIGGqlM/xi?=
 =?us-ascii?Q?qi1cWlzTJmOgCCSyjxu9e3dwylnGDYnB/1psluk6wH1sBa319o6VDE4r9qBP?=
 =?us-ascii?Q?ZlQC8QKpn7KJnlFMz1NV1pOZukbjRM7t/rScqFiNWgrxsQ6dzuCvlc1ob8/6?=
 =?us-ascii?Q?gATU8nJuPdecJzu1tF3OmCxeA+EasrpARugKS1rwPS2V3i7VHOwF9IlZXBgx?=
 =?us-ascii?Q?zRLcefqmScQestJcL5SE+DqJk9YUDnGLp2NEtXJZ4cn4WvSP74nrBK1U38R6?=
 =?us-ascii?Q?QAFjVqHNFLK+2RzF8eNR9OnDs28hZn5JLwxTenDdJ8z0vJUzEpACOQAqziLy?=
 =?us-ascii?Q?v4Cm1Gfq7sTnR6SXoxkd2/B0RZ5k+HzO3vrX+BkcgrkQJa3yAFPlRmgQwOvb?=
 =?us-ascii?Q?ABxS+x0xAOrf5P67Tr5v9WLcR3fdSjNJZ7vxiNVdN6V6CP6AQ/zuMZPwLJkr?=
 =?us-ascii?Q?XG2TNyzHQurEjCxJJLMtWy8X8jStinlXL6bQZVL/MKuQbjxODk1Dk6+gC+aK?=
 =?us-ascii?Q?i8xU4PO9NEw2sDuttjlx2LJuaoohXsPdhRHebeTiuI/Wf2YhsubuCUxhdhhQ?=
 =?us-ascii?Q?kpFqrs5CQVN1HdTyLQKmtvd3ufrTw9OT9N8HxVLZfPUDY54Zfj/iTvYle1tI?=
 =?us-ascii?Q?RzuEJlU1qBkM6+ANsQUTbH2VQYn1Bix8pyCh8l7R4umC2jYsFUSWwTMzYUhA?=
 =?us-ascii?Q?ByHBBkaU5J375PFZ5tuAU2A0RDjBLZ1DV2yJ2Pm1e1z5YlvIcn1ooIPQ0cmV?=
 =?us-ascii?Q?aQtGfHApvyMEJBSx9WrgWR6Ut5y0uukufn7eKd/5wd3N6h3vAnCidB9j9hzj?=
 =?us-ascii?Q?2KuEdq/7HUpv5b9Oz+5oWAnSKc0mo+TFQRnZ0PCsAb7pk/ku9VeObmM9uy7L?=
 =?us-ascii?Q?29t2Mki1?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+ZOa+9bOv/o6D4bgq10+nuanIChUyd65imCaXr+l0JtUevoef/gQaInlV9DP?=
 =?us-ascii?Q?J+Vi5a/Zd3w5hLcw1Z0BnlRC9RSImllctSPmLY1DZT9f3iH01si1POVfMnGD?=
 =?us-ascii?Q?gOvpP/JqhC6UhY4uw0kLK6P9XXU1FBgiPri1yrB7cgSVwyAi50YXcB1zX5nR?=
 =?us-ascii?Q?igE+4KkcCM2+bwI/CYrnDIzod9WzH9jWYOUyygw+xTd1yIx1Ru9dPMNY/fUC?=
 =?us-ascii?Q?k6p8uC1JeQFCFNlGXL/3bEtygGBlL/YcaEuvRWi1oQFHkRGGEl5H/Eo8l6Mr?=
 =?us-ascii?Q?TdlBDYCgNE/y8GOsjz76qAKHyGsXNvT0rda6g5Gnf9+yVfC10v3/PVYsk+SI?=
 =?us-ascii?Q?XpsyTGLyqpFFAwyVMbrfRPE6KJIuo6kqn0jh5qtGghm7NABlXfwW0meAg8BQ?=
 =?us-ascii?Q?hkttoOFQd2P+y9YMZhSLAC7LGhOkxhOTLoT1QNtHpO7UWXnmWZ4UPuhQW2Xh?=
 =?us-ascii?Q?D0lgzHH7lG4F0aQ225jmO0VQ+bd2QfiKNix/OUsPR5pBicL50z5rSXQSfKSy?=
 =?us-ascii?Q?d7aB483l+9KLLpfFIYzzbi6SgYsdiSiAwq6WE54yLvQo/3PqQqa0oYZ2NuHB?=
 =?us-ascii?Q?VnnQfniZmevWiHDoOgMGVB+fSrGYasn3PO/PgtYFYVWIoYl/lX1HPPTnxkUm?=
 =?us-ascii?Q?fkEDxHVMKHxDVdBX1ReWHgpGMOxc+rNvsuW2DlF61sSMQLQ2n+NJqII19qCl?=
 =?us-ascii?Q?ysu0f/jBYmahh4VvjRIvgiOPXdZY04gr2daufW/Bnr29SR7D2+Rx5CxZHjZi?=
 =?us-ascii?Q?vkIH12+YX6f2nEYmzXaqe2cDbwrYS1mRbWGMqhvr5MyBjoHpA7GoS60MkSaM?=
 =?us-ascii?Q?OxlqAv4OJJ0Qs0sx7+XTknct2e0Fj4snjsLQNrGDuXtasUwE/iMOaiuTKYac?=
 =?us-ascii?Q?fLUXLyLEnpA4ZRFTf3VVobbbmAN8zkGLhzRaxjWR4ZlrlT5yRhG5ruSvWMM4?=
 =?us-ascii?Q?6yh3xhic2C0rns0J2fqZulLl79H22be7xzVo65S8pH57XLmwJJdigqSTFETH?=
 =?us-ascii?Q?BGd1oCI7Nv4kbXArYoAYj6ADY0RKEaQaL8SDTSJhWX12/eq2nKTwoA5SWNwI?=
 =?us-ascii?Q?IXUoO2f/vOGU9UXkD+UG5mu8kVgvVBPQPuxSTZ77LKUbgd1lD6Xsys0qPaEE?=
 =?us-ascii?Q?CYnMY9ydda/uD3PiAN4v7wuSN2Wy88lFFkRjfEn2r6cPzu28xI6x9S3SCvJJ?=
 =?us-ascii?Q?4lUyMyptyjz9L1SvgxWAxJ95mr43BTKBObS26mibttIrx811EX5I2iVksnax?=
 =?us-ascii?Q?pYfOrdcdRhaJdzK9Sny2LMiH6Vt+FLMvntDVs+8LWGdN6jF5MEaK7pJcZea+?=
 =?us-ascii?Q?59K8aMbzioPkoAArnGq4hKXtmNEfO+o7HX/7FLI5w8cRho4A9b8X/0p6nE/i?=
 =?us-ascii?Q?oySPJI2dD661F4Ad6p2ojizLcM6RMkHa36O7DliVygU2uiRcjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C49A8A4C4E7F444BB6A9C988E1BB352@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab42bb3-d6bb-4331-3d93-08de9938c15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:43:37.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10711
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10127-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid,mailbox.org:email]
X-Rspamd-Queue-Id: 2F91C3E94CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:05:35PM -0800, vdso@mailbox.org wrote:
> All in all, from the three options of (generic check for overflow, simple=
 check
> for arch bad PFNs/GFNs, an elaborated check with all specifics) I suggest=
ed the simple check.
> Fast and still more useful than checking for overflow in my opinion.
=20
Thanks Roman for the thorough write-up. Since the original patch mixes
host and hypervisor-side constants with an unclear unit, IMO we should
do the bounds check in bytes instead.

For instance:

	u64 start_gpa, end_gpa;

	if (check_mul_overflow(mem->guest_pfn, HV_HYP_PAGE_SIZE,
						   &start_gpa) ||
		check_add_overflow(start_gpa, mem->size, &end_gpa) ||
		end_gpa > (1ULL << MAX_PHYSMEM_BITS))
		return -EINVAL;

Both sides of the final comparison are bytes, so no host-vs-hv page
unit conversion is needed.

In addition, it changes return value from -EOVERFLOW to -EINVAL.

Does this approach look reasonable? Happy to iterate if either of you
would prefer a different choice.

Thanks,
Junrui Luo


