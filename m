Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAE53E26D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jun 2022 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiFFIij (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jun 2022 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiFFIid (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jun 2022 04:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A171531529
        for <linux-hyperv@vger.kernel.org>; Mon,  6 Jun 2022 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ankO/A6GexfuOzgw81I2p1BsvNyp5HWjsdt3gE+7fDg=;
        b=J9EFNLRJ4FpOrk2YvDst5QEHOcuWsByQ3OdXFrmj0zSUJISg9Xnzo8Ki0gDwbvqz+hfprk
        j6G9QZJ5/l79AfM1c07IomEEUgKtkg5fx+mtqr88RjlvIxntTuulkhcGIXeWVV3wOc0llg
        Kg4npQAkw/Oqf/FHf5WofTWCshCQkjs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-Cl0miY05Py6ykdoELt8p_Q-1; Mon, 06 Jun 2022 04:38:26 -0400
X-MC-Unique: Cl0miY05Py6ykdoELt8p_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E71C3299E743;
        Mon,  6 Jun 2022 08:38:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0C681121314;
        Mon,  6 Jun 2022 08:38:23 +0000 (UTC)
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
Subject: [PATCH v6 37/38] KVM: selftests: Move Hyper-V VP assist page enablement out of evmcs.h
Date:   Mon,  6 Jun 2022 10:36:54 +0200
Message-Id: <20220606083655.2014609-38-vkuznets@redhat.com>
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

Hyper-V VP assist page is not eVMCS specific, it is also used for
enlightened nSVM. Move the code to vendor neutral place.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../selftests/kvm/include/x86_64/evmcs.h      | 40 +------------------
 .../selftests/kvm/include/x86_64/hyperv.h     | 31 ++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/hyperv.c | 21 ++++++++++
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  1 +
 5 files changed, 56 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/hyperv.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1e61ccc0da4d..eb7b51af5683 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -38,7 +38,7 @@ ifeq ($(ARCH),riscv)
 endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
-LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
+LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/hyperv.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 LIBKVM_riscv = lib/riscv/processor.c lib/riscv/ucall.c
diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
index 36c0a67d8602..026586b53013 100644
--- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
@@ -10,6 +10,7 @@
 #define SELFTEST_KVM_EVMCS_H
 
 #include <stdint.h>
+#include "hyperv.h"
 #include "vmx.h"
 
 #define u16 uint16_t
@@ -20,27 +21,6 @@
 
 extern bool enable_evmcs;
 
-struct hv_nested_enlightenments_control {
-	struct {
-		__u32 directhypercall:1;
-		__u32 reserved:31;
-	} features;
-	struct {
-		__u32 reserved;
-	} hypercallControls;
-} __packed;
-
-/* Define virtual processor assist page structure. */
-struct hv_vp_assist_page {
-	__u32 apic_assist;
-	__u32 reserved1;
-	__u64 vtl_control[3];
-	struct hv_nested_enlightenments_control nested_control;
-	__u8 enlighten_vmentry;
-	__u8 reserved2[7];
-	__u64 current_nested_vmcs;
-} __packed;
-
 struct hv_enlightened_vmcs {
 	u32 revision_id;
 	u32 abort;
@@ -246,31 +226,15 @@ struct hv_enlightened_vmcs {
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ENLIGHTENMENTSCONTROL    BIT(15)
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL                      0xFFFF
 
-#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
-#define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
-#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
-#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
-		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
-
 #define HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH 0x10000031
 
 extern struct hv_enlightened_vmcs *current_evmcs;
-extern struct hv_vp_assist_page *current_vp_assist;
 
 int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id);
 
-static inline int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist)
+static inline void evmcs_enable(void)
 {
-	u64 val = (vp_assist_pa & HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK) |
-		HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
-
-	wrmsr(HV_X64_MSR_VP_ASSIST_PAGE, val);
-
-	current_vp_assist = vp_assist;
-
 	enable_evmcs = true;
-
-	return 0;
 }
 
 static inline int evmcs_vmptrld(uint64_t vmcs_pa, void *vmcs)
diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index c302027fa6d5..a2561f31dabb 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -216,4 +216,35 @@ static inline void hyperv_write_xmm_input(void *data, int n_sse_regs)
 /* Proper HV_X64_MSR_GUEST_OS_ID value */
 #define HYPERV_LINUX_OS_ID ((u64)0x8100 << 48)
 
+#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
+#define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
+#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
+#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
+		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
+
+struct hv_nested_enlightenments_control {
+	struct {
+		__u32 directhypercall:1;
+		__u32 reserved:31;
+	} features;
+	struct {
+		__u32 reserved;
+	} hypercallControls;
+} __packed;
+
+/* Define virtual processor assist page structure. */
+struct hv_vp_assist_page {
+	__u32 apic_assist;
+	__u32 reserved1;
+	__u64 vtl_control[3];
+	struct hv_nested_enlightenments_control nested_control;
+	__u8 enlighten_vmentry;
+	__u8 reserved2[7];
+	__u64 current_nested_vmcs;
+} __packed;
+
+extern struct hv_vp_assist_page *current_vp_assist;
+
+int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist);
+
 #endif /* !SELFTEST_KVM_HYPERV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/hyperv.c b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
new file mode 100644
index 000000000000..32dc0afd9e5b
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hyper-V specific functions.
+ *
+ * Copyright (C) 2021, Red Hat Inc.
+ */
+#include <stdint.h>
+#include "processor.h"
+#include "hyperv.h"
+
+int enable_vp_assist(uint64_t vp_assist_pa, void *vp_assist)
+{
+	uint64_t val = (vp_assist_pa & HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK) |
+		HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
+
+	wrmsr(HV_X64_MSR_VP_ASSIST_PAGE, val);
+
+	current_vp_assist = vp_assist;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index e644622e4b51..d23b1218e3c3 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -94,6 +94,7 @@ void guest_code(struct vmx_pages *vmx_pages, vm_vaddr_t pgs_gpa)
 	GUEST_SYNC(2);
 
 	enable_vp_assist(vmx_pages->vp_assist_gpa, vmx_pages->vp_assist);
+	evmcs_enable();
 
 	GUEST_ASSERT(vmx_pages->vmcs_gpa);
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
-- 
2.35.3

