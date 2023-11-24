Return-Path: <linux-hyperv+bounces-1050-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429687F78C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C592811D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70E33CFA;
	Fri, 24 Nov 2023 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YDm2n3hF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52F9199A;
	Fri, 24 Nov 2023 08:19:48 -0800 (PST)
Received: from [192.168.1.150] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CB3E20B74C0;
	Fri, 24 Nov 2023 08:19:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CB3E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700842788;
	bh=y/iXAqpUVSBXxsl40YVBg93EGfjbUQXj+lkf6hLjxzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YDm2n3hFWmreZjT+MHHX4GF4KrTMaSuD63YV4ICVgreMTN9ba8PUvNpV3S2rDSXA0
	 JoIKsZDDSehcpPXBQIZBsfJ/oI9u80WOZGfbAZGWMc4ztpkUJ8Jul8DA0GdAnI5HdC
	 jihBQv5GMovZBhdKiuVFZ5pIQCBufXhtu7RMV6UY=
Message-ID: <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
Date: Fri, 24 Nov 2023 17:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Kelley <mhkelley58@gmail.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 stefan.bader@canonical.com, tim.gardner@canonical.com,
 roxana.nicolescu@canonical.com, cascardo@canonical.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, sashal@kernel.org,
 stable@vger.kernel.org
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
Content-Language: en-US
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2023 14:33, Kirill A. Shutemov wrote:
> On Fri, Nov 24, 2023 at 12:04:56PM +0100, Jeremi Piotrowski wrote:
>> On 24/11/2023 11:43, Kirill A. Shutemov wrote:
>>> On Fri, Nov 24, 2023 at 11:31:44AM +0100, Jeremi Piotrowski wrote:
>>>> On 23/11/2023 14:58, Kirill A. Shutemov wrote:
>>>>> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
>>>>>> Check for additional CPUID bits to identify TDX guests running with Trust
>>>>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
>>>>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
>>>>>>
>>>>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
>>>>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
>>>>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
>>>>>> aware mechanisms for what's left. So currently such guests do not have
>>>>>> X86_FEATURE_TDX_GUEST set.
>>>>>>
>>>>>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
>>>>>> need to check these additional CPUID bits, but we skip further initialization
>>>>>> in the function as we aren't guaranteed access to TDX module calls.
>>>>>
>>>>> I don't follow. The idea of partitioning is that L2 OS can be
>>>>> unenlightened and have no idea if it runs indide of TD. But this patch
>>>>> tries to enumerate TDX anyway.
>>>>>
>>>>> Why?
>>>>>
>>>>
>>>> That's not the only idea of partitioning. Partitioning provides different privilege
>>>> levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
>>>> In our case Linux always runs enlightened (both with and without TD partitioning), and
>>>> uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).
>>>
>>> What value L1 adds in this case? If L2 has to be enlightened just run the
>>> enlightened OS directly as L1 and ditch half-measures. I think you can
>>> gain some performance this way.
>>>
>>
>> It's primarily about the privilege separation, performance is a reason
>> one doesn't want to run unenlightened. The L1 makes the following possible:
>> - TPM emulation within the trust domain but isolated from the OS
>> - infrastructure interfaces for things like VM live migration
>> - support for Virtual Trust Levels[1], Virtual Secure Mode[2]
>>
>> These provide a lot of value to users, it's not at all about half-measures.
> 
> Hm. Okay.
> 
> Can we take a step back? What is bigger picture here? What enlightenment
> do you expect from the guest when everything is in-place?
> 

All the functional enlightenment are already in place in the kernel and
everything works (correct me if I'm wrong Dexuan/Michael). The enlightenments
are that TDX VMCALLs are needed for MSR manipulation and vmbus operations,
encrypted bit needs to be manipulated in the page tables and page
visibility propagated to VMM.

Whats missing is the tdx_guest flag is not exposed to userspace in /proc/cpuinfo,
and as a result dmesg does not currently display:
"Memory Encryption Features active: Intel TDX".

That's what I set out to correct.

> So far I see that you try to get kernel think that it runs as TDX guest,
> but not really. This is not very convincing model.
> 

No that's not accurate at all. The kernel is running as a TDX guest so I
want the kernel to know that. TDX is not a monolithic thing, it has different
features that can be in-use and it has differences in behavior when running
with TD partitioning (example: no #VE/TDX module calls). So those differences
need to be clearly modeled in code.

> Why does L2 need to know if it runs under TDX or SEV? Can't it just think
> it runs as Hyper-V guest and all difference between TDX and SEV abstracted
> by L1?
> 

If you look into the git history you'll find this was attempted with
CC_VENDOR_HYPERV. That proved to be a dead end as some things just can't be
abstracted (GHCI vs GHCB; the encrypted bit works differently). What resulted
was a ton of conditionals and duplication. After long discussions with Borislav
we converged on clearly identifying with the underlying technology (SEV/TDX)
and being explicit about support for optional parts in each scheme (like vTOM).

