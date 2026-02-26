Return-Path: <linux-hyperv+bounces-9004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPEzDf4koGkDfwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9004-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:48:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21D1A4871
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6547130166F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EB3081C2;
	Thu, 26 Feb 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpBJ+v5Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE5302750
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102903; cv=none; b=ZuYfHE9KoaxghtnJKbM8gs9FivPDYbvpZb+yiCafBL0qCOGcGvkvxVp8rosSBjWNZPQkW4ju6ObJRDMXXKXZr72bmAGJJrVGBtsbVx8vmZrczpLCeJ9xhnke3E7+j9h6A5CK8KpK5J8jJ4VUNQLApeaYZLcRkmWKematKmBIrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102903; c=relaxed/simple;
	bh=OAQmUhK72ZpUG6vh2IK2DIM8apvGn6pylDPMvamhBIU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CCVTI517J8o27dFqkNSY3SBuxmWB6102lkb+AT7RC2B1K1V7ScXUB9Ggu0mLPNP1pW9X9rcy+hbaxQ/Z9t4pyP3YL/n7qroOou4lHzau1ncIVQaGvm+CXf6jMTYlU+c3DDyW2BQ56SwJ9yVLlIYw8Tn02vOMCCKMzAILu65lLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpBJ+v5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8BEC116C6;
	Thu, 26 Feb 2026 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772102903;
	bh=OAQmUhK72ZpUG6vh2IK2DIM8apvGn6pylDPMvamhBIU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IpBJ+v5Y1Dgsg4FOKcS4Ku81LMWgHstKZCKm8I/czobW7JjEQ3i/jO59vKYwd7o+Z
	 UyEFujkmy3aow5ESX/9/veelCV6Mwls/gx6sPX4dQHNaib8vUSNrA/GS/Vrr6LJAxO
	 SxcSvZAjQLJA86i+egpZciV/869cVg/Zuol923dD03tNyMolXhph9/Kz4A9Mi4rBTh
	 8lVihdLhPOog/L2S5Ul0p1KtFMUo/TB0OoS/QzIN5Ed/7F3YFmidojrrjugeyJt8V9
	 QIQLIk83RzBnoeETgI58AbEnbo1SjEv3YBdkK2FnHxRX+gWAFB44XzxVQvHKF5Vl70
	 tG9upBFBAr9dw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B937FF40069;
	Thu, 26 Feb 2026 05:48:21 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 05:48:21 -0500
X-ME-Sender: <xms:9SSgaRo6K4OZCl9oLwzIapMubm5gTJri2R3Iauk-hkwnizAIqCpdrg>
    <xme:9SSgaefsIadywMCdpfiT1bSx2r5dzbSBByHsGfrRDFCQfbXOCd7w05bstKGDi7QL0
    xlOecgumPqOKqM1pA0zdiSfXKgGmBvAQfNbHwwrROQ_SJSgytuQVKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuhgsihiijhgrkhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrrhgusgdoghhithesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghirdhlih
    husehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrrghthhhorheslhhinhhugidrmh
    hitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgtrhhoshhofhht
    rdgtohhmpdhrtghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:9SSgafhPpdX-zBIWD6wKa9f8GI6Zuz5_Oi0OmnHNAEf6t_IgcKh_nA>
    <xmx:9SSgaTmsbZxGVYYzjM-I3OUQMg3fJtq4ahtV9LLrSUJpswvYqwbq7w>
    <xmx:9SSgaeuUpHCwaGSJYftdBMRMa1MjOMHLoe6H87UlJQeXpLy83WAAEQ>
    <xmx:9SSgaZDpNZqQRJty1v4cICOKrdriWfXLAQ-L9ZZvWL5Ll5H0z-rEAw>
    <xmx:9SSgaTVa3V0sUBrck_g-wt8tyO6-WVbznx-GPcBlDXC6TCN6H8uhT0Wo>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E1C5700065; Thu, 26 Feb 2026 05:48:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZdU3QzfaZ07
