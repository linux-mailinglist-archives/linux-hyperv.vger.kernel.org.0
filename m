Return-Path: <linux-hyperv+bounces-1782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E7287F626
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Mar 2024 04:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D6B1F2282B
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Mar 2024 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138497BAFF;
	Tue, 19 Mar 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XqesdReY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB47BAF0;
	Tue, 19 Mar 2024 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819851; cv=none; b=tQKZZeE8WLKyIh/z92xYzK6LCayD/fNwKBIAw+j6/PUMQmP/luPClZWnCH8AcneI84O37GSdvY2A8Ejk/jCu9/AvAzD573L4I8jZkS9bz6Gy3sGwfECCAd3BNSTDR+rPhQ3mzHERczypJei0hnV+3wCB2A3pnqh9myZhnyuos/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819851; c=relaxed/simple;
	bh=V5r8LcMDVOhylr0403axJbjXQUUgSy+13S7QWHsKshc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cr6vFaOHMYVJEEF52ySsJdB5MrJALpG0WcweIIXDoF2PFcEbiZFt5CTwpQnVu6qeniuH5/L+clbBiBmLsv1lRuCBrDwE73XV7Vc+1Wbem2gSuDDxrqSXJmYPLqQX5i7EkTxHe0CI7QCTo6AW6TRjBhQLIX0xmQLypoDovIMp8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XqesdReY; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710819848; x=1742355848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V5r8LcMDVOhylr0403axJbjXQUUgSy+13S7QWHsKshc=;
  b=XqesdReYwtqhvlhxvMiJrWoyIrGBa+j8rK5YVZ1PQMCLkV1oL06Q5kZj
   5woVIzeB8gyL/CrjlmV0vnprRsmvcx7t1bsEbIYYKBESV3cbcPCKPfcG7
   cBDh6vvJyicn7hNCF7K9nMFfJrwB8kniBSS27HdfwUuwYwcETJMB8yYVp
   1evH5Eau2VsM5V6rJTuILLdUFc+SClhkvdsJ/VeiCf5LLMmfJ429QdGZc
   9M5l4P7/85BJd1LTDA281eIGAe/ZOOHUFnnxu33VoUMoi/bmrNB6icoYC
   vdXWIMzJLmMX4VAuK8Dl2G8iD6cEbfsupd2y7SbK2ei/PzJ4F0fFAQ38f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="131984966"
X-IronPort-AV: E=Sophos;i="6.07,135,1708354800"; 
   d="scan'208";a="131984966"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 12:43:58 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C213D4805;
	Tue, 19 Mar 2024 12:43:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9B82BB4E25;
	Tue, 19 Mar 2024 12:43:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 27AC920097CC4;
	Tue, 19 Mar 2024 12:43:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8133D1A006B;
	Tue, 19 Mar 2024 11:43:54 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 11:43:50 +0800
Message-Id: <20240319034350.1574454-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.004
X-TMASE-Result: 10--12.014700-10.000000
X-TMASE-MatchedRID: vWLMKRYJCzcbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8I86i7wAXPvIb/+iW2gmXjwz/CH/seULK8+1GdiGC77k9kNxPzDYM+p3de2OoBqgwlrdf
	Vv+SM1snW1tJNv42A2dqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8ALt/pGZBmeWbYGF
	h48Enoj8j4vdOAc0peEJMoRLBuciEze1V/T0TyU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: linux-hyperv@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hv/vmbus_drv.c | 94 +++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7f7965f3d187..121f1ab32b51 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -131,7 +131,7 @@ static ssize_t id_show(struct device *dev, struct device_attribute *dev_attr,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n", hv_dev->channel->offermsg.child_relid);
+	return sysfs_emit(buf, "%d\n", hv_dev->channel->offermsg.child_relid);
 }
 static DEVICE_ATTR_RO(id);
 
@@ -142,7 +142,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *dev_attr,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n", hv_dev->channel->state);
+	return sysfs_emit(buf, "%d\n", hv_dev->channel->state);
 }
 static DEVICE_ATTR_RO(state);
 
