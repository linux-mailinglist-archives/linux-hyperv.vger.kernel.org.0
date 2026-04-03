Return-Path: <linux-hyperv+bounces-9970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKUfBboP0GlQ2wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9970-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:06:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89B39781C
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FABA300B9F8
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705093D564D;
	Fri,  3 Apr 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ooPUfoBf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5553D4102;
	Fri,  3 Apr 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243181; cv=none; b=J9pFqGu66+A60vNT4mSWOk1oIEIBNxFC+rSBC3MeGtkCu8XvGXOiX5IPWlFkTvRsAS6XPZigmBx37RCBgxgtlYgSOuqGFHauBjoGskXcbOAaeqhRYth8Sz6ayLvKHYIt0O7HA/UCQkRM8TW+cgbla2i5iJ4zxHARmh20vV7ia3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243181; c=relaxed/simple;
	bh=TGgnAFzlIDIivrxTgxPOdYRWjFMaQLSOV3k1ZpfrgAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaBX9AUedhVWKmq97Gl6frFqnjbPg0SvOvezad+GGOzz9dmhKAg6oP7ifqU6ApsXU+pEyLAhY0/Vy0tQEwNRPNel62WPw6KYkfyxV32VTD90VtSMvtPj7Tuviefu7NgrjdSCrxP9SaXv2hrbMjVHyEuXuA72JeuYu16aZo0KXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ooPUfoBf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 25DD620B6F0C; Fri,  3 Apr 2026 12:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25DD620B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775243180;
	bh=oe8/Pqe4w3M//1TBoCPONOMHSy0PBbB0t+C6t5dQLKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooPUfoBf8oQCRKP9t9HHfupwRCMUHvaOL7HtM4MgrGi3ramxYKPMQk/iQM7Feb3rv
	 goeUxYijM+NqXzK3XAafEJyH1DHh3SY1ty23/FKKz8KLSPpEC25iUUbAZQHPNWvuCH
	 iQ5h9Y8hBRLZtmeJDXcafzAhxay2FOBsKi7nha40=
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
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Subject: [PATCH v2 2/6] x86/hyperv: move stimer cleanup to hv_machine_shutdown()
Date: Fri,  3 Apr 2026 12:06:08 -0700
Message-ID: <20260403190613.47026-3-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403190613.47026-1-jloeser@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9970-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA89B39781C
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


