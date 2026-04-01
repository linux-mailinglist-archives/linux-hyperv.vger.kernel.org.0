Return-Path: <linux-hyperv+bounces-9879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEhvNztSzWmnbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9879-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:13:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABF37E782
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3EE3146131
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC333DCDA2;
	Wed,  1 Apr 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aVo4R0ik"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013089.outbound.protection.outlook.com [52.103.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5632BCF46;
	Wed,  1 Apr 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062707; cv=fail; b=dv5orEco2NUcKnG15mO923DkhkxrzsBWe5Fn+td1OIls8J/IPZ4WV4Zwj28nBLqmoZ8E11d4UlZhvmN8ikHbm7zPttP+9KanwbbcoXbc2jWRjzySAML3fa3jk7WOwS1PmU3yJxHrBAvWWWCNDSPnT1/eeGlYy52VgF/bDba+X8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062707; c=relaxed/simple;
	bh=yuAtJovJWKZ+rZ+v/ZTdwxurFUPUC5cpz7GEMGP9CxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EjvR2TKvQMbQuD+vCsduqlqFgmTdMQ2yb7eUXRyTfywN4dlo+fo9nLhxFYD7IypWBDCzGXm0/OOqLzD1hvkd8kTPMimF5WURoy8Eswdxv07zf1+7Cx0XFF1ifTWgdrxFkWccph1daijWWFy+xdmSBkutc4zCn5NVomg8AiKbbMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aVo4R0ik; arc=fail smtp.client-ip=52.103.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuB+QqqZQsYboOPmVYSjL7twTHSJJ+IIpemPrTl01rzqc7OQvwiM0NZ9HRt2fqCPYT+lgTFmGXtIa1JFS0XvBoFkeZ7a9/XJQd0OpjRZ/QxSYyDPC+5QjMo6b9uLzoEfGqTTYOgk5GqBJpPvA+FWyvohRbbrbIIbbzvKr3q2mkiv63Q0VNjolyzY9oEoGg8ZhZp6wCS68qk3aaX5CxpgCUT2jRUINZc3QqqWj7RpWGXI38F4j5dRRLQqmMTLMNwqy7585XfOOI13H37DGq6tmZMCSd+j2amy7WPLg/akTWFacZbkGBkWdbzOvXR/8Ogi5yhmS14osko5evn0BAPuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XP0UhU66pcu5R6KZYi6JQ+2Wq0BDQGrF3vDCj6anEg=;
 b=B5zIoOs0sgLVCuuxDZWbnfLpIplXwQAQfhff0HA3VG64HFwyNU/SB3c0gztggUOy1yrdtqFw5UFjPI9l/AM5MUy/tWQXiEfNvkE/rXseuxyni3+ik3gcPFRq/COWOlCkAb9UxUk9oanxcsDU2G+mpyGGqsqlaW9L6vvTEtMm0pkYGyheP2dXP4qLpj87kkDEZlIVhEJZoERnT4BJJEueqmAVIH3vYBFHwPtaBH16le8IN2dNPR+n1fAXwIUyt23qyHjB5+tlGj9HsdSanENwacuVAw+M7pxSh2fzLykqjNHh0ujnH7zPGeGVZog/WIjsS4PIEt57U/lVkqYjO4EyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XP0UhU66pcu5R6KZYi6JQ+2Wq0BDQGrF3vDCj6anEg=;
 b=aVo4R0ikwy8guZrj0S8UXSo0B+RULCrUHgfOwJ3Qb5c/PSFTziD54iWd+xcfEFjrnJlL4EHpHxiUoMq5pOru52SLgkowfvN9KBT/1W9DqY8cMMjTch4WVUKYTfIcGhJZIQgGnA4krKbdTS4AgZ3LI3TsTzRhFGOxCI8CJBry1w60XoyIQn9xly6TjkKhR/SzZqDS4RGMs2CUS401PoIXnnqHrQ3MRZzIVCGjhAyMcQyunBgeIjxTL3QmF0PCnbexBvxnP16y6vZftIJW3Z9CMb1mZgcnM1UBD0Y0HMJkuY5p4S6gmAx23PopUlIgxryKAGDEw2zVXhCLA4kfi7sI+Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:58:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:58:23 +0000
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
Subject: RE: [PATCH 09/11] Drivers: hv: mshv_vtl: Let userspace do VSM
 configuration
