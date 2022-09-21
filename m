Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9645E545C
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIUUQR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiIUUQP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 16:16:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209BA4B07
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 13:16:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b18-20020a253412000000b006b0177978eeso6212541yba.21
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=9UwbrQ0jbfkdWibvQjcC8zTWLX7OGdH/X8ruvlS1WMg=;
        b=d6OxGnQwB6PfvAxP09aDlfsT7F+vltfemklLt+BdEo9n3HeF5TNxtuhbxj95cNx1OX
         4YGu4iYzkQN5Ev8cwMJSQ5djfM0aw7Zw94hSpNKrxRfotDdC0JTQWVUJy23fYusp5S5X
         B2PGbCjiSWD1+qdythdWEj2fHw7RFJnUVJewsM+/yYxUVpQAljsB+LJXxUXbFxMyE8sl
         whhTLh+BC5S5B3avSV8SuylbxXaiDiSVFrEwImHUcTnHEU+cGdeCZe1x4u4tiILhKll0
         7y5FUfiRtE4tOIXhUj2vd8/+vIPN6TPW/O8sk3U2l0JFvs2J4KU2hzO30G+IfuB+yGE+
         1y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=9UwbrQ0jbfkdWibvQjcC8zTWLX7OGdH/X8ruvlS1WMg=;
        b=Fie/jaAnP8o2KHSETqU6UK7Mo8zNU3vWvwzpiy+2UqvnnYmKEFJ7Tbj/NiQSloDc/P
         LeqA+hej1zJJjCsvXfibmTmFd6hCL1mI6nfYcMRrDbnSpErc8ze1jQkJAAkpj5FWPGWK
         Cff9i5IJ+jYi/Bcw7ghszOZy+97Ht54v6h7mFBwsI0kKVkkYSTMEAFn+I7nc0Rsy9dTZ
         Q8EmOEHsAhzQFxfIynNmvy4TpDnkeMIi8CmA6Fn7nw28QUdKpPeF+jcWxNlVVFZ4TZqZ
         8RoA66bseTOMIDq+bfFNPyME0bbsloYaTlWP2P6isk59IrFhaIuK07tgJzf79xEmRuTR
         MEYQ==
X-Gm-Message-State: ACrzQf1GU2d/1zjtRGKCu9ti08Q+H/rsttzXlKQPACf819fFWfAqAp1z
        hYp+r+dB89aojWZeCV70fjXc2bNiQyY=
X-Google-Smtp-Source: AMsMyM5oooDD0bapnTTsN91Ujsfq/81cDKDLq8MhjvmiTpwq+/VM4sHbdG7LLT/W813IB7Q5fZK3VMMV1bU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2187:0:b0:6b0:1abc:2027 with SMTP id
 h129-20020a252187000000b006b01abc2027mr110766ybh.348.1663791372853; Wed, 21
 Sep 2022 13:16:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Sep 2022 20:16:05 +0000
In-Reply-To: <20220921201607.3156750-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220921201607.3156750-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921201607.3156750-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Move Hyper-V's VMCB "struct hv_enlightenments" to the svm.h header so
that the struct can be referenced in "struct vmcb_control_area".
Alternatively, a dedicated header for SVM+Hyper-V could be added, a la
x86_64/evmcs.h, but it doesn't appear that Hyper-V will end up needing
a wholesale replacement for the VMCB.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/svm.h | 17 +++++++++++++++++
 .../selftests/kvm/x86_64/hyperv_svm_test.c     | 18 ------------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index c8343ff84f7f..10b9d0d4e0ec 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -58,6 +58,23 @@ enum {
 	INTERCEPT_RDPRU,
 };
 
+struct hv_enlightenments {
+	struct __packed hv_enlightenments_control {
+		u32 nested_flush_hypercall:1;
+		u32 msr_bitmap:1;
+		u32 enlightened_npt_tlb: 1;
+		u32 reserved:29;
+	} __packed hv_enlightenments_control;
+	u32 hv_vp_id;
+	u64 hv_vm_id;
+	u64 partition_assist_page;
+	u64 reserved;
+} __packed;
+
+/*
+ * Hyper-V uses the software reserved clean bit in VMCB
+ */
+#define VMCB_HV_NESTED_ENLIGHTENMENTS (1U << 31)
 
 struct __attribute__ ((__packed__)) vmcb_control_area {
 	u32 intercept_cr;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index a380ad7bb9b3..b366b197759f 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -23,24 +23,6 @@
 
 #define L2_GUEST_STACK_SIZE 256
 
-struct hv_enlightenments {
-	struct __packed hv_enlightenments_control {
-		u32 nested_flush_hypercall:1;
-		u32 msr_bitmap:1;
-		u32 enlightened_npt_tlb: 1;
-		u32 reserved:29;
-	} __packed hv_enlightenments_control;
-	u32 hv_vp_id;
-	u64 hv_vm_id;
-	u64 partition_assist_page;
-	u64 reserved;
-} __packed;
-
-/*
- * Hyper-V uses the software reserved clean bit in VMCB
- */
-#define VMCB_HV_NESTED_ENLIGHTENMENTS (1U << 31)
-
 void l2_guest_code(void)
 {
 	GUEST_SYNC(3);
-- 
2.37.3.968.ga6b4b080e4-goog

