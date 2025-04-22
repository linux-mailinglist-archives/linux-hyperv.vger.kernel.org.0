Return-Path: <linux-hyperv+bounces-5029-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A0A962AA
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246C73B5F72
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C592836A5;
	Tue, 22 Apr 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c4MxNRji"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946E2405F8
	for <linux-hyperv@vger.kernel.org>; Tue, 22 Apr 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311145; cv=none; b=Lj5m034DrD7aHIaFTfQGALq0fSTANEZMXGg1h3Dy3hoNLZzOfk2rg1zeS/Ib1lxCQS/ic3igGKYIKk3oKqDO8sJl4B2aMhd9PiUG8m6SnhFtU0GuuGnxUVzpjYQG9JUF8bcZ/7LbbAXM3JtRm1adKFvPdKv+l82qoznCIFNyCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311145; c=relaxed/simple;
	bh=0ax55UGcTWOWHuVz+3BJ6ZXy/45nBJzHHncbaK4NkZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H02SpUyEhO9QvSdz1rhg5KdPIUlIZf/omJzBTF8A/FznNfL1K5rdrvOCGxIlu5qk2J7+rItiBpTnMbKHE/iLhTQl6gLbwHLXeq1HDNr5Tcav2pWa0Tip5ytk7C6dSAaJpwsHLmFC18j5qMj+O+Zh34JllXY5CP3JrcLOJJuHIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c4MxNRji; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so681395066b.0
        for <linux-hyperv@vger.kernel.org>; Tue, 22 Apr 2025 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745311140; x=1745915940; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ax55UGcTWOWHuVz+3BJ6ZXy/45nBJzHHncbaK4NkZI=;
        b=c4MxNRjiXa1lLom5IZOmVtO2qQz0NRhjYiT2lOYcxliKrmTp7qjsd1rvizfDvDr9lz
         eRvz547GuWcxVslwjkKpBDK9b7uKe/ScruNcH3QZDl4bOAlrJWwGZQHfoMuxGKYWe+Vm
         vGDDB61812lDxT7OBmp5hiVghTNc1bwto5TKrVbwTcNtyWFl2gxyscfOO0bG1fMs5V3Z
         2XA9t1GgeNu044BWO8g6Lp/8TcUmBdiLGrAPinIZu020iSKpdJYBbV7MXlXdVHmuOrp8
         JFkx/hlLNbsKGs3cS9klaHRP64yxn05h5N2WTceA6aYFGkV+7kXY1a5QTtqcdvr/vpvH
         +LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311140; x=1745915940;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ax55UGcTWOWHuVz+3BJ6ZXy/45nBJzHHncbaK4NkZI=;
        b=J4cW7joKnKWe+dnGpgfDYp8AOUYnQiim/4Qm38flmO9PZaRfzTPLFcHV1wE96vlXF7
         yckRe1bWtBQLxJsXYCyOUhhZgFi6D6z0cwIF465VP2nrh+3s+D9QRCHk37bPozhJyips
         47FUhmMCJ8eQ3nUp6Ry11GKhCoJpAiRJTvRxdKHKbrxZfN+LQcK6h7za8vn4YGzAPfK7
         sdzDa1doM7OGr5jH/4kEnQitssOumMNyhUGVXBTOjGG5UowwCDeNuiZojd5P9vTd5EtT
         6VaicFyP+pauRCwkgzQoHvzkuW/N2NFtf2Mem0ZkSLsSy48U2H7F8SJIsj7hwFSnf7Yj
         lhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDc80rDH30+LsKrwwT3NjrkvOzS/fDnotxmCgZSvWl2zGUVELSnxmRw0mFDW9b5OhR6Vmoxssf3avYxFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsEFXRaq67/v98OHZrvAFo+3t4VQAWGMsJ7WbKGLgT95U79Q/
	DlC9+qpkXvJ9+BTk329X4FZro5paSQ1cxLzk1cDOd4Je3h/NdA5/4V5iR15kC4g=
