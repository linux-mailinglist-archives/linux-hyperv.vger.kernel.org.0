Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC4588D95
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Aug 2022 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiHCNqb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbiHCNqQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 09:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C9D1F2F3
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Aug 2022 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659534364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGn7Ztrcap1pfSngtDmtejgqnZJ5KF/X45z5sEDPEdQ=;
        b=YEeE9vCJos21xlwAqcysu5VfDCOB+8RRKSig311qRPwvGbarI/+HsWYH7JdkN/mZVOxiCZ
        2WwSVuKr6MQmBG453YJ7OPLQnqqlYeWx898EblM33Hd67eRuHvCTIBR2aIfGD9JFUUcB4l
        MyW8Uetf6YgVL2JupSPdMlqiF86pqKM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-nLJNn0tOP6yfbh2PATJ0sQ-1; Wed, 03 Aug 2022 09:46:01 -0400
X-MC-Unique: nLJNn0tOP6yfbh2PATJ0sQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 602423C0F372;
        Wed,  3 Aug 2022 13:46:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45FB7492C3B;
        Wed,  3 Aug 2022 13:45:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 17/40] KVM: x86: hyper-v: L2 TLB flush
Date:   Wed,  3 Aug 2022 15:45:57 +0200
Message-Id: <20220803134557.399286-1-vkuznets@redhat.com>
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Handle L2 TLB flush requests by going through all vCPUs and checking
whether there are vCPUs running the same VM_ID with a VP_ID specified
in the requests. Perform synthetic exit to L2 upon finish.

Note, while checking VM_ID/VP_ID of running vCPUs seem to be a bit
racy, we count on the fact that KVM flushes the whole L2 VPID upon
transition. Also, KVM_REQ_HV_TLB_FLUSH request needs to be done upon
transition between L1 and L2 to make sure all pending requests are
always processed.

For the reference, Hyper-V TLFS refers to the feature as "Direct
Virtual Flush".

Note, nVMX/nSVM code does not handle VMCALL/VMMCALL from L2 yet.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 82 ++++++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/hyperv.h |  3 --
 arch/x86/kvm/trace.h  | 21 ++++++-----
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 401649a9d288..be25a8ddab9d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -34,6 +34,7 @@
 #include <linux/eventfd.h>
 
 #include <asm/apicdef.h>
+#include <asm/mshyperv.h>
 #include <trace/events/kvm.h>
 
 #include "trace.h"
@@ -1835,9 +1836,10 @@ static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc
 				  entries, consumed_xmm_halves, offset);
 }
 
-static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
+static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu,
+				 struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo,
+				 u64 *entries, int count)
 {
-	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 flush_all_entry = KVM_HV_TLB_FLUSHALL_ENTRY;
 	unsigned long flags;
@@ -1845,9 +1847,6 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
 	if (!hv_vcpu)
 		return;
 
-	/* kvm_hv_flush_tlb() is not ready to handle requests for L2s yet */
-	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo[HV_L1_TLB_FLUSH_FIFO];
-
 	spin_lock_irqsave(&tlb_flush_fifo->write_lock, flags);
 
 	/*
@@ -1916,6 +1915,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
 	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 	/*
 	 * Normally, there can be no more than 'KVM_HV_TLB_FLUSH_FIFO_SIZE'
 	 * entries on the TLB flush fifo. The last entry, however, needs to be
@@ -1959,7 +1959,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		}
 
 		trace_kvm_hv_flush_tlb(flush.processor_mask,
-				       flush.address_space, flush.flags);
+				       flush.address_space, flush.flags,
+				       is_guest_mode(vcpu));
 
 		valid_bank_mask = BIT_ULL(0);
 		sparse_banks[0] = flush.processor_mask;
@@ -1990,7 +1991,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		trace_kvm_hv_flush_tlb_ex(flush_ex.hv_vp_set.valid_bank_mask,
 					  flush_ex.hv_vp_set.format,
 					  flush_ex.address_space,
-					  flush_ex.flags);
+					  flush_ex.flags, is_guest_mode(vcpu));
 
 		valid_bank_mask = flush_ex.hv_vp_set.valid_bank_mask;
 		all_cpus = flush_ex.hv_vp_set.format !=
@@ -2028,19 +2029,57 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
-	if (all_cpus) {
-		kvm_for_each_vcpu(i, v, kvm)
-			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt);
+	if (all_cpus && !is_guest_mode(vcpu)) {
+		kvm_for_each_vcpu(i, v, kvm) {
+			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
+			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
+					     tlb_flush_entries, hc->rep_cnt);
+		}
 
 		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
-	} else {
+	} else if (!is_guest_mode(vcpu)) {
 		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
 		for_each_set_bit(i, vcpu_mask, KVM_MAX_VCPUS) {
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt);
+			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
+			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
+					     tlb_flush_entries, hc->rep_cnt);
+		}
+
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
+	} else {
+		struct kvm_vcpu_hv *hv_v;
+
+		bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
+
+		kvm_for_each_vcpu(i, v, kvm) {
+			hv_v = to_hv_vcpu(v);
+
+			/*
+			 * The following check races with nested vCPUs entering/exiting
+			 * and/or migrating between L1's vCPUs, however the only case when
+			 * KVM *must* flush the TLB is when the target L2 vCPU keeps
+			 * running on the same L1 vCPU from the moment of the request until
+			 * kvm_hv_flush_tlb() returns. TLB is fully flushed in all other
+			 * cases, e.g. when the target L2 vCPU migrates to a different L1
+			 * vCPU or when the corresponding L1 vCPU temporary switches to a
+			 * different L2 vCPU while the request is being processed.
+			 */
+			if (!hv_v || hv_v->nested.vm_id != hv_vcpu->nested.vm_id)
+				continue;
+
+			if (!all_cpus &&
+			    !hv_is_vp_in_sparse_set(hv_v->nested.vp_id, valid_bank_mask,
+						    sparse_banks))
+				continue;
+
+			__set_bit(i, vcpu_mask);
+			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
+			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
+					     tlb_flush_entries, hc->rep_cnt);
 		}
 
 		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
