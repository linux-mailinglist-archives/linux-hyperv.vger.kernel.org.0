Return-Path: <linux-hyperv+bounces-5497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA5AB61AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 06:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF17F189F735
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141111F0E37;
	Wed, 14 May 2025 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJOnvn6E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC901CFBC;
	Wed, 14 May 2025 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197894; cv=none; b=hAxzx9MghfTp2g2mctijo/+Lew+kkpanUq4IeUKlHeyTt0VmcPFNzUcMdpMunhktTiosN23tBzo+uLfR51FvYLg+D+ReObH5BBpHncMhH8NHrY/SUubPesxrWoy8G0uOyFG6IG1p/km94/5JGk4utMPqN+5fZQ5Ypdj3/8nVYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197894; c=relaxed/simple;
	bh=Y6s3AX2jrPC7U4pqLlFuhTwX0EZLQ+3bOheTss9JR7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WK4lbjNM9DqHYnUth8WRDBDj48Q/GVHAoq1Fske1EMordnU0Zfw/wYI+V3t1SMhThdHfsK999Iabh/oy3ddBL9JEdA8wP62fBgHd+VAurJk1b4uHlwitKj/26QuY6pLFuMu7qwwHwJYmEQkbrlUyB83ftbTCZEW80f2q/Lu7S3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJOnvn6E; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4966016a12.2;
        Tue, 13 May 2025 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747197891; x=1747802691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9trPMXX/EB7UVvTChy9shKqqwZNL3OD0NP24pTFGYI=;
        b=aJOnvn6Ef+yENNdpZps/EmjmWnQ0Oi0HCcKPOlowEGEy56Ndmv8vhYvtTPgzGTQQ8r
         jGfk09Qm7I7O2WIwIp0aQYHweyvBM3ImcZJYkSppabRtKYW+FfIVm/2Se5kt4fQjG6CH
         S59yHlHl1XYprzrTBwGdB/j6y+lheZXs0kpSMrWCSKdOAnG6HUVntFfS5JGKppp1VUT4
         A0J70Hbd3XxnJVRElmQDaMNAy7b4beDAYmDyNeJZhhGZZW40jLS+rwtA9DjjXyTeYTnd
         NBEcJ1lzt1YidF8t1khPFV0/AORMJTZ4k7XPJH9zV1yLUWsr/qLBMEHR5glytnl29Ex1
         PGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747197891; x=1747802691;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9trPMXX/EB7UVvTChy9shKqqwZNL3OD0NP24pTFGYI=;
        b=h3q0xyV0IEDmghZoien8sMrPxZP4nCHF6S09tvh+di0REEvliJxfiZfa7XtS16G6bS
         kUkdhmPguj18pVPhfBk1ancJGftmZG5zPhxoS1SP9PRuPvJ1n72EZWGlbcmgIckCr9te
         Ry8hcQcZK8hXQhiHRiDtDLqgKYGn03k+JUw9i63quMqQMl5W67bivResZVCz3y4RUg1s
         PJsOn6aVrFICNMJVKNdDLs4p3kWkrbn1ElxqoQmYDypeXeoXFrIhpkKvm6gwJIk6rVuA
         bHoNI/8VDqB7tP5ND3hJRjKaXLw1Ok1pUwZ+GvxcqqTgx9zyGNLCasnnriT4gzaivnWD
         KpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfWiK06HHM8sFrpfW0kq7TFjbRjhSJtqdrug+EpP7fLVKJyURBGxMIqnj9Ae/uHYs3Y8/4pSfGV7qIP22t@vger.kernel.org, AJvYcCVBix1f685e6YYvzNaWKojyECC2ULxon85VpUaYnizTK178c6Dwz2GgjJlYPCJjWpT222S3xZcGgMIqw8GC@vger.kernel.org, AJvYcCWm06zLa1RAYwBWowmewvAuOFfvwuhWCkBRZaNFWlJOPfEFthAW011uFP5PK9rp/WF59sLFDY0GlC4J7UrL4y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4FZFfhglIKiqI9XGTN0ddBUWx14oY41JRrXj9uWheEFyFglY
	DCAwgYmy5z70BGK/cvQZOhRm/zC33JpeWui4aKxMezY84P4VZfbcO4uLPQ==