@@ -153,7 +153,7 @@ static ssize_t monitor_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n", hv_dev->channel->offermsg.monitorid);
+	return sysfs_emit(buf, "%d\n", hv_dev->channel->offermsg.monitorid);
 }
 static DEVICE_ATTR_RO(monitor_id);
 
@@ -164,8 +164,8 @@ static ssize_t class_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "{%pUl}\n",
-		       &hv_dev->channel->offermsg.offer.if_type);
+	return sysfs_emit(buf, "{%pUl}\n",
+			  &hv_dev->channel->offermsg.offer.if_type);
 }
 static DEVICE_ATTR_RO(class_id);
 
@@ -176,8 +176,8 @@ static ssize_t device_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "{%pUl}\n",
-		       &hv_dev->channel->offermsg.offer.if_instance);
+	return sysfs_emit(buf, "{%pUl}\n",
+			  &hv_dev->channel->offermsg.offer.if_instance);
 }
 static DEVICE_ATTR_RO(device_id);
 
@@ -186,7 +186,7 @@ static ssize_t modalias_show(struct device *dev,
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 
-	return sprintf(buf, "vmbus:%*phN\n", UUID_SIZE, &hv_dev->dev_type);
+	return sysfs_emit(buf, "vmbus:%*phN\n", UUID_SIZE, &hv_dev->dev_type);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -199,7 +199,7 @@ static ssize_t numa_node_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 
-	return sprintf(buf, "%d\n", cpu_to_node(hv_dev->channel->target_cpu));
+	return sysfs_emit(buf, "%d\n", cpu_to_node(hv_dev->channel->target_cpu));
 }
 static DEVICE_ATTR_RO(numa_node);
 #endif
@@ -212,9 +212,8 @@ static ssize_t server_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_pending(hv_dev->channel,
-				       vmbus_connection.monitor_pages[0]));
+	return sysfs_emit(buf, "%d\n", channel_pending(hv_dev->channel,
+			  vmbus_connection.monitor_pages[0]));
 }
 static DEVICE_ATTR_RO(server_monitor_pending);
 
@@ -226,9 +225,8 @@ static ssize_t client_monitor_pending_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_pending(hv_dev->channel,
-				       vmbus_connection.monitor_pages[1]));
+	return sysfs_emit(buf, "%d\n", channel_pending(hv_dev->channel,
+			  vmbus_connection.monitor_pages[1]));
 }
 static DEVICE_ATTR_RO(client_monitor_pending);
 
@@ -240,9 +238,8 @@ static ssize_t server_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_latency(hv_dev->channel,
-				       vmbus_connection.monitor_pages[0]));
+	return sysfs_emit(buf, "%d\n", channel_latency(hv_dev->channel,
+			  vmbus_connection.monitor_pages[0]));
 }
 static DEVICE_ATTR_RO(server_monitor_latency);
 
@@ -254,9 +251,8 @@ static ssize_t client_monitor_latency_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_latency(hv_dev->channel,
-				       vmbus_connection.monitor_pages[1]));
+	return sysfs_emit(buf, "%d\n", channel_latency(hv_dev->channel,
+			  vmbus_connection.monitor_pages[1]));
 }
 static DEVICE_ATTR_RO(client_monitor_latency);
 
@@ -268,9 +264,8 @@ static ssize_t server_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_conn_id(hv_dev->channel,
-				       vmbus_connection.monitor_pages[0]));
+	return sysfs_emit(buf, "%d\n", channel_conn_id(hv_dev->channel,
+			  vmbus_connection.monitor_pages[0]));
 }
 static DEVICE_ATTR_RO(server_monitor_conn_id);
 
@@ -282,9 +277,8 @@ static ssize_t client_monitor_conn_id_show(struct device *dev,
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	return sprintf(buf, "%d\n",
-		       channel_conn_id(hv_dev->channel,
-				       vmbus_connection.monitor_pages[1]));
+	return sysfs_emit(buf, "%d\n", channel_conn_id(hv_dev->channel,
+			  vmbus_connection.monitor_pages[1]));
 }
 static DEVICE_ATTR_RO(client_monitor_conn_id);
 
