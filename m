Return-Path: <linux-hyperv+bounces-5889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B81AD775D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 18:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C41891C64
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6F1A8F79;
	Thu, 12 Jun 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="C9VUNhos";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="a1/eMsGN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B727144B
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Jun 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743671; cv=pass; b=EGpSatbZy8oTh4m9qyeYVV2w8o5ySNtqL0MSGsIgOjSSeouap9Ypv0ICYvP/dHSJ8qoQKFASgUUtkL7k5wE7JWBzpodMneQah+N2PdY4lzcvtvWtF1756pU9X/5oBc+AfcK1vLT3HkTuKTfxQIJFceJag6b3+3QdsCItd8kMKDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743671; c=relaxed/simple;
	bh=7Nlg84WHwJgJnpPFzxqfu3W87BGgKlCFcn5OCVFMXxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ci5YtyF7fFhVpWtobLbMOPbhz6Okl4gPg8NWpWaDYHnecJUvQ9yKQzKmNLAJVodmEecEdyPyykVWsqJ7wH+7/285Nk2RVdsoFtW810GajkEnH2r/krdYAtMRnB57r5AQ3ovWPMxsSriYsTHr/5J2Hjr47Pc56oza3kBJKnJjhPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=C9VUNhos; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=a1/eMsGN; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1749743656; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bovAuyK5Je2QLvtzFORhbLzTdE8/tJlu/tj9AUiNcupHrrn6/y0YF6S1tHDDQ2wiU8
    m/t5PMYzOTPNAqa3efltBy5twyc9ATwKx1D/DSo4vvvw3vPwep4F0TWEbIR5p2QSbUwF
    /motlzV+1r9JKMx5mrudEiW4YASCxMKaiNaVQW4Y3jgqKsW6ALU7NDP+bf7YK3o7K8Wi
    xFXcDFyZ0ZY16gcPzleSNRhOYB545h1LHbXGWCKuArUryMdo+1GNAizvibAUbno3Ut2d
    TdGakFtEOcjRMSAbZqMdLvK8LwjKVjNfCSZODqufGoUD4FpGCRd3cXinSqGyVUuZyXrg
    AQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749743656;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=mRp2xRCABkQqy3JfZR2A2FiBfA5bwd4N2p9eE8hlvSE=;
    b=GeQhf4Ug/YMouMey1djukKhzS+RGibRQO+oZhBryeoCo3bylGiJhkycr2kryVNcuds
    s2z3m7pePzjxuHvTzjBov8iMx4oiP0OmPnEf4bwQB8n2QLet/hCU1M9j6wL6I9zlxjpZ
    jDz61Kgmqu9+9zPa808C/Ayd1ZDPEM/A/qKh/rM+gKECrK8vQPdzA73xBsfY+LPogaRB
    rd4IijxcdH94MutJg22847j6e601+tdl2VPv3mpUFPwHFPfftLpkQJjGPzsObUC3e1MU
    GmLlW4ZLOMHtGFILM3pIJG6rlAcqy1RanBdtu9GVkQbHB3bZCxEJX/NJV7bpo2gEVpkF
    Rmdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749743656;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=mRp2xRCABkQqy3JfZR2A2FiBfA5bwd4N2p9eE8hlvSE=;
    b=C9VUNhosF0nbRVJXBzBd3G7fH9KdTLTdXQQSoHu+IshgF9S3iV01lTq2dQP29kBr3p
    Z+dRZ7IbegJj0mtPPRqc3FCFXxc69dnp3EElx0xJmtmJqbBb2p3f3loSqk6Kn82H2AXq
    IXrJCHQBIgS3676HBaUgziw1L7doKhSYNXBgJNj+B+Ue/Ww1T/n40gukr7UTNQLJrq1n
    d5qI0kMJjuscBUh9j0DkUTVwWi2b4llFRz+NdcUOz91yU5DEdVP2v2h/2r5l7k+t/oiC
    BiRcYK7biH+JsTmEc+LE4h0pldAMYcAzGsjUxslETtdSobBdDprvKNXVN2C8McOYVemr
    zfOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749743656;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=mRp2xRCABkQqy3JfZR2A2FiBfA5bwd4N2p9eE8hlvSE=;
    b=a1/eMsGN4k2CAOrc58fckvAXSvRA51W4KcHp1MNqmXXHw7l/Stal/bglAaXS0+Bf5s
    DGCIh1rofdQTMpcuJfBA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmzGoJ8rBK6cWAVfDMmnI2IZ8kj8s0jE6n+P5L1"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd15CFsFW8s
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 12 Jun 2025 17:54:15 +0200 (CEST)
Date: Thu, 12 Jun 2025 17:54:01 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Naman Jain <namjain@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Enable debug logs for
 hv_kvp_daemon
