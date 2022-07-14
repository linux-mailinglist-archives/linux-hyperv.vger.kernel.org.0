Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D807A574FF2
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Jul 2022 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiGNNvs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Jul 2022 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiGNNvM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Jul 2022 09:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F22F62488
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Jul 2022 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bf0rerKADaivbwEgd/ogWWd72NnFZOL2krdmLItOnhg=;
        b=GYTc1wk7cn5mrHNVB1Luf1FeSmAwAr9eMGpYpT/4Dnzs/8c07xviT4RGWdNwIPjaWkA6Ky
        cDlNW88WJ0vJfD1fZpupJXys8hgN+cMCRWL85PogRzaUbfC888v80/SAjf6WnAgyFQ8DpF
        HewWy4dgnh/25b3dM14NbsWSRLlRjfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-QvcmBX6kMXuJcmun6x4qaw-1; Thu, 14 Jul 2022 09:50:34 -0400
X-MC-Unique: QvcmBX6kMXuJcmun6x4qaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBD6180A0B7;
        Thu, 14 Jul 2022 13:50:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C02C2166B26;
        Thu, 14 Jul 2022 13:50:31 +0000 (UTC)
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
Subject: [PATCH v8 26/39] KVM: selftests: Move the function doing Hyper-V hypercall to a common header
Date:   Thu, 14 Jul 2022 15:49:16 +0200
Message-Id: <20220714134929.1125828-27-vkuznets@redhat.com>
In-Reply-To: <20220714134929.1125828-1-vkuznets@redhat.com>
References: <20220714134929.1125828-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

All Hyper-V specific tests issuing hypercalls need this.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/hyperv.h      | 16 ++++++++++++++++
 .../selftests/kvm/x86_64/hyperv_features.c     | 18 +-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index f0a8a93694b2..285e9ff73573 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -185,6 +185,22 @@
 /* hypercall options */
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 
+static inline uint8_t hyperv_hypercall(u64 control, vm_vaddr_t input_address,
+				       vm_vaddr_t output_address,
+				       uint64_t *hv_status)
+{
+	uint8_t vector;
+	/* Note both the hypercall and the "asm safe" clobber r9-r11. */
+	asm volatile("mov %[output_address], %%r8\n\t"
+		     KVM_ASM_SAFE("vmcall")
+		     : "=a" (*hv_status),
+		       "+c" (control), "+d" (input_address),
+		       KVM_ASM_SAFE_OUTPUTS(vector)
+		     : [output_address] "r"(output_address)
+		     : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
+	return vector;
+}
+
 /* Proper HV_X64_MSR_GUEST_OS_ID value */
 #define HYPERV_LINUX_OS_ID ((u64)0x8100 << 48)
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index d7c2c7b840aa..eb9fc0a70f17 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -13,22 +13,6 @@
 #include "processor.h"
 #include "hyperv.h"
 
-static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
-				vm_vaddr_t output_address, uint64_t *hv_status)
-{
-	uint8_t vector;
-
-	/* Note both the hypercall and the "asm safe" clobber r9-r11. */
-	asm volatile("mov %[output_address], %%r8\n\t"
-		     KVM_ASM_SAFE("vmcall")
-		     : "=a" (*hv_status),
-		       "+c" (control), "+d" (input_address),
-		       KVM_ASM_SAFE_OUTPUTS(vector)
-		     : [output_address] "r"(output_address)
-		     : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
-	return vector;
-}
-
 struct msr_data {
 	uint32_t idx;
 	bool available;
@@ -78,7 +62,7 @@ static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
 		input = output = 0;
 	}
 
-	vector = hypercall(hcall->control, input, output, &res);
+	vector = hyperv_hypercall(hcall->control, input, output, &res);
 	if (hcall->ud_expected)
 		GUEST_ASSERT_2(vector == UD_VECTOR, hcall->control, vector);
 	else
-- 
2.35.3

