Return-Path: <linux-hyperv+bounces-11714-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YReDJYvSRGq31QoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11714-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 10:40:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF736EB33C
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 10:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=DkFUWyqW;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11714-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11714-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7482730FFAD7
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A03EB0E6;
	Wed,  1 Jul 2026 08:33:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2803E9584
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 08:33:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894814; cv=none; b=XUowANTaksu4ByGaoVb/JB42nSk6ubBNCcBDk5F6g2oaE0pKsALgdzgGKNzrsxwFrDH6Wfn5byBzmLStST1ttB6VtbZBIBzAVAeGAL8liiOcm5OzEzi/R2TZCD7Lcrz85WgyKqOPrnXnQ/VY410IN9XsPHhafu1/Y3h7ca3h3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894814; c=relaxed/simple;
	bh=vjpi9gDuzwwRM7WLjI09X9TThOB1p5PHgz+55yL6rYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN1VNAfJ1ByVeeGSSKz43riv2XA1XdaHfmj4ZDbOpBlg4j14IguBf+Ev1Sl7ZYdKZlW/ieoRCZ8hE6+SCZY42azOBT7ACdmJdquvkX9iOalVTE4YQPK30hl3EStRTFbPUc2KIe8g0TXiim4kjCxfUbuPmeXEh6PpuRTFZmiGto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DkFUWyqW; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-695f6438518so648064a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 01:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782894810; x=1783499610; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjpi9gDuzwwRM7WLjI09X9TThOB1p5PHgz+55yL6rYs=;
        b=DkFUWyqWgHxHYcBp/nkaazJBOgywn1jIJGObl7tyCpjYq9+mpQKE+0rynd2RjzfAln
         TfpbQG1lMoQrqU2qN/QNEJrSnUNTuJDCihBoNOPiNjSsf8gMYeHq4a+oS513NxoZz+E9
         Odh+0eqoXLTk3yGO/G1x3pOr0oR+2gXsdJXRTV5EzHkYrsoAX9CVJWxOvTzEQtox/BrK
         LmvuNVDJQ+tBKftxx/vOWMhmHIwJ2fqU63brG78qvhy3up//G6cYDjnATwlwhIfR+7R/
         mD1mFHE2Bu4D/3hu8ajaIwZq/P1TEnqwZhExPIFBCCAdizo5oKdylPa7PUUgedYmHqfI
         poaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894810; x=1783499610;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjpi9gDuzwwRM7WLjI09X9TThOB1p5PHgz+55yL6rYs=;
        b=iCmsAzJ/kVGla/8Y/dVbx3kjjiWVBQjIA0mfgoI/ONyuKo8dFDupHKU4Tq0/Wj76Kq
         bqWw8irWZbCypVrIt5VqSiCcwwbuW8+DFKaJSSpDARO9l2WJuKyDnEWRHVAiNYbdUnH4
         kf1mLgLTn9+B0rX/y8LjNVAfeEMLMFdWsYjLM8/1d2+zToA2+lhGlMLLYwI6AepHY9sP
         WLE3F41DIOi7fNKn9GeMbUXVFAFR8YyeKil792XkPptehO2P36S25SmR76JB7141ZYC5
         0HNVGUcI9770jDYg79nKvpWk+eC17qdGZS5VYATPH2dv+QQXgrHCFSTu5SOchy2tfD0j
         bRNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXulZOhnVv6nhmoVMZSP1vufM2B3N810y3jSZ49pkoqEEFUXPgJSgD4Pa7oBaU8/O6xYXcw/4/JqFDlOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqrNkHLuzak6EEs5nulVZlXhlIs2SmmydWLPpdsJsbmvHpX3V
	A2jA7ZiKqyQWjr4P39DF3WkZIHspcmu3O3w4DZ80Hybup+zWd7deeKJeq0KHiY3uIjI=
