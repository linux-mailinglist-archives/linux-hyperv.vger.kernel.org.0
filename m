Return-Path: <linux-hyperv+bounces-1277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B7808E32
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58D0B20AF6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9744C73;
	Thu,  7 Dec 2023 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kEmh9SUa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09763D1;
	Thu,  7 Dec 2023 09:06:47 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32DE920B74C0;
	Thu,  7 Dec 2023 09:06:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32DE920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701968806;
	bh=56k6nLXOObGCyIj9dZYd9gyocqrB3kKOchmRLoVdHg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEmh9SUaaXtb8FDQoPxKy5lGxqy6p9XmIPh9Tt8pQOFdn5PgyFiaQsmtlpeqjN9PT
	 gwSWOJFN2L+zMnLcIXjxd3/RjI1t9QTJTX/JhSbvSpwu17fM+CgAywmNg/+PnsckN6
	 SnaoZliD7Pap2lnjf8VqyUbSAu81sVTFNJTdIxhQ=
Message-ID: <66cff831-1766-4b82-b95a-bc3790a6f24b@linux.microsoft.com>
Date: Thu, 7 Dec 2023 18:06:38 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Michael Kelley <mhkelley58@gmail.com>, Nikolay Borisov
 <nik.borisov@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "Cui, Dexuan" <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "cascardo@canonical.com" <cascardo@canonical.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9ab71fee-be9f-4afc-8098-ad9d6b667d46@linux.microsoft.com>
 <20231205105407.vp2rejqb5avoj7mx@box.shutemov.name>
 <0c4e33f0-6207-448d-a692-e81391089bea@linux.microsoft.com>
 <20231206225415.zxfm2ndpwsmthc6e@box.shutemov.name>
Content-Language: en-US
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231206225415.zxfm2ndpwsmthc6e@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/12/2023 23:54, Kirill A. Shutemov wrote:
> On Wed, Dec 06, 2023 at 06:49:11PM +0100, Jeremi Piotrowski wrote:
>> On 05/12/2023 11:54, Kirill A. Shutemov wrote:
>>> On Mon, Dec 04, 2023 at 08:07:38PM +0100, Jeremi Piotrowski wrote:
>>>> On 04/12/2023 10:17, Reshetova, Elena wrote:
>>>>>> Check for additional CPUID bits to identify TDX guests running with Trust
>>>>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>>>>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>>>>>
>>>>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is
>>>>>> visible
>>>>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>>>>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>>>>>> aware mechanisms for what's left. So currently such guests do not have
>>>>>> X86_FEATURE_TDX_GUEST set.
>>>>>
>>>>> Back to this concrete patch. Why cannot L1 VMM emulate the correct value of
>>>>> the TDX_CPUID_LEAF_ID to L2 VM? It can do this per TDX partitioning arch.
>>>>> How do you handle this and other CPUID calls call currently in L1? Per spec,
>>>>> all CPUIDs calls from L2 will cause L2 --> L1 exit, so what do you do in L1?
>>>> The disclaimer here is that I don't have access to the paravisor (L1) code. But
>>>> to the best of my knowledge the L1 handles CPUID calls by calling into the TDX
>>>> module, or synthesizing a response itself. TDX_CPUID_LEAF_ID is not provided to
>>>> the L2 guest in order to discriminate a guest that is solely responsible for every
>>>> TDX mechanism (running at L1) from one running at L2 that has to cooperate with L1.
>>>> More below.
>>>>
>>>>>
>>>>> Given that you do that simple emulation, you already end up with TDX guest
>>>>> code being activated. Next you can check what features you wont be able to
>>>>> provide in L1 and create simple emulation calls for the TDG calls that must be
>>>>> supported and cannot return error. The biggest TDG call (TDVMCALL) is already
>>>>> direct call into L0 VMM, so this part doesn’t require L1 VMM support. 
>>>>
>>>> I don't see anything in the TD-partitioning spec that gives the TDX guest a way
>>>> to detect if it's running at L2 or L1, or check whether TDVMCALLs go to L0/L1.
>>>> So in any case this requires an extra cpuid call to establish the environment.
>>>> Given that, exposing TDX_CPUID_LEAF_ID to the guest doesn't help.
>>>>
>>>> I'll give some examples of where the idea of emulating a TDX environment
>>>> without attempting L1-L2 cooperation breaks down.
>>>>
>>>> hlt: if the guest issues a hlt TDVMCALL it goes to L0, but if it issues a classic hlt
>>>> it traps to L1. The hlt should definitely go to L1 so that L1 has a chance to do
>>>> housekeeping.
>>>
>>> Why would L2 issue HLT TDVMCALL? It only happens in response to #VE, but
>>> if partitioning enabled #VEs are routed to L1 anyway.
>>
>> What about tdx_safe_halt? When X86_FEATURE_TDX_GUEST is defined I see
>> "using TDX aware idle routing" in dmesg.
> 
> Yeah. I forgot about this one. My bad. :/
> 
> I think it makes a case for more fine-grained control on where TDVMCALL
> routed: to L1 or to L0. I think TDX module can do that.

can -> could. Elena suggested something similar in another mail. That might
make it possible to standardize future paravisor-like usecases, similar to
[1]. Not sure this alone would be enough.

[1]: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

> 
> BTW, what kind of housekeeping do you do in L1 for HLT case?
> 

