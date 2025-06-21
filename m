Return-Path: <linux-hyperv+bounces-5986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F804AE2774
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Jun 2025 07:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199BB1893A1F
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Jun 2025 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26818C011;
	Sat, 21 Jun 2025 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="HcE0Fw19";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="4a1W7ppP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED230E859
	for <linux-hyperv@vger.kernel.org>; Sat, 21 Jun 2025 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750482608; cv=pass; b=CE/3Wmky47tmeyeXXpeAPuRAosn7X2qVFvTAO0fOuor4qwAx2s+iO2odbSej2wrOfAKGeqI8nL5cby4ucIMfnFaSpcksvaZyAC9+mfTT7x6Au454fqiyKlSX7XdxQHJkt1Ug2H47J3FvIJLM5rstPub0r6IEQmu/8Lm5+2jj+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750482608; c=relaxed/simple;
	bh=iMqNL1VIUaSK86OgEd5xDEZHthKVSNZHR/m6jeh5h+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzCqm+TJ9ygKCNBawN7sYaZCz0QZOIhCQo42Qtj8IQBWTUAYrDF3c3OKpWaCjxSwENERZjpGMoOLXD0s0De8L/eEhFFXtDKRYN0Spnc/aGFoWu3bstKsS+TqSzxfc5dJkEMxjDRTUqDTmgWsveYqfmZVfLljCXBoK0xSw4wwczw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=HcE0Fw19; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=4a1W7ppP; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1750482413; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FeP891ecfVMoep83nvM7XwrKKGVl774iqnMAStywkPB/hdmpV3fZ1JhekEPI3sFWV5
    /udEbadNUUuQ+Dj0FI9dNELVpwpR+cInjYL0AvyHb29X8cmvrEg97WbfXzkVp3EHSD/2
    Fzdr+CbXVD4QAhsqdai7drQIPwouNfOv/ZLd1cqev4LIgJa6m9+R1weUNsqSFrK/w8cW
    ns6OBJJ8nVV9Cj4v+aaHicYjBaekpIRVMKLb4CrvOcGoUGavKaDxpw4gNzpGc7n7kN6B
    Qn9VZBpt5e1X+If/G2MwU1J5sJBnfzoSEsS4+nP9SspLKl3X48quADuo3Bq0Mg5HH5fW
    0ZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1750482413;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XKQ8QekkF50ykdMbE6HrvtN56IRZUBm69FQzBFO9hME=;
    b=hl1M4M79F8qNt2lh9Ta4PSDI5MsOwHpKB/V3g4SQ8+zz/PFmRmzPKRG67STUfxMrqo
    DPD9KNvltSrkY5ih01LlX6v2nBGIpKH9V2jUXBcl6LoTuMJww5ffitXSpnGooz0lnL5y
    ssyezfchtnCS6UfjvY+7x/fcacmLYSEdc64niyNed4AMuDw/ToVVR410twH3oJOUxqjB
    RJ1bscWx3LVmCNZqxmGxQvPjd1gnpJ7Wjx0iDqWi+FMuV9epktJr0fwcpSHBUHEL74av
    /sAT+fDvO/FvpTRSIuhxGCrVDu3pU43NS4W0/zoDFa33BCwA3AZjyJAg7Aiworu1qfAO
    9t4Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750482413;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XKQ8QekkF50ykdMbE6HrvtN56IRZUBm69FQzBFO9hME=;
    b=HcE0Fw194VINTnY1PQwew7fwREiKZ/qebRnuCvo4Rw/OUyU5gtR3vs8mZdyVcbBUp5
    x53v47rJejLHPWGEntn+lpmxYWtj6BMYzrWpv72Mnhsqr+FINWSejwJKALmu4Hg3Fq6V
    D4S2d0oITQGqj1NIOJaragKN6D+FHWc022Vfyg1pR7lBS7SIEfv8Rw/yx07jR4M+P32m
    P92i/NLUO9LWVwfWPkIG7Epmw0oxlJkScI6chbPcFCj4wlmOKnw3Okp4lQpm6KNHJ6xj
    +ZQyZMhQjE4P372s6eU9P9P2zbOUTq4asHbOC1ERhMuWXJJx4tPGDat2ZIlOgtrRhlGd
    xKIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750482413;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XKQ8QekkF50ykdMbE6HrvtN56IRZUBm69FQzBFO9hME=;
    b=4a1W7ppP1OBGPo54zAY/2X0ITyDTZHm8wKqn7LWnd9g6t1vTRf1x2pczja4Q4SbdjZ
    xdl4oqjJgGzYUMjoNTBg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmzGoJ8rBK6cWAVfDMmnI2IZ8kj8s0jE6n+P5L1"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd15L56r1kC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 21 Jun 2025 07:06:53 +0200 (CEST)
Date: Sat, 21 Jun 2025 07:06:44 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Message-ID: <20250621070644.3b4185b6.olaf@aepfle.de>
In-Reply-To: <20250620070618.3097-1-namjain@linux.microsoft.com>
References: <20250620070618.3097-1-namjain@linux.microsoft.com>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2JU9w6Agp2zSvh9H.WYfJgB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/2JU9w6Agp2zSvh9H.WYfJgB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 20 Jun 2025 12:36:18 +0530 Naman Jain <namjain@linux.microsoft.com>:

> +	desc =3D (unsigned char *)malloc(ring_size * sizeof(unsigned char));

Is this cast required?


Olaf

--Sig_/2JU9w6Agp2zSvh9H.WYfJgB
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmhWPeQACgkQ86SN7mm1
DoAKPA//YglZSVJQcglECyjxM6msqOal51UqqolOBBDC03W3KYxQ/nEdfKfXmLYv
9TZovN3EZvhozhj7r/7AnJ9dR84nkp+OuZzZxbKv5lXfbnDyL6sAjrHS/GBmm/wP
ki2IT9jcoqg4o9BKyvCoe/8ZYMS4eT0VfbxUOFLl3IGsArB1AhzUZH4G+ltEbXNS
VhC2DNldTjOd/unDxJMFXTtJpI6+HtXTe7UZtHSPE3/RcPe1A+aQC+dvn3yZG/6Y
NP7YqY4U+fWvCPFN0ZByKRte+W72a8b11rUJFhfGF+uF/Pm0mzN5YoI8Z4GBnEU5
bjKnUdL59vCuDPtLW1frGjj6SuMJx/+AxawYHPAMqlJxdRnKOoS6jQe3YUsQ6Brd
X+BHbD4aw+a2DFR7yv7pzfFm9AjyWuGFGXUOmShj+zB+cIYw55slPA6BjYEut6qI
hms/SFw4cSMhMLW+Cvbmh941HsgZdbuMIKW75Ygeb1a8U590BE6ftHKUU14YwEU5
pBvN6+q5MzdzM71IvWecHPchx6fDQJRPmvdQbiGP2wGx4SCh1r2MfUAyXlrGnn99
zUDVIuoktk4UBSjEI7DRxb9QMYxGxK5f2S6vOT1ZhSPuw1nFKlwOhszgrkv3OHLn
h3sCC2X8eXQirgtOr94q3NLEaoyye4CttWypDZ0EXSLJV/u0YKE=
=oNRO
-----END PGP SIGNATURE-----

--Sig_/2JU9w6Agp2zSvh9H.WYfJgB--

