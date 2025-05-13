Return-Path: <linux-hyperv+bounces-5480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F0AB4830
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCFA3B75BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F43597E;
	Tue, 13 May 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqfnYomk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE78F58;
	Tue, 13 May 2025 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094787; cv=none; b=L58J1LyaJPev2pS5ELgFbhekaEE5lJlMZgsU/vh85cLWaq8yEmM7pc+W8lEmcxZrWyj/RQHhHJ1HoEaVdkAHm5rROaM4EwmhzuZ3AmPBLqAkTUWmGomZEYXuuaZenx/I+Q8WzofnN2e3YeC9BU9WroOre/Mcmt4RXPCITO9zlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094787; c=relaxed/simple;
	bh=vZfS0plRbyqQQIcbaNY4ymvGlAp3r4D8TzDQwLuOOLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyRAJybRkdtHZ1PxSwcvB5qww3X5orsNahgTzR9rmzbUqC0yIAKPhL7a+w8OEHlAZ/VTtJs54thQ28/Sb8qlIcozjzrwCsxMUcyVFInmECTYqRQTCoVS+gkCogKhUCicHfo3bCoRmgBURkTEFQlFYH2N1JB1/CShdwUR5RTwkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqfnYomk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2093aef78dso5019827a12.0;
        Mon, 12 May 2025 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094784; x=1747699584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swNi1/At9M9lQUHOHslqUPRL9lajtucPO8KagwNe5wo=;
        b=TqfnYomk0xcnv5ODlZvA3Ffdd6fbfs0sZPwui6n0rP3QDmGmoF2QhfjxuU2T0zfHNB
         Ix4xGaGeQY4K2dLh5lwtle8E9kfRUqjw4X49Qld3clPhN8Z4+d3SMsrOzHoqVnh0Bv22
         inlptGX+53wR4fQ/8sSuwK5lA3s7UkM8CY1nIbDGH655xUg38BytZYlkuWsl5FKhxYNN
         A8fV7n42LjVAWbSPWZztEgK5uYc4S6TIpeumuMTt+vX/Ff9FlSkB45ScGlm1Dq529RdT
         kHO8Qb4YriAnljGasRtEs0dR0wKysPaGWBMBedULDZ3W4KRKJi4JXvSig0Kt9lUoXXQ5
         F32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094784; x=1747699584;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swNi1/At9M9lQUHOHslqUPRL9lajtucPO8KagwNe5wo=;
        b=jfxyCwC0Ev529IMP73/0aHwT+n+MyLD7YPEs+OvsuhXGOp12wYyn9PwttNUIGah8mW
         1O79lT1vP9SiuIx623+O2+5fh937IIxGuzSvRywHNpiSL6/jyNdZQEJG26iwy9fFNj9j
         bjB+F486S/ZfNc9D4Pfgu+fq/Gz3eCdkIYORxiwKJOeGAZR2i3qMQ/ol1duHj4aFogJm
         vYXtqCO+ZqwPOCK5SgWgFuo1lx3XlNhd4gJqoccVeFGRwXdmbWvxqSMKLxvNZ3SxwJVm
         /QRSMt8Clqeo7Ay3sW/lnuaOV0LMMvilDN9LSHR5yUQkLFLBAW8xgb+hj+QdknjyhtcZ
         lHZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Aln2y58E3PguTcDu+0bb+Jaxze6IBvep/pppcRntVLDTr7995kmLeFKKFZK6gjB2yNkHK1EmuL53Nlk=@vger.kernel.org, AJvYcCVYoxHwD9A+5BbXLPFScLOyuINmrYAIb0muZ9fIYtnQzRLsjLID8rZalxI64MqZ04Sm9xSYeZet@vger.kernel.org, AJvYcCVvMzAbgeGvxukhoVars3UM4NtgDuD/tbqAbQZ+SdpvcSnx1bavWIc1CCAoiStzGbIQL7fGUcj2@vger.kernel.org, AJvYcCXaI8HbU8COXi2gFTvnZiLetV066/OaZZf9FNuVr0XxdgOd4bBoXEjJKJIY5qUr5aajJV79UgVtldW51A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hCTm5XCgk87crVE3bjdYptlUUlxQJuoKfnvZrtpVXBTpAt0W
	dyWTokRll/bVuPVS7sOg33vbMBD4fu28zdMet7t5ug69/8ex533x