Date: Thu, 26 Feb 2026 11:48:01 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Uros Bizjak" <ubizjak@gmail.com>, "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org
Message-Id: <ac6778bd-a701-47e6-8521-768726246ce9@app.fastmail.com>
In-Reply-To: 
 <CAFULd4aSAdKV7XtASr_uQz5hA4qBbWeO-nfgKb979HkwZDbQ_w@mail.gmail.com>
References: <20260226095056.46410-2-ardb+git@google.com>
 <CAFULd4aSAdKV7XtASr_uQz5hA4qBbWeO-nfgKb979HkwZDbQ_w@mail.gmail.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9004-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,git];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF21D1A4871
X-Rspamd-Action: no action

Hi Uros,

On Thu, 26 Feb 2026, at 11:35, Uros Bizjak wrote:
> On Thu, Feb 26, 2026 at 10:51=E2=80=AFAM Ard Biesheuvel <ardb+git@goog=
le.com> wrote:
>>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> hv_crash_c_entry() is a C function that is entered without a stack,
>> and this is only allowed for functions that have the __naked attribut=
e,
>> which informs the compiler that it must not emit the usual prologue a=
nd
>> epilogue or emit any other kind of instrumentation that relies on a
>> stack frame.
>>
>> So split up the function, and set the __naked attribute on the initial
>> part that sets up the stack, GDT, IDT and other pieces that are needed
>> for ordinary C execution. Given that function calls are not permitted
>> either, use the existing long return coded in an asm() block to call =
the
>> second part of the function, which is an ordinary function that is
>> permitted to call other functions as usual.
>>
>> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection=
 into vmcore")
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> Build tested only.
>>
>> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Long Li <longli@microsoft.com>
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Uros Bizjak <ubizjak@gmail.com>
>> Cc: linux-hyperv@vger.kernel.org
>>
>>  arch/x86/hyperv/hv_crash.c | 80 ++++++++++----------
>>  1 file changed, 42 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
>> index a78e4fed5720..d77766e8d37e 100644
>> --- a/arch/x86/hyperv/hv_crash.c
>> +++ b/arch/x86/hyperv/hv_crash.c
>> @@ -107,14 +107,12 @@ static void __noreturn hv_panic_timeout_reboot(=
void)
>>                 cpu_relax();
>>  }
>>
>> -/* This cannot be inlined as it needs stack */
>> -static noinline __noclone void hv_crash_restore_tss(void)
>> +static void hv_crash_restore_tss(void)
>>  {
>>         load_TR_desc();
>>  }
>>
>> -/* This cannot be inlined as it needs stack */
>> -static noinline void hv_crash_clear_kernpt(void)
>> +static void hv_crash_clear_kernpt(void)
>>  {
>>         pgd_t *pgd;
>>         p4d_t *p4d;
>> @@ -125,6 +123,25 @@ static noinline void hv_crash_clear_kernpt(void)
>>         native_p4d_clear(p4d);
>>  }
>>
>> +
>> +static void __noreturn hv_crash_handle(void)
>> +{
>> +       hv_crash_restore_tss();
>> +       hv_crash_clear_kernpt();
>> +
>> +       /* we are now fully in devirtualized normal kernel mode */
>> +       __crash_kexec(NULL);
>> +
>> +       hv_panic_timeout_reboot();
>> +}
>> +
>> +/*
>> + * __naked functions do not permit function calls, not even to __alw=
ays_inline
>> + * functions that only contain asm() blocks themselves. So use a mac=
ro instead.
>> + */
>> +#define hv_wrmsr(msr, val) \
>> +       asm("wrmsr" :: "c"(msr), "a"((u32)val), "d"((u32)(val >> 32))=
 : "memory")