X-Gm-Gg: AfdE7ckBV3Mf1TiLpWYSam138AflKEsEWfjQeXkMupdLzsauj0SATSPPNO/96uw+4I6
	xsuKdC5pMiPb0HVDq1CW1MHVFTdWATsnckCC4nMgE/7rLClzVe0J4EK3iSudG+DgiGkh2wJfUvw
	qqdyCpX/e3FaoRQJyVD0IpAJi9RRvH4p7pyJpvwllexXje+UVOIObmFdCn5WV8dKy+3ciKv40RS
	Y26RCr8pu0gSEkNLdJGT2yuA22E77s9b2IthLV+XznOq8nw/aoYH0o8be05uq8cpZ1PMv3oJxov
	g6r+EyB15MPcK4M7NBGzC66X2MhciyRavRXLbCLQqTW/VlwQIF4Iu8ZgNcMKIFhAV1hbD3v2Zg/
	GKGNF7dwl5sYmPATF9ZIRmnbDRT3NjdMfZhdpn9ROyNOUDugQpaD1LuT7FUmFWp5gEfAf05P5y1
	NmdweMo4QA4mcditstuTBjK6njZlDtl0Ik4QIiNFb1JQ7fTqNffZJT3r5lUa+bETyxrOltPRWwb
	ixfoxC855+Im978OqI58ccEOaIWBOv+EkKJPkAcWkTg0dfjDYEIzg==
X-Received: by 2002:a05:6402:4146:b0:698:99be:29d6 with SMTP id 4fb4d7f45d1cf-6989f38e868mr343446a12.29.1782894809526;
        Wed, 01 Jul 2026 01:33:29 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c21f123sm2359277a12.0.2026.07.01.01.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 01:33:29 -0700 (PDT)
Message-ID: <0c5e4515-b51e-4b19-8389-a76cabc88042@suse.com>
Date: Wed, 1 Jul 2026 10:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
To: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>
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
In-Reply-To: <akQR9YMtMHReJTfB@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yR0aQa1Dp38FRBSVbM28PBR6"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.85 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11714-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:mingo@kernel.org,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@inte
 l.com,m:puwen@hygon.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.
 huang@amd.com,m:mario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,vger.kernel.org,kernel.org,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,zytor.com,hygon.cn,google.com,broadcom.com,linaro.org,zhaoxin.com,gmx.de,selenic.com,gondor.apana.org.au,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_GT_50(0.00)[96];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:mid,suse.com:from_mime,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEF736EB33C

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yR0aQa1Dp38FRBSVbM28PBR6
Content-Type: multipart/mixed; boundary="------------vD8700IqVizDT0GQTpFiBkTP";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>
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
Message-ID: <0c5e4515-b51e-4b19-8389-a76cabc88042@suse.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
References: <20260629060526.3638272-1-jgross@suse.com>
 <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com>
 <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com> <akQR9YMtMHReJTfB@google.com>
In-Reply-To: <akQR9YMtMHReJTfB@google.com>

--------------vD8700IqVizDT0GQTpFiBkTP
Content-Type: multipart/mixed; boundary="------------jBK7pBe03sqwPCAFbkx06T5B"

