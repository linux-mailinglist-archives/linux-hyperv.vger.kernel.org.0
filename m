Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21041B950
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbhI1VfD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 17:35:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13334 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhI1VfC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 17:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1632864430;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FtDPVWexU4xJe/tAusBJYNUP4c4isrVjBItMQMHTHjE=;
    b=Aq5hll2aoIvcbuzHXu4aPnciNtTYLsjKd9l9MdUrOzf/sAUhVNT+wqAQe7H4yhmJOD
    OADOLdelhMMiUZ6aQbern/lOho7G34klQJ870XtkP4Ty+l+sse/A45KLT4I9uYBm7oDB
    gzN/7M64mcr/fqsh/E5e8nmfk6y8l3ah3QVNbCrrC/WnCE2H+/q5Bk5P7dNuNFaAhuIV
    YmYsCgsXx0c/i89ymiRay76XbDqOzylHqTnaJw5y9SgEK8fALFPpIV0c0UoPQTZt6VqL
    VzBW5a0DWznAyaiLOZhnk2xA0e83QQchel8BAhByAoyLco+3BdO3A6Tv82ScGTwx3vKv
    mErQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisEoBx6KYk3sDSS2ECuxRNydJqDgTcTmRadqe62a"
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id j06d2fx8SLR9XXj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Sep 2021 23:27:09 +0200 (CEST)
Date:   Tue, 28 Sep 2021 23:27:02 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: Re: [PATCH v3 08/19] drivers/hv: map and unmap guest memory
Message-ID: <20210928232702.700ef605.olaf@aepfle.de>
In-Reply-To: <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
        <1632853875-20261-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: Claws Mail 2021.09.26 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 28 Sep 2021 11:31:04 -0700
schrieb Nuno Das Neves <nunodasneves@linux.microsoft.com>:

> +++ b/include/asm-generic/hyperv-tlfs.h
> -#define HV_HYP_PAGE_SHIFT      12
> +#define HV_HYP_PAGE_SHIFT		12

I think in case this change is really required, it should be in a separate =
patch.


Olaf

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmFTiKYACgkQ86SN7mm1
DoCzPg/7BzqGmQge0FXBboVIFiF8AO30AipTW+49jct6hzfqEbECZxBGXnh21tVc
yWlyPotEtV7FlldrW1DNvNuzMv/0/4H6KYvSt68YudzetG9KBHOJIF/JnIKPCRc2
wcHTRWQe9r6FJGJF0dVwByvzdLD1BUvPPEM39STys69Y+Nq3z3cnk1q7qPBp4rSA
QQaSwRCdle5CoHmHvg1Ipc7uqIA+L7ySqec0oq55v6QzbSwZKql5j79sCY/c/53U
aONAs/pBDG6Q8FRBu+U1s5sBcDmWKVDQ0QHeCIH45X2bUgNa7EHwVDpnQN0UH9AO
KHe3jEPQDTh41CE34Va47lz6X/OcBIrjmUt/r/Njxif86i4beBGGbrjzDLx61anY
nnsvnd6z3olZLiSzoboyPoKTl/4WwdYZoXlnCxfCmaHujECFVNhc3A3PA58PLhh0
xy4CCcmYJiuaQnVIbuQcmn4+1huWDkNdDPrrEVLK1BdjL/Ru/SP3PWDxm97tz0wv
uPyW/tB3ErB3Edh7UyhNPaUTJLZy0rwcxx2P5DQ+S5Mv1utnPcQeModuuTKHdLLM
TFLWRJOXPitCS3+eKxORrB6/QUDn10VvYxn1tt+iVrHrSvf0qncTAa17e4ZbCGEh
s3Xp1BEegkzGWnOX5EV1I5msbm91AiSJoc/98TwyH0ViA+doYtM=
=RRvk
-----END PGP SIGNATURE-----

--Sig_/0hx3rtBWUJeEmmJ0OWqZ=2y--
