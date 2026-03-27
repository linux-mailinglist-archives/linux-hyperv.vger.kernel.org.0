Return-Path: <linux-hyperv+bounces-9816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEMHABXrxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9816-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:39:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC134B1D8
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8B930E6436
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726439902D;
	Fri, 27 Mar 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TZNhmALc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70558396D07;
	Fri, 27 Mar 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642783; cv=none; b=EiOE0ZjMI02Up1mwGjqOw9tl8guwAx47LNQE0SBRH/xyZQp6VdS8HTHzFiQB0F5lOpvDuygE1Z7gVOVudjxzo3xmg9pQBBsT24OOL3bttkeOsR+Clvo1Z/jY3esE/+tjeljAfbk1XqVUKC6ltaOWCvSXrXriklG9ClUPLuL7GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642783; c=relaxed/simple;
	bh=TGgnAFzlIDIivrxTgxPOdYRWjFMaQLSOV3k1ZpfrgAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVvtsZvgGiDKC8Qj8yrLutB3yDkm0OgaLi2KOc4eqBF1WXPfs3SbhA4bvdeaAWc+UAmutOwWoerkvWc6nq4WWndyj0Fa5qO05XZgCpu7Nn8QOv5dGLmszSNU2ee275XVfCKqx9FvrDSZhKsxJPqZG7FvysTb8SRrtE8gfzxZqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TZNhmALc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 8BD3F20B7129; Fri, 27 Mar 2026 13:19:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BD3F20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642782;
	bh=oe8/Pqe4w3M//1TBoCPONOMHSy0PBbB0t+C6t5dQLKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZNhmALcDyG4DqfdeyDMw8r4bn7xnDgMtmXe3aYBnnHoeoZp/dQnmEiSpP/HoJ2UG
	 DXVHSDNuZlT2STu+babv6CQE4v8vAcViOkd9emMh4I/tCzIf/fJ5hrJMk3INE9JVih
	 9z8xzZUYm57M8BKw0ScGToR7EFbtQ0sjhwQwmIbg=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Subject: [PATCH 2/6] x86/hyperv: move stimer cleanup to hv_machine_shutdown()
Date: Fri, 27 Mar 2026 13:19:13 -0700
Message-ID: <20260327201920.2100427-3-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9816-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: EEEC134B1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move hv_stimer_global_cleanup() from vmbus's hv_kexec_handler() to
hv_machine_shutdown() in the platform code. This ensures stimer cleanup
happens before the vmbus unload, which is required for root partition
kexec to work correctly.

Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
 drivers/hv/vmbus_drv.c         | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 89a2eb8a0722..235087456bdf 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -235,8 +235,12 @@ void hv_remove_crash_handler(void)
 #ifdef CONFIG_KEXEC_CORE
 static void hv_machine_shutdown(void)
 {
-	if (kexec_in_progress && hv_kexec_handler)
-		hv_kexec_handler();
+	if (kexec_in_progress) {
+		hv_stimer_global_cleanup();
+
+		if (hv_kexec_handler)
+			hv_kexec_handler();
+	}
 
 	/*
 	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 301273d61892..5d1449f8c6ea 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2892,7 +2892,6 @@ static struct platform_driver vmbus_platform_driver = {
 
 static void hv_kexec_handler(void)
 {
-	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
-- 
2.43.0


