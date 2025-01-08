Return-Path: <linux-hyperv+bounces-3601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C79A051D9
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 05:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1A27A03FF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA719CCF5;
	Wed,  8 Jan 2025 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyOnGQoN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625020B20;
	Wed,  8 Jan 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736309197; cv=none; b=EklphDFyMKUWfAK96Q8Dszi4tuz1tePbrTWndmwF3UrsiThhDZfsA5R4BYedS1p99Dmki/KgpFZxMzwjImmB3kwtlrXmRdZymNk+RdkV1CWFGh3fqfLtKcNeENwVX1wX4cdX9mdMuIQEikVBKDkq3e76OmBsXh6yLff0vxh6V84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736309197; c=relaxed/simple;
	bh=H3Ir9Z6YEOKuNI+Bk8J8mNq/UyY9/Wrb45UUaO9p1P8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7ZARcHOEhniG7rbTLkD5M26pNiwnYodWjYyYEen6QuvLrKxdGn6eTUkjMsnioP2f6kC7KOAWye+aMIWZk3TFodfS9ioymDcdp1YwqDj16UtVxMReANlc8SKQbIE8zdIGUKNqj3IVhyCVozwiY8jVrB9q37O/TfWJwJpBgCixMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyOnGQoN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so212039385ad.1;
        Tue, 07 Jan 2025 20:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736309195; x=1736913995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONfbWeP0iDQviDfnB2GD4XLWQZBCEfcI8wqguNnYwV8=;
        b=WyOnGQoNkcVLf4oefFVng0MRKPXoAg/7/T+Qryf7mivO+vrXyM0jbK5CRhnm0BLWK1
         14vTV9VG3LLyiuKLm2x/hjz57CPFHByPLMIoEbzMeiBS6OyGRbVjDpBKeh0zF7el08MD
         hrXKCIqtfuJrXgv0cGXK8k6dcAMSzHhE6HFvgk/R9bgNPRHY+Rcp3aY2g7N2gw9Jzy58
         h/K+muGbn52urpRk1WjbNPoAlNlxQEAuTpv0a9wwrojoTCXkPsZgmG38mJNVJIiOm7gf
         l9xKcZjICTcyvETFooPd3PTvGSqHSSRw4Rbpkp73ueVAal9AzqzIqw3cy7p4MLwSvu9d
         TZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736309195; x=1736913995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONfbWeP0iDQviDfnB2GD4XLWQZBCEfcI8wqguNnYwV8=;
        b=w8dmPotWBtueU2KQbkCcv/MZyG1gOPzjdnPuL6pgl7TZc8jlM+Qw4RX0pFnN+EkFFn
         TA5SG8JhcV02n7VC76v92cxJquDPaZPK8XKt8TojjCNglJvzOiJ+RMjWhzstZ7nD/KRc
         BC4CX9nXaQkscoZfbL0ZAnrKMKKnXYvA1jrnjXJ98glhUbd6+mz90ZKhftpCxAPQ9f1/
         5wbeh1HAoXFWvIH0K9bSrn/IUHwSZ0KPWVAbKT7ceHcaM4DKycgjO5YUPZBy1dNEI9wy
         2h++pGqULtXPDRUhq5eN07zhqlcWn6cWWKDNMDMkPGTwl83RR5QWdG4x4hfQ3ZNZtFcQ
         zdyg==
X-Forwarded-Encrypted: i=1; AJvYcCVUdVeYZpbdAhpsw3vt2mcGq0Znnxw9arYGmjq58fCQTB015rjSBKLtUGyjQZAIIhrCigtbaQ9fTSY=@vger.kernel.org, AJvYcCWYtASAADt7NaIqOHb+F3O0LcOWHT5Q4dOJ4pcbgg4FnWplv05oJAuVxtYjAsu9J3B6inCYI/fkA/+jsYWQ@vger.kernel.org, AJvYcCXyY9/hKVFunU94Q6sqrWD5rKhVD7czSDeNtUBeFI8sevFyUMU0eOO+x/kbUCdjlsBdoApdSFNfVQdwFwia@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu02UJTDhSw+zb4rDEKA/6nyEYAuq91YaevkNU+FbYRzL2RkeR
	wqIH/mjiruNGGY2pTLU6uBBF8sliktONN7lmIsL9r/Oe2Ww38mEq
