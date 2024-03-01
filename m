Return-Path: <linux-hyperv+bounces-1625-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D686DE33
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866AC1C20E8D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9A16A34D;
	Fri,  1 Mar 2024 09:26:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DA5B1E2;
	Fri,  1 Mar 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285183; cv=none; b=cavcIJ9y8Md7QpR2HP1NR70Tvw1g6SugRDRnbzZ8JUGcNUyGozgbBGTYYYi2hTmU/O2HcNIsSoq8Cg3OD2U+vXNpRfJdfq0ZtmLPjOBwrAIFBAcGM4ewy33+yH5/CrPWA4XJFakN+bqW94f4IPOEeHe0Fy22nBaJobVHnJtbVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285183; c=relaxed/simple;
	bh=MnXxYdim+ErAvLCa4ek2QvDPq8ga9LS4BaAHVYX3eow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A75TfUinaXxlGAhwBVv3+WlsC9KdO5hmI/5Y8JPkijK+SD3IeCDnmi3MOTdFtT9hvqfBKX0DXZK0c/FMwXQqECKZgqDmqfFFUFjFHHaMapOBsxdh/ep+we7buOFQgzphhevtjCXfPk+fXQtd4ln/hke8kDdvGYu3hPERaqHRJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21fed501addso904180fac.2;
        Fri, 01 Mar 2024 01:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285180; x=1709889980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdJCGnsr1PgomKAYNsHyEsd3dtv9l/bjbY6EGM5JJ3k=;
        b=VVx/gDHCoD0WA76CNmKyqTxss5Leuaflj+zCIQgOh4zfwFgSqERacwTI1Ws93O3HqI
         yOw6FLGmv0mGSCsSvZnarA6pDrCkRPWo9htouts1wkh+0wKcNxFl444uNvMCtafCGg4E
         e4BFumJF8IFqcS0G9o1P0lO43pz27WMuFU32GRFpYrwaAJSlRvbqAtJLxCpIB45ELTsw
         SW4CePO1+q0NpNKFzGaPaD6YrfcrwRBZ3/uZ8Lanjudx6z+jQteriT0AYkhQ9g9b4Vw9
         /xnwTU2vRrhqWAQtV31lLPpmBAT2NIzuu7De4swqdUJ0EyFenUeocEOR4JGzkZ9IOfAD
         staQ==
X-Forwarded-Encrypted: i=1; AJvYcCVesPkSTWnJuh6SxR2NEtlCZTGQJ0t1zOg2AB7AQGJVbMIXJJssyLsEAY7hEdSkgvL4pTuFNpbG7zcpS3y6bCFzbj8b8rkMd4A9WNI2FQwAGxzgnzKNfzOIF1/HAEnhI6iQHYDpWDzef88B
X-Gm-Message-State: AOJu0Yy25v9C9zpCQYOHX5VgzzF0yJwbw6r48Ub4n2YSyBqMB4kMkvez
	0ePveJxC4mgehhiYuF6h5Wv0zWaWBXRh00ZGIhpXaCXiCSuP2pEB
X-Google-Smtp-Source: AGHT+IGQI9dLrMg4IIQbS5TRKDxZlX5ExuzhnqXLR2XHjV3/BPtjzMkzXsLqatBT2Fy0YdDZABUovw==
X-Received: by 2002:a05:6870:bb06:b0:220:9f9c:2bd8 with SMTP id nw6-20020a056870bb0600b002209f9c2bd8mr1050514oab.4.1709285180319;
        Fri, 01 Mar 2024 01:26:20 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id it2-20020a056a00458200b006e508b6a13dsm2525245pfb.58.2024.03.01.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:26:19 -0800 (PST)
Date: Fri, 1 Mar 2024 09:26:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kirill.shutemov@linux.intel.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com, thomas.lendacky@amd.com,
	ardb@kernel.org, jroedel@suse.de, seanjc@google.com,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
Message-ID: <ZeGfOiizl5o-PNLZ@liuwe-devbox-debian-v2>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116022008.1023398-1-mhklinux@outlook.com>

