Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A44719F4
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Dec 2021 13:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLLMNm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Dec 2021 07:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhLLMNm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Dec 2021 07:13:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51DC061714
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 04:13:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z6so9313671plk.6
        for <linux-hyperv@vger.kernel.org>; Sun, 12 Dec 2021 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Jbizk0oKiVQa1QzOLVBB4IFFKoIs49iZCESSc5AJDQ=;
        b=TBc7Yhfi8TvHDEqNTIU/tjzTyhPqFy1awDSR53zWKgKNi6DJgq12EONd5F8WQHTpa+
         joRLucXb3jpA6x0QPQA7LONsiZ+SaVY0CoxMW1sPN1Vf1E8ZCCGPcfRno4vVJnHwrPiq
         jkv8IzN9J7m4Jobe6lPzRS7lOqD8fetOj98TIcsqg2jP0lW1L+zlYxsfliN7JM/apZ8a
         6oePG1AeL7OmiFkwWX5UoDgCa82uEWF7wr4M/CUH4/PwDm/laFDad8Xp1+UWa3MgU58G
         PPRjIXhLxsS5p9OJkvoqyalZunqK2njba6qzGJwpnPu4TTseYyRmXJ7eYaRdwUnCO2Gp
         T6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Jbizk0oKiVQa1QzOLVBB4IFFKoIs49iZCESSc5AJDQ=;
        b=zw4d6sczqmkl4ko7Yw6cTWs5mnZaDZYf2qS1qsiU4OzVDn+kKmp/cmQUoZILBeGvN0
         ctk0pUqTB2jtzpQmWPcFgNoKaX3OePCFvDrGodp31jtgaFiXjatZUATpsPWSZogp+XDJ
         9oSaNHfzK7sffSySCUcQUr8WRDrs++VlBcAvg1cwMMR/ACdtmmGXa3dc1CaN7WfN5fCA
         Ivi/fAiaYtNiMLZ9jXH7jHoTVqZmnZqCmEnRhrrRrBn+1PS+u6tFJogHaUENm8LbSMHJ
         NUmF66sMBwUDG1PDUdvoEeY12SIPXV4RMLMQE1+gv9VPHx4F+4z9wF1pao/FlHy3fdGL
         8N/g==
X-Gm-Message-State: AOAM530LzPgCTSYkIF8oJmyFXFKkgiUZqMY7ZzWSXN7FvSimLsKrXyrU
        qNpXT63EfGuDGQ/GZXcHUJkIJXREni6evQ==
X-Google-Smtp-Source: ABdhPJyeyFlb1FKXrjhoMWEsP1Vd1YUHfUggDUIuFv/s8QKZnzi+2krQ0ELOhlY/6nRwjxtPcKUQIQ==
X-Received: by 2002:a17:902:f54d:b0:146:8d4f:1b68 with SMTP id h13-20020a170902f54d00b001468d4f1b68mr43549604plf.25.1639311221526;
        Sun, 12 Dec 2021 04:13:41 -0800 (PST)
Received: from megumi-s.h.riat.re ([103.72.4.142])
        by smtp.gmail.com with ESMTPSA id q21sm9571121pfu.106.2021.12.12.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 04:13:41 -0800 (PST)
From:   Yanming Liu <yanminglr@gmail.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Yanming Liu <yanminglr@gmail.com>
Subject: [PATCH] hv: account for packet descriptor in maximum packet size
Date:   Sun, 12 Dec 2021 20:13:26 +0800
Message-Id: <20211212121326.215377-1-yanminglr@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
out of the ring buffer") introduced a notion of maximum packet size and
used that size to initialize a buffer holding all incoming packet along
with their vmpacket_descriptor header. All vmbus drivers set the maximum
packet size to the size of their receive buffer. However most drivers
are expecting this maximum packet size being packet payload size due to
vmbus_recvpacket() stripping the packet descriptor off. This leads to
corruption of the ring buffer state when receiving a maximum sized
packet.

Specifically, in hv_balloon I have observed of a dm_unballoon_request
message of 4096 bytes being truncated to 4080 bytes. When the driver
tries to read next packet it starts from the wrong read_index, receives
garbage and prints a lot of "Unhandled message: type: <garbage>" in
dmesg.

Allocate the packet buffer with 'sizeof(struct vmpacket_descriptor)'
more bytes to make room for the descriptor. This is still flawed as
'desc->offset8' may not match the packet descriptor size, but this is
impossible to handle correctly without re-designing the original patch
and I have not observed such packets sent by Hyper-V in practice.

Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
Signed-off-by: Yanming Liu <yanminglr@gmail.com>
---
 drivers/hv/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 71efacb90965..e403ed4755ed 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -256,6 +256,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 	/* Initialize buffer that holds copies of incoming packets */
 	if (max_pkt_size) {
+		max_pkt_size += sizeof(struct vmpacket_descriptor);
 		ring_info->pkt_buffer = kzalloc(max_pkt_size, GFP_KERNEL);
 		if (!ring_info->pkt_buffer)
 			return -ENOMEM;
-- 
2.33.0

