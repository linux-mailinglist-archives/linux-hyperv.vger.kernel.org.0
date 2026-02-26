Return-Path: <linux-hyperv+bounces-9007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPGmL79FoGmrhAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9007-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:08:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DE1A6195
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5DD630067AA
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9430E854;
	Thu, 26 Feb 2026 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj9jhHwV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B130E0F4
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111244; cv=none; b=JQVZ7dG0M+BpgqUDmGyt+PjOj6ew8AqiY+Wdu57XBqIAtmPgX82n4P0hVF2ZsDO8dSg4XH/lSCEeAOGxqIUc1lldc6msgKwGFwXPGOL6tCRknGu1NHkeUP5y80RpnJaigWI1fWgcAF0zK9A1jxxuyYj8xvxAvz7Bk9QoXH00VAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111244; c=relaxed/simple;
	bh=zpQfMx8muj1CSqy+fPAsB79JvDcmqcvrRvg16VXPFYc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F1L+FslhhDQPP1EWQgolttw24yE+oHvlXZPjsUvPEKG+Wmn8rz65xiMzYzVs1YO26ehisylhSsjwD0BHkQmZlKke85jMw5mQF6UX+S0ccGGF9M8pTGkKnxowu+gyJz4GOEDw0fgkXuk6Du0neTzEvKaxQDzxqEKNmzODk+d3SKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj9jhHwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACFDC19422;
	Thu, 26 Feb 2026 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772111243;
	bh=zpQfMx8muj1CSqy+fPAsB79JvDcmqcvrRvg16VXPFYc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fj9jhHwVSi0qfb6gSqvqZ1nVbJjd+v+mwYGgXDq+m1SsK+8lBZ4GeahlfOLtoy67+
	 GY1+RCHUKgomLrKDDjOacobKem8RoOEwPatRl4OAxc5DW+akp8fcW8WgjGH068ABPH
	 DAL9Ft2mwMv6+jUJJW8YaXmVar7QZJxbqB2Ko4Uj66IfoNWtYwEXj45yetygv8k83g
	 S4H/QrYhWqFvY6LFDBeW35gx8Yh0hGxf5Vbd0dv5lS98wGjAgQJ048JLqx6QYUW6X6
	 /rIOcDfTc8UPxhGd/oT5daUi73w//21YcJSFuOPeHy/qqAvfA6S41PCpbRd62UMjhs
	 /xG6hUsm7PH4A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42EA7F40068;
	Thu, 26 Feb 2026 08:07:22 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 08:07:22 -0500
X-ME-Sender: <xms:ikWgaS5M_B6CGkwxM_UcKFSUq-ImiD-vebBjTN9Q8frYt0agmRmfvg>
    <xme:ikWgaWuX1Ne_M15FNS0xr3LygHtq6OlqgeE077n6WwreRgruplqoGp5yZjJQi6QHn
    y-u9IpVi_g0A_aEtYn0HuZ4YDuoIIluplvMNO-oA-eUpRbmxavQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheprghnughrvgifrdgtohhoph
    gvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrrghthhhorheslh
    hinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgt
    rhhoshhofhhtrdgtohhmpdhrtghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofh
    htrdgtohhm
X-ME-Proxy: <xmx:ikWgaUydLiZJfTW8qdOyZjht6DbbWWHbYsdPSY3pH9YwJdv-6Da3_w>
    <xmx:ikWgaf0QzWOTU5rOAHPjIewOGkdPphr_sqpVHQ_049i3ggktcBlVQw>
    <xmx:ikWgaV-UeuXFqMEedd4UovRSyi3UOA1M7P4u4ynuV3Pv5YQXRM3Y0Q>
    <xmx:ikWgafTlxbPZfsNkxBolJ3064Yc2-g0SyuNCg8lw7xHPMsDf71ozfw>
    <xmx:ikWgacmoHQHuBh-WRbJCEW1Q5RQg_FqO3BAK6_sMPRDXKROevg_BjqwG>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E488700069; Thu, 26 Feb 2026 08:07:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZdU3QzfaZ07
Date: Thu, 26 Feb 2026 14:07:00 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>
Cc: "Borislav Petkov" <bp@alien8.de>, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com,
 "H . Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Long Li" <longli@microsoft.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Uros Bizjak" <ubizjak@gmail.com>,
 wei.liu@kernel.org
Message-Id: <a7e1b5c1-f933-44e5-99ec-a83b27fcf81e@app.fastmail.com>
In-Reply-To: <5a2f3ffd-1692-4c32-b6f7-b94e5066dd95@citrix.com>
References: <20260226095056.46410-2-ardb+git@google.com>
 <5a2f3ffd-1692-4c32-b6f7-b94e5066dd95@citrix.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-9007-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[alien8.de,linux.intel.com,microsoft.com,zytor.com,vger.kernel.org,redhat.com,linux.microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 551DE1A6195
X-Rspamd-Action: no action



On Thu, 26 Feb 2026, at 13:01, Andrew Cooper wrote:
>> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(void=
)   * available. We restore kernel GDT, and rest of the context, and con=
tinue
>>   * to kexec.
>>   */
>> -static asmlinkage void __noreturn hv_crash_c_entry(void) +static void
>> __naked hv_crash_c_entry(void)  {
>> - struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt; -  	/* first thing, =
restore kernel gdt */
>> - native_load_gdt(&ctxt->gdtr); + asm volatile("lgdt %0" : : "m"
>> (hv_crash_ctxt.gdtr)); =20
>> - asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss)); - asm
>> volatile("movq %0, %%rsp" : : "m"(ctxt->rsp)); + asm volatile("movw
>> %%ax, %%ss" : : "a"(hv_crash_ctxt.ss)); + asm volatile("movq %0,
>> %%rsp" : : "m"(hv_crash_ctxt.rsp));
>
> I know this is pre-existing, but the asm here is poor.
>
> All segment registers loads can have a memory operand, rather than
> forcing through %eax, which in turn reduces the setup logic the compil=
er
> needs to emit.
>
> Something like this:
>
> =C2=A0 =C2=A0 "movl %0, %%ss" : : "m"(hv_crash_ctxt.ss)
>
> ought to do.
>

'movw' seems to work, yes.
...
>
> As Uros notes, "a" is clobbered here but the compiler is not informed.=
=C2=A0
> But, it's not necessary.
>
> As a naked function you could even use 3x asm() statements, but you can
> get the compiler to sort out the function reference automatically with:
>
> =C2=A0 =C2=A0 asm volatile ("push %q0\n\t"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "push %=
q1\n\t"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "lretq"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :: "r"(=
hv_crash_ctxt.cs), "r"(hv_crash_handle));
>
>

Yeah much better - thanks.

