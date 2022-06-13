Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A36549A79
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiFMRyP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiFMRyA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 13:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2583574DDC
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655127586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24HZ2+kUUQuVcuHCEQZMrbqA0ptJQ9pqY0sl1MAQd1o=;
        b=ce9aDFFreSQL5d1CsOzmzq6ar9T9PU86dqB9HE8FURiuEO4rV8HQNupqAKRwEImwdwJLM/
        APfLiXgj6u5sa9NPxCJpVgcMNVouccTJB3hkyFSPIJQU9LqM+lF3RO8vAMMeN7GFG6CrB9
        vZYGkNHCe4hvb+vuKXI3Dt7l4nTA+Dg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576--xeCBIDVOj6JGxg_voZoqw-1; Mon, 13 Jun 2022 09:39:43 -0400
X-MC-Unique: -xeCBIDVOj6JGxg_voZoqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D60986F132;
        Mon, 13 Jun 2022 13:39:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9FC492CA2;
        Mon, 13 Jun 2022 13:39:25 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/39] KVM: x86: Rename 'enable_direct_tlbflush' to 'enable_l2_tlb_flush'
Date:   Mon, 13 Jun 2022 15:38:44 +0200
Message-Id: <20220613133922.2875594-2-vkuznets@redhat.com>
In-Reply-To: <20220613133922.2875594-1-vkuznets@redhat.com>
References: <20220613133922.2875594-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To make terminology between Hyper-V-on-KVM and KVM-on-Hyper-V consistent,
rename 'enable_direct_tlbflush' to 'enable_l2_tlb_flush'. The change
eliminates the use of confusing 'direct' and adds the missing underscore.

No functional change.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 2 +-
 arch/x86/include/asm/kvm_host.h    | 2 +-
 arch/x86/kvm/svm/svm_onhyperv.c    | 2 +-
 arch/x86/kvm/svm/svm_onhyperv.h    | 6 +++---
 arch/x86/kvm/vmx/vmx.c             | 6 +++---
 arch/x86/kvm/x86.c                 | 6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 6f2f1affbb78..3259259b12ed 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -123,7 +123,7 @@ KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
 KVM_X86_OP(get_msr_feature)
 KVM_X86_OP(can_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
-KVM_X86_OP_OPTIONAL(enable_direct_tlbflush)
+KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
 KVM_X86_OP_OPTIONAL(migrate_timers)
 KVM_X86_OP(msr_filter_changed)
 KVM_X86_OP(complete_emulated_msr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7e98b2876380..3d394ba44c4b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1599,7 +1599,7 @@ struct kvm_x86_ops {
 					void *insn, int insn_len);
 
 	bool (*apic_init_signal_blocked)(struct kvm_vcpu *vcpu);
-	int (*enable_direct_tlbflush)(struct kvm_vcpu *vcpu);
+	int (*enable_l2_tlb_flush)(struct kvm_vcpu *vcpu);
 
 	void (*migrate_timers)(struct kvm_vcpu *vcpu);
 	void (*msr_filter_changed)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm_onhyperv.c b/arch/x86/kvm/svm/svm_onhyperv.c
index 8cdc62c74a96..69a7014d1cef 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.c
+++ b/arch/x86/kvm/svm/svm_onhyperv.c
@@ -14,7 +14,7 @@
 #include "kvm_onhyperv.h"
 #include "svm_onhyperv.h"
 
-int svm_hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
+int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct hv_enlightenments *hve;
 	struct hv_partition_assist_pg **p_hv_pa_pg =
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index e2fc59380465..d6ec4aeebedb 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -13,7 +13,7 @@
 
 static struct kvm_x86_ops svm_x86_ops;
 
-int svm_hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu);
+int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu);
 
 static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
 {
@@ -51,8 +51,8 @@ static inline void svm_hv_hardware_setup(void)
 
 			vp_ap->nested_control.features.directhypercall = 1;
 		}
-		svm_x86_ops.enable_direct_tlbflush =
-				svm_hv_enable_direct_tlbflush;
+		svm_x86_ops.enable_l2_tlb_flush =
+				svm_hv_enable_l2_tlb_flush;
 	}
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5e14e4c40007..7aa9611649bb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -469,7 +469,7 @@ static unsigned long host_idt_base;
 static bool __read_mostly enlightened_vmcs = true;
 module_param(enlightened_vmcs, bool, 0444);
 
-static int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
+static int hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct hv_enlightened_vmcs *evmcs;
 	struct hv_partition_assist_pg **p_hv_pa_pg =
@@ -8401,8 +8401,8 @@ static int __init vmx_init(void)
 		}
 
 		if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH)
-			vmx_x86_ops.enable_direct_tlbflush
-				= hv_enable_direct_tlbflush;
+			vmx_x86_ops.enable_l2_tlb_flush
+				= hv_enable_l2_tlb_flush;
 
 	} else {
 		enlightened_vmcs = false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2318a99139fa..0a3e2c3fde43 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4373,7 +4373,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
-		r = kvm_x86_ops.enable_direct_tlbflush != NULL;
+		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
 		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
@@ -5316,10 +5316,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		}
 		return r;
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
-		if (!kvm_x86_ops.enable_direct_tlbflush)
+		if (!kvm_x86_ops.enable_l2_tlb_flush)
 			return -ENOTTY;
 
-		return static_call(kvm_x86_enable_direct_tlbflush)(vcpu);
+		return static_call(kvm_x86_enable_l2_tlb_flush)(vcpu);
 
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 		return kvm_hv_set_enforce_cpuid(vcpu, cap->args[0]);
-- 
2.35.3

