Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A575F432B
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Oct 2022 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJDMmF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Oct 2022 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJDMlf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Oct 2022 08:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA05C9D3
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Oct 2022 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664887235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27w0Xf6KPC4Fsi1BOos8sj3cpjd7912e9dNdzVM+f78=;
        b=UHIiDfc3ohonrMN7HpB1rOVc240OkRLu0xPgd1QbUA/AF/jdlPSstUvSjeA4xmyFxj5S3h
        ut7hZMaqBDihU+L6fIGn4eNCeTw6/1CFDSviILxtB6oHgskmnf/huRrqEaOZBgfVarQBaR
        bWuCHOrwoA7I3NFS2+cYGCfXqh3tcIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-dt9C2oavP-msF-JI9B0MGA-1; Tue, 04 Oct 2022 08:40:32 -0400
X-MC-Unique: dt9C2oavP-msF-JI9B0MGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06DE1855305;
        Tue,  4 Oct 2022 12:40:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2A517AE5;
        Tue,  4 Oct 2022 12:40:29 +0000 (UTC)
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
Subject: [PATCH v11 13/46] KVM: x86: Prepare kvm_hv_flush_tlb() to handle L2's GPAs
Date:   Tue,  4 Oct 2022 14:39:23 +0200
Message-Id: <20221004123956.188909-14-vkuznets@redhat.com>
In-Reply-To: <20221004123956.188909-1-vkuznets@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To handle L2 TLB flush requests, KVM needs to translate the specified
L2 GPA to L1 GPA to read hypercall arguments from there.

No functional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9ede23e881b1..215d6cf09f21 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,6 +23,7 @@
 #include "ioapic.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "mmu.h"
 #include "xen.h"
 
 #include <linux/cpu.h>
@@ -1909,6 +1910,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
 
+	if (!hc->fast && is_guest_mode(vcpu)) {
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		if (unlikely(hc->ingpa == INVALID_GPA))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
+
 	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
 	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE) {
 		if (hc->fast) {
-- 
2.37.3

