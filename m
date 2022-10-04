Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F85F435A
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Oct 2022 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJDMoX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Oct 2022 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJDMnl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Oct 2022 08:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717A5A83C
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Oct 2022 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664887281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUCg8qdmT/f9wGvYa9s3dkKIpVFfOtqQkOxHWueTN/k=;
        b=UU0XtbDSdAPgekM80aMpjofHf0kGM4STsMqJwUVUWhTswmnlVYdw0sIc6+hP13avDCFr5i
        wLqiT9q1NcRLhJI/ymxz6GyrR4CKCwVRYm8n7KZg6LeHNiAm9H1x4toXDDsJfEjthU9SzW
        dQbps8g01mXZh44NOXyVj1wl1SxFvsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-Q2NHBm_7PLyctHYWyl1W1A-1; Tue, 04 Oct 2022 08:41:16 -0400
X-MC-Unique: Q2NHBm_7PLyctHYWyl1W1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5D7D882821;
        Tue,  4 Oct 2022 12:41:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CCC717583;
        Tue,  4 Oct 2022 12:41:13 +0000 (UTC)
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
Subject: [PATCH v11 31/46] KVM: selftests: Move HYPERV_LINUX_OS_ID definition to a common header
Date:   Tue,  4 Oct 2022 14:39:41 +0200
Message-Id: <20221004123956.188909-32-vkuznets@redhat.com>
In-Reply-To: <20221004123956.188909-1-vkuznets@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

HYPERV_LINUX_OS_ID needs to be written to HV_X64_MSR_GUEST_OS_ID by
each Hyper-V specific selftest.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 3 +++
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index b66910702c0a..f0a8a93694b2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -185,4 +185,7 @@
 /* hypercall options */
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 
+/* Proper HV_X64_MSR_GUEST_OS_ID value */
+#define HYPERV_LINUX_OS_ID ((u64)0x8100 << 48)
+
 #endif /* !SELFTEST_KVM_HYPERV_H */
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 05b32e550a80..71bb91602a7f 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -13,8 +13,6 @@
 #include "processor.h"
 #include "hyperv.h"
 
-#define LINUX_OS_ID ((u64)0x8100 << 48)
-
 static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
 				vm_vaddr_t output_address, uint64_t *hv_status)
 {
@@ -71,7 +69,7 @@ static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
 
 	GUEST_ASSERT(hcall->control);
 
-	wrmsr(HV_X64_MSR_GUEST_OS_ID, LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
 
 	if (!(hcall->control & HV_HYPERCALL_FAST_BIT)) {
@@ -169,7 +167,7 @@ static void guest_test_msrs_access(void)
 			 */
 			msr->idx = HV_X64_MSR_GUEST_OS_ID;
 			msr->write = 1;
-			msr->write_val = LINUX_OS_ID;
+			msr->write_val = HYPERV_LINUX_OS_ID;
 			msr->available = 1;
 			break;
 		case 3:
-- 
2.37.3

