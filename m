Return-Path: <linux-hyperv+bounces-7101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB47BBDD5C
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7874A1898B77
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1E265CCD;
	Mon,  6 Oct 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxnJJ2ZR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271C170A11;
	Mon,  6 Oct 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749043; cv=none; b=MMT0lUQpxJ/feNkXY7crALcPB1w8/SX/4nQv+VC6gGdCLQ/xoqjpsg8ww1TOgE1y0kChvd7Dj4mMhe0xB7E09y1eQmPNtXlgldaKIT93i7Fx4egHZ5xECHTa9568GycJO93MxLOLBSGLRmQcdB5jTDBxhveGkjCgKCNMHe6pW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749043; c=relaxed/simple;
	bh=DIlBSgr/mSzhziWJOmRfekecg8JOIy41/V+z1EQrEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ1lHwyrVP8F5D8S91pKih6mGDF2PcEopWCI2wd6nNaabfndauG2kYUQJSJXmOZOgdh+I0TTZlnyivZmvqcpOIR2cvSL8Ud3VWkT81tK2+5/Q04iImfkKSInxJ/SMQv0hqW0uzvveVP1gB4x7P/Xeihd0uEhzLHUnHc9afm1PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WxnJJ2ZR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PH8rBo5IdyG01s0ryxVVuoYJyvhmSI/VIZPq4wZJnhA=; b=WxnJJ2ZRglzHWG0OLU/YCj6Qa5
	RaL1eD6ah8PG3OFfola6UsQ1WjSDOzw5gYCQzHFNL2Bpm6zEAWwtyux1vs9MgyD2dyHn9vGv5dSjd
	zJvJp+rbk3LDvOG19CPBSVMSH12sZd1lQ16efUF9XhjbVZi6FxpMXGwwS4y8t4jN1JK/6Lz/wdu4T
	CbyVqAPWvj0CeRLMPpS2IL4cAn4UGncZdQCetLw0yWBHz2ZtFrJcNp06Tmeqj68ouMvvnRB4XT0sr
	pP54/SFf+QrOuUrowYti/y+1F1ZyVaqEcOS7YVlOgpztvHyQMHMiAZYVXpjx3BEbPiXWiDrH/BTfp
	X9MxlA5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5j6t-0000000GsOH-0ag4;
	Mon, 06 Oct 2025 11:10:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B341E300212; Mon, 06 Oct 2025 13:10:30 +0200 (CEST)
Date: Mon, 6 Oct 2025 13:10:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Message-ID: <20251006111030.GU3245006@noisy.programming.kicks-ass.net>
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
 <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
 <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
 <aMl5ulY1K7cKcMfo@google.com>
 <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>
 <20250918064713.GW3419281@noisy.programming.kicks-ass.net>
 <9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com>

On Mon, Oct 06, 2025 at 04:20:03PM +0530, Naman Jain wrote:

> I am facing issues in this approach, after moving the assembly code to a
> separate file, using static calls, and making it noinstr.
> 
> We need to make a call to STATIC_CALL_TRAMP_STR(hv_hypercall_pg + offset) in
> the assembly code. This offset is populated at run time in the driver, so I
> have to pass this offset to the assembly function via function parameters or
> a shared variable. This leaves noinstr section and results in below warning:
> 
> [1]: vmlinux.o: warning: objtool: __mshv_vtl_return_call+0x4f: call to
> mshv_vtl_call_addr() leaves .noinstr.text section
> 
> 
> To fix this, one of the ways was to avoid making indirect calls. So I used
> EXPORT_STATIC_CALL to export the static call *trampoline and key* for the
> static call we created in C driver. Then I figured, we could simply call
> __SCT__<static_callname> in assembly code and it should work fine. But then
> it leads to this error in objtool.

Easiest solution is to create a second static_call and have
hv_set_hypercall_pg() set that to +offset.

DEFINE_STATIC_CALL(__hv_vtl_hypercall);


hv_set_hypercall()
	...
	static_call_update(__hv_vtl_hypercall, ptr+offset); /* +- cast to right function type */


> [2]: arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find
> static_call_key symbol: __SCK__mshv_vtl_return_hypercall

Look at arch/x86/include/asm/preempt.h

you might need that __STATIC_CALL_MOD_ADDRESSABLE() thing somewhere.


Also, what's actually in that hypercall page that is so magical and
can't just be an ALTERNATIVE() ?



