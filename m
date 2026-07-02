Return-Path: <linux-hyperv+bounces-11807-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nwHZK55GRmpmNgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11807-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 13:08:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34B6F6704
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 13:08:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=fFwMSklP;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11807-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11807-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DA763026793
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491A3D6690;
	Thu,  2 Jul 2026 11:03:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA23C76A6
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 11:03:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990238; cv=none; b=RElIlme3iK6bq+pylUawYJGozPXa/NQab7nbquv4emv+M5AU8ITzw1i1KF+zdisAIn8yOaV7ZtSfIJ+WA2+Vok9TU2gdPPU3TNP3HU7HI9CKGwWAvieLYnZAUdQfEaZ+RGsEOTfmKYvC4ezUUm2AvAQcRCb3z/89jd6CddCIPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990238; c=relaxed/simple;
	bh=rLAZ6xjWSh4dBeXXx+Zm/8773z7w6ApW8uj4atG+Tbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+fBU2rENI9HDBg1pw8E97oUqcpFXXvjvekSoLDIRDLJeosFsHf6hfzLinMXj5zDJx3cZ0gPINsFW1S2qYjIJaHP/zq3DLO7vT/3zqaf+UZ8sA5WtNjDDNISzz/b5VvjwJEkbeKRylph998QxzG1nY0AFcahCkn8o+LETO8wOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fFwMSklP; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c125bce2294so190443766b.3
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Jul 2026 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782990234; x=1783595034; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLAZ6xjWSh4dBeXXx+Zm/8773z7w6ApW8uj4atG+Tbg=;
        b=fFwMSklPk0K45f82cZkspN0XsW8ZtBuWJzhUe4xeCi24fLDRim2r9FMLcrAW2l2CRM
         UmlK6M0QWT7XvyQM/cn09ziJXQjKd7ZsumWeSiaRRghFwEa6iOLf1yJ/AXt1ONpPEH3I
         KstDJ1gUUMIVlpa1BSWwcRPDispmLW++j7GzDeNBM6Esg0RlzD91LniADw/G/qIAFALv
         5Ozakp1uvbCNhx8DAcYIFY1YWcxmzb1yeuo2otcJDZDjAwK521FQlFsZEFHVi4khWsNy
         Oyh76J9OzTaslFSKJKGQviWPawMCyN/bFcSJ46DTuzX0G+GuGgn652CKn2uSHsI7EPtQ
         rl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782990234; x=1783595034;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLAZ6xjWSh4dBeXXx+Zm/8773z7w6ApW8uj4atG+Tbg=;
        b=SB16657k2Zlwcl/La4pbtvtRn0sgN1q1lImV5EL/FFxJ9ynoWZBg5x9Je4oi0SxKqK
         6ncLTnUOCDCznw09ARAks9QjCdzQL4HQ9uGawJzv8JwC96wdOQqxhbDQSzba8p64L9I9
         SOi2VO0H/mByiw8lY/gX/9V4GHJTW8TrH4xWVlJWuP809gOYivSMY2l1u6gyXdwWdElw
         Dj1QLqkPjxSg2SMmCJnKmnvZcuz8XswSUHo1WbUu5ttVhk2ihp9+vMAUUjKSIUZpozFy
         hUE8HXHcREgdY+695nFgknPGS5zb9vkBTkRVtH/kFlL7NtVJmYopGQu1UCp1lmdkTILj
         f+Gw==
X-Forwarded-Encrypted: i=1; AHgh+RrkZvORqK3tN/XvD/5S6TWmvVkHeX6wgHhmB450Not1MkzD7JbHD0/g3ExR02QWMeLHck8TFOxCtaiP+p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorXdWFJuMvSy1LKFrYIbZuE4hpl1HVMClmd0hItltTgSsYvd5
	+hgy5gHP4vExlTQlIcuexrH3ezhSOrGjC/lZZbYQTflm3fmJXB6NMglEOgOV4ac32tc=
