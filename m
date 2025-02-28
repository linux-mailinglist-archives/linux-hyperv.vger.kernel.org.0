Return-Path: <linux-hyperv+bounces-4172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCAA4A5BD
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E5E1891F6E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617881DE4DE;
	Fri, 28 Feb 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="niQ0Y2QN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7CF1DE2DF;
	Fri, 28 Feb 2025 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780903; cv=none; b=ZYRPfg6yGZ5TghyLzJMKuuf+fo8sZIUEtdFnVLPFlfWRdMvBY7AC55Qxcn9FicGRH4nfTO8ydMPZOwWJJKYSVhjacUwxQLIgWS/adSBkzWi7w56rHaOaM19Y+qe7kOXandKAVFRE67RU32lSJLKersLlLdZHGTQoHITpS5EipfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780903; c=relaxed/simple;
	bh=v/EWmHfP+jzvIU9H3RHUQaWE1YNNoxkF9vERCt690K0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BgwxO7KyFt6rQG4a5Vlwgx2BESTDFkij0L3wjPhcD8HhvuO02NJMECX4eeMCcHzjnCM324gxhj/yyvTlzNB8v73g5gpGGzdf2PCsVOZ+P8Xc7wFLJcx0pfRpuoyfiKVPyeX++BS+/S6JXsK7oEBfTnPnxCMVD8+7VYtfdmoeAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=niQ0Y2QN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4FA24210D0EB; Fri, 28 Feb 2025 14:15:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FA24210D0EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1740780901;
	bh=Lg5CvRFW8Gu79ZvpC+be+tdhf1yh2bjgNXBVffCNAjs=;
	h=From:To:Cc:Subject:Date:From;
	b=niQ0Y2QNdS+Awp2yPtSWXpDcLh6P8mLZK9lfz7KXnq6fDgczhWXofoxaASbtoqfgr
	 MbS8CSSLSq+b1EC9R0e9IDKur5fX5ujh6vFJa6uEzUTgS4NNrHMj+7h2br4Ff8aH9k
	 jp0NPYP6eOKJbh9isBKnyWJTQmn12/W5EzGQiq8M=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2] uio_hv_generic: Set event for all channels on the device
Date: Fri, 28 Feb 2025 14:14:14 -0800
Message-Id: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Hyper-V may offer a non latency sensitive device with subchannels without
monitor bit enabled. The decision is entirely on the Hyper-V host not
configurable within guest.

When a device has subchannels, also signal events for the subchannel
if its monitor bit is disabled.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: Use vmbus_set_event() to avoid additional check on monitored bit
    Lock vmbus_connection.channel_mutex when going through subchannels

 drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3976360d0096..45be2f8baade 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -65,6 +65,16 @@ struct hv_uio_private_data {
 	char	send_name[32];
 };
 
+static void set_event(struct vmbus_channel *channel, s32 irq_state)
+{
+	channel->inbound.ring_buffer->interrupt_mask = !irq_state;
+	if (!channel->offermsg.monitor_allocated && irq_state) {
+		/* MB is needed for host to see the interrupt mask first */
+		virt_mb();
+		vmbus_set_event(channel);
+	}
+}
+
 /*
  * This is the irqcontrol callback to be registered to uio_info.
  * It can be used to disable/enable interrupt from user space processes.
@@ -79,12 +89,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 {
 	struct hv_uio_private_data *pdata = info->priv;
 	struct hv_device *dev = pdata->device;
+	struct vmbus_channel *primary, *sc;
 
-	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
-	virt_mb();
+	primary = dev->channel;
+	set_event(primary, irq_state);
 
-	if (!dev->channel->offermsg.monitor_allocated && irq_state)
-		vmbus_setevent(dev->channel);
+	mutex_lock(&vmbus_connection.channel_mutex);
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		set_event(sc, irq_state);
+	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	return 0;
 }
@@ -95,12 +108,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 static void hv_uio_channel_cb(void *context)
 {
 	struct vmbus_channel *chan = context;
-	struct hv_device *hv_dev = chan->device_obj;
-	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
+	struct hv_device *hv_dev;
+	struct hv_uio_private_data *pdata;
 
 	chan->inbound.ring_buffer->interrupt_mask = 1;
 	virt_mb();
 
+	/*
+	 * The callback may come from a subchannel, in which case look
+	 * for the hv device in the primary channel
+	 */
+	hv_dev = chan->primary_channel ?
+		 chan->primary_channel->device_obj : chan->device_obj;
+	pdata = hv_get_drvdata(hv_dev);
 	uio_event_notify(&pdata->info);
 }
 
-- 
2.34.1


