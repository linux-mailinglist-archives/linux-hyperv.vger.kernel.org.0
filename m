Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D4736035
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFSXnk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 19:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFSXni (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 19:43:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D065134;
        Mon, 19 Jun 2023 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687218217; x=1718754217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjdeJrHKQrrbCHSdMm3YTrFoZr8SNMp9Q07vjTANKnk=;
  b=IEuOwOjg4Fr0QdAJESBVzjt2HrSQeaJBj3xTp/isIVLIwiFVc3IOXABZ
   YaHelYfQrIL1FKE0vxNumQPAyt1AtuNRRpn+wYbwHCvjOa0MDRJjlTXCz
   saHCL9AgIQ9QiHmPTf1szfHXvcwySzdi2Gl6IEJY8Kh4bFYtU3jAaBXny
   y2RSBob1vDv+R+E1VyA4d0+pEqvdthGfkkkj664NvnZrFFdmMzIxl6sN2
   3JhbU4YoS421CCSedZksfW+K66EdDzK1niz8QqumPWJ3Pa3+ZR6m/nOIt
   0PIZKsYroaK+gZ80ng/4SGcGiDEt9LpQD8ZVDEAyZTbLnleyykFD2hBEL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="340071473"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="340071473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 16:43:37 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="747789693"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="747789693"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2023 16:43:35 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        iommu@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, steve.wahl@hpe.com,
        mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, dvhart@infradead.org, andy@infradead.org,
        joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, xin3.li@intel.com, seanjc@google.com,
        jiangshanlai@gmail.com, jgg@ziepe.ca, yangtiezhu@loongson.cn
Subject: [PATCH 2/3] x86/vector: Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback
Date:   Mon, 19 Jun 2023 16:16:10 -0700
Message-Id: <20230619231611.2230-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619231611.2230-1-xin3.li@intel.com>
References: <20230619231611.2230-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace IRQ_MOVE_CLEANUP_VECTOR with a timer callback for cleaning
up the leftovers of a moved interrupt.

The only new job incurred is to do vector cleanup in lapic_offline()
in case the vector cleanup timer has not expired.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/idtentry.h    |   1 -
 arch/x86/include/asm/irq_vectors.h |   7 --
 arch/x86/kernel/apic/vector.c      | 101 +++++++++++++++++++++++------
 arch/x86/kernel/idt.c              |   1 -
 4 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b241af4ce9b4..cd5c10a74071 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -648,7 +648,6 @@ DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 
 #ifdef CONFIG_SMP
 DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
-DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 43dcb9284208..3a19904c2db6 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -35,13 +35,6 @@
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
 
-/*
- * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
- * triggering cleanup after irq migration. 0x21-0x2f will still be used
- * for device interrupts.
- */
-#define IRQ_MOVE_CLEANUP_VECTOR		FIRST_EXTERNAL_VECTOR
-
 #define IA32_SYSCALL_VECTOR		0x80
 
 /*
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index aa370bd0d933..23a3f3b6dd2c 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -44,7 +44,18 @@ static cpumask_var_t vector_searchmask;
 static struct irq_chip lapic_controller;
 static struct irq_matrix *vector_matrix;
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
+
+static void vector_cleanup_callback(struct timer_list *tmr);
+
+struct vector_cleanup {
+	struct hlist_head	head;
+	struct timer_list	timer;
+};
+
+static DEFINE_PER_CPU(struct vector_cleanup, vector_cleanup) = {
+	.head	= HLIST_HEAD_INIT,
+	.timer	= __TIMER_INITIALIZER(vector_cleanup_callback, TIMER_PINNED),
+};
 #endif
 
 void lock_vector_lock(void)
@@ -841,10 +852,21 @@ void lapic_online(void)
 		this_cpu_write(vector_irq[vector], __setup_vector_irq(vector));
 }
 
+static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr);
+
 void lapic_offline(void)
 {
+	struct vector_cleanup *cl = this_cpu_ptr(&vector_cleanup);
+
 	lock_vector_lock();
+
+	/* In case the vector cleanup timer has not expired */
+	__vector_cleanup(cl, false);
+
 	irq_matrix_offline(vector_matrix);
+	WARN_ON_ONCE(try_to_del_timer_sync(&cl->timer) < 0);
+	WARN_ON_ONCE(!hlist_empty(&cl->head));
+
 	unlock_vector_lock();
 }
 
