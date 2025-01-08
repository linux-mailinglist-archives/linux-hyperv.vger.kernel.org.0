Return-Path: <linux-hyperv+bounces-3611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA26A056E8
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4F1161860
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4361EE026;
	Wed,  8 Jan 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTsZXfFY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1522594A2;
	Wed,  8 Jan 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328637; cv=none; b=CzJTGTvIQyoxx46nhpJJlB52p4hql5LKG0LVmrnwzAfO5HYKXTy8s7xx09Io5wzusTSfAwCKyccS+MzvrOWN39ylWYOxr0ET8/620m1+FUx1F1Zd400+jq837dwfSYd41FzcySiXJGk4FtBh7WGDr+xyApWt9hbwzO3UqbmZ9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328637; c=relaxed/simple;
	bh=QViLy/GzMVpMLURgu6CKy7VMLOWMqPuo+67Y90jsBKM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8A2+FM/E2Y9z9FIeRPazTz14Fft4TgTTVvPZ2VK8Kuo1QhUJCAzvQMJj+hZ3lK20XCPKz0pOv86uT849G/rzPK5WS6Ot3aZvizWueTfYj+L0Pz1IpKwM23+61zMSHTdAY86reOeulU+5oPv6yhFgFEnZYPoUUfgw4XrUnV/Oz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTsZXfFY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso18692508a91.2;
        Wed, 08 Jan 2025 01:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736328635; x=1736933435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5QPT5hAYtzAAHlcpV6TvTAuoenPd313KzNDPXtMQNA=;
        b=WTsZXfFYQIuwo/fs5x3tbsdNfAigt1rqptYz+miaIZuIJvS8QE3nhTMQP9SLptDWIT
         JbVwrRG9R+BD2wHmOOKBl66E5nXzKLtbiUmS40XW0guMJLeqW3xwQmndSqOWVuQP5/Rf
         8DMKIJqQJHz5dEQ17KvRDnVkKSlYBP6BElRnHIwgquz8P0V3J4vkcDKnn+MDoDJuBYGD
         lhUfcbl3g4I9aVUNtAKQ2BnuVCdLDXCCn8hDZIzEWT+YjM49awRrDOnLYxsHZbcgRdIt
         ugi0eRIBDSQM1XidliWNwawlXRkgwagny0L9ENzIwLrnCfNorLMQEHrv0WPWDwbswjdj
         7GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328635; x=1736933435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5QPT5hAYtzAAHlcpV6TvTAuoenPd313KzNDPXtMQNA=;
        b=SLNKSysVAaLRLys8qAkLTsYYfp+DfhASiqlQxKmqWcabQWHaBQpfEFKOCxc/1TXYUm
         vy91xbA+byQsIrtIQ6yI066i828Invzi1J5gh1oCFjML2bGGtW62nUSfqcB1banib3XD
         dmktD0rK4mRUDbs2XNb5RJkHqSyd8iJU8EVddZ2L55oOAemwODH/9RNxFcuPsS0ddlus
         F6Pc42TNNlcP9vfFV4UyyPHGTiSV+u+QfUnBCec5K5bc06xnm15gDiij8kLUzNCgmOcH
         WNWBBQBRDnST4IJFBcPmz1xftlKEfCphMabE4W/qiq/OgOyfeFzWEpSeakCR6y8vcB2k
         elEg==
X-Forwarded-Encrypted: i=1; AJvYcCU2W2Z6+vmAFeIr1pc7RJXrPlpVKSs6RTj6wQEBGKmOfJG4LE0z3060VHjcPbATigdn0iNLLsTiibw+1PLi@vger.kernel.org, AJvYcCUP3KK0ZvOpgGzDyI1d4Vk/5d2KUxoStwvS2Sw/IgFUeCp9SahBIIfw/D7otDe6fuvj1hofaMakuP0=@vger.kernel.org, AJvYcCV4sbIjRg6FAWDUh2ERhDP5HmU8Tqg0CAQuz1/vB+iDc82eneIdeN8EsC01pTMDyVHJds1R4Zg3Ebzby5//@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEF3OB2odq/xyHclDsd0vtg1f22vy6kzS535wV4bpRgOFNzrx
	9FD74cej9EfIUgOQF9OLmSFnHO22D+xbHr6MMWCuq0cgLN5lnah5
X-Gm-Gg: ASbGncsM6UCPfIjmhrKsZuEKBN+PDVkxp5E5btcXPQyp8x1oGWY+Hjpss7T8Icr64Db
	5/k/vp2wirYWJZNuLaBOxoyQn/r8X8hi7USBawt5HPMVrBCbRJguXxhgiH2gzHH5HX7WMjMko4P
	G0yd8m786lhz/oM/eLxwLL5bd/ntkmaUx01jtC4DtK5HxVgG1BvRFYiMXT4cM01jua6wAndBPUi
	UDzJ8riwRT+pOH/1LX0SVDMu6zYRRCDPFToxBIrpCKtG7Xg1EEq9eBe
