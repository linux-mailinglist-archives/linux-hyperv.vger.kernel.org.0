Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6002C588DD3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Aug 2022 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiHCNte (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbiHCNsv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 09:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD4C047BAA
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Aug 2022 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659534434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5jt8zPvGePZwp/yIjyQAv2mZHeaTgHJpBXg1VlVzaA=;
        b=XkhYoXHDZhHt6+Wm6LrbiFxCA8A24ruQUX5Fa4kFD0igrqYgAoOUbCwMkiUIWJYup+JGNr
        7eQmQpGBSIAkdiXqaEUH90qF7AaQtOU8XClsjehr0DYqvNerN0R/SQcdiIknllBgjqGTPq
        q75Oelhxfkpg3wO6XtziS1fVw04eKhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-JRkBvOPjPz-B5ujUwMJ9JA-1; Wed, 03 Aug 2022 09:47:09 -0400
X-MC-Unique: JRkBvOPjPz-B5ujUwMJ9JA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53FEF83DE86;
        Wed,  3 Aug 2022 13:47:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1B61492C3B;
        Wed,  3 Aug 2022 13:47:05 +0000 (UTC)
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
Subject: [PATCH v9 36/40] KVM: selftests: Create a vendor independent helper to allocate Hyper-V specific test pages
Date:   Wed,  3 Aug 2022 15:47:04 +0200
Message-Id: <20220803134704.399551-1-vkuznets@redhat.com>
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There's no need to pollute VMX and SVM code with Hyper-V specific
stuff and allocate Hyper-V specific test pages for all test as only
few really need them. Create a dedicated struct and an allocation
helper.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/evmcs.h      |  4 ++--
 .../selftests/kvm/include/x86_64/hyperv.h     | 15 +++++++++++++
 .../selftests/kvm/include/x86_64/vmx.h        |  8 -------
 .../testing/selftests/kvm/lib/x86_64/hyperv.c | 20 +++++++++++++++++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  | 12 ----------
 .../testing/selftests/kvm/x86_64/evmcs_test.c | 22 +++++++++----------
 6 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
index 77b2bb8de96e..c399058b36db 100644
--- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
@@ -245,9 +245,9 @@ static inline int evmcs_vmptrld(uint64_t vmcs_pa, void *vmcs)
 	return 0;
 }
 
-static inline bool load_evmcs(uint64_t enlightened_vmcs_gpa, void *enlightened_vmcs)
+static inline bool load_evmcs(struct hyperv_test_pages *hv)
 {
-	if (evmcs_vmptrld(enlightened_vmcs_gpa, enlightened_vmcs))
+	if (evmcs_vmptrld(hv->enlightened_vmcs_gpa, hv->enlightened_vmcs))
 		return false;
 
 	current_evmcs->revision_id = EVMCS_VERSION;
diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 42213f5de17f..e00ce9e122f4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -265,4 +265,19 @@ extern struct hv_vp_assist_page *current_vp_assist;
 
 int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist);
 
+struct hyperv_test_pages {
+	/* VP assist page */
+	void *vp_assist_hva;
+	uint64_t vp_assist_gpa;
+	void *vp_assist;
+
+	/* Enlightened VMCS */
+	void *enlightened_vmcs_hva;
+	uint64_t enlightened_vmcs_gpa;
+	void *enlightened_vmcs;
+};
+
+struct hyperv_test_pages *
+vcpu_alloc_hyperv_test_pages(struct kvm_vm *vm, vm_vaddr_t *p_hv_pages_gva);
+
 #endif /* !SELFTEST_KVM_HYPERV_H */
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 99fa1410964c..7f30324452a9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -562,14 +562,6 @@ struct vmx_pages {
 	uint64_t vmwrite_gpa;
 	void *vmwrite;
 
-	void *vp_assist_hva;
-	uint64_t vp_assist_gpa;
-	void *vp_assist;
-
-	void *enlightened_vmcs_hva;
-	uint64_t enlightened_vmcs_gpa;
-	void *enlightened_vmcs;
-
 	void *eptp_hva;
 	uint64_t eptp_gpa;
 	void *eptp;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/hyperv.c b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
index 32dc0afd9e5b..e44bb5cc8566 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
@@ -8,6 +8,26 @@
 #include "processor.h"
 #include "hyperv.h"
 
+struct hyperv_test_pages *
+vcpu_alloc_hyperv_test_pages(struct kvm_vm *vm, vm_vaddr_t *p_hv_pages_gva)
+{
+	vm_vaddr_t hv_pages_gva = vm_vaddr_alloc_page(vm);
+	struct hyperv_test_pages *hv = addr_gva2hva(vm, hv_pages_gva);
+
+	/* Setup of a region of guest memory for the VP Assist page. */
+	hv->vp_assist = (void *)vm_vaddr_alloc_page(vm);
+	hv->vp_assist_hva = addr_gva2hva(vm, (uintptr_t)hv->vp_assist);
+	hv->vp_assist_gpa = addr_gva2gpa(vm, (uintptr_t)hv->vp_assist);
+
+	/* Setup of a region of guest memory for the enlightened VMCS. */
+	hv->enlightened_vmcs = (void *)vm_vaddr_alloc_page(vm);
+	hv->enlightened_vmcs_hva = addr_gva2hva(vm, (uintptr_t)hv->enlightened_vmcs);
+	hv->enlightened_vmcs_gpa = addr_gva2gpa(vm, (uintptr_t)hv->enlightened_vmcs);
+
+	*p_hv_pages_gva = hv_pages_gva;
+	return hv;
+}
+
 int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist)
 {
 	uint64_t val = (vp_assist_pa & HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK) |
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index f8acbc7c8d7d..11e7f1f26624 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -107,18 +107,6 @@ vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva)
 	vmx->vmwrite_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmwrite);
 	memset(vmx->vmwrite_hva, 0, getpagesize());
 
