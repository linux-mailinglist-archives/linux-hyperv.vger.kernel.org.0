Return-Path: <linux-hyperv+bounces-4020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5B5A40209
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 22:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24D13BB5CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB08253B7A;
	Fri, 21 Feb 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZdegYFwv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCA1BC09A;
	Fri, 21 Feb 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173495; cv=none; b=TSBp5uR1U9GZCsXl6Qyy7d9f7jxS/o8pVd6Qhimp0XSiXj4auxAOnDgLpj83vh1rDT8QptpROquBsX9wW5xOCw3UuptN10dRJnqgVwJ88gxICZBKV+Zho1gsGbmYCq4SMmnm/kjxQ5077IQeJHOVFBpicMjPZuXjsYyvZB7gD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173495; c=relaxed/simple;
	bh=Y/uiyb0GT6mRH7A6SFFogb/RXA7QNWZ3JtaLaoRy6xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOuAGfyerdnXmbNMIX8hmw8EJkeQyeLt9wInsEeQONN6uqVDwj4ktNHxQuoUemG1Y1z212/VzKJN+9LlTwNy9ymqnZYKsGDSWekuZDH9Ttp5916+m7bU+hs4mF5NN9OrneO9BMdgJib+ZffqWQjm0/FXJrr6QyGGj3mXGt8GoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZdegYFwv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id A199A2069419;
	Fri, 21 Feb 2025 13:31:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A199A2069419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740173493;
	bh=Q59l4qt1+RTSqlc2FJqfXDTpEldHLx9ZIhB535cZxYY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZdegYFwvcTUGUwAfnlHupQpE5hD/3GEVNQQ16J+NggtbQTRz3mJTIVCmWySY6RtZa
	 4XWUp70c+sC7f7ik8QIdFkwHpRN2YxtorzKC8c7M12W7mH1mywql3oaok0TCx38riZ
	 rCkoyEjzwVq8JFg/CJ2MDWmbzYuzcAaqI68ACqbc=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v2] panic: call panic handlers before panic_other_cpus_shutdown()
Date: Fri, 21 Feb 2025 16:30:52 -0500
Message-ID: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since, the panic handlers may require certain cpus to be online to panic
gracefully, we should call them before turning off SMP. Without this
re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
crash_smp_send_stop() before the vmbus channel can be deconstructed.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: keep printk_legacy_allow_panic_sync() after
    panic_other_cpus_shutdown().
---
 kernel/panic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index fbc59b3b64d0..433cf651e213 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
 	if (!_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
-
-	printk_legacy_allow_panic_sync();
-
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
+
+	printk_legacy_allow_panic_sync();
+
 	panic_print_sys_info(false);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
-- 
2.47.1


