Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1120053E20E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jun 2022 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiFFIim (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jun 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiFFIif (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jun 2022 04:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35941326CE
        for <linux-hyperv@vger.kernel.org>; Mon,  6 Jun 2022 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6i4ig/R8rMzs2AbGp9PmmaZ4npm6FEPMuif5WYyDsbY=;
        b=XbZ0LO749ktcDSyAaCoZ3G+fCisNQOyLdpOuWm2kLhZMLlamMQY79mZyfpcA2Zqa7GE/d+
        y8aOAnoGG8mE3S3co2zNhlAR9y6HzfmbfyLOOthvaIA0uhQEd4fpehtCKQRVMr9N55le6L
        BfFLuP9VpZVJIJC1E+Kh/7fJWdrPAdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-QWR_hF7GPK6fOJfI4vehdw-1; Mon, 06 Jun 2022 04:38:28 -0400
X-MC-Unique: QWR_hF7GPK6fOJfI4vehdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD2C80418C;
        Mon,  6 Jun 2022 08:38:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33CAA1121314;
        Mon,  6 Jun 2022 08:38:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 38/38] KVM: selftests: hyperv_svm_test: Introduce L2 TLB flush test
Date:   Mon,  6 Jun 2022 10:36:55 +0200
Message-Id: <20220606083655.2014609-39-vkuznets@redhat.com>
In-Reply-To: <20220606083655.2014609-1-vkuznets@redhat.com>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enable Hyper-V L2 TLB flush and check that Hyper-V TLB flush hypercalls
from L2 don't exit to L1 unless 'TlbLockCount' is set in the Partition
assist page.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/x86_64/hyperv_svm_test.c    | 54 +++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 994b33fd8724..2d938523ae27 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -42,6 +42,9 @@ struct hv_enlightenments {
  */
 #define VMCB_HV_NESTED_ENLIGHTENMENTS (1U << 31)
 
+#define HV_SVM_EXITCODE_ENL 0xF0000000
+#define HV_SVM_ENL_EXITCODE_TRAP_AFTER_FLUSH   (1)
+
 void l2_guest_code(void)
 {
 	GUEST_SYNC(3);
@@ -57,11 +60,25 @@ void l2_guest_code(void)
 
 	GUEST_SYNC(5);
 
+	/* L2 TLB flush tests */
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE |
+			 HV_HYPERCALL_FAST_BIT, 0x0,
+			 HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES |
+			 HV_FLUSH_ALL_PROCESSORS);
+	rdmsr(MSR_FS_BASE);
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE |
+			 HV_HYPERCALL_FAST_BIT, 0x0,
+			 HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES |
+			 HV_FLUSH_ALL_PROCESSORS);
+	/* Make sure we're not issuing Hyper-V TLB flush call again */
+	__asm__ __volatile__ ("mov $0xdeadbeef, %rcx");
+
 	/* Done, exit to L1 and never come back.  */
 	vmmcall();
 }
 
-static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
+static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm,
+						    vm_vaddr_t pgs_gpa)
 {
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
@@ -70,13 +87,23 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
 
 	GUEST_SYNC(1);
 
-	wrmsr(HV_X64_MSR_GUEST_OS_ID, (u64)0x8100 << 48);
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
+	enable_vp_assist(svm->vp_assist_gpa, svm->vp_assist);
 
 	GUEST_ASSERT(svm->vmcb_gpa);
 	/* Prepare for L2 execution. */
 	generic_svm_setup(svm, l2_guest_code,
 			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
+	/* L2 TLB flush setup */
+	hve->partition_assist_page = svm->partition_assist_gpa;
+	hve->hv_enlightenments_control.nested_flush_hypercall = 1;
+	hve->hv_vm_id = 1;
+	hve->hv_vp_id = 1;
+	current_vp_assist->nested_control.features.directhypercall = 1;
+	*(u32 *)(svm->partition_assist) = 0;
+
 	GUEST_SYNC(2);
 	run_guest(vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
@@ -111,6 +138,20 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
 	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_MSR);
 	vmcb->save.rip += 2; /* rdmsr */
 
+
+	/*
+	 * L2 TLB flush test. First VMCALL should be handled directly by L0,
+	 * no VMCALL exit expected.
+	 */
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_MSR);
+	vmcb->save.rip += 2; /* rdmsr */
+	/* Enable synthetic vmexit */
+	*(u32 *)(svm->partition_assist) = 1;
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(vmcb->control.exit_code == HV_SVM_EXITCODE_ENL);
+	GUEST_ASSERT(vmcb->control.exit_info_1 == HV_SVM_ENL_EXITCODE_TRAP_AFTER_FLUSH);
+
 	run_guest(vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
 	GUEST_SYNC(6);
@@ -121,7 +162,7 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
-
+	vm_vaddr_t hcall_page;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	struct ucall uc;
@@ -136,7 +177,12 @@ int main(int argc, char *argv[])
 	vcpu_set_hv_cpuid(vm, VCPU_ID);
 	run = vcpu_state(vm, VCPU_ID);
 	vcpu_alloc_svm(vm, &nested_gva);
-	vcpu_args_set(vm, VCPU_ID, 1, nested_gva);
+
+	hcall_page = vm_vaddr_alloc_pages(vm, 1);
+	memset(addr_gva2hva(vm, hcall_page), 0x0,  getpagesize());
+
+	vcpu_args_set(vm, VCPU_ID, 2, nested_gva, addr_gva2gpa(vm, hcall_page));
+	vcpu_set_msr(vm, VCPU_ID, HV_X64_MSR_VP_INDEX, VCPU_ID);
 
 	for (stage = 1;; stage++) {
 		_vcpu_run(vm, VCPU_ID);
-- 
2.35.3

