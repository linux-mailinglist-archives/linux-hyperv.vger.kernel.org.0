Return-Path: <linux-hyperv+bounces-8340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4045BD38851
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 713F3301AB41
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF730B52A;
	Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqwvUnlN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310F3081B8
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598947; cv=none; b=tUmnS2NFy+R8ZJUh0Ay84N9anSr1Nc8Ta9dDQwEBuxulry9fOkXGT3HRT5HpPDzkbHprCGYy3puWCddNmy1i1szG8Kgn/gs7kxlIMeBlflgNAB0ZWD2Ct19CAY55i8uOdRlfuE/k3T8WejGyetQVfjao8NqXljdeZ2ICXE5lrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598947; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP3gcQ3dUmsbHFzfSL01ZmuODQz9DylhY690dSD2DwgdaFy/RzwXtyMcvUlsP4Im2MM8Z/HyZMhkXiumcLJh2+Ch3I7YmArJjcSWtaJbKBVH7HwBiAduoCtpGb4CtNBja6Vi3Cvz7uWbqKZUdRwcgRAN2zi2pNEj/n5dWZ8aGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqwvUnlN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fb9a67b06so26107697b3.1
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 13:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598944; x=1769203744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=BqwvUnlNPCKikTxYdL+5w8XOT82LgQ0+ssDXjKCFsQOiOEKeiqpdAFz8/CE93RQl5v
         /GVKF15nii0G6eKA5oQ8s22PMA7hztwgG5qgQDLIW3i5knksl747rL2nTy6hhVXHGHFy
         vQNhM17LwHRwZEtAqwkm6d5i5P1xIbrGPD8eDjNZCCEMNSMK8p6XUwSj1NxI0l7Ym5ZV
         S3Lxo/tw3O96guydkObG3nLyxKn7r9U0oaRjAvCLmJ8qQ1uCYYurSraB70Sj03AnAvXI
         WkOkTK0q3z508sBiWTyQ8VqmEyUTD1pndtwVGYmkBN5icbbVkvQOfNR9KCBiKYMzS1wK
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598944; x=1769203744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=UL17GLWSU2Z8c6zYIZdtInwtU+LLYFxL1MDJPuluOw9eAZIPTLgfhiZUbNzgQx5Yg5
         R0gjxCgZ4x9ayJm2LZDq6bWJlFzaC5jxSQ47Sn7DYbUkFGz/YeljUAsaze4lIKRianoW
         MirOYHqXsrJBTaN2TFzPYRDmME1lIAbh1JU9w7k+XH54h+e/7z1dYylEQAMe51wU4tBc
         PlQFw/7L+TkutuykiR6NCcEmfmtwxPHaSrBCfdluxhp5e7ZJFb1U3ANm9NgCtZZ8nNs+
         06kK8yOaDf1hXGI3+k9Nc8AHW/z5+AFA+2leF+RQIr5l96DrlI2U8oxvXAolbca9cPcP
         jLkw==
X-Forwarded-Encrypted: i=1; AJvYcCXGAK90NnGgfUtDApsQUDc1JlXC9gZlr/TVb2XL69HU7XlNlpro9JWGikcKdd7an+ylBwr/+J+sNOUZc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/gQbUSleaETpvzhCWrZ9QN6iXt84bpOByDtpCQDktYXgQgQT
	Ev2Vp2M+Q6dxNVeYIlQ9pU7+2M9F1N8K534+vlDV5sLPIococxjec+Fv
X-Gm-Gg: AY/fxX4TP2Qt9Yd5wOBZkeStDosP4iAQ14tW+aQYbKgDfqPTMdoJKWV7zcY8i1UK5q+
	w/210IlrwroE/wkNwELMPc3pGJUoFE7kiiw1mNe90ZmqneASWRnqRnu8ijgp9g3hIst6/+ICB/4
	7GVt6ATyb+CeCH5AUUWE0Vk3mjf75jFbFfw/K8IGBRpOxvn34bnf8Csh+qImYLBBl+xX0Xcv1qM
	ljlDgd0y+EYjWD9EIEBD8FqeiSNstjCbvF7/gexVRAo5paWskRGD/DjMwZUr2xTOHoOboYgtk2A
	bOj5twebKXJck1eOPXr6tdGpG4dbEYDZU6DCPKIE3Dg468lUtzFXG5cmEElU0YwUzr3kARJGPC1
	1vqsYbZR6JZh6a3vS4guhOUJ0QduIl+80MsJZFf2d9NSdBF7eEGIDc3KXNuoywpI8K3DmKpKfhZ
	CIkDwHOMx0+A==
X-Received: by 2002:a05:690c:39d:b0:78c:2916:3f0a with SMTP id 00721157ae682-793c66b8eb1mr33268517b3.7.1768598944439;
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm13186297b3.12.2026.01.16.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:42 -0800
Subject: [PATCH net-next v15 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-2-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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


