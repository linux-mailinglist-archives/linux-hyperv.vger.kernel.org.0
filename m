Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53A501292
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Apr 2022 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbiDNNef (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Apr 2022 09:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244890AbiDNN2O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 935ADA7764
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Apr 2022 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649942474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zm7vWWpJoFp3QcOqQVtM2lUKGQCpQSZQDFy6GatKo98=;
        b=D5v29DmVSQTHM3eELiZ3gOWN73eslG1PKkaVUNPmyNXlKDOtYHO9Z0oZyooMNqos9c+Gpt
        3btEVE6nsEULTxRpdxACZMgqFV4oWb9GPdzNB6BEHOk9svN3s0gOfkZmrIMBxb9yERM6K3
        Weub8ZIp4lWBlKwXwI5nbg0+gqKUHy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-7za_fzKSNOqilB9AI3PYsA-1; Thu, 14 Apr 2022 09:21:13 -0400
X-MC-Unique: 7za_fzKSNOqilB9AI3PYsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7FF91801229;
        Thu, 14 Apr 2022 13:21:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56CB210725;
        Thu, 14 Apr 2022 13:21:06 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 25/34] KVM: selftests: Make it possible to replace PTEs with __virt_pg_map()
Date:   Thu, 14 Apr 2022 15:20:04 +0200
Message-Id: <20220414132013.1588929-26-vkuznets@redhat.com>
In-Reply-To: <20220414132013.1588929-1-vkuznets@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__virt_pg_map() makes an assumption that leaf PTE is not present. This
is not suitable if the test wants to replace an already present
PTE. Hyper-V PV TLB flush test is going to need that.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c     | 6 +++---
 tools/testing/selftests/kvm/max_guest_memory_test.c    | 2 +-
 tools/testing/selftests/kvm/x86_64/mmu_role_test.c     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 9ad7602a257b..c20b18d05119 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -473,7 +473,7 @@ enum x86_page_size {
 	X86_PAGE_SIZE_1G,
 };
 void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
-		   enum x86_page_size page_size);
+		   enum x86_page_size page_size, bool replace);
 
 /*
  * Basic CPU control in CR0
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 9f000dfb5594..20df3e84d777 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -229,7 +229,7 @@ static struct pageUpperEntry *virt_create_upper_pte(struct kvm_vm *vm,
 }
 
 void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
-		   enum x86_page_size page_size)
+		   enum x86_page_size page_size, bool replace)
 {
 	const uint64_t pg_size = 1ull << ((page_size * 9) + 12);
 	struct pageUpperEntry *pml4e, *pdpe, *pde;
@@ -270,7 +270,7 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 	/* Fill in page table entry. */
 	pte = virt_get_pte(vm, pde->pfn, vaddr, 0);
-	TEST_ASSERT(!pte->present,
+	TEST_ASSERT(replace || !pte->present,
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
 	pte->pfn = paddr >> vm->page_shift;
 	pte->writable = true;
@@ -279,7 +279,7 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 {
-	__virt_pg_map(vm, vaddr, paddr, X86_PAGE_SIZE_4K);
+	__virt_pg_map(vm, vaddr, paddr, X86_PAGE_SIZE_4K, false);
 }
 
 static struct pageTableEntry *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 3875c4b23a04..437f77633b0e 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 #ifdef __x86_64__
 		/* Identity map memory in the guest using 1gb pages. */
 		for (i = 0; i < slot_size; i += size_1gb)
-			__virt_pg_map(vm, gpa + i, gpa + i, X86_PAGE_SIZE_1G);
+			__virt_pg_map(vm, gpa + i, gpa + i, X86_PAGE_SIZE_1G, false);
 #else
 		for (i = 0; i < slot_size; i += vm_get_page_size(vm))
 			virt_pg_map(vm, gpa + i, gpa + i);
diff --git a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
index da2325fcad87..e3fdf320b9f4 100644
--- a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
@@ -35,7 +35,7 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 	run = vcpu_state(vm, VCPU_ID);
 
 	/* Map 1gb page without a backing memlot. */
-	__virt_pg_map(vm, MMIO_GPA, MMIO_GPA, X86_PAGE_SIZE_1G);
+	__virt_pg_map(vm, MMIO_GPA, MMIO_GPA, X86_PAGE_SIZE_1G, false);
 
 	r = _vcpu_run(vm, VCPU_ID);
 
-- 
2.35.1