>> +
>>  /*
>>   * This is the C entry point from the asm glue code after the disabl=
e hypercall.
>>   * We enter here in IA32-e long mode, ie, full 64bit mode running on=
 kernel
>> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void)
>>   * available. We restore kernel GDT, and rest of the context, and co=
ntinue
>>   * to kexec.
>>   */
>> -static asmlinkage void __noreturn hv_crash_c_entry(void)
>> +static void __naked hv_crash_c_entry(void)
>>  {
>> -       struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt;
>> -
>>         /* first thing, restore kernel gdt */
>> -       native_load_gdt(&ctxt->gdtr);
>> +       asm volatile("lgdt %0" : : "m" (hv_crash_ctxt.gdtr));
>>
>> -       asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>> -       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>> +       asm volatile("movw %%ax, %%ss" : : "a"(hv_crash_ctxt.ss));
>> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
>>
>> -       asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
>> -       asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
>> -       asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
>> -       asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
>> +       asm volatile("movw %%ax, %%ds" : : "a"(hv_crash_ctxt.ds));
>> +       asm volatile("movw %%ax, %%es" : : "a"(hv_crash_ctxt.es));
>> +       asm volatile("movw %%ax, %%fs" : : "a"(hv_crash_ctxt.fs));
>> +       asm volatile("movw %%ax, %%gs" : : "a"(hv_crash_ctxt.gs));
>>
>> -       native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
>> -       asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
>> +       hv_wrmsr(MSR_IA32_CR_PAT, hv_crash_ctxt.pat);
>> +       asm volatile("movq %0, %%cr0" : : "r"(hv_crash_ctxt.cr0));
>>
>> -       asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
>> -       asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
>> -       asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
>> +       asm volatile("movq %0, %%cr8" : : "r"(hv_crash_ctxt.cr8));
>> +       asm volatile("movq %0, %%cr4" : : "r"(hv_crash_ctxt.cr4));
>> +       asm volatile("movq %0, %%cr2" : : "r"(hv_crash_ctxt.cr4));
>>
>> -       native_load_idt(&ctxt->idtr);
>> -       native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
>> -       native_wrmsrq(MSR_EFER, ctxt->efer);
>> +       asm volatile("lidt %0" : : "m" (hv_crash_ctxt.idtr));
>> +       hv_wrmsr(MSR_GS_BASE, hv_crash_ctxt.gsbase);
>> +       hv_wrmsr(MSR_EFER, hv_crash_ctxt.efer);
>>
>>         /* restore the original kernel CS now via far return */
>> -       asm volatile("movzwq %0, %%rax\n\t"
>> -                    "pushq %%rax\n\t"
>> -                    "pushq $1f\n\t"
>> -                    "lretq\n\t"
>> -                    "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
>> -
>> -       /* We are in asmlinkage without stack frame, hence make C fun=
ction
>> -        * calls which will buy stack frames.
>> -        */
>> -       hv_crash_restore_tss();
>> -       hv_crash_clear_kernpt();
>> -
>> -       /* we are now fully in devirtualized normal kernel mode */
>> -       __crash_kexec(NULL);
>> -
>> -       hv_panic_timeout_reboot();
>> +       asm volatile("pushq     %q0             \n\t"
>> +                    "leaq      %c1(%%rip), %q0 \n\t"
>
> You can use %a1 instead of %c1(%%rip).
>

Nice.

>> +                    "pushq     %q0             \n\t"
>> +                    "lretq                     \n\t"
>
> No need for terminating \n\t after the last insn in the asm template.
>
>> +                    :: "a"(hv_crash_ctxt.cs), "i"(hv_crash_handle));
>
> Pedantically, you need ': "+a"(...) : "i"(...)' here.
>

Right, so the compiler knows that the register will be updated by the as=
m() block. But what is preventing it from writing back this value to hv_=
crash_ctxt.cs? The generated code doesn't seem to do so, but the semanti=
cs of "+r" suggest otherwise AIUI.

The code following the asm() block is unreachable anyway, so it doesn't =
really matter either way in practice. Just curious ...

