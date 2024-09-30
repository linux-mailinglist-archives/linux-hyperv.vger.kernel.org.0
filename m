Return-Path: <linux-hyperv+bounces-3088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802C989C59
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A6D28153E
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24B17A584;
	Mon, 30 Sep 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mCxztwcA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC2183CC5;
	Mon, 30 Sep 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683953; cv=none; b=jcl8QFwyi60gWsF+p02sPHNLZCnpvMRh7nr0RKgpt+amVhY2y4BWtnugojb8gz/dlywLiBlxZDJNdc1sRTF9Lo6hBQnYMAQRyKiQWKdiKimIz8jR0kghWlLJjSbQBhHSxllBJ97ejKzsEIZeD3i3FiKayFNNmqfqDcd0SZXcslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683953; c=relaxed/simple;
	bh=mRQWu9Qi60Rm069HxpdDnlMKyQWzItHFvKHZXcTx8kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UZ7Pmn9nU0LcnLeWSMs4Cz8elYy5wgXO6IV8P4/hahOs5LWuXjSlSYnZvSzy9r1hGSW/QMiMWRdFjd7On/zT/1/IJU3BqGMqJrp3VfB/EtTDWytACMnEVQPYUcrx/zvcgL+UdHTkO1JdAgtJ6lkRWLsaEBU4ORbxaLa1o4LsApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mCxztwcA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 86D9920C8C63; Mon, 30 Sep 2024 01:12:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D9920C8C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727683950;
	bh=aJfcW+SnLrtO8B80Y7aKM3iIgHe2LRVFhMf8g7MibuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCxztwcAbN05peCzD6y9PHK/AUWHmkAHDM12qfDJxOhC4Cd9Pcd7ZwLZUTdPhdtp0
	 cdvXzXhr4U+1IHelAUlpcwTwkXTn2oJ+3B5pRTnrpyjO27zLib915IxUJm9VEN3PyD
	 xiq5qLdPFi+ZjinTUrtIMTIjbZ+EtxSqUYp0esKU=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	mikelley@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v2 2/3] Revert "Input: hyperv-keyboard - register as a wakeup source"
Date: Mon, 30 Sep 2024 01:11:56 -0700
Message-Id: <1727683917-31485-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727683917-31485-1-git-send-email-ernis@linux.microsoft.com>
References: <1727683917-31485-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.

Remove keyboard as wakeup source since Suspend-To-Idle feature
is disabled.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/input/serio/hyperv-keyboard.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 31d9dacd2fd1..b42c546636bf 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -162,15 +162,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
 		}
 		spin_unlock_irqrestore(&kbd_dev->lock, flags);
-
-		/*
-		 * Only trigger a wakeup on key down, otherwise
-		 * "echo freeze > /sys/power/state" can't really enter the
-		 * state because the Enter-UP can trigger a wakeup at once.
-		 */
-		if (!(info & IS_BREAK))
-			pm_wakeup_hard_event(&hv_dev->device);
-
 		break;
 
 	default:
@@ -356,9 +347,6 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
 		goto err_close_vmbus;
 
 	serio_register_port(kbd_dev->hv_serio);
-
-	device_init_wakeup(&hv_dev->device, true);
-
 	return 0;
 
 err_close_vmbus:
-- 
2.34.1


