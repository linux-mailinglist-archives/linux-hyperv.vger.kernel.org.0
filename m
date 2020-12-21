Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4C2E00B0
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Dec 2020 20:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLUTIP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Dec 2020 14:08:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57986 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLUTIO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Dec 2020 14:08:14 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 245031C0B7C; Mon, 21 Dec 2020 20:07:33 +0100 (CET)
Date:   Mon, 21 Dec 2020 20:07:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: How can a userspace program tell if the system supports the ACPI
 S4 state (Suspend-to-Disk)?
Message-ID: <20201221190731.GA19905@amd>
References: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <MWHPR21MB0863BA3D689DDEC3CA6BC262BFC91@MWHPR21MB0863.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-12-12 01:20:30, Dexuan Cui wrote:
> Hi all,
> It looks like Linux can hibernate even if the system does not support the=
 ACPI
> S4 state, as long as the system can shut down, so "cat /sys/power/state"
> always contains "disk", unless we specify the kernel parameter "nohiberna=
te"
> or we use LOCKDOWN_HIBERNATION.
>=20
> In some scenarios IMO it can still be useful if the userspace is able to =
detect
> if the ACPI S4 state is supported or not, e.g. when a Linux guest runs on=
=20
> Hyper-V, Hyper-V uses the virtual ACPI S4 state as an indicator of the pr=
oper
> support of the tool stack on the host, i.e. the guest is discouraged from=
=20
> trying hibernation if the state is not supported.

Umm. Does not sound like exactly strong reason to me.

If ACPI S4 is special to the hypervisor, perhaps that should be
reported to userspace...?

> I know we can check the S4 state by 'dmesg':
>=20
> # dmesg |grep ACPI: | grep support
> [    3.034134] ACPI: (supports S0 S4 S5)
>=20
> But this method is unreliable because the kernel msg buffer can be filled
> and overwritten. Is there any better method? If not, do you think if the
> below patch is appropriate? Thanks!


> @@ -600,8 +601,12 @@ static ssize_t state_show(struct kobject *kobj, stru=
ct kobj_attribute *attr,
>                         s +=3D sprintf(s,"%s ", pm_states[i]);
>=20
>  #endif
> -       if (hibernation_available())
> -               s +=3D sprintf(s, "disk ");
> +       if (hibernation_available()) {
> +               if (acpi_sleep_state_supported(ACPI_STATE_S4))
> +                       s +=3D sprintf(s, "disk+ ");
> +               else
> +                       s +=3D sprintf(s, "disk ");
> +       }
>         if (s !=3D buf)

Will this compile on all the systems?

Certainly needs documentation.

Plus if ACPI S4 is supported, kernel can support both normal
hibernation and ACPI S4... so perhaps it should list two entries? And
"disk+" sounds wrong, "acpidisk"?

=2E..and that would bring next question. Usespace writes "disk" there
and uses different file to select between S4 and S5...

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/g8nMACgkQMOfwapXb+vLkgwCeMW2fXbRDW6Sr2dCIQGMICYaX
sBsAoJgURNDoL/yTSiY5EuI7q+BdCwvx
=HAYT
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
