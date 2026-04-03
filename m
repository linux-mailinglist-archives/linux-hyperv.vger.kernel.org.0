Return-Path: <linux-hyperv+bounces-9958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBBD4l6z2mvwgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9958-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:30:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B6392187
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70BAB302231F
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00993793B5;
	Fri,  3 Apr 2026 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OJy6E+f2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10393373C16;
	Fri,  3 Apr 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204958; cv=none; b=KSKY943vn4HkOD3qtFZKLsveX01bO1IjFT72tZQXhuMUIDL++HxOa0Zl77nrafTPK16j1KcN8jItEubww910nT6N+bwUXObE6Xc7pmlzVQ3T/HLKoXplj3VmjYvthy/xTaaqlnySmSK1wqydHLZrknHnVCm+PfNJ8IgiRMTaJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204958; c=relaxed/simple;
	bh=ge8OjaMqEUvhHVvpza5+BFU338QJ2rUNJ+dj80xQupk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3aAjyGUBh6w+aWyHeLVJZvcbTjevXjgzCYmw+pM8g8BJZiGoruY2qx5jDeLqFEJJ0M8nRacps12nE6wI5jy1gKqi0Zb34SxldTJuuv3D1j8cZf7yKQTjZRcpoRUgGmejZ66HKtEMRT9Gim9pfXqlXLu6tJNSRsilEFiv7fWDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OJy6E+f2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775204954;
	bh=ge8OjaMqEUvhHVvpza5+BFU338QJ2rUNJ+dj80xQupk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OJy6E+f2EQ6oxaTxS2CvZnPkKoX39PaFkMNjyhOpovKTO3F5WEpBZ0zXLbSf+Q8k1
	 mODt9gMxvthk6bkkjKYK0RSEykrALWWDrrb/GRK0mRNMspiI9ZjRKRHA7xXEbOmRmg
	 6wifnVEYUVzHrKjWhQ8bDdkwrwjl+oYhylb0tvgY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Apr 2026 10:29:16 +0200
Subject: [PATCH v2 4/4] drivers: hv: mark channel attributes as const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-sysfs-const-hv-v2-4-8932ab8d41db@weissschuh.net>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
In-Reply-To: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775204954; l=7310;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ge8OjaMqEUvhHVvpza5+BFU338QJ2rUNJ+dj80xQupk=;
 b=N61JExPheYTzBlacNgzOypbLRvTbcVrEnFmA8/FZ2Aow9sX5J5e4y5isnJs7HjFlgWnouvOVI
 g2gaOStvxQFCImzlZb8uPRQYHnyFgNIQv5v6SrtDTbRQQfdH4IEsSVC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,weissschuh.net];
	TAGGED_FROM(0.00)[bounces-9958-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5A8B6392187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These attributes are never modified, mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ecce6b72a2a2..b33b85764c19 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1695,7 +1695,7 @@ static ssize_t out_mask_show(struct vmbus_channel *channel, char *buf)
 	mutex_unlock(&rbi->ring_buffer_mutex);
 	return ret;
 }
-static VMBUS_CHAN_ATTR_RO(out_mask);
+static const VMBUS_CHAN_ATTR_RO(out_mask);
 
 static ssize_t in_mask_show(struct vmbus_channel *channel, char *buf)
 {
@@ -1712,7 +1712,7 @@ static ssize_t in_mask_show(struct vmbus_channel *channel, char *buf)
 	mutex_unlock(&rbi->ring_buffer_mutex);
 	return ret;
 }
-static VMBUS_CHAN_ATTR_RO(in_mask);
+static const VMBUS_CHAN_ATTR_RO(in_mask);
 
 static ssize_t read_avail_show(struct vmbus_channel *channel, char *buf)
 {
@@ -1729,7 +1729,7 @@ static ssize_t read_avail_show(struct vmbus_channel *channel, char *buf)
 	mutex_unlock(&rbi->ring_buffer_mutex);
 	return ret;
 }
-static VMBUS_CHAN_ATTR_RO(read_avail);
+static const VMBUS_CHAN_ATTR_RO(read_avail);
 
 static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
 {
@@ -1746,7 +1746,7 @@ static ssize_t write_avail_show(struct vmbus_channel *channel, char *buf)
 	mutex_unlock(&rbi->ring_buffer_mutex);
 	return ret;
 }
-static VMBUS_CHAN_ATTR_RO(write_avail);
+static const VMBUS_CHAN_ATTR_RO(write_avail);
 
 static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
 {
@@ -1864,7 +1864,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 
 	return ret ?: count;
 }
-static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
+static const VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
 
 static ssize_t channel_pending_show(struct vmbus_channel *channel,
 				    char *buf)
@@ -1873,7 +1873,7 @@ static ssize_t channel_pending_show(struct vmbus_channel *channel,
 		       channel_pending(channel,
 				       vmbus_connection.monitor_pages[1]));
 }
-static VMBUS_CHAN_ATTR(pending, 0444, channel_pending_show, NULL);
+static const VMBUS_CHAN_ATTR(pending, 0444, channel_pending_show, NULL);
 
 static ssize_t channel_latency_show(struct vmbus_channel *channel,
 				    char *buf)
