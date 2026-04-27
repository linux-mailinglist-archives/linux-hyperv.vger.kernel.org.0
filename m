Return-Path: <linux-hyperv+bounces-10381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO05JED27mnT2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10381-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:38:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF76346D41D
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B563009534
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E631AAAA;
	Mon, 27 Apr 2026 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f1+cKhCC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013064.outbound.protection.outlook.com [52.103.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531C34E75A;
	Mon, 27 Apr 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268285; cv=fail; b=mcJ57kLrklPFc2+6nJ6tVgaBP/zSw3EuJtdEbRrdPBEEkEE86l5hrpG0rWT2PoYH6W3gq5IOOLMS03lG9h5xUgiPk7xp9JWHMftqrx6vtmSZGCEb8Cj07tZ5ASAJXURlqQs8nuvW8huhtv/m6Uv3fgar8kGxvuSnqz7LebvZvVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268285; c=relaxed/simple;
	bh=23W1w1jfbpsm6oH+QwPMRRnLpNqdiPDi/RhUGJGk+4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKELsROvU35IsaGP2+q0F0d6JFB/EYSf98hXFYdouvFwPTIyDcaFffp/z0R5dcMOhShWEckeB85zvBal84PEyhOjTw+QFMB52Ho//IGQteP9thOFpOLHJw98iJjIXv8Q9D/YQInksUBQWsXOw+1tj9JvLLWGHaK1ur5a+an2obQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f1+cKhCC; arc=fail smtp.client-ip=52.103.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQEWil3AX6nO8pvkLeNTwsKoIH3/9weZ+Bw/VHJvY/A3lgdi06Sgss/DeCH7VRlukxktdvlsFlETGbsVxsn7HwcWkCD6KDQHw+iA8/VRzFT/LqtgnH7hfphsNzErKD6zmUsZCia1thoulBakrQuLM+m9JH1Jz+c/Ir8+x3VObeSx4kGXBxWnLCoS0aRYylyPzGRx0pDhkdwoOzYGbjRIz1NPRlR4HQeT9j2NMvLqFUGr2Fsa4I3kwc4dlyZmVV05p6PL1YafISWI8+tnVjy5TSWwrTjuYPvtYpEmZZBrqZ6FMftHr1phm9imj14hImqKI3UlAotGoshyLztPYPLTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzNX49s8ma2LUbwHFAK21zBkXpHE3+eG9f2U6d1UHHE=;
 b=nuAVwbTnnjK+MxufumCu6wfMU89T8afwwTdy3SAlF/CKaJ1q4hDa/yMLI74Kuv/fhJmcvKg3FT/JKoYoVK4DV5a+t2eEe1aiJL6PuSrluIqpBMvVN2oS2fj7n5tXEayFZB82V2Gq/zra4o3guy17y0IhVlN9CclDs08sLBEj/wT1U0q8bpVMLchkOiB1E++If7/siySHGVTdYwINCVqO9ZIIn2Qlo/YDoh8nfRIWltPdxZ4lOUlbAWIDkYOJfZOqF4vD83syJJKe4CkII7SUhUY7H5kNUO6eIHLPRluW8TBRzqqUhdPCUyZzAsWTkVSheZHnmoNMgBB43KX0EiC71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzNX49s8ma2LUbwHFAK21zBkXpHE3+eG9f2U6d1UHHE=;
 b=f1+cKhCCxk6Wk5vZ71ErTGzeiBv+Ih3E02ACB9bZtHRo5OATpEnJlWnPhTsiRe3gsJW05qjb+Qi953l46DfvSol9uNrUoYgF1WRHu5f7OzQFplIBPDSL5SHw+zS517HVtVG93YQJZB1SH7JTlO+WnReRj6H5Zo2OxO/msLQ0bJqWILSOJ51K1vZeLPu285TUtudXOqriejB+C/9h6jWn0RrLJGLJZjq+ro8sLx5MNHmu3sze11a6GvpDbS9F7lxJWz2JBO3wzRfpvqpLcLitpsohxcNWsXDgoc670BTwTEJMqBg854vvelSmAT41zmJuAkOYpMPo0d2xDEcxCTqUlg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:38:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:38:00 +0000
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
Subject: RE: [PATCH v2 03/15] Drivers: hv: Move vmbus_handler to common code
Thread-Topic: [PATCH v2 03/15] Drivers: hv: Move vmbus_handler to common code
Thread-Index: AQHc0x6xowCVGOfZ/kaacmAUtH31s7XyacUQ
Date: Mon, 27 Apr 2026 05:38:00 +0000
Message-ID:
 <SN6PR02MB4157E3B0A6F76E4686D8C3E4D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-4-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-4-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: d917da57-ddd5-40d0-3aac-08dea41f250e
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|55001999006|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|56899033|40105399003|440099028|3412199025|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NaKZ/JifPSMsOIShsnHpoTf7nrM66O6E7SfdZ+P5wWvL/ki3sx7/FA4s1hNn?=
 =?us-ascii?Q?EQRvLqHcgvcFedvWyhUjivTN6T+0AyRTWyJIgT+w0BQw4j/HhbTHYtZ3BJZ2?=
 =?us-ascii?Q?pSKffrbmjjT8keZmYI2JiqfkLZauyw29KtxjhDvrUM81qKskCkbu5gbtnyAF?=
 =?us-ascii?Q?fw/ddvRWVhgq43ON6XewzHHBKPb7CKCLyStr4/r4rrqrauVRtsxC4K0rBiGm?=
 =?us-ascii?Q?UBr4STB9HXgTZJmYAfd+/kJqjPeHdcRImtw9GdN+10WB+k9n2BLQLUN2VeFD?=
 =?us-ascii?Q?Ry6/8A8A2gXKdO9gCpYJB00qG6hLJweUkTtAIiJHRQLWVH5PqKJEIyy3hB8v?=
 =?us-ascii?Q?vGQoKE8+seqqPKsWxL2QoatGoU5+BBIes1BIHWNQLRjvLSJZHhSYPA1/vYsW?=
 =?us-ascii?Q?2P18xqkcGL9T144wKv6iukiSjQPgdlME6D0jDbwsNGPbMG+o32Q+GOMNtokj?=
 =?us-ascii?Q?O5Hd2X+0Liu4wwzMzz0h6vzQhN7AlT5KKHe0pA7Ms/+hJ42Q2qdMn5k3ej6D?=
 =?us-ascii?Q?mKBn7utp9AvaZ2OYSZYLEvODl7RGY9uprEaSZot4ueCReD4r6KJCmmO536zT?=
 =?us-ascii?Q?w+UC9M7iqy75rQ8uPnDrAPx4SU6fi24VTqsLZE26e21RTWBSSxlyWFzBFtA/?=
 =?us-ascii?Q?9duXtsszm2hkCykgzWjtHWLhaJ75bfQBtBoPQpJVH+xawksyH8POqAHId2qe?=
 =?us-ascii?Q?aRSS0b4vSJDONGuUFBVuhFVwvRgrco4igQVAjrvGUFQf0XzO0/wNfsGtUIBr?=
 =?us-ascii?Q?zI92AEOYDcqSHfa7RBjhcTLrP3/6aV7bMJlpll+HFna5P5uyP0BQwbO6PAlM?=
 =?us-ascii?Q?zXzc1z65G/ESAoPLvc8jeJ8PgskTzQAFwtbAQ7IfrNM6W3OgQaK1IGNhAjmG?=
 =?us-ascii?Q?WjoZgad6mVEgqAgzTKtmsZ1qIqBj6VeZHw+kYPya1WDW7jRb0lR9eE8eOhq3?=
 =?us-ascii?Q?Aev5O/hWCiMQqb6D4TEdbZIngWijHiEggnxfHndpRFUfnI9uqgunQPhqa8xW?=
 =?us-ascii?Q?myG3zDaxbrciUKMpoVRnbNbG62ATo9BOM/Cl42ZvB7l19ZFSEPPPp49J5yMp?=
 =?us-ascii?Q?RmR4t0FVguGPS6qBVVsENPBBGD6vkeIlfER8f+FBKi51YNk4HGxSba5yDeg9?=
 =?us-ascii?Q?Pd/16UFH7t0Z?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aPWp34m2VTQ9o9KLh/l80OnSBlsf6mYDFD5V28Z5VOmgd5VJVrJ9TXLcuR4l?=
 =?us-ascii?Q?kaZCrS4wHPX/iJ1CF6mt4zo9g3u17Qb9ZLaZoI1hMJ8vTW4wHrfJOZRhmClz?=
 =?us-ascii?Q?oZtZGH9u9t5/dLbmewuNNPabIIdaWY/K+A3GldHY2XfFqdS7m2CedgNji8Wj?=
 =?us-ascii?Q?NHHVwMsMlZp+mnwbYq4eey1FVLAKZcyCVu+wBLIzRQpRZm0RLYJMnNe2Yxkk?=
 =?us-ascii?Q?wWXXtk2nS9ERXjpk5xVGEnLoue44hkvXjAcmPWF4D3Jx3HzhCl0rXEJfHqFH?=
 =?us-ascii?Q?EZT84wWDle7HJkv32JU6lM9Dpx7kDzSyK/q5VmF28eyYQJL2JEMA0wmfU9j2?=
 =?us-ascii?Q?yWxF4mgnKyNU5v8r1yJL+XbV/cpxEFZ/MKWT+9IuRni8pMxLgG7c5ER/NSQo?=
 =?us-ascii?Q?OZ+NJb2sEJqXxGl8o4xxYsMcx08H34eaUXCCE4naV3+z3W/XZTgWmnePfMpN?=
 =?us-ascii?Q?A1eJOogrNFJEFLIXVKOjzsF33V2VMmcJu+OcVK6sg8jPglx7cl3uzI8GD7va?=
 =?us-ascii?Q?/gT9gVB8HDFYbJPCurRDTDVX6o7plSZzoep6EBHJeHcvFP3HWBBHHEy3A3D/?=
 =?us-ascii?Q?EFrrNmaw1hmjaiYqGRxP68eOb9E69Da0gY0/d1FpYwUasAs2qrFgXKzlDZZ5?=
 =?us-ascii?Q?N6yVBnEAUCvLv4EQgLT1z/na9lchN/SBBWqJ18OTL0a/KqljFSqk7m3CnmOa?=
 =?us-ascii?Q?JXALgpVkxJCvwyV05+DZwVHAoL4fvnHLzBIsZciP2IYpUS4KEAJzuFNon01w?=
 =?us-ascii?Q?cidghkLKu8AJAmjUhTeGDKHba94osPkBiwF4SaOWDEmwBHvt46ykUv4RPU9y?=
 =?us-ascii?Q?4sVVu/7HRt6Ir1QU478XPDmCfgpu7uFfnhoHcgNZtXPY4FLQltmXE9/OoynU?=
 =?us-ascii?Q?8NhN8r/LTarbrU+HZG8itseEFG0CQkgx/HpTkqeW9dHDZyfB9SkdDS1oMAr0?=
 =?us-ascii?Q?oNEEwDWCJNY9Un8yblqMDPDwOX+gKf5ddNNdOjD7hcHtPK2tD98UXmHX/KfA?=
 =?us-ascii?Q?J0GP1kkE0N/LmIWljH+eNtnd7T7ajSwvZKgicSOz9HuvZARvpsB/oNiv/dek?=
 =?us-ascii?Q?Kef/wffe58VjepD/2XU3xSyMCKNvixMLiJI2mpnwvh1QP+Cni6ycr4fRA2ru?=
 =?us-ascii?Q?AtM0JwTHqu8c88joRPV6B6bq8gjcie63UZn2dVDTZH2Y1O0ur+BZxC5epB9S?=
 =?us-ascii?Q?nLCJ88KFy75uhKBQZkPIp2VXQYblDSA3GEZYj2QHnq5ny85D4HyhaWQ6+5nJ?=
 =?us-ascii?Q?8dwjL+PAQZjKIbJkmEYLmfaXYZicCgfdx6h7XW8CbAQCgLpkznSOCRaPPBeP?=
 =?us-ascii?Q?quAR6hJV9FQ7gcqor9MPvzCdffVNtfu6WHnzWpuuVPQJD1Ctvu/hoaRdXTql?=
 =?us-ascii?Q?lWDtIuA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d917da57-ddd5-40d0-3aac-08dea41f250e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:38:00.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: EF76346D41D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10381-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> Move the vmbus_handler global variable and hv_setup_vmbus_handler()/
> hv_remove_vmbus_handler() from arch/x86 to drivers/hv/hv_common.c.
>=20
> hv_setup_vmbus_handler() is called unconditionally in vmbus_bus_init()
> and works for both x86 (sysvec handler) and arm64 (vmbus_percpu_isr).
>=20
> This eliminates the need for separate percpu vmbus handler setup
> functions and __weak stubs, that are needed for adding ARM64 support
> in MSHV_VTL driver where we need to set a custom per-cpu vmbus handler.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 12 ------------
>  drivers/hv/hv_common.c         |  9 +++++++--
>  drivers/hv/vmbus_drv.c         | 17 +++++++++--------
>  include/asm-generic/mshyperv.h |  1 +
>  4 files changed, 17 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 89a2eb8a0722..68706ff5880e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -145,7 +145,6 @@ void hv_set_msr(unsigned int reg, u64 value)
>  EXPORT_SYMBOL_GPL(hv_set_msr);
>=20
>  static void (*mshv_handler)(void);
> -static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
>  static void (*hv_crash_handler)(struct pt_regs *regs);
> @@ -172,17 +171,6 @@ void hv_setup_mshv_handler(void (*handler)(void))
>  	mshv_handler =3D handler;
>  }
>=20
> -void hv_setup_vmbus_handler(void (*handler)(void))
> -{
> -	vmbus_handler =3D handler;
> -}
> -
> -void hv_remove_vmbus_handler(void)
> -{
> -	/* We have no way to deallocate the interrupt gate */
> -	vmbus_handler =3D NULL;
> -}
> -
>  /*
>   * Routines to do per-architecture handling of stimer0
>   * interrupts when in Direct Mode
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e8633bc51d56..eb7b0028b45d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -758,13 +758,18 @@ bool __weak hv_isolation_type_tdx(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>=20
> -void __weak hv_setup_vmbus_handler(void (*handler)(void))
> +void (*vmbus_handler)(void);
> +EXPORT_SYMBOL_GPL(vmbus_handler);
> +
> +void hv_setup_vmbus_handler(void (*handler)(void))
>  {
> +	vmbus_handler =3D handler;
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
>=20
> -void __weak hv_remove_vmbus_handler(void)
> +void hv_remove_vmbus_handler(void)
>  {
> +	vmbus_handler =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);

I'd suggest moving hv_setup_vmbus_handler() and
hv_remove_vmbus_handler() above or below the group
of __weak stubs in this source code file. There's a comment
describing the purpose of these __weak functions, and
intermixing these two functions that are no longer __weak
produces something of a jumble.

>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bc4fc1951ae1..052ca8b11cee 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1415,7 +1415,8 @@ EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
>=20
>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>  {
> -	vmbus_isr();
> +	if (vmbus_handler)
> +		vmbus_handler();

Is it necessary to test vmbus_handler first? From what I can
see, it is always set before the per-cpu interrupt is setup.

>  	return IRQ_HANDLED;
>  }
>=20
> @@ -1517,8 +1518,10 @@ static int vmbus_bus_init(void)
>  		vmbus_irq_initialized =3D true;
>  	}
>=20
> +	hv_setup_vmbus_handler(vmbus_isr);
> +
>  	if (vmbus_irq =3D=3D -1) {
> -		hv_setup_vmbus_handler(vmbus_isr);
> +		/* x86: sysvec handler uses vmbus_handler directly */
>  	} else {
>  		ret =3D request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
>  				"Hyper-V VMbus", &vmbus_evt);
> @@ -1553,9 +1556,8 @@ static int vmbus_bus_init(void)
>  	return 0;
>=20
>  err_connect:
> -	if (vmbus_irq =3D=3D -1)
> -		hv_remove_vmbus_handler();
> -	else
> +	hv_remove_vmbus_handler();
> +	if (vmbus_irq !=3D -1)
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);

These operations should be reordered so they are the inverse
of how they are setup.  I.e., free_percpu_irq() first, then remove
the VMBus handler. That's just good standard practice unless
there's a specific reason to do the cleanup ordering differently. In
fact, hv_remove_vmbus_handler() needs to be moved down
to the err_setup label so it's done if request_percpu_irq()
fails.

>  err_setup:
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
> @@ -3026,9 +3028,8 @@ static void __exit vmbus_exit(void)
>  	vmbus_connection.conn_state =3D DISCONNECTED;
>  	hv_stimer_global_cleanup();
>  	vmbus_disconnect();
> -	if (vmbus_irq =3D=3D -1)
> -		hv_remove_vmbus_handler();
> -	else
> +	hv_remove_vmbus_handler();
> +	if (vmbus_irq !=3D -1)
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);

Ordering should be changed here as well so it is the inverse
of how things are set up.

>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
>  		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 2810aa05dc73..db183c8cfb95 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -179,6 +179,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_ver=
sion)
>=20
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>=20
> +extern void (*vmbus_handler)(void);
>  void hv_setup_vmbus_handler(void (*handler)(void));
>  void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
> --
> 2.43.0
>=20


