Return-Path: <linux-hyperv+bounces-6114-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100FAFA32E
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 06:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE2179F5C
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 04:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD81D88AC;
	Sun,  6 Jul 2025 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9wQ/Ath"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5831D5CFE;
	Sun,  6 Jul 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776645; cv=none; b=r7aHQKmVyu+aYmGIRXx31cxTwHjlZAoktvzjUdILzYkLBfL+AGNylw08r+8ZYXS3pZ2C5zANVLAnE6fgnjQo1JtsFnYeXrV6Jj5OkuFuLJVPsHpd+VsiJs5PVWuxcxZm+mByOA9IIgm5jGasyZD3eai6SqDGVc+Cr3ly3N37TOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776645; c=relaxed/simple;
	bh=Doct89OeyNO072Y2Ys7bCVOd+ekwZZ2v2r0ziNK3ALY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSOt3BHB03+Kx+IY4l/XAWDYn4Vkfz96lnq6MeJf9Bnsvts2hPaZIt/r2siM4gSBnSKyGX5i0Coc+kRzAGyLfaLeg8Zt37VK7Qa28OXRbDEy+R51RlmZd+AyyeCK/bLPfXhGpAuy+KUBfKjNZIF6ECAPz377AEbFzT2fSFcT2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9wQ/Ath; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fba9f962so1573496b3a.0;
        Sat, 05 Jul 2025 21:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776643; x=1752381443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78u4kXViM2gstT6OJkwZc50WiKMJcTjBxWIBBOazpAI=;
        b=A9wQ/AthfS8Z1qGdi8uzDvwBn1LKRdGAGjp978NjVTCp95NYJruZe6tcdPoLvZlcfv
         S0mqjYqU3STrpOnyW9q6z7PDbcivMBkt8QDkJ+zK5802wgnrO1rIPzcfazt5zB/xIGky
         T9cm5BkR1zb5KcfcDePduKp8HozfqzuOOUv3BqGrTUg9J67rZTcC6j3AjhzCeuuQH1Yb
         DcJYUegejC+FMc1vNgbkUQhqNhKJQkss/r0jC0sl+/DaTrHDm4PuBZ9NyZohmN1ykpTK
         a57Gc0QbjBw2MsvGfd9gXRJgaFI+siNAe8gy2KttjlaMb+3Z2qts0rsmMjBJq8Nb9nsm
         nLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776643; x=1752381443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78u4kXViM2gstT6OJkwZc50WiKMJcTjBxWIBBOazpAI=;
        b=ATjAtbFpSRvhAnoDYvQm+XLCjFbm4R4v+iXAxd66Uo/9i9sJPUOfks/AimFtcGu1Mk
         3NA1MyRLQfmqypYE/AghQwSsEbKRsl2UoUqwZPTIfeaZ51z7qQw9nQRg87Q0hE7BbSyx
         XnMbWXrbXAqF6V8IuHkxYJ3SSFlJX8cr2ffkhCFMRhWF+yf+Fr+QJ1D/F1bW+aLqHMPx
         q+KGaLdS+cyXzGrMp/+2z+yINLdpRZdwmiQtu36yD5yvrwZsUWGLFYynfe9q94qECKzN
         arUVm2Gq6dwEpLxTnoHf3tTg/TwoCYr8iYDbEWAUCZicfFApKTxgseTJLnfR7tjLP/ZV
         t+jA==
X-Forwarded-Encrypted: i=1; AJvYcCXVxJbwLglFcnonJnEGXuIYG8ZrVo8DK1QyUsIq2kLaFQGqIxsUufO0G8CfioqyGrc5ORt7drEzgWKDoWY=@vger.kernel.org, AJvYcCXjZi59LXPE52BdMmUpJEc5EElNBCEXjnDLcAeIVZQW4oEcyZbRy8UTsZqbjecTacMUSakKUdXc@vger.kernel.org
X-Gm-Message-State: AOJu0YwYajtRpX41cly5zRMd2SaEa8nN7l71DuNCZ37FhDg1++3m9Wwz
	oyOIY3NYF7CVYoVr/M446FZgX04Eia5btBm6uqAOj5FpVzSSfNYd3F1e
X-Gm-Gg: ASbGncuW4x1UQndueoezD9GDvcCk2VRkfqKWz9tdOOduXOEnd7rN/2+YbFABQsN5xb2
	VPGqok6I9Poi4Q/hiexPQZr0K4Fi2UVyFZcGV+6uUFyhvBKaO/hMDI3I9dsNH1EKZUdRvL0bSFe
	GnjsdYhZ3dcDFXqMcFnIw7xCpsLldgtzcqAWBihX9mQpkm0jVuMEVlSEqrOmUs2Q+cZjsq9B2dr
	ACmQ4nzmSOWzAOy7lx2PMnkHyOsNzKVhETxDTEHtEypbpHlyNHig0QagvcMy79npKGAqOfLWB6o
	w0+iH+5k8Jc1nlenKmoVJrga+QBtBYGFMrKqwgahNz9as52if0+7dReOpyTxAL1FAg==
X-Google-Smtp-Source: AGHT+IH2y2QqKJnnc+SmoDKhK3pmoL1e3dI0WHkyQabKVkG03aZHUFCwpTWKs/9Ba4zbMfwP3glYUw==
X-Received: by 2002:a05:6a00:1a93:b0:744:a240:fb1b with SMTP id d2e1a72fcca58-74ce5f5f908mr12036995b3a.5.1751776642904;
        Sat, 05 Jul 2025 21:37:22 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:22 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:32 +0800
Subject: [PATCH net-next v5 4/4] test/vsock: Add ioctl SIOCINQ tests
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-4-8d0b96a87465@antgroup.com>
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

Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.

The client waits for the server to send data, and checks if the SIOCINQ
ioctl value matches the data size. After consuming the data, the client
checks if the SIOCINQ value is 0.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index be6ce764f69480c0f9c3e2288fc19cd2e74be148..a66d2360133dd0e36940a5907679aeacc8af7714 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -24,6 +24,7 @@
 #include <linux/time64.h>
 #include <pthread.h>
 #include <fcntl.h>
+#include <linux/sockios.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1307,6 +1308,54 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	close(fd);
 }
 
+static void test_unread_bytes_server(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int client_fd;
+
+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
+	if (client_fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	for (int i = 0; i < sizeof(buf); i++)
+		buf[i] = rand() & 0xFF;
+
+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	close(client_fd);
+}
+
+static void test_unread_bytes_client(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int fd;
+
+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SENT");
+	/* The data has arrived but has not been read. The expected is
+	 * MSG_BUF_IOCTL_LEN.
+	 */
+	if (!vsock_ioctl_int(fd, SIOCINQ, MSG_BUF_IOCTL_LEN)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		goto out;
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	/* All data has been consumed, so the expected is 0. */
+	vsock_ioctl_int(fd, SIOCINQ, 0);
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1327,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
 }
 
+static void test_stream_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_STREAM);
+}
+
+static void test_stream_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_STREAM);
+}
+
+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
+}
+
+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
+}
+
 #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
 /* This define is the same as in 'include/linux/virtio_vsock.h':
  * it is used to decide when to send credit update message during
@@ -2276,6 +2345,16 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_transport_change_client,
 		.run_server = test_stream_transport_change_server,
 	},
+	{
+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
+		.run_client = test_stream_unread_bytes_client,
+		.run_server = test_stream_unread_bytes_server,
+	},
+	{
+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
+		.run_client = test_seqpacket_unread_bytes_client,
+		.run_server = test_seqpacket_unread_bytes_server,
+	},
 	{},
 };
 

-- 
2.34.1


