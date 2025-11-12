Return-Path: <linux-hyperv+bounces-7507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A82C50C9C
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 07:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807883AD3B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8992EBB8C;
	Wed, 12 Nov 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXjGsGAD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA82E3B15
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930543; cv=none; b=kmjZBv/Rzqny2aW9bsaYRfrmMSBpRqJoXqVJ9+QT8bBfMBFxKxJrOeOoiNx+8v651lMNpCCrlkcBUoC1O+HCcVMRqrLpB4YSY9cIrR2nn7fKPMWqXiEDwEdA0FLVJA3nWVmx/WKu4JQrb9KuObokt+nW/mMvPwuKnBhNDr5WTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930543; c=relaxed/simple;
	bh=5emprepJCkrosJM8h3ONRAh/VBEaqfFdtQYY3rXLh2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0JXvd4AgkJ6cQMBoTpAml1i4j+fgwKbzkDfmVPWL1gUVSG9TjM3U6T8pxYP9+tU3FW95prhX/MQr3C+3LfyYj0ajfBaQmnpWQED2yAyoqdciM2tWC0/u3DR/5ihjuQfGM9W88Z27AW1AVnM1pSJ9KZzSVQA3gs6LiT8evq4HVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXjGsGAD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e982506fso6033285ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Nov 2025 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930538; x=1763535338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=bXjGsGADzGCoIedw0cuDsmzCkFavQcBN8SX4Dez5eX+1Hy9nY4dUhBD0opyzTBrhNr
         LRjRpQtCYYbgOP0MTe7t6rvEmFKQiZu5Hczn/4zo4pz2mfQZrXYUQj1k0CifMEksP4vf
         kQofAyVIjfoUKJOyRsQTxAWWOzT3P9IzNPFT4YcEVWgB94eZdEhutn/jBTJj73D/Vzm5
         Tcp15aXGZkMwjkD4ItS1AcdB4Nwprkak+BV0oegH53/A5pUvFG0R/b5YOde/TnvdIpDv
         0uOD5NKRLUfbtbuatI6ZvtjXxbQjtvspHLtuto9r/OTYLToknfbHiNwpsbgKqBSFo9pg
         3jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930538; x=1763535338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfQ2Nx6CoFxjU6rBT4tiqTH+6eTbyO5fnFEERoP0vpM=;
        b=fwZmROPy7eIg5FXFVSb+8BGGqhWMfQpxf5MzLlrFQ9hiHGBMfwjVnCqsOuMVlCsfkk
         zQRoe2LTk7KfL6mUQCq7sgqH1XsPw0Sc+PgTWMdcGc09D0UTV+HwHg8S18CpgwliaRP8
         MM0QfcOpK2luZUDrRP/6srDprcnOtzTIDIH08fX6+hfasCzI6HVRCBj/vSG8VFI51jur
         a83YXf+LjB6isvXXfI6kfAxq27eFcaITxIGLXnn75qYKjTaKRAG3FVGGYAezfUPGCeg1
         5iOP7AjZszJaaCLpgwgRACJNbXWIbnv5hsxq3KYKNwSLij8E9Uk/nTvxEjRzW/OxVGhq
         iErQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1wz8sZgTJNNoB1hwN/nI0WzIUvqNOcs6rvITruiLlHqOl/q5Zrq/2i4BCq5tEf1oaS48n6V572rtnM8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgzPXkXaRhFYum2XR7QFP8s/Mib/zhzOkgwnqIhtahD5ZQGqZ
	FpuIw5E6x6DmrNFsG+kGCK7Fw61lNAU/SkUvPXJZ6z8RC3bHvgyCmIXS
X-Gm-Gg: ASbGncuzLZKMvcIOlklTReakBqA5gTnTHmrp36hya6z+gLYs2OzU0GifYyzssMZ6SZ5
	qN18Zxumugy7RxYyKAdtVQzGrrhJEvtasw7ycSa3uVY3r580glU7dco7couGJDDq3EfFkd+qu3w
	TMoyzLzFzvQfgvLWE5PoP/e5oeCu21yrBXUINR7vroDkhh37yvEbSfmJ228oq9K1FsvlBXfUWES
	iMwDtcz7GEOnRYr2v6Z1wCKXCd7j8Jq/XdLKVuWZdGzwXfyHa91UD0sPbQkVJh3FnjDv1RBP6/u
	AD56/RvkdpKXF78hDxIbepHstVcRlTsfmn/n1OQsSo8YnhxB4Y1QUvN39g0Ku5VVQCu25s+IaXt
	nSKCG4k8WRhmSM6TcZi9exWodPdshbWUPQe4Zfc1+Tm0qN7pz2nMPPtU7+SN/nC1aiUvjnXRr
X-Google-Smtp-Source: AGHT+IF7DfsEqGvimsF/vV7xkPY5hQFPw6KbtZBzdnrAV5tW65XpvT8z84/9DJylmvZPMXLFyKNPwg==
X-Received: by 2002:a17:903:19e3:b0:295:21ac:352b with SMTP id d9443c01a7336-2984ed92f72mr26986205ad.15.1762930538514;
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dce55dcsm18719235ad.97.2025.11.11.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:38 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:46 -0800
Subject: [PATCH net-next v9 04/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-4-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 5ed6136a4ed4..18deb3c8dab3 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3


