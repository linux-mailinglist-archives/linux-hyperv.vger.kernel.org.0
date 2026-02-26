Return-Path: <linux-hyperv+bounces-9005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCGLLjonoGk6fwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9005-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:58:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E81A4B99
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83B093145BD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2835314A9D;
	Thu, 26 Feb 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn5UWUJR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F1319852
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103120; cv=pass; b=Zq11mDBleoVe07nHcGpM4KPdR4FpDaS2CNjaRoIbE0h0jqT/vEv1LWyrjJ6R1sHqxVhRX2fKQgKkntTjnDkU2/Cia2Qf0tUHEEe6r0vpjG0Fn7ZNSNB/Lub17tT698V2z/6qdhimjqLiDxzBaB1sCLiOs34wiqvvXUiaOChJp64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103120; c=relaxed/simple;
	bh=lBZgmn88L59xR9hNb2uEM1QlFuV/xpQVkJqTMpZiKAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaM2Et1mwspAcWIV6cd/XZncZoLO7twyHQZUuI9iPRK0tc8UakiELMDVIiRF3G6aaSimz5UqPQcj7XNw9AUSMAOuNqxvZlc7y2zyAuQ2p6AI3HNZVqyBzjgQyMP8asiPTRMMz+JdKpU1shEDK+0nYl4Tfo1tGfnRfITHHYfTO/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn5UWUJR; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-389f173b91fso6293591fa.1
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 02:51:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772103117; cv=none;
        d=google.com; s=arc-20240605;
        b=WZYjC5/X6U48m4gxSatE7+pRaagXrbODjJp1x4ULsRKYU/+RdNR2aAjEQs4tEa2c4R
         7aMax/JHE/SdU7q2HC+GXqUTKnRc02hEd+8JtZFDQxhlOtyzyx1rFUx7BIGPtvRJc2n8
         b+wmEwrV2sOBdSZ/bmz0ZevcGTIiRLGO62EBmqo/s/EZtGEFS8RMzJ9p3baq+2cLwAHo
         8JVTJBijK415gCEhCZdUmFpRtpHsROKJiG6XYw7B0KWtE7H40FFGGVts3uES9wYSW/0e
         f9Zy2k9v3LpSE8w9MOWcxF7R5jB9JwuaI56mYKe88U6DxwhiasAMrQnC+KFMx7jvbAlw
         zqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7zFmjmjWqxk+bR6vHh9xW3qhF2JzFjUYITKd/jdYtk=;
        fh=9OYOvVAm6RYhboJW/8dbHA6fImpBDNZwnUOTQaPQJ+8=;
        b=QDMms+7HKmAnkDA9tQi50ZW10swKDExExDnOzq6V/7BhPrS0YzBy481eDCccVEQf8m
         Dwld2qB0fu9N1+/qSgMbx6kcJTJY1mLtCqYPwQFNa7seV40y1LQFuVu+urrNKchbkGfs
         9xxvA4/YYkTHZQeEYGJB3x9UQSltIGDkBeUMbuTSOwn1XQs04uM9OHKxAc5cw7GgAkAt
         vujOf7QXP7xchXqjJLboQmGyfkhCYfPXTCy8MR+yj7R8uLsbTuwdJLRY1FMUyyb60Tuc
         FTNJjMuNmN3cEEoqFmfpDNquy4TWqr4S7FVv+NZooJWDPjVVIlX2kVyFx4eELkfeYUnt
         TPOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772103117; x=1772707917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7zFmjmjWqxk+bR6vHh9xW3qhF2JzFjUYITKd/jdYtk=;
        b=cn5UWUJRb/p+rTNZaoPVEJT2KO0HTFPT7Fqd4TsPJkDyvaI7ynOCcfdKeYWeJnolz2
         TlgyJUKn0pD/TeVDOVoIyZyaVypKk+yYp37Ooq9Iy/q8Wa6lRMs/aRkKKWNeHZwoYVvT
         htrRVUG84Bzk79O5X0LjtIY44XRsb1GmQCoDty4BS/8PO7cHuXm9PWkKGPy+w78QmakW
         quAmoQa1wiugJc99GBfvMl+Se0tkidK/0f9WNdlyICQnVL1D1HAEdVUUok4ILQ4x9vH9
         pPtNy7lgaoEsf1qdvRMr1uVUja1vWRbn3tcINa9INiVsvooRCCrcBIDh2gCSCLua19Ue
         SJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772103117; x=1772707917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7zFmjmjWqxk+bR6vHh9xW3qhF2JzFjUYITKd/jdYtk=;
        b=iyQX40wnVES+SkM9wvCUTGmtMk6BMgmOVpXFyOD4h42y2YXJZfKbGpTteds5tenD3M
         prkJdwdHMm6LjZ+oqeIKDjA2ND4VGVXd7kn8jveUq5CPuZZa3YZFJ4BM7EgP+w16ttmj
         cguTI+ES/gCT+iDPT0Hti18Dzh0pRExx3eCVFvQFk+zuTuiBy8z3sMRdQpWKUwhfiRoc
         ulKfRUYKSgaoJSu/XzQTx/Iruyk38eemya+0iqZnt1BKpSFFQgTcbWdnb/vgqhjAglOf
         6ZCIZkwcL35morBZGqIYi1PE/U6OTinGw9EfGEGZlzfzP9l2WfHyt74UGVy2iFTyyq6K
         uAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5BCx7RYLvSqAUOkLS4BbHSqnMI1YnnMoEHsJjYO184lcAk3It5+C1H2BwYSUvlaKBvfvKg3fzkH9mbD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/GMSqJkOUGpjkOUEcE7w2UR3LH6fuuKxeFISvTIvshEw+Kqu
	acf1vQXcpleoJWZ4TNfjSHhP5W4mO6XQICumcLL/EcR78CVjKpv3xZIg5jyvY3D6P4n8nNhtOAa
	DUGpO7/IK+W81aqJEJaWwloWLRwK1NVo=