X-Gm-Gg: ASbGncvLsjz1VhvVdWqgFF92VXiODj3AGCHqDTuPKSFgQGup3w41iduWZ6MeTPTVI+Z
	o0LG3Qbv4r/gDpdPzrK3Y+RJhmDpivIFtHODz69qPX3IzMByBA6qazqvQ1vuSajuiQHJBOHFJHp
	CYGhLoLBfcKPnxOW1Cv5cEVDWUdF7fKRjdgrQAPVdNnGddSOI379sh+aL2NKAwhBZcEDdhlWiqA
	KDNI6O8aKNlf/l3iQVNvzavu9UpG9yF4yPRDKMVYwNsqhwPHKVkbmWzIDlsK7j/aHe2TIXarYFG
	oA3MJ8w/SXwswMEkc1GR3GznJys4wp35vEx0fKg+d8nt2Emvgd+bZ+vObyxyxN8InSVCeYFZ9XT
	vBdiQLvxLq/599RGuJBS4qegYu9bf4AfXj6bR7wYA
X-Google-Smtp-Source: AGHT+IHLP2oJUtXKiM26CLjzKW+MVekolbuyEIjQf6pZqRH55HA5MC3HvmIPl+AIf5XTZZhPfj2chA==
X-Received: by 2002:a17:902:db06:b0:221:78a1:27fb with SMTP id d9443c01a7336-231981057a2mr32169645ad.11.1747197891426;
        Tue, 13 May 2025 21:44:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742ceesm90682255ad.73.2025.05.13.21.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 21:44:51 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	gustavoars@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/1] PCI: hv: Remove unnecessary flex array in struct pci_packet
Date: Tue, 13 May 2025 21:44:40 -0700
Message-Id: <20250514044440.48924-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

struct pci_packet contains a "message" field that is a flex array
of struct pci_message. struct pci_packet is usually followed by a
second struct in a containing struct that is defined locally in
individual functions in pci-hyperv.c. As such, the compiler
flag -Wflex-array-member-not-at-end (introduced in gcc-14) generates
multiple warnings such as:

drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure
    containing a flexible array member is not at the end of another
    structure [-Wflex-array-member-not-at-end]

The Linux kernel intends to introduce this compiler flag in standard
builds, so the current code is problematic in generating these warnings.

The "message" field is used only to locate the start of the second
struct, and not as an array. Because the second struct can be
addressed directly, the "message" field is not really necessary.
Rather than try to fix its usage to meet the requirements of
-Wflex-array-member-not-at-end, just eliminate the field and
either directly reference the second struct, or use "pkt + 1"
when "pkt" is dynamically allocated.

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Original discussion of the issue is here:

