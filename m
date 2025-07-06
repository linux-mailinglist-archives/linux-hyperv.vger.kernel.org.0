Return-Path: <linux-hyperv+bounces-6112-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E923AFA323
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 06:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E630104E
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3391B042E;
	Sun,  6 Jul 2025 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgEi//0j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122C1ACEDA;
	Sun,  6 Jul 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776637; cv=none; b=fzgnOJQ22n/wCC19ZQ8DT6RMuxTM76NgBn4BN2ySOBIHP7o8DbvUSeiGienZweLTyFhxwUPssor7PbGlccyj0BxicG6iw9igzAaeAkgI5Kh5EcEm7YSuH59IFj9VNrIPVxN+EaNvFU24LRMXuftKHNltrLfoIvZDkcMzlew5aVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776637; c=relaxed/simple;
	bh=lrNsByWI4+JZUOhPSorgBp0TBt5xNkaU5kzScC5uvPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jalav3xev9ou6O6pHN3/mbdE1vqcHB8eEK2qAHCpvusHVLro/ZI4LCZtr4gCdfUIPUoz2kncKUgk3SUb4A6UGVwQEhhayB9laVCfk1o4s8zDwqoqdDrKeTRmvUmcH35W9HW8v3J0v5faC0+Zp8kKO9Kx1KqvsIBsGBDHsUbNYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgEi//0j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748fe69a7baso1850140b3a.3;
        Sat, 05 Jul 2025 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776635; x=1752381435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enAMJL6mb/z9WNfWVziA8KCdR5RF2FfP9GwDXl38f/E=;
        b=ZgEi//0jRnwTsrvAwQgmNhy2ueR37xPEuP5bbNsHJlhP7ogfxD8/rCf5uZzxdvqGTi
         7Xa6krRFUn2ou4L2Xgxs1tNcAifL9gEPujOkFRLbczJHtey41wiI560PxyvxfoRJ2hmW
         ooajIzSASwmcQj2+c91UWTTIZZcovxBi8KGn0bhp5pApTVmnUIM1L4Ilkxd1aoP8YDFt
         +aZ1MJxmGqnlybTNkkEh9g08IFdhMjzFLKZU6EAe7KUYyH9njoA+HC9Eaixpuek38WVn
         ua5NAmQGKsVIoJDK94fLwGyjDBiRm/qjnl4pQBxb3lcXnc7RrmsH9vm/U/u1EQ6d1Jio
         +WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776635; x=1752381435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enAMJL6mb/z9WNfWVziA8KCdR5RF2FfP9GwDXl38f/E=;
        b=GjjetGcVUcXR2SOgrmdZWexd70sb+bppdVxmw9VpG1dKJmssVOxUSf7cDzn4VGRhgc
         5/vjMJAvhpvcph4AtF4UmouPL3bFBNCXvboqw2vVtd9ttusZT372m5jy/E83btwes9Uq
         Ewd5qrIXa332SM6toqnFctrRhI5K5zCMTy9h+BezJ9caLEmDeYhf7cGpjWJkTpjh05pm
         G91zgRQm7BrlOa7/tiPqbFCj44EVuoE3aBRhn8S5s63wfMr3Eo+rYpSDcTw2U1Nkz8s7
         6k/kYxNQybWltliRFl7uujQzG/U8T8rrr/lsLkWjKjDHiolFQ32kF9Xh9WbKSMbaTpeg
         kNrw==
X-Forwarded-Encrypted: i=1; AJvYcCUaC6hojK0mbP8pgeeltWQWYoY/4MVKnVeIgENTolw2Uri1io1rm/odeYdh/K+0/6CxlXel57cVn5BoCMs=@vger.kernel.org, AJvYcCWEtRle9/yWCdfMzjCldvVzCOklIrXVJy/fuw4rWhbf9PpHtTVwUAsxp/W0C0xRyynxdQFSxnwp@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfplM00E7TuUsEG+jWrTqCAU+R9WpuQ8VBCxhjDW9eDNYv3uq
	fZJrzSgw2iQO1NPweOaiYdTZLiB3xpxmGSRPexzxPmnKZ2wTikQdyM+w
X-Gm-Gg: ASbGncuPm5dU1ALkaYENYSnj5jtGLPmOmdRNuPDNlKb+q3gsq4gzCvxAiCNb3mgNW2H
	yuS2GLPhCW7FN3DvaESORguTWwqhLTBtmjgYUq3SuVRJf/vGbW0SMGn25B66MOn0hfEqyBTuoey
	pQVmSpyzUY+h95i+4FoCHXnQKny8qh1a3e2kTEEzC39AmIpcrgAkIDgJf7FAkxWi+96/HWVGGXP
	3g7fOUcABk0cOD0Swc8V+eU3CBR08ekmZXh+DsSyCJ7oIh5LtT9Ew2FXEHpxoXqIxrW3ycThSMA
	CRzpIv2+w81ULpzv8TRHQyZvBDnOMWvhoh+PlStdrCTKWijPAPDxDeH3/omHtvf9+A==
X-Google-Smtp-Source: AGHT+IHQIGrgZb4Ga8DvGclOdGTppLhL3WybIIS3/IKCgYv4g44bAwZQzlV18+HfQ/D8ucanu+qLQQ==
X-Received: by 2002:a05:6a00:4b10:b0:748:f1ba:9aff with SMTP id d2e1a72fcca58-74cf6ef79aemr5032449b3a.5.1751776634875;
        Sat, 05 Jul 2025 21:37:14 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:14 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:30 +0800
Subject: [PATCH net-next v5 2/4] vsock: Add support for SIOCINQ ioctl
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-2-8d0b96a87465@antgroup.com>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
X-Mailer: b4 0.14.2

Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
socket. The value is obtained from `vsock_stream_has_data()`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsock_stream_has_data(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 

-- 
2.34.1


