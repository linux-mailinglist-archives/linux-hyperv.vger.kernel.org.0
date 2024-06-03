Return-Path: <linux-hyperv+bounces-2284-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EC8FA69F
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 01:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A352DB221F3
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96D81AB5;
	Mon,  3 Jun 2024 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F6kPfk5m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950788061F;
	Mon,  3 Jun 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458454; cv=none; b=VokH/e3Z9hqU+3tQqTD9rzsF3LcBamZUMZ7XY+xryxnKR40FOxEZh+9+xRf2SBv2FfV3CaCxU7Ulj1DWakLUjU7YDCGiD4Fv2RmBLdZyD+TjKgbdSwLq4/g/ecgKI7fyDvsAX2JdvRew2pnQCeVNGBKx60tDKoI6xuHl5XDzj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458454; c=relaxed/simple;
	bh=6bEpQgcxUVGW2oHLoP+LTHY1R7E8TDG7aTpirGPEYG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inshmYfGXCBcBmM3d1In0pqcIl85d6R1mOS+ML8aYVM5rvRFzFF26L0jPIgI/IuveUuS72sY9uAPG5HbvvYJEztX5O15OiDR3Eh+5RlGZevtArJ8TX6HXYRMNETrIvnE3prrgYtJQjhfmAbUvqO6ed3LePuGB8uQzWw2jJJYY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=F6kPfk5m; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 453EhCwn3610090
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 07:43:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 453EhCwn3610090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717425794;
	bh=sOv2pml39rCUmYtq263pd0Mke6ArsY5AX7diMAElB7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6kPfk5mkSk5h0hAkB5UJ45Gs5fwkaIkIuhFTy8KR1NFWRKyqxjf62B+INqAcQtYS
	 1K1lC+HHZJuFQJH2hrVwQHOc06tWtoXdTqdjxCtihWqxWYG502lPDyIQ4rkBMhLEhX
	 K5hZO67HdOTy/G6fEJulnDhrID0NSaitVzskOa4cHmaexkEmC7pQImZo+W84PK6HAo
	 bnuJkaQAPQoM+KjEcz2CDmaFd2wNeI3Zuz5LkufhuWzQsKUTxlzUbNf3l2hZnESq6D
	 qE+/LWd5MSggxOHt2HBe0b+7WMwUp6U2gtRzKKnfqNHrh1XhfRO17fyfW7MrCcVKLc
	 kcU1XkhpOZnLg==
Message-ID: <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
Date: Mon, 3 Jun 2024 07:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: Nikolay Borisov <nik.borisov@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/24 03:47, Nikolay Borisov wrote:
>>
>> diff --git a/arch/x86/kernel/relocate_kernel_64.S 
>> b/arch/x86/kernel/relocate_kernel_64.S
>> index 56cab1bb25f5..085eef5c3904 100644
>> --- a/arch/x86/kernel/relocate_kernel_64.S
>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>> @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>        */
>>       movl    $X86_CR4_PAE, %eax
>>       testq    $X86_CR4_LA57, %r13
>> -    jz    1f
>> +    jz    .Lno_la57
>>       orl    $X86_CR4_LA57, %eax
>> -1:
>> +.Lno_la57:
>> +
>>       movq    %rax, %cr4
>>       jmp 1f
> 
> That jmp 1f becomes redundant now as it simply jumps 1 line below.
> 

Uh... am I the only person to notice that ALL that is needed here is:

	andl $(X86_CR4_PAE|X86_CR4_LA57), %r13d
	movq %r13, %rax

... since %r13 is dead afterwards, and PAE *will* have been set in %r13 
already?

I don't believe that this specific jmp is actually needed -- there are 
several more synchronizing jumps later -- but it doesn't hurt.

However, if the effort is for improving the readability, it might be 
worthwhile to encapsulate the "jmp 1f; 1:" as a macro, e.g. "SYNC_CODE".

	-hpa

