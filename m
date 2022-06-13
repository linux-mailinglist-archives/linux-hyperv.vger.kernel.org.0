Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6657549A8C
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiFMRyh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiFMRyE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 13:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D6C74DF4
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655127591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYoxCAQooCgsqVZnU7eNU2nrE92V8/WKAg2e2d/OvUE=;
        b=JvyuiywASPfawwU3He73ITwDibPj1ksHFU+0FsvytrFr6pTSGW4dN+lQnmkTw5sMW9Ns1P
        ew65fk68yujfz9Bz9DLHFhAsEGaNkn6A9v+A3E228nWlGmGJAtnPXLuGi10ebRUKGpVPCL
        ZgMxka+JonJ5vP2wzfpftNxhbz/DFrY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-3Oc-3751OLyM03ViS_0dYg-1; Mon, 13 Jun 2022 09:39:47 -0400
X-MC-Unique: 3Oc-3751OLyM03ViS_0dYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B4E319705A8;
        Mon, 13 Jun 2022 13:39:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0E17492CA4;
        Mon, 13 Jun 2022 13:39:42 +0000 (UTC)
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
Subject: [PATCH v7 07/39] KVM: x86: Prepare kvm_hv_flush_tlb() to handle L2's GPAs
Date:   Mon, 13 Jun 2022 15:38:50 +0200
Message-Id: <20220613133922.2875594-8-vkuznets@redhat.com>
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

To handle L2 TLB flush requests, KVM needs to translate the specified
L2 GPA to L1 GPA to read hypercall arguments from there.

No functional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 783612e1fa3f..489a3918a757 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -23,6 +23,7 @@
 #include "ioapic.h"
 #include "cpuid.h"
 #include "hyperv.h"
+#include "mmu.h"
 #include "xen.h"
 
 #include <linux/cpu.h>
@@ -1915,6 +1916,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
 
+	if (!hc->fast && is_guest_mode(vcpu)) {
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		if (unlikely(hc->ingpa == UNMAPPED_GVA))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+	}
+
 	if (hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
 	    hc->code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE) {
 		if (hc->fast) {
-- 
2.35.3

