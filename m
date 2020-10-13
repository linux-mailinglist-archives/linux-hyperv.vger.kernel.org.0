Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041AE28CDBA
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Oct 2020 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgJMMCW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Oct 2020 08:02:22 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:10262 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgJMMCI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Oct 2020 08:02:08 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 08:02:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1602590525;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DB5nKPru7XVklO9ceTjFWRheKxqV87qvETnsV9UVBjU=;
        b=NifKg7y4N686D5kL2KSWZPopUbxvel+KJgeJH8QFRapfIPEdgjSQaH5GJcOfDn+lKW
        py/5iTkLlY67KLY7ZEID6x633jKYP8EthrgMCWJO2ePsSIYrWoNBwQHsHvdoc/RSqtsN
        hyn7j2dv8ryprgovKQ8rUSeEN6lvDMsqEGgRyrmp6Pls7OZuheub7F7qnXvpyee2zEWW
        aQdZK/Pyo8EqLUcqBjZ2o2TqVryiMJfsFRNlabuLmdo1pM32DZZAGjlhzmi+LOwhYzYH
        TJ1bwHM1WetSNyoJi6uxsVpqFgHQFIeyWhD1m9G81AVedCY+30KKBYYLq115IaKH8/Wc
        y5Zw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXmEVBDI4vdCIAd4eCQfPA=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 47.2.1 SBL|AUTH)
        with ESMTPSA id e003b5w9DBu1j3P
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 13 Oct 2020 13:56:01 +0200 (CEST)
Date:   Tue, 13 Oct 2020 13:55:46 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201013135546.3c5b7feb.olaf@aepfle.de>
In-Reply-To: <20201013111921.2fa4608c.olaf@aepfle.de>
References: <20201008071216.16554-1-olaf@aepfle.de>
        <20201008091539.060c79c3.olaf@aepfle.de>
        <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
        <20201013111921.2fa4608c.olaf@aepfle.de>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/58I9z82b3mdGOqVUji+3aMv"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/58I9z82b3mdGOqVUji+3aMv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 13 Oct 2020 11:19:21 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> A message is generated every 5 minutes. Unclear why this remained unnotic=
ed since at least v5.3. I have added debug to my distro kernel to see what =
the involved variable values are. More info later today.

The actual values for avail_pages, num_pages and floor are shown below.
The VM has min 512M, startup 1024M. If I interpret it correctly, the host r=
equests to balloon down 83MB, while the VM has ~596MB assigned according to=
 the GUI. free still reports 878MB.

Olaf

[   66.917948] hv_balloon: Max. dynamic memory size: 2222 MB
[  331.839393] hv_balloon: Balloon request will be partially fulfilled. (65=
875 32768 54728) Balloon floor reached.
[  331.847451] hv_balloon: Balloon request will be partially fulfilled. (54=
745 21621 54728) Balloon floor reached.
[  331.848480] hv_balloon: Balloon request will be partially fulfilled. (54=
745 21604 54728) Balloon floor reached.
[  331.849465] hv_balloon: Balloon request will be partially fulfilled. (54=
745 21587 54728) Balloon floor reached.
[  331.850463] hv_balloon: Balloon request will be partially fulfilled. (54=
745 21570 54728) Balloon floor reached.
[  331.851393] hv_balloon: Balloon request will be partially fulfilled. (54=
682 21553 54728) Balloon floor reached.
[  631.814538] hv_balloon: Balloon request will be partially fulfilled. (54=
801 21553 54728) Balloon floor reached.
[  631.819084] hv_balloon: Balloon request will be partially fulfilled. (54=
801 21480 54728) Balloon floor reached.
[  631.823487] hv_balloon: Balloon request will be partially fulfilled. (54=
738 21407 54728) Balloon floor reached.
[  631.825832] hv_balloon: Balloon request will be partially fulfilled. (54=
738 21397 54728) Balloon floor reached.
[  631.827988] hv_balloon: Balloon request will be partially fulfilled. (54=
738 21387 54728) Balloon floor reached.
[  631.830111] hv_balloon: Balloon request will be partially fulfilled. (54=
738 21377 54728) Balloon floor reached.
[  931.814649] hv_balloon: Balloon request will be partially fulfilled. (54=
406 21367 54728) Balloon floor reached.
[ 1231.829087] hv_balloon: Balloon request will be partially fulfilled. (54=
408 21367 54728) Balloon floor reached.
[ 1531.859374] hv_balloon: Balloon request will be partially fulfilled. (54=
416 21367 54728) Balloon floor reached.
[ 1831.874813] hv_balloon: Balloon request will be partially fulfilled. (54=
408 21367 54728) Balloon floor reached.
[ 2131.878262] hv_balloon: Balloon request will be partially fulfilled. (54=
672 21367 54728) Balloon floor reached.
[ 2431.895144] hv_balloon: Balloon request will be partially fulfilled. (54=
532 21367 54728) Balloon floor reached.
[ 2731.916792] hv_balloon: Balloon request will be partially fulfilled. (54=
609 21367 54728) Balloon floor reached.
[ 3031.922862] hv_balloon: Balloon request will be partially fulfilled. (54=
597 21367 54728) Balloon floor reached.
[ 3331.949145] hv_balloon: Balloon request will be partially fulfilled. (54=
615 21367 54728) Balloon floor reached.
[ 3631.957564] hv_balloon: Balloon request will be partially fulfilled. (54=
540 21367 54728) Balloon floor reached.
[ 3931.969477] hv_balloon: Balloon request will be partially fulfilled. (53=
057 21367 54728) Balloon floor reached.

--Sig_/58I9z82b3mdGOqVUji+3aMv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+FlcIACgkQ86SN7mm1
DoCaUxAAkbDbD842M0QWng9KwNyveXgyjfC4xKISgJr4rU/6uu+/eSGdWnyYE+g7
XTzB62kJ6waDqloDR+Qud0lJdzvnZVaqUjpMwkzpwgZipS+8JYH+49IBb2WymylC
P/QdTdggKgALCCw9G42Tenyhd/cuTEMvgziDb7CEOFQy8AQlX6/eIBwqlIls85jc
nK67jc6nkiwQ6gnbYn8MEdSeatscLFw5FgBjKGLX8EmIlHWdj4QPCxt3x5dQ316n
zgg/s3SbP5jeSKsYt5dl7i/CYdgaGQVuyEvNFeG1ZlcVH7ukmwFqRtqn5Kd94J+3
t/18pJ2GvD6DtANUWVubslV7yQOo0KU/WEfDFJ4A1ldqzF2ayOqVlnZ8x+w46H1E
67n08nI4yOJ6PznYsFJUTSKWIw11TDPZ6ciKczfj+jPzPt9sP+a6phN2DR0vUye3
vqU/d/sVyP4ECsyJtd63hI20Uq5an28TmfRD05GPEdF9cjg3hu6NpiG22r4LnbW2
w4+YqLgxEAzu698T1BxQ3yEqabzbXaI57bAKoynZsNCYkPJz6cCbfM+B50+NvNJU
h5Uewk5kkd2DYaRQEqHRiInMEWTV0dFH9nY4ULwpsGMug7OaGJJSL5AvwHK4gWQM
HI67kwZ0LDwb9dRxOYetzHPUrzeqKRK63nDTQzCS/2hfxAO5m88=
=3Bmh
-----END PGP SIGNATURE-----

--Sig_/58I9z82b3mdGOqVUji+3aMv--
