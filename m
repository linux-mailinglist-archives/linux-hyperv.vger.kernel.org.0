Return-Path: <linux-hyperv+bounces-6893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3CB7E446
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685E51C040D1
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Sep 2025 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7415A2F60A2;
	Tue, 16 Sep 2025 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsIvOElp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004532F3C35
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066242; cv=none; b=pAPW+daTVglcWYjtlIEVkhxt1cHdmuAc0hMfAQV7TyGKralBi9KOB986gdbW0zDPUdoD+nnb4c13iANKpcyoBnluI+LSE48Wb35Ax8S+W2ols26XXyXmDxV2LmD2c9m89lWDX7AsRcCAO3vEjhhVU2497KoEiHcZHSFh0u10g1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066242; c=relaxed/simple;
	bh=EH9ooYSziv5KhjIFRNdY5bYLFFDgOaXRzl70F+kjAYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CdqbM9Pa5MKSgNw1xnADxpHBCnZTNL+TzblGFd5QyeDjSbKH7yF9ggIYVYRYCphRscr7nY6A+LZngQ3EJVa4M6DWAc40j8UCX4LXnusUREoAVgMqUZtpzXGm9dSzOrdrDXzIist5NlKa97TO6ncaUhEqGYIc6fUuvJ/z5FQ84s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsIvOElp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so5709754b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066239; x=1758671039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=RsIvOElp2Gw0bwnNvVCtO5RYXXLSqQXv3+1QCCFE3o58NRCVGzRS05scwKA/bVW18V
         MMuJGgsHHsRfb8GK8Ba0OlbG3BrV5hgX9ahv5ObNLaOodKLMY6iv9lEJml+SbmNSrmim
         JMvXvWvS0XQY2GkZ+LC/oRTBfmTnn2s2KTDS2nZdojgBQHzNSnHHnOZ1xRycoLcXlUs7
         k77RA0CQwh3GE4BvuBM85XOGZflm4nK3+YzjmdHZFmn9KvYh7seKBJVX5ucBi6e60Tm5
         cZLtikKT0x0UbfrCaQ1DzrQgDMTwHMz3dtd0nXFrPwZxcOk+VpbGTToV/iN4KzX46Q7f
         LY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066239; x=1758671039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVUMTjnbN6eX5riUEyr4WxlmQzTb3YpJ8a1+nr7efDY=;
        b=sCrDi58vYi0CyuS2fkG8cGbmUjeWdi7jMUS+WD3MtPNz5l5eHAH5NyH7QmSPRWvMOc
         MkGaPFjBFH7I00eI+5PiWsf851WQDQhsViLRrVh60zX5N/ZRolbrBASS2KYZJ2Zsyjxo
         qChqMNScH8oPwyNPZJHvm2aosNGjKE31E5S6YUviibSxo8wwzhpYWsD7zNneUo61k/kH
         VL4G2IS6bdy3p5OTUX25WopUgP90JWOH7IuxNv8yOiRYP+H//z8793By1ohpW67n+cJJ
         OmOawwIZSx3QHROqjcWFWBt2fE6fTMA3D8rokk3S2Ub1vYwCuwAynLkn2xcYqFK/lJHv
         PDvg==
X-Forwarded-Encrypted: i=1; AJvYcCXi3L6qrBMMakJIAcTF3qUJbFvEPtlIOb6Cfjxo+Uy3So0a0QUhzkP/VdD7+IxuAVG7IgKLxRGoqTTYQRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuWoeex4VLh0B6lRcELowPlWfQDmzZOOpYe3W9qfdF43MoPW+
	c6Nkh4JLyOAeJyhpEYS5peJAx3n9ZeDX3dO8FYqQrYMu3BxmN+i1tl6f
X-Gm-Gg: ASbGncv+3FD+hGbdVmEMo92Fvciq7dUpLfbZ6AunCv6CK3nMb4mX6F4Kjw9dznKlBRJ
	pDvwBgbOONjtMx8KtXo9+N1uYu4YthjDCiP3aQC3fFGSbequUTFOMsnaKTumRko9Yd2+dBE4tM1
	mRFuSb+cBlnmQ83qtzO3eOxGF3q9NQIk/OL1ZqWnKAeq2ptXYnos6YlMGsIMPZF5y40xt7notC8
	RYm48BAa3hUUHDgYjO6c/n+6XFyV78vRtDoyNfNmE/eP5LgnMI1hgiR9dLqHTsWxXc2Oy/2tUIT
	GA8bGZkQYz5NhSzCY1LjPniMzrnE+Q05QQWkNB44oEgwPgIWs2WRDrK8BVoADHaNRYyn29E5MAR
	u38bsBPWsPisMn5hyMIYk3yi3tu3v5ePm9iVHfWy8hQ==
X-Google-Smtp-Source: AGHT+IHh73YIhkH04jOcSNkz8qf8UKgUb5SUQdLJktTvor8RNRMCdjI+LaMxqb5RVFwojQ7SBvQpvw==
X-Received: by 2002:a05:6a00:3e1a:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-77bf8c7796emr66050b3a.16.1758066239010;
        Tue, 16 Sep 2025 16:43:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776210c4a5bsm11338744b3a.47.2025.09.16.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:49 -0700
Subject: [PATCH net-next v6 5/9] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>
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

Add support to the virtio-vsock common code for passing around net
namespace pointers (tx and rx). The series still requires vhost/virtio
transport support to be added by future patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index ea955892488a..165157580cb8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -196,6 +196,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1a9129e33d51..8a08a5103e7c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	virtio_vsock_skb_set_net(skb, info->net);
+
+	if (vsk)
+		virtio_vsock_skb_set_orig_net_mode(skb, vsk->orig_net_mode);
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +532,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1073,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1089,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1116,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1154,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1165,6 +1175,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+		.net = virtio_vsock_skb_net(skb),
 	};
 	struct sk_buff *reply;
 
@@ -1465,6 +1476,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1590,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode orig_net_mode = virtio_vsock_skb_orig_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1620,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
+	sk = vsock_find_connected_socket(&src, &dst, net, orig_net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
+		sk = vsock_find_bound_socket(&dst, net, orig_net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


