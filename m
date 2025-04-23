Return-Path: <linux-hyperv+bounces-5065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92AA994AD
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A003D178C77
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1C25F7AD;
	Wed, 23 Apr 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foHx8vG8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744119DFA7
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Apr 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424676; cv=none; b=r3oZVaQEy0M68Oj2xdPkzp+7XrfUipiYuLyDC4MwIxWS3hLWV2WfzPN2bE+QKYcKFyUp76+izL8Js7MzLLg5Hk3n0HwBDsbae/g/iZ59QjHyhkLs0O8Q/DJA/ElUZltawqVxhtbqoKcV40J+XQqNdeplw3EhR+qytcVOpaxFVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424676; c=relaxed/simple;
	bh=r6M9Ja1D8Zs6b5j1y3MnNQBue4KN5PdtElPgqLbvxSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijaIamod3D+CnXropohA4ClQQF6OK9cGIfZSMOAoF68J2ava9D1+WJ6o3vQXxcmKOMrtt4B1AdPbv3cNgagGL85Wg776ge1wob9UazwlsvQdTS3WumypTy+Yzxeo6Fa/MBd6faeDIcNssQIefNdDlUJsG6jNBOHbKZ6lTIIj0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foHx8vG8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb615228a4so198910066b.0
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Apr 2025 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745424672; x=1746029472; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6M9Ja1D8Zs6b5j1y3MnNQBue4KN5PdtElPgqLbvxSg=;
        b=foHx8vG8PQfH0jKC0Ufn87MRkGXSXtLPt9ndfFmB/CBj5NXqlBrmsHPuoq0ZbYDYEi
         qDtgDo2r4St6mitw5+zUq18bHaCf5P9nV2AjWm6alFhzbXtfHqDNm1pSSb6QBbD7k42l
         khrRlcGn8tce6EP2TLEJRoRNkByxfm5GEo047t07clh+vb9phjPcvki9oUkIj4QaaZfp
         MCkB8iSRHc8UyJc59a5zuSGQE9gYQF4TO6Q961KwvFzyEuKv5VjViagfN2YGCv7N+6Nb
         XqTzFTpoR4UGDAU8by/odEGmUmuU6nwaXKXLfGMnQ8GeIDChcNre9TXc/bvzv/VnFeMd
         iYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745424672; x=1746029472;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6M9Ja1D8Zs6b5j1y3MnNQBue4KN5PdtElPgqLbvxSg=;
        b=VThOdHJDvz6B1nyMx3Vy2V1IhePCOG0rihk22w2ltQ1+KM41LPCqfKA3afcWdH3kXg
         tq0apPoPiYPOqLVhqwOwHFKOWuEvYLZe3OCujHfEJ4Qvs/9YavFnJWu0Vn+UXGfFPBgT
         lmGdNJ64liUbsKW36m+/MmpLnvp+C+6J/5owFQSzLlLzgTP2xksokoyJS8sMRbLfZGO/
         86ebEy0YTa6jO1Pw9Az+u7BKfiH+E0/4Y5OpBDNtc1bWRpV/mKdiAP5TVI6xlxZfxLim
         6ULBKwqzxdl7iL4o44v2g8EL87xuNswIGZ3HMJg/4LrMUko+/6FIU6fz35kGKvWCPTkd
         hD1g==
X-Forwarded-Encrypted: i=1; AJvYcCUj4v1mSUxJ39JBfVMSMWUmwfgfvwOMin0so5nEUb60I+610ZzwRKWUuThrLypmhg7MS5+aigbL8KjgzeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvT6QctQxKE6SarEO0/r6MMeGFy2e61rhdki7SStyTtm6q6ssc
	tSMCP8doCz1Em1ukUXJJxCmm1+3YLsWCO9BDz+IMG1xYcMHApzzF+mbQ9J8K/bY=