X-Gm-Gg: ATEYQzys+1Jd46AdNuwAyTVNDjSvE5N67an2EeFNI7TFFr16M+bvvxUMSfNsf0UpIVM
	GqPy0j+bn6cLmJUlrt/dPz3u88o8VxaIPjsvOANVQL2wR/E7vdtRgwjMRQQW2MKFGnko2BGm2E2
	EhyASuiAOC4WHqdcwAyS8Cn33hm9+xukjOUVuPSiFGulTT7X29YupIRHCmIFVng/n/qRmPhp0wI
	qKHuR1gkLnj4loPIMhnfCV6cF9a6Ckv2pfnXWwaPgyCTR3VSIa8OTSUA3KdHkzVY+0s0brT93l4
	IjJ4T1FuktDS9pHVG/UICStTZ7z4gae7t/iTljuTPcdm2d/sXh9E4ELXfoiC8Nx8vPwH7XUNnS9
	4g+colvX1ehoogwMC/NR9qE2kdhJndS/6Uuat5RZPerSVPA==
X-Received: by 2002:a05:651c:210e:b0:387:17e6:1dd9 with SMTP id
 38308e7fff4ca-389f2fcdfb5mr6028551fa.23.1772103116966; Thu, 26 Feb 2026
 02:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226095056.46410-2-ardb+git@google.com> <CAFULd4aSAdKV7XtASr_uQz5hA4qBbWeO-nfgKb979HkwZDbQ_w@mail.gmail.com>
 <ac6778bd-a701-47e6-8521-768726246ce9@app.fastmail.com>
