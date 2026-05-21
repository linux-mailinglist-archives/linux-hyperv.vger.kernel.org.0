Return-Path: <linux-hyperv+bounces-11135-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGNrHUhKD2qPIwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11135-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:09:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366A5AAD0E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B598303C4FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2077349CD1;
	Thu, 21 May 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="T+KQkXlm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147E13AA2F;
	Thu, 21 May 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382229; cv=pass; b=pCuNVuto39LgNulLIfp+hvjryh5+ypPe7p86vhSPTm/mcpJDP9KGi13xIIfDjEHuIWN85uwHzxAFb7OJODVcNqMCm6Yr+TY1ysrmJrQbBBVzJZTd//qeOmS82pS3R4fZ37E0hsH6MK7UF7GSmMBKi1oZEOPiKJBQJXclAuVw6Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382229; c=relaxed/simple;
	bh=XKGxHUdfW85nhnRs3FyUuuFjLFSjPd0vYblBn8PJUzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyGpTwckDuk/RXbKfTsyaRC4/aw2Hf8U/PWYFPeb98AS31+jXfLq0fAN8SkwZQBPo7PZFPfhuQ+V1hnElm6MXT6zZCCT8I2Fclk+LG5I0lniSD/4yR6AOq+cPObsh+3pmjyvqTc0rPKDHqtTDSSrx6AkWJxBx04oZsitkTCxKYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=T+KQkXlm; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1779382219; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b1+SUSEK45YXS/UtfhvnnmM/9j/ieB4XGqtzU9zkLDAwEAgSash2iwqLIEGWI4yWYMP3rltCnBxFMoi7w8yzJLMv1BUXbY2rZkGVldLi3aOkVd0/EfQM8WD7+S9x/7CxYSGXt9AyxU6YETSLEPVStt26i496+8oAvY6GHa5Cni8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779382219; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=cm9lkD2R8BGuEquskWBfiyKxqPlpBqJIzXvJYMuZ9AQ=; 
	b=oBjhrqtnjGnyUOp5nscq44atjwsaDrw5U5xQWqj/bxaIxR44CSjMwnpm7F2fQBfzJIf9c0ZEO0tJFYLoDXjc39jMM19/krRcX+i1JlyODdO9h1bn8vmQ6Ls0vRx3sigKNGE/w3w9IrohrN+lECQFQVNimF6v6pO/UqwRV58jb4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779382219;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=cm9lkD2R8BGuEquskWBfiyKxqPlpBqJIzXvJYMuZ9AQ=;
	b=T+KQkXlm9hg+AFJsp2/Pz09DEdsNGuBS9pb4LGVocPDEqTD0KemB1a5zShaD536b
	hoZhvZCLfR4yRpa0fcqm2BJMkn4RUhKpAFlin/aMII5Vab0RLvkNQHD+KeJzTnMzIPd
	Ftif+rLsCL008KpCQwf80yJtZMxc5dCQR6rPYEGE=
Received: by mx.zohomail.com with SMTPS id 1779382215477748.2620470282186;
	Thu, 21 May 2026 09:50:15 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	jloeser@linux.microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	hamzamahfooz@linux.microsoft.com
Subject: [PATCH 1/1] mshv: Add conditional VMBus dependency
Date: Thu, 21 May 2026 09:49:21 -0700
Message-Id: <20260521164921.1995-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112271c1a5cd93e737c82df1ed3df0000747d119c0fc19aac4be19fb427ff165cf8530d39c9075cf735:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External
X-Spamd-Result: default: False [6.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:dkim];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[zohomail.com,reject];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-11135-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[zohomail.com:s=zm2022];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:replyto,outlook.com:email,arndb.de:email]
X-Rspamd-Queue-Id: 5366A5AAD0E
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Michael Kelley <mhklinux@outlook.com>

When the VMBus driver is not part of the kernel (CONFIG_HYPERV_VMBUS=n),
the MSHV root driver fails to link:

ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!

Fix this while meeting these requirements:
* It must be possible to include the MSHV root driver without the
  VMBus driver. In such case, the MSHV root driver can be built-in
  to the kernel image, or it can be built as a separate module.
* If both the MSHV root driver and the VMBus driver are present, the
  MSHV root driver and VMBus driver can both be built-in, or they can
  both be separate modules. Or the MSHV root driver can be a module
  while the VMBus driver can be built-in, but the reverse is
  disallowed. Regardless of the build choices, the VMBus driver must
  be loaded before the MSHV driver in order for the SynIC to be
  managed properly (see comments in the MSHV SynIC code).

The fix has two parts:
* Add a Kconfig entry for MSHV_ROOT to depend on HYPERV_VMBUS if
  HYPERV_VMBUS is present. The entry disallows MSHV_ROOT being
  built-in when HYPERV_VMBUS is a module, but without requiring that
  HYPERV_VMBUS be built.
* Add #ifdefs around MSHV SynIC calls to hv_vmbus_exists(). When
  the VMBus driver is present, these calls establish a module
  dependency to ensure that the VMBus driver loads first when both
  are built as modules. But if the VMBus driver is not present,
  the behavior is as if hv_vmbus_exists() returned "false", and
  there is no module dependency.

Existing code ensures that the VMBus driver loads first if it is
built-in. The VMBus driver uses subsys_initcall(), which is
initcall level 4. The MSHV root driver uses module_init(), which
becomes device_init() when built-in, and device_init() is
initcall level 6.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel.org/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/Kconfig      |  1 +
 drivers/hv/mshv_synic.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2d0b3fcb0ff8..aa11bcefddf2 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -74,6 +74,7 @@ config MSHV_ROOT
 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
 	# no particular order, making it impossible to reassemble larger pages
 	depends on PAGE_SIZE_4KB
+	depends on HYPERV_VMBUS if HYPERV_VMBUS
 	select EVENTFD
 	select VIRT_XFER_TO_GUEST_WORK
 	select HMM_MIRROR
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 88170ce6b83f..3f72a3dd232d 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -463,11 +463,15 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 			&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
 			&spages->synic_event_ring_page;
+	bool vmbus_active = false;
+
 	/*
 	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
 	 * See hv_hyp_synic_enable_regs() for that initialization.
 	 */
-	bool vmbus_active = hv_vmbus_exists();
+#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
+	vmbus_active = hv_vmbus_exists();
+#endif
 
 	/*
 	 * Map the SYNIC message page. When VMBus is not active the
@@ -587,8 +591,12 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 		&spages->synic_event_flags_page;
 	struct hv_synic_event_ring_page **event_ring_page =
 		&spages->synic_event_ring_page;
+	bool vmbus_active = false;
+
 	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
-	bool vmbus_active = hv_vmbus_exists();
+#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
+	vmbus_active = hv_vmbus_exists();
+#endif
 
 	/* Disable the interrupt */
 	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
-- 
2.25.1


