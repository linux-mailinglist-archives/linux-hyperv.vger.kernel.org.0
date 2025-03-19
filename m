Return-Path: <linux-hyperv+bounces-4633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D00A69A2B
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844C419C07B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE2214200;
	Wed, 19 Mar 2025 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NvkgEmbX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010009.outbound.protection.outlook.com [52.103.11.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5411C4A24;
	Wed, 19 Mar 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416160; cv=fail; b=b8rDVKTIqTU5vahSzZ23j14R9EwpMKdqX/zKeP/n2n2fuleVdMhf8UPDmJr0BHFUrXyIl6gw0GqWvFjTuvcv0S943fDVay+WGNW7pTfDI6X+htSwdJ1rkRMefPdzP3PT1Ay1qRITdjvcL8wD7TUE6hWVkA7hdZXLLEhmRUgK9cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416160; c=relaxed/simple;
	bh=IDNiUlc0vXgrySOqB/JopHBFqCm7i1mxl3X+x2eH0cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbqW6XkbXiqe+JLabVh7Ggn+NF4O/j4RkjhD8vVPye2vzW/cHBWPlCg3p9f+QXlmI15L3fvto4cNnxyMQHFEjFKMdSVTw97pS71iVkPM7OY8MjBg4XaD4Am+WqaJFNSptP0bAWeXFa+/vKZqnlRBuiX9GzN/NEoCTggaV+YL4+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NvkgEmbX; arc=fail smtp.client-ip=52.103.11.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSoJfZehv+l0hGyllnP6q13Zsd5fKcebw29xvFRq42VbBn3mmyv6mFcERKw87VJvYIfutPwf1Gj/DtGBF9jiwv8k9uYk2QigONZ7HY8ftpmTU0Z+bo/h1QJfVGlJmONbAybXxATakAsCozC/2yXPgtojQu6LpKulW49hhXJrV10R1eQVYuuQDkTyJ6cJdgXN6YMdlR8DaR4Af3YCyH7iyYXiSBq0k21DfpJtHBuHzAHkyuZ1Oq8JL8YoVJkFr3R65ioDSItC+7JXVJolOL/eD0H0O4VIS9YRoe7nYr0jMWFHDaTx+WJqXNzJ1dsGCEasyz7NRjcj3eoQZzhWL7ETEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDNiUlc0vXgrySOqB/JopHBFqCm7i1mxl3X+x2eH0cw=;
 b=LnANgu9yIg1+aJu0QQuQK1nWgggA1VW8TpqaKFWg16CBouEQcuXye2hx0s80kuzYbcT/l4uAJqiphY1L7BVlgUZMuuk0WYdPzyo0OV/o8T3MHZmorRjztwO69vmdE4IdwIf3mNnrDysAx2+UkPg2En8QN47k93ourCcmV/ZBm4+Wq3Fz2Gnh3jLbDnCQcP9fyxIaq0tbbx8+HFpZdd6Y4T1Vw1CqxGD1lJjWY3wQuavbSamhKmZ8Ez0Xat2+cFpCZuLWqlAz0niqG8gIkn7ZWT/ZhS5OHPK3VEnM1/mzcsmhkP6+g3rsarBKaWgyXVJ6136pYD2uVjQ3OtSQtndjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDNiUlc0vXgrySOqB/JopHBFqCm7i1mxl3X+x2eH0cw=;
 b=NvkgEmbXS+BIuPppV5glWf/Y8/dzswmY/mGsW1Zt6xm0n06hmY9Inqi0hv26H1nMmGhn80ZeSO5JEL74ePwQlcWI1QWgNOk4klTWgHHSQFqI5vfo9Wi58Y3hgPLR3x2fRRByugc2SrIc1rPVnm9XCg/CKVMBA62NQf2euKgeeCbIISF5f0/xabAvpQtLpIZ9YKgOo74+y8n0jOzrud3Uif230DuA9RGn3kJdUITlosyS3wbKD0tVNmFoj6nQMgUdY2LAAa3rh6tLmKMd6MZ/09uzqupHwL74ALT4UrmFI12hAY7F/67p2xQys5PgDk5/FOYG2eD6xTM5655MoB/deA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BY5PR02MB6658.namprd02.prod.outlook.com (2603:10b6:a03:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Wed, 19 Mar
 2025 20:29:13 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 20:29:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Helge Deller <deller@gmx.de>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: fbdev deferred I/O broken in some scenarios
Thread-Topic: fbdev deferred I/O broken in some scenarios
Thread-Index: AduXqaeNbacCNH8yTNyrrucfCfcIpQANFPoAAEthzCA=
Date: Wed, 19 Mar 2025 20:29:12 +0000
Message-ID:
 <BN7PR02MB4148157E5307E306FD9D093ED4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de>
In-Reply-To: <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BY5PR02MB6658:EE_
x-ms-office365-filtering-correlation-id: 8f795afc-4951-4168-f573-08dd6724b63e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|8060799006|15080799006|440099028|3412199025|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2ZXblNzdkQrZ0tIRzB2MzJHcEExOEhKbUFUdTgydThzMktWR2JFc29tblpK?=
 =?utf-8?B?Rk9ESzl5a3VZNzlGOXZqcjRLcWk5dUEzRVlTUlIxMWo2ZjlBVndneHJxN2pi?=
 =?utf-8?B?dDBoVStOcmZMUHZhK1dBQ1ZWcWlMVEVENDJkdEhuRHcrR2VpMVZla3E5MlBD?=
 =?utf-8?B?QXZRZUcwV1RHc2FvTUEwMS9SV2kxUUpPNWZpUXVaVzEvNjB5dHBodWVIMDk5?=
 =?utf-8?B?QjErMks1c1RKTU5KdFJOaFhnSWVyRHcyQ29LT2hUSHFhVE1tWU5PL3Z1RXls?=
 =?utf-8?B?TVFRS0RJUXRzR3l6S3U0dXgxMHhkT1EwRm1SVy9nWjBaWE5KemF0bUtTZW9I?=
 =?utf-8?B?eTZMR1Q0U2xGTllxWjcyWGVxeGpLRm55MWNsWUZsemJObmViTWtRdUhBUHhz?=
 =?utf-8?B?aXZzMi9POEFUL1ZEaTkwaGUwU1lLc2liVEFsNkhnWGJYYVEvL1UwTkNtL1Bs?=
 =?utf-8?B?K1M2ZlRuTlpablFUV2FDeDR5cWJvYUgvRkM4SXVWbm85U0kvZXU4a1BVMGNj?=
 =?utf-8?B?OEhMc2hVd1hTcWIrb0FuSE9UN1BuUjBmb214ZUhWMDQ4aWQ0N2lsOWt4SGNK?=
 =?utf-8?B?R2x2aGY5VUtqL3hneWd3TGhpdkNnTXN3blNuaDUraEszQ01qMldLanZRZTRO?=
 =?utf-8?B?ZnJROFFFZExvNnNhc1FYTkdiY1o3TkZtaFhtVUpvbmN3NlVRWmFEZmx0T2lZ?=
 =?utf-8?B?Smh5eXJkNGFscXNVcS9Hcm5FQXo3WGVkRmhRVWp1L1lCUGc0ejMzZy9raUpF?=
 =?utf-8?B?V0h0ZGh2eU1BbDBLMW9WZlJJNlJ2T3J1RVBYR0NQcDFHSVM2NzZNQXVjcW5L?=
 =?utf-8?B?cGV4eDVmN296WXZ0eTFObTljdTBHb3c0UWd3TVFHTGVLNWlLS0cyV2FMdXpF?=
 =?utf-8?B?T1lDVWhna1QyUGhFSFRFNnRZOU9hb0JyR0loK1ZZUjN2eW5aMlNVQ2VMRXRK?=
 =?utf-8?B?ZDBJdHhIU2RLay9SU0pBS3hMWTc0a1VvU3VhVGlCQVRtQVRMbFQzQ1lRR05r?=
 =?utf-8?B?RnBST2Q0MHRYZlR5Z1dCbGZJQVgvaUxvWlRKdzFwSEtkWU1PeG9HMzhsQ1ZJ?=
 =?utf-8?B?dzBUMUp3dUhYbGk2b2VsMm15L0F2aVVmZXl0WjQrN09IeTZFZjRBeHg4bWpz?=
 =?utf-8?B?ZUlCVXhNRUNMTnFIZXFjMm1XVnUrNmRBVHhwbG9LVkRKWTV5eVg2bUZ6NVF3?=
 =?utf-8?B?QXVjUTZiN3lGNHVoTHF2VDBoUG0yNkVWa3AxL3h1UVdZTHZCcWhjT1lmT3Er?=
 =?utf-8?B?SlZsUzBHbFl3NWx6SjNxR0ZOWlpwZEgvN1RqdjFVQkNEenNrb2daSFEwNGE4?=
 =?utf-8?B?NnJHdTJnSlRBdlkxTjVJN09LVFBkMDdKRjBXcWIveHpoelduOUpJNlUyTTV6?=
 =?utf-8?B?RUNrQ3IyUDVIbW1CMzBuRUN5K2o0aG9zaFVvTERPbVp1bk9sSEM5MmI3cVVu?=
 =?utf-8?B?b0RYMUliZTd6WlBXcDRHeCtPejhDRXFLRGd4V3VFUDkxa2hzNzJYeWdIdXpP?=
 =?utf-8?Q?Cuu+7K/eKTyuijeRyY7ddWDUYtd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wnk2c0piUVpVL0hYYXJ4cTYrZUU5WXByeVU2a0JsbS9BeUVmU1FCcmxpL1dh?=
 =?utf-8?B?REt2QzVHNm1ZZkkvS3dzZHZsY1pDdXozcEtPOWd5dlQwQ2pROHQvdDdoVXZt?=
 =?utf-8?B?dEs0VmNzM2MzOFhoQTVxbFBqUG81SHhpek5RRXE4Rk5YSW9mWG5oUjZNNGRi?=
 =?utf-8?B?b1JHbnR4UWtqem9GNFd1ekJyck8wdVhYKytlZFhvYWJLTmNIeDBjcGlRVjE1?=
 =?utf-8?B?dlhJdWdTeStvSW5XREhQUmtDeTFjR3Z0UTJWM1kzNVZMNDNNSVQ5QWZmOS9U?=
 =?utf-8?B?UFNTZ0RQMVdiYkx4RzJUVlF4MUJIU1JnUjZ4RU8yNDBkM3RWWVNvY0RYbzV6?=
 =?utf-8?B?WmVPaHFuSDRRY3R6K3VZblpGMDVIYkpKc3BpZWs5bEVTTTZMdVZWRDk5L24r?=
 =?utf-8?B?QktjQlJTTmhVMVY2WnFJaENVdVlxV0FXN0V4eXdaa2hnUTJjZDJrRWtCRFNU?=
 =?utf-8?B?TnZLV2VEZjJUbmNjeHBhdEZsNDBSTUZEWE43Y0o3NUJmdVYrU3QxNDV3RkdU?=
 =?utf-8?B?QUMrZ3pVZ2MzMUJTRnViYW1qSFZEQ01yeWhJUEF5eUlKYVFRNEJtc2xNbTZU?=
 =?utf-8?B?Nml6M25wR2tXRkozZUloQkhRNHdleVArNXpscDRRenNBc2Z2Q1lEMnppbzQ3?=
 =?utf-8?B?Mm11Y1Q4eWNVZVQ3TzNXVHo3Uy84SFQza2VSTStRb3J2bXRZZ0VHeWJxU0hH?=
 =?utf-8?B?ZHVDMy9CdFlxSndyVWVRSFFJMUVpVlFIdHR6RDRXRk5tOGY4TnhxaHlDajFI?=
 =?utf-8?B?b3NIdVpuN1lMaWJXMitpSzF6WFJoWmlSSEwvNC9uYkU2bnEvcGRnV2Q2aDBy?=
 =?utf-8?B?dWNDQ0NyR2F5MFZXZ1Q0TkxsVFFjTE9nODRES0VVVVZ0MnpjMjQvZ2g0dFlI?=
 =?utf-8?B?ZDA5WXJhb3lTaVlOWXNyZWhzOWRDdjhvc0p1NDhhc2lQNGN6MWowS2RMSnlL?=
 =?utf-8?B?WndDWDVVQXd5a05MREFUbHo4alFMdXR0NGVSTGw5bS9qdjd5Q0JsMjllZmdx?=
 =?utf-8?B?dU1JQVpYQVNrWFVScHkyazNlcWl4bjZYMEp6UW1iUG56N3JoVjBCVGg2NUtE?=
 =?utf-8?B?VkgyYjk2cU9TRGlNK2k2Z0RjLzRtbElyVmIrd3pIZ25IV2Y2VHhnYXVXSlE3?=
 =?utf-8?B?QmJ4aVRSNDdIamp0bTBGbGVLRnBIZW9wMHpSc3NVMnJyTTExQTVCZlpIZzBU?=
 =?utf-8?B?cmpmWjlLdU1zTXk0SGxqVUJoaDJHemhlR2hSbTQrNENyMHlWb1cyb1J5ZUtF?=
 =?utf-8?B?aUJMTngzK052NnBWSWtJWVhDbXBzQWREMUxUSFZOeW8xVllTSVBLTzZjSTdY?=
 =?utf-8?B?aEFDZWRtNUhOWkFnOWdZdVowWGlvdWdobW9zb3lVZ3FpeWc3eXZIWE0yUEN6?=
 =?utf-8?B?ZDMvaHJmbmhTa05kR0YrUnprcklmZDJpNEdUV3JkWFZtWHg3WXRLUy83ZVp0?=
 =?utf-8?B?M1dPejVYZ2JZTUVOdis1YUUvc2F2NDA2TVFGYlNaNG9RNmNDNzFid25teXB1?=
 =?utf-8?B?dW5Fd0wrcWkva0pVMnJvVmhPR3VQWWpveFVxZktiQXhKUVQrbXJnTmhBeEN3?=
 =?utf-8?B?RXlVQ29BNHNTUkFxclFvaEhTakhPclBDRW4veExyTUlWVm1mVjlyOFY4cEhZ?=
 =?utf-8?Q?bee9TxtBPN9Y2M1//kpFbFnYzSmjpDd7GJFgNtNeTifk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f795afc-4951-4168-f573-08dd6724b63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 20:29:13.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6658

RnJvbTogSGVsZ2UgRGVsbGVyIDxkZWxsZXJAZ214LmRlPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAx
OCwgMjAyNSAxOjE2IEFNDQo+IEhpIE1pY2hhZWwsDQo+IA0KPiBPbiAzLzE4LzI1IDAzOjA1LCBN
aWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIGdldCBtbWFwKCkg
d29ya2luZyB3aXRoIHRoZSBoeXBlcnZfZmIuYyBmYmRldiBkcml2ZXIsIHdoaWNoDQo+ID4gaXMg
Zm9yIExpbnV4IGd1ZXN0cyBydW5uaW5nIG9uIE1pY3Jvc29mdCdzIEh5cGVyLVYgaHlwZXJ2aXNv
ci4gVGhlIGh5cGVydl9mYiBkcml2ZXINCj4gPiB1c2VzIGZiZGV2IGRlZmVycmVkIEkvTyBmb3Ig
cGVyZm9ybWFuY2UgcmVhc29ucy4gQnV0IGl0IGxvb2tzIHRvIG1lIGxpa2UgZmJkZXYNCj4gPiBk
ZWZlcnJlZCBJL08gaXMgZnVuZGFtZW50YWxseSBicm9rZW4gd2hlbiB0aGUgdW5kZXJseWluZyBm
cmFtZWJ1ZmZlciBtZW1vcnkNCj4gPiBpcyBhbGxvY2F0ZWQgZnJvbSBrZXJuZWwgbWVtb3J5IChh
bGxvY19wYWdlcyBvciBkbWFfYWxsb2NfY29oZXJlbnQpLg0KPiA+DQo+ID4gVGhlIGh5cGVydl9m
Yi5jIGRyaXZlciBtYXkgYWxsb2NhdGUgdGhlIGZyYW1lYnVmZmVyIG1lbW9yeSBpbiBzZXZlcmFs
IHdheXMsDQo+ID4gZGVwZW5kaW5nIG9uIHRoZSBzaXplIG9mIHRoZSBmcmFtZWJ1ZmZlciBzcGVj
aWZpZWQgYnkgdGhlIEh5cGVyLVYgaG9zdCBhbmQgdGhlIFZNDQo+ID4gIkdlbmVyYXRpb24iLiAg
Rm9yIGEgR2VuZXJhdGlvbiAyIFZNLCB0aGUgZnJhbWVidWZmZXIgbWVtb3J5IGlzIGFsbG9jYXRl
ZCBieSB0aGUNCj4gPiBIeXBlci1WIGhvc3QgYW5kIGlzIGFzc2lnbmVkIHRvIGd1ZXN0IE1NSU8g
c3BhY2UuIFRoZSBoeXBlcnZfZmIgZHJpdmVyIGRvZXMgYQ0KPiA+IHZtYWxsb2MoKSBhbGxvY2F0
aW9uIGZvciBkZWZlcnJlZCBJL08gdG8gd29yayBhZ2FpbnN0LiBUaGlzIGNvbWJpbmF0aW9uIGhh
bmRsZXMgbW1hcCgpDQo+ID4gb2YgL2Rldi9mYjxuPiBjb3JyZWN0bHkgYW5kIHRoZSBwZXJmb3Jt
YW5jZSBiZW5lZml0cyBvZiBkZWZlcnJlZCBJL08gYXJlIHN1YnN0YW50aWFsLg0KPiA+DQo+ID4g
QnV0IGZvciBhIEdlbmVyYXRpb24gMSBWTSwgdGhlIGh5cGVydl9mYiBkcml2ZXIgYWxsb2NhdGVz
IHRoZSBmcmFtZWJ1ZmZlciBtZW1vcnkgaW4NCj4gPiBjb250aWd1b3VzIGd1ZXN0IHBoeXNpY2Fs
IG1lbW9yeSB1c2luZyBhbGxvY19wYWdlcygpIG9yIGRtYV9hbGxvY19jb2hlcmVudCgpLCBhbmQN
Cj4gPiBpbmZvcm1zIHRoZSBIeXBlci1WIGhvc3Qgb2YgdGhlIGxvY2F0aW9uLiBJbiB0aGlzIGNh
c2UsIG1tYXAoKSB3aXRoIGRlZmVycmVkIEkvTyBkb2VzDQo+ID4gbm90IHdvcmsuIFRoZSBtbWFw
KCkgc3VjY2VlZHMsIGFuZCB1c2VyIHNwYWNlIHVwZGF0ZXMgdG8gdGhlIG1tYXAnZWQgbWVtb3J5
IGFyZQ0KPiA+IGNvcnJlY3RseSByZWZsZWN0ZWQgdG8gdGhlIGZyYW1lYnVmZmVyLiBCdXQgd2hl
biB0aGUgdXNlciBzcGFjZSBwcm9ncmFtIGRvZXMgbXVubWFwKCkNCj4gPiBvciB0ZXJtaW5hdGVz
LCB0aGUgTGludXgga2VybmVsIGZyZWUgbGlzdHMgYmVjb21lIHNjcmFtYmxlZCBhbmQgdGhlIGtl
cm5lbCBldmVudHVhbGx5DQo+ID4gcGFuaWNzLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdoZW4gbXVu
bWFwKCkgaXMgZG9uZSwgdGhlIFBURXMgaW4gdGhlIFZNQSBhcmUgY2xlYW5lZA0KPiA+IHVwLCBh
bmQgdGhlIGNvcnJlc3BvbmRpbmcgc3RydWN0IHBhZ2UgcmVmY291bnRzIGFyZSBkZWNyZW1lbnRl
ZC4gSWYgdGhlIHJlZmNvdW50IGdvZXMNCj4gPiB0byB6ZXJvICh3aGljaCBpdCB0eXBpY2FsbHkg
d2lsbCksIHRoZSBwYWdlIGlzIGltbWVkaWF0ZWx5IGZyZWVkLiBJbiB0aGlzIHdheSwgc29tZSBv
ciBhbGwNCj4gPiBvZiB0aGUgZnJhbWVidWZmZXIgbWVtb3J5IGdldHMgZXJyb25lb3VzbHkgZnJl
ZWQuIEZyb20gd2hhdCBJIHNlZSwgdGhlIFZNQSBzaG91bGQNCj4gPiBiZSBtYXJrZWQgVk1fUEZO
TUFQIHdoZW4gYWxsb2NhdGVkIG1lbW9yeSBrZXJuZWwgaXMgYmVpbmcgdXNlZCBhcyB0aGUNCj4g
PiBmcmFtZWJ1ZmZlciB3aXRoIGRlZmVycmVkIEkvTywgYnV0IHRoYXQncyBub3QgaGFwcGVuaW5n
LiBUaGUgaGFuZGxpbmcgb2YgZGVmZXJyZWQgSS9PDQo+ID4gcGFnZSBmYXVsdHMgd291bGQgYWxz
byBuZWVkIHVwZGF0aW5nIHRvIG1ha2UgdGhpcyB3b3JrLg0KPiA+DQo+ID4gVGhlIGZiZGV2IGRl
ZmVycmVkIEkvTyBzdXBwb3J0IHdhcyBvcmlnaW5hbGx5IGFkZGVkIHRvIHRoZSBoeXBlcnZfZmIg
ZHJpdmVyIGluIHRoZQ0KPiA+IDUuNiBrZXJuZWwsIGFuZCBiYXNlZCBvbiBteSByZWNlbnQgZXhw
ZXJpbWVudHMsIGl0IGhhcyBuZXZlciB3b3JrZWQgY29ycmVjdGx5IHdoZW4NCj4gPiB0aGUgZnJh
bWVidWZmZXIgaXMgYWxsb2NhdGVkIGZyb20ga2VybmVsIG1lbW9yeS4gZmJkZXYgZGVmZXJyZWQg
SS9PIHN1cHBvcnQgZm9yIHVzaW5nDQo+ID4ga2VybmVsIG1lbW9yeSBhcyB0aGUgZnJhbWVidWZm
ZXIgd2FzIG9yaWdpbmFsbHkgYWRkZWQgaW4gY29tbWl0IDM3YjQ4Mzc5NTljYjkNCj4gPiBiYWNr
IGluIDIwMDggaW4gTGludXggMi42LjI5LiBCdXQgSSBkb24ndCBzZWUgaG93IGl0IGV2ZXIgd29y
a2VkIHByb3Blcmx5LCB1bmxlc3MNCj4gPiBjaGFuZ2VzIGluIGdlbmVyaWMgbWVtb3J5IG1hbmFn
ZW1lbnQgc29tZWhvdyBicm9rZSBpdCBpbiB0aGUgaW50ZXJ2ZW5pbmcgeWVhcnMuDQo+ID4NCj4g
PiBJIHRoaW5rIEkga25vdyBob3cgdG8gZml4IGFsbCB0aGlzLiBCdXQgYmVmb3JlIHdvcmtpbmcg
b24gYSBwYXRjaCwgSSB3YW50ZWQgdG8gY2hlY2sNCj4gPiB3aXRoIHRoZSBmYmRldiBjb21tdW5p
dHkgdG8gc2VlIGlmIHRoaXMgbWlnaHQgYmUgYSBrbm93biBpc3N1ZSBhbmQgd2hldGhlciB0aGVy
ZQ0KPiA+IGlzIGFueSBhZGRpdGlvbmFsIGluc2lnaHQgc29tZW9uZSBtaWdodCBvZmZlci4gVGhh
bmtzIGZvciBhbnkgY29tbWVudHMgb3IgaGVscC4NCj4gDQo+IEkgaGF2ZW4ndCBoZWFyZCBvZiBh
bnkgbWFqb3IgZGVmZXJyZWQtaS9vIGlzc3VlcyBzaW5jZSBJJ3ZlIGp1bXBlZCBpbnRvIGZiZGV2
DQo+IG1haW50ZW5hbmNlLiBCdXQgeW91IG1pZ2h0IGJlIHJpZ2h0LCBhcyBJIGhhdmVuJ3QgbG9v
a2VkIG11Y2ggaW50byBpdCB5ZXQgYW5kDQo+IHRoZXJlIGFyZSBqdXN0IGEgZmV3IGRyaXZlcnMg
dXNpbmcgaXQuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBpbnB1dC4gSW4gdGhlIGZiZGV2IGRpcmVj
dG9yeSwgdGhlcmUgYXJlIDkgZHJpdmVycyB1c2luZyBkZWZlcnJlZCBJL08uDQpPZiB0aG9zZSwg
NiB1c2Ugdm1hbGxvYygpIHRvIGFsbG9jYXRlIHRoZSBmcmFtZWJ1ZmZlciwgYW5kIHRoYXQgcGF0
aCB3b3JrcyBqdXN0IGZpbmUuDQpUaGUgb3RoZXIgMyB1c2UgYWxsb2NfcGFnZXMoKSwgZG1hX2Fs
bG9jX2NvaGVyZW50KCksIG9yIF9fZ2V0X2ZyZWVfcGFnZXMoKSwgYWxsIG9mDQp3aGljaCBtYW5p
ZmVzdCB0aGUgdW5kZXJseWluZyBwcm9ibGVtIHdoZW4gbXVubWFwKCknZWQuICBUaG9zZSAzIGRy
aXZlcnMgYXJlOg0KDQoqIGh5cGVydl9mYi5jLCB3aGljaCBJJ20gd29ya2luZyB3aXRoDQoqIHNo
X21vYmlsZV9sY2RjZmIuYw0KKiBzc2QxMzA3ZmIuYw0KDQpEbyB5b3UgaGF2ZSBhbnkgb3duZXJz
aGlwIG9yIHN0YXR1cyBpbmZvcm1hdGlvbiBhYm91dCB0aGUgbGFzdCB0d28/ICBOZWl0aGVyIGlz
DQpsaXN0ZWQgaW4gTUFJTlRBSU5FUlMsIHNvIG1heWJlIHRoZXkgYXJlIGZvciBvbGQgZGV2aWNl
cyBhbmQgbm93IGVmZmVjdGl2ZWx5DQphYmFuZG9uZWQuIEJlZm9yZSBJIG1ha2UgY29kZSBjaGFu
Z2VzIHRvIGZiX2RlZmlvLmMsIEkgd2FudGVkIHRvIG1ha2Ugc3VyZQ0KSSBoYXZlIGFsbCB0aGUg
Y29udGV4dCBJIGNhbiBnZXQsIHN1Y2ggYXMgd2h5IHRoaXMgcHJvYmxlbSBoYXNuJ3Qgc3VyZmFj
ZWQgb3V0c2lkZQ0Kb2YgdGhlIGh5cGVydl9mYi5jIGRyaXZlci4gUGFydCBvZiB0aGUgcmVhc29u
IGlzIHRoYXQgZXZpZGVudGx5IHRoZSB2bWFsbG9jKCkgYmFzZWQNCmFwcHJvYWNoIGlzIG1vcmUg
Y29tbW9uLCBhbmQgaXQgd29ya3MgZmluZS4gV2l0aCBvbmx5IHR3byBvdGhlciBkcml2ZXJzIHVz
aW5nDQpjb250aWd1b3VzIGtlcm5lbCBtZW1vcnkgYWxsb2NhdGlvbnMsIGFuZCB3aXRoIHRob3Nl
IHR3byBwZXJoYXBzIGJlaW5nIGZvciBvbGQNCmFuZCBub3cgbW9zdGx5IHVudXNlZCBkZXZpY2Vz
LCB0aGF0IG1pZ2h0IGV4cGxhaW4gdGhpbmdzLiBUaGUgaHlwZXJ2X2ZiLmMNCmNvbmZpZyB0aGF0
IHVzZXMgY29udGlndW91cyBrZXJuZWwgbWVtb3J5IGlzIGFsc28gc29tZXdoYXQgcmFyZSwgYW5k
IEkgb25seQ0Kc3R1bWJsZWQgYWNyb3NzIGl0IHdoZW4gZGVidWdnaW5nIG90aGVyIHByb2JsZW1z
Lg0KDQpJbiBhbnkgY2FzZSwgSSdtIHByZXR0eSBjb252aW5jZWQgdGhpcyBpcyBhbiBpc3N1ZSB3
aXRoIGZiX2RlZmlvLmMgYW5kIG5vdA0Kc29tZXRoaW5nIHNwZWNpZmljIHRvIGh5cGVydl9mYi5j
LCBzbyBJJ2xsIGdldCB0byB3b3JrIG9uIGEgZml4IGFuZCBob3cgaXQgZ29lcw0KZnJvbSB0aGVy
ZS4NCg0KTWljaGFlbA0K

