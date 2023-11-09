Return-Path: <linux-hyperv+bounces-825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44E7E6EF3
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAECC280FE9
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815BA22335;
	Thu,  9 Nov 2023 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P5g32T/i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDC2231C
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Nov 2023 16:35:46 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D0435AC;
	Thu,  9 Nov 2023 08:35:44 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id CFE6220B74C0;
	Thu,  9 Nov 2023 08:35:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFE6220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699547744;
	bh=Xb4zVDtxtGdwPAnhyMCxbu916b6ZbtJVbUTOWrLT7jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P5g32T/iCUi+XzdE2yIB7+Vk+y1jkYXsQZYnJOFUhNKHROzXMtOx3p0JqrFmtn6mQ
	 JfDkvj2ken97iBJ+MYvWg//v0Pz6tJec3nkjhMcL2NGjcEkHKys7LtbYpJUVnG8uCD
	 qoGG9PQzDqf1fZte+HO/oSu9w2O9G32v1HQEjhMU=
Message-ID: <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
Date: Thu, 9 Nov 2023 17:35:39 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
 tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
 cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, kirill.shutemov@linux.intel.com, sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2023 17:25, Dave Hansen wrote:
> On 11/9/23 08:14, Jeremi Piotrowski wrote:
> ...
>>  	pr_info("Memory Encryption Features active:");
>>  
>> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>> +	if (cc_vendor == CC_VENDOR_INTEL) {
>>  		pr_cont(" Intel TDX\n");
>>  		return;
>>  	}
> 
> Why aren't these guests setting X86_FEATURE_TDX_GUEST?

They could if we can confirm that the code gated behind
cpu_feature_enabled(X86_FEATURE_TDX_GUEST) is correct when running with TD partitioning.

It still makes sense to have these prints based on the cc_xxx abstractions.

Jeremi

