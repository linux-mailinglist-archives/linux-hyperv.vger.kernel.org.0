Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0244D6512
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Mar 2022 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiCKPwH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Mar 2022 10:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349877AbiCKPvr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Mar 2022 10:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F7A1CC7E2
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Mar 2022 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647013840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BUkCceWwPF6IV25ZH1+8yGdQLQ11zSPD8IwItivN4M=;
        b=FHILrMbPc8w5Pty68V98YrSpD2ep8T0+qB1WTcx/AEKtceka96+Lv5YtSbN6P1IkbjfVRI
        40gS4/uoluvMjuxtRliBndo8SdiCypewL6GiCZG1uLC/Yeux6XzJ9MQXFKAofD6ONqRHyJ
        V+eJ/n+xmLbD/TPp/JyyNlVIVO0i28Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-NX2EUs27Pp2GRaWfd_b8MA-1; Fri, 11 Mar 2022 10:50:39 -0500
X-MC-Unique: NX2EUs27Pp2GRaWfd_b8MA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C737951E0;
        Fri, 11 Mar 2022 15:50:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17EA1785FD;
        Fri, 11 Mar 2022 15:50:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/31] KVM: x86: KVM_REQ_TLB_FLUSH_CURRENT is a superset of KVM_REQ_HV_TLB_FLUSH too
Date:   Fri, 11 Mar 2022 16:49:29 +0100
Message-Id: <20220311154943.2299191-18-vkuznets@redhat.com>
In-Reply-To: <20220311154943.2299191-1-vkuznets@redhat.com>
References: <20220311154943.2299191-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

KVM_REQ_TLB_FLUSH_CURRENT is an even stronger operation than
KVM_REQ_TLB_FLUSH_GUEST so KVM_REQ_HV_TLB_FLUSH needs not to be
processed after it.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0082c5691a05..81f1039c9aff 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3336,8 +3336,11 @@ static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
  */
 void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
 {
-	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
 		kvm_vcpu_flush_tlb_current(vcpu);
+		if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+			kvm_hv_vcpu_empty_flush_tlb(vcpu);
+	}
 
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
 		kvm_vcpu_flush_tlb_guest(vcpu);
-- 
2.35.1

