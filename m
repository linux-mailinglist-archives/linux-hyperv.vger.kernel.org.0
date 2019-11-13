Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA21FB47A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2019 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKMQAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Nov 2019 11:00:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:21085 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfKMQAb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Nov 2019 11:00:31 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 11:00:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573660828;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RdiTOqLL6TpP/1ppCJ5I+QMZbD8ieq03oQjLfF8v3IE=;
        b=qpKTYPbWoJBGYh5ZgJRyMhXNOUK+dtNGeSCY1KoBAamHnNPh7yMkg+2mo8uKOEv37r
        uvzEZ/BjHi+t89/SQc85xsjcxEvqLe5El5OPZs8aiXz8nrBFgSvAQcfXTSKZk2i50hrX
        OPu6hTDpS9C1r9wAuFR0XuQh9OgC8bvI1RUMO/1U6qluL7tVlXmXiwf3KpfTTUqfslSx
        1jB7+aXCXm3IuGloVL2kPl1w8I9Y42ukzIjYRM2A/Bv4zPGGWV+0tN3F1gxttXx1VUOo
        HDe+LSxsgFj0h9lyQxwjjZ6bPxDBPu9uXQO+8O4VyAI5vpDrDjG37pcoSCluvJ0DRrM+
        9p7Q==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuY8hl6Q=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id 20735bvADG0SGhN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 17:00:28 +0100 (CET)
Date:   Wed, 13 Nov 2019 17:00:21 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191113170021.2e98f1fb.olaf@aepfle.de>
In-Reply-To: <20191113155400.25456-1-olaf@aepfle.de>
References: <20191113155400.25456-1-olaf@aepfle.de>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3x08emajI3SN.tG200Ioafb"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/3x08emajI3SN.tG200Ioafb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 13 Nov 2019 16:54:00 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> During this time all "FullyQualifiedDomainName" requests will be
> answered with an empty string.

> +			strcpy(key_value, full_domain_name ? : "");
>  			strcpy(key_name, "FullyQualifiedDomainName");


KY, Haiyang, Stephen,

please check if the host side can actually handle such temporary, empty str=
ing.
If the tools cache the first result, the implemented approach can not work.
If that is indeed the case, is there some sort of -ERETRY in the protocol?


Olaf

--Sig_/3x08emajI3SN.tG200Ioafb
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3MKJUACgkQ86SN7mm1
DoDNUxAAj9Xsz8miILXi1nmy/CqbawpOYRBs2IxdOiPMHkxkqgyOvBd3KW5dJumq
0hHPjemJaBS2u90ijPpeLjxGkgjSHH614QLz5BnTvMatkuW6AYYNy75L5eQ2tn26
EaEgj8Bdv5tKzq0puj+CZLSywJeoH6g2gR6YNDS5EypIZsIBZ11I8+Y7Zrcot74N
IXaI5tINChIKisVPGoft5HJrpC7I78+tpl9hp1jFefNA0J81td4pr4pDi+qn9IYs
6m6Lz9B9ivKrsBhB+Sg5TdJLbpRRZ+ixmpVClFOllWqdCumQhMPdYnRdS5h2mCWU
fxgPSa9Rzc43zTp94QQxBiojOJJr+kbrW0nJsQJ/YsVXLS0eLzesm8qleVDONekm
Gm8S7vQiyYNi3QarBcKuQkHLP+3AV4uhxdr9pd1Whn6afxy9dYWD4lg2WqXbudt2
Wbol3o9aN1KhP7iu69iaGg2UCCf+G6aFyxqFH0/B9dm92QbpJoTpDrRKcxr6+LX5
NglvJxKH6TxSz2GLpjkkalrSZPWx6CfNmIMiaWViDxuf0gXxx+Iwn0nMDHvDeXEo
r9DEB9u3lWcytSqyMegWfTk0mUjkisb2Od52SqDNO6gaTyg40qgorjtkEee69fek
CPrDcAZbhGs1bDTvpBMi/ku+PI9vAccbM2b7OvteEQIEATeFDQc=
=Ox4b
-----END PGP SIGNATURE-----

--Sig_/3x08emajI3SN.tG200Ioafb--
