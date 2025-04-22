Return-Path: <linux-hyperv+bounces-5030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFEA962E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67861887912
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935225D8F8;
	Tue, 22 Apr 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HYtok0Rg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2725DB16
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Apr 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311209; cv=none; b=UZuDFYBQ9qONUB7ascV1uATee6CC30rvVBpqB31jxEZ+UVYcGxu7T/ndNZ3R8QfTPKU0R4zYe/M9j8Z+b4mOQMzuWzUinwLmOGhA1ySJkWhjwz2R1zum05GVSe9Mddwb15mqBzn6qku5EdFwVTwY2vaaQoIEadgrzchYG5b5n0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311209; c=relaxed/simple;
	bh=CUMHG1QvxG5BH5figTxBO0Gnu9UORHUCkgf8ecXGmgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2VA1/XMmmU44GlRU7PbxBvN0m+j2ZpugRbrA94Mc1QV3bvjUpacTAc4TrTutrB5lmeNclxKjsmM2OzZXYCxP3n/fj/AJYAMGHAHcSj8G4bXIwNUFozaM8gwebhN7OQH6JVqUmDhaT7rUxcammgn3ME/cyNPhYgURLaEStvKDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HYtok0Rg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acbb85ce788so233444966b.3
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Apr 2025 01:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745311206; x=1745916006; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CUMHG1QvxG5BH5figTxBO0Gnu9UORHUCkgf8ecXGmgI=;
        b=HYtok0RgSEsZt2H9hgN5kdQ8TQhEPVcxySx1xqED/xrexvHgXPG1I+bxXVCIhY7Ob5
         Zsi3voESO8+MLEnxWUpeUFHhuQw/MRXm1EtdLiwCYMDLESY3I0GzRgnIlk25mwh7kbsR
         GxFcoSHvK2FfEn0uBwaa0+HjZJMd7+F+vo+u6qEWbLelSCOee7fzHypfNlIU4ttAQXLo
         q4StC/VNhMNFCkFxcMvXywxQ+Fw6Rw0pu6a/9eEqVwl8p0yxgyUVRJqJInm6YVNq3tpt
         3foq596p62THmNAE5Ff5P8q3JPGfXQnOfr2khT3QRRo6N4XBs1zGUNH0W9D5uBJzoZWU
         pRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311206; x=1745916006;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUMHG1QvxG5BH5figTxBO0Gnu9UORHUCkgf8ecXGmgI=;
        b=hZMICPdsfJewiCj+Jxie1hxkup+Vs1leArUOT1rQ+58J2w//C8hd2oXOKdka7WZpId
         aZ27v1vMNCs3OGiGd6Fwwy+uYYvYYnFnWgvABCwURm1WRwoU75qko8Osg6Z8i6Wu4GpP
         1xVcyf837Pd5r4tpo0FMcTC0m0XPbUuGGKXoxPNZ1mF0VbecSrYJE+yCsWJbSkiW/ava
         OQzR7pUdlkdoyF9yYDGmTMPHvIheAW2m0ja/DrGd/ew8yAo2ShQMjpl2Rssm9H2wv5TO
         7b1fN/p6nN3p7QMt189MIOxK50JURwnqUqIkHBUdR5CBaCvRKwfSkGLK6ecR7P6FpPTA
         +Gzw==
X-Forwarded-Encrypted: i=1; AJvYcCVkZ6rhtK/H6YjU7lgMgrhs61d3BSh1noR4TpJ/gVAavYf7uTe/1Jk5SynrGJBV8g6ZjY6Ct+lXbqmyyqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3PeontpN8Z0E3znIbjQA4zvIw9ujanaZYKneNCxlmSNJ1Trz
	/s0HvSouS6sAJUD1nXFgK5U1RNXqDQLbCjZdJ1r24QaMJbHa88gZl//F7ElMD2c=
X-Gm-Gg: ASbGncs4xPZeiEZucfPr3ZhylQ8Sxg5i7xLApXJPD3xi8T/hg9g7L9h451Le6Uheb4c
	i/mWsDNGu0jBpI9Y3Z79CVkvRFcdekbjuJUdSyz0sjchgt4fDvXyND0o3symDTcLX245dxm5o9F
	hUTAxnzmf/op/898MB8mKzCezIONxUUrKC6g8+BJTdtQY/qq9fB5q3S9Go306jyl3y/v8+LHurQ
	re0TeoB7AIFSv3Y/M0+hsfZOCa7p8/dei87ax4EdOd+Le0ElKNmlCgxRxEtqWgTZTz6eztRdDQb
	PTSgj9e6EhQMdN6EBl7JTdE20lxKkONXVlnSE2WCzVnIZ+Jdol9rdhMJBOTilIyG7nBpGVmd7tE
	WGWNfcfKQWlZWwdnWqIESXIj6mnQEXCy5L4LaCUd1yy1WPineDf/qgwj+4CXAFnJHWA==
