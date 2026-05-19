Return-Path: <linux-hyperv+bounces-11034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPRgJT3EDGo+lwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11034-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:12:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C085848A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C50E3009526
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E253B7777;
	Tue, 19 May 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mpj4kcB8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012015.outbound.protection.outlook.com [52.103.23.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CD33A9E8;
	Tue, 19 May 2026 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221314; cv=fail; b=e9ZPIHYQdwk3t7gLWCe2yOnT+XtiMOdsgXUshUb8zauJR29yV9lTBSBsOcqeuSpV12rkHft4ggDIptLKza4z7TBFN/uDTAnBxUlwzbrtLvYFsjb+Dp1F/ctEMSDp/PJyvl39S+6pc3n41KebLu6e90us7zv6McaUXK3p9mFxXcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221314; c=relaxed/simple;
	bh=RjaUowy5oCPAkK8exkpbp2/02lSFk3kNl2fxAW4R8DA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDtfrNBpsPmzf4SbVaAK9Rurym2iVX2iK0o80jE9Cwq9TJwy0HzSaQHrEmSVsnqgMXDxSXih5UzvMI1fKe2GPYZdXF1DyRGTb+gpGAbiVpwQ1dIasO98oyGK5kodkt+mE3lk6OSiDdTAiYl4wlp/n8LrW41sVVcpKw9nxvx1ysI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mpj4kcB8; arc=fail smtp.client-ip=52.103.23.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3Z1ZfAeA6mHCLPNxueu3LETMqEiz7nMdGG43uUmJciyizcO2vReHYkSfdmnVDZIMXvC0Oh3If3rwsydaTSc01uQobUtLwo/IVyA9qW3ADtpVfayImjoeBdIVK15nfPhGszx0rk5mYhB0cwAeC6VfkydL0v5uoCXzT+39u+pIzxTelXk3ZAhdbvkaL+g3mjCtsukCbXOxp3GV9t5n7twvkKeWZlxEpnIFwKzERMl1nheEZiCLeu2I8szkQFzGBGKJrNV2M9MZxXLOk8Kswj8OclgBrW4y3hJtbvt0fLgxg1bD/uT4jphx2W4pbuudPEJpS90zP6srqHia7Hw3NZEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+7/Qv9HH3aj5jVgn41umedhyPSOwAp8PKbKYict2Bc=;
 b=grdlT2EIZcYiT/B44sn7NcMqZRVCb4Ty1m/JlHOQ/AdL9rEAkCp01w9s5QkStnN9jM6IP2d/ReRR4v+5omnnP4LwJV8C55EP0denjofpKBQJwZ7ytm+iNWDbu+DU9/i16IsSYpu1Z9IdIVSy82mUD6xFciqbWl9EiIHQLSVE2R5DsD9YmFVzMHpYQir367a9H+P6w15GS5XXYRrEN0+rC77YjOJ3PqZRdMngisrpRbZJiqQ4hnz566PNurtoblSwhHCjJLdk9uKIj4+/lbruhpFAKsCnp1PhGZeujiQFGKuZD3Wxoztrrn4pwkIw8iUw8vLcaaI8LMMhlgNFwAosgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+7/Qv9HH3aj5jVgn41umedhyPSOwAp8PKbKYict2Bc=;
 b=Mpj4kcB8qC6sb9tbAZ9OFLoCRyjoDwuoHqsfrg1xia0/suFHtC2+728VsmE10cFOjMqxxqPWMtUiousfrKcN0cjkgcHHasUEaXx72bxdkmOybjIm59e7eAG6gDPOE5MAumPJQ2URPW4AyvZXhuPrBFTbO8febGOzxG/FcddgigL8NHI7r7/OLOSqbeKxrP9Hsn/Q2R7gKYxLBSobrlAtXnUeoMEm1RaFq3DZjABXf9liQmMLOT9kCyQkgtqBjXsy3SjR0avfHkW8ZmX5dvXNRTAoN8dvy3FY0Cefdun7jkbULcNV18KFFL05fVkDCrorkgggOYkZAUffIWZep/nmXw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6759.namprd02.prod.outlook.com (2603:10b6:610:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 20:08:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 20:08:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 04/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
Thread-Topic: [PATCH v4 04/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
Thread-Index: AQKgEqxJw6vunjXZ4JfDTdDBDzr/OQH3WWB3tH+xv/A=
Date: Tue, 19 May 2026 20:08:31 +0000
Message-ID:
 <SN6PR02MB41572B5BB398F780274756DDD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816860118.21765.7481864545928795603.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177816860118.21765.7481864545928795603.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6759:EE_
x-ms-office365-filtering-correlation-id: ddce05d0-83c4-49ef-3c24-08deb5e2663c
x-ms-exchange-slblob-mailprops:
 02NmSoc12DekrR47MFWXRYzut/69urIxHYlN3kyQ0ZGuHkCg8j8bGerg4jpP4bBpeNgvKzrjoK19pzXwseqBqe2pfVpydPJjzAjYoFOgXPSAigs6608xYtWktAg8X0xVdoFhOJTRItJ2tZ9oEEvI09JqwByOqxZ/oVzRZa3i3txj8mNpvs7yt1y8CzargxPQPjBN73zR4t4ckQ2uymkgfVkhrOL2GvNXXdDpR3QiXzo2xAKDCRKWqgSkjBW7HSPZ4Jn6SJenStf0nr+SdinfbhgARH36qmCLx7MOLOVYpQIWzkia0O/zfpmV+KUVcp2FTWENZC+zidT7C9p+ZOABEwpPxp7T1Q8RlDwB9QPROARtkBfW2wFeAn6HefKP8N+MaaaFnRf7rTRTWDVohzHBBkwiwvxX+QCK4Vg6tmuQf5d35k/s5jqF4PC6NREzmO6SmeD5/iD4eVYPQXtpalvV/uxopB22l+tXL6YkBMekomkX7IZ+/aSU8bcGKSRU/26CcFGYtRwDNiGccY2FMOeMQSKVkIPAQK9w4QMQHl750N1k7mhDLroV8pLEa5ALFcgCsP2Jthg70KegiX/qjW+Ol28Rele0aMHlIRAKh9SZ37VjUZi9vcqM4bESwhsAmVkAIl8epPz+hogNdylEgxGQcd66V5T0lwqI7rxpfS6g4N8uhN0r8AJER23LzBVppQ6QL8dWWEwhzF+Zv7PzMl/SG3ZGam7k5Oupkmn3g4Ex0Do5U9ZUOJt/E3tsZ+Q8WXyw
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|41001999006|12121999013|13091999003|15080799012|19110799012|8062599012|31061999003|51005399006|37011999003|55001999006|19101099003|440099028|3412199025|102099032|19061999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OyriDh7TNz031huRcZ0jiVscWfdqf22Js0Fmca5QgUjUa2CuBLXy3f/Jj5G/?=
 =?us-ascii?Q?9aMwqi1lPtObmILJkRQ3cDJ4MqqABPc5ZGSivPhWkLqvieo780l1pBtG/3e/?=
 =?us-ascii?Q?P5lHAmtm56jO5sKTrOEL4mDNuyOiT8MjWveuqVHLKo23/sLLQ3cryv2sAtBx?=
 =?us-ascii?Q?6VX7XbobQiDPLXcTR/CxF2Aq2MdHcCKfJm4ZHEgw4P2qav2JTHJES0ijj8tl?=
 =?us-ascii?Q?KcL6FBYWfAG/Kt6Me42DJhI1SkYX2qcf+TU4ByIO9lrMVrxe8wRFkZagl3uk?=
 =?us-ascii?Q?DK7UWHN1Xd9QmKr+WdGakiNjotC/ENHdtCFMPDyT9f/QbIyncRyYoOUNGKsB?=
 =?us-ascii?Q?X22gG+AHH6lH/lRh3+4ykEUuejK/v10PKzOp5I1Q50GW8VTS6dYznVMJ18xJ?=
 =?us-ascii?Q?AcGOiCNDy/x1GPdiTm9BDvtmcU+8b8Raa9qvOrl0N9TznLbM/7IvGZw626e2?=
 =?us-ascii?Q?qnEO30fg0kecRK6T19WCXhxiTm0hWscPv9exnu3QDJuASm8JGnBSfC9iOypC?=
 =?us-ascii?Q?vuJxL9fzz7Y/rqinimIjM4vZA5FuyfyxMR5RZiG5sAJDfa+DrOKQ/w8QOnTJ?=
 =?us-ascii?Q?hccI1NNvz5ktd8cHspzjOknO3jilkjNxwlUKOlBuX2TUWx2sC/M+hUEYIsZi?=
 =?us-ascii?Q?/XZRxVwQumK2IbrjthXy4pEjHYCRkGoBXiFZcOx6/f9b626nRL81lFuZed5j?=
 =?us-ascii?Q?a4u2+cVcQ0PzXIpFV5Duh92iJQEr5jKPPeti3Q4uWOoL72UgE9Fm5OafaUXr?=
 =?us-ascii?Q?eGkKudcDD9HNJ+miyjPjEC1UrvzrsKdJvLHrn9MqH0RfuR0KTkBCuleRj7Mk?=
 =?us-ascii?Q?Ou33IIWRN81jj8FkM9glGBv57tVgTCAf0fS3kyxv9lsIvZXrV6/f3yvFOxPB?=
 =?us-ascii?Q?GFKqqSQT7gIYHAhmAXmEMSO3JkNzn+RZdPEaL3sXbbLoBavU28BiS5keOmlj?=
 =?us-ascii?Q?yfzbzN40SwfpX4hlHqfHly/kGW2G4P9hMEscPMFbMyBus2eqwSs30vwPpw5g?=
 =?us-ascii?Q?JTgbPt+xclJc6bD/OZ0Zs0au7YNPTpbgS6g3XN0SY37gkz+9FDRkcG/72phh?=
 =?us-ascii?Q?gDQZdD/VTHbryqU2bRzylWt9aZ9bgMERZ6s8KjY9bUJmWtIfYC412kjf/heW?=
 =?us-ascii?Q?4pkfo9B9EJkv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7g4+TGdEIZFdIItdMYvobIkGBHS1yPw/X/49km5sn5Y5DMu/3Ljy9SkYvTj1?=
 =?us-ascii?Q?CeOZBCe42RWTeRQEY+KzeFA14Hw9evh9KWZzpmJpD2fXjfbhDHAA5WLS0PS9?=
 =?us-ascii?Q?riD32knkIdCi4j9g8/sTs7M06LwLi2z40pVgF1pi2OOzP4pbbInU7gI8dBCt?=
 =?us-ascii?Q?wABE93PxhzwLxoiQsemlT263HwHH2K8eFwLKZAmYrHMbmppWQr+jAntEzsoh?=
 =?us-ascii?Q?BJl6zA79D/fugDpalYVqCPk8k+6bZLpCnR7HGdgC5m0PhDSaqe005h8MF2AN?=
 =?us-ascii?Q?/AymmizbUbbPCLlzBm4L9rMY3T3GRi7fNFa6n+U28fV2fQ3PIcb+ps4xF1OO?=
 =?us-ascii?Q?8r2AulckcPM31T0B+fyY/fnGO9i4ckJi06GaeFHPW1wn+70yZs/WDZjELUnv?=
 =?us-ascii?Q?vz0sT2KVii7srCF94sAizoMN4dwukVB6UQ5UqdfpUyzoRG7SW9wN8UQPwHHI?=
 =?us-ascii?Q?Ymp5FYfR1Vo0+i77Eqpc4O1k7b6zV4twt3laAfO2Wsz+1l5kyMBBYA9Gnzi9?=
 =?us-ascii?Q?LoYgoCBTBL3Ol30+WcCnTOU8jIdW2UohnRDtxqCMrBp/eB5WI+aVlwNpVA1j?=
 =?us-ascii?Q?wPgoEfyF3MZPv7HEF32/NjZQeg9bXe/Byeswz1x15W0e5D56bkrJn9sLvMDK?=
 =?us-ascii?Q?KH32l3eKWmFQpOCOrQ/qpoOuvNEp+jCKlFWdVC/E0D9PYWsYgN7XRfp2h+63?=
 =?us-ascii?Q?z+FqO/J2N3jo1Ysc54zygjeALCGUVgGpmyEeJ6gtDX4tOwFNIjufodMFioGC?=
 =?us-ascii?Q?8hDxvQZBdGA+7aziyev1+BBriyEUQfmFUcdy7qX6Kn3xpB26iWB3EP+fGPUJ?=
 =?us-ascii?Q?WaZC4oIFAbZtv11gyVDBDkGafXUvhKKDwQY/RxwrZ8X+NwnRleSiUR/Jv1us?=
 =?us-ascii?Q?DEysYZliPwNouXzMesxhnIkdb+c1+GEDDsjdhVuWCRECetwoliDDT/uYc4LD?=
 =?us-ascii?Q?YhvWUsWcBgAooLY/5x6uleWxPH66N1ElbSxt96VWekHt40n7dXBGiSb5A/Bj?=
 =?us-ascii?Q?0mnSOV4f8DKZyKIW7d64Ri+mKZOd//sOvKwjl300YTLJlLqebxQvbFvnAFG0?=
 =?us-ascii?Q?+ckIv519YHxvds/ChoLPg5M6cmyOgxYphxGznaaX3kE/siNBMF63DFSM7Nb2?=
 =?us-ascii?Q?kKCi5M6GaPFWhXIRREh0gaa9mXGFzFVSQr/G+ghvNEbOBh8eEk1IZ6epefNC?=
 =?us-ascii?Q?i87vh5CryHmkSAwtC04TSsj6b00v8rncq13aO+SE3mZThrz0b/BTVA7UnUB8?=
 =?us-ascii?Q?Yw7E9+lm1NQn1Bn3OlD0SbuBZs1xd8ZF1OosACNAQ7sTF+iQKguOFkZ88GBs?=
 =?us-ascii?Q?gC1Wl1fIpxUlswj++NGz6FpLkSk5S+Xac8uLiU1vW75iNS9uxbnFbN4xuNee?=
 =?us-ascii?Q?zgNH57w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ddce05d0-83c4-49ef-3c24-08deb5e2663c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 20:08:31.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6759
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11034-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: 02C085848A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, May 7, 2026 8:43 AM
>=20
> mshv_try_assert_irq_fast() dereferences the vp pointer obtained from
> pt_vp_array[lapic_apic_id] without checking for NULL or validating that
> lapic_apic_id is within bounds. A spurious interrupt from the hypervisor
> targeting a non-existent VP (or one not yet created) causes a NULL
> pointer dereference and crashes the host.
>=20
> Add a bounds check on lapic_apic_id against MSHV_MAX_VPS and a NULL
> check on the vp pointer before dereferencing.
>=20
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose =
/dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_eventfd.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 5995a62aff8d8..b398e58411dd7 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -169,7 +169,12 @@ static int mshv_try_assert_irq_fast(struct mshv_irqf=
d *irqfd)
>  		return -EOPNOTSUPP;
>  #endif
>=20
> +	if (irq->lapic_apic_id >=3D MSHV_MAX_VPS)
> +		return -EINVAL;

APIC IDs are 8-bit values, and indeed lapic_apic_id is set in
mshv_copy_girq_info() after masking the value with 0xFF. So
this check doesn't do anything. (I guess MSHV_MAX_VPS
could be changed to something smaller than 256, but that
seems highly unlikely.) There is extended destination
id functionality that provides for a 15-bit APIC ID, but I don't
see any support for that in the MSHV code.

> +
>  	vp =3D partition->pt_vp_array[irq->lapic_apic_id];

The APIC ID does *not* equal the Linux CPU number or VP
index in the general case, so this indexing is problematic. APIC
IDs are not dense if the target partition has multiple NUMA
nodes and the number of VPs in a NUMA node is not a power
of 2. In such case, the APIC ID space has gaps. Azure has such
VM sizes, and you can create such a configuration using
the local Hyper-V Manager UI. So having APIC IDs that aren't
dense is a real case.

> +	if (!vp)
> +		return -EINVAL;
>=20
>  	if (!vp->vp_register_page)
>  		return -EOPNOTSUPP;
>=20
>=20


