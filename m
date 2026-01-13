Return-Path: <linux-hyperv+bounces-8240-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09077D166A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 04:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071483012767
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA430E0D1;
	Tue, 13 Jan 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irPpLPU2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDF30E0F2
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273980; cv=none; b=OWlJhEvkIv3bsoBbMnzkpBy66+CrmcGQjW68oXCt9Ftvn8d3tn/xmybwm3x9Ajrn4//IaDEGqpL72O3xqqfmzUvBc+Z2k4qvL1fIotYQgmUeBSFMkZgGrz7hzqZNsHR+aPSqepSj5FZqvBYTtXKCe1reDzUpS2yRDYCf2+ilq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273980; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qamtTZQUUww56htk9GMzh+/tgYzhyyj/EghWyUh4mGHFF9+FPiH1WFJn8G4+mt8xQu1d5rWLHhETbsfvYah3Oc5tHCM2ak4/FyyIS6ZIS1FPVn2RfaFIKYyg0SKqAzdHyoTZJSIlvZxy/K2QKqne+X4eTEa9KrD1bT29GiG60PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irPpLPU2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79276cef7beso22173627b3.2
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273978; x=1768878778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=irPpLPU2XzmI+2sVaJdVcskUb/Tttp2FaeL030WnEqu/DYNJPFMCTG7PrKIJL0OCIy
         Pgxz1DBwFphhLICgm19CHrv/fo+K3Q9MMMI70K+wADSmbbeM4o090UvrridrdEGg5ZpZ
         7hOqPkOHz9jZFErUvSC19JrSRL08gNsE3EelM43J3hejO2WbjvO6tHNbmXGQYZG1DPFb
         xgV3doQwigaiGiNnu40vkPsFTVeNCoEkfmDR2H7JuwqCLAbVHA3Dyp/trJkaE6K7wIrX
         Lq4D5m5tB/SndBie0zEwcAHsb4obYWMyHbb9oiXOgyuwzzh3tVhtFnARjTU4jwG374r5
         a9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273978; x=1768878778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=Y6E016uK4qL08jXgmw6KDtn1nklJ4mxlZJnURBTi1JlIOyUcnu8VLKFx1mJwdoC6NK
         5CIO9GjZCk8jPlvl1ZM0ZbK0mH/C61HisC7eDLlK476f/EXNIMsVldqi1XAzqvrU2nGU
         J5Lt6HUD2Be5zLvtOCsEXcTo6bS3LermEr0twwRgVRm6rYdjPuE1MjX0Pn8jzgluhnrj
         vDF9+FWN872VE10YtPeAjC+JGI11jYWWe+K6r6OkwF7wyQ78zkCrDRrabNws3lvx379c
         bEaA6JtS+8TqQ/1rdW1YxXB/YWrKwUBjAp3tTXdf/qHZZquTpW5B7sDnD4Y089QktiKm
         fXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF0VRCvYm7lSAJPaLcFL8L+FoLgBQ2Loc4EAj4JcxmFkmsRDu9ODt5LP6w5ktH9Vcd2lDYhc2hAHTEmV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUjFyA3XUZnfLi8zbn5KU+VOP7QOCrwyCzuCC9BElQT/D55Er
	aPM66LLtNTh5jVeJVyomrYl3w442QL3MLjp8N81ogosUA7Qy318ZWvoj
X-Gm-Gg: AY/fxX7+ma8ihOtViXCbjaA1gve8EZAmMkgCUX5h4rByHYVYUjDXpxY7SM5SopbCIY7
	wysTJ+QDZjZsZM7Fad9k6DTkQnE7RRk0Vl4pooWj3PdZRt6lsFM6S0XQmT9K4AMFA5POAAHbtcf
	zV4+Z+bGUVuCIsLaoN0frT2tOBJLGb6sco3QQJksHe1qLL5cPvVCDIzB8wJzeEgQBxmvJVz8Blo
	wIfgCbGOnDkqTc07SQ2Ugs9sWzUaZi1rs132VpK+xBAdL8vbJdRtodzZh/Trzpi0Xr1c86WBvdv
	0Dw0ctLIBFXXyafSwXzjFi0+ykY+nx/ZU35In+PapDvtdBosw/pH4hjQIiMkGzzYawh/87oj+Km
	ReYx9ocKyEKznJhXNZQerqkqoHFMoKL+3SwhZvuQQt0eH9xL0Aokt3gTZ0nrrcLlj8z2y1obD4B
	i0+TqBWivAXw==
X-Google-Smtp-Source: AGHT+IHcF7Zmu1veaf8u0eg/Kbb68KxKW7zWjXp5XrByj/JKfJyEyOkbbQZuZ3nalmLjzPkGlfdNOw==
X-Received: by 2002:a05:690c:6285:b0:78c:2473:ae79 with SMTP id 00721157ae682-790b56a66bemr171959117b3.39.1768273977917;
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm75715147b3.25.2026.01.12.19.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:11 -0800
Subject: [PATCH net-next v14 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-2-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fdb8f5b3fa60..718be9f33274 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


