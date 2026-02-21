Return-Path: <linux-hyperv+bounces-8938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE42AOLgmWnMXAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8938-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 17:44:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1B16D4BC
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D4430421DA
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E32E146;
	Sat, 21 Feb 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoUji8A4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35532E13E
	for <linux-hyperv@vger.kernel.org>; Sat, 21 Feb 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771692255; cv=none; b=tCPtuzVUOHt3GyZAV5sfpMy52TS/p7gIa9jEkhujVRrsHEHVqsIQeFT6xlNGeHcmUc520OZHa53dnxIO4OAmGplPfgfX8L5U+rPl6eIRpQtdlYbdDVLpFDxL6+ZsWcqoEumamsxvXkXGXhOoYfCF+MwU3Wi2CxEhIOgcdVtU+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771692255; c=relaxed/simple;
	bh=PYYUMWYiV51lO/SR+awkNyRlcJLKNvI+P6h91H96lmY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RdmBHc4jW7KDlRdZPh3CIIPcsi7JjLSyO2/LFTPicK8DRcur0yfDWoABGogqd6A3Ymqb/1MkG2C8s2qLMXpnMCd5iT05AZdziER0ddl7/VFiSU2jJYshLLSQD7zk+0NOmEReJ0ptrvVVpUD0qiTMD9dxO4P4UfMbw/xwZGLxer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoUji8A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC0FC19421;
	Sat, 21 Feb 2026 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771692255;
	bh=PYYUMWYiV51lO/SR+awkNyRlcJLKNvI+P6h91H96lmY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SoUji8A4tNbBXol2EW9jgB5itRynz35LPbqUq/FnGqTP5OYxqvqNue2akJhJkGjn6
	 wNvpOt7tVRxhXXp2t+/yG6b+qHHRkxgm8U3DRbuRfa5F5VZnGxQIG48YYGvq2DqL3k
	 ATHpYFCn21gel48PAnCo+k4C0FBsnTn8D7cSR43CbBkv9jL+XOjrpYN7Sy6v2mI947
	 vZle4mp2d7a3CjmGvIApej1YiDNdAK89XvsxuKDRoDWEUP5PuBjuP4UMhJEcKwWgdA
	 c0ZlooHliMB33RrceemMhhna7+5Iauv+LkIUTCNdZhPetNr/h8m4iYNyMNg+IZ9Ox1
	 I3ckrX2fGKXng==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB94DF4006C;
	Sat, 21 Feb 2026 11:44:13 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Sat, 21 Feb 2026 11:44:13 -0500
X-ME-Sender: <xms:3eCZaf0Zx4M_-z6l3QMRV1wkFdX9KGMcKexLsCWfusvbdtjZv5Us5A>
    <xme:3eCZaY4y6jMTbJgXwvpvvM1N-pKMVR0xp_TsBvoSxfe9VTh2ZNhMBSPQzJThrbRzJ
    ftUowG8i97vdpxrXQyC05obPQ8IRdiqGbMKci7U9LiyYEdfK_yYTZCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfedukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrd
    guvgdprhgtphhtthhopeifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhht
    vghlrdgtohhmpdhrtghpthhtohepmhhrrghthhhorheslhhinhhugidrmhhitghrohhsoh
    hfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgtrhhoshhofhhtrdgtohhmpdhr
    tghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:3eCZaX-EQ4q5R9Wt1ITcA_61pAEnLzPCCN_cd2TUZRKQfaJVdLA3tg>
    <xmx:3eCZafgLL-NOLUOBRcy-0iMMpuKYZlSugMqyGYTZ0OX72p5fYzOv5w>
    <xmx:3eCZaagm7_dS3hvvFRu1_2eRiR8gYzakkUrCAIi3Qln23G03xFdzBA>
    <xmx:3eCZaV6BajZEkOTJ-rukNhxCeMMSBadHchkhOIn4YYj11Mrzf-2q6Q>
    <xmx:3eCZacTUoXPDEV14511GbUJvxeQL2gEyIgMrGXeX51TpSLUpYqnoB37y>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91DD8700065; Sat, 21 Feb 2026 11:44:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABHypM1vLXn-
Date: Sat, 21 Feb 2026 17:43:16 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 dave.hansen@linux.intel.com, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>
Message-Id: <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
In-Reply-To: <20250910001009.2651481-6-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection into vmcore
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8938-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BF1B16D4BC
X-Rspamd-Action: no action

Just spotted this code in v7.0-rc

On Wed, 10 Sep 2025, at 02:10, Mukesh Rathor wrote:
...

> +static asmlinkage void __noreturn hv_crash_c_entry(void)

'asmlinkage' means that the function may be called from another compilation unit written in assembler, but it doesn't actually evaluate to anything in most cases. Combining it with 'static' makes no sense whatsoever.

> +{
> +	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
> +
> +	/* first thing, restore kernel gdt */
> +	native_load_gdt(&ctxt->gdtr);
> +
> +	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> +	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> +

This code is truly very broken. You cannot enter a C function without a stack, and assign RSP half way down the function. Especially after allocating local variables and/or calling other functions - it may happen to work in most cases, but it is very fragile. (Other architectures have the concept of 'naked' functions for this purpose but x86 does not)

IOW, this whole function should be written in asm.

> +	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
> +	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
> +	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
> +	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
> +
> +	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
> +	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
> +
> +	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
> +	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
> +	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
> +
> +	native_load_idt(&ctxt->idtr);
> +	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
> +	native_wrmsrq(MSR_EFER, ctxt->efer);
> +
> +	/* restore the original kernel CS now via far return */
> +	asm volatile("movzwq %0, %%rax\n\t"
> +		     "pushq %%rax\n\t"
> +		     "pushq $1f\n\t"
> +		     "lretq\n\t"
> +		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
> +
> +	/* We are in asmlinkage without stack frame,

You just switched to __KERNEL_CS via the stack.

> hence make a C function
> +	 * call which will buy stack frame to restore the tss or clear PT 
> entry.
> +	 */

Where does one buy a stack frame?

> +	hv_crash_restore_tss();
> +	hv_crash_clear_kernpt();
> +
> +	/* we are now fully in devirtualized normal kernel mode */
> +	__crash_kexec(NULL);
> +
> +	for (;;)
> +		cpu_relax();
> +}
> +/* Tell gcc we are using lretq long jump in the above function 
> intentionally */
> +STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
> +