-	/* Setup of a region of guest memory for the VP Assist page. */
-	vmx->vp_assist = (void *)vm_vaddr_alloc_page(vm);
-	vmx->vp_assist_hva = addr_gva2hva(vm, (uintptr_t)vmx->vp_assist);
-	vmx->vp_assist_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vp_assist);
-
-	/* Setup of a region of guest memory for the enlightened VMCS. */
-	vmx->enlightened_vmcs = (void *)vm_vaddr_alloc_page(vm);
-	vmx->enlightened_vmcs_hva =
-		addr_gva2hva(vm, (uintptr_t)vmx->enlightened_vmcs);
-	vmx->enlightened_vmcs_gpa =
-		addr_gva2gpa(vm, (uintptr_t)vmx->enlightened_vmcs);
-
 	*p_vmx_gva = vmx_gva;
 	return vmx;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 5a4c8b1873aa..74f076ba574b 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -68,7 +68,7 @@ void l2_guest_code(void)
 	vmcall();
 }
 
-void guest_code(struct vmx_pages *vmx_pages)
+void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
 {
 #define L2_GUEST_STACK_SIZE 64
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
@@ -78,23 +78,22 @@ void guest_code(struct vmx_pages *vmx_pages)
 	GUEST_SYNC(1);
 	GUEST_SYNC(2);
 
-	enable_vp_assist(vmx_pages->vp_assist_gpa, vmx_pages->vp_assist);
+	enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
 	evmcs_enable();
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
-	GUEST_ASSERT(load_evmcs(vmx_pages->enlightened_vmcs_gpa,
-				vmx_pages->enlightened_vmcs));
-	GUEST_ASSERT(vmptrstz() == vmx_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(load_evmcs(hv_pages));
+	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
 	GUEST_SYNC(4);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code,
 		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
 	GUEST_SYNC(5);
-	GUEST_ASSERT(vmptrstz() == vmx_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 	current_evmcs->revision_id = -1u;
 	GUEST_ASSERT(vmlaunch());
 	current_evmcs->revision_id = EVMCS_VERSION;
@@ -104,7 +103,7 @@ void guest_code(struct vmx_pages *vmx_pages)
 		PIN_BASED_NMI_EXITING);
 
 	GUEST_ASSERT(!vmlaunch());
-	GUEST_ASSERT(vmptrstz() == vmx_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
 	/*
 	 * NMI forces L2->L1 exit, resuming L2 and hope that EVMCS is
@@ -152,7 +151,7 @@ void guest_code(struct vmx_pages *vmx_pages)
 	GUEST_SYNC(11);
 
 	/* Try enlightened vmptrld with an incorrect GPA */
-	evmcs_vmptrld(0xdeadbeef, vmx_pages->enlightened_vmcs);
+	evmcs_vmptrld(0xdeadbeef, hv_pages->enlightened_vmcs);
 	GUEST_ASSERT(vmlaunch());
 	GUEST_ASSERT(ud_count == 1);
 	GUEST_DONE();
@@ -199,7 +198,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 
 int main(int argc, char *argv[])
 {
-	vm_vaddr_t vmx_pages_gva = 0;
+	vm_vaddr_t vmx_pages_gva = 0, hv_pages_gva = 0;
 
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -217,7 +216,8 @@ int main(int argc, char *argv[])
 	vcpu_enable_evmcs(vcpu);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+	vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
+	vcpu_args_set(vcpu, 2, vmx_pages_gva, hv_pages_gva);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
-- 
2.35.3

