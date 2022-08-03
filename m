Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D882F588D92
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Aug 2022 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiHCNq1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiHCNqN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18EEB1F2ED
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Aug 2022 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659534363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czVSfgeJdT0ENI1O87zKlSMPq/hlgeK5s27AHY9iFeg=;
        b=UUGIvtJBcn/jDgOwI2rsdn7wgoO2moi8VleF/na6pI4CYqlrVAlj5LTgbufBqO9K2Yakc3
        c5dAlUuWbYfp0T5ZSo33NYJudghvbRw/F0bhWe422ELDrKTtTKIONh51XIIih5Tz3ceerG
        XAXJ7rhY5L0AdKxm1OpwBju4Wlk2ALU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-X-Zt0wjnPreaLsEv7C-wtA-1; Wed, 03 Aug 2022 09:45:57 -0400
X-MC-Unique: X-Zt0wjnPreaLsEv7C-wtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AB1483DE57;
        Wed,  3 Aug 2022 13:45:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A878DC27D95;
        Wed,  3 Aug 2022 13:45:54 +0000 (UTC)
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
Subject: [PATCH v9 16/40] KVM: x86: hyper-v: Introduce kvm_hv_is_tlb_flush_hcall()
Date:   Wed,  3 Aug 2022 15:45:54 +0200
Message-Id: <20220803134554.399275-1-vkuznets@redhat.com>
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The newly introduced helper checks whether vCPU is performing a
Hyper-V TLB flush hypercall. This is required to filter out L2 TLB
flush hypercalls for processing.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 8a902b59aa46..239946ea483b 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -172,6 +172,24 @@ static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
 
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
+
+static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	u16 code;
+
+	if (!hv_vcpu)
+		return false;
+
+	code = is_64_bit_hypercall(vcpu) ? kvm_rcx_read(vcpu) :
+					   kvm_rax_read(vcpu);
+
+	return (code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX ||
+		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX);
+}
+
 void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
 
 
-- 
2.35.3

