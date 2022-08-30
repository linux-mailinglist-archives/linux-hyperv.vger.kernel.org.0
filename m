Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBE5A6530
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Aug 2022 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiH3NlA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Aug 2022 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiH3NkO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Aug 2022 09:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BF122BE2
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661866721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CM5YiOQptbU9X800szyhSBz6fSk82jbxp+XK1QEeC+g=;
        b=OteDmgwYIaTaxTuOt9XDY/a06nJ2AJ23ZoJhj5E16mG8Iq7zTrIthezxdx5TI+0Y87Z4Ha
        79qpvEusjYtgVZMGkHkwXjPy1aFoT4WRFT4KZ/c0dsUOeOCZP5qS5/fWyLle1q3jpfrO+n
        BqUltWKDOpbbZkkNm0jeu/hUatY+7DA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-7YVJEuoLPF6w-XluUHyi9w-1; Tue, 30 Aug 2022 09:38:37 -0400
X-MC-Unique: 7YVJEuoLPF6w-XluUHyi9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1DC22999B44;
        Tue, 30 Aug 2022 13:38:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B94572166B26;
        Tue, 30 Aug 2022 13:38:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 22/33] KVM: VMX: Don't toggle VM_ENTRY_IA32E_MODE for 32-bit kernels/KVM
Date:   Tue, 30 Aug 2022 15:37:26 +0200
Message-Id: <20220830133737.1539624-23-vkuznets@redhat.com>
In-Reply-To: <20220830133737.1539624-1-vkuznets@redhat.com>
References: <20220830133737.1539624-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Don't toggle VM_ENTRY_IA32E_MODE in 32-bit kernels/KVM and instead bug
the VM if KVM attempts to run the guest with EFER.LMA=1. KVM doesn't
support running 64-bit guests with 32-bit hosts.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9a9cdd4ea34d..7b73fee34598 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3039,10 +3039,15 @@ int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 		return 0;
 
 	vcpu->arch.efer = efer;
+#ifdef CONFIG_X86_64
 	if (efer & EFER_LMA)
 		vm_entry_controls_setbit(vmx, VM_ENTRY_IA32E_MODE);
 	else
 		vm_entry_controls_clearbit(vmx, VM_ENTRY_IA32E_MODE);
+#else
+	if (KVM_BUG_ON(efer & EFER_LMA, vcpu->kvm))
+		return 1;
+#endif
 
 	vmx_setup_uret_msrs(vmx);
 	return 0;
-- 
2.37.2

