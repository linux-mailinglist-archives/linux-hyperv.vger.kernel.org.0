Return-Path: <linux-hyperv+bounces-7314-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C4C02EED
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D9D3AFB23
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907334BA2D;
	Thu, 23 Oct 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZluPI/AT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5C34B1B8
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244088; cv=none; b=fCEEEYjuKfGg/ENtESsSAF11oo2Ofxu97AfbYMOYe3x/bcIQQGzAhYZaOHl4p8KzsCAzMq3Gw/168ZENIz/uNndZmrm5qD2S5YYLLnTY5b74lPRc55Cjpd/BFYm5mfpKUrhiF43YYuVwa40wtXm2nIjuXtDMIxPNn9NLL7TSEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244088; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgkVFkbBePtc0lSwq1l4WfXwGbXGXErErWzlNgAZAB+ftTX7oREJNjHycoaAKxPwUSzSDgFWNH+ObnbFUdagNcvbeEWmlpyxaOdFrQzgc2+mKm4BXnmIToEClPC0Def6hx1Ni+PUaWhfXHX65MdTBpNIQsz0W+V+negXw/csBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZluPI/AT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso1016878a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244086; x=1761848886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=ZluPI/ATyLxWxTZnYtnR1Q+2uqTB8mTBDQVYynXfkdJqsa6A9Txt9/KjUi4mCfhZ/Y
         6XLP/aLF5CVY9ezJucDQCws4m1PpC0+ulGf2zweCjxbvf6bfEKR1MiMTRXJQ0wPXrTTx
         leva9rnWFR43CoZ2ATmAEOtOJrCAkQQ+pfX59nKs1bNb4NWM52FTWeXJLq/gLHHr+wFS
         5whdVdBitUm2RU7sV+qHkbRjyemuJ+TfwBgvHIITwc7W7uIkYNSSmWLUjjTPoQHSguef
         +1s1PKqKYefGRIu/7tV2+Gd61SpbNP06SvCt5aOZgzKxwzM4ARH1o65DylVHpdAR7/tY
         cbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244086; x=1761848886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=xHR6IbzNg932EzmT1+iJXCFVk8oGnZ2TuXTrZ681oHzlHAGKekgI9P+4eXlsw5KQK7
         ClHYO7rrtz6trI1xIU8kYYoJCyOa549K17DnTHwDZP4QNY7rbMrAU/V4yzdY3DLqVAAj
         mXuDlI6KMlvMGH4KUfMjkdOU+ajySLOeyIMRO0ntkUnIBWlNdID+H7EACFKDYi0h0Q7b
         1doKag2N5R/PbOo2TzwBXhizuQOisntwAblOPeR8sXb/28uJiwhXr6qvIZZYtH9fbnno
         hQSdb8q8WA3pX1U4j+FkpKOB5RdT9fogKSOkZ5XL+N9zyGwH7IY7mjM7uMmPQMR/CBAX
         pmug==
X-Forwarded-Encrypted: i=1; AJvYcCUAKYmqQUhsvAgFvv944uV2pmjkA1mykS7dylqFp7kTomJ6+cfz3pwQAu200hAjgeuBar/7o6RJgQZ5fnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQFXZy6Zv5ZblGHvUOGcNDCTLF2uOlgrgRSuYSOvr7CIYFn4A
	VudG/vZfqW14yRX8SahChwKgZYygQmu1rWGnjsZHlaovKgdbGjQTjhkY
X-Gm-Gg: ASbGnctjfPK8sb0osMgIDqk7nuu7/EY5YL7j6TFena6TdPpaoWrpekoJnvtFWJekKot
	lOWJaddDbZ7494HBu0vTDbHQxiOxaEXJFPpmQIYpy7DvES2wJUX3bPQ90sMrNdOw8anunmFEA+q
	zM7mTWVJFYnqNDwFtLaT8vLOrxGqJVoh703xwvj8hv7i8Mts0/9rXWjs+9NFIE6c52zTcx0RGc1
	KfnBZFX8tQvcC1orGfx3osGRW4mpbaCNC6I3FcO4pBZghse3rjez71km9sHWz6nP3an3oLYgjqH
	b4Yzo51iOWv7v3vZ7DFx09WjmQSbQ2zTQUe5RLoJHzVAgrLxImEvVLJN+VRQJPOo5KVRSlyZCf0
	k266FhpozPYwB4/nl/UbCLM9GEzg1Eva8hOTpKhcrNNd45H0jJAqTapL7FbODP7rzq0L5Mx1wgt
	eZKO3CWiIq7bG93Jy5zTU=
X-Google-Smtp-Source: AGHT+IHuF0nGiLuYIY7bEPnV/kWChQOzz0OHyllyc5LZQHhWV90GhBaf/if/KbPVYud5pvRswtc0Ww==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr337313795ad.53.1761244085636;
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de152e7sm30294645ad.29.2025.10.23.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:41 -0700
Subject: [PATCH net-next v8 02/14] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-2-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..87cf4dcac78a 100644
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


