Return-Path: <linux-hyperv+bounces-844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E787E7D84
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 16:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09591C2090D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2581DA43;
	Fri, 10 Nov 2023 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XT+5CtK1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA521DA36
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 15:51:50 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11BD43B328;
	Fri, 10 Nov 2023 07:51:49 -0800 (PST)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id D14D220B74C0;
	Fri, 10 Nov 2023 07:51:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D14D220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699631508;
	bh=GUjVGqNVu7d4fvxVqt/6V3ZEo+hYIJHaOrVg7KkMyso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XT+5CtK1/lHZ/9RzAt+v+Lnkte27rdQtrTdOScIhTjMKBDV+zw7iJQYaiqjjcHz1Y
	 1X7ik9coUml3O3Qb3efw6JDD+VpkiGwO+VTNgFDwP4kiG0JQOifmfZwVK08H+NFe3i
	 yiC2bIfKu+qZbWagc9iKRmj4/72zgO+7HaLmIVFY=
Message-ID: <73b51be2-cc60-4818-bdba-14b33576366d@linux.microsoft.com>
Date: Fri, 10 Nov 2023 16:51:43 +0100
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
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2023 14:17, Borislav Petkov wrote:
> On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
>> tdx_early_init() changes kernel behavior with the assumption that it
>> can talk directly to the TD module or change page visibility in
>> a certain way, instead of talking to a paravisor. So that CPUID is
>> hidden to prevent this.  Otherwise tdx_early_init() would need to be
>> modified to check "am I running with TD partitioning and if so
>> - switch to other implementations".
> 
> Here we go with the virt zoo again. If you hide TDX_CPUID_LEAF_ID from
> it, then it of course doesn't know that it is a TDX guest. This is the
> same thing as the SNP vTom thing: the only viable way going forward is
> for the guest kernel to detect correctly what it runs on and act
> accordingly.

That part already works correctly. The kernel knows very well that it is a
TDX guest because TD partitioning (same as SNP vTOM) support uses the standard
coco mechanisms to indicate that to the kernel. The kernel is well aware of
how to operate in this case: use bounce buffers, flip page visibility by calling
the correct hoosk, etc. Same flow as for every other flavor of confidential guest.

> 
> You can't just do some semi-correct tests for vendor - correct only
> if you squint hard enough - and hope that it works because it'll break
> apart eventually, when that second-level TDX fun needs to add more
> hackery to the guest kernel.
> 

What's semi-correct about checking for CC_VENDOR_INTEL and then printing Intel?
I can post a v2 that checks CC_ATTR_GUEST_MEM_ENCRYPT before printing "TDX".
Feature printing needs to evolve as new technologies come along.

> So, instead, think about how the paravisor tells the guest it is running
> on one - a special CPUID leaf or an MSR in the AMD case - and use that> to detect it properly.

The paravisor *is* telling the guest it is running on one - using a CPUID leaf
(HYPERV_CPUID_ISOLATION_CONFIG). A paravisor is a hypervisor for a confidential
guest, that's why paravisor detection shares logic with hypervisor detection.

tdx_early_init() runs extremely early, way before hypervisor(/paravisor) detection.
If the TDX_CPUID_LEAF_ID leaf were present it would require duplicating hypervisor/paravisor
logic in that function (and in sme_early_init()). As soon as we'd detect the
paravisor we'd need to avoid performing tdx_module_calls() (because they're not
allowed) so the function would return without doing anything useful:

void __init tdx_early_init(void)
{
        u64 cc_mask;
        u32 eax, sig[3];

        cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);

        if (memcmp(TDX_IDENT, sig, sizeof(sig)))
                return;

        setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

        cc_vendor = CC_VENDOR_INTEL;

        /* Can't perform tdx_module_calls when a paravisor is present */
        if (early_detect_paravisor())
                goto exit;

        ....
exit:
        pr_info("Guest detected\n");
}

Additionally we'd need to sprinkle paravisor checks along with existing X86_FEATURE_TDX_GUEST
checks. And any time someone adds a new feature that depends solely on X86_FEATURE_TDX_GUEST
we'd run the chance of it breaking things.

That would be a mess.

Jeremi


> 
> Everything else is a mess waiting to happen.
> 
> Thx.
> 