X-Gm-Gg: ASbGnct+SyFakKXLedOKLqWexJ8QqQhWPQbgci6jZd2WA3TggzH3UT3hWULDrb62AfU
	E7LTfef7rK6ibIrescl6KiF6SuHYsVRpKlCt6rZ1udpYDJPkC7i0gdOQfEhudf1AAeDsyWVeNC1
	uwEYRxEoCDRCoe8vcSkIJ0JcjGgfPR6fWywyooLZKJsXSCTYP3oQN8obx8ao43ovE3rmvIKCLSL
	bZABVXoMMO6axrGUID3s+aLBEOhtg2BfyFkpHpR19kc5FRjPbDynzx90jVrQL5k3PJiQCxEkiZp
	gLnWoqYZdKBtFpAxwAoBEwddAa/anUUwIYxpho7DrSN+JMj/70XuG3RheymiCTLdVxYHTFhxqk3
	rTQQtKbIY4NQgOAs2otc6i9T2RWAtBdIkWs9m/zvH
X-Google-Smtp-Source: AGHT+IGygUT5aBPmu8NtYjKXJ3844FFa6d/oNU1vUY9zpQwVV+VqCV/8ZJq4SXeGrG+0EV2XtDTspQ==
X-Received: by 2002:a17:902:e54f:b0:22e:3b65:9286 with SMTP id d9443c01a7336-22fc91a84edmr234399455ad.49.1747094784178;
        Mon, 12 May 2025 17:06:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:23 -0700 (PDT)
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
Subject: [PATCH net 3/5] hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
Date: Mon, 12 May 2025 17:06:02 -0700
Message-Id: <20250513000604.1396-4-mhklinux@outlook.com>
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

