Return-Path: <linux-hyperv+bounces-4143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E590A48AC8
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 22:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B612188C7EE
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 21:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753B271824;
	Thu, 27 Feb 2025 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d+kvVWYu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76927181D;
	Thu, 27 Feb 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692852; cv=none; b=c7bNvG/OJmKWClctZ+GTWs7RrW0icTrHIJX/kelzjQPo8dIPOAYZPqdKdQlaN87b8lRLNAqVDqWepJoMUiVrhnv4wB47I383aqQF+5xA/mYcgNOoIB1Yd32r1nkKB/nGGB2eKXn/j0W3cxBfZsFuEz0G7PuBu8HJSoIc9EbZ9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692852; c=relaxed/simple;
	bh=H0sc0Dzoy3F2dNp0PaU0lxzNo4cuwBbWvkCnJDbwqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIN3MlOxGnhXCZPHkIC2efbM/3MffoS0BeQik+soMiFKszsFPTmgLjewDVBtXzxmrMy8Sdwiuj61CXC93VnME4Fik3A4G6aB4xZ6fJdPJKR/dS9LFf3h5c3VhHao3osazZfgXEEU+LU699cH0h4KxbvL0w5VATD5SN8QGBlE8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d+kvVWYu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2800A210EAC4;
	Thu, 27 Feb 2025 13:47:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2800A210EAC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740692850;
	bh=V+jj0mO8JyhApYoPayBDHN4fMJAhT0KBvP1icd3eeMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+kvVWYu2LDYS7bWYTjj8pFx1l2C3c+zT4wVBxA3dJFu4CIPjgiA7jkPe1XeCO93u
	 5X+Pdtogasp8BKWFLGKZijAYJprER5zqXn6pcpFi/WAq6O+BixXX1EP06F8Eel/M0W
	 tIt3R7My9wUrXQm4TsCX/OEaxl5z7E8rlD+VkrYQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 2/2] x86/hyperv: Add VTL mode callback for restarting the system
Date: Thu, 27 Feb 2025 13:47:28 -0800
Message-ID: <20250227214728.15672-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227214728.15672-1-romank@linux.microsoft.com>
References: <20250227214728.15672-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel runs as a firmware in the VTL mode, and the only way
to restart in the VTL mode on x86 is to triple fault. Thus, one
has to always supply "reboot=t" on the kernel command line in the
VTL mode, and missing that renders rebooting not working.

Define the machine restart callback to always use the triple
fault to provide the robust configuration by default.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4421b75ad9a9..582fe820e29c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -44,6 +44,15 @@ static void  __noreturn hv_vtl_emergency_restart(void)
 	}
 }
 
+/*
+ * The only way to restart in the VTL mode is to triple fault as the kernel runs
+ * as firmware.
+ */
+static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
+{
+	hv_vtl_emergency_restart();
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -258,6 +267,8 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 int __init hv_vtl_early_init(void)
 {
 	machine_ops.emergency_restart = hv_vtl_emergency_restart;
+	machine_ops.restart = hv_vtl_restart;
+
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
 	 * and here is the earliest it can be used.
-- 
2.43.0


