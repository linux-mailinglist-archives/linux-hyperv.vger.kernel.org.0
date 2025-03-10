Return-Path: <linux-hyperv+bounces-4369-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B8DA5A6C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 23:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B99E7A3740
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED21CEEBE;
	Mon, 10 Mar 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="JQSHsWDP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E751DE2CE;
	Mon, 10 Mar 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644726; cv=none; b=tfYRjTwjB4m7/DLf5CA4MQwYiVP6fLFmYs969A4XK8cZ0Fy6/Eq0yqmduM4TdKUUVScJFNrE+FjozRHrtq9QAyiHZiJQSQdF8TNogUPcsHJTg9NEzhCmZK7Gf/DVWbJpEYFcCNvucQi1/RfqAqljiHBKvEAQJA8s+mJkJ2U9EnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644726; c=relaxed/simple;
	bh=SKvO+7zXnoNHvTpiQVfIZVEjAhuH9e4b+IWhxYM/mIk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PFqdxIpHsG4DTOIG2ZPNmvomCvUlT66zpUbW/nuCFRW67mgSJCHZ+khRXp0CUrDjZSKACCC/9haXof3YPFKLdL+/gi1IMq6Z7Of+5dql3yDVUiA/mw7BwXmrwGR1m4R49mN3IpsCv/NzT+uiil5ZqgVVciFvjRl56wE5Po6FSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=JQSHsWDP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id DC698205492D; Mon, 10 Mar 2025 15:12:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC698205492D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1741644723;
	bh=asMeEivWZCVDFdinhQ6RmSqwY26km8pyKKRGxicSGAs=;
	h=From:To:Cc:Subject:Date:From;
	b=JQSHsWDPQZ3LknXNpKFxiTiesnGE5sEDYuWFUe30YokttyuaFCfr9XpsTGvO9YImN
	 zHXWlrReDZg64w03bcr/HWMLJwwbg+laoTCmzL5q9sidIhvqFaGgetk+L/ymx00tCn
	 1AZ1tOli1vwNjHjdp5iescLaOSXp5au9x/SiW4VY=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v3] uio_hv_generic: Set event for all channels on the device
Date: Mon, 10 Mar 2025 15:12:01 -0700
Message-Id: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
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

This patch also removes the memory barrier when monitor bit is enabled
as it is not necessary. The memory barrier is only needed between
setting up interrupt mask and calling vmbus_set_event() when monitor
bit is disabled.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: Use vmbus_set_event() to avoid additional check on monitored bit
    Lock vmbus_connection.channel_mutex when going through subchannels
v3: Add details in commit messsage on the memory barrier.

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


