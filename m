Return-Path: <linux-hyperv+bounces-10380-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Eu/zFyT27mnS2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10380-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:37:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03246D408
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B360300B748
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EFE31AAAA;
	Mon, 27 Apr 2026 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="knJ1HSW8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012038.outbound.protection.outlook.com [52.103.23.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BF40DFA5;
	Mon, 27 Apr 2026 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268255; cv=fail; b=I7DLflqferPXwVMtkZBHhP8NBGJl5F5gPgYU87DP8jtWOCYBPWgs29HVHMfr9H7LCAceHA/qd13Iy4EC7H9VhckG9eaHAfraxb96la7KAEIxHtXLmAjWkVKrSSho9jVB65RY2g58YEY0lzlyghn3tkIaP/m1KGXEpxLgWbYgda8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268255; c=relaxed/simple;
	bh=AIWfjjrebcjYxz8V1L4xyEn4t6nRk6Bb+dkkroUXxVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BwjgW+o5QeLo0fbW+UFp+eVz5UFxFPu+Wkr2WjRgNhsG9WLV+edG9kkFIxulMdiavswsKTVHMGPMUE9uf/UM2Prn6mt7hsD85i3wE7FeCx8h3coWKWtYlH3aDnKPLCX/XiDij8oSKII/FZb9hyz2E4Rwbas55tx9rH8tDpkQKKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=knJ1HSW8; arc=fail smtp.client-ip=52.103.23.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4+cAUuRnqVLXpZWS6koVmua4G09WXiQkdq5FKTRb8DrFwdEiZSffWINbZHE+buBGZFRtb9x8pIdaof3eKKQ4ncS9IpcJANkon0csmcj7udx1guCqqumel1Yc5Q8O/U5hobNwOMCPIUKrQNMyzipNHshIsZLqw1IxuDBqfMMSpa5InJtijNEgoil1hinaBuw5vPByNt5GiuH2nVqjZtW1UqLOrxuXw5RRsbRpVFl/Li/OLCkcvTwVfM/52J6Syb/3hBykD/P3Kr/4CZr+8ch8TbrwVPD0CIOB5vUhL/CynhCFxL4kjqCOFN9UOPfgmDs5YmTnWYbnnhvzG3JWMxo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdEyUmHqpcPNEEz4G6lRZEBsdfRU7rwhcOk1yMh9qnU=;
 b=gtjwSdQVlZaB2LXdjXS/Znk/ccastvAP3TccPNXRAfM7nXVpLMl9kc9D1YVGLXvzRFQqWeSfUfnvLRPLZq92d5mbHooJIvQ+5HhFwK7ywaFWOnc3ff2nicrxU6toRCibjKptfcTEeU1pLjzfI8gx4bNXDK4XxkiglBuSAZD8sA+SDMJL+fA23e1/8qlxDl6gjxJCA2zf127nWr0k2G+jbMJlOezg4WiKKaAahwQ696R6EbWKPZE6zsvPZv6RQ9Svt0VrmXG3Nd71eDv751V78xM3Xy2b9hzR1BpSRHbwIE24x5heBYFqGr/YXfdcolz9wpTg4k+N4465KGl/vgKo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdEyUmHqpcPNEEz4G6lRZEBsdfRU7rwhcOk1yMh9qnU=;
 b=knJ1HSW8mjik6xucWxKpikH/qkCVGS883EdUt+sAQzoVAqFxInGiF2g+iPyMbN9Klw1iwIDWBuE502aFxkBM96JJWHAQwwATUR69YgMiFUyy0U6sbXc/mJYAeMQMYVaC6kBl6Pjhmjw+0CS7Uq0yQ3fmrhVnnMDkLkX+QU8FqUjb/ahrHf7hx0NYfvKrEhIBb/CbA72bRogkLOz3ta2H/BOoPWOtRuEvx9QYpKtHWCNNQYd9VIOfsxlM0MugNj7IjpHp0yDvfBTKGDmBWGsLAnyWCt8CWjM7ysh4zZfeUOdsr0e5FU9ENv96JnYrijZ6jamiH45cJLcEbNaZdkLc/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:37:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:37:29 +0000
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
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 02/15] Drivers: hv: Move hv_vp_assist_page to common
 files
