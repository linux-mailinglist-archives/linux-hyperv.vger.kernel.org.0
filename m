Return-Path: <linux-hyperv+bounces-1171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB3800FDE
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A6AB2104E
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Dec 2023 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F34C608;
	Fri,  1 Dec 2023 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GItS9ys7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E23519AE;
	Fri,  1 Dec 2023 08:17:00 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id EED9820B74C0;
	Fri,  1 Dec 2023 08:16:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EED9820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701447419;
	bh=NMYkmf4971siLaRL4OWx2op6fuwe7tx/W/X81lmjSxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GItS9ys7im+FCS/EcsKLiMbm8OOpOlpEo7mev1mM6uvfYmK7n/gq8kdDL30K4OoCk
	 jnCSMBlqUwV8OWLpBsct4In2pzDgbDzaX//ugzHjVON0i0f1wB5K7ndNiqQLnGp2Ht
	 /rTb8ld5hUhuP8wzqIVDfp6FdEOxglkP0PZXrmcc=
Message-ID: <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
Date: Fri, 1 Dec 2023 17:16:56 +0100
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
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
 "Cui, Dexuan" <decui@microsoft.com>
Cc: "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "cascardo@canonical.com" <cascardo@canonical.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/11/2023 05:36, Huang, Kai wrote:
> On Fri, 2023-11-24 at 17:19 +0100, Jeremi Piotrowski wrote:
>> On 24/11/2023 14:33, Kirill A. Shutemov wrote:
>>> On Fri, Nov 24, 2023 at 12:04:56PM +0100, Jeremi Piotrowski wrote:
>>>> On 24/11/2023 11:43, Kirill A. Shutemov wrote:
>>>>> On Fri, Nov 24, 2023 at 11:31:44AM +0100, Jeremi Piotrowski wrote:
>>>>>> On 23/11/2023 14:58, Kirill A. Shutemov wrote:
>>>>>>> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
>>>>>>>> Check for additional CPUID bits to identify TDX guests running with Trust
>>>>>>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>>>>>>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>>>>>>>
>>>>>>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
>>>>>>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>>>>>>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>>>>>>>> aware mechanisms for what's left. So currently such guests do not have
>>>>>>>> X86_FEATURE_TDX_GUEST set.
>>>>>>>>
>>>>>>>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
>>>>>>>> need to check these additional CPUID bits, but we skip further initialization
>>>>>>>> in the function as we aren't guaranteed access to TDX module calls.
>>>>>>>
>>>>>>> I don't follow. The idea of partitioning is that L2 OS can be
>>>>>>> unenlightened and have no idea if it runs indide of TD. But this patch
>>>>>>> tries to enumerate TDX anyway.
>>>>>>>
>>>>>>> Why?
>>>>>>>
>>>>>>
>>>>>> That's not the only idea of partitioning. Partitioning provides different privilege
>>>>>> levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
>>>>>> In our case Linux always runs enlightened (both with and without TD partitioning), and
>>>>>> uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).
>>>>>
>>>>> What value L1 adds in this case? If L2 has to be enlightened just run the
>>>>> enlightened OS directly as L1 and ditch half-measures. I think you can
>>>>> gain some performance this way.
>>>>>
>>>>
>>>> It's primarily about the privilege separation, performance is a reason
>>>> one doesn't want to run unenlightened. The L1 makes the following possible:
>>>> - TPM emulation within the trust domain but isolated from the OS
>>>> - infrastructure interfaces for things like VM live migration
>>>> - support for Virtual Trust Levels[1], Virtual Secure Mode[2]
>>>>
>>>> These provide a lot of value to users, it's not at all about half-measures.
> 
> It's not obvious why the listed things above are related to TDX guest.  They
> look more like hyperv specific enlightenment which don't have dependency of TDX
> guest.
> 
> For instance, the "Emulating Hyper-V VSM with KVM" design in your above [2] says
> nothing about TDX (or SEV):
> 
> https://lore.kernel.org/lkml/20231108111806.92604-34-nsaenz@amazon.com/
> 

These are features that require TD-partitioning to implement in the context of a
TDX guest. I was trying to answer Kirill's question "What value L1 adds in this case?".

In SEV-SNP we implement the same features using VMPLs (privilege levels) and an SVSM
(but call it paravisor).

I should have elaborated on what I meant with [2]: it shows how others are trying to 
implement Virtual Trust Levels in KVM for non-confidential guests. You can't do that
for TDX without TD-partitioning.