X-Google-Smtp-Source: AGHT+IEqRtfMiY1DWfkilqUfgWds2faWrE7hVCyGOEEmvjcgFKPAUYOnV2kf16210MIzcS8WQAu72w==
X-Received: by 2002:a17:907:3e9e:b0:ac6:e327:8de7 with SMTP id a640c23a62f3a-acb74d9b0f2mr1110204866b.42.1745311205533;
        Tue, 22 Apr 2025 01:40:05 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec42af6sm623016066b.43.2025.04.22.01.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:40:05 -0700 (PDT)
Message-ID: <72f5c841-f710-42a6-8236-fdf2a8e4c8dc@suse.com>
Date: Tue, 22 Apr 2025 10:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/34] x86/msr: Return u64 consistently in Xen PMC
 read functions
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
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
 <20250422082216.1954310-6-xin@zytor.com>
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
In-Reply-To: <20250422082216.1954310-6-xin@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WAMohfNsrm1k14t8nB6fK70k"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WAMohfNsrm1k14t8nB6fK70k
Content-Type: multipart/mixed; boundary="------------5GE4asvy3qe50nApI1ewKtAF";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <72f5c841-f710-42a6-8236-fdf2a8e4c8dc@suse.com>
Subject: Re: [RFC PATCH v2 05/34] x86/msr: Return u64 consistently in Xen PMC
 read functions
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-6-xin@zytor.com>
In-Reply-To: <20250422082216.1954310-6-xin@zytor.com>

--------------5GE4asvy3qe50nApI1ewKtAF
Content-Type: multipart/mixed; boundary="------------iKeJnAHhWV9cjLJ7DPQ5kCij"

--------------iKeJnAHhWV9cjLJ7DPQ5kCij
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDQuMjUgMTA6MjEsIFhpbiBMaSAoSW50ZWwpIHdyb3RlOg0KPiBUaGUgcHZfb3Bz
IFBNQyByZWFkIEFQSSBpcyBkZWZpbmVkIGFzOg0KPiAgICAgICAgICB1NjQgKCpyZWFkX3Bt
YykoaW50IGNvdW50ZXIpOw0KPiANCj4gQnV0IFhlbiBQTUMgcmVhZCBmdW5jdGlvbnMgcmV0
dXJuIHVuc2lnbmVkIGxvbmcgbG9uZywgbWFrZSB0aGVtDQo+IHJldHVybiB1NjQgY29uc2lz
dGVudGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGluIExpIChJbnRlbCkgPHhpbkB6eXRv
ci5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQoNCg0KSnVlcmdlbg0K
--------------iKeJnAHhWV9cjLJ7DPQ5kCij
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------iKeJnAHhWV9cjLJ7DPQ5kCij--

--------------5GE4asvy3qe50nApI1ewKtAF--

--------------WAMohfNsrm1k14t8nB6fK70k
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgHVeMFAwAAAAAACgkQsN6d1ii/Ey/j
jwf9FjFuU15+W0uDc4zGUao0fzYML/q56lEOOYrN4qdKg7Yz+aaWPgbfFayS8jYd5vCuKMJIvKNt
O86pjk2/3l+taVz9alop2FXdFTDucTrCjVyr9kiHeU7o93sniRH7ELuty0Z3bGDSnUdwVxENGs3H
np8FT9FW6QshiK+IGY/HOHuL102pAHR5W262cqwH+XOb1TmJGIgPOa2Q9OgT7FL3/DP96w09wOAZ
N7lzNJ+tfdaNiWco0hLCRohvUIu3CTO825cLYVvzS2iXQ4HKqCzHhBbmODUVDzLXJAQt2dIW00gZ
oehEL6ci5yZLt30VHIeYyHucROrYtXypolEX9nTPFw==
=COw5
-----END PGP SIGNATURE-----

--------------WAMohfNsrm1k14t8nB6fK70k--

