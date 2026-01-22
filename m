Return-Path: <linux-hyperv+bounces-8455-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK4GHGsZcmnrbwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8455-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 13:34:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13D66B32
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7B5070C013
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFE41B367;
	Thu, 22 Jan 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K7CnPuvm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2LqcnjTA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K7CnPuvm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2LqcnjTA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9C421EF0
	for <linux-hyperv@vger.kernel.org>; Thu, 22 Jan 2026 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082151; cv=none; b=TBLBkK9LG13djN5mwP1C1kQbnGFQMaTSneCiP2Z4DTfhuog8isyaJ1oNqSX/EDDBSgTXGQOfHSu7eYB/7WG64I8jwTfGR/PPdb1RgAQDVRNHBlMMykDN1IC7OZbCy3EE5T97Znsc3paqKIW6o0WTk2eaWJR9Rk6+vPWPRFW+rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082151; c=relaxed/simple;
	bh=aXPlBfwgf3FSR/JYvZXNBUIGXw7rI/R3QSupQMV0UZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzP++pojEXhhK8UVUa2H6Qe3YBc6FFg+8qUkp5MjVxBAeM4f3uDGljg6D3YO2c8qBaMNoL/Md1Sa6Dv4LZk0ShC9Fesm7wEAfIdF9Huziq8nXbBooV1vOxgVuVq8y5hirhjRXvy3S+/Zq4cMRkIPQJ+Q10Aa3FLA7WGWjJNut8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K7CnPuvm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2LqcnjTA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K7CnPuvm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2LqcnjTA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCF8336F8;
	Thu, 22 Jan 2026 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769082146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J7HS/7fVODCxb+s+SaY/Cet3k6woYVVydqkfaMO/wwU=;
	b=K7CnPuvmXDpL/SziLBqMVs2/OcOD7stIQ2+obEZKCM1oHmKYIvuUlyD3J3Du596y0IQB31
	/selTGRa6AVjLgmG/xwb5jVdRqAkbixsRvBo2FMNOT0HHOaggUY83BYmhVGIglN8aYv8Sn
	8dxY8aEg8Q2vBl+psUBFIGOFPmf4bHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769082146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J7HS/7fVODCxb+s+SaY/Cet3k6woYVVydqkfaMO/wwU=;
	b=2LqcnjTAlFT7UPbiCtOa7tDSWSWodf4r+WVopcKMM1QUcIW6035UuOHLyXecJsHpxvuGrq
	v5tq816ifkAZj0DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K7CnPuvm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2LqcnjTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769082146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J7HS/7fVODCxb+s+SaY/Cet3k6woYVVydqkfaMO/wwU=;
	b=K7CnPuvmXDpL/SziLBqMVs2/OcOD7stIQ2+obEZKCM1oHmKYIvuUlyD3J3Du596y0IQB31
	/selTGRa6AVjLgmG/xwb5jVdRqAkbixsRvBo2FMNOT0HHOaggUY83BYmhVGIglN8aYv8Sn
	8dxY8aEg8Q2vBl+psUBFIGOFPmf4bHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769082146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J7HS/7fVODCxb+s+SaY/Cet3k6woYVVydqkfaMO/wwU=;
	b=2LqcnjTAlFT7UPbiCtOa7tDSWSWodf4r+WVopcKMM1QUcIW6035UuOHLyXecJsHpxvuGrq
	v5tq816ifkAZj0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0AD013533;
	Thu, 22 Jan 2026 11:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MoDKLyENcmmlWQAAD6G6ig
	(envelope-from <clopez@suse.de>); Thu, 22 Jan 2026 11:42:25 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: linux-hyperv@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mshv: clear eventfd counter on irqfd shutdown
Date: Thu, 22 Jan 2026 12:41:31 +0100
Message-ID: <20260122114130.92860-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8455-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clopez@suse.de,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: BC13D66B32
X-Rspamd-Action: no action

While unhooking from the irqfd waitqueue, clear the internal eventfd
counter by using eventfd_ctx_remove_wait_queue() instead of
remove_wait_queue(), preventing potential spurious interrupts. This
removes the need to store a pointer into the workqueue, as the eventfd
already keeps track of it.

This mimicks what other similar subsystems do on their equivalent paths
with their irqfds (KVM, Xen, ACRN support, etc).

Signed-off-by: Carlos López <clopez@suse.de>
---
 drivers/hv/mshv_eventfd.c | 5 ++---
 drivers/hv/mshv_eventfd.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index d93a18f09c76..4432063e963d 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -247,12 +247,13 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
 {
 	struct mshv_irqfd *irqfd =
 			container_of(work, struct mshv_irqfd, irqfd_shutdown);
+	u64 cnt;
 
 	/*
 	 * Synchronize with the wait-queue and unhook ourselves to prevent
 	 * further events.
 	 */
-	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
+	eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx, &irqfd->irqfd_wait, &cnt);
 
 	if (irqfd->irqfd_resampler) {
 		mshv_irqfd_resampler_shutdown(irqfd);
@@ -371,8 +372,6 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
 	struct mshv_irqfd *irqfd =
 			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
 
-	irqfd->irqfd_wqh = wqh;
-
 	/*
 	 * TODO: Ensure there isn't already an exclusive, priority waiter, e.g.
 	 * that the irqfd isn't already bound to another partition.  Only the
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
index 332e7670a344..464c6b81ab33 100644
--- a/drivers/hv/mshv_eventfd.h
+++ b/drivers/hv/mshv_eventfd.h
@@ -32,7 +32,6 @@ struct mshv_irqfd {
 	struct mshv_lapic_irq		     irqfd_lapic_irq;
 	struct hlist_node		     irqfd_hnode;
 	poll_table			     irqfd_polltbl;
-	wait_queue_head_t		    *irqfd_wqh;
 	wait_queue_entry_t		     irqfd_wait;
 	struct work_struct		     irqfd_shutdown;
 	struct mshv_irqfd_resampler	    *irqfd_resampler;

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.51.0


