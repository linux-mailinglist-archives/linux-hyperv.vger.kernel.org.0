Return-Path: <linux-hyperv+bounces-1417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0388D82B368
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0281F22A0E
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811D51028;
	Thu, 11 Jan 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtnrJ0IG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27B4F8BF;
	Thu, 11 Jan 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d542701796so30062135ad.1;
        Thu, 11 Jan 2024 08:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704992108; x=1705596908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BY9LkQc7H0xc2ozs1WXl/5ZEHgn4Jzym12IkkPi6Elk=;
        b=XtnrJ0IGs8WGKZ2icKIyT1rXgumqGW79AM8KwcQcb+UlFvPEz9zgZgTmwILdvRPNyR
         DLbwxLizVA3BXk538JOYevi4QunQo39IGXcmXTrzxjqyFtyTkNIvPZZ5Y0Y/VAEcBBRn
         0CMe/V/3UcbXr4RiDuAf2yWOSBJIH6uUJu9gzS8FimauJV7ORmjyFiMxoBkc3kvSdLCE
         DH+UK4NFnLOQigTmdPvAilqw3vqH0sOKS+dcTR6L8b649hs459/P6GuQx2O9Z6yyjuvv
         I4H0PUuuUG3rhUm7J9PmqLFlrTIz2FVGBzDzt9pVLUg46O2j0ZX///7f+JPAWqhgJyFa
         dBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992108; x=1705596908;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY9LkQc7H0xc2ozs1WXl/5ZEHgn4Jzym12IkkPi6Elk=;
        b=rDPvbCTEzMCDwA4X2f660blOfoMCzxLsO67vnTLTcexG/RQCEqtcEk9X9mA3M3mfa1
         /cZ+EVXUoJxehyTmeow8AUPvoH/+E9LDv+VUDG9YWRXNN4P6ge/Y6AQdSMkbRmANkoD9
         6aZQ4fvhoYtYSUnyIIH10wgHu9T5+gRxGHqM/G5ShQxM0l88rDz3uhqMopXSM6zAXJLW
         wvu86p9Ncxvo4lMxiogmKW++aNeYCipx0OW8rvrcHz/1W57Mt+hlfZBOk0SU6itFB5ug
         YdCAw3Wo44ljgMvbazCSa0g7J04oL8twJ12fSbxIfDSl6oabxQs+0r8zSf+tU4bKcR0o
         vhRw==
X-Gm-Message-State: AOJu0YzQ1bl59/ix4Nn+9Gyf2/Fqlbjt87Bgd1LRFfLOzXuJtj1TOQLY
	uuixTgRDno3t4AoGFRTLh3Q=
X-Google-Smtp-Source: AGHT+IGBavDrDFFH5bjY5F9kG55VrmkEm6oJlI+mcVNLOSsEcb7HsuQEyTI05EKLNiuWSnua9ckYIg==
X-Received: by 2002:a17:902:eb8d:b0:1d0:8352:b71c with SMTP id q13-20020a170902eb8d00b001d08352b71cmr10502plg.5.1704992108348;
        Thu, 11 Jan 2024 08:55:08 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id km16-20020a17090327d000b001b7f40a8959sm1386563plb.76.2024.01.11.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:55:08 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	dan.carpenter@linaro.org,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup code in create_gpadl_header()
Date: Thu, 11 Jan 2024 08:54:50 -0800
Message-Id: <20240111165451.269418-1-mhklinux@outlook.com>
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

create_gpadl_header() creates a message header, and one or more message
bodies if the number of GPADL entries exceeds what fits in the
header. Currently the code for creating the message header is
duplicated in the two halves of the main "if" statement governing
whether message bodies are created.

Eliminate the duplication by making minor tweaks to the logic and
associated comments. While here, simplify the handling of memory
allocation errors, and use umin() instead of open coding it.

For ease of review, the indentation of sizable chunks of code is
*not* changed.  A follow-on patch updates only the indentation.

