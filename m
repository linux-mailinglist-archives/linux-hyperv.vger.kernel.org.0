Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7334D53E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Mar 2021 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2QiX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Mar 2021 12:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhC2Qhz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Mar 2021 12:37:55 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A5C061574;
        Mon, 29 Mar 2021 09:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1617035846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kL3LkZkOr8saEjz13/Dt64M4xjwvU+y3HREcOaPNn7H4AypsJuq8xaG85rBBfysBH8
    0gS5hglfojx6OxLf1sIU5KDuMS95YVh196a7Hzo8vx2tKSJoRznPnRsRVh3T9h7O7nwq
    MTgas1vaCQWHMuFAJfptieq+WBas3rlqWU2wIhraKnWW+YIK1CyBuvr+PzdNVN9y6B4B
    Cs6V2YR2MVvw4+6zz2YJdaBPsSJg5iAvciVK+UjLa0NQHsXuNWiS0MU0W26Y0gZNvfU2
    y5lkvD/iRn9KiX02uJdY13nJ7XHFqzpE8txi3lAvsXi7QDtm86on47xgnEpxbMPDnDwR
    7m/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1617035846;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DoTVMU/GpjFnPo3eVvtwAXtiODdJ7fMM7tEyfQfAQPQ=;
    b=BThepzprP/g3y741mlaffeNn9INoFTuv1JWheb9eCJOlYA2EKJMRN0hmNVKR5ruG9I
    wGZEJJw1Hlske3k10Upodtklo5IiRjsfZjquyrpq4Vg8xHc2t5+ua3sGxqX97N+ozgGA
    47qfqvz9I40S/Rto3X2FgmL2INGYSQ3RRKY7qDU1+u7LkNUc+xTqL5m3b4scYaKS5kgs
    +bqtYG3hqIcMxRC4gyaTxgCnNNxG/LkCRFzVUgJkUP3zxwhcUd7Wwoezgc3YGaf8g0U+
    vqku9BW5UQFU1zeR+s2fY75usMoA6ZjK1ji/vFG4yd9YjfXtz4ejTDbf0c5Pv/dOxF9H
    zTRw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1617035846;
    s=strato-dkim-0002; d=aepfle.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DoTVMU/GpjFnPo3eVvtwAXtiODdJ7fMM7tEyfQfAQPQ=;
    b=nZsZ7Sq59pDmwJx9FLC+6xFv8SR+mhWBv9lbPwdT/8Oy0ulsVGlgSNMveSUx9x8GLn
    4aecGXOtC4SZAXm/xkMyfI+t0OgT5M/1AANK5LT6Ex/pS+6C8Rz9nDhmSKhusQoOMa8r
    +wPkuRRZKuVWHcsNYFC1JUQZkVFy2IMiopbhAhvkSYJu1byIQgEs4M+Og3z4wBPnUkBm
    8RBswwMCHNLQLrn4XSzhKfXnrcrE9HPQEoZnxWMMjX+6UiBnA8bUeHefJYIRngvNYEuu
    UhBHjJVCmKsIhr0w1LAXgVexk0e7Xa7m7f/peuNyimSpLdccYBId5i9KgRgRQoyYekLa
    Rwow==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS3GRNjw=="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
    by smtp.strato.de (RZmta 47.24.0 DYNA|AUTH)
    with ESMTPSA id w0692ax2TGbP02A
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 Mar 2021 18:37:25 +0200 (CEST)
Date:   Mon, 29 Mar 2021 18:37:21 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Message-ID: <YGICQc6HaYw8+uES@aepfle.de>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-4-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XkBehx7WaGRrHSaS"
Content-Disposition: inline
In-Reply-To: <20201217203321.4539-4-parri.andrea@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--XkBehx7WaGRrHSaS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Dec 17, Andrea Parri (Microsoft) wrote:

> Check that the packet is of the expected size at least, don't copy data
> past the packet.

> +		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> +				stor_device->vmscsi_size_delta) {
> +			dev_err(&device->device, "Invalid packet len\n");
> +			continue;
> +		}
> +

Sorry for being late:

It might be just cosmetic, but should this check be done prior the call to vmbus_request_addr()?


Unrelated: my copy of vmbus_request_addr() can return 0, which is apparently not handled by this loop in storvsc_on_channel_callback().


Olaf




--XkBehx7WaGRrHSaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmBiAjwACgkQ86SN7mm1
DoBdxQ//bfefYJeZmm7H6Sg7GPYzy1pdu9YvnfBhuEO5K7g1jZi5I1Tvk2DpJmDo
9dGh2I9Id1Jcp/vjq9Y/Ju/apMPeUExMWCIbgu7+O2DiJ/eeuEnywLEnoKvuP7uz
V0el8h2RM/dZj+e6TaWRkkPPIJDfJLCSMGQRbY96COkxb9a//i6StfjV/ql+OsEr
vzGLs7mWg46Se1n7ZuEfNtMdFPZFBygcFNuoZqgAuvK2kL69i8nHZWjHN76udTsO
gsjNhSQveRoYwhsit7tGECr9y31Ps8HR6qSyVmwVf14+XMaIF9BFvxYwoI4UPTUB
ed9cEJediC1DItcHai41i6Ggu3DZ3zawwhBP2z3DBDY8lgCnA39e6BqmYtvePgM2
+vsAm77UDn+K3q0GYdk+BCcMwGnxsf9z78Gt0EGKT0ZEYFRiMlaF1J/eSPRi4jOY
1Sm33qpV1abezDkoWxzos7B0fGRvpbNzsNXUYqa4sXg4kKtVHWU5hNktwt7RfFSx
fGD0JlOGe7m5jOY5lsYr2nmsSumjelZ7NuUF43U5IJp/uy5Gbnk5mjbannCGSHt5
2gMUfBhrp3bmyjafJPDlqu7P5xv3Oxx8Kf+aA2KG8RWH+PhfTYzysYc66JJbPTWG
DcQs/DTNgoHrlukzyRySx+7IZsHH+AVyZU5tFFBbk98zc5EGMVU=
=UXaL
-----END PGP SIGNATURE-----

--XkBehx7WaGRrHSaS--
