Return-Path: <linux-hyperv+bounces-3435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3FB9E8CA4
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 08:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA257162FBA
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936421504E;
	Mon,  9 Dec 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="l0dZXr74";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="NnB/6n2B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F15588B;
	Mon,  9 Dec 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730877; cv=pass; b=FEawiB43opx9AHUKdnopWv3RjdkALS7heS/U38fAqQtR5M59zbKVKcFnmFY88Z4WnRYqn90z312xFCpPTS0ZOmuSKRFxiixTYpAyyNehPbWvbQHu33GcVLOPWSzc8mQCzIcPAQFA/tJvOSyMbrp/liLztxMXDqadPvLE7tSlCkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730877; c=relaxed/simple;
	bh=lO0tLRu715gEynI+0ZypsviUR0QiCBm+EfA4I6sCJ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHzR8gy7OAr8UnLLEwdcTpNwk+wdlaEQqX1zSNGe1kVcOVXqjZLc3NbGPOI05QHcouqAlqyrC5kCmhICAYI0OHDArZz0vxDNzbkNG9omkauJWD0BK5OjUzFQJlOaBB4t0nfFd9O8koDLCGiq/9H9ffwr1GqXAuU9HbR+iof/W58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=l0dZXr74; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=NnB/6n2B; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1733730685; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EgmztAAIcWKqeMHEACPx7b6bo9nV+Y/VJi1fo8ZMTGU5lHJHmVbBDGqcHXBghY1/Ep
    RCWbljSoPFTnM1o0WRA89z768YfWLbiJXcXZFtWLgWeKmxYwJR9L4ZB6Nn5v6SmFs3hm
    NJE/yc5a9mXOFN1wqnB1i1I2WogzciyUCydNZX3e8QrDdKKkUcfClfzipmCn5jzrzyuB
    R7TWXHqQ/9KvW8ucewvcTI+/wQPt1rDiH+SVz24wgXAb6zUrvfsc11kVKXEKVsnb4SRh
    B/UaNpjCJKF1gRy7qju28RRUW8SNq/P6wMCSMDlPgpvNOEZ89WXLziMthLr7e/X8zwiK
    8SEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733730685;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lO0tLRu715gEynI+0ZypsviUR0QiCBm+EfA4I6sCJ9s=;
    b=fB1r2GWLleqH0e99XqQeA91W/hNKolwcfuIlWIf7sFCBULIbpgo1K3+oaWlC4FwKw5
    soBE+85TyainzUfzTI2PVkrl3qypR9C9a1pm0Uun/+aCIiFgulMoFBhGvZuJsEdFMTMu
    fcKJVgPyu/mXNNjt3t1q5klEuNZgPagzpVs2o4YzZmDc+coTMX+ve/gSatbJhXGqmAMA
    0I9A78sxs6PVo9IJKYPTh4VrXgfDkj1P2qLhK4PG4XkpaRXqFDkqfs3k9QttAtHhTGqF
    xAQTctkLDhVsKue9IFF1v6rQH8EhZj35Cfu0mAI6kOXBHa+nfpkkP7WKnI+IW9TARatM
    AQ7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733730685;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lO0tLRu715gEynI+0ZypsviUR0QiCBm+EfA4I6sCJ9s=;
    b=l0dZXr74ItJagukzcqY/2nxyDw+0odGQG+UZFVw1A1FCjaXpug2lPfw6ZbOqoIS2Ij
    yg7jrg+kRVeXGMNpC1lVkrDTA5M9ORU9zWVpBvVXL+H6VNlSeMQYlHOeSZO4h2xQ9x9P
    mkjDZT1kFkIjHeF2N/HkmBIFvT3//js5ohopZe+wjOLlmTwYJtjEYo93zieOxy/G4AfO
    uWghvUT/Oi03knE1YS+2AKPQmr0vS4y2gsBgIlBc+GC1uEv5Adf6cUkyy5ULT61Rhjcn
    WsayfogcCubKgwip8Nuw7SCTJlkGIBwS5ENG01yOMTLR9F8O92VcE0dlX6kE9zkA+AcJ
    dheA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733730685;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lO0tLRu715gEynI+0ZypsviUR0QiCBm+EfA4I6sCJ9s=;
    b=NnB/6n2BlWehNFekGYkLAivwdslJzJQiu1BH+o0ZphXq/OUHm89JQ9tqZs2pkcU2Qh
    amOy+rQspXeLnfkLEeAg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmwGoJ7/hK6fuqCyaRBAxUwjRhfQImNezCGFSUO"
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250B97pPDrc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Dec 2024 08:51:25 +0100 (CET)
Date: Mon, 9 Dec 2024 08:51:16 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: reduce resouce usage in hv_kvp_daemon
Message-ID: <20241209085116.4284d3a3.olaf@aepfle.de>
In-Reply-To: <Z1YxVhO1x2YTLX_F@liuwe-devbox-debian-v2>
References: <20241202123520.27812-1-olaf@aepfle.de>
	<Z1P2ucUPPEYN2cg5@liuwe-devbox-debian-v2>
	<Z1YxVhO1x2YTLX_F@liuwe-devbox-debian-v2>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jhiiDLm_YK67zfSx1JjfVAy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/jhiiDLm_YK67zfSx1JjfVAy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sun, 8 Dec 2024 23:52:54 +0000 Wei Liu <wei.liu@kernel.org>:

> There's one conflict caused by an earlier patch by Vitaly. I've resolved
> the conflict and applied the patch to hyperv-fixes. Please check the
> final result.

Commit b8ea8cd0fbd358feee3e9172c5ef8afd671e0d11 looks good, thanks.


Olaf

--Sig_/jhiiDLm_YK67zfSx1JjfVAy
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmdWoXQACgkQ86SN7mm1
DoALUQ/+OlxChD/a7VlwBI7DJNsqyv9AkygMZCaTCfF556ZjnJmNzyBLchIae4qM
DarpwO+2tZ/GHeo0nP+oF+KrduZpmNm6WRQbjJ04Rgvj5eMcRux/XmlCOyMIL0Iz
/2bCJFDMi0ySkulDU0e+22Nfo+Uce5pVjfclBMw7DrIFilH/4Cz4NZXlrASQ9CY7
1EdTZkV0Of3DT1/L8ACl9Ou7c6aN+mnQjsks2f6hqJNHlEXBY1OlGeV6BIg6Tmkv
3A40a5wSy5ZkTaSg9UJtFZIr6vg2Laoa746xue0VjkAXih558OTWTmAz+V4oFOF0
tZYAcCvtZ1YTCNgWyS7OCHR1T9OgptubhH8h8aveh0bxiiq7r8BbgVRq22zwvwl5
frLxLRoP6vpukRphd221xrv2g7AWKBU/MKsWMBaEN9ytkCkFxwRQpPgQY/FpQDer
EaGdBO6LAnO1kndO7+okfenX2TJX5cLM/as6pRiE94KjomqWGOKXIAAukMa75KiI
+j1GEe7zGBzYz4yvD188g21HRjGjS2/KtmioMaaBX7FP/0B0SbC+O1+/Ow05F4a8
12iHSp1Y+kivCO14+8Nr8JeZPVneKTGZrh0jZxsE9l+HKKk9QYwA5FRbZwwUUI7B
HLMghuIyVyXPDc0QybvP0LTopBfbLCtoAbLHn6j/rsZCJGwZ824=
=EhdX
-----END PGP SIGNATURE-----

--Sig_/jhiiDLm_YK67zfSx1JjfVAy--

