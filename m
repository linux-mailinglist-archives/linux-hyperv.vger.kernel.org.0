Return-Path: <linux-hyperv+bounces-5479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AADAB4821
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3A816B3B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494FC2EF;
	Tue, 13 May 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpL1VPWO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492628F3;
	Tue, 13 May 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094785; cv=none; b=twCqwatI0M/VfHs4OEuxQAJ8K8JZ6Oof36AcEec6M99ZedH3pfXCYyv0EWDa0IMEgFeSwvtx+WERhOVok4Ceu0XtN+qGuiAPeCjBB3hSLphBfQNpu/wPV4cAwkSTe2rZg3EnGpLrxvL4SUPfLc5yd8JdKFXr1+2qDBgxbZQCH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094785; c=relaxed/simple;
	bh=8/xVulW2CSRK1+XsSobzHokLcQO2lTn+ZWudBCT/UHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDoaqV3tnWlo0kVeiQy69W3LX7eeDwxrFQI/zjCI/9qd3JVutx19nGl2uSkQegY+xSqj2qNwx8Az/so3bFhGI32QD84bAWwdk3kaDqBu7mBpin6Ipu0+e+RGPEt/XN8BUXlaTYYUqecL1ZVDO6DjjqVGufyrr2KnMyjxFA9BYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpL1VPWO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33e4fdb8so43109895ad.2;
        Mon, 12 May 2025 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094783; x=1747699583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXCvU2Vs7s7mGjO2bzsEOujhMs8/vRhZqhlIuLlVupA=;
        b=HpL1VPWOJdw8g8GUaauvwRP18hIw4UO1VIG9TxegZTRzmzNRtkbrMmMM4lJaV6MbRF
         YRXaEn/eW5ZjdzpisSU2FkTCpq+Nsr4tlh955iI1J8Br0JLvSMWdPVMjg8gJwc6a4J3S
         UsAJW4a/xVAIgzWD+UMT26veKm3MbzYMpgsBDC1qlP69gDD1+a4JWHCkjcr3pUPKqKH+
         sp9Pd+Clq2ruHCWUwF0iYOb321KKj+AbP+HGGI8Bv9Um2ufew05EIb78HZ0z7U9fn6NC
         wKlcq6pmsYX3KS7TotU1j2LqifWfEd0YguSu1pkE7oykXtnHPDxA6roFC+7kNA+dDwhw
         +6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094783; x=1747699583;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXCvU2Vs7s7mGjO2bzsEOujhMs8/vRhZqhlIuLlVupA=;
        b=CsfY1HMZHSVzMrUzx3Apb5Eo+7+DVtHkgGWe87Qsx8lCTILdVnxvykuf5nM7uhernb
         iFgo4UiO3gDjVNvCAUYujXpkDqQEbYmbdWwXx22oq5B9JCHFQLxQvgZ1JqmsRaUIeaE2
         Vn+MasGUYjfUMUeGBqJS491Qc1gpDmCk6UWf5mOUWu7rlOIk5M7fIN4d3pThqLYazhEB
         hTPYUqe2VGKxdJ+HPzb8oqjSxv/aQ3YFO5NzceixHwyA1KHLL1DZh9hZ6/G786M3eoJr
         ZT7i6c5PPvtro6qg5827f2Bvog2uJB7kz4kk9mEd3GWGoSQ6qaojqdJEwE74nGlKieSs
         OMoA==
X-Forwarded-Encrypted: i=1; AJvYcCULnwTw1iaFVAHarT70A3vjMB/SS4gm78C1eZ9zJjrcWbWTu+HC9ixZhxTqZvCauvpEhHfpekHCks2cwMA=@vger.kernel.org, AJvYcCUT9IoK61b+d8Y6P83X56qUn41Ttg8CTTqseNP1KRZ2PV89+/smN0/vMkbKydrD0k9auZmgYEvD@vger.kernel.org, AJvYcCUrHiiLdlVorzZBg7i/Zivd9S9/8KS4oreqmTW2VTEYfzoT+5zWMdxClsyz57nz9uxUVrxwBQfT@vger.kernel.org, AJvYcCWeQX4g/M5O1qEKDBf3lYs5B/C7XDDybRugLF01W0rOneMm9bQFok/jbEWe8MWqgUObYixZ0yFvo0XOog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fcA5t5N1Uq0MZVPqaXzAKAAZxJL7avPj8nuAIKO6G0QdUbeQ
	aI/PwgnwfQ6ZyMoHEEjGHdiUDPW6RVLN8Uvgk6rm3OQZvFlDtFNR
