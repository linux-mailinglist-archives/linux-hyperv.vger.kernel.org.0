Return-Path: <linux-hyperv+bounces-9876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA0AI5lQzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9876-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E751437E67C
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A501030632B0
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326846AEC5;
	Wed,  1 Apr 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FvuidpLi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013087.outbound.protection.outlook.com [52.103.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD340FD8F;
	Wed,  1 Apr 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062650; cv=fail; b=S5Zqz1kV7c4T2d8NmXlDLT+MetddRBMerM5iQOMQjf6lYCz8zrfxh7Lr5PEbmu+DbHh+ujvvXGKIVCNYHbGRmCIu7p4iJDCGDtJF0Sqxjg0vLubf43/GODkvO0vEKz8it8fEc53bzLyTvx5og77A6QZaon4/rpiQXEPZp8RO0ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062650; c=relaxed/simple;
	bh=s4IT5v4fTOtBWBh0+3O/TJ4F75OMXyWwHml6OOpbV4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/uNXVGtzTuBJenPO7m+lF7qGNNMqMLp2fAx/syzt8+XKxI3bpA7y/92jhyQ3cNONg02JGFhau3LsiQgqxqK7dA+BJR0ipmV2ctsXIazeGFpuZV4xzq+IWxdoCwx6ZrSmTJVQDEMwP6rMWpXbS1Q1gW6CEX/I2ROwCx6OwvwUXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FvuidpLi; arc=fail smtp.client-ip=52.103.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcI4YTePnqtmd6ynjl4RSLU4K5fsXsyDG/h0GLFBRbcaUhuQfoNpfQnk7/q31lAeOxzpeRAsFkdVMAVq26uGqzoNfn9mKBPP2uRYned9oefce6ZMeUjP5EHlUqx6GS8heCLljBEG1EO4CpBiKj3PF5MbHp66J2we0+ZGYB4+S8zR1gYtVcQUBtmX2vUm91B0fICPzJjC20ZZCGICrBRTRGgV2UYIAucCb75kLc5YycqvIRmDdlnQ7Xm602yzcwDSk1h5PteqUVZR9xu7YK/2l2a3+nxzd1IYm057TNB8Dzp3VgszoinlybLfwrszKcdCmggdKFbcR6Z2LnNeL2bniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74mvd7LZMAcDSeAdC7b+ehIoANCs0Ks9n4TxOAAWqcU=;
 b=ny3RSnBcwM53EISVHs9Zoab4TrBq6frmErRJi8jvF2u4azaGXmYzpzDwzLm8KSzDQEhvCpjPMrX4KJSNaf2zD88i5No/IRnSHgHpc1ySnh2/UTBZcyIlhz4T/TfNujiLYWG4TUZune5rbTCp+90k1WUt/+NUhZXFf6aFBQjBeMd3hPxpTNKnDGpC8TGk1zOeJcgrgM9QpSj7SHqOBJuhTdOeW28k6hmIc+nz/05PEDzcO/taZeZEsxm6KSJbYsy4GwBDfIaE+4/wCLsSi8I7J3OUEgYP89cfv5Pb2BTb8FKwRfNtqSo2OF0uau/GNc1k6JUlLMCWOR0mh0RLJx4ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74mvd7LZMAcDSeAdC7b+ehIoANCs0Ks9n4TxOAAWqcU=;
 b=FvuidpLiPhHwM7nmOHxEdlT6efq/rSHLM3CdfsG7FyBtmMWrumD005dmR+awbAm7yl03Go3Q/BzDTFrqVzbZ8MU1D2Ts+ljuBF8ZP9cOChGPuh6FBQxi+w5bBwBWJu6OwWjVDUDu8gaJDW7DAzyiYZuvO8IUE+vlQuNv7sHApBcmfsnoTnRsTitBkABuUdEEbPVIucTMY0mhGr2MlSRmj6mtAMNx/znSmWgB4SgDdLGtxfsE2m0d9O4exexBeVDXM81BLoVVEpJiW4HI1UZwo9nyD46N96lRm96PP81ifxC5SxrkWMM1WIqi0jTVRYDggkPm0uBfXfW+vbjBFnJKXw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:57:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:57:24 +0000
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
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Topic: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Index: AQHctT5Uo06CdizxUEmOmS2tUYF/frXKhrvA
Date: Wed, 1 Apr 2026 16:57:23 +0000
Message-ID:
 <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-7-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-7-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 722c0d55-e1ef-4506-2ec0-08de900fbf29
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpoKR1sppEwd13KkOHVgHFJjMLOpZGTol3LaDxO3wdnkdvLSH5/bKJjbnavsMTTPQnuLfvn11SosTknE4UFghDs4e9Fwg48gUKF1+l5gFFM5Mdwzo7uJBu68UHwL938xpxeQcYkuxs88VOs55hgUFIZnn8PmiXqWespket0K0Z6Ze04qaI7V1YCeitl0dScxPBVJNGRw/iCXcB13xBVoJMl0l1myGJEm56v+FEwMwTntJMyqO/pIt2xgKgCzWl6DekAo/woHRSrH/TFrVy1wTy63PMJH/M396ojOd0+XxMYCQOFYl9t8s1FBGwtYNyYmm4Fy8gK06zfswFb/SVcFIGHrV0d/8HT3so1PtIRxGz6DgXKrLsAouhg5JscdZXcKNWr21PsNpmriE/Cq6a5uPnmF+yMtcJTwbG30L5CrtvSHj0hx0e50bXaMfPf7HSn3gugMyG6LMqBTHW2KnDxCcwzQcYk9tJjo04r1+uqxA73NSJWGF7nz36FZMwefXWNYtNgCYq0U+iIWmT7Ce9Meq3Nc9ZoSE/50Y2qAvC7yKIzljn33CDL5mweN3y8F27WKeiL7u52RLZ54UWdqDRIHUhwomQswSJ1Ze9L6nmG+d+aeEDPFO0keQbC5/+7JjJ5uow5ieIhzxrmsJ4DTBR13hjWDgnnUs0tbwEQYSbZtIcZS6RhshJ6OB4tfPrQL0oHqBVDJ14pzgVgWVPSQkJCs13TiehQRt6nSUoNPgVKMNPiObhpAz9ebZHd1znHaxiB/Tg8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|37011999003|31061999003|461199028|51005399006|15080799012|13091999003|440099028|3412199025|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KPxY+P/ztR31KviQcUUUDl7zRYjW70ebrs04F72aem9CvRUQ1Df3X5q5K08p?=
 =?us-ascii?Q?q9HLfog0qYmrX504KXqR45lk44CKTVVPICCCcPUmihYMSsY+3oEx/pByq2gq?=
 =?us-ascii?Q?KlxHWa5nRJHePa2dJ7Nakpj2Mhp0iEPO8EdCli77lT8S9c861OTvE/HLUtEy?=
 =?us-ascii?Q?rlEH+55ca4UoHnyfJbwguwrryRwO+b2kNUA/6Et4q7Ia5hYMJWI3M1VBUVnu?=
 =?us-ascii?Q?gioNH/P9LvfYJ+EUr4hNJgfcygjLbWvLZDjYF73GKVTRFKPDtQnX33sNCR1h?=
 =?us-ascii?Q?YCDP33JIDah9yS5V3NmYUF6lDLfkzUljFmQSrpSs1sW+FFfGbEsErnapDoUw?=
 =?us-ascii?Q?zIytuzCMznUFhwRUNaFCSG0KPwwuC/Hsj8a8EcfunQQvOzRGAsKPFAq8U4Yr?=
 =?us-ascii?Q?nszem1n8MJ3ko4A49PoJLGEu13mzM38m7QzJLbNK9HgBrcAf7Dewq/SBkOXD?=
 =?us-ascii?Q?OvDaFJ3r6c+08PfxApUReAPtQrT3js7nfJtibBVkTa+I8x0A4Ua1Cg8mNLjR?=
 =?us-ascii?Q?E55hzz3jf+/c2WGD7z2kkHwSZWypENd5HnY9vrSemcL8y1Ye7WDHtFJ7AKp0?=
 =?us-ascii?Q?xrWLtiiCEky8c1AJyQXFUB/yXUegUmcOYi5OAxB4AEXXJi/57eKNYWetg1iq?=
 =?us-ascii?Q?dsFMdH87Pq20/53qGiX60eADN6nhHgumwK5R+vMx50M1pDCkm3v92t4zWgGr?=
 =?us-ascii?Q?xmloIOXyGzP32BhwogAyz3prPBEbv+hr/gObnnUroImwvX1+OCQh6ff5pAPG?=
 =?us-ascii?Q?LFOmnHAzabUkW88UOO9OG2iO9D1MVvje/G9oHgx89T/KdZsffUYuhhWo04t9?=
 =?us-ascii?Q?xCWuffQxSj05ONpzyO7cIA6gHUtpoCwxeuJ8kNA3101lsLwry9DeMZazlgQI?=
 =?us-ascii?Q?x7O/DNy1o/uX0h0DoV96pPVC/HPucanvDyk0KOHQ9+T621Io/XvE2YuseEE3?=
 =?us-ascii?Q?oM9ND29/BphgOBvWS5GxFlTfW28cmynF+GMDJp8ba8NKHnuZxq3bthxxwmgW?=
 =?us-ascii?Q?C+7rU0vH2pMIzi7l8m/k+TXF+Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mCjsg02xq/j8BrUIiBUCI0AXRIBIJXmKIqRTDYI6mG6Cgwn+QYfrVL0PEEv7?=
 =?us-ascii?Q?cVlWjX/Ucj3/7eMGBaoRUfM8dYcuXYNLualRKdCPdA5AVqbLySi5KxbxshWb?=
 =?us-ascii?Q?B0LT4mawI3C3JBkreCH6qQ8WjLLSYB9spV/4/pGNyFRo4sCaVf40N3BD4hrV?=
 =?us-ascii?Q?X1ubvJL10AIH50bgXOoHwMjFMiFlUw1+x6XklHhILyyNo9cmurw4bVOu1tOo?=
 =?us-ascii?Q?jSuRXsf5fgrmqm34Ff0eS/qX9dgiMqX/MFT3Ge5yuiJxEQFtZ30Ths4hJAz3?=
 =?us-ascii?Q?T2U6SEVvAPRjCykyvbbvoYD4gYNrhBW4vG97fe/hmAE33RyAqNSVVH9ZcPCd?=
 =?us-ascii?Q?quPfW4fTccl+RnhtJCpk8GIKCidL/JYVt/Y1czVw/N5MP/VF24BsjBY1NEdh?=
 =?us-ascii?Q?pfblEpn1PZeV+KFAGugXHxWZvrnZkSR67YgUEGVIYSXa6XK5Itr6uo+e6LQA?=
 =?us-ascii?Q?e57xq98rFlLFO4gUrdImaqVxOa3E1cfBckbpENNPJf0WXlMGXmJJCpnFHM5k?=
 =?us-ascii?Q?DCBLPLraNz18PI3j1CoxmOniC9AEk7YRihPk22+m7FxDQWC53ZK+mspYbMqw?=
 =?us-ascii?Q?ddRF96nSXWDbb/klfbNUOO1Xn4zR86Ui8pqPSf6vzW1pdMvo9rFEATPe0u91?=
 =?us-ascii?Q?lGaoTUg82n0BTmSaMIGaYeIbp2nvv5DkE3PxnjRuyMi8SjCCSSPcrTzVlMBq?=
 =?us-ascii?Q?9TyJ6zWuoRLYP0rEWfPob3fbvrDp83NftcsI6kiRCvxVZq40OLP6iWKHLg+F?=
 =?us-ascii?Q?R2xIXs9PF00imsQkmbOkCl7KQ5bmX1IY/i1iBc8V0FbyPK5D9kQCMwl4uiVL?=
 =?us-ascii?Q?JfJFDmaPmLt5fGgVTgYJaQFkgiIHIrgzQbvqUDZRrTeXZMXdjIRzJOdF2FPJ?=
 =?us-ascii?Q?bp8N2qh9DXUXX/LO4OaJACIFA0aiytn/vRozcrJCMH29Jx3EG04i8VjxNc3h?=
 =?us-ascii?Q?UtOJFRw/EvX5+jB2TkrMsfLBH+gxBsf62PJxgHYYCL8f8aXfPXRwtkXY6iaJ?=
 =?us-ascii?Q?nJd1GvBxTrKV618N1d+/43cQ4ppIManvktaxcMGADkZo80ZdJ4jE/KhFA925?=
 =?us-ascii?Q?ryI9Bc61zGS0jI1Tu1CBAbsDVTARmiLEWZjIVp1kM86NdvLZ05AefWMwXSn5?=
 =?us-ascii?Q?HF+rH7eEVnm/u8HvMtRVKozN/e6lARYTnWVqC123wfSXGhXRutGmOIl8y3rU?=
 =?us-ascii?Q?wLOBhrhX1qvR0X6MWtDsvFaZIhcwEoarC/GjW5SUvuVyOZ47ccU8Ol+n0a3W?=
 =?us-ascii?Q?nLWM+0oNbZtpaUVJSzfFYaQgoyyZFwRcx/m3hP+MgGYlV1UYvuzRe9rqFNfy?=
 =?us-ascii?Q?usehFwG+1TpgyYHXgijAxY3Gi6Sp2dQHCdSQfBdsfevCLMcTWXpGIk7DDOko?=
 =?us-ascii?Q?L4pdr78=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 722c0d55-e1ef-4506-2ec0-08de900fbf29
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:57:23.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9876-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: E751437E67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Generalize Synthetic interrupt source vector (sint) to use
> vmbus_interrupt variable instead, which automatically takes care of
> architectures where HYPERVISOR_CALLBACK_VECTOR is not present (arm64).

Sashiko AI raised an interesting question about the startup timing --
whether the vmbus_platform_driver_probe() is guaranteed to have
set vmbus_interrupt before the VTL functions below run and use it.
What causes the mshv_vtl.ko module to be loaded, and hence run
mshv_vtl_init()?

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index b607b6e7e121..91517b45d526 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -234,7 +234,7 @@ static void mshv_vtl_synic_enable_regs(unsigned int c=
pu)
>  	union hv_synic_sint sint;
>=20
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D vmbus_interrupt;
>  	sint.masked =3D false;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>=20
> @@ -753,7 +753,7 @@ static void mshv_vtl_synic_mask_vmbus_sint(void *info=
)
>  	const u8 *mask =3D info;
>=20
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D vmbus_interrupt;
>  	sint.masked =3D (*mask !=3D 0);
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>=20
> --
> 2.43.0
>=20

Assuming there's no timing problem vs. the VMBus driver,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

