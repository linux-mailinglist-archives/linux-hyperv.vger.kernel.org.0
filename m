Return-Path: <linux-hyperv+bounces-1288-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BA809188
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 20:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427F4B20C0E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36AC4F88D;
	Thu,  7 Dec 2023 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SEnV+pY3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C964171E;
	Thu,  7 Dec 2023 11:35:43 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2D7220B74C0;
	Thu,  7 Dec 2023 11:35:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2D7220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701977742;
	bh=6BiLByj3fZjdf+BfxwCzcTu0LXWFgvJe9QuEPuRxeO4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SEnV+pY3cHBgbDr+d8z34kVMryVfuOl0+dMA8g20vqAM6ROcn3YJik6DRDuaoaCrW
	 o2NybIL15Y5hBMXjaHTTLdcdy5S6Zub8nYIoEXmJCrRs4B+hxlG6vwTh028qtBZlSe
	 mrDfw2y5fPDOreaJkDjkztR0iF2R4Gq0Kvc6eR6U=
Message-ID: <6ec6b73e-c3f6-4952-9835-0dbc4b7c199f@linux.microsoft.com>
Date: Thu, 7 Dec 2023 20:35:33 +0100
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
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
 "Cui, Dexuan" <decui@microsoft.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "cascardo@canonical.com" <cascardo@canonical.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "kys@microsoft.com"
 <kys@microsoft.com>, "stefan.bader@canonical.com"
 <stefan.bader@canonical.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
 <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
 <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
 <59bdfee24a9c0f7656f7c83e65789d72ab203edc.camel@intel.com>
 <8362bf44-f933-4a7e-9e56-a7c425a2ba5a@linux.microsoft.com>
In-Reply-To: <8362bf44-f933-4a7e-9e56-a7c425a2ba5a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2023 18:21, Jeremi Piotrowski wrote:
> On 07/12/2023 13:58, Huang, Kai wrote:
>>>
>>> That's how it currently works - all the enlightenments are in hypervisor/paravisor
>>> specific code in arch/x86/hyperv and drivers/hv and the vm is not marked with
>>> X86_FEATURE_TDX_GUEST.
>>
>> And I believe there's a reason that the VM is not marked as TDX guest.
> Yes, as Elena said:
> """
> OK, so in your case it is a decision of L1 VMM not to set the TDX_CPUID_LEAF_ID
> to reflect that it is a tdx guest and it is on purpose because you want to 
> drop into a special tdx guest, i.e. partitioned guest. 
> """
> TDX does not provide a means to let the partitioned guest know that it needs to
> cooperate with the paravisor (e.g. because TDVMCALLs are routed to L0) so this is
> exposed in a paravisor specific way (cpuids in patch 1).
> 
>>
>>>
>>> But without X86_FEATURE_TDX_GUEST userspace has no unified way to discover that an
>>> environment is protected by TDX and also the VM gets classified as "AMD SEV" in dmesg.
>>> This is due to CC_ATTR_GUEST_MEM_ENCRYPT being set but X86_FEATURE_TDX_GUEST not.
>>
>> Can you provide more information about what does _userspace_ do here?
> 
> I gave one usecase in a different email. A workload scheduler like Kubernetes might want to
> place a workload in a confidential environment, and needs a way to determine that a VM is
> TDX protected (or SNP protected) to make that placement decision.
> 
>>
>> What's the difference if it sees a TDX guest or a normal non-coco guest in
>> /proc/cpuinfo?
>>
>> Looks the whole purpose of this series is to make userspace happy by advertising
>> TDX guest to /proc/cpuinfo.  But if we do that we will have bad side-effect in
>> the kernel so that we need to do things in your patch 2/3.
>>
> 
> Yes, exactly. It's unifying the two approaches so that userspace doesn't have to
> care.
> 
>> That doesn't seem very convincing.
> 
> Why not? 
> The whole point of the kernel is to provide a unified interface to userspace and
> abstract away these small differences. Yes it requires some kernel code to do,
> thats not a reason to force every userspace to implement its own logic. This is
> what the flags in /proc/cpuinfo are for.
> 

So I feel like we're finally getting to the gist of the disagreements in this thread.

Here's something I think we should all agree on (both a) and b)). X86_FEATURE_TDX_GUEST:
a) is visible to userspace and not just some kernel-only construct
b) means "this is a guest running in an Intel TDX Trust Domain, and said guest is aware
   of TDX"

a) is obvious but I think needs restating. b) is what userspace expects, and excludes legacy
(/unmodified) guests running in a TD. That's a reasonable definition.

For kernel only checks we can rely on platform-specific CC_ATTRS checked through
intel_cc_platform_has.

@Borislav: does that sound reasonable to you?
@Kai, @Kirill, @Elena: can I get you to agree with this compromise, for userspace' sake?

Jeremi

