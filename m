Return-Path: <linux-hyperv+bounces-1425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F582C370
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C471C21975
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFA745C8;
	Fri, 12 Jan 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NgmYJMJx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2013.outbound.protection.outlook.com [40.92.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4073198;
	Fri, 12 Jan 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2f0QMkVl7G2fjtHVV7jFIuNAFNgf3LhbJ1o557ils9K0HePPXvqPouCRwE7G+04EAIAWQw69HBz1HMAeNUMXjYYWC7ff+V6ts0a+eMryhopULLONKxYyjCenbYsvQi9+261bBLGUv7bY7Y5alQMFBeEMFATnF5tDQp9dLu9OnGooGzlvBDlc1W0J9vebuD/hmI0zuS/sDm7DOLOYOArmFkG8sHgJee71xqd4yeeCblYmcwrw3c1CtwAJQvz3iFJxpFol/CXkcKQ0os+zPCR5LDJuftgd/lllZ80GxqEBOSQ0h+hCILXL7nefYRxF1dyQ4Va7QKTd0LGqz1MMb2faA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WEPWa3xLFMjUWvVDGpOtCn1MrQ59m4f8xhQCO4faC0=;
 b=RxvYAe7Px0GR8UU5Wg74DoTg1kAyeUjUpBNjjivyRr9lj7Wmk1Fk8BRiMHwo0ptJVQicOI8+bxbZA/1c6+j9o7GqKugCOcY8xl86dCDzpMNSY7Y2/Mik1c2GnmX6W/N64USGoOktbpYrwWenvIMzyqi2C21laoIBTjgIYqfWnzyby3HLqN4RNCABkIvOWUEJ2CVXe1wQqGQYmzPsdD1r8KejghY57g/reMO5svAHk+jwt2ZLXyV6jDBRiYqFwJJJRzdhhUX9zJnyOnJ0ZNuAYCYkBAuF6b3GhGKk8EyB53ad9Ej1RXb6oYY+mhrXPWW/kZiPRHb6noc4ZIln6s8SWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WEPWa3xLFMjUWvVDGpOtCn1MrQ59m4f8xhQCO4faC0=;
 b=NgmYJMJx6f7ynyYs+WLey7zcyMzPiXzuj0jAfzlArCOzUyAjB4P4Qoa6xgitIdD3Dqxfh/wInxNT0vn+5FBWU4rsHO97arFUHl3FUxPZmtAiveCJEz0yzaEid6nIWyPvMbUKhmS+Ii817XbCCcBfaYIcVmQPIXsCUdkG0DidizRKQGlTj1W1qoew/I90XVN5M89Nv+mjxd6+gmuGsyLTqPQnd1Ff5V1zOAMzanjoMbliSYdNiUsb8u+fgI5gWnOPBWb/lGLMJiQfN3HlE9okRkJ6K2ECzPpTYkdeUljd6ik77af94tlEht6qFg4itbWJM8IyC6+HUF5sC4/rhsEsnw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8480.namprd02.prod.outlook.com (2603:10b6:806:1fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 16:19:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 16:19:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
Thread-Index: AQHaRK8CIUgdftXbBEW892p4qa59RLDV0xuAgACHZeA=
Date: Fri, 12 Jan 2024 16:19:05 +0000
Message-ID:
 <SN6PR02MB4157A7AC71EF769E5B88202CD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240111165451.269418-1-mhklinux@outlook.com>
 <de6c23b2-aa27-494a-a0ec-fe14a4289b38@web.de>
In-Reply-To: <de6c23b2-aa27-494a-a0ec-fe14a4289b38@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [s7AGYa9FTi00zqso51vlPsm3hxRXHHGQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8480:EE_
x-ms-office365-filtering-correlation-id: 8f6b3428-8356-437d-0af6-08dc138a3270
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uHtwhdI/0aZrMjX6uU4Mi1/bILEQqCOVkjKzFGrQFvPhbUbBLlvOJeTSWB6ZV7ngRvwW+YE1dD9FGSmAmwwfP7R9ApVlx34QZFCgG3+Z0DLCVxdRVWwKyYgliXJfH9vB/ZifqF9peHoFM7Pmyqxz4NARm7KAoohXwnuw3eBzLpm6uEi+l3b4RhIiid/DuYeE4C3yIX3zOJ20Txkqm2AgUEZrXzCrMcT1I1Gj2Ps6SPGYVdFY0LPu2WZUhGMYM5Kpf+ocN2fuef9nZP6ydKZEvmsC0O6saVUZq7uuUxk3RojjOyED4YpLSt0B+oOWkhLtPSDxNcGbeH1jJPmVGWGfaY1oSkRZtBcViI45XnY0I0pnamMcgvzZnwGKdPxotgg3eUSiVvDqBFeaikciL0lCko1IcrxPLa+rQRVrYkiOEMnLm6tA7ASofFJD5KB80tAfPxNMvjS55EI/yQnU0Umne5yAtsxTLoVrPxXlH5ZfJitqSzioHxtdrrgTRa9ImDQqfCfaVYDr4Y9j+RzLJUTa4ralJhqa8rPLRM4zEUYtBc5AeTpTolTPfTkTo3lUl/JE0qSgfTh836+f8chCVptik/ZdASrfCJ/Xf8VR7/fmEEQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmR6SWxtV2Rad1ZKUzh3d0RibHplSFdGRHJXRmlFZHVXdmJRUlBQdG1BbkMr?=
 =?utf-8?B?ZmNmRHNWRlBHNmpJSHZtbDZ6b3VpZU43L0U2NUlpRTNDbmFlNzdWazQ4K0E3?=
 =?utf-8?B?bjBCUVFuV2hwU2NiWXBRaVJUTmJoeDgrelZ5alYwQXgrUmNQdEg0NXI4djRj?=
 =?utf-8?B?SlRvZ2htMHFMZXZZb1FjR2VnWXUxS0loVjNOVzN2cmxkeDZTS0wwVGw5UXkx?=
 =?utf-8?B?UFdDZzhhcG1aYVB4Y2M0OTZMZjB1dXBmci9Ca0hxVDFzbHd3VjlqV2FQVk0z?=
 =?utf-8?B?Y0k3QUNkVnB2VlRTb2dmRU92eWlzdmRSN1EyNmFzUmdqdHIySmFtc05UR3dX?=
 =?utf-8?B?WFlYTll0NFJwbUZPV1M5ZllzbFNiRkJtcDlxekZpK1J5cmo4VW5SUkdySVV1?=
 =?utf-8?B?bGszc0JjNnl2WWM4WmtpK3ZrUkQ4cEFmUlpsb0ZUQXh2Z2YzNnM4dzQzVjRy?=
 =?utf-8?B?cndmUXNneXM2UEMxWTZsVGJIajJZOFgwSTFxMWZzZVFGUVZpaXMwRG9NNEtj?=
 =?utf-8?B?SkVBNzRhNHZDTjNrUkp0NEtjaHAxSWJCZEsrNDJ4THFmTDU2ZkRGNlpqL1pG?=
 =?utf-8?B?dXYzSEx5UGZ0U05zREdCQ3M2RThZYnEvVkZjZGM4K1poY3F4VUNzTTllS0xQ?=
 =?utf-8?B?UXlEdUxoeXkvRFVlZjNLYmpURm1wREFKUDBVeVFuOFpqREhVclV6NkFTcXRh?=
 =?utf-8?B?aVd5Tkg4UFJjUnFrT2VaRStBS3BGRlk5K3dvK09tVC9BbXVVeVk5K25XTlFB?=
 =?utf-8?B?MzlmL29ocDRvRjJvYVE5aDRuVUhtSFFFajZ5VUsrcStySDlXK1RPVnZzc3FU?=
 =?utf-8?B?YVpuRFRqZUpjK3JEelhIZmJ4ZCtFa3NCVFRhSUt0RElGZVdOanFxNDJEVVll?=
 =?utf-8?B?Wm5QNTh0cnRlZSswNmdHRnNncUtwc0pUUWVWanlUYmNXY3JLSzFrWXVaelly?=
 =?utf-8?B?N2xyTXJlNTU3T2F0ZThEWTJtbkxsOStnNWE4YlN1ZUpLRzY4RG9IZE1BemJU?=
 =?utf-8?B?dVlZcFNiV2x4NjhYWVpUbmhsaVlucW1NdVp5ZDhMdkZ6SzF1N1I5dFVsWkp5?=
 =?utf-8?B?ZFIzSTFlTVEzODJUWllBODNWcUNzMG9yZFVhVzBvVWdFTjh4dWlmL2pKVlVT?=
 =?utf-8?B?Rzk4d1VJSDVwbTZ6dHhjL1oybm84cnh0WThaTmc4RjNqWFRESHBobW83TllC?=
 =?utf-8?B?WjNwN0pUV2xDS3ExT0RmOEk5M0Q5YTlwYlFNOERYS21jeXRzNFNVbnhibFMv?=
 =?utf-8?B?ZW5ZaGl3cEpsRnAxR0M4VW9EUjNkMzZGU3VlcnJuRlluek82UVcwKzJPY2dD?=
 =?utf-8?B?b2NxdGROMHFUMU5FM1o4UkpkdFQ0SStadk5wZmc3TW54OHBvNFVZVHlJTEdi?=
 =?utf-8?B?aWl1Rm9WWUtHeGVSRm1nRkdHaDEyeUFScGcxQ1RVZDJMVVhlMVBVZzE1dThU?=
 =?utf-8?B?ZkFGaHpwYmExM3hPMHFacFNuYWdpY2UzRUpETjg4bitwVUZoVUZFaGhJMnZQ?=
 =?utf-8?B?WVp3dzBJSWlEZlRBaWNZZnFReEZUOUNsSkE2MkQxMGw1ZHk5RDgyeGl6VlBa?=
 =?utf-8?B?OWNOWmNNdjdHYisxZ0RVa0dFMitZS2tPWEc1dlU5dUFhS0NSVzZYSjFTRzdu?=
 =?utf-8?B?S2V3ekRUc04wNXdNTzdQL2ltVUFkNVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b3428-8356-437d-0af6-08dc138a3270
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 16:19:05.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8480

RnJvbTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gU2VudDogRnJpZGF5
LCBKYW51YXJ5IDEyLCAyMDI0IDEyOjA2IEFNDQo+IA0KPiDigKYNCj4gPiBFbGltaW5hdGUgdGhl
IGR1cGxpY2F0aW9uIGJ5IG1ha2luZyBtaW5vciB0d2Vha3MgdG8gdGhlIGxvZ2ljIGFuZA0KPiA+
IGFzc29jaWF0ZWQgY29tbWVudHMuIFdoaWxlIGhlcmUsIHNpbXBsaWZ5IHRoZSBoYW5kbGluZyBv
ZiBtZW1vcnkNCj4gPiBhbGxvY2F0aW9uIGVycm9ycywgYW5kIHVzZSB1bWluKCkgaW5zdGVhZCBv
ZiBvcGVuIGNvZGluZyBpdC4NCj4g4oCmDQo+IA0KPiBJIGdvdCB0aGUgaW1wcmVzc2lvbiB0aGF0
IHRoZSBhZGp1c3RtZW50IGZvciB0aGUgbWVudGlvbmVkIG1hY3JvDQo+IHNob3VsZCBiZSBwZXJm
b3JtZWQgaW4gYSBzZXBhcmF0ZSB1cGRhdGUgc3RlcCBvZiB0aGUgcHJlc2VudGVkIHBhdGNoIHNl
cmllcy4NCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNy9zb3VyY2UvaW5j
bHVkZS9saW51eC9taW5tYXguaCNMOTUNCj4gDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJl
ZS9Eb2N1DQo+IG1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni43
I244MQ0KPiANCg0KVG8gbWUsIHRoaXMgaXMgYSBqdWRnbWVudCBjYWxsLiAgQnJlYWtpbmcgb3V0
IHRoZSB1bWluKCkgY2hhbmdlIGludG8NCmEgc2VwYXJhdGUgcGF0Y2ggaXMgT0ssIGJ1dCBmb3Ig
Y29uc2lzdGVuY3kgdGhlbiBJIHNob3VsZCBwcm9iYWJseQ0KYnJlYWsgb3V0IHRoZSBjaGFuZ2Ug
dG8gbWVtb3J5IGFsbG9jYXRpb24gZXJyb3JzIGluIHRoZSBzYW1lDQp3YXkuICAgVGhlbiB3ZSB3
b3VsZCBoYXZlIHRocmVlIHBhdGNoZXMsIHBsdXMgdGhlIHBhdGNoIHRvDQpzZXBhcmF0ZWx5IGhh
bmRsZSB0aGUgaW5kZW50YXRpb24gc28gdGhlIGNoYW5nZXMgYXJlIHJldmlld2FibGUuDQpUbyBt
ZSwgdGhhdCdzIG92ZXJraWxsIGZvciB1cGRhdGVzIHRvIGEgc2luZ2xlIGZ1bmN0aW9uIHRoYXQg
aGF2ZQ0Kbm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UuICBUaGUgaW50ZW50IG9mIHRoZSBwYXRjaCBp
cyB0byBjbGVhbnVwDQphbmQgc2ltcGxpZnkgYSBzaW5nbGUgMTMteWVhciBvbGQgZnVuY3Rpb24s
IGFuZCBpdCdzIE9LIHRvIGRvDQp0aGF0IGluIGEgc2luZ2xlIHBhdGNoIChwbHVzIHRoZSBpbmRl
bnRhdGlvbiBwYXRjaCkuDQoNCldlaSBMaXUgaXMgdGhlIG1haW50YWluZXIgZm9yIHRoZSBIeXBl
ci1WIGNvZGUuICBXZWkgLS0gYW55DQpvYmplY3Rpb25zIHRvIGtlZXBpbmcgYSBzaW5nbGUgcGF0
Y2ggKHBsdXMgdGhlIGluZGVudGF0aW9uIHBhdGNoKT8NCkJ1dCBJJ2xsIGJyZWFrIGl0IG91dCBp
ZiB0aGF0J3MgeW91ciBwcmVmZXJlbmNlLg0KDQpNaWNoYWVsDQoNCg==