https://lore.kernel.org/linux-hyperv/aAu8qsMQlbgH82iN@kspp/

 drivers/pci/controller/pci-hyperv.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e1eaa24559a2..ca5459e0dfcb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -309,8 +309,6 @@ struct pci_packet {
 	void (*completion_func)(void *context, struct pci_response *resp,
 				int resp_packet_size);
 	void *compl_ctxt;
-
-	struct pci_message message[];
 };
 
 /*
@@ -1438,7 +1436,7 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.pkt.completion_func = hv_pci_read_config_compl;
 	pkt.pkt.compl_ctxt = &comp_pkt;
-	read_blk = (struct pci_read_block *)&pkt.pkt.message;
+	read_blk = (struct pci_read_block *)pkt.buf;
 	read_blk->message_type.type = PCI_READ_BLOCK;
 	read_blk->wslot.slot = devfn_to_wslot(pdev->devfn);
 	read_blk->block_id = block_id;
@@ -1518,7 +1516,7 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.pkt.completion_func = hv_pci_write_config_compl;
 	pkt.pkt.compl_ctxt = &comp_pkt;
-	write_blk = (struct pci_write_block *)&pkt.pkt.message;
+	write_blk = (struct pci_write_block *)pkt.buf;
 	write_blk->message_type.type = PCI_WRITE_BLOCK;
 	write_blk->wslot.slot = devfn_to_wslot(pdev->devfn);
 	write_blk->block_id = block_id;
@@ -1599,7 +1597,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
 		return;
 	}
 	memset(&ctxt, 0, sizeof(ctxt));
-	int_pkt = (struct pci_delete_interrupt *)&ctxt.pkt.message;
+	int_pkt = (struct pci_delete_interrupt *)ctxt.buffer;
 	int_pkt->message_type.type =
 		PCI_DELETE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot = hpdev->desc.win_slot.slot;
@@ -2482,7 +2480,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	comp_pkt.hpdev = hpdev;
 	pkt.init_packet.compl_ctxt = &comp_pkt;
 	pkt.init_packet.completion_func = q_resource_requirements;
-	res_req = (struct pci_child_message *)&pkt.init_packet.message;
+	res_req = (struct pci_child_message *)pkt.buffer;
 	res_req->message_type.type = PCI_QUERY_RESOURCE_REQUIREMENTS;
 	res_req->wslot.slot = desc->win_slot.slot;
 
@@ -2860,7 +2858,7 @@ static void hv_eject_device_work(struct work_struct *work)
 		pci_destroy_slot(hpdev->pci_slot);
 
 	memset(&ctxt, 0, sizeof(ctxt));
-	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
+	ejct_pkt = (struct pci_eject_response *)ctxt.buffer;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
@@ -3118,7 +3116,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
 	init_completion(&comp_pkt.host_event);
 	pkt->completion_func = hv_pci_generic_compl;
 	pkt->compl_ctxt = &comp_pkt;
-	version_req = (struct pci_version_request *)&pkt->message;
+	version_req = (struct pci_version_request *)(pkt + 1);
 	version_req->message_type.type = PCI_QUERY_PROTOCOL_VERSION;
 
 	for (i = 0; i < num_version; i++) {
@@ -3340,7 +3338,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	init_completion(&comp_pkt.host_event);
 	pkt->completion_func = hv_pci_generic_compl;
 	pkt->compl_ctxt = &comp_pkt;
-	d0_entry = (struct pci_bus_d0_entry *)&pkt->message;
+	d0_entry = (struct pci_bus_d0_entry *)(pkt + 1);
 	d0_entry->message_type.type = PCI_BUS_D0ENTRY;
 	d0_entry->mmio_base = hbus->mem_config->start;
 
@@ -3498,20 +3496,20 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 
 		if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2) {
 			res_assigned =
-				(struct pci_resources_assigned *)&pkt->message;
+				(struct pci_resources_assigned *)(pkt + 1);
 			res_assigned->message_type.type =
 				PCI_RESOURCES_ASSIGNED;
 			res_assigned->wslot.slot = hpdev->desc.win_slot.slot;
 		} else {
 			res_assigned2 =
-				(struct pci_resources_assigned2 *)&pkt->message;
+				(struct pci_resources_assigned2 *)(pkt + 1);
 			res_assigned2->message_type.type =
 				PCI_RESOURCES_ASSIGNED2;
 			res_assigned2->wslot.slot = hpdev->desc.win_slot.slot;
 		}
 		put_pcichild(hpdev);
 
-		ret = vmbus_sendpacket(hdev->channel, &pkt->message,
+		ret = vmbus_sendpacket(hdev->channel, pkt + 1,
 				size_res, (unsigned long)pkt,
 				VM_PKT_DATA_INBAND,
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
@@ -3809,6 +3807,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 		struct pci_packet teardown_packet;
 		u8 buffer[sizeof(struct pci_message)];
 	} pkt;
+	struct pci_message *msg;
 	struct hv_pci_compl comp_pkt;
 	struct hv_pci_dev *hpdev, *tmp;
 	unsigned long flags;
@@ -3854,10 +3853,10 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 	init_completion(&comp_pkt.host_event);
 	pkt.teardown_packet.completion_func = hv_pci_generic_compl;
 	pkt.teardown_packet.compl_ctxt = &comp_pkt;
-	pkt.teardown_packet.message[0].type = PCI_BUS_D0EXIT;
+	msg = (struct pci_message *)pkt.buffer;
+	msg->type = PCI_BUS_D0EXIT;
 
-	ret = vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
-				     sizeof(struct pci_message),
+	ret = vmbus_sendpacket_getid(chan, msg, sizeof(*msg),
 				     (unsigned long)&pkt.teardown_packet,
 				     &trans_id, VM_PKT_DATA_INBAND,
 				     VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-- 
2.25.1


