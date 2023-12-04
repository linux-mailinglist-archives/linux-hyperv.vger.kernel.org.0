Return-Path: <linux-hyperv+bounces-1189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3281803524
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 14:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A3F1C2095C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3625116;
	Mon,  4 Dec 2023 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hy/8Psmf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0BF9191;
	Mon,  4 Dec 2023 05:39:09 -0800 (PST)
Received: from [100.66.64.18] (unknown [108.143.43.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 246E020B74C1;
	Mon,  4 Dec 2023 05:39:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 246E020B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701697148;
	bh=BtY3bVxPtr2XdgE2ZvKoiT1mqgpjS0iGQgzugKiTo+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hy/8PsmfTgS7df7xb+x9yGMaoEJdmcwSkjs0qSk4z8IGyhirMOK7pvLeWIx9kAeOA
	 oH52/3UsyfwuFtBdEP/mYS8f65zzZxyUm6kE2TIPyHtdRgRlur5d0PJVff+1AfFnjC
	 dUkGUg41jrA0GKxcGRmUSz9LShxyjqXmVJaaNSlU=
Message-ID: <8747ed90-72b8-49bf-8df7-5c5f06056fe2@linux.microsoft.com>
Date: Mon, 4 Dec 2023 14:39:03 +0100
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
To: "Reshetova, Elena" <elena.reshetova@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "cascardo@canonical.com" <cascardo@canonical.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michael Kelley <mhkelley58@gmail.com>, Nikolay Borisov
 <nik.borisov@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "Cui, Dexuan" <decui@microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
 <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/11/2023 09:31, Reshetova, Elena wrote:
> 
>> On Thu, Nov 30, 2023 at 07:08:00AM +0000, Reshetova, Elena wrote:
>>> ...
>>> 3. Normal TDX 1.0 guest that is unaware that it runs in partitioned
>>>    environment
>>> 4. and so on
>>
>> There's a reason I call it a virt zoo.
>>
>>> I don’t know if AMD architecture would support all this spectrum of
>>> the guests through.
>>
>> I hear threats...
> 
> No threats whatsoever, I just truly don’t know details of SEV architecture
> on this and how it envisioned to operate under this nesting scenario.
> I raised this point to see if we can build the common understanding 
> on this. My personal understanding (please correct me) was that SEV
> would also allow different types of L2 guests, so I think we should be
> aligning on this.
I don't think SNP allows the level of freedom you describe. But regardless
of the possibilities, I can't think of users of this technology actually
being interested in running all of these options. Would love to hear someone
speak up.

I think of VMPLs provided by SNP and the TD-partitioning L1/L2 scheme as
the equivalent of ARM's trustzone/EL3 concept. It lets you separate high
privilege operations into a hardware isolated context. In this case it's
within the same confidential computing boundary. That's our use case.
 
> 
>>
>>> Instead we should have a flexible way for the L2 guest to discover
>>> the virt environment it runs in (as modelled by L1 VMM) and the
>>> baseline should not to assume it is a TDX or SEV guest, but assume
>>> this is some special virt guest (or legacy guest, whatever approach
>>> is cleaner) and expose additional interfaces to it.
>>
>> You can do flexible all you want but all that guest zoo is using the
>> kernel. The same code base which boots on gazillion incarnations of real
>> hardware. And we have trouble keeping that code base clean already.
> 
> Fully agree, I wasn’t objecting this. What I was objecting is to make
> explicit assumptions on what the L2 guest under TDX partitioning is. 
> 

That's fair, my intention was to have this simple logic (if td-partitioning,
then this and this is given) until a different user of TD-partitioning comes
along and then we figure out which parts generalize.

>>
>> Now, all those weird guests come along, they're more or less
>> "compatible" but not fully. So they have to do an exception here,
>> disable some feature there which they don't want/support/cannot/bla. Or
>> they use a paravisor which does *some* of the work for them so that
>> needs to be accomodated too.
>>
>> And so they start sprinkling around all those "differences" around the
>> kernel. And turn it into an unmaintainable mess. We've been here before
>> - last time it was called "if (XEN)"... and we're already getting there
>> again only with two L1 encrypted guests technologies. I'm currently
>> working on trimming down some of the SEV mess we've already added...
>>
>> So - and I've said this a bunch of times already - whatever guest type
>> it is, its interaction with the main kernel better be properly designed
>> and abstracted away so that it doesn't turn into a mess.
> 
> Yes, agree, so what are our options and overall strategy on this? 
> We can try to push as much as possible complexity into L1 VMM in this
> scenario to keep the guest kernel almost free from these sprinkling differences.
> Afterall the L1 VMM can emulate whatever it wants for the guest.
> We can also see if there is a true need to add another virtualization
> abstraction here, i.e. "nested encrypted guest". But to justify this one
> we need to have usecases/scenarios where L1 VMM actually cannot run
> L2 guest (legacy or TDX enabled) as it is. 
> @Jeremi Piotrowski do you have such usecase/scenarios you can describe?
> > Any other options we should be considering as overall strategy? 

Just taking a step back: we're big SNP and TDX users. The only kind of guest
that meets our users needs on both SNP and TDX and that we support across
our server fleet is closest to what you listed as 2:
"guest with a CoCo security module (paravisor) and targeted CoCo enlightenments".

We're aligned on the need to push complexity out of the kernel which is exactly
what has happened (also across vendors): the guest is mostly unconcerned by the
differences between TDX and SNP (except notification hypercall in the I/O path),
does not need all the changes in the early boot code that TDX/SNP have forced,
switches page visibility with the same hypercall for both etc.

I'm not aware of use cases for fully legacy guests, and my guess is they would suffer
from excessive overhead.

I am also not aware of use cases for "pretending to be an TDX 1.0 guest". Doing that
removes opportunities to share kernel code with normal guests and SNP guests on hyperv.
I'd also like to point out something that Michael wrote here[1] regarding paravisor
interfaces:
"But it seems like any kind of (forwarding) scheme needs to be a well-defined contract
that would work for both TDX and SEV-SNP."

[1]: https://lore.kernel.org/lkml/SN6PR02MB415717E09C249A31F2A4E229D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com/

Another thing to note: in SNP you *need* to interact with VMPL0 (~L1 VMM) when
running at other VMPLs (eg. pvalidate and rmpadjust only possible at VMPL0) so
the kernel needs to cooperate with VMPL0 to operate. On skimming the TD-part
spec I'm not sure how "supporting fast-path I/O" would be possible with supporting
a "TDX 1.0 guest" with no TD-part awareness (if you need to trap all TDVMCALL then
that's not OK).

Now back to the topic at hand: I think what's needed is to stop treating
X86_FEATURE_TDX_GUEST as an all-or-nothing thing. Split out the individual
enlightenment into separate CC attributes, allow them to be selected without
requiring you to buy the whole zoo. I don't think we need a "nested encrypted guest"
abstraction.

Jeremi

> 
> Best Regards,
> Elena.
> 
>>
>> Thx.
>>
>> --
>> Regards/Gruss,
>>     Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette


