Return-Path: <linux-hyperv+bounces-7127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC820BBFD35
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C042E4E413D
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CC249EB;
	Tue,  7 Oct 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i8JM3dhF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010024.outbound.protection.outlook.com [52.103.23.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B9CA6F;
	Tue,  7 Oct 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795340; cv=fail; b=h56ItpzzT+nHvBUWEMz0OePdOVpIqvcwaQ/9SpCeX96KzeZ9ztW19dO+zloi2cfy556l9r2sQse5rMKfwYza0W4UB2pYHgvBDSmUmvVDOv5J++HowLSkxlmO/l/3+28scYgyHD63wWoHXmS0U3RZjJmpnOO7qOMoNiZ7oHxT7rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795340; c=relaxed/simple;
	bh=u3NiBVhPoqmE0bukPTBpz/oVvjgHZrvXStLwqjMfsgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVH450OvLnAlJpYfxMRIDSnx5R9HcAubcrSB/r0L9bs1lD2K7jjGEFIUwQSbQrahSGQUU888WSgFU6hj0I4Cuj+nNmOYC9kMrUuTgBjBd3f37I7ItzcQP2rHvlUvgZvmLjdmxDWQ65r8nxG3ld6Qzx3w5jJod7nFX074NZzhw1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i8JM3dhF; arc=fail smtp.client-ip=52.103.23.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf4L9WuXVPa2cc+zC3jeLBLT4UIPVfEfN32RfFM7voS1nK/19NAmsTkeoZPlHooN8DsL0Y8KJ1vorz8FR6T4sOLCkG1LS8JiyV28RxvJehYm3aSIGhZjgYXQp4AylGIC7jbk0qoOOpXJb1/sGXUvTkaeslvWbO4yzhimzbrslpnq8ZE2+8E2IPtZZ6fIJvQl2+04NeFeduZs5/Vi/7lcaVTODT6DJq8fykQTn36q67AtK39YBEWuVMT857YvR3vugaP3K0UfPW2Wo7WTC/GcRgiDKairw3FNDBPj363s50XzsXe/0pahblhlUAGhfhEOyw/DPtn+6ArohJLfk37WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3NiBVhPoqmE0bukPTBpz/oVvjgHZrvXStLwqjMfsgg=;
 b=Eg1qP/RQRNOXrKcHavvURt5nwWnfoWoOSXf076G3sYK4V0sQY/yv0+nt8oMWAqxeFjh7fbbwHyNmFpbHdrYL7Ijjfy0+v6dClnCBDqmyap/wrJVK4cqV9mxYQAcP+Cd8dq9MjDNQAlO53shxLKLpN1Ebk2HwPuqNPa+sIgLb3hLr7xAnLlw1k9JW3HtmSPI32eljJe7xYoDbF9V9rv7yz2q7sjmcjmj/gh2G4UAi/JaVEtFAn+evrJknC4EHslSoCbhK8VB886YYdlcm2J8mvwPVsyVTe4I52DqErJ+ueR/n7OQLvGETNfoag0PBevXoUC3B0AUpX5TMpvrnghXoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3NiBVhPoqmE0bukPTBpz/oVvjgHZrvXStLwqjMfsgg=;
 b=i8JM3dhFMjSggo6gk8KbrOAYYqvDzF+FyeHEvdRK8WTrl8M2+Hu2i0J4R3Pokzt9WdR5HSCkJyxuL4LkxZOq2JwsGoHtFXt4eNak958Ahgcurj75Fzu8Tu34h/rn+oycDPAtiyWkMTd1HnHtkvt1CXY9o5dl3EgPDADvg99lSFjHXv7Krvi68F1zURBFFNwaNA346JvDyuh19r/wPmwMO+W6KNwWcpOoxg0lbJfCrhMtwMx/ymvcEAzw+EZ7ctuXys5+EzmvPIar8nBSJniryKnMj6s3reZ4XFxnMriHL+8/wqqGm+Z2SkN+P+FLeFMmRi3j/oEuaxGXCL224cOW8g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10200.namprd02.prod.outlook.com (2603:10b6:610:1bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 00:02:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 00:02:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
Thread-Topic: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Thread-Index: AQHcNtLek7tWvuore02WjZDCwrJP3rS1Vo1QgABu4ACAAAersA==
Date: Tue, 7 Oct 2025 00:02:14 +0000
Message-ID:
 <SN6PR02MB41574B6F94BCC0E0F75DADFED4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157A4FBBF17A73E5D549DDFD4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aORRplcP1r17gave@skinsburskii.localdomain>
In-Reply-To: <aORRplcP1r17gave@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10200:EE_
x-ms-office365-filtering-correlation-id: a561e4ae-abec-4fce-c782-08de0534c570
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|13091999003|15080799012|19110799012|8060799015|8062599012|461199028|12121999013|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzZzZ3U5enVMODRISjdqTnowZzNEc3hsVHRva2hyS2VhLzlVbEJEMHJncHVN?=
 =?utf-8?B?eFAxSGZlZXB3cjNqK0tidEhWTW9VaS9RRzlsOWJRNnJZV1N3VkJFWXF2NHk3?=
 =?utf-8?B?MFA2Tkp1Y0dOT2oxN2d6Qno5bTJjdUl6UnZ0TURGaFpMUzdKTUlBQ25OcjZ3?=
 =?utf-8?B?RS9jaE00UlQvQzRFaHVKVStpWUZlbEZialh2N0N4NEE5bG9QbVRSTGtpbGtT?=
 =?utf-8?B?UEZoSUQyaG1wOUNzS0hCQUdMd3JsOEpIQWJaT3NlemlSY2JkNHVjMnBQZ0N2?=
 =?utf-8?B?Y0N3ZUpLUklYQUhLTVJtLzl6aFhURmFQc0QzMDVhaEVMK3A0YitKSjhReURL?=
 =?utf-8?B?enIrWXVTaGgwV0lxSVRVS3JyWXB4N1dFL2ZIRXB5Umo1d290TGNZSXdzWitt?=
 =?utf-8?B?WDB1YWh3Rkp3UXcrM1BpSEpPYk4zNHpPSm1xRnpqeWVnRFRyK3BHMC9ZSUVF?=
 =?utf-8?B?VEZuS1p5UjlpbFVXVkovUEZmdVR5UWJPQStRVDBBYXJKZ2JPZllkRlRISXVU?=
 =?utf-8?B?TUxhbUpNVGZwVm9UOUxJNU5XNnZ1SGZlNHhHWTZZbVFKeFE5WDVrb3JKRllM?=
 =?utf-8?B?ZkNqNGhaNUczYkdBVGdBNTV2cWVBNTJ6U2RKMjA2UVMxVkxHKy81Yml6S1Fo?=
 =?utf-8?B?QXpUaGRZNEsvNkpCVzQrMWYvTFhqa0pZOUFrRGRNcGZYY1NDUE9HT2JYbVBW?=
 =?utf-8?B?a1E4NTNmNE1xNEZqUmM4QmJOeE1hSUNQS2xEdllOdkRFWlZLV2tsQm9sdmZR?=
 =?utf-8?B?aWZBM2wyRnVzWTBkK1lFWUd6d1hIbTVzbXhUaDdaMHkwclEzMkhnU3YxSEN4?=
 =?utf-8?B?TmRoYXB5bGZienZNMXdsakVrcFhPYmxmbXk4M0V1eFZ1aVdJUWlWVW5ITk12?=
 =?utf-8?B?MUc3bm5wSHdaR3NGczU5TTg0MU1YMmRzYnZoL3B0TU50eXhwalBVeVFjOWZT?=
 =?utf-8?B?aWlwNURXSEQ3b091eDYvREFOMlBYbEU2dnE2Q2JxbE96UWpLTDBYOUwxK0do?=
 =?utf-8?B?bDdFbm9uZzVocmtWSnZCQytiSWsxTk9rV2h1ZXZlN05Za2FBNFRaMHRrQzlR?=
 =?utf-8?B?YnFIc2Q1d3FucDhQazIxdC9RMzVHU2pwVnVwcE0vbzgvV3drcE0wNWhZK0d6?=
 =?utf-8?B?cGsxY3p2NGJxYVVZQ0oyZDlqWGJIRnNEUFcyRklrSTRPUlNjZ29ZK0dGbzla?=
 =?utf-8?B?UHR0S0h2dDl5N2djR0NPMjFaNXVkS3RNVzNJRXMwK01oVUM1aDFPL1BHUkpz?=
 =?utf-8?B?dUNOaEhpaDhFVTdyK241bCtQY3h4bkZuNktJUWlmQ0oyZXMzVU1UT2d3UGlm?=
 =?utf-8?B?TDRNUTJpMVJUeG5qSG5yQ1dCRjAzbWJRK0xzdzFlRVJWNGQ0TVh6NHlJNkZZ?=
 =?utf-8?B?WGFiQVM4SGUvWElMcHNkNzhzazZ4cUNKdkFtZUJIc29IY3ZhcnNqY2hnNGdY?=
 =?utf-8?B?cENiS2lXZG1GZXdma08xZHhQSXRSNGw5blExK2U2LzlVTGNNdE5kaVhBTVdp?=
 =?utf-8?B?Z0lERVozbWV5dFQvOHZqcXd6Z1pyYkZhMEZEaTIwak1PbmVFdEdqbUxHS0E4?=
 =?utf-8?B?SmRweVFvSHBuUU5hMk9wam14UGNOaWs1d3RjRUtoWGRUeVFzRFJaN1k3OXNY?=
 =?utf-8?B?NHJFeTZOb0xrZFZXemRFUk93TTg0NkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LytQZ2ZaTHFpaXRUR0kyTjRrYUVlVjhBQWx6VmFtWWJHaWlPYzlWSG43QUxY?=
 =?utf-8?B?ZmVzUFhLQ25TeEh5WVVKMTRjbzQwWjl0ajljWlVZT0pzTzVKZkRzNTBySGNE?=
 =?utf-8?B?cnNoMlIybE1YQit1SlNQR3RGcjNRVEVrSmdSamdpL085SUZycGhCdkt6Y2lo?=
 =?utf-8?B?YW1ocGg4QS8zVURxZURFaElwUTRCZ25JaFhtNkI5L3RPc0pxRzVhRXZ0TC9p?=
 =?utf-8?B?Zkw1KzBTMEpnSWQyRkxLbG1rdlROTXhURHhsK3V5YnJ1TTlUeVB0MW9DeElm?=
 =?utf-8?B?RDhWeXlLbjdRcHduL2h0alU4aS9DUHpOQ3RZWEdpZFRCc0paQUxvV2grNXU5?=
 =?utf-8?B?UUN3TUpCMExjN0M2aWxKVit4eG9TVmdEeTNXQ25TSkpId2xKNG1Ic20yMU4v?=
 =?utf-8?B?QXMxZ0xpYis4aVc2b0RucHlyRk1VdHdzQ2lHUlBGMGdPQ2I0RXhPTjhoR002?=
 =?utf-8?B?NDlRQ0p3azdIamF0dEF0YTFFUkJmWnp0b2RhSnZCaE5HRGduMm9LZm15UXpH?=
 =?utf-8?B?cGlkL1N4SC9DWW9ZNmV2YXlUWlJ3blB6VzFnQWdtaVdNcGxmYTNmc2hsT3Ix?=
 =?utf-8?B?VzZRZ05KcE1pY3loUGVWOG9hQnRUcStJOVo1ZVBBZXdublJWc2ZjZVMvT1Zi?=
 =?utf-8?B?SXdwRW9lYkFiVU1UYTBKcGNaNUM2anlIaVRlZVRWTU5WeW13ZjYvdEJDUGRw?=
 =?utf-8?B?MU5wUU1heGN2K0JOWERuTzJmaDdZZXpCYWRFU3FaTFJMNkZoRW5FT0tLbW1F?=
 =?utf-8?B?KzV6Ty9vdWZrcG5aeFpzMjlFL2VjakRSSlBxalpodHNFMzNIZHQraUtYZWFI?=
 =?utf-8?B?eVJnTi9qODRjTWZuV2pzZCtyd1RqQXNiQjV4UmdmczlteGw2alNMY3JsQWU5?=
 =?utf-8?B?ZHBrY2cvMkdDK0ZVbGdtRDFOeTlCeWp4bGFoNm9UMlVPem5HOXAvK01FZXlT?=
 =?utf-8?B?TUtRc2ZMSHVzeVRsMThKVzVQUHFQWlZlU3M1eW51Mjd6T0IxVVBaMUFqcXV5?=
 =?utf-8?B?ZHpBRTJ2N01HWG5BZUFWSm5BcmEvd2hvcEFaamRqWUFyZHpidHN2S0VqSkhB?=
 =?utf-8?B?K2gwbnIxTVY0VDlDWGk2dTBIZlhFNTJmMWg0ajI3VWkyQTNPMXZVWFUzSm9x?=
 =?utf-8?B?U1B3RmVlQ05samJaOWdtYjhKTkpqSS9JRlI5OGxla0Nxa2hieXUwd0FwZ0xT?=
 =?utf-8?B?bEFkWExONys0cTkzdUZ3aWoyWG9BRmdRdTl5aDA2SFVZV1JZaTNBQS96U0RC?=
 =?utf-8?B?djRUY3pzekxsaXUrYUZMS1E4WXNtajlUc2Z6UTcwYitNSzFDbkpxTFUvYStt?=
 =?utf-8?B?andRSWFnUG9iQllJUTNUTGxzc2EyYXpPbkNWeWlsbG5ZSXA0VEtDVS9acXdL?=
 =?utf-8?B?SnY1SmZVNXkxK2w3eEpKckt4R0tXek9sZzJ3YVA2a2gyaDFGK3ZJTUpadkJU?=
 =?utf-8?B?UkJmVDhDV3g0QVB2RnFwTjdhd3ZNZko1U2hJVEplMVczV2EwaG95Z0J5Q1ll?=
 =?utf-8?B?T0JyK0x4a3FUTFdBd1FlR1dJMWJTVHA2ZnpOYWZmNGw1Y3dvQzlUR2F6WVVP?=
 =?utf-8?B?aHRnV3VIZ1A3RldLajkyZGpFcnBYeHl4cEVOTmZNamh3RDdoVC9wbE5qcjZT?=
 =?utf-8?Q?ZPH9g4h5gVvO20ka+ABWUotvsaxuOdjTB/M0whh5lPWM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a561e4ae-abec-4fce-c782-08de0534c570
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 00:02:14.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10200

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDYsIDIwMjUgNDozMyBQTQ0KPiANCj4gT24gTW9u
LCBPY3QgMDYsIDIwMjUgYXQgMDU6MDk6MDdQTSArMDAwMCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6
DQo+ID4gRnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWlj
cm9zb2Z0LmNvbT4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDYsIDIwMjUgODowNiBBTQ0KPiA+ID4N
Cj4gPiA+IFJlZHVjZSBvdmVyaGVhZCB3aGVuIHVubWFwcGluZyBsYXJnZSBtZW1vcnkgcmVnaW9u
cyBieSBiYXRjaGluZyBHUEEgdW5tYXANCj4gPiA+IG9wZXJhdGlvbnMgaW4gMk1CLWFsaWduZWQg
Y2h1bmtzLg0KPiA+ID4NCj4gPiA+IFVzZSBhIGRlZGljYXRlZCBjb25zdGFudCBmb3IgYmF0Y2gg
c2l6ZSB0byBpbXByb3ZlIGNvZGUgY2xhcml0eSBhbmQNCj4gPiA+IG1haW50YWluYWJpbGl0eS4N
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXYgS2luc2J1cnNraWkgPHNraW5z
YnVyc2tpaUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9o
di9tc2h2X3Jvb3QuaCAgICAgICAgIHwgICAgMiArKw0KPiA+ID4gIGRyaXZlcnMvaHYvbXNodl9y
b290X2h2X2NhbGwuYyB8ICAgIDIgKy0NCj4gPiA+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9tYWlu
LmMgICAgfCAgIDI4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiA+ICAzIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvbXNodl9yb290LmggYi9kcml2ZXJzL2h2L21zaHZfcm9v
dC5oDQo+ID4gPiBpbmRleCBlMzkzMWIwZjEyNjkzLi45N2U2NGQ1MzQxYjZlIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9odi9tc2h2X3Jvb3QuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9odi9t
c2h2X3Jvb3QuaA0KPiA+ID4gQEAgLTMyLDYgKzMyLDggQEAgc3RhdGljX2Fzc2VydChIVl9IWVBf
UEFHRV9TSVpFID09IE1TSFZfSFZfUEFHRV9TSVpFKTsNCj4gPiA+DQo+ID4gPiAgI2RlZmluZSBN
U0hWX1BJTl9QQUdFU19CQVRDSF9TSVpFCSgweDEwMDAwMDAwVUxMIC8gSFZfSFlQX1BBR0VfU0la
RSkNCj4gPiA+DQo+ID4gPiArI2RlZmluZSBNU0hWX01BWF9VTk1BUF9HUEFfUEFHRVMJNTEyDQo+
ID4gPiArDQo+ID4gPiAgc3RydWN0IG1zaHZfdnAgew0KPiA+ID4gIAl1MzIgdnBfaW5kZXg7DQo+
ID4gPiAgCXN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqdnBfcGFydGl0aW9uOw0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYyBiL2RyaXZlcnMvaHYvbXNodl9y
b290X2h2X2NhbGwuYw0KPiA+ID4gaW5kZXggYzljMjc0ZjI5YzNjNi4uMDY5NjAyNGNjZmUzMSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jDQo+ID4gPiBAQCAtMTcsNyArMTcs
NyBAQA0KPiA+ID4gIC8qIERldGVybWluZWQgZW1waXJpY2FsbHkgKi8NCj4gPiA+ICAjZGVmaW5l
IEhWX0lOSVRfUEFSVElUSU9OX0RFUE9TSVRfUEFHRVMgMjA4DQo+ID4gPiAgI2RlZmluZSBIVl9N
QVBfR1BBX0RFUE9TSVRfUEFHRVMJMjU2DQo+ID4gPiAtI2RlZmluZSBIVl9VTUFQX0dQQV9QQUdF
UwkJNTEyDQo+ID4gPiArI2RlZmluZSBIVl9VTUFQX0dQQV9QQUdFUwkJTVNIVl9NQVhfVU5NQVBf
R1BBX1BBR0VTDQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgSFZfUEFHRV9DT1VOVF8yTV9BTElHTkVE
KHBnX2NvdW50KSAoISgocGdfY291bnQpICYgKDB4MjAwIC0gMSkpKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMgYi9kcml2ZXJzL2h2L21zaHZf
cm9vdF9tYWluLmMNCj4gPiA+IGluZGV4IDk3ZTMyMmYzYzZiNWUuLmI2MWJlZjZiOWMxMzIgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2h2L21zaHZfcm9vdF9tYWluLmMNCj4gPiA+ICsrKyBi
L2RyaXZlcnMvaHYvbXNodl9yb290X21haW4uYw0KPiA+ID4gQEAgLTEzNzgsNiArMTM3OCw3IEBA
IG1zaHZfbWFwX3VzZXJfbWVtb3J5KHN0cnVjdCBtc2h2X3BhcnRpdGlvbiAqcGFydGl0aW9uLA0K
PiA+ID4gIHN0YXRpYyB2b2lkIG1zaHZfcGFydGl0aW9uX2Rlc3Ryb3lfcmVnaW9uKHN0cnVjdCBt
c2h2X21lbV9yZWdpb24gKnJlZ2lvbikNCj4gPiA+ICB7DQo+ID4gPiAgCXN0cnVjdCBtc2h2X3Bh
cnRpdGlvbiAqcGFydGl0aW9uID0gcmVnaW9uLT5wYXJ0aXRpb247DQo+ID4gPiArCXU2NCBnZm4s
IGdmbl9jb3VudCwgc3RhcnRfZ2ZuLCBlbmRfZ2ZuOw0KPiA+ID4gIAl1MzIgdW5tYXBfZmxhZ3Mg
PSAwOw0KPiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4NCj4gPiA+IEBAIC0xMzk2LDkgKzEzOTcsMzAg
QEAgc3RhdGljIHZvaWQgbXNodl9wYXJ0aXRpb25fZGVzdHJveV9yZWdpb24oc3RydWN0IG1zaHZf
bWVtX3JlZ2lvbiAqcmVnaW9uKQ0KPiA+ID4gIAlpZiAocmVnaW9uLT5mbGFncy5sYXJnZV9wYWdl
cykNCj4gPiA+ICAJCXVubWFwX2ZsYWdzIHw9IEhWX1VOTUFQX0dQQV9MQVJHRV9QQUdFOw0KPiA+
ID4NCj4gPiA+IC0JLyogaWdub3JlIHVubWFwIGZhaWx1cmVzIGFuZCBjb250aW51ZSBhcyBwcm9j
ZXNzIG1heSBiZSBleGl0aW5nICovDQo+ID4gPiAtCWh2X2NhbGxfdW5tYXBfZ3BhX3BhZ2VzKHBh
cnRpdGlvbi0+cHRfaWQsIHJlZ2lvbi0+c3RhcnRfZ2ZuLA0KPiA+ID4gLQkJCQlyZWdpb24tPm5y
X3BhZ2VzLCB1bm1hcF9mbGFncyk7DQo+ID4gPiArCXN0YXJ0X2dmbiA9IHJlZ2lvbi0+c3RhcnRf
Z2ZuOw0KPiA+ID4gKwllbmRfZ2ZuID0gcmVnaW9uLT5zdGFydF9nZm4gKyByZWdpb24tPm5yX3Bh
Z2VzOw0KPiA+ID4gKw0KPiA+ID4gKwlmb3IgKGdmbiA9IHN0YXJ0X2dmbjsgZ2ZuIDwgZW5kX2dm
bjsgZ2ZuICs9IGdmbl9jb3VudCkgew0KPiA+ID4gKwkJaWYgKGdmbiAlIE1TSFZfTUFYX1VOTUFQ
X0dQQV9QQUdFUykNCj4gPiA+ICsJCQlnZm5fY291bnQgPSBBTElHTihnZm4sIE1TSFZfTUFYX1VO
TUFQX0dQQV9QQUdFUykgLSBnZm47DQo+ID4gPiArCQllbHNlDQo+ID4gPiArCQkJZ2ZuX2NvdW50
ID0gTVNIVl9NQVhfVU5NQVBfR1BBX1BBR0VTOw0KPiA+DQo+ID4gWW91IGNvdWxkIGRvIHRoZSBl
bnRpcmUgaWYvZWxzZSBhczoNCj4gPg0KPiA+IAkJZ2ZuX2NvdW50ID0gQUxJR04oZ2ZuICsgMSwg
TVNIVl9NQVhfVU5NQVBfR1BBX1BBR0VTKSAtIGdmbjsNCj4gPg0KPiA+IFVzaW5nICJnZm4gKyAx
IiBoYW5kbGVzIHRoZSBjYXNlIHdoZXJlIGdmbiBpcyBhbHJlYWR5IGFsaWduZWQuIEFyZ3VhYmx5
LCB0aGlzIGlzIGEgYml0DQo+ID4gbW9yZSBvYnNjdXJlLCBzbyBpdCdzIGp1c3QgYSBzdWdnZXN0
aW9uLg0KPiA+DQo+ID4gPiArDQo+ID4gPiArCQlpZiAoZ2ZuICsgZ2ZuX2NvdW50ID4gZW5kX2dm
bikNCj4gPiA+ICsJCQlnZm5fY291bnQgPSBlbmRfZ2ZuIC0gZ2ZuOw0KPiA+DQo+ID4gT3INCj4g
PiAJCWdmbl9jb3VudCA9IG1pbihnZm5fY291bnQsIGVuZF9nZm4gLSBnZm4pOw0KPiA+DQo+ID4g
SSB1c3VhbGx5IHByZWZlciB0aGUgIm1pbiIgZnVuY3Rpb24gaW5zdGVhZCBvZiBhbiAiaWYiIHN0
YXRlbWVudCBpZiBsb2dpY2FsbHkNCj4gPiB0aGUgaW50ZW50IGlzIHRvIGNvbXB1dGUgdGhlIG1p
bmltdW0uIEJ1dCBhZ2FpbiwganVzdCBhIHN1Z2dlc3Rpb24uDQo+ID4NCj4gPiA+ICsNCj4gPiA+
ICsJCS8qIFNraXAgaWYgYWxsIHBhZ2VzIGluIHRoaXMgcmFuZ2UgaWYgbm9uZSBpcyBtYXBwZWQg
Ki8NCj4gPiA+ICsJCWlmICghbWVtY2hyX2ludihyZWdpb24tPnBhZ2VzICsgKGdmbiAtIHN0YXJ0
X2dmbiksIDAsDQo+ID4gPiArCQkJCWdmbl9jb3VudCAqIHNpemVvZihzdHJ1Y3QgcGFnZSAqKSkp
DQo+ID4gPiArCQkJY29udGludWU7DQo+ID4gPiArDQo+ID4gPiArCQlyZXQgPSBodl9jYWxsX3Vu
bWFwX2dwYV9wYWdlcyhwYXJ0aXRpb24tPnB0X2lkLCBnZm4sDQo+ID4gPiArCQkJCQkgICAgICBn
Zm5fY291bnQsIHVubWFwX2ZsYWdzKTsNCj4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiArCQkJcHRf
ZXJyKHBhcnRpdGlvbiwNCj4gPiA+ICsJCQkgICAgICAgIkZhaWxlZCB0byB1bm1hcCBHUEEgcGFn
ZXMgJSNsbHgtJSNsbHg6ICVkXG4iLA0KPiA+ID4gKwkJCSAgICAgICBnZm4sIGdmbiArIGdmbl9j
b3VudCAtIDEsIHJldCk7DQo+ID4gPiArCX0NCj4gPg0KPiA+IE92ZXJhbGwsIEkgdGhpbmsgdGhp
cyBhbGdvcml0aG0gbG9va3MgZ29vZCBhbmQgaGFuZGxlcyBhbGwgdGhlIGVkZ2UgY2FzZXMuDQo+
ID4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9ucy4gSSBhbHNvIGdlbmVyYWxs
eSBwcmVmZXIgcmVkdWNpbmcgdGhlDQo+IGNvZGUgaW4gYSBzaW1pbGFyIHdheSwgYnV0IGluIHRo
aXMgY2FzZSwgSSBkZWxpYmVyYXRlbHkgY2hvc2UgYSBtb3JlDQo+IGVsYWJvcmF0ZSBhcHByb2Fj
aCB0byBpbXByb3ZlIGNsYXJpdHkuDQo+IA0KPiBTbywgaWYgeW91IGRvbuKAmXQgbWluZCwgSeKA
mWQgcmF0aGVyIGtlZXAgaXQgYXMgaXMsIHNpbmNlIHRoaXMgdmVyc2lvbiBpcw0KPiBlYXN5IHRv
IHVuZGVyc3RhbmQgYW5kIHNlbGYtZG9jdW1lbnRpbmcuDQo+IA0KDQpZZXMsIHRoYXQncyBmaW5l
IHdpdGggbWUuDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9v
ay5jb20+DQo=

