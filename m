Return-Path: <linux-hyperv+bounces-9065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DUkILAao2lD9wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9065-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 17:41:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB51C4625
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A8DD30630DE
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5702FBE1F;
	Sat, 28 Feb 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLGcnneO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEED2D97A6
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296877; cv=none; b=kBRG5D6zj/t8RRCD4LqntYgoL+0R2d5IM4vwXZK38t6r9IV7ipc5GAKFq+0V8aRbIl9cDagD81FfEVDSKqT1MmF4eE74lnKOD4rce/5T2CCYdxWVP+j/bP9ZcPf5/ANkf2hOZQlHYp5k4bNbOKDEVY4UajD0MtGXQvJQJtsKHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296877; c=relaxed/simple;
	bh=vNpaSDYpd9w1K/bZT8htDFDgOc5/vHZmU9FD3I1Dnbs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tpG1hWcCKlv/peW2bliRpy4t90suWHNSLORFL67edJ3J3ziakb+MWaM2mhPmyG+bHojCgfXNEjEWZvVrCtcp0ilGWEttUZN5akC6iKt9KYMQEym9J4cMp1jCRheD/Kkvzb0J9CcERe/EWhwnupLQirU1pAqjLkNwbS5zZiX3K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLGcnneO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0EFC4AF09;
	Sat, 28 Feb 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296876;
	bh=vNpaSDYpd9w1K/bZT8htDFDgOc5/vHZmU9FD3I1Dnbs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dLGcnneO+l3V2cRhlL47jGBcOHbobR6LxbF3hNH3htaT3Hu/1L175Y8SDAaqpwTlu
	 KEzGlz2QIEGlHd+TFnft/b3zu4AiJm8Ml0uCVL3jOo9klqD0dlFSGShA/PC1z0pDtI
	 JkaTmTuhkqmmlpNlfyH01PLeISlaN8vj3CDQ5fpwUUNySTvlSUPH+bS4cfycGCDcqf
	 tWuur+/ubUoNPtswEASYRAL3fXB8If5FUICJMI86H+wclTETh69ZPniq9dmn/RxQNr
	 0Atz4BB7qUyEqWLXBVHU5Ez+YbspPwN/C1H0tGDltaIJ9oYQz51z9JCYo5irJ3NAVT
	 TyWZdFzvWzyiw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C067CF4008C;
	Sat, 28 Feb 2026 11:41:15 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Sat, 28 Feb 2026 11:41:15 -0500
X-ME-Sender: <xms:qxqjad9R3gFnYJTiTL3O6QpwgnJIryQBvtBfQFgVtWGM297Vboqs6A>
    <xme:qxqjacgJWkBUFCEbefpAwClm0otc0OZnqDEI83Z4K1bp3dZqGOuLLLFxOaQQrTee6
    3Utk7ZalBbr_an1xpxsVFyTPIkSAkWhr57-3n-Mk7myKRxtAmRjq2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrnhgurhgvfidrtghoohhpvghrfeestghithhrihigrdgtohhmpdhrtghpthhtoh
    epuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopeifvghirdhlihhusehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmrhgrthhhohhrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqhhihphgvrhhvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qxqjadgyMaVUW5GXcnR7m2oAmfWm11hBSw54xHpRkcHxxOUOMIaa5A>
    <xmx:qxqjaRGxKUeGu1YGpvo0mCrXBl-lJX50lKssBTDZMayFLRST5GQIRQ>
    <xmx:qxqjaTRoDk_KIuxHU_j_50bQnAiVA5g7cQWvkAGz9jsVbob9OG_rbg>
    <xmx:qxqjaewzmjchypUbT6_KZKa2AYe8eRIELwVou7ech7CxF5-qQhxZrw>
    <xmx:qxqjafexHOXLmFTngDoIVoZsmCh4BEcN0-tT3lFtDXj5P9OZeqq-evPX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A41F6700065; Sat, 28 Feb 2026 11:41:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_ejbntDxbYw
Date: Sat, 28 Feb 2026 17:40:55 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Uros Bizjak" <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Andrew Cooper" <andrew.cooper3@citrix.com>,
 linux-hyperv@vger.kernel.org
Message-Id: <7c7cd72e-fd46-4f77-8bf7-8d538fec0a52@app.fastmail.com>
In-Reply-To: 
 <CAFULd4YM=D9+akehA5h_sC-97otYyv1Nxr2neE8bD1AoW-8ocQ@mail.gmail.com>
References: <20260227224030.299993-2-ardb@kernel.org>
 <CAFULd4YM=D9+akehA5h_sC-97otYyv1Nxr2neE8bD1AoW-8ocQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9065-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,citrix.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 29BB51C4625
X-Rspamd-Action: no action



On Sat, 28 Feb 2026, at 11:17, Uros Bizjak wrote:
> On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
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
>> Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Uros Bizjak <ubizjak@gmail.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: linux-hyperv@vger.kernel.org
>> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection=
 into vmcore")
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> v2: apply some asm tweaks suggested by Uros and Andrew
>>
>>  arch/x86/hyperv/hv_crash.c | 79 ++++++++++----------
>>  1 file changed, 41 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
>> index 92da1b4f2e73..1c0965eb346e 100644
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
>
> This one should be defined as "asm volatile", otherwise the compiler
> will remove it (it has no outputs used later in the code!).

An asm() block with only input operands does not need to be marked as vo=
latile to prevent it from being optimized away.

> Also, it
> should be defined as "asm volatile" when it is important that the insn
> stays where it is, relative to other "asm volatile"s. Otherwise, the
> compiler is free to schedule other insns, including other "asm
> volatile"s around . Since this macro is also used to update
> MSR_GS_BASE (so it affects memory in case of %gs prefixed access),
> "memory" clobber should remain).
>

All the other asm() blocks except the last one read from memory, and hv_=
msr() has a memory clobber. So I don't think there is any legal transfor=
mation that the compiler might apply except perhaps re-ordering it with =
the final asm() block doing the long return.

So I don't see any reason for volatile on hv_msr(). However, I do see a =
potential issue with the compiler assuming that code after the final asm=
() block is reachable, and calling unreachable() is not permitted [by Cl=
ang] due to the __naked attribute.

Would it be better to add a memory clobber to that one as well?


