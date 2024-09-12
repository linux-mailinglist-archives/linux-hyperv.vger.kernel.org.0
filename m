Return-Path: <linux-hyperv+bounces-3007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818109773A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 23:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD14B24000
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A661C3F05;
	Thu, 12 Sep 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Afd38TyL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1981C2441;
	Thu, 12 Sep 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176499; cv=none; b=jBdQQ3Kifm3hD7bgApF60emgzbPLkGS2J5s/Oz+MEwBfxA9ibWSCOCsnYqcN4TBYBhkvTjv9TalZza7zYmsGC5cLb9432pMfKWFFp8PRIa4NLLsIPW5Ug+UxiQqpaTVKYqGbPIoOyrHK5t5CJW5N/my6mGIOOS52N41SikZH07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176499; c=relaxed/simple;
	bh=JIwb2fxdGTCY3ZXiwAi/IPPzke29FwK/r3lMIvWGaOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n6XdQ/4QG49pJLg79/MlGtd6aQKGeIvtCwGgZW1ggSNPKSMOgdyac0xKV4O8uqPLnCRfpY5rFBJKcLxZRZfKI/LnwQsNCpdv5Y8M3O5rD6soaKiGsg+sSEMj2L25MF0nApovXbEy/c8MaafQBY5sA9ol2lhDixVAjdMeQbsp8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Afd38TyL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 817E420B9D5D; Thu, 12 Sep 2024 14:28:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 817E420B9D5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726176497;
	bh=1HKlBTJZg9nod4uf/oOpvVXZP9gG3UTdC9IPlLQXrZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Afd38TyLkkLjLkIGzvfXBgV3/b/x2qun2JHpgvSu1zzjg9ZlTJB0ep02B+QF/iLaI
	 EsLIWejM3IaYvHdBpMUwLn1MbOFrJfc8guKUwoAL1Nl+l7vd6XBau8lvAOdMzF2IrM
	 OZGFRGo2zJ+As60j8acfpuiIJS2guL2CG4ybkVVE=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH 2/3] Revert "Input: hyperv-keyboard - register as a wakeup source"
Date: Thu, 12 Sep 2024 14:27:49 -0700
Message-Id: <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.

Remove keyboard as wakeup source since Suspend-to-Idle feature
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