X-Gm-Gg: AfdE7ckjwCKHjTA/9r8iKTmjkF/wtK2mhuFk1Up6xLsDnOl0lmNsi/E6idYIJfqE5jm
	j6gPeB3zuP2oJcUua6VuW3ldsqh8O/XzMWUpK5y8betI2gzTrk9ApPq3UVObttd3axdXSlwdbtt
	yIO0DVv8mLSGhK8PwoOH/+9K7OjTTHLMNhuA7w+9MdnvFslk6wtXoWWKkjQo3745/5+e1xRLnLO
	1e2ZDU2hsIk9wiTL77D/6/sAcseJvXDSgjjTf8BU2PWCRlIF5jC75kaXDwJ6vKFHkP2+ZQ3U87L
	B+SVzIMgJmUmH/eJ5L7SPW3fr/JH38T5gRb6py8YIg/crO+xVaZUmyFBbaYsky0xzu6b6tCAxYR
	DCEf7ro80rFIDcg+RfnfaHkCtwmWmeNhqbLtpek36KsTjrXhRA9WXsBJTft2TiZOxxaul2NRvFp
	sIhxF9QH1UN1CEo8pGOQRLz7Xe/ls4khU+pvpC+nWvFylRsMkvLSsvLMK01kq1c8dT37b1+IKu6
	a257ez4eQsCMmD4pPks5JH4z8h7UT6aVeEH951M5TI=
X-Received: by 2002:a17:907:e14b:10b0:c12:3143:864f with SMTP id a640c23a62f3a-c12ae47556cmr180127966b.2.1782990234377;
        Thu, 02 Jul 2026 04:03:54 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698acf25f4dsm809220a12.8.2026.07.02.04.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 04:03:53 -0700 (PDT)
Message-ID: <99228803-b8b7-47a3-b77c-6fdf3b785730@suse.com>
Date: Thu, 2 Jul 2026 13:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, "lukasz.luba@arm.com"
 <lukasz.luba@arm.com>, Jason Baron <jbaron@akamai.com>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>,
 Bjorn Helgaas <bhelgaas@google.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, xen-devel@lists.xenproject.org
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com> <akQR9YMtMHReJTfB@google.com>
 <akY4U0jUZm4HOGZ_@gmail.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <akY4U0jUZm4HOGZ_@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WjZXb44KsATEDkDSufWy2bKk"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11807-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:seanjc@google.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@inte
 l.com,m:puwen@hygon.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.
 huang@amd.com,m:mario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,vger.kernel.org,kernel.org,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,zytor.com,hygon.cn,google.com,broadcom.com,linaro.org,zhaoxin.com,gmx.de,selenic.com,gondor.apana.org.au,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B34B6F6704

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WjZXb44KsATEDkDSufWy2bKk
Content-Type: multipart/mixed; boundary="------------o2fircZpb09tU1GMO2GxqgPd";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, "lukasz.luba@arm.com"
 <lukasz.luba@arm.com>, Jason Baron <jbaron@akamai.com>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>,
 Bjorn Helgaas <bhelgaas@google.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, xen-devel@lists.xenproject.org
Message-ID: <99228803-b8b7-47a3-b77c-6fdf3b785730@suse.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com> <akQR9YMtMHReJTfB@google.com>
 <akY4U0jUZm4HOGZ_@gmail.com>
In-Reply-To: <akY4U0jUZm4HOGZ_@gmail.com>

--------------o2fircZpb09tU1GMO2GxqgPd
Content-Type: multipart/mixed; boundary="------------DvT8SfkPmJRmXAYHiBwk9gCF"

