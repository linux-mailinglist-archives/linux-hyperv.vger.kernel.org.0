Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989BEF7820
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2019 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKPzq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Nov 2019 10:55:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:35730 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfKKPzq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Nov 2019 10:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573487741;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KlOKFrmkDI7GV+1PiMIhjIPTlTpG431Vo+TeP0qxrh4=;
        b=fvhC8Ha13e/DGlAlPygAKBM37iFG2UQnQQmBid/y02/G38YJ5EzYMPrEgihKhKmFQU
        +MoKy8qIndiJDvjcCv7DF8iNjnZyr+MQNvVu4bVvnPUcaOIVzhKOiG8vxFRcKdKlBtpn
        CY4e5DRwMTLg0CD7PcTt327phVdwQ21mHYSAn0Z1xVZgZD3w2gvnaCiaejZU3aFQ7Rga
        raShURl6seU8OzC0TUIVPyDrWPjKPJnP0acqp+/vqkEITKBT6GzMjVnaKk5HClGaqaVk
        WQqdFNZaCXNKtHZl3V3C8uuLP7ROkNW1gjWpDinOfi/Yi0Jxjzbqs5SCEZR8cl2fMiww
        DTYQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id 20735bvABFtf4v9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 16:55:41 +0100 (CET)
Date:   Mon, 11 Nov 2019 16:55:21 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "open list:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191111165521.4a04398d.olaf@aepfle.de>
In-Reply-To: <20191102041856.GY1554@sasha-vm>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <20191028161754.GF1554@sasha-vm>
        <20191028184955.24dbb7d4.olaf@aepfle.de>
        <20191102041856.GY1554@sasha-vm>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xLcfgRcxe=vix.RenICTuWq"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/xLcfgRcxe=vix.RenICTuWq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Sat, 2 Nov 2019 00:18:56 -0400
schrieb Sasha Levin <sashal@kernel.org>:

> make[1]: Leaving directory '/home/sasha/linux/tools/hv'
> gcc -O2 -Wall -g -D_GNU_SOURCE -Iinclude -lpthread hv_kvp_daemon-in.o -o =
hv_kvp_daemon
> /usr/bin/ld: hv_kvp_daemon-in.o: in function `kvp_obtain_domain_name':
> /home/sasha/linux/tools/hv/hv_kvp_daemon.c:1372: undefined reference to `=
pthread_create'
> /usr/bin/ld: /home/sasha/linux/tools/hv/hv_kvp_daemon.c:1377: undefined r=
eference to `pthread_detach'

Is perhaps '-pthread' instead of -lpthread' required, as indicated by pthre=
ad_create(3)?
Not sure why it happens to work for me. But I will make this change for the=
 upcoming v2.

Olaf

--Sig_/xLcfgRcxe=vix.RenICTuWq
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3JhGkACgkQ86SN7mm1
DoATPBAAoVPRJdhxD1eU6WleNhWl1GY6MY6PrcuMrd/+L9vs0s/a/nendf+mSF8v
XAqBGsfD7RL5T78yD7gdDQ1azrkWeucM5HW2xHiyWKFXfLDiG1Wm8CBdBNm82k18
gRnb+EgVobESBzSeGu8Qw66xDtBcg4EiBJF9Ns82dIPuaHuo6O4lCvp003sCEwnI
hg8Tlf14dvYAuPO/aQmoMtiiz9dKsh2wfmt5fc/dAqoaYgAtLDPwA+BJR5VdSjTW
DcJUuKjc4PWwJPnuO0IwOfwcAXiuZd594EySWfGIAHM67MI1UwxBxgH0FcwzdMuf
o/TjjLublwPf02DIvb2JfBx0ABtV8fqx5Qp/ddf5wPzmBDycDOQUJ98emkuLHpUU
3AsB76BT6cRWS+cKe+LKqdH2mp6tVlv1VjYsPi3pP9n77Ffl4uCvctMA6pjdOah6
Q717Ay3/ECDhyVVPfijuFJqPv4Zhqrw0SFywHBMWghfOnZl5MxqjcAxwqLCt2+7R
HgfzlQVObJNCbxCCUxURcS9ufCebqtTMZ7FXap0xRxBc8lZXFJSEQsp0KNNMM2W8
EBSm6JLRcM8rc2rYGM2c4g+jVcuEXD5M9LGi5E6o58IEy0gFM8rjSldDyd7ZJ8Jm
U0eOb97z9sneiOvGr38KWSEQBmi9hSoRS11bWHHNJaRdnU8AdwA=
=uCTS
-----END PGP SIGNATURE-----

--Sig_/xLcfgRcxe=vix.RenICTuWq--