--------------jBK7pBe03sqwPCAFbkx06T5B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDYuMjYgMjA6NTksIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIE1v
biwgSnVuIDI5LCAyMDI2LCBJbmdvIE1vbG5hciB3cm90ZToNCj4+ICogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQo+Pg0KPj4+Pj4+IE5vdGUgdGhhdCBtb3N0IHBh
dGNoZXMgb2YgdGhpcyBzZXJpZXMgYXJlIGluZGVwZW5kZW50IGZyb20gZWFjaCBvdGhlci4N
Cj4+Pj4+PiBPbmx5IHRoZSBwYXRjaGVzIHJlbW92aW5nIGEgc3BlY2lmaWMgaW50ZXJmYWNl
IChwYXRjaGVzIDcsIDE1LCAyNiBhbmQNCj4+Pj4+PiAzMCkgYW5kIHRoZSBsYXN0IHR3byBw
YXRjaGVzIG9mIHRoZSBzZXJpZXMgZGVwZW5kIG9uIGFsbCBwcmV2aW91cw0KPj4+Pj4+IHBh
dGNoZXMuDQo+Pj4+Pg0KPj4+Pj4gSXQgbG9va3MgbGlrZSB5b3UgYXJlIHRvdWNoaW5nIG1v
c3QgZmlsZXMgdHdpY2Ugb3IgbW9yZSBoZXJlLCB0bw0KPj4+Pj4gZmlyc3QgY29udmVydCBm
cm9tIHJkbXNyIHRvIHJkbXNycSBhbmQgdGhlbiB0byBjaGFuZ2UgdGhlDQo+Pj4+PiB0d28t
YXJndW1lbnQgcmRtc3JxKCkgbWFjcm8gdG8gYSBzaW5nbGUtYXJndW1lbnQgaW5saW5lLiBJ
ZiB5b3UNCj4+Pj4+IGludHJvZHVjZSB0aGUgaW5saW5lIHZlcnNpb24gb2YgcmRtc3JxKCkg
Zmlyc3QsIHlvdSBzaG91bGQgYmUNCj4+Pj4+IGFibGUgdG8gc2tpcCB0aGUgc2Vjb25kIHN0
ZXAgKHBhdGNoIDMxKSBhcyB0aGV5IGNvdWxkIGJlIGFibGUNCj4+Pj4+IHRvIGNvZXhpc3Qu
DQo+Pj4+DQo+Pj4+IEkndmUgZGlzY3Vzc2VkIGhvdyB0byBzdHJ1Y3R1cmUgdGhlIHNlcmll
cyB3aXRoIEluZ28gTW9sbmFyIGJlZm9yZSBbMV0uIFRoZQ0KPj4+PiBjdXJyZW50IGFwcHJv
YWNoIHdhcyBoaXMgcHJlZmVyZW5jZS4NCj4+Pg0KPj4+IE9rLg0KPj4NCj4+IE5vdGUgdGhh
dCB0aGUgaW5kaXZpZHVhbCBwYXRjaGVzIGFyZSBJTU8gc2lnbmlmaWNhbnRseSBlYXNpZXIg
dG8gcmV2aWV3DQo+PiB0aHJvdWdoIHRoZSBhY3R1YWwgMzItYml0ID0+IDY0LWJpdCB2YXJp
YWJsZSBhc3NpZ25tZW50IGNoYW5nZXMgZG9uZQ0KPj4gaW4gaXNvbGF0aW9uICh3aGljaCBz
b21ldGltZXMgaW5jbHVkZSBtaW5vciBjbGVhbnVwcyksIHdoaWxlDQo+PiB0aGUgQ29jY2lu
ZWxsZSBzZW1hbnRpYyBwYXRjaDoNCj4+DQo+PiAgICAgeyBhKGIsYykgPT4gYyA9IGEoYikg
fQ0KPj4NCj4+IHdoaWNoIGNoYW5nZXMgYm90aCB0aGUgZnVuY3Rpb24gc2lnbmF0dXJlIGFu
ZCB0aGUgb3JkZXIgb2YgdGVybXMgYXMNCj4+IHdlbGwsIGlzIGp1c3QgYSBzaW5nbGUgYWRk
LW9uIHRyZWV3aWRlIHBhdGNoLg0KPiANCj4gSXMgdGhlIHBsYW4gZm9yIHN1YnN5c3RlbSBt
YWludGFpbmVycyB0byBwaWNrIHVwIHRoZSByZWxldmFudCBwYXRjaGVzLCBhbmQgdGhlbg0K
PiBkbyB0aGUgdHJlZXdpZGUgY2hhbmdlIG9uZSByZWxlYXNlIGN5Y2xlIGxhdGVyPw0KDQpZ
ZXMsIHBsZWFzZS4NCg0KDQpKdWVyZ2VuDQo=
--------------jBK7pBe03sqwPCAFbkx06T5B
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------jBK7pBe03sqwPCAFbkx06T5B--

--------------vD8700IqVizDT0GQTpFiBkTP--

--------------yR0aQa1Dp38FRBSVbM28PBR6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpE0NcFAwAAAAAACgkQsN6d1ii/Ey+4
VQf5ARTTFZkvO/RB1pgLA5pxpW3UUS3uxxV7SopNU0hZc/AzNq9az9lJfyH7jPZ8QBmU9IKulebG
ITlyXQQs6UjK+gdS9lqvVR/gt7jXQo56BFaXUZQwHSt8ln7k9LhUmdEaBj2m305DZnpb9SGilWTg
FU/0xAyiM++MkxazBUebIsHavKxiZg3dIjZQ6L7GCivFopHxm59Fg0dv+E0OzaQGPmtrz/oR7sNP
AkYiOzz84cF2fQXnHTlKAU02RMhfJ2YDp/KAdwPaf1hFwAZsNFL3usH2Ku34Q0ARJoRpUockNhfc
G3t+JspAVbLH9NBe6jFF+6eWh86FKPsmtwZt0e9tvQ==
=ng7t
-----END PGP SIGNATURE-----

--------------yR0aQa1Dp38FRBSVbM28PBR6--