In-Reply-To: <ac6778bd-a701-47e6-8521-768726246ce9@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 26 Feb 2026 11:51:45 +0100
X-Gm-Features: AaiRm52KF72si08AYeqfaPFGLnBKSBIw_Z5Fl4Ot7Ulh80qqecaiL2t13R_zZCo
Message-ID: <CAFULd4b_m3G5vdtCKm9u2x6NXpK9j1W78ZJzverCe14==6pxbg@mail.gmail.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9005-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,git];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hv_crash_ctxt.es:url]
X-Rspamd-Queue-Id: 1C8E81A4B99
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:48=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Hi Uros,
>
> On Thu, 26 Feb 2026, at 11:35, Uros Bizjak wrote:
> > On Thu, Feb 26, 2026 at 10:51=E2=80=AFAM Ard Biesheuvel <ardb+git@googl=
e.com> wrote:
> >>
> >> From: Ard Biesheuvel <ardb@kernel.org>
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
> >> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection =
into vmcore")
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >> Build tested only.
> >>
> >> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> >> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> >> Cc: Wei Liu <wei.liu@kernel.org>
> >> Cc: Dexuan Cui <decui@microsoft.com>
> >> Cc: Long Li <longli@microsoft.com>
> >> Cc: Thomas Gleixner <tglx@kernel.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Uros Bizjak <ubizjak@gmail.com>
> >> Cc: linux-hyperv@vger.kernel.org
> >>
> >>  arch/x86/hyperv/hv_crash.c | 80 ++++++++++----------
> >>  1 file changed, 42 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> >> index a78e4fed5720..d77766e8d37e 100644
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
> >> +
> >>  /*
> >>   * This is the C entry point from the asm glue code after the disable=
 hypercall.
> >>   * We enter here in IA32-e long mode, ie, full 64bit mode running on =
kernel
> >> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)
> >>   * available. We restore kernel GDT, and rest of the context, and con=
tinue
> >>   * to kexec.
> >>   */
> >> -static asmlinkage void __noreturn hv_crash_c_entry(void)
> >> +static void __naked hv_crash_c_entry(void)
> >>  {
> >> -       struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt;
> >> -
> >>         /* first thing, restore kernel gdt */
> >> -       native_load_gdt(&ctxt->gdtr);
> >> +       asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
> >>
> >> -       asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> >> -       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> >> +       asm volatile("movw %%ax, %%ss" : : "a"(hv_crash_ctxt.ss));
> >> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
> >>
> >> -       asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
> >> -       asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
> >> -       asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
> >> -       asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
> >> +       asm volatile("movw %%ax, %%ds" : : "a"(hv_crash_ctxt.ds));
> >> +       asm volatile("movw %%ax, %%es" : : "a"(hv_crash_ctxt.es));
> >> +       asm volatile("movw %%ax, %%fs" : : "a"(hv_crash_ctxt.fs));
> >> +       asm volatile("movw %%ax, %%gs" : : "a"(hv_crash_ctxt.gs));
> >>
> >> -       native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
> >> -       asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
> >> +       hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
> >> +       asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
> >>
> >> -       asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
> >> -       asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
> >> -       asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
> >> +       asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
> >> +       asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
> >> +       asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
> >>
> >> -       native_load_idt(&ctxt->idtr);
> >> -       native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
> >> -       native_wrmsrq(MSR_EFER, ctxt->efer);
> >> +       asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
> >> +       hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
> >> +       hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
> >>
> >>         /* restore the original kernel CS now via far return */
> >> -       asm volatile("movzwq %0, %%rax\n\t"
> >> -                    "pushq %%rax\n\t"
> >> -                    "pushq $1f\n\t"
> >> -                    "lretq\n\t"
> >> -                    "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
> >> -
> >> -       /* We are in asmlinkage without stack frame, hence make C func=
tion
> >> -        * calls which will buy stack frames.
> >> -        */
> >> -       hv_crash_restore_tss();
> >> -       hv_crash_clear_kernpt();
> >> -
> >> -       /* we are now fully in devirtualized normal kernel mode */
> >> -       __crash_kexec(NULL);
> >> -
> >> -       hv_panic_timeout_reboot();
> >> +       asm volatile("pushq     %q0             \n\t"
> >> +                    "leaq      %c1(%%rip), %q0 \n\t"
> >
> > You can use %a1 instead of %c1(%%rip).
> >
>
> Nice.
>
> >> +                    "pushq     %q0             \n\t"
> >> +                    "lretq                     \n\t"
> >
> > No need for terminating \n\t after the last insn in the asm template.
> >
> >> +                    :: "a"(hv_crash_ctxt.cs), "i"(hv_crash_handle));
> >
> > Pedantically, you need ': "+a"(...) : "i"(...)' here.
> >
>
> Right, so the compiler knows that the register will be updated by the asm=
() block. But what is preventing it from writing back this value to hv_cras=
h_ctxt.cs? The generated code doesn't seem to do so, but the semantics of "=
+r" suggest otherwise AIUI.
>
> The code following the asm() block is unreachable anyway, so it doesn't r=
eally matter either way in practice. Just curious ...

Oh, you just need a temporary here... the original is OK. Indeed, "+r"
will write back the value to the memory location, and this is not what
we want here.

Uros.

