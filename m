Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0849681402
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 16:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjA3PDU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjA3PDT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 10:03:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4460917140;
        Mon, 30 Jan 2023 07:03:18 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 03ECC20E9F8A; Mon, 30 Jan 2023 07:03:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03ECC20E9F8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675090998;
        bh=SzSx6WrPFT5+HVqIk4AWasOuf4rLyIQswZa2Nd3lE1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1bJHeFgodb9BnnMH3n4oIR30nlWPtv02O4UPWlKu/9b5o8Uh+d60hOX8LUip3OzP
         hRzfV+uJV6NtNtMezN5+uNzrgc+qRW37mMFAeyTqMu+i2x3FkfeCCAoSoH7rPOQdSq
         pO04HrfXAKH440hrCWcWoe85gCJs8aLX0t+b7IQI=
Date:   Mon, 30 Jan 2023 07:03:17 -0800
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
Subject: Re: [RFC PATCH v1 1/6] x86/hyperv: Allocate RMP table during boot
Message-ID: <20230130150317.GA27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-2-jpiotrowski@linux.microsoft.com>
 <SN6PR2101MB1693C405F2DA48F078D38CF3D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR2101MB1693C405F2DA48F078D38CF3D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
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

On Sat, Jan 28, 2023 at 07:26:05PM +0000, Michael Kelley (LINUX) wrote:
> From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> Sent: Monday, January 23, 2023 8:51 AM
> > 
> > Hyper-V VMs can be capable of hosting SNP isolated nested VMs on AMD
> > CPUs. One of the pieces of SNP is the RMP (Reverse Map) table which
> > tracks page assignment to firmware, hypervisor or guest. On bare-metal
> > this table is allocated by UEFI, but on Hyper-V it is the respnsibility
> 
> s/respnsibility/responsibility/
> 

ok

> > of the OS to allocate one if necessary. The nested_feature
> > 'HV_X64_NESTED_NO_RMP_TABLE' will be set to communicate that no rmp is
> > available. The actual RMP table is exclusively controlled by the Hyper-V
> > hypervisor and is not virtualized to the VM. The SNP code in the kernel
> > uses the RMP table for its own tracking and so it is necessary for init
> > code to allocate one.
> > 
> > While not strictly necessary, follow the requirements defined by "SEV
> > Secure Nested Paging Firmware ABI Specification" Rev 1.54, section 8.8.2
> > when allocating the RMP:
> > 
> > - RMP_BASE and RMP_END must be set identically across all cores.
> > - RMP_BASE must be 1 MB aligned
> > - RMP_END – RMP_BASE + 1 must be a multiple of 1 MB
> > - RMP is large enough to protect itself
> > 
> > The allocation is done in the init_mem_mapping() hook, which is the
> > earliest hook I found that has both max_pfn and memblock initialized. At
> > this point we are still under the
> > memblock_set_current_limit(ISA_END_ADDRESS) condition, but explicitly
> > passing the end to memblock_phys_alloc_range() allows us to allocate
> > past that value.
> > 
> > Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c          |  5 ++++
> >  arch/x86/include/asm/hyperv-tlfs.h |  3 +++
> >  arch/x86/include/asm/mshyperv.h    |  3 +++
> >  arch/x86/include/asm/sev.h         |  2 ++
> >  arch/x86/kernel/cpu/mshyperv.c     | 41 ++++++++++++++++++++++++++++++
> >  arch/x86/kernel/sev.c              |  1 -
> >  6 files changed, 54 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 29774126e931..e7f5ac075e6d 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -117,6 +117,11 @@ static int hv_cpu_init(unsigned int cpu)
> >  		}
> >  	}
> > 
> > +	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) && hv_needs_snp_rmp()) {
> 
> Could the IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) condition be
> folded into the implementation of hv_needs_snp_rmp() so that only one
> test is needed?
> 

Yes, I'll fold it in. I originally kept this out because I was worried about
dead-code elimination. I wanted to make hv_needs_snp_rmp() a static inline but
I couldn't find the right place to put it:

