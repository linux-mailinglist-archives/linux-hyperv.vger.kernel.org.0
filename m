Return-Path: <linux-hyperv+bounces-10065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO9HDGix1WlF8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10065-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:37:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDAE3B5F78
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765A7301BF5F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF535F616;
	Wed,  8 Apr 2026 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dlhHp83C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785FB345752;
	Wed,  8 Apr 2026 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612226; cv=none; b=f47buZuc/U7qoS7hpJJ0YswQYM/lLlICMSRgJjdy+Jk7+bzidfPAIuucKKSU0vRnjX1pt1RNljvcR+AgVowOiDeMip1Fo7e4Z5AtYL+5UvGP5s4CE+YQ88chLFRxdNT0AMTwbh/OX45EjYapl9hXkHKpB8qL1O8PLY5BtFstakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612226; c=relaxed/simple;
	bh=D3+nTek4z+f2K6DxERB6jh7RqgMhOQ91+SvxspOvKjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLU1urpJw/+XsBacu+puBWkj26szeAUNMTwfagF2AC4gYpW48uynayZY7ByedmG56GwDty/C4g016G1QTK9t8DyhLV+86sOidjjBr6qt7rfw9a2swhbRHyaREsiZqsBSOxfXgzj8jLDLGrLmPlh4tC1jdcmh0WYq1oFMeuXZwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dlhHp83C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 6AF7120B6F0C; Tue,  7 Apr 2026 18:37:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF7120B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775612225;
	bh=yfCzaUkvJYM8O7R2xk5HIq2mTUM6YiYpv8qiLrcpMaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlhHp83COysq0cK0LeYRJnstD1riOaHdPSvGYDI3FJFpdQYj8cn3/eK9nglQnscKU
	 xoYp0e2kyck7F7cnqVT5aG9FMwxI3vxUSPh6MUdPlEqBu5+oi8GqODvAkheMEXKC9b
	 x2/C3KjMuzBA/M7hNogi97m69drPn0hbd0ID4ZDY=
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
Subject: [PATCH v3 2/6] x86/hyperv: move stimer cleanup to hv_machine_shutdown()
Date: Tue,  7 Apr 2026 18:36:39 -0700
Message-ID: <20260408013645.286723-3-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260408013645.286723-1-jloeser@linux.microsoft.com>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10065-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CDAE3B5F78
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
index a7dfc29d3470..e498b6b2ef19 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -237,8 +237,12 @@ void hv_remove_crash_handler(void)
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
index 5e7a6839c933..c5dfe9f3b206 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2891,7 +2891,6 @@ static struct platform_driver vmbus_platform_driver = {
 
 static void hv_kexec_handler(void)
 {
-	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
-- 
2.43.0


