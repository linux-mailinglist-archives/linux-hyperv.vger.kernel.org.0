Return-Path: <linux-hyperv+bounces-8057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65DCD0D53
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 17:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F99B31E1AAC
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033C350D52;
	Fri, 19 Dec 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlyUXmvn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B3350A1E
	for <linux-hyperv@vger.kernel.org>; Fri, 19 Dec 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160523; cv=none; b=B6oMoxxCNWH8bUvlKH/GwfcfNTCRWy+kkjbDgb2HFB1DGYI7zT9TJDkWj0nc1Ki7TQWbuBjOZk+XLR9CohoT25/re4T+6hyWH94rhBPFW49SMfjXDwnWhwTBYkGEttzZC6cHBoYgbza496XFRtGmGIEE9DtkmHps6/VoKaT1PmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160523; c=relaxed/simple;
	bh=LladhLvwRMWhA8vGb+dOSlzPqutFbgYvVLti9ZD7ET4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=R2GmAaW3cLRV68cXo+Pp/qP9jQeU0sOMk6wjXesZ/oLwwoo+Xxop5lMqtayd7R+Vg7+n9rzcN90E24kqQxpznGYrvcDrPWtSdedhZeGNlkZQlDEq7Gg1oP+ysDzFGv1zh2DM7kUtD28C1/eR6hL4Z3jOKkd+uOkUc1URaZSAZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlyUXmvn; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0834769f0so18285495ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 19 Dec 2025 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766160521; x=1766765321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMjHkQgefsgKMNiMw1uK49UtpaTPx9PY394Kz4+AQqk=;
        b=HlyUXmvnTCmkzrh2CltaqvT0jRvH6PNJFmDhC/FYJJgKwpfdDa908Zz04TATcVoWmX
         7y/OnE54LM7ONkwW71uVac5djlEJtjSrxYtDcRZvvzuB8bED83uIuGoTwP+SeX/EY3CZ
         Rm3Fu2TCSW+NhMZYDsdzHc5tV49N4HKH28yTeZwE9aJwjr36Ngy0yMfnJ6prbdgkbJ7O
         to/0EyrMzg6If+fYzrfdg9Ncq+5r9S0AULlx83wuGuIgqCjsJWm8LLE6vSGcF9GqGFHl
         4H9J7RgovmvVwaAXLcSm3VLZJka4eHQKSE3UcLihodvmnX9Twcl5SGsA4qnvrf+xI7vD
         7s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160521; x=1766765321;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMjHkQgefsgKMNiMw1uK49UtpaTPx9PY394Kz4+AQqk=;
        b=TG7mP/suQ7mvmYJcb/LJLa2YqxTmlbNPkTdSfj7+S5tcWw8NPSAf/FTjixKE/FdF3T
         44TUg9Bo26Qjd8xigjDv3ZsDrs7ttAJ1tPDuk3hyqUllFeysUGrqXrhn4Zn0qTQDkizu
         f+1bXyVZ+EW7ezKEE2oT9mPYgy0KKTA0YUqDbiPoikmVDAcGY9AFJeHQ1Qxrh9Nq0TB8
         DT3tqWQw8DZR9ZvVREMnK8CwjM70K6lYJhdOBzS7dT/s7hYynUiU2O6jU8ILgRDWol4a
         mJPtG3hd6SlNF9SWDKQI6HxDRsnTui8PxtwLAQtvM+8/ftvDpNauxfUCV9gUxZbLWmtL
         +Neg==
X-Forwarded-Encrypted: i=1; AJvYcCWq2RTo4M/PuCxIi/2Klf9ESJkpg0xDGpgzU4W2Xab/NitkrAcs/NlUG6lbeV3AP7FdPTijMioT0FubLFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1raCEaTTykRtFMYuZJRTbyVIe4TpWJRSFV3p/MV1Dvk9OVwW
	gWqsxEvUnh0p88vUZyI/HCSEoQAOb6tVM/342rbTsKeqQUaBtsX7MzNW
X-Gm-Gg: AY/fxX4RNTP+l/BIxnsyvvEeyno28v1jGpQ3bHJSVwlawWvSRRKSwrDTyOHhVYTd03M
	xGGHPAlYTHWIfWf/Rm9fHtPEaFZ1QckRaBbcnSrJ6gdglXvvN6mu8+Z9yj2+TgS+A5P70TNGG7B
	GpYmXBpkBJyGp4pQ/56DC/zXkx26O2snh5kdN0B4bRpYqvc/uqXRCvPlin05Aix7LFpAUH1+Tg5
	0RdqzHx6fDkY8bZgI2nLGsU1e0fXklo0YNHfFBGBOsZWjJtdxPJT6Neo1ciWQGIMd2Al8MBtD7c
	E50ypvVxQUc7qRVySONu92cCqYAPAC8wnY77xJLCJsvAgcsvUKRX0DWn1USzRiKpf4NERXfDlLX
	HjH4yWiDRbhw/SqJr8nkU1T/rcpFNT5WhprL+a14lLVrvrQT3dtMH27Lzgv9XUwZAYe53CXsV91
	305zCr6Bx2ZXUYyxNibpQFTCT8HOwCVYBo36JE//qVWfcIg0djWD8BWPh0DKD6PRQT3w==
X-Google-Smtp-Source: AGHT+IFL4JzuGa8U7btTbb/2CeaC/I5S375hPppiUk8LVW3VtrA7jLwJS5y2cbwGa1+cXTgyvr0QHA==
X-Received: by 2002:a17:903:1a68:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a2f2422906mr34105005ad.25.1766160521059;
        Fri, 19 Dec 2025 08:08:41 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66bd3sm26625355ad.1.2025.12.19.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:08:40 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in hv_msg_dump() if CONFIG_PRINTK not set
Date: Fri, 19 Dec 2025 08:08:32 -0800
Message-Id: <20251219160832.1628-1-mhklinux@outlook.com>
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

When CONFIG_PRINTK is not set, kmsg_dump_get_buffer() returns 'false'
without setting the bytes_written argument. In such case, bytes_written
is uninitialized when it is tested for zero.

This is admittedly an unlikely scenario, but in the interest of correctness
and avoiding tool noise about uninitialized variables, fix this by testing
the return value before testing bytes_written.

Fixes: 9c318a1d9b50 ("Drivers: hv: move panic report code from vmbus to hv early init code")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/202512172102.OcUspn1Z-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index f466a6099eff..de9e069c5a0c 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -188,6 +188,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 {
 	struct kmsg_dump_iter iter;
 	size_t bytes_written;
+	bool ret;
 
 	/* We are only interested in panics. */
 	if (detail->reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
@@ -198,9 +199,9 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * be single-threaded.
 	 */
 	kmsg_dump_rewind(&iter);
-	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
-			     &bytes_written);
-	if (!bytes_written)
+	ret = kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+				   &bytes_written);
+	if (!ret || !bytes_written)
 		return;
 	/*
 	 * P3 to contain the physical address of the panic page & P4 to
-- 
2.25.1


