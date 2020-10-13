Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B328CAE2
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Oct 2020 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbgJMJTn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Oct 2020 05:19:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:26557 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbgJMJTn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 05:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602580779;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZtAeMDqbZpLa3zP7F3G23ADVxJP7A7hhBmjV6JexgB8=;
        b=BcvUNg+BLtiQU4kPfCgN7tzOWUdPWOHQ8hhuYB2eBw16NSDx8cadTaLKQ9Wi+X6NNT
        WU/5Yf6uu4H4u+pB5LmAd0+PZMn9V3aibTPCUNuEvmMdekjJ4wn3lKN4sHBE0UbY4r8C
        0qQ56H351Gm6LZW0sRguliEXtmEYZJ0mJhHc4GRDxascao75pTmczQIhWdBKKdl+uXHS
        z/sP/BggrjZmNsfbtFJYsejvYR9+qVosSN+Qj/x/MT6VJ632wVubhZJGz5w6c/E3kYl6
        2OgWt0Y2L5AFSOoXCW8HZSidqv+Q0nht4UDyoPx2sJuPR3MO5PZrf7BMTUSPt/2XY9Ck
        i1ug==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXmEVBDI4vdCIAd4eCQfPA=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 47.2.1 SBL|AUTH)
        with ESMTPSA id e003b5w9D9JViAp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 13 Oct 2020 11:19:31 +0200 (CEST)
Date:   Tue, 13 Oct 2020 11:19:21 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201013111921.2fa4608c.olaf@aepfle.de>
In-Reply-To: <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
References: <20201008071216.16554-1-olaf@aepfle.de>
        <20201008091539.060c79c3.olaf@aepfle.de>
        <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GjANj41aXE9=73fqIqVTbCp"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/GjANj41aXE9=73fqIqVTbCp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 13 Oct 2020 09:17:17 +0000
schrieb Wei Liu <wei.liu@kernel.org>:

> So ... this patch is not needed anymore?

Why? A message is generated every 5 minutes. Unclear why this remained unno=
ticed since at least v5.3. I have added debug to my distro kernel to see wh=
at the involved variable values are. More info later today.

Olaf

--Sig_/GjANj41aXE9=73fqIqVTbCp
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+FcRkACgkQ86SN7mm1
DoDYLxAAgY2+ORnYw0Ylmf/9bbZ0f2OE+Bb+dTzFcJC6DEd+tEY4duRKJxju0S+d
kVZETBS4BbtuhNdpK5tBCdMaoO9C4Px9qpewun4L90D4zUSukmzAFQa8/avmlS1R
ZBOrkJSURqRRalZQOVF3fvXnI+oQB1dTZvlB+OIja4CiFjNjvNTAQHb1CxkIt8Am
9PvciQoM/zOYDQ3UwGV32pbtw5tmNVmIwYHdLfxOoVVC6L+mY09QOPhxJYW18ss1
eQvW4u6SpH2EGMxjG3ImkfcqHZyvoEsn+SnAQQZDjo7hFZunHr6b9kQ9Stx+1wqi
YsQQMp4WBNTrRF33zRY/rZuAJBC3c8JvxrneCuPHF0850AnyNlk4DAgGB+v0vyAA
eP3hvZPwpGJwni9f8UGWKgwl1qniqQUcRA3FwDsIbatTZUwenE0IKkPtVtaiOdIV
V3P8Hgz0fWTlsE772B0H8W1+swNqmZHXCBWJ7AE5jgSJf73+OUE4bUi6QK5W5xnO
BvcJ0Tc2TEW0bgn3KpRtd+yXkwfkIBKANO1LF2LEIzuDm5+6rZJb5VXsydW/IUm7
l8Pl32TvNHQiTt++NsUUZte6/jxkuLy7tpZFcySbaZvRKCdiKPEXmVcVyfR2ioph
FjsGbAxaB780gk1J/Jb41Kc3yQ/xRGHz/HZnEd6jKdCcUoxOjVI=
=MMNn
-----END PGP SIGNATURE-----

--Sig_/GjANj41aXE9=73fqIqVTbCp--