@@ -2228,10 +2267,27 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 
 static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 {
+	int ret;
+
 	trace_kvm_hv_hypercall_done(result);
 	kvm_hv_hypercall_set_result(vcpu, result);
 	++vcpu->stat.hypercalls;
-	return kvm_skip_emulated_instruction(vcpu);
+	ret = kvm_skip_emulated_instruction(vcpu);
+
+	if (unlikely(hv_result_success(result) && is_guest_mode(vcpu)
+		     && kvm_hv_is_tlb_flush_hcall(vcpu))) {
+		struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+		u32 tlb_lock_count;
+
+		if (unlikely(kvm_read_guest(vcpu->kvm, hv_vcpu->nested.pa_page_gpa,
+					    &tlb_lock_count, sizeof(tlb_lock_count))))
+			kvm_inject_gp(vcpu, 0);
+
+		if (tlb_lock_count)
+			kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
+	}
+
+	return ret;
 }
 
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 239946ea483b..892c252b9bc3 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -155,9 +155,6 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
 				HV_L1_TLB_FLUSH_FIFO;
 
-	/* KVM does not handle L2 TLB flush requests yet */
-	WARN_ON_ONCE(i != HV_L1_TLB_FLUSH_FIFO);
-
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 2120d7c060a9..44471d9c8190 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1528,38 +1528,41 @@ TRACE_EVENT(kvm_hv_timer_state,
  * Tracepoint for kvm_hv_flush_tlb.
  */
 TRACE_EVENT(kvm_hv_flush_tlb,
-	TP_PROTO(u64 processor_mask, u64 address_space, u64 flags),
-	TP_ARGS(processor_mask, address_space, flags),
+	TP_PROTO(u64 processor_mask, u64 address_space, u64 flags, bool guest_mode),
+	TP_ARGS(processor_mask, address_space, flags, guest_mode),
 
 	TP_STRUCT__entry(
 		__field(u64, processor_mask)
 		__field(u64, address_space)
 		__field(u64, flags)
+		__field(bool, guest_mode)
 	),
 
 	TP_fast_assign(
 		__entry->processor_mask = processor_mask;
 		__entry->address_space = address_space;
 		__entry->flags = flags;
+		__entry->guest_mode = guest_mode;
 	),
 
-	TP_printk("processor_mask 0x%llx address_space 0x%llx flags 0x%llx",
+	TP_printk("processor_mask 0x%llx address_space 0x%llx flags 0x%llx %s",
 		  __entry->processor_mask, __entry->address_space,
-		  __entry->flags)
+		  __entry->flags, __entry->guest_mode ? "(L2)" : "")
 );
 
 /*
  * Tracepoint for kvm_hv_flush_tlb_ex.
  */
 TRACE_EVENT(kvm_hv_flush_tlb_ex,
-	TP_PROTO(u64 valid_bank_mask, u64 format, u64 address_space, u64 flags),
-	TP_ARGS(valid_bank_mask, format, address_space, flags),
+	TP_PROTO(u64 valid_bank_mask, u64 format, u64 address_space, u64 flags, bool guest_mode),
+	TP_ARGS(valid_bank_mask, format, address_space, flags, guest_mode),
 
 	TP_STRUCT__entry(
 		__field(u64, valid_bank_mask)
 		__field(u64, format)
 		__field(u64, address_space)
 		__field(u64, flags)
+		__field(bool, guest_mode)
 	),
 
 	TP_fast_assign(
@@ -1567,12 +1570,14 @@ TRACE_EVENT(kvm_hv_flush_tlb_ex,
 		__entry->format = format;
 		__entry->address_space = address_space;
 		__entry->flags = flags;
+		__entry->guest_mode = guest_mode;
 	),
 
 	TP_printk("valid_bank_mask 0x%llx format 0x%llx "
-		  "address_space 0x%llx flags 0x%llx",
+		  "address_space 0x%llx flags 0x%llx %s",
 		  __entry->valid_bank_mask, __entry->format,
-		  __entry->address_space, __entry->flags)
+		  __entry->address_space, __entry->flags,
+		  __entry->guest_mode ? "(L2)" : "")
 );
 
 /*
-- 
2.35.3

