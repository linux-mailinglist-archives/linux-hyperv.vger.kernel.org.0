Return-Path: <linux-hyperv+bounces-4816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6CA7F387
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 06:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C983ACD54
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 04:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B61B0F19;
	Tue,  8 Apr 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="cLzK2pwU";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="4jXtGW83"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549B198E91
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Apr 2025 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086265; cv=pass; b=U6BG2npuP960g+p+1DKhxDBzQHCVy7FUwzGdTqpBIPSRL5/UcqzqGkEyatQmCH70XGQNc1JvdmGvMMP0HmlQnprBQibN1P10yoGOtAKwORmb9xQ8Zyspm2vA0m69tAzrc4UDVTotOYtTGL/5mRGOfFTnBm8r2NVtAfMTvKN67Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086265; c=relaxed/simple;
	bh=w5RwJZ7m5XXuJp7EFh6fCENVkJaa5gkg0Z2MXXFHdvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrLEwRadNKtyYEVe4AK/QdCwQ9dM+m1ylf/p8uqx1Mxmt5lPLic6r9rQAGDhjWSEyBME+QLvdxbkjIysP/INsT9a7+yFzMZSPRpHrTagvzpdAincMb8oyiwYw44S+wygKsJ0CiqGpAuEolIUDGMdQsvPfRcTsT+M7pMIk55aAWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=cLzK2pwU; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=4jXtGW83; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744086073; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VXwPbrCsLTBHcAjXxycIhklXPk8uwnyWc5WDl8M8VA0e4CQcgeHZ4bliwqcpqTsOJS
    aMROFIIQ2cV5RsfAHxRJHGEV7YVqetA/5ZVFKZC/tZdZbzVZJ6BtcCrjQ4Khq57xuKSI
    YlDhfjr+5Ljvzisp3mUfPr/NEObIQDC80Xbk7TT+oevPPgJophn/8qGs+pUTkCTepvEl
    M2wnEbpab4IWzi++9MBhjlMR0pOz3vIC7AqSMNepalwBiAvsZr05P4pmuy1p+sbOEMI4
    qKFVsmVdmf/5Joy39uiSaebXzcnhyjsPsrsm/fLHtNUxysWEmVIuL/X2Uj8gr9b4986M
    1QXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744086073;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=crJkZ+qUuEJuaRsVavYmXqUmXjBavHJMVzb7XFS/MmI=;
    b=ISTINnUr8yPUq6JB0sMv/1oVkcr30RBIjtiAL6wiWHrvgg3mYi/lV1RF2fmdDGpvtm
    ZxuBFfKgbyI0rOSUdvuf+20ijCABXD2kYg7k3G68YDvwa5W+ogS6G9lw11dDXDaFLdPe
    URJB9KjJlby8qPhMrrWcCfKkt55kzJVw+854KzmZsC/0QQYbOvbeKbYp2OLsii7EZyFy
    fdiOZTiB0ekaT9KK0jeaoj646sqs0qZRetTMl4CLYRSiJL2XiGQ1xDqIMa3dHBao06Xz
    9WyMFKeNIESUjMqv+ZdYFGyeyzbiRsDC7ysfAbMUjF27Iwj1u5ft64wlsVW1t2rGX3w6
    G29Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744086073;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=crJkZ+qUuEJuaRsVavYmXqUmXjBavHJMVzb7XFS/MmI=;
    b=cLzK2pwUp80ov1x3ryv/LW8yGHKK6xeQ9/kHpB3/Myv3UBjxGMZXVhSGn5yZGpqFz0
    OLs9Rmgnhs4rvNEVIK9gGCRE9Ex2UqMHMRXy5rCSfMUd7SK9JGo0eN5ZPSs8LQOr5A8N
    R3SX/SWdTXo7t6xI3dCr+c2InXD9VwcnTZ55TzE37k4AyMQTJQlktKKC/pKjaCD4jGsN
    sT3MODv5zstNpNtYXOXrFfdEOOdZeHZxKY5unObrZ3vmWP8AI7tGjNiGUh7/z1uKwFHK
    RN9fKsRk4DGVlTt9rbTbmN990qJ+JwcPjuzCPSxH/a/3qPxyxr8cGL5+GmTRDPARqpjW
    azBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744086073;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=crJkZ+qUuEJuaRsVavYmXqUmXjBavHJMVzb7XFS/MmI=;
    b=4jXtGW834vPmoaXQ/NLy9aUVA7l2KJfle7f96HcwFCm74qXI7KR5WntHkNBX9PbDu9
    q78mVca3Fe5lCNzWn1Bw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd1384LCOkS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 06:21:12 +0200 (CEST)
Date: Tue, 8 Apr 2025 06:20:57 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: update route parsing in kvp daemon
Message-ID: <20250408062057.6f5812d3.olaf@aepfle.de>
In-Reply-To: <20241202102235.9701-1-olaf@aepfle.de>
References: <20241202102235.9701-1-olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QJapevxT==4ySCMrXSj.IiG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/QJapevxT==4ySCMrXSj.IiG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon,  2 Dec 2024 11:19:55 +0100 Olaf Hering <olaf@aepfle.de>:

> After recent changes in the VM network stack, the host fails to
> display the IP addresses of the VM. As a result the "IP Addresses"
> column in the "Networking" tab in the Windows Hyper-V Manager is
> empty.

Did anyone had time to address this issue?


Olaf


--Sig_/QJapevxT==4ySCMrXSj.IiG
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmf0pCkACgkQ86SN7mm1
DoACRA//cBXW7YJW5yuqs81dzunHGzzyvM5AbCHvhK7AAO2yNEiyjGM56kMmulyv
3JFwSKqKzsjnmn9pukCVy6wM5qABirwAoz1GG7f+5yt7uS41Kvge98DCRlCCxSaC
0zgMromn9iO7Ho/5kJNHMOCymCiwjc3QDCIdkwj4K9rrg2kbI7CkcwX9YA71ADx+
TFmcB5PJacFDMgcKXZsn1ILsgdMH5LeOu28MV3WhMPiLQJwnw+LCBFcuI+gHBLjf
LKftZ/GHjFlNYWRcUQWsa7C+y2fsn0Z1W/lzu7QiP1WVI+4dezwMDyonqtn/5+wD
uMGfwGeHhm7NvCN/EpF/0B4e5Xdy2iU0c4Kz7Wg3uIwKZxjzQNCy5lXEK7TYdf0B
mPJQnyHbCkRX+2H7zYtlXddaK3TskNrF6hFb4Zt4Hcu6a+nNj3s2xlTflzI5k9C5
gFQ8i/P7QwB5Nicd5DjlKF4aMlCDAcBn8xzQjLmsG9ys7mVHHH8Fiw+Aksqb6t5E
Quxa7myVeB96Vp3N5Y//WonBRO9t+JwTBRFITvAlmV8KeDxw4PApxaVEoI/u6xD3
FHKZm88auJRMw1fvnNxewPAGd2qaHbwBlfu0N2CgChJWuX+IJ+wtBgamg8dgYUun
dWaiQllSo1+bQwtIAFY5bfazuRYMLNuEUTeQB6eftjq1AqVEqts=
=P8yw
-----END PGP SIGNATURE-----

--Sig_/QJapevxT==4ySCMrXSj.IiG--