@@ -303,7 +297,7 @@ static ssize_t out_intr_mask_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
+	return sysfs_emit(buf, "%d\n", outbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(out_intr_mask);
 
@@ -321,7 +315,7 @@ static ssize_t out_read_index_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", outbound.current_read_index);
+	return sysfs_emit(buf, "%d\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
 
@@ -340,7 +334,7 @@ static ssize_t out_write_index_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", outbound.current_write_index);
+	return sysfs_emit(buf, "%d\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
 
@@ -359,7 +353,7 @@ static ssize_t out_read_bytes_avail_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
+	return sysfs_emit(buf, "%d\n", outbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(out_read_bytes_avail);
 
@@ -378,7 +372,7 @@ static ssize_t out_write_bytes_avail_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
+	return sysfs_emit(buf, "%d\n", outbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(out_write_bytes_avail);
 
@@ -396,7 +390,7 @@ static ssize_t in_intr_mask_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
+	return sysfs_emit(buf, "%d\n", inbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(in_intr_mask);
 
@@ -414,7 +408,7 @@ static ssize_t in_read_index_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", inbound.current_read_index);
+	return sysfs_emit(buf, "%d\n", inbound.current_read_index);
 }
 static DEVICE_ATTR_RO(in_read_index);
 
@@ -432,7 +426,7 @@ static ssize_t in_write_index_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", inbound.current_write_index);
+	return sysfs_emit(buf, "%d\n", inbound.current_write_index);
 }
 static DEVICE_ATTR_RO(in_write_index);
 
@@ -451,7 +445,7 @@ static ssize_t in_read_bytes_avail_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
+	return sysfs_emit(buf, "%d\n", inbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(in_read_bytes_avail);
 
@@ -470,7 +464,7 @@ static ssize_t in_write_bytes_avail_show(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
+	return sysfs_emit(buf, "%d\n", inbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(in_write_bytes_avail);
 
@@ -480,7 +474,7 @@ static ssize_t channel_vp_mapping_show(struct device *dev,
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct vmbus_channel *channel = hv_dev->channel, *cur_sc;
-	int buf_size = PAGE_SIZE, n_written, tot_written;
+	int n_written;
 	struct list_head *cur;
 
 	if (!channel)
@@ -488,25 +482,21 @@ static ssize_t channel_vp_mapping_show(struct device *dev,
 
 	mutex_lock(&vmbus_connection.channel_mutex);
 
-	tot_written = snprintf(buf, buf_size, "%u:%u\n",
-		channel->offermsg.child_relid, channel->target_cpu);
+	n_written = sysfs_emit(buf, "%u:%u\n",
+			       channel->offermsg.child_relid,
+			       channel->target_cpu);
 
 	list_for_each(cur, &channel->sc_list) {
-		if (tot_written >= buf_size - 1)
-			break;
 
 		cur_sc = list_entry(cur, struct vmbus_channel, sc_list);
-		n_written = scnprintf(buf + tot_written,
-				     buf_size - tot_written,
-				     "%u:%u\n",
-				     cur_sc->offermsg.child_relid,
-				     cur_sc->target_cpu);
-		tot_written += n_written;
+		n_written += sysfs_emit_at(buf, n_written, "%u:%u\n",
+					  cur_sc->offermsg.child_relid,
+					  cur_sc->target_cpu);
 	}
 
 	mutex_unlock(&vmbus_connection.channel_mutex);
 
-	return tot_written;
+	return n_written;
 }
 static DEVICE_ATTR_RO(channel_vp_mapping);
 
@@ -516,7 +506,7 @@ static ssize_t vendor_show(struct device *dev,
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 
-	return sprintf(buf, "0x%x\n", hv_dev->vendor_id);
+	return sysfs_emit(buf, "0x%x\n", hv_dev->vendor_id);
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -526,7 +516,7 @@ static ssize_t device_show(struct device *dev,
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 
-	return sprintf(buf, "0x%x\n", hv_dev->device_id);
+	return sysfs_emit(buf, "0x%x\n", hv_dev->device_id);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -551,7 +541,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", hv_dev->driver_override);
+	len = sysfs_emit(buf, "%s\n", hv_dev->driver_override);
 	device_unlock(dev);
 
 	return len;
-- 
2.29.2


