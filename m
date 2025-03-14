Return-Path: <linux-hyperv+bounces-4502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE9A6184B
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683A618898EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F32045B2;
	Fri, 14 Mar 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6pv0Qui"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162D14375C;
	Fri, 14 Mar 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974118; cv=none; b=nytsQXcDqiy7PT1kSI1NDZ3eJuoaCqO7dZ3hzgRl43K5HflmkjMXD7oDWDGnEURd37/CwO1J2/HyDRK6xbr/TSi/MXY3BRMVTTDEGphx/ate77f/kQsFT5eA15CBP6Qn0yI1EsEk0DUJ1FKnKyMgQctsmHONrHEnn2+LIX+GGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974118; c=relaxed/simple;
	bh=nPIQa2zqNUwoVtbHR8A/I61uNaClpZ9/aE7Xl1KoV9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrEncjH0ES88NlRjkzJWoozLKzQADR/d5YEHtCPQbh/MBWsFJzkIJTDB5E6IKtXGKjx5p4c1qS7hZ6/l8NZ+9ZYhXEaXkppiQZ8st9c4VUvMFIaY7EQIGsmhz5kWh8r+gCklVgMRjdTIySTOb9nGaV6aA1/2gVZb+9pdNsqz06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6pv0Qui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51CFC4CEE9;
	Fri, 14 Mar 2025 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974118;
	bh=nPIQa2zqNUwoVtbHR8A/I61uNaClpZ9/aE7Xl1KoV9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6pv0QuiHYPrup6eHKszrLbHgWXLDutEIIZ2foZpIllM11XGA9B0l6nxEHDmXpinT
	 C8t1I7QFNkOSypjwZXptYBMFk1V/mYFqpuXyxRNBaueKqNQ1poVjdFviw9wVaZv/86
	 R7Reh/SPAXraeKZWHtrMJpFUxvhREQFmScRtxzMONBtpKIDWUZHc5889QJ8m4aq7UD
	 cedM6YS6ZYI0Y+O9XJk9sbCwIU8d/EuVulQ2W/5MFRKZZ5x1IsPy3b5iRbDDd7XmI6
	 7OnMy9Ts6tkgwq4BxkM3O5WTBiNvvEdr3M8Su/VbZaE96RCiNvtnCxcWRu6SZWQ46u
	 +uBxWspqOPccA==
Date: Fri, 14 Mar 2025 17:41:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	Tianyu Lan <tiala@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/Hyperv: Fix check of return value from snp_set_vmsa()
Message-ID: <Z9RqZPc2nMs-R-RZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250313085217.45483-1-ltykernel@gmail.com>
 <SN6PR02MB41577FAB4DD56699D48B8106D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMvTesChp_kSNrJA6oCu8iZ6xFQReckRQU-_EGO7jjBPD_FUJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvTesChp_kSNrJA6oCu8iZ6xFQReckRQU-_EGO7jjBPD_FUJQ@mail.gmail.com>

On Fri, Mar 14, 2025 at 09:41:30AM +0800, Tianyu Lan wrote:
> On Fri, Mar 14, 2025 at 4:20 AM Michael Kelley <mhklinux@outlook.com> wrote:
> >
> > From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, March 13, 2025 1:52 AM
> > >
> > > snp_set_vmsa() returns 0 as success result and so fix it.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> > > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > > ---
> > >  arch/x86/hyperv/ivm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > > index ec7880271cf9..77bf05f06b9e 100644
> > > --- a/arch/x86/hyperv/ivm.c
> > > +++ b/arch/x86/hyperv/ivm.c
> > > @@ -338,7 +338,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> > >       vmsa->sev_features = sev_status >> 2;
> > >
> > >       ret = snp_set_vmsa(vmsa, true);
> > > -     if (!ret) {
> > > +     if (ret) {
> > >               pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> > >               free_page((u64)vmsa);
> > >               return ret;
> > > --
> > > 2.25.1
> > >
> >
> > Yes, with this change the code is now consistent with other call sites for
> > snp_set_vmsa() and for direct invocation of rmpadjust().
> >
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> Thank you for your review, Michael!

Applied to hyperv-next. Thanks.

Wei.

