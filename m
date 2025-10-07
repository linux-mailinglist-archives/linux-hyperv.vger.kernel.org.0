Return-Path: <linux-hyperv+bounces-7129-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D535BC005A
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D965234B63E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5B1A9FA3;
	Tue,  7 Oct 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsUbabb6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BF5CDF1
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Oct 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759803796; cv=none; b=uD0v3R9kALwXh6+PBZ+ukC/RzePgGlCet6sjxwjlhdLqoyA6FSTfV+v2W6HPF0a4cFxNmqFOGkB1RTtfJCKjrdXzd60L0rQU4hHr9VEAQMyle10OvqmjBleHafA1mZd/uohm1AxLPGrz3RyJibjSQ1p5M2u781XZiiL6p9cfDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759803796; c=relaxed/simple;
	bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbOywl/as7jALi5uGtvvbs9ofpkoW3edNc4aXfcJDrV1WCfjgwOR/rNA+ptTLh+DbAUnDPbSQxdihw1eFhd1eF9uKQ1UAx/FtG75RTRf4jmErHjPeKGEFpX4yHLI65GCgcHW6l4Od3d8vIe2MWIK1+qEbd5X1c+h/qbcxBWvrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsUbabb6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33255011eafso5685533a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Oct 2025 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759803795; x=1760408595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=dsUbabb6l06KJXGCdPtZiVMtWdwnBLSbSQsM1Rk5pumQuR/OkOgFCKVg4GQxwFDGMS
         mBWrQKCqrj0pK+6jFR6HWD52gXGSAgL2LOl6TDduNamn6NH8S18yyAaYDZlfizrvjU40
         1xSrp3nibSL+PF29vEbKn8tRaB6MQRLYzBXZaUZz1JKRwySPFYH3wOY1HAD/NOUrRXdc
         tpcpSns+N2l7Ky5dPi8MQldx1qpyQPsF1Aql9UOrjo8B6MIvnlIKSsQ36tKBuhNNvxms
         tV1r9M+Mh8Z4wY90kX54phHFNpUHHHKv9WPb2eSucGx312kuwHLTT/pBGA8a8q7p13g/
         OR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759803795; x=1760408595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=dxJRQrdzyxjWCHMGitaoTCRABvgoKwjPCAhljtNYTG51OZ6Btp7SrA+naKkV2Q9gTj
         oRIvW+ElGk9y3ccGeV//3Fykw6hpWbo2N/QQh7TN9qNvUXYeG8/p0yZ2HTi63wSngmiz
         FGoynE9xpp2rl4ZD+T80teXf3zCTl/wJu5Qc99M5KufYS//quxhXjDpWMqNe4I86nSfx
         Srh0I62rHLPAB1ea5RbLdCOxeYnmCIVxyca++GrdIzwAEDmuvv6z50bbCCb6ehy5W1BF
         HEfiUx+2vRQphzewVRm+W7oDtMNbnhP9FYgpJBUvw5oivbZs0hkttIzs1tnJdjewVrCi
         SnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiYOy1jO08jNvXwF6EDKPadbt+Rl9dlBPCtkr6hDkJ3fC4sTQM1CnASYfJjMuQYLycUoLMzDfWYB0WAkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0p4Jqg1K8KItwMKlrDrJTxa1Yf9ph9UU3a+U2RXY4L3E+/xkC
	eRdkZV0bqd3Y1NY8A8yV5lnxg/wLnoUwauQmH1KixLpDqHHDvYyz1WDv
X-Gm-Gg: ASbGnctQe6srvLmw0Kv6m9AQSFHzPrcVe93a1ShgjASxbztPwwby36/V9JJvEAsD8Im
	fU3eFFB9GtnOMI8yK1pmJRZfkXcWRKqSuNUCeIXUHMN6UEYodnWH1jW+/TT4xFNR5u/c80zdTf5
	6aW/a1QKd5f1znSUjFrOsgLRgWjVXI4AemuDHD+t4qN4Mh8F1htzRBAwBGImErPRFPXSjjYLC0O
	gLgD/m/0noRn5DlNDRW7GsW+zLSuOnUGZf3z3yiwsxcA86HdgJPNHPkHWDcBXDuppF/jg1HCwd9
	eqS/IAnVIQEJNgDuFZ2u8Q/ULMy3ymfs2cGbjvOvBx7n3o20f5dTuQC1wMR7YF/jBexnyWaWIb7
	Dx37enoPE5Uf71LPaAMfIbEWiR9NC4x3CQh5ROk2hiP+4I/jwJg==
X-Google-Smtp-Source: AGHT+IFOWjODpkm0RXk0UNQxPxlDwgwSSLwVcoAanx1LQC/FF/GVJT5hQh4wQ4RD5szE0at/zJ+BUA==
X-Received: by 2002:a17:90b:4a84:b0:32b:ab04:291e with SMTP id 98e67ed59e1d1-339c279971dmr17239314a91.25.1759803794482;
        Mon, 06 Oct 2025 19:23:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff26f8sm18166635a91.13.2025.10.06.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:23:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8DC154233432; Tue, 07 Oct 2025 09:23:10 +0700 (WIB)
Date: Tue, 7 Oct 2025 09:23:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
	corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aOR5juzHnsK2E40z@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BxWMTnibnAgGT5v9"
Content-Disposition: inline
In-Reply-To: <20251003222710.6257-2-romank@linux.microsoft.com>


--BxWMTnibnAgGT5v9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> +The data is transferred directly between the VM and a vPCI device (a.k.a.
> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VT=
L2
> +and that supports encrypted memory. In such a case, neither the host par=
tition

Nit: You can also write the cross-reference simply as vpci.rst.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BxWMTnibnAgGT5v9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOR5fQAKCRD2uYlJVVFO
o7mVAP9gyGXv/aQVGaS5iH1wf6rUETBzEy69Mg8TYKRf5l2JsQEA5cnv0cPiT81i
pUA3Vos9PED8kntZHhKYkra64woP1wo=
=xXE5
-----END PGP SIGNATURE-----

--BxWMTnibnAgGT5v9--

