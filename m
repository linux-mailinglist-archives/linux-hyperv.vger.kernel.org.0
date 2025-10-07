Return-Path: <linux-hyperv+bounces-7135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346BBC3049
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 01:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0991F3E3DBD
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7F277CBC;
	Tue,  7 Oct 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLz8WOVG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09732036E9
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881407; cv=none; b=DJoWTfrWWzDFJQOGo98K9mBaRCtrgChDrkEAwQwdsjRZovsB1snQ6VGD3nkto+al8y++N1mZwVNYtLZf+UqJqRIWvU4SIOwWW1favUWgtXjmuaCfAQ7sOide37bXliQhE5CfmdSbneL4zhZb83U3mAwEPTJTyNyNvJMMJHc7sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881407; c=relaxed/simple;
	bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFgLkygfjKZbVvc+yiPt8n3FQIKk8TJhX0gOXIve2Q5sKe6rjM7rYdirlbQCfR3IdyvD4V7C19Jkud3d82yQnEPvawXq1hU0YdDqaPzOJoyvtelqRNtjym5980+jecCoar1oaKb6+jX8JAj5txHm8qC5B1r0f2ia2dRWrWF0PWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLz8WOVG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2897522a1dfso68183905ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881405; x=1760486205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=GLz8WOVGheFn3RBJaFY/U1JgK36OepF93uQJoRhispeXsiPtRsLqFhqs63Bjuk1uhM
         ophSCnysgbBUxf6QEwtyqHSxrQCtEuio0YUPZ+P75xhXzgPaYq8etiLstBJaMxfEazRO
         zfuWD1802NUI/eBlw3bkrVEP/DyiYAWp6rn8xoJEiJFUzxdCDUxGIU4quEP0CyJNfHzX
         AudNZqvRYPeEFilDQ8X4nsblrn8i5dGS3ryDCX/NZ9Ve6p6s8c++4i7gfGTF/QfR5pl6
         lFju8eVY8qejuOz/n7RtRApTpjUrMf9ZGDhBo9fhDg+wKnRsrC8zSWMNOUFuPrK7l+x3
         kTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881405; x=1760486205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=JXoFjFRHrRQu4nSvjAPjRi+ChdMWTj8SLLrh8ovxKKvKQkmSX/jKwbXtNMI5yYl/i9
         Vw1MqonibtudMLR8egiff55f14lgLAuLZixkL61FJmPlOj23bhjnaOysxR1SOqxcHRYO
         EX+x3BuHs/DDLv2HeFxYIQ/sff5iUONABKaG3s13OTGlcLplwSBZ/n/y4E51KOm8U66A
         1ifPO4879DLfa3UcaQqksJ73dSFjKCudEuPELIl9/o9IbqB4EEw85YlJ/BnFWQ4ut1tJ
         NFlUB3HDpzkPZj6ud8+lLcfYcjVKEuUFxTFWK7P9i+rqEvI1LxypP8amlSR9ZZ1+st+9
         Oqqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYzV+YAebyx5ZmWOpMIGHETGQD0x0bmm1YEgbSlaPnfLPcsu0KZsQ8ZrGHwNtnW0yuJkpiUX0W0hDOvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9qzr5J7gcMlujh+WFyuoIdd/0/d+piBM0LtCYvYT9x3d/0Xk
	oZw1xDtHBabP0lbaiEge9wJELlYj1M7m1zpsMeP0yJA4uFkccySlFkId
X-Gm-Gg: ASbGncuQ4btx9rJDNugCF3UiDxhS2RyAWOgZj75kjaxrh2+rQryBCkxXOCNwdnb0b1w
	WGD9TG1H5CIbgy5t/qSSNVu1XUv0jFahHDcpNSAbL/EhEasI4QfxcQ/ER1N8g8iYqHMMo1ZQKP7
	zybNfin04aLl+H9UK0F5dk9UvWXtoZAOjmscjZ9GEqu57wUDoDT3uOq80oynC5LTGyKfzc+M9d4
	Ag5I/J9eU6OnqCisFU2YQid12gR5jq70P2SiDl+oJ8IfWDj2p3sIBuYrzbo9F6nBCproTAq7cpb
	9nhp+mdjlJrvVTGvZdutdzDnXzm590WF9k1hPNYCVm7XyHRrUt7frkSscFp5L2jFRzIuqRj4nA3
	wijBeD++R7yzzcwaQpTWqoKu1wc71lHcYMXQ1HWRSCtPi7SKeY+F0ULTxTVFn
X-Google-Smtp-Source: AGHT+IECR12KH7zCTIlL8PskN4SIrX86zChxhzZyqyWEAG+eeOOhmLw/P52uED83EK633yo7c2PQsw==
X-Received: by 2002:a17:903:298e:b0:26c:9b12:2b6d with SMTP id d9443c01a7336-290272b550dmr18677895ad.38.1759881405144;
        Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513ae7d9sm937031a91.24.2025.10.07.16.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:56:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 599D64233430; Wed, 08 Oct 2025 06:56:41 +0700 (WIB)
Date: Wed, 8 Oct 2025 06:56:40 +0700
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
Message-ID: <aOWouGarxf0FB7ZR@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DTXlXJKe31yrlnoK"
Content-Disposition: inline
In-Reply-To: <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>


--DTXlXJKe31yrlnoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
>=20
>=20
> On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> > On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> > > +The data is transferred directly between the VM and a vPCI device (a=
=2Ek.a.
> > > +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned t=
o VTL2
> > > +and that supports encrypted memory. In such a case, neither the host=
 partition
> >=20
> > Nit: You can also write the cross-reference simply as vpci.rst.
> >=20
>=20
> Thanks for helping out! I could not find that way of cross-referencing
> in the Sphinx documentation though:
> https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-referen=
cing-documents

That's kernel-specific extension (see Documentation/doc-guide/sphinx.rst).

>=20
> I tried it out anyway. The suggestion worked out only for the HTML
> documentation, and would not work for the PDF one. Options attempted:
>=20
> 1. vpci
> 2. vpci.rst
> 3. Documentation/virt/hyperv/vpci
> 4. Documentation/virt/hyperv/vpci.rst
>=20
> and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
> generated a hyperlink in HTML.

That's it.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DTXlXJKe31yrlnoK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWotAAKCRD2uYlJVVFO
o/pSAP9eXlQLoQODQqZ+A48QpAAsl+hf9OhLGhdndl6X6JStvAD+OSXtE5WfHadF
FMFMiFdufdHXrrE7npbMx380tvu34Qs=
=nx3N
-----END PGP SIGNATURE-----

--DTXlXJKe31yrlnoK--

