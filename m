Return-Path: <linux-hyperv+bounces-7497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE7C4D4F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13653188805F
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE0351FDF;
	Tue, 11 Nov 2025 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="og8xVEyG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541863546E1;
	Tue, 11 Nov 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858812; cv=none; b=uu5pN6wECyy6Pnqr9ZcqM9zO4XEovyn7gibNlMVf0Qiu22oJ5tGiui/QawQRsrQ8bMRPCkTiBgxoXkQCmm7V0nLfvzkfOwAM3SD1lJkxDHgr4gDnnzWctCJRm3kpPJMMokrtnC9sjk1aH0/LZG+knhfUxeVwOZ/SHCUtPlZla0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858812; c=relaxed/simple;
	bh=+KR3IEt6xV4mf1mwAioUcSifWqBGiyC7BrWwK+bQIls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hclr1snRHPAUCtMEatvv417PJpyHlemUaNhWZ1+/0r7bm+ZjyFYovMP4oFFo3ojChAX/7pkcffhDm4fYEaY/2J5eHrvyionJgtMA2DrV1Dk+eWRFJZcXxXTvsn6pKXhJU45nQWk4SPBq8cnYzSnRFtGwshyhKPW/IEEUypB2uoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=og8xVEyG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J/mA2+LhBwcehR17SXnbx+3glZ3c+agwCFsRGcfUzIY=; b=og8xVEyG4tHAjwndEf/OZKFRhr
	OhuyvdbRlJY9n6GUrOpev4rwVeNknRnxKIG/4zuwg+0pQ/PuOtV7OFxhMY3vZ/EZSZw0EJZ54AM7k
	a9UfeyU69XyPA2WiwC+fMzqctr/KFNfyY9DgfqrMpfOM5Suma4NfpEkgDPJYmkhEb4r3Pw6ToXIQi
	vo/0+uR/cVO85sXZmm0wFFNkpjQLxpRLWTwzoTdLmC5R7195NS4wvaXzsJXpslnpKh4lT7ZviKeSG
	gHmDdZQzoJFmEb+ML8lNx1Xi46BR8MGypNg0Q6u+QCM9u9PDm8w/HKmrGQfB/OP0ZqknNRENRK47W
	JKD79Jkw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIm6O-000000049fJ-3eeG;
	Tue, 11 Nov 2025 10:59:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63BF4300328; Tue, 11 Nov 2025 11:59:55 +0100 (CET)
Date: Tue, 11 Nov 2025 11:59:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251111105955.GK278048@noisy.programming.kicks-ass.net>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
 <5788c77f-fbb7-43e9-bfcb-7c0b103ca301@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5788c77f-fbb7-43e9-bfcb-7c0b103ca301@linux.microsoft.com>

On Tue, Nov 11, 2025 at 04:28:27PM +0530, Naman Jain wrote:
> 
> 
> On 11/11/2025 1:43 PM, Peter Zijlstra wrote:
> > On Tue, Nov 11, 2025 at 12:25:54PM +0530, Naman Jain wrote:
> > 
> > > This would have been the cleanest approach. We discussed this before and
> > > unfortunately it didn't work. Please find the link to this discussion:
> > > 
> > > https://lore.kernel.org/all/9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com/
> > > 
> > > To summarize above discussion, I see below compilation error with this from
> > > objtool. You may have CONFIG_X86_KERNEL_IBT enabled in your workspace, which
> > > would have masked this.
> > 
> > IBT isn't the problem, the thing is running objtool on vmlinux.o vs the
> > individual translation units. vmlinux.o will have that symbol, while
> > your .S file doesn't.
> > 
> > >    AS      arch/x86/hyperv/mshv_vtl_asm.o
> > > arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find
> > > static_call_key symbol: __SCK____mshv_vtl_return_hypercall
> > 
> > Right, and I said you had to do that ADDRESSABLE thing. So I added a
> > DECLARE_STATIC_CALL() and a static_call() in hv.c, compiled it so .s and
> > stole the bits.
> > 
> > And then you get something like the below. See symbol 5, that's the
> > entry we need.
> > 
> > # readelf -sW defconfig-build/arch/x86/hyperv/mshv_vtl_asm.o
> > 
> > Symbol table '.symtab' contains 8 entries:
> >     Num:    Value          Size Type    Bind   Vis      Ndx Name
> >       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> >       1: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0
> >       2: 0000000000000000     0 SECTION LOCAL  DEFAULT    4 .noinstr.text
> >       3: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCT____mshv_vtl_return_hypercall
> >       4: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_return_thunk
> >       5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __SCK____mshv_vtl_return_hypercall
> >       6: 0000000000000010   179 FUNC    GLOBAL DEFAULT    4 __mshv_vtl_return_call
> >       7: 0000000000000000    16 FUNC    GLOBAL DEFAULT    4 __pfx___mshv_vtl_return_call
> > 
> > 
> > ---
> 
> 
> Thanks a lot for sharing the changes. I tested this and it works fine. I can
> create a separate patch for the include/linux/* changes and add it as the
> first patch in the next version of my patch series.
> 
> Please let me know if this is fine and if I can add your Signed-off-by in
> that patch.

Sure, have at. Thanks!

