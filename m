Return-Path: <linux-hyperv+bounces-6890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E592B7E4F2
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806137B55DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74512F39CC;
	Tue, 16 Sep 2025 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFDCioro"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4B2EAB6C
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066238; cv=none; b=F17vX/nFGpJ8krCII0nipz7NBlhjGcpuzFOa1Q/MHxojT4J1sOjMDKp8Rs7C8jvMNnSoMkpNjitJ/23P2Mgj0PcUewVeVedC/e1wyG1zgznQCeQpSwqHvkdG/Klx2xEn1cC89xTjtMZGEkuL915wGK+vQZWRD1vT+Wy4d7U07Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066238; c=relaxed/simple;
	bh=W8gd6XhWQ6pvri0xbAF1EAgDb4RZn2xcu5cNNgZFNfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+0tjDPvWbCOSP0ubpS+ORrsM0pXB1i5RMZK6Rb0v/v2Mab6siFRXUEoe9NYVSxTMh0ll697pOeYN198gs+hknzg1xeB9EZFH2Y3hkcLbQE1al5K9zrh9+MjNJiAzCZ3cPXOzW3lr7e34SED0QM8fp3LFyik5A5HH8a8WzNK5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFDCioro; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25669596921so62560865ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066234; x=1758671034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=CFDCiorouBgrTtHADayhVGin8siFjn9RXQTl6LQ5IEBv65PSBsrOMVLddUYCO2gv6S
         SpSK+2+/J4Ndv8/onlVkAJtF++c+FmUGVplPAi6XwrqHTI0UpTSPuHXSkhKvmErilHUe
         GNTBDFCdyzSC2LR2YZojmo/DiLSAf6Q6JzIZcCqb4GZ1cOIWY1QiNPZkgFtmrm30QOCq
         WZlJdpiSXeX/rtB3XwG98VVVXp8NvmMtssvV5In/KCOq+lYwbPnj4WLRpt/3b2hWKjyi
         elDtaa4Yfh4WeSAI4grmazua+vRUqDHdJPrvbsqT4JOauddLfwkTi1cN4uqQt/fvWbPE
         deWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066234; x=1758671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=mvo9xZe8sft/Yo7xk0FobljTD+87X1AgdD/+LQ7Mc2MnpEmLthghvmsdVunJkUrZ6o
         2T/QjlxzCGVHtg8p1Xtnqy3svdVj96nFti/jQjllIbTFxyxhDqkO94GEYQaXi6bId/Ar
         kRH9cgmygcmwGomwMLK3LNsh5roDfbmXtrqaYA5xV/jD0fDLveKwzeZBpMQa2DZFrUWf
         Xi62IZFpD6ei7CryiV4drMtbu2y+Ini857/Z/Mh2LGIe4wVaoZVkVBX6p/xZa1f1i9jZ
         MTyD1Mt+PNGKINJS1TcveoIQ5POmBPHhviOzOrlbFvbCtblc8Vwfcg7FPGovd7JFA24k
         +woA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ckkriOTxWW7tITTnGnGGR4Vzr84uQIOx2qrvVcuLR4IMz+feUwaBzcvh4awUwnCzaLjZDaU6o6e9DQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgFi2qMGYVEypOglsICmLepN048+QIN7iKVN2Ng7lyAXcK5i9
	bIFD1Accxw5PCUX4NPIp9CuSJaRMLIZ2+Fq4zRpt5sbk/RvyWpYxRkaG
X-Gm-Gg: ASbGncsjqLPZNmVxErL+UP2o0WKfjDpKdUSML3Xrb/o6LIGcYfRdJzkQCcwI1BSeGqY
	ohVkxQvlcBEuYRj7nywgN86d0/CcJNnIolG+HpFp3ibnQJfToDiYD0SnX7WU2l/ZPv3zuM8GvrN
	864t5R2JeYN+8CpvjUiwVgi6q69AFQbLz0zC7IQdALG2krLdSH9TjFCrNly2bSayex26Nf7AOrO
	zhfEY8T0H96uG6+4V1wLqgSRKNotHHq6jBBVO0hGD/FpRpSCPbAeRj1dlfuR6IHbeboIABexaHu
	Q454kNZmRlZcE092Y4DUyQ5Mip8tbtuGD2eGnkx/EM3gDD37+kpjEdZUVuLATa3tAKRK2trBUVN
	umf05yZeyX8KQ9J8dchRj
X-Google-Smtp-Source: AGHT+IF/xw2akPqfiTx346iDoeH7Z1/kqJEVjbR3GnSIaOpGaqTCjMLhCHfObu3TSyZ9Zry5A1RkkQ==
X-Received: by 2002:a17:902:ec91:b0:267:b357:9450 with SMTP id d9443c01a7336-26812179838mr1096375ad.17.1758066234099;
        Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2679423db7fsm59353765ad.70.2025.09.16.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:46 -0700
Subject: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer and orig_net_mode to the vsock skb and helpers for
getting/setting them.  This is in preparation for adding vsock NS
support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..ea955892488a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
+	enum vsock_net_mode orig_net_mode;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
+}
+
+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode orig_net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3


