Return-Path: <linux-hyperv+bounces-9878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VJi/NbNQzWmnbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9878-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB637E68C
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84911313F444
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FB46AEC5;
	Wed,  1 Apr 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P+mEwjVU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010020.outbound.protection.outlook.com [52.103.12.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759C3DCDA2;
	Wed,  1 Apr 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062689; cv=fail; b=GnaoY1p9KXMtud0Zn6yT1RXIDhy/iPvaliAmAVxnCV85KXs8OjmG3gxs0qDgiLVgq/nFs5Wzs1ywiv+sqK7A2OYRop6TNfnjFxl0aalXSkQZvbnmcklYjAmsUjZ2LNkVtbeyhNrI9x7wwTFn+POMa837l46pdxpUu1tXLpXGCHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062689; c=relaxed/simple;
	bh=rSt+BLfmANlALpbxnAvBD1ilkMOGthAShtT2snVO8e0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pRS7A6/dvPnE36QA8KndKNIE0KwqHlifdUlSvORT/pAqqpSmLQ36Rai9YJog5YOwCJEfYtklvgMljTwwXPMwfmmbKA+6ULpMo3fFnvgGXTPKAfJIWxM/7NXYUZEzV2TUImO7ggwlnRrF8NJYQEniu6huYm/0isBO3fC6cV1JsEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P+mEwjVU; arc=fail smtp.client-ip=52.103.12.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDL+rEzqDYC3k+f6niefQH4RGzM4ZwD5UQNyWTOKsyf2AFSHEp7DRPqTOsHbNyfYJH6UwVNxwcaC8iuz0WQNNPjnRRWxTx+p7wJ4xoT+aibvc5CMrPDpL/mlxRMKsV8Rwg6y8hk3njf9R0hVsR+UkUswm8/i6TvnzbcAJaqO31t0LuCt+TDcDrkW7BJ3I/OInsKosf6P3ZDkWGs6Nhofa6Kj7s8OxwnO2o5sVCJBTZXdepox41MgeFWc75w7XAGzm9vcfftgqNTIsPy3Wez3FvbgShJhlAR4YLpMMVNojQdweT+hoDIAluIZTkDtKTRktX/z2jMuAPPUlrExx4HGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c32Kwckkv7QHB8Qci8kisujml1D76Ukxv7nwc0dSrlg=;
 b=YJ+1/QyDaQwMSpoc0bhWxg2m2ZdHYzIv4Dc3GoE3zHg94x2u5ATEf9ysPkkTBVvx9kBvhKKJNG9yDvI5c3wZT8yEgRt2/5VrlclT7IzuUlur5npzt00wK/h3whzFBLi3OmAMVpyCgoLnXN2qzUSePl/GrZBZQeiAQuNyK3OWywYXZl4e76E9M5KzfLx9NHUPQ0PAF5iNosWQJPEn3nVglQnT5Aw62vSx0bRhPy3jteh91ModuBHhxJ6GnTH7ttO0mPNgIPbZJGlatS4ET9NO8yKcYnH0whm2uEmXeS0WQkNh5jr/1HfKatiTVMDcwXI1MicqiabSkk6xyDjzX67F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c32Kwckkv7QHB8Qci8kisujml1D76Ukxv7nwc0dSrlg=;
 b=P+mEwjVUofa0zYY+DAklRjFls1XXTSdW3ls1w0tnGylsUnH5btUOn5aoVBhiPv+lZqxi+c15vasGzKUin2UL5jXssjvs0f0eLxSpCurzYliAK0hs1zA9Hs1M7JHalLHRGKoKTbwV3B+Q7xiZ+/O8iQ0Qd2CUa+Tdmb7rzUGwXj+c60BmO6XA1wZeZBzaCrpEGafo3mwwv31lbSFv4J3lf1MXTmK4RmwId1TFLXPF0yMWCl8e2Be4umyKkOtfmqOk9ns068EysW7CSiXNK9Cfz6wxg0+PbrEJ0JDdujZRUnCMoy1fHSv/0Tc+4hkUow/pMbzBmvNVZzc7gv7C84rMww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:58:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:58:04 +0000
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
Subject: RE: [PATCH 08/11] Drivers: hv: mshv_vtl: Move register page config to
 arch-specific files
Thread-Topic: [PATCH 08/11] Drivers: hv: mshv_vtl: Move register page config
 to arch-specific files
Thread-Index: AQHctT5ddrXGwjQN/UKsejGezZ3YILXKhuoA
Date: Wed, 1 Apr 2026 16:58:04 +0000
Message-ID:
 <SN6PR02MB4157CF364DA2C0CC657A6DCBD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-9-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-9-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 999ef9d2-a147-46b4-ea2d-08de900fd736
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6S6REtdWBhRCAyF2PAii0EZ2S96yU2VqSL/FFPLyEIdZ6VOyyNOdtQBERu+fRFZ4JKVfay2UFLCBCQ/OwZH2Mak0m+YmxO2qk6I65lR3SblXbp0xGS5qd/Tf8vQnj9O6z161DT7uKgjgmFu7Jqz9Zd2JBuGTvZGlkvV9vJHbtKacmbQ2Onvnr/yJnjfIsrNjiY7hat+yep+6OFktdgazn30+j+9hwpnvqXajiPdLXKcEByGtbypOtEaD24C2fyuyVmscTMpF8jBRRiBIg10WH2vhHBAhM9lp6WFzVS+fqmpJq/knCn7qjdGQ5IC0+ZRMb2vnoIuGs+sWT2jUDSjIchSOmAOwz1Q5BRoFB+XhxDfrMlnnOn4mJSrzD95ynYway0jmgapgrdpQoXZr5u9Mw5g85Ecq3G/nU8CtEHiDx5PmpjnDTbIzw35dCZ2F93NWdT58xHly0GDx4PbvCL1QoZ0XswKZChZKUXiBPliABTP7J6fLK1YiCGBI3+qF/cTje6kCLkVOETNRWsrPk7tAR0HnXpivjFfsDvxBeJC0WqVGprZI5EmsOHuOSmFs1btEV9S1FwXtQRwj4m0e0XgJpXWk+uXILePFugwsQqAGXFEt9N6OJhqe8AtkvCvI+YlqfLGNST8n5RRm005KADwNX9rq1mlgB+MnigBaA6bZgA7VWP4UHw9hxOvPHqCPzeUFC6Tbj5UqXLYndmzAWk+HoPhL9khGfFTUCkVcfS0jWh5S0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|12121999013|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|12091999003|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ngcK2p2fx0yYaGnDXvzSkzgUu6F4txrh3KGwJu2om07nEIPqPZI/w2gijANk?=
 =?us-ascii?Q?6LXjw3Va5RbCBoRCyJpqN3WcOmLyea7q9TtX59BITbCYigVs0ywWX8U/bRep?=
 =?us-ascii?Q?k2Dy14rBexkcm1ZLeUL+lNenl0TWPKu4c1p3MonR0hAe8w8/yF9Hnblxwhzn?=
 =?us-ascii?Q?l/PxYr3O8ea2WGyGI67M8/Vi1HpUfoTns/R21NWF3f52F1lBTS5Bw2u883fT?=
 =?us-ascii?Q?F4YMyPiZRMG2jwU8la3jCifX3HmzLbFhHP2yioQmjBPoybCRj4TeYYsaPaS6?=
 =?us-ascii?Q?7wlRYhWIfZvYY0A+r3M3EN75thLBeo2N4Mfnwlpn3FMcDUQP8WdqKqgSUQIv?=
 =?us-ascii?Q?EYyl0avytmZZHmrZcRlgmtMZevPU+ymA21q+HeE/oRqiJV0hc3bUYVw9hEMc?=
 =?us-ascii?Q?IqENSKxviidvu3TsyDXJQ1Ty/zz5zIz23LbKFSxWRh8fwucaL3I4qWQeTYKR?=
 =?us-ascii?Q?yfvmr9G4xGqhpD/y+jNzLyKq/9OBBTJiTjQE3rhXfx3VQ9lIh7eapCXvVu2k?=
 =?us-ascii?Q?dWDp6nfl6Iu+wP4ACghjBvBfq5K0+qsE5Bq2YmXi412mEXEBvX8wL88H3RlF?=
 =?us-ascii?Q?dBPBFZTX96mrrPb4bDRFi7vTS+xxqsYEolkY/+sOERB5wb9MZeIKyOYIf7ZK?=
 =?us-ascii?Q?lKsB0UR/goZdEJ7cZATTS3pf6m2NZY0vVimQLFooVcqK4ciDylzsX2ZRMZWO?=
 =?us-ascii?Q?8oCs1Y1vayXRwA3l9NufMtC+dsGcodFpazTGFAJNboEnfXsGG7I+ghoxzsRA?=
 =?us-ascii?Q?B4xr+iT8gztRnGuWDH/dAl15p0sPlfVvfMaJ/5VXHKbV8/gW/hJ0jEguArCE?=
 =?us-ascii?Q?t/KcZeUaMGhUTtCO8vjSmzXW18qIYWoicWmnQ2NyvXcPLDuMejtE9OGpF+mS?=
 =?us-ascii?Q?hHWMZe+RODM+DVpV2QgS7tPEd9sG4oARLpUuI8PPZqBCH5XfISdEkAKIy0oU?=
 =?us-ascii?Q?NzkoiQQzdneB0j0KceeodvffsKpP8ZFpFdL9UmSAvsR+KE55OKO1nXcay3aT?=
 =?us-ascii?Q?rxU8lx5boiZArEzqTck2hjtKVJQzD462i8RudfAeLCeW+BZKJzhUBJALg2Ty?=
 =?us-ascii?Q?bfC7TE/JnTC5LFjOSjTC+7jbzdu1NUJy3axk5huMpkEoexMIZhEa/ugYKgyC?=
 =?us-ascii?Q?7y2m6iMX71tU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ygruX8XNLxN+ZlKyMjUqTkZhRVgE7khihumUhA1f8E/yx9AsgR32V92GAIrZ?=
 =?us-ascii?Q?Dxl4JcnCkG5UKvZQvIqGulENpj6pCd1gJ6mSHnmmPFLflBfQV17HiWI+S7Ji?=
 =?us-ascii?Q?1Fbq0X4h0WNnhIq3gqssvxZiNtAnkQeTxvZS3qR8eb8D/QaNfMPl7q5DgE8Z?=
 =?us-ascii?Q?urRG9HIx6df6ZZSonWrzxdr00husdYnzC/uJJppSXXU2qeqmoRXvdbhSX7tp?=
 =?us-ascii?Q?br33j1Wb5ynsTd74h35x+KyBwmfdKz8njIcBBjlfKoN6jyfYw2/5p4YPl6FY?=
 =?us-ascii?Q?0gYmneFy8jufrjiJMqvR8V/ykQbuyz15fGV/bP7BlOEOZ8yevC6yG2USltLE?=
 =?us-ascii?Q?aaWoU0djkcUUz/DZt8Zd/rtxLO0wLBi0n3sTdoizc5bDMvIt5+YeNBn2/r5G?=
 =?us-ascii?Q?xjlkx4Pds9ablqVBNH7WjpR5gtQ6AMZWiazURc6YYLtWSBEgpe8j876fF47y?=
 =?us-ascii?Q?gUOZ7KP27XXmlXGRwUKq25qofZPp70pznrsEHmaBSWxlRUqYt3BPVlPdKvqD?=
 =?us-ascii?Q?3XebRHsVAS+R0U/JEuL2DqJW2vGnv7M9TQzKbWx5yaaEZ4ZRgllQqw5sHFCQ?=
 =?us-ascii?Q?vQ/eSeTnhpMbOWVC8in+NRE69OIrYhdMj77VH3+2IzUBYuRkJ4Er9W5inm95?=
 =?us-ascii?Q?nHHmPHh5YO+XkD5MToBvF5MFOC8m1pc9mU10Z1+vS/PMn1iNRz4HEirrZsMf?=
 =?us-ascii?Q?rLo+lB9w5SSPcu6jErxfz6cxAmTecLiqVorTPUmUcMZOBpb+pOA2QGef1aeN?=
 =?us-ascii?Q?ouWOoMZWo2lIYdceUKYGw3aZuV6QTQztepNXUcit8RPL8la5vd9+yUYGSipo?=
 =?us-ascii?Q?EV/Mb+oG11RuBUJPwmeBcZktal4SDGO+5260jxgcD+39wuEhiRsXsRet1XAb?=
 =?us-ascii?Q?hSElXG6i55tOgMclU1e97hkkZ02uM3I66kAbOCJZJJ7IjSXUKgekMm7c9zgg?=
 =?us-ascii?Q?hCoF2W2IX5zjdL3r4LBrrn3CxvpDUVzhMwriLixy1vrAIVHhaiYwX4IQKxka?=
 =?us-ascii?Q?plFeUNHgOlY/NqB9bC/KPMZtR4qqDaCsvGVvRVyz9qVNmWww8Po+LCsqKArH?=
 =?us-ascii?Q?hC+y3Qa4InV+LP7GuXkrjF+GPpG1ezUkQiiynUPQGqMYEcUOtvskBXvO1yRY?=
 =?us-ascii?Q?35/Q1ilbjvZiFp5WMiRXzMBsZP2u0oy17TSXKwo+wRWlytwE1qkAynz8zHS4?=
 =?us-ascii?Q?ABzZbA9ia4k/NKyBhnhxhWuYYFgh78WVC08drUyjiZEXPkZAFvfa5U9BoZwa?=
 =?us-ascii?Q?fY/lhjrOBg+DFQBntUPiXBQNIkVeWhY9ZsND1M9UecKaxUNfJ7ZppAg13qA8?=
 =?us-ascii?Q?Wxyrzjb1eilW0KYQL5NgxPgnifyQQktFExDKstzvWgVp2p9dP1g1DbS+SlBe?=
 =?us-ascii?Q?nXjUlLI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 999ef9d2-a147-46b4-ea2d-08de900fd736
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:58:04.2631
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
	TAGGED_FROM(0.00)[bounces-9878-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,reg_assoc.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 63BB637E68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Move mshv_vtl_configure_reg_page() implementation from
> drivers/hv/mshv_vtl_main.c to arch-specific files:
> - arch/x86/hyperv/hv_vtl.c: full implementation with register page setup
> - arch/arm64/hyperv/hv_vtl.c: stub implementation (unsupported)
>=20
> Move common type definitions to include/asm-generic/mshyperv.h:
> - struct mshv_vtl_per_cpu
> - union hv_synic_overlay_page_msr
>=20
> Move hv_call_get_vp_registers() and hv_call_set_vp_registers()
> declarations to include/asm-generic/mshyperv.h since these functions
> are used by multiple modules.
>=20
> While at it, remove the unnecessary stub implementations in #else
> case for mshv_vtl_return* functions in arch/x86/include/asm/mshyperv.h.

Seems like this patch is doing multiple things. The reg page configuration
changes are more substantial and should probably be in a patch by
themselves. The other changes are more trivial and maybe are OK
grouped into a single patch, but you could also consider breaking them
out.

>=20
> This is essential for adding support for ARM64 in MSHV_VTL.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_vtl.c        |  8 +++++
>  arch/arm64/include/asm/mshyperv.h |  3 ++
>  arch/x86/hyperv/hv_vtl.c          | 32 ++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  7 ++---
>  drivers/hv/mshv.h                 |  8 -----
>  drivers/hv/mshv_vtl_main.c        | 49 +++----------------------------
>  include/asm-generic/mshyperv.h    | 42 ++++++++++++++++++++++++++
>  7 files changed, 92 insertions(+), 57 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> index 66318672c242..d699138427c1 100644
> --- a/arch/arm64/hyperv/hv_vtl.c
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -10,6 +10,7 @@
>  #include <asm/boot.h>
>  #include <asm/mshyperv.h>
>  #include <asm/cpu_ops.h>
> +#include <linux/export.h>
>=20
>  void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
>  {
> @@ -142,3 +143,10 @@ void mshv_vtl_return_call(struct mshv_vtl_cpu_contex=
t *vtl0)
>  		"v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
>  }
>  EXPORT_SYMBOL(mshv_vtl_return_call);
> +
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
> +{
> +	pr_debug("Register page not supported on ARM64\n");
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index de7f3a41a8ea..36803f0386cc 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -61,6 +61,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int re=
g)
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
>=20
> +struct mshv_vtl_per_cpu;
> +
>  struct mshv_vtl_cpu_context {
>  /*
>   * NOTE: x18 is managed by the hypervisor. It won't be reloaded from thi=
s array.
> @@ -82,6 +84,7 @@ static inline int hv_vtl_get_set_reg(struct hv_register=
_assoc *regs,
> bool set, u
>  }
>=20
>  void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);

I think this declaration could be added in asm-generic/mshyperv.h so that i=
t
is shared by x86 and arm64. That also obviates the need for the forward
ref to struct mshv_vtl_per_cpu that you've added here.

>  #endif
>=20
>  #include <asm-generic/mshyperv.h>
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 72a0bb4ae0c7..ede290985d41 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -20,6 +20,7 @@
>  #include <uapi/asm/mtrr.h>
>  #include <asm/debugreg.h>
>  #include <linux/export.h>
> +#include <linux/hyperv.h>
>  #include <../kernel/smpboot.h>
>  #include "../../kernel/fpu/legacy.h"
>=20
> @@ -259,6 +260,37 @@ int __init hv_vtl_early_init(void)
>  	return 0;
>  }
>=20
> +static const union hv_input_vtl input_vtl_zero;
> +
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu)
> +{
> +	struct hv_register_assoc reg_assoc =3D {};
> +	union hv_synic_overlay_page_msr overlay =3D {};
> +	struct page *reg_page;
> +
> +	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return false;
> +	}
> +
> +	overlay.enabled =3D 1;
> +	overlay.pfn =3D page_to_hvpfn(reg_page);
> +	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 =3D overlay.as_uint64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> +				     1, input_vtl_zero, &reg_assoc)) {
> +		WARN(1, "failed to setup register page\n");
> +		__free_page(reg_page);
> +		return false;
> +	}
> +
> +	per_cpu->reg_page =3D reg_page;
> +	return true;

As Sashiko AI noted, the memory allocated for the reg_page never gets freed=
.

> +}
> +EXPORT_SYMBOL_GPL(hv_vtl_configure_reg_page);
> +
>  DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>=20
>  void mshv_vtl_return_call_init(u64 vtl_return_offset)
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index d5355a5b7517..d592fea49cdb 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -271,6 +271,8 @@ static inline u64 hv_get_non_nested_msr(unsigned int =
reg) {
> return 0; }
>  static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
>  #endif /* CONFIG_HYPERV */
>=20
> +struct mshv_vtl_per_cpu;
> +
>  struct mshv_vtl_cpu_context {
>  	union {
>  		struct {
> @@ -305,13 +307,10 @@ void mshv_vtl_return_call_init(u64 vtl_return_offse=
t);
>  void mshv_vtl_return_hypercall(void);
>  void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>  int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u64 sha=
red);
> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);

Same as for arm64. Add a shared declaration in asm-generic/mshyperv.h.

>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
>  static inline int __init hv_vtl_early_init(void) { return 0; }
> -static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl=
0) {}
> -static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
> -static inline void mshv_vtl_return_hypercall(void) {}
> -static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *v=
tl0) {}
>  #endif
>=20
>  #include <asm-generic/mshyperv.h>
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> index d4813df92b9c..0fcb7f9ba6a9 100644
> --- a/drivers/hv/mshv.h
> +++ b/drivers/hv/mshv.h
> @@ -14,14 +14,6 @@
>  	memchr_inv(&((STRUCT).MEMBER), \
>  		   0, sizeof_field(typeof(STRUCT), MEMBER))
>=20
> -int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> -			     union hv_input_vtl input_vtl,
> -			     struct hv_register_assoc *registers);
> -
> -int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> -			     union hv_input_vtl input_vtl,
> -			     struct hv_register_assoc *registers);
> -
>  int hv_call_get_partition_property(u64 partition_id, u64 property_code,
>  				   u64 *property_value);
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 91517b45d526..c79d24317b8e 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -78,21 +78,6 @@ struct mshv_vtl {
>  	u64 id;
>  };
>=20
> -struct mshv_vtl_per_cpu {
> -	struct mshv_vtl_run *run;
> -	struct page *reg_page;
> -};
> -
> -/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> -union hv_synic_overlay_page_msr {
> -	u64 as_uint64;
> -	struct {
> -		u64 enabled: 1;
> -		u64 reserved: 11;
> -		u64 pfn: 52;
> -	} __packed;
> -};
> -
>  static struct mutex mshv_vtl_poll_file_lock;
>  static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
>  static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> @@ -201,34 +186,6 @@ static struct page *mshv_vtl_cpu_reg_page(int cpu)
>  	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
>  }
>=20
> -static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu=
)
> -{
> -	struct hv_register_assoc reg_assoc =3D {};
> -	union hv_synic_overlay_page_msr overlay =3D {};
> -	struct page *reg_page;
> -
> -	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL);
> -	if (!reg_page) {
> -		WARN(1, "failed to allocate register page\n");
> -		return;
> -	}
> -
> -	overlay.enabled =3D 1;
> -	overlay.pfn =3D page_to_hvpfn(reg_page);
> -	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> -	reg_assoc.value.reg64 =3D overlay.as_uint64;
> -
> -	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> -				     1, input_vtl_zero, &reg_assoc)) {
> -		WARN(1, "failed to setup register page\n");
> -		__free_page(reg_page);
> -		return;
> -	}
> -
> -	per_cpu->reg_page =3D reg_page;
> -	mshv_has_reg_page =3D true;
> -}
> -
>  static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
> @@ -329,8 +286,10 @@ static int mshv_vtl_alloc_context(unsigned int cpu)
>  	if (!per_cpu->run)
>  		return -ENOMEM;
>=20
> -	if (mshv_vsm_capabilities.intercept_page_available)
> -		mshv_vtl_configure_reg_page(per_cpu);
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		if (hv_vtl_configure_reg_page(per_cpu))
> +			mshv_has_reg_page =3D true;

