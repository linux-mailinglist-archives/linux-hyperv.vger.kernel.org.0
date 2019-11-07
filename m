Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7626DF307F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKGNwD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 08:52:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:9000 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbfKGNwD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 08:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573134721;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=xePb0EruLlu0nO5HtILqFKWXJ1QLBtzbkUwOSAhevVY=;
        b=NXjTJHsvHtbkJP3pxp/2rSK3PLCYBdnd7kDoMoPSiO4KsDJoHLWsVIH05nBd4GCqrE
        /Hs/McN9zb4OF81PXb8OOlgLGr7gGgkdKl5kXy22gIHKsrb0/xTqRCgmgvOjaicLcwK5
        u1KR8ThBsXDXwlWXGmX2Awpr073df7VIxcCck2vN3oyLeCsf66OOTdsmdS4tVpNAczjC
        maRn+obuPrcVQXWv3Wcv1rSwUWJKLxYoMdmqCbyC2myoN5FjiX/UrHdviy5PSUEcAFIG
        WNrnkiuomvaEeip0tfIdxK18e692OVUUpu9kW8oquqJChMACK3c/84sX8W/IOYHyThcT
        Gu6w==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id 20735bvA7DmxlOo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 14:48:59 +0100 (CET)
Date:   Thu, 7 Nov 2019 14:48:50 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191107144850.37587edb.olaf@aepfle.de>
In-Reply-To: <874kzfbybk.fsf@vitty.brq.redhat.com>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <874kzfbybk.fsf@vitty.brq.redhat.com>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TfRDKLn+ytyQpDe=3EHiVfq"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/TfRDKLn+ytyQpDe=3EHiVfq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 07 Nov 2019 14:39:11 +0100
schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:

> Olaf Hering <olaf@aepfle.de> writes:

> Is it only EAI_AGAIN or do you see any other return values which justify
> the retry? I'm afraid that in case of a e.g. non-existing hostname we'll
> be infinitely looping with EAI_FAIL.

I currently do not have a setup that reproduces the failure.
I think if this thread loops forever, so be it.

The report I have shows "getaddrinfo failed: 0xfffffffe Name or service not=
 known" on the host side.
And that went away within the VM once "networking was fixed", whatever this=
 means.
But hv_kvp_daemon would report the error string forever.

> > +	pthread_detach(t); =20
> I think this should be complemented with pthread_cancel/pthread_join
> before exiting main().

If the thread is detached, it is exactly that: detached. Why do you think t=
he main thread should wait for the detached thread?

Olaf

--Sig_/TfRDKLn+ytyQpDe=3EHiVfq
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3EIMIACgkQ86SN7mm1
DoDUzxAAoj3rIvo4UnuYA6gdsJXo/4gzx1ef87gMMUDuTYvUerULqG3HqC0PbzWg
T7nX3L8MqHDqTJ3NhZyIuicIqGub5HfwnzQDnTMS/1PIW/t0tkiVbFbnXyYaRx9B
wC8aJLxpaR6NT4XCqq1HMv1zF2fr329phf3kFOPRONGwRoh1ACgk8N9cVnK6Wakl
SCXWvXxaUtpt5I3A9UQUmQUSDDtv2+DrHiJctWfVZR2ZW2EVSeCNqMVJS4ZyF6Fo
WMPCnb/5zLlLYo204jlsdEB9ny/FgKrLhjQeuEO2Mt+qBXK//Rz79jRQLhKB1EpV
NrIpSgZ2PJAmnKRXVoKhqDo6CkPHmCbZFlWHGbmaRg9b5tQpY2cTiZI/4UgM8IIm
ogFuGEFAM7uWC+iPKgf/apAofMmNoL/8YHwThlgCptHZZotaZu/FdFHnUT1mYSY/
BsfFqhjjNKFkiy4J0GubudeCyKCyiIQ+aQ3inXDCJF3Mh2EbV4MMGIkzy9BqjCG3
pnmv5kcSXiuUv4r/KGBS0L+JD9D9cAQcF2arbs/YR4U20WbMQb+WHQmZgfKmjW9u
hLvAPIQSvkt6SJOVhqxUtC+YpuNp8gn+muX2SeTVFhIzYUhDwRUKdwGA/vcYeD+O
NT2FTV4m6T68jhRCWT1EcvAYztABDp8g9mhn2KJYvssbbstKIpk=
=A5vV
-----END PGP SIGNATURE-----

--Sig_/TfRDKLn+ytyQpDe=3EHiVfq--
