Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25435342007
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCSOqj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhCSOq1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 10:46:27 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A1C06174A;
        Fri, 19 Mar 2021 07:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1616165176; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rMr6806o7Cdl9QE76yrzHiCVEWBOHQEpk3zpAmEqVZAiukbXGrMv4DSL2AdudtIVg3
    HrWgzdFZHsBbZglimmjaCVSGHJ1dF1qhzjZGszNlm2D68hCF2nFJ+Wb/4LJbvsy7DCnT
    aK5lf8t0pT8ahGcsxHIDQqlmB2CgKcd65V/7knMMIruZ6/iMZ2VXHntOLUN9MdmD0865
    wAs70dN1e9p8IrVH4++nBBweFSu2Jp6A8xYNuXzE91bmrXW3kW5GNlPn7KrDK9JG4HZE
    da3xFNVwg48nlV+EwfKkVTFaYtUMrYvNkYtwMLLanPHC0voMYnSB0gmWsmSuIPLet2hM
    tjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616165176;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0g6ivdcZkjFnRkFc2L1BIjTwwTdxzAc71cxW0S+jmO0=;
    b=GOAa2zWTDNA6HC63RjxDIimZORdDg4oy9udHuCZvUnUOZoVOpib9Tbt3vnMw1JjIzA
    /TEyFMoZRvDjWpn1EeP91+M8w3url/w3nETgbIpL+seOuIQWiJ8+fdPTu4vCcnYNZa7b
    JIgS/AK7RMYhzCoFZOy7pYAyJQ/HHqCT8Qxkbv6KlXHWAWj8HM6OHczbuLJob6uDsW1f
    FpW4sZ/5fAmMohmj5OG+reo3iLr2j1oQ9CKLNkC5lR6KdUwM3ZnBKM9Wo5jSG1OYzdUa
    o8L+H8HnbRAkahHZYLQN8eA6cc9PLFKCLfbWKcRQptHhYGRDOcynbXOcfnB63CX/n1fQ
    D3Ig==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616165176;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0g6ivdcZkjFnRkFc2L1BIjTwwTdxzAc71cxW0S+jmO0=;
    b=UpOoT4DfYVY7wH4zHa5ZyKoUQo9z81hOgKa2GcwjrfG+nInCKdc/XeTwc3gl3SQv4S
    V84iP9KSai/uzGLXnYl86ihR9NoLEY2hu/fGkyXKHzpeyHYmQQgVZ04gZM6j7i0hx7Rk
    0A7xjcMHXKmUDyl+rTG3kPYrB/U68T9tbpsZltAMF870DRfPgo2gHVhOq9S7B/ftgVOa
    33s/32egi8L3aamgzWabOBSSJrZ+pZlnBwiSiIvTS3MQqe3U3/7Sa2XeLBSBIJWhNEIb
    Bmip0W+GxTtoVvfch/WGiwUqz1msNn56lfPvJdGL/7TnDijW/bKrpES/T7Pq1il6i092
    7gsg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTWOn4/A=="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.21.0 SBL|AUTH)
    with ESMTPSA id k0a44fx2JEkFBBr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Mar 2021 15:46:15 +0100 (CET)
Date:   Fri, 19 Mar 2021 15:46:07 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/hv: async name resolution in kvp_daemon
Message-ID: <20210319154607.550198ad.olaf@aepfle.de>
In-Reply-To: <20210319144145.4064-1-olaf@aepfle.de>
References: <20210319144145.4064-1-olaf@aepfle.de>
X-Mailer: Claws Mail 2021.03.05 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zx4IEKm519yE9fAl5ina=vF"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/zx4IEKm519yE9fAl5ina=vF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 19 Mar 2021 15:41:44 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> FullyQualifiedDomainName

I think in the past I did asked MSFT what the host side really expects. May=
be this time there will be an answer.

Why would the host expect a FQDN from a VM? Why would it care about DNS lay=
out of the network within the VM?

Basically my copy of hv_kvp_daemon just sends `uname -n` to the host. This =
is more correct. This does not waste any network resources. This, up to now=
, led to no complains.

So, what is the purpose of this API?


Olaf

--Sig_/zx4IEKm519yE9fAl5ina=vF
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmBUuTEACgkQ86SN7mm1
DoAMXg//UW9gD7vVI9LReBYKUQ/9Qo8NZdh63xk/JHI+Jx9KEA84M8t6Y5HxwEdd
oy/SkGV2K6HLRXAYB3yjYmeXSbzsmugKfDlBortyxYewbP/dTkuMIamvcGPHaT/s
sHyWkV/kVYhh4F6iRF7FsQTlshQHHSZoExQrKSct8QJ6rwkOrS4spn7D/Lxwj5hq
Tkn4MQ23oOfA6vfhxRqBTSPQ/TqRrLnzx0vYxEplj5JYD8c/BryzrEY9AibjS4Ma
c8B29ZKbZe8ppj4nLczMs9GERXeWWQYkxaaB0uj1PE31soHglIZ+wHZQbGpc2/V+
aeHg+XQUnnwxEGCv72HOaXyQTeOfqReRM9PjsNXPglKb82ghDU2piVzDbdrgCPQk
yeuft8CP/Z8RHJav6oXRdlzMmimMxz4Z66MMHrAgp0t380Jf+prOXL41Gx9eJ/mU
e5Hmj8xGDmyhRK1oUfl/4+Hdjtxf6hqmaRf6kXMBCdq1mTKhOZj7AgI/54rwKfMD
4arPwycRon/dSZd8707126rbSryz0Olly01lTgDijCPqj1X2IO2bzOVWsYgqEaSr
InwFCf6GKdgzolYPKT4Urf5tjp6JRoP6sGInQFUgP2z+zkT5R7VrNpnTjX0/Z2bO
c4oqou3Q7G1gAtjWqdSa61LQ+qWn51YmBvjh6Omt5rxMf7jJ8Dg=
=osfl
-----END PGP SIGNATURE-----

--Sig_/zx4IEKm519yE9fAl5ina=vF--
