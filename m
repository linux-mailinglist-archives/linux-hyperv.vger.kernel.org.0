Return-Path: <linux-hyperv+bounces-2285-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3318FA6A1
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 01:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD69B1C20D4A
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A313D270;
	Mon,  3 Jun 2024 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FBToC2O4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A113D25F;
	Mon,  3 Jun 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458458; cv=none; b=rbY7A4uBLJdWJOwZgWUns1kCVblq83oYpyhGfbuhjjreK0BWVg/relnz0blER7nCOo5VcuO60rfggZBf+0F+S9PMq/kGhKiPSzjxqLZDFxb47WuaMWAXjVN2Fq0ZjaspYisQsp09g+KkmMHHzFrGLoWEhxArl8gBgHyy97OL38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458458; c=relaxed/simple;
	bh=kSZeBvRXuEwaL+IlHMDX4WGJNsrJcRdd9a4wOhfLKfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn6t3e+4u6cATNJyZcJgWEL6l4x+CTQ6eyF4jSpLV9Wg62C6hWhC5+SoigDNxvYYBtJcFJsqzYtiBoyh6vtaogrv2J1VfPImVjVBFQCFpNJu+uIiw92VO9o2oE4ssbMR7UKm6HJtnBDwaPjCGBeZ43lgsozNRUD6kQHk5B6BgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FBToC2O4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2607:fb90:3707:40b:a32e:4449:b3a:891d] ([IPv6:2607:fb90:3707:40b:a32e:4449:b3a:891d])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 453MhgU5475578
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Jun 2024 15:43:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 453MhgU5475578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1717454626;
	bh=wuD6WLaEWhP4n3Qasi9wvzUCa2upP1PV62NIREW0BKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBToC2O4KGQk197cIv7t84JmESw/VZTY3yCo3LqaSIXdLNAqfkAdoAN+wohABjwpV
	 GG8YdHXGo0U45ht4clybrH6eJ/AiZIL2nz1YNbWGmte1xbtzL3wkn7penFxvDyij1J
	 w1sPlUp39rOPmBXa3KDRfbxxVxioSumuNPHXOXJoU60YnM/WXbT8vWyCloinAqoZ+E
	 lAArupSy4TdrTTju+IaHtBBQsQHt8qzCikfK/2TAoD86qTyqGlwTzhL4m2ipVvPsk+
	 mp0olUR+8EO4Z6RjUV5pc3lZiwOYm3IvGz1v+NNFEsPXVh1CpFmDZisWBu3BX+ytNL
	 s7upucbc1rdrQ==
Message-ID: <2b661d91-badc-4c90-9a9a-fe82635cf514@zytor.com>
Date: Mon, 3 Jun 2024 15:43:41 -0700
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

Sorry if this is a duplicate; something strange happened with my email.

If you are cleaning up this code anyway...

this whole piece of code can be simplified to:

	and $(X86_CR4_PAE | X86_CR4_LA57), %r13d
	mov %r13, %cr4

The PAE bit in %r13 is guaranteed to be set, and %r13 is dead after this.

	-hpa