Starting with commit dca5161f9bd0 ("hv_netvsc: Check status in
SEND_RNDIS_PKT completion message") in the 6.3 kernel, the Linux
driver for Hyper-V synthetic networking (netvsc) occasionally reports
"nvsp_rndis_pkt_complete error status: 2".[1] This error indicates
that Hyper-V has rejected a network packet transmit request from the
guest, and the outgoing network packet is dropped. Higher level
network protocols presumably recover and resend the packet so there is
no functional error, but performance is slightly impacted. Commit
dca5161f9bd0 is not the cause of the error -- it only added reporting
of an error that was already happening without any notice. The error
has presumably been present since the netvsc driver was originally
introduced into Linux.

The root cause of the problem is that the netvsc driver in Linux may
send an incorrectly formatted VMBus message to Hyper-V when
transmitting the network packet. The incorrect formatting occurs when
the rndis header of the VMBus message crosses a page boundary due to
how the Linux skb head memory is aligned. In such a case, two PFNs are
required to describe the location of the rndis header, even though
they are contiguous in guest physical address (GPA) space. Hyper-V
requires that two rndis header PFNs be in a single "GPA range" data
struture, but current netvsc code puts each PFN in its own GPA range,
which Hyper-V rejects as an error.

The incorrect formatting occurs only for larger packets that netvsc
must transmit via a VMBus "GPA Direct" message. There's no problem
when netvsc transmits a smaller packet by copying it into a pre-
allocated send buffer slot because the pre-allocated slots don't have
page crossing issues.

After commit 14ad6ed30a10 ("net: allow small head cache usage with
large MAX_SKB_FRAGS values") in the 6.14-rc4 kernel, the error occurs
much more frequently in VMs with 16 or more vCPUs. It may occur every
few seconds, or even more frequently, in an ssh session that outputs a
lot of text. Commit 14ad6ed30a10 subtly changes how skb head memory is
allocated, making it much more likely that the rndis header will cross
a page boundary when the vCPU count is 16 or more. The changes in
commit 14ad6ed30a10 are perfectly valid -- they just had the side
effect of making the netvsc bug more prominent.

Current code in init_page_array() creates a separate page buffer array
entry for each PFN required to identify the data to be transmitted.
Contiguous PFNs get separate entries in the page buffer array, and any
information about contiguity is lost.

Fix the core issue by having init_page_array() construct the page
buffer array to represent contiguous ranges rather than individual
pages. When these ranges are subsequently passed to
netvsc_build_mpb_array(), it can build GPA ranges that contain
multiple PFNs, as required to avoid the error "nvsp_rndis_pkt_complete
error status: 2". If instead the network packet is sent by copying
into a pre-allocated send buffer slot, the copy proceeds using the
contiguous ranges rather than individual pages, but the result of the
copying is the same. Also fix rndis_filter_send_request() to construct
a contiguous range, since it has its own page buffer array.

This change has a side benefit in CoCo VMs in that netvsc_dma_map()
calls dma_map_single() on each contiguous range instead of on each
page. This results in fewer calls to dma_map_single() but on larger
chunks of memory, which should reduce contention on the swiotlb.

Since the page buffer array now contains one entry for each contiguous
range instead of for each individual page, the number of entries in
the array can be reduced, saving 208 bytes of stack space in
netvsc_xmit() when MAX_SKG_FRAGS has the default value of 17.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217503

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217503
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/hyperv_net.h   | 12 ++++++
 drivers/net/hyperv/netvsc_drv.c   | 63 ++++++++-----------------------
 drivers/net/hyperv/rndis_filter.c | 24 +++---------
 3 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 70f7cb383228..76725f25abd5 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -893,6 +893,18 @@ struct nvsp_message {
 				 sizeof(struct nvsp_message))
 #define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
 
+/* Maximum # of contiguous data ranges that can make up a trasmitted packet.
+ * Typically it's the max SKB fragments plus 2 for the rndis packet and the
+ * linear portion of the SKB. But if MAX_SKB_FRAGS is large, the value may
+ * need to be limited to MAX_PAGE_BUFFER_COUNT, which is the max # of entries
+ * in a GPA direct packet sent to netvsp over VMBus.
+ */
+#if MAX_SKB_FRAGS + 2 < MAX_PAGE_BUFFER_COUNT
+#define MAX_DATA_RANGES (MAX_SKB_FRAGS + 2)
+#else
+#define MAX_DATA_RANGES MAX_PAGE_BUFFER_COUNT
+#endif
+
 /* Estimated requestor size:
  * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
  */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c51b318b8a72..929f6b3de768 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -326,43 +326,10 @@ static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return txq;
 }
 
-static u32 fill_pg_buf(unsigned long hvpfn, u32 offset, u32 len,
-		       struct hv_page_buffer *pb)
-{
-	int j = 0;
-
-	hvpfn += offset >> HV_HYP_PAGE_SHIFT;
-	offset = offset & ~HV_HYP_PAGE_MASK;
-
-	while (len > 0) {
-		unsigned long bytes;
-
-		bytes = HV_HYP_PAGE_SIZE - offset;
-		if (bytes > len)
-			bytes = len;
-		pb[j].pfn = hvpfn;
-		pb[j].offset = offset;
-		pb[j].len = bytes;
-
-		offset += bytes;
-		len -= bytes;
-
-		if (offset == HV_HYP_PAGE_SIZE && len) {
-			hvpfn++;
-			offset = 0;
-			j++;
-		}
-	}
-
-	return j + 1;
-}
-
 static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 			   struct hv_netvsc_packet *packet,
 			   struct hv_page_buffer *pb)
 {
-	u32 slots_used = 0;
-	char *data = skb->data;
 	int frags = skb_shinfo(skb)->nr_frags;
 	int i;
 
@@ -371,28 +338,28 @@ static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 	 * 2. skb linear data
 	 * 3. skb fragment data
 	 */
-	slots_used += fill_pg_buf(virt_to_hvpfn(hdr),
-				  offset_in_hvpage(hdr),
-				  len,
-				  &pb[slots_used]);
 
+	pb[0].offset = offset_in_hvpage(hdr);
+	pb[0].len = len;
+	pb[0].pfn = virt_to_hvpfn(hdr);
 	packet->rmsg_size = len;
-	packet->rmsg_pgcnt = slots_used;
+	packet->rmsg_pgcnt = 1;
 
-	slots_used += fill_pg_buf(virt_to_hvpfn(data),
-				  offset_in_hvpage(data),
-				  skb_headlen(skb),
-				  &pb[slots_used]);
+	pb[1].offset = offset_in_hvpage(skb->data);
+	pb[1].len = skb_headlen(skb);
+	pb[1].pfn = virt_to_hvpfn(skb->data);
 
 	for (i = 0; i < frags; i++) {
 		skb_frag_t *frag = skb_shinfo(skb)->frags + i;
+		struct hv_page_buffer *cur_pb = &pb[i + 2];
+		u64 pfn = page_to_hvpfn(skb_frag_page(frag));
+		u32 offset = skb_frag_off(frag);
 
-		slots_used += fill_pg_buf(page_to_hvpfn(skb_frag_page(frag)),
-					  skb_frag_off(frag),
-					  skb_frag_size(frag),
-					  &pb[slots_used]);
+		cur_pb->offset = offset_in_hvpage(offset);
+		cur_pb->len = skb_frag_size(frag);
+		cur_pb->pfn = pfn + (offset >> HV_HYP_PAGE_SHIFT);
 	}
-	return slots_used;
+	return frags + 2;
 }
 
 static int count_skb_frag_slots(struct sk_buff *skb)
