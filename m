Return-Path: <linux-hyperv+bounces-3580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37010A02D73
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98403A69E1
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA51448F2;
	Mon,  6 Jan 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FNoxHQh7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010079.outbound.protection.outlook.com [52.103.2.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1E50285;
	Mon,  6 Jan 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179860; cv=fail; b=Uk/4GY/h4O/mmsGZC11aOQr+SkA3laLhAMhc1dJ+8zgXKaqumN2/2wvRr30RZvg1P0YMPZKRLAzaD9UhoqoJTkm4YldkjETSPuh4rmncEcbu3rtFgRJqx0iBD80AsHlylg875PDeWnyXlzrZeQZSeEs8pkv5dwGs6O3H2nIoiq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179860; c=relaxed/simple;
	bh=iWTkw3+/UIia/rEvbVSYgjjdyDvoIw0Kh8Gj/qNVaTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbdGIFV1LWFtfPjG7JpWe2CDIGiVlNr3X33SToB+PzwbtHbIRdAIQbJMaoBjbtUSlzRGBdxRzETzvXFEfDL0p8Wv6opX56oSro1peUL02HY+Uz6HlVSSjj6aRV7cn760hO/Seo54R1f3eElpRwi6nVrboQbisRm6lk+Y9pmPfm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FNoxHQh7; arc=fail smtp.client-ip=52.103.2.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF38nrdxhpeCgbb0/l6AZri7twqPgjQB4a4SKtY73jLGy1/PZ+Flm0f57nrcqSWNEtW9nefZhrU/u5aD/OrUx/6Dh3Pp3S6T2TfiQ+zNzxigZQr89QHBaUJh8jLoAqSQP6xVaV6wc6zbttDg6bvKvN+YK4P1XyJlCtcfwZ5SWnT3YYZHZNeeGDLIhZtVztAMmEdgJk96Gc+wLEIGzDwE+ARoEyylanKfHpyxBvR/U1cXQu0e8+vtd373DNouzV+MGlSMwyS0xpD5BkqXUllrlbQ69TVP762ivBTbcB3yK9InyzQfgkvZAV1H4S5MW4pVHiWiZSliiMNVAhUq3FMhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWTkw3+/UIia/rEvbVSYgjjdyDvoIw0Kh8Gj/qNVaTU=;
 b=Ms1tPvk/xnswRiRa/eIUdvxWxEYVhNNUGUJJ4+sWUM+yTW2oFvHR4UBQ29tPdW0opLj/+lc81gTpt2OM3u8d+WHRm0VAgITlqiQoOufDegYetJqzcY+udunSnuSXE1vWkN7XUS1epFKid+8jenxi0O1PNey+f2gNsgNJLpozpbTZtt2Kp2idjacQu4wTKegIrFxabNfm9hn2QmAmkuOb1vrqFjxg3WJbI51cDC7vymP9uEOZs6TlOXcJDTuaMY588CgVKuvKhQGeRGGvjrZPbgNOB+GfhMvClRHI2AjjIrE4QEimOA4KCz6k7rEwxFeBjW8i/WFayDCG5nyiA0PJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWTkw3+/UIia/rEvbVSYgjjdyDvoIw0Kh8Gj/qNVaTU=;
 b=FNoxHQh7gK1YURr6elr3rQNi+aRvvJ3NfCSvWaIlIWS7AJIQbbQzgy/B7yZrFECw7jlt8oFc1XPSBvN7GXMPvdCnCWbei5JK8KoIOz1JeH/UNh/tSrsy/huBh4mB7Fv/cYrhPv7V+162TI2wVlVI1tMPGr4WpV1sprPhFZnT6eBmL0MkvYZOuy0EhfBp8JYwnCcwV0uDfrrqgsGpVmK42WMsxV4Fdhi5NHDtefYObOezgrtQVjrs598cIX+b9Hvq8HSyC34wOMgi05IDwfF+JjYw3GNTWqugdz1yHv/g0WoqkFtHvktixcmFz9ego03Mjs1Fp7oHuseGK+9uZGRnIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6918.namprd02.prod.outlook.com (2603:10b6:610:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 16:10:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:10:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alex Ionescu <aionescu@gmail.com>
CC: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Roman Kisel
	<romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
	<apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Topic: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Index: AQHbWuYCjpxLpvSze0qhquwoWcqvGbMFcy0AgAAtWgCABDzjgIAAAl8AgAASe0A=
Date: Mon, 6 Jan 2025 16:10:55 +0000
Message-ID:
 <SN6PR02MB4157711BFA3440C8274AB39BD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJ-90NKKfF-KcWJ7sdMCXK9fWiXwMG-9xtjQn9fVhXgjRinZbA@mail.gmail.com>
 <CAJ-90N+uyZETZnAOCo03YRm=8as5d_dbO1VObfgYp=4AxBEH3A@mail.gmail.com>
In-Reply-To:
 <CAJ-90N+uyZETZnAOCo03YRm=8as5d_dbO1VObfgYp=4AxBEH3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6918:EE_
x-ms-office365-filtering-correlation-id: 30d94921-9b28-45bb-6b97-08dd2e6cb30e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|19110799003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTJ4SExDVWRtT05PcktxUEJSMVVVbUgvekhCa2tSbm5TM1ozVFFXUVkyUStr?=
 =?utf-8?B?ZkRTcGt2M3BVb3l1R0kxVzkrWmFQWFp2RWl5R0hKZUhkS0lwVHdvc3FGVTI5?=
 =?utf-8?B?VldnaUpZTnI5bk14TTlrbGNzdGVKaFZUZ0pzS3dMNGRvdjFaRnliUWprQVpZ?=
 =?utf-8?B?dk1GTkJFQ3BYUzgvaS9UQWtIYUExbTBiTkJoSHRzOUVUekNVVjZoWE5lS0Zh?=
 =?utf-8?B?ZTBqUDdpSlVzbXdIUGRzbkRwOUFJbWxTdlB1SjhUL2s2Qkw0ODloV3pIUjZ6?=
 =?utf-8?B?NUg5SHlxVWQrVFpVS1dQSUFYdVJoYjRHYlN4MnNzbzZBVFRoNjJvb2JBQmF2?=
 =?utf-8?B?U3JxL2N2QXYra0RZV1BiZGtBWThKUS95ZlZlTUdPc3RtZ2F4MllRZTQzak9a?=
 =?utf-8?B?dGpxOWdXV1VUMUVkMFM1c0J6cHF0cVcxV2V1QlJEdDcxeTFGem01NTJ3MVlz?=
 =?utf-8?B?TkgvcWE1dThqU1loYkw1aXJPbjZjY2lBODJUMEpzeTRsNXBxRWJsYU9UbnYy?=
 =?utf-8?B?VURQYk1uVHdnT1lwYWhjNEJqL3Rob0RETkp1RkptWnpIVUw0cGpDNUhQd0Ji?=
 =?utf-8?B?VXorS3ZuNjBuV0ZhMkJGNFpvaTRNaysrYmxYK0RjQ2Qxei85WlhWMnd1cG5U?=
 =?utf-8?B?bUdMU1dsTDN2NFZLdDRxa3J0bURUM2JKWXc0ckpSc29uUE15VnJab1Z6bzlC?=
 =?utf-8?B?dEc2bDgwQU9vWEdqQ05Ha3d2T0o4R3YveElwbXNhbTB3b05aeHk5d2w3K3Ry?=
 =?utf-8?B?YW5YYTd4aDB3NUZieW16ZTU3S0N3MFVBcUl3b243ODRYYmJyRVN6Mkk3Qzdy?=
 =?utf-8?B?R3l3Y1BLeVROU0hqaHRhUlpXSTFqaW5ud1l4d0hPclFzVm1IUU9wQ2srZEVN?=
 =?utf-8?B?SVJiN2IzRlhCM05iUkF1bGYxRmdFSlhueUNuczdqWU9IbnNscU1RRjhRS0Q4?=
 =?utf-8?B?bCt0My9JWmJjd0NtY3JtNGVybTFHdndld3ZTdGhRUXkwWWNQU01qQ0VJcWZy?=
 =?utf-8?B?SXN1M3FrK1lSVnZKaStNTkJ0bXRDVlJtVmQxVVhTZm85WXNuc3BMMU9iMzVn?=
 =?utf-8?B?U2tldG1wSmZMOHJmMUUxSVFnRzBnQ1BCTXZmbWtvT3ZJdkZjYnB2Nm9MMmx5?=
 =?utf-8?B?L3RzcldWdjByeTdKTGdaUjhTeDd6dCtCbnN3T09sTUpraGdzQ2xkdGFDc05N?=
 =?utf-8?B?emJPTXJrRDkzOWtTUVNISUxaZzlmbjBwYWNJVWJ3anFoQVpubFBMTWtETkQ4?=
 =?utf-8?B?K0pqUVU0a1VmSjdLK05PVWxzUXIxMGZuQnFLMER5NHJwWS9uUmo3Q0hQNWtE?=
 =?utf-8?B?cXJscExGY3JGRVZGZmlBNS9qVWkxdDEySXl2QzlPM0dmbGdQYmNRL2QwZDNz?=
 =?utf-8?Q?qwxWbtSEnZd2UAH0jyJvWcQlitKvxAUk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHcyRVg3NHFnWVF5Q0hhOU5lNHNxbm4zMWY3QURwQWsyWnV1aVlLUnluenRj?=
 =?utf-8?B?VkF4cUp5U3NaanMxQnlQV3JrdTBRcS90K2RaVVZrdC9lQlZZTFRLeFF3dVZs?=
 =?utf-8?B?bzJVZWFxTEl4NE5kTG4xRTcyVlY0SkZMd3QvSlVFR1VFVzFHVDhXdzh1RTRo?=
 =?utf-8?B?SjNZMUpiTFZmMitwZGZlN3YxSDlZUFBMVVZObk5pdnBRK3RNUEtMVzVKZ2c5?=
 =?utf-8?B?ZG9VRE01QjBIT3o3SHU1OHZrOG8xYk9BM3IzUk0zRzZoR1BKMDJrWDd5TEtP?=
 =?utf-8?B?ZmtyLzczcHBiS2lNd0FTaHMvYWdTQURxcXF6WGgzN1EyeXNmeGJlQmtka0VU?=
 =?utf-8?B?TEdBM0lhaTMvdzZ0N1I2Z2hDOTNKcUlFVXRJZkVzQkc2VXFHQ2lyZjZQTERs?=
 =?utf-8?B?dHdSVGkrM096aTREcFd2WENaL2VicUE3K3lCd3FkWDZTRzVEK2t2NXFGdmEw?=
 =?utf-8?B?RGllNExlM0dBU0JneGdFbVJiaDRseUJsSDF3ODlUQS8yZFFkQm1kdkY3VWUw?=
 =?utf-8?B?YXRPK1dMSTh5V1hWeFFiVVB0djFoM0U4SkJKRkQwNXlsZlQ4dklLa25EbHhU?=
 =?utf-8?B?QlBhUkdyS0thY2ZlSU03Y2Z0ZUZZZnp5YUhFVStGc2VzUUhraTcwbkpjYnBx?=
 =?utf-8?B?L1VtQm9HK0UwVVdHbjZ5Y01nWGMrQmdqSSs5WGxiSy9CVUFzbDdnTVhTcGtp?=
 =?utf-8?B?NStwSmwrSHBWZVRsYWd4ZWE2dXRhanVoMmZBNTlXcjh0d2hpdy9pZExkbXRE?=
 =?utf-8?B?azN0ZmFmODZyTG9zbFBFRVEvazhaMEtOb1RhMnNPd05OZ2h6V2x0b2F3OHJQ?=
 =?utf-8?B?QmJReEpoakFENnNYa2xEU1hIVUp1WFZYb0NqVllid0t3UUVjczV3WGozdy9V?=
 =?utf-8?B?ZHNBZGZBZFNpb3JOWEVJWTV1eU1KMWNPVU1zYjZUUHZ5QStzYUhYNGRudGo5?=
 =?utf-8?B?cG1McEdzWDZPUGZvSUt0d0ozVW5PZkJwN2VheTR5a2VxdEp2L09IU05aeHJQ?=
 =?utf-8?B?M2VDR3N0c1Vxa0x6VHVMc1N5S1U0VUROT2VFYWV2bXhGWXFwMU9QVmFOMzJ1?=
 =?utf-8?B?TndQWkJhZTZuN3dsc1dUUVRGaklvOEM1SVNJaGVTamRkbmhLeUQ0TlE3c1B1?=
 =?utf-8?B?RlV5THZxbFJRdVUvTmdmQ3FKVEl1UUMwQzUwWWRjck5ha21Oa1JlY29ZMm95?=
 =?utf-8?B?L0pRbTd2eENnT1dGQVpqQkVsVll6aTRLZjNpbnpxZUdFMHdZSGxvNGN2WG9l?=
 =?utf-8?B?RXlwK1Aya3dBSU5rSFZrenUvcDc0UE16cjMxN3BZaHhMa2NCQ2pQMHl6cmtv?=
 =?utf-8?B?WVJ2ZGdkUTl4N0RsTjhZTXllSFIwd0ZlTW93Q0tSYlR0dTloMlVMdFprVG8w?=
 =?utf-8?B?ZVgyZWFTVWxNL1ZyRXMxY05Mc1FwaWJvRnNyU1F0dHFHZzlRaXRYbUxoRTgy?=
 =?utf-8?B?YVV5LzVoUm5qbU5vR3JOTUI0aXY0SERXbmR2SGFqaVpvME9mVFcvOEVNVkM4?=
 =?utf-8?B?eW81L2tnYmR4eTVMeFkwMmh2aG5MWjhlVmFmSi9sWmREM3FWNnZ4WXg1QUhu?=
 =?utf-8?B?NzFFSzV3endlaVMvNTZ2QjYzRFV6NXN5MFM3TXlEcHlnSTJPYXU1UUhuektG?=
 =?utf-8?Q?EH1gof/Me19ynUIYQ+FV7TPcZzjHuv5xCONDwiJHGij4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d94921-9b28-45bb-6b97-08dd2e6cb30e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 16:10:55.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6918

RnJvbTogQWxleCBJb25lc2N1IDxhaW9uZXNjdUBnbWFpbC5jb20+IFNlbnQ6IE1vbmRheSwgSmFu
dWFyeSA2LCAyMDI1IDY6NTQgQU0NCj4gDQo+IEZvciBhbm90aGVyIDJjIHdvcnRoLCBJIGhhZCBw
cmV2aW91c2x5IHJlcXVlc3RlZCAjMSAoYWx3YXlzIGFsbG9jYXRlDQo+IG91dHB1dCBwYWdlKSBh
cyB0aGlzIHdvdWxkIHNpbXBsaWZ5IHNvbWUgZnVydGhlciB3b3JrIEkgd2FzIGludGVyZXN0ZWQN
Cj4gaW4gYXQgc29tZSBwb2ludCB0byBwcm92aWRlIFZTTS1saWtlIGZ1bmN0aW9uYWxpdHkgdG8g
YSBWVEwgMCBMaW51eA0KPiBndWVzdCwgd2hpY2ggd291bGQsIGF0IHRoYXQgcG9pbnQsIG5vdCBt
YWtlIGl0IHdhc3RlZnVsIGZvciBWVEwgMCBhbnkNCj4gbG9uZ2VyIChzaW5jZSBzb21lIHJlcXVp
cmVkIGh5cGVyY2FsbHMgZm9yIFZTTSBzdXBwb3J0IG5lZWQgYW4gb3V0cHV0DQo+IHBhZ2UpLg0K
PiANCj4gSSByZWFsaXplIHRoaXMgaXMgImZ1dHVyZS1wcm9vZmluZyIgc29tZXRoaW5nIHRoYXQg
ZG9lc24ndCBleGlzdCB5ZXQNCj4gYnV0IGl0IHdvdWxkIGF2b2lkIGEgZnVydGhlciBjaGFuZ2Ug
ZG93biB0aGUgcm9hZC4NCj4gDQoNCkFsZXggLS0NCg0KSSdtIHByb3RvdHlwaW5nIGEgbmV3IGFw
cHJvYWNoIHRvIG1hbmFnaW5nIHBlci1jcHUgbWVtb3J5IGZvcg0KSHlwZXItViBoeXBlcmNhbGwg
aW5wdXRzIGFuZCBvdXRwdXRzLiBUaGlzIG5ldyBhcHByb2FjaCBkb2VzbuKAmXQgaGF2ZQ0KZXhw
bGljaXQgImlucHV0IiBhbmQgIm91dHB1dCIgcGFnZXMsIGJ1dCBtYXkgc2hhcmUgYSBzaW5nbGUg
cGFnZSBmb3INCmJvdGggaW5wdXQgYW5kIG91dHB1dCAod2l0aG91dCBvdmVybGFwcGluZywgYXMg
cmVxdWlyZWQgYnkgdGhlIFRMRlMpLg0KVGhlIGdvYWwgaXMgdG8gYWJzdHJhY3QgYW5kICJyZWd1
bGFyaXplIiB0aGUgd2F5IGh5cGVyY2FsbCBpbnB1dCBhbmQNCm91dHB1dCBzcGFjZSBpcyBzZXQg
dXAsIHNvIHRoYXQgd2UgYXZvaWQgdGhlIGN1cnJlbnQgYWQgaG9jIGFwcHJvYWNoDQp0aGF0IGlz
IG9wZW4gY29kZWQgZm9yIGVhY2ggaHlwZXJjYWxsIGludm9jYXRpb24gYW5kIGlzIHN1YmplY3Qg
dG8gZXJyb3JzLg0KDQpJIHdhbnQgdG8gbWFrZSBzdXJlIG15IGFwcHJvYWNoIHdvdWxkIGhhbmRs
ZSB5b3VyIGNhc2UuIENvdWxkIHlvdQ0KZWxhYm9yYXRlIG9uIHRoZSBuYXR1cmUgb2YgdGhlIGlu
cHV0IGFuZCBvdXRwdXQgZnJvbSB0aGUgVlNNLXJlbGF0ZWQNCmh5cGVyY2FsbHM/IElzIGl0IHNv
bWUgZml4ZWQgc2l6ZSBzdHJ1Y3R1cmU/IE9yIHBlcmhhcHMgYSBmaXhlZCBzaXplDQpzdHJ1Y3R1
cmUgcGx1cyBhbiBhcnJheT8gT3Igc29tZXRoaW5nIGVsc2U/DQoNClRoYW5rcywNCg0KTWljaGFl
bA0KDQo+ID4NCj4gPiBPbiBGcmksIEphbiAzLCAyMDI1IGF0IDU6MDjigK9QTSBNaWNoYWVsIEtl
bGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBGcm9tOiBTdGFu
aXNsYXYgS2luc2J1cnNraWkgPHNraW5zYnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50
OiBGcmlkYXksIEphbnVhcnkgMywgMjAyNSAxMToyMCBBTQ0KPiA+PiA+DQo+ID4+ID4gT24gTW9u
LCBEZWMgMzAsIDIwMjQgYXQgMTA6MDk6MzlBTSAtMDgwMCwgUm9tYW4gS2lzZWwgd3JvdGU6DQo+
ID4+ID4gPiBEdWUgdG8gdGhlIGh5cGVyY2FsbCBwYWdlIG5vdCBiZWluZyBhbGxvY2F0ZWQgaW4g
dGhlIFZUTCBtb2RlLA0KPiA+PiA+ID4gdGhlIGNvZGUgcmVzb3J0cyB0byB1c2luZyBhIHBhcnQg
b2YgdGhlIGlucHV0IHBhZ2UuDQo+ID4+ID4gPg0KPiA+PiA+ID4gQWxsb2NhdGUgdGhlIGh5cGVy
Y2FsbCBvdXRwdXQgcGFnZSBpbiB0aGUgVlRMIG1vZGUgdGh1cyBlbmFibGluZw0KPiA+PiA+ID4g
aXQgdG8gdXNlIGl0IGZvciBvdXRwdXQgYW5kIHNoYXJlIGNvZGUgd2l0aCBkb20wLg0KPiA+PiA+
ID4NCj4gPj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvbWFuIEtpc2VsIDxyb21hbmtAbGludXgubWlj
cm9zb2Z0LmNvbT4NCj4gPj4gPiA+IC0tLQ0KPiA+PiA+ID4gIGRyaXZlcnMvaHYvaHZfY29tbW9u
LmMgfCA2ICsrKy0tLQ0KPiA+PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+ID4+ID4gPg0KPiA+PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aHYvaHZfY29tbW9uLmMgYi9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jDQo+ID4+ID4gPiBpbmRleCBj
NmVkM2JhNGJmNjEuLmM5ODNjZmQ0ZDZjMCAxMDA2NDQNCj4gPj4gPiA+IC0tLSBhL2RyaXZlcnMv
aHYvaHZfY29tbW9uLmMNCj4gPj4gPiA+ICsrKyBiL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMNCj4g
Pj4gPiA+IEBAIC0zNDAsNyArMzQwLDcgQEAgaW50IF9faW5pdCBodl9jb21tb25faW5pdCh2b2lk
KQ0KPiA+PiA+ID4gICAgIEJVR19PTighaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsNCj4gPj4gPiA+
DQo+ID4+ID4gPiAgICAgLyogQWxsb2NhdGUgdGhlIHBlci1DUFUgc3RhdGUgZm9yIG91dHB1dCBh
cmcgZm9yIHJvb3QgKi8NCj4gPj4gPiA+IC0gICBpZiAoaHZfcm9vdF9wYXJ0aXRpb24pIHsNCj4g
Pj4gPiA+ICsgICBpZiAoaHZfcm9vdF9wYXJ0aXRpb24gfHwgSVNfRU5BQkxFRChDT05GSUdfSFlQ
RVJWX1ZUTF9NT0RFKSkgew0KPiA+PiA+DQo+ID4+ID4gVGhpcyBjaGVjayBkb2Vzbid0IGxvb2sg
bmljZS4NCj4gPj4gPiBGaXJzdCBvZiBhbGwsIElTX0VOQUJMRUQoQ09ORklHX0hZUEVSVl9WVExf
TU9ERSkgZG9lc24ndCBtZWFuIHRoYXQgdGhpcw0KPiA+PiA+IHBhcnRpY3VsYXIga2VybmVsIGlz
IGJlaW5nIGJvb3RlZCBpbiBWVEwgb3RoZXIgdGhhdCBWVEwwLg0KPiA+Pg0KPiA+PiBBY3R1YWxs
eSwgaXQgZG9lcyBtZWFuIHRoYXQuIEtlcm5lbHMgYnVpbHQgd2l0aCBDT05GSUdfSFlQRVJWX1ZU
TF9NT0RFPXkNCj4gPj4gd2lsbCBub3QgcnVuIGFzIGEgbm9ybWFsIGd1ZXN0IGluIFZUTCAwLiBT
ZWUgdGhlIHRoaXJkIHBhcmFncmFwaCBvZiB0aGUNCj4gPj4gImhlbHAiIHNlY3Rpb24gZm9yIEhZ
UEVSVl9WVExfTU9ERSBpbiBkcml2ZXJzL2h2L0tjb25maWcuDQo+ID4+DQo+ID4+IE1pY2hhZWwN
Cj4gPj4NCj4gPj4gPg0KPiA+PiA+IFNlY29uZCwgY3VycmVudCBhcHByb2FjaCBpcyB0aGF0IGEg
VlRMMSsga2VybmVsIGlzIGEgZGlmZmVyZW50IGJ1aWxkIGZyb20gVlRMMA0KPiA+PiA+IGtlcm5l
bCBhbmQgdGh1cyByZWx5aW5nIG9uIHRoZSBjb25maWcgb3B0aW9uIGxvb2tzIHJlYXNvbmFibGUu
IEhvd2V2ZXIsDQo+ID4+ID4gdGhpcyBpcyBub3QgdHJ1ZSBpbiBnZW5lcmFsIGNhc2UuDQo+ID4+
ID4NCj4gPj4gPiBJJ2Qgc3VnZ2VzdCBvbmUgb2YgdGhlIGZvbGxvd2luZyB0aHJlZSBvcHRpb25z
Og0KPiA+PiA+DQo+ID4+ID4gMS4gQWx3YXlzIGFsbG9jYXRlIHBlci1jcHUgb3V0cHV0IHBhZ2Vz
LiBUaGlzIGlzIHdhc3RlZnVsIGZvciB0aGUgVlRMMA0KPiA+PiA+IGd1ZXN0IGNhc2UsIGJ1dCBp
dCBtaWdodCB3b3J0aCBpdCBmb3Igb3ZlcmFsbCBzaW1wbGlmaWNhdGlvbi4NCj4gPj4gPg0KPiA+
PiA+IDIuIERvbid0IHRvdWNoIHRoaXMgY29kZSBhbmQga2VlcCB0aGUgY25hZ2UgaW4gdGhlIFVu
ZGVyaGlsbCB0cmVlLg0KPiA+PiA+DQo+ID4+ID4gMy4gSW50cm9kdWNlIGEgY29uZmlndXJhdGlv
biBvcHRpb24gKGNvbW1hbmQgbGluZSBvciBkZXZpY2UgdHJlZSBvcg0KPiA+PiA+IGJvdGgpIGFu
ZCB1c2UgaXQgaW5zdGVhZCBvZiB0aGUga2VybmVsIGNvbmZpZyBvcHRpb24uDQo+ID4+ID4NCj4g
Pj4gPiBUaGFua3MsDQo+ID4+ID4gU3Rhcw0KPiA+PiA+DQo+ID4+ID4gPiAgICAgICAgICAgICBo
eXBlcnZfcGNwdV9vdXRwdXRfYXJnID0gYWxsb2NfcGVyY3B1KHZvaWQgKik7DQo+ID4+ID4gPiAg
ICAgICAgICAgICBCVUdfT04oIWh5cGVydl9wY3B1X291dHB1dF9hcmcpOw0KPiA+PiA+ID4gICAg
IH0NCj4gPj4gPiA+IEBAIC00MzUsNyArNDM1LDcgQEAgaW50IGh2X2NvbW1vbl9jcHVfaW5pdCh1
bnNpZ25lZCBpbnQgY3B1KQ0KPiA+PiA+ID4gICAgIHZvaWQgKippbnB1dGFyZywgKipvdXRwdXRh
cmc7DQo+ID4+ID4gPiAgICAgdTY0IG1zcl92cF9pbmRleDsNCj4gPj4gPiA+ICAgICBnZnBfdCBm
bGFnczsNCj4gPj4gPiA+IC0gICBpbnQgcGdjb3VudCA9IGh2X3Jvb3RfcGFydGl0aW9uID8gMiA6
IDE7DQo+ID4+ID4gPiArICAgY29uc3QgaW50IHBnY291bnQgPSAoaHZfcm9vdF9wYXJ0aXRpb24g
fHwNCj4gPj4gPiBJU19FTkFCTEVEKENPTkZJR19IWVBFUlZfVlRMX01PREUpKSA/IDIgOiAxOw0K
PiA+PiA+ID4gICAgIHZvaWQgKm1lbTsNCj4gPj4gPiA+ICAgICBpbnQgcmV0Ow0KPiA+PiA+ID4N
Cj4gPj4gPiA+IEBAIC00NTMsNyArNDUzLDcgQEAgaW50IGh2X2NvbW1vbl9jcHVfaW5pdCh1bnNp
Z25lZCBpbnQgY3B1KQ0KPiA+PiA+ID4gICAgICAgICAgICAgaWYgKCFtZW0pDQo+ID4+ID4gPiAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+PiA+ID4NCj4gPj4gPiA+IC0g
ICAgICAgICAgIGlmIChodl9yb290X3BhcnRpdGlvbikgew0KPiA+PiA+ID4gKyAgICAgICAgICAg
aWYgKGh2X3Jvb3RfcGFydGl0aW9uIHx8IElTX0VOQUJMRUQoQ09ORklHX0hZUEVSVl9WVExfTU9E
RSkpIHsNCj4gPj4gPiA+ICAgICAgICAgICAgICAgICAgICAgb3V0cHV0YXJnID0gKHZvaWQgKiop
dGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X291dHB1dF9hcmcpOw0KPiA+PiA+ID4gICAgICAgICAg
ICAgICAgICAgICAqb3V0cHV0YXJnID0gKGNoYXIgKiltZW0gKyBIVl9IWVBfUEFHRV9TSVpFOw0K
PiA+PiA+ID4gICAgICAgICAgICAgfQ0KPiA+PiA+ID4gLS0NCj4gPj4gPiA+IDIuMzQuMQ0KPiA+
PiA+ID4NCj4gPj4NCg==

