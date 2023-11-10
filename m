Return-Path: <linux-hyperv+bounces-835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394877E7C28
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 13:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C911C203DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239B18E15;
	Fri, 10 Nov 2023 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KdRWVtyd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9818E09
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 12:27:16 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1903A6FBF;
	Fri, 10 Nov 2023 04:27:15 -0800 (PST)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25A5820B74C0;
	Fri, 10 Nov 2023 04:27:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25A5820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699619233;
	bh=aAFVWtwiu6x+35A7o2OY0KDyWLYfSVIZY373tBGp+R0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KdRWVtydl5Y/3Ld1JNd2X+ewHpODShTJ/3KaMPk3gG8u/wcL3wxL56IkvYdweleeN
	 TVh6NMQP8+oamyWEE/r42lY++rzNN2XSROA5OsQcbSXmM1xl5sxU/TQl+L+fEJP/zC
	 HLxiMvPLA7qdxgckLx2NGrV43iKnrc7PmZFreMnQ=
Message-ID: <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
Date: Fri, 10 Nov 2023 13:27:08 +0100
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
To: kirill.shutemov@linux.intel.com
Cc: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
 tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
 cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2023 13:06, kirill.shutemov@linux.intel.com wrote:
> On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
>> It's not disregard, the way the kernel behaves in this case is correct except
>> for the error in reporting CPU vendor. Users care about seeing the correct
>> information in dmesg.
> 
> I think it is wrong place to advertise CoCo features. It better fits into
> Intel/AMD-specific code that knows better what it is running on. Inferring
> it from generic code has been proved problematic as you showed.
> 

Let's not make this into a bigger issue than it is. There is a check that does
not cover all cases, and needs to be changed into a different check that covers
all cases. I'd wouldn't call that problematic.

I would be open to moving the function to arch/x86/coco/core.c or providing a
mechanism for cpu/paravisor-specific code to do the reporting (which is what
Dexuan originally proposed [1]).

[1]: https://lore.kernel.org/lkml/20231019062030.3206-1-decui@microsoft.com/

> Maybe just remove incorrect info and that's it?
> 

I disagree, other users and I find the print very useful to see which coco
platform the kernel is running on and which confidential computing features
the kernel detected. I'm willing to fix the code to report correct info.

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c290c55b632b..f573a97c0524 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -40,42 +40,6 @@ bool force_dma_unencrypted(struct device *dev)
>  	return false;
>  }
>  
> -static void print_mem_encrypt_feature_info(void)
> -{
> -	pr_info("Memory Encryption Features active:");
> -
> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> -		pr_cont(" Intel TDX\n");
> -		return;
> -	}
> -
> -	pr_cont(" AMD");
> -
> -	/* Secure Memory Encryption */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		/*
> -		 * SME is mutually exclusive with any of the SEV
> -		 * features below.
> -		 */
> -		pr_cont(" SME\n");
> -		return;
> -	}
> -
> -	/* Secure Encrypted Virtualization */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		pr_cont(" SEV");
> -
> -	/* Encrypted Register State */
> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		pr_cont(" SEV-ES");
> -
> -	/* Secure Nested Paging */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> -		pr_cont(" SEV-SNP");
> -
> -	pr_cont("\n");
> -}
> -
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void)
>  {
> @@ -85,7 +49,7 @@ void __init mem_encrypt_init(void)
>  	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>  	swiotlb_update_mem_attributes();
>  
> -	print_mem_encrypt_feature_info();
> +	pr_info("Memory Encryption is active\n");
>  }
>  
>  void __init mem_encrypt_setup_arch(void)


