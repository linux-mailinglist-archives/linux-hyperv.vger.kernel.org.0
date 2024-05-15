Return-Path: <linux-hyperv+bounces-2125-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDD88C65FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB08F284916
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724E74C14;
	Wed, 15 May 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7QqoPiH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4174416;
	Wed, 15 May 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774172; cv=none; b=nVvFOsy9r4Pvb38Hmco78MXY9zcEeiD72JivDx+alIbeCzt8+eq/5ikE2f7LpATmLXH+3w+7pxhk+2CAJSnUszRVUS4k7NVAgDSv/qX7yXXcWSKf82HP9nAVA/JABCLexueXqKeXV4LqXi8pIBIf6rIDmSHcV5pYvdpmQsFKMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774172; c=relaxed/simple;
	bh=KLIJf6dyuUtjxVo29n46MFMN5nAM6CJEG8L1rIRFJXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpTm//1M7feMuxac8zDS6UnKEkh21MFKoH0YkFH0jfbgyBR5PO5UuUWEtDDUjni2UBlJxodxBGnLOEd438E/j3pz7M0DCaoyoVg7uGjSJT8rFmq2xCDixg7kCk/uWlpA+6QkUN2f1HGSthM1+S3bZiol74Bo7BmI7aFBGmoGBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7QqoPiH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f6765226d0so474851b3a.3;
        Wed, 15 May 2024 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715774170; x=1716378970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLIJf6dyuUtjxVo29n46MFMN5nAM6CJEG8L1rIRFJXc=;
        b=V7QqoPiH4mE1vYcxyxLYiYiRwbMO0AYPCg7QJQ1kcHOLWHnzdmCqyCCLw33MkpDh4b
         +MlPTg43EyXPO24Ff4B+xWJis7DGv7znPjU+ok9WV9E9eUYOPunuHCzzqAIYUfhHJ7WU
         IYHecI4GmoJ2N8Jy5mPSW+E7MTjsbaU1CUILbKZeMTzJWlTiAC2I1Y0HqIduxkrbB0wr
         Ah1+WTdam7dQFjvic/+zJj/uPiMZULewxbgprSg0Zd8m01jgpDVs//Iyljgm/4umKsID
         lyzqEVdAchXQiAIAl4NdAzFhajJSD2kfVwrJufRkbeP44BfoV4VUoaXpTR/rSskk4jEX
         XSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774170; x=1716378970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLIJf6dyuUtjxVo29n46MFMN5nAM6CJEG8L1rIRFJXc=;
        b=XFa026hChOWUEtHvHCs0kiqPgkte4rCeupjBRJ4gGFhgey0kJIu1fNDDKSB5qo03CY
         WsSWiviykY+Q60uBLZeQBfTnAaA0Y6I0th+OXFIy+8MlxN9daa6FVd5rphF8xcZx7e9X
         BUwGXoF79fl7pQsWIYar86b60D6FxsEnQ8b6SToMcDWrz6mMiUnvjlyuumXomoO7xN6+
         SlHMMwCCka6M0rIoBbuWxD5lrQnlIR8mZxI6r35P2Zs6V3YpH/R9J+eA+zcPsvkU25AB
         on6ILYD2K3F2Th/FTtlmOOu5OH8L8w4sAybV4qwYiU8E3HvvqqwOpUm2JoLZEY/Rx4Cr
         4U5w==
X-Forwarded-Encrypted: i=1; AJvYcCUI5TJMyxTSdRLFMJSfwj6rJSRjGd6pOewTGKMMr8/vF9K2k+hJjX8YPQkBu5EGJQM9jtuUm7KuJb4VbDfRC4ZRSlgSFOfRWjEcMTiSM9X9pHmWk9XIXUPXlvm+5qBhWnR9tBlMHUSFAxOJIkBcVuYKnzX+Tyt0pRfodqqBdfGnx3d88/zm
X-Gm-Message-State: AOJu0YzUFWZdMl6raZSkb6K+Y4kQogYJkg4owTpGJlhcgIm+7Zc1yiOE
	xmv/ghW3FV/Km4FGiVsOGlE1jAIognkptjCBtTqYY3qHNUw1zHKlWLSEgg==
X-Google-Smtp-Source: AGHT+IGbixuRdWw3hpUoH/eg1XmRvH8la1VlEm92zf5wZvmtJsIjySYZuMUHfsOOYQLyQZwHSeeW7A==
X-Received: by 2002:a05:6a20:5504:b0:1a9:da1f:1679 with SMTP id adf61e73a8af0-1afde0e20f6mr13397919637.34.1715774170370;
        Wed, 15 May 2024 04:56:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c95sm115677075ad.125.2024.05.15.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:56:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7272A19C325FD; Wed, 15 May 2024 18:56:07 +0700 (WIB)
Date: Wed, 15 May 2024 18:56:06 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>, LihaSika <lihasika@gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: hyperv: Update spelling and fix
 typo
Message-ID: <ZkSi1raEBdu7MdBE@archie.me>
References: <20240511133818.19649-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mYU1ClqV7Ho83G5"
Content-Disposition: inline
In-Reply-To: <20240511133818.19649-1-mhklinux@outlook.com>


--3mYU1ClqV7Ho83G5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 06:38:17AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> Update spelling from "VMbus" to "VMBus" to match Hyper-V product
> documentation. Also correct typo: "SNP-SEV" should be "SEV-SNP".
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3mYU1ClqV7Ho83G5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkSi0wAKCRD2uYlJVVFO
oxgoAQDmu6lTcbrHgqcQ1gt7KND0JsUN7RpkeyB7/6Ot0t2pwwD/d6Gvmzh1zJBg
7y20CyvYAA6LPQ7TrB9/ITaX0kci/AU=
=pwFL
-----END PGP SIGNATURE-----

--3mYU1ClqV7Ho83G5--