- ms_hyperv is declared in include/asm-generic/mshyperv.h but I wouldn't
  put something x86 specific there.
- doesn't go in arch/x86/include/asm/hyperv-tlfs.h with the NESTED_NO_RMP_TABLE
  definition.
- arch/x86/include/asm/mshyperv.h would have been good but it would need to be
  at the bottom of the file (after the asm-generic/mshyperv.h include) and
  nothing else is there.

> > +		wrmsrl(MSR_AMD64_RMP_BASE, rmp_res.start);
> > +		wrmsrl(MSR_AMD64_RMP_END, rmp_res.end);
> > +	}
> > +
> >  	return hyperv_init_ghcb();
> >  }
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index e3efaf6e6b62..01cc2c3f9f20 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -152,6 +152,9 @@
> >   */
> >  #define HV_X64_NESTED_ENLIGHTENED_TLB			BIT(22)
> > 
> > +/* Nested SNP on Hyper-V */
> > +#define HV_X64_NESTED_NO_RMP_TABLE			BIT(23)
> > +
> 
> Just for my clarification, is this flag always set in an SNP guest when
> running on a version of Hyper-V that supports nested SNP?  I'm
> presuming "yes".

No, this is not set for SNP guests. I'll expand the cover letter but when I say
"nested SNP" I mean "running an SNP guest as a nested guest", and not "running
guests nested inside an SNP guest". SNP guests do not support any form of
virtualization, and the L1 in this scenario is not SNP itself.

> But there may be older versions of Hyper-V
> that support SNP guests, but not nested SNP guests, in which case
> this flag would be clear.

These two cases are exclusive, so I'm adding a:

!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)

Condition to make that clearer. The NO_RMP_TABLE flag would never be set for a
"Hyper-V SNP guest" and is always set for a "Hyper-V guest that is capable of
running SNP guests".

