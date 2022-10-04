Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22FA5F4367
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Oct 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJDMpL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Oct 2022 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJDMop (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Oct 2022 08:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2D5D130
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Oct 2022 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664887313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/mBUp5om8+lhF+564fXSbS6jTR1Ky4c+482nYxEp3g=;
        b=REx9zaCLcHoAinn1cHREtAeH7alDumzLsjSeySH6tY1UK3sFlW2cLKaKDQA4piyq497WIA
        N9b9RRI60sO3hf5slopfpbY++lm7BD/rwbejTuWQwEYFNhc/cAQImWYNcAj8oYHWo6Rzvz
        Y8a3ScTszr9oIYrPoInU7es7kqHwI2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-eeRVb9qOO_iAWlMIdd-BDA-1; Tue, 04 Oct 2022 08:41:48 -0400
X-MC-Unique: eeRVb9qOO_iAWlMIdd-BDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F76811E67;
        Tue,  4 Oct 2022 12:41:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A28BD7AE5;
        Tue,  4 Oct 2022 12:41:45 +0000 (UTC)
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
Subject: [PATCH v11 43/46] KVM: selftests: Allocate Hyper-V partition assist page
Date:   Tue,  4 Oct 2022 14:39:53 +0200
Message-Id: <20221004123956.188909-44-vkuznets@redhat.com>
In-Reply-To: <20221004123956.188909-1-vkuznets@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In preparation to testing Hyper-V L2 TLB flush hypercalls, allocate
so-called Partition assist page.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/hyperv.h | 5 +++++
 tools/testing/selftests/kvm/lib/x86_64/hyperv.c     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 186f3aab888f..ffe28a78c8a3 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -273,6 +273,11 @@ struct hyperv_test_pages {
 	uint64_t vp_assist_gpa;
 	void *vp_assist;
 
+	/* Partition assist page */
+	void *partition_assist_hva;
+	uint64_t partition_assist_gpa;
+	void *partition_assist;
+
 	/* Enlightened VMCS */
 	void *enlightened_vmcs_hva;
 	uint64_t enlightened_vmcs_gpa;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/hyperv.c b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
index a2fc083c65ef..efb7e7a1354d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/hyperv.c
@@ -19,6 +19,11 @@ struct hyperv_test_pages *vcpu_alloc_hyperv_test_pages(struct kvm_vm *vm,
 	hv->vp_assist_hva = addr_gva2hva(vm, (uintptr_t)hv->vp_assist);
 	hv->vp_assist_gpa = addr_gva2gpa(vm, (uintptr_t)hv->vp_assist);
 
+	/* Setup of a region of guest memory for the partition assist page. */
+	hv->partition_assist = (void *)vm_vaddr_alloc_page(vm);
+	hv->partition_assist_hva = addr_gva2hva(vm, (uintptr_t)hv->partition_assist);
+	hv->partition_assist_gpa = addr_gva2gpa(vm, (uintptr_t)hv->partition_assist);
+
 	/* Setup of a region of guest memory for the enlightened VMCS. */
 	hv->enlightened_vmcs = (void *)vm_vaddr_alloc_page(vm);
 	hv->enlightened_vmcs_hva = addr_gva2hva(vm, (uintptr_t)hv->enlightened_vmcs);
-- 
2.37.3

