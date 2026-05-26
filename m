Return-Path: <linux-hyperv+bounces-11197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJlaJ1yxFWpxYAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11197-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:42:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3E5D7CF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677E03003E8E
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3583FAE08;
	Tue, 26 May 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="XjZAtOW0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE3BE156;
	Tue, 26 May 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804806; cv=pass; b=qyqc0Ui65oAkWeY4Ob7Dr3q398a0Er1GHjzu029Inrbuy9fAVQj0uMuRxUjvkNK7pFl68tIFY7oucG4aKUevDsQgz4qqE5o5H+Jp4IztQbv0kESEKqdxIf9iRr+m7cPTlhpbYcT9BBwstX7V0Fsz2tphDf8cz7+7/Oac8ETxWXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804806; c=relaxed/simple;
	bh=Sg5HFQ+6c0me1xR1i3ICG44h19Au3qCBspO6LbloZG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMR7y8qx5m1gNJSfOUI8oCdMTMCH7OkUZUd0Ik/mDe9K7jKtRLVveGPsnpvJrxqhQQgsPnvKUo1FtddDkKPlAr+KD3EBzcaj4qGs/YvWH0OzfoetjWOYl3BV1d7VMGejHWCJEEE5ImQLJ7M33hPBREqQomCvYAsOYvSihb8yE7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=XjZAtOW0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1779804795; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iz9/jN8Q4K8XLedi13LCBWlei8/oOgJca15e7VUCM/VNvYXN2+skJ3BXIvaYz8tqtTa2TzU2yD69lWh5r8AUCIOlQm8mPW0K6xgg8TMbWK9Cs1LhqIowPqayZT8eJK+MXK2GZUgd9zX422UJ2FFAnkuMJvjkK4afwwogHC/nYMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779804795; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=/WI/REGq2+DPFS3rMfaBEFu5yWsh1kHMtr9A64GzV44=; 
	b=VI6PrZFwaiJgGuDxLLCkpx8uslRLw/wTs8XuKE19p1Zl/S7w7ValuEce5xOQgyPcAYp2RttNef7QUFUrSJ1A1kCcw3payH1P6tr7ResyX2jfIz4fu5W9QRfF+kvlFHIN6xTEvGqvicP9kf4w9dObPXi2cFavbR4neOTwQGD/MwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779804795;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=/WI/REGq2+DPFS3rMfaBEFu5yWsh1kHMtr9A64GzV44=;
	b=XjZAtOW0JsxjOzT7A0dXUARloTb58STl5EZPjCDdgsmWFOvIfQooZeGrZSJ5uKZ/
	mq2xlmBmkvAWEFf3A2BsBS72aF6Qsl1878MrgqOD68LZ5V04H85jO06A3FaSC7XpgkX
	TqnCzk3V2bF5xi0D8jvZSfVS752fzSPjajUFYbY0=
Received: by mx.zohomail.com with SMTPS id 1779804794141532.659716772417;
	Tue, 26 May 2026 07:13:14 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mshv: Add conditional VMBus dependency
Date: Tue, 26 May 2026 07:13:04 -0700
Message-Id: <20260526141304.3924-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227ba939d4f58f01ca51200a84b00006f3733c4cfff1608e8ed7a32285a16c2a1b902e42fec993368:ZohoMail
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
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[zohomail.com,reject];
	TAGGED_FROM(0.00)[bounces-11197-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[zohomail.com:s=zm2022];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.222];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.com:mid,zohomail.com:dkim,outlook.com:replyto,outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:email]
X-Rspamd-Queue-Id: D7C3E5D7CF5
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
* Add a stub implementation of hv_vmbus_exists() for when the
  VMBus driver is not present so that the MSHV root driver has
  no module dependency on VMBus. When the VMBus driver *is*
  present, the module dependency ensures that the VMBus driver
  loads first when both are built as modules.

Existing code ensures that the VMBus driver loads first if it is
built-in. The VMBus driver uses subsys_initcall(), which is
initcall level 4. The MSHV root driver uses module_init(), which
becomes device_init() when built-in, and device_init() is
initcall level 6.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel.org/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>
---
Changes in v2:
* Instead of putting IS_ENABLED(CONFIG_HYPERV_VMBUS) around each of
  the two calls to hv_vmbus_exists() in mshv_synic.c, provide a stub
  for hv_vmbus_exists() when CONFIG_HYPERV_VMBUS is not set. The
  effect is the same as in v1, but the code is cleaner. [Jork Loeser]

Arnd: I've kept your Ack even though I changed how hv_vmbus_exists()
is stubbed out since the effect is the same. Let me know if
you have any concerns.

 drivers/hv/Kconfig     | 1 +
 include/linux/hyperv.h | 4 ++++
 2 files changed, 5 insertions(+)

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
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 41a3d82f0722..734b7ef98f4d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1304,7 +1304,11 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
 
 struct device *hv_get_vmbus_root_device(void);
 
+#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
 bool hv_vmbus_exists(void);
+#else
+static inline bool hv_vmbus_exists(void) { return false; }
+#endif
 
 struct hv_ring_buffer_debug_info {
 	u32 current_interrupt_mask;
-- 
2.25.1


