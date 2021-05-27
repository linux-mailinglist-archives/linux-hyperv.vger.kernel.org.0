Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22858392FCE
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 May 2021 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhE0New (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 May 2021 09:34:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56126 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbhE0Nec (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 May 2021 09:34:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F8B7218DD;
        Thu, 27 May 2021 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622122366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YEIUcc4qUinjg/hHthHHv46TYJ8qSJvIYTcVgYGU5g=;
        b=Om8/e1Y0kBTu0w9eogyrTOMdrJWGZ9kIvhiY2F6ASvj0Oqpb/cj8JES070z/PX4PWbaTE6
        fXEUu/4dCFnHsDit6O9WOsY4C+K2liXaOvt0Lp3cadkBrWJOJjyr5LK3bimWx8RaYIjTEF
        8zN5iEAkbAIqP+sESUHw5Ehx97fC5P8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622122366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YEIUcc4qUinjg/hHthHHv46TYJ8qSJvIYTcVgYGU5g=;
        b=h9noa0MUbm1Q1+HBc/RMkZHbgnkpVPnGTkjct7INOq1f2J58UYg6vhQIcszbuFcpuyGZGo
        S1U0MKdJ7tEfCSBw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 7D19C11A98;
        Thu, 27 May 2021 13:32:46 +0000 (UTC)
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Add maintainer for hyperv video
 device
To:     Deepak Rawat <drawat.floss@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20210527112230.1274-1-drawat.floss@gmail.com>
 <20210527112230.1274-3-drawat.floss@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5f6abc89-9f0b-5e3c-401f-7c1f932e6a20@suse.de>
Date:   Thu, 27 May 2021 15:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527112230.1274-3-drawat.floss@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2qKEjhihazloU02J3Q65BIOEF7URnCT67"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2qKEjhihazloU02J3Q65BIOEF7URnCT67
Content-Type: multipart/mixed; boundary="hWhslfvckPJfziidocdItdVtDIhZhRAZl";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Deepak Rawat <drawat.floss@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Message-ID: <5f6abc89-9f0b-5e3c-401f-7c1f932e6a20@suse.de>
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Add maintainer for hyperv video
 device
References: <20210527112230.1274-1-drawat.floss@gmail.com>
 <20210527112230.1274-3-drawat.floss@gmail.com>
In-Reply-To: <20210527112230.1274-3-drawat.floss@gmail.com>

--hWhslfvckPJfziidocdItdVtDIhZhRAZl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 27.05.21 um 13:22 schrieb Deepak Rawat:
> Maintainer for hyperv synthetic video device.
>=20
> Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 315120c4124d..a4fdde4bb250 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6084,6 +6084,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-mis=
c
>   F:	Documentation/devicetree/bindings/display/hisilicon/
>   F:	drivers/gpu/drm/hisilicon/
>  =20
> +DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
> +M:	Deepak Rawat <drawat.floss@gmail.com>
> +L:	linux-hyperv@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/hyperv
> +
>   DRM DRIVERS FOR LIMA
>   M:	Qiang Yu <yuq825@gmail.com>
>   L:	dri-devel@lists.freedesktop.org
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--hWhslfvckPJfziidocdItdVtDIhZhRAZl--

--2qKEjhihazloU02J3Q65BIOEF7URnCT67
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCvn34FAwAAAAAACgkQlh/E3EQov+A7
RQ/+JPnO+RjqiUadxlKeMKL94BksSVwvB1ZUP2JUwNBqSD9yPNFwbx9daYDBwV/MqVpBSydkrGk+
r8SwtYtq1Ay7N8BEw4kzaSuNOnOhnhsHhrZs7vSPpfKrckiR5azLoFJfmeePQ04R2jKc/1swWcBa
Ge8WzaynpErJIXhjCkbZZdfJW4QOS2k7QBmw85vRkQHaYUBWiZqQaxLIkHCdqJuYgvXfXsW4yxN+
PhbFaMHruu+jYUpxlptpT/R2ith7WckiRknWXS3dm6+azgXh3y03jN/18ThuekDEasLEHAS5a4s9
PQPZo1WedbI1z6tNMVCxCdVSZsQAmmymXUmIcgy3lF+823iDM1zHQeo7ALiiXyGsvHYDPzCZG/ci
WjcZZOnM23dX9KDE6zIM3LsPlaywUgAYKiy+yMclgvfCOThVnnjlyRxu9fyTByNY7UXpeKQ6SdcC
5FzF715WbzECU3VdiT8YpUCUWRvss5iNGATZSYrmjEocrXUiXw4K80TI4aZQTq0TEuZ+Ju5XtQln
W+x/LWjZVAfyX6r7UvB72SnuFlEF18uAQRdOtd88TanKRgrIOjXi2HVmAnOnYWgIQuksY+zemTj4
+B+A1/knqiGpfTf7oQhpZs2tW085vJKGnXCqHGA5WYZdi4xwjEdkgfW2HKui3ZpRuNLBQDYAxTMv
MbA=
=OhaY
-----END PGP SIGNATURE-----

--2qKEjhihazloU02J3Q65BIOEF7URnCT67--
