Return-Path: <linux-hyperv+bounces-9067-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDSqOjwyo2kE+QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9067-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 19:21:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708A1C5B53
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92F7D311F980
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81604A13BD;
	Sat, 28 Feb 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5qfb5Ag"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347444A1386
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300076; cv=pass; b=Z+aOlHnp9N2CXch8wh8twb9JYV6F4WZi0PL6IYO9azKTRZCZO4vDFJjyUajhY6SdjwguZjpKASw1mCwzhp19wu4xxdcHg8WTXYPBo0zhRpiMZAjvyjiCNN+PwqncawZ3dnmCNS4vSRJVwXxMgF74fPCW6z9nCRUO2yZWVDrOR4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300076; c=relaxed/simple;
	bh=F81ZEOjBA5tTpCYpCr36MoJoBnw5rylxtDQwON2eMec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usu+vzV/jwnLrNdkb6VhmvfPuWdEIb53KuqL9YOPYP7/KYzo1s/wuuAPQX3e+BW6JcgyREKeKsyUDIagvXTksZnWTnSZ2hR78fevasHbzTwc6vOwVvcT0YJ8N6Ysn7Ap98MRs75cFKOSndnbi8YdyvoPlRicXkmIqMmMHXHwlVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5qfb5Ag; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-389fad34e2eso42961131fa.3
        for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 09:34:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772300073; cv=none;
        d=google.com; s=arc-20240605;
        b=kRmqSjng7B5OFqbHn0P+bZ4YSg0+v5tI2S/mwg0s7aOwAKFowfsOzRuoXWa7V+V0XN
         +JBu6uPvrIe/uZHDw/i1al0pACD6qam+sBxO4aJHNJwrMFJFJVQy2Ujf2OzcU0E8NztR
         v5gac/Jy5C1NS/n5J6Kd4Yh47+1PFcOpN+IicAdrutaNbPY9DH1HkPDp3rsLlcqX4LN8
         WubBn7Q707GN8BeNb5UxjX/R2oVowr/jMXB5B1pDqf9NR/5Rf6fPzj4Qc0osX/DA6Wu4
         UZZVkAfPxB/ChK187QeqH+N+xKprUZfKd80mgsij+2aiIOfhOUgGQvxXObUNpuetCy3X
         yjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEkLc4tmER/yqfvFYAC/4zKD6sPpdthlHB2AJLA8p94=;
        fh=ReDsR1FJpoFcaDr9HWrj1l4LSrsfKTRAtShJ6FoO6D0=;
        b=VLPAndMpCLSG7h2Zbzd4JKT848phdTrAfeqLEofxap93rmxOow29sETzTtKVaKMC9O
         COMmh1H0pMSi3dly3tJ8olHLghZgPVmfmP0oJ/mgpF87UOXCbRwWxJDsUre83aAwxQIs
         Rw8q/4CjBX/Te5hxvGHlC5UA6Es0VmNK43MUx62FDaZBUj2hRJ2m7uAvjY/dXq6CuAfT
         gPCziTfW9i+X/o5aYnhuhVTaGTwy6kYhy0qYTSKgpxFjjqjWrfWhosaPCfVkDqc7N5NT
         SSOhoNRyrJ9P4OO2llboFHMmP+DM2A+E3ULspfBomcFh9AG5Putc/Cf4h7dmjGdv62rM
         m1bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772300073; x=1772904873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEkLc4tmER/yqfvFYAC/4zKD6sPpdthlHB2AJLA8p94=;
        b=O5qfb5AgweBaPhGvNlC0nz4sg0xIWsE6GbKeBo4vkSQo3DxPTdaEdTOiG46fkMiweT
         T1RA0QYIWFzZJGZqOwbGkn3QMaeEKIwxvNseHmoCvdFYbe97eV7HuBmwmuIabbed1ysn
         8lNSYpWwxuhxAkwI9+PbMKC+H5aLAddb3WR0+W2MhC4mLJxAp4XdVydMHWNfR1E5N90/
         dA/9BvSYwYNrYiIm6nnr8OiXZXRsj05Rup/RYTdcrZ2zAG63a9nPyWs2vI/+Ho42IgLS
         eC+EH7FlnBUUh2SOXPoxG+9sQhHEfMZoelGeK13j4x5AIy65HJ3xYKHoRnBus5uvPJgB
         7yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300073; x=1772904873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEkLc4tmER/yqfvFYAC/4zKD6sPpdthlHB2AJLA8p94=;
        b=v/gVdL7opv43ctdbbp8CCkf+JQUw8bh0imIcdyyvd/b/Xzi0aKGlhRG1HBdtmu6jQv
         Xi+mP8hN+FkR7EygAVTcZuMlkf1ecDFMh2xfj64+hkh2t4y+AG3+5cq2kg7YO+ANupg/
         YNHTgE6CaAR7LunWXEGjldGjcR32MBG3Zk769er6WcAoaZmsj8mwHlDEMeQh9jPFH04A
         JAW0LcCj7hJ66dzY+Kd0D4vD9/JDuVp5k+fE+BzE0J1RTA2HhhL1dUEk1k5l//EQWbiP
         +1+YbGPT6T8P6M7gn3gmK7tV5xxmkyOd5bUjQ+Hptq7l/N4Lj4jvYsT3rOFpfJmrJt7a
         N06Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPegEgL+yldOngD9+zL4RQK0UxfkUQbi4n2zFMCpy5e9vJoSuw/nCmkwnPiMyqR8SWT78HZzCg6sWtTUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hjf5lxb729/CNYpL+gbE83O5WGO9/5pgiSkIWqU4wh4iSUUT
	6qCeD1JB+tFG01nYUTm/4WIm6fEW50EoYoMLy4uhqcEc+/MGjccgF2P38uQqa4nKYt45JBtrkc6
	p+jTDhfmsApsJy6LUQY8VFVr/0n+yyns=
X-Gm-Gg: ATEYQzy0nAHuoQNRBcl7E5Y30HXR4VIWwDFVHEQyct0bL2lK00+RO1PSBrUAGl23lbc
	sReqN6QOgip27T5OLN7deFVoGMGvpI8exD8R2JBBpUTFMB5Osn8eJnubjlHM+SksI4vEWndYnC4
	Cs0aysb+aLSBGmVGP9Vr3ftKAcF/aC15QNcVkN/rDsrheKQvAV4O7327+r28zumKPFnaDhQljQy
	KytUPoyKiQRQcr0It3PbMGGXVvvNomw6oIHUtyiOPuuge6RE5HV9uGQdnDgEG/5wP4jov7qn3sn
	r4gL6eQDl/35FA7uWDMf6i95ukCNzRzrxDQqOlm1a5drRRF55s9g492j+j8Zy0ZNpMoaFHW459q
	DiJwwLZPrSykKaGe/PXrzO1eFkqjezp4Q
X-Received: by 2002:a05:651c:b21:b0:383:1b4b:c2c8 with SMTP id
 38308e7fff4ca-389ff365720mr41483751fa.41.1772300073131; Sat, 28 Feb 2026
 09:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227224030.299993-2-ardb@kernel.org> <CAFULd4YM=D9+akehA5h_sC-97otYyv1Nxr2neE8bD1AoW-8ocQ@mail.gmail.com>
 <7c7cd72e-fd46-4f77-8bf7-8d538fec0a52@app.fastmail.com>
