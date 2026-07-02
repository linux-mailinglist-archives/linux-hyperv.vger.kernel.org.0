Return-Path: <linux-hyperv+bounces-11803-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6oBXGb0pRmqEKwsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11803-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 11:05:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76786F50CC
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 11:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=f5MDYLpU;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11803-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11803-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C23F3027692
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F0363C53;
	Thu,  2 Jul 2026 08:52:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5B35AC1C
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 08:52:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982356; cv=none; b=OVa6jnrQjTj0suNSM7Udl7cUd/kPq1A2qUQ4nnwYmlq7JuEwPzql8iZyHPe1/o0iAKJL4Ny+YUKIt0LhxpJ9ErBtpgcdNSzuezvi8poOAT3zK2HUJ+XMGUBcb1RVJWdRARKpz/ZttwuwrQdpsWBh2h9BSiw8fXFJa5DaJtnX2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982356; c=relaxed/simple;
	bh=q8ZDAMb2bQo0oUW4Ub/cESqmCJc0thRqkkVKs39GofU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmPuWe3YSUjWO65faK5HepOuPV4XOHDfxume/fuyYwa0hrunblQ4yf7bDvfcwKW9VyDsST0tSZbf5IcYqKE/0p+sUkB8IecPu35plPFgKK6nhJ4p012d/AFw2F9J9pTHyM+4TI3t8N+pwhyO/RkPj5o2zoUrratsAGBVUSS6LRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=f5MDYLpU; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso1005300f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Jul 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782982352; x=1783587152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aElLLGay9xB16xeANMb8tta8IpzpcumQhgPLm7WpnQE=;
        b=f5MDYLpUYNjo0fld9V2DiLjHRLbkPYAbWYbL9RjSlsqqW1/po8+sOZ9EawjWeO6m0g
         4Ve0tyPyS43OLlGe8xTJldWpbig9ySXPIHdiWgxAwpkMNS8KxcDXXOUS9dYaSq/+UCM4
         KCWfZVKYUSDsS8EL1noa1ShX6WBPpc2URlBpf55x8FA6i1rOunz1ZMMAc9xBlCVXvON6
         Y8IeI3F7ASIwlRjEIjW6HQPy5JOE8dWN35vBys28y01+SqyBTV9Zp+Twc1CDrXwZ+2mJ
         gd2U/QrdowZr2FMe0IyfpTn8YCIaTTZkNTKId/lPvhTFvQ9KfYHl5Ll3xjOMue7hxrbP
         E/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982352; x=1783587152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aElLLGay9xB16xeANMb8tta8IpzpcumQhgPLm7WpnQE=;
        b=qYwayqcCtczoZjcI82meslr5RCOhGIZXgk4yQVAkStfmGPqb36mszBwAmDUGbajaEQ
         HGHU16IYC+lkI79mP+xn1FGI1jR5R+/CbIn4tFYAs8BHFct5EqcfF4sDHt3lh08LdqDz
         yMeWJrYrlM2y2UPJ1H708CSqZcy42zeRyodmJ3D+yc11gDR87cTz9g7G89leL/kCwxyy
         PvP2WPkVbwOvhfROYUC7tZeJY/wQiHRZypn++tY2uweCSHNQiKlIAD6nqdUYEZTE5VYO
         gk8L2TPSkvvMpRnqN3QKuau/LHUHdbtXEZWpKPDtCeJ6Yc5Z8dKgGd8P2jxHE1/wxKk7
         MS1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqzUZfJ3BL+lgtfizRWN9b/y1s+HxiCW49gsXFIL56FvFAbUx7KNet7aaLsIsAEo7JV9K3ChLKVtpZIIvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFh5cNR91oK8AWK4bv8S1oFAD/ttc0W7iL2tS6oUSp4UuBF4W9
	h3ouo5MXYnblKunsVqwHbAkJM4sfOdlfCCaSXXBXuBiOy8YhtLTvOdEFcPKNLQ2fwJg=
