Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EE6EB8F9
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Apr 2023 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDVLzx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Apr 2023 07:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDVLzw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Apr 2023 07:55:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384771BFE;
        Sat, 22 Apr 2023 04:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1682164523; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KJdJj+vzAda3XI2dWsfTQYMo2sKS8jaihe/DR4FOmBAKrqXJ5FMGFf6Dt+PxIdW8bd
    fQOU4e9Hop8OEwaOcYjX/9NdYnZsRZAWcsFNAei0QwmSplgP6v+zy2vr6E8fmDcxgnKy
    /CILKoH8hettexW2SOSUoL+VGgu/DhEwhU46S89+5nMJq5nwySFMV/f0mxdhY/iwSdFF
    UAOY94qdAT4TyyMWuUFsLyNMl/UNEcQsrPGxr/7/LGSb2QAP9e50a42WWfFhT6CMHWvF
    MaGTZyGWUU8V5bBkvttYOKQZ50m7OckOvfwlbJ8oKVLMIUHekVQDhxJO0n7J7/Zv63dh
    81rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1682164523;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Qx/SIjgw1CpcYUZ5e+avMfde6mLCVId4ENIB227pyY=;
    b=fikL7e+jGbqwGoIa832p9ib47zj1KmjKWfG/hR0WP3DZVQu5N+12uZDCfVzxV5VMn2
    uZBMztswVVcSbALJzD+BTpBTcKrnV2BzkXAFMZzWY/396V1toFQ37lhiB6P6xWw/RidP
    QQ4xWjftELD7R/mXfcpyJV/8LsLJ+iQOEQAJW5pjTfpNEapkCSFddtBuqSBAx1JQqGc5
    CCz6KkVH8g6UH+QeDLhc6THfeu4BVBR4PEO01EEWbXOZ/0f1//ZX/7oqVvMyZ7xNzP6X
    +b32OYlgxympNqlIoBQ416pA3LLcoMebwDvYnPzopBZnzW2ufLdijzSrdHp5LTemm4mH
    fNHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1682164523;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Qx/SIjgw1CpcYUZ5e+avMfde6mLCVId4ENIB227pyY=;
    b=IFsdV/alkjB/5m8QMkzhPv3NUTp5juXgSQT8uJ/w0VUlbOGoaNjeImXAlbJznyiEeo
    vtsjO2V7jZyLTuU1vhwEfihgTV13FI8G9C421qRKFnM3394nMjNK6QS9wcP5VM7t0jJw
    6KBh5vwDxzHd3+Q77dJipOqELSG3DpNyMy8yHqGpXAj8lkm6qJqW+DNzCpKpu2dbkdWI
    STsA2RuivctZWcaGr0me2o2VPM68QVDC7tF/WgjVF/DhEu92JrzhS9u74ncd/Bg7329j
    3yMo3OZfaKllWClz48gMJ4uqfHW5d/ALhKvjFaiDsmj7DcDLAsXrg003FH26z9pTUo0P
    r2SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1682164523;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3Qx/SIjgw1CpcYUZ5e+avMfde6mLCVId4ENIB227pyY=;
    b=9Y5wadaSGbtBD3kHGW1NPIW5C5EMa0UQUDawZhAnUlLssFTFAqgR+Dla/f7OSKSheO
    qkEpM8q33Xikd8HuLiDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5BBKIYx7sXVVhU9+brASRK3ZldJTnR7IDHecOJA=="
Received: from sender
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x6987cz3MBtN3Lw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 22 Apr 2023 13:55:23 +0200 (CEST)
Date:   Sat, 22 Apr 2023 13:55:16 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Add support for keyfile config
 based  connection profile in NM
Message-ID: <20230422135516.70a63d96.olaf@aepfle.de>
In-Reply-To: <1682152783-21787-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <=1B[200~<ZDdbfiMD?= =?ISO-8859-1?Q?8iq2OH9s@liuwe-d?=
        =?ISO-8859-1?Q?evbox-debian-v2>
        <1682152783-21787-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: Claws Mail 20220819T065813.516423bc hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gRWi/P1pLCpKXQRKOsjqL1m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/gRWi/P1pLCpKXQRKOsjqL1m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sat, 22 Apr 2023 01:39:43 -0700 Shradha Gupta <shradhagupta@linux.microsoft=
.com>:

> The next part of this support is to let the Distro vendors consume
> these modified implementations to the new configuration format.

The approach taken here makes it difficult to consume the changes.
The way it is implemented means a given variant of the daemon produces
either ifcfg or .nmconnection files. In practice there is a single
source of hv_kvp_daemon.c which is compatible with all versions of a distro.

IMO the new feature should be implemented such that hv_kvp_daemon=20
writes both files. Then the tooling can decide which of the files will
actually be used.


I think the configuration file for NetworkManager should have the
suffix .nmconnection, even if it may not be mandatory.

Olaf

--Sig_/gRWi/P1pLCpKXQRKOsjqL1m
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmRDyyUACgkQ86SN7mm1
DoCPvhAApdGUJobGH4vFtZ34rhTNOoEpTdQ5fTc6qcxjPjvukenex2hx5f3eum4Y
e3/cdubySB3rdf9QJOBEc0KeEf9wMMTsnL6doa7Ib8HAqhd7Ul1Cf4aJR5qq+YMH
gzNwftsjlHC1/78g1Up07rMcsiYj9uwnxCVrD0DCJljEU1bcoPNKw5BE+ATo0jVH
sLxg58DRes60Ylq1pHocj6TC10UN1tXio5cSpxmKvGmiATh4IX1eUoLTPArPZ6qg
k5WrQmy07/Ck49pZwJ6UzXqr/gfKdaRWCZf19+MzOhvdHCiOxHjVM3cxlMpJjcj2
njR2BNK+/eWJF9vbrQBv9Q1WCC8DQO3jKJTzA5VUHGjboChyKn7vtlMjNIQQNc2B
p5/HrqjZ+Ny1nyjDNQAyDF8g19jJV7VE5wnqSPrDThliVwuyfWGk8rYIX6xvWFde
XOT1Ers4Xj48U82y2iMsa4JkTuBhvyZWVCo66P9jiQb2cLFk4a0qA1Xd/8mAEPEl
nVy8diAcVIXRlSL1STexZzDNEkvPyp5x0nVxXSLzstiebbZOCLPDpoVHOKwGK3EX
G6U7BNr6AdnmOJn6dryM8nbhA6FZotF123+aT/7vTGuAOQtOMv8YBoOxGH52n6Wg
L8SRw1AkwJ2AUg8a0xOh0iQqzmQz3KugduYKI9blfkEsK9pmq90=
=HkRI
-----END PGP SIGNATURE-----

--Sig_/gRWi/P1pLCpKXQRKOsjqL1m--
