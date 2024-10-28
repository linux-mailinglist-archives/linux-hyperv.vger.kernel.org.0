Return-Path: <linux-hyperv+bounces-3197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593F9B34AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3361281D43
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6A1DE2C4;
	Mon, 28 Oct 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fFyfcNn+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011033.outbound.protection.outlook.com [52.103.13.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CF1DD0C7;
	Mon, 28 Oct 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128870; cv=fail; b=E9JgawdkdFUBQIMVmLvD/QceIRw9sjl/oAVSH0J4gMKX18m5VGN0O7LK0uDWXfQG9bXdcmWVEs/kYb7qy6OD7/GgaOCr+2QFq+bdkCLfrdqm/gDROCV/2dFb483RgIUMjDhnJHgf7p4CfgfR6WYPD4VDPSSJoSNDz72XCPDxtgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128870; c=relaxed/simple;
	bh=HszIT5s7pDFJMV5/WUWRFF11lARzesZL6iRQYKdHENk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7feMIgRg0AWrGV3u30gHguRBhPBrskhwbe2Aqlcq5q6MkOcXBaautPy29SixDAKAcu12szzAKI5YFYXiOM+70kIsWmQRp0qFCWrQ4N9yyhc//YkdcLdZSONCLvYE3jMMFGDPuJNavtThTIT9Mtq1/7ZQVRXPDcjCBEJcSc+4m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fFyfcNn+; arc=fail smtp.client-ip=52.103.13.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8FEqrFc2B/QBetVoNLYKT/uRiK3Qn+patZjefbdWoVVvIcd7tfoGKZxDaKmPDwKuq/zIOV/Quf2Gtva8jx9fFl4t2MrMeCixBlxciQoB1oYlbt8c6jvaBPo+O5b0fZmEq1lPRcyMb3ipQCgOPj2ZM4TeogO7RU73iMJEPAqBHFNmnqIroLtvBSMeKMMKM/j8qFfIfzs5IZxTB3KIV1pbjW0zy1hBbI2dY62N7zzogaer1ppMOUhc9nbg1bop05QWGxSPNSII+ehNAghBUiXqyGyRSO3OugaZTkjZr8x6gVcsbY8jSCRjNVr7Df1LcNby4NoJHlp7jHAdWTB/OtXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HszIT5s7pDFJMV5/WUWRFF11lARzesZL6iRQYKdHENk=;
 b=gtSSfme+SkLsa8fYm8LIFj9YIxA4ydzfq9bH/vkPupig7NTGAD7TC+fYGxWd1DLk2Uula+iHNZziBf6Rs35se1aCFDFB6RujD+5xjAMPdyr0MDq8GWb1aWlvxb6nxPgLmrJWnBTY2Ce4KKNIxtx2Xc3mtx5CSlXhmuwuYy2EwsL9zhjIfecRnh8l5OCqEfeS0teJnLyKd8w9PjlRO9SXhrbQOjbO9+g+6bQYguL1T/B9ONp39WO+P5SRz3aqdsnaTjzwmDOUlzn6L67vNqG23pdLID2PH/e6iUasMQdAFCo7AUapdTb2av7AHx8NJE3/CxEA/XBacDTRFdjYCh+wMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HszIT5s7pDFJMV5/WUWRFF11lARzesZL6iRQYKdHENk=;
 b=fFyfcNn+VyCjKBFfLGfOZSVj83cB6smWZNVJTc4Rg0ABsQryQXwKdlM3RA/wWHbVF2HjNvJzgONAiuD0EUg7SAy1biWA2Lh5lzzegkaJtDNp+KQsxszxTei+W3kAm/dXw/sra2OlRfeX+/gX1mS0KkJq9mRThCIJTWLTcUHiIsmmMSXI41uHCCycC++NZC7Khp6jtGRK+jXC8BschFAhOLLNh0gW9AgoXyOmhseIlf23heSyKrTYYrwFGHJtS6m5ap9P/d8OwxYDib2FqOjfrr2givUWIE+hsepsqyvJePZPVJdoZHqVzSCWajYI5RmVcZkGFtpwfjB4UsDEBX+4yg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7444.namprd02.prod.outlook.com (2603:10b6:303:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 15:21:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:21:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, Naman Jain
	<namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Starks
	<John.Starks@microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
Thread-Index: AQHbIVUZK3+QpQzaU0GO9u2NqFEaQbKPwn3AgALKcYCAAIM+YIAEryvAgASV7/A=
Date: Mon, 28 Oct 2024 15:21:05 +0000
Message-ID:
 <SN6PR02MB4157D30B50EF5B58BDCBD423D44A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157F0678E2F7074A905BB64D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
 <81b0e19f-7711-4cfb-8cb1-8d4c1affc0d1@linux.microsoft.com>
 <SN6PR02MB4157FAF47E917885BFDBB9DDD44C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB1317FAD9C895C085F8872899BF4F2@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB1317FAD9C895C085F8872899BF4F2@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fab78077-b57b-488e-82c2-5d0195c2a737;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-25T17:12:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7444:EE_
x-ms-office365-filtering-correlation-id: 1b9100aa-c41c-48d6-c46f-08dcf7642408
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|8062599003|8060799006|461199028|56899033|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 IpYNgEm9pOvxvEAsHW5xyCWMeyiVV2w2bBqpiTyA1487vPpGIfjeY9VV2VpdswIlPT6wgax2u7MHEtAMkydCYESQZekdIwtjSJVUIFZN64bp0nzCdwl81xHANoWc0f+D5f0bHJsi2Et7AL+65QNi9lY5fUJx3IQ9gmOpBohJGBTpDjgS8V1Z/vr5tK8klSdrsSmM7GXWuGy5UmazbmCG+dtP4r91CvFww56qOjSUCxcxROa9bW/7TSiiIJaB2pvq5wQ2bDa065Rkyq/LMaOJ/TyQQziq+hXs8xVAyrCebApKoJSZFovPdnOt00Ogp4MOvdGwq3mmfG6AwNHG4Q7mqbsiaHPZhp8maC1hjr+pWWOywvBEQzFWwwYRkFHIpeQ6UcmuKUz8vdGBhW9f5q75n0jfsJLm7KWhNV00JwnMvOjeWAEMiCbFBfnwbclr2biTqj3svbofKdGLkGEywqmZTbgZthz02YIM2qUsIyIt01vxyHp+T4NAOm9j4rBZNdyrbbaRmmc0qLzUM5lux7jZilAVnfhDrwyWrubget5o1y9hjIxRmNCOD1epj1OusPWD1NNvW2KSYzG6KaLqj/iMuYyfcg63Eq7zLRuINWhIeUf2OUP+ioUVRw25jCXhd6iPIwlGKtvAZ0zKFX2S3TR7nXg5xeHcWXO7oDG9nq95GCPgk5NBgd6P6wv/XLVpM6HuOqf90Wvb1a5j6bck/+TrQg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmpieWIyQ1E2T2pqWnBGTXVTaXZFUk0xaE5QVXhFd0thb2VPZXdGMEpIcW9v?=
 =?utf-8?B?TTdad29TcGlVQVlCT0NjTHVNeklFRTF4b0dlMkxrU2FsQXNoRjh3SzNrWWZx?=
 =?utf-8?B?aUQ0MytIUW5Cd0dtUUNDdUM3NXo4OWcrZVFjZ3NFblVVUHBFNnNPODJwYjhX?=
 =?utf-8?B?MlMwQlhTc2pHSWsrU29oQ1NnSU1icXdvblNGNSt3NzM2TjYxUDdlcVBTTzFW?=
 =?utf-8?B?RjMrVVR2dzBLcExvTTFORS82ZVh3UGhmUDVlTjI3dlgvWkdpZ05oR3dybGZM?=
 =?utf-8?B?dTAxM0JLdkFYNGlqRlFyTHRZWjhlV2VVQ1N5RHEydEdsZ1NCTnB3T250S0ho?=
 =?utf-8?B?MEFHdkdMejk5TUJieGsrV2hxa0s5cEFUMlhxSGVTczBVT2Q1OTY5MFpHNURN?=
 =?utf-8?B?NlVTRDdHamJpWXV4V0NsMHJUcEplWmlqM1YyUE0wT2tFQTdXd0lsQU8rYUlY?=
 =?utf-8?B?TmltcDhUa05UcDBVNUxSUGpscm9WdS9LQnIvL3creXZZVC9VeHlTdjQrcDI1?=
 =?utf-8?B?Zlp2QkUzdzBud1c3cTQyWjRKaERtWmR1SXdHUlprdnpBbDZJc1kzWVRwSVpJ?=
 =?utf-8?B?d1FxY3RuMmljWm9YeGxpaUN0QzlPTHl2aTFJNm1lV3ZuYWJoWVRxTHE3Y0JV?=
 =?utf-8?B?Uk5KUlYxQ01Wb1FLcCt0UE1ib3AxeHpVMzZpdDFKYkU0SW1kcXY3ZWRVY3lC?=
 =?utf-8?B?a2llZGYzc1BQUjFhRW9jVGhSc3pydzZqNVNxeW5BZE53aERZU3VlSkxTa3hr?=
 =?utf-8?B?V014MGJtRW5hOTFzMjA2VE1vc2FtcURzOWZ1TStXTmJ6QjNLL2pNOEZ3TEpi?=
 =?utf-8?B?NHJHYWt6MWFQMnVnak1HWTE0YWhtVno0VW8zVGNYNWgrRDVLNjFPemRhZW1m?=
 =?utf-8?B?OWpSTFlpYlpOYkp3dnlHT0FIdkNXeGhlZ1loSHhtanNKRUcvNjJKaW1RdTFq?=
 =?utf-8?B?RHZlMVBZN1A2eEN4ZVg1dEpWTXpCTVJGdmZLQkZrZU1jalV2TmNFR1BlSzBF?=
 =?utf-8?B?c3IzU0Z6TURudXhJcUdYVS9sVnhDWlVwWUpVVjNyZElxMFpEZCthSzBoei82?=
 =?utf-8?B?UjhmSkJxbGh0OXJDTVoxUE9xOTRXemNITk1pamJocUxFYlZxcEhlUi81cGxl?=
 =?utf-8?B?SlcxRDAzY2lWS3hRbUJWVFB6d240a3grU2xCd0xYYjh5SS9LZ2RJTVJsdzJN?=
 =?utf-8?B?Q0lBaXBIRWlMQzBVSlNJcjN3c0luYjRnZnpHZmx0eis3RzVLb0JWcnlsa3Bh?=
 =?utf-8?B?bWlBZHdxYXVmZytlejVhWXVHcHVpRVdWUm83U3BjMkFvbWg2ZXorZjdzSkpl?=
 =?utf-8?B?ODY5S2p0dWc2Q1VCZVM0a2hQd0JSWUR5TzRCb0krcGUxZmtJUmkvZ3JZbXBL?=
 =?utf-8?B?ZkhGdzN3L1hEN0RNMlp3eXFWbXUzOXQvYWJUOTg0YkVHSnZqeG84eUVtdGVW?=
 =?utf-8?B?cXhWV2tlL1NqZENBekVFUm94OHVhcWJQUGJnLytJNkIwak0veG9HbktRMTZj?=
 =?utf-8?B?bk9pZzdVQWlLckoxRGVqR2l1WDk1WVJIRzRrRmVkUmRBM0h1NXRpdktaMFlz?=
 =?utf-8?B?K0FTaTlOWU9BQ3Uzbk9TNGFEU3AwZlFOSU8ySUNuUWpBOTNhRS95QU9Md2F6?=
 =?utf-8?Q?aFLayhk1s5Q2zXeRrUcEqQE/2DFRxysJweWW/eyBRVQ4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9100aa-c41c-48d6-c46f-08dcf7642408
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:21:05.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7444

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDI1LCAyMDI0IDExOjE5IEFNDQo+IA0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5IDxtaGts
aW51eEBvdXRsb29rLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIyLCAyMDI0IDEx
OjA0IEFNDQo+ID4gWy4uLl0NCj4gPiBJIHdhc24ndCBhd2FyZSBvZiB0aGUgVkYgaGFuZGxpbmcu
IFdoZXJlIGRvZXMgdGhlIGd1ZXN0IG5vdGlmeSB0aGUNCj4gPiBob3N0IHRoYXQgaXQgaXMgcGxh
bm5pbmcgdG8gaGliZXJuYXRlPyBJIHdlbnQgbG9va2luZyBmb3Igc3VjaCBjb2RlLCBidXQNCj4g
PiBjb3VsZG4ndCBpbW1lZGlhdGVseSBmaW5kIGl0LiAgSXMgaXQgaW4gdGhlIG5ldHZzYyBkcml2
ZXI/IElzIHRoaXMgdGhlDQo+ID4gc2VxdWVuY2U/DQo+ID4NCj4gPiAxKSBUaGUgZ3Vlc3Qgbm90
aWZpZXMgdGhlIGhvc3Qgb2YgdGhlIGhpYmVybmF0ZQ0KPiA+IDIpIFRoZSBob3N0IHNlbmRzIGEg
UkVTQ0lORF9DSEFOTkVMT0ZGRVIgbWVzc2FnZSBmb3IgZWFjaCBWRg0KPiA+ICAgICBpbiB0aGUg
Vk0NCj4gPiAzKSBUaGUgZ3Vlc3Qgd2FpdHMgZm9yIGFsbCBWRiByZXNjaW5kIHByb2Nlc3Npbmcg
dG8gY29tcGxldGUsIGFuZA0KPiA+ICAgICBhbHNvIG11c3QgZW5zdXJlIHRoYXQgbm8gbmV3IFZG
cyBnZXQgYWRkZWQgaW4gdGhlIG1lYW50aW1lDQo+ID4gNCkgVGhlbiB0aGUgZ3Vlc3QgcHJvY2Vl
ZHMgd2l0aCB0aGUgaGliZXJuYXRpb24sIGtub3dpbmcgdGhhdCB0aGVyZQ0KPiA+ICAgICBhcmUg
bm8gb3BlbiBjaGFubmVscyBmb3IgVkYgZGV2aWNlcw0KPiANCj4gV2hlbiBhIGhpYmVybmF0ZWQg
Vk0gcmVzdW1lcyBvbiBhIGRpZmZlcmVudCBob3N0LCBpdCBsb29rcyBsaWtlIHRoZSBob3N0IHRl
YW0NCj4gdGhpbmtzIHRoYXQgaXQncyBkaWZmaWN1bHQgdG8gcmVtZW1iZXIgdGhlIFZNQnVzIGRl
dmljZSBJbnN0YW5jZSBHVUlEIGZvciB0aGUNCj4gVkYsIGFuZCB1c2UgdGhlIHNhbWUgR1VJRCBv
biB0aGUgbmV3IGhvc3QuIFdoZW4gdGhlIG5ldyBob3N0IHVzZXMgYSBuZXcNCj4gSW5zdGFuY2Ug
R1VJRCBmb3IgdGhlIFZGLCBhIFdpbmRvd3MgVk0gcGFuaWNzLCBhbmQgYSBMaW51eCBWTSBwcmlu
dHMgYQ0KPiB3YXJuaW5nIGFuZCBJSVJDIGxvc2VzIHRoZSBhYmlsaXR5IHRvIGhpYmVybmF0ZSBh
Z2FpbiBkdWUgdG8gYSBjaGVjayBpbiB0aGUNCj4gVk1CdXMgZHJpdmVyLg0KPiANCj4gU28sIGFz
IGEgd29ya2Fyb3VuZCwgdGhlIGhvc3QgdGVhbSBkZWNpZGVzIHRvIHJlbW92ZSB0aGUgVkYocykg
YmVmb3JlDQo+IGFza2luZyB0aGUgVk0gdG8gaGliZXJuYXRlLiBUaGUgc2VxdWVuY2Ugb2YgYSAi
aG9zdC1pbml0aWF0ZWQgVk0gaGliZXJuYXRpb24iDQo+IGlzOg0KPiAxKSBhIHVzZXIgY2xpY2tz
IHRoZSAiSGliZXJuYXRpb24iIGJ1dHRvbiBvbiB0aGUgcG9ydGFsIChvciB1c2VzIHRoZSBlcXVp
dmFsZW50DQo+IGNtZCBsaW5lIG9yIEFQSSkuDQo+IA0KPiAyKSBJbnRlcm5hbGx5LCB0aGUgaG9z
dCB0ZW1wb3JhcmlseSBkaXNhYmxlcyBBY2NlbE5ldCBmb3IgdGhlIHZOSUNzLCBpLmUuIHNlbmRp
bmcNCj4gUENJX0VKRUNUIGFuZCBSRVNDSU5EX0NIQU5ORUxPRkZFUiBmb3IgZWFjaCBWRi4NCj4g
DQo+IDMpIFRoZSBndWVzdCByZXNwb25kcyBhY2NvcmRpbmdseSwgaW5jbHVkaW5nIHNlbmRpbmcg
UENJX0VKRUNUSU9OX0NPTVBMRVRFDQo+IGFuZCBDSEFOTkVMTVNHX1JFTElEX1JFTEVBU0VELg0K
PiANCj4gNCkgT25jZSB0aGUgaG9zdCBrbm93cyB0aGF0IEFjY2VsTmV0IGhhcyBiZWVuIGRpc2Fi
bGVkIGZvciB0aGUgVk0sIHRoZSBob3N0DQo+IFNlbmRzIGEgInBsZWFzZSBoaWJlcm5hdGUiIG1l
c3NhZ2UgdG8gdGhlIGd1ZXN0IHZpYSB0aGUgU2h1dGRvd24gSUMuDQo+IA0KPiA1KSBUaGUgZ3Vl
c3QgcHJvY2VlZHMgd2l0aCB0aGUgaGliZXJuYXRpb24sIGtub3dpbmcgdGhhdCB0aGVyZSBhcmUg
bm8gb3Blbg0KPiBjaGFubmVscyBmb3IgVkYgZGV2aWNlcyBhbmQgYXNzdW1pbmcgbm8gbmV3IFZG
IHdpbGwgYmUgb2ZmZXJlZCBkdXJpbmcgdGhlDQo+IGhpYmVybmF0aW9uIG9wZXJhdGlvbi4NCj4g
DQo+IDYpIFdoZW4gdGhlIFZNIGZpbmlzaGVzIGhpYmVybmF0aW9uIGFuZCBwb3dlcnMgb2ZmLCB0
aGUgaG9zdCBpbnRlcm5hbGx5IGVuYWJsZXMNCj4gQWNjZWxOZXQgZm9yIHRoZSBWTSBzbyB0aGF0
IHdoZW4gdGhlIFZNIHJlc3VtZXMgb24gYSBuZXcgaG9zdCwgdGhlIG5ldyBob3N0DQo+IGNhbiBv
ZmZlciBhIFZGIHdpdGggYSBkaWZmZXJlbnQgVk1CdXMgZGV2aWNlIGluc3RhbmNlIEdVSUQuDQo+
IA0KPiBUaGUgYWJvdmUgaXMgZm9yIGEgImhvc3QtaW5pdGlhdGVkIFZNIGhpYmVybmF0aW9uIi4N
Cj4gDQo+IEN1cnJlbnRseSwgdGhlIEF6dXJlIHRlYW0gZG9lc24ndCBzdXBwb3J0IGEgIlZNLWlu
aXRpYXRlZCBoaWJlcm5hdGlvbiIsIHdoZXJlDQo+IHRoZSBob3N0IGhhcyBubyBvcHBvcnR1bml0
eSB0byB0ZW1wb3JhcmlseSBkaXNhYmxlIEFjY2VsTmV0LiBNYXliZQ0KPiAiVk0taW5pdGlhdGVk
IGhpYmVybmF0aW9uIiBjYW4gYmUgc3VwcG9ydGVkIHdoZW4gTUFOQS1EaXJlY3QgaXMgdXNlZCAo
aS5lLg0KPiBubyBtb3JlIE5ldFZTQyBOSUNzIGFuZCB0aGVyZSBhcmUgb25seSBNQU5BIFZGIE5J
Q3MpOiBpbiB0aGlzIHNjZW5hcmlvLCBJDQo+IHN1cHBvc2UgdGhlIGhvc3QgbXVzdCByZW1lbWJl
ciB0aGUgTUFOQSBWRidzIFZNQnVzIGRldmljZSBJbnN0YW5jZSBHVUlEDQo+IGFuZCB1c2UgdGhl
IHNhbWUgR1VJRCBvbiB0aGUgbmV3IGhvc3QuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBpbmZvcm1h
dGlvbiwgRGV4dWFuISBJJ20gdGhpbmtpbmcgYWJvdXQgaGliZXJuYXRpb24NCmEgYml0IG1vcmUs
IGFuZCBwZXJoYXBzIHdpbGwgd3JpdGUgYSBMaW51eCBrZXJuZWwgZG9jdW1lbnRhdGlvbiB0b3Bp
Yw0KdW5kZXIgRG9jdW1lbnRhdGlvbi92aXJ0L2h5cGVydiB0aGF0IGNvdmVycyB0aGUgZnVsbCBz
ZXQgb2Ygc2NlbmFyaW9zLg0KVGhlIEh5cGVyLVYgaW50ZXJhY3Rpb25zIGFuZCBhc3N1bXB0aW9u
cyBhcmUgbW9yZSBjb21wbGV4IHRoYW4gSQ0KaGFkIHJlYWxpemVkLiBHZXR0aW5nIHRoZW0gZm9y
bWFsbHkgZG9jdW1lbnRlZCBzaG91bGQgYmUgaGVscGZ1bCBpbg0KdGhlIGxvbmcgcnVuLg0KDQpN
aWNoYWVsIA0KDQo+ID4gPiBUaGUgYmVoYXZpb3Igd2Ugd2FudCBpcyBmb3IgdGhlIGd1ZXN0IHRv
IGhvdCByZW1vdmUgdGhlIE1MWCBkZXZpY2UNCj4gPiA+IGRyaXZlciBvbiByZXN1bWUsIGV2ZW4g
aWYgdGhlIE1MWCBkZXZpY2Ugd2FzIHN0aWxsIHByZXNlbnQgYXQgc3VzcGVuZCwNCj4gPiA+IHNv
IHRoYXQgdGhlIGhvc3QgZG9lcyBub3QgbmVlZCB0aGlzIHNwZWNpYWwgcHJlLWhpYmVybmF0ZSBi
ZWhhdmlvci4gVGhpcw0KPiA+ID4gcGF0Y2ggc2VyaWVzIG1heSBub3QgYmUgc3VmZmljaWVudCB0
byBlbnN1cmUgdGhpcywgdGhvdWdoLiBJdCBqdXN0IG1vdmVzDQo+ID4gPiB0aGluZ3MgaW4gdGhl
IHJpZ2h0IGRpcmVjdGlvbiwgYnkgaGFuZGxpbmcgdGhlIGFsbC1vZmZlcnMtZGVsaXZlcmVkDQo+
ID4gPiBtZXNzYWdlLg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIGl0J3MgYSBnb29kIGlkZWEgdG8g
YWRkIG5ldyBjb2RlIHRvIHRyeSB0byByZW1vdmUgYW4NCj4gc3RhbGUgTUxYIFZGIHNpbmNlIHRo
ZSBzY2VuYXJpbyBzaG91bGQgbm90IGV4aXN0IG9uIEF6dXJlIG5vd2FkYXlzDQo+IChjdXJyZW50
bHkgdGhlIGhvc3QgdGVtcG9yYXJpbHkgZGlzYWJsZXMgQWNjZWxOZXQgZHVyaW5nIGhpYmVybmF0
aW9uIHNvIHRoZXJlDQo+IHNob3VsZCBiZSBubyBzdGFsZSBNTFggVkYgdXBvbiByZXN1bWUuKQ0K
PiANCj4gT24gYSBsb2NhbCBIeXBlci1WIGhvc3QsIGFmdGVyIGEgVk0gaGliZXJuYXRlcywgd2Ug
Y2FuIG1hbnVhbGx5IGRpc2FibGUNCj4gQWNjZWxOZXQgKGkuZS4gTklDIFNSLUlPVikgZm9yIHRo
ZSBWTSwgYW5kIHRoZSBWTSB3aWxsIHNlZSBhIHN0YWxlIHVucmVzcG9uc2l2ZQ0KPiBNTFggVkYg
dXBvbiByZXN1bWUuIEl0IHdvdWxkIGJlIHRyaWNreSB0byBjbGVhbiB1cCB0aGUgVkYgZ3JhY2Vm
dWxseToNCj4gd2Ugd291bGQgaGF2ZSB0byB3YWl0IGZvciB0aGUgcmVzdW1lIGNhbGxiYWNrIGlu
IHRoZSBNZWxsYW5veCBWRiBkcml2ZXINCj4gdG8gdGltZSBvdXQgb24gdGhlIHVucmVzcG9uc2l2
ZSBWRiAodGhpcyBjYW4gdGFrZSAxIG1pbnV0ZSkgYW5kIGNsZWFuIHVwIHRoZQ0KPiByZWxhdGVk
IFZNQnVzIHBhc3MtdGhyb3VnaCBkZXZpY2UgYmFja2luZyB0aGUgVkY7IHdoYXQgaGFwcGVucyBp
ZiBhDQo+IGhvc3QtaW5pdGlhdGVkIG9yIFZNLWluaXRpYXRlZCBoaWJlcm5hdGlvbiBpcyB0cmln
Z2VyZWQgZHVyaW5nIHRoZSAxIG1pbnV0ZT8NCj4gSSBzdXNwZWN0IHRoZXJlIG1heSBiZSBzb21l
IHRyaWNreSByYWNlIGNvbmRpdGlvbiBpc3N1ZXMsIGUuZy4gd2UgbWF5DQo+IG5lZWQgdG8gZmln
dXJlIG91dCBob3cgdG8gc3luY2hyb25pemUgdGhlIC5yZXN1bWUgd2l0aCB0aGUgLnJlbW92ZSBj
YWxsYmFja3MNCj4gb2YgdGhlIE1MWCBkcml2ZXIuDQo+IA0KPiBJIHRoaW5rIHRoZSBnZW5lcmFs
IGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgVk0ncyBjb25maWd1cmF0aW9uIHNob3VsZCBub3QNCj4g
Y2hhbmdlIGF0IGFsbCBhY3Jvc3MgaGliZXJuYXRpb24sIGJ1dCBpdCBsb29rcyBsaWtlIHRoaXMg
YXNzdW1wdGlvbiBpcyBmb3VuZA0KPiB0byBiZSBmYWxzZSB1bmRlciBzb21lIGNvbmRpdGlvbnMg
ZnJvbSB0aW1lIHRvIHRpbWUuLi4gSSB3aXNoIHRoZSBhc3N1bXB0aW9uDQo+IGNhbiBiZSBhbHdh
eXMgdHJ1ZSB3aXRoIE9wZW5IQ0wuDQo=

