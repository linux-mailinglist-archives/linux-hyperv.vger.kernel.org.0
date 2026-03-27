Return-Path: <linux-hyperv+bounces-9820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBorNPDoxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9820-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:30:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAAC34AFCD
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C48031E7EA7
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53763A0B31;
	Fri, 27 Mar 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uesr+RPz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA1D39EF12;
	Fri, 27 Mar 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642790; cv=none; b=bn826xsh5MMjQWG7GYT7rqzAsEQPJXZDjjEmyGk3owpAKR0ZcD2PNQAe0hRqk2sd7hwcg4X6urulT6gvCjabU8d6SEJPYDkZf8g6uELWA2pu4r48bCPuA3D8eprlOM1TtJAWodKPCTsxVPmVEhp1x9TsFBd93FUFU3J2z1qjUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642790; c=relaxed/simple;
	bh=eJFkaRo9CKhZlto6iDCuLzjnu9hkc3JVC3IjFHx3XJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNi67YtdlL5Oi0SlkvYrIWENxRMtQ6JypEDVhOzVBRC7kVjxoVoQSP/pTDipjtiFvGcxpt9XBWlgAqPvqZHxESso0Dg1nFquvR6T3xZqb0ghv3hcCL6ON1DIpScOd35sTVAbBSdpCVLjm7/8YqFU+fVZycU2AziaA/HgKyo28kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uesr+RPz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id AB74820B7135; Fri, 27 Mar 2026 13:19:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB74820B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642789;
	bh=dtJ8seWmbMqGCQ41xKmiIdEUtLNh0z2d7AxXL8JOv/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uesr+RPzzxWsPaVhwsg0gOb8TIvmzpSFiFCwxkwk1mEQL3yy9GtUb4EQcH6ln2XmL
	 CESk+Hz1cI6K9LtRAcEfr+AH8TZY9sqWLm2qG21grKU7LcaAKpkJNJf6bmEATWmxez
	 Kk2h8YUORX8cKaxF3MilozBjdvDU9XTEKE6gn2v0=
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
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH 6/6] mshv: unmap debugfs stats pages on kexec
Date: Fri, 27 Mar 2026 13:19:17 -0700
Message-ID: <20260327201920.2100427-7-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9820-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 7CAAC34AFCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On L1VH, debugfs stats pages are overlay pages: the kernel allocates
them and registers the GPAs with the hypervisor via
HVCALL_MAP_STATS_PAGE2. These overlay mappings persist in the
hypervisor across kexec. If the kexec'd kernel reuses those physical
pages, the hypervisor's overlay semantics cause a machine check
exception.

Fix this by calling mshv_debugfs_exit() from the reboot notifier,
which issues HVCALL_UNMAP_STATS_PAGE for each mapped stats page before
kexec. This releases the overlay bindings so the physical pages can be
safely reused. Guard mshv_debugfs_exit() against being called when
init failed.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_debugfs.c   | 7 ++++++-
 drivers/hv/mshv_root_main.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
index ebf2549eb44d..f9a4499cf8f3 100644
--- a/drivers/hv/mshv_debugfs.c
+++ b/drivers/hv/mshv_debugfs.c
@@ -676,8 +676,10 @@ int __init mshv_debugfs_init(void)
 
 	mshv_debugfs = debugfs_create_dir("mshv", NULL);
 	if (IS_ERR(mshv_debugfs)) {
+		err = PTR_ERR(mshv_debugfs);
+		mshv_debugfs = NULL;
 		pr_err("%s: failed to create debugfs directory\n", __func__);
-		return PTR_ERR(mshv_debugfs);
+		return err;
 	}
 
 	if (hv_root_partition()) {
@@ -712,6 +714,9 @@ int __init mshv_debugfs_init(void)
 
 void mshv_debugfs_exit(void)
 {
+	if (!mshv_debugfs)
+		return;
+
 	mshv_debugfs_parent_partition_remove();
 
 	if (hv_root_partition()) {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 281f530b68a9..7038fd830646 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2252,6 +2252,7 @@ root_scheduler_deinit(void)
 static int mshv_reboot_notify(struct notifier_block *nb,
 			      unsigned long code, void *unused)
 {
+	mshv_debugfs_exit();
 	cpuhp_remove_state(mshv_cpuhp_online);
 	return 0;
 }
-- 
2.43.0


