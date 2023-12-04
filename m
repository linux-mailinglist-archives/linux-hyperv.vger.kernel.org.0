Return-Path: <linux-hyperv+bounces-1196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53825803E87
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C31C209B1
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEE3174E;
	Mon,  4 Dec 2023 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EqaWQiP/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FF1B6;
	Mon,  4 Dec 2023 11:37:44 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E63820B74C0;
	Mon,  4 Dec 2023 11:37:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E63820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701718664;
	bh=6OgqpPIDYAhEvqdnTA5+1k8rBb0kW/Ne8m6QL+eFWfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EqaWQiP/J41/orn/yXK04P4ChSOua40DK3YNcn4gA8ZTD8x0gteOv8XXF3GUozHK1
	 GJxqPvmxT+VWDnynPZJ0J0nTLxQA0G0Z1tn8M7FYS4AUftBQXJJ1+hidwFvPYYT/3k
	 CVSUZBqM0cDdKsnvb/kLcuUkMOAqjZge43lpcQXs=
Message-ID: <e11b0d18-2f58-4ddd-8f17-309e1a999b61@linux.microsoft.com>
Date: Mon, 4 Dec 2023 20:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
 tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
 cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, sashal@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michael Kelley <mhkelley58@gmail.com>, Nikolay Borisov
 <nik.borisov@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, x86@kernel.org, Dexuan Cui <decui@microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 17:40, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 06:19:20PM +0100, Jeremi Piotrowski wrote:
>> Which approach do you prefer?
> 
> I'm trying to figure out from the whole thread, what this guest is.

Wanted to clarify some things directly here. This type guest is supported
in the kernel already[1], so this whole series is the kind of attempt to
share more code that you advocated for in another email.

[1]: https://lore.kernel.org/lkml/20230824080712.30327-1-decui@microsoft.com/#t

> 
> * A HyperV second-level guest

From Hyper-V's point of view it's a TDX guest with privilege levels inside, not
second-level...

> 
> * of type TDX

...but Intel TDX calls these privilege levels L1 and L2 instead of VMPL0/VMPL1-3.

> 
> * Needs to defer cc_mask and page visibility bla...
>

The implementations in tdx_early_init() depend on TDX module calls (not avail)
and the correct calls are standard Hyper-V hypercalls (same as vTOM SNP guests).

> * needs to disable TDX module calls
> 
> * stub out tdx_accept_memory

This is actually a fix that for something that only works by accident right now
and I meant to post separately from the rest of the discussion.

If you look at arch/x86/include/asm/unaccepted_memory.h (below), it is used by both
CONFIG_INTEL_TDX_GUEST and CONFIG_AMD_MEM_ENCRYPT, but there is no tdx_accept_memory
implementation when CONFIG_INTEL_TDX_GUEST is not set. This is subtle and confusing,
the stub should be there.
 
static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
{
        /* Platform-specific memory-acceptance call goes here */
        if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
                if (!tdx_accept_memory(start, end))
                        panic("TDX: Failed to accept memory\n");
        } else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
                snp_accept_memory(start, end);
        } else {
                panic("Cannot accept memory: unknown platform\n");
        }
}

> 
> Anything else?
> 
> And my worry is that this is going to become a mess and your patches
> already show that it is going in that direction because you need to run
> the TDX side but still have *some* things done differently. Which is
> needed because this is a different type of guest, even if it is a TDX
> one.
> 
> Which reminds me, we have amd_cc_platform_vtom() which is a similar type
> of thing.
> 
> And the TDX side could do something similar and at least *try* to
> abstract away all that stuff.
> 
> Would it be nice? Of course not!
> 
> How can one model a virt zoo of at least a dozen guest types but still
> keep code sane... :-\
> 


