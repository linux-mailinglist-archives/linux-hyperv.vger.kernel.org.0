Return-Path: <linux-hyperv+bounces-7519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74139C517A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FCAD500881
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C162741A0;
	Wed, 12 Nov 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FCvtRDLj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4A2264B8;
	Wed, 12 Nov 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940248; cv=none; b=QAO+BmfcgB51aPGXkjBQz4FpYtnAJ1Bi8UYHuwQGTjguuA3RcAIjPHe//zc4vTlBqsN3dzemH9BbMHk35LGIqD3VYNQUnbdYSsUzYe0/UBSWnk7DuGjq97Z9GN2Qz+PBF32xjt9+ptwhxofWRV6l0upCR6azqzLzC2gM5sz6mYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940248; c=relaxed/simple;
	bh=5+bPDfABTSbjsLLGKhxi1I1q3IpYd9dL+0JlpBz+J0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaOIXJg88s749uv6pLLaMA+c85kFXHCXLadhBLArA0r77SsmlL8gHWxej8PtatdppfcRjZ802r2bB1KAkyS2IJsY0wK0KILnttJQsooH5UPyBGoR/MKcIcsUuoSjwC4NtKTXojdqFp8X3Oalb3DHSkzPPEaHmzraaQgNPG1I9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FCvtRDLj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5NdirOb8DJHe18dV/Aw9s3XZrGnwVYcrB7NCzcdUjYc=; b=FCvtRDLjkqL4h7PL6Ra/Rv5uGh
	vpgcTOtNhDNcf0GdKSoUMP+opntbAikjbUygY4LtJXkiNC6zibDhukEjdts8s01DwL9OA1FB5DWNy
	t6oqhR6umV8FGDTHC/vn9J4ub9HkeDREZ/PNANTI1JyYkU82H01DIbiCunjRJ+Ec1pZ/K3xQ3ixsX
	xsliVHeDj+NTeX+qVKlGbU19rq6ez57ulpZEPsf5oF8+1r4Y1vEHwwL63OXiw+g82QBQiHbBDiIRV
	st5tMkYMyubCEpMVGrpk8M9CVBpfqwhfduIjhvk6gQGynsZJlPqYtcVmG1n8flequ2RgRlvrxEHvj
	CwglLzGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ6Q6-0000000F4jE-3GqQ;
	Wed, 12 Nov 2025 08:41:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C89AE30023C; Wed, 12 Nov 2025 10:37:04 +0100 (CET)
Date: Wed, 12 Nov 2025 10:37:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251112093704.GC4067720@noisy.programming.kicks-ass.net>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Nov 12, 2025 at 04:12:08AM +0000, Michael Kelley wrote:

> > @@ -96,3 +97,10 @@ SYM_FUNC_START(__mshv_vtl_return_call)
> >  	pop %rbp
> >  	RET
> >  SYM_FUNC_END(__mshv_vtl_return_call)
> > +
> > +	.section	.discard.addressable,"aw"
> > +	.align 8
> > +	.type 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0, @object
> > +	.size 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0, 8
> > +__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
> > +	.quad	__SCK____mshv_vtl_return_hypercall
> 
> This is pretty yucky itself. 

Definitely doesn't win any prizes, for sure. 

> Why is it better than calling out to a C function?

It keeps all the code in one place is a strong argument.

> Is it because in spite of the annotations, there's no guarantee the C
> compiler won't generate some code that messes up a register value? Or is
> there some other reason?

There is that too, a frame pointer build would be in its right to add a
stack frame (although they typically won't in this case). And the C ABI
doesn't provide the guarantees your need, so calling out into C is very
much you get to keep the pieces.

> Does the magic "_662.0" have any significance?  Or is it just some
> uniqueness salt on the symbol name?

Like Paolo already said, that's just the crazy generated by our
__ADRESSABLE() macro, this name is mostly irrelevant, all we really need
is a reference to that __SCK____mshv_vtl_return_hypercall symbol so it
ends up in the symbol table. (And the final link will then complain if
the symbol doesn't end up being resolved)

Keeping the name somewhat in line with __ADDRESSABLE() has the advantage
that you can clearly see where it comes from, but yeah, we can strip of
the number if you like.

