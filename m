Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2F39211D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhEZTuh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 15:50:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhEZTuf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 15:50:35 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 15:50:35 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0543E218D6;
        Wed, 26 May 2021 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622058124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpQS0S8UgWoCKkK++F0VqKtAX/5uxfYGj3cK7qAt8iw=;
        b=eLd/Oc2nj3T3/a02t2cC56f/F42AUOBVmX/rFqNUx/8I7cfIHnJjMLaNiDy+MGZ6phQYgW
        /hk940H50tXag5EwR0yAEFm9MizEbatKdTXZsRiyTJyZNvuZpI4qCd5jCPSzFwkDbWi9ok
        lufAAK9diq//d1AZ3gRrFhspm9qwiL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622058124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpQS0S8UgWoCKkK++F0VqKtAX/5uxfYGj3cK7qAt8iw=;
        b=y5Gloui85mTgaI4TTcFmqtKFnnvwgj9OxSFt9orkpZNn65wi0cdL9osEkCPhAEqiAmJ9il
        6H6nf7g4XWq4USCw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id D681511A98;
        Wed, 26 May 2021 19:42:03 +0000 (UTC)
Subject: Re: [PATCH v5 1/3] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
To:     Dexuan Cui <decui@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>
References: <20210519163739.1312-1-drawat.floss@gmail.com>
 <MW2PR2101MB08920209B00F7692FA83BBD0BF2A9@MW2PR2101MB0892.namprd21.prod.outlook.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <b093d480-c3f1-f2f7-1107-60195c0bea0c@suse.de>
Date:   Wed, 26 May 2021 21:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB08920209B00F7692FA83BBD0BF2A9@MW2PR2101MB0892.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z2KiuCxO0gW3A2oHtXwJvtjYXfaReMLLm"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z2KiuCxO0gW3A2oHtXwJvtjYXfaReMLLm
Content-Type: multipart/mixed; boundary="UxLrgG8n7ZZgDBQ3zQ9v9Rp1bM6194xom";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dexuan Cui <decui@microsoft.com>, Deepak Rawat <drawat.floss@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>
Message-ID: <b093d480-c3f1-f2f7-1107-60195c0bea0c@suse.de>
Subject: Re: [PATCH v5 1/3] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
References: <20210519163739.1312-1-drawat.floss@gmail.com>
 <MW2PR2101MB08920209B00F7692FA83BBD0BF2A9@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB08920209B00F7692FA83BBD0BF2A9@MW2PR2101MB0892.namprd21.prod.outlook.com>

--UxLrgG8n7ZZgDBQ3zQ9v9Rp1bM6194xom
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.05.21 um 07:41 schrieb Dexuan Cui:
>> From: Deepak Rawat <drawat.floss@gmail.com>
>> Sent: Wednesday, May 19, 2021 9:38 AM
>> ...
>> +static int hyperv_vmbus_suspend(struct hv_device *hdev)
>> +{
>> +	struct drm_device *dev =3D hv_get_drvdata(hdev);
>> +	int ret;
>> +
>> +	ret =3D drm_mode_config_helper_suspend(dev);
>=20
> If 'ret' is not zero, return immediately?
>=20
>> +
>> +	vmbus_close(hdev->channel);
>> +
>> +	return ret;
>> +}
>=20
>=20
>> +MODULE_DESCRIPTION("DRM driver for hyperv synthetic video device");
>=20
> s/hyperv/Hyper-V ?
>=20

Maybe let's fix these points and then get the driver merged.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--UxLrgG8n7ZZgDBQ3zQ9v9Rp1bM6194xom--

--Z2KiuCxO0gW3A2oHtXwJvtjYXfaReMLLm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCupIsFAwAAAAAACgkQlh/E3EQov+Df
OxAAue43IHKEckIj7j+bS0Bt6D4YSyJW1Hr521l00IzcMDvOWrsDd2oSCzj/tZ47laeif1ngBexC
XB7DiihwEDkcBccQvWDbmTdijkwfP5yJZyEXInSnv6MVt12hd7X7MiVZ60f4VzoiWT1XjOTDpm92
9vXAOiKlYeIP56Ca0tW1sIFnfHlXfuWdLSzeel6NOT9XGA5PtwcY9hmu6SKxPlajBl+5cWHsCh6f
hvmosn+KIbTG6cg0Pd5HXQhb3dNTwD1EPTpssAtdAFlqvnOkHF0F+bpab4BcmJ+8xmWhbpFIrwHi
6QTXlNaBHfLTAHvXi3d1ynyZLrqo7uu/PgYtfp0B81+IMGeWcZHg6z7fp/ia7vnsfkDkZIXHAQIu
wB8A6ThFptISJVBb/DiUpZ/6x+ug30RDb+Lvzth+0i9fKiPR1rQ9nwTdQuamA1o8xz7ddJmiISdy
FJc4wb/kCLYN9voG8kZHFScpzFnR4BqeuXQ0+uSbXWRyfN3FxiRj8ltOlUCUYyMP0noUmo2VapPK
7X1GIGEWcUDs6e4vRcxKaLBqbyFPzYY5nl+OEejos0uBt05N4BspGctb3YxJobbKmho90PIUBlrQ
MaF/2ZOza2rRx94icWkt38L0nvGdiJfL55lE1XZf3XogcEpNl9gw47F36pkEQkJkVXBkydF1SGi9
5os=
=5S32
-----END PGP SIGNATURE-----

--Z2KiuCxO0gW3A2oHtXwJvtjYXfaReMLLm--
