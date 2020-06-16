Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0756C1FAE9A
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgFPKwD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:52:03 -0400
Received: from verein.lst.de ([213.95.11.211]:37565 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgFPKwD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:52:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4875968AEF; Tue, 16 Jun 2020 12:52:00 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:52:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dexuan Cui <decui@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616105200.GA32175@lst.de>
References: <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <20200616072318.GA17600@lst.de> <20200616101807.GO2531@hirez.programming.kicks-ass.net> <20200616102350.GA29684@lst.de> <20200616102412.GB29684@lst.de> <20200616103137.GQ2531@hirez.programming.kicks-ass.net> <20200616103313.GA30833@lst.de> <20200616104032.GR2531@hirez.programming.kicks-ass.net> <20200616104230.GA31314@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616104230.GA31314@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:42:30PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 16, 2020 at 12:40:32PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 16, 2020 at 12:33:13PM +0200, Christoph Hellwig wrote:
> > > sorry, s/ftrace/kprobes/.  See my updated branch here:
> > > 
> > > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/module_alloc-cleanup
> > 
> > Ah the insn slot page, yes. Didn't you just loose VM_FLUSH_RESET_PERMS
> > there?
> 
> Yes, we did.  vmalloc_exec had it, but given that module_alloc didn't
> allocate executable on x86 it didn't.  I guess we should make sure it
> is set by the low-level vmalloc code if exec permissions are set to
> sort this mess out.

I think something like this should solve the issue:

--
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index e988bac0a4a1c3..716e4de44a8e78 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -13,4 +13,6 @@ struct mod_arch_specific {
 #endif
 };
 
+void *module_alloc_prot(unsigned long size, pgprot_t prot);
+
 #endif /* _ASM_X86_MODULE_H */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 34b153cbd4acb4..4db6e655120960 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -65,8 +65,10 @@ static unsigned long int get_module_load_offset(void)
 }
 #endif
 
-void *module_alloc(unsigned long size)
+void *module_alloc_prot(unsigned long size, pgprot_t prot)
 {
+	unsigned int flags = (pgprot_val(prot) & _PAGE_NX) ?
+			0 : VM_FLUSH_RESET_PERMS;
 	void *p;
 
 	if (PAGE_ALIGN(size) > MODULES_LEN)
@@ -75,7 +77,7 @@ void *module_alloc(unsigned long size)
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
 				    MODULES_VADDR + get_module_load_offset(),
 				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    prot, flags, NUMA_NO_NODE,
 				    __builtin_return_address(0));
 	if (p && (kasan_module_alloc(p, size) < 0)) {
 		vfree(p);
@@ -85,6 +87,11 @@ void *module_alloc(unsigned long size)
 	return p;
 }
 
+void *module_alloc(unsigned long size)
+{
+	return module_alloc_prot(size, PAGE_KERNEL);
+}
+
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
