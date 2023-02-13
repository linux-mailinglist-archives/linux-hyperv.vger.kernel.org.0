Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF86942F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBMKfA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBMKex (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:53 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E648E13D45;
        Mon, 13 Feb 2023 02:34:44 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 486C320C8B73;
        Mon, 13 Feb 2023 02:34:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 486C320C8B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284483;
        bh=6FyEHphcQFflUo9SuGkOPqnwYofGYMYNDEnJFWuN+p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrMtkOd1CwfJf6LnPWUPPAiIA/JLvDKepzvuSXnElFQf1wYGNOFFmuMspWyESh3Md
         aJLVDcle7HBxTnPfNRoYPGKaVNnL88xdlXEjAK5/ykffTPAhXyzFElVB5aY7r555K/
         viRumx21ZR9f6C0rDLrVFD5enchU+7MAlgkeY4S8=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v2 7/7] x86/fault: Handle RMP faults with 0 address when nested
Date:   Mon, 13 Feb 2023 10:34:02 +0000
Message-Id: <20230213103402.1189285-8-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
References: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When using SNP, accessing an encrypted guest page from the host triggers
an RMP fault. The page fault handling code can currently handle this by
looking up the corresponding rmp entry. If the same operation happens
when using nested virtualization, the L0 hypervisor sees a #NPF but the
CPU does not provide the address of the fault if the CPU was running at
L1 at the time of the fault.

This happens on Hyper-V when using nested SNP guests. Hyper-V has no
choice but to use a placeholder address (0) when injecting the page
fault to L1. We need to handle this, and the only sane thing to do is to
forward a SIGBUS to the task.

One path where this happens is when the SNP guest issues a
KVM_HC_CLOCK_PAIRING hypercall, which leads to KVM calling
kvm_write_guest() on a guest supplied address. This results in the
following backtrace:

  [  191.862660]  exc_page_fault+0x71/0x170
  [  191.862664]  asm_exc_page_fault+0x2c/0x40
  [  191.862666] RIP: 0010:copy_user_enhanced_fast_string+0xa/0x40
  ...
  [  191.862677]  ? __kvm_write_guest_page+0x6e/0xa0 [kvm]
  [  191.862700]  kvm_write_guest_page+0x52/0xc0 [kvm]
  [  191.862788]  kvm_write_guest+0x44/0x80 [kvm]
  [  191.862807]  kvm_emulate_hypercall+0x1ca/0x5a0 [kvm]
  [  191.862830]  ? kvm_emulate_monitor+0x40/0x40 [kvm]
  [  191.862849]  svm_invoke_exit_handler+0x74/0x180 [kvm_amd]
  [  191.862854]  sev_handle_vmgexit+0xf42/0x17f0 [kvm_amd]
  [  191.862858]  ? __this_cpu_preempt_check+0x13/0x20
  [  191.862860]  ? sev_post_map_gfn+0xf0/0xf0 [kvm_amd]
  [  191.862863]  svm_invoke_exit_handler+0x74/0x180 [kvm_amd]
  [  191.862866]  svm_handle_exit+0xb5/0x2b0 [kvm_amd]
  [  191.862869]  kvm_arch_vcpu_ioctl_run+0x12a8/0x1aa0 [kvm]
  [  191.862891]  kvm_vcpu_ioctl+0x24f/0x6d0 [kvm]
  [  191.862910]  ? kvm_vm_ioctl_irq_line+0x27/0x40 [kvm]
  [  191.862929]  ? _copy_to_user+0x25/0x30
  [  191.862932]  ? kvm_vm_ioctl+0x291/0xea0 [kvm]
  [  191.862951]  ? kvm_vm_ioctl+0x291/0xea0 [kvm]
  [  191.862970]  ? __fget_light+0xc5/0x100
  [  191.862972]  __x64_sys_ioctl+0x91/0xc0
  [  191.862975]  do_syscall_64+0x5c/0x80
  [  191.862976]  ? exit_to_user_mode_prepare+0x53/0x240
  [  191.862978]  ? syscall_exit_to_user_mode+0x17/0x40
  [  191.862980]  ? do_syscall_64+0x69/0x80
  [  191.862981]  ? do_syscall_64+0x69/0x80
  [  191.862982]  ? syscall_exit_to_user_mode+0x17/0x40
  [  191.862983]  ? do_syscall_64+0x69/0x80
  [  191.862984]  ? syscall_exit_to_user_mode+0x17/0x40
  [  191.862985]  ? do_syscall_64+0x69/0x80
  [  191.862986]  ? do_syscall_64+0x69/0x80
  [  191.862987]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Without this fix the handler returns without doing anything and the
result is a soft-lockup of the CPU.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/mm/fault.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f2b16dcfbd9a..8706fd34f3a9 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
 #include <asm/sev.h>			/* snp_lookup_rmpentry()	*/
+#include <asm/hypervisor.h>		/* hypervisor_is_type()		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1282,6 +1283,18 @@ static int handle_user_rmp_page_fault(struct pt_regs *regs, unsigned long error_
 	pte_t *pte;
 	u64 pfn;
 
+	/*
+	 * When an rmp fault occurs while not inside the SNP guest, the L0
+	 * hypervisor sees a NPF and does not have access to the address that
+	 * caused the fault to forward to L1 hypervisor. Hyper-V places a 0 in
+	 * the PF as a placeholder. SIGBUS the task since there's nothing
+	 * better that we can do.
+	 */
+	if (!address && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
+		do_sigbus(regs, error_code, address, VM_FAULT_SIGBUS);
+		return 1;
+	}
+
 	pgd = __va(read_cr3_pa());
 	pgd += pgd_index(address);
 
-- 
2.25.1

