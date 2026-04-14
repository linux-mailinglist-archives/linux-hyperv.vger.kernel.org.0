Return-Path: <linux-hyperv+bounces-10156-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK2eG0xf3mn+CQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10156-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:37:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3003FBFAD
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A433067B06
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE63EC2CF;
	Tue, 14 Apr 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LhXajarn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E43E95BD;
	Tue, 14 Apr 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180895; cv=fail; b=GtLMdc8GQLQBrB1aHb7ozvmvtl3HMuWdqQYqp6VyBOkC614VyGJf+41nZJeJ9IjTtEp0x+hVi8A84lylx3N7Y/BYcLaK9yhRZY7XSMhZ8dg173XeZb2tbL/+6ZP5ImC60AD691gJOQANX8WDEkN8Ok4EMpqdld9pabb254srCJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180895; c=relaxed/simple;
	bh=3tB4b991+0ngkd6tGR/yUAp1V5N1zlqLnmoPuJHD488=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2yoVIhygxEwhocLa+ZzSIkpct3sZrM/Zcgh2b+7oqmwHL68x4r+rgaleXRu8bfOmMGn88PqURV10cn7OrXSHQqQuw8+b80ItW7E+/irYh6zNZtmqGFnMvOsV1MM+r5TM34OchC54GvXMlVGG17fu6gB5oNmu9WePWZQcvTB5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LhXajarn; arc=fail smtp.client-ip=52.103.14.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJDyA+l5mT1EfFi6waipwpK2sqB2AZVzNQVJ70XRt7S3xjbON4+7qWfgwDi/08L8gPuDSxneQ8o83s+khqU4irYc93bOvLf/zXfwWcMp/Xfq5coa+igqd9TbyY0rF9qpJliorxIMC23qDET/ja5wQadYKPx3C3y5yV/0IgN8AZU/b1vK+/G31IKB0Jqit1WG1cYTnt0pdU+ZY5MFe/mkz2nUDOf9I5Gm3c7Bh9tQIWCgqaaIuNHJ9Gu8uKH9kLV8oQScTXWyIHbyfdViVQVB53aaRHYrBo9j2pKp4xgzNfZLLAiyPjRzb1sS69XDlHqcEjUeui4lgwmZBFmxvUkpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tB4b991+0ngkd6tGR/yUAp1V5N1zlqLnmoPuJHD488=;
 b=gLhSRRjEqDclJdPVshussCtWeC7qsIpBmaTU3sYgV1giWyEj1JPG6MVZBCLkD1BMdbrR67+Tz+qyvOcQRJPiH29oONzF07vm5Lw1GwY95JnCAdjmZA0GvViOep4VgeucIkCjXnOoeSzQw/0nRXP2jcRt+zQqdc65dMP1zTxa1TW3K1gQ3Oi7xwi7NuyrC5EPmq1lQjskxD9gJLQMiRq2OPkDXZt7907w8vOoO3L4E3wHDeB4N+9bOmPuuUTkCH2BX1X84TzXUUJJqOr6VdDwoX6GdjrBsZ8UlVf98HP3ro19lxeeErkAOcHSjD9HJCgQgnHpITh7XMrqWhZO/6v+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tB4b991+0ngkd6tGR/yUAp1V5N1zlqLnmoPuJHD488=;
 b=LhXajarnWqnpzVjpL11EO88N5WqFZmK12rTuLny1mEWv52RJA23LFVnddQFFZUJ7Nc58WkVHPKt/AbpWavHpGD0RfQa6CMCaTP5sAeQPbi+WHTVypekkXA+BPPtBAy+bgxUiME092Vgf+sZTRbLS/aHLiVG8A9pUXQli/iXxNlAZoqhNEMh0BFyKLnxwZkpfJ8Rj43bWqK61enZrM5zzrlmSNRCSDncgWfMdu6PmGGnl1GhxQN1q3YQNA7cOdykxPLAR2mprf7pLFWJsoKLsXP+n5CbMC84A+ybmDQQpdsKTCsnqLQlzs6TuDzts8jHs3Uk/0e8ffcUkjrnXukkS1g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9987.namprd02.prod.outlook.com (2603:10b6:610:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:34:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:34:52 +0000
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
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Topic: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
Thread-Index: AQHctT5Uo06CdizxUEmOmS2tUYF/frXKhrvAgBKFcICAAEOtMIAAEU2AgAF80pA=
Date: Tue, 14 Apr 2026 15:34:52 +0000
Message-ID:
 <SN6PR02MB4157331531DA55B2591ED8A0D4252@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-7-namjain@linux.microsoft.com>
 <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b5125f61-173f-45d0-a6dc-d795ba0f8693@linux.microsoft.com>
 <SN6PR02MB4157DA00A31F0BA8585B9B69D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3264b2e6-f6fb-41b1-97da-22b5249c1839@linux.microsoft.com>
In-Reply-To: <3264b2e6-f6fb-41b1-97da-22b5249c1839@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9987:EE_
x-ms-office365-filtering-correlation-id: 277ac8cd-da33-4b5d-74c1-08de9a3b5f04
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|8060799015|13091999003|19110799012|461199028|31061999003|37011999003|51005399006|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0grRWlyN2liUUFXRm96UThoUEZXUU5FZlVHbGY3V3ZkR25sOFhydDdhUkk0?=
 =?utf-8?B?cnl5WnNwelBrcmROaEY3UTNrWXBQaHFrR3pTRHVTTmR4aklnWm5qbHovbFJv?=
 =?utf-8?B?WXpWQ0lGb3pCOUt0QzZ0cHA2bEdmRkNON0VranBKQzk1VytCWjluTlhWQ3kz?=
 =?utf-8?B?ZTgzSG5iNzJQS1JYVEF4cHJCOU5IOHlEUCtpd0IrNHNoYzduYzFrdXZSWkNj?=
 =?utf-8?B?c2lWdk94ditlSUFmMmVGS01ocWd2WWN2UVZLa3QyRUtSYnNoMXUzcFRjM2M3?=
 =?utf-8?B?dWlldnlGWEk0ZDU3ZmhQbFJKTVdtNlBXcUUrai9FcjVVNVhrVnU4T2FpK1JU?=
 =?utf-8?B?Z1BVcjVBREZhRzIzY3RBNHBpbzFVa3MwTXk4bFU5MktPV0hXdjlOOWVzQ1E5?=
 =?utf-8?B?TGpTMGk2MXBLZkRJWUtPM1hMNUhGSHBNQTQwaUoxb2ZIMVJncU90NHBXT3hp?=
 =?utf-8?B?cmV3T3AvbnJ3eXF5YjcrdmFocFZXUDRCMG4wSjJreGxYVXp2bHNxZ1BKckN3?=
 =?utf-8?B?SFZFbkZxclVreG1VK05NeHo3UWtKZkxkUGRmTlZQcnFWNXVieGNVK3VGR05O?=
 =?utf-8?B?Z1diVUJ3S3Rkdi91Vzdsd3M4WGZNWW44WVc5UExhaThHL0lCYkwvN3liRVNS?=
 =?utf-8?B?VTA5TUxYSkJMY1BiS0FOWVpRR2xEbGtuTTlmSHZ3VEozaStYOEpMVUVyV2Vi?=
 =?utf-8?B?bE92ZXRVM3VQc0NBaGw5SUc2WSs3SkxDNmlyemxJS2R0U2V4S3lndy8zazZM?=
 =?utf-8?B?eldIb3g3Q1I0Yy8wbURibDJYSkdySFdSVHdKb0FjdkRrSmpxRWdUNStrOEFD?=
 =?utf-8?B?TXA0SkpNU1FLbHQ0YTdCNXBwMmxDaWhqbXV4WlMzSHBKdE1MeGF3MW9XLzds?=
 =?utf-8?B?OGpGSjRyMHFWTXBJVFNXUTB3ejVNQVlORlh2V3MxSVVJZnFsVWt5WWRMa3ZB?=
 =?utf-8?B?Mm1wV1Jsd1o1ZXB0RjNHSm55U0ZQY1dCNnd3ek94VjYwUGVSaTd6c3BvREU0?=
 =?utf-8?B?RFZUeGJwL1J0cERQNXdIRDg0dGhXdkRSZ1BkMUhoRnFXOXNTbUFGYmZoZlVI?=
 =?utf-8?B?V1VNN0RSNUNDQklYTUptWnlQbkVJdTZndGQ0TTAweUR0cEx6QWNRMGxObUtu?=
 =?utf-8?B?V2xKZUZQZnU2ZlVZWk9aNXlYSTBzais4emdNZ0YvMlo1V0hHNlo2Wmtia2tq?=
 =?utf-8?B?K3FkWTgxNERmckZBRFlIcktmMXU1b1NyRmJuc0szcG5RN1BGbCtyb3dYZ2U0?=
 =?utf-8?B?eExyUGc0SFdsdmNpL0tuclBIMHpDekVLVnAvTnpCTXpBRnFuWEsrand0YkpZ?=
 =?utf-8?Q?PqshYcwiYOyRSgGUhm3STcwYFQx3gnwbAV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUhZT3NZY0Vvc1BWRVZ4bjh3dnZXa0c5UGhjNUZ2ZzZEOStzbHk1aDNWQzIr?=
 =?utf-8?B?S29ERWVDVmlWNkJxRFBwKzdveEVTWVA5MmNlai9nZnFlcVh2K29tcVJqY3NV?=
 =?utf-8?B?Y0ZnWlpOWG1nTlVSNHVQTUFjSUxIcDJkV2JHcVNjTlVYUDI3bUxtdGZQZkhl?=
 =?utf-8?B?aUJjaVAwVHhNTkhHRFhjSDIyMWErQmp5dkRNMU9mWGl2TDhwOU5paTlCZmpp?=
 =?utf-8?B?T0s2UXU3Mk4rb3ovS1NERk5hY0pwakkwZFNsbWlYbEVZVnlZNlpPbjJuVG51?=
 =?utf-8?B?eUhpRGpRekpYUGNocm1WWE13LzV2dlRRMk1NK3padkRhbTBzZmVnS3EvVnJ3?=
 =?utf-8?B?K0Voa1k2cVh4ZzBRK2Fzb21ENmh3eXRRWGxNRHhkWHNpUUhtRkN4SGU1c1Zu?=
 =?utf-8?B?VW1Fd2tSektEcEUxWlRCVFpxNTNybFBKMFFZZm1IeXZBRVVCRlVSenUrUzRC?=
 =?utf-8?B?TWxpalVyaVBBblNwOHpaZWdNbEpzQmZ6Mk15cDBWQVRaTzlmcnU0VDEydmp2?=
 =?utf-8?B?a0FZQit3TkMvNlJ3S0VTdy8wRWc0NHViUHI5cU40Qy9zV3FjcDR4VVFwb2ZJ?=
 =?utf-8?B?SVpNSlJhUC9DRW5zUStDeTFrL3dpeFAwN1VzS2IyOFd2ellYRHc1S1RlM3JW?=
 =?utf-8?B?RitmS3VNNGpkU0JhUG9wcDVVczV1ZjVxUlVWa094aVJzQ0NBRThFWmp6Zkk3?=
 =?utf-8?B?SVVYaEtTV05tMDZDUGkyT21qT21hdjRmbnJaRk9KclM5TWovZkVzVE5McWQ0?=
 =?utf-8?B?M0pMb0Y2a0pENmkvTWt1WUp6Q25MdXF5N1hReTEwMms1VEh3NTdQYytqT2t3?=
 =?utf-8?B?dm4vQXdzbmFPT1h0L1pnektHMUdBcUNIWnBBaU5wTVlRVUFKNzJ1OFV3bXVN?=
 =?utf-8?B?MmdjSTYwZzZNQ3J4WHJXK0VaMGdZa21idmlyc2FvaC81SndpTW5ZVTVycXNa?=
 =?utf-8?B?am90Z0V6blQ4a2tiU1pJSFFJM08wcGZSSFpTb0pmcUdaUWNockdzejNvUEta?=
 =?utf-8?B?WkprekpCcllRZFJMQXV5K3QzVkdCa0xXeWIrT3czRXhEVWNtL0dkMzdqdHV0?=
 =?utf-8?B?WFZ2S3ZNRllYa01VRWVtODFCaGI5UUFuSWpqcmltNjdrc2UxNnRwYy9HaXNo?=
 =?utf-8?B?clhvcXJNUHRjQnRrTy9QTm5XRUh3ajV3cHJUaTlvRUlXYy9sQ1FlUFJZOC9h?=
 =?utf-8?B?RmZTWVo3dGZONFFWd1dyMlB6a3FOL0FHa0RQeHhXY25vQUZnM2VFT09GOEk0?=
 =?utf-8?B?NVJWOGxXQ28rM2JQd3Z5ajJUMDR1NjN6MERQbDA0WVQ0dSt3eWJ2emNNUTBR?=
 =?utf-8?B?RnhNYkozeXc0R3N1TGJjNERXUWZuYVc2L2FmLzF0bXAxQ3lPTld1LzNhWjZj?=
 =?utf-8?B?dDhDSWNjaDkxV0tkNWNYdVVkL1J1MzFDR0srTFJHMGpjeFN5eVQ1RU11UWhu?=
 =?utf-8?B?OHRUcnZnQktmZ3llSjIxZkI0Si9wR1V5RWRHbkNsTmxtdVJ5THFpTUJ5VUc2?=
 =?utf-8?B?TVVLT3F5OUZkd0EzV1l5Y2h0M04wVjhINkJ6OXdTcG5jUEJqZjJ2ODIvUVhI?=
 =?utf-8?B?QjdVU08zRjIyZ2NNRGoyTDdzNFNnREUveitXc2pZK3g1aUZNemNhTG1Gb3dV?=
 =?utf-8?B?QXYra2RLcjdIZFF6K0tZeVlrSlE3V3FJcnRYL2k0Q1ZCY1dJL0NVWFlvV0dN?=
 =?utf-8?B?bEVHL004Y2NjOFNhM01WeWxBb1Z5MFJPRnZYZWg5ekg1MkdoZ0pQWTd0cXRQ?=
 =?utf-8?B?SXFHUFVFVkM5OVUzN2Yyai9haWRaSWh5eVI4RkdZWVV4UGhud3BBL3BiMWZj?=
 =?utf-8?Q?BVMuBarF/QDNwal17/FDacvjgtVtwUWaSR1bI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 277ac8cd-da33-4b5d-74c1-08de9a3b5f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 15:34:52.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9987
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10156-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC3003FBFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEFwcmlsIDEzLCAyMDI2IDk6NTIgQU0NCj4gPj4+DQo+ID4+PiBTYXNoaWtvIEFJIHJhaXNl
ZCBhbiBpbnRlcmVzdGluZyBxdWVzdGlvbiBhYm91dCB0aGUgc3RhcnR1cCB0aW1pbmcgLS0NCj4g
Pj4+IHdoZXRoZXIgdGhlIHZtYnVzX3BsYXRmb3JtX2RyaXZlcl9wcm9iZSgpIGlzIGd1YXJhbnRl
ZWQgdG8gaGF2ZQ0KPiA+Pj4gc2V0IHZtYnVzX2ludGVycnVwdCBiZWZvcmUgdGhlIFZUTCBmdW5j
dGlvbnMgYmVsb3cgcnVuIGFuZCB1c2UgaXQuDQo+ID4+PiBXaGF0IGNhdXNlcyB0aGUgbXNodl92
dGwua28gbW9kdWxlIHRvIGJlIGxvYWRlZCwgYW5kIGhlbmNlIHJ1bg0KPiA+Pj4gbXNodl92dGxf
aW5pdCgpPw0KPiA+Pg0KPiA+PiBUaGVyZSBpcyBubyByYWNlIGNvbmRpdGlvbiBoZXJlLiBUaGUg
aW5pdCBvcmRlcmluZyBndWFyYW50ZWVzIHRoYXQNCj4gPj4gdm1idXNfaW50ZXJydXB0IGlzIGFs
d2F5cyBzZXQgYmVmb3JlIG1zaHZfdnRsX3N5bmljX2VuYWJsZV9yZWdzKCkNCj4gPj4gcmVhZHMg
aXQuDQo+ID4+DQo+ID4+IFRoZSBjYWxsIGNoYWluIGZvciBzZXR0aW5nIHZtYnVzX2ludGVycnVw
dDoNCj4gPj4NCj4gPj4gICAgIHN1YnN5c19pbml0Y2FsbChodl9hY3BpX2luaXQpICAgICAgICAg
ICAgICAgICAgICAgICAgICBbbGV2ZWwgNF0NCj4gPj4gICAgICAgLT4gcGxhdGZvcm1fZHJpdmVy
X3JlZ2lzdGVyKCZ2bWJ1c19wbGF0Zm9ybV9kcml2ZXIpIGFuZCBzbyBvbi4NCj4gPj4NCj4gPj4N
Cj4gPj4gVGhlIGNhbGwgY2hhaW4gZm9yIHJlYWRpbmcgdm1idXNfaW50ZXJydXB0Og0KPiA+Pg0K
PiA+PiAgICAgbW9kdWxlX2luaXQobXNodl92dGxfaW5pdCkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFtsZXZlbCA2XQ0KPiA+PiAgICAgICAtPiBodl92dGxfc2V0dXBfc3luaWMoKQ0KPiA+
PiAgICAgICAgIC0+IGNwdWhwX3NldHVwX3N0YXRlKENQVUhQX0FQX09OTElORV9EWU4sIC4uLiwg
bXNodl92dGxfYWxsb2NfY29udGV4dCwgLi4uKQ0KPiA+PiAgICAgICAgICAgLT4gbXNodl92dGxf
YWxsb2NfY29udGV4dCgpDQo+ID4+ICAgICAgICAgICAgIC0+IG1zaHZfdnRsX3N5bmljX2VuYWJs
ZV9yZWdzKCkNCj4gPj4gICAgICAgICAgICAgICAtPiBzaW50LnZlY3RvciA9IHZtYnVzX2ludGVy
cnVwdA0KPiA+Pg0KPiA+PiBkb19pbml0Y2FsbHMoKSBwcm9jZXNzZXMgc2VjdGlvbnMgaW4gb3Jk
ZXIgMCB0aHJvdWdoIDcsIHNvDQo+ID4+IGh2X2FjcGlfaW5pdCgpIChsZXZlbCA0KSBpcyBndWFy
YW50ZWVkIHRvIGNvbXBsZXRlIGJlZm9yZQ0KPiA+PiBtc2h2X3Z0bF9pbml0KCkgKGxldmVsIDYp
IHJ1bnMuDQo+ID4+DQo+ID4NCj4gPiBJIHRoaW5rIHRoZSBzaXR1YXRpb24gaXMgbW9yZSBjb21w
bGV4IHRoYW4gd2hhdCB5b3UgZGVzY3JpYmUsIGRlcGVuZGluZw0KPiA+IG9uIHdoZXRoZXIgdGhl
IFZNQnVzIGRyaXZlciBhbmQvb3IgTVNIVl9WVEwgYXJlIGJ1aWx0IGFzIG1vZHVsZXMgdnMuDQo+
ID4gYmVpbmcgYnVpbHQtaW4gdG8gdGhlIGtlcm5lbCBpbWFnZS4gSW4gaW5jbHVkZS9saW51eC9t
b2R1bGUuaCwgc2VlIHRoZQ0KPiA+IGNvbW1lbnQgZm9yIG1vZHVsZV9pbml0KCkgYW5kIGhvdyBz
dWJzeXNfaW5pdGNhbGwoKSBpcyBtYXBwZWQNCj4gPiB0byBtb2R1bGVfaW5pdCgpIHdoZW4gYnVp
bHQgYXMgYSBtb2R1bGUuDQo+ID4NCj4gPiBJZiBib3RoIGFyZSBidWlsdC1pbiwgdGhlbiB3aGF0
IHlvdSBkZXNjcmliZSBpcyBjb3JyZWN0LiBCdXQgaWYgZWl0aGVyIG9yDQo+ID4gYm90aCBhcmUg
bW9kdWxlcywgdGhlbiB0aGUgcmVzcGVjdGl2ZSBpbml0IGZ1bmN0aW9ucyAoaHZfYWNwaV9pbml0
DQo+ID4gYW5kIG1zaHZfdnRsX2luaXQpIGdldCBjYWxsZWQgYXQgdGhlIHRpbWUgdGhlIG1vZHVs
ZSBpcyBsb2FkZWQsIGFuZA0KPiA+IG5vdCBieSBkb19pbml0Y2FsbHMoKS4gSSB0aGluayBodl92
bWJ1cy5rbyBnZXRzIGxvYWRlZCB3aGVuIGFuIGF0dGVtcHQNCj4gPiBpcyBmaXJzdCBtYWRlIHRv
IGFjY2VzcyBhIGRpc2ssIGJ1dCBJIHdvdWxkIG5lZWQgdG8gbG9vayBtb3JlIGNsb3NlbHkgdG8N
Cj4gPiBiZSBzdXJlLiBJIGRvbid0IGhhdmUgYW55IHVuZGVyc3RhbmRpbmcgb2Ygd2hhdCBjYXVz
ZXMgbXNodl92dGwua28NCj4gPiB0byBiZSBsb2FkZWQuIEFuZCB3aGF0IGlzIHRoZSBvcmRlcmlu
ZyBpZiBNU0hWX1ZUTCBpcyBidWlsdC1pbiB3aGlsZQ0KPiA+IFZNQnVzIGlzIGJ1aWx0IGFzIGEg
bW9kdWxlLCBvciB2aWNlIHZlcnNhPw0KPiA+DQo+ID4gTWljaGFlbA0KPiA+DQo+IA0KPiBCYXNl
ZCBvbiB0aGlzLCBJIHN0aWxsIGZlZWwgdGhhdCB0aGlzIHJhY2UgaXMgbm90IHBvc3NpYmxlLg0K
PiANCj4gaHZfdm1idXMgICBtc2h2X3Z0bA0KPiAgICAgeSAgICAgICAgICB5ICAtPiBkaWZmZXJl
bnQgaW5pdGNhbGwgbGV2ZWxzLCBubyBpc3N1ZXMNCj4gICAgIHkgICAgICAgICAgbSAgLT4gdXNl
IHdpdGhvdXQgaW5pdGlhbGl6YXRpb24gaXMgbm90IHBvc3NpYmxlDQo+ICAgICBtICAgICAgICAg
IHkgIC0+IGNvbmZpZyBkZXBlbmRlbmNpZXMgdGFrZSBjYXJlIG9mIHRoaXMsIGFuZCBtc2h2X3Z0
bA0KPiBpcyBmb3JjZWQgdG8gY29tcGlsZSBhcyBhIG1vZHVsZSBpbiB0aGlzIGNhc2UuDQo+ICAg
ICBtICAgICAgICAgIG0gIC0+IGNvbmZpZyBhbmQgc3ltYm9sIGRlcGVuZGVuY2llcyBzaG91bGQg
dGFrZSBjYXJlIG9mDQo+IGl0LiBtc2h2X3Z0bCBoYXMgc3ltYm9sIGFuZCBjb25maWcgZGVwZW5k
ZW5jaWVzIG9uIGh2X3ZtYnVzLCBhbmQgaXQNCj4gd29uJ3QgYWxsb3cgbG9hZGluZyBtc2h2X3Z0
bCBpZiBodl92bWJ1cyBtb2R1bGUgaXMgbm90IGxvYWRlZC4NCj4gDQo+IFJlbGV2YW50IGNvZGUg
aGVyZToga2VybmVsL21vZHVsZS9tYWluLmMNCj4gDQoNCk1ha2VzIHNlbnNlLiAgSSdtIGNvbnZp
bmNlZCEgIDotKQ0KDQpNaWNoYWVsDQo=

