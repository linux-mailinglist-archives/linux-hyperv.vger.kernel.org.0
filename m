Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6A6FA1AB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjEHH5D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjEHH5C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 03:57:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A5E62;
        Mon,  8 May 2023 00:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683532437; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ld63pTySf78aYCa8z9zsbsW5ixvoukPNm7OzSRszRZ5ynIUolcU1J0FKd6ig1WPleS
    DgI2UyCRLcS6QsZTQeMYkwONUx2M9vbQ+IkTkpLpQSG3/ZRO1n3lwjvGtK5OarMlbOKS
    wM0tdc7B4m9SnnW3Ue8D/21yY7anU80Shex8U2tkAB7oJfgHBPL0UHgaXZfdbvII168u
    mbZwwEqxiVekwuSB13s6Jtp4giqrr5Lo74TOuRo/QOQ7OZrOHeP2TOSurh4jwosFq08T
    1hp6ntVTh69vJvQIAey/HdfZvd9o0Q/08E4mmJar6kdH6HH65kfKLcFdFBNf7GucHUaq
    XzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683532437;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2xRln1FyXG/yqM5zWN3EmjBdBqqr2yBLjoFlxRmq/5w=;
    b=gjq4YwZODV83eGA/rRQfMxEaUp/zaE8KCLtnuljsPw/uK29SANL4xas6fss5v6CZJO
    LprnJOJK1cAcm/MpbXpbq2W6MfjPYBBHSQbhqTGYcE69uKMQa1SIGqjed3X1QhKNzdtU
    FPJVfeHYjsFiyvrviV8BfbW0Uykv/L1F6c63jdu2J4tOlxtKXUabLWCx5UdUVA6OTBZZ
    qFUi1Qw9VBk5DTRRzQGM3mes7+/goJ+DtLLQOXuOtW6sf4PGv+IzSpcp6rsvWRG201lP
    KUHuBdFJBMs4KYdIcUNK2tABMKfTwbV2vBlTTEE1FFUbfUd/t/XtGVV8zKqw7nZYDGV7
    3YAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683532437;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2xRln1FyXG/yqM5zWN3EmjBdBqqr2yBLjoFlxRmq/5w=;
    b=HEaKOvHHrFuFDqecpzhT2qepBtsHn76LfNnspC0nT0gA7hGODtwsFFpGv9r4Uzf3FM
    A1lv3hjd7BIZgDPktU7ZNCk1lnzz7m8EHBUqgNdSbPP/xdXq94UD8JnWEAzMGsoFnJ92
    COfIoxmpZ76P0hBZjvHsAbC0zNM7M1c8hTStU1vc/lMNBymBETTi6Q1aiq4Fcl51LwOT
    74a9nQZcXT1aTRuo6e9Th9/EXmBE81SQdNXzR4JcJ1SIR8hKT5/iFimO7a/dZXDrYwTv
    fwM3oBgBTRcueopyKjMXX+YZqxn569ETpFGuE0Ci7cgEboDgjVdRNvtGEKK5PRDwT6uH
    mLmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683532437;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2xRln1FyXG/yqM5zWN3EmjBdBqqr2yBLjoFlxRmq/5w=;
    b=yC4SbyVakZLD44+Yro/MrHg3l651+0uKjHgEZLIg2vAqGy9FlMBYQNJX9332rcO1LS
    0ZkqkDFVQ6nYlKrwkECQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4ARWIYxzstZKeVom+bauo0LKSCjuo5iX5xLikmg=="
Received: from sender
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x6987cz487ruyxP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 8 May 2023 09:53:56 +0200 (CEST)
Date:   Mon, 8 May 2023 09:53:40 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230508095340.2ca1630f.olaf@aepfle.de>
In-Reply-To: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: Claws Mail 20230504T161344.b05adb60 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LUlXsZ2lKsDARMMPAPHyxDO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/LUlXsZ2lKsDARMMPAPHyxDO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thu,  4 May 2023 22:51:15 -0700 Shradha Gupta <shradhagupta@linux.microsoft=
.com>:

> Ifcfg config file support in NetworkManger is deprecated. This patch
> provides support for the new keyfile config format for connection
> profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> to generate the new network configuration in keyfile
> format(.ini-style format) along with a ifcfg format configuration.

Thanks, this approach is compatible with current expectations inside the VM.


Olaf

--Sig_/LUlXsZ2lKsDARMMPAPHyxDO
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmRYqoQACgkQ86SN7mm1
DoBFdRAAoGaJ6Nt95xQ4ryrZp3ihaAu9YhOQFi2trga5FUzLa9SdF4yDqSENgtoa
MYs4ieWlUo2Z2jxYbquVBQhN6Su1poNELp3EIEGqN4V8+1vm8sL+JHVXt0mijjAA
93/A+VjfU4dSwpxkSvSx0pPs6LuJKtS3LnEuSX/dwaPFFmK7A5TtjlUWQbT80lcW
J9oKtb5VSaKgqdtdfBMlyeoNvQxgtB12OhXfzzXZrV6v/j/5Jw4A0BkEvX8jQrn1
BLxn3J3oR69hRumq6DLxrZF3xekDurhUfHQKUIdis8P4UahOgLfA8xDd0CzUXXBr
DbZPnPnQ8RW2ZM1d6/947fhqmsEBJ3rZFLdQcqDAhftVivxbDMBCOlUlqkVOEA3j
AAy84FxcwIybdzMO++EGcLobuq4xTp2LNs0S3DXX7Wr6iRQv3toZ6bev62BIEFur
DjKQZgQ/xegZhCXxOiGRF8DcjKWVUPjOptcEwlAv0ewimm5ZCpsgB7jkEQi1k56Q
5PW+yQ7CKUktnQThP1MY7BNSkGDhhXw3aPK6lT4TPX/kLxllxlW5OSrCU25ZTrzR
p+RcgUPJe4sVvV8/qAcoFzNzFn1GJm7yQ2ofqeIfxQraihOLidbR3F+AhJTTZH0/
5uZpKwuE+760F4VP0mFGGJjS6oRUNF82QbtN71clOBGqlvr5oS8=
=Y7Cz
-----END PGP SIGNATURE-----

--Sig_/LUlXsZ2lKsDARMMPAPHyxDO--
