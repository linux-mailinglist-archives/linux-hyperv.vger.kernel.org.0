Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE80EC986
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Nov 2019 21:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfKAUU6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Nov 2019 16:20:58 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:36540 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKAUU6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Nov 2019 16:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572639656;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=XtCq+R5tcMt8CotAtaiQUQwbLgPqym0ayXNPvI8RUz4=;
        b=M8hV507crXnOYYFu/b4zx2tstn3fg7H1zRIuPFJ/fJM+lZJjSKQzHREBCpvdH+s9q6
        GRRpR/moawFvam2GRd19rbs4noXdmhRSG4+QGD39g1P69BaXcet9Q3pQK1TlBqSfvahT
        aJ4BlritT4Jlir3l1272pxCR/PFHxBOJtpPG2FsTqAsPHkb0gddqMGCJzrdbkz0GWPu4
        AkIXa9snsnAYTnkFHDTMXfAfqeF64nX51JsPsr7xtVNzIlt5WFFOsNT0bCGym6TEqzjC
        Y2pLQ9t2yRZd0/OXehqBpXbwXLEW1fxe7h23R8u0sNOT7GFFpCEehXOFn2S0fJYkjclM
        0e3w==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYM9nFg=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id 20735bvA1KHqHLo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 1 Nov 2019 21:17:52 +0100 (CET)
Date:   Fri, 1 Nov 2019 21:17:45 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191101211745.37dc5044.olaf@aepfle.de>
In-Reply-To: <20191028184955.24dbb7d4.olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <20191028161754.GF1554@sasha-vm>
        <20191028184955.24dbb7d4.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HtdrpGxa9p+iibwC0FBZ88M"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/HtdrpGxa9p+iibwC0FBZ88M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 28 Oct 2019 18:49:55 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> Am Mon, 28 Oct 2019 12:17:54 -0400
> schrieb Sasha Levin <sashal@kernel.org>:
> > undefined reference to `pthread_create' =20
> Does "make V=3D1 -C tools/hv" work for you?

Did you have a chance to check why the patch fails for you?


Olaf

--Sig_/HtdrpGxa9p+iibwC0FBZ88M
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl28kuoACgkQ86SN7mm1
DoBEAQ//W23SXKcJCdXPXpGBL3K6CrmsWiiVHoarCoQaK00IPvxwkMnUizXZPZLT
JFAad9nqT/ZxbYVxh6BfcIyKqSTP3ospBQISvIFCPODS36pBRN5UkmDQVvtUJDu5
MJPlUUi82uLQMjgvlBvDadrBhZ/m0HBhaiD5rpcQLrntljNtAs7T6+yioG0tJ8N2
xSR5iaD1Wo3tGZwbHhcpi//XRds6Wx6K+2UXCVKOrehlZCRhp4CowYmceyH3RtLH
p3gNXbC5plm5mgBeRTXYnsxvkqzfAxOu0sFwLZKhzsgA1AVRR/7+9oEmt1kMFe7w
EjvsLKahCE5tzgULZOuVVwhjCfQPXq6XRjMpud/WR5oS34znIZgmfVLeq2Ut0TeU
PzujNRSshx/rlnGtgmEHxEJdcQU9/CzPwCSqYAgDZVvYI6PhHmzZ87dwihsiupYn
6DZBfMilNdc1KN2QsLBCbv3D3mZd653tWKRcp+arNR5F8Vwx0iuUtxl7BDQCQcb/
+atsEY8kNYO7oYoyo9Ex/mMyLV7Ze9rEDCV3CfoJA/M+o6cC0BULJGt2r6QDx0s5
iiDxf9jbBK8X7gfmjn/fyL5I+PC6eYseW5D2/Q+1boELMfSjJAJxpMMgkQppE6Hr
sj4gm0+gZsNgbimDI9U+YRjM0ZFdyWKOUNpMX/dFfss2qTdAAck=
=lTlB
-----END PGP SIGNATURE-----

--Sig_/HtdrpGxa9p+iibwC0FBZ88M--
