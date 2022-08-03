Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DD588DB2
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Aug 2022 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiHCNsL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Aug 2022 09:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiHCNro (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Aug 2022 09:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B740205FF
        for <linux-hyperv@vger.kernel.org>; Wed,  3 Aug 2022 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659534401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZePUXx6jI2dMdCbhczqhF1SsVWBmNTOtinLHfHc2hPA=;
        b=Oz25fZREZKQUXNU6yVd3I353caPNy2a+Zrg7QgLEKQqdSSiXCGx8YOx/7vDdyCPDASGo5Q
        nV667YeyyoFFxHmg2FQA4dzzZMC05Sqvsal+zJAO/HSIyYw6mJdcTPVnb/88bC0CQ5ZO7N
        GrFOyb4279LY9go28ysu3bF6QIH2Lag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-36ptAVxlPaO_Ji8o9BWlcg-1; Wed, 03 Aug 2022 09:46:39 -0400
X-MC-Unique: 36ptAVxlPaO_Ji8o9BWlcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58D0C800DBE;
        Wed,  3 Aug 2022 13:46:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6E2E2166B2A;
        Wed,  3 Aug 2022 13:46:36 +0000 (UTC)
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
Subject: [PATCH v9 28/40] KVM: selftests: Fill in vm->vpages_mapped bitmap in virt_map() too
Date:   Wed,  3 Aug 2022 15:46:35 +0200
Message-Id: <20220803134635.399448-1-vkuznets@redhat.com>
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Similar to vm_vaddr_alloc(), virt_map() needs to reflect the mapping
in vm->vpages_mapped.

While on it, remove unneeded code wraping in vm_vaddr_alloc().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9889fe0d8919..ad9e15d4c6a9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1214,8 +1214,7 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 
 		virt_pg_map(vm, vaddr, paddr);
 
-		sparsebit_set(vm->vpages_mapped,
-			vaddr >> vm->page_shift);
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
 	}
 
 	return vaddr_start;
@@ -1288,6 +1287,8 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		virt_pg_map(vm, vaddr, paddr);
 		vaddr += page_size;
 		paddr += page_size;
+
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
 	}
 }
 
-- 
2.35.3

