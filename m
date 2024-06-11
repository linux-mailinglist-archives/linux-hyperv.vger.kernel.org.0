Return-Path: <linux-hyperv+bounces-2389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4829043EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AE01F214EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE4762C9;
	Tue, 11 Jun 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="okEtiCOV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604157CB5;
	Tue, 11 Jun 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131487; cv=none; b=mzQXsULubCZLU17byRNMgXkxPL6MPnanMlqV5ZC0z1yZiASQeGO3aJDz1GrFp0++CKEBOWjEyIJioOogNRhDUrDYfODW2iFY0NwDAv0EtzGMUF8AANotiPKUq5rDf5roUhyORnOaT2+K7uMwNx6dDxZ2KgFz4ozat3I90vRprKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131487; c=relaxed/simple;
	bh=yWm+CV/ol6Yb0FRVj/f//Za7SwasM3ugj7xYp1INfAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN9+ADkh7hO/oQXjq/iG5PRcbq/NCch5CrolkDmsEKdKzonsCdsPqeGDlpWwHn1Hhh5IvE+sMrEvCu5O5I02AdlIeTJtxRNhK8xLSv8HOlwiLZ/rmrbuxUWmWosCway00Wq6SBHyP24WluzkGWTpdt4ix5Xy4h2jMarZudpqujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=okEtiCOV; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45BIQOXg3417874
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Jun 2024 11:26:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45BIQOXg3417874
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718130387;
	bh=OHa9DhySlaaVhhVOAe30IsVHYFteIibUy4qxaCqMzfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okEtiCOVX3HdSiQvDxNYgYr+0HqgJLKnG2m/rlhjGnPh3XRakqH86Oe0HdFjQ8vb8
	 lCLlJW7zSBSPM1bA8ax15thRrIwWFaFPa+o+EdL0rZXm/4/srmUbr6CHP65bznGV6W
	 /KqQ2D4aqxtZUQuY/R1ri1KUYKGzgNTcj5gKCQDmB9GzuFD1tce5uDmWNtkEv67UBQ
	 IMwXQ4AT2ur45vH1k3ay4KEUOfF1/sbHVKDC6HZDl/Rr6CAEEJOpoq0nP6p/4NCCle
	 bBvwdvwS9QuAK9Xc12EimU7dTn6UCMfkGN+YTd5x4KhT3RxS5dyR7XQZEkI5pnsssf
	 IW/2FxDzYYpCw==
Message-ID: <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>
Date: Tue, 11 Jun 2024 11:26:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish"
 <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
 <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 08:21, Kirill A. Shutemov wrote:
> 
>  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Fri, 10 Feb 2023 12:53:11 +0300
> Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> 
> TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
> that bit is cleared during CR4 register reprogramming during boot or
> kexec flows, a #VE exception will be raised which the guest kernel
> cannot handle it.
> 
> Therefore, make sure the CR4.MCE setting is preserved over kexec too and
> avoid raising any #VEs.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 085eef5c3904..9c2cf70c5f54 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>    */
>   
>   #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>   #include <asm/page_types.h>
>   #include <asm/kexec.h>
>   #include <asm/processor-flags.h>
> @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 * Set cr4 to a known state:
>   	 *  - physical address extension enabled
>   	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
> +	 *
> +	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> +	 * PAE is always set in the original CR4.
>   	 */
> -	movl	$X86_CR4_PAE, %eax
> -	testq	$X86_CR4_LA57, %r13
> -	jz	.Lno_la57
> -	orl	$X86_CR4_LA57, %eax
> -.Lno_la57:
> -
> -	movq	%rax, %cr4
> +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
> +	movq	%r13, %cr4
>   

If this is the case, I don't really see a reason to clear MCE per se as 
I'm guessing a machine check here will be fatal anyway? It just changes 
the method of death.

Also, is there a reason to save %cr4, run code, and *then* clear the 
relevant bits? Wouldn't it be better to sanitize %cr4 as soon as possible?

	-hpa