@@ -934,49 +956,86 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 	apicd->move_in_progress = 0;
 }
 
-DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
+/*
+ * Called with vector_lock held
+ */
+static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 {
-	struct hlist_head *clhead = this_cpu_ptr(&cleanup_list);
 	struct apic_chip_data *apicd;
 	struct hlist_node *tmp;
+	bool rearm = false;
 
-	ack_APIC_irq();
-	/* Prevent vectors vanishing under us */
-	raw_spin_lock(&vector_lock);
-
-	hlist_for_each_entry_safe(apicd, tmp, clhead, clist) {
+	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
 		unsigned int irr, vector = apicd->prev_vector;
 
 		/*
 		 * Paranoia: Check if the vector that needs to be cleaned
-		 * up is registered at the APICs IRR. If so, then this is
-		 * not the best time to clean it up. Clean it up in the
-		 * next attempt by sending another IRQ_MOVE_CLEANUP_VECTOR
-		 * to this CPU. IRQ_MOVE_CLEANUP_VECTOR is the lowest
-		 * priority external vector, so on return from this
-		 * interrupt the device interrupt will happen first.
+		 * up is registered at the APICs IRR. That's clearly a
+		 * hardware issue if the vector arrived on the old target
+		 * _after_ interrupts were disabled above. Keep @apicd
+		 * on the list and schedule the timer again to give the CPU
+		 * a chance to handle the pending interrupt.
+		 *
+		 * Do not check IRR when called from lapic_offline(), because
+		 * fixup_irqs() was just called to scan IRR for set bits and
+		 * forward them to new destination CPUs via IPIs.
 		 */
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
+		irr = check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
 		if (irr & (1U << (vector % 32))) {
-			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
+			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->irq);
+			rearm = true;
 			continue;
 		}
 		free_moved_vector(apicd);
 	}
 
-	raw_spin_unlock(&vector_lock);
+	/*
+	 * Must happen under vector_lock to make the timer_pending() check
+	 * in __vector_schedule_cleanup() race free against the rearm here.
+	 */
+	if (rearm)
+		mod_timer(&cl->timer, jiffies + 1);
+}
+
+static void vector_cleanup_callback(struct timer_list *tmr)
+{
+	struct vector_cleanup *cl = container_of(tmr, typeof(*cl), timer);
+
+	/* Prevent vectors vanishing under us */
+	raw_spin_lock_irq(&vector_lock);
+	__vector_cleanup(cl, true);
+	raw_spin_unlock_irq(&vector_lock);
 }
 
 static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 {
-	unsigned int cpu;
+	unsigned int cpu = apicd->prev_cpu;
 
 	raw_spin_lock(&vector_lock);
 	apicd->move_in_progress = 0;
-	cpu = apicd->prev_cpu;
 	if (cpu_online(cpu)) {
-		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
-		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
+		struct vector_cleanup *cl = per_cpu_ptr(&vector_cleanup, cpu);
+
+		hlist_add_head(&apicd->clist, &cl->head);
+
+		/*
+		 * The lockless timer_pending() check is safe here. If it
+		 * returns true, then the callback will observe this new
+		 * apic data in the hlist as everything is serialized by
+		 * vector lock.
+		 *
+		 * If it returns false then the timer is either not armed
+		 * or the other CPU executes the callback, which again
+		 * would be blocked on vector lock. Rearming it in the
+		 * latter case makes it fire for nothing.
+		 *
+		 * This is also safe against the callback rearming the timer
+		 * because that's serialized via vector lock too.
+		 */
+		if (!timer_pending(&cl->timer)) {
+			cl->timer.expires = jiffies + 1;
+			add_timer_on(&cl->timer, cpu);
+		}
 	} else {
 		apicd->prev_vector = 0;
 	}
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..f3958262c725 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -131,7 +131,6 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
-	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
 	INTG(REBOOT_VECTOR,			asm_sysvec_reboot),
 #endif
 
-- 
2.34.1