X-Gm-Gg: AfdE7ck7HYIC94FO4ztfiiIHLgifPe1iN+Ovim1UtBCVm73rJll+FxvfB7YEeq36lYN
	oZ5ZmtKvLvhNyxsxRyyGpJV/3l/JnX0HKtPAJ0v8W9yJhoJUlled5xFBIPCCKt81yw/n0JEWpDZ
	Ipe3mO8RuKJXvUfm5nWNdK94xxrA0BMwl4Ichok3a/x2unE7p01iFUFLLmZ8tk3neAoUdo8/xSx
	CjvGu9VPwt7O2Hxti7K/uTde4p4MDvzexTUYoKCtCP3o5DjY4icW67KNXvpbPDCZ+CFM6bi9w9Z
	GdkaQkY8lSyBIWTA87dDN5UR0naaxu/YW00zeyrwkFXtZRVzCmtdHlNN0SNlMrY/c8IlS47iLhJ
	l8Ay6LcgnsziYepau6bKCXUe0Zjtou8zspqtRzeNDF7dnF/4dqJSNPmltK8w/HG8VeS+y9B31GU
	HxcbDRjYnQpvhrm9FiBQ==
X-Received: by 2002:a05:6000:260c:b0:475:f0c2:5b05 with SMTP id ffacd0b85a97d-4775b64ba1emr7587656f8f.59.1782982352189;
        Thu, 02 Jul 2026 01:52:32 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-477dd94c829sm6684131f8f.24.2026.07.02.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:52:31 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:52:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and
 subdevice for pci match array
Message-ID: <akYkWQzXIo-y3n4J@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
 <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqfonh6coq5d6ttj"
Content-Disposition: inline
In-Reply-To: <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-11803-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A76786F50CC


--sqfonh6coq5d6ttj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and
 subdevice for pci match array
MIME-Version: 1.0

Hallo Thomas,

On Thu, Jul 02, 2026 at 08:43:32AM +0200, Thomas Zimmermann wrote:
> Am 01.07.26 um 19:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > .subvendor and .subdevice were set to 0 implicitly, so only devices with
> > these two values set to 0 in hardware can probe automatically. Make this
> > requirement explicit.
> >=20
> > While touching this array item, also make use of the pci macro designed
> > for that case.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_drv.c
> > index 2e75fb793495..e766d87b7a9d 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
> >   static const struct pci_device_id hv_drm_pci_tbl[] =3D {
> >   	{
> > -		.vendor =3D PCI_VENDOR_ID_MICROSOFT,
> > -		.device =3D PCI_DEVICE_ID_HYPERV_VIDEO,
> > +		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
> > +				0, 0),
>=20
> IDK, but it looks like an oversight to me.=A0 Setting the sub-fields to A=
NY
> seems like the better fix.

That was my initial reflex, too. However while writing the commit log
for that change I noticed that since commit d750785f305e ("Staging: hv:
fix hv_utils module to properly autoload") from 2010 (applied to
v2.6.35-rc4) the driver never worked for hardware with .subvendor !=3D 0
or .subdevice !=3D 0. I cannot believe that something like that is
discovered 16 years later by chance during a rework by someone who
didn't try to run that hardware. And if I understand correctly, this is
emulated hardware and so I guess used quite a lot.

Best regards
Uwe

--sqfonh6coq5d6ttj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpGJssACgkQj4D7WH0S
/k55cwf/UJBZ26bD2BNncRiKxBadwLt7x6gNyMi02vNafvcP5U6SmmmXCVTWPNxg
21tfbjDQBmk+B4wGTrcyLJLNWhh04x0o3nvE3aGMX4BjXOJR5LCdexnIuby3mLKU
A8JQTJKyHu2WdtRT4aLITjAE/4g5rYoRzH7UV970O4k1JjRYCJivjRMTpLzNQLYC
ZUA8AkZ9eFlVbt1yPzcrR/lpzk1V8zWQWRHjK16ZGVZpdFA7v2/GNcZTvoYcvZCP
e4jtKrKnSJr3Wwp8sfcEjLHtXlo2EL0GjatENsnFYdb7oyrQxXoLQ0G4EBxy9I37
JtoxY9CMlHLAsBUDt0gv/ecgN9xosg==
=QzVa
-----END PGP SIGNATURE-----

--sqfonh6coq5d6ttj--