No functional change.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---

Because the GPADL messages interact with Hyper-V and use
PFNs, I tested on x86, ARM64 with 4K page size, and ARM64
with 64K page size.  All look good.


 drivers/hv/channel.c | 54 ++++++++------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..604f5aff8502 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -322,21 +322,17 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 
 	pagecount = hv_gpadl_size(type, size) >> HV_HYP_PAGE_SHIFT;
 
-	/* do we need a gpadl body msg */
 	pfnsize = MAX_SIZE_CHANNEL_MESSAGE -
 		  sizeof(struct vmbus_channel_gpadl_header) -
 		  sizeof(struct gpa_range);
-	pfncount = pfnsize / sizeof(u64);
+	pfncount = umin(pagecount, pfnsize / sizeof(u64));
 
-	if (pagecount > pfncount) {
-		/* we need a gpadl body */
-		/* fill in the header */
 		msgsize = sizeof(struct vmbus_channel_msginfo) +
 			  sizeof(struct vmbus_channel_gpadl_header) +
 			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
 		msgheader =  kzalloc(msgsize, GFP_KERNEL);
 		if (!msgheader)
-			goto nomem;
+			return -ENOMEM;
 
 		INIT_LIST_HEAD(&msgheader->submsglist);
 		msgheader->msgsize = msgsize;
@@ -356,18 +352,17 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 		pfnsum = pfncount;
 		pfnleft = pagecount - pfncount;
 
-		/* how many pfns can we fit */
+		/* how many pfns can we fit in a body message */
 		pfnsize = MAX_SIZE_CHANNEL_MESSAGE -
 			  sizeof(struct vmbus_channel_gpadl_body);
 		pfncount = pfnsize / sizeof(u64);
 
-		/* fill in the body */
+		/*
+		 * If pfnleft is zero, everything fits in the header and no body
+		 * messages are needed
+		 */
 		while (pfnleft) {
-			if (pfnleft > pfncount)
-				pfncurr = pfncount;
-			else
-				pfncurr = pfnleft;
-
+			pfncurr = umin(pfncount, pfnleft);
 			msgsize = sizeof(struct vmbus_channel_msginfo) +
 				  sizeof(struct vmbus_channel_gpadl_body) +
 				  pfncurr * sizeof(u64);
@@ -386,8 +381,8 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 					list_del(&pos->msglistentry);
 					kfree(pos);
 				}
-
-				goto nomem;
+				kfree(msgheader);
+				return -ENOMEM;
 			}
 
 			msgbody->msgsize = msgsize;
@@ -410,37 +405,8 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 			pfnsum += pfncurr;
 			pfnleft -= pfncurr;
 		}
-	} else {
-		/* everything fits in a header */
-		msgsize = sizeof(struct vmbus_channel_msginfo) +
-			  sizeof(struct vmbus_channel_gpadl_header) +
-			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
-		msgheader = kzalloc(msgsize, GFP_KERNEL);
-		if (msgheader == NULL)
-			goto nomem;
-
-		INIT_LIST_HEAD(&msgheader->submsglist);
-		msgheader->msgsize = msgsize;
-
-		gpadl_header = (struct vmbus_channel_gpadl_header *)
-			msgheader->msg;
-		gpadl_header->rangecount = 1;
-		gpadl_header->range_buflen = sizeof(struct gpa_range) +
-					 pagecount * sizeof(u64);
-		gpadl_header->range[0].byte_offset = 0;
-		gpadl_header->range[0].byte_count = hv_gpadl_size(type, size);
-		for (i = 0; i < pagecount; i++)
-			gpadl_header->range[0].pfn_array[i] = hv_gpadl_hvpfn(
-				type, kbuffer, size, send_offset, i);
-
-		*msginfo = msgheader;
-	}
 
 	return 0;
-nomem:
-	kfree(msgheader);
-	kfree(msgbody);
-	return -ENOMEM;
 }
 
 /*
-- 
2.25.1