X-Gm-Gg: ASbGncu6GdHHLwQTRLcHwWQkdOL3bt4GvRb4oy4PEu0V1dOabI5/u7EstlFwopMD82b
	Hzb5yCNi1J+bK/2zf3l7EJ7Jqn1t28dCj3kbOG4iWJ2uzBXxXF9NQshy4b2lIkuE/9fYH5Sn0K0
	hMLO+ACkKBBTqBalUuYHRX/YsPC6sFC+vAr96QUVvoslFGMZVKMJh8D+tbR/SyvMAmDOE67YAE0
	AfIV1CEBiu2e+MUkaTqJk8C7em0HTehwabYZGmkW57sGulyc0ziJqlQ
X-Google-Smtp-Source: AGHT+IEOOASpxD85SpPsLTkeOZpCqpEWSC//B3nAE3UBolTsjMklHB/Qw7G7kvC4fGdON+ypsLX3FA==
X-Received: by 2002:a17:902:d50d:b0:216:4c88:d939 with SMTP id d9443c01a7336-21a83fc77cemr19688465ad.38.1736309195035;
        Tue, 07 Jan 2025 20:06:35 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f842esm317615005ad.218.2025.01.07.20.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 20:06:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2F983420B892; Wed, 08 Jan 2025 11:06:31 +0700 (WIB)
Date: Wed, 8 Jan 2025 11:06:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Message-ID: <Z335xwWRTjyX0u6G@archie.me>
References: <20250107202047.316025-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="676hDs5ENvvMNeOp"
Content-Disposition: inline
In-Reply-To: <20250107202047.316025-1-mhklinux@outlook.com>


--676hDs5ENvvMNeOp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 12:20:47PM -0800, mhkelley58@gmail.com wrote:
> +VMBus devices are identified by class and instance GUID. (See section
> +"VMBus device creation/deletion" in
> +Documentation/virt/hyperv/vmbus.rst.) Upon resume from hibernation,
> +the resume functions expect that the devices offered by Hyper-V have
> +the same class/instance GUIDs as the devices present at the time of
> +hibernation. Having the same class/instance GUIDs allows the offered
> +devices to be matched to the primary VMBus channel data structures in
> +the memory of the now resumed hibernation image. If any devices are
> +offered that don't match primary VMBus channel data structures that
> +already exist, they are processed normally as newly added devices. If
> +primary VMBus channels that exist in the resumed hibernation image are
> +not matched with a device offered in the resumed VM, the resume
> +sequence waits for 10 seconds, then proceeds. But the unmatched device
> +is likely to cause errors in the resumed VM.

Did you mean for example, conflicting synthetic NICs?

> +The Linux ends of Hyper-V sockets are forced closed at the time of
> +hibernation. The guest can't force closing the host end of the socket,
> +but any host-side actions on the host end will produce an error.

Nothing can be done on host-side?

> +Virtual PCI devices are physical PCI devices that are mapped directly
> +into the VM's physical address space so the VM can interact directly
> +the hardware. vPCI devices include those accessed via what Hyper-V
"... interact directly with the hardware."
> +calls "Discrete Device Assignment" (DDA), as well as SR-IOV NIC
> +Virtual Functions (VF) devices. See Documentation/virt/hyperv/vpci.rst.
> +
> <snipped>...
> +SR-IOV NIC VFs similarly have a VMBus identity as well as a PCI
> +identity, and overall are processed similarly to DDA devices. A
> +difference is that VFs are not offered to the VM during initial boot
> +of the VM. Instead, the VMBus synthetic NIC driver first starts
> +operating and communicates to Hyper-V that it is prepared to accept a
> +VF, and then the VF offer is made. However, if the VMBus connection is
> +unloaded and then re-established without the VM being rebooted (as
> +happens in Steps 3 and 5 in the Detailed Hibernation Sequence above,
> +and similarly in the Detailed Resume Sequence), VFs are already part
                                                  "... that are already ..."
> +of the VM and are offered to the re-established VMBus connection
> +without intervention by the synthetic NIC driver.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--676hDs5ENvvMNeOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ335wwAKCRD2uYlJVVFO
ozuZAQDRYUwxON4iNNRuBnzFnLzs+GvI5MdP6h3woDe7HC8rTQD+MipWV/qOjA0a
Lbm9mU+/hLqVJL8TwD4y178PXfV8PgM=
=Blp1
-----END PGP SIGNATURE-----

--676hDs5ENvvMNeOp--

