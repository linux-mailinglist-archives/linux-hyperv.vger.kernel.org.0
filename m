Return-Path: <linux-hyperv+bounces-3485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FD9F419F
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 05:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2E188C4BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4F1459E0;
	Tue, 17 Dec 2024 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LXLOJl7L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6B13DDB9;
	Tue, 17 Dec 2024 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409048; cv=none; b=XkhvMsCVUjxiTyLm7jxTGGMkw9SIE9s6wH4NnORvKjZTQlJ/rMb8RYC4jPbp/4VZsHXfu+h6R0IG+1A1YqFaqUWlAF4Fa14dc4AKq9V5SK5DrdyBxwKx0dGIWvgu5jJ+sgb0dS14SpyBxLjHv/ItNgXCUywfKcPMy+I0Wzf7S4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409048; c=relaxed/simple;
	bh=AdrUadjhSx97doxIAfVk9I6cDW4O2hldGinLswbkeIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ErKXjBhJNfdAYcBU/SL7HJOvU3WIU6hThmLQqe/aRDp2Wbxg4bb37CYmhWL2y7L9eWLXPm9tHjExYceAapT1ZRfoFvBS9CLAoDidjzGnAG6xw5XNDGGCEOQG0jCUcHoZJe4rD+jo7GgX+wU15298myeBWS+pZy2HtYYTk1j/I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LXLOJl7L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A13FB204720E; Mon, 16 Dec 2024 20:17:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A13FB204720E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734409046;
	bh=uSjkqG/GU6kBlj8gGZKTEqQn5LvmkpbdjNJqKjHZLfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXLOJl7LxeD7xxHsLpexHbFw2c3zdoiCTsRBoAuBRsaJ9ygL7kIpyngmDupEHo6Dm
	 hmdzm7KzJXBsSjavFEICWVHUXMo2B27SJNbolR6b/OROtb07Gp3s5wpoT3qzFx+Dc5
	 SMghudy+UehzWcKBGsGulVc0zt8x+gw5lcXDTi6E=
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
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH v4 2/3] Input: hyperv-keyboard - disable as wakeup source
Date: Mon, 16 Dec 2024 20:17:08 -0800
Message-Id: <1734409029-10419-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
References: <1734409029-10419-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Do not enable keyboard as wakeup device since
Suspend-to-Idle feature is no longer supported.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* Replace device_init_wakeup() with device_set_wakeup_capable()
  without reverting "Input: hyperv-keyboard - register as a wakeup source"

Changes in v3, v2:
* No change.
---
 drivers/input/serio/hyperv-keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 0ee7505427ac..b32047f36321 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -355,7 +355,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
 
 	serio_register_port(kbd_dev->hv_serio);
 
-	device_init_wakeup(&hv_dev->device, true);
+	device_set_wakeup_capable(&hv_dev->device, true);
 
 	return 0;
 
-- 
2.34.1