>>>
>>> Hm. Okay.
>>>
>>> Can we take a step back? What is bigger picture here? What enlightenment
>>> do you expect from the guest when everything is in-place?
>>>
>>
>> All the functional enlightenment are already in place in the kernel and
>> everything works (correct me if I'm wrong Dexuan/Michael). The enlightenments
>> are that TDX VMCALLs are needed for MSR manipulation and vmbus operations,
>> encrypted bit needs to be manipulated in the page tables and page
>> visibility propagated to VMM.
> 
> Not quite family with hyperv enlightenments, but are these enlightenments TDX
> guest specific?  Because if they are not, then they should be able to be
> emulated by the normal hyperv, thus the hyperv as L1 (which is TDX guest) can
> emulate them w/o letting the L2 know the hypervisor it runs on is actually a TDX
> guest.

I would say that these hyperv enlightenments are confidential guest specific
(TDX/SNP) when running with TD-partitioning/VMPL. In both cases there are TDX/SNP
specific ways to exit directly to L0 (when needed) and native privileged instructions
trap to the paravisor.

L1 is not hyperv and no one wants to emulate the I/O path. The L2 guest knows that
it's confidential so that it can explicitly use swiotlb, toggle page visibility
and notify the host (L0) on the I/O path without incurring additional emulation
overhead.

> 
> Btw, even if there's performance concern here, as you mentioned the TDVMCALL is
> actually made to the L0 which means L0 must be aware such VMCALL is from L2 and
> needs to be injected to L1 to handle, which IMHO not only complicates the L0 but
> also may not have any performance benefits.

The TDVMCALLs are related to the I/O path (networking/block io) into the L2 guest, and
so they intentionally go straight to L0 and are never injected to L1. L1 is not
involved in that path at all.

Using something different than TDVMCALLs here would lead to additional traps to L1 and
just add latency/complexity.

> 
>>
>> Whats missing is the tdx_guest flag is not exposed to userspace in /proc/cpuinfo,
>> and as a result dmesg does not currently display:
>> "Memory Encryption Features active: Intel TDX".
>>
>> That's what I set out to correct.
>>
>>> So far I see that you try to get kernel think that it runs as TDX guest,
>>> but not really. This is not very convincing model.
>>>
>>
>> No that's not accurate at all. The kernel is running as a TDX guest so I
>> want the kernel to know that. 
>>
> 
> But it isn't.  It runs on a hypervisor which is a TDX guest, but this doesn't
> make itself a TDX guest.> 

That depends on your definition of "TDX guest". The TDX 1.5 TD partitioning spec
talks of TDX-enlightened L1 VMM, (optionally) TDX-enlightened L2 VM and Unmodified
Legacy L2 VM. Here we're dealing with a TDX-enlightened L2 VM.

If a guest runs inside an Intel TDX protected TD, is aware of memory encryption and
issues TDVMCALLs - to me that makes it a TDX guest.

>> TDX is not a monolithic thing, it has different
>> features that can be in-use and it has differences in behavior when running
>> with TD partitioning (example: no #VE/TDX module calls). So those differences
>> need to be clearly modeled in code.
> 
> Well IMHO this is a design choice but not a fact.  E.g., if we never sets
> TDX_GUEST flag for L2 then it naturally doesn't use TDX guest related staff. 
> Otherwise we need additional patches like your patch 2/3 in this series to stop
> the L2 to use certain TDX functionality.
> 
> And I guess we will need more patches to stop L2 from doing TDX guest things. 
> E.g., we might want to disable TDX attestation interface support in the L2
> guest, because the L2 is indeed not a TDX guest..
> 

The TDX attestation interface uses a TDCALL, I covered that in patch 2. The only
extra patch missing is to not rely on tdx_safe_halt (which is a TDVMCALL).

> So to me even there's value to advertise L2 as TDX guest, the pros/cons need to
> be evaluated to see whether it is worth.
> 

This all started from this discussion [1]. X86_FEATURE_TDX_GUEST is needed so
that dmesg contains the correct print ("Memory Encryption Features active: Intel TDX")
and so that userspace sees X86_FEATURE_TDX_GUEST. I think it's fair to want parity
here so that a workload scheduler like kubernetes knows how to place a workload
in a TDX protected VM, regardless of what hypervisor runs underneath.

[1]: https://lore.kernel.org/lkml/1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com/

>>
>>> Why does L2 need to know if it runs under TDX or SEV? Can't it just think
>>> it runs as Hyper-V guest and all difference between TDX and SEV abstracted
>>> by L1?
>>>
>>
>> If you look into the git history you'll find this was attempted with
>> CC_VENDOR_HYPERV. That proved to be a dead end as some things just can't be
>> abstracted (GHCI vs GHCB; the encrypted bit works differently). What resulted
>> was a ton of conditionals and duplication. After long discussions with Borislav
>> we converged on clearly identifying with the underlying technology (SEV/TDX)
>> and being explicit about support for optional parts in each scheme (like vTOM).
> 
> Can you provide more background?  For instance, why does the L2 needs to know
> the encrypted bit that is in *L1*?
> 
> 

Michael or Dexuan know way more about this than me, but my understanding is that when
the L2 guest accesses a bounce buffer that it has shared with the host then it needs
to do so through a mapping the correct kind of mapping with the "decrypted bit" set.

