Return-Path: <linux-hyperv+bounces-4495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80DAA6071B
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 02:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D093419C12C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4A15E8B;
	Fri, 14 Mar 2025 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibqK9IVj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B942E339D;
	Fri, 14 Mar 2025 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916531; cv=none; b=iITAo4ko01JF7pT6Yi4wKShgzCNaoVqlAGoi6Wc7SVmRuGwLFMDiMCRB1AIh9i1oXfOaA1Zw5mQLkJg6Q02RpUx31fS/5jBJ+MNEnZKFOwP23w29i19hcZT1iNfmsB0SlLHSVCBzA32uZrISFdw0UHeFflnm8sYqoneWCvLb8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916531; c=relaxed/simple;
	bh=nxeynpp2GhM8NkuPL/rtAUAixamX6LE58LdKt000WG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz05d7DIOHO+toW6SMUjhrWsLsaigNmsEn3noowcNU7wJpOdi2qCSV709pqyiDQw96grM69cHKgoptelzDrgTay63xoumUdUXGgiYXPLIjDFGkYtswbhIk9IBsf1zxL0IGmlH/wmdisr6/F3JLdRTpmeiRxdbojlGBU6wWbb+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibqK9IVj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso2903158a12.0;
        Thu, 13 Mar 2025 18:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741916528; x=1742521328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKbM0Y1xm2LvTjDY1gdE9vVuc5IoEqPbsZvGMSSIoY4=;
        b=ibqK9IVjnDOsL263kbWrkifbIKFt4d4apsR/K+jsMCA1wgMkHqT7x0U3O8BgdF5qIZ
         w7Cfp9o2yJWXcFh98xNy8Hur+xKhfandhEeRhHlkcItGiBJn7eIGzAvo/q1WiSSu8HIq
         RRnSOZPKXFBX4PpqGoCkQ68xk6Jj+/+uzVt7mS9+qvChZ3sUPkTJZaLFUY/iHHkB5WDM
         Xc61vfl1ZsodDG59GDMr26aMW5UIuJ5g/LaqokZSM0yw/FDW4EtI7vpuYbFqanCFYZ8B
         oA3NSz+uHIXrZW8osVyP0wrIbi4moezxq3kWIs8mkl82OF+H0cuLR+rP0qfU9KT3p8fP
         XDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741916528; x=1742521328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKbM0Y1xm2LvTjDY1gdE9vVuc5IoEqPbsZvGMSSIoY4=;
        b=PxL9FdB+aC1Ff5IrQPxaYrTVOxq/sPvq+w+ZevpXSizfVeDhyQFB2aYr5onuwChChA
         Vrxc3NOR84/Jdc36dL3sbQko0C2NFQpKERvAiyqUCQPi2dSVLxdpEn1B2rGxAWKFFfth
         tgxsOb2vgvl4G+KKzFj2qKIp9o2TWrX0NW34Aq0kJG3/KgnLWDCKOf86LjRP2LvhXGYc
         LvepXwbjmJzWHpTDWnPODWgTVXBDCsWH0Jyv2LtLv0SSI9CufbRw6pgv/41+sROUCKGw
         yCHQ3zWapZz0DxM7DdT/8jhw4mLasbCtY1eK4zkXtBM645JzbuJum8e++ya8Np5vBYNP
         OdIA==
X-Forwarded-Encrypted: i=1; AJvYcCV6idP+c49TpLtHTVj9Qt4BDtaJgkb1zneQCT8Yc6Glx+BbOZaVxuYVXGmCQJnZhEGCw5MInXIOhWRUZTpd@vger.kernel.org, AJvYcCWXKaF2pS8wG1C8MlTMOKrGmXL1mxW5Bp7Hktd/t0pZ7Ow3fVi6nS7ZcuhJnhl/XLrzylf/nrDB@vger.kernel.org, AJvYcCXJoFV2EPTV9MuNGzc1xHdaZK2949qtapWckY+piBqlHbJZ0DRP1txn9e4Bxpb3nidJRAELlqroFA+eqro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFiQcPtzSkVaQbMoxq/lqW/Aq65Rq4f7I1EAS62ihijN8l4j5
	mpJUdU9WL3SSrU/PgaKnpS6IQO0d/5t/s6VWHHUgEfyC8055fQtzPyJimi++vCWMQRq/gOecFQ3
	bo3U6oVpj2j1r7sLLdAvqcVWyx+E=
X-Gm-Gg: ASbGncsMKtRkxAWdXC/vawAmT0X/LE2TtjmBEs+tO91jLAOFmNMedKARbkOcvdZOdqg
	PBelNVPFEVdyCFwHBabsukrq+csPV5k+ht2wqpNFMlf0jPbuy8fUCL116ii+KJGttFm/VbcQvET
	gtICKUjlIxKhfAyG2gGdRauyUsRWttR4N+1aHd3fwFSqYi
X-Google-Smtp-Source: AGHT+IF92Uz41eVjchIp+LLcwbwRxAp5s/KzrGp/+rtX/sO4N5rfVPhj49jIFasGVb1D6W//3SRtOYa2ZuTJKMVGt48=
X-Received: by 2002:a05:6402:27d1:b0:5e4:d229:ad3d with SMTP id
 4fb4d7f45d1cf-5e89fa4e9ccmr686122a12.16.1741916528140; Thu, 13 Mar 2025
 18:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313085217.45483-1-ltykernel@gmail.com> <SN6PR02MB41577FAB4DD56699D48B8106D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41577FAB4DD56699D48B8106D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 14 Mar 2025 09:41:30 +0800
X-Gm-Features: AQ5f1JqUKAR3LzE9lrqxUKVuG-3AmtG7kgxxPntUrxsdt9pMNXzewRpxZidevQs
Message-ID: <CAMvTesChp_kSNrJA6oCu8iZ6xFQReckRQU-_EGO7jjBPD_FUJQ@mail.gmail.com>
Subject: Re: [PATCH] x86/Hyperv: Fix check of return value from snp_set_vmsa()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:20=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, March 13, 2025 1:5=
2 AM
> >
> > snp_set_vmsa() returns 0 as success result and so fix it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  arch/x86/hyperv/ivm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index ec7880271cf9..77bf05f06b9e 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -338,7 +338,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> >       vmsa->sev_features =3D sev_status >> 2;
> >
> >       ret =3D snp_set_vmsa(vmsa, true);
> > -     if (!ret) {
> > +     if (ret) {
> >               pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> >               free_page((u64)vmsa);
> >               return ret;
> > --
> > 2.25.1
> >
>
> Yes, with this change the code is now consistent with other call sites fo=
r
> snp_set_vmsa() and for direct invocation of rmpadjust().
>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you for your review, Michael!

--=20
Thanks
Tianyu Lan

