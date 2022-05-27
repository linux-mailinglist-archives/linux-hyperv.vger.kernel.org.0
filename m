Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DA53658B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 May 2022 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354046AbiE0P5z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 May 2022 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbiE0P5X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 May 2022 11:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11D7939FB
        for <linux-hyperv@vger.kernel.org>; Fri, 27 May 2022 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653667027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ry63xFrwO6O2lt3NumR064ix6uPD5MMi+epdiiFne5w=;
        b=Y48+vZx3UNh5HOz01ivQf4FlX7D3x5hCrPYWgBjoE0uvNUe2ycUAN0u4nSBPxoYasrqwJC
        d6pj9t6/ISd1aA5plK5QKXaO+BFlTvXwynsbMKi0ihc4q7BVJ2OtziYU8e+OE1dcLqrOIV
        hxDI+NExCOiyJ7mGKWsZKno/Py/04oY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-hyRRrNw4NCyypEobIz6nlQ-1; Fri, 27 May 2022 11:57:03 -0400
X-MC-Unique: hyRRrNw4NCyypEobIz6nlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9034101A54E;
        Fri, 27 May 2022 15:57:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC1702166B26;
        Fri, 27 May 2022 15:57:00 +0000 (UTC)
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
Subject: [PATCH v5 27/37] KVM: selftests: Fill in vm->vpages_mapped bitmap in virt_map() too
Date:   Fri, 27 May 2022 17:55:36 +0200
Message-Id: <20220527155546.1528910-28-vkuznets@redhat.com>
In-Reply-To: <20220527155546.1528910-1-vkuznets@redhat.com>
References: <20220527155546.1528910-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Similar to vm_vaddr_alloc(), virt_map() needs to reflect the mapping
in vm->vpages_mapped.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1665a220abcb..936be9c9f870 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1445,6 +1445,9 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		virt_pg_map(vm, vaddr, paddr);
 		vaddr += page_size;
 		paddr += page_size;
+
+		sparsebit_set(vm->vpages_mapped,
+			vaddr >> vm->page_shift);
 	}
 }
 
-- 
2.35.3

