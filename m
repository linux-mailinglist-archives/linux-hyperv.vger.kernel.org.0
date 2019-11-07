Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E12F313A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfKGOVI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 09:21:08 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:9181 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfKGOVH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 09:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573136465;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mjZP4Hd2SkSytHO0j/Ew9/golJ/SQ3thag40MTADCEw=;
        b=jR3331fXCb87c6ooEaA4pPdKktXoItpLW92xJ/HJrauWA5nDyPmtFsweqhJOPSekk/
        QbH8RrFAXjnvyyc4rpBUoi7GMbcYT8TdjQ9+dWWmVsQp6uI4r3+SuHpWqfw43YudGzXh
        UACYAzl8okvOK92TAN12Cv9KewHepFRl2PXNj5h4ktuYK3mrnJNSd/fSzrS85oj5GwIW
        8FZ63Du++Au7BR70LOiFxsVg74VPPvwIrXFBPoKT1ieY05fPzPR2ImBW+z66Vf/Z54sh
        mcjcrP9ocQuWzfZTXRNbryd9e75TM3Hz8Xq+Cs5GHe+KcXM6EI7TV9Z7U3oO9lq5vmGd
        TZpA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id 20735bvA7EL5lcw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 15:21:05 +0100 (CET)
Date:   Thu, 7 Nov 2019 15:20:59 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191107152059.6cae8f30.olaf@aepfle.de>
In-Reply-To: <87zhh7ai26.fsf@vitty.brq.redhat.com>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <874kzfbybk.fsf@vitty.brq.redhat.com>
        <20191107144850.37587edb.olaf@aepfle.de>
        <87zhh7ai26.fsf@vitty.brq.redhat.com>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=Fg_ayl37ghOOnhDjAm/6iM"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/=Fg_ayl37ghOOnhDjAm/6iM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 07 Nov 2019 15:15:45 +0100
schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:

> Looping forever with a permanent error is pretty unusual...

That might be true, but how would you detect a permanent error?
Just because the DNS server is gone for one hour does not mean it will be g=
one forever.

Olaf

--Sig_/=Fg_ayl37ghOOnhDjAm/6iM
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3EKEsACgkQ86SN7mm1
DoB3Fw/+IAfvWix2lZU25z3bgy89Uc9EpGECmxAExz33zhBE+ykXSRAemjan5A9r
bFijSJSovB00iCOfgOA0jAy5Rv/NUy/sC4S07pIQq5ESMBretC+wIi2eAzB/qIjO
A1at0OwntEMui1c6gBv3wbqDwb2/LBDOh3rCfrMHTEd9A/icDnVzA/bS1WtdtxYD
0FRslOjkcjst4O3WlQgK1NwrEPswft90vhaziJ6GZL47osOmm+xGvV+oWpuChSeL
3sm5yj9yLQ2fjHnRPApxNm44iN4aJCUOSWwviQjJajDdmx2Ra7+K7Wdz7lsbkYcm
+Rj1QT1H2fhS6aIdXjWi7wL9IPRnsNzxVTUpZSHPmrDRQHczbSbqoqkvCkgBIA9z
CxqbUu6YCx2zJsUxPdIHsJ1wpGw00lc8XZDLhxkdTbZe7PdtmGOvlZy+jnYIS/UB
3nLxLOMb6191Ep8DXDL/sY9Ek1F4sZifW9oq9p4S4ItasOA/A6p0Wv0T/tHP7bzj
lSoA7EKiQkHqd82eNhf4yH/cZ9uq0Qb2/7wGzYyXs1LQJvjcLR2tsW0mRNxffiKb
NiNdvPTmAzTtsj1PQmIthRI+dbCaWjZFaSlDtSnos85Kx1uxFKIxSIkmSuIpRl3C
UiMgO2/ASECYOmcLJSp2ABFRe4DETZYOxCaKyN4WiaaZJYxcoxE=
=C+B/
-----END PGP SIGNATURE-----

--Sig_/=Fg_ayl37ghOOnhDjAm/6iM--
