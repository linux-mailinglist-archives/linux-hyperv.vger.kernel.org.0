Return-Path: <linux-hyperv+bounces-4002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDCDA3E7D0
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 23:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E64417CEE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 22:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D12641E3;
	Thu, 20 Feb 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mYkAQnZZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503021C5D67;
	Thu, 20 Feb 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091996; cv=none; b=mrBV5qsjAPDUd22/ZCjIDXPC9XvCEleJIRD4B6m6CRzFeOhJU21yGzOeSNFRBYqv7EdQAGXQxr8XLm4GP0th2Bo/XaHqIyhDoKFaxzO73iWcrROEiOuG5f0VodhK0RyIISo3MkuytgE8wMIo1ZqIcamJHnOu82TfLAoUxaAIlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091996; c=relaxed/simple;
	bh=9hWIgKmuLTrHjMYIsySqi8UfGFFpNhE9057KHcZqlO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRs/p/ReCc/eblqs/BCHtycNaPi+QDbP/BG+SAdMjSt1Ywo3lTMhyELM3KobctxUGlzdwRh7Z343+flPfW5VT6UREj99JJfMRYXdxLtaUh6TqYxFOIkn3Mh1krzC2u1sg0qA3fyg2xzDIRYg/B8rdcT4u7ML82PQw9Wwll97E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mYkAQnZZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.corp.microsoft.com (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9B0D203EC1E;
	Thu, 20 Feb 2025 14:53:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9B0D203EC1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740091994;
	bh=QPvpHWc6P2LYPk70og1QDBHr0W2xXNBlEljmWChKKV0=;
	h=From:To:Cc:Subject:Date:From;
	b=mYkAQnZZueh56EKC5CwZ+ERx0efV0WUIMLtyQd1N4MbzFrs3k5u8zJUoPpoWWRJL5
	 5Ylh/1JT/7DqgdGRBd82QxWHPVwWpf9u6ZnxsEjcrEs6A2knVMObpk7QLb7ho4mBs4
	 7KcSsEn2gvfNVn4X7PBdjlDjHJeDwMidZXv4atZI=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Baoquan He <bhe@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH RFC] panic: call panic handlers before panic_other_cpus_shutdown()
Date: Thu, 20 Feb 2025 17:53:00 -0500
Message-ID: <20250220225302.195282-1-hamzamahfooz@linux.microsoft.com>
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
 kernel/panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index fbc59b3b64d0..9712a46dfe27 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -372,8 +372,6 @@ void panic(const char *fmt, ...)
 	if (!_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
-
 	printk_legacy_allow_panic_sync();
 
 	/*
@@ -382,6 +380,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
+
 	panic_print_sys_info(false);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
-- 
2.47.1