Thread-Topic: [PATCH v2 02/15] Drivers: hv: Move hv_vp_assist_page to common
 files
Thread-Index: AQHc0x6sH7YGHCQdqUepmn1fh9hlT7XyaZnA
Date: Mon, 27 Apr 2026 05:37:28 +0000
Message-ID:
 <SN6PR02MB4157BEAF5480D931C3756B7DD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-3-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: f9428a7f-2245-44f4-eac2-08dea41f122a
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|55001999006|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|19061999003|40105399003|440099028|3412199025|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WBAgu0oJL9dUswrLeppJfhN3Gg9PLbTPuIc6UtVM/SMqTngUWtcVwo1WcbDO?=
 =?us-ascii?Q?WxsuLIfTjDk+ToWfxgghxComzGtnUWKxDA8IeuYvoYOMYcgNpCBfCPfAfAwL?=
 =?us-ascii?Q?cp5VD8NAVDolFYeIoLh9WOSkB37tSo0VMNsWcewvdNSjHMCXtmFQq8oPFGqp?=
 =?us-ascii?Q?66PjG0WS8zaaRiTuvRWl9rbQkO4ZwfBlKEWlHBjfJxTwM3/Wtv6AlV656TIw?=
 =?us-ascii?Q?BMpU6DmMen/LnONocI84DkdB9wyz3IW15PXrtrmxZtJFsUyZL8PMOaUUCZkd?=
 =?us-ascii?Q?x1auOkIer2d7Gy4eblfH9dsVX2HWOpX4B4wc17PKXLwk3bwiDT+nEkDk+Vfq?=
 =?us-ascii?Q?180cBpHFhyl1vW1Zv69FyfNNWRQxXcDjW3iqFCypDljzPM4ELarAmxkAxHPC?=
 =?us-ascii?Q?KM2RaxgacsoyroV9WgrrYv3vAdSMaiNPOy8nsSDKQBGJa6MVJ8eGTwoisoVO?=
 =?us-ascii?Q?HhsXRfLNGwd6dwTnNvbadj77p25HAWuGg5IV/CWkIm80dcW85c15oFpX5dTH?=
 =?us-ascii?Q?ErskhzrhKy9OgGxnRPMUYMcSBJuQ5qVXUkrpsHabeMHJePLD0AEAccYZp6Zi?=
 =?us-ascii?Q?NQG8UaCAJxNMkqNhUhWHB0gRgZ3PiPHd3duoZlXWRgX8zFfkEMzj/D2C6wsX?=
 =?us-ascii?Q?SH0RovmL1y1m2C9ta5LTl4uP63AczKB4Y2diR7zNABljgE7yhZlQajppIp/9?=
 =?us-ascii?Q?x6QQIoP+chZf0qNsjgYG63vl+wrXExpcsKKSYGHmH5VzDMLO5WANrJbZVMXS?=
 =?us-ascii?Q?fmkfbfTzi9LWFiqyJaoTJCbFqnrGi6DimqJGH9JZumwiLtYss98yj3axJ8au?=
 =?us-ascii?Q?34fx+HGeZ9F8G7h1TXkQy4CXehxR5fvXdjeV/1NU3kcIofnCikTFFhoA4ixS?=
 =?us-ascii?Q?IVAOiRibLW7R/884yv/gb8YMgYazCD2NeABSriXXBGig6AiUo5LbVR+qOo/6?=
 =?us-ascii?Q?NqqLasmlg2zkKhnUp+O7Gixi0toa8yVTMpc1MIiljxsXTaXET/ScKgcy4X+f?=
 =?us-ascii?Q?M4D4E2psg/0JlaSaVJckrLaXxJxmQc2e1Ayn7JC/vItWDEACaYQ2IEExvZ5s?=
 =?us-ascii?Q?2MR56y31SceRgcuj8SS2XqH2Cl+rVDGWyW3xwQbxcQQCnNmO4K3LfqaVXLFH?=
 =?us-ascii?Q?mKvMLzqZBO1QCA/nsYe8pP3NjPkZHa7boA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Y4VJTtFNuVYygEs6OQI+oPJ9t0D9J/dLaLvdFeHGV1aKbzM2kYOJzFpGlEy?=
 =?us-ascii?Q?tIyOE690pvRXot+z7rwgE95ZCo7jWKHNYAVZ0NSUikybl4+eE4U3+5+ZllKa?=
 =?us-ascii?Q?OjN+6HRGIm1y/wTLEesG4lyyN+KeZeddBrNhS0WkBlyJZQmFmiztaf3Xb5kM?=
 =?us-ascii?Q?bca0zT+/ma2+LrDdWDVLwxJ6OWyVSHiDg2sqeqaqKuH2SnSLLvGhHd8peLnC?=
 =?us-ascii?Q?m6P6ogbfuCmk8tYle1JKP1dmtAiPTSQ9971k4efIuH41wgN0mVGhmw0YCckk?=
 =?us-ascii?Q?I2c/0deZoCGrFB596oSVzb+qZSvvEw+528VHignWDF3/FVIt4eCJZ8v+EoWE?=
 =?us-ascii?Q?4cIHRxH8PnQwHh4yeIYSweoGP9AKSDXzeGjaFZEACgM928Hw4z3iahNXfeQt?=
 =?us-ascii?Q?3NdumDbUqxY4CCEFXdV42WUfFQhZ2Hf8W4PKE4DR+ud6LGhp0HQGwYo9quqd?=
 =?us-ascii?Q?gMSWEK5BLfo+Y2UGZ6iLbPfLXllggH32bpDstm21IOPYRn+EobRsjgTutFnE?=
 =?us-ascii?Q?zBDx7GKWoMlEGQP6PHVc8IJGIOBX6MqMcH0hgqhq5BNF4NuulVJActcFxCrJ?=
 =?us-ascii?Q?4SWExEws7QLZLWrLwiihULXoBE6Pn7+CzW3PjmyS2IrCJ4/LSXNPluW1Ycz9?=
 =?us-ascii?Q?VXEfWT6t41KzIGIyj0MLpPVvKaprD9kMxRzs6hOTMvG/+wrL/7vkWzNwS6dh?=
 =?us-ascii?Q?oI46WwsJ1kERGa5FcXENV0IJnAte2jdba6EQnjUad2ZKkzJmepMrzAEjpHwD?=
 =?us-ascii?Q?NqCcEC2Hx3Nz39KLVOQoJJda//BfXZI0aTE3wEVjFgqlJEFA51mu+CbEiCV3?=
 =?us-ascii?Q?OrTzeTgid2sXfq+CZ0MNQArwQrAfvgZu1naXAH/R7ZmobCXqhbV1IuybLdhV?=
 =?us-ascii?Q?VGob//2nSmXvuDATcq+SWiTlM1wHhUX7PKysFXXjUdUUYUTigZfOtkfmUbkI?=
 =?us-ascii?Q?3bqYgAcqQ4z7L0J0fzMh9BLAf4HdD8Or1Pucvek6KRkvTP7yikTKT7pWKLdb?=
 =?us-ascii?Q?SOA1VvCZgoof7ZxV++lSvBeWGkvCrRs2w2U6N2uyU/YcsnI/gqeWvUmFsoze?=
 =?us-ascii?Q?SzjNfhn8eogYAWc0e1tKbeL2K9golSQLRtAKZh+zQCrRqkHYCpcSgU4RKmcK?=
 =?us-ascii?Q?pmDh0HjuaweMhI+o3D70aoxUGolk1oTTTBRyXV0Xkbx3EbpIntRko7Wza9p7?=
 =?us-ascii?Q?Fx2kQvEfJvuB3Z8dIFXH1l45UQ/aCHORVpJGfimBo5XknRdKJq6dmTvxZhEc?=
 =?us-ascii?Q?wlUhOC6e1Ribs+tAw1Svs0ePo3pfxR6j+su2QzlsNh9T9P666lOWNtNHkEUh?=
 =?us-ascii?Q?vWRMYUPICFtUQ/pAJ/3p+3uYBnAOs3TBfm8eG2JZ0l04m0i5kHEXjZqFlajT?=
 =?us-ascii?Q?aoHPei4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9428a7f-2245-44f4-eac2-08dea41f122a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:37:28.8796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: BE03246D408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10380-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,mailbox.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> Move the logic to initialize and export hv_vp_assist_page from x86
