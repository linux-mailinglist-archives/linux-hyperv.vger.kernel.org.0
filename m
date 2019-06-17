Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC67F4838F
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFQNJZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 09:09:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46051 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQNJY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 09:09:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B9A7E8025E; Mon, 17 Jun 2019 15:09:11 +0200 (CEST)
Date:   Mon, 17 Jun 2019 15:09:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Message-ID: <20190617130921.GC21113@amd>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > It seems that sleep.c isn't built when on the ARM64 architecture.  Using
> > acpi_sleep_state_supported() directly in hv_balloon.c will be problemat=
ic
> > since hv_balloon.c needs to be architecture independent when the
> > Hyper-V ARM64 support is added.  If that doesn't change, a per-architec=
ture
> > wrapper will be needed to give hv_balloon.c the correct information.  T=
his
> > may affect whether acpi_sleep_state_supported() needs to be exported vs.
> > just removing the "static".   I'm not sure what the best approach is.
> >=20
> > Michael
>=20
> + some ARM experts who worked on arch/arm/kernel/hibernate.c.
>=20
> drivers/acpi/sleep.c is only built if ACPI_SYSTEM_POWER_STATES_SUPPORT
> is defined, but it looks this option is not defined on ARM.
>=20
> It looks ARM does not support the ACPI S4 state, then how do we know=20
> if an ARM host supports hibernation or not?

But actually... I remember ELCE talk about hibernation or ARM32. Not
sure if patches are mainline, but someone was working on that.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0HkQEACgkQMOfwapXb+vJUqACbBRbrUMu0nfAR+ZaWSWjQrS1t
6DEAn3UmgaE6hq2ub8ECCopo61cXUVxu
=V6Tb
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
