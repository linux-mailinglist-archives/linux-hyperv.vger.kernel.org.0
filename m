Return-Path: <linux-hyperv+bounces-2126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C58C6666
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EF31C22013
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203B74432;
	Wed, 15 May 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVxaogia"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FA482E9;
	Wed, 15 May 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715776591; cv=none; b=awFPdTcsViqxKseNVLb8nDqgfPKcLktLPk+tFanfFog+g5a3baeVm7eddAaQM+WnH2aLYDRnFFmZJRXNYbILyjZ+4tsC8olUOi/CCOhn1lfHqODakUzRw1LDpKh4ot1IvjWBumWafFxAgRcsb3bL6rzWiSnOnNiD/ia4Ux8xsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715776591; c=relaxed/simple;
	bh=cWhVo/kLDDvqijtRQESDCl3lSsOu9f46mfSThgnSdUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWA7ohwPNjGZIAH904/fIVtPAvy2jKWzeGFssCByJWCdFQkYZLNej77CLip6invgF8CvcJoeR9IVyneKwHsFeXinuHZjOaQsVrbu4w3saQq0Jl5+zrF3MVQCykwCWJRug+uYNHHLPQN+7rxRpGsqNL3y/Iup0mzFX1sVlB2hBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVxaogia; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee5235f5c9so52858075ad.2;
        Wed, 15 May 2024 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715776589; x=1716381389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWhVo/kLDDvqijtRQESDCl3lSsOu9f46mfSThgnSdUw=;
        b=nVxaogiaOmRTcyzz8qzZaH2v7MlF5JwJeZ++T7Y9Rd9drNtFDPdoL6nHIWwPTCunQI
         4hahKweGzA+uiIG0AxfT2pAlhNU5I9SDvJfGGRLX+/XnZbM+VJf0AyvmPxvsSp7G8WZ4
         Q0Pq7purDOteCkcTsXH1J+x08XFlqCx4cmAjxFHOoEvgYk0uWwR01xIGWdt0+FKVpxQ6
         /3XocSpqMOoDqey8OrHDOtpJivLCrAnlvON5yTo0Kx9KIIV17DdmE8shhyp79dsrf2Vf
         1fHP9n5hA3I3wkjKi8n5afMGlka2juVNgcuNEYPy+9ELl5/DGLjf+vKc2KYQnsJxxMyo
         BTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715776589; x=1716381389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWhVo/kLDDvqijtRQESDCl3lSsOu9f46mfSThgnSdUw=;
        b=ZWkB3EGw/5P2t9xBObal0mjJ/sC76mj9pdf/0ErwYB69ko/xRZJuI0azDW9CyA5wHX
         JGY6DtRYithB1BOrNTeI+p7G+TdlSXNz36IULTq5+NabpPn3JPvYgsd0lyOiVgtiFOkJ
         jx4a1wohl82PL0K7xlHoHklLhHS0HmQbgSQQBmmz3/+mjLD6DJLBpvXLCQV2oG6y/t6v
         R8/bTtez1xcgBBx+ZcqjKp1yEaYNmyTPyx36aIQjzGt27x/qZsG584xNgNVrR9Ylz4K5
         z3Y/X4IoXpXGbF2tVE7RC/vp3Lmegkegjw0InYKi3jcqUJRDezSllCqly4kRpkF6UG/R
         QT+w==
X-Forwarded-Encrypted: i=1; AJvYcCWpZ05alV78Pjim5/iCUYSDskIYx0hfNau6hln69cnq8RvlJU1UhxGZEl5uP010hj8HHVoKkL54oQ3tZ226vYEXYsg+5nt7kZq71UJh2ibyMhxVJkLSJfEiUDBMZU5lO2w/PHK+6eeFAKAEQwZB7uHLNkS9ZNVBvp+yYpdnyw39MN9eGcgo
X-Gm-Message-State: AOJu0YzkCs6VxuZgNn/e1W7bsj4y9QOfqoKyeP9Ki/smY3zqoVf2nmDP
	qjQyubDzpt3MRVr02GcX6qH87Zv6Ko5MR+SxNABZeCasaaU+p4pA
X-Google-Smtp-Source: AGHT+IFj/BQqZzSQ0Oocu1v+JDcwo10TzKjcB+jwGK9GGCEIAbaUbw7A1t1yhW4VtFtKw2TWxI4Ptg==
X-Received: by 2002:a17:903:1c8:b0:1eb:7981:28e8 with SMTP id d9443c01a7336-1ef43c0c94cmr186405245ad.7.1715776589112;
        Wed, 15 May 2024 05:36:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad7dc1sm117038395ad.89.2024.05.15.05.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:36:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2508319C325FD; Wed, 15 May 2024 19:36:26 +0700 (WIB)
Date: Wed, 15 May 2024 19:36:25 +0700
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
Subject: Re: [PATCH v2 2/2] Documentation: hyperv: Improve synic and
 interrupt handling description
Message-ID: <ZkSsSd4xUZkb5R2z@archie.me>
References: <20240511133818.19649-1-mhklinux@outlook.com>
 <20240511133818.19649-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvwbu0/nHWp+XFdt"
Content-Disposition: inline
In-Reply-To: <20240511133818.19649-2-mhklinux@outlook.com>


--vvwbu0/nHWp+XFdt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 06:38:18AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> Current documentation does not describe how Linux handles the synthetic
> interrupt controller (synic) that Hyper-V provides to guest VMs, nor how
> VMBus or timer interrupts are handled. Add text describing the synic and
> reorganize existing text to make this more clear.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--vvwbu0/nHWp+XFdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkSsRgAKCRD2uYlJVVFO
o9QfAQDCNVHEeRoHJWRzgq9pQzkyhszfHSHwtoeHXdQ42yppxgEAx5T83CYOa2/y
LMx7W1RUXaNm7kSUDkeLloMQSRzAfQ4=
=Rand
-----END PGP SIGNATURE-----

--vvwbu0/nHWp+XFdt--

