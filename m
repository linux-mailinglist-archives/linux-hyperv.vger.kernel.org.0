Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23954892A
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfFQQkA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 12:40:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQQkA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 12:40:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so10736516wrl.1
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Jun 2019 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbiPhpQVwadkxwWwxjXwvyYtMv62C8jLCWc43wCVGgA=;
        b=Nbt6c8XjsUO1WKmxXBx2rhdqfo6aRRO3XCDZCOYk/LJEdRiTStAP9V+2Ec4HPkNy3i
         dcb3fJA1iEDY1Fd5wZ5M3tsA+03Z4ouYS9uEqSbe+yz3IqqzhYkeXmAqDoRHoIc6C54c
         KZ2LZM30yJN8ph2G6nO9YtZ5oR605ysGYifEdWja6Tg5QTO+Aqy5cEys1HSHg4sXO4NE
         mZwXj5bT6p3ccyJ/thqe4QQ8BCzlSbVbMQpe9cv6j7zJH+B1GQt44guX2VDbGVN/Mo9i
         DPqOX0hhXvTGcieympMKVTr3d7GXt830jVu/UnRRcqcWanL+5d7zsN9ql7GdeWR0bIjP
         WGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QbiPhpQVwadkxwWwxjXwvyYtMv62C8jLCWc43wCVGgA=;
        b=P7sLh+uebdGufhccls3LT34dDctQIW0JhPIIYTitUseRP+FZYhZnRcBcV5zPOozF4v
         bunARvfLkuiLeMcbt4m4x8q7qh7V+3jKgh3BEqhTgL04dDlXAsdHIUThZfh5KELnK/XB
         K9ShoMrTqixN3WsEV+aRTPNj94gktTgI4a4HezQnLs05rJ7pmzKA31XJFFEzbpHVsNt0
         JcbpJNDv2Ag16S5iubbWcZ2lHE3H/1gbVdhxvOlzqO/Xz7w++gXUzV8pYIp8azpknvxb
         n9C1CsuKNI3UlwfhGRfEqbrO3kIlnvnfhml64NWvM7FQA8yW3TFwgJ7fn3DzViEhtnqc
         U0cA==
X-Gm-Message-State: APjAAAUPyJn/3ExoJfveXnq3NyINz8rOHsh+nf+kkmLIDhJ78gE3bq3h
        w95Dus+fKSKJ4BI8ZoEVI8OXxQ==
X-Google-Smtp-Source: APXvYqxWmprhSIQFrp6t1xWST1zp4m0M4IRmuT1yMzRfcK4ZLnwK4Kkm5/WSedVmpsHQ739OSSRy2Q==
X-Received: by 2002:a5d:6449:: with SMTP id d9mr21108302wrw.192.1560789597394;
        Mon, 17 Jun 2019 09:39:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y133sm20578382wmg.5.2019.06.17.09.39.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:39:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Prasanna Panchamukhi <panchamukhi@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Cathy Avery <cavery@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: [PATCHv2] x86/hyperv: Hold cpus_read_lock() on assigning reenlightenment vector
Date:   Mon, 17 Jun 2019 17:39:55 +0100
Message-Id: <20190617163955.25659-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

KVM support may be compiled as dynamic module, which triggers the
following splat on modprobe (under CONFIG_DEBUG_PREEMPT):

 KVM: vmx: using Hyper-V Enlightened VMCS
 BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/466
 caller is debug_smp_processor_id+0x17/0x19
 CPU: 0 PID: 466 Comm: modprobe Kdump: loaded Not tainted 4.19.43 #1
 Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090007  06/02/2017
 Call Trace:
  dump_stack+0x61/0x7e
  check_preemption_disabled+0xd4/0xe6
  debug_smp_processor_id+0x17/0x19
  set_hv_tscchange_cb+0x1b/0x89
  kvm_arch_init+0x14a/0x163 [kvm]
  kvm_init+0x30/0x259 [kvm]
  vmx_init+0xed/0x3db [kvm_intel]
  do_one_initcall+0x89/0x1bc
  do_init_module+0x5f/0x207
  load_module+0x1b34/0x209b
  __ia32_sys_init_module+0x17/0x19
  do_fast_syscall_32+0x121/0x1fa
  entry_SYSENTER_compat+0x7f/0x91

Hold cpus_read_lock() so that MSR will be written for an online CPU,
even if set_hv_tscchange_cb() gets being preempted.
While at it, cleanup smp_processor_id()'s in hv_cpu_init() and add a
lockdep assert into hv_cpu_die().

Fixes: 93286261de1b4 ("x86/hyperv: Reenlightenment notifications
support")

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Cathy Avery <cavery@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Mohammed Gamal <mmorsy@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

Cc: devel@linuxdriverproject.org
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org
Reported-by: Prasanna Panchamukhi <panchamukhi@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v1 link: lkml.kernel.org/r/20190611212003.26382-1-dima@arista.com

NOTE that I hadn't a chance to test v2 on hyperv machine so far,
ONLY BUILD TESTED. (In hope that the patch still makes sense and Kbuild
bot will report any issue).

 arch/x86/hyperv/hv_init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 1608050e9df9..ec7fd7d6c125 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,6 +20,7 @@
 #include <linux/clockchips.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 
 #ifdef CONFIG_HYPERV_TSCPAGE
@@ -91,7 +92,7 @@ EXPORT_SYMBOL_GPL(hv_max_vp_index);
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
 	void **input_arg;
 	struct page *pg;
 
@@ -103,7 +104,7 @@ static int hv_cpu_init(unsigned int cpu)
 
 	hv_get_vp_index(msr_vp_index);
 
-	hv_vp_index[smp_processor_id()] = msr_vp_index;
+	hv_vp_index[cpu] = msr_vp_index;
 
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
@@ -182,7 +183,6 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	struct hv_reenlightenment_control re_ctrl = {
 		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
 		.enabled = 1,
-		.target_vp = hv_vp_index[smp_processor_id()]
 	};
 	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
 
@@ -196,7 +196,16 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	/* Make sure callback is registered before we write to MSRs */
 	wmb();
 
+	/*
+	 * As reenlightenment vector is global, there is no difference which
+	 * CPU will register MSR, though it should be an online CPU.
+	 * hv_cpu_die() callback guarantees that on CPU teardown
+	 * another CPU will re-register MSR back.
+	 */
+	cpus_read_lock();
+	re_ctrl.target_vp = hv_vp_index[raw_smp_processor_id()];
 	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
+	cpus_read_unlock();
 	wrmsrl(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
 }
 EXPORT_SYMBOL_GPL(set_hv_tscchange_cb);
@@ -239,6 +248,7 @@ static int hv_cpu_die(unsigned int cpu)
 
 	rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	if (re_ctrl.target_vp == hv_vp_index[cpu]) {
+		lockdep_assert_cpus_held();
 		/* Reassign to some other online CPU */
 		new_cpu = cpumask_any_but(cpu_online_mask, cpu);
 
-- 
2.22.0