Thread-Topic: [PATCH 09/11] Drivers: hv: mshv_vtl: Let userspace do VSM
 configuration
Thread-Index: AQHctT5i3U2OtQnFDEytxm9/+5T5w7XKhwGw
Date: Wed, 1 Apr 2026 16:58:22 +0000
Message-ID:
 <SN6PR02MB4157392C04E0CF830257EF47D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-10-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-10-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 3460cf34-f360-4c56-5371-08de900fe256
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmnDmlsl/vneQbmorDq9Hf2dotiaGsq3z/UPhey1xJFBaLUMvKAoOaXB1U+3TvMt+fWP26utdVQE2TYZ0C+Xf2Xtmey5cUtc1GFfed1ntjcKuXtUnBTTo//RkKZ362YHQPKkWDAKv7A2yCpSDBiyOkHv8hHokJueNIj9ofNxkiAXrLt4xw26ycm4r3vHpk7eyd1UBpSiKTXGloGiCxFKF2q3InM22wIaeR13+3xbfNxECOtRNFT66EO0sut0uiMbODj2aOBG+7b1W2po1+zpY7vHZDgplacIpcGcXlP07RhhiggKzVFu/ZQa72A25YbqLzxNj3LEeW/0KRBgVW6vVZrU4pJXT3ogmf3WM9qRGINYErxOwNSLNoKf2Qmb85sdvdiVyxhw2CyBHExakFEy9nXzGZsifGaVYonGG7HKZkRUSag65AlIamAqlUz8uP3YH4orHoQ0efqnyJt+g8ojoD8B5PcKZGZ41qwO5Q2X+JCWpzhtQS2KvF6zPMRdx5zh53d2s37ksvZi2iJd1wCJ4hx9LyYtBL4Qq/fpdyWN2M+bmH7KjF9OM3tEoz5UIt7H6nSlCz9pgw15YRGHnabyhqYxbr96TEV7gUB8KzHfDqSN61+e/SZVmr8RK1m3Arh9w/R1Ur+YW5B22fe1GDTk9HNEHN6iSltMH6V1SArsI8iMVyHlSvGyQcUQNiHnCRc4hEx/UA6pBNKlRvAHSVnOaHcocW2fUwptLk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|12091999003|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X/yfeZiB3ynPYVbb3w+4gqMEAEoPJjU57Zs2P9zluQJGWcIuqvyOR+YKHeKc?=
 =?us-ascii?Q?3742Tgx43wdKwq2PSOqOHUobH+R9pOEaqhvFaaEvIlpphH963yRox7CFx1w2?=
 =?us-ascii?Q?/otwe+ysG4sF8SsAuCL8Xt92tVcbOMTCKfq/v70xhVOOV2fR3MOkrXumpBFP?=
 =?us-ascii?Q?Oj1MUaylmKF4/oFFPtDXujqxQvC1hVVe9//b0ny/zm/+RvIEWwazrTB4fGyq?=
 =?us-ascii?Q?n21iaIGVg1rCD5oeiAW0tH0+AKOJGpAdoGpWZgcexZGMZVqwQJgR+ePCtgka?=
 =?us-ascii?Q?K467wd4Lq7NTaU3mD0TxTlV/fuSyhgJl6xh+3LG262QbDr9qgIlY/b592Q+7?=
 =?us-ascii?Q?VekDA9Vc4+O43UaUYFoIJH/kDKtbFJIRDCGaWJX+oRbEYIolVETk6inYxiib?=
 =?us-ascii?Q?QPPHivimMe9MN4sMfIega2E4Xqx3C51y1/sbpEQlynLmdcjOh/rAuPCjVeB6?=
 =?us-ascii?Q?TgN3UMccJSWfoOoMTjUOnv0Hv9QUQIAubCIoDbv47z/Xy+rEjDHvBxFszHSo?=
 =?us-ascii?Q?1keEopGiPAkBeo4MMgv04Nszvm72+0TsqDPHIkY7wjel0Pxdf73OH0w/Ybu+?=
 =?us-ascii?Q?DvKeB11MgObyu5e515qTPjVF5EnfqycE3XTX+qeQQjHOLM+z/5+niAkc1qyX?=
 =?us-ascii?Q?FmkZ42b1mfVM94pho+8xtkF71MfSh+sMu25SbI3PhxZ5Le8gLxIb2Q1XOcgq?=
 =?us-ascii?Q?Aafkmhdhoj8oNZ98SNEhA6WwAW6sH8iZbDbwcYY85LkvYkb04UvXGmINrgdh?=
 =?us-ascii?Q?8aJKeDa5+R5wJQAi47/XS+ErpG0okjcaqR8OvcBuA9DAXzuPz4UmbyAj7e09?=
 =?us-ascii?Q?1Em5ATHhcBNDTcmJfHanlZmBcuR7VhANs8I87vybohhSdQmZV204hnF/Oaf5?=
 =?us-ascii?Q?6G5Y9NQkHxIx8XDshGyA4bukD5qz9Vots48VqlqLRMmsaOYZVE9CTvOEd2kf?=
 =?us-ascii?Q?trx24dIZV25f29MuZlRJEhT8j/cLe0wEYpvw8Ve2N2Ol+F3oV3hfoERGhu+O?=
 =?us-ascii?Q?4d7qFxGXtlFea6O+JujE1Zbd9u1ztlhQEDR6Bjs5WB3caM0/ABez4l8VJLWb?=
 =?us-ascii?Q?A4wiSjYHqOYDStUbR7ONkTK6UR9+eg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uM1TZN6EKyZXhJ4MULPlFRBkRXglDExsuCPPh8cZzVBtHkCLAlbcTSNDa573?=
 =?us-ascii?Q?EQc4hAgiCNe/UmMfCwp3LK0gAy9SFKYe9ROQUp9a+FAmVhPoxAgi+vJYd5rO?=
 =?us-ascii?Q?LHWcv3jaf5zWpJRZgPDud2XdrNuD4vYQxr+MfnrvFdelDP+49ZkCr1zBqnl+?=
 =?us-ascii?Q?+irtdlZNIjTEjilE77JZ4hULLjNg2UJI2WDMFnQTO+uYs6wpg0tqARvDzev5?=
 =?us-ascii?Q?DFfLxDFyXfWcNH97jOPvq41hK25LNOShLOpMlvcHK5HKFeUuivRJnCn9RxPc?=
 =?us-ascii?Q?sD7hb+VGiSW0emcd8SfX2nPPCuigcVk6tnX3G5iHPoiHhHHtabrR0lJHlHc0?=
 =?us-ascii?Q?AUd6ylH+bNUuiZ61vwoRTEWXxVSEVdDNyxJzQjMxD7rHzTsgjPuVGx0qnwoT?=
 =?us-ascii?Q?awyTLNsMEnDN5ggGT4oPHdgQwYK9lsVLr1Od2dhDYii8fl6ae1jbAsMqfcli?=
 =?us-ascii?Q?yv+Fy3t9TfeuSwc10mWgo3um/xm1x2DKrFvlI+A++bMG2g1riGDy/aGWBCUQ?=
 =?us-ascii?Q?vRKM+AuijsMso0sXWs26qrs4++j+WjYLT/dXI08Zd+F9ujE08irZ9bZAtKYC?=
 =?us-ascii?Q?ytjE4AS+WioQDhi4zJoT6SUNrQpdaKseH6pX+r8obcM23XKRT6okLjeczvvr?=
 =?us-ascii?Q?iaVfjAJ1fE0caoatCKvH7uDwe4b7s0efmsymjbm2GE9uNAu8+SOMFlwliqwg?=
 =?us-ascii?Q?3t5FeHg3bnFdRpZ5GK2yClYsczd7U8geD7qtfqkIZAxbqgpDuRtZKNuyMmj/?=
 =?us-ascii?Q?lrF9datouXCpb5khw4nOW8MUTydhr5zAkrqE1RbBG170Uh620hwUgOSgMpNl?=
 =?us-ascii?Q?LJcDk41HV9cI7S7CNDAt11m04FVKq2tLYHsio1JYbVoQ/X9yq6IsYX51WgDw?=
 =?us-ascii?Q?Q3bOAxDXMVAqm56hwexZrtoW5M2IoCu/yuTiPjEZ4kscN0okfbr2jOo29Wls?=
 =?us-ascii?Q?wrTWHsdZaF8VlUg+Baari2wP3qjMo7yOH1E8Mwo7wL/RgsiQ2UDDWqY94clw?=
 =?us-ascii?Q?Bnn+STsOBj4bLlO32Qq4VnTqJcT2h6l6jSzZ2Kf25rVFG4MmF6iqcSW1PMuq?=
 =?us-ascii?Q?TdZ+6VCFzzSpD98TDD47BgotT4QTP2YTSMMrF0w/SIGeE77CWoI+R06yviEy?=
 =?us-ascii?Q?PUFzyfOD00SdbR9/7HSLoSa8eOMJyfdp5Wer13nSHI3pmUpy06t55YgbqAvE?=
 =?us-ascii?Q?tHaLqr1KafVKXJ5463bFOLmtI+n9/g1eZriqg1VZp4ueNoLYCabE+dPo3Gne?=
 =?us-ascii?Q?tUBHNkKoU+mdHotzPJh4CfalXjX27iTV6brGDLXUgUyQDxen2VS9BviaTeh5?=
 =?us-ascii?Q?EqgVwpoxdcUZT0yvr0SSEKnlOLiRlBcxZFd0UgcQoRnoEB8xHSFx7gR+TsXO?=
 =?us-ascii?Q?TvWlsUg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3460cf34-f360-4c56-5371-08de900fe256
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:58:22.9155
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
	TAGGED_FROM(0.00)[bounces-9879-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,reg_assoc.name:url]
