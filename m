Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79678FB3DA
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2019 16:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKMPjv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Nov 2019 10:39:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:27310 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMPju (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Nov 2019 10:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573659588;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IcWKXBk6OLF61eXvC2m4VfKEa190SInPY4yvpfHGVq8=;
        b=ryDVLjY8KyB/NCNFYxPmfZGHBnzh75BV/lK76fu+GH3vZrwpKBsexachgbWUKK6a0l
        53hW9sRuey2jyjm1VjyIVjXsyEr/n40eInEyIbsFlYlf5jGs+If3NqoOhC2l9FtX3Rhv
        L+nPUOqgJmAw7yQyNlX1BdanHxvLD9abKmv+Oz7kEmDG/Ts8OieqXqx7PtnZGahZXPqa
        CTpbpYAddMJq8fb0auBT8N1dkWDIDToFCgUXFb4PabqDEk92VjjnAZ9lQu50c8FW856A
        K2lRuUUbivrkP5Crer8VL4fp7ix3FkjUZPwl1OCLECu8EdX/ELd1AGaDyjsW0wwULVGl
        Uzmg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuY8hl6Q=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id 20735bvADFdmGbJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 16:39:48 +0100 (CET)
Date:   Wed, 13 Nov 2019 16:39:41 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Message-ID: <20191113163941.59124120.olaf@aepfle.de>
In-Reply-To: <87wocbagqc.fsf@vitty.brq.redhat.com>
References: <20191024144943.26199-1-olaf@aepfle.de>
        <874kzfbybk.fsf@vitty.brq.redhat.com>
        <20191107144850.37587edb.olaf@aepfle.de>
        <87zhh7ai26.fsf@vitty.brq.redhat.com>
        <20191107152059.6cae8f30.olaf@aepfle.de>
        <87wocbagqc.fsf@vitty.brq.redhat.com>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jIGef0Ofd=8F/1tOqnM7Fbw"; protocol="application/pgp-signature"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/jIGef0Ofd=8F/1tOqnM7Fbw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 07 Nov 2019 15:44:27 +0100
schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:

> I *think* what you're aiming at is EAI_AGAIN and EAI_FAIL, the rest
> should probably terminate the resolver thread (e.g. AF_INET is
> unsupported or something like that).

The thread aims for success. Resolving of the hostname can take some time.
Maybe the network is not fully functional when the thread starts.
Maybe the VM admin does further tweaks while the thread is running.
IMO there is no downside to wait for success.


Olaf

--Sig_/jIGef0Ofd=8F/1tOqnM7Fbw
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3MI70ACgkQ86SN7mm1
DoD+TA//UuW2hrqWiB33HTuz3g0RxmA7ZY1UuaEs+khSCMV/W8ktIEnYLgZkON5S
JTGG2II0xGZhmNkV8GgwgwQbIuPhrgsYAdz1Z6G5q+zDpow82O4cGQeMUgKG6Xfi
N1c+dQUJYMo2SuAkYfvHks/7L20TZBi3tw43ZpKQtoNyQG1w2RdYMFKLBhpHIMaJ
BuL8GRo58x/n7YjLDVqWRurYC3Iu7FrkJT98g8ccrgGhh8hfNC9Mkvy/oJRdes4W
+QooloWFEwmMRhkZZof2xCJg8fkXxOHFaEL8YxVed66OxlQjus8uv/pO++TTdaxf
DKuxxfjkM/JOzFwKnObIJUXUbh3gEjQj+9/EFLNE/oJvXPQb2LVBFYnQLseF4t9C
rg8tL1WPSZdTtPZCqKbS8Ng7CiKmwj/tYqG/ooQ3qDWp+lQ1mK9762XBO1+Q+PV8
rm8LimGnIvUHo46rRP1F4ncoNZ+y8jKvwrG4AjzsQHwP2uLBvSIjs91GJem4oeSr
qHC4VKeF0dzeuFaQZASI6nHomWyxn9JiMU7ED4C+vt0O7T3dv5gY175xCxDbg8pr
2fryLn73oFOz+QVyI0Qe0Vf6uIW3s4mTnXNtAxlOgVFK8dxQlRk/OnEA/+X7ZmuE
gPLrNZJWRpAya3fWob6dFBqv2nZ2d1jb7wZoYGJvpH5iaRCCatE=
=88wJ
-----END PGP SIGNATURE-----

--Sig_/jIGef0Ofd=8F/1tOqnM7Fbw--
