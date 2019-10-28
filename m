Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A17E77E8
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2019 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfJ1R4J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Oct 2019 13:56:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:11954 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbfJ1R4J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Oct 2019 13:56:09 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 13:56:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572285367;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=O1Y3cHLchpCrbqj8e6xjlT/zTElzb7HM0YYVa7PBPnQ=;
        b=PcVqPg+GPcG7+B6KA4OGjbngaVWjXIMoQG9EeQs2wasC8wDH+Lm7MPTMpbq+kR9dIE
        AozAsUIDDFf/80hpJOCbh3Hl3VUb+OY3/Nr1QEWgYnSaLQYRpRIPO0gYr/IXJodiYVnu
        OHncsi6lPLj8CBq0PjjomJL3Az/lQEiTLw1v9uCcr5c1aIBMQDlfNt1g8ULexjI0sT3x
        vcdFxf0ExYeldcEiULADyr/xSvqI4zhd2iZ/aO/2rhgi4kuQmk8iuV8Y0mDd7Z/Rw9H8
        mxKVo+JhSIhpc+NcuO5ZTHOli1Nr00J7/jK0yAAi8triGrIFhNgdbGG+hTs1OUGqd1nE
        Aa+A==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYM9i8w=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.28.1 SBL|AUTH)
        with ESMTPSA id e01a77v9SHo6tns
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 28 Oct 2019 18:50:06 +0100 (CET)
Date:   Mon, 28 Oct 2019 18:49:55 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191028184955.24dbb7d4.olaf@aepfle.de>
In-Reply-To: <20191028161754.GF1554@sasha-vm>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <20191028161754.GF1554@sasha-vm>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IuoZQOlE/DrovulyPpUOb_M"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/IuoZQOlE/DrovulyPpUOb_M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 28 Oct 2019 12:17:54 -0400
schrieb Sasha Levin <sashal@kernel.org>:

> undefined reference to `pthread_create'

Does "make V=3D1 -C tools/hv" work for you?
This is what I use.

Olaf

--Sig_/IuoZQOlE/DrovulyPpUOb_M
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl23KkMACgkQ86SN7mm1
DoCRWQ/+LG5xpg4eIZaIs/EnRBJawuXuQ1KF4Uz20eoKmJkSXAvwSG0SF7CmgrHV
OPnIugF9R02hFD686YOLSZJDqsCs5s+GHRMLMorRQOfBgXZlnbA7WL4Kj4T9EyiW
q+yRzGefuekOAn/shc+ARHVCmhOglL/Uq/Cu/H7V7rGSNBLuc1JAHY2jQsasg+ds
1YdVMWl3vVcZOP9X/JgBjC4DPXryer8MkAg8A01vV6NPGe2GJbm98mJOZBvUg7aO
0QtRG+rR+c3mJelE9XWLrl+AT7Rl38H0x6qqMGxOUIrFfQBBlcgB9hA/DuxZXTN4
eEDHRQbvCdLlBJ/+WHM4qxTU6ZaSkVpdQWPf+EpsoTHaQpRNYStD6LKh4+AWtKrW
mTvZQvmt7qaGvPVX0hwDHlC8HwP0CJhNpBPCM6svozAyukfYrSKwxajV2Mvrul3D
CXz4zWOk9qjYrjZKJecI93M3PekMoHbtN6AO7aTZKLBgtruGD5qf64bzpvb6cWUn
7rsytsn5JfUY8PjRcDDDlpgqki5VE4YCQKRsOHyACjdtoXRVAltqTPSfhsmqU5MT
eLQeyBLbMvGKxII83A8dLoU6FxdWAmsq1Yd7NtCKvSbLhPESnmbHb8dfFyvJtAmR
062L5egcECYBkLgcwMZ06d1qXxrp8I0t2MDv9qu2xFFQjkT9Jp8=
=lVDa
-----END PGP SIGNATURE-----

--Sig_/IuoZQOlE/DrovulyPpUOb_M--
