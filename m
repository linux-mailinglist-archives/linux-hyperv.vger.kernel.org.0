Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E862922B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Oct 2020 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgJSG5A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Oct 2020 02:57:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:18867 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgJSG5A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Oct 2020 02:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603090618;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=60lTu+SIFl3Z+SiTLMIIM/Rscx77GBIuUnPDMFu+m7E=;
        b=Cx+dZ2VYyVYR7diTrB9Zg8Yb6xD2/7OOwycIAypQ0PVi88CLnCGDBsmDpXEcffuEd0
        npQf4VrCl+GcmdjVD0xENotfu31E/cf4sHE5TzJaZfTL1Y8Mjxkrsv8tQ3r3sQ5WoMq4
        SgjOmSQdwdG3qZpTIzdMq0RqTWsytf+51Rs0fnf3N8g6odX9b1aAYkXamw4S9bLsbR8n
        t+67PeMK2yzk0JnZ8iICA3068lUL5YV9LX1vtxkYUSrG1azejMABjzb8izx/RY74k3N2
        rA3LnFOY0fPWgAuzoh/Me6DhrEW/pMyaBvnSou9HQThCQVtce9jgkf4/3RMJ0IGIH1/v
        Q3Wg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTW+r+/A=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id e003b5w9J6uo5Yd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 19 Oct 2020 08:56:50 +0200 (CEST)
Date:   Mon, 19 Oct 2020 08:56:23 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201019085623.2cffe580.olaf@aepfle.de>
In-Reply-To: <MW2PR2101MB1052AAC9DE9A4829F53BB493D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201008071216.16554-1-olaf@aepfle.de>
        <20201008091539.060c79c3.olaf@aepfle.de>
        <20201013091717.q24ypswqgmednofr@liuwe-devbox-debian-v2>
        <20201013111921.2fa4608c.olaf@aepfle.de>
        <20201013094017.brwjdzoo2nxsaon5@liuwe-devbox-debian-v2>
        <MW2PR2101MB1052AAC9DE9A4829F53BB493D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y4jgRNWCKTwCArZ7R3N1v+c"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/Y4jgRNWCKTwCArZ7R3N1v+c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 19 Oct 2020 02:58:08 +0000
schrieb Michael Kelley <mikelley@microsoft.com>:

> I think we should take the patch.

Thanks. I just briefly looked at the code, did not understand much of it. B=
ut it feels like the math uses the wrong input. I think its is not the 'pr_=
warn' that needs changing, the 'Fixes' tag would also be incorrect because =
a 4.12+backports kernel does not show the warning.

Olaf

--Sig_/Y4jgRNWCKTwCArZ7R3N1v+c
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+NOJcACgkQ86SN7mm1
DoA7fQ/+Kc851egDG2Hbk6LNSAKP1wqNfVlvwa3LF9h5Z7hmVyQRgmsLN5OSXoVV
lx4uFLDO8YwIPdM0fCtBz/2CMx89FxGTG5jRXOdUSsntVQJLOOfzK4nJJvA9c2oM
beSOMngxEx4s9Ds4/UJhi6/DyLUKrTAkPWa/cyQF3e/cb6OnZ0oKsqR4N6ePnB/k
eVIIhiJ6IgFSOtSEMpVSLOl0qD+2fSlSmLGIEO2Jir/csDg8BbEQGxZY1xxOl/9y
hkib50Qe9RaXhjVV7SPWEQn9e7XKGozc6cyObya8AJy4kHQ3z7APdoKinFSOJo4D
DWdudheIM52ZpyK5B7gyaH1n4gA4T80rzCNtC8wwZt4PpINnCpxORAGKS5lF0Llu
80qPK6k9nEATqU+x0E8WCJBDWrLQHbaDlqq/+Z9RArQIri6WZDQauXmMayE3v9GN
EBlS8vMKhse0B2thgO23u5aemK5DW6skoEai6CVpv94NiCLrh+pax2CDr8qIwp1B
T3OGqmUgAydhax7b1k2o8uRWzRsAhhVOAwHd7oSvQ6Su1CuHMkWNe0k6UUdFV+Vx
6Zelz8RUrXrNmsm/qJWke+faauolkusxXHAr1YkvPzAQjm7dJDJO5npKWzD0zw/U
8+BK8voyUzaDTaJ/FyJ6cn7yG6znyhfnMooUK6XaOW5vYSs79OY=
=Cskk
-----END PGP SIGNATURE-----

--Sig_/Y4jgRNWCKTwCArZ7R3N1v+c--
