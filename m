Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4D12F8E3
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2020 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgACNnz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Jan 2020 08:43:55 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:30089 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgACNnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Jan 2020 08:43:55 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 08:43:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578059033;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nLUaJbwi1ip35T9ouH4xnaMxz+OZ8pmUc8OdZQe4ZWI=;
        b=OHayZeimyMlBnFjXmNC2zck4TYc/A+tk7PW8/qtfx3Xx4YiqCop64095vgLfwvV+jQ
        8FpI42xBJAAHFZdciVXb0+Hq2iP1Bw6+96MA9D/87Y37XwAQ7YVc+es7gmTXvV81MtPy
        Y6cv/WcjUFGpn59npV7ggc2/btjh8z7yLMJBul4bWfBn9bm1/bGy0AZ2HMPhG9q6b5JZ
        Ef6rDBJ7MAnYHbb946dN+U4lmqfYvlE+HnnTb+njCCEeloENoiqoGKQ/W1AKHTkS/eYQ
        1SBExzzDWn8QKvliHqqZuK2gRNeY9ZUWrSTCn90Woeoa/Wy+GTWweGPW8GHTb9uLaHtf
        vceA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC44eztn93Z9OGdNZkAhh"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id D0b379w03DVmOY5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 3 Jan 2020 14:31:48 +0100 (CET)
Date:   Fri, 3 Jan 2020 14:31:33 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] tools/hv: async name resolution in kvp_daemon
Message-ID: <20200103143133.7168cff4.olaf@aepfle.de>
In-Reply-To: <20191113155400.25456-1-olaf@aepfle.de>
References: <20191113155400.25456-1-olaf@aepfle.de>
X-Mailer: Claws Mail 2019.12.16 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8KC0n9/zLPMhjeiBcAFvawH"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/8KC0n9/zLPMhjeiBcAFvawH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 13 Nov 2019 16:54:00 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> Adjust the code to resolve the current hostname in a separate thread.

Are you now finally able to compile the patch?
Did you find some documentation about the host-side API of the "FullyQualif=
iedDomainName" request?
Any further comments about the "aim for success" approach?


Thanks,
Olaf

--Sig_/8KC0n9/zLPMhjeiBcAFvawH
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4PQjUACgkQ86SN7mm1
DoDHlRAAkio4iY0zZA/e2HYJdbpsT6hBLoldQeIEP8szqHJRnb7ctsZcEkWPShqd
MO5Tgh3kECKjm8fqsXuU8oDWjMLU8Vwn5srgUauWcrQJpNF11dtOwX5DTmAyLE6v
g8xF/MEYXkhzyqKHK9hdddMPqCTffnKNQSuS2nA1jRUh6MzvbVH2Bklh21xYfSdh
Hbl1EXNpA/vnr6K4SFfVgf9aV49P21FPA+gq/AgRntVOSKFMTpqxsd8ox4gdgW7H
v+Di8AfMHFVnCHWCsRpWzLbHqK0CEnwXyE21VpuzPrygHMAW3gG+ZiFu/55/f/6P
mlKIDQe+QGYezGnL1+/inR186BMcA9CfiM8htCKTC/6Ea23AR+onuy/QjvAMqnKD
l1c+gt41l/TdhMGBPWHx6UeDQsj4WCwBAaryv0ARLLHr72IcEpKvML98/q/xAkYs
vce20VuI8yplYBck6EaLRQgf7s+GUHlsBTSAK6UKoFpvFKIUHmsLWkBKDOlwYfsR
9JV6RTthF/umFjdLaFsnvZPgzcJgDM9cWbxMZZm2trR4ovLhI+Tl/Exzai2mm4xA
6Y3rQfVchIaLEAQwHtXx124ioBmVm8p3BOZyvq0EE9V1CCJaMHC4a9+JR9eN7dWR
uQE5ZYCzHGTx2P1oQwpGEboyL5yKikiJOUyw2sEeF6zNcn1Wkq4=
=0Oyf
-----END PGP SIGNATURE-----

--Sig_/8KC0n9/zLPMhjeiBcAFvawH--
