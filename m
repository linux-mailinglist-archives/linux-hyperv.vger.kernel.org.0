Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E75A6535
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Aug 2022 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiH3NlZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Aug 2022 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiH3Nkk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Aug 2022 09:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BEFE350
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661866734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNi9YFlQcv9FJWQJuw7DCVKDq1XvYvPpqL3U/pqCadg=;
        b=GilRDgdL+5G6cUwkhL0cmRjd0AZVqwhRpYDISAYYPwqLOpdGMQ6FGz4rN+eKfEipNTv1zW
        HR7BrsIC2M94aTdKjHTEJ6PXyz9MVfGsfnI2epHUgapN2X12oHu6Cxfu9FFbRIycGecSJz
        NDNY63A9EBFxAuGJ2GHEau81o673n+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-xPrpndBOObCjhMEn-63OWQ-1; Tue, 30 Aug 2022 09:38:50 -0400
X-MC-Unique: xPrpndBOObCjhMEn-63OWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9857101E9BA;
        Tue, 30 Aug 2022 13:38:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B222166B2A;
        Tue, 30 Aug 2022 13:38:47 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/33] KVM: VMX: Adjust CR3/INVPLG interception for EPT=y at runtime, not setup
Date:   Tue, 30 Aug 2022 15:37:31 +0200
Message-Id: <20220830133737.1539624-28-vkuznets@redhat.com>
In-Reply-To: <20220830133737.1539624-1-vkuznets@redhat.com>
References: <20220830133737.1539624-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Clear the CR3 and INVLPG interception controls at runtime based on
whether or not EPT is being _used_, as opposed to clearing the bits at
setup if EPT is _supported_ in hardware, and then restoring them when EPT
is not used.  Not mucking with the base config will allow using the base
config as the starting point for emulating the VMX capability MSRs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be69fc3a57a3..2e1fe1f8d764 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2578,13 +2578,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP,
 		&vmx_cap->ept, &vmx_cap->vpid);
 
-	if (_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) {
-		/* CR3 accesses and invlpg don't need to cause VM Exits when EPT
-		   enabled */
-		_cpu_based_exec_control &= ~(CPU_BASED_CR3_LOAD_EXITING |
-					     CPU_BASED_CR3_STORE_EXITING |
-					     CPU_BASED_INVLPG_EXITING);
-	} else if (vmx_cap->ept) {
+	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) &&
+	    vmx_cap->ept) {
 		pr_warn_once("EPT CAP should not exist if not support "
 				"1-setting enable EPT VM-execution control\n");
 
@@ -4353,10 +4348,11 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 		exec_control |= CPU_BASED_CR8_STORE_EXITING |
 				CPU_BASED_CR8_LOAD_EXITING;
 #endif
-	if (!enable_ept)
-		exec_control |= CPU_BASED_CR3_STORE_EXITING |
-				CPU_BASED_CR3_LOAD_EXITING  |
-				CPU_BASED_INVLPG_EXITING;
+	/* No need to intercept CR3 access or INVPLG when using EPT. */
+	if (enable_ept)
+		exec_control &= ~(CPU_BASED_CR3_LOAD_EXITING |
+				  CPU_BASED_CR3_STORE_EXITING |
+				  CPU_BASED_INVLPG_EXITING);
 	if (kvm_mwait_in_guest(vmx->vcpu.kvm))
 		exec_control &= ~(CPU_BASED_MWAIT_EXITING |
 				CPU_BASED_MONITOR_EXITING);
-- 
2.37.2