In-Reply-To: <7c7cd72e-fd46-4f77-8bf7-8d538fec0a52@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 28 Feb 2026 18:34:21 +0100
X-Gm-Features: AaiRm53HtGykWm5SMl07CrbiMIDo3KlEogTS_EoDWJuQuV-NTi4tuIjWAd1YSTU
Message-ID: <CAFULd4YTkLLdvjTtGXtHgsZCiEMXAYXcjSwciwdsE-RGvnVrdg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9067-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,citrix.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1708A1C5B53
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 5:41=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
>
>
> On Sat, 28 Feb 2026, at 11:17, Uros Bizjak wrote:
> > On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> >>
> >> hv_crash_c_entry() is a C function that is entered without a stack,
> >> and this is only allowed for functions that have the __naked attribute=
,
> >> which informs the compiler that it must not emit the usual prologue an=
d
> >> epilogue or emit any other kind of instrumentation that relies on a
> >> stack frame.
> >>
> >> So split up the function, and set the __naked attribute on the initial
> >> part that sets up the stack, GDT, IDT and other pieces that are needed
> >> for ordinary C execution. Given that function calls are not permitted
> >> either, use the existing long return coded in an asm() block to call t=
he
> >> second part of the function, which is an ordinary function that is
> >> permitted to call other functions as usual.
> >>
> >> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> Cc: Wei Liu <wei.liu@kernel.org>
> >> Cc: Uros Bizjak <ubizjak@gmail.com>
> >> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> >> Cc: linux-hyperv@vger.kernel.org
> >> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection =
into vmcore")
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >> v2: apply some asm tweaks suggested by Uros and Andrew
> >>
> >>  arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
> >>  1 file changed, 41 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> >> index 92da1b4f2e73..1c0965eb346e 100644
> >> --- a/arch/x86/hyperv/hv_crash.c
> >> +++ b/arch/x86/hyperv/hv_crash.c
> >> @@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(v=
oid)
> >>                 cpu_relax();
> >>  }
> >>
> >> -/* This cannot be inlined as it needs stack */
> >> -static noinline __noclone void hv_crash_restore_tss(void)
> >> +static void hv_crash_restore_tss(void)
> >>  {
> >>         load_TR_desc();
> >>  }
> >>
> >> -/* This cannot be inlined as it needs stack */
> >> -static noinline void hv_crash_clear_kernpt(void)
> >> +static void hv_crash_clear_kernpt(void)
> >>  {
> >>         pgd_t *pgd;
> >>         p4d_t *p4d;
> >> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
> >>         native_p4d_clear(p4d);
> >>  }
> >>
> >> +
> >> +static void __noreturn hv_crash_handle(void)
> >> +{
> >> +       hv_crash_restore_tss();
> >> +       hv_crash_clear_kernpt();
> >> +
> >> +       /* we are now fully in devirtualized normal kernel mode */
> >> +       __crash_kexec(NULL);
> >> +
> >> +       hv_panic_timeout_reboot();
> >> +}
> >> +
> >> +/*
> >> + * __naked functions do not permit function calls, not even to __alwa=
ys_inline
> >> + * functions that only contain asm() blocks themselves. So use a macr=
o instead.
> >> + */
> >> +#define hv_wrmsr(msr, val) \
> >> +       asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) =
: "memory")
> >
> > This one should be defined as "asm volatile", otherwise the compiler
> > will remove it (it has no outputs used later in the code!).
>
> An asm() block with only input operands does not need to be marked as vol=
atile to prevent it from being optimized away.

Oh, you are right in this detail. It won't be removed, but insn
reordering is still allowed (the ones without memory access when
"memory" clobber is also used).

> > Also, it
> > should be defined as "asm volatile" when it is important that the insn
> > stays where it is, relative to other "asm volatile"s. Otherwise, the
> > compiler is free to schedule other insns, including other "asm
> > volatile"s around . Since this macro is also used to update
> > MSR_GS_BASE (so it affects memory in case of %gs prefixed access),
> > "memory" clobber should remain).
> >
>
> All the other asm() blocks except the last one read from memory, and hv_m=
sr() has a memory clobber. So I don't think there is any legal transformati=
on that the compiler might apply except perhaps re-ordering it with the fin=
al asm() block doing the long return.

The last asm() block also reads from the memory, so it is OK here, too.
>
> So I don't see any reason for volatile on hv_msr(). However, I do see a p=
otential issue with the compiler assuming that code after the final asm() b=
lock is reachable, and calling unreachable() is not permitted [by Clang] du=
e to the __naked attribute.

As far as the compiler is concerned, there is "nothing" after the last
asm() block. It can be marked with noreturn attribute, but I don't
know how it interacts with the naked attribute.
>
> Would it be better to add a memory clobber to that one as well?

But the last asm() block also reads from memory, this prevents
scheduling of asm() with memory clobber around it.

Uros.