L1 is responsible for "virtual trust levels" so it might want to service
software running at other trust levels (other L2).

>>>> map gpa: say the guest uses MAP_GPA TDVMCALL. This goes to L0, not L1 which is the actual
>>>> entity that needs to have a say in performing the conversion. L1 can't act on the request
>>>> if L0 would forward it because of the CoCo threat model. So L1 and L2 get out of sync.
>>>> The only safe approach is for L2 to use a different mechanism to trap to L1 explicitly.
>>>
>>> Hm? L1 is always in loop on share<->private conversion. I don't know why
>>> you need MAP_GPA for that.
>>>
>>> You can't rely on MAP_GPA anyway. It is optional (unfortunately). Conversion
>>> doesn't require MAP_GPA call.
>>>
>>
>> I'm sorry, I don't quite follow. I'm reading tdx_enc_status_changed():
>> - TDVMCALL_MAP_GPA is issued for all transitions
>> - TDX_ACCEPT_PAGE is issued for shared->private transitions
> 
> I am talking about TDX architecture. It doesn't require MAP_GPA call.
> Just setting shared bit and touching the page will do the conversion.

Not when L1 is involved.

> MAP_GPA is "being nice" on the guest behalf.> 
> Linux do MAP_GPA all the time. Or tries to. I had bug where I converted
> page by mistake this way. It was pain to debug.

Reading TDX host support in KVM/Qemu it seems to rely on the MAP_GPA, and
I believe so does Hyper-V when the guest runs non-partitioned TDX.

So the spec may say one thing, but if all implementations do the MAP_GPA
then it becomes expected behavior. But we're digressing.

> 
> My point is that if you *must* catch all conversions in L1, MAP_GPA is not
> reliable way.

Exactly, you're confirming my point. Which is why L2 issues a hypervisor specific
hypercall on every page visibility change that will always be handled by L1.

> 
>> This doesn't work in partitioning when TDVMCALLs go to L0: TDVMCALL_MAP_GPA bypasses
>> L1 and TDX_ACCEPT_PAGE is L1 responsibility.
>>
>> If you want to see how this is currently supported take a look at arch/x86/hyperv/ivm.c.
>> All memory starts as private and there is a hypercall to notify the paravisor for both
>> TDX (when partitioning) and SNP (when VMPL). This guarantees that all page conversions
>> go through L1.
> 
> But L1 guest control anyway during page conversion and it has to manage
> aliases with TDG.MEM.PAGE.ATTR.RD/WR. Why do you need MAP_GPA for that?
>

When the L2 wants to perform a page conversion it needs to notify L1 of this so that it
can do its part managing the aliases. Without L1 involvement the conversion doesn't
happen. MAP_GPA is not suitable for this purpose as I've described and you've confirmed
above.
 
>>>> Having a paravisor is required to support a TPM and having TDVMCALLs go to L0 is
>>>> required to make performance viable for real workloads.
>>>>
>>>>>
>>>>> Until we really see what breaks with this approach, I don’t think it is worth to
>>>>> take in the complexity to support different L1 hypervisors view on partitioning.
>>>>>
>>>>
>>>> I'm not asking to support different L1 hypervisors view on partitioning, I want to
>>>> clean up the code (by fixing assumptions that no longer hold) for the model that I'm
>>>> describing that: the kernel already supports, has an implementation that works and
>>>> has actual users. This is also a model that Intel intentionally created the TD-partitioning
>>>> spec to support.
>>>>
>>>> So lets work together to make X86_FEATURE_TDX_GUEST match reality.
>>>
>>> I think the right direction is to make TDX architecture good enough
>>> without that. If we need more hooks in TDX module that give required
>>> control to L1, let's do that. (I don't see it so far)
>>>
>>
>> I'm not the right person to propose changes to the TDX module, I barely know anything about
>> TDX. The team that develops the paravisor collaborates with Intel on it and was also consulted
>> in TD-partitioning design.
> 
> One possible change I mentioned above: make TDVMCALL exit to L1 for some
> TDVMCALL leafs (or something along the line).
> 

You can explore changes to TDVMCALL handling in the TDX module but I don't see any reason
this would be adopted, because a shared hypercall to control page visibility for SNP & TDX is
already part of Hyper-V ABI and works great for this purpose.

> I would like to keep it transparent for enlightened TDX Linux guest. It
> should not care if it runs as L1 or as L2 in your environment.

I understand that is how you would prefer it but, as we've established in these emails,
that doesn't work when the L1 paravisor provides services to the L2 with an L1 specific
protocol and TDVMCALLs are routed to L0 for performance reasons. It can't be done
transparently with TDX 1.5 calls alone and we already have TDX 1.5 deployed to users with
an upstream kernel.

Can you propose a way forward to enable X86_FEATURE_TDX_GUEST for this usecase? We're
talking about consolidating existing kernel TDX code here.

> 
>> I'm also not sure what kind of changes you envision. Everything is supported by the
>> kernel already and the paravisor ABI is meant to stay vendor independent.
>>
>> What I'm trying to accomplish is better integration with the non-partitioning side of TDX
>> so that users don't see "Memory Encryption Features active: AMD SEV" when running on Intel
>> TDX with a paravisor.
> 
> This part is cosmetics and doesn't make much difference.
> 

Not according to Intel engineers and users that I've talked to that are unhappy with this.
And also userspace lacks discoverability of tdx guest in /proc/cpuinfo.

