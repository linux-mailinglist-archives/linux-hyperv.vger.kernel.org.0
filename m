Return-Path: <linux-hyperv+bounces-2407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC64905EED
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE341C21250
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0022CCB4;
	Wed, 12 Jun 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="arGK1znU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554212B177
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718233573; cv=none; b=RK2Jgx2ksyBqlbZVNRV2DhQCHSTsWzLOKVKGCX7P5/YWt04hWa2K5QRL0dJyWwZ5uiSuVWakLF6rICs4yZSv34M6xbYgWKN9qAEQEgRf8FciiFpiNnFSwkrvOOfSPmIGApVIQOeDuY/lO9fGB7oipg5vgV87La0APp4ZWOVHSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718233573; c=relaxed/simple;
	bh=JQbugJA8jcGelVyE2M9ReTkk0J62dOaLR16rY0Fg4OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR5SDZOLUSTX4tRvgddU8MGEFRMDj3EbMT0/hQB3LQCSqdrdsK8R42D8Q+YRasYQyfe4+xVHyKt4IBNOFSUx/yMMjarJbEwsUKtEEQOw4jIzG4h1C2MbvhsrMk8dKj9zUXgqZFz9nlmEdy3uyeglyibLvZ3mvQs3Ux4jDTj0gqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=arGK1znU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217d451f69so4651055e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2024 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718233569; x=1718838369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nBdu/p+rPedbbedDDyqmAgiBRsCiRDycnW5wqxTyACs=;
        b=arGK1znUQSC1tQKxmkgpkNYy5op5s+O5g9QDhzlsho+Nad+qRV6ZsE26Lv8ZY6Ft30
         CmfCZxBEqTckzbCxbPe3neSctVfY/QQ69/i33nKJDVSSB2HyiRsQKuDryu3ZVEtVlY5s
         Gbd0oyvgPjVO6xoZOALi0bPgx9G5z0XzewQ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718233569; x=1718838369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBdu/p+rPedbbedDDyqmAgiBRsCiRDycnW5wqxTyACs=;
        b=Jq3XmY8gO1RHUcvVk3iZv03o+Hy/oqHKyFr4x/C0GlSSClk6l8zdZwtCHuWkGXsBqQ
         kS7NFWGGr55a8woknAMsKdWYsqvSNkIKaZDxL7AZsHWk8u8O+UlQ3HcaYJ/nK+1Py3iC
         cL+mkBb4eV6tbZ4d3sDOmefJkwYyYVWXYGxPa24Lym7MdrX7stuf7h1AYt9f0DeVlhwh
         Yq3TemZ4JA8Pj1ow9ql7pYO2dmqw8aF5C7Qmh9zHiAjSJUSfVHIaUnZrjOIhgMsm1bjZ
         ziUS+cglgE0oj8wvqXNvtvkqQgyU82AokC49p4O31ew9xVaTW9NxYN30v77XlYHEe1Oi
         bWpw==
X-Forwarded-Encrypted: i=1; AJvYcCWNSprsaafadilkfiBKVBR27/aJneGFQ4p+Dj20fy/XIv9Q7JMRx8jxy67/LER+SP7WVVqcOwrvbAatA818MhTw2BQkw1f6sjAXqCee
X-Gm-Message-State: AOJu0Ywqm89ksg3gKfkIzXXzV0+EClDfJhL/RaTRcMpG8jZYqk7Wd+0M
	6E9VWRRw7YwshOdbZumY0xo3WD7BuHtP9bmOt/c4G1UI9Jn4cz2sZEARHhlJ9BQ=
X-Google-Smtp-Source: AGHT+IHG+f0o9hNbI+2TQlMCyzttV2QTbaYydAK8N22sR60f8GaXn0G6V6BCroySwbJ4fjWkKL4LsA==
X-Received: by 2002:a05:600c:45cc:b0:421:21d2:abf5 with SMTP id 5b1f17b1804b1-422865acc67mr27498415e9.31.1718233569336;
        Wed, 12 Jun 2024 16:06:09 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a64bsm2618385e9.46.2024.06.12.16.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 16:06:08 -0700 (PDT)
Message-ID: <addbd29a-66dc-4180-ae45-ef038c2249d1@citrix.com>
Date: Thu, 13 Jun 2024 00:06:07 +0100
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
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
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
 <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com>
 <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2024 10:22 am, Kirill A. Shutemov wrote:
> On Tue, Jun 11, 2024 at 11:26:17AM -0700, H. Peter Anvin wrote:
>> On 6/4/24 08:21, Kirill A. Shutemov wrote:
>>>  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>> Date: Fri, 10 Feb 2023 12:53:11 +0300
>>> Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
>>>
>>> TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
>>> that bit is cleared during CR4 register reprogramming during boot or
>>> kexec flows, a #VE exception will be raised which the guest kernel
>>> cannot handle it.
>>>
>>> Therefore, make sure the CR4.MCE setting is preserved over kexec too and
>>> avoid raising any #VEs.
>>>
>>> The change doesn't affect non-TDX-guest environments.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>   arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>>> index 085eef5c3904..9c2cf70c5f54 100644
>>> --- a/arch/x86/kernel/relocate_kernel_64.S
>>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>>> @@ -5,6 +5,8 @@
>>>    */
>>>   #include <linux/linkage.h>
>>> +#include <linux/stringify.h>
>>> +#include <asm/alternative.h>
>>>   #include <asm/page_types.h>
>>>   #include <asm/kexec.h>
>>>   #include <asm/processor-flags.h>
>>> @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>   	 * Set cr4 to a known state:
>>>   	 *  - physical address extension enabled
>>>   	 *  - 5-level paging, if it was enabled before
>>> +	 *  - Machine check exception on TDX guest, if it was enabled before.
>>> +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
>>> +	 *
>>> +	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
>>> +	 * PAE is always set in the original CR4.
>>>   	 */
>>> -	movl	$X86_CR4_PAE, %eax
>>> -	testq	$X86_CR4_LA57, %r13
>>> -	jz	.Lno_la57
>>> -	orl	$X86_CR4_LA57, %eax
>>> -.Lno_la57:
>>> -
>>> -	movq	%rax, %cr4
>>> +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
>>> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
>>> +	movq	%r13, %cr4
>> If this is the case, I don't really see a reason to clear MCE per se as I'm
>> guessing a machine check here will be fatal anyway? It just changes the
>> method of death.
> Andrew had a strong opinion on method of death here.
>
> https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com

Not sure if I intended it to come across that strongly, but given a
choice, the !CR4.MCE death is cleaner because at least you're not
interpreting garbage and trying to use it as a valid IDT.

~Andrew

