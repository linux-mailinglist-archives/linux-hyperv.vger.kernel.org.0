Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA0054C917
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jun 2022 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiFOMuL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Jun 2022 08:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiFOMtk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Jun 2022 08:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD0F37AAF
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Jun 2022 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655297369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSJfjgdN0vQG1u3bjjSqAwaUNHGoByzADLhrcH/GT+4=;
        b=M6Rq9hZkbam3LEXb/eKeDbs6t/SVVfUdB9cyQ6ZtSpvOWOSrUYRdvcnx70ZYc38mRXX7Kd
        WaIvt9KpUZEwzFiFeE8ac+s8yz3RPJwJ4zHKzxTaQtznMCdFCcxP3mCKJfrQDVfBCbHhZK
        sByUwC8UfIWMEUVl3kCsdWA/lxCIkVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-Tb8qwV40NBWMMlUqXNkgow-1; Wed, 15 Jun 2022 08:49:28 -0400
X-MC-Unique: Tb8qwV40NBWMMlUqXNkgow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339C1100EB07;
        Wed, 15 Jun 2022 12:49:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78E35401E68;
        Wed, 15 Jun 2022 12:49:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 5/5] KVM: VMX: Support TSC scaling with enlightened VMCS
Date:   Wed, 15 Jun 2022 14:49:15 +0200
Message-Id: <20220615124915.3068295-6-vkuznets@redhat.com>
In-Reply-To: <20220615124915.3068295-1-vkuznets@redhat.com>
References: <20220615124915.3068295-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enlightened VMCS v1 now includes the required field for TSC scaling
feature so SECONDARY_EXEC_TSC_SCALING can remain unfiltered.

While on it, update the comment why VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL/
VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL are keept filtered out.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index f886a8ff0342..ffdf8955c62c 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -37,16 +37,14 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
  *	EPTP_LIST_ADDRESS               = 0x00002024,
  *	VMREAD_BITMAP                   = 0x00002026,
  *	VMWRITE_BITMAP                  = 0x00002028,
- *
- *	TSC_MULTIPLIER                  = 0x00002032,
  *	PLE_GAP                         = 0x00004020,
  *	PLE_WINDOW                      = 0x00004022,
  *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
- *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
- *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
  *
- * Currently unsupported in KVM:
- *	GUEST_IA32_RTIT_CTL		= 0x00002814,
+ *	While GUEST_IA32_PERF_GLOBAL_CTRL and HOST_IA32_PERF_GLOBAL_CTRL
+ *	are present in eVMCSv1, Windows 11 still has issues booting when
+ *	VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL/VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL
+ *	are exposed to it, keep them filtered out.
  */
 #define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
 				    PIN_BASED_VMX_PREEMPTION_TIMER)
@@ -58,7 +56,6 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
 	 SECONDARY_EXEC_ENABLE_PML |					\
 	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
 	 SECONDARY_EXEC_SHADOW_VMCS |					\
-	 SECONDARY_EXEC_TSC_SCALING |					\
 	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
 #define EVMCS1_UNSUPPORTED_VMEXIT_CTRL					\
 	(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |				\
-- 
2.35.3

