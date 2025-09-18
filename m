Return-Path: <linux-hyperv+bounces-6618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC065B38F8B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 02:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238D1C241BF
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 00:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AC246761;
	Thu, 28 Aug 2025 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYoZOaTP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB722422A
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Aug 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339335; cv=none; b=bTFI6ks3U4hDR/Kq5nkrkisJ+OrBPNJFBcund8Au/q/UPUNX11bueYolWLatf8+R9Fru7wXwcPyyWUgGK9uIxLdST4Il8fs1FmtCdduF3GffIqTKHEZNpOf2Rh2EBkHTqkohkOwKlvH4cojMyiTjJkt72LGmWYuNyKtlVNB8Tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339335; c=relaxed/simple;
	bh=HB2czoPRXRoML34y9sGK0CPNDZK1NSst82B/XrgzCeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InNu5y4VUdYHN3e88nmpaMVn04gmLuSF9URQYNdnpHFKN91r9PYPqNvuxD0eQt2A3/hodpT3YP+dMFZrRgFv+8jycBpayoFS2jGB8EMOmqtPJvOxhzSD3MPmELASzCkKBxAhO4P8WmQSMzBrBJCsjWF4KAJnTPFV3HkWgj4DaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYoZOaTP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3274f7e6c1fso353931a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339333; x=1756944133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EmsaxLywmqXJrqAtwLwAP27sFBwlzqDgNEuWnDn/370=;
        b=cYoZOaTPFuAf+Db7HaxfsruIOBXoup/dWieeEWTsQqupSNoghDppsp+pHzUfq57ILL
         XaOVdawezy8HHtO/pKjrtDZfZZ2IfkcSivHuSU2jArq1I5yGA7TtE3abZpT+UcNaYUPr
         KteClzJ0UwKpHPAEsLAkMSFk5tqMFQCMMpZwTZ72g88almOPeep3Y9/xOoFPezW7nV5g
         xQvodxlfPsoCT3c8EaM3ahJKWmiFCXX8nl6ojOOnL1LC+qU+7XZFmF9Zw7dkAsux+lpk
         n2hfUZeckTa8Rdcs/ZL5oCMbfiB1ZjygX2lW/1alBGVyWdEPjYu/PmWvvpTrtOe2H/Z1
         eEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339333; x=1756944133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmsaxLywmqXJrqAtwLwAP27sFBwlzqDgNEuWnDn/370=;
        b=BIH62VXfYEc+ywrlJSwQtFYTUzDB/qThAZSSaQfx54QPaxbPCEQ7hsIPSG6JB1asdt
         +VvL3aOq1Qp5xtKPUqxBQtZOp7tIYrIAm/yM1rUPMy4T/kfP8zGib+5S0AhZSWSLyZjZ
         7tWWnztd68a/UkaKWzExDzOzQunSOQGN9DxmS1fBXILf6Ia4aw5Ud1XmkyFpUDZjHFIG
         kS5pv1wWv9obW4thKKA9hBC8nSTXd3+e7PyoR75P9+nD6e/wXRGGyCTwOzjaJ7O7VYqa
         dl+Jdw7uqNEAwzFeCtS8DMbD3I7c3FX0YYYDyWbtZg246Li6TO0qmnMyvjY7fmyP0vXG
         XLXA==
X-Forwarded-Encrypted: i=1; AJvYcCXTm2YijVKYV+oiDnAQl19nwQcZHpaDfg6nqJ4saywvX3JI0/2d/mgIlVbn0Mnx45kcW9jDYR+esQ5o7os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJGw+v3HxmeGqFXTbrREnyGJ5Um7W9nPic4h0FXD7cS//unt5
	Smko9ivim9zGaTZhkAW+seJFVdo0vTovIToZhbbvb0Z2Lj/V0ySvxBEks75DKNcIJP6v5htr7yI
	wbHUA3A==
X-Google-Smtp-Source: AGHT+IHWkrv7kVZHVzSto7MjJE9ImCnU6mvGeqto5tWqGBVv3p+HjVdYjEAK6cb7aWSN7qrvwO4+vOKCqys=
X-Received: from pjur11.prod.google.com ([2002:a17:90a:d40b:b0:325:9404:7ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2785:b0:31f:9114:ead8
 with SMTP id 98e67ed59e1d1-32515e2d5a0mr28901913a91.6.1756339332928; Wed, 27
 Aug 2025 17:02:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:55 -0700
In-Reply-To: <20250828000156.23389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-7-seanjc@google.com>
Subject: [PATCH v2 6/7] Drivers: hv: Use common "entry virt" APIs to do work
 in root before running guest
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
(re)entering guest mode, now that the virt APIs don't have a superfluous
dependency on KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/Kconfig          |  1 +
 drivers/hv/mshv_root_main.c | 32 ++++++--------------------------
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2e8df09db599..894037afcbf9 100644
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
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 0d849f09160a..7c83f656e071 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -8,6 +8,7 @@
  * Authors: Microsoft Linux virtualization team
  */
 
+#include <linux/entry-virt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -481,29 +482,6 @@ mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
 	return 0;
 }
 
-static int mshv_pre_guest_mode_work(struct mshv_vp *vp)
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
-		ret = mshv_do_pre_guest_mode_work(th_flags);
-
-		if (ret)
-			return ret;
-
-		th_flags = read_thread_flags();
-	}
-
-	return 0;
-}
-
 /* Must be called with interrupts enabled */
 static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 {
@@ -524,9 +502,11 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 		u32 flags = 0;
 		struct hv_output_dispatch_vp output;
 
-		ret = mshv_pre_guest_mode_work(vp);
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
2.51.0.268.g9569e192d0-goog


