Return-Path: <linux-hyperv+bounces-10659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAEEEIgK/GkAKQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10659-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 05:44:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E94E2B56
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 05:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A7D30158A5
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B42E7F25;
	Thu,  7 May 2026 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZNlBaGdB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2E1EB5F8;
	Thu,  7 May 2026 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125419; cv=none; b=CAUEIiEy5GD94TKu4BoFDMEKQwubAeqmrRny5Jo3Gc2Xbb9Lth4noYHRr0im/c+ViyJ+crn8A8I0/gwk52px/ku6AKYdin5Bx7Whz2RKatUEKq5IAzs9HgAQ3yGKAr0oZbVEwEsmZGsrYc4VxD3RbTMD2WSL9/f8Mci2pH+ZPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125419; c=relaxed/simple;
	bh=nTs/z2Wq8LCfWPMl6GiK8n/iSq19n7fi1bFLnQKW8Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFhARVrp0zACf5GZyrNj5aWVMKzLnOMstzx2oOaS6BmBB6BOA9wB97tenNkHkxfoL9h+uaMGGM4Qn+mJ97V+PQzgBSaPtceTT9OiuCmjb1I1ZrKMqsPVkFrVkWbHxH8XLtp8tQerVIzj2pXs77FmUs0ejJMj4i942Kwe8QMs9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZNlBaGdB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.64] (unknown [167.220.238.64])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33FE320B7165;
	Wed,  6 May 2026 20:43:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33FE320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778125413;
	bh=ZaiVA7FK64HzHiW79paCCu3hRwFlMBFKVgvgM3gbwUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZNlBaGdBTGgWhXBzXBgqOVZm/b/shQdBDzoIUFvlVMUYDb35gRYc2aRNtfBtUwVde
	 0yvNU7byjWVWhwL6ErC+tJLxcEwic9+viIQo4EvQsOVk3Ed9dZyD3pgRTvCuHQWwws
	 ORdyFcW2lS6CP3jUPBUMPamNznpGn0N/JJmWavVk=
Message-ID: <b9ab1860-ec82-4a82-abac-f099a3747ba8@linux.microsoft.com>
Date: Thu, 7 May 2026 09:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
To: Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sascha Bischoff <sascha.bischoff@arm.com>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "vdso@mailbox.org" <vdso@mailbox.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-10-namjain@linux.microsoft.com>
 <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <567cf73b-6a48-4fc3-b312-9be6d71e2f22@linux.microsoft.com>
 <SN6PR02MB4157AD364DE0755DE070D286D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
 <024aed8c-cd97-45f0-a653-489fc334a2b9@linux.microsoft.com>
 <SN6PR02MB4157D109AF4B5C62EF7F0E2CD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157D109AF4B5C62EF7F0E2CD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D3E94E2B56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10659-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action



