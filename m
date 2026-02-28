Return-Path: <linux-hyperv+bounces-9063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1IpXHrnAomlc5QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9063-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 11:17:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF91C1ED3
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B0CF301BAB0
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FF2E0412;
	Sat, 28 Feb 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRwuq87m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ABE1B424F
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273847; cv=pass; b=H0lRxPTLV8vIxk1ExLJ+YGlks1kInxHclQ8oS+x++dHglMp51rRI2jnrOAGjgeAdCb9s8zl/CfoC6G3AYObsx5NYO+OWlTzaE43zTgdQF7FuH20qy6Sra7Nfg5VeEyVbsT4uEKy3+QfYpVijCvC6E4Fa31JnUzSZgs1NtdRfsqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273847; c=relaxed/simple;
	bh=wsMn+e1ci1g9f029n7Nkbej8nZ0Ig/cgpPhE+rfH+x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWAa/UZi6sFRCuhFhghSbx5mEqYbwNAU4Ocw9AbIsMqORICzdZ1gXg8BEGOFYMv+W/riPPHtRa8Cx8JOVSkv+5hfo8bnJA4imARH26Yp/xJn0dXxe1ThTh4yvQjvV1m9Wcy1+PlEfMnBJa0V36TuALq3nSVPK3YMrMTn9+Px3xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRwuq87m; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870acaf78eso12123601fa.2
        for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 02:17:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772273844; cv=none;
        d=google.com; s=arc-20240605;
        b=WYwXRKRzT4lJPUgbYG4QGqU1mvoYhC46hcjxI4RdewDtlYV6pM8/yNms3ajV4dZaV+
         li0SrL3NX3rNEkD0b/CmNXC1R/ho4U0jsXtcfkm7436bG/S+OEOEXX3uGMdwC4xhPFRZ
         vn7SpZSI5ZIJiWg/F3qsWntmO+kiF8uIQOFUjb2Mzx5Vd2msJpsK/Qo5NqCPozRy+F+i
         R2oFOnOytu/f+yNBEouueFliD6leNgCur2u/K6bfMcxSlmRYf1R7uuJpGFMIzgujiiTn
         Ie6b3jy52Kn6RyX1D6NdHZK7tSPTkwpCzDPl2ANlyS6Qy3V51Q80rhKdoYaYGzbrhIzk
         g00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gc/QSBr3UAzEI5QC0AjKND4jUaBh6rWU3v9kYYdXis=;
        fh=crtL7qgplT7OsbNMmqXmuAJlnBjGJWzOTxOAuNFZpRY=;
        b=Xuz9aSHzBQqWo4nWCL4MUEp90yvA+bLqKDMmgpzXEagkqPgKvgTqWUPkDidF5NMFMJ
         L54HSiEa/FfuI1m0GpcVHawOPsWpvzaRS9IQ8MWKMA9kDQ7OK4nvm2bJg+vpGG1ATegN
         VbdF+ulTMbNAF2yqicYzhOI5SvPSLV8doFvdAyelSoIdzVITRJdinEdSTvHpVZ6SMeGS
         7v3g0VxFvOW0R15GxjQ6HJLoSvo5dTDe0T/eAB30tLiOUo1sSPuIgPwrg23lPAsWswZC
         Jpc5Q3lkn8vCgFhrTZVu8KqPnTNebnuSVi2BYWK4A219OBXieEMxZ+WAEmkR0T7lKwGM
         Zs9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772273844; x=1772878644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gc/QSBr3UAzEI5QC0AjKND4jUaBh6rWU3v9kYYdXis=;
        b=RRwuq87mlPw9prinemS30t77HokYfGAPKTQgPgDCNA6A8v8kpgN1I0LZw27CKgYpjw
         kKjYCUtXvJklAePuJEn+zF9KWDSCcUKoSD5T6F1RhUPIOfihcjU9/YGAuKPU+fY6D8z/
         RM8eFEIqVjjtCt5WUbgZckQe7O23JsJFxrebFtetX/SuxTzlLH3jb2nC/DXcq6ikiYro
         lflGdlSkTCFYdz1MN3CrO91FfY+XEA4Lk5BZeqDUcIyUwdx4N9ahqmrK7WIygLINNr5Q
         003XDR5mfDBvM7JfxBDy7S36G/jQpl5Zp/I7guHnhgpeuprsldd0PeY6OIrPaUH/BfAQ
         Dy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772273844; x=1772878644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gc/QSBr3UAzEI5QC0AjKND4jUaBh6rWU3v9kYYdXis=;
        b=tWY1wyIr+q87EwLPBUlLEnSSAgm3PTEatLlyRMgsvRf05DbkekEczgTlSZyYlpyxlg
         Kv0bl/tmcsQANGni+JnXzvKlNSaGpqdScxbd5daOXoqijou7L9/TXziy/ezGGrzlhCqi
         VYvzhZKY2HQVcENVjjU0wPxM4O8mAT2AiYaUR5MiE865Ht8L53ctLHlKGgYKnwR4FpTF
         ARTCr3VkO4BS0Imxd7UcwfefQ+IYhMvtoPUMBU2Zc6hUpdntvIoql4pD41Qz6TR+wZvQ
         Nbxy8S04hg8brIpxUbrlsW1YSYHFJ375tF5ZDT28bNWZp9gdrqKuFeV3OgdaJMThifAD
         tDmA==
