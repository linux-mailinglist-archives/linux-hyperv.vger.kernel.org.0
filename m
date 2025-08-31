Return-Path: <linux-hyperv+bounces-6676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA9B3D446
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE591896C5C
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BC1DF269;
	Sun, 31 Aug 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGYFINVW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155315464E;
	Sun, 31 Aug 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756656259; cv=none; b=YBPcwX/vHAT+qEAJCUEnPOPpjDHwMZ3KbVb0rmDYdEbPiNvib/qq2XEM0DNQpL9w8S3fOrzwKWUvujmL8iIH0T0QvZhXPfnAuMsUV8Eb/Di5uDlPXFSP9CqZqE+EGN1EIWwQ05WHWyxEkazOGBo3VsTINmgEUyp+KsUrcs3mn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756656259; c=relaxed/simple;
	bh=ltxqsIkTPOvwWD1bTxmoTBUCOFRnRX2ZvtvfWYqwYb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wiao/ni0/rXXg+3mYCYltmrP3HK5zDymjRsqV65f75ddZdp1yj0JZCB4bgkJb3/VxdRs/+IpLLZhJO6o26bswn/IvS+3KdE4YYQwa3XgubEM3JH6N7mL6uuyaqNTjM/A1s1dE83vdHYEcXtlhCZjpvYE4E7En3pAokcqNlP2vLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGYFINVW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c53892a56so3116002a12.2;
        Sun, 31 Aug 2025 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756656257; x=1757261057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4xzCjokMOPZtEHhRoxrtmTUmXntVRlstGQOZj1FSgU=;
        b=DGYFINVWONs4PPdT3lbGoyzXr2dqVrWjVPFQ+nI/6u3/u9zbn1HCmJCBuJ2ABmXjZy
         iNedwZnOnpsRkQ3ILT4nzotGiZp8m8l+k4yu2o8kGVLQDMsI8bIZBGg1TE3MrqHlp/Gz
         990fBxc+EcpzhQTOinFlDvmQZfOMdaI2isF6jChwzOCXopPXpMB/7nwZag5sB/oWxb/J
         o/IgQPstqeh/zw0CX5eNO2xNYvWKVjgBj/0gVYfJmlPQ8R0J7WVne5Gm0s86BCUIlKKr
         VoU7Rl/nTwymmGYoICx8vXhJVHlBOVwqqHK9cRsvEwyM5zO4tS3xA4yd1k6e239VQm+3
         UeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756656257; x=1757261057;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4xzCjokMOPZtEHhRoxrtmTUmXntVRlstGQOZj1FSgU=;
        b=JgtPSj1+VHhqipCU89YfgzdxxJKg+8JfXQInofNDG5vahMQ7EbvmTpLr0KPNynQJXn
         v6HNAjvMGZmFjC5dZXX8GZLoYDrCI/Jbj6T5PHqJgofhRuRRZlkiMLOtjIJ9zs05zRED
         pjCbpRLR2jAL3XAHBVO/lXEKcYQNwOufWhwX5CaxumfxwznNs8PYHOS/LkkleZ4StqbX
         rwN1/7cyb+Ty8V/ZWJZ9FQPuxMjomIX189hMb6fKL8CbMCv0vz9Dqf/aGX567tHCmz+e
         VA+fPXiD0jiNAnarkugvcycOHx/Yxqhx6b4H2hb9n/z1Yg4sJ7bdd/9sAd++EH5JkS38
         Ksgw==
X-Forwarded-Encrypted: i=1; AJvYcCWmaerI2ZXTN+38+QoFjUMBMN+TfXYJOTABBf5NbW9nNOW2f1QWUexXiMTA/cHvlfMF6Kpz6XyjhMQ09hR4@vger.kernel.org, AJvYcCX93JOctjyB4IuUzYvQOf+fW1YosZ164lBTKwcZdyvE/zcApIUkQ7Eox33umYHGN2MPZS/Mci9FQC/GTKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGTXP4RjkhwU7roJOVTVpBZ9mKgbWAEehy5MKYXASbpYEmu+1
	yaKZTq4DT1IONoUu7NIVyAGBwPsUu+ZXGMNtVAmNUZ2lWt7J/0s/pV3x4Wt+mPgWSI0=
