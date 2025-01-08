Return-Path: <linux-hyperv+bounces-3602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75ADA0525D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 05:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0DD7A29C8
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DC198A11;
	Wed,  8 Jan 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZqtLRvUw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA218EB0;
	Wed,  8 Jan 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736311822; cv=fail; b=N+QWR+ZgENsC9m8rYysXzGAuu2EXkq1MKtKTKc5WxuS9+YnZkt29y30ZfXKXa/obY8FwfgbAjZNnsukeiDSTVI6xQpeVkhfgxlN5vwwp+pSlGcQs8NPNKMxr3mOkZM/ZuFWORyAhBomVrRIXf6mawEwE4Go3GlxkQiymgu13tm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736311822; c=relaxed/simple;
	bh=hBPujfCW99dEm6c4USExsJdrhkyCumSbG6YmjBVIQ6M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3+dglY46Is37GO8Wxn/ML/Dk9IodLNGXku0Nny1sBnpMf0Mdd8sfypiShoJQ40P92/Ikl4bFtn6tq5FR8Ma14b71T/oEThM2a3+dgaPf9y4Ke2TTiR1Lft24lDIptUfuWrIMJsfEuEy1zBTAJFZ0Os7jY9Aq+yEcWVWybT7s+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZqtLRvUw; arc=fail smtp.client-ip=52.103.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/p+k64IOYoGvxSrmDw0daL3zf18SDH3Vdf+NJFNhuJKLbaOn1H/5d3FzNpkMdgU2KvTW4vOVnvldUJzcJhwqEcFgxZ99WIJTuE1/Z1qHlHfrDwRjMmFhNhxRXixVsLAij534jLDFi2JfOY3laJGDI4BBoKKOVyrsnVhVyEDb3sEZR4jlJuoPEfli1GgMQ1GhFKKmQi6XNCIkjGDs6VsXu678VJaz3j8Cuvj+JRS2uYWNtDDeU1EUpQsNXorYGvvEY3oju77poWvrkALmviYtn6tn6XeJ8FcjZm/+UvECJeNIxHBBi9DzyndVCFfpcRlYoIjRZSifLJdJ3Fj0yaZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBPujfCW99dEm6c4USExsJdrhkyCumSbG6YmjBVIQ6M=;
 b=wZa8Gk/AbqItsjyElot2dqXezUNITqbR57w3jtsy3nKKGRdMqGmNmU24OyAAGZTzo/XlauqchMg75l0HPOtO2GWeZCJ49nCeS5TUOkCtbYe2hyjLwsJJPaiwnhjyWWF3KcixPq2dOeYfMoeDch5hNmasj9OHROuyqEq9yZe6EJ1AQkqV8ApMyywdLHkjUx5SjG4QVQcrB7mZndRMnxcCiEJqOEpWQhGTFjuyQNxHhFqdQzBmaWj4BXmrzoHd5lYCBbswn7ymA+fzM/kPQD3fJFNDatTiYE9jFOOhCdm/LaOHsH7K/VxpN0MCeEKq+75uLr0xpoqZWx+3z0XPU2Yqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBPujfCW99dEm6c4USExsJdrhkyCumSbG6YmjBVIQ6M=;
 b=ZqtLRvUwSfHuFC5ve9l/FhvKGkgnqLmoZVxNmxL3hnTohmoIB7nwYAsjaVkrj2ZDJwZBkGVC/c6SdVgh2pdzO8CTA56QFKNQbvU/46aqFsT6NNGC4oywT65m1x4W06Ns/I5zllTxDtT8ilWLK36j/i6Qmvz7WUpZyf2E6mOec9sWl3Jwsr8bpKUmEnE4P36YWvPRVcjAipsfPnEEfzdZsx6+OXDKxpl65BEY+S4G+3YwkQWjbIsDu8ExLNuYDtpDj1pdRHVO3miOZS2r4GVNJ7Me54cP1DNq804dPwzvREcJ2+j9Ij9YBhMt1VTy9mtS8hdH29pGHgYxlwNtnz47Sw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8534.namprd02.prod.outlook.com (2603:10b6:510:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 04:50:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 04:50:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Topic: [PATCH v2 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Thread-Index: AQHbYUGyOe7qvwtFeESlC0Kh/PGqmLMMQuKAgAAGd5A=
Date: Wed, 8 Jan 2025 04:50:15 +0000
Message-ID:
 <SN6PR02MB4157AC80E1975CE9BB6E3E62D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250107202047.316025-1-mhklinux@outlook.com>
 <Z335xwWRTjyX0u6G@archie.me>
In-Reply-To: <Z335xwWRTjyX0u6G@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8534:EE_
x-ms-office365-filtering-correlation-id: d732dba5-bd94-42d9-b11f-08dd2f9ff1b3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|56899033|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yi9sN3pOVC9NZEFER2NwaFJMMnlXT3M2c1BGa0hNUWh1TVlWc2JMSmhXaXIx?=
 =?utf-8?B?K1VDd20wMGNpZnN2c3RkTC9BOWlkakFCbndHWHc1cXZFaklZcWY1N0dSRkdm?=
 =?utf-8?B?OUJBOEozN1FhNEwzS0FRSng3dVcyaFlwNkg5TkNRa1lLVitYeEVVWFBUN1BX?=
 =?utf-8?B?OW1vNk9TV2Z1d3Q3VFQzQkdSalVaME9zK2QvTzh3M1NMWjNTVXhpYm9SUXJO?=
 =?utf-8?B?M0pXMWhMM2hHQ3BRMG91WXhLZ3RTckFnT3FYbWJ4TjJKRUVjbGxZcGJkRzBK?=
 =?utf-8?B?N1A2RkY1ZE56a2pZa3Z6aDRqNkpXMUkyREM5YVlGZC9qelI2QWZiWDhOT2Qy?=
 =?utf-8?B?em1QdkJPVk56NmR0RDhkQXFXTGFieUIrWTc3bzY1YlhSQzhJMFJ3OEFMdWlh?=
 =?utf-8?B?L05Hc1NvNHZsYzFyeE53SDBkaDUwclVuSzF4V3I1TDkzMzJuQ3J2bWlGdExl?=
 =?utf-8?B?clBkWWorWGVVR3FSaU9QNFZpV3VkRGk1WnBXR1pzREhyMERMOVJCdG9vWVhi?=
 =?utf-8?B?NlgwMGRSa2x0bktuUVZ1Nk91QTVGeG1OakZ4NVJ4aVlZK1V4MG54RjNFenpz?=
 =?utf-8?B?SDI5WW5SbkFtSGlhZDY2WFg4ZFhUUTRiRDJocnlPcEd6c2FGUWYzNzdiZjhn?=
 =?utf-8?B?TTgrT3R3N0crN3dXb0QxSVZBSnJYMG5yYTF3T1dzMmVJRkdwSnBOUzE1bVow?=
 =?utf-8?B?aCtyN3hSRWlrWmhhQWVJWUUvMlUzUUo1aEJpR3pWSzFXd05DTE1KK3JZcW1z?=
 =?utf-8?B?RStlWGxmdWd1NEpEekxzTFI2cG9raERpaWF6bVFMUm9VZ3h2TUVzL3NHdk83?=
 =?utf-8?B?a25VVHlGdnRubVd0bGRuMTI4bmo2OGVjUE5zeFRTM0JLanhsaEVCc3lXZUpY?=
 =?utf-8?B?bldYYkNDNGFBeC8razJBQnBhU3EvSUM1Z2RjdTAvQ0dEYWl0TjN2Rk1NUlNM?=
 =?utf-8?B?ZWVyUWNWTEtKUXBLU2xRbHlPZW00NzU1blJ1eFdqakhDZU0yMkx0eldqSUI5?=
 =?utf-8?B?TzhVK3pOWHVUYUwzY2J2ZlkySzJzUmxXbVFWRWtUNWY2M3BBOGl6RkdtQ0Ur?=
 =?utf-8?B?ZUtSeDh5dm5mdzJxeGJRTWtRUDIwV1NQWnVJZzBzWVJwenZkeis4cm5pVUJD?=
 =?utf-8?B?bEhUSTBpQ2tyMUNoR3RSbDlNbGYzeU9QL09sRlgydjBsTnE0djhpaG9KTkY3?=
 =?utf-8?B?MGJvTGN1SXdrWnZmVkFoNUkzUnA3bTlLOHUwZjh4OEVSNS9Rdko3N0hOWlFm?=
 =?utf-8?B?RXM0V2I5Zll0SGIxVGZUTW5SaXhyMGhmWWIveit1cjh3dGtYcWhjcVVnVStE?=
 =?utf-8?B?MGJrTHBZeTkxM2lueGozQThmeGduamo5Y1pmSGtpeTh0NWZFZ0FVazlEbW1X?=
 =?utf-8?Q?SpSPnVzyL+HKRvaAR/aMju/DKn7Xo+Ys=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWpSMy85bzZQOE9jM0QvdHdldEtaaXhFalBSdWZ1Z1FJUGFDQ2NFUTQ2WVlw?=
 =?utf-8?B?Z2hNdi9wQUF3QXpGOVVwSjV5UjZ5VklwMGJUZ1NicFJZeU5HQTRXVXIrOUpX?=
 =?utf-8?B?T2M5RUFGS0RoTDB1M0tWcER0eDd3WDkvNUl6aEpMdHpEbUs2U0o2RDhtTDVr?=
 =?utf-8?B?V293cFJZYWxETHNKbkVTQ1VJVWpqRzFxam9pRWM4YW5PdW1WZlNNSFhnMmo5?=
 =?utf-8?B?Rzd4S3Bud1B1bDlLR2pVVWI1N0NGU0JzRmp0bXZrV0F1OTBROTl0WUVMUmpy?=
 =?utf-8?B?V3h0VXl3RWNtY1dJdjhMT0kyaURtMUhqY3VzV3Jkc0RUaUJkSHdrN2R4Zjht?=
 =?utf-8?B?aE5DV0tnM1h5ZHk0d3JIYjlvRTNqUXVaS1hrL2svQkRjZTFTdmdpZWEyNWd2?=
 =?utf-8?B?TmREdXVFSUxtZXYvUW4xa05QODNJRTZUVm4rRGJMQzM0VHp2MlBBZ3pIczRY?=
 =?utf-8?B?RTNkWm5maUdHdURDdWlCZG54ZTZoYkM2VEVudU9mWDhGY2NrN2krblFBbGI3?=
 =?utf-8?B?ZzhPSXFsZC84NTFHR2NMVzU5ZndtTXg4T3FNSDJZMjlIdFJzLzBYNWo2TWhE?=
 =?utf-8?B?bWVmdFJ0VzF5QWQ1TzhjRUdZWW9YMUpSbVFkbm5zTS9QMTZyTVJOaGFrNmxz?=
 =?utf-8?B?YTM4MDMvV01QZGt2UHR2TTVCYzlibUpxYUtFV0VRK3M1REJnOElZeldLcldH?=
 =?utf-8?B?U2wvZXhEc3g0c0svY0tsL0xzM3l0eHlwNjVtbUdzdmdqUHgxMmorZ3JFTHZE?=
 =?utf-8?B?NkRwNXQzTjJZeC8vRUNoTm12Ri8rYWNzVFhLVC81ZU5wMFhvWW5Hd01tS2xZ?=
 =?utf-8?B?a0p2M1g2TE5KNEVmN1NaTkxtV2FRNWsrRWdZWGRsWVNDdXU4WWZjMk04YXQ5?=
 =?utf-8?B?SHBrdmpUUk9CYXVGak9acTYwL1pmaVRWOXFxdUtZcitISERvd3hjek5RWjdy?=
 =?utf-8?B?eVNRRVlEaERTdHAzSkZrZjRyVGhEdGhaS1d3MkpOQlJXR0ZQWFprL1pDdE5r?=
 =?utf-8?B?THFiVWJMbUR2aVFwZVY5OXQyeTJpcDBIZ2xPQStuYmxxQ0xVREVCMG9WRkdC?=
 =?utf-8?B?RWdCR0JJMGJoUEs1T29ZUzQyeTNFV0Nzam9KYUp0M2Q4elVGSU4wTVZlQU5S?=
 =?utf-8?B?WUxUZThlWUJOMitCdHhEaUg5bVgrVmpNZ2xrc3h6L3pGWVMwUmx4czhSenI0?=
 =?utf-8?B?Sis2aFJJSmQ5QWxBTy9wT3JRK1d1RjJsaTQrL2YrZU0wR1ZBUmxmMTNuWmw0?=
 =?utf-8?B?SmxPdjl0c0tpUEZQRFBuQmdaQnE3UGJOcXNTS2V4c1BJOGNoTlpQclF5VVRa?=
 =?utf-8?B?cEFpTjVabWx3RlBoQ21ZeWZkTzl6ekpTRmFtY3Q3V2dsS0M1RWorODBiUDBC?=
 =?utf-8?B?QmpVYkxMelBnOFZXRTlUSEdWa0Z0djFLU2l4YnluOVZkSGlUT01FM2VOL3VP?=
 =?utf-8?B?K2NxZlNaM0V4VFdISkRvNzAyRFVralZLY2FBR1o4NDlOS0VISnZxdlpWOUZF?=
 =?utf-8?B?TG1XVXFoQUgwdGdTZ2pnRjFwRnJVOTdNNlFMdTVYNDJGOEtOaXJWcG5XWTIy?=
 =?utf-8?B?LzVjMUFyb2o0Smx0WEppVDFodUY4R2xFQ3cwSVJSNzgzdm5jemV3RnJJZmlO?=
 =?utf-8?Q?cU/l+UqLJgUfBCYf9auR8oVsthz5YQ+1U+Fbi6IZyrXY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d732dba5-bd94-42d9-b11f-08dd2f9ff1b3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 04:50:15.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8534

RnJvbTogQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+IFNlbnQ6IFR1ZXNkYXks
IEphbnVhcnkgNywgMjAyNSA4OjA3IFBNDQo+IA0KPiBPbiBUdWUsIEphbiAwNywgMjAyNSBhdCAx
MjoyMDo0N1BNIC0wODAwLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3cm90ZToNCj4gPiArVk1CdXMg
ZGV2aWNlcyBhcmUgaWRlbnRpZmllZCBieSBjbGFzcyBhbmQgaW5zdGFuY2UgR1VJRC4gKFNlZSBz
ZWN0aW9uDQo+ID4gKyJWTUJ1cyBkZXZpY2UgY3JlYXRpb24vZGVsZXRpb24iIGluDQo+ID4gK0Rv
Y3VtZW50YXRpb24vdmlydC9oeXBlcnYvdm1idXMucnN0LikgVXBvbiByZXN1bWUgZnJvbSBoaWJl
cm5hdGlvbiwNCj4gPiArdGhlIHJlc3VtZSBmdW5jdGlvbnMgZXhwZWN0IHRoYXQgdGhlIGRldmlj
ZXMgb2ZmZXJlZCBieSBIeXBlci1WIGhhdmUNCj4gPiArdGhlIHNhbWUgY2xhc3MvaW5zdGFuY2Ug
R1VJRHMgYXMgdGhlIGRldmljZXMgcHJlc2VudCBhdCB0aGUgdGltZSBvZg0KPiA+ICtoaWJlcm5h
dGlvbi4gSGF2aW5nIHRoZSBzYW1lIGNsYXNzL2luc3RhbmNlIEdVSURzIGFsbG93cyB0aGUgb2Zm
ZXJlZA0KPiA+ICtkZXZpY2VzIHRvIGJlIG1hdGNoZWQgdG8gdGhlIHByaW1hcnkgVk1CdXMgY2hh
bm5lbCBkYXRhIHN0cnVjdHVyZXMgaW4NCj4gPiArdGhlIG1lbW9yeSBvZiB0aGUgbm93IHJlc3Vt
ZWQgaGliZXJuYXRpb24gaW1hZ2UuIElmIGFueSBkZXZpY2VzIGFyZQ0KPiA+ICtvZmZlcmVkIHRo
YXQgZG9uJ3QgbWF0Y2ggcHJpbWFyeSBWTUJ1cyBjaGFubmVsIGRhdGEgc3RydWN0dXJlcyB0aGF0
DQo+ID4gK2FscmVhZHkgZXhpc3QsIHRoZXkgYXJlIHByb2Nlc3NlZCBub3JtYWxseSBhcyBuZXds
eSBhZGRlZCBkZXZpY2VzLiBJZg0KPiA+ICtwcmltYXJ5IFZNQnVzIGNoYW5uZWxzIHRoYXQgZXhp
c3QgaW4gdGhlIHJlc3VtZWQgaGliZXJuYXRpb24gaW1hZ2UgYXJlDQo+ID4gK25vdCBtYXRjaGVk
IHdpdGggYSBkZXZpY2Ugb2ZmZXJlZCBpbiB0aGUgcmVzdW1lZCBWTSwgdGhlIHJlc3VtZQ0KPiA+
ICtzZXF1ZW5jZSB3YWl0cyBmb3IgMTAgc2Vjb25kcywgdGhlbiBwcm9jZWVkcy4gQnV0IHRoZSB1
bm1hdGNoZWQgZGV2aWNlDQo+ID4gK2lzIGxpa2VseSB0byBjYXVzZSBlcnJvcnMgaW4gdGhlIHJl
c3VtZWQgVk0uDQo+IA0KPiBEaWQgeW91IG1lYW4gZm9yIGV4YW1wbGUsIGNvbmZsaWN0aW5nIHN5
bnRoZXRpYyBOSUNzPw0KDQpJbiB0aGUgcmVzdW1lZCBoaWJlcm5hdGlvbiBpbWFnZSwgdGhlIHVu
bWF0Y2hlZCBkZXZpY2UgaXMgaW4gYSB3ZWlyZA0Kc3RhdGUgd2hlcmUgaXQgaXMgZXhpc3QgYW5k
IGhhcyBhIGRyaXZlciwgYnV0IGlzIG5vIGxvbmdlciAib3BlbiIgaW4gdGhlIFZNQnVzDQpsYXll
ci4gQW55IGF0dGVtcHQgdG8gZG8gSS9PIHRvIHRoZSBkZXZpY2Ugd2lsbCBmYWlsLCBhbmQgaW50
ZXJydXB0cyByZWNlaXZlZA0KZnJvbSB0aGUgZGV2aWNlIGFyZSBpZ25vcmVkLiBQcmVzdW1hYmx5
IHRoZXJlJ3MgdXNlciBzcGFjZSBzb2Z0d2FyZSBvciBhDQpuZXR3b3JrIGNvbm5lY3Rpb24gdGhh
dCBoYXMgdGhlIGRldmljZSBvcGVuIGFuZCBleHBlY3RzIHRvIGJlIGFibGUgdG8NCmludGVyYWN0
IHdpdGggaXQuIFRoYXQgc29mdHdhcmUgd2lsbCBlcnJvciBvdXQgZHVlIHRvIHRoZSBJL08gZmFp
bHVyZS4NCg0KSSBoYXZlbid0IHRob3VnaHQgdGhyb3VnaCBhbGwgdGhlIGltcGxpY2F0aW9ucyBv
ZiBzdWNoIGEgc2NlbmFyaW8sIHNvDQpqdXN0IGxlZnQgdGhlIGRvY3VtZW50YXRpb24gYXMgImxp
a2VseSB0byBjYXVzZSBlcnJvcnMiIHdpdGhvdXQgZ29pbmcNCmludG8gZGV0YWlsLiBJdCdzIGFu
IHVuc3VwcG9ydGVkIHNjZW5hcmlvLCBzbyBub3QgbGlrZWx5IHNvbWV0aGluZyB0aGF0DQp3aWxs
IGJlIGltcHJvdmVkLg0KDQpJIGRvbid0IHRoaW5rIHRoZSBpc3N1ZSBpcyBuZWNlc3NhcmlseSBj
b25mbGljdGluZyBOSUNzLCB0aG91Z2ggaWYgYSBOSUMgd2l0aA0KYSBkaWZmZXJlbnQgaW5zdGFu
Y2UgR1VJRCB3YXMgb2ZmZXJlZCwgaXQgd291bGQgc2hvdyB1cCBhcyBhIG5ldyBOSUMNCmluIHRo
ZSByZXN1bWVkIGltYWdlLCBhbmQgdGhhdCBtaWdodCBjYXVzZSBjb25mbGljdHMvY29uZnVzaW9u
IHdpdGgNCnRoZSAiZGVhZCIgTklDLg0KDQo+IA0KPiA+ICtUaGUgTGludXggZW5kcyBvZiBIeXBl
ci1WIHNvY2tldHMgYXJlIGZvcmNlZCBjbG9zZWQgYXQgdGhlIHRpbWUgb2YNCj4gPiAraGliZXJu
YXRpb24uIFRoZSBndWVzdCBjYW4ndCBmb3JjZSBjbG9zaW5nIHRoZSBob3N0IGVuZCBvZiB0aGUg
c29ja2V0LA0KPiA+ICtidXQgYW55IGhvc3Qtc2lkZSBhY3Rpb25zIG9uIHRoZSBob3N0IGVuZCB3
aWxsIHByb2R1Y2UgYW4gZXJyb3IuDQo+IA0KPiBOb3RoaW5nIGNhbiBiZSBkb25lIG9uIGhvc3Qt
c2lkZT8NCg0KTm90IHJlYWxseS4gIFdoYXRldmVyIGhvc3Qtc2lkZSBzb2Z0d2FyZSB0aGF0IGlz
IHVzaW5nIHRoZSBIeXBlci1WDQpzb2NrZXQgd2lsbCBqdXN0IGdldCBhbiBlcnJvciB0aGF0IG5l
eHQgdGltZSBpdCB0cmllcyB0byBkbyBJL08gb3Zlcg0KdGhlIHNvY2tldC4NCg0KSXMgdGhlcmUg
c29tZXRoaW5nIHlvdSBoYWQgaW4gbWluZCB0aGF0IHRoZSBob3N0IGNvdWxkL3Nob3VsZCBkbz8N
Cg0KPiANCj4gPiArVmlydHVhbCBQQ0kgZGV2aWNlcyBhcmUgcGh5c2ljYWwgUENJIGRldmljZXMg
dGhhdCBhcmUgbWFwcGVkIGRpcmVjdGx5DQo+ID4gK2ludG8gdGhlIFZNJ3MgcGh5c2ljYWwgYWRk
cmVzcyBzcGFjZSBzbyB0aGUgVk0gY2FuIGludGVyYWN0IGRpcmVjdGx5DQo+ID4gK3RoZSBoYXJk
d2FyZS4gdlBDSSBkZXZpY2VzIGluY2x1ZGUgdGhvc2UgYWNjZXNzZWQgdmlhIHdoYXQgSHlwZXIt
Vg0KPiAiLi4uIGludGVyYWN0IGRpcmVjdGx5IHdpdGggdGhlIGhhcmR3YXJlLiINCg0KVGhhbmtz
IGZvciB5b3VyIGNhcmVmdWwgcmVhZGluZy4gIEknbGwgYWRkIHRoZSBtaXNzaW5nICJ3aXRoIi4g
IDotKQ0KDQo+ID4gK2NhbGxzICJEaXNjcmV0ZSBEZXZpY2UgQXNzaWdubWVudCIgKEREQSksIGFz
IHdlbGwgYXMgU1ItSU9WIE5JQw0KPiA+ICtWaXJ0dWFsIEZ1bmN0aW9ucyAoVkYpIGRldmljZXMu
IFNlZSBEb2N1bWVudGF0aW9uL3ZpcnQvaHlwZXJ2L3ZwY2kucnN0Lg0KPiA+ICsNCj4gPiA8c25p
cHBlZD4uLi4NCj4gPiArU1ItSU9WIE5JQyBWRnMgc2ltaWxhcmx5IGhhdmUgYSBWTUJ1cyBpZGVu
dGl0eSBhcyB3ZWxsIGFzIGEgUENJDQo+ID4gK2lkZW50aXR5LCBhbmQgb3ZlcmFsbCBhcmUgcHJv
Y2Vzc2VkIHNpbWlsYXJseSB0byBEREEgZGV2aWNlcy4gQQ0KPiA+ICtkaWZmZXJlbmNlIGlzIHRo
YXQgVkZzIGFyZSBub3Qgb2ZmZXJlZCB0byB0aGUgVk0gZHVyaW5nIGluaXRpYWwgYm9vdA0KPiA+
ICtvZiB0aGUgVk0uIEluc3RlYWQsIHRoZSBWTUJ1cyBzeW50aGV0aWMgTklDIGRyaXZlciBmaXJz
dCBzdGFydHMNCj4gPiArb3BlcmF0aW5nIGFuZCBjb21tdW5pY2F0ZXMgdG8gSHlwZXItViB0aGF0
IGl0IGlzIHByZXBhcmVkIHRvIGFjY2VwdCBhDQo+ID4gK1ZGLCBhbmQgdGhlbiB0aGUgVkYgb2Zm
ZXIgaXMgbWFkZS4gSG93ZXZlciwgaWYgdGhlIFZNQnVzIGNvbm5lY3Rpb24gaXMNCj4gPiArdW5s
b2FkZWQgYW5kIHRoZW4gcmUtZXN0YWJsaXNoZWQgd2l0aG91dCB0aGUgVk0gYmVpbmcgcmVib290
ZWQgKGFzDQo+ID4gK2hhcHBlbnMgaW4gU3RlcHMgMyBhbmQgNSBpbiB0aGUgRGV0YWlsZWQgSGli
ZXJuYXRpb24gU2VxdWVuY2UgYWJvdmUsDQo+ID4gK2FuZCBzaW1pbGFybHkgaW4gdGhlIERldGFp
bGVkIFJlc3VtZSBTZXF1ZW5jZSksIFZGcyBhcmUgYWxyZWFkeSBwYXJ0DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIi4uLiB0aGF0IGFyZSBhbHJl
YWR5IC4uLiINCg0KUmlnaHQuIEknbGwgZml4IHRoaXMgd29yZGluZyBwcm9ibGVtIGFzIHdlbGwu
DQoNCk1pY2hhZWwNCg0KPiA+ICtvZiB0aGUgVk0gYW5kIGFyZSBvZmZlcmVkIHRvIHRoZSByZS1l
c3RhYmxpc2hlZCBWTUJ1cyBjb25uZWN0aW9uDQo+ID4gK3dpdGhvdXQgaW50ZXJ2ZW50aW9uIGJ5
IHRoZSBzeW50aGV0aWMgTklDIGRyaXZlci4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IC0tDQo+IEFu
IG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMgd2FudGVkISAtIENsYXJhDQo=