@@ -1882,19 +1882,19 @@ static ssize_t channel_latency_show(struct vmbus_channel *channel,
 		       channel_latency(channel,
 				       vmbus_connection.monitor_pages[1]));
 }
-static VMBUS_CHAN_ATTR(latency, 0444, channel_latency_show, NULL);
+static const VMBUS_CHAN_ATTR(latency, 0444, channel_latency_show, NULL);
 
 static ssize_t channel_interrupts_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->interrupts);
 }
-static VMBUS_CHAN_ATTR(interrupts, 0444, channel_interrupts_show, NULL);
+static const VMBUS_CHAN_ATTR(interrupts, 0444, channel_interrupts_show, NULL);
 
 static ssize_t channel_events_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->sig_events);
 }
-static VMBUS_CHAN_ATTR(events, 0444, channel_events_show, NULL);
+static const VMBUS_CHAN_ATTR(events, 0444, channel_events_show, NULL);
 
 static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
 					 char *buf)
@@ -1902,7 +1902,7 @@ static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
 	return sprintf(buf, "%llu\n",
 		       (unsigned long long)channel->intr_in_full);
 }
-static VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show, NULL);
+static const VMBUS_CHAN_ATTR(intr_in_full, 0444, channel_intr_in_full_show, NULL);
 
 static ssize_t channel_intr_out_empty_show(struct vmbus_channel *channel,
 					   char *buf)
@@ -1910,7 +1910,7 @@ static ssize_t channel_intr_out_empty_show(struct vmbus_channel *channel,
 	return sprintf(buf, "%llu\n",
 		       (unsigned long long)channel->intr_out_empty);
 }
-static VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show, NULL);
+static const VMBUS_CHAN_ATTR(intr_out_empty, 0444, channel_intr_out_empty_show, NULL);
 
 static ssize_t channel_out_full_first_show(struct vmbus_channel *channel,
 					   char *buf)
@@ -1918,7 +1918,7 @@ static ssize_t channel_out_full_first_show(struct vmbus_channel *channel,
 	return sprintf(buf, "%llu\n",
 		       (unsigned long long)channel->out_full_first);
 }
-static VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show, NULL);
+static const VMBUS_CHAN_ATTR(out_full_first, 0444, channel_out_full_first_show, NULL);
 
 static ssize_t channel_out_full_total_show(struct vmbus_channel *channel,
 					   char *buf)
@@ -1926,14 +1926,14 @@ static ssize_t channel_out_full_total_show(struct vmbus_channel *channel,
 	return sprintf(buf, "%llu\n",
 		       (unsigned long long)channel->out_full_total);
 }
-static VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show, NULL);
+static const VMBUS_CHAN_ATTR(out_full_total, 0444, channel_out_full_total_show, NULL);
 
 static ssize_t subchannel_monitor_id_show(struct vmbus_channel *channel,
 					  char *buf)
 {
 	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
 }
-static VMBUS_CHAN_ATTR(monitor_id, 0444, subchannel_monitor_id_show, NULL);
+static const VMBUS_CHAN_ATTR(monitor_id, 0444, subchannel_monitor_id_show, NULL);
 
 static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 				  char *buf)
@@ -1941,7 +1941,7 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 	return sprintf(buf, "%u\n",
 		       channel->offermsg.offer.sub_channel_index);
 }
-static VMBUS_CHAN_ATTR_RO(subchannel_id);
+static const VMBUS_CHAN_ATTR_RO(subchannel_id);
 
 static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
 				       const struct bin_attribute *attr,
@@ -1963,7 +1963,7 @@ static const struct bin_attribute chan_attr_ring_buffer = {
 	},
 	.mmap = hv_mmap_ring_buffer_wrapper,
 };
-static struct attribute *vmbus_chan_attrs[] = {
+static const struct attribute *const vmbus_chan_attrs[] = {
 	&chan_attr_out_mask.attr,
 	&chan_attr_in_mask.attr,
 	&chan_attr_read_avail.attr,
@@ -1992,7 +1992,7 @@ static const struct bin_attribute *const vmbus_chan_bin_attrs[] = {
  * each attribute, and returns 0 if an attribute is not visible.
  */
 static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
-					  struct attribute *attr, int idx)
+					  const struct attribute *attr, int idx)
 {
 	const struct vmbus_channel *channel =
 		container_of(kobj, struct vmbus_channel, kobj);
@@ -2030,9 +2030,9 @@ static size_t vmbus_chan_bin_size(struct kobject *kobj,
 }
 
 static const struct attribute_group vmbus_chan_group = {
-	.attrs = vmbus_chan_attrs,
+	.attrs_const = vmbus_chan_attrs,
 	.bin_attrs = vmbus_chan_bin_attrs,
-	.is_visible = vmbus_chan_attr_is_visible,
+	.is_visible_const = vmbus_chan_attr_is_visible,
 	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
 	.bin_size = vmbus_chan_bin_size,
 };

-- 
2.53.0