> 
> >  /* HYPERV_CPUID_ISOLATION_CONFIG.EAX bits. */
> >  #define HV_PARAVISOR_PRESENT				BIT(0)
> > 
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 61f0c206bff0..3533b002cede 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -190,6 +190,9 @@ static inline void hv_ghcb_terminate(unsigned int set, unsigned
> > int reason) {}
> > 
> >  extern bool hv_isolation_type_snp(void);
> > 
> > +extern struct resource rmp_res;
> > +bool hv_needs_snp_rmp(void);
> > +
> >  static inline bool hv_is_synic_reg(unsigned int reg)
> >  {
> >  	if ((reg >= HV_REGISTER_SCONTROL) &&
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index 2916f4150ac7..db5438663229 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -83,6 +83,8 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
> >  /* RMUPDATE detected 4K page and 2MB page overlap. */
> >  #define RMPUPDATE_FAIL_OVERLAP		7
> > 
> > +#define RMPTABLE_CPU_BOOKKEEPING_SZ     0x4000
> > +
> >  /* RMP page size */
> >  #define RMP_PG_SIZE_4K			0
> >  #define RMP_PG_SIZE_2M			1
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 831613959a92..e7f02412f3a1 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/kexec.h>
> >  #include <linux/i8253.h>
> > +#include <linux/memblock.h>
> >  #include <linux/random.h>
> >  #include <linux/swiotlb.h>
> >  #include <asm/processor.h>
> > @@ -31,6 +32,7 @@
> >  #include <asm/timer.h>
> >  #include <asm/reboot.h>
> >  #include <asm/nmi.h>
> > +#include <asm/sev.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/numa.h>
> >  #include <asm/coco.h>
> > @@ -488,6 +490,44 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
> >  	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
> >  }
> > 
> > +struct resource rmp_res = {
> > +	.name  = "RMP",
> > +	.start = 0,
> > +	.end   = 0,
> > +	.flags = IORESOURCE_SYSTEM_RAM,
> > +};
> > +
> > +bool hv_needs_snp_rmp(void)
> > +{
> > +	return boot_cpu_has(X86_FEATURE_SEV_SNP) &&
> > +		(ms_hyperv.nested_features & HV_X64_NESTED_NO_RMP_TABLE);
> > +}
> > +
> > +
> > +static void __init ms_hyperv_init_mem_mapping(void)
> > +{
> > +	phys_addr_t addr;
> > +	u64 calc_rmp_sz;
> > +
> > +	if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> > +		return;
> > +	if (!hv_needs_snp_rmp())
> > +		return;
> 
> Another case where it would be cleaner if all the
> conditions could be folded into hv_needs_snp_rmp().
> 

ok

> > +
> > +	calc_rmp_sz = (max_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
> > +	calc_rmp_sz = round_up(calc_rmp_sz, SZ_1M);
> > +	addr = memblock_phys_alloc_range(calc_rmp_sz, SZ_1M, 0, max_pfn << PAGE_SHIFT);
> > +	if (!addr) {
> > +		pr_warn("Unable to allocate RMP table\n");
> > +		return;
> > +	}
> > +	rmp_res.start = addr;
> > +	rmp_res.end = addr + calc_rmp_sz - 1;
> > +	wrmsrl(MSR_AMD64_RMP_BASE, rmp_res.start);
> > +	wrmsrl(MSR_AMD64_RMP_END, rmp_res.end);
> > +	insert_resource(&iomem_resource, &rmp_res);
> > +}
> > +
> >  const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
> >  	.name			= "Microsoft Hyper-V",
> >  	.detect			= ms_hyperv_platform,
> > @@ -495,4 +535,5 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
> >  	.init.x2apic_available	= ms_hyperv_x2apic_available,
> >  	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
> >  	.init.init_platform	= ms_hyperv_init_platform,
> > +	.init.init_mem_mapping  = ms_hyperv_init_mem_mapping,
> 
> On versions of Hyper-V that support nested SNP guests, it appears that every
> L1 SNP guest will allocate memory for the RMP, even if it never runs an L2 guest.
> The amount of memory allocated is 16 bytes per 4K page, or 0.4% of the total
> memory size of the L1 VM.  In most cases the memory will be unused.  For
> example, that works out to be 256 Mbytes in a 64 Gbyte VM, which to me is
> a fairly big chunk of memory to waste, even though the percentage isn't huge. 
> Should we have a CONFIG option that controls whether the RMP is allocated?
> L1 guests that intend to run their own L2 guests would need to be built with
> this CONFIG option.   Presumably the allocation must be done early to ensure
> the ability to get a big chunk of contiguous physical memory.  Allocating
> the RMP later only if it is needed isn't an option.
> 

I clarified above - this table is not intended to be allocated on L1 SNP guests
and I agree that doing so would be wasteful.

Once we exclude L1 SNP guests, I don't think a CONFIG option is needed because
the VMM can easily control whether to expose the SNP CPU flag to the guest or
not. If it's exposed, the guest is going to need an RMP to do anything with
SNP, if it's not exposed the RMP won't be allocated. It's also already behind
CONFIG_AMD_MEM_ENCRYPT.

The allocation needs to be done early to match the behavior the rmp handling
code expects (big and physically contiguous). In an earlier version I had a big
vmalloc allocation in 'fs_initcall(snp_rmptable_init)' which worked fine but I
thought that would not be suitable for upstreaming.

> >  };
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index 1dd1b36bdfea..7fa39dc17edd 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -87,7 +87,6 @@ struct rmpentry {
> >   * The first 16KB from the RMP_BASE is used by the processor for the
> >   * bookkeeping, the range needs to be added during the RMP entry lookup.
> >   */
> > -#define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
> >  #define RMPENTRY_SHIFT			8
> >  #define rmptable_page_offset(x)	(RMPTABLE_CPU_BOOKKEEPING_SZ + (((unsigned long)x) >> RMPENTRY_SHIFT))
> > 
> > --
> > 2.25.1
> 
