Return-Path: <linux-hyperv+bounces-5477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF8AB481D
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162DD189EF7D
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91F3D76;
	Tue, 13 May 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ka0XCE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C9367;
	Tue, 13 May 2025 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094784; cv=none; b=Ka9YCWqqmb5IWAq8paqUVSlllR8VFpLrLLEC7mKyNLjNXs2N9GC8CM5JaI8QeqNE3UAk1hQe9GuVcWEBlL6S+57c6xAtWUrN77B+AMr700VNptQGgYkOenQlOKYDUiDO+Y+64ZIXxaUrcX7wcrlpHIzOfoYGrNcqEiOkSH8kY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094784; c=relaxed/simple;
	bh=FqKM+4QL0Ww31oOptKrxbmEN83vTXpCtq/sYWBVjerc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkSO/pmRYnsPe5pSkNw3s5CAhl9EdhqXYgnwMJ05KqeSBcRjbMzCUel+UQ7QND3uZGv0F6ayXI1ElLh1U9iAHA5lo5fKcKXtb7htCARrsPcO33ITtvm/HYY2HSqoe0YivhKDFCzK7GCo58z8v17yoHmKmtXOyOJ2AAO5NkliWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8ka0XCE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e4d235811so72608925ad.2;
        Mon, 12 May 2025 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094782; x=1747699582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+wz2fZe6II1B8M7LCEZ+1BKnQs3N11wYkIiB94tlgk=;
        b=S8ka0XCEqmC4Ys2FDA+kV3i0WXoiN/zC/8IxQlQmTgw1Pr/AX3H/KOGcBMQyrdu3lR
         ROM9Jqo1dNPua2pWBXteHjTh3R1b8gPnKFzrMp1m1MenOWDBx3d2yt5ebASJUNKCBEmR
         yKdkNJDJADRaQOM1zeOdT9xSSb+rhnSCmRmRlg8d03F996Cn4RQVtuQlxG9eXw09FaNr
         6ETLd4SbTCWmjJ/27ka/fzobDs7apqC8POCkHjAFA7uW3HcYiKVweoARvuRzhafe//CI
         Ku2ZFXzSEfRx5f3mlqzcD9lv49waJGmBi2LaCqOyWVYL8bacE0zIaszqE3l5DEgT+3sb
         L9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094782; x=1747699582;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+wz2fZe6II1B8M7LCEZ+1BKnQs3N11wYkIiB94tlgk=;
        b=nEpahuvhTKFMYwp0n2c2Q9w8C+ThjNh+xrF8q8nafK+rnVvQECtqiP8DU/7djJLh1q
         IVlaicm0hNK2VGOLVSm5XXHA7eOrZYCweI89WiVIqOpP1PD5mmnGHhTeHTEKZq3lKduX
         kSwYMP12sFnysjTqT3VhBYVKwF2Jh7JzEKh79l39rF3KUrnfIOlBvvRKexYMRagjjm/6
         Hlf1apTk4LAiiqa7Wuo2zyfQKev7BDWbELaZkoWbsr+78fvM87/4fskfFki9FUo99dsC
         QEbkLLJ+xffbi2lzkZOmAUlM7dyGwObhbqUOEJ0wkuHaC3iJ+hUFKY2nmyP9DUsqmLzp
         JYjg==
X-Forwarded-Encrypted: i=1; AJvYcCU0r+SCpqnh2n5/TUljLZp2c53QZDp34VjfVN5fQKF5cwVoaht9Dd/CQJ+LZi4U0oq+oaGMCcGL@vger.kernel.org, AJvYcCV6GUzxBrQ7EjbuyZzpbj60TzT4BaWJPjFaobVhbd4nAzScRulXQVHaTTL18Wc/Hzl/UObkSz33KVfZEg==@vger.kernel.org, AJvYcCVkCPKPVd1zXLFUElstktQ8iGdv1Fb/aVGmSSD8GWaAGWWXw4akvRcewdBZMOIVJbCCzm5JZr+/dXMbK7s=@vger.kernel.org, AJvYcCWzoAE3MYSqyQDuwJnBeicwg0DGzsizNEgezO2nQOmgLHG8BJseJednACSHSeOTlOmOUgKZ3iow@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+2KDHcUrFaya+i3HBHPpXjFV+6WrOzwhZPm9DdQ0OhYl+kVk
	2qHg1igMBl/te2D3+cCqU2z7CqVErV3GDFmF7iUwwelpN6OviRMe
X-Gm-Gg: ASbGncsoCD7KkOBNPgqHgtFVyg8AwlepFZZOaXPmnN1je4qtpcVTcQngX8PK+sl3uZC
	/+2Lmwosz0/IXPDT7d6kdqihwr2f+OzzjBydRDvA/ScJKUNeSfA5v6ljFAWLaBdl3PWwRfxS5o3
	qBExxAL9UEwlt9a3E6kHmlbaRRlVvzLbpL5tn90ojg01ROgeHCYoajHMnjdCn4ARdBPHoyoqpE2
	gNdBbwTge5vbSdIvMSScxSRpF/sgrOqZ2Ejqe/jOHx9ztl3Ub5cE5P5OwbXtCRs6j58eF2lt8eV
	NJ5ggn+/uYoXjitkBrr7vndidPp4myiQxm6Wzc6CFp4xOLMje69XpIC4H1yvkod3Ns5jpL16kdI
	VU1EdqblFgSuDlGF71Bnp5pEebWP7ccNbUKeO9Q5U
X-Google-Smtp-Source: AGHT+IHIWe95ox3zt/ZzG1SW9KG/4OtiRl2M/Zxq8XMDH7/fn4wU67Qk37R3LtB/fXEZes0qT3Tkkw==
X-Received: by 2002:a17:902:ce83:b0:227:ac2a:2472 with SMTP id d9443c01a7336-22fc8c83d38mr230587205ad.28.1747094782102;
        Mon, 12 May 2025 17:06:22 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:21 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/5] Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
Date: Mon, 12 May 2025 17:06:00 -0700
Message-Id: <20250513000604.1396-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250513000604.1396-1-mhklinux@outlook.com>
References: <20250513000604.1396-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

vmbus_sendpacket_mpb_desc() is currently used only by the storvsc driver
and is hardcoded to create a single GPA range. To allow it to also be
used by the netvsc driver to create multiple GPA ranges, no longer
hardcode as having a single GPA range. Allow the calling driver to
specify the rangecount in the supplied descriptor.

Update the storvsc driver to reflect this new approach.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c       | 6 +++---
 drivers/scsi/storvsc_drv.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..4ffd5eaa7817 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1136,9 +1136,10 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
 
 /*
- * vmbus_sendpacket_multipagebuffer - Send a multi-page buffer packet
+ * vmbus_sendpacket_mpb_desc - Send one or more multi-page buffer packets
  * using a GPADL Direct packet type.
- * The buffer includes the vmbus descriptor.
+ * The desc argument must include space for the VMBus descriptor. The
+ * rangecount field must already be set.
  */
 int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 			      struct vmbus_packet_mpb_array *desc,
@@ -1160,7 +1161,6 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->length8 = (u16)(packetlen_aligned >> 3);
 	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
-	desc->rangecount = 1;
 
 	bufferlist[0].iov_base = desc;
 	bufferlist[0].iov_len = desc_size;
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 35db061ae3ec..2e6b2412d2c9 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1819,6 +1819,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 
+		payload->rangecount = 1;
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
-- 
2.25.1


