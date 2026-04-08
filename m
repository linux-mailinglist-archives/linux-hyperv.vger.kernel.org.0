Return-Path: <linux-hyperv+bounces-10069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNBdN8ux1WlF8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10069-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:39:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3C3B5FD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB16830666A8
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201436C9CD;
	Wed,  8 Apr 2026 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o+f6ibhx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFA35E959;
	Wed,  8 Apr 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612230; cv=none; b=DUqGSF7IlhB7ISB0z2jfJjRWvrqeDmqEOpgBCIF7Ew6Z724qbYFqvk6feUEqtmVatl7O/YND/NH8NOfpFHrcml0harr6U4M6DlmJzoXpm/wv1NAqqwMg9ABTlNxYneYl8XXFQa1aywr3gS8gNCARMxm1VdZcn5orUBMNZXXzro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612230; c=relaxed/simple;
	bh=Qa47xpsTwc0NoOrDL+Xc0AOo5MDDI34B1r1aXQhRz5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX5H9S0Bxm+LqJNYwUwXAxoTYkelvE0HTyKUVp+AL2qucIae/GCzLZwwy3vxeYiUDpgOBiFQ2wdmqojlgVGkeuoBT1s80GUXE4Jw1tlhzBoV6X/1v950jpSoHn8E05s19egAL/qsv375GwmIjli0LOIctZAMU0+w35Z6HxYMPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o+f6ibhx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 7F6AF20B6F1B; Tue,  7 Apr 2026 18:37:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F6AF20B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775612229;
	bh=tB4BZhw0Vkrh5XhzS7hac2vx15vGtVKUShHe3x1I80o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+f6ibhxPrqSK7TKU1UTbef35g+K06I2J0M95ZzyLkWs6viSCQqUb6VN9cFgiBpVs
	 uo3xwL/HOwGDgCLuXHDhEF/wd+OkqCNlChF5QCznoTIwpOyR/K/QQn7zsXTBESW+te
	 1CLtgZO9QE49kdf2VXEzhbn5evZrGYhbFyF9VAEU=
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
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v3 6/6] mshv: unmap debugfs stats pages on kexec
Date: Tue,  7 Apr 2026 18:36:43 -0700
Message-ID: <20260408013645.286723-7-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10069-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47D3C3B5FD3
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
 drivers/hv/mshv_debugfs.c | 7 ++++++-
 drivers/hv/mshv_synic.c   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
index 418b6dc8f3c2..3c3e02237ae9 100644
--- a/drivers/hv/mshv_debugfs.c
+++ b/drivers/hv/mshv_debugfs.c
@@ -674,8 +674,10 @@ int __init mshv_debugfs_init(void)
 
 	mshv_debugfs = debugfs_create_dir("mshv", NULL);
 	if (IS_ERR(mshv_debugfs)) {
+		err = PTR_ERR(mshv_debugfs);
+		mshv_debugfs = NULL;
 		pr_err("%s: failed to create debugfs directory\n", __func__);
-		return PTR_ERR(mshv_debugfs);
+		return err;
 	}
 
 	if (hv_root_partition()) {
@@ -710,6 +712,9 @@ int __init mshv_debugfs_init(void)
 
 void mshv_debugfs_exit(void)
 {
+	if (!mshv_debugfs)
+		return;
+
 	mshv_debugfs_parent_partition_remove();
 
 	if (hv_root_partition()) {
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 8fe673c876fd..ed025f90003f 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -719,6 +719,7 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
 static int mshv_synic_reboot_notify(struct notifier_block *nb,
 			      unsigned long code, void *unused)
 {
+	mshv_debugfs_exit();
 	cpuhp_remove_state(synic_cpuhp_online);
 	return 0;
 }
-- 
2.43.0


