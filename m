Return-Path: <linux-hyperv+bounces-6605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC87B35EC5
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1861BA0064
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA72BD5BC;
	Tue, 26 Aug 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7vdPORA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF437464;
	Tue, 26 Aug 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210089; cv=none; b=YFBr4ppEbswxE0ghqs0eCRr6ipvvlV24aPLa77+KnJkLmLmbBu0VqwuGbw0ZEfWgWzX6AHYLL2noUypY35736Dd+0f1l8eNxVsrdpNHf2FoVK7+s5i2emzDabiooSnVnC2mW7j0Ma7TLWSvbo4grhAx/xU5LrcLR0P1M2vkEbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210089; c=relaxed/simple;
	bh=eBTjrpFjZktYfQEek7wFWXsXh9PLOThEDUgAG3qIKX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCEpdpm5epiyrSoXinyEe4TaKUC99zJa7eI663NmwDnKLmPvfY2Jl9179CJdDVFjh98FVAjPwEhzZ6clQ/rG7HyYhjCjZLC2RNg5thqU8Ynii1rfvdY4PKmaQaeAgyJUkwb0NHhEXfT8kaHIeakbDY1HRoMFev0xScaWr/eFhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G7vdPORA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RNrj+PrYCp7vZgile/6ySLaeHzS2H6oogyM9xuLWTO8=; b=G7vdPORAre1sVFm5R81fAYIiR9
	Uy2o1j9kIIeleerC60D05c1tXGUwtH+N/ynl8gXIsCokbjvLKpLeI2AXRSMsCfHeRpOY3tN4ReVa6
	uawGR/wPcLcKQs4Yk7MT4M/XjrurZDGuXdOIMv+fsSZULLmc+OA0AmqB5BtwG5dH1S7F87WjDwB4j
	peRFriZQvXftstUUuMdTWjy25CUcGys+4kIArzWjE3F/izeQs0RzSqj48uH82l7CmuKa9B0enTjzW
	UoviVFBSmIVHyNLTgM7gyjxE6+EWR3UCMHtVHZ1Jn1xga55OfghmhhtEuMqFNokabJV4PsrH9vH1f
	4Ij+vzSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsSv-00000002D4N-2sit;
	Tue, 26 Aug 2025 12:07:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BA3E3002C5; Tue, 26 Aug 2025 14:07:52 +0200 (CEST)
Date: Tue, 26 Aug 2025 14:07:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Message-ID: <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>

On Tue, Aug 26, 2025 at 05:00:31PM +0530, Naman Jain wrote:
> 
> 
> On 8/25/2025 3:12 PM, Peter Zijlstra wrote:
> > On Mon, Aug 25, 2025 at 11:22:08AM +0530, Naman Jain wrote:
> > > With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
> > > config checks were added to conditionally restrict export
> > > of hv_hypercall_pg symbol at the same time when a usage of that symbol
> > > was added in mshv_vtl_main.c driver. This results in missing symbol
> > > warning when mshv_vtl_main is compiled. Change the logic to
> > > export it unconditionally.
> > > 
> > > Fixes: 96a1d2495c2f ("Drivers: hv: Introduce mshv_vtl driver")
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > 
> > Oh gawd, that commit is terrible and adds yet another hypercall
> > interface.
> > 
> > I would argue the proper fix is moving the whole of mshv_vtl_return()
> > into the kernel proper and doing it like hv_std_hypercall() on x86_64.
> 
> Thanks for the review comments.
> 
> This is doable, I can move the hypercall part of it to
> arch/x86/hyperv/hv_init.c if I understand correctly.
> 
> > 
> > Additionally, how is that function not utterly broken? What happens if
> > an interrupt or NMI comes in after native_write_cr2() and before the
> > actual hypercall does VMEXIT and trips a #PF?
> 
> mshv_vtl driver is used for OpenHCL paravisor. The interrupts are
> disabled, and NMIs aren't sent to the paravisor by the virt stack.

I do not know what OpenHCL is. Nor is it clear from the code what NMIs
can't happen. Anyway, same can be achieved with breakpoints / kprobes.
You can get a trap after setting CR2 and scribble it.

You simply cannot use CR2 this way.

> > And an rax:rcx return, I though the canonical pair was AX,DX !?!?
> 
> Here, the code uses rax and rcx not as a means to return one 128 bit
> value. The code uses them in that way as an ABI.

Still daft. Creating an ABI that goes against pre-existing conventions
is weird.

> > Also, that STACK_FRAME_NON_STANDARD() annotation is broken, this must
> > not be used for anything that can end up in vmlinux.o -- that is, the
> > moment you built-in this driver (=y) this comes unstuck.
> > 
> > The reason you're getting warnings is because you're violating the
> > normal calling convention and scribbling BP, we yelled at the TDX guys
> > for doing this, now you're getting yelled at. WTF !?!
> > 
> > Please explain how just shutting up objtool makes the unwind work when
> > the NMI hits your BP scribble?
> 
> Returning to a lower VTL treats the base pointer register as a general
> purpose one and this VTL transition function makes sure to preserve the
> bp register due to which the objtool trips over on the assembly touching
> the bp register. We considered this warning harmless and thus we are
> using this macro. Moreover NMIs are not an issue here as they won't be
> coming as mentioned other. If there are alternate approaches that I should
> be using, please suggest.

Using BP in an ABI like that is ridiculous and broken. We told the same
to the TDX folks when they tried, IIRC TDX was fixed.

It is simply not acceptable to break the regular calling convention with
a new ABI.

Again, I can put a breakpoint or kprobe in the region where BP is
scribbled.

Basically the argument is really simple: you run in Linux, you play by
the Linux rules. Using BP as argument is simply not possible. If your
ABI requires that, your ABI is broken and will not be supported. Rev the
ABI and try again. Same for CR2, that is not an available register in
any way.

> I now understand that as part of your effort to enable IBT config on
> x64, you changed the indirect calls to direct calls in Hyper-V.

Yeah, I was cleaning up indirect calls, and this really didn't need to
be one.

> As of today, there is no requirement to enable IBT in OpenHCL kernel
> as this runs as a paravisor in VTL2 and it does not effect the guest
> VMs running
> in VTL0.

I do not know what OpenHCL or VTLn means and as such pretty much the
whole of your statement makes no sense.

Anyway, AFAICT the whole idea of a hypercall page is to 'abtract' out
the VMCALL vs VMMCALL nonsense Intel/AMD inflicted on us. Surely you
don't actually need that. HyperV already knows about all the gazillion
of ways to do hypercalls.

> I can disable CONFIG_X86_KERNEL_IBT when CONFIG_MSHV_VTL is enabled in
> Kconfig in next version.

Or you can just straight up say: "We at microsoft don't care about
security." :-/

Doing that will ensure no distro will build your module, most build bots
will not build your module, nobody cares about your module.

And no, the problems with BP and CR2 are not related to IBT, that is
separate and no less broken. They violate the basic rules of x86_64.

