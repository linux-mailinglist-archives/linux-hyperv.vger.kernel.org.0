Return-Path: <linux-hyperv+bounces-1027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E357F4DD8
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 18:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781551C20803
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23D54BC6;
	Wed, 22 Nov 2023 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TL6ISCBs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D82B11F;
	Wed, 22 Nov 2023 09:09:21 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18A3220B74C0;
	Wed, 22 Nov 2023 09:09:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18A3220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700672960;
	bh=s6AX/C2zNGnXlHAMv/3n6sM1eRG+UvFSPtvrOsZmvRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TL6ISCBs2mXICFHaLznFSNLZx8vNPxwTMEuAIeK1WbK0uIkkeQG5XRy2uLV68FDmb
	 QEYA9axxXLQkDhSRROlF4Na6A+03Cy4h83Sd7GxgF0jUXzjGrtpuY0EDLduInLUOO1
	 CZ4G8AChrC+V/l48ZRD/gyPgNyBh0sVxIFVZVDG4=
Message-ID: <6f20977c-a152-4195-bf4e-f212cf721410@linux.microsoft.com>
Date: Wed, 22 Nov 2023 18:09:16 +0100
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
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 stefan.bader@canonical.com, tim.gardner@canonical.com,
 roxana.nicolescu@canonical.com, cascardo@canonical.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, kirill.shutemov@linux.intel.com,
 sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
 <73b51be2-cc60-4818-bdba-14b33576366d@linux.microsoft.com>
 <20231110164557.GBZU5eRRj9x6dOVOaH@fat_crate.local>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110164557.GBZU5eRRj9x6dOVOaH@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2023 17:45, Borislav Petkov wrote:
> On Fri, Nov 10, 2023 at 04:51:43PM +0100, Jeremi Piotrowski wrote:
>> What's semi-correct about checking for CC_VENDOR_INTEL and then
>> printing Intel?  I can post a v2 that checks CC_ATTR_GUEST_MEM_ENCRYPT
>> before printing "TDX".
> 
> How is it that you're not seeing the conflict:
> 
> Your TD partitioning guest *is* a TDX guest so X86_FEATURE_TDX_GUEST
> should be set there. But it isn't. Which means, that is already wrong.
> Or insufficient.
> 
> 	 if (cc_vendor == CC_VENDOR_INTEL)
> 
> just *happens* to work for your case.
> 
> What the detection code should do, rather, is:
> 
> 	if (guest type == TD partioning)
> 		set bla;
> 	else if (TDX_CPUID_LEAF_ID)
> 		"normal" TDX guest;
> 
> and those rules need to be spelled out so that everyone is on the same
> page as to how a TD partitioning guest is detected, how a normal TDX
> guest is detected, a SEV-ES, a SNP one, yadda yadda.
> 
>> The paravisor *is* telling the guest it is running on one - using a CPUID leaf
>> (HYPERV_CPUID_ISOLATION_CONFIG). A paravisor is a hypervisor for a confidential
>> guest, that's why paravisor detection shares logic with hypervisor detection.
>>
>> tdx_early_init() runs extremely early, way before hypervisor(/paravisor) detection.
> 
> What?
> 
> Why can't tdx_early_init() run CPUID(HYPERV_CPUID_ISOLATION_CONFIG) if
> it can't find a valid TDX_CPUID_LEAF_ID and set X86_FEATURE_TDX_GUEST
> then?

I guess it can if no one has an issue with it.

Thank you for the review, I've posted a patchset that implements this idea here:
https://lore.kernel.org/lkml/20231122170106.270266-1-jpiotrowski@linux.microsoft.com/T/#u

> 
>> Additionally we'd need to sprinkle paravisor checks along with
>> existing X86_FEATURE_TDX_GUEST checks. And any time someone adds a new
>> feature that depends solely on X86_FEATURE_TDX_GUEST we'd run the
>> chance of it breaking things.
> 
> Well, before anything, you'd need to define what exactly the guest kernel
> needs to do when running as a TD partitioning guest and how exactly that
> is going to be detected and checked using the current cc_* and
> cpufeatures infra. If it doesn't work with the current scheme, then the
> current scheme should be extended.
> 
> Then, that should be properly written out:
> 
> "if bit X is set, then that is a guest type Y"
> "if feature foo present, then so and so are given"
> 
> If the current guest type detection is insufficient, then that should be
> extended/amended.
> 
> That's the only viable way where the kernel would support properly and
> reliably a given guest type. There'll be no sprinkling of checks
> anywhere.
> 
> Thx.
> 

OK. In the new submission I've added CC_ATTR_TDX_MODULE_CALLS because that
is what we really need to guard against, and these guests can then have
X86_FEATURE_TDX_GUEST set normally.

Jeremi


