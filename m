Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176FC46BAE6
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Dec 2021 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhLGMVT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhLGMVT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B95C061354;
        Tue,  7 Dec 2021 04:17:48 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So+Myncn1chaY/5pWFszm6sD7nAqG86xqh1XFqhxRK0=;
        b=19Ni0JLuG9QBbsDLzg1Z9JanNvacM3qxR/vZsof5oDiVgVfMmWW2EYXnDZjv0dFY88/X4P
        BuVU9+LgEG0QZLeW0ZUM/pra3eNzCNKvo0KE6UB9VvPXCpzMpSzXIP4g3AxmPJIEJoZUvp
        WAeruiGYFpmU/hIjDSU4OauBgr6s/lmemQuswpCU2EepPTPRSzJYMZkHkrZana/alIw1Us
        2D38Wz3xvPtr1lOtqTnCvOKyK6vCyoCO2gmR5yjFY4x7RG+DIhydeQsJVQz5XbSF8036fj
        TwcsQeXbKyCuoDNPR9vtTG6UC5HzBdRRlXTN+s1wWdar0dFueenFc972bRAiVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So+Myncn1chaY/5pWFszm6sD7nAqG86xqh1XFqhxRK0=;
        b=MJouK96NCHx/m2jpKuk9PU7Ksfcmzw9jS0v4UMoliu8KypJUhNrB0VTPwSmD0dv7D4v8cE
        I5qyc3orYVzWSzBA==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/5] random: Remove unused irq_flags argument from add_interrupt_randomness().
Date:   Tue,  7 Dec 2021 13:17:33 +0100
Message-Id: <20211207121737.2347312-2-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-1-bigeasy@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit
   ee3e00e9e7101 ("random: use registers from interrupted code for CPU's w/=
o a cycle counter")

the irq_flags argument is no longer used.

Remove unused irq_flags irq_flags.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 drivers/char/random.c          | 4 ++--
 drivers/hv/vmbus_drv.c         | 2 +-
 include/linux/random.h         | 2 +-
 kernel/irq/handle.c            | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ff55df60228f7..2a0f836789118 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -79,7 +79,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
 	inc_irq_stat(hyperv_stimer0_count);
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
-	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
+	add_interrupt_randomness(HYPERV_STIMER0_VECTOR);
 	ack_APIC_irq();
=20
 	set_irq_regs(old_regs);
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f965..c8067c264a880 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -200,7 +200,7 @@
  *	void add_device_randomness(const void *buf, unsigned int size);
  * 	void add_input_randomness(unsigned int type, unsigned int code,
  *                                unsigned int value);
- *	void add_interrupt_randomness(int irq, int irq_flags);
+ *	void add_interrupt_randomness(int irq);
  * 	void add_disk_randomness(struct gendisk *disk);
  *
  * add_device_randomness() is for adding data to the random pool that
@@ -1242,7 +1242,7 @@ static __u32 get_reg(struct fast_pool *f, struct pt_r=
egs *regs)
 	return *ptr;
 }
=20
-void add_interrupt_randomness(int irq, int irq_flags)
+void add_interrupt_randomness(int irq)
 {
 	struct entropy_store	*r;
 	struct fast_pool	*fast_pool =3D this_cpu_ptr(&irq_randomness);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 392c1ac4f8193..7ae04ccb10438 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1381,7 +1381,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
=20
-	add_interrupt_randomness(vmbus_interrupt, 0);
+	add_interrupt_randomness(vmbus_interrupt);
 }
=20
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
diff --git a/include/linux/random.h b/include/linux/random.h
index f45b8be3e3c4e..c45b2693e51fb 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -35,7 +35,7 @@ static inline void add_latent_entropy(void) {}
=20
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entr=
opy;
+extern void add_interrupt_randomness(int irq) __latent_entropy;
=20
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 27182003b879c..68c76c3caaf55 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -197,7 +197,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *de=
sc)
=20
 	retval =3D __handle_irq_event_percpu(desc, &flags);
=20
-	add_interrupt_randomness(desc->irq_data.irq, flags);
+	add_interrupt_randomness(desc->irq_data.irq);
=20
 	if (!irq_settings_no_debug(desc))
 		note_interrupt(desc, retval);
--=20
2.34.1