X-Gm-Gg: ASbGncsOlUFBP1vBn1sVcJXMjPMycq7y9vlnooLUstwmr4go5Sm45oFPOIXkiqxBgtk
	54IbndVPAmJOU7Yw3014gZy+l1qOUgOb6M6WmgtthSN0BH6e+QS+hsxWrEL+VK6YsU+yJXMybBx
	YhjzXNFlVi9iF0iJ+eDN0oSVXQxNUM897fsUEnae75kbFSyn2P9iU5V9OOUFPFej9hFKqYlvQod
	2zgF88ctsXagIbMtJ7x2RBndW9eTk++frqgv3ZQe6lxYVIjA9wL0VZN4WqIn0V5qz+lL4JXyICa
	q0NmrZMN7Gjd8/wYLAHKhtkf0zsMXGJ4PeYDDFABbX85ow9FuZqMPfcStKKBMI7SJFI0WKBCkC/
	EZncsBqMz/t/sV52Ce14baTmYO4m/BkiCbM5nJsIC7PyNP4uZbtSrbw2R+sYHmaiutw==
X-Google-Smtp-Source: AGHT+IGCpPmCGC7IHEh0MIOg0AX5sgy1qpm3zmVV6d+GogUn6nD6VtfuVEh/CSiuiB3OjgZ0F+tEng==
X-Received: by 2002:a17:907:728e:b0:ac7:3441:79aa with SMTP id a640c23a62f3a-ace3f4c1d0dmr289156466b.13.1745424672252;
        Wed, 23 Apr 2025 09:11:12 -0700 (PDT)
