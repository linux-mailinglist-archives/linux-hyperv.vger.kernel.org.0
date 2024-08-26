Return-Path: <linux-hyperv+bounces-2864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F695E7FE
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 07:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B897C1F214C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEB7406F;
	Mon, 26 Aug 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HoboMzIn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010012.outbound.protection.outlook.com [52.103.11.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B188C11;
	Mon, 26 Aug 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650841; cv=fail; b=AWGqL0mJ/W15KXIH1/FSEflRi9CDmf+R4E0gMQYrbAJ8wKiiIsi0hwxuRPR0XMVw32nRj5FjNBLkf+8LWZOe/TikxT2DElVDje2SXVWN0PtypxL4KRxrOnTXd1LLuwMa6OQYqG85fW9SjxF4JtsjTWZGYi6cSj/sSKml8KPbp98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650841; c=relaxed/simple;
	bh=l7AXVg6ZKgNLxk6BLSig8iGZtVEmFbH5T8Fp6d9384k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuhcHjoc5/VHFc6jG5CvBUe6IBOHbnW11x1T4874n0ZBX5t4un3jmoHy8/7mNcnSzNaA/35TSmdP6W6FHsry4XxHeugnjxaw16+KKSTeIhSZJvhR0wdP8GELnMqiDdT8YmQd8r3nfhGeGwSLFDl0rj4hWt/dKFglRvTV49GMcIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HoboMzIn; arc=fail smtp.client-ip=52.103.11.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL3jfrT9XGmfVbLRUzZ7s1Now/7Xe0JUF56YYAwJLVQS3Vs+w0Igg48qK5guKTwAyOF8pXNdHm55ltNCBZWkz+WC2XGExd52JI4CrJmAKffkNJRsegpG1rkOV0PkmVXiCM/eTBhv3SY3SQpOt0SxAdP/6OcMvrgQ5vIYHHj8I4oYpXdjx8o9Twn+p0NiXIRJwQy5WiNdtWEhO+kb1z+xwEoBDfUAVzTwkk/E5EH0bcpBGjSuJzl75E2ve1JAKRIHoL7V3/UpxpbXI64LjkH7kKtDji1lPwX2N98N05hUD+JSHE6Fs0EwoSJaVGXA331NLFT4aOnPpNi/dJJao1sYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7AXVg6ZKgNLxk6BLSig8iGZtVEmFbH5T8Fp6d9384k=;
 b=aj/28WfsFGgKIg+QdZI5jvdaYuqUolxun5ClvUolLkyj9dgE3w8wny94+A0Xl2a6NE/8KZeqn28qtDvKApYzC3BgG9rlhXTi3LT+pbl1w4y4uKjsufuE05YRcGwFXZGcsugly61ddMXDAKHIN5Erq2XR1P1VgBe+sXxWIBA5D1+VmDBJruVCZ9QqdnMQbEz7kS2/mz8LyL13Wq75DcwF7eyfUw71hCp0zZXZTLZeFYAN72ki5gctgKQs7MjEVwh696ZW3yrOAtMhE/bpI7hpAkwCgrTEEBMlYdAbVpCB4Uhmi7XNn/KBFIHhoKhqMjhUFxsLKvai6R1H1ihWAS7jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7AXVg6ZKgNLxk6BLSig8iGZtVEmFbH5T8Fp6d9384k=;
 b=HoboMzInFJu5I8kYOAJJxReugJ0VZ47zdYOvmRbiDdmjPIbRcvM6AbHXum+RDqQ1uMk9qb4St6LS8DpTj9xKSHmwiqcxh8JNsb1vymA3wzPSoDj92sMp9g8s5CveRaAP12nDgsmTAQPXFaU/OCVGrcy1Mh4eefsUradMEA1HAm3uyU0t23y7VM1iVRuCDAbRfq6aYsQw9QMkqf4r7ExBQvswj4EhBxokn+teN3zQZhptsJNDZM81fdeDcluHxgKRtRK3trGr/rZ2Req2dNxk9Y+2KrAIFSOR1XS/BttDRJ7FYeX6LYZJvxkk8NE8ZzMaVgOjwGXlvjw45HyU1q8xjw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6582.namprd02.prod.outlook.com (2603:10b6:610:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:40:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Mon, 26 Aug 2024
 05:40:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Index: AQHa9IPP2ZEuiKarEkiNA338VE6Og7I3SmgwgAG/A4CAAAG7YA==
Date: Mon, 26 Aug 2024 05:40:37 +0000
Message-ID:
 <SN6PR02MB415711F672364610BBE6861DD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a447911b-ef12-46de-ba01-13105e34b8fe@linux.microsoft.com>
In-Reply-To: <a447911b-ef12-46de-ba01-13105e34b8fe@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [XExJh9RKSlcvKOzVjU9Y5N/63tBP0lTu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6582:EE_
x-ms-office365-filtering-correlation-id: 7a14b9d8-967d-4091-8f77-08dcc5919cd7
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|461199028|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 ljZtMV0lwX1Fw1OHJLnWV121G/jYr2r580K+hOKHnp5UTi3tDs4F1ZcUOcWXk439z4OEBDyXTHN/gvMsh9IbdnkzP7qQr6Xz6vEM26OAuIzgFasKJ+k+l0Q+alnWzE550wtbtiz47VLrZ9v9Djh11GHzqaY013mbxv8g/x4a5QQSTTY7q0DhmH19V7zl0J0pzoHKASAcn5O26++T1mZge1bAWlX/7Gmx9V6jccaGvFtmqONVJEtSRqI+VecU/WVKAV9oAc6CRYn43vNFQ2bVELiC7mKziOhHty/UrH8ePQXVMUHwdnKJLgUWNyGB3nlRzxm5mRcUQU9RT27Qc4nv66g5LViw29s8QSTPo4EbWWjKmVjZPsFz+GbzbxmV9cVh3SalHyxOqafy5LuNK4qEdd1gVsNDJS3L3mtYbVwDv9+iTj20QN5/iqVq3o8372UiFn2lQoPdoet2anpggzPOVN4/l70FYB0VeFU6RQ17DUQ3aauvV2d1s7drKEUSG5CuHZOL9QVbDrpmkAfJypYZOhTTQKjKScuKcivPAP1QZzfivEOY/F7TajXb7yJGJA8Ozl8by6akxmFI3OZwLDZ0K85RgEgulZLcIysGqH/WGhziwZhNqpKXFPoLI+lqi4eAuPqPCkAbmHt4h4zZMuaiyePzk1+WU3bsBnThLHfysLx0CCZN3zqT8hX1Y3ZS61Li
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlRjTWk3UTh1WmZtSUZxTURPWUZHQnRHQVhPRXY4eHBFMlNyOGs3MEczTGpw?=
 =?utf-8?B?V2drTmtOZDhobFlnRytQdS9ZbHZJN3p4TmFLcDNUMEVCOVMzNG14YTZFZWdF?=
 =?utf-8?B?OElhSWcvall5MmFWR0pwSUV2QW1pUitpSFBBY1NnK0VXcDN0VVpoWWtZRmwr?=
 =?utf-8?B?Y1Npb3NJK1I3R2RYS0ltR09xb1loUTluNDh0dDVIZEY3bzdPdTRpbEtENm9z?=
 =?utf-8?B?RkJXM0h6bTVieDFzTVFoa0lWVkthcFFFWEh6eGFQR2htREh2S21nM2M2T3kv?=
 =?utf-8?B?azU5eGdBZ2FIc3RQTEQ5dzg1NHRlcnlsQVZDb3NZRWdxRHlxMS96QjlxNkVh?=
 =?utf-8?B?VWQwOC9HNlZTR2RiMHlpUE1leGJBcCtaU2pOY1dGWUtoMFVxeGZvRkdrWVlQ?=
 =?utf-8?B?ZFBJRFFaTlhtbnhkcWNIM2JteGRqNmNuNkIzSkJwcnFMTUthZWZCOFM2SzQx?=
 =?utf-8?B?V2JURXZ0VHZ3cktzWWd3anFYZ3NYdFJGU3FWN3FybTZZWTNrVUc1UEROeUxW?=
 =?utf-8?B?ZFNrMVBVa0tnWWI4ZG9waGZDayt2WHRKUGpXRzdObndmMGdmVTYyYUZScHdQ?=
 =?utf-8?B?MHB3UGN6VGFTc21kdXNHR1NwdW1LQVhvSklDRHQ1d0dNWFRNcXphQTdHOGU5?=
 =?utf-8?B?TDdMeEp1SUFMNklpbVAvMmZlYlBmSnpwZ0JVdmR0eUQ1UUltTUJMWFVrS0hp?=
 =?utf-8?B?aiszeW1jTVJvbGo5N2hudVlrMTdxNFNsRUR2NEp1WFJkcnJVVEpVZUxkV2dV?=
 =?utf-8?B?NFpHQzBCaklTajZNaXh6eDFHWlZhSUQyZWtHdm1QUmxvT3FhUE5uUEdCVGp0?=
 =?utf-8?B?NDZ6U1JQTHlySjFTb0tQd3p5TGI4TkViSHNNMXZOK09YVkN1a1BzeVhGQzBI?=
 =?utf-8?B?dGg0bHAyK1J3M2tQYzBiVk03VXBMQm5uWmVoRTZNSVdNcm56aVF6bUxQak5z?=
 =?utf-8?B?SmNSNklITWtpRlh3ZXAyZUtjMk5vSXhVQ0RWdis4T2QwVHZkYy9JeUd4ZkRK?=
 =?utf-8?B?ODlGZWdCUmJ2Vjd3WnM4UHpIQVZPcXN3eVlsaWxMSG0yZXA2cVZnbmVYUDRD?=
 =?utf-8?B?S1N0MFlsQmNEMFZDVVBnZzVYTHRtalNRVU1sc1o4a3k4MmJra2p6SWR1MXA4?=
 =?utf-8?B?ZGR6YnR4dXF3OWRlamR3ZkpuNTBqY2FvREV2Tm5yN0NtRGRtc1BrTkJPWFJr?=
 =?utf-8?B?SVplMFhJQk5pNXN1RzJVdnEyRHJrM1V6ZmQ3U0tudkJBV0drYy9SbWxqWW81?=
 =?utf-8?B?VGdqd1NyU25PVUliVU9Sb2YybmJmSHJOakEzTkVFREdyalhaUmU4RExkTmw2?=
 =?utf-8?B?ZkY2OFNjVlFGeEhOTjlqQmsrRmU3aTViZnovOU1tOWNiYmJWVjVMbFNtQkM1?=
 =?utf-8?B?UG9OK1FKc0tMNnpxNnAyQmFZVFIvd2ZRbnI5NGNlbWEwLzdSeGJjeDZvR2tC?=
 =?utf-8?B?UVhHK0tIeXMxR1FwTEtMQTBVYWVjSzFCKzNRcHVkcG9iUG52MUVvcS92bEQr?=
 =?utf-8?B?ciswdGRBeHZJaEVIWWh1ckNaaVBXUkpWNUExYW91YUFYNHBkdjVreVZwekdV?=
 =?utf-8?B?aHRDOVpUN3dlcTZsVWh1VEx6T0lXeEJKYkw1cVk1aW55U1RkOXpkVEJZak9L?=
 =?utf-8?Q?Ce85F7MJpFJIl89jE1W5WbK6QtBSCTqSxEMHgByQJ/Rg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a14b9d8-967d-4091-8f77-08dcc5919cd7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 05:40:37.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6582

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBTdW5k
YXksIEF1Z3VzdCAyNSwgMjAyNCAxMDozMiBQTQ0KPiANCj4gT24gOC8yNS8yMDI0IDg6MjcgQU0s
IE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE5hbWFuIEphaW4gPG5hbWphaW5AbGlu
dXgubWljcm9zb2Z0LmNvbT4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA0OjA5IEFN
DQo+ID4+DQo+ID4+IFJlc2NpbmQgb2ZmZXIgaGFuZGxpbmcgcmVsaWVzIG9uIHJlc2NpbmQgY2Fs
bGJhY2tzIGZvciBzb21lIG9mIHRoZQ0KPiA+PiByZXNvdXJjZXMgY2xlYW51cCwgaWYgdGhleSBh
cmUgcmVnaXN0ZXJlZC4gSXQgZG9lcyBub3QgdW5yZWdpc3Rlcg0KPiA+PiB2bWJ1cyBkZXZpY2Ug
Zm9yIHRoZSBwcmltYXJ5IGNoYW5uZWwgY2xvc3VyZSwgd2hlbiBjYWxsYmFjayBpcw0KPiA+PiBy
ZWdpc3RlcmVkLg0KPiA+PiBBZGQgbG9naWMgdG8gdW5yZWdpc3RlciB2bWJ1cyBmb3IgdGhlIHBy
aW1hcnkgY2hhbm5lbCBpbiByZXNjaW5kIGNhbGxiYWNrDQo+ID4+IHRvIGVuc3VyZSBjaGFubmVs
IHJlbW92YWwgYW5kIHJlbGlkIHJlbGVhc2UsIGFuZCB0byBlbnN1cmUgcmVzY2luZCBmbGFnDQo+
ID4+IGlzIGZhbHNlIHdoZW4gZHJpdmVyIHByb2JlIGhhcHBlbnMgYWdhaW4uDQo+ID4+DQo+ID4+
IEZpeGVzOiBjYTNjZGE2ZmNmMWUgKCJ1aW9faHZfZ2VuZXJpYzogYWRkIHJlc2NpbmQgc3VwcG9y
dCIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IE5hbWFuIEphaW4gPG5hbWphaW5AbGludXgubWljcm9z
b2Z0LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9odi92bWJ1c19kcnYuYyAgICAgICB8
IDEgKw0KPiA+PiAgIGRyaXZlcnMvdWlvL3Vpb19odl9nZW5lcmljLmMgfCA3ICsrKysrKysNCj4g
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9odi92bWJ1c19kcnYuYyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4g
Pj4gaW5kZXggYzg1N2RjMzk3NWJlLi40YmFlMzgyYTNlYjQgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gPj4gKysrIGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0K
PiA+PiBAQCAtMTk1Miw2ICsxOTUyLDcgQEAgdm9pZCB2bWJ1c19kZXZpY2VfdW5yZWdpc3Rlcihz
dHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2Vfb2JqKQ0KPiA+PiAgIAkgKi8NCj4gPj4gICAJZGV2aWNl
X3VucmVnaXN0ZXIoJmRldmljZV9vYmotPmRldmljZSk7DQo+ID4+ICAgfQ0KPiA+PiArRVhQT1JU
X1NZTUJPTF9HUEwodm1idXNfZGV2aWNlX3VucmVnaXN0ZXIpOw0KPiA+Pg0KPiA+PiAgICNpZmRl
ZiBDT05GSUdfQUNQSQ0KPiA+PiAgIC8qDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vpby91
aW9faHZfZ2VuZXJpYy5jIGIvZHJpdmVycy91aW8vdWlvX2h2X2dlbmVyaWMuYw0KPiA+PiBpbmRl
eCBjOTk4OTBjMTZkMjkuLmVhMjZjMGI0NjBkNiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy91
aW8vdWlvX2h2X2dlbmVyaWMuYw0KPiA+PiArKysgYi9kcml2ZXJzL3Vpby91aW9faHZfZ2VuZXJp
Yy5jDQo+ID4+IEBAIC0xMjEsNiArMTIxLDEzIEBAIHN0YXRpYyB2b2lkIGh2X3Vpb19yZXNjaW5k
KHN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsKQ0KPiA+Pg0KPiA+PiAgIAkvKiBXYWtlIHVw
IHJlYWRlciAqLw0KPiA+PiAgIAl1aW9fZXZlbnRfbm90aWZ5KCZwZGF0YS0+aW5mbyk7DQo+ID4+
ICsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIFdpdGggcmVzY2luZCBjYWxsYmFjayByZWdpc3RlcmVk
LCByZXNjaW5kIHBhdGggd2lsbCBub3QgdW5yZWdpc3RlciB0aGUgZGV2aWNlDQo+ID4+ICsJICog
d2hlbiB0aGUgcHJpbWFyeSBjaGFubmVsIGlzIHJlc2NpbmRlZC4gV2l0aG91dCBpdCwgbmV4dCBv
bm9mZmVyIG1zZyBkb2VzIG5vdCBjb21lLg0KPiA+PiArCSAqLw0KPiA+PiArCWlmICghY2hhbm5l
bC0+cHJpbWFyeV9jaGFubmVsKQ0KPiA+PiArCQl2bWJ1c19kZXZpY2VfdW5yZWdpc3RlcihjaGFu
bmVsLT5kZXZpY2Vfb2JqKTsNCj4gPg0KPiA+IFdoZW4gdGhlIHJlc2NpbmQgY2FsbGJhY2sgaXMg
Km5vdCogc2V0LCB2bWJ1c19vbm9mZmVyX3Jlc2NpbmQoKSBtYWtlcyB0aGUNCj4gPiBjYWxsIHRv
IHZtYnVzX2RldmljZV91bnJlZ2lzdGVyKCkuIEJ1dCBpdCBkb2VzIHNvIGJyYWNrZXRlZCB3aXRo
IGdldF9kZXZpY2UoKS8NCj4gPiBwdXRfZGV2aWNlKCkuIFlvdXIgY29kZSBoZXJlIGRvZXMgbm90
IGRvIHRoZSBicmFja2V0aW5nLiBJcyB0aGVyZSBhIHJlYXNvbiBmb3INCj4gPiB0aGUgZGlmZmVy
ZW5jZT8gRnJhbmtseSwgSSdtIG5vdCBzdXJlIHdoeSB2bWJ1c19vbm9mZmVyX3Jlc2NpbmQoKSBk
b2VzIHRoZQ0KPiA+IGJyYWNrZXRpbmcsIGFuZCBJIGNhbid0IGRlZmluaXRpdmVseSBzYXkgaWYg
aXQgaXMgcmVhbGx5IG5lZWRlZC4gU28gSSBndWVzcyBJJ20NCj4gPiBqdXN0IGFza2luZyBpZiB5
b3Uga25vdy4gOi0pDQo+ID4NCj4gPiBNaWNoYWVsDQo+IA0KPiBJTUhPLCB3ZSBoYXZlIGFscmVh
ZHkgTlVMTCBjaGVja2VkIGNoYW5uZWwtPmRldmljZV9vYmogYW5kIG90aGVyIGNvdXBsZQ0KPiBv
ZiB0aGluZ3MgdG8gbWFrZSBzdXJlIHdlIGFyZSBzYWZlIHRvIGNsZWFuIHRoaXMgdXAuIEF0IG90
aGVyIHBsYWNlcyBhcw0KPiB3ZWxsLCBJIGRvbid0IHNlZSB0aGUgdXNlIG9mIHB1dCBhbmQgZ2V0
IGRldmljZS4gU28gSSB0aGluayBpdHMgbm90DQo+IHJlcXVpcmVkLiBJIGFtIG9wZW4gdG8gc3Vn
Z2VzdGlvbnMuDQo+IA0KPiBSZWdhcmRzLA0KPiBOYW1hbg0KDQpPSy4gSSdtIGdvb2Qgd2l0aCB3
aGF0IHlvdSd2ZSBzYWlkLCBhbmQgZG9uJ3QgaGF2ZSBhbnkgZnVydGhlciBzdWdnZXN0aW9ucy4N
CkdvIHdpdGggd2hhdCB5b3VyIHBhdGNoIGFscmVhZHkgaGFzLiA6LSkNCg0KTWljaGFlbA0K

