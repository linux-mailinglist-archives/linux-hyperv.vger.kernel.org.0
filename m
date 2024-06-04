Return-Path: <linux-hyperv+bounces-2288-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAF98FA71A
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 02:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838581F22643
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983444C91;
	Tue,  4 Jun 2024 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IcBtkMGI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20160399;
	Tue,  4 Jun 2024 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461910; cv=none; b=jcLSdkocjdnAFsiiFOKLg8ZACdJAiORboQTib3EH0WNoQlKTpc8a5VCoE84WWGhCi84V9qvmTolBsvuT3UMvHl2n+1OTh2GLq2oL+YS9xwWYdw2zbZiyfVUJBLobFWQ/Q88GHysrhdOpL/phHQYU5xtSKEoZL3uJBCq849ba+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461910; c=relaxed/simple;
	bh=7mlxyKX/tSYlAa4UsecWzVPrQObeMubwDYBXeApQ3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhI2csFK/VT1uyqj+FIGQO/tuPaZz2FvUvenxGnZCGjzihLxJ4h7bgS8x+3UIR6DO5wyxT57ik+Pgfp19YH+dply3sEqlpaqFqrkIKxK+Gpv0S6XGMWeTYk6lWWJhmoL0oT7VViF2hss03NwE7NWd8X8BJxECIkH3x22nILj2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IcBtkMGI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4540O6GP697624
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 17:24:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4540O6GP697624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717460652;
	bh=hPNX3NSLHYNb2TcI1l7fuFsWwNCcNc5ytF4+K+xW86o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IcBtkMGIO/Y/xzeu3xUgo0V2bIRkGJWdFYBCuvM7FvQFv4DD5SqW52rOMi1M1NXq0
	 UbpxLqPThJOMWS5OGoH5JDJTneX9Fz4WB6HCAlD3DdwNRoR6DOySE7liMPJ2OoJXwk
	 kN0YOjNf4IHAm/j/fRONallpudtEaMW7a9guw+zMWdMJsw0v5yTE4w+UjP4qPSHwDW
	 +lzLAyxf6BQR+J+gKWA9WL4tVNflr3bNAQgvUQ8ZJY3ET9y22IPwofcNUeVC+3avqJ
	 UFYXxzGbHKtq+nJW3AUi/L4zQrxGWhTvCCXwlR00kYfSxD0xpWVzLtMVCBflrX/zBr
	 fTdcJY72jn6bw==
Message-ID: <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
Date: Mon, 3 Jun 2024 17:24:00 -0700
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
        Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Trying one more time; sorry (again) if someone receives this in duplicate.

>>>
>>> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>>> index 56cab1bb25f5..085eef5c3904 100644
>>> --- a/arch/x86/kernel/relocate_kernel_64.S
>>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>>> @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>    	 */
>>>    	movl	$X86_CR4_PAE, %eax
>>>    	testq	$X86_CR4_LA57, %r13
>>> -	jz	1f
>>> +	jz	.Lno_la57
>>>    	orl	$X86_CR4_LA57, %eax
>>> -1:
>>> +.Lno_la57:
>>> +
>>>    	movq	%rax, %cr4

If we are cleaning up this code... the above can simply be:

	andl $(X86_CR4_PAE | X86_CR4_LA54), %r13
	movq %r13, %cr4

%r13 is dead afterwards, and the PAE bit *will* be set in %r13 anyway.

	-hpa


