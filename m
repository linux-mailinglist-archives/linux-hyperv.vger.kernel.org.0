Return-Path: <linux-hyperv+bounces-4083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5231A47079
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 01:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386B2188D8A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 00:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3527003A;
	Thu, 27 Feb 2025 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="JK9JophO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AD7462;
	Thu, 27 Feb 2025 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617179; cv=none; b=VTVmXpPaqkXTStWQLlsPO3pX/QTzhnA5QKEaG7O8h66ckvd0gTqml7vK1xYXbFcMcy6wDTlLgPI71XESjxLB0Yzfw+eY9gy6y/82s7C16yAc1BWlY1zYJfxjeql4r0So8QozXaEVNV5QnEWNgL4CHYtp8v3GUi1u4U3jNqwhR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617179; c=relaxed/simple;
	bh=mXzZ0BmaQS0yzGWDeFwERyTqnUkdRAA9/VSw1crzZlA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BS5Wtf8BvtY4kv7O/HY19/L1UdRNDm9XqHvdWOOz1oHpeYH3hXj7qIjxeMp+DbNQaO9i75rn4oGR6msR0aaBsbvbO2JMP6j97Gnzae5PXlHUeqHi3ETLAYVgVB2espGka8eNxHOcPUxdcXHh3eryn7YwLOnRiJ8zlRoz6tTfScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=JK9JophO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 11C0F210C313; Wed, 26 Feb 2025 16:46:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11C0F210C313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1740617178;
	bh=ZftA8Or9AuHhHcKwPIKZDu5IOAx79F4qZJUHq+qO1GU=;
	h=From:To:Cc:Subject:Date:From;
	b=JK9JophOsvP5UY+utUXAht+ZBcmvxMPWb3Q7dAbaPFoemssa6yMCCq0EuOiQH0Z2D
	 e5vNjMO+9r0hBh/c4hRBVttptJjw+G54hQgpR5HpuYO00luSbs/+oS4eRaeAgykM56
	 LZqVfJ4dnzZQTonUwP9wF0/jstZ2/Ko1n2LSDlXw=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] uio_hv_generic: Set event for all channels on the device
Date: Wed, 26 Feb 2025 16:45:58 -0800
Message-Id: <1740617158-15902-1-git-send-email-longli@linuxonhyperv.com>
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
 drivers/uio/uio_hv_generic.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3976360d0096..8b6df598a728 100644
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
+		vmbus_setevent(channel);
+	}
+}
+
 /*
  * This is the irqcontrol callback to be registered to uio_info.
  * It can be used to disable/enable interrupt from user space processes.
@@ -79,12 +89,13 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
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
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		set_event(sc, irq_state);
 
 	return 0;
 }
@@ -95,12 +106,19 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
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


