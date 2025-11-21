Return-Path: <linux-hyperv+bounces-7730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D5C776B6
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 06:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4E8072CA5C
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A52FD7A8;
	Fri, 21 Nov 2025 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXufHc81"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11D2F693A
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703898; cv=none; b=AGm1ZaPOEnbj0oOFp5QSWZvhvS52F27UhwJyoPefXwg3cEn2eaV6vKqPvpNNOsluVu1OpvE4bfbMttU+DfXjQ/t+looUgKPnHhcBzaJWwM2RLVcG951me8rrFxQ7iRi/cTZVkYQhSyMgomGlBZC78F/t1uQ7cT/GPKktkYd4gTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703898; c=relaxed/simple;
	bh=fsBBb11rRzR4Q5pi4KL2AyZQEMokJCJhZHnuBGJ1xhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhEJZ9h1OneHIobpDqfkuEaeEdGlgGqRi2EPaNeLhIO5xoefvnYFHaMDdm+/F4RWXQTh5FT/lUKc0qicT3rItLly/dAj9zV7exoR2U15qyItsVn6oiK67w7ovAbw3lRxyDxEi3VvWf0Bpdy5sU6aAZOr35MLBF1EMfNi7W8kwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXufHc81; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297dd95ffe4so14270135ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 21:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703895; x=1764308695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=MXufHc81htKDHR7hx8nYgiZlT38+9IgO7C4G60UdU10UUhHbf52nM8xsEDkWKCBpXb
         V64BVPkWwlazJqRjDdgCrTU5Y5azVDuXb5NKbB6xFYRJZyyN2KLWy4UwZq2x3m0vvZFv
         FkxAANDMxYd/cX+Ii9bZbVczvZu2mmuAPPk16ZcvuESlysO1/8c88waTD7HrFlX0VQvN
         wRriWddBaOh9akp8C3IIvbPsN/sZj7UxM4Hv+LD6y1fdDh8nc2OMMNvGZhS5JWCD7F01
         Y8wc7K51GjxvujTsz8tt9wFRdfOLeXo2Ga9k/fSrdt9SUkhb1BL64WmtDpvzHDps23VQ
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703895; x=1764308695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=rThueDE3gTEYyRWnkqly+BQ+J0SAIqycdwv6nGJhgMzFimSIkzMipOwze0h1kW+WID
         /SkyYu6wzkLg377ib3qN0FLF3K5k4kavAeAGLKKzPaWCLvaiGpKGZ4OY6owB0aNUGxrj
         6lNYOJtOaz/SDa98HOdbyddEUeq+yWzTGOZsW0T0DWd6+KVUAoG49YIYCQC2cf/80uMz
         3E1mFZekP4LeGgW3X7vTYc4mY30Nc5uHRxyrrVgPn6kDXpbXiLpO+NgCGzkhQhzA0c8g
         2bJg4srlvMHbVxY3LNQMk8oYNzkdwHubG26Tcct/n1BI4k6JrgE1nMyPjUBGsehSZ+YB
         Qdag==
X-Forwarded-Encrypted: i=1; AJvYcCXusDRsblwpLn3cd78rzp+4JJU/Eab7PacSSpvyEMtx67yj/aoLkYu/ku2lUiHzkyRukusjZbbBLzFd/5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybqn0lR0FKSf+Qtruitg3Vduj2dVc8ut303VidW9sxi2amayph
	BFJrBtcAlgz4mRDhIlmshNmWprZceFaAKJmIvxnJN5rMILcGz9gx+5hY
X-Gm-Gg: ASbGnctXxttWWFgVpbnZWkkGuGKJLxJ91hH78D4jRDtjJr3P/MNLMiFWKQuJDOGE+6L
	PfmApyACIPJAeMVY7Ztsr6c6G5nqFDRT7obwGu8nrODj/mRJK4DFA8/K+yCkzCpEw9N4K7kEuQc
	IVvz4E49La1vQKfBM/VTHwEfA+CuRSk3hVjuk0yUuvOfTMT7+m7o+fZ8f1atApMIAKBa2qebl4Q
	qLUXgKjHUqdZascxFTPYwz/3JoLDQqtHl4Ayp4sPx1HMcLxtgRpuPRXghc8uTg9k8SBjSdbgPFb
	7Ayl0GSVaNZZR+3ppemHDMEXKgxAjz8B2Xdm2k7rdaszzhsw/L8mQukrxuQLHaNJ6TJgp96Wb5j
	UPfEl7jhJsXVwfTzy3KK6xb0IUcTyukrSrKPfWu0y7bNNYKMY9OvDVgPthMGI/1GqcReIWQBlVr
	y9lQ63PCcx1ymEk1US
X-Google-Smtp-Source: AGHT+IGa+OjNw6ZNUabNVrbiRm1cN34zeqSyarDkZ/uyC1wiDWIlKAxvnZ18+6IgwXZkACrQhhBeIQ==
X-Received: by 2002:a17:903:2acc:b0:298:efa:511f with SMTP id d9443c01a7336-29b6bf3bc9emr17507735ad.39.1763703894492;
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a870sm44383905ad.34.2025.11.20.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:36 -0800
Subject: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
 Shuah Khan <shuah@kernel.org>
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
index dcc8a1d5851e..675eb9d83549 100644
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


