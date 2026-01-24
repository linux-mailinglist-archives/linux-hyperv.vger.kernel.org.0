Return-Path: <linux-hyperv+bounces-8508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKQmNQ4WdGk32AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8508-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:45:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019F7BC8E
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41073301452E
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D21CF7D5;
	Sat, 24 Jan 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sVd6zKmC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012045.outbound.protection.outlook.com [52.103.23.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576619E839;
	Sat, 24 Jan 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769215494; cv=fail; b=W36oc8l/HBUrxobiLEKTmTDRCimIfiE8Luiuw68oPcfn0aImGoRl6zCosSNSPrHeoswn/pKw0yaBBPFjuQxJZvREhrmye/l+NRH7BTRsisqJqvHb+i2Tp9coQqWfh24lBeC6dt23tpILCaquGa0OYdo/7nxmhNGiSiUr+bb9oGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769215494; c=relaxed/simple;
	bh=VcURokesCTR0SdYqO2561EFpPXXLGf3FlywOGMBy3X4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uco2eTWtoxnDwa5VrmDBojBpv4yQstjKLtRL1CGcNS7MkbZGMj61ViFojAiM5+tbhLU30kvjDZZjcoPyDyq3ZgicevYId8W2daEMDtXuRtVaNkmSuXgA2GLywoqBD0Di01o9Nv8rE/21RCzwFsEM3NwoSB15u7TYqd3oyvvvek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sVd6zKmC; arc=fail smtp.client-ip=52.103.23.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haVFsARlAvjQRvHdHqxdz31UYrDIwsKvcarmSb2xm7p+OaYw09Bk7WyEXvxtrxRQO2gSeZr/NMsVmIlffgCR9387A8cbnq1GrqTkrzEOYvav8sDRqe9qk9yV1nlmQQB6KzXntYFP0RPa1PNexinLOJ3M4GzQNgsAqfdzWtnqlM/iCu24JrZsTXhl/F6eswtQ96ywfc/d5el2tE8efVvek574K7ED3jW/UNPbpHevSAAElMq2Epvoc4uEc5xAZ/aD+Uq/XWWSyuBfC0eFsuisXLdL7yTxfr4VOyUDLvXeA5U0Yr5pu2VBtoNlXqvW/xoBq0TLT2c1FJkPpIF0NgBeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcURokesCTR0SdYqO2561EFpPXXLGf3FlywOGMBy3X4=;
 b=swmMrD4v09VeUza67NLrEdN7mu1z8ImCPIgdLbYWhXKJUVquHlrIZHnRZLouvUfwIlEV5zZY5QqKkE90V0r6m1lYEmm3AUhoX0AnPk/MRTNoCqdg5Q8/cKP5fa41Iv5DiZiusfjANLi9gxSAOG5VnFnq4lN/W5chwvs5ZiuQodr3mTKNsjWR28+IPJ6maf5+9wCXYl5Y+ICcw82xiQrarSMw2uwVuxiqg0lwJ3yWfsfBu8VLEILi7p8KN8yJfMHfjYKuE19MonJvWyAo04QfNr5wTl2izoNqx/wB1YHweyMFv5XLWfjIsCdTZIPgWdUU5DhOKCfCgWUGKwKyYOGtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcURokesCTR0SdYqO2561EFpPXXLGf3FlywOGMBy3X4=;
 b=sVd6zKmC8xmsfkosx7Ud4wZIHyx60RCT0FhROt/XGUfsifcfIyxnO7N6I73tUDdiiS1hEsqDrWJod+n3ZeMcJJyGEq0nMKoeY+ZXulicDG8Ht8Hm5Dj6Xyyt9P7AcmHX5rRC+l9YKKAWpSZW02yRkIupCzt4V4tQPAacwQ9VG5Fh88xEeDhEPQ+EIwFhqmE/aPB0h83Syp5aEfvfLjNesBijpSB247X4dbyqx6wOTiFAmD3ooe05nU5lJNNK5XEXmyoz9roFosOCHKh1j2bCI5HrF9Dq3AtilY5tr3Z2EZPDK3tTXd2gBl6l2CHhOyEqVCDDGvMDdFO8BIdraafPcg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6487.namprd02.prod.outlook.com (2603:10b6:a03:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 00:44:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 00:44:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Topic: [PATCH v4 6/7] mshv: Add data for printing stats page counters
Thread-Index: AQHcix9mx12lepGkcE2/p3HiI/apmLVfOm+QgADloACAADmqgIAAHH2AgAAG2EA=
Date: Sat, 24 Jan 2026 00:44:50 +0000
Message-ID:
 <SN6PR02MB4157C2266EB06759A8E16BD1D495A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2ea6f13f-ac2e-4ed7-9f2c-6c079cb25b85@linux.microsoft.com>
 <aXP2s7V7u6aScDHv@skinsburskii.localdomain>
 <dbe3960d-c765-4394-87ce-e11c051cde44@linux.microsoft.com>
In-Reply-To: <dbe3960d-c765-4394-87ce-e11c051cde44@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6487:EE_
x-ms-office365-filtering-correlation-id: 26124766-6dbb-45ed-7101-08de5ae1c847
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|31061999003|461199028|8060799015|15080799012|19110799012|8062599012|13091999003|3412199025|440099028|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?d095SlpFRVhjZko2b3RZS0xTWUk2d01xVWFWSXFPN1FvMmtieVpmZmUyclZK?=
 =?utf-8?B?TDdPdDVaVEFyVjVVbmhZclBRNWdMTCt0ckFqb3FHUWx4cnRHQmV3ZFQ4eklG?=
 =?utf-8?B?S291aEdPNFZDYnhiNTl3SThicDY1dlNSZ3lpMTZ2SDc0ZURQMTdGUUViZ1Vk?=
 =?utf-8?B?ZE5pQit6TDBZSWV4TWFqOXpqQmIvTlpVYk5rbjIraVZER2hlbTdnUmJBM3F5?=
 =?utf-8?B?RHdPb1ptcHUvUTdkbFJiaXllWE55bGZVaUMvVlJqSHlnc2JuM2w5UTE3MU91?=
 =?utf-8?B?amlyVGVrdml5Sk9CTDhYZVlvcGh2bERMYnh0b3FVZ0RkMFZaTlNvemlZU1lM?=
 =?utf-8?B?UmlPUEJQVlVWLzhRaEl5QXZvM21iWERjVzYrMW9UUlZTb0w0ZThnV3dRNFZB?=
 =?utf-8?B?UnZZVEpLampTc3FkZnRvR1RmZjdqZnVOY3R0RGtndGVBREcra0JhSU96NFEv?=
 =?utf-8?B?STlDVnFCWG45cUUra3BQa29IYXNHOHloMlgzcExVdHo2SjF2U3RWNnEyWk5K?=
 =?utf-8?B?ZitCbmVrVm41VFlWRHFPbUk0S2xUa1NjeEdYTDlTbGEzMzFxSE0rTWVJMlBS?=
 =?utf-8?B?VjJVMWZOYmFxK2Q5UitaNWp4NUpCQlRxZ3J2SlcxeTJJMzkyVzRYRUg0Wkly?=
 =?utf-8?B?bkowenA1eXVJQW5qRUNRcUlieWF2bWNwVitxUkphZ3haS1A0QUl0dlpVaGdq?=
 =?utf-8?B?czdNblhxSjhYOWluK0N3a3F5M2x2ZXVmOGFJN2pUOHZYejl3STArSnVtbCs4?=
 =?utf-8?B?UTNmdi85UUdYeTJGTksvY1FxZjVPeWFBby9kVTR4YTFleTVKRmZlYTRvaVJu?=
 =?utf-8?B?dWVJYWNaOXJxa21ZSXBKQkFHcytyMlFvbzczQXVkZFExYXRpdXZNd29JZ0dQ?=
 =?utf-8?B?cDB1UFVQckxPQWR0M2VvL3plNGg1MytGQ1NUTEgwTTJ3bEF5cHRwb05pc1c2?=
 =?utf-8?B?Vkd3N1ZEUktSeU5Db0VoRkxtY3Q0UElHdHB2OEtHQ3BvYnNIakJNb1ZKc3Za?=
 =?utf-8?B?WXJVZjR2dTd2S0gzZ2JvanBuOVNQMXNkcFJxUHlsbW1SejZuUEorMFVwaHRC?=
 =?utf-8?B?VEVHVGZSQWNNa3ozU0JoRWh4T2Y1QzFET0VkZFBaK3pkbytGTUVTb1hGdWdK?=
 =?utf-8?B?aFVWTGVBdmk3QUpNbmJZSjJYb0I3ekxpc3NFSkxEUDVpaEFwTVJHOEFKcmUw?=
 =?utf-8?B?U1ZUS2pHM1pDKzZCMHlpN2pNS3cwdSt3MkpJT21aUVdaaUViOG4vdE4vRlJp?=
 =?utf-8?B?UHduM1RObTliTHZlZVJiY2pqRmI0NDViMGJkRUVlMk9GT3hrcEg0R29PWFVB?=
 =?utf-8?B?L1dRNkVHbEJGZUtaQ1pYVlhLYm1MNmErMGowNlVhbE5hU0NpZ1JCZnUzMGNZ?=
 =?utf-8?B?djJEQWpwRlV3cXdIcVJLREYyYU15bnlEQnNJNjFVSlRxWEIvLzQ4aDVRY2d1?=
 =?utf-8?B?OUEyYi9CQzV4YXZQQ0M3ejVodDg3Z3F0aENIRnR6cjJRWnJRVG84V0tZUlpR?=
 =?utf-8?B?RGc2U0ZTVDZxemZXSFpXRStFNkVTYksyR2t6ejRvbnc2MXRIMzVWL3dubkM5?=
 =?utf-8?B?VUowTWY0amhGaldEb3lod1hmS1JkbFRBazA4UGg4ME41UW80ZGJCUUlrNk5m?=
 =?utf-8?B?bnp4SHRtTzJTRXpTWkx1MHd4NUVRTGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHgyUHIvUVk4SDJ4bGhzc081OFQ2Y1BZSnV3cmFHc3JadWlINUVZalIrREgz?=
 =?utf-8?B?ZGx4dTY0L0g1N0ZGdkdKZWI3MEh5NWdTU0J1T3VMUk1OMEJOMTVwaDNQRGdq?=
 =?utf-8?B?czR4cHFUNUk3NFNCaW9WMFdjeGsrLy9SSDFmblYwcUFJVlRJemcyRUVrVmJv?=
 =?utf-8?B?UWE5c2V5QjFSYWNFaGdBekpPazJlWEVBQkc1c1pnb1RNS08zZHpaRW5WcjFO?=
 =?utf-8?B?NDZ3MmFKWWJBYVNCa2xsOWJ4MzRKaFVBdDZuckZaN0RCWkhwM2liWjBvTEgw?=
 =?utf-8?B?OSs1Q0J2ajRzRTVZamVLNWtBa2lPY1FxS2ZHT3lDSkhzZDNkRHNqbEFyK0dN?=
 =?utf-8?B?eEo4cVVlMWU3RXE2c05zZVQyeGRQRE8rTXJQamhLYVg0dmdYK3FvYUlsUzQx?=
 =?utf-8?B?K0FqcWJFOHBjQVJUcUhSSjhjeWFZc1Y4eVFncUVuaUdvUzQrdTdxdEFUeWQ5?=
 =?utf-8?B?MVBZVjducDh4NnB0bDFyb1h4VnI2NVhRVEpuYXRUdnh0UGdXNEJvdVk4OWRv?=
 =?utf-8?B?RnRjQnNiSnBjZ2FnQ3NQOXloRUk1YlNwajBjMkVpYUJway9pRXhUL2YrNFpn?=
 =?utf-8?B?ejRwK1g3OUFIODVVZlRjRFJZWUZ1OG1qbHF2ajYvZWtqMDNzSVlWUjdocUJU?=
 =?utf-8?B?b3FLSUk4N05Eb3E2cGorUFcxVGVrY2hHOEZNNGgzVjBNeUY5NjZBVjhqZ3gw?=
 =?utf-8?B?a3RBQTZQY3B1TVdRRk1YMUZ3S3lkcnJ2NWN1TFBoSW1mdFArcENnTzFtZ0NU?=
 =?utf-8?B?S3BWUThWVnJMZ2dhTVB5ZFc2clQ1VW1YUGVydVlvSzFXTDVPZXlHbzI3R2pm?=
 =?utf-8?B?WThiOFhWejk3ZjZ0OG1ZV0dFbm1qcm9ldC84eDhHZ1FzWTF1bGFlN3NuZUF5?=
 =?utf-8?B?dGdxWWtLSWlISXRHNitlYndyTktyTnN1UWVjK2crVlRzSXl2WjhvNnpkc3ZR?=
 =?utf-8?B?VWFiUFJHOVkvR0dSVzhieDJHTHUycFhUUkVGTXpxazNab01UNDJ1WVNUYXRX?=
 =?utf-8?B?dFpGUW9jYkVVRTlRTmNkRjdMMVRsb0VNOEQ2dXdaVVVVTHJRdFNZRG0wNlhR?=
 =?utf-8?B?S3oxUFFYekpPcFlNNCtCM2dkL3ZXRXIxRms5N1ZIa0ZBMFVFVXpRTlE1VlBs?=
 =?utf-8?B?WER6M0Z3K2ZIcGF5eEM1OFd4djRVeVRlK3dMRHF1LzZEUmt4TkFjbHQ0Qm9V?=
 =?utf-8?B?Vk5YYnBGUm5MNmtLbFU0bzUxVGdESkR5MFdtcE9jcDhuRCtaTUtYMzNaQ214?=
 =?utf-8?B?cWdRRVhHWUdCQktXZ2lvYzFYNURUTU40K2dlMTZxQjI0NGJLN1VXVExibyt6?=
 =?utf-8?B?SlNJNmJMM05aUTc0LzVrcktnS3Z4QTZSUkQ5VUEzc3lKQ2hNNWlZYndTTlRk?=
 =?utf-8?B?ME51S0RkcGJWc3JaZ25lcHVWZy9UZjJ4dndmWDhNZWlRVkt2NTlEbHJMbDNZ?=
 =?utf-8?B?QndtTzZWN3lPUnNqU1VXYm56dzFTcTdkTHBZUWpFYk0xdUpjSjd0eWJSSi90?=
 =?utf-8?B?ZlJJdWlEbGZ1alB3eGI1UDVXU2VQci9FenUxcFEzYlBkQ0FWUzB5Y0JFZUZo?=
 =?utf-8?B?c3RtL0xmOGkwRk9WaGlTZ3M2a0ZUb3ZIbHpmZjRGM21WMWFNaWpVMS80UjVL?=
 =?utf-8?B?cjdVUDFMa0JXUWVzNGFMaUp2UVQ0UGh2T28zN25Sb2xPalBQdFlsU1ViSFYv?=
 =?utf-8?B?OGg2L3kxbXFWbUNDeGltZlFXbTYrK2FUL2FvL2E3TVNWMGJSQ2FvbW1xckZa?=
 =?utf-8?B?R0VvZE9zaUw1dXkvR2hkVDJPVlpOUUlvRUVkODE1dW16NVR2MHRlTTV3RnNq?=
 =?utf-8?Q?wE5DyLM7/2ST2ln439BUkEiXCH4ojGQsdZfWs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26124766-6dbb-45ed-7101-08de5ae1c847
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 00:44:50.6893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8508-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 5019F7BC8E
X-Rspamd-Action: no action

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIEphbnVhcnkgMjMsIDIwMjYgNDoxMyBQTQ0KPiANCj4gT24gMS8yMy8yMDI2
IDI6MzEgUE0sIFN0YW5pc2xhdiBLaW5zYnVyc2tpaSB3cm90ZToNCj4gPiBPbiBGcmksIEphbiAy
MywgMjAyNiBhdCAxMTowNDo1MkFNIC0wODAwLCBOdW5vIERhcyBOZXZlcyB3cm90ZToNCj4gPj4g
T24gMS8yMy8yMDI2IDk6MDkgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+Pj4gRnJvbTog
TnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBX
ZWRuZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMTo0NiBQTQ0KPiA+Pj4+DQo+ID4+Pj4gSW50cm9k
dWNlIGh2X2NvdW50ZXJzLmMsIGNvbnRhaW5pbmcgc3RhdGljIGRhdGEgY29ycmVzcG9uZGluZyB0
bw0KPiA+Pj4+IEhWXypfQ09VTlRFUiBlbnVtcyBpbiB0aGUgaHlwZXJ2aXNvciBzb3VyY2UuIERl
ZmluaW5nIHRoZSBlbnVtDQo+ID4+Pj4gbWVtYmVycyBhcyBhbiBhcnJheSBpbnN0ZWFkIG1ha2Vz
IG1vcmUgc2Vuc2UsIHNpbmNlIGl0IHdpbGwgYmUNCj4gPj4+PiBpdGVyYXRlZCBvdmVyIHRvIHBy
aW50IGNvdW50ZXIgaW5mb3JtYXRpb24gdG8gZGVidWdmcy4NCj4gPj4+DQo+ID4+PiBJIHdvdWxk
IGhhdmUgZXhwZWN0ZWQgdGhlIGZpbGVuYW1lIHRvIGJlIG1zaHZfY291bnRlcnMuYywgc28gdGhh
dCB0aGUgYXNzb2NpYXRpb24NCj4gPj4+IHdpdGggdGhlIE1TIGh5cGVydmlzb3IgaXMgY2xlYXIu
IEFuZCB0aGUgZmlsZSBpcyBpbmV4dHJpY2FibHkgbGlua2VkIHRvIG1zaHZfZGVidWdmcy5jLA0K
PiA+Pj4gd2hpY2ggb2YgY291cnNlIGhhcyB0aGUgIm1zaHZfIiBwcmVmaXguIE9yIGlzIHRoZXJl
IHNvbWUgdGhpbmtpbmcgSSdtIG5vdCBhd2FyZSBvZg0KPiA+Pj4gZm9yIHVzaW5nIHRoZSAiaHZf
IiBwcmVmaXg/DQo+ID4+Pg0KPiA+PiBHb29kIHF1ZXN0aW9uIC0gSSBvcmlnaW5hbGx5IHRob3Vn
aHQgb2YgdXNpbmcgaHZfIGJlY2F1c2UgdGhlIGRlZmluaXRpb25zIGluc2lkZSBhcmUNCj4gPj4g
cGFydCBvZiB0aGUgaHlwZXJ2aXNvciBBQkksIGFuZCBoZW5jZSBhbHNvIGhhdmUgdGhlIGh2XyBw
cmVmaXguDQo+ID4+DQo+ID4+IEhvd2V2ZXIgeW91IGhhdmUgYSBnb29kIHBvaW50LCBhbmQgSSdt
IG5vdCBvcHBvc2VkIHRvIGNoYW5naW5nIGl0Lg0KPiA+Pg0KPiA+PiBNYXliZSB0byBqdXN0IGJl
IHN1cGVyIGV4cGxpY2l0OiAibXNodl9kZWJ1Z2ZzX2NvdW50ZXJzLmMiID8NCj4gPj4NCj4gPg0K
PiA+IFRoaXMgaXMgcmV1ZG5hbnQgZnJvbSBteSBQT1YuDQo+ID4gSWYgdGhlc2UgY291bnRlcnMg
YXJlIG9ubHkgdXNlZCBieSBtc2h2X2RlYnVnZnMuYywgdGhlbiBzaG91bGQgcmF0aGVyIGJlDQo+
ID4gYSBwYXJ0IG9mIHRoaXMgZmlsZS4NCj4gPiBXaGF0IHdhcyB0aGUgcmVhc29uIHRvIG1vdmUg
dGhlbSBlbHNld2hlcmU/DQo+ID4NCj4gDQo+IEp1c3QgYSBtYXR0ZXIgb2YgdGFzdGUgLSBzbyB0
aGVyZSBpc24ndCB+NDUwIGxpbmVzIG9mIGRlZmluaXRpb25zIGF0IHRoZSBiZWdpbm5pbmcgb2YN
Cj4gbXNodl9kZWJ1Z2ZzLmMuIEJ1dCBJJ20gbm90IGZ1c3NlZC4gSWYgeW91IHRoaW5rIGl0J3Mg
YmV0dGVyIHRvIGp1c3QgcHJlcGVuZCB0aGUNCj4gZGVmaW5pdGlvbnMgdG8gbXNodl9kZWJ1Z2Zz
LmMsIHRoZW4gdGhhdCdzIGFuIGVhc3kgY2hhbmdlLg0KPiANCj4gTnVubw0KDQpGV0lXLCBJIHBy
ZWZlcnJlZCB0aGUgc2VwYXJhdGUgZmlsZSBzbyB0aGF0IHRoZSBtYWluIGRlYnVnZnMgY29kZQ0K
aXNuJ3QgYnVyZGVuZWQgd2l0aCA0NTAgbGluZXMgb2YgZGVmaW5pdGlvbnMgdGhhdCBhcmVuJ3Qg
Z29pbmcgdG8gYmUNCmVkaXRlZC9yZXZpc2VkL2ltcHJvdmVkIHZpYSB0aGUgdHlwaWNhbCBwcm9j
ZXNzZXMuIFRoZSBjdXJyZW50DQptc2h2X2RlYnVnZnMuYyBpcyBhIHJlYXNvbmFibGUgNzAwIGxp
bmVzIG9mIGNvZGUgd2l0aG91dCBhbGwgdGhlDQpkZWZpbml0aW9ucy4NCg0KQnV0IGl0J3Mgbm90
IGEgYmlnIGRlYWwgZm9yIG1lIGVpdGhlciB3YXkuDQoNCk1pY2hhZWwNCg0KPiANCj4gPiBUaGFu
a3MsDQo+ID4gU3RhbmlzbGF2DQo+ID4NCj4gPj4+IEFsc28sIEkgc2VlIGluIFBhdGNoIDcgb2Yg
dGhpcyBzZXJpZXMgdGhhdCBodl9jb3VudGVycy5jIGlzICNpbmNsdWRlZCBhcyBhIC5jIGZpbGUN
Cj4gPj4+IGluIG1zaHZfZGVidWdmcy5jLiBJcyB0aGVyZSBhIHJlYXNvbiBmb3IgZG9pbmcgdGhl
ICNpbmNsdWRlIGluc3RlYWQgb2YgYWRkaW5nDQo+ID4+PiBodl9jb3VudGVycy5jIHRvIHRoZSBN
YWtlZmlsZSBhbmQgYnVpbGRpbmcgaXQgb24gaXRzIG93bj8gWW91IHdvdWxkIG5lZWQgdG8NCj4g
Pj4+IGFkZCBhIGhhbmRmdWwgb2YgZXh0ZXJuIHN0YXRlbWVudHMgdG8gbXNodl9yb290Lmggc28g
dGhhdCB0aGUgdGFibGVzIGFyZQ0KPiA+Pj4gcmVmZXJlbmNlYWJsZSBmcm9tIG1zaHZfZGVidWdm
cy5jLiBCdXQgdGhhdCB3b3VsZCBzZWVtIHRvIGJlIHRoZSBtb3JlDQo+ID4+PiBub3JtYWwgd2F5
IG9mIGRvaW5nIHRoaW5ncy4gICNpbmNsdWRpbmcgYSAuYyBmaWxlIGlzIHVudXN1YWwuDQo+ID4+
Pg0KPiA+Pg0KPiA+PiBZZXMuLi5JIHRob3VnaHQgSSBjb3VsZCBhdm9pZCBub2lzZSBpbiBtc2h2
X3Jvb3QuaCBhbmQgdGhlIE1ha2VmaWxlLCBzaW5jZSBpdCdzDQo+ID4+IG9ubHkgcmVsZXZhbnQg
Zm9yIG1zaHZfZGVidWdmcy5jLiBIb3dldmVyIEkgY291bGQgc2VlIHRoaXMgZmlsZSAod2hldGhl
ciBhcyAuYyBvcg0KPiA+PiAuaCkgYmVpbmcgbWlzdXNlZCBhbmQgaW5jbHVkZWQgZWxzZXdoZXJl
IGluYWR2ZXJ0YW50bHksIHdoaWNoIHdvdWxkIGR1cGxpY2F0ZSB0aGUNCj4gPj4gdGFibGVzLCBz
byBtYXliZSBkb2luZyBpdCB0aGUgbm9ybWFsIHdheSBpcyBhIGJldHRlciBpZGVhLCBldmVuIGlm
IG1zaHZfZGVidWdmcy5jDQo+ID4+IGlzIGxpa2VseSB0aGUgb25seSB1c2VyLg0KPiA+Pg0KPiA+
Pj4gU2VlIG9uZSBtb3JlIGNvbW1lbnQgb24gdGhlIGxhc3QgbGluZSBvZiB0aGlzIHBhdGNoIC4u
Lg0KPiA+Pj4NCj4gDQo+IDxzbmlwPg0KDQo=