X-Forwarded-Encrypted: i=1; AJvYcCU69V+HXYknXJBpWHZvxPQqiwlVABWCpooJchXJAFwxzbHAoSlfyxnb3NPv353XnW6Jl6rPGn16CeMm5E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZHuNk8CR4ggA8Xjk+f66UER8SYf3yWH+iLzQaHzUd60nJ/CM
	DE1kt7polkvAU7fQtAeumxiNrE61Ys6Ft78mhlXK4KzjazkvMwsBmVD+7T3p682+ccWl/dX2lKP
	jcDpnOgwNpimNMuBUnYCm1CZrw3OgRHk=
X-Gm-Gg: ATEYQzytwExywbs1tAIr5FhOJVtTSgc/bwprMGN8BOxTn2NBqOTuynYSsj+BKj1qVOg
	Cb0XTgP+Bgsa69n1R8H5yKY168NhOmXXgaOrvlr2RtYqBcLx4Obg/eKT/OGlrpEVjNLkUia7re3
	NYvHVdUVUIHqX5CqiFR/3IOBTQRl5r0z+cX5WKJhkWWDgWpVaCJtdHfQCeEO7QOPdysDdYdFcjz
	x7LbFiZIVLgdo4zBW7nlcfXfxPQ7nig+ITJHUu+X08AUJ8VNfqffA7tnnK0VR+s4kp2ABIIL31X
	lA3XCmZarhREo+hxdoNJ8uUGwC1G/V22nz5o58pYG2g85XfCmJGn2yTYFLr3xbV+1lF7afAocrU
	rvoaJo3bU0otMT0wsBuPsvlY31Scq2Olq
X-Received: by 2002:a05:651c:150e:b0:384:9355:6a7e with SMTP id
 38308e7fff4ca-389ff144dcdmr44521161fa.17.1772273843729; Sat, 28 Feb 2026
 02:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227224030.299993-2-ardb@kernel.org>
In-Reply-To: <20260227224030.299993-2-ardb@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 28 Feb 2026 11:17:14 +0100
X-Gm-Features: AaiRm50MZClk3il9d6BNHMgJ5zBNCxWH5AF1QwoBNW7MFOBvrHf1mzO3YlkTKcs
Message-ID: <CAFULd4YM=D9+akehA5h_sC-97otYyv1Nxr2neE8bD1AoW-8ocQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9063-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,citrix.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18AF91C1ED3
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> hv_crash_c_entry() is a C function that is entered without a stack,
> and this is only allowed for functions that have the __naked attribute,
> which informs the compiler that it must not emit the usual prologue and
> epilogue or emit any other kind of instrumentation that relies on a
> stack frame.
>
> So split up the function, and set the __naked attribute on the initial
> part that sets up the stack, GDT, IDT and other pieces that are needed
> for ordinary C execution. Given that function calls are not permitted
> either, use the existing long return coded in an asm() block to call the
> second part of the function, which is an ordinary function that is
> permitted to call other functions as usual.
>
> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: linux-hyperv@vger.kernel.org
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection int=
o vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: apply some asm tweaks suggested by Uros and Andrew
>
>  arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
>  1 file changed, 41 insertions(+), 38 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index 92da1b4f2e73..1c0965eb346e 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(void=
)
>                 cpu_relax();
>  }
>
> -/* This cannot be inlined as it needs stack */
> -static noinline __noclone void hv_crash_restore_tss(void)
> +static void hv_crash_restore_tss(void)
>  {
>         load_TR_desc();
>  }
>
> -/* This cannot be inlined as it needs stack */
> -static noinline void hv_crash_clear_kernpt(void)
> +static void hv_crash_clear_kernpt(void)
>  {
>         pgd_t *pgd;
>         p4d_t *p4d;
> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
>         native_p4d_clear(p4d);
>  }
>
> +
> +static void __noreturn hv_crash_handle(void)
> +{
> +       hv_crash_restore_tss();
> +       hv_crash_clear_kernpt();
> +
> +       /* we are now fully in devirtualized normal kernel mode */
> +       __crash_kexec(NULL);
> +
> +       hv_panic_timeout_reboot();
> +}
> +
> +/*
> + * __naked functions do not permit function calls, not even to __always_=
inline
> + * functions that only contain asm() blocks themselves. So use a macro i=
nstead.
> + */
> +#define hv_wrmsr(msr, val) \
> +       asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32)) : "=
memory")

This one should be defined as "asm volatile", otherwise the compiler
will remove it (it has no outputs used later in the code!). Also, it
should be defined as "asm volatile" when it is important that the insn
stays where it is, relative to other "asm volatile"s. Otherwise, the
compiler is free to schedule other insns, including other "asm
volatile"s around . Since this macro is also used to update
MSR_GS_BASE (so it affects memory in case of %gs prefixed access),
"memory" clobber should remain).

Uros.

