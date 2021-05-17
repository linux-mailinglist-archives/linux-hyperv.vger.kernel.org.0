Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82969382DF2
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 May 2021 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhEQNwc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 May 2021 09:52:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237567AbhEQNw0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 May 2021 09:52:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6077AAF11;
        Mon, 17 May 2021 13:51:09 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] drm/hyperv: Handle feature change message from
 device
To:     Deepak Rawat <drawat.floss@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
 <20210517115922.8033-2-drawat.floss@gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <917a36ef-8db3-16c5-21f1-7bd9aa7ee706@suse.de>
Date:   Mon, 17 May 2021 15:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517115922.8033-2-drawat.floss@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="876RRYCtmUYI4TgYg1M28rTMBdnHMKzlO"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--876RRYCtmUYI4TgYg1M28rTMBdnHMKzlO
Content-Type: multipart/mixed; boundary="Snc8cqlPpJR2QKdTuMz4CBgcTrZmeYBvJ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Deepak Rawat <drawat.floss@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Message-ID: <917a36ef-8db3-16c5-21f1-7bd9aa7ee706@suse.de>
Subject: Re: [PATCH v4 2/3] drm/hyperv: Handle feature change message from
 device
References: <20210517115922.8033-1-drawat.floss@gmail.com>
 <20210517115922.8033-2-drawat.floss@gmail.com>
In-Reply-To: <20210517115922.8033-2-drawat.floss@gmail.com>

--Snc8cqlPpJR2QKdTuMz4CBgcTrZmeYBvJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.05.21 um 13:59 schrieb Deepak Rawat:
> Virtual device inform if screen update is needed or not with
> SYNTHVID_FEATURE_CHANGE message. Handle this message to set dirt_needed=

> flag.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/hyperv/hyperv_drm.h       | 1 +
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c   | 2 ++
>   drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 7 +++++++
>   3 files changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hype=
rv/hyperv_drm.h
> index e1d1fdea96f2..886add4f9cd0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> @@ -29,6 +29,7 @@ struct hyperv_drm_device {
>   	struct completion wait;
>   	u32 synthvid_version;
>   	u32 mmio_megabytes;
> +	bool dirt_needed;
>  =20
>   	u8 init_buf[VMBUS_MAX_PACKET_SIZE];
>   	u8 recv_buf[VMBUS_MAX_PACKET_SIZE];
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_drv.c
> index 68a6ba91a486..8e6ff86c471a 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -201,6 +201,8 @@ static int hyperv_vmbus_probe(struct hv_device *hde=
v,
>   	if (ret)
>   		drm_warn(dev, "Failed to update vram location.\n");
>  =20
> +	hv->dirt_needed =3D true;
> +
>   	ret =3D hyperv_mode_config_init(hv);
>   	if (ret)
>   		goto err_vmbus_close;
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/dr=
m/hyperv/hyperv_drm_proto.c
> index 700870b243fe..6fff24b40974 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -301,8 +301,12 @@ int hyperv_update_situation(struct hv_device *hdev=
, u8 active, u32 bpp,
>  =20
>   int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)=

>   {
> +	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
>   	struct synthvid_msg msg;
>  =20
> +	if (!hv->dirt_needed)
> +		return 0;
> +
>   	memset(&msg, 0, sizeof(struct synthvid_msg));
>  =20
>   	msg.vid_hdr.type =3D SYNTHVID_DIRT;
> @@ -387,6 +391,9 @@ static void hyperv_receive_sub(struct hv_device *hd=
ev)
>   		complete(&hv->wait);
>   		return;
>   	}
> +
> +	if (msg->vid_hdr.type =3D=3D SYNTHVID_FEATURE_CHANGE)
> +		hv->dirt_needed =3D msg->feature_chg.is_dirt_needed;
>   }
>  =20
>   static void hyperv_receive(void *ctx)
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--Snc8cqlPpJR2QKdTuMz4CBgcTrZmeYBvJ--

--876RRYCtmUYI4TgYg1M28rTMBdnHMKzlO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCidMwFAwAAAAAACgkQlh/E3EQov+DF
FxAAidwCE+/73KSotR2dlSbhgCOM9bYwaCRf+jS6NUcBMP7WJo0ALQcPnZQXlKzB8300RIl6Fsb2
/6euzj6aUTj0Zgf/tkfEiBiPof2AJXMseIDVpK8D/2XQ6xwFkug9WEV8M1fSMgBtEcLMgj7Oyh1m
Bxe4llxEs1jwML+hXkSWFz2g478m7EN1t3MlSOr8g2EFndu2EbJQf7tEoH9akCXSgxhpwV8l3Sr2
j3wuymFDtrDUK/h79pE+2f/wu50D/a+G52/22VYbYlghCDetJ9siLp6FQ2wkDO/0gvBDN1RlUECL
dEY4Qed03FIaLxULfXABCQnBU39nGquMC5f5VWShU4dpTJrQAvEd+mXHaga09uGW2ppVa3Qj1tOQ
FqzT7/BgAQHVrO+ezEfkvQlReEZSWy2snOgbX14Z15ftBnBwigW7EzCmTbAr4JzHRRtrfYRbieb1
k/hcflYG5l41lnGAA4fM0Kvt1vGt/fXYkoJgL/JbfjuZdOakAxmYVGBuWyjheB4thhLdYHm2VG58
zATm0gVqWJQEVGq3y3OvFy7EWepbT0KbiNZoMIuTFw7nISzCoYhHhDOO4dpEo5cQ9vcuJCjEoDp8
SA5CN5prSxU/KmZvm1ueJsXEVOtIjJIi2Rz+Bn/jLo3fXqGn6nKpdNLU1Yfz6nsAj2pYpfbItYwH
Lyw=
=sSso
-----END PGP SIGNATURE-----

--876RRYCtmUYI4TgYg1M28rTMBdnHMKzlO--