X-Gm-Gg: ASbGncuX0j+VjRqI/y4XusnuepCXNNR1xiGcgsSp0c8tzEKhdibGOEbZR+xhiglOUxp
	j8T3Fq5KYxa4VO3XbIf1CgwULgMA0If1el9Zc0LAD4qHzVA4n18G0HIwxDmI5+BFUAAS2cqTCY1
	o43vxlscYNKV94l/bwYkv9ssIeKMWQ/64IP7O2NaH/3CmJrieE5vyAsgkcoVqqPbHXuNyCJV4b5
	fFDCQKrMm2XnmiJdx2p/zd9JGDSNvic21wJlRkTxqnmiEE3QK5y/dU+Q0KsYez+zKsRBciCBNow
	6p21GcyCfN7v4s56qRTOqd0UsPj+K+GSz1mbuUV6XyVOdtXGZ1gl6RYz+88f/w9ju93fpv8Amf8
	qkY45omNlVOayO/sd9iLqRAZt5yRWASkvgRmf+Goez9rXUcZsTNFbnqXNr2ipw7AfCRUPmHrEa7
	5pPU2RZDHCApRc
X-Google-Smtp-Source: AGHT+IFNQ5hkrSBoyPHyAMM9aBz2R3k0RAFzu7HGiTKsSfoz7fQJ00AP7eWwKhhYeF/TNTMrbduY/A==
X-Received: by 2002:a17:902:c952:b0:248:d9af:de27 with SMTP id d9443c01a7336-2494486f95cmr80571545ad.1.1756656257207;
        Sun, 31 Aug 2025 09:04:17 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da28b9sm78746315ad.76.2025.08.31.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 09:04:16 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: gustavoars@kernel.org
Subject: [PATCH 1/1] Drivers: hv: Simplify data structures for VMBus channel close message
Date: Sun, 31 Aug 2025 09:04:06 -0700
Message-Id: <20250831160406.958974-1-mhklinux@outlook.com>
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

struct vmbus_close_msg is used for sending the VMBus channel close
message. It contains a struct vmbus_channel_msginfo, which has a
flex array member at the end. The latter's presence in the middle
of struct vmbus_close_msg causes warnings when built with
-Wflex-array-member-not-at-end.

But the struct vmbus_channel_msginfo is unused because the Hyper-V host
does not send a response to the channel close message. So remove the
struct vmbus_channel_msginfo. Then, since the only remaining field is
struct vmbus_channel_close_channel, also remove the containing struct
vmbus_close_msg and directly use struct vmbus_channel_close_channel.
Besides eliminating unnecessary complexity, these changes resolve the
-Wflex-array-member-not-at-end warnings.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   | 2 +-
 include/linux/hyperv.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 7c7c66e0dc3f..162d6aeece7b 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -925,7 +925,7 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 
 	/* Send a closing message */
 
-	msg = &channel->close_msg.msg;
+	msg = &channel->close_msg;
 
 	msg->header.msgtype = CHANNELMSG_CLOSECHANNEL;
 	msg->child_relid = channel->offermsg.child_relid;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a59c5c3e95fb..59826c89171c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -707,11 +707,6 @@ struct vmbus_channel_msginfo {
 	unsigned char msg[];
 };
 
-struct vmbus_close_msg {
-	struct vmbus_channel_msginfo info;
-	struct vmbus_channel_close_channel msg;
-};
-
 enum vmbus_device_type {
 	HV_IDE = 0,
 	HV_SCSI,
@@ -800,7 +795,7 @@ struct vmbus_channel {
 	struct hv_ring_buffer_info outbound;	/* send to parent */
 	struct hv_ring_buffer_info inbound;	/* receive from parent */
 
-	struct vmbus_close_msg close_msg;
+	struct vmbus_channel_close_channel close_msg;
 
 	/* Statistics */
 	u64	interrupts;	/* Host to Guest interrupts */
-- 
2.25.1


