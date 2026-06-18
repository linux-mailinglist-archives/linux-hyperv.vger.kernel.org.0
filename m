Return-Path: <linux-hyperv+bounces-11636-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHgHNPIuNGp1QwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11636-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:46:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CA6A1FE7
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=dua1+vBT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11636-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11636-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2483037DC6
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531E34E745;
	Thu, 18 Jun 2026 17:45:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011095.outbound.protection.outlook.com [52.103.23.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405E330D35;
	Thu, 18 Jun 2026 17:45:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804752; cv=fail; b=FmOtMz0NuJ4J89do5O+HHsgLf0ewqkVesfmU8r8AAufvQvq+CpaKn4yksSmkdFuer/0XaFyqT5q1KwefPAkKicgZ3Isef7sIi2/wjxCohLUKbck2smkrWxybJVH1Frsx31uvyqX9IYQ2XtMgtAz/0M1VRubfGeX6Mvykfp3L1y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804752; c=relaxed/simple;
	bh=eYFeW3szSgtqZRW/iutPMCBjB2nMwjMhkXi2YdKJFyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mo/zsG/BuxHGVyZtR+R1iUvltkaw47LtDTgQL4HPJZAksqkNiDTd/QnOFIYl7ttrD+3Xh2QikllKWRoRzW9MszS7WcbnFtzk7TcEjcJdZIjLoWv2Ko6GoKVRRkKK/AqZkEYq58F+rRoXQ29Db/cP1T8nfBty1DbSmz8BRyg0aZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dua1+vBT; arc=fail smtp.client-ip=52.103.23.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hneP50YR6YDDhrgtFAbpvuJjvK6Fnftv/xpxym6FJTv+ZEh7YqJHXC+TLB44LBoCbQnyjYBZcOOusGHQYa/+MBtz25r1flKqJRoVb3BBdQUzBQfx+wtjjSvT0Kun/YrbxEdk0BP4SbQm8P0ERGNgNWW9oeIAAE7g13nm7CdrgqM9JiXtQymKKAUyB+cOd4Y5V4AvDOtEEnRIp1BOAILFL9gqCbeA1bzBo2M0fkjFp619BWNz+BYFYI8J+LI0BpI5OimIzuRAlR02Aiz7UoBo9gBFVb1cUG9SHEBmBUPQGyGu+rP7I9+qMrCGpwUK6HII2JM+/MH1oPK8fDyakszmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TygbtODSEar3i6teL2rFv2YakiRuYcDGXtdCltmzc4=;
 b=RsANAsRmStu23/lozJMMAgMLnHKoKoNRJr2xUaozzxyrvVlepgTqhh1KXEIW10PmhlbzJXXaNRg99DtLGLIOBjihjlEWZpyP5XdglpliFjGotdJ3zsFTn7u6iqmRMK5DABsHAOVezCXnGxA5J44eG2M8ZS59hP9El2TX/EwIj9tCEzGFkEj90/EWZQZJ6p/vnFOFhRGPirKgoa5jqUUmLNViEJME8YSs9InkVE0ndf/sbF+jZEmbyBmGVvR9vAmWCIfw1D378cl2XML4kra45xUk5xECabHU548UmpNC+vpxI0X1/H/MphO5JHMKo5MGVSyxX/tI6jXzppWdfr4FNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TygbtODSEar3i6teL2rFv2YakiRuYcDGXtdCltmzc4=;
 b=dua1+vBTY/kerOWsXv1woiKmDK4WgH1GgzVyOpW2dxDxjnjh6/U+hNYgcRMFuqd9A+HioxfYaEn5F+dktR8PfoDX5FqYFte8HEeLF0qpOZf5P12lu6jLueNplJO20tOwt59+v0ifD4mYY7zZsQK6J97bhkN0wvfG1T4sFbrThw2BrWZWbWTHMCMi75VwD0seSpqq7hEX9ZNt03CK/Y32mLfYgFXObpZnZxct2F3rgM5zkykm1IwTlqKNNotMa+C+W7oFw+rSVqKnpa+7RWJxT/p6UfGOIl18Uwm2WkUTYB9YG4wjHXkz2y8Tr18wKsXbrSrjl0X0zD+XZTP7IoVL6w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10791.namprd02.prod.outlook.com (2603:10b6:806:440::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 17:45:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:45:47 +0000
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
Subject: RE: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Thread-Topic: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Thread-Index: AQHc+DtPiPbW/N97YES0Gzl/nsT1VbZEpBwQ
Date: Thu, 18 Jun 2026 17:45:47 +0000
Message-ID:
 <SN6PR02MB4157C9AA6BA2DD14E7697F2BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
 <20260609181030.2378391-2-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260609181030.2378391-2-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10791:EE_
x-ms-office365-filtering-correlation-id: 3f31ca5f-1b7e-4a64-e36b-08decd616e26
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CIf2MSGTwZoeDHz1TOtpKUsczNikK0Bi3Mm4SoDzVfNpaU9g3va/Z1OC2SWsrSOyfHOQuXBPZ5e2j2MQKWrICTAiF+djmNPNVcj5mZUJWYi3VFvjvgsOLUxD5EXVNkE+TE29Tmt+H0/YBP8w8anbDkq6LuIcY+LpNntoyMoWjt31eKBMgSFozKHiVh517HMkEl0W1p8S/Z/NwQ2XkxQYxeJVxTK5C3RubS1omJvrGaeTaat4NVLDnjVEqfWTroZUK9tgfXyoBZAVCXqR/2dgSaa6s8f/G70v+2zsaCS7xsXeHrvpsewG5p2+5hv4u/ZhqCdwaP+HtgzCMED/OcuOTiixWxIvjsfG5+h63jSHNsI7o73NsFNn+ShFHxR+eO/0GnACr5a1pEJV/F+Ghd/ij4bP/sUxXvRmHT/e/JI6Iw9oV1xfx7YOuC6Bk0UHczYsllZtc72Tv0R2MKXXIfzsbxlKVMVZCq07uG/bkzGLwEiEcw05VuiFS9Z+fRGbJ2TocPtsWVI/hvFAVh8O0B+eQN/Hl+/7+Foo3S7rwR62D6RoSNqSGnGAc3OSYu6Ttisun75e7PU6ROm84pUPZtmDaGujDxio9NT6eb0XiaUvjmtvDPYzSB+GkVTPDIXid8AA0dcPQBYiwePhAd3vOnByOPjDQvwk6TgiGxAH4SjCNfoAWyuPdX9dBorZwdZrHAX7TLIJqaVEPlMsVCxrkSRKgFRVfVF27MtB5vxCDlRUNJbJI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|31061999003|8060799015|8062599012|15080799012|19110799012|19101099003|13091999003|51005399006|102099032|40105399003|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gSnCDaNJp9PNoJ6fLEpZpDqiuy6n/c2MMeg3P2wxNvo5JVd3e2KJzbat1OT5?=
 =?us-ascii?Q?5Jl+N6gV+W3UhCVz9ep90ZQT+biGymJZZ54O+ClSVHeTS4TMrJU/6MrttXat?=
 =?us-ascii?Q?Omgxr9P7lElwJAasHpWopiVGGANkVMl96sJUxxeYvBgeqOXR3+GGb1b6V0gb?=
 =?us-ascii?Q?Kj2Ny/eZHvJOShKihwjJWR+RaT6N+jycZdWEc8jPF5b6jTCR1FXUHV0GEwJi?=
 =?us-ascii?Q?l4M/prHiOKCS4P1SQF+wqbzvS0EBUrPubtOCHF1jqtLXXIogDTLHN/Hs0NxM?=
 =?us-ascii?Q?Zqce8WvMhuWu7fKCd+GUPXKQGCgexZjol1N1vjVsj0/OAfcKJSRUqPRtsm7e?=
 =?us-ascii?Q?aqQuJzJQ3sntqQ4lzWLCJAaB/qOU4p/09rM+i57YO3haaXnQLWhkw8A0JDTN?=
 =?us-ascii?Q?XRQ2fmGGWCHWDBV4n1s+pLkuHbWnhEcaW58m+6FaHpSsRnHPvWfY1SR7MXkS?=
 =?us-ascii?Q?lf63nvINBv6XZxSVKGDVfkIgJcn4ENf6qW7Vsejudh7gURrclJI5yAvm8Z9L?=
 =?us-ascii?Q?4Sn6Srt9ZM/XiWPnnRDSe4sY/6a8ZGEGXufpGaj6706xZbuRFmiiJEG/ElQQ?=
 =?us-ascii?Q?tUcPiOmhlS3S61dIhp3VS10ey0lDayXIzqVaoplPcqZUey773lB2ceDupFbx?=
 =?us-ascii?Q?AmvcJnMYv+TiSjGxaN+hxQ3dIR4kGG3pfVgZnEt5UWTAJl96sKu65siXUsCj?=
 =?us-ascii?Q?o8brZ8hJwGw4R8+NMhAkbAOG/lH10zk3Euyi7y1t1Q0D5ykjMCQt/idKQh4m?=
 =?us-ascii?Q?XcaJdFM0u80kiHS9SlelZ8Rmr3huie//niWs4gwNSX6JMCTYYf1SC+TiKcSP?=
 =?us-ascii?Q?ORsIbdAn4YL1kKdaHrkfKgFkAfFa+Wh14CGHB/uNB1lT8wHHG00auvxMmDKX?=
 =?us-ascii?Q?oPv3XdqAV/o4Io6s2yRpfqEZSXI6J53j77L1pYcPZ8cnTf684+hqZ2Wq4h2L?=
 =?us-ascii?Q?ObuGLK6Ykiz3knZ6KPH3npSBCenQSkCYSsKnfh/kFHCqNfBVBkKyn1gBBuyT?=
 =?us-ascii?Q?ErTLnrDRfXKlPzuDznAJR4cxI03ieO7R/wfsSIV8URpGM8IaxISGsqDvBNqS?=
 =?us-ascii?Q?FV402CVN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e3vHKZuaBRvaldSHkr3aV7j0PZJFHzU8+pTpkamxuLwHTxQDAqDtvEXuRsI6?=
 =?us-ascii?Q?MZoM4ozZK1yZkM8/tbegAWZ6ShvDhJE+mnBwoQCrnQdzqcCxb+AMO4MhyCn0?=
 =?us-ascii?Q?4N6It+FetEfr/m2WTcVzSsM2OFXjJf4IoYL4TtBT1um2J8T6UzoIPEzQGpAQ?=
 =?us-ascii?Q?zpMuNeToK3WH8tyVzWkQJj1AdyePo4h9crJ2VeferC2l0PIRsMN33vTkFb72?=
 =?us-ascii?Q?Ejs7GmdcGWdyYLDz2Es/s4WF0+zdmiNcgM0ZmQCLnzpkbF9oo5QyIlc+WzZO?=
 =?us-ascii?Q?lhf2QbGhh5ipPGxi7iAU3Qj2d1eeECotrQjB9B6JOWNN+CsQlJrAOTMKhzCi?=
 =?us-ascii?Q?AT1Pe5VCwouvWEkAZywRzXYX4BdD/t+w+yrGF0E6iM6Mygr6LPNhjHLj1mVm?=
 =?us-ascii?Q?EiajervWtnrkVhSmP1+mBHJEfqEv+4/N/Qtf5dLI4KegQSue+Q1HZwfwouYe?=
 =?us-ascii?Q?bixxNEj420Ofp/MdP1ZdmpRZy0Dni+sxWKmPGAL1Q0OE+JXn4w2tbsfV3eV7?=
 =?us-ascii?Q?8MQM2KefWuoRyRJMSqb05DUNH8ypPstc79brB7V3V9f8U7C2prae+KaR6q2q?=
 =?us-ascii?Q?9Vbi0kwX1l1Ftnw/44COJixnWJyOS0KwiJv4+AkVxHuSanOM3JnRfdDaYV87?=
 =?us-ascii?Q?0GZQj3qTOnZ0SGP8nLNldkk82Yra6rTPQ6XagJyZV1ShgJRxgOuKwg4wO/II?=
 =?us-ascii?Q?sJBk28FQLDhhytTLAto6HYsWHB/ir7XUlsHD/qmnacvL7nrjBcKPXeETAiuo?=
 =?us-ascii?Q?ItoZ3z9dvl11WuB1ReIFkTMDNO+P+xrf2y47SP5WU7LaVO1Xdzz1RXlNJaC3?=
 =?us-ascii?Q?lYNPLizfeFTfxKx7w99DoR1gEZ0lnQ1dPG7o2+3c6zm0nW0y2/+uAkfO/Viw?=
 =?us-ascii?Q?ZDzXb824kbxrN+s1T0cdw8DajKm+FBLciTrs4ajYy1BWoSa037Mrtq70oX4H?=
 =?us-ascii?Q?QGGXWGNOstPYOqLRg3MW8MJiNeZRp6JyBo37726w0QsbnhzWFlO104Ej76FB?=
 =?us-ascii?Q?EC7IDJpfvmbo1htOTe7aoLWDDlqTB4PyOoDNj1HBE5aI5xCL7YMrG+qMMjjR?=
 =?us-ascii?Q?gJ4buztEOXkQiaaz1O60QCac00uw+G8CkFYcdcCjJq7D33E46Ea9Lnfgzl6B?=
 =?us-ascii?Q?kwob3gwd1FZS75b1njECZUpbSbTB8YENStae7K47wQ2qY53CPx6bFt/QhuOw?=
 =?us-ascii?Q?kcApyaPrRyRYwjt0OPZNSbDVOGb/7Q8uOG+LaDzPDwvBnbltiildJcPmdBTb?=
 =?us-ascii?Q?dcCxSZLc8WAD7Jc3wRcSBn/TnVnSPxIxZFHxWdNNc6uTh8WYQCJJBIF0Jmf9?=
 =?us-ascii?Q?XpzKGCAcThbNzgDk0WYpHRH2wqkfbqljA8eoWnHD5WvgB6iJQEaEtwEPOPVD?=
 =?us-ascii?Q?RpT2sNU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f31ca5f-1b7e-4a64-e36b-08decd616e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 17:45:47.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10791
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11636-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7CA6A1FE7

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June 9,=
 2026 11:10 AM
>=20
> Add struct rsi_host_call to rsi_smc.h, which represents the host call
> data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
>=20
> Add rsi_host_call() static inline wrapper in rsi_cmds.h that invokes
> SMC_RSI_HOST_CALL with the physical address of the host call structure.
> This will be used by Hyper-V guest code to route hypercalls through the
> RSI interface when running inside an Arm CCA Realm.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/rsi_cmds.h | 9 +++++++++
>  arch/arm64/include/asm/rsi_smc.h  | 6 ++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/r=
si_cmds.h
> index 2c8763876dfb7..83b4b1f598454 100644
> --- a/arch/arm64/include/asm/rsi_cmds.h
> +++ b/arch/arm64/include/asm/rsi_cmds.h
> @@ -159,4 +159,13 @@ static inline unsigned long
> rsi_attestation_token_continue(phys_addr_t granule,
>  	return res.a0;
>  }
>=20
> +static inline long rsi_host_call(phys_addr_t host_call_struct)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
> +		      &res);
> +	return res.a0;
> +}

For consistent grouping, it seems like this inline function should
be placed after rsi_set_addr_range_state() since it follows the
same pattern. It's a bit different from the token functions.

> +
>  #endif /* __ASM_RSI_CMDS_H */
> diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rs=
i_smc.h
> index e19253f96c940..ffea93340ed7f 100644
> --- a/arch/arm64/include/asm/rsi_smc.h
> +++ b/arch/arm64/include/asm/rsi_smc.h
> @@ -142,6 +142,12 @@ struct realm_config {
>  	 */
>  } __aligned(0x1000);
>=20
> +struct rsi_host_call {
> +	u16 immediate;

I don't see the "immediate" used anywhere in this patch set.
Is it always zero for the Hyper-V use cases?  Just curious ...

> +	u64 gprs[31];
> +} __aligned(256);
> +static_assert(sizeof(struct rsi_host_call) =3D=3D 256);

This struct defines an ABI with the RMM layer, so I'd suggest
adding explicit padding of 6 bytes after the immediate so there's
no implicit dependency on the compiler adding the padding.
Sashiko had the same comment ....

Michael

> +
>  #endif /* __ASSEMBLER__ */
>=20
>  /*
> --
> 2.45.4
>=20


