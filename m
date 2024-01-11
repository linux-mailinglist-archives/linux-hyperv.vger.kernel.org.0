Return-Path: <linux-hyperv+bounces-1418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060D82B36A
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 17:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CAD1C268E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jan 2024 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CED651C2D;
	Thu, 11 Jan 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3OcHp30"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909851017;
	Thu, 11 Jan 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d40eec5e12so45518185ad.1;
        Thu, 11 Jan 2024 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704992109; x=1705596909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgpEv6BM4kXZdgI8Mdlx79ZOeLD1VY/BHQeWtYs9ais=;
        b=B3OcHp30EqxI3oihAfggfwChYfbpZ5VQjCIAHgCone3MTTx7dFDZHKZYPrWInVFmF0
         T2nzBbfp/wZ7ZuSkwlxbc9P0F6ldpW4KErnclL2bO7oie4qDZ3eQbA1Dzoo3+7J2cmr+
         vRNswFUSL/SyPAbRNe8nE+MIKhaSYVNPP2vMFpwmHVageSLHsEZjDCFI1RZgeLwFf9NC
         fb9O/HqZ9GUgjRHkzltYi3CnO5YVeQKQQMRQrpuxMSYAy+ia0GI3JQbBv3mE8inqatHF
         ta50dFpwom2zNNSn5hHCX8HAP8sl+e4aAb+Wz8UCwjPTfAU7zUjZ29RL9yCw3wVSOV/w
         T3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992109; x=1705596909;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MgpEv6BM4kXZdgI8Mdlx79ZOeLD1VY/BHQeWtYs9ais=;
        b=Iy28xqTKTRnpj1s/MGxigHT1x/DcDxLV8Nu5Xzq/iMZ2t+GgENLSr5FqwohEfI/pVe
         kgHKZYyGlMgzk2dmgmJaEdGMxM+541ePKTwMcXR0HhP0aeeGslkX7nob7IaW5PGd0rWj
         yvWFEZBmKwlXnZ+0fMpZ2UwFJNStLuZEPJpIKgF037tHC2qaIniRUxE7zBCCQQ9gMSzA
         IS19/6QnVaPDRcBj+9aAD3yIjqO2qW8Qb351BDxLgHn77LaOTjfyvLOZR5DaxWTD24Gb
         ZiIsH3y/dkJztvuA9G/qaz/CrWJnzoN3rkp1WGCPuy48dcVEV/ITAJH4L0VFeHtHLhlN
         jYIw==
X-Gm-Message-State: AOJu0Yxwp5CT0bIxxjbg1kFDMYLsDEX495oOy6lPkGLPVJE4swrHr5q+
	9CGtxbmg3iP/lwA/4sbSbGk=
X-Google-Smtp-Source: AGHT+IGjHQIxalAjr6H8lF8Uv3muWVYgOPElI2iG5S4zh6TUXE3d9/dQFv6NL8GByWAUhffWtejZhg==
X-Received: by 2002:a17:902:7c04:b0:1d5:8bf4:c7b2 with SMTP id x4-20020a1709027c0400b001d58bf4c7b2mr1074167pll.88.1704992109228;
        Thu, 11 Jan 2024 08:55:09 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id km16-20020a17090327d000b001b7f40a8959sm1386563plb.76.2024.01.11.08.55.08
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
Subject: [PATCH 2/2] Drivers: hv: vmbus: Update indentation in create_gpadl_header()
Date: Thu, 11 Jan 2024 08:54:51 -0800
Message-Id: <20240111165451.269418-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111165451.269418-1-mhklinux@outlook.com>
References: <20240111165451.269418-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

A previous commit left the indentation in create_gpadl_header()
unchanged for ease of review. Update the indentation and remove
line wrap in two places where it is no longer necessary.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c | 142 +++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 72 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 604f5aff8502..adbf674355b2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -327,85 +327,83 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 		  sizeof(struct gpa_range);
 	pfncount = umin(pagecount, pfnsize / sizeof(u64));
 
-		msgsize = sizeof(struct vmbus_channel_msginfo) +
-			  sizeof(struct vmbus_channel_gpadl_header) +
-			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
-		msgheader =  kzalloc(msgsize, GFP_KERNEL);
-		if (!msgheader)
-			return -ENOMEM;
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
-		for (i = 0; i < pfncount; i++)
-			gpadl_header->range[0].pfn_array[i] = hv_gpadl_hvpfn(
-				type, kbuffer, size, send_offset, i);
-		*msginfo = msgheader;
-
-		pfnsum = pfncount;
-		pfnleft = pagecount - pfncount;
-
-		/* how many pfns can we fit in a body message */
-		pfnsize = MAX_SIZE_CHANNEL_MESSAGE -
-			  sizeof(struct vmbus_channel_gpadl_body);
-		pfncount = pfnsize / sizeof(u64);
+	msgsize = sizeof(struct vmbus_channel_msginfo) +
+		  sizeof(struct vmbus_channel_gpadl_header) +
+		  sizeof(struct gpa_range) + pfncount * sizeof(u64);
+	msgheader =  kzalloc(msgsize, GFP_KERNEL);
+	if (!msgheader)
+		return -ENOMEM;
 