On Mon, Jan 15, 2024 at 06:20:05PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM, when transitioning memory from encrypted to decrypted, or
> vice versa, the caller of set_memory_encrypted() or set_memory_decrypted()
> is responsible for ensuring the memory isn't in use and isn't referenced
> while the transition is in progress.  The transition has multiple steps,
> and the memory is in an inconsistent state until all steps are complete.
> A reference while the state is inconsistent could result in an exception
> that can't be cleanly fixed up.
> 
> However, the kernel load_unaligned_zeropad() mechanism could cause a stray
> reference that can't be prevented by the caller of set_memory_encrypted()
> or set_memory_decrypted(), so there's specific code to handle this case.
> But a CoCo VM running on Hyper-V may be configured to run with a paravisor,
> with the #VC or #VE exception routed to the paravisor. There's no
> architectural way to forward the exceptions back to the guest kernel, and
> in such a case, the load_unaligned_zeropad() specific code doesn't work.
> 
> To avoid this problem, mark pages as "not present" while a transition
> is in progress. If load_unaligned_zeropad() causes a stray reference, a
> normal page fault is generated instead of #VC or #VE, and the
> page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
> reference. When the encrypted/decrypted transition is complete, mark the
> pages as "present" again.
> 
> This version of the patch series marks transitioning pages "not present"
> only when running as a Hyper-V guest with a paravisor. Previous
> versions[1] marked transitioning pages "not present" regardless of the
> hypervisor and regardless of whether a paravisor is in use.  That more
> general use had the benefit of decoupling the load_unaligned_zeropad()
> fixup from CoCo VM #VE and #VC exception handling.  But the implementation
> was problematic for SEV-SNP because the SEV-SNP hypervisor callbacks
> require a valid virtual address, not a physical address like with TDX and
> the Hyper-V paravisor.  Marking the transitioning pages "not present"
> causes the virtual address to not be valid, and the PVALIDATE
> instruction in the SEV-SNP callback fails. Constructing a temporary
> virtual address for this purpose is slower and adds complexity that
> negates the benefits of the more general use. So this version narrows
> the applicability of the approach to just where it is required
> because of the #VC and #VE exceptions being routed to a paravisor.
> 
> The previous version minimized the TLB flushing done during page
> transitions between encrypted and decrypted. Because this version
> marks the pages "not present" in hypervisor specific callbacks and
> not in __set_memory_enc_pgtable(), doing such optimization is more
> difficult to coordinate. But the page transitions are not a hot path,
> so this version eschews optimization of TLB flushing in favor of
> simplicity.
> 
> Since this version no longer touches __set_memory_enc_pgtable(),
> I've also removed patches that add comments about error handling
> in that function.  Rick Edgecombe has proposed patches to improve
> that error handling, and I'll leave those comments to Rick's
> patches.
> 
> Patch 1 handles implications of the hypervisor callbacks needing
> to do virt-to-phys translations on pages that are temporarily
> marked not present.
> 
> Patch 2 makes the existing set_memory_p() function available for
> use in the hypervisor callbacks.
> 
> Patch 3 is the core change that marks the transitioning pages
> as not present.
> 
> This patch set is based on the linux-next20240103 code tree.
> 
> Changes in v4:
> * Patch 1: Updated comment in slow_virt_to_phys() to reduce the
>   likelihood of the comment becoming stale.  The new comment
>   describes the requirement to work with leaf PTE not present,
>   but doesn't directly reference the CoCo hypervisor callbacks.
>   [Rick Edgecombe]
> * Patch 1: Decomposed a complex line-wrapped statement into
>   multiple statements for ease of understanding. No functional
>   change compared with v3. [Kirill Shutemov]
> * Patch 3: Fixed handling of memory allocation errors. [Rick
>   Edgecombe]
> 
> Changes in v3:
> * Major rework and simplification per discussion above.
> 
> Changes in v2:
> * Added Patches 3 and 4 to deal with the failure on SEV-SNP
>   [Tom Lendacky]
> * Split the main change into two separate patches (Patch 5 and
>   Patch 6) to improve reviewability and to offer the option of
>   retaining both hypervisor callbacks.
> * Patch 5 moves set_memory_p() out of an #ifdef CONFIG_X86_64
>   so that the code builds correctly for 32-bit, even though it
>   is never executed for 32-bit [reported by kernel test robot]
> 
> [1] https://lore.kernel.org/lkml/20231121212016.1154303-1-mhklinux@outlook.com/
> 
> Michael Kelley (3):
>   x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor
>     callback
>   x86/mm: Regularize set_memory_p() parameters and make non-static
>   x86/hyperv: Make encrypted/decrypted changes safe for
>     load_unaligned_zeropad()

Applied. Thanks.

The changes to mm code are mostly cosmetic. The changes had been pending
for a while without any objections from the maintainers, so I picked
them up as well.

If this becomes problematic, please let me know.

> 
>  arch/x86/hyperv/ivm.c             | 65 ++++++++++++++++++++++++++++---
>  arch/x86/include/asm/set_memory.h |  1 +
>  arch/x86/mm/pat/set_memory.c      | 24 +++++++-----
>  3 files changed, 75 insertions(+), 15 deletions(-)
> 
> -- 
> 2.25.1
> 

