Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681B91FB4A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFPOlY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 10:41:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33644 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgFPOlY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 10:41:24 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 624471C0BD2; Tue, 16 Jun 2020 16:41:22 +0200 (CEST)
Date:   Tue, 16 Jun 2020 16:41:22 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
        chris@chris-wilson.co.uk, ville.syrjala@linux.intel.com,
        Hawking.Zhang@amd.com, tvrtko.ursulin@intel.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-ID: <20200616144122.GA18447@duo.ucw.cz>
References: <20200519163234.226513-1-sashal@kernel.org>
 <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
 <20200616105112.GC1718@bug>
 <20200616132819.GP1931@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20200616132819.GP1931@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-06-16 09:28:19, Sasha Levin wrote:
> On Tue, Jun 16, 2020 at 12:51:13PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > The driver creates the /dev/dxg device, which can be opened by user=
 mode
> > > > application and handles their ioctls. The IOCTL interface to the dr=
iver
> > > > is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
> > > > definitions). The interface matches the D3DKMT interface on Windows.
> > > > Ioctls are implemented in ioctl.c.
> > >=20
> > > Echoing what others said, you're not making a DRM driver. The driver =
should live outside
> > > of the DRM code.
> > >=20
> >=20
> > Actually, this sounds to me like "this should not be merged into linux =
kernel". I mean,
> > we already have DRM API on Linux. We don't want another one, do we?
>=20
> This driver doesn't have any display functionality.

Graphics cards without displays connected are quite common. I may be
wrong, but I believe we normally handle them using DRM...

> > And at the very least... this misses API docs for /dev/dxg. Code can't =
really
> > be reviewed without that.
>=20
> The docs live here: https://docs.microsoft.com/en-us/windows-hardware/dri=
vers/ddi/d3dkmthk/

I don't see "/dev/dxg" being metioned there. Plus, kernel API
documentation should really go to Documentation, and be suitably
licensed.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXujaEgAKCRAw5/Bqldv6
8q/JAKCQjRPnkrFqnsMWU0xDN/FHE1enzwCeMHA4YAkm0yQfrg+8eKiMWa/ARU8=
=bHer
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
