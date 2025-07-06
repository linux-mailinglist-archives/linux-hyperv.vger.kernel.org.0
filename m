Return-Path: <linux-hyperv+bounces-6111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E0AFA31F
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 06:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169783BD7BF
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD91A314D;
	Sun,  6 Jul 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ/2gn54"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E21A08A4;
	Sun,  6 Jul 2025 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776633; cv=none; b=ecKvmoAiJEUXpp2/bpoc39fscYReM1vq0N18kFDHg0nIYdERV8wyvMkjBOgrAfKwxPAu0263CpUe9ozzrHkL5RWbD45X3vDwJvRcBL6CqqJsqMhsJ3fvuxvQmsTToeebn8cT2GgWC+7DF5sQenIRIQ79AvCvGpA226AYSRnJr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776633; c=relaxed/simple;
	bh=n9Q2c70s99hykiVWRTO0HNEhldxVXbUo16t8vijIGOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOQ+3x4OZl/CMEwktiMQfC8Yzfq5J6AwmcTzli7Pe8HmTXKP97owo+gR/CnRlCs8hkYPpHR2k/07Fg+BEy9uTriyOmhGUyaUm4YZuthwl62bXlZQyVqPR+wJQtJ28oSlRdqAoO8ppPTm1R7Pm+gUyKe3ezRAVzR7t6xlMNQiFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ/2gn54; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso2563800b3a.0;
        Sat, 05 Jul 2025 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776631; x=1752381431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkHPe6LE8OXWdD0I5CLih7m7+WFtKYT46OEMON9KnWQ=;
        b=lJ/2gn5400QRjGV5Ift6119tD+rQ112n7K/0muZmekdv/p7l5x47Lp/3f7mZ1mmIAx
         bXi1iXj0mlh6KtDKRfqWu1T/eiecpfrTI5yRPYk2X3HTNOTLglwKlfKl4FneoaW9bFOT
         nRreJtjKtfxwDMMU/4XAbnuoCEMGS3KlUsyG5lH8yOe12H+TfEC2JCa/zbpBLqHyfOCP
         W/EyLythaEBSa+d6UDaK6e2lz8M169T4gWO8XthtIjJBaFoqdbvxjuPxWN4HuFyKtPqN
         w4aKXRjww/HP31cqXh6H8td3oNPZx4SrEXDFnw8IPSY/Zd6RXon3Aag5wTqeQOOQintC
         QeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776631; x=1752381431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkHPe6LE8OXWdD0I5CLih7m7+WFtKYT46OEMON9KnWQ=;
        b=Q4skcTmeljoSsEZK2GUDMe/NWWt1tNyqlRqsg7FlZEm4TmMvLO8G6+nWS2lXL6sxkX
         FneDkqsBP8QreTaNLUG7SjGkgxJIMTS9nIoI1t2D6pF5dZbjb8tWJ0NiIdQ7HUeaElAf
         MVNG7E1x4PfSIFcvJeTrpPibfIMXZ73QeHvfn7Eku3eSvftQckold4wJnSjTbWYfBHiG
         dwNEAO3xALIYAhmN0arBxylcwlTRXpSrSayBREzs0C7tk8PKgOMVDl5AkWvJYlk80qCr
         TwP0hKhSFg9dkrCZ+dEvlzB/JQS2ROyftOTbbSCJH9Tr3v9TrewDh9GpvpNrKvmdkAhJ
         oUvw==
X-Forwarded-Encrypted: i=1; AJvYcCUAuBFafTxXRPzFKHU60F+l/Ovz3bhFIrRze0ChR4s780HEPTwf81TLeaD9wFe1UaoRx3BSjrHaOcljBHk=@vger.kernel.org, AJvYcCVsBtHFEvMGu3C5quy3x30/XX50JDdggOHwZmYbW0fqYmLdBGEjOsNK4zg36MndNTKiNgUGAXCD@vger.kernel.org
X-Gm-Message-State: AOJu0YyDazMFVJbNxooJyZWHlMGaqi6cLYsvPeKg+9kE037rCG+NKtR3
	lkGmr0g4eyudbl3SnLJEb4kkQ/t9245PXRHgqr0Hbi/nNXo7qBSonw8E
X-Gm-Gg: ASbGncv78shSVFnbQRwSeHC8iu3n4UE6RPI/nKL+c9RPdTPt4X2g2H2bWMnhPeslgXa
	HhLPNYWVwL08N8eFECdwZIwmuX2XpGPYYd3TXReLJYXR0Djd7ONH8epFpjrgGUCV7K6LqoUu4ly
	9cz+wnPHUe+UZuCeXPZKqSNID/w4EMKhIWM9XKyl0ff4La346SY+JO8MKG5CQYRnVciwdpaInNR
	xlAkB5MiY6IIe6H1+mYP/fqWcNQnQauRTOH4ybzYmo7KLnhhobr2TgAPK2CZxiKhW/3NOiyQzB8
	j3tRwBKia5YGrISB8/EvSZcw/oiNNP1aeU4qMkqsuqBEho05YUModZRRWxa9d5uzsQ==
X-Google-Smtp-Source: AGHT+IHGk8AFJbLfLq2JPJAq88rU8JLJAkLvo3fQgqjmGI7NA8C+iaMBGdiCICDxGFishDdjSB5qyg==
X-Received: by 2002:a05:6a00:3e21:b0:748:f365:bedd with SMTP id d2e1a72fcca58-74ce8ad63cdmr10121558b3a.17.1751776630879;
        Sat, 05 Jul 2025 21:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:10 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:29 +0800
Subject: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
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

When hv_sock was originally added, __vsock_stream_recvmsg() and
vsock_stream_has_data() actually only needed to know whether there
is any readable data or not, so hvs_stream_has_data() was written to
return 1 or 0 for simplicity.

However, now hvs_stream_has_data() should return the readable bytes
because vsock_data_ready() -> vsock_stream_has_data() needs to know the
actual bytes rather than a boolean value of 1 or 0.

The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
the readable bytes.

Let hvs_stream_has_data() return the readable bytes of the payload in
the next host-to-guest VMBus hv_sock packet.

Note: there may be multpile incoming hv_sock packets pending in the
VMBus channel's ringbuffer, but so far there is not a VMBus API that
allows us to know all the readable bytes in total without reading and
caching the payload of the multiple packets, so let's just return the
readable bytes of the next single packet. In the future, we'll either
add a VMBus API that allows us to know the total readable bytes without
touching the data in the ringbuffer, or the hv_sock driver needs to
understand the VMBus packet format and parse the packets directly.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
 static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 {
 	struct hvsock *hvs = vsk->trans;
+	bool need_refill;
 	s64 ret;
 
 	if (hvs->recv_data_len > 0)
-		return 1;
+		return hvs->recv_data_len;
 
 	switch (hvs_channel_readable_payload(hvs->chan)) {
 	case 1:
-		ret = 1;
-		break;
+		need_refill = !hvs->recv_desc;
+		if (!need_refill)
+			return -EIO;
+
+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
+		if (!hvs->recv_desc)
+			return -ENOBUFS;
+
+		ret = hvs_update_recv_data(hvs);
+		if (ret)
+			return ret;
+		return hvs->recv_data_len;
 	case 0:
 		vsk->peer_shutdown |= SEND_SHUTDOWN;
 		ret = 0;

-- 
2.34.1