Received: from ?IPV6:2003:e5:870f:e000:6c64:75fd:2c51:3fef? (p200300e5870fe0006c6475fd2c513fef.dip0.t-ipconnect.de. [2003:e5:870f:e000:6c64:75fd:2c51:3fef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec04668sm821934866b.24.2025.04.23.09.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 09:11:11 -0700 (PDT)
Message-ID: <281505d5-7459-4903-887e-dc78a4c1fce4@suse.com>
Date: Wed, 23 Apr 2025 18:11:10 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 22/34] x86/msr: Utilize the alternatives mechanism
 to read MSR
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org,
 andrew.cooper3@citrix.com, peterz@infradead.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-23-xin@zytor.com>
 <080351cb-6c3d-4540-953d-6205f1ff0745@suse.com>
 <7899fcd9-3492-49d3-8097-a3ddefaaeef0@zytor.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <7899fcd9-3492-49d3-8097-a3ddefaaeef0@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FE970QYjLz2b50Iy5t5x4Ioe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FE970QYjLz2b50Iy5t5x4Ioe
Content-Type: multipart/mixed; boundary="------------mQHAHZCn0fpZPeY8nLddn93h";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org,
 andrew.cooper3@citrix.com, peterz@infradead.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 wei.liu@kernel.org, ajay.kaher@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
 pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
 luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com
Message-ID: <281505d5-7459-4903-887e-dc78a4c1fce4@suse.com>
Subject: Re: [RFC PATCH v2 22/34] x86/msr: Utilize the alternatives mechanism
 to read MSR
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-23-xin@zytor.com>
 <080351cb-6c3d-4540-953d-6205f1ff0745@suse.com>
 <7899fcd9-3492-49d3-8097-a3ddefaaeef0@zytor.com>
In-Reply-To: <7899fcd9-3492-49d3-8097-a3ddefaaeef0@zytor.com>

--------------mQHAHZCn0fpZPeY8nLddn93h
Content-Type: multipart/mixed; boundary="------------hwRd1olu00ORJ06CZhGAHDwc"

--------------hwRd1olu00ORJ06CZhGAHDwc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDQuMjUgMTE6MDMsIFhpbiBMaSB3cm90ZToNCj4gT24gNC8yMi8yMDI1IDQ6MTIg
QU0sIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+Pj4gKw0KPj4+ICtzdGF0aWMgX19hbHdheXNf
aW5saW5lIGJvb2wgX19yZG1zcnEodTMyIG1zciwgdTY0ICp2YWwsIGludCB0eXBlKQ0KPj4+
ICt7DQo+Pj4gK8KgwqDCoCBib29sIHJldDsNCj4+PiArDQo+Pj4gKyNpZmRlZiBDT05GSUdf
WEVOX1BWDQo+Pj4gK8KgwqDCoCBpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVS
RV9YRU5QVikpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBfX3hlbnB2X3JkbXNycSht
c3IsIHZhbCwgdHlwZSk7DQo+Pg0KPj4gSSBkb24ndCB0aGluayB0aGlzIHdpbGwgd29yayBm
b3IgdGhlIFhlbiBQViBjYXNlLg0KPiANCj4gV2VsbCwgSSBoYXZlIGJlZW4gdGVzdGluZyB0
aGUgY29kZSBvbiB4ZW4tNC4xNyBjb21pbmcgd2l0aCBVYnVudHUNCj4gMjQuMDQuMiBMVFMg
OikNCg0KSG1tLCBzZWVtcyB0aGF0IHRoZSBhY2Nlc3NlZCBNU1IocykgYXJlIHRoZSBvbmVz
IGZhbGxpbmcgYmFjayB0byB0aGUNCm5hdGl2ZV9yZG1zcigpIGNhbGxzLiBBdCBsZWFzdCBv
biB0aGUgaGFyZHdhcmUgeW91IHRlc3RlZCBvbi4NCg0KPj4gWDg2X0ZFQVRVUkVfWEVOUFYg
aXMgc2V0IG9ubHkgYWZ0ZXIgdGhlIGZpcnN0IE1TUiBpcyBiZWluZyByZWFkLg0KPiANCj4g
Tm8gbWF0dGVyIHdoZXRoZXIgdGhlIGNvZGUgd29ya3Mgb3Igbm90LCBnb29kIGNhdGNoIQ0K
PiANCj4+DQo+PiBUaGlzIGNhbiBiZSBmaXhlZCBieSBzZXR0aW5nIHRoZSBmZWF0dXJlIGVh
cmxpZXIsIGJ1dCBpdCBzaG93cyB0aGF0IHRoZQ0KPj4gcGFyYXZpcnQgZmVhdHVyZSBoYXMg
aXRzIGJlbmVmaXRzIGluIHN1Y2ggY2FzZXMuDQo+IA0KPiBTZWUgbXkgb3RoZXIgcmVwbHkg
dG8gbGV0IFhlbiBoYW5kbGUgYWxsIHRoZSBkZXRhaWxzLg0KPiANCj4gUGx1cyB0aGUgY29k
ZSBhY3R1YWxseSB3b3JrcywgSSB3b3VsZCBhY3R1YWxseSBhcmd1ZSB0aGUgb3Bwb3NpdGUg
Oi1QDQoNCkJUVywgaXQgd2FzIGluIGtlcm5lbCA2LjEyIEkgaGFkIHRvIGNoYW5nZSB0aGUg
TVNSIHJlYWQgZW11bGF0aW9uIGZvcg0KWGVuLVBWIHRoZSBsYXN0IHRpbWUgKGZpeCBzb21l
IHByb2JsZW1zIHdpdGggY2hhbmdlZCB4ODYgdG9wb2xvZ3kNCmRldGVjdGlvbikuIFRoaW5n
cyBsaWtlIHRoYXQgd29uJ3QgYmUgZWFzaWx5IHB1dCBpbnRvIHRoZSBoeXBlcnZpc29yLA0K
d2hpY2ggbmVlZHMgdG8gc2VydmUgb3RoZXIgT1MtZXMsIHRvby4NCg0KDQpKdWVyZ2VuDQo=

--------------hwRd1olu00ORJ06CZhGAHDwc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------hwRd1olu00ORJ06CZhGAHDwc--

--------------mQHAHZCn0fpZPeY8nLddn93h--

--------------FE970QYjLz2b50Iy5t5x4Ioe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgJER4FAwAAAAAACgkQsN6d1ii/Ey9B
OAgAgUnmx2ytj5fx0ZWLVVSeVgbrAkAAJwflobLTfsKbhnmAKSXlnLeLRLVkxNnEl2JtohZ6+oZD
YIxawfxiIGTbwbemJOWdlKj6zJJE2cKl39wCE83gJZM/VGYiBo+Q0dTWWOWGfUJD04EkOMAAiJ96
iI2xfjOnxm1YBb5TqBqC/CvC2mbHOg543h8N5NoVx39tEeSepbZH6UirBZ3B50y3/Zgp50DK2R3O
6YLl6jBayBEHkZkqK59qYmjBrj6OriVMZpo5QCK+NLuv2mdv3O7hI1nKbmUmS94/7UcuHFtan862
npbfPTBwkAXV5WDYJ7uyIdkMVl3F9PhN2zVI4a4VUQ==
=Dl6w
-----END PGP SIGNATURE-----

--------------FE970QYjLz2b50Iy5t5x4Ioe--