On 5/6/2026 8:06 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, May 5, 2026 10:50 PM
>>
>> On 5/4/2026 9:36 PM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 29, 2026 2:58 AM
>>>>
>>>> On 4/27/2026 11:10 AM, Michael Kelley wrote:
>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>>>>>
>>>>>> Move hv_vtl_configure_reg_page() from drivers/hv/mshv_vtl_main.c to
>>>>>> arch/x86/hyperv/hv_vtl.c. The register page overlay is an x86-specific
>>>>>> feature that uses HV_X64_REGISTER_REG_PAGE, so its configuration belongs
>>>>>> in architecture-specific code.
>>>>>>
>>>>>> Move struct mshv_vtl_per_cpu and union hv_synic_overlay_page_msr to
>>>>>> include/asm-generic/mshyperv.h so they are visible to both arch and
>>>>>> driver code.
>>>>>>
>>>>>> Change the return type from void to bool so the caller can determine
>>>>>> whether the register page was successfully configured and set
>>>>>> mshv_has_reg_page accordingly.
>>>>>>
>>>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>>>> ---
>>>>>>     arch/x86/hyperv/hv_vtl.c       | 32 ++++++++++++++++++++++
>>>>>>     drivers/hv/mshv_vtl_main.c     | 49 +++-------------------------------
>>>>>>     include/asm-generic/mshyperv.h | 17 ++++++++++++
>>>>>>     3 files changed, 53 insertions(+), 45 deletions(-)
>>>>>>
>>>>
>>>> <snip>
>>>>
>>>>>>     #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>>>>> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
>>>>>
>>>>> This comment pre-dates your patch, but I don't understand the point
>>>>> it is trying to make. The comment is factually true, but I don't know
>>>>> why calling that out is relevant. The REG_PAGE MSR seems to be
>>>>> conceptually separate and distinct from the SIMP MSR, so the fact
>>>>> that the layouts are the same is just a coincidence. Or is there some
>>>>> relationship between the two MSRs that I'm not aware of, and the
>>>>> comment is trying (and failing?) to point out?
>>>>
>>>> This was added as per suggestion from Nuno in my initial series for
>>>> MSHV_VTL. If the reference in "identical to" is misleading, I should
>>>> remove it.
>>>>
>>>> https://lore.kernel.org/all/68143eb0-e6a7-4579-bedb-4c2ec5aaef6b@linux.microsoft.com/
>>>>
>>>> Quoting:
>>>> """
>>>> it is a generic structure that
>>>> appears to be used for several overlay page MSRs (SIMP, SIEF, etc).
>>>>
>>>> But, the type doesn't appear in the hv*dk headers explicitly; it's just
>>>> used internally by the hypervisor.
>>>>
>>>> I think it should be renamed with a hv_ prefix to indicate it's part of
>>>> the hypervisor ABI, and a brief comment with the provenance:
>>>>
>>>> /* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
>>>> union hv_synic_overlay_page_msr {
>>>> 	/* <snip> */
>>>> };
>>>
>>> OK, so this union is not associated *only* with the REG_PAGE MSR
>>> (though that MSR is the only current user). Instead, it is intended to
>>> be a more generic description of MSRs that set up overlay pages. I
>>> don't think I had previously noticed Nuno's comment on the topic.
>>>
>>> Looking through hvgdk_mini.h and hvhdk.h, I see 6 definitions that
>>> are exactly the same:
>>>
>>> * union hv_reference_tsc_msr
>>> * union hv_x64_msr_hypercall_contents
>>> * union hv_vp_assist_msr_contents
>>> * union hv_synic_simp
>>> * union hv_synic_siefp
>>> * union hv_synic_sirbp
>>>
>>> There's an argument to be made for removing these 6 unique definitions
>>> and using union hv_synic_overlay_page_msr instead (though "synic"
>>> would need to be removed from the name).  I would not object to such
>>> an approach. It's a small extra layer of conceptual indirection, but saves
>>> some lines of code for duplicative definitions. The alternative is to drop
>>> the idea of a generic overlay page MSR layout, and replace union
>>> hv_synic_overlay_page_msr with a definition that is specific to the
>>> REG_PAGE MSR, like the other six above.
>>>
>>
>> Hi Michael,
>>
>> While having a generic definition looks good to have here, I can see two
>> reasons for not going ahead with generic overlay page definition:
>> 1. All of the above definitions are present in Hyper-V headers and
>> generalizing them would deviate from the strategy of keeping the kernel
>> headers in line with Hyper-V headers.
>> 2. For any of these definitions, if the use-case requires using some of
>> these reserved bits, then it would be a problem. I can actually see that
>> happening in "hv_x64_msr_hypercall_contents" in the corresponding
>> variant in the Hyper-V header.
> 
> Your points are certainly valid, and I'm good with not going the
> generic route.
> 
>>
>>> I could go either way. If we want to use a generic overlay page definition,
>>> then that approach should be applied everywhere. With the current
>>> state of your patch set, we're halfway in between -- the generic definition
>>> is used one place, but duplicative specific MSR definitions are used other
>>> places. That's probably the least desirable approach.
>>>
>>> Michael
>>
>>
>> Now, coming back to the hv_synic_overlay_page_msr definition. While
>> Nuno's comment hinted at it being "generic", the same is not documented
>> in the name of this structure or its comments. So it should be safe to
>> assume that it is specific to synic_overlay_page_msr usage. But since it
>> is not part of Hyper-V header as such, we needed that comment:
>> "/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */"
>>
> 
> An "overlay page" is a generic concept in the Hyper-V world, and it is used
> in multiple places in the guest<->hypervisor interface. The old PDF version of
> the Hyper-V TLFS describes overlay pages in the section 5.2.1 entitled "GPA
> Overlay Pages". See [1]. Unfortunately, this material about overlay pages
> doesn't seem to have been carried over to the web page version of the TLFS.
> 
> So in my thinking, the name "hv_synic_overlay_page_msr" is inherently
> a generic definition that could be applied to multiple MSRs that are used to
> specify overlay pages. Your patch is about a specific MSR,
> HV_X64_REGISTER_REG_PAGE, which happens to be used to define an
> overlay page. But if the decision is to *not* go the generic route, I
> would expect to see something like "union hv_x64_reg_page_msr"
> that is specific to the REG_PAGE MSR, and to have that type used in
> hv_vtl_configure_reg_page(). The definition of hv_x64_reg_page_msr
> would not have a comment referencing the SIMP or any other MSR
> because it would be a standalone definition that is specific to
> HV_X64_REGISTER_REG_PAGE. Then the pattern would be the same as
> the other six cases that I listed above.
> 
> When not using the generic approach, hv_synic_overlay_page_msr
> really has no purpose, and could go away.
> 
> Michael
> 
> [1] https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf


Thanks for suggesting this, I was not aware of it. I'll change it to 
hv_x64_reg_page_msr and remove the comment.

Regards,
Naman


