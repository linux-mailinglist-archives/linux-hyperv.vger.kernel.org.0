Return-Path: <linux-hyperv+bounces-7741-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B31C77CF8
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269014EAF8F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E1305E3F;
	Fri, 21 Nov 2025 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo6tf/ls"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D633375A4
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712595; cv=none; b=YT2IhXoqi3/d7gj52Lj5tr0g6HXPVNhITNJLcPzrNbFTXHEWXohB6axOaB3uoxe0mOYKg4T6F9ITNj/h0ywVecEFutkSFA0Zue/1g1rZWQYrcqbP5YpFwV8cO26Ee89/m6ffXIxOhuR8CJvw3wBbj8gBsD9e9zL07YLnBYWGOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712595; c=relaxed/simple;
	bh=zdCRY2T6aJQzhbmON8O3KRUgmRk7a2jIQLsaPu+D4iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkVEk0avmJwod1vu9YJspUkDHafjw0np8yeP6o8KOvzx0y/8kJHRcwsBS9vQJ85cD1fPwrCEPgdQad0U9OiOCSU5c0yu6TQMnwMwa1CSCxG5vnaiM//HUEghrD3pWWT+x+ES0nmdcS1CIQVvn9IZL6own9LilXdmLqamNptU24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo6tf/ls; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37b495ce059so14352671fa.0
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 00:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763712592; x=1764317392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kUJ9RcKJhG9LinHueO+MWyEw0Sz9WNiKd8OaGRbCEc=;
        b=Wo6tf/lsw4eexw4HUOPGLZ7DiJspoE7sBofPKYfqAvdlVRWHTNi7VXWduQlCXu/sAr
         WkIwNNRTjnZFTFDT2RKzw2927oUFpeJbfpk8jalUK6NsgBGKDzpyyPSASwB4UFFVf2hs
         /VCwQXYne1kTZj6NspFfbSXFhCQu5rrAA1h/eTI2AE/4ePzqHIHw+74KHM2W6b4lfOTk
         tv6+tl0svXJ4c66SpNhmaQVDuH77MGppRO0RgpGQjA9Yk4uQm/KiZMaOkbr+/j60wrBH
         R6R5P6+MPV9dInmPGb1XnWWzezGBplo7c+FmZuDRuYnWmlrO3HRHPQqs6kIXnRjzUuYx
         2iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763712592; x=1764317392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kUJ9RcKJhG9LinHueO+MWyEw0Sz9WNiKd8OaGRbCEc=;
        b=q4zRz6zUpegqkXCK/ygaTqsX2gZEHvxZrFL1F9nK1x9xixmLFPn1Kwl2WLkPfIxkJH
         nZUUt/s5nVKp4YT72XQoUDnQ0f9rdPVCeI5/2GaYXFhnxHj0LV80oiXlhdD/sT4rU5k+
         KvDaBxJgdHLFADI0/8klVizDhpl64CseIrhZbIXHhmqditJovA64EMICfMEoJobneKZF
         7EkgtNMHGQMx8/FgjJ+UFUzd9qEi3i5v2aI3x9uy3lnKYSJ8A1E38I6IegihMlZ/2ZXD
         xgyBPeRKtzCZI22fhOcfC0VSSlP0mXTcVE3/ht6hqPk7rLmFf5o0mFthWNG9jIj60YaL
         L2pg==
X-Gm-Message-State: AOJu0YzWabvsOpe2SrELdlGIAkJei/OR7qa5yXvdQpBXunMG5//SlEJ+
	jm7iL7GF5uLmjTQROMMeer3BKwjRv8trmxCZgctgpfqwmJd7xQx7ixciHy8kJJWDu1jgQRwRO9X
	1p8yrZDoqyKQKAGq5mz6o/V3FWNYsbbI=
X-Gm-Gg: ASbGnct9Olwh/ETqbM8sK9LbOlOuNJhTTcjxKSo3OcwMdusHBVUY+DrMyjx3fWmT/a2
	MPBOMTjK8jU9pUHCYepDNwS9UQ9JTC7xI0+Ma75KT5XIjdQD46XBvfR7jlxMXplDDkz8iNr3bDU
	rIb1qCa2/p7ISNmbsYwO6FkiXUU/jhhrJ3/WVlkEFHBnuSB59KIFwfwSqePIMDBavIbKM9dwcfB
	VU2Rt7KR0Dm7GdoIFtdmtd2n7AUnvGc6aT3f2JOldUxg/eJC43iTpEV9k125lkRgxTOWKTTBySX
	EO2Wqw==
X-Google-Smtp-Source: AGHT+IHKT/dl+Bb5pmkPwif9lR6rb/vSd4My/N8B0GTWiU6PbPGZSgg8xmyW1QPS21mxg9zMTWWzNIPzitGnql2xLPc=
X-Received: by 2002:a05:651c:31d1:b0:37a:5cb7:968f with SMTP id
 38308e7fff4ca-37cd924d252mr4385411fa.29.1763712591500; Fri, 21 Nov 2025
 00:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120134105.189753-1-ubizjak@gmail.com> <SN6PR02MB41571E23242892F03B528C56D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41571E23242892F03B528C56D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Nov 2025 09:09:40 +0100
X-Gm-Features: AWmQ_bluc3ZPusc0e1J0rgcN2xbuBuagn9aVK0xodafRGWLRM_c-3KuggTnMX9I
Message-ID: <CAFULd4Z=ZkOR5qiRxE-5LTyn=FrjtDTbjRRQP2n08kDEbc4_aA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Use MOVL when reading segment registers
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:03=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Uros Bizjak <ubizjak@gmail.com>
> >
> > Use MOVL when reading segment registers to avoid 0x66 operand-size
> > override insn prefix. The segment value is always 16-bit and gets
> > zero-extended to the full 32-bit size.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > ---
> >  arch/x86/include/asm/segment.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segm=
ent.h
> > index f59ae7186940..9f5be2bbd291 100644
> > --- a/arch/x86/include/asm/segment.h
> > +++ b/arch/x86/include/asm/segment.h
> > @@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short =
value)
> >   * Save a segment register away:
> >   */
> >  #define savesegment(seg, value)                              \
> > -     asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> > +     asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
> >
> >  #endif /* !__ASSEMBLER__ */
> >  #endif /* __KERNEL__ */
> > --
> > 2.51.1
> >
>
> I've built a linux-next20251119 kernel plus the three patches in this
> series, and tested it in an SEV-SNP VM in the Azure public cloud. The VM
> is a Standard DC16ads v5 (16 vcpus, 64 GiB memory) running Ubuntu
> 20.04. It boots and does basic smoke tests with no issues. So, for all
> three patches,
>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
>
> I do have a comment on the commit message for Patch 3 (I would have
> replied there, but for unknown reasons the third patch didn't show up
> in my LKML feed). The commit message says "VMMCALL ... may be inserted
> before the frame pointer". This text was somewhat ambiguous to me.
> I initially read it as "the compiler might insert VMCALL before the
> frame pointer is set up". But I think you meant "it's OK to allow the
> compiler to insert the VMMCALL before the frame point is set up".
> Maybe the intended meaning is obvious to experts in this area,
> but I'm new enough that it was confusing to me. ;-)
>
> To avoid any future confusion, I'd suggest this wording, which is explici=
t
> about why this patch is appropriate:
>
> Unlike the CALL instruction, VMMCALL does not push to the stack, so
> it's OK to allow the compiler to insert it before the frame pointer gets
> set up by the containing function. ASM_CALL_CONSTRAINT is for CALLs
> that must be after the frame pointer is set up, so it is over-constrainin=
g
> here and can be removed.
>
> FWIW, removing the ASM_CALL_CONSTRAINT does not change
> the generated code for hv_snp_hypercall().

Michael,

thanks for your testing and rewording suggestion! After reading it
again a couple of times, I agree that the original text is a bit too
terse, and adding your words indeed clear it up considerably! I have
changed the patch description as you proposed in v2.

BR,
Uros.

