Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAE286F1C
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Oct 2020 09:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJHHTC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Oct 2020 03:19:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:19148 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJHHTC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Oct 2020 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602141540;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Z+n3AY33dhZpyf9B3oZ5nlhFzBDQUR+iBwatVYu9Trc=;
        b=lDIOjyLKg014fDD5m9WFZP8FdBERHc0pPOtUMfaVpc/3nqOJbkEH4FfnEZoAfL+e+0
        S5SWCDlrjptRL7qLaN0bM+6rM8p1p/wGdMriYBcFRz7ZcYAU37kufZ9SoJphMYeQ/yKi
        cbO6Pn7JfDCN3EN643GaFs6axTxdSh4ef2NvI4TyXPgPNs2rNmlnAO1VdPlWfvp1ajqj
        l2K4WZOegAN2bteCHd0CNXsx4NBDXkw4e/3VJ+D19dFizE5Q6vjUQuZD4+43nEe/z0nU
        TFL7ldBJ59roGnaIzCb92ap6h1gCV9IbQD9n1rnzXjXSOcGfY4xMOzmQTcXMv+zOgWX5
        8jlA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTW+n+/A=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id e003b5w987FrP2K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 8 Oct 2020 09:15:53 +0200 (CEST)
Date:   Thu, 8 Oct 2020 09:15:39 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201008091539.060c79c3.olaf@aepfle.de>
In-Reply-To: <20201008071216.16554-1-olaf@aepfle.de>
References: <20201008071216.16554-1-olaf@aepfle.de>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AR4/U/CcDsqOR7cE50tlqh3"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/AR4/U/CcDsqOR7cE50tlqh3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu,  8 Oct 2020 09:12:15 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> warning is logged in dmesg

Actually it is logged on the system console, depending on how logging is co=
nfigured.


Olaf

--Sig_/AR4/U/CcDsqOR7cE50tlqh3
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl9+vJsACgkQ86SN7mm1
DoC45Q//Uk2BW8kBogrqZCAgZCenmgqv3xINZVNsjSJYhmlgyyScq8ra9IPCgMP0
ssS+ESxHLYfmCj1BNjiwSf0KfJpQ9oOvfTYU3CO+OqBT/ZHqbXmmQh+gYUB24ZU/
HOQZliNnZFE3lmgLzt6wur1pVcZdIXAIobj2LokCj5+SAUzS+1KFVpPzfLRdZfSr
zfs0uWh3ExjsQ9+kSfg26wlg1bmXJt0Krm21EIGAVWm84jxxWa/ygT6EI0ryzHuy
2fMUlQiDZJF4Uo4uiyjm/LKi4qwYNFzfddTklTN4VG+vhIuBgOr79TJ1JiQ1Lfet
lbUWKKYUtthh6G1i0pMHsufJI9TvLm1Nt91YS/OxY/jEr8Ml5TPXv8lTTGWu17Hp
Fr4ZaMbN2CnasP31+ii53N8M8u8epLdHb/m/QvTo3W5f1s4KGL6epNf3T4lztM45
AHJcDa9Nqw7RWt/XhE362N3fy9qh6+8OIKd13WrFPcxrFMnGx1uwGeCTAp/FfYYM
G/PA9xmg64hrdEKraFKLf0QCzDfD34MDsfoalubSSsWWx2Y2poUOlWTbevUAooui
/TnufxMPZSddFA9iqCCfbzEoCKMlPXCEMHvh+dPQw1NJCrz66mxE4fcycaI9osGh
Icakb2I1eWPcfjHZOykJlgtjcONqxTyU82/buYvxnkwa4j66wOc=
=j0Sn
-----END PGP SIGNATURE-----

--Sig_/AR4/U/CcDsqOR7cE50tlqh3--