X-Gm-Gg: ASbGncstfitKjjBS44IPH1SUbQXZmbRZsXzwIC0P0/yP336eoJ1R0H2Kg/Ld4GM/j1V
	TmUxzu+v3gS15QWTvJ8bcLl9yK0c3kZPPvsZ4tUhX+KuD47GNp3RmsEkTGecVB8NRmIIQopSBfP
	G9AC2W16YyeEw1blCH/QaXKT4BmV93bNb3Gie+DJYrNNZ2sWooEqRS8yYp+3rls1JaM9zG90FnB
	aTOP4tL5+Bzu97BDia9sJyjHdQlfV8HediZe8V3wpgZ3dCuTATKHP2+/lkjLh6r6vHt+j/Y5U8J
	Jr9QzaEi3zJq+i9ipC7l3V//2zJv/ytptRhml4JcfM857ufmtMPEhn261k4c0p4elQPVveIQBYs
	t7He5eU94lxYCkDRR4QiV5zeqyXMEDHmLx0uhXy9lIgJRw7zGDZudgavyQGjjGVPJmE+UlZ4Blg
	cA
X-Google-Smtp-Source: AGHT+IEmp/5XJLTqP5S0pRZ5YtwXiVrJr7qIcIrg0GxrIdRMvNGGFjSJJZr5xRVxQvA2fct+zsz19A==
X-Received: by 2002:a17:907:1c14:b0:aca:95e7:9977 with SMTP id a640c23a62f3a-acb74b508b5mr1316747266b.28.1745311139866;
        Tue, 22 Apr 2025 01:38:59 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b? (p200300e5873d1a008e99ce06aa4a2e7b.dip0.t-ipconnect.de. [2003:e5:873d:1a00:8e99:ce06:aa4a:2e7b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefd8besm623509666b.122.2025.04.22.01.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:38:59 -0700 (PDT)
Message-ID: <fbb509e8-0bd6-480f-be32-fd0895255a21@suse.com>
Date: Tue, 22 Apr 2025 10:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/34] x86/msr: Use the alternatives mechanism to
 read PMC
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
 <20250422082216.1954310-7-xin@zytor.com>
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
In-Reply-To: <20250422082216.1954310-7-xin@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oWGr0D8fp74ylaTm4CQbbsBV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oWGr0D8fp74ylaTm4CQbbsBV
Content-Type: multipart/mixed; boundary="------------qqqJQkp59jKjmbEZC1Vwrfie";
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
Message-ID: <fbb509e8-0bd6-480f-be32-fd0895255a21@suse.com>
Subject: Re: [RFC PATCH v2 06/34] x86/msr: Use the alternatives mechanism to
 read PMC
References: <20250422082216.1954310-1-xin@zytor.com>
 <20250422082216.1954310-7-xin@zytor.com>
In-Reply-To: <20250422082216.1954310-7-xin@zytor.com>

--------------qqqJQkp59jKjmbEZC1Vwrfie
Content-Type: multipart/mixed; boundary="------------xefsIXpq0wxo0BM9i717snKf"

--------------xefsIXpq0wxo0BM9i717snKf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDQuMjUgMTA6MjEsIFhpbiBMaSAoSW50ZWwpIHdyb3RlOg0KPiBUbyBlbGltaW5h
dGUgdGhlIGluZGlyZWN0IGNhbGwgb3ZlcmhlYWQgaW50cm9kdWNlZCBieSB0aGUgcHZfb3Bz
IEFQSSwNCj4gdXNlIHRoZSBhbHRlcm5hdGl2ZXMgbWVjaGFuaXNtIHRvIHJlYWQgUE1DOg0K
DQpXaGljaCBpbmRpcmVjdCBjYWxsIG92ZXJoZWFkPyBUaGUgaW5kaXJlY3QgY2FsbCBpcyBw
YXRjaGVkIHZpYSB0aGUNCmFsdGVybmF0aXZlIG1lY2hhbmlzbSB0byBhIGRpcmVjdCBvbmUu
DQoNCj4gDQo+ICAgICAgMSkgV2hlbiBidWlsdCB3aXRoICFDT05GSUdfWEVOX1BWLCBYODZf
RkVBVFVSRV9YRU5QViBiZWNvbWVzIGENCj4gICAgICAgICBkaXNhYmxlZCBmZWF0dXJlLCBw
cmV2ZW50aW5nIHRoZSBYZW4gUE1DIHJlYWQgY29kZSBmcm9tIGJlaW5nDQo+ICAgICAgICAg
YnVpbHQgYW5kIGVuc3VyaW5nIHRoZSBuYXRpdmUgY29kZSBpcyBleGVjdXRlZCB1bmNvbmRp
dGlvbmFsbHkuDQoNCldpdGhvdXQgQ09ORklHX1hFTl9QViBDT05GSUdfUEFSQVZJUlRfWFhM
IGlzIG5vdCBzZWxlY3RlZCwgcmVzdWx0aW5nIGluDQpuYXRpdmUgY29kZSBhbnl3YXkuDQoN
Cj4gDQo+ICAgICAgMikgV2hlbiBidWlsdCB3aXRoIENPTkZJR19YRU5fUFY6DQo+IA0KPiAg
ICAgICAgIDIuMSkgSWYgbm90IHJ1bm5pbmcgb24gdGhlIFhlbiBoeXBlcnZpc29yICghWDg2
X0ZFQVRVUkVfWEVOUFYpLA0KPiAgICAgICAgICAgICAgdGhlIGtlcm5lbCBydW50aW1lIGJp
bmFyeSBpcyBwYXRjaGVkIHRvIHVuY29uZGl0aW9uYWxseQ0KPiAgICAgICAgICAgICAganVt
cCB0byB0aGUgbmF0aXZlIFBNQyByZWFkIGNvZGUuDQo+IA0KPiAgICAgICAgIDIuMikgSWYg
cnVubmluZyBvbiB0aGUgWGVuIGh5cGVydmlzb3IgKFg4Nl9GRUFUVVJFX1hFTlBWKSwgdGhl
DQo+ICAgICAgICAgICAgICBrZXJuZWwgcnVudGltZSBiaW5hcnkgaXMgcGF0Y2hlZCB0byB1
bmNvbmRpdGlvbmFsbHkganVtcA0KPiAgICAgICAgICAgICAgdG8gdGhlIFhlbiBQTUMgcmVh
ZCBjb2RlLg0KPiANCj4gQ29uc2VxdWVudGx5LCByZW1vdmUgdGhlIHB2X29wcyBQTUMgcmVh
ZCBBUEkuDQoNCkkgZG9uJ3Qgc2VlIHRoZSB2YWx1ZSBvZiB0aGlzIHBhdGNoLg0KDQpJdCBh
ZGRzIG1vcmUgI2lmZGVmIGFuZCBjb2RlIGxpbmVzIHdpdGhvdXQgYW55IHJlYWwgZ2Fpbi4N
Cg0KSW4gY2FzZSB0aGUgeDg2IG1haW50YWluZXJzIHRoaW5rIGl0IGlzIHN0aWxsIHdvcnRo
IGl0LCBJIHdvbid0IG9iamVjdC4NCg0KDQpKdWVyZ2VuDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFhpbiBMaSAoSW50ZWwpIDx4aW5Aenl0b3IuY29tPg0KPiAtLS0NCj4gICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tc3IuaCAgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCAgICAgICB8
ICA1IC0tLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaCB8
ICAyIC0tDQo+ICAgYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMgICAgICAgICAgICB8ICAx
IC0NCj4gICBhcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMgICAgICAgICAgIHwgIDIgLS0N
Cj4gICBkcml2ZXJzL25ldC92bXhuZXQzL3ZteG5ldDNfZHJ2LmMgICAgIHwgIDIgKy0NCj4g
ICA2IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4gaW5kZXggMDFkYzhlNjFlZjk3Li4zM2NmNTA2ZTJm
ZDYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oDQo+ICsrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oDQo+IEBAIC04LDYgKzgsNyBAQA0KPiAgIA0K
PiAgICNpbmNsdWRlIDxhc20vYXNtLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9lcnJuby5oPg0K
PiArI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9jcHVt
YXNrLmg+DQo+ICAgI2luY2x1ZGUgPHVhcGkvYXNtL21zci5oPg0KPiAgICNpbmNsdWRlIDxh
c20vc2hhcmVkL21zci5oPg0KPiBAQCAtNzMsNiArNzQsMTAgQEAgc3RhdGljIGlubGluZSB2
b2lkIGRvX3RyYWNlX3JlYWRfbXNyKHUzMiBtc3IsIHU2NCB2YWwsIGludCBmYWlsZWQpIHt9
DQo+ICAgc3RhdGljIGlubGluZSB2b2lkIGRvX3RyYWNlX3JkcG1jKHUzMiBtc3IsIHU2NCB2
YWwsIGludCBmYWlsZWQpIHt9DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsjaWZkZWYgQ09ORklH
X1hFTl9QVg0KPiArZXh0ZXJuIHU2NCB4ZW5fcmVhZF9wbWMoaW50IGNvdW50ZXIpOw0KPiAr
I2VuZGlmDQo+ICsNCj4gICAvKg0KPiAgICAqIF9fcmRtc3IoKSBhbmQgX193cm1zcigpIGFy
ZSB0aGUgdHdvIHByaW1pdGl2ZXMgd2hpY2ggYXJlIHRoZSBiYXJlIG1pbmltdW0gTVNSDQo+
ICAgICogYWNjZXNzb3JzIGFuZCBzaG91bGQgbm90IGhhdmUgYW55IHRyYWNpbmcgb3Igb3Ro
ZXIgZnVuY3Rpb25hbGl0eSBwaWdneWJhY2tpbmcNCj4gQEAgLTE3MCwxNiArMTc1LDMyIEBA
IG5hdGl2ZV93cml0ZV9tc3Jfc2FmZSh1MzIgbXNyLCB1MzIgbG93LCB1MzIgaGlnaCkNCj4g
ICBleHRlcm4gaW50IHJkbXNyX3NhZmVfcmVncyh1MzIgcmVnc1s4XSk7DQo+ICAgZXh0ZXJu
IGludCB3cm1zcl9zYWZlX3JlZ3ModTMyIHJlZ3NbOF0pOw0KPiAgIA0KPiAtc3RhdGljIGlu
bGluZSB1NjQgbmF0aXZlX3JlYWRfcG1jKGludCBjb3VudGVyKQ0KPiArc3RhdGljIF9fYWx3
YXlzX2lubGluZSB1NjQgbmF0aXZlX3JkcG1jcShpbnQgY291bnRlcikNCj4gICB7DQo+ICAg
CURFQ0xBUkVfQVJHUyh2YWwsIGxvdywgaGlnaCk7DQo+ICAgDQo+IC0JYXNtIHZvbGF0aWxl
KCJyZHBtYyIgOiBFQVhfRURYX1JFVCh2YWwsIGxvdywgaGlnaCkgOiAiYyIgKGNvdW50ZXIp
KTsNCj4gKwlhc21faW5saW5lIHZvbGF0aWxlKCJyZHBtYyIgOiBFQVhfRURYX1JFVCh2YWws
IGxvdywgaGlnaCkgOiAiYyIgKGNvdW50ZXIpKTsNCj4gKw0KPiAgIAlpZiAodHJhY2Vwb2lu
dF9lbmFibGVkKHJkcG1jKSkNCj4gICAJCWRvX3RyYWNlX3JkcG1jKGNvdW50ZXIsIEVBWF9F
RFhfVkFMKHZhbCwgbG93LCBoaWdoKSwgMCk7DQo+ICsNCj4gICAJcmV0dXJuIEVBWF9FRFhf
VkFMKHZhbCwgbG93LCBoaWdoKTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgX19hbHdheXNf
aW5saW5lIHU2NCByZHBtY3EoaW50IGNvdW50ZXIpDQo+ICt7DQo+ICsjaWZkZWYgQ09ORklH
X1hFTl9QVg0KPiArCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBW
KSkNCj4gKwkJcmV0dXJuIHhlbl9yZWFkX3BtYyhjb3VudGVyKTsNCj4gKyNlbmRpZg0KPiAr
DQo+ICsJLyoNCj4gKwkgKiAxKSBXaGVuIGJ1aWx0IHdpdGggIUNPTkZJR19YRU5fUFYuDQo+
ICsJICogMikgV2hlbiBidWlsdCB3aXRoIENPTkZJR19YRU5fUFYgYnV0IG5vdCBydW5uaW5n
IG9uIFhlbiBoeXBlcnZpc29yLg0KPiArCSAqLw0KPiArCXJldHVybiBuYXRpdmVfcmRwbWNx
KGNvdW50ZXIpOw0KPiArfQ0KPiArDQo+ICAgI2lmZGVmIENPTkZJR19QQVJBVklSVF9YWEwN
Cj4gICAjaW5jbHVkZSA8YXNtL3BhcmF2aXJ0Lmg+DQo+ICAgI2Vsc2UNCj4gQEAgLTIzMywx
MiArMjU0LDYgQEAgc3RhdGljIGlubGluZSBpbnQgcmRtc3JxX3NhZmUodTMyIG1zciwgdTY0
ICpwKQ0KPiAgIAkqcCA9IG5hdGl2ZV9yZWFkX21zcl9zYWZlKG1zciwgJmVycik7DQo+ICAg
CXJldHVybiBlcnI7DQo+ICAgfQ0KPiAtDQo+IC1zdGF0aWMgX19hbHdheXNfaW5saW5lIHU2
NCByZHBtY3EoaW50IGNvdW50ZXIpDQo+IC17DQo+IC0JcmV0dXJuIG5hdGl2ZV9yZWFkX3Bt
Yyhjb3VudGVyKTsNCj4gLX0NCj4gLQ0KPiAgICNlbmRpZgkvKiAhQ09ORklHX1BBUkFWSVJU
X1hYTCAqLw0KPiAgIA0KPiAgIC8qIEluc3RydWN0aW9uIG9wY29kZSBmb3IgV1JNU1JOUyBz
dXBwb3J0ZWQgaW4gYmludXRpbHMgPj0gMi40MCAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2
aXJ0LmgNCj4gaW5kZXggNTkwODI0OTE2Mzk0Li5jNzY4OWY1ZjcwZDYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgNCj4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vcGFyYXZpcnQuaA0KPiBAQCAtMjM5LDExICsyMzksNiBAQCBzdGF0aWMg
aW5saW5lIGludCByZG1zcnFfc2FmZSh1bnNpZ25lZCBtc3IsIHU2NCAqcCkNCj4gICAJcmV0
dXJuIGVycjsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCBy
ZHBtY3EoaW50IGNvdW50ZXIpDQo+IC17DQo+IC0JcmV0dXJuIFBWT1BfQ0FMTDEodTY0LCBj
cHUucmVhZF9wbWMsIGNvdW50ZXIpOw0KPiAtfQ0KPiAtDQo+ICAgc3RhdGljIGlubGluZSB2
b2lkIHBhcmF2aXJ0X2FsbG9jX2xkdChzdHJ1Y3QgZGVzY19zdHJ1Y3QgKmxkdCwgdW5zaWdu
ZWQgZW50cmllcykNCj4gICB7DQo+ICAgCVBWT1BfVkNBTEwyKGNwdS5hbGxvY19sZHQsIGxk
dCwgZW50cmllcyk7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJh
dmlydF90eXBlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaA0K
PiBpbmRleCA2MzFjMzA2Y2UxZmYuLjQ3NWY1MDg1MzFkNiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlwZXMuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oDQo+IEBAIC0xMDEsOCArMTAxLDYgQEAgc3Ry
dWN0IHB2X2NwdV9vcHMgew0KPiAgIAl1NjQgKCpyZWFkX21zcl9zYWZlKSh1bnNpZ25lZCBp
bnQgbXNyLCBpbnQgKmVycik7DQo+ICAgCWludCAoKndyaXRlX21zcl9zYWZlKSh1bnNpZ25l
ZCBpbnQgbXNyLCB1bnNpZ25lZCBsb3csIHVuc2lnbmVkIGhpZ2gpOw0KPiAgIA0KPiAtCXU2
NCAoKnJlYWRfcG1jKShpbnQgY291bnRlcik7DQo+IC0NCj4gICAJdm9pZCAoKnN0YXJ0X2Nv
bnRleHRfc3dpdGNoKShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnByZXYpOw0KPiAgIAl2b2lkICgq
ZW5kX2NvbnRleHRfc3dpdGNoKShzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5leHQpOw0KPiAgICNl
bmRpZg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvcGFyYXZpcnQuYw0KPiBpbmRleCAxY2NkMDVkODk5OWYuLjI4ZDE5NWFk
NzUxNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMNCj4gQEAgLTEzMiw3ICsxMzIsNiBAQCBz
dHJ1Y3QgcGFyYXZpcnRfcGF0Y2hfdGVtcGxhdGUgcHZfb3BzID0gew0KPiAgIAkuY3B1Lndy
aXRlX21zcgkJPSBuYXRpdmVfd3JpdGVfbXNyLA0KPiAgIAkuY3B1LnJlYWRfbXNyX3NhZmUJ
PSBuYXRpdmVfcmVhZF9tc3Jfc2FmZSwNCj4gICAJLmNwdS53cml0ZV9tc3Jfc2FmZQk9IG5h
dGl2ZV93cml0ZV9tc3Jfc2FmZSwNCj4gLQkuY3B1LnJlYWRfcG1jCQk9IG5hdGl2ZV9yZWFk
X3BtYywNCj4gICAJLmNwdS5sb2FkX3RyX2Rlc2MJPSBuYXRpdmVfbG9hZF90cl9kZXNjLA0K
PiAgIAkuY3B1LnNldF9sZHQJCT0gbmF0aXZlX3NldF9sZHQsDQo+ICAgCS5jcHUubG9hZF9n
ZHQJCT0gbmF0aXZlX2xvYWRfZ2R0LA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9wdi5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+IGluZGV4IDg0
NmI1NzM3ZDMyMC4uOWZiZTE4N2FmZjAwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni94ZW4v
ZW5saWdodGVuX3B2LmMNCj4gKysrIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+
IEBAIC0xMjM2LDggKzEyMzYsNiBAQCBzdGF0aWMgY29uc3QgdHlwZW9mKHB2X29wcykgeGVu
X2NwdV9vcHMgX19pbml0Y29uc3QgPSB7DQo+ICAgCQkucmVhZF9tc3Jfc2FmZSA9IHhlbl9y
ZWFkX21zcl9zYWZlLA0KPiAgIAkJLndyaXRlX21zcl9zYWZlID0geGVuX3dyaXRlX21zcl9z
YWZlLA0KPiAgIA0KPiAtCQkucmVhZF9wbWMgPSB4ZW5fcmVhZF9wbWMsDQo+IC0NCj4gICAJ
CS5sb2FkX3RyX2Rlc2MgPSBwYXJhdmlydF9ub3AsDQo+ICAgCQkuc2V0X2xkdCA9IHhlbl9z
ZXRfbGR0LA0KPiAgIAkJLmxvYWRfZ2R0ID0geGVuX2xvYWRfZ2R0LA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdm14bmV0My92bXhuZXQzX2Rydi5jIGIvZHJpdmVycy9uZXQvdm14
bmV0My92bXhuZXQzX2Rydi5jDQo+IGluZGV4IDdlZGQwYjVlMGU3Ny4uOGFmM2I0ZDdlZjRk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC92bXhuZXQzL3ZteG5ldDNfZHJ2LmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvdm14bmV0My92bXhuZXQzX2Rydi5jDQo+IEBAIC0xNTEsNyAr
MTUxLDcgQEAgc3RhdGljIHU2NA0KPiAgIHZteG5ldDNfZ2V0X2N5Y2xlcyhpbnQgcG1jKQ0K
PiAgIHsNCj4gICAjaWZkZWYgQ09ORklHX1g4Ng0KPiAtCXJldHVybiBuYXRpdmVfcmVhZF9w
bWMocG1jKTsNCj4gKwlyZXR1cm4gbmF0aXZlX3JkcG1jcShwbWMpOw0KPiAgICNlbHNlDQo+
ICAgCXJldHVybiAwOw0KPiAgICNlbmRpZg0KDQo=
--------------xefsIXpq0wxo0BM9i717snKf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------xefsIXpq0wxo0BM9i717snKf--

--------------qqqJQkp59jKjmbEZC1Vwrfie--

--------------oWGr0D8fp74ylaTm4CQbbsBV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgHVaEFAwAAAAAACgkQsN6d1ii/Ey+4
Iwf+P9Anst6NLwWqmB/uty6SQtRbl27XWkzPR5WuXxRCqzw/TzMJRycI3KQdOG3uwJm2SavyMaCW
uoBR5Q6dEVl+HR/HEjYcFUPrht8UBU/DPjII+Mw9av5BTpbqZbeWcSXzGpssCKT6LSdMz2lL9/z7
tJ/TqijlLR9rqocXgE+4glFgcv3QAefO1du0hLZqrVI4MA7R/q9ygvviVnq5XE3roR21AiFmxJ3+
hrYYFSKQ62D4hp5zgr+XlPdiGmhSZuUeJqd0xKaIBX/gB2zoAeUsbxxinEe73DfRVQCw+zG9WpP1
oUZyBiVvIe4saCtWqIFn8SB/re/GmwczEUAFjiN8Kg==
=Nnhs
-----END PGP SIGNATURE-----

--------------oWGr0D8fp74ylaTm4CQbbsBV--

