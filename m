Return-Path: <linux-hyperv+bounces-5481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5848AB4833
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3638C46DB
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEF537F8;
	Tue, 13 May 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwtEr5YB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248271CD0C;
	Tue, 13 May 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094787; cv=none; b=m9Pf3F4qEYZNHzief8r6zJma/2O1nAoL2eXFqTNzkh/iP2NTjZ3c8vew4mOEbs4O9h14sKQQwcUNed7E0KRVSuOb8JqGqhVoVsYaE0J084RWqtA1a+NF0NG7W2AxqJGBd2sNr6ZJ3VtEbsY6oxfI78qNKKdGQJpFCfjqxL8OJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094787; c=relaxed/simple;
	bh=VmgqKKYqwuDqT8GL2s3Gll3zTEUf6vjQUTkvOgII1zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knKzlHEu7YahoOdij3r/U0dIZwD687i8CmR3TGFwP2qc/NY+YUiMCciQRtpL2/4vKdYZyyaXP6yOEOe2DfV7wptPqDeouW8vB8Hp58toXyFBpPHdgu/sJS350vpTDfOrC12MBLwrq+ppv8zUX9S2M5SvZtE07eDGN7ppnrbHVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwtEr5YB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22e730c05ddso45739205ad.2;
        Mon, 12 May 2025 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094785; x=1747699585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1/dEAWJwnzGJroYQuZwyw96GLa+9EYPpLfplVYwHAUM=;
        b=OwtEr5YBtvfQ5UO7HDD5B7cJcOKxkBSTpi/P5d48HdE/WiMltx7KG9huaWzCCIiWi9
         aaZGf9SCcBVba3JJOWGa9n8x20sFur3DXVwqLhpE3ht9P2PnJP0Pgll3Ix71SZ2/2Em2
         X5YV1BMw04xGunsVMyUav+xp1Bx1w3pDJuKg8zouS/Nadl9JUlpRlk819sv7RkPaKy8o
         RKEPVaiUvk23Ky/xTaNNSIKRz+G4TvMhVtfUMm157Bsp9KaluqBkha0Hq2zcMVjSa35W
         IffQPvWEn2WOpwrnWIkD5IgHyL5I8bMMO3JnNT+TTJ/L8sYud9wSJOPRUztuCGmmvlF3
         MtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094785; x=1747699585;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/dEAWJwnzGJroYQuZwyw96GLa+9EYPpLfplVYwHAUM=;
        b=RpzqKzwCiY9mnrwENCxgrsH6tlKJnHzltpzOc8xL2QJ1V3HAFVF0fhWRtTXDdfrBPq
         CEWYNG714zmygBKK5I9w4vAFOKDspRcoFk4W5boVMG5ZGt375DEh7HDIuGGvzod2n20d
         mWJALf6mSDzCf+gvSGuQlRteyJpNllyzwwR2odRgCWNu22ve7XgYdNHBpoEEz026WS2F
         85Wc4HNaR0NCvgXyjj0Qst+S82RzjilQK01Wisal/1mQVYYuEElhhlGKx/ut+ycIicND
         LO2O40hUXMB7rcLWmvmDhgPvHuBmC17IqF6nZz8Rhm33lnZ13meLK83ksNdl9GnPONEB
         /X3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJhlVfeFhCY+k4Ujm8TvO1mZ+0YP/ZlkPBNGTdOcfAtZDGPBceY6bySG3Z3ehAeiLo+K2460XTmD/PFnM=@vger.kernel.org, AJvYcCXDx1OtZuuDNLSia3RXySMphQArP6fBCo0UsdJAShuTyW0PB5GncneCaDbL4KW6ScF0wXszGZtm@vger.kernel.org, AJvYcCXZ/bBp6lEKF8ptwq8GCjsvCJT/kzCZbv34OdRK7F6GI/4DTxFCMF8RdfpNSAcablC7tMnrJk+9@vger.kernel.org, AJvYcCXpnevbKY8y+dkuUv1Iw6a8+TiqzE3Yw4iLlNEFRh2jPKChgRv140b5TWjAlxRt3uLsk8fchiZw1483Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKBNO24nm5E0h1pauQzo3/zzT1SDB3m+Xn4Vpw26MhwYtdoZl
	6wwrskd10MofWRlyZq/tJ0T1OLGobCLJY3ebsQ7nIHJJ90v+McuM