X-Google-Smtp-Source: AGHT+IGJjX1QfT0R1lf+GM2tb+pmcW8FxBgztE1zI+2WxJeK8I17qMPt5fIXbAVJXU1rl0T3Ptzs/g==
X-Received: by 2002:a17:90b:5146:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f548eca259mr3067533a91.19.1736328634573;
        Wed, 08 Jan 2025 01:30:34 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a265fffsm1116880a91.2.2025.01.08.01.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:30:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B5B0441E5F02; Wed, 08 Jan 2025 16:30:22 +0700 (WIB)
Date: Wed, 8 Jan 2025 16:30:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Message-ID: <Z35FriFiFcQn4Wi7@archie.me>
References: <20250107202047.316025-1-mhklinux@outlook.com>
 <Z335xwWRTjyX0u6G@archie.me>
 <SN6PR02MB4157AC80E1975CE9BB6E3E62D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ovyy0gUq7zMeP6EX"
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AC80E1975CE9BB6E3E62D4122@SN6PR02MB4157.namprd02.prod.outlook.com>


--Ovyy0gUq7zMeP6EX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2025 at 04:50:15AM +0000, Michael Kelley wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com> Sent: Tuesday, January 7, 2025=
 8:07 PM
> >=20
> > On Tue, Jan 07, 2025 at 12:20:47PM -0800, mhkelley58@gmail.com wrote:
> > > +VMBus devices are identified by class and instance GUID. (See section
> > > +"VMBus device creation/deletion" in
> > > +Documentation/virt/hyperv/vmbus.rst.) Upon resume from hibernation,
> > > +the resume functions expect that the devices offered by Hyper-V have
> > > +the same class/instance GUIDs as the devices present at the time of
> > > +hibernation. Having the same class/instance GUIDs allows the offered
> > > +devices to be matched to the primary VMBus channel data structures in
> > > +the memory of the now resumed hibernation image. If any devices are
> > > +offered that don't match primary VMBus channel data structures that
> > > +already exist, they are processed normally as newly added devices. If
> > > +primary VMBus channels that exist in the resumed hibernation image a=
re
> > > +not matched with a device offered in the resumed VM, the resume
> > > +sequence waits for 10 seconds, then proceeds. But the unmatched devi=
ce
> > > +is likely to cause errors in the resumed VM.
> >=20
> > Did you mean for example, conflicting synthetic NICs?
>=20
> In the resumed hibernation image, the unmatched device is in a weird
> state where it is exist and has a driver, but is no longer "open" in the =
VMBus
> layer. Any attempt to do I/O to the device will fail, and interrupts rece=
ived
> from the device are ignored. Presumably there's user space software or a
> network connection that has the device open and expects to be able to
> interact with it. That software will error out due to the I/O failure.
>=20
> I haven't thought through all the implications of such a scenario, so
> just left the documentation as "likely to cause errors" without going
> into detail. It's an unsupported scenario, so not likely something that
> will be improved.
>=20
> I don't think the issue is necessarily conflicting NICs, though if a NIC =
with
> a different instance GUID was offered, it would show up as a new NIC
> in the resumed image, and that might cause conflicts/confusion with
> the "dead" NIC.

Understand.

>=20
> >=20
> > > +The Linux ends of Hyper-V sockets are forced closed at the time of
> > > +hibernation. The guest can't force closing the host end of the socke=
t,
> > > +but any host-side actions on the host end will produce an error.
> >=20
> > Nothing can be done on host-side?
>=20
> Not really.  Whatever host-side software that is using the Hyper-V
> socket will just get an error that next time it tries to do I/O over
> the socket.
>=20
> Is there something you had in mind that the host could/should do?

None really.

>=20
> >=20
> > > +Virtual PCI devices are physical PCI devices that are mapped directly
> > > +into the VM's physical address space so the VM can interact directly
> > > +the hardware. vPCI devices include those accessed via what Hyper-V
> > "... interact directly with the hardware."
>=20
> Thanks for your careful reading.  I'll add the missing "with".  :-)
>=20
> > > +calls "Discrete Device Assignment" (DDA), as well as SR-IOV NIC
> > > +Virtual Functions (VF) devices. See Documentation/virt/hyperv/vpci.r=
st.
> > > +
> > > <snipped>...
> > > +SR-IOV NIC VFs similarly have a VMBus identity as well as a PCI
> > > +identity, and overall are processed similarly to DDA devices. A
> > > +difference is that VFs are not offered to the VM during initial boot
> > > +of the VM. Instead, the VMBus synthetic NIC driver first starts
> > > +operating and communicates to Hyper-V that it is prepared to accept a
> > > +VF, and then the VF offer is made. However, if the VMBus connection =
is
> > > +unloaded and then re-established without the VM being rebooted (as
> > > +happens in Steps 3 and 5 in the Detailed Hibernation Sequence above,
> > > +and similarly in the Detailed Resume Sequence), VFs are already part
> >                                                   "... that are already=
 ..."
>=20
> Right. I'll fix this wording problem as well.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--Ovyy0gUq7zMeP6EX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ35FpwAKCRD2uYlJVVFO
oxPKAP0XC8l/vuGJ5lYvorjMxiURQaPKFIFcmBV864e8/1YYaAD5AXgZz5KYLwIq
4FhUgbtfufp4Hw3znaLUUThvDfmy9AE=
=hGJ8
-----END PGP SIGNATURE-----

--Ovyy0gUq7zMeP6EX--

