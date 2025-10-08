Return-Path: <linux-hyperv+bounces-7148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EFBC6D95
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A573AF8C4
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D62C15AC;
	Wed,  8 Oct 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYkCLU0W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AF29AB13
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Oct 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965630; cv=none; b=bxY7qupvDHrkMGAlHe6qrbwR9t+r6vnkT2cW1qi2rQvQnHXZx7M9CDZWzuuhBm98/mnuihZWjZsem+TfXxBfwy+OEyohcLN+vdHTvESraHfxJhA24V0XiDaX3tvl6wsi2HDY4t/meWkwly7QdMYmVcTq2LFNGHJ4oI2fdslneD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965630; c=relaxed/simple;
	bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGg8GGS9tgV9PVzLnH3V4mT5HN1ixCCTu1UA2foRpFah6EKpAIgU8xCFmHfnMu3Xzwg48R4W9Rs18tf6cYeQOSwA+JbCHUtIeZu4SPIN7YFcEeh/70SHEqUc2LEgqjFZnAygQLihpU/KzGsOJm+MIO9yHWrxywdayjN/knxBfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYkCLU0W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-28832ad6f64so4090025ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Oct 2025 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759965628; x=1760570428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
        b=eYkCLU0WkNktpp4jLKV7h39Fh+oz8/jVxRbarBo5DBJA1+lg298DEOoMo5G2/CqBHg
         XV7zj5WQcsDRcULzxa2dFJHsbHWwuG4UJrHzckQhN/XBMPAU3axB8q0EHyih9FW225oo
         d+THtmwDKsami6HIRQgsUgAdFC3kt24AnS73GUyURtQopSqaErgpT+w43ttVj8wgAq/y
         O1810n6PPiRbOX4aDGjlKce0/2fNhqUz6dlfMEozJzOFF/H0mA77Vstqlh4Ya94JgRY0
         M6Sn5mQeBw/HPZ/ywE+XCuLeiTemwuz97NzbYYmqvbn4gFsztV+hmaGF/ifhKgZiU7j0
         pr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759965628; x=1760570428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
        b=vnGbQeG93sXZFLdbelkHXIVnWXVNQ+mju2ffz8BlgpBu+xL+7uYkLY4kQ2T/66C2vA
         s+qDZp4EU7iSEENmZLrzgRLWPhAcGWDG4HcxnGv8YGRURKL9hCKybrWJcj/We4LfUr/X
         D9M93y7prPqdjMQiruf4L0qVLWoe7BJpLdqMIU8o4NET4rz/iABViw3UUbjKrEtdaAhQ
         s1yOcbiqJ27bdS0TYMRRj61Sdsjug+RAwHJOLoN2k75MexSuZwN9HSR2sKYqJAKOfO35
         UGMkswhCgCOYcL8vama6L0qwhjK4EhBpIpP/4VkNCqNwY2Tq97pS/i1zqO0r19fzp33f
         dL4A==
X-Forwarded-Encrypted: i=1; AJvYcCVC5Bds5Cs2wXyNI2EIPlLMi0kGlLx9NvTDWAcI3FGrsM9T32LsuEfBaqlsMUO/BhqL/DZ1KxKkrO+9DrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsO2EQ+ChBd2l9gDR28qTTMSzKY4sStbcrJOOld4LeutW96N/j
	4SgiWmaQrJnLHOsoW0ubnsF1WB/gEarqn4Stt+0m5zgI+mAjpf7RM7B6FgjhczaV
X-Gm-Gg: ASbGnctJSV5kFVBxWsp4VQg2eTYYlbX39lco1f6OWTtTvt/CAoQZdV/Q6uVNPZQ0zZK
	orC5KmLIEt8BUca3JCTxEAjx5mY3B+nZoJnRrn2VcfW0qkFRhfctNn/fsOJn0jzN7Ox9Hpg5sOt
	YHfCprKAOmua3e/0P+AR6ckcDw8o92jYuDYX7ki8IR84FdcaN/AlYml8vX7aCU1NpgyVKDPagCe
	5r121M/A5YwZh7tYtsOtLmhjucFmoxpepu88uh5lso1CEcceuV/RQlu+MFqGIEGHqkf9vmxYhf9
	OmRbI648oyXtZA5vC1vvOeE/9/BPAehAIFiRAuhjV8uRAc6Eo2UN85ldd9gU4YwTK6hFDzFNVJB
	v8rtZxz5qLKh7vGsQ1ton2zVP1rFS7c8Ql7WTP/icrndzCu12Ww==