@@ -483,7 +450,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 	struct net_device *vf_netdev;
 	u32 rndis_msg_size;
 	u32 hash;
-	struct hv_page_buffer pb[MAX_PAGE_BUFFER_COUNT];
+	struct hv_page_buffer pb[MAX_DATA_RANGES];
 
 	/* If VF is present and up then redirect packets to it.
 	 * Skip the VF if it is marked down or has no carrier.
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 82747dfacd70..9e73959e61ee 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -225,8 +225,7 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 				  struct rndis_request *req)
 {
 	struct hv_netvsc_packet *packet;
-	struct hv_page_buffer page_buf[2];
-	struct hv_page_buffer *pb = page_buf;
+	struct hv_page_buffer pb;
 	int ret;
 
 	/* Setup the packet to send it */
@@ -235,27 +234,14 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 	packet->total_data_buflen = req->request_msg.msg_len;
 	packet->page_buf_cnt = 1;
 
-	pb[0].pfn = virt_to_phys(&req->request_msg) >>
-					HV_HYP_PAGE_SHIFT;
-	pb[0].len = req->request_msg.msg_len;
-	pb[0].offset = offset_in_hvpage(&req->request_msg);
-
-	/* Add one page_buf when request_msg crossing page boundary */
-	if (pb[0].offset + pb[0].len > HV_HYP_PAGE_SIZE) {
-		packet->page_buf_cnt++;
-		pb[0].len = HV_HYP_PAGE_SIZE -
-			pb[0].offset;
-		pb[1].pfn = virt_to_phys((void *)&req->request_msg
-			+ pb[0].len) >> HV_HYP_PAGE_SHIFT;
-		pb[1].offset = 0;
-		pb[1].len = req->request_msg.msg_len -
-			pb[0].len;
-	}
+	pb.pfn = virt_to_phys(&req->request_msg) >> HV_HYP_PAGE_SHIFT;
+	pb.len = req->request_msg.msg_len;
+	pb.offset = offset_in_hvpage(&req->request_msg);
 
 	trace_rndis_send(dev->ndev, 0, &req->request_msg);
 
 	rcu_read_lock_bh();
-	ret = netvsc_send(dev->ndev, packet, NULL, pb, NULL, false);
+	ret = netvsc_send(dev->ndev, packet, NULL, &pb, NULL, false);
 	rcu_read_unlock_bh();
 
 	return ret;
-- 
2.25.1


