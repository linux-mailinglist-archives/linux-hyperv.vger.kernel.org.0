Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353166814F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjA3PZ5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjA3PZ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 10:25:56 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 990DFCDC6;
        Mon, 30 Jan 2023 07:25:55 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 63D0F20E9F8D; Mon, 30 Jan 2023 07:25:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63D0F20E9F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675092355;
        bh=bGi+RJN59kO3g6+Cd8jXPvBoBF+THRp7NH5eM0/2kE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hW4PyYBbWTE2zdCNUzGzmKrzB0O4Yv2jrjBJBJJ+SdNBNgTbEazKf+REZ5fSBZ4Y/
         I7ZHUJzmx+IXkr8OPOG7ZtJ2JOnLAZO8FpqYiF/Z/6W1Dsf7WtrC6/gddS84V3zUt1
         0HC3BS1kJGK7NJ8udimTOrx+0ELGcn7i+EwFlGiQ=
Date:   Mon, 30 Jan 2023 07:25:55 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 2/6] x86/sev: Add support for NestedVirtSnpMsr
Message-ID: <20230130152555.GB27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-3-jpiotrowski@linux.microsoft.com>
 <SN6PR2101MB169362990E4BB621A5A27D13D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR2101MB169362990E4BB621A5A27D13D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 28, 2023 at 07:48:27PM +0000, Michael Kelley (LINUX) wrote:
> From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> Sent: Monday, January 23, 2023 8:51 AM
> > 
> > The rmpupdate and psmash instructions, which are used in AMD's SEV-SNP
> > to update the RMP (Reverse Map) table, can't be trapped. For nested
> > scenarios, AMD defined MSR versions of these instructions which can be
> 
> s/can be/must be/  ??
> 

yes indeed

> > emulated by the top-level hypervisor. One instance where these MSRs are
> 
> And by "top-level", I think you are referring the hypervisor running at L1, right?
> Using the L0/L1/L2 terminology would probably help make the description
> more precise.

These instructions are called by the L1 hypervisor and are emulated by the L0
hypervisor which controls the actual rmp table. I'll rephrase the commit
message to make that clearer.

> 
> > used are Hyper-V VMs which expose SNP isolation features to the guest.
> > 
> > The MSRs are defined in "AMD64 Architecture Programmer’s Manual, Volume 2:
> > System Programming", section 15.36.19.
> > 
> > Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h |  1 +
> >  arch/x86/include/asm/msr-index.h   |  2 +
> >  arch/x86/kernel/sev.c              | 62 +++++++++++++++++++++++++-----
> >  3 files changed, 55 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 480b4eaef310..e6e2e824f67b 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -423,6 +423,7 @@
> >  #define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
> >  #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
> >  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
> > +#define X86_FEATURE_NESTED_VIRT_SNP_MSR	(19*32+29) /* Virtualizable RMPUPDATE and PSMASH MSR available */
> > 
> >  /*
> >   * BUG word(s)
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 35100c630617..d6103e607896 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -567,6 +567,8 @@
> >  #define MSR_AMD64_SEV_SNP_ENABLED
> > 	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
> >  #define MSR_AMD64_RMP_BASE		0xc0010132
> >  #define MSR_AMD64_RMP_END		0xc0010133
> > +#define MSR_AMD64_VIRT_RMPUPDATE	0xc001f001
> > +#define MSR_AMD64_VIRT_PSMASH		0xc001f002
> > 
> >  #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
> > 
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index 7fa39dc17edd..95404c7e5150 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -2566,6 +2566,24 @@ int snp_lookup_rmpentry(u64 pfn, int *level)
> >  }
> >  EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
> > 
> > +static bool virt_snp_msr(void)
> > +{
> > +	return boot_cpu_has(X86_FEATURE_NESTED_VIRT_SNP_MSR);
> > +}
> > +
> > +static u64 virt_psmash(u64 paddr)
> > +{
> > +	int ret;
> > +
> > +	asm volatile(
> > +		"wrmsr\n\t"
> > +		: "=a"(ret)
> > +		: "a"(paddr), "c"(MSR_AMD64_VIRT_PSMASH)
> > +		: "memory", "cc"
> > +	);
> > +	return ret;
> > +}
> 
> From checking the AMD spec, I can see that the above use
> of wrmsr is non-conventional.  Could you capture the basics
> of the usage paradigm in a comment?  I.e., the expected
> inputs and outputs, and the core assumption that the
> MSR isn't implemented in hardware, but must trap
> to the hypervisor.

ok, how does this sound:

/*
 * This version of rmpupdate is not implemented in hardware but always
 * traps to L0 hypervisor. It doesn't follow usual wrmsr conventions.
 * Inputs:
 *   rax: 4KB aligned GPA
 *   rdx: bytes 7:0 of new rmp entry
 *   r8:  bytes 15:8 of new rmp entry
 * Outputs:
 *   rax: rmpupdate return code
 */

and similar for psmash.

> 
> > +
> >  /*
> >   * psmash is used to smash a 2MB aligned page into 4K
> >   * pages while preserving the Validated bit in the RMP.
> > @@ -2581,11 +2599,15 @@ int psmash(u64 pfn)
> >  	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> >  		return -ENXIO;
> > 
> > -	/* Binutils version 2.36 supports the PSMASH mnemonic. */
> > -	asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
> > -		      : "=a"(ret)
> > -		      : "a"(paddr)
> > -		      : "memory", "cc");
> > +	if (virt_snp_msr()) {
> > +		ret = virt_psmash(paddr);
> > +	} else {
> > +		/* Binutils version 2.36 supports the PSMASH mnemonic. */
> > +		asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
> > +			      : "=a"(ret)
> > +			      : "a"(paddr)
> > +			      : "memory", "cc");
> > +	}
> > 
> >  	return ret;
> >  }
> > @@ -2601,6 +2623,21 @@ static int invalidate_direct_map(unsigned long pfn, int npages)
> >  	return set_memory_np((unsigned long)pfn_to_kaddr(pfn), npages);
> >  }
> > 
> > +static u64 virt_rmpupdate(unsigned long paddr, struct rmp_state *val)
> > +{
> > +	int ret;
> > +	register u64 hi asm("r8") = ((u64 *)val)[1];
> > +	register u64 lo asm("rdx") = ((u64 *)val)[0];
> > +
> > +	asm volatile(
> > +		"wrmsr\n\t"
> > +		: "=a"(ret)
> > +		: "a"(paddr), "c"(MSR_AMD64_VIRT_RMPUPDATE), "r"(lo), "r"(hi)
> > +		: "memory", "cc"
> > +	);
> > +	return ret;
> > +}
> 
> Same here about a comment capturing the expected inputs
> and outputs.

ok

> 
> > +
> >  static int rmpupdate(u64 pfn, struct rmp_state *val)
> >  {
> >  	unsigned long paddr = pfn << PAGE_SHIFT;
> > @@ -2626,11 +2663,16 @@ static int rmpupdate(u64 pfn, struct rmp_state *val)
> >  	}
> > 
> >  retry:
> > -	/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
> > -	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
> > -		     : "=a"(ret)
> > -		     : "a"(paddr), "c"((unsigned long)val)
> > -		     : "memory", "cc");
> > +
> > +	if (virt_snp_msr()) {
> > +		ret = virt_rmpupdate(paddr, val);
> > +	} else {
> > +		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
> > +		asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFE"
> > +			     : "=a"(ret)
> > +			     : "a"(paddr), "c"((unsigned long)val)
> > +			     : "memory", "cc");
> > +	}
> > 
> >  	if (ret) {
> >  		if (!retries) {
> > --
> > 2.25.1
> 