X-Google-Smtp-Source: AGHT+IGPI2MExiSfnnLPYD+tUnOJs0Zg7egrbTgL9CdVjSBxNVuUdrol/TpXRHHhafhK1jcIWh4STg==
X-Received: by 2002:a17:903:40c9:b0:27e:d9a0:ba08 with SMTP id d9443c01a7336-290272e3b3emr66288225ad.43.1759965627774;
        Wed, 08 Oct 2025 16:20:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ffd77sm4824305a91.7.2025.10.08.16.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 16:20:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0666D4233432; Thu, 09 Oct 2025 06:20:24 +0700 (WIB)
Date: Thu, 9 Oct 2025 06:20:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aObxuPcUDHzcWoir@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
 <aOWouGarxf0FB7ZR@archie.me>
 <f1cd86d1-3a59-4bfa-ae97-3ab092a1f3d3@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M44Aw6fd2pjuHLwf"
Content-Disposition: inline
In-Reply-To: <f1cd86d1-3a59-4bfa-ae97-3ab092a1f3d3@linux.microsoft.com>


--M44Aw6fd2pjuHLwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 03:11:35PM -0700, Roman Kisel wrote:
>=20
>=20
> On 10/7/2025 4:56 PM, Bagas Sanjaya wrote:
> > On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
> > >=20
> > >=20
> > > On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> > > > On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> > > > > +The data is transferred directly between the VM and a vPCI devic=
e (a.k.a.
> > > > > +a PCI pass-thru device, see :doc:`vpci`) that is directly assign=
ed to VTL2
> > > > > +and that supports encrypted memory. In such a case, neither the =
host partition
> > > >=20
> > > > Nit: You can also write the cross-reference simply as vpci.rst.
> > > >=20
> > >=20
> > > Thanks for helping out! I could not find that way of cross-referencing
> > > in the Sphinx documentation though:
> > > https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-ref=
erencing-documents
> >=20
> > That's kernel-specific extension (see Documentation/doc-guide/sphinx.rs=
t).
> >=20
>=20
> Thanks, got it! So far, in my experience, that doesn't work for PDFs.
>=20
> > >=20
> > > I tried it out anyway. The suggestion worked out only for the HTML
> > > documentation, and would not work for the PDF one. Options attempted:
> > >=20
> > > 1. vpci
> > > 2. vpci.rst
> > > 3. Documentation/virt/hyperv/vpci
> > > 4. Documentation/virt/hyperv/vpci.rst
> > >=20
> > > and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
> > > generated a hyperlink in HTML.
> >=20
> > That's it.
> >=20
> > Thanks.
> >=20
>=20
> I found in the document you referred to ("1.3.4 Cross-referencing") that
>=20
> "Cross-referencing from one documentation page to another can be done
> simply by writing the path to the document file, no special syntax
> required."
>=20
> From the document, that relies on some additional processing within the
> kernel tree (above you mentioned that, too), and that doesn't seem to
> work for PDFs. I'll stick to the :doc: syntax then used in the patch.
> I'll investigate separately why the additional processing that allows to
> simplify syntax works for HTMLs only.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--M44Aw6fd2pjuHLwf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaObxuAAKCRD2uYlJVVFO
o07sAP9qQrckotDpQU+Wf0v1I+327Okq0ZEldg97vKf558qkKwD/ecnMknqaTLqj
pTkwfBiapQdzY3ss+QylP9Vu4xQzpAo=
=zcax
-----END PGP SIGNATURE-----

--M44Aw6fd2pjuHLwf--

