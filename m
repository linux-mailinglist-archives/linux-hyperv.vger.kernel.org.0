Return-Path: <linux-hyperv+bounces-7051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6FABB27FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 07:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBB19C631F
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FC126BF1;
	Thu,  2 Oct 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jmu9XBct"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D04288AD;
	Thu,  2 Oct 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759381540; cv=none; b=LV4asN36FRSDeB3OhINy7vLWORbV2QasITeWMzCU2ifbCvgtgIIOztgg1XydPS89TjtJ+vzc4RAKaQ8Nhe8eYOx1IgBEuywxqBKc5khSH64ZQKHWNSpLz73ZUoIOSRL2ODAVPFeGDd5R9isHWn5kZcXRqUN4l16Il07v+Sygg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759381540; c=relaxed/simple;
	bh=bI/mZGVNvgSTCHzPzpYYFFI0KxTnqy0WQILS8PYBcjw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LMgE+wXgP6bMWfWHSkoxwuCYuMOLv9/CC82faCLsx9jadUikIu00+Iaw60sG3XsPIu5KVZ73dWUZJ3z8wvdNIcthF0OIeaYsBAD8J/RRndJZFzG9JW2+cOlvcMn9XdtGufEa3FE0iwOXfGBgHxI7MX7EqZLKTZT0iuavwo5xdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jmu9XBct; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 2C58D211B7BA; Wed,  1 Oct 2025 22:05:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C58D211B7BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759381538;
	bh=CCt7Ka1OHCkdfERjqHmJFqFGJf3OixpHd49QDRrSK2M=;
	h=From:To:Cc:Subject:Date:From;
	b=Jmu9XBctU81uECJaeRw4OBjHvyQYc7DBVtU2IR8m3YbK/iDAWBSrOZ6tHvlRO7fgW
	 ytrAe8UnjrI8xozMK5EPHOv3vzk4Ro3SYEHoA7YdN7oRvaEw/btECU2VXBJuxVd4fu
	 fOaceNfROIj6xUbF93hgxFGjXHiNeNa1/DkBEB1I=
From: longli@linux.microsoft.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <JBottomley@Odin.com>,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU as on the I/O issuing CPU
Date: Wed,  1 Oct 2025 22:05:30 -0700
Message-Id: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When selecting an outgoing channel for I/O, storvsc tries to select a
channel with a returning CPU that is not the same as issuing CPU. This
worked well in the past, however it doesn't work well when the Hyper-V
exposes a large number of channels (up to the number of all CPUs). Use
a different CPU for returning channel is not efficient on Hyper-V.

Change this behavior by preferring to the channel with the same CPU
as the current I/O issuing CPU whenever possible.

Tests have shown improvements in newer Hyper-V/Azure environment, and
no regression with older Hyper-V/Azure environments.

Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 96 ++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index d9e59204a9c3..092939791ea0 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1406,14 +1406,19 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 	}
 
 	/*
-	 * Our channel array is sparsley populated and we
+	 * Our channel array could be sparsley populated and we
 	 * initiated I/O on a processor/hw-q that does not
 	 * currently have a designated channel. Fix this.
 	 * The strategy is simple:
-	 * I. Ensure NUMA locality
-	 * II. Distribute evenly (best effort)
+	 * I. Prefer the channel associated with the current CPU
+	 * II. Ensure NUMA locality
+	 * III. Distribute evenly (best effort)
 	 */
 
+	/* Prefer the channel on the I/O issuing processor/hw-q */
+	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
+		return stor_device->stor_chns[q_num];
+
 	node_mask = cpumask_of_node(cpu_to_node(q_num));
 
 	num_channels = 0;
@@ -1469,59 +1474,48 @@ static int storvsc_do_io(struct hv_device *device,
 	/* See storvsc_change_target_cpu(). */
 	outgoing_channel = READ_ONCE(stor_device->stor_chns[q_num]);
 	if (outgoing_channel != NULL) {
-		if (outgoing_channel->target_cpu == q_num) {
-			/*
-			 * Ideally, we want to pick a different channel if
-			 * available on the same NUMA node.
-			 */
-			node_mask = cpumask_of_node(cpu_to_node(q_num));
-			for_each_cpu_wrap(tgt_cpu,
-				 &stor_device->alloced_cpus, q_num + 1) {
-				if (!cpumask_test_cpu(tgt_cpu, node_mask))
-					continue;
-				if (tgt_cpu == q_num)
-					continue;
-				channel = READ_ONCE(
-					stor_device->stor_chns[tgt_cpu]);
-				if (channel == NULL)
-					continue;
-				if (hv_get_avail_to_write_percent(
-							&channel->outbound)
-						> ring_avail_percent_lowater) {
-					outgoing_channel = channel;
-					goto found_channel;
-				}
-			}
+		if (hv_get_avail_to_write_percent(&outgoing_channel->outbound)
+				> ring_avail_percent_lowater)
+			goto found_channel;
 
-			/*
-			 * All the other channels on the same NUMA node are
-			 * busy. Try to use the channel on the current CPU
-			 */
-			if (hv_get_avail_to_write_percent(
-						&outgoing_channel->outbound)
-					> ring_avail_percent_lowater)
+		/*
+		 * Channel is busy, try to find a channel on the same NUMA node
+		 */
+		node_mask = cpumask_of_node(cpu_to_node(q_num));
+		for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
+				  q_num + 1) {
+			if (!cpumask_test_cpu(tgt_cpu, node_mask))
+				continue;
+			channel = READ_ONCE(stor_device->stor_chns[tgt_cpu]);
+			if (!channel)
+				continue;
+			if (hv_get_avail_to_write_percent(&channel->outbound)
+					> ring_avail_percent_lowater) {
+				outgoing_channel = channel;
 				goto found_channel;
+			}
+		}
 
-			/*
-			 * If we reach here, all the channels on the current
-			 * NUMA node are busy. Try to find a channel in
-			 * other NUMA nodes
-			 */
-			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
-				if (cpumask_test_cpu(tgt_cpu, node_mask))
-					continue;
-				channel = READ_ONCE(
-					stor_device->stor_chns[tgt_cpu]);
-				if (channel == NULL)
-					continue;
-				if (hv_get_avail_to_write_percent(
-							&channel->outbound)
-						> ring_avail_percent_lowater) {
-					outgoing_channel = channel;
-					goto found_channel;
-				}
+		/*
+		 * If we reach here, all the channels on the current
+		 * NUMA node are busy. Try to find a channel in
+		 * all NUMA nodes
+		 */
+		for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
+				  q_num + 1) {
+			channel = READ_ONCE(stor_device->stor_chns[tgt_cpu]);
+			if (!channel)
+				continue;
+			if (hv_get_avail_to_write_percent(&channel->outbound)
+					> ring_avail_percent_lowater) {
+				outgoing_channel = channel;
+				goto found_channel;
 			}
 		}
+		/*
+		 * If we reach here, all the channels are busy. Use the
+		 * original channel found.
+		 */
 	} else {
 		spin_lock_irqsave(&stor_device->lock, flags);
 		outgoing_channel = stor_device->stor_chns[q_num];
-- 
2.34.1


