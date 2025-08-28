Return-Path: <linux-hyperv+bounces-6619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCEBB38F8E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 02:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F88981AAD
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 00:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E879258EE0;
	Thu, 28 Aug 2025 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3ILK07k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEE244664
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Aug 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339337; cv=none; b=Eu5DqjaqRt0KekIJw7DxFtSd+Emxdc6AdLpAX8lg5fpLvOIHJhxKo+7KTy4PCC9g8AzvQ+W+DpghNQNWud5i3nOn4S4jUcJXKqlrI9a8WLAHV/yK+LR/nw8OOPTPdxKiKJdoc5ll5usGD3l9faO23wdKrctvBAJxP+o5VrIqYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339337; c=relaxed/simple;
	bh=5KZra7rrb6EshYnRt06iajnZTBGSSVrTrCSYe32dt9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9hu+Vcy9GFKXKXK/4UevXBk068oHE5IEQD4REE4ipTPFIkkBRtN5mVdFd/zmjm75z9aUFShj5AWDwo48+h0yYUJb+nSKcOcgRqbNsulM77+rS6eLQ30WkjXgkBnYUIYhwub5yW/cSGIcQ7NEZxEHimucgfFwqZqyWZWmTq2BjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3ILK07k; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso368379a91.3
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 17:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339335; x=1756944135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qS5zxATrMXESBFPKwTqytXa2jxoDaW3HrytCSPyurss=;
        b=P3ILK07kHqpUGuivkSLsoI+MFv54KeHD0qtH79NPU/KqIIn8aXu3po2ImTA6Zbi1rb
         E5fBA7B2UekDDNvUsAKexzToVzRJc7Mw5dg7uHLZwb62LaaH+ax04wKyjta2qvvu3S+h
         kTOk1iAlOQBWuwZhpmkRB+iXKBRmnXgrckSG/m3GzzzExftf50JP43JiZxW6f235Lo7V
         fFCHf9fbjIGrlALSh3sn42twHZWzxgWNcnuQqOMarurbLQfJXVDcqoaiP3Wyv10FIbtY
         4WAE16o5571YGlB8Lz65SnxkmdGx0ApLw47O36szCXI96jYaIvBsgiiEaF4hhKpQRkP3
         /LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339335; x=1756944135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS5zxATrMXESBFPKwTqytXa2jxoDaW3HrytCSPyurss=;
        b=e7uBOGqje+WB9DtBe+a44jj9xxGhnkgu4BXqXCrwrmQ61Si9YWEZy9Hqv54VIR9nS+
         Tp3yx9MTEdfTP9GWYlnMs0FZeES/8Cf3h+epMEIS9EW8BMy2UDwiERAy/t0aT3vkei7p
         RCqElFxGthjksEt0Yn0oJEvYSSAjGydYeV0f1L5mJUpuzMYeUD8NbM4o2j9zz1YLUhbM
         izqocd/0h7Xlx1ZP0QXXoyJjxOTppSUv5ACJKXmlJXyz6tMSRqsHDil4RPNeY9ux04sU
         +7afvCoNUXsbgpaha72N/gLOjr5oHilWAeRDPcGiZL8gu2lhz/wcUh+CpHgWn7ScgeS5
         8IIg==
X-Forwarded-Encrypted: i=1; AJvYcCXVwW5MPY9zBP8fP3D4QzALpXslI0xAz1wBrB4TMVPQVN6ksEcxUjG01+Z6ng3CwtgFFHy4ZIIoTSyqldw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqJ0OHcSQPKr642rQ2EWrBVTzK2/bM+kaQxnK+BPHCzxB7T0m
	hhsmn0sFeJFX11MECqcpccjyT5dcQl7ZZQHyhH/XhnDEe2dB3VA3X0/T7PvnL7gxJgzluuelgnb
	jZ8oXTw==
X-Google-Smtp-Source: AGHT+IHTwHRJ1LtJUNLrZJovplfjTJdtHnbpa9Rw0OlaHYLIVyGS/gJ8LisaniBrYJHJcn/KzpZqw55zABU=
X-Received: from pjbsc11.prod.google.com ([2002:a17:90b:510b:b0:321:c36d:1b8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3941:b0:327:b01c:4fd4
 with SMTP id 98e67ed59e1d1-327b01c52bcmr306189a91.2.1756339334767; Wed, 27
 Aug 2025 17:02:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:56 -0700
In-Reply-To: <20250828000156.23389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-8-seanjc@google.com>
Subject: [PATCH v2 7/7] Drivers: hv: Use "entry virt" APIs to do work before
 returning to lower VTL
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Use the kernel's common "entry virt" APIs to handle pending work prior to
returning to a lower VTL.  Drop the now-defunct common MSHV helper for
doing work as the VTL driver was the last user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/Kconfig         |  1 +
 drivers/hv/mshv.h          |  2 --
 drivers/hv/mshv_common.c   | 22 ----------------------
 drivers/hv/mshv_vtl_main.c | 11 +++--------
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 894037afcbf9..b00b2b3fe3db 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -85,6 +85,7 @@ config MSHV_VTL
 	# Therefore, do not attempt to access or modify MTRRs here.
 	depends on !MTRR
 	select CPUMASK_OFFSTACK
+	select VIRT_XFER_TO_GUEST_WORK
 	default n
 	help
 	  Select this option to enable Hyper-V VTL driver support.
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 0340a67acd0a..d4813df92b9c 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -25,6 +25,4 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 int hv_call_get_partition_property(u64 partition_id, u64 property_code,
 				   u64 *property_value);
 
-int mshv_do_pre_guest_mode_work(ulong th_flags);
-
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index eb3df3e296bb..aa2be51979fd 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -138,25 +138,3 @@ int hv_call_get_partition_property(u64 partition_id,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
-
-/*
- * Handle any pre-processing before going into the guest mode on this cpu, most
- * notably call schedule(). Must be invoked with both preemption and
- * interrupts enabled.
- *
- * Returns: 0 on success, -errno on error.
- */
-int mshv_do_pre_guest_mode_work(ulong th_flags)
-{
-	if (th_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-		return -EINTR;
-
-	if (th_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-		schedule();
-
-	if (th_flags & _TIF_NOTIFY_RESUME)
-		resume_user_mode_work(NULL);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 4ca13c54c0a0..1eabed16aab9 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -8,6 +8,7 @@
  *   Naman Jain <namjain@linux.microsoft.com>
  */
 
+#include <linux/entry-virt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/miscdevice.h>
@@ -727,22 +728,16 @@ static int mshv_vtl_ioctl_return_to_lower_vtl(void)
 {
 	preempt_disable();
 	for (;;) {
-		const unsigned long VTL0_WORK = _TIF_SIGPENDING | _TIF_NEED_RESCHED |
-						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL |
-						_TIF_NEED_RESCHED_LAZY;
-		unsigned long ti_work;
 		unsigned long irq_flags;
 		struct hv_vp_assist_page *hvp;
 		int ret;
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
-		if (unlikely(ti_work & VTL0_WORK)) {
+		if (__xfer_to_guest_mode_work_pending()) {
 			preempt_enable();
-			ret = mshv_do_pre_guest_mode_work(ti_work);
+			ret = xfer_to_guest_mode_handle_work();
 			if (ret)
 				return ret;
 			preempt_disable();
-			continue;
 		}
 
 		local_irq_save(irq_flags);
-- 
2.51.0.268.g9569e192d0-goog


