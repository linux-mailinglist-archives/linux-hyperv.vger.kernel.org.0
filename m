Return-Path: <linux-hyperv+bounces-6063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D1AEF66C
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6055E1BC6187
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6926B96E;
	Tue,  1 Jul 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="IsOURGwR";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="1ROTpqMA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1826A1DE
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Jul 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368912; cv=pass; b=eBt9LRmTNwbmsLV50nInJ6fr5kRX/8Lo7CrPIe04QDN7kJMX6mFxjohe3uR5zDBpUgQooqZswVimQaVNVMlN8qIzmqtnhuFlS1NWNy7/XgGYLhxibh/7NnTVYEAaR86u8L/ruGcQwE1yu2ERwlEjBm9Z2sD1mN0r87Akf72NqK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368912; c=relaxed/simple;
	bh=gUQyv41Gn9LR0/WCRhrgn8wWqLPyv9FHtr12u4lbRFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu41BUxnvGASXx8zBHIraPLbvF+bNEhQcMJN2AKg814m3RjibZcrGLTFlgGpaWkIzW9q0Wob7Wy6jtfDpQIm0LaKq/+lVTBMhQBm5EvPWlB5p6HKSRQ6hz2ryoYWvMy0KIdcHk7TnDO9sXEthYXvte87McDxIH9sKSss9eFxAr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=IsOURGwR; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=1ROTpqMA; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1751368543; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m8tSjQYH/rjSNye0oX9WF+e3b8LHnJskUaGVd+5+9eRHykFd5QAJe9LW3Tb5uoF2Ah
    LpLbol8lhZLTx5Ji27B3P8PT8+cQvrVclrbkCSaGeRWJw6Tf+npK1eKShqn4e8gLeSNa
    Ph8cYdunoplBBvpKgSf26SdRdXyuQq4AlKRQP0UoVTm4RFIdRAY5zgXxufxtuKwf8UCD
    qxvPrMfKgHnomPeDQaubOJsOH6wyDhNGRDpO2PY4ScTlziYaSagN0PG+uMM4nMpZAG6m
    OVKgnP4txev+nwpRV2G06Cxjg6kokaSg/G6KWWmedUm7nJEd29IsHLXVV+R/j/aFBRRy
    cxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751368543;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wEOBlKUXvrWzRxDgnR1dClAq6TTdBBzY3YMfXYkvyt0=;
    b=dYfOfhc+BusUuGSrmksmT3R5xnDsSGcORgA0I4GKjk8m7Ufq6q8ciB2E5FmElELMul
    ehTU2gB+MXdVraKM8W7MtyrXmmY70HF15BBq3/YieKopo4FfFM7tnxWuxcq/BzzbYlp2
    d31x2Za4GVeB4vG6c+U9m/a22gV+uoqVW6nGzvggskrPFUm0vLASHl+ozXvKuy3HZikh
    R71nRJH4ccussVBzSqHlcB8OcehlCFdP++FyBQTYJejEjyg33wuAiVdfVivQGlJ2w6Q/
    tJF2gpbZbwx8PyNx1e8Hgb8iYDhy/slOE4Yvzsr0q9pDp0rxzHnuytd45qcGqhRlP6yi
    utZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751368543;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wEOBlKUXvrWzRxDgnR1dClAq6TTdBBzY3YMfXYkvyt0=;
    b=IsOURGwRC8+3uIPKXhZGvoxBL2brFiAUsbiit3m0BbIGT3dKhBP0z4x9Esaf13rSlF
    L4rt7CVCdnO6G5GFaoHgAiaMHluZUU8JwapOMNzGN1EKbWSNEEPvOHa9PcLqVcccI577
    QqbMdj4ZvAN9lt+DvKF9WJLBLah7/hxsHRi6hSRagXX5ZtMg0uowNd3Qei/9mKeZS2bC
    lO/Hs6m+WLpozWhBuWVeQlvRUzzpkT0dhnPQcXDKteRZRxA46XqMScR8NcTs5c0wC9Ev
    KKowHcSUp0nb7OLPZ5Ry0nHSI3m7Px5+1OSY91I6/7kTaMPgoaYIeIz34esADabiTR/G
    K9KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751368543;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wEOBlKUXvrWzRxDgnR1dClAq6TTdBBzY3YMfXYkvyt0=;
    b=1ROTpqMAvBriu2SBB3gxDBTvZIV5XNnl/bMg6gNgBtm8najhEUaU29qPTdhhy1wyjq
    JMChnDldgd7zuXJjWzAQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmzGoJ8rBK6cWAVfDMmnI2IZ8kj8s0jE6n+P5L1"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D2e95d161BFgJKQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Jul 2025 13:15:42 +0200 (CEST)
Date: Tue, 1 Jul 2025 13:15:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2] tools/hv: fcopy: Fix irregularities with size of
 ring buffer
Message-ID: <20250701131532.125b960c.olaf@aepfle.de>
In-Reply-To: <20250701104837.3006-1-namjain@linux.microsoft.com>
References: <20250701104837.3006-1-namjain@linux.microsoft.com>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/64GBwXXANp4OImnPC0816Nn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/64GBwXXANp4OImnPC0816Nn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue,  1 Jul 2025 16:18:37 +0530 Naman Jain <namjain@linux.microsoft.com>:

> +		syslog(LOG_ERR, "Could not determine ring size, using default: %u byte=
s",
> +		       HV_RING_SIZE_DEFAULT);

I think this is not an actionable error.
Maybe use the default just silently?


Olaf

--Sig_/64GBwXXANp4OImnPC0816Nn
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmhjw1QACgkQ86SN7mm1
DoBixQ/+K8zbmVa+J9bZMhBJj3QtmssG4V4Q7YSkABrg4T0rJnTBWn2P6JA91LFi
3yw1LgT8V7ZiC6FWDk/0GODs3N2qlf01+aZbracP6RcYUa7rISfRkDmc5a3xlPuu
Hj0FgQ49o4Hg2523KBqWLnGiS6cMcrOGExTsEdaTiu7pmUW1SPCJfCn9tWm8LxeI
OMrh9TobF5LTrQXNB15eCbQjrBngoceKv2fIJ37RTRRWChHCUo0obLKmNbpOK/cC
Ytr23xe0zKW/WhqAnoYpAyqoBXEOTTsBXm5qT9fxd40szusdOnMj7pONtsIdEMrg
YJYxLu/X3eSFOyLzaXQSrLvFxTjpC287X7QEYEQb9KzjmYc3z3HA4sa0VHTzcsQD
7TYtwN2LGiX0TKc8ofPaTTdSc9w2bt/xbx6z2gEjgTO48MSPk939O268BtXSlzf5
lWBZKW6GweTh8yrwcHUhESJt7k5cEzPixhNLwBflEKGxwTku9plANisbLD1xOvBS
8HGZyS+BmLNaiu52GnOzFa8BqlbAkFsaYeW58MovMz49rJZtBbUhPvOZ64yZxIlC
JLqHHF1kBPB0mK5Ox9p0pdc1fNExLimOfIqVkvehEJj2r47cypMUtBc1m/qygfhX
jZa2ptE23oIxMZQHdaxEuMqUXn66TYB0NpRv3DyEzAhv+47Reb8=
=E6cr
-----END PGP SIGNATURE-----

--Sig_/64GBwXXANp4OImnPC0816Nn--