X-Gm-Gg: ASbGnctsfLAt4EVF8pTSYlPJw2Zpyc850clLW2v/55bImxlgYeeUQqlU436/RZiL/dP
	+oPhW2UnFStJfE9n46CX8xPLyday5uvFlpWI2orTpTqbRXxA1vktunIJXrnc9Iknz1oqCAJvMC7
	eBowNpHqxOSNS3uM+IPGzecIcgehPpcV48Sdz9S4yA+h9HNwtMe8hQboqEdhSA1IvKdlNEQxCVV
	y+ATzwJ6LlVV/7EdXTx2cYWvsnMkZFrfaKtvrmlxMNhkIiHqjEvAzwLwUoJbCphjBi/Ozgr/Zzl
	GLRNIRyinyaFp8WTDNCNb6+mdIifKngN8F/4cbhwYfscANPRavuHoLm6oh3cgoEvQ71tDdcc3Ga
	herLXRv4KKae1woepsKumH9UzjoKhZw==
X-Google-Smtp-Source: AGHT+IFziuIqABFOvhkhgN/xuoHGmIstOjH0r6ljTVAroISwtMFpsIg6e5wHjzk4TIlhWturAbynGA==
X-Received: by 2002:a17:902:f70b:b0:224:1af1:87ed with SMTP id d9443c01a7336-22fc8b7bddfmr203927655ad.27.1747094783134;
        Mon, 12 May 2025 17:06:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:22 -0700 (PDT)
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
Subject: [PATCH net 2/5] hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
Date: Mon, 12 May 2025 17:06:01 -0700
Message-Id: <20250513000604.1396-3-mhklinux@outlook.com>
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

netvsc currently uses vmbus_sendpacket_pagebuffer() to send VMBus
messages. This function creates a series of GPA ranges, each of which
contains a single PFN. However, if the rndis header in the VMBus
message crosses a page boundary, the netvsc protocol with the host
requires that both PFNs for the rndis header must be in a single "GPA
range" data structure, which isn't possible with
vmbus_sendpacket_pagebuffer(). As the first step in fixing this, add a
new function netvsc_build_mpb_array() to build a VMBus message with
multiple GPA ranges, each of which may contain multiple PFNs. Use
vmbus_sendpacket_mpb_desc() to send this VMBus message to the host.

There's no functional change since higher levels of netvsc don't
maintain or propagate knowledge of contiguous PFNs. Based on its
input, netvsc_build_mpb_array() still produces a separate GPA range
for each PFN and the behavior is the same as with
vmbus_sendpacket_pagebuffer(). But the groundwork is laid for a
subsequent patch to provide the necessary grouping.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 50 +++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index d6f5b9ea3109..6d1705f87682 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1055,6 +1055,42 @@ static int netvsc_dma_map(struct hv_device *hv_dev,
 	return 0;
 }
 
+/* Build an "array" of mpb entries describing the data to be transferred
+ * over VMBus. After the desc header fields, each "array" entry is variable
+ * size, and each entry starts after the end of the previous entry. The
+ * "offset" and "len" fields for each entry imply the size of the entry.
+ *
+ * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
+ * uses that granularity, even if the system page size of the guest is larger.
+ * Each entry in the input "pb" array must describe a contiguous range of
+ * guest physical memory so that the pfns are sequential if the range crosses
+ * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
+ */
+static inline void netvsc_build_mpb_array(struct hv_page_buffer *pb,
+				u32 page_buffer_count,
+				struct vmbus_packet_mpb_array *desc,
+				u32 *desc_size)
+{
+	struct hv_mpb_array *mpb_entry = &desc->range;
+	int i, j;
+
+	for (i = 0; i < page_buffer_count; i++) {
+		u32 offset = pb[i].offset;
+		u32 len = pb[i].len;
+
+		mpb_entry->offset = offset;
+		mpb_entry->len = len;
+
+		for (j = 0; j < HVPFN_UP(offset + len); j++)
+			mpb_entry->pfn_array[j] = pb[i].pfn + j;
+
+		mpb_entry = (struct hv_mpb_array *)&mpb_entry->pfn_array[j];
+	}
+
+	desc->rangecount = page_buffer_count;
+	*desc_size = (char *)mpb_entry - (char *)desc;
+}
+
 static inline int netvsc_send_pkt(
 	struct hv_device *device,
 	struct hv_netvsc_packet *packet,
@@ -1097,6 +1133,9 @@ static inline int netvsc_send_pkt(
 
 	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
+		struct vmbus_channel_packet_page_buffer desc;
+		u32 desc_size;
+
 		if (packet->cp_partial)
 			pb += packet->rmsg_pgcnt;
 
@@ -1106,11 +1145,12 @@ static inline int netvsc_send_pkt(
 			goto exit;
 		}
 
-		ret = vmbus_sendpacket_pagebuffer(out_channel,
-						  pb, packet->page_buf_cnt,
-						  &nvmsg, sizeof(nvmsg),
-						  req_id);
-
+		netvsc_build_mpb_array(pb, packet->page_buf_cnt,
+				(struct vmbus_packet_mpb_array *)&desc,
+				 &desc_size);
+		ret = vmbus_sendpacket_mpb_desc(out_channel,
+				(struct vmbus_packet_mpb_array *)&desc,
+				desc_size, &nvmsg, sizeof(nvmsg), req_id);
 		if (ret)
 			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 	} else {
-- 
2.25.1


