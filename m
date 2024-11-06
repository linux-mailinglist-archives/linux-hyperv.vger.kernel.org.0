Return-Path: <linux-hyperv+bounces-3275-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003329BF92A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF861F211D7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00620C47F;
	Wed,  6 Nov 2024 22:20:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625D20C48E
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Nov 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931603; cv=none; b=gzFRaViZsXbcPD75DA/VFfdrjb+AGCUhhn2wwIXMsurELfjp3TWufndt7D8oUWH1sIu8EHYpuNJQIQTuAfKnSfEY+QpeM2eArJYxSgtk9BQLDGMsHZqAZNCYi+7mIDAFuDQIoLnvEtdKSEEY+qOyUgdeSW44Kuf4vOt8TaMsjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931603; c=relaxed/simple;
	bh=K8KsY2smXkK1xQT8hZaHtpx8Err1J8dEOV/nMsM834c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=p9Dkl6ZDeaX+CoH8/RH0rjvXA9/EsUb/mxPggtDecxXbd5A6c2TPCYkPN0KvZ+rgd5OlKKk3G2gH1imBGBpNVQPSZJuOEJCcEUCVi8yG6aeHHSMiQ0fQoKuqmvE5Xkv46rN/OdqCIzjeUDEgCOP+BoRRGWmq4ZQhLZ22KsE7/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-0l6m2jorNFGkVKQs09YrBw-1; Wed, 06 Nov 2024 22:19:56 +0000
X-MC-Unique: 0l6m2jorNFGkVKQs09YrBw-1
X-Mimecast-MFC-AGG-ID: 0l6m2jorNFGkVKQs09YrBw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Nov
 2024 22:19:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Nov 2024 22:19:55 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
Thread-Topic: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
Thread-Index: AQHbKih6Ns02ltD4hEi4XtuoZsqA1LKq32OQ
Date: Wed, 6 Nov 2024 22:19:55 +0000
Message-ID: <6acb24504a454638848dd9adff7cb5dc@AcuMS.aculab.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
 <87wmhq28o6.ffs@tglx>
 <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
 <87ed3y255a.ffs@tglx>
In-Reply-To: <87ed3y255a.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cRWRCtW2zV_7EOlDhBGq5YGtrqPXbBrfHe0Dz_mYOtI_1730931595
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQo+IFNlbnQ6IDI5IE9jdG9iZXIgMjAyNCAxNzoyNQ0KPiAN
Cj4gT24gVHVlLCBPY3QgMjkgMjAyNCBhdCAxNzoyMiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgT2N0IDI5LCAyMDI0IGF0IDU6MDjigK9QTSBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+ID4+IE9uIE1vbiwgT2N0IDI4IDIwMjQgYXQg
MTk6MTEsIEVhc3dhciBIYXJpaGFyYW4gd3JvdGU6DQo+ID4+ID4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvamlmZmllcy5oIGIvaW5jbHVkZS9saW51eC9qaWZmaWVzLmgNCj4gPj4gPiBpbmRl
eCAxMjIwZjBmYmU1YmYuLmU1MjU2YmI1Zjg1MSAxMDA2NDQNCj4gPj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2ppZmZpZXMuaA0KPiA+PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvamlmZmllcy5oDQo+
ID4+ID4gQEAgLTUyNiw2ICs1MjYsOCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVk
IGxvbmcgbXNlY3NfdG9famlmZmllcyhjb25zdCB1bnNpZ25lZCBpbnQgbSkNCj4gPj4gPiAgICAg
ICB9DQo+ID4+ID4gIH0NCj4gPj4gPg0KPiA+PiA+ICsjZGVmaW5lIHNlY3NfdG9famlmZmllcyhf
c2VjcykgKChfc2VjcykgKiBIWikNCj4gPj4NCj4gPj4gQ2FuIHlvdSBwbGVhc2UgbWFrZSB0aGF0
IGEgc3RhdGljIGlubGluZSwgYXMgdGhlcmUgaXMgbm8gbmVlZCBmb3IgbWFjcm8NCj4gPj4gbWFn
aWMgbGlrZSBpbiB0aGUgb3RoZXIgY29udmVyc2lvbnMsIGFuZCBhZGQgYSBrZXJuZWwgZG9jIGNv
bW1lbnQgd2hpY2gNCj4gPj4gZG9jdW1lbnRzIHRoaXM/DQo+ID4NCj4gPiBOb3RlIHRoYXQgYSBz
dGF0aWMgaW5saW5lIG1lYW5zIGl0IGNhbm5vdCBiZSB1c2VkIGluIGUuZy4gc3RydWN0IGluaXRp
YWxpemVycywNCj4gPiB3aGljaCBhcmUgc3Vic3RhbnRpYWwgdXNlcnMgb2YgICI8dmFsdWU+ICog
SFoiLg0KPiANCj4gQmFoLiBUaGF0IHdhbnRzIHRvIGJlIG1lbnRpb25lZCBpbiB0aGUgY2hhbmdl
IGxvZyB0aGVuLg0KPiANCj4gU3RpbGwgdGhlIG1hY3JvIHNob3VsZCBiZSBkb2N1bWVudGVkLg0K
DQpJIHdhcyB3b25kZXJpbmcgaWYgaXQgcmVhbGx5IGhhZCBhbnkgcHVycG9zZSBhdCBhbGwuDQpJ
dCBqdXN0IG9iZnVzY2F0ZXMgY29kZSwgZG9lc24ndCBldmVuIG1ha2UgaXQgc21hbGxlci4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==


