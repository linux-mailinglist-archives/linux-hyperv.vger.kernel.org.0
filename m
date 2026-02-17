Return-Path: <linux-hyperv+bounces-8869-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CwIJkazlGlbGgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8869-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 19:28:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F224E14F209
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 19:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34EEB3021E70
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5736F41C;
	Tue, 17 Feb 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="a96ICpz4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64832E12D;
	Tue, 17 Feb 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352643; cv=pass; b=Gao85ACooj9C6BB8Rezrxcp6F3wnkrDm7Mqhb3PSV/pVkd0GlSy8xwtZlaQI8ldGfVrPE6JR7v8jpOGEEKtzeIQiwi8RXU+kHhZPz5AHfdQQ3SHNJ/6CnTnuuiHRziow1/wTq0finyFaAgs0WnS+ufdezTPR3hyk3j7siW16bPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352643; c=relaxed/simple;
	bh=X78ccbi4OmwcUVGngpHLQ/zK0ELOvNhj7644sNblSUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ossn3ue2G6iFkZZjOjjYvEetxb6l0EOag6VFT+2uDmoFFOrQCW+oQQQcYR7OAtkIi6eyxQ1WPYNIBZra7C7paVl7Fr/cPgdVTVLNamX4CrbIN9Jsj7FNnPnxTTSbStvwaIfZM9IRgUUQlLV5ul1l0V8aCZXDO5QvypEMK5DWj3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=a96ICpz4; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771352624; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WjuzFw+PXrNUmSxsL2pcyWyyYuQrFGTIENy2fxTeW++Z2yc+TPwweU0M3TvECGqYW97ql7GiMSR0xclAuY7V6447jYJY9MytUooYZ4KUAu5IUOz9yR1BqcEUIXnrScoT+01L84taEm++deKzsLeG2Sm31TfyLG+XjuonbqFmkUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771352624; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=secGQ8gJ+A/aEZorjaD129GrmUJMAQLRoILQUsk1s34=; 
	b=bKnf2gemc3jdXyQ+ot/MrmQ/fKBFrejkBsIUgEv7z44UTZ5AVVd/Nt7UHEKTZckFw1lReKiD8ms99tXK30a2P8WP1SyDu8kY6jgaWsjLOODh0gemgPhYerxyY6brreK3FUFxsO21+e2JABsgKLAMqorIuu2ERwBCvnNuYibka/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771352624;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=secGQ8gJ+A/aEZorjaD129GrmUJMAQLRoILQUsk1s34=;
	b=a96ICpz45/EPLzCwtsjQJGSQeywaIvJs1+vm5euokPV0k+5IBJ8i0Y41w1nxozwj
	2o+NEcwhTZgCHoQUlaFTIF48qy23jTYSMt6k6PAG6REcR+T1bR+n3zf9aPtXvNYZ2Yl
	IvP23iG6xsXXZJtiNsHlpKZKOaEKRPGjwpof53WM=
Received: by mx.zohomail.com with SMTPS id 1771352621999530.8202478046807;
	Tue, 17 Feb 2026 10:23:41 -0800 (PST)
From: Michael Kelley <mhklkml@zohomail.com>
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	ryasuoka@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus unload on panic
Date: Tue, 17 Feb 2026 10:23:34 -0800
Message-Id: <20260217182335.265585-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ccb303be702fc9b91d3953f30000e29f6a2f9b0bf7f5bad0ef5b2e8081a2669eea31ad3ebd845e:zu08011227eb7b9ae6314e7f1f0b2a639800000b19db97a9b3666c59faac2d54943373ed5f06961ee1a3990b:rf0801122679a09cfd55e7bbdf618a9a6a00002ace3421f4f745b2d350401f57001777dd36ccb57310860b:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8869-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.com:mid,zohomail.com:dkim,outlook.com:replyto,outlook.com:email]
X-Rspamd-Queue-Id: F224E14F209
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

Currently, VMBus code initiates a VMBus unload in the panic path so
that if a kdump kernel is loaded, it can start fresh in setting up its
own VMBus connection. However, a driver for the VMBus virtual frame
buffer may need to flush dirty portions of the frame buffer back to
the Hyper-V host so that panic information is visible in the graphics
console. To support such flushing, provide exported functions for the
frame buffer driver to specify that the VMBus unload should not be
done by the VMBus driver, and to initiate the VMBus unload itself.
Together these allow a frame buffer driver to delay the VMBus unload
until after it has completed the flush.

Ideally, the VMBus driver could use its own panic-path callback to do
the unload after all frame buffer drivers have finished. But DRM frame
buffer drivers use the kmsg dump callback, and there are no callbacks
after that in the panic path. Hence this somewhat messy approach to
properly sequencing the frame buffer flush and the VMBus unload.

Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2: None

 drivers/hv/channel_mgmt.c |  1 +
 drivers/hv/hyperv_vmbus.h |  1 -
 drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
 include/linux/hyperv.h    |  3 +++
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 74fed2c073d4..5de83676dbad 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -944,6 +944,7 @@ void vmbus_initiate_unload(bool crash)
 	else
 		vmbus_wait_for_unload();
 }
+EXPORT_SYMBOL_GPL(vmbus_initiate_unload);
 
 static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 				      struct vmbus_channel_offer_channel *offer)
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index cdbc5f5c3215..5d3944fc93ae 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -440,7 +440,6 @@ void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
 void hv_vss_onchannelcallback(void *context);
-void vmbus_initiate_unload(bool crash);
 
 static inline void hv_poll_channel(struct vmbus_channel *channel,
 				   void (*cb)(void *))
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6785ad63a9cb..97dfa529d250 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -69,19 +69,29 @@ bool vmbus_is_confidential(void)
 }
 EXPORT_SYMBOL_GPL(vmbus_is_confidential);
 
+static bool skip_vmbus_unload;
+
+/*
+ * Allow a VMBus framebuffer driver to specify that in the case of a panic,
+ * it will do the VMbus unload operation once it has flushed any dirty
+ * portions of the framebuffer to the Hyper-V host.
+ */
+void vmbus_set_skip_unload(bool skip)
+{
+	skip_vmbus_unload = skip;
+}
+EXPORT_SYMBOL_GPL(vmbus_set_skip_unload);
+
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
- *
- * Notice an intrincate relation of this notifier with Hyper-V
- * framebuffer panic notifier exists - we need vmbus connection alive
- * there in order to succeed, so we need to order both with each other
- * [see hvfb_on_panic()] - this is done using notifiers' priorities.
  */
 static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
-	vmbus_initiate_unload(true);
+	if (!skip_vmbus_unload)
+		vmbus_initiate_unload(true);
+
 	return NOTIFY_DONE;
 }
 static struct notifier_block hyperv_panic_vmbus_unload_block = {
@@ -2848,7 +2858,8 @@ static void hv_crash_handler(struct pt_regs *regs)
 {
 	int cpu;
 
-	vmbus_initiate_unload(true);
+	if (!skip_vmbus_unload)
+		vmbus_initiate_unload(true);
 	/*
 	 * In crash handler we can't schedule synic cleanup for all CPUs,
 	 * doing the cleanup for current CPU only. This should be sufficient
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..b0502a336eb3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1334,6 +1334,9 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			bool fb_overlap_ok);
 void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 
+void vmbus_initiate_unload(bool crash);
+void vmbus_set_skip_unload(bool skip);
+
 /*
  * GUID definitions of various offer types - services offered to the guest.
  */
-- 
2.25.1


