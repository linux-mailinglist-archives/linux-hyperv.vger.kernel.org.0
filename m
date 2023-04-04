Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A352E6D58EF
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjDDGv7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjDDGv6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 02:51:58 -0400
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 23:51:55 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05772108;
        Mon,  3 Apr 2023 23:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680590739; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F89UqXw7WQn5f+4lcR2kONlzODLlzIfwJy7Zz04RpohPSVehsbbMgZEJPSg3oqyylu
    LlTMaa1hBjLS0Lgw9LAZnGz/jTCqdhzQ00WGJYdqdUAKi/6Gn1UZHs89ZvBjtgxKcXsv
    vMF1xHK5gWANuy0nXxbmNKJ5GhaYhQKxmNh2fTnllCTxMP2w55/iK8UgrkbmBu4W7f/s
    +K2LyH61OmtidXx2GGPbCwarLIsAzwLzaTsSJbzO/xUJlUCN4yxIrWNMj+jZCUQjp3oA
    uQv8lYccEutrxumGl38oHzIfRJGzdtvNLKT1kQHFHND3EK6T4wZwN4glTJ8E6bL7buu1
    aJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680590739;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6ijxY7T4sM5SU91yAlbdXDryqtdhQfY77OxVU0pdxxg=;
    b=eg57EhLvN99tk12f3bD6q6IFtqtKeEJVLZJStXhf/c0ek3tdTdqlwuLQc+VxhRsA1G
    1a2j1FOM4Hgd8VKe1M8RDyJ8BDxVhcCMVj+OozlrhnHnAM2Zx8NDeUJNZKYavqJACo4b
    OVzYp46HAWMHWv/TWgRZPZ1+4OGaEYo9KB8y29rh6IT3i+GIm71TcqRviFnOMnZnYwHY
    bmv2hty8f0WBwxGRu8LFtVYMO1IvPTNKeBQT5biZh+8GG43vIXYj/mfxKOBfhH7Karn+
    kbUCBjcOpe59mOtLj3BikDPz+qElEXk33OTxYevJU/Bw421sq2Z1LrWNkz00owAIIxWA
    jGMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680590739;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6ijxY7T4sM5SU91yAlbdXDryqtdhQfY77OxVU0pdxxg=;
    b=c3ngVn4/aX+uKOsb7OtrvlluqoyrtRuaGsCG0sZd5jhxIDm3FxPRN0GcrbadYIE/jm
    IoNcAbjuk44fdRBMqc+1cAp58mb0zBTMrYuwqEcI558GEEsofxgaxaBvd37Zco8ACPbx
    xzNJCa50aJ9EcdmyffFWRLK30uPSJV6cmKqubtF7bLYIuexmV5+hG8i0Yp9BegrYN2NN
    hSGSNOy2U6lCm1eBeW7YQ76OP9UxLj7rdC5OaYU8xZrWi5rF+rKWVx5ZuF0LWiD7ZKe3
    XjRyVO2lq5QvI/YkNPNjHLx6ljeu17K59eBMd/W/DXiTYMv4iYMPLQLjdpXF0Tb5yf9L
    iSYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680590739;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6ijxY7T4sM5SU91yAlbdXDryqtdhQfY77OxVU0pdxxg=;
    b=P7q6CRlfbfuPOWxSSptAomak804v3w43nTbCKWtzxe99UK6fWWouIZ0cSelinU4Rd2
    pgfFyc4N9h16VUFBc0Dw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5AEWIPBvsPI52f2TnxTwFPmhSWhc+9ByBCFU+BA=="
Received: from sender
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x6987cz346jd1uM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Apr 2023 08:45:39 +0200 (CEST)
Date:   Tue, 4 Apr 2023 08:45:30 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
Subject: Re: [PATCH] Drivers: hv: Use nested hypercall for post message and
 signal event
Message-ID: <20230404084530.2b9ca791.olaf@aepfle.de>
In-Reply-To: <1680564178-31023-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1680564178-31023-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: Claws Mail 20220819T065813.516423bc hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MYRDLMDGnPR8M7CE41RN5it";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--Sig_/MYRDLMDGnPR8M7CE41RN5it
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon,  3 Apr 2023 16:22:58 -0700 Nuno Das Neves <nunodasneves@linux.microsof=
t.com>:

> Only relevant for x86; nested functionality is not available in ARM64.

> +#if defined(CONFIG_X86_64)
> +	else if (hv_nested)

Should there be a hv_nested in the ARM64 code path?
Looks like c4bdf94f97c86 provided such thing, so the Kconfig conditional co=
uld be removed.

Olaf

--Sig_/MYRDLMDGnPR8M7CE41RN5it
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmQrx4oACgkQ86SN7mm1
DoBRkQ/+JkI9dSELwuWH7eBkZ4o9RwqE9rtOvmbywx7LVL4MwyAgoTRV7XS2J7yE
NFrqZTzpWZX02vnKujglHRizuIC7rJTx7CDFFzRIAcUc+YyRiaKHiEdUqv5321ws
daH4d5MDSImwy8bsnzrNmupsxpfSPVwCmHBou7+rwJKQR/PPBzj6MS9MGzA6aKgj
m0cX8MuMKnJCor0wHaCb3nUYwNdU9ezQE8TXGObars/2qB3xCtJQ9IJfbmBjFK70
hilmET7LIsXOl3ma2aAcTKd3XR59tC6gxFYunqMS0TF0wAEBnjjsnD7xk8teyZJi
4PMZOtAARTNBj5KG1ejmYIgq8Q8nOb478yFb+ibsRPeR2QqwM05CldQ8KKjSooOK
0cphRYVl7JJAUCvDlb0sxD+YkokxQr+snIMrBS/MLFlBUU+SNRJFirX9QtRDagoH
vJ0Nre0RYiPHPENRGquBieRZhJZf6xcN8hg1/uIpOUcpXSHP6bWnd8B1wXHDhx4y
96558prfkYTMtC7OAUY1Td7tON4TrsEnOlpXhZM/i/nEiZfmqJk+M/BXqb/VgrlM
3imyM/2UjOo2B7TwWf8OFe1VfIeH+aMVz/DMzl/OAon1vtnIRXvwxowY3aBQ2miG
YyrQTYhdTa1WLxLK1vCTRF4Ma7b+ztop6ypVE3Geocbcnpdb980=
=AoNI
-----END PGP SIGNATURE-----

--Sig_/MYRDLMDGnPR8M7CE41RN5it--
