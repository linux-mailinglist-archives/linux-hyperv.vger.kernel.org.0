Return-Path: <linux-hyperv+bounces-6587-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECEB34B77
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D66417A0FE
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDE28C5D5;
	Mon, 25 Aug 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paRzXkPY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB436245021
	for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152390; cv=none; b=t5rhGFTiWcBcjS+ifAlPWj3uYokCkrI58jwSxr0hJsWTTWPf5VVGxnZ7M/aNrg4V34Hr7kQYWchkOkDNql0IPUcjIcp6nACvSuloUqEgrC6uRwDMn7c09SJs60uIKAJTnIelQs77/Zj0geKTAbUkF6CZjZnDREwu71l1jRDHLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152390; c=relaxed/simple;
	bh=aOaAMFU0lRUzQeN1F6iLwL6S3YUHwj3pFv409qQl9yQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pk+KkwxHBqAWvs/JbNp7qMG2JJPjZZodFPcqiwNC+69+3b4NnApJGsDkwgYWxGfK5W+AhOkNqfJFPiS2pkzIFv79rmVCOYyUV5rIIB+7els1m4yLh7y1GhuvJfFwLXQhHcrCPJ5xFFUOF8JX92Ij3NNXfKtI6eub6S/vH/Qyyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paRzXkPY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso61741305ad.1
        for <linux-hyperv@vger.kernel.org>; Mon, 25 Aug 2025 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756152387; x=1756757187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n6KAJgpe+g35DHpdkouiNXTkH/lGhIRNqTvdrNu3evo=;
        b=paRzXkPYY6C9gGx1xtvlFnhsaQhvZWvKcnW7AzKfSVqSynNxgDM8yGutVYQPcSZIqi
         6gw1Yuomw9vSmb7Zk1lN+IP7uiFDCG2oZuBv8uUzDxRN8Naf33a6LeWFNevpvUvSu9uc
         5rkslGWHL+o6Du9K1s5WKNnO/BHQi/ytiMXjAfGXdOeo4NZh8v0lw49iBPYwVL62Uu8W
         nxA+HmbVhfO9u9Dv6dpJDBZydZeTuflEsnS/6DkxGRgF1F4CtTxL1V+XGQRGrMsqg9D8
         ej2H9xd1wj74wxBJsPNq9uLa1kLwZLjDrDzdZRgpb4A9nf7X88gHm4e0rZ6CNWegY3qz
         qhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152387; x=1756757187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6KAJgpe+g35DHpdkouiNXTkH/lGhIRNqTvdrNu3evo=;
        b=PdCIr/HisSSfXQPOBtVzMD3v4/N7/PhO1rndYD+6GQtjVmoZ6Rf9htfCc7wvzCpRsb
         mtwz/fg71/1EPxWtBzQbnCqmgQZScoNNElhnCBT7dZHDuABvMdtCw9p/diPWH5d/NLYF
         KeHL/KnLMDcdlBfBpsIH5rGRkGTJFbP8QA8cRTGxKGycGAMJZGSg020I5NEjAl4oRzgK
         ztFrMWKs2km/OavaiKfAM4vPw+ifaTifCTukV9sYqx4l+iHOuSx1g3LfQWTSHSWRJW+f
         rku0nB1Ebr6u07gMaVuWGEN38MNDdFzD0AhGPLm12UbOGGlluCZeU3IBW6qYAhjBvBSh
         H0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfWfa/XVcqzlgjYjFzzssHoDqyTp3bYzO3IyhasKjmW34Z0JnAMknyzSY+bxbIsyDINbAnTSdkFMhzSoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkR5jnpcOBTHBt4oxelQbB7aYPimaWy+G4Lvcf+HkeET44HFoK
	NIxFykSGC1n9OoL3rI99BPr60R0oMmnOKzdNHcOPtt5IFj6c+xkFstddTY3BiFU1FwMpklBjAvB
	IxewEGg==
X-Google-Smtp-Source: AGHT+IF91dn1j6fIvX+uRWorld3If0wpZl5jf5hDJFPUly2WnQsNSAnJfoCi7L3EWOQImM7m2slTmOJmyMA=
X-Received: from pjbok14.prod.google.com ([2002:a17:90b:1d4e:b0:325:8fba:708c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4b:b0:246:76ed:e25d
 with SMTP id d9443c01a7336-24676edecf2mr117886095ad.50.1756152387296; Mon, 25
 Aug 2025 13:06:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 25 Aug 2025 13:06:18 -0700
In-Reply-To: <20250825200622.3759571-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825200622.3759571-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825200622.3759571-2-seanjc@google.com>
Subject: [PATCH 1/5] Drivers: hv: Move TIF pre-guest work handling fully into mshv_common.c
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

Move the root partition's handling of pending thread work fully into
mshv_common.c so that the "work pending" and "do work" code is co-located.
Splitting the flags-to-check logic makes the code unnnecessarily difficult
to maintain, e.g. it would be all too easy to add a check in "do work" but
not in "work pending", and vice versa.

Note, this adds an extra CALL+RET when no work is pending; that will be
remedied in the near feature by switching to common virtualization entry
APIs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/mshv.h           |  2 +-
 drivers/hv/mshv_common.c    | 24 +++++++++++++++++++++++-
 drivers/hv/mshv_root_main.c | 24 +-----------------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
index 0340a67acd0a..db3aa3831c43 100644
--- a/drivers/hv/mshv.h
+++ b/drivers/hv/mshv.h
@@ -25,6 +25,6 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 int hv_call_get_partition_property(u64 partition_id, u64 property_code,
 				   u64 *property_value);
 
-int mshv_do_pre_guest_mode_work(ulong th_flags);
+int mshv_do_pre_guest_mode_work(void);
 
 #endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 6f227a8a5af7..1acc47c4be0d 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -146,7 +146,7 @@ EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
  *
  * Returns: 0 on success, -errno on error.
  */
-int mshv_do_pre_guest_mode_work(ulong th_flags)
+static int __mshv_do_pre_guest_mode_work(ulong th_flags)
 {
 	if (th_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		return -EINTR;
@@ -159,4 +159,26 @@ int mshv_do_pre_guest_mode_work(ulong th_flags)
 
 	return 0;
 }
+
+int mshv_do_pre_guest_mode_work(void)
+{
+	const ulong work_flags = _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING |
+				 _TIF_NEED_RESCHED  | _TIF_NOTIFY_RESUME;
+	ulong th_flags;
+
+	th_flags = read_thread_flags();
+	while (th_flags & work_flags) {
+		int ret;
+
+		/* nb: following will call schedule */
+		ret = __mshv_do_pre_guest_mode_work(th_flags);
+		if (ret)
+			return ret;
+
+		th_flags = read_thread_flags();
+	}
+
+	return 0;
+
+}
 EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 72df774e410a..6f677fb93af0 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -487,28 +487,6 @@ mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
 	return 0;
 }
 
-static int mshv_pre_guest_mode_work(struct mshv_vp *vp)
-{
-	const ulong work_flags = _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING |
-				 _TIF_NEED_RESCHED  | _TIF_NOTIFY_RESUME;
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
@@ -529,7 +507,7 @@ static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
 		u32 flags = 0;
 		struct hv_output_dispatch_vp output;
 
-		ret = mshv_pre_guest_mode_work(vp);
+		ret = mshv_do_pre_guest_mode_work();
 		if (ret)
 			break;
 
-- 
2.51.0.261.g7ce5a0a67e-goog