X-Rspamd-Queue-Id: 42ABF37E782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> The kernel currently sets the VSM configuration register, thereby
> imposing certain VSM configuration on the userspace (OpenVMM).
>=20
> The userspace (OpenVMM) has the capability to configure this register,
> and it is already doing it using the generic hypercall interface.
> The configuration can vary based on the use case or architectures, so
> let userspace take care of configuring it and remove this logic in the
> kernel driver.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index c79d24317b8e..4c9ae65ad3e8 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -222,30 +222,6 @@ static int mshv_vtl_get_vsm_regs(void)
>  	return ret;
>  }
>=20
> -static int mshv_vtl_configure_vsm_partition(struct device *dev)
> -{
> -	union hv_register_vsm_partition_config config;
> -	struct hv_register_assoc reg_assoc;
> -
> -	config.as_uint64 =3D 0;
> -	config.default_vtl_protection_mask =3D HV_MAP_GPA_PERMISSIONS_MASK;
> -	config.enable_vtl_protection =3D 1;
> -	config.zero_memory_on_reset =3D 1;
> -	config.intercept_vp_startup =3D 1;
> -	config.intercept_cpuid_unimplemented =3D 1;
> -
> -	if (mshv_vsm_capabilities.intercept_page_available) {
> -		dev_dbg(dev, "using intercept page\n");
> -		config.intercept_page =3D 1;
> -	}
> -
> -	reg_assoc.name =3D HV_REGISTER_VSM_PARTITION_CONFIG;
> -	reg_assoc.value.reg64 =3D config.as_uint64;
> -
> -	return hv_call_set_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> -				       1, input_vtl_zero, &reg_assoc);
> -}
> -
>  static void mshv_vtl_vmbus_isr(void)
>  {
>  	struct hv_per_cpu_context *per_cpu;
> @@ -1168,11 +1144,6 @@ static int __init mshv_vtl_init(void)
>  		ret =3D -ENODEV;
>  		goto free_dev;
>  	}
> -	if (mshv_vtl_configure_vsm_partition(dev)) {
> -		dev_emerg(dev, "VSM configuration failed !!\n");
> -		ret =3D -ENODEV;
> -		goto free_dev;
> -	}
>=20
>  	mshv_vtl_return_call_init(mshv_vsm_page_offsets.vtl_return_offset);
>  	ret =3D hv_vtl_setup_synic();
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


