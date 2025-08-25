Return-Path: <linux-hyperv+bounces-6591-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09F8B34B7C
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B48C18865C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5353093BD;
	Mon, 25 Aug 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqoAProS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CF30498E
	for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152397; cv=none; b=VmWBrDRWjRWDo70zRgzNathw9JjmewCNj+yKZP1+lYZcZxEkMDvK2Jb+80ytiFvOWsydnaott+55/nSlNxTUE3GyTZGQkBfy1pdXmkwMXURj9H/47PYB3yHSBuhIv70bt6mAEg4jwmuXx63d2E+yCbdX5hl7na0KsHeu1Xa8Utw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152397; c=relaxed/simple;
	bh=3CyWxc3bBWcKOng0lDUJyf2wCvHLahNPzrrtR5W4C3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V/IHv1IHiJStkP2S+q/zZ8zRRsydC+9HuYq5UneyrjcU9Vm9j1SfIUfDhB/j2364tqvUW1hCpp9cjisjDtU7s7jcioHRGIUhbWzuve8Qnqo5mvIGSnCT2F4WlBA3x4SR5ZjUUZ0ePtG++u+NR3Kmz9SCujTCp/U/3KA0a6zs0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqoAProS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso59565115ad.2
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756152394; x=1756757194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CT7JgTEeo8ssIUb6BIDGd5TM5agUhLYUjQZKEJ9GRpQ=;
        b=rqoAProSjLzJcNYSQ0Jvt+HVN9pMiePGmyD1VXKO6VTSY4eSKoTlOrb8AH4Ar5CqS5
         b0Nvc/fYVkOSgREHh3S+Ky7XFR2rNguABL/lrBOOogGx4BrZd3/6HEEKHdmt13blM/sO
         bMCC80oTywFsTHIUNL3pjKdW/W7SvFAletZZQLN2tHl6pBD4TWqYsS+6f+C4JgSBrIpH
         T3atW9Ly7tE3ofqTlpntiWw6RJGiLBWVjNsr947+kmVlcRkTDjCEmdFrSdXHEoQlLIVf
         0aShBlOOxCwRsgWoorQiSR+/+xiTV7f3L5oxMuS1BYcl3Lt9cKAE+Bw491cDnSSVuaiu
         eUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152394; x=1756757194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CT7JgTEeo8ssIUb6BIDGd5TM5agUhLYUjQZKEJ9GRpQ=;
        b=RH3U1FW0NJ7Y6YUtMteFjHchOuWQcaefoS1F2OTXR+Wq3kBa/zxiSwwwyxdGn1LQa1
         hw5A94atQVEhWnKQrhlm0WhtKRoyR7ja/lqY7Vfg7mgPVowXKl0A3RN/ldvFrOivID1M
         t2tZmzvuSOK7qUxEPEWK50ukD1j8XIgcSYNJpTLpKIpk6deGtmUuzzfFZ8q9o+FtputL
         K5aW8c471AbTwjuKv/n5b0/p4eanWt17Zqen/qPlWOyzibBufSF5sFjIDD5RocmbSX3l
         QfZrgZXBDYPdQxlI1Cj70IEhBDe9N148aYcM7q/E0VTeWgwWMdsU7rBd8wSrHpHmyHKm
         4CAg==
X-Forwarded-Encrypted: i=1; AJvYcCV/STPnTASIH7t9fUJllL/CwSm9oUk4G/NgBSif0rJNAEsWgUpMEfbSpa3lEPPxlLe4FiaICI0ndI+mi0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgmOuzG/cnLSl2c2wc8r2QP+jyW6C28iJ6ddLJgnfn1wi3D5Y
	ns6FyuiuS7nDeOlbpy44fUOmGkoBen8JsCqJ9fkZciQEndOX8fA/ObCZTS/bp4J/C9N/xyGznam
	cKWNXeQ==
X-Google-Smtp-Source: AGHT+IHfBbVUXQztG4xcJ+8aXPPjjnJpBA+jqNiJZvuMravmup3swJ9oylnciy13R3aKiPcwGzmYXXd0xTE=
X-Received: from pjvb15.prod.google.com ([2002:a17:90a:d88f:b0:311:c197:70a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f611:b0:246:60d4:8708
 with SMTP id d9443c01a7336-24660d4883amr156063605ad.49.1756152394181; Mon, 25
 Aug 2025 13:06:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 13:06:22 -0700
In-Reply-To: <20250825200622.3759571-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825200622.3759571-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825200622.3759571-6-seanjc@google.com>
Subject: [PATCH 5/5] Drivers: hv: Use common "entry virt" APIs to do work
 before running guest
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
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the kernel's common "entry virt" APIs to handle pending work prior to
(re)entering guest mode, now that the virt APIs don't have a superfluous
dependency on KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/Kconfig          |  1 +
 drivers/hv/mshv.h           |  2 --
 drivers/hv/mshv_common.c    | 45 -------------------------------------
 drivers/hv/mshv_root_main.c |  9 +++++---
 4 files changed, 7 insertions(+), 50 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 57623ca7f350..cdb210cd3710 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -66,6 +66,7 @@ config MSHV_ROOT
 	# no particular order, making it impossible to reassemble larger pages
 	depends on PAGE_SIZE_4KB
 	select EVENTFD
+	select VIRT_XFER_TO_GUEST_WORK
 	default n
 	help
 	  Select this option to enable support for booting and running as root
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index db3aa3831c43..d4813df92b9c 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -25,6 +25,4 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 int hv_call_get_partition_property(u64 partition_id, u64 property_code,
 				   u64 *property_value);
 
-int mshv_do_pre_guest_mode_work(void);
-
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index b953b5e21110..aa2be51979fd 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -138,48 +138,3 @@ int hv_call_get_partition_property(u64 partition_id,
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
-static int __mshv_do_pre_guest_mode_work(ulong th_flags)
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
-
-int mshv_do_pre_guest_mode_work(void)
-{
-	const ulong work_flags = _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING |
-				 _TIF_NEED_RESCHED  | _TIF_NEED_RESCHED_LAZY |
-				 _TIF_NOTIFY_RESUME;
-	ulong th_flags;
-
-	th_flags = read_thread_flags();
-	while (th_flags & work_flags) {
-		int ret;
-
-		/* nb: following will call schedule */
-		ret = __mshv_do_pre_guest_mode_work(th_flags);
-		if (ret)
-			return ret;
-
-		th_flags = read_thread_flags();
-	}
-
-	return 0;
-
-}
-EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6f677fb93af0..387491ca16d6 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -8,6 +8,7 @@
  * Authors: Microsoft Linux virtualization team
  */
 
+#include <linux/entry-virt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -507,9 +508,11 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 		u32 flags = 0;
 		struct hv_output_dispatch_vp output;
 
-		ret = mshv_do_pre_guest_mode_work();
-		if (ret)
-			break;
+		if (__xfer_to_guest_mode_work_pending()) {
+			ret = xfer_to_guest_mode_handle_work();
+			if (ret)
+				break;
+		}
 
 		if (vp->run.flags.intercept_suspend)
 			flags |= HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND;
-- 
2.51.0.261.g7ce5a0a67e-goog


