Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F9618830
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKCTHK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKCTHJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 15:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CE1D674
        for <linux-hyperv@vger.kernel.org>; Thu,  3 Nov 2022 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667502369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Ns3xU1SqKKJDYkuvUPPy7RWE9S2cnkow8czUZNPGj8=;
        b=KXf+Uwz0BykKuMDRg8ddJ5mNHpZYzQiCRP2+N2EcglEKYj6KcoaQtQf4pxDL2S0sqVrmfx
        B65Ej6ZsqVYE4yNsntrIaDhp2vUIL7dpNDklEBkCRQlLiVjNCDQYdomHhY1qUx2ohiQzgk
        0b6hATYRKPpyDrOh2ZBMGC2lvv0pYfM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-qrCib1lGMUGTf6kfahNkiA-1; Thu, 03 Nov 2022 15:06:04 -0400
X-MC-Unique: qrCib1lGMUGTf6kfahNkiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A0F63C32C54;
        Thu,  3 Nov 2022 19:06:04 +0000 (UTC)
Received: from ovpn-194-252.brq.redhat.com (ovpn-194-252.brq.redhat.com [10.40.194.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58AEF2166B26;
        Thu,  3 Nov 2022 19:06:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/hyperv: Restore VP assist page after cpu offlining/onlining
Date:   Thu,  3 Nov 2022 20:06:01 +0100
Message-Id: <20221103190601.399343-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing
to VP assist page MSR") moved 'wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE)' under
'if (*hvp)' condition. This works for root partition as hv_cpu_die()
does memunmap() and sets 'hv_vp_assist_page[cpu]' to NULL but breaks
non-root partitions as hv_cpu_die() doesn't free 'hv_vp_assist_page[cpu]'
for them. This causes VP assist page to remain unset after CPU
offline/online cycle:

$ rdmsr -p 24 0x40000073
  10212f001
$ echo 0 > /sys/devices/system/cpu/cpu24/online
$ echo 1 > /sys/devices/system/cpu/cpu24/online
$ rdmsr -p 24 0x40000073
  0

Fix the issue by always writing to HV_X64_MSR_VP_ASSIST_PAGE in
hv_cpu_init(). Note, checking 'if (!*hvp)', for root partition is
pointless as hv_cpu_die() always sets 'hv_vp_assist_page[cpu]' to
NULL (and it's also NULL initially).

Note: the fact that 'hv_vp_assist_page[cpu]' is reset to NULL may
present a (potential) issue for KVM. While Hyper-V uses
CPUHP_AP_ONLINE_DYN stage in CPU hotplug, KVM uses CPUHP_AP_KVM_STARTING
which comes earlier in CPU teardown sequence. It is theoretically
possible that Enlightened VMCS is still in use. It is unclear if the
issue is real and if using KVM with Hyper-V root partition is even
possible.

While on it, drop the unneeded smp_processor_id() call from hv_cpu_init().

Fixes: e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing to VP assist page MSR")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c | 54 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f49bc3ec76e6..a269049a43ce 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -87,34 +87,32 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
-	if (!*hvp) {
-		if (hv_root_partition) {
-			/*
-			 * For root partition we get the hypervisor provided VP assist
-			 * page, instead of allocating a new page.
-			 */
-			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
-			*hvp = memremap(msr.pfn <<
-					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
-					PAGE_SIZE, MEMREMAP_WB);
-		} else {
-			/*
-			 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
-			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
-			 * out to make sure we always write the EOI MSR in
-			 * hv_apic_eoi_write() *after* the EOI optimization is disabled
-			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
-			 * case of CPU offlining and the VM will hang.
-			 */
+	if (hv_root_partition) {
+		/*
+		 * For root partition we get the hypervisor provided VP assist
+		 * page, instead of allocating a new page.
+		 */
+		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
+		*hvp = memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
+				PAGE_SIZE, MEMREMAP_WB);
+	} else {
+		/*
+		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
+		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
+		 * out to make sure we always write the EOI MSR in
+		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
+		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
+		 * case of CPU offlining and the VM will hang.
+		 */
+		if (!*hvp)
 			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
-			if (*hvp)
-				msr.pfn = vmalloc_to_pfn(*hvp);
-		}
-		WARN_ON(!(*hvp));
-		if (*hvp) {
-			msr.enable = 1;
-			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
-		}
+		if (*hvp)
+			msr.pfn = vmalloc_to_pfn(*hvp);
+
+	}
+	if (!WARN_ON(!(*hvp))) {
+		msr.enable = 1;
+		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
 
 	return hyperv_init_ghcb();
-- 
2.38.1