> architecture code to Hyper-V common code to allow it to be used for
> upcoming arm64 support in MSHV_VTL driver.
> Note: This change also improves error handling - if VP assist page
> allocation fails, hyperv_init() now returns early instead of
> continuing with partial initialization.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Roman Kisel <vdso@mailbox.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       | 88 +-----------------------------
>  arch/x86/include/asm/mshyperv.h | 14 -----
>  drivers/hv/hv_common.c          | 94 ++++++++++++++++++++++++++++++++-
>  include/asm-generic/mshyperv.h  | 16 ++++++
>  include/hyperv/hvgdk_mini.h     |  6 ++-
>  5 files changed, 115 insertions(+), 103 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 323adc93f2dc..75a98b5e451b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -81,9 +81,6 @@ union hv_ghcb * __percpu *hv_ghcb_pg;
>  /* Storage to save the hypercall page temporarily for hibernation */
>  static void *hv_hypercall_pg_saved;
>=20
> -struct hv_vp_assist_page **hv_vp_assist_page;
> -EXPORT_SYMBOL_GPL(hv_vp_assist_page);
> -
>  static int hyperv_init_ghcb(void)
>  {
>  	u64 ghcb_gpa;
> @@ -117,59 +114,12 @@ static int hyperv_init_ghcb(void)
>=20
>  static int hv_cpu_init(unsigned int cpu)
>  {
> -	union hv_vp_assist_msr_contents msr =3D { 0 };
> -	struct hv_vp_assist_page **hvp;
>  	int ret;
>=20
>  	ret =3D hv_common_cpu_init(cpu);
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_vp_assist_page)
> -		return 0;
> -
> -	hvp =3D &hv_vp_assist_page[cpu];
> -	if (hv_root_partition()) {
> -		/*
> -		 * For root partition we get the hypervisor provided VP assist
> -		 * page, instead of allocating a new page.
> -		 */
> -		rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -		*hvp =3D memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> -				PAGE_SIZE, MEMREMAP_WB);
> -	} else {
> -		/*
> -		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> -		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> -		 * out to make sure we always write the EOI MSR in
> -		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> -		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> -		 * case of CPU offlining and the VM will hang.
> -		 */
> -		if (!*hvp) {
> -			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -
> -			/*
> -			 * Hyper-V should never specify a VM that is a Confidential
> -			 * VM and also running in the root partition. Root partition
> -			 * is blocked to run in Confidential VM. So only decrypt assist
> -			 * page in non-root partition here.
> -			 */
> -			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) =
{
> -				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> -				memset(*hvp, 0, PAGE_SIZE);
> -			}
> -		}
> -
> -		if (*hvp)
> -			msr.pfn =3D vmalloc_to_pfn(*hvp);
> -
> -	}
> -	if (!WARN_ON(!(*hvp))) {
> -		msr.enable =3D 1;
> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -	}
> -
>  	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
>  	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
>  		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
> @@ -286,23 +236,6 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> -		union hv_vp_assist_msr_contents msr =3D { 0 };
> -		if (hv_root_partition()) {
> -			/*
> -			 * For root partition the VP assist page is mapped to
> -			 * hypervisor provided page, and thus we unmap the
> -			 * page here and nullify it, so that in future we have
> -			 * correct page address mapped in hv_cpu_init.
> -			 */
> -			memunmap(hv_vp_assist_page[cpu]);
> -			hv_vp_assist_page[cpu] =3D NULL;
> -			rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -			msr.enable =3D 0;
> -		}
> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -	}
> -
>  	if (hv_reenlightenment_cb =3D=3D NULL)
>  		return 0;
>=20
> @@ -460,21 +393,6 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
>=20
> -	/*
> -	 * The VP assist page is useless to a TDX guest: the only use we
> -	 * would have for it is lazy EOI, which can not be used with TDX.
> -	 */
> -	if (hv_isolation_type_tdx())
> -		hv_vp_assist_page =3D NULL;
> -	else
> -		hv_vp_assist_page =3D kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
> -	if (!hv_vp_assist_page) {
> -		ms_hyperv.hints &=3D ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> -
> -		if (!hv_isolation_type_tdx())
> -			goto common_free;
> -	}
> -
>  	if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
>  		/* Negotiate GHCB Version. */
>  		if (!hv_ghcb_negotiate_protocol())
> @@ -483,7 +401,7 @@ void __init hyperv_init(void)
>=20
>  		hv_ghcb_pg =3D alloc_percpu(union hv_ghcb *);
>  		if (!hv_ghcb_pg)
> -			goto free_vp_assist_page;
> +			goto free_ghcb_page;

