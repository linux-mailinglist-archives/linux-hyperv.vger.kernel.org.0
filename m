Return-Path: <linux-hyperv+bounces-1256-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236468077F7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Dec 2023 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AC5B20FAA
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Dec 2023 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C7364C7;
	Wed,  6 Dec 2023 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lsixbao9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F27E1BD8;
	Wed,  6 Dec 2023 10:47:20 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DC9620B74C0;
	Wed,  6 Dec 2023 10:47:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DC9620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701888439;
	bh=6KggGmz88rhr5n/dsclowm4NnGB7AvZhaFeWmFu6uuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lsixbao9JxNBxqxN+ypdKlIANt1PJcuGSRpIlNkIbAa1NhL5DUV4DEvTZ+ONIeYoE
	 ZaBvGG4b8Ye5biVo1EOgmjLI7Fu/vfjm93tB19/kNPsoktMbMvua8CA3iZBmq0246U
	 Vxsq5shDTdzp4pyROPD59NPFMpTfU4Cs337/Rzlc=
Message-ID: <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
Date: Wed, 6 Dec 2023 19:47:12 +0100
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
Cc: "cascardo@canonical.com" <cascardo@canonical.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
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
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/12/2023 14:26, Huang, Kai wrote:
>>
>>>>>
>>>>> Hm. Okay.
>>>>>
>>>>> Can we take a step back? What is bigger picture here? What enlightenment
>>>>> do you expect from the guest when everything is in-place?
>>>>>
>>>>
>>>> All the functional enlightenment are already in place in the kernel and
>>>> everything works (correct me if I'm wrong Dexuan/Michael). The enlightenments
>>>> are that TDX VMCALLs are needed for MSR manipulation and vmbus operations,
>>>> encrypted bit needs to be manipulated in the page tables and page
>>>> visibility propagated to VMM.
>>>
>>> Not quite family with hyperv enlightenments, but are these enlightenments TDX
>>> guest specific?  Because if they are not, then they should be able to be
>>> emulated by the normal hyperv, thus the hyperv as L1 (which is TDX guest) can
>>> emulate them w/o letting the L2 know the hypervisor it runs on is actually a TDX
>>> guest.
>>
>> I would say that these hyperv enlightenments are confidential guest specific
>> (TDX/SNP) when running with TD-partitioning/VMPL. In both cases there are TDX/SNP
>> specific ways to exit directly to L0 (when needed) and native privileged instructions
>> trap to the paravisor.
>>
>> L1 is not hyperv and no one wants to emulate the I/O path. The L2 guest knows that
>> it's confidential so that it can explicitly use swiotlb, toggle page visibility
>> and notify the host (L0) on the I/O path without incurring additional emulation
>> overhead.
>>
>>>
>>> Btw, even if there's performance concern here, as you mentioned the TDVMCALL is
>>> actually made to the L0 which means L0 must be aware such VMCALL is from L2 and
>>> needs to be injected to L1 to handle, which IMHO not only complicates the L0 but
>>> also may not have any performance benefits.
>>
>> The TDVMCALLs are related to the I/O path (networking/block io) into the L2 guest, and
>> so they intentionally go straight to L0 and are never injected to L1. L1 is not
>> involved in that path at all.
>>
>> Using something different than TDVMCALLs here would lead to additional traps to L1 and
>> just add latency/complexity.
> 
> Looks by default you assume we should use TDX partitioning as "paravisor L1" +
> "L0 device I/O emulation".
> 

I don't actually want to impose this model on anyone, but this is the one that
could use some refactoring. I intend to rework these patches to not use a single
"td_partitioning_active" for decisions.

> I think we are lacking background of this usage model and how it works.  For
> instance, typically L2 is created by L1, and L1 is responsible for L2's device
> I/O emulation.  I don't quite understand how could L0 emulate L2's device I/O?
> 
> Can you provide more information?

Let's differentiate between fast and slow I/O. The whole point of the paravisor in
L1 is to provide device emulation for slow I/O: TPM, RTC, NVRAM, IO-APIC, serial ports.

But fast I/O is designed to bypass it and go straight to L0. Hyper-V uses paravirtual
vmbus devices for fast I/O (net/block). The vmbus protocol has awareness of page visibility
built-in and uses native (GHCI on TDX, GHCB on SNP) mechanisms for notifications. So once
everything is set up (rings/buffers in swiotlb), the I/O for fast devices does not
involve L1. This is only possible when the VM manages C-bit itself.

I think the same thing could work for virtio if someone would "enlighten" vring
notification calls (instead of I/O or MMIO instructions).

> 
>>
>>>
>>>>
>>>> Whats missing is the tdx_guest flag is not exposed to userspace in /proc/cpuinfo,
>>>> and as a result dmesg does not currently display:
>>>> "Memory Encryption Features active: Intel TDX".
>>>>
>>>> That's what I set out to correct.
>>>>
>>>>> So far I see that you try to get kernel think that it runs as TDX guest,
>>>>> but not really. This is not very convincing model.
>>>>>
>>>>
>>>> No that's not accurate at all. The kernel is running as a TDX guest so I
>>>> want the kernel to know that. 
>>>>
>>>
>>> But it isn't.  It runs on a hypervisor which is a TDX guest, but this doesn't
>>> make itself a TDX guest.> 
>>
>> That depends on your definition of "TDX guest". The TDX 1.5 TD partitioning spec
>> talks of TDX-enlightened L1 VMM, (optionally) TDX-enlightened L2 VM and Unmodified
>> Legacy L2 VM. Here we're dealing with a TDX-enlightened L2 VM.
>>
>> If a guest runs inside an Intel TDX protected TD, is aware of memory encryption and
>> issues TDVMCALLs - to me that makes it a TDX guest.
> 
> The thing I don't quite understand is what enlightenment(s) requires L2 to issue
> TDVMCALL and know "encryption bit".
> 
> The reason that I can think of is:
> 
> If device I/O emulation of L2 is done by L0 then I guess it's reasonable to make
> L2 aware of the "encryption bit" because L0 can only write emulated data to
> shared buffer.  The shared buffer must be initially converted by the L2 by using
> MAP_GPA TDVMCALL to L0 (to zap private pages in S-EPT etc), and L2 needs to know
> the "encryption bit" to set up its page table properly.  L1 must be aware of
> such private <-> shared conversion too to setup page table properly so L1 must
> also be notified.

Your description is correct, except that L2 uses a hypercall (hv_mark_gpa_visibility())
to notify L1 and L1 issues the MAP_GPA TDVMCALL to L0.

C-bit awareness is necessary to setup the whole swiotlb pool to be host visible for
DMA.

> 
> The concern I am having is whether there's other usage model(s) that we need to
> consider.  For instance, running both unmodified L2 and enlightened L2.  Or some
> L2 only needs TDVMCALL enlightenment but no "encryption bit".
> 

Presumably unmodified L2 and enlightened L2 are already covered by current code but
require excessive trapping to L1.

I can't see a usecase for TDVMCALLs but no "encryption bit". 

> In other words, that seems pretty much L1 hypervisor/paravisor implementation
> specific.  I am wondering whether we can completely hide the enlightenment(s)
> logic to hypervisor/paravisor specific code but not generically mark L2 as TDX
> guest but still need to disable TDCALL sort of things.

That's how it currently works - all the enlightenments are in hypervisor/paravisor
specific code in arch/x86/hyperv and drivers/hv and the vm is not marked with
X86_FEATURE_TDX_GUEST.

But without X86_FEATURE_TDX_GUEST userspace has no unified way to discover that an
environment is protected by TDX and also the VM gets classified as "AMD SEV" in dmesg.
This is due to CC_ATTR_GUEST_MEM_ENCRYPT being set but X86_FEATURE_TDX_GUEST not.

> 
> Hope we are getting closer to be on the same page.
> 

I feel we are getting there