As Sashiko AI noted, it doesn't work to use the global mshv_has_reg_page
to indicate the success of configuring the reg page, which is a per-cpu
operation. But this bug existed before this patch set, so maybe it should
be fixed as a preliminary patch.

> +	}
>=20
>  	mshv_vtl_synic_enable_regs(cpu);
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index b147a12085e4..b53fcc071596 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -383,8 +383,50 @@ static inline int hv_deposit_memory(u64 partition_id=
, u64 status)
>  	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>  }
>=20
> +#if IS_ENABLED(CONFIG_MSHV_ROOT) || IS_ENABLED(CONFIG_MSHV_VTL)
> +int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +
> +int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +#else
> +static inline int hv_call_get_vp_registers(u32 vp_index, u64 partition_i=
d,
> +					   u16 count,
> +					   union hv_input_vtl input_vtl,
> +					   struct hv_register_assoc *registers)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int hv_call_set_vp_registers(u32 vp_index, u64 partition_i=
d,
> +					   u16 count,
> +					   union hv_input_vtl input_vtl,
> +					   struct hv_register_assoc *registers)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
> +
>  #define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
> +
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> +union hv_synic_overlay_page_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	} __packed;
> +};
> +
>  u8 __init get_vtl(void);
>  #else
>  static inline u8 get_vtl(void) { return 0; }
> --
> 2.43.0
>=20

Sashiko AI noted another existing bug in mshv_vtl_init(), which is that
the error path does kfree(mem_dev) when it should do
put_device(mem_dev).  See the comment in the header of
device_initialize().