Seems like this should be "goto common_free". The allocation of
hv_ghcb_pg has failed, so going to a label where hv_ghcb_pg is
freed seems redundant. It works since free_percpu() checks for
a NULL argument, but it's a bit unexpected since the common_free
label is already there.

>  	}
>=20
>  	cpuhp =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:on=
line",
> @@ -613,10 +531,6 @@ void __init hyperv_init(void)
>  	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
> -free_vp_assist_page:
> -	kfree(hv_vp_assist_page);
> -	hv_vp_assist_page =3D NULL;
> -common_free:
>  	hv_common_free();
>  }
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee..95b452387969 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -155,16 +155,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1, u64 input2)
>  	return _hv_do_fast_hypercall16(control, input1, input2);
>  }
>=20
> -extern struct hv_vp_assist_page **hv_vp_assist_page;
> -
> -static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> -{
> -	if (!hv_vp_assist_page)
> -		return NULL;
> -
> -	return hv_vp_assist_page[cpu];
> -}
> -
>  void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
>  void set_hv_tscchange_cb(void (*cb)(void));
> @@ -254,10 +244,6 @@ static inline void hyperv_setup_mmu_ops(void) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
>  static inline void hyperv_stop_tsc_emulation(void) {};
> -static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> -{
> -	return NULL;
> -}
>  static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
>  static inline int hyperv_flush_guest_mapping_range(u64 as,
>  		hyperv_fill_flush_list_func fill_func, void *data)
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac616789..e8633bc51d56 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -28,7 +28,11 @@
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
> +#include <linux/io.h>
> +#include <linux/hyperv.h>
>  #include <hyperv/hvhdk.h>
> +#include <hyperv/hvgdk.h>
>  #include <asm/mshyperv.h>
>=20
>  u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> @@ -78,6 +82,8 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>  u8 * __percpu *hv_synic_eventring_tail;
>  EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
> +struct hv_vp_assist_page **hv_vp_assist_page;
> +EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -92,6 +98,9 @@ void __init hv_common_free(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>  		hv_kmsg_dump_unregister();
>=20
> +	kfree(hv_vp_assist_page);
> +	hv_vp_assist_page =3D NULL;
> +
>  	kfree(hv_vp_index);
>  	hv_vp_index =3D NULL;
>=20
> @@ -394,6 +403,23 @@ int __init hv_common_init(void)
>  	for (i =3D 0; i < nr_cpu_ids; i++)
>  		hv_vp_index[i] =3D VP_INVAL;
>=20
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with TDX.
> +	 */
> +	if (hv_isolation_type_tdx()) {
> +		hv_vp_assist_page =3D NULL;
> +#ifdef CONFIG_X86_64
> +		ms_hyperv.hints &=3D ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> +#endif

I realize that this #ifdef went away for the reason I flagged in v1 of
this patch set, but it's back again for a different reason.

Let me suggest another approach. hv_common_init() is called from
both the x86/64 and arm64 hyperv_init() functions. Immediately after
the call to hv_common_init() in the x86/64 hyperv_init(), test
hv_vp_assist_page for NULL and clear
HV_X64_ENLIGHTENED_VMCS_RECOMMENDED if it is. No #ifdef is
needed, and x86/64 specific hackery stays under arch/x86 instead of
being in common code.

> +	} else {
> +		hv_vp_assist_page =3D kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
> +		if (!hv_vp_assist_page) {
> +			hv_common_free();
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -471,6 +497,8 @@ void __init ms_hyperv_late_init(void)
>=20
>  int hv_common_cpu_init(unsigned int cpu)
>  {
> +	union hv_vp_assist_msr_contents msr =3D { 0 };
> +	struct hv_vp_assist_page **hvp;
>  	void **inputarg, **outputarg;
>  	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
> @@ -539,7 +567,53 @@ int hv_common_cpu_init(unsigned int cpu)
>  						sizeof(u8), flags);
>  		/* No need to unwind any of the above on failure here */
>  		if (unlikely(!*synic_eventring_tail))
> -			ret =3D -ENOMEM;
> +			return -ENOMEM;
> +	}
> +
> +	if (!hv_vp_assist_page)
> +		return ret;
> +
> +	hvp =3D &hv_vp_assist_page[cpu];
> +	if (hv_root_partition()) {
> +		/*
> +		 * For root partition we get the hypervisor provided VP assist
> +		 * page, instead of allocating a new page.
> +		 */
> +		msr.as_uint64 =3D hv_get_msr(HV_MSR_VP_ASSIST_PAGE);
> +		*hvp =3D memremap(msr.pfn << HV_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +				HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> +	} else {
> +		/*
> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +		 * out to make sure that on x86/x64, we always write the EOI MSR in
> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +		 * case of CPU offlining and the VM will hang.
> +		 */
> +		if (!*hvp) {
> +			*hvp =3D __vmalloc(HV_HYP_PAGE_SIZE, flags | __GFP_ZERO);
> +
> +			/*
> +			 * Hyper-V should never specify a VM that is a Confidential
> +			 * VM and also running in the root partition. Root partition
> +			 * is blocked to run in Confidential VM. So only decrypt assist
> +			 * page in non-root partition here.
> +			 */
> +			if (*hvp &&
> +			    !ms_hyperv.paravisor_present &&
> +			    hv_isolation_type_snp()) {
> +				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> +				memset(*hvp, 0, HV_HYP_PAGE_SIZE);
> +			}
> +		}
> +
> +		if (*hvp)
> +			msr.pfn =3D page_to_hvpfn(vmalloc_to_page(*hvp));

Your Patch 0 changelog mentions adding a comment about vmalloc_to_pfn(), wh=
ich
I didn't see anywhere. I'm not sure what that comment would say, so maybe i=
t
became unnecessary.

> +	}
> +	if (!WARN_ON(!(*hvp))) {
> +		msr.enable =3D 1;
> +		hv_set_msr(HV_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
>=20
>  	return ret;
> @@ -566,6 +640,24 @@ int hv_common_cpu_die(unsigned int cpu)
>  		*synic_eventring_tail =3D NULL;
>  	}
>=20
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		union hv_vp_assist_msr_contents msr =3D { 0 };
> +
> +		if (hv_root_partition()) {
> +			/*
> +			 * For root partition the VP assist page is mapped to
> +			 * hypervisor provided page, and thus we unmap the
> +			 * page here and nullify it, so that in future we have
> +			 * correct page address mapped in hv_cpu_init.
> +			 */
> +			memunmap(hv_vp_assist_page[cpu]);
> +			hv_vp_assist_page[cpu] =3D NULL;
> +			msr.as_uint64 =3D hv_get_msr(HV_MSR_VP_ASSIST_PAGE);
> +			msr.enable =3D 0;
> +		}
> +		hv_set_msr(HV_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +	}
> +
>  	return 0;
>  }
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d37b68238c97..2810aa05dc73 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <hyperv/hvhdk.h>
> +#include <hyperv/hvgdk.h>
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> @@ -299,6 +300,16 @@ do { \
>  #define hv_status_debug(status, fmt, ...) \
>  	hv_status_printk(debug, status, fmt, ##__VA_ARGS__)
>=20
> +extern struct hv_vp_assist_page **hv_vp_assist_page;
> +
> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> +{
> +	if (!hv_vp_assist_page)
> +		return NULL;
> +
> +	return hv_vp_assist_page[cpu];
> +}
> +
>  const char *hv_result_to_string(u64 hv_status);
>  int hv_result_to_errno(u64 status);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
> @@ -327,6 +338,11 @@ static inline enum hv_isolation_type hv_get_isolatio=
n_type(void)
>  {
>  	return HV_ISOLATION_TYPE_NONE;
>  }
> +
> +static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_HYPERV */
>=20
>  #if IS_ENABLED(CONFIG_MSHV_ROOT)
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 056ef7b6b360..c72d04cd5ae4 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -149,6 +149,7 @@ struct hv_u128 {
>  #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12

Can this X64 specific definition of the shift be eliminated entirely,
and a single common definition for x86/64 and arm64 be used?
As I understand it, the MSR layout is the same on both architectures.
The one gotcha is that kvm_hv_set_msr() would need to be updated.

HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK defined below isn't
used anywhere, so it could go away too.  (The KVM selftest usage has
its own definition.)

I realize these are changes to a source code file that is derived from
Windows, and I'm not sure of the guidelines for such changes. So maybe
these suggestions have to be ignored ....

>  #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
>  		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
> +#define HV_MSR_VP_ASSIST_PAGE              (HV_X64_MSR_VP_ASSIST_PAGE)

This is the correct file for this #define, but it should be placed down aro=
und
line 1148 or so with the other HV_MSR_* definitions in terms of HV_X64_MSR_=
*

>=20
>  /* Hyper-V Enlightened VMCS version mask in nested features CPUID */
>  #define HV_X64_ENLIGHTENED_VMCS_VERSION		0xff
> @@ -410,6 +411,7 @@ union hv_x64_msr_hypercall_contents {
>  #if defined(CONFIG_ARM64)
>  #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
>  #define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT 12
>  #endif /* CONFIG_ARM64 */
>=20
>  #if defined(CONFIG_X86)
> @@ -1163,6 +1165,8 @@ enum hv_register_name {
>  #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
>  #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>=20
> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT HV_X64_MSR_VP_ASSIST_PAGE_ADDRES=
S_SHIFT
> +
>  #elif defined(CONFIG_ARM64) /* CONFIG_X86 */
>=20
>  #define HV_MSR_CRASH_P0		(HV_REGISTER_GUEST_CRASH_P0)
> @@ -1185,7 +1189,7 @@ enum hv_register_name {
>=20
>  #define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
>  #define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
> -
> +#define HV_MSR_VP_ASSIST_PAGE    (HV_REGISTER_VP_ASSIST_PAGE)

Nit: This definition is slightly mis-aligned. It has spaces where there
should be a tab to match the similar definitions above it.

>  #endif /* CONFIG_ARM64 */
>=20
>  union hv_explicit_suspend_register {
> --
> 2.43.0
>=20


