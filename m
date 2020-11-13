Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B743D2B19C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMLOh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 06:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgKMLGJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 06:06:09 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026FDC061A47;
        Fri, 13 Nov 2020 03:05:23 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id e17so8118634ili.5;
        Fri, 13 Nov 2020 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5G16OMow2JB9kURMNUxc0v/8xFwWUF3aZE0lmTUl3s=;
        b=tGDJUfwEE7Yy2xiFOTlpelEP/mXaRqrYCg8kEBroxrB6QHLhiTjkXg75+5ir2IHxWB
         GTRFn/5TFG7w40jkoIuhds8uw1dQbkxORwdpJHxhfRc6Ov/M68kA5Al3nCqbhUAKws3H
         ZYAy67kztMYhvyA0q0/0PhB0ulWSZnl7aIhj/DJwRt+HT2Y0EVKSHCHRL2gXqiNz8i1Y
         PAi8hlravGvUOWfSI6nHL7SWWqZXL6DDPlHobTFi53B3Du+clxmKSa+miLP4dqJi71HJ
         0V9NA8tbQeoM0XUsZ3uPO3G6lSLV7Kgj6ob8HtcUCmIU9VYFa5F7mVABGrNh97/XRxPu
         6f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5G16OMow2JB9kURMNUxc0v/8xFwWUF3aZE0lmTUl3s=;
        b=txZFq377wRyRnBckT+MyyiAf2REb/0GAFi84o58Hu+gzuQ2MXOwbXJb69q7oFsX2A+
         4nH97AvkmGGavRGDQrkK+Xvq1eygiPXzKGQEK3RJWwnNnTvyd2Py2sypjOvqIBPVdJ1W
         EVV89LN7OGiHTSYRCkPYtuNLJIKl72/OSkaTw0KBD0BzRM3MNj/CKknZlBxD2C39kpzD
         um5QBnuJuuwgDrgWNtv7q5zc++62FB7ViCT1qiYm3pqRN2M17oP3qVB0ZVOhJXHw7Fsh
         xEISBZwy0mdL7K3KMBVv+88YsQIp8C/x2ys6C8hasra9gBzFGfRhlbllU7FpON7nwcGe
         nCxg==
X-Gm-Message-State: AOAM531/I4kOWnwnJRWa/NzlG3za9oEngC/XXoHqURNeohj6u6kfTtlC
        aTmP0ZEghOQ4xP6bBqf7V4c=
X-Google-Smtp-Source: ABdhPJxsF/yhI/BjekUZSQ7dOiQBNwvxLyi/lC7tx52WfHtixxfKT7YrSlV+ZBb8oZxhC/mHT3xsuQ==
X-Received: by 2002:a92:b653:: with SMTP id s80mr1526161ili.73.1605265522291;
        Fri, 13 Nov 2020 03:05:22 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k20sm4888609ilr.28.2020.11.13.03.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:05:21 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2C72E27C0054;
        Fri, 13 Nov 2020 06:05:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 13 Nov 2020 06:05:20 -0500
X-ME-Sender: <xms:b2iuX0R_Vq57JgxGaZclWcQ4VB7hlGEMUAX1kYvRofvmrMx4L7uCLw>
    <xme:b2iuXxxk0YMrtZsr9HcZAKEG8jKttkpjvEy1qycxQSGkOYrB_AC6t-SWl56Vd4Mtl
    J3lR3Nl1GvjoNjJhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:b2iuXx0gSclahg0GE35r5Um7JT9bOFy3pXQfPuixgJ5UhSA8m6-qEw>
    <xmx:b2iuX4AmnGyL29OTnhski8BIeTLKmlV4Rl27h2wCmw01i-Rw0WjiIQ>
    <xmx:b2iuX9goV0MOahAJR8aQ2Bk8FLPH6gjMJdc9k-l6KxJpz7mbbJH3eg>
    <xmx:cGiuX4rJVzL2j404WJB3EXUEz7Ott4mDcfra9p01S5ZfYCZ0xj9aCUdb1sY>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0498C3280059;
        Fri, 13 Nov 2020 06:05:18 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [RFC] lockdep: Put graph lock/unlock under lock_recursion protection
Date:   Fri, 13 Nov 2020 19:05:03 +0800
Message-Id: <20201113110512.1056501-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A warning was hit when running xfstests/generic/068 in a Hyper-V guest:

[...] ------------[ cut here ]------------
[...] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
[...] WARNING: CPU: 2 PID: 1350 at kernel/locking/lockdep.c:5280 check_flags.part.0+0x165/0x170
[...] ...
[...] Workqueue: events pwq_unbound_release_workfn
[...] RIP: 0010:check_flags.part.0+0x165/0x170
[...] ...
[...] Call Trace:
[...]  lock_is_held_type+0x72/0x150
[...]  ? lock_acquire+0x16e/0x4a0
[...]  rcu_read_lock_sched_held+0x3f/0x80
[...]  __send_ipi_one+0x14d/0x1b0
[...]  hv_send_ipi+0x12/0x30
[...]  __pv_queued_spin_unlock_slowpath+0xd1/0x110
[...]  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11/0x20
[...]  .slowpath+0x9/0xe
[...]  lockdep_unregister_key+0x128/0x180
[...]  pwq_unbound_release_workfn+0xbb/0xf0
[...]  process_one_work+0x227/0x5c0
[...]  worker_thread+0x55/0x3c0
[...]  ? process_one_work+0x5c0/0x5c0
[...]  kthread+0x153/0x170
[...]  ? __kthread_bind_mask+0x60/0x60
[...]  ret_from_fork+0x1f/0x30

The cause of the problem is we have call chain lockdep_unregister_key()
-> <irq disabled by raw_local_irq_save()> lockdep_unlock() ->
arch_spin_unlock() -> __pv_queued_spin_unlock_slowpath() -> pv_kick() ->
__send_ipi_one() -> trace_hyperv_send_ipi_one().

Although this particular warning is triggered because Hyper-V has a
trace point in ipi sending, but in general arch_spin_unlock() may call
another function having a trace point in it, so put the arch_spin_lock()
and arch_spin_unlock() after lock_recursion protection to fix this
problem and avoid similiar problems.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b71ad8d9f1c9..b98e44f88c6a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -108,19 +108,21 @@ static inline void lockdep_lock(void)
 {
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+	__this_cpu_inc(lockdep_recursion);
 	arch_spin_lock(&__lock);
 	__owner = current;
-	__this_cpu_inc(lockdep_recursion);
 }
 
 static inline void lockdep_unlock(void)
 {
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
 	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
 		return;
 
-	__this_cpu_dec(lockdep_recursion);
 	__owner = NULL;
 	arch_spin_unlock(&__lock);
+	__this_cpu_dec(lockdep_recursion);
 }
 
 static inline bool lockdep_assert_locked(void)
-- 
2.29.2