Message-ID: <20250612175318.3a794cf2.olaf@aepfle.de>
In-Reply-To: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SX8CYt=Y+L__R2XGsF6qkcc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/SX8CYt=Y+L__R2XGsF6qkcc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 15 Apr 2025 04:19:38 -0700 Shradha Gupta <shradhagupta@linux.microsoft=
.com>:

>  static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
> +	if (debug)
> +		syslog(LOG_DEBUG, "%s: got a KVP: pool=3D%d key=3D%s val=3D%s",
> +		       __func__, pool, key, value);
> =20
>  	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
> -		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
> +		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
> +		syslog(LOG_ERR, "%s: Too long key or value: key=3D%s, val=3D%s",
> +		       __func__, key, value);
> +
> +		if (debug)
> +			syslog(LOG_DEBUG, "%s: Too long key or value: pool=3D%d, key=3D%s, va=
l=3D%s",
> +			       __func__, pool, key, value);
>  		return 1;
> +	}

I think this is logging three times in case of an error.
Maybe move the debug case after the size check, and change the LOG_ERR case=
 to show all details just once?


Olaf

--Sig_/SX8CYt=Y+L__R2XGsF6qkcc
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmhK+BkACgkQ86SN7mm1
DoAA3g/+KAWUGZu4tOY6pAMr9uHaGWbJkWR+HD6BW3bC22NJY3MWrnghkQk/6A6O
cCLevwYBSJGn4O+cF04S+rX7o8P+8rQKZ1nUxEKNvOwTnDvgV7YuP6+bfRHRYNhN
tEf30DjRy7EwdP0TsHd5HOc9bpqKBeuTv6ES4QsvaYU/a+rTeF54vM+BSFNBDkWR
i/y/T5JYD38cMEPosRYiJG7lYkI/T6qLt5XGUB5ugzBxfTvfIB0511t4U6RfSJuP
ml8VPp9gb3WD2mS9qcO0Pj29CQriAzOp1njzLa67kgMNPN/oQtUyJxqYvBzx4Z8P
eDdDy8lhUWC6Q06dS7ivM1RLJNlD55rfcZZOV9oua1r7YpB5KSBhXXrsgBBgxOk2
DdvCmXuAVFFPmUkQEWwjOmXFgNPnShC4vaa5FsuKxs8gDJ6dwgVx7NvwLZD3Oj9K
E5SbThMJ2TjzTSmGvRC4qy8mgmYLiLyxqyjSkpZq8D/C1zWIYeQdMF5FE6rZP4t8
3SLd+r1947L9mISoHkLL4tHOIk5wRuZyOpy59MtXjUmiBYYkuloizk6MQ6WyfCwo
UB0VqL6vWUB9CueBrCCJaWCy5BSn9hktQd1ko1UGLDv8qHuXwDynSFsGIrsCfmvU
qDKwncGLZVwSB9uH6T+6/8WrwZlcG119+KPFYO7sfIGwC9b8xao=
=K4Lx
-----END PGP SIGNATURE-----

--Sig_/SX8CYt=Y+L__R2XGsF6qkcc--