-		/*
-		 * If pfnleft is zero, everything fits in the header and no body
-		 * messages are needed
-		 */
-		while (pfnleft) {
-			pfncurr = umin(pfncount, pfnleft);
-			msgsize = sizeof(struct vmbus_channel_msginfo) +
-				  sizeof(struct vmbus_channel_gpadl_body) +
-				  pfncurr * sizeof(u64);
-			msgbody = kzalloc(msgsize, GFP_KERNEL);
-
-			if (!msgbody) {
-				struct vmbus_channel_msginfo *pos = NULL;
-				struct vmbus_channel_msginfo *tmp = NULL;
-				/*
-				 * Free up all the allocated messages.
-				 */
-				list_for_each_entry_safe(pos, tmp,
-					&msgheader->submsglist,
-					msglistentry) {
-
-					list_del(&pos->msglistentry);
-					kfree(pos);
-				}
-				kfree(msgheader);
-				return -ENOMEM;
-			}
+	INIT_LIST_HEAD(&msgheader->submsglist);
+	msgheader->msgsize = msgsize;
+
+	gpadl_header = (struct vmbus_channel_gpadl_header *)
+		msgheader->msg;
+	gpadl_header->rangecount = 1;
+	gpadl_header->range_buflen = sizeof(struct gpa_range) +
+				 pagecount * sizeof(u64);
+	gpadl_header->range[0].byte_offset = 0;
+	gpadl_header->range[0].byte_count = hv_gpadl_size(type, size);
+	for (i = 0; i < pfncount; i++)
+		gpadl_header->range[0].pfn_array[i] = hv_gpadl_hvpfn(
+			type, kbuffer, size, send_offset, i);
+	*msginfo = msgheader;
+
+	pfnsum = pfncount;
+	pfnleft = pagecount - pfncount;
+
+	/* how many pfns can we fit in a body message */
+	pfnsize = MAX_SIZE_CHANNEL_MESSAGE -
+		  sizeof(struct vmbus_channel_gpadl_body);
+	pfncount = pfnsize / sizeof(u64);
 
-			msgbody->msgsize = msgsize;
-			gpadl_body =
-				(struct vmbus_channel_gpadl_body *)msgbody->msg;
+	/*
+	 * If pfnleft is zero, everything fits in the header and no body
+	 * messages are needed
+	 */
+	while (pfnleft) {
+		pfncurr = umin(pfncount, pfnleft);
+		msgsize = sizeof(struct vmbus_channel_msginfo) +
+			  sizeof(struct vmbus_channel_gpadl_body) +
+			  pfncurr * sizeof(u64);
+		msgbody = kzalloc(msgsize, GFP_KERNEL);
 
+		if (!msgbody) {
+			struct vmbus_channel_msginfo *pos = NULL;
+			struct vmbus_channel_msginfo *tmp = NULL;
 			/*
-			 * Gpadl is u32 and we are using a pointer which could
-			 * be 64-bit
-			 * This is governed by the guest/host protocol and
-			 * so the hypervisor guarantees that this is ok.
+			 * Free up all the allocated messages.
 			 */
-			for (i = 0; i < pfncurr; i++)
-				gpadl_body->pfn[i] = hv_gpadl_hvpfn(type,
-					kbuffer, size, send_offset, pfnsum + i);
-
-			/* add to msg header */
-			list_add_tail(&msgbody->msglistentry,
-				      &msgheader->submsglist);
-			pfnsum += pfncurr;
-			pfnleft -= pfncurr;
+			list_for_each_entry_safe(pos, tmp,
+				&msgheader->submsglist,
+				msglistentry) {
+
+				list_del(&pos->msglistentry);
+				kfree(pos);
+			}
+			kfree(msgheader);
+			return -ENOMEM;
 		}
 
+		msgbody->msgsize = msgsize;
+		gpadl_body = (struct vmbus_channel_gpadl_body *)msgbody->msg;
+
+		/*
+		 * Gpadl is u32 and we are using a pointer which could
+		 * be 64-bit
+		 * This is governed by the guest/host protocol and
+		 * so the hypervisor guarantees that this is ok.
+		 */
+		for (i = 0; i < pfncurr; i++)
+			gpadl_body->pfn[i] = hv_gpadl_hvpfn(type,
+				kbuffer, size, send_offset, pfnsum + i);
+
+		/* add to msg header */
+		list_add_tail(&msgbody->msglistentry, &msgheader->submsglist);
+		pfnsum += pfncurr;
+		pfnleft -= pfncurr;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


