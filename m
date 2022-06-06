Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17C653E3A5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jun 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiFFIi1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jun 2022 04:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiFFIiW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jun 2022 04:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD0973152B
        for <linux-hyperv@vger.kernel.org>; Mon,  6 Jun 2022 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da7nS1EdTAInnQ5mYClBlXrsAp+Wl4jzAQ2Ex+71s1o=;
        b=Q64EZ6AatR6AeW8VBkCGBIeRwu8gnzNL/GhASJLDuYNv00G8n55v8jtYDRwYHGC0apHOqh
        C1NaiybuSDrQHhtAnelYfWHUEns072slEp5VPfeoRrnKSafURpC5deVo4GgwExzY17YYbo
        NbWM3rmaE0LtuPTwC7m2BFB7AaE0N5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-10mz35SqMOK0asE-vW0eLg-1; Mon, 06 Jun 2022 04:38:17 -0400
X-MC-Unique: 10mz35SqMOK0asE-vW0eLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69FE1811E75;
        Mon,  6 Jun 2022 08:38:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD901121314;
        Mon,  6 Jun 2022 08:38:13 +0000 (UTC)
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
Subject: [PATCH v6 33/38] KVM: selftests: nVMX: Allocate Hyper-V partition assist page
Date:   Mon,  6 Jun 2022 10:36:50 +0200
Message-Id: <20220606083655.2014609-34-vkuznets@redhat.com>
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

In preparation to testing Hyper-V L2 TLB flush hypercalls, allocate
so-called Partition assist page and link it to 'struct vmx_pages'.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/vmx.h | 4 ++++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c     | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 583ceb0d1457..f99922ca8259 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -567,6 +567,10 @@ struct vmx_pages {
 	uint64_t enlightened_vmcs_gpa;
 	void *enlightened_vmcs;
 
+	void *partition_assist_hva;
+	uint64_t partition_assist_gpa;
+	void *partition_assist;
+
 	void *eptp_hva;
 	uint64_t eptp_gpa;
 	void *eptp;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index d089d8b850b5..3db21e0e1a8f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -124,6 +124,13 @@ vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva)
 	vmx->enlightened_vmcs_gpa =
 		addr_gva2gpa(vm, (uintptr_t)vmx->enlightened_vmcs);
 
+	/* Setup of a region of guest memory for the partition assist page. */
+	vmx->partition_assist = (void *)vm_vaddr_alloc_page(vm);
+	vmx->partition_assist_hva =
+		addr_gva2hva(vm, (uintptr_t)vmx->partition_assist);
+	vmx->partition_assist_gpa =
+		addr_gva2gpa(vm, (uintptr_t)vmx->partition_assist);
+
 	*p_vmx_gva = vmx_gva;
 	return vmx;
 }
-- 
2.35.3

