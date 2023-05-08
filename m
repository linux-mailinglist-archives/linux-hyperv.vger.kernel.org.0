Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E476FB5C5
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjEHRQK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEHRQJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 13:16:09 -0400
X-Greylist: delayed 163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 May 2023 10:16:07 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAD4C32;
        Mon,  8 May 2023 10:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683565980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NiF1JUqDYoQIh/S1bCdnfxBDrd1qUVMeDQh5nlkU7CPGavxbWwU6T5uMXiX31y/KdT
    axRyd4kSFI0PaJA1pBQuwmymtg2sq9xkGHrDX5o/rjInGI5lZSwSaCuBxguE18zOpe44
    KOCvrHnuuuD9Z3kOOkHSHfS1u75Z2KQOP8N7vLM/SDV59yEk4IiHXsvrEZkD6KMkandb
    0qwWLS9UDazvLSEGPwme4xy58tSmljsnJtqNWmyyqUM6Jit26T8NEsnuey2uzBAl4no1
    NyagUiPPMPDNBlqleMkwjedb2PGEx+1IrTRdM4Pg5UGCjoaPqfPTLkhvLX4IGUkw+Sm+
    1ndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683565980;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v7IXfx3YQvyH8c/7Vbeb0stBQF1uRq2uUOL9UVK2cXA=;
    b=SNHNfvJy0uE2PXhRr9Kd5mthCN3rNbZzoCK2GLCCHN6CQHIQfTx4HDTBhV81DbIIeD
    QhH5HwtvQ0lye4IgAzO3b2Zf9fYkW9t36aAij+4O8Pk9VRTd9Oif+p4QPXKQhJ/rijaN
    7nog81KiU8E3o1ExJU03TbEsHrfIm/afvSjYLYW+mUfo7teUQje65BP3IPO6+kwVn6rE
    mW9eZ32HZVL3z/fQmFPdeioi3e4u4A03V/Eo7uyshMFvZnb3GFjfPhNQzmI4Jamu9EI0
    seY1obNFgKLINQUWSMWKyhmxQeCHv4DdAmvUR/mFAq+YYiaYKCgFpM4xALW4g0AMW1/y
    j9ow==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683565980;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v7IXfx3YQvyH8c/7Vbeb0stBQF1uRq2uUOL9UVK2cXA=;
    b=fArY0hwcGr9WxoNysJ1qZhELwQWA1S2lpmNzGHfvRW/z5uy5l8/fnb/MD+PXWkEUpv
    GKgHZ2Ubtr9A5SyceYbxUHBYkEpAhZtA8piwHUiOm8D5S0i/qb/pyb9iMSN349VtGB4Y
    Q0HdbeZA4FYlQoEGW4EXMjXX+uFwhej8uymYcbBPKQV3Vq0g6eOD7e45qcPPaycrs4L7
    M7akCxvjgNBVFgYPDm7V5GGYBg9gr5TLkxXhdzrLA9PSK7LX7nu+kSbZcXfNQvxYQBU7
    HrPaS5POKH+3wkSAxuc29ulWgDiEmWy2t8CQOI78EGxKHmaeuMxUR8CK9TzD2Ql7oMaV
    JWiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683565980;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=v7IXfx3YQvyH8c/7Vbeb0stBQF1uRq2uUOL9UVK2cXA=;
    b=TENsmZC8HLZiJA1BhBMBQu7KjewAptN6Cb6phOmrEGnEnsUI9+SprH06cGeQF6zBCP
    Q5udp/xjcZ/kddipehAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4ARWIYxzstZKeVom+bauo0LKSCjuo5iX5xLikmg=="
Received: from sender
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x6987cz48HD01i1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 8 May 2023 19:13:00 +0200 (CEST)
Date:   Mon, 8 May 2023 19:12:46 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230508191246.2fcd6eb5.olaf@aepfle.de>
In-Reply-To: <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
        <20230508095340.2ca1630f.olaf@aepfle.de>
        <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
X-Mailer: Claws Mail 20230504T161344.b05adb60 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LB9tL/NpqSz2=szEqmvTjmJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/LB9tL/NpqSz2=szEqmvTjmJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:

> Olaf, is this a reviewed-by from you? :-)

Sorry, I did not review the new functionality, just tried to make sure ther=
e will be no regression for existing consumers.

Olaf

--Sig_/LB9tL/NpqSz2=szEqmvTjmJ
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmRZLY4ACgkQ86SN7mm1
DoCgeBAAhS9Jeft8KdyBdtlwJEZgj2ESGmC16/WkEQAVSBNkfkIOmMoxEjgJ/keK
QoG5AUp8PQ7gS2vnI7dBlj4eK/ZXfynqn11YtcMu7WFf5dZQ20KkogkJKAjY6SnO
9GM+hwmXRcjmI03a9TAhViJ+cn57RfXCZBEkmJZtgdo/WrgtaV8p6CPfXgAUNft0
pgZYGE2xNx7Njzz0bojjKpWryphvgVs40Zb4t1JLGrcMGXi1QcXFYpnEaknlLgxP
m4QZhoTvoFNEFNJz4YAy0oRk0oyoSH9KQgufAJAtKabMo5Ntxx5k6uDWgp5V/9b2
OYFpcHDEP5r+/zZrw/foWM75KRIA6dHWseaTu9aCRyFTsZ9uImTeVp3QaIXwC3Nd
xwZjJ01DfSOPis0T8m4k6MLDNteOgRM/A68vfrhjo8vBtqamAlVtpeSWUe9srzsQ
k9BbPwXEyxhGsfIOLzcH1ahYFBIE+mExeFSmkAAjvLnQGZGWkNRM1O5Rmatw0/nC
SMpNYL70komZydkt865j4Aw/4PATz8uiN94k4bNYG6a01UEC4qnNV9CxfOdd9a4J
+bFrZC7hA3QKW4LezgqTdhib2Q2ildkxUtc0hsbWSowgs8t9zaqd+fx2+I4VvHQu
OgK0mdVvqOnanP++O2XNK2DQx3lR5kdF6vQIY22z2EzaW190kaA=
=Q/Xk
-----END PGP SIGNATURE-----

--Sig_/LB9tL/NpqSz2=szEqmvTjmJ--
