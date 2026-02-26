Return-Path: <linux-hyperv+bounces-9001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAL/EWD6n2n3fAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9001-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:46:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7991A2061
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 101033037190
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF582311599;
	Thu, 26 Feb 2026 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGL7b/7k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759C3921C9;
	Thu, 26 Feb 2026 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091972; cv=none; b=IE9v9GjRdVPVPej3vqe2BTrD14ow/BiYZ5fita+fzK+Tw+6PRgG1CaetfA03OS2tbJPtTMXP6mUhy8yrGcGWMq+PAYN4jj02sq2JaqCihE99tlfVm5kdOrFH6ebbjW9Gc8wnArMBnz/DSWQvcPR4zFmj9n9fnQUGeqsocVP7CEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091972; c=relaxed/simple;
	bh=8rF5K/Ao47rfUmEx+Ps1mmhI+24bcrG8/kevhQmsoCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z+H96GjTJzgumegt2gkjmr20CYQBUB75tWrpoL3yEb++jSv2VyGI4WYsUtLQMAJlkfYwT6dB92z3fcn0JdcPQWFMIrghsisBDFB1n6EbDMLJP2THeVO23BHj+VU32rOb0tQM+/oIYezEIt7hHf061+BB0KNJWQpluGXXUmRPtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGL7b/7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28CFC2BCB4;
	Thu, 26 Feb 2026 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091972;
	bh=8rF5K/Ao47rfUmEx+Ps1mmhI+24bcrG8/kevhQmsoCQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AGL7b/7kINL5ceVMZ24rdnFoEWEZgN1vnLo5XexSO9uhdKH1gawSIJ/tUd2pCpXxe
	 x0LTdxTuZoaWAHzNt9/uvxSFNV7HkyKuGKTppjSjS6T12/gRbq8cjzmDzBbPoWTUti
	 /1favtqMRKOg1CZHIQ9TuTIXn93Nbb/DA8n0fhltpC5k8zGj0ldZLgnhJVKxFrncvr
	 8rJLg9+j8n1yCulVNb+osym+9M12nWf6Pi7+yqyX3sRbvX+1ura6RDtwJlL+fjpBIJ
	 yz5HzhrGr+JhvKGWuGAcILlQz4ZSeO4OA80/GI5+rMkZUBgzxZFaXMHeNzW0qkR8iC
	 BglmHDzCZXS+g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A70B1F40068;
	Thu, 26 Feb 2026 02:46:10 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 02:46:10 -0500
X-ME-Sender: <xms:QvqfaS45-LhO2YbNoD7td_Nn691d95J7SBwiMbbciR9wuG6AqWEviw>
    <xme:QvqfaWuABjsraTQBU_wyKrBtiA88f4lYMiDvwkJ5GYwyCavNS37TKEGSJ-Xmc7SMu
    flosps_UZrYS2eWaJO8wLxao5w6yINGVk5klXLQwlvjNpLWueYzZec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QvqfaV-Z0iBB23v2e2fCaiJc3ZT-wbl4ttw4hx3MD2EB9a160UKQmw>
    <xmx:QvqfafQGvqh2MZ-rxCiWZnOF9ZEl2G6aaaeHFMInEB3x-q_Vz88MCw>
    <xmx:Qvqfacm1aagKmmFjlPabdKL8Tycqf-nyfJIYFcv3q5syNu-bdC4aug>
    <xmx:QvqfaaU6J3G5DONCluueCLczj4YwlaHzdMPKSmMhmdxVnC2goHj3Eg>
    <xmx:QvqfaRdSfAgHuPZx5LtO0DSBBnqylFkLT-AI2O1gUTR1EfKtKvTu2mrj>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76112700065; Thu, 26 Feb 2026 02:46:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 08:44:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 dave.hansen@linux.intel.com, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>
Message-Id: <eb1c44d7-2664-4269-8824-e90e5a8494b2@app.fastmail.com>
In-Reply-To: <f8199494-0c42-5eb0-f99e-cc6f6e304d40@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
 <f8199494-0c42-5eb0-f99e-cc6f6e304d40@linux.microsoft.com>
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection into vmcore
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9001-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA7991A2061
X-Rspamd-Action: no action


On Wed, 25 Feb 2026, at 23:27, Mukesh R wrote:
> On 2/21/26 08:43, Ard Biesheuvel wrote:
>> Just spotted this code in v7.0-rc
>> 
>> On Wed, 10 Sep 2025, at 02:10, Mukesh Rathor wrote:
>> ...
>> 
>>> +static asmlinkage void __noreturn hv_crash_c_entry(void)
>> 
>> 'asmlinkage' means that the function may be called from another compilation unit written in assembler, but it doesn't actually evaluate to anything in most cases. Combining it with 'static' makes no sense whatsoever.
>
> 'static' means scope is limited to the file. Common in cases where function
> pointers are used, like here in this file way below.
>
> Like the comment says:
>      "This is the C entry point from the asm glue code after...."
>
> IOW, called from assembly function (asm == assembly).
>

I wasn't asking you to explain what 'static' means. I was explaining to you that asmlinkage means 'external linkage' whereas 'static' means the opposite, and so combining them makes no sense.


>> 
>>> +{
>>> +	struct hv_crash_ctxt *ctxt = &hv_crash_ctxt;
>>> +
>>> +	/* first thing, restore kernel gdt */
>>> +	native_load_gdt(&ctxt->gdtr);
>>> +
>>> +	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
>>> +	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>>> +
>> 
>> This code is truly very broken. You cannot enter a C function without a stack, and assign RSP half way down the function. Especially after allocating local variables and/or calling other functions - it may happen to work in most cases, but it is very fragile. (Other architectures have the concept of 'naked' functions for this purpose but x86 does not)
>
> Local variable refers to static bss struct. IOW,
>
>        asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
>
> same as:
>        asm volatile("movq %0, %%rsp" : : "m"(&hv_crash_ctxt.rsp));
>
>

No, it is *not* the same. In practice, the compiler might perform this substitution, but there is no guarantee that this happens.


>> IOW, this whole function should be written in asm.
>>> +	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
>>> +	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
>>> +	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
>>> +	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
>>> +
>>> +	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
>>> +	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
>>> +
>>> +	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
>>> +	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
>>> +	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
>>> +
>>> +	native_load_idt(&ctxt->idtr);
>>> +	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
>>> +	native_wrmsrq(MSR_EFER, ctxt->efer);
>>> +
>>> +	/* restore the original kernel CS now via far return */
>>> +	asm volatile("movzwq %0, %%rax\n\t"
>>> +		     "pushq %%rax\n\t"
>>> +		     "pushq $1f\n\t"
>>> +		     "lretq\n\t"
>>> +		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
>>> +
>>> +	/* We are in asmlinkage without stack frame,
>> 
>> You just switched to __KERNEL_CS via the stack.
>
> compiler doesn't know that.
>

So? But does it means to 'be in asmlinkage' in your interpretation? Did you check what 'asmlinkage' actually evaluates to?

I am not asking you to justify why this broken code works in practice, I am asking you to fix it.

>>> hence make a C function
>>> +	 * call which will buy stack frame to restore the tss or clear PT
>>> entry.
>>> +	 */
>> 
>> Where does one buy a stack frame?
>
> A stack market :).  Callee will create stack frame now that rsp is
> setup.
>

This code is beyond broken. Please propose fixes rather than try to argue why carrying broken code like this is acceptable.


