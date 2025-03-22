Return-Path: <linux-hyperv+bounces-4675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99406A6CB87
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Mar 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0629F3ACD1D
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Mar 2025 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E316DECB;
	Sat, 22 Mar 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlyUtzfg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213C42A95;
	Sat, 22 Mar 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742662042; cv=none; b=kJwqeOMW3k1VQgjUZ1GAJg8Xnme8Lc9CV4a/te69LWPI6bcroabOlnK0yZ4gzRVhHzJ0P22LyMSL5x7J/mWYHwf9+Pm8B008z1IaavVVJhfOr3UWZNgBg9qT4fO26X0QuGLcuzS4euz57S3GkXsaDzUnQkt6C336ZIGiTxjux/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742662042; c=relaxed/simple;
	bh=x1Hxu2NqB091ZMTTEHQh3QdoMEAvMoFfMHZylr0YIDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBeDP+cOVFP6im/A2Oj24DPB4cTtnp3p593cOPgFpt9VUea9/hLWlGh5C7h71TWwa0m/mZAhWNQzPzSgw8HH8hlBr8R2DBCexx7JpdfUEqbC6ByZFbn5ua8l54qSn8SITnThB/x4w1sfxS19aLQC4PIM/c8G/Kxu9qq3lyZl+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlyUtzfg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so33023855ad.3;
        Sat, 22 Mar 2025 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742662041; x=1743266841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oZWghiNjAlrtNJFVehbVZflo2MEg7y9K6aALaJ0B68=;
        b=JlyUtzfglolmMlOmn4qDoQT66HQeD6HwRz+PdAcAMfaxSmnMHD+bf3es0set89QdvB
         ggmYRil4Eu7O8++wzjPtrcKnMjs1ZYQjKESzYbQ5gD0rWEzdnj8P4tziPtYD5ENGLy29
         PPtEDYiefeAuDYAmb6JpFOPkoOCaN2F0GQxnmuxZPNgCtAomDGNFHPystLKCCZF1e6M1
         Kl5BccdcBVTNJPlYsuDqcx7DHGTWPn86/Do292ApBxGU4eSCkhEp5vFifuSx0l5eeLX0
         NE6Uwcwqw8FCKPHEhwLI/3pGXLBa7pGZwHm3TBhTDUfR+mFFdLfxxaceZuURVvu5fLd8
         RivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742662041; x=1743266841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oZWghiNjAlrtNJFVehbVZflo2MEg7y9K6aALaJ0B68=;
        b=MLkh8IGjg/2i1bkBvFd9FuAj/KsRWNDKXHNr57UizK9V8BxqId3dNx0OLJ7Qxdtm8Y
         LsgJAN+DPvWKiZHAhG73okg9Q3MIF+tnG+Bdie/eKwtUSyz3r5byU08Ab2kHA4VfhUk1
         4yJ5TPFbC7kS8Mshbxrri1m5mC+gUNa/XnplkByBBM7ExqRU7smmVfRipYc9ri9nLvFQ
         zvOvJx4MCtdE2b+SccQn8hFKXKMMnvYauxiMZviiQJYxD/qP6L5gH15i1JT/cT0vdAej
         niORcq8kNCDWVJ5/g3ZNvVWKDZwzP3JtA9G0HeCAQpRcQAV11hvfintH+KuKk6avSwas
         GMcw==
X-Forwarded-Encrypted: i=1; AJvYcCXMpNh8WY9W4Xa1O1b0DeJKo+7XtGFXkH5rhaa9nggxQxNo07mEmp0K3WqCqKnURCX5AjZ3ZPng1BksbkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxV/+xc9O+iLQWnshz++6oneE5J2PnPD5YpNZb3B6F+8hq3F6e
	BNzNIAsxMUdjw9x837Cx6kFZfsXIOlFc2QmCvQazz33vivGHHkNQ
X-Gm-Gg: ASbGncvuIaV1h1gWnCNrKXqtOtpQeM/qlrJWKs5PGHJ0VpEFR51XWylX+7d3gkNh/Kb
	wR5kZIAMxKMzeP36L0Q9R0sjYMBpE29fEKRVPrsMYQqOAvcD+moK9zGV2iELxrUIA12a9sgHfM9
	oI/G1W4yPhpOtu22EV2ubrQSZcfZSVK/8zMjzfgmXTkUlSh35D6L26WJstrMiFCSxOvVOi4tmF1
	NSb2vARgUyhDB6R25Cw/jKmtyL0pdE7mz1HAJiqx475Sw/RkfF8yB96buqNVJV7TwHwplPm+UZG
	bw9ADeFkUs135lAJqU4DP8mB2rQpPeZAyYUvilGF3bFUqCoLJB7AOIum2Y8CHgnLEpB3u1XkpDj
	1JitJXoiNN+vaHPUKj1/sXlRYhnY=
X-Google-Smtp-Source: AGHT+IF9f+O6T6I/yyZTflx572MZ3X35rrNAF1uc+QEq5g6l1n1zYIC84y61RNeO5oIZdK4izvg0lg==
X-Received: by 2002:a05:6a00:1393:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-73905999e30mr9691143b3a.14.1742662040423;
        Sat, 22 Mar 2025 09:47:20 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e5c2sm4381645b3a.172.2025.03.22.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 09:47:19 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: malayarout91@gmail.com
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH] tools/hv: Memory Leak on realloc
Date: Sat, 22 Mar 2025 22:16:47 +0530
Message-ID: <20250322164709.500340-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analysis for hv_kvp_daemon.c with cppcheck : error:

hv_kvp_daemon.c:359:3: error: Common realloc mistake:
'record' nulled but not freed upon failure [memleakOnRealloc]
record = realloc(record, sizeof(struct kvp_record) *

If realloc() fails, record is now NULL.
If we directly assign this NULL to record, the reference to the previously allocated memory is lost.
This causes a memory leak because the old allocated memory remains but is no longer accessible.

A temporary pointer was utilized when invoking realloc() to prevent
the loss of the original allocation in the event of a failure

CC: linux-kernel@vger.kernel.org
    linux-hyperv@vger.kernel.org
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/hv/hv_kvp_daemon.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 04ba035d67e9..6807832209f0 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -356,11 +356,14 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 	 */
 	if (num_records == (ENTRIES_PER_BLOCK * num_blocks)) {
 		/* Need to allocate a larger array for reg entries. */
-		record = realloc(record, sizeof(struct kvp_record) *
-			 ENTRIES_PER_BLOCK * (num_blocks + 1));
-
-		if (record == NULL)
+		struct kvp_record *temp = realloc(record, sizeof(struct kvp_record) *
+				ENTRIES_PER_BLOCK * (num_blocks + 1));
+		if (!temp) {
+			free(record);
+			record = NULL;
 			return 1;
+		}
+		record = temp;
 		kvp_file_info[pool].num_blocks++;
 
 	}
-- 
2.43.0