X-Gm-Gg: ASbGncvXmJ/GPWkuyQe3+lNNv5olepJ654x7Ts5WULlX1KmSTFJSPVfgF9UjE84ve81
	OqLFDJeXFzpUxaajpu6W8+DGlO6nQcCKQ9K9JKiJuaVQCFoHd5TKOPCOBcL8LlZ/GAEsqJtrlh5
	s9U1DkZhtzday+RxjPSItgxgnnBRKzXfjMoHsdOjxzp+6abztQaM7RLK4iYz1TANxwTKpiL7guh
	cwdr8FlkqfcCpLVtHtsY4CPKLTIprx69bmf+ltEK14yGMhp0B6q30Ffz4waGFOPTTgZ/sG63IRH
	ecpiayXVrfNzpc/dBkTagtU341uwc7C3sqrmcFLX2/FXNnknfAV5+cW/UNydCtPk/whOP+BADps
	cmYvPRYwNtGxqE+77LPOO+DSSE3VuKg==
X-Google-Smtp-Source: AGHT+IHTotbGNpWEp+9dh8Q2BnZLuywz176C9RGAHPZaKRManN25KNn7wGf4VUMAP5Icy6sXzPhtbw==
X-Received: by 2002:a17:903:988:b0:22e:5abd:7133 with SMTP id d9443c01a7336-22fc917f836mr191850515ad.45.1747094785305;
        Mon, 12 May 2025 17:06:25 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:25 -0700 (PDT)
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
Subject: [PATCH net 4/5] hv_netvsc: Remove rmsg_pgcnt
Date: Mon, 12 May 2025 17:06:03 -0700
Message-Id: <20250513000604.1396-5-mhklinux@outlook.com>
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

init_page_array() now always creates a single page buffer array entry
for the rndis message, even if the rndis message crosses a page
boundary. As such, the number of page buffer array entries used for
the rndis message must no longer be tracked -- it is always just 1.
Remove the rmsg_pgcnt field and use "1" where the value is needed.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/hyperv_net.h | 1 -
 drivers/net/hyperv/netvsc.c     | 7 +++----
 drivers/net/hyperv/netvsc_drv.c | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 76725f25abd5..cb6f5482d203 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -158,7 +158,6 @@ struct hv_netvsc_packet {
 	u8 cp_partial; /* partial copy into send buffer */
 
 	u8 rmsg_size; /* RNDIS header and PPI size */
-	u8 rmsg_pgcnt; /* page count of RNDIS header and PPI */
 	u8 page_buf_cnt;
 
 	u16 q_idx;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 6d1705f87682..41661d5c61ab 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -953,8 +953,7 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 		     + pend_size;
 	int i;
 	u32 padding = 0;
-	u32 page_count = packet->cp_partial ? packet->rmsg_pgcnt :
-		packet->page_buf_cnt;
+	u32 page_count = packet->cp_partial ? 1 : packet->page_buf_cnt;
 	u32 remain;
 
 	/* Add padding */
@@ -1137,7 +1136,7 @@ static inline int netvsc_send_pkt(
 		u32 desc_size;
 
 		if (packet->cp_partial)
-			pb += packet->rmsg_pgcnt;
+			pb++;
 
 		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
 		if (ret) {
@@ -1299,7 +1298,7 @@ int netvsc_send(struct net_device *ndev,
 		packet->send_buf_index = section_index;
 
 		if (packet->cp_partial) {
-			packet->page_buf_cnt -= packet->rmsg_pgcnt;
+			packet->page_buf_cnt--;
 			packet->total_data_buflen = msd_len + packet->rmsg_size;
 		} else {
 			packet->page_buf_cnt = 0;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 929f6b3de768..d8b169ac0343 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -343,7 +343,6 @@ static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 	pb[0].len = len;
 	pb[0].pfn = virt_to_hvpfn(hdr);
 	packet->rmsg_size = len;
-	packet->rmsg_pgcnt = 1;
 
 	pb[1].offset = offset_in_hvpage(skb->data);
 	pb[1].len = skb_headlen(skb);
-- 
2.25.1


