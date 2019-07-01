Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8684416C7
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2019 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406712AbfFKVUI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jun 2019 17:20:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34594 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407020AbfFKVUI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jun 2019 17:20:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26so22223702edt.1
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Jun 2019 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OOJyWbB6/jxUd7+KAEy96qdC4Tdsl/f96tHzMaVcB4=;
        b=jyXIkF1GdcmUnLu0AjQVG+Udjq0UcLRwKiUZCFdPn8a+eUUs0JzwnCONzTAOgGvuuL
         8qywm8p9GaPge4mxScd7qXROT/CTuLJQpFl2FOylF96lRmgQ4fQvRcuYuCInAT5gHpWh
         Anuw3mQQ0ML9bICJ8UdTd7HL3HN9oMf9ogRugDvI1U/pGKPwFPIZr5xwo9aKz6tSL9V4
         PNu9kyl72rjbyjy1b8MTUB2fHoUgRpKJq1MVudCAG3SC8hfdFVVx/gVKqooXi1vcxQLG
         BMq7V6uYNvrRn6rQT5vUSD2LQfSuqy7EbRgy3wUz9ateaSAcjBUsdixYhK0zQNNmM++7
         H68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OOJyWbB6/jxUd7+KAEy96qdC4Tdsl/f96tHzMaVcB4=;
        b=rUVwFS/lhRw9Lbz8WlNG9NWXhmVX3x9on0VEyUkj4HG3ZOlLiy9BecB8ELmylbwvvd
         5cINzzebhjI2D08phOZRzNEPUZ0K52MNbC3gAkphm7ct/Tp4bcehXWkdwtcyEN8pBlf6
         Iifs3QAeM8Q6WSJ9cM43CRtYAYysVejCZx1T79SMMS5XX9ISoPydmPJnFEuvxQS+aQLm
         2ZQ64nVKmDOoKcgoqevg2VFFqn59WtuHkKO0lN8kTlJHMrBIVz26R5CRNkV6j7x8kRU3
         /UX2YceBUdq6Vjx0C3FZ9UC+Jk/C0ZEPCLNZdmbWHkmJ+MBf40Hq2gDwYSuOsJEUxndH
         K/cg==
X-Gm-Message-State: APjAAAW2vn3U3Wpr0SjTqp2ZtvInWvll2ELlNoybsuqiEI4zsoig8zLB
        fsm/1vwkvPVJTDYfuF11jGGuwQ==
X-Google-Smtp-Source: APXvYqy8UkurlAlIz6eWbNQVfj0pLtyKFJ1RdwsS4Mhclx5Ug3s5dTGx4YcObvRBnw363mK1Ak9kYA==
X-Received: by 2002:a50:f385:: with SMTP id g5mr2541498edm.14.1560288005996;
        Tue, 11 Jun 2019 14:20:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a15sm1967030ejr.4.2019.06.11.14.20.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:20:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
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
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/hyperv: Disable preemption while setting reenlightenment vector
Date:   Tue, 11 Jun 2019 22:20:03 +0100
Message-Id: <20190611212003.26382-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

KVM support may be compiled as dynamic module, which triggers the
following splat on modprobe:

 KVM: vmx: using Hyper-V Enlightened VMCS
 BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/466 caller is debug_smp_processor_id+0x17/0x19
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

The easiest solution seems to be disabling preemption while setting up
reenlightment MSRs. While at it, fix hv_cpu_*() callbacks.

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
 arch/x86/hyperv/hv_init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 1608050e9df9..0bdd79ecbff8 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -91,7 +91,7 @@ EXPORT_SYMBOL_GPL(hv_max_vp_index);
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
 	void **input_arg;
 	struct page *pg;
 
@@ -103,7 +103,7 @@ static int hv_cpu_init(unsigned int cpu)
 
 	hv_get_vp_index(msr_vp_index);
 
-	hv_vp_index[smp_processor_id()] = msr_vp_index;
+	hv_vp_index[cpu] = msr_vp_index;
 
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
@@ -182,7 +182,6 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	struct hv_reenlightenment_control re_ctrl = {
 		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
 		.enabled = 1,
-		.target_vp = hv_vp_index[smp_processor_id()]
 	};
 	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
 
@@ -196,7 +195,11 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	/* Make sure callback is registered before we write to MSRs */
 	wmb();
 
+	preempt_disable();
+	re_ctrl.target_vp = hv_vp_index[smp_processor_id()];
 	wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
+	preempt_enable();
+
 	wrmsrl(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
 }
 EXPORT_SYMBOL_GPL(set_hv_tscchange_cb);
-- 
2.22.0