--------------DvT8SfkPmJRmXAYHiBwk9gCF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDcuMjYgMTI6MDcsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPj4+IE5vdGUg
dGhhdCB0aGUgaW5kaXZpZHVhbCBwYXRjaGVzIGFyZSBJTU8gc2lnbmlmaWNhbnRseSBlYXNp
ZXIgdG8gcmV2aWV3DQo+Pj4gdGhyb3VnaCB0aGUgYWN0dWFsIDMyLWJpdCA9PiA2NC1iaXQg
dmFyaWFibGUgYXNzaWdubWVudCBjaGFuZ2VzIGRvbmUNCj4+PiBpbiBpc29sYXRpb24gKHdo
aWNoIHNvbWV0aW1lcyBpbmNsdWRlIG1pbm9yIGNsZWFudXBzKSwgd2hpbGUNCj4+PiB0aGUg
Q29jY2luZWxsZSBzZW1hbnRpYyBwYXRjaDoNCj4+Pg0KPj4+ICAgICB7IGEoYixjKSA9PiBj
ID0gYShiKSB9DQo+Pj4NCj4+PiB3aGljaCBjaGFuZ2VzIGJvdGggdGhlIGZ1bmN0aW9uIHNp
Z25hdHVyZSBhbmQgdGhlIG9yZGVyIG9mIHRlcm1zIGFzDQo+Pj4gd2VsbCwgaXMganVzdCBh
IHNpbmdsZSBhZGQtb24gdHJlZXdpZGUgcGF0Y2guDQo+Pg0KPj4gSXMgdGhlIHBsYW4gZm9y
IHN1YnN5c3RlbSBtYWludGFpbmVycyB0byBwaWNrIHVwIHRoZSByZWxldmFudCBwYXRjaGVz
LA0KPj4gYW5kIHRoZW4gZG8gdGhlIHRyZWV3aWRlIGNoYW5nZSBvbmUgcmVsZWFzZSBjeWNs
ZSBsYXRlcj8NCj4gDQo+IEknbGwgdHJ5IHRvIGtlZXAgdGhlIHBhdGNoZXMgaW4gYSBzaW5n
bGUgdHJlZSAodGlwOng4Ni9tc3IpDQo+IGluIHRoZSBob3BlIG9mIG5vdCBwcm9sb25naW5n
IHRoZSBwYWluIHR3byBjeWNsZXMgLSBidXQgaXQncw0KPiBvZiBjb3Vyc2UgZmluZSBmb3Ig
bWFpbnRhaW5lcnMgdG8gcGljayB1cCB0aGUgcGF0Y2hlcyB0b28NCj4gKG1vc3Qgb2YgdGhl
bSBhcmUgc3RhbmRhbG9uZSksIHdlJ2xsIHNvcnQgaXQgYWxsIG91dCBpbiB0aGUgZW5kLg0K
DQpJbmdvLCB3b3VsZCB5b3UgYmUgZmluZSB3aXRoIG1lIHBvc3RpbmcgcGF0Y2ggdXBkYXRl
cyBqdXN0IGFzIHJlcGxpZXMgdG8gdGhlDQpvcmlnaW5hbCBwYXRjaCBlbWFpbHM/IFRoaXMg
d291bGQgc3BlZWQgdGhpbmdzIHVwLCBhcyBJIHdvdWxkbid0IG5lZWQgdG8gd2FpdA0KZm9y
IG1vcmUgcmV2aWV3IGlucHV0IG9mIGFsbCB0aGUgcGF0Y2hlcyBiZWZvcmUgc2VuZGluZyBv
dXQgbmV3IHZlcnNpb25zLg0KDQpBcyB0aGUgcGF0Y2hlcyBhcmUgKG1vc3RseSkgc3RhbmRh
bG9uZSwgdGhpcyBzaG91bGQgbm90IGNhdXNlIGFueSB3ZWlyZA0KcHJvYmxlbXMuDQoNClRo
ZSBsYXN0IHR3byBwYXRjaGVzIG1pZ2h0IG5lZWQgdXBkYXRlcywgYnV0IHRob3NlIGNhbiBi
ZSBhcHBsaWVkIG9ubHkgYWZ0ZXINCnRoZSByZXN0IGhhcyBiZWVuIGFjY2VwdGVkIGFueXdh
eS4NCg0KDQpKdWVyZ2VuDQo=
--------------DvT8SfkPmJRmXAYHiBwk9gCF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------DvT8SfkPmJRmXAYHiBwk9gCF--

--------------o2fircZpb09tU1GMO2GxqgPd--

--------------WjZXb44KsATEDkDSufWy2bKk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpGRZgFAwAAAAAACgkQsN6d1ii/Ey9T
iQf8D4c54BGRNKMRsSJiXSFxOPiUVfGXcsH7BLGSCIbavlNKB6PC4nfBVKfvlEHUsQk3Zy7dOXCt
DjWUBhqMxb+QCJKNrUGKsdDFtl1Agihz8PaRzzF6LAJL86LHnhjy30FkyEoT+wE8pfL61qKpyusy
xGc+xkkzm+tcDAwQDn9wTrmDKRaa/yWjrPX2idLQ/ATrKILtNW/Ci7tbKeltRSGhWV7aNEtyEUco
wq6RU91rH9miz+a9ZWCRa/bc1FU0brdudBe2pkTiDua5vzSwUx4gBoLQ98BcHb+bKidB+OS3WYBa
Qfoo0sr6Uryp6mf98UcyNgyPhA4rdUuo1iUvfsGhdg==
=MZUf
-----END PGP SIGNATURE-----

--------------WjZXb44KsATEDkDSufWy2bKk--

