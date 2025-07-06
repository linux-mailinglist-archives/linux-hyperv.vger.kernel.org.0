Return-Path: <linux-hyperv+bounces-6113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC9AFA32A
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 06:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE7F1688DB
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 04:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0221C860B;
	Sun,  6 Jul 2025 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZkq7iHE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A791C5496;
	Sun,  6 Jul 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776641; cv=none; b=PZIGjtB3PT6MNnc5DCVNim2DFtoycr1keuwNgj/+f4NjS/fklDO6Y8+KdLz2R3JVQS4Vh3j8BwUXBHzEypKstVKkUZtlqFHyWfziKlZECgqW147b/QTwkltDnL4QJLI1S7l1s5ljQ8giKiuiUX1Cd3+nIdhbK9HskO3d65YTlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776641; c=relaxed/simple;
	bh=e6+A6V/GIHjY2NtS85toohY3fDmWeS+De+ENSmkaW48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFKoF3fyglnZ3XTQA+MCNjWkIPKx4DJ8ClPsb1w+zO+PGtk6U2aJB/jFXkgPXQZIrAiRUCbhc7dR9bKvGvHDfh2X07FrCs2sdcG1q5CGShaD/Yx86RbrhzLeIfRgOrNkcwVmNNqy6EHX8f/JfO96jfOo8+NGCy/pL8u14e3xHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZkq7iHE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so2812974a12.0;
        Sat, 05 Jul 2025 21:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776639; x=1752381439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Adkwaehj8WQlyxe1tcyATntmfd0OiZXAi1oQdyK2Hg=;
        b=XZkq7iHE+NDE2pvfOJPU2CFte8mnQU93hEKiTtfDkKzjTmhoX+xmNw8Xpip3409p8m
         enOSxPVnzqpP1SqUA5k+f87is7CrSs9ufKE6SJjdwDCcLZpTpUgF0s3W2fA9F7zESREi
         MHO1rUdoNO3cPxT/0oA92hONHSR1972eNGwN21U1a8dSTk7HcG1cgYkapEtYZ6dHoSgq
         SP6xu/n6wM9nGqXoCc8jm0Sl3yYCW11n9B/ZuHPcMd9jw7oI6wICci79PXCdelNtOs1T
         tLg8E/l0ZWJBZyGTPgefUotGQcaxHijikGKZewo3HY9n3E6ahcvWMfb8U6SzMqFmHJAC
         ijQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776639; x=1752381439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Adkwaehj8WQlyxe1tcyATntmfd0OiZXAi1oQdyK2Hg=;
        b=BDltYM79qHdfm6qqZO+wqdz3se2ug2cjfLNTXB99sCtc3uzwQaNG8HYFhmIigBLDtb
         tcNMnXhrD51+50MlJt82S6dqmZe71Cpk1d7gdGdZ7eITnlm5dv03PsI32E1DUoRbNgVz
         o2uNMbQZvDn1XoSLRQ2eZKskaU7VJU0ejIcOciEoTNWTsJu7/XJ8KbcbcDy5Exo5PfQ+
         BI2pam8+lvTb+QoVtDKpqtP0rzSuRfDqV9WzJXqq3o2hliuUMCfIm0hqqbcQHNZP3hvW
         NU4ct3uclL8jVbWk3kAKyFHqw/n5kH6pOyOa+sPiUa2/rDbzr51GIFQS8U6CqzJ98kYw
         EZBA==
X-Forwarded-Encrypted: i=1; AJvYcCU1RVFU1+Cv7Ikv8Gx3vYL6HSFKGWNRF+brzIBNIqcZXJTvU3bL5VfjA1dEj8c5WzBGvA0BliZmipEsrto=@vger.kernel.org, AJvYcCXhPQ2MrzCzvNtr3h6+EyMAkHHtSYeaA3gb00PacIyUoQcv/18kPUDCNOOY6zbkyXWlepQzjsjf@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYM0e/wW4ZVUHUgXZicoS2aWv33dRZ057pZK9/XLGJMy4P8U8
	tB9L44buuDIysa/vI58yx7s1SbEBjGBqIhUHIUVGWRvcxjXOZrk2UbdV
X-Gm-Gg: ASbGncv97GBBP4icI/mmNrBpNIrIfk4j5QuEKzRNDsttXKT3TWM+C/kRHb5ir7bnTZY
	AxhYaohLjRmuinsqcDOWvoGg8Pm7WUnG+TmhxQ+qnnTQhjR0XRIl/QLDfmotZ7O7rmXke7ehKck
	YAn+X4g35bIz5BTc9Xh/N+fSz9YlYLufnn3QlO3ktWyNpTpjmr6aaMTQnAO0OMqLkvzPo6XW2ZC
	gpr+IH77Ookt6NzCWfd2m8XNFToanW84hn925vWKEyfwvep0lLT1q1d8wxNVTwnCG+k3CDg3TWd
	55GcOvQQ/ZF3m0pAl7D4vax1u5DUDLaTbsZeDBpuxFRxPy0pr+1aOHnU4JvNZjBKUQ==
X-Google-Smtp-Source: AGHT+IFTD8Ubs6vrLh9uOBqgWb9R02OzYwWvb5+TvstZ1sZuMkvbVOBc0mozEtb+peNJ0afHcOnIqg==
X-Received: by 2002:a05:6a20:748a:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-225b4fe122emr14819222637.0.1751776638842;
        Sat, 05 Jul 2025 21:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:18 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:31 +0800
Subject: [PATCH net-next v5 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-3-8d0b96a87465@antgroup.com>
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

Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
int value and an expected int value. The function will not return until
either the ioctl returns the expected value or a timeout occurs, thus
avoiding immediate failure.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <sys/epoll.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <linux/sockios.h>
 
@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Wait until transport reports no data left to be sent.
- * Return false if transport does not implement the unsent_bytes() callback.
+/* Wait until ioctl gives an expected int value.
+ * Return false if the op is not supported.
  */
-bool vsock_wait_sent(int fd)
+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
 {
-	int ret, sock_bytes_unsent;
+	int actual, ret;
+	char name[32];
+
+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
 
 	timeout_begin(TIMEOUT);
 	do {
-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		ret = ioctl(fd, op, &actual);
 		if (ret < 0) {
 			if (errno == EOPNOTSUPP)
 				break;
 
-			perror("ioctl(SIOCOUTQ)");
+			perror(name);
 			exit(EXIT_FAILURE);
 		}
-		timeout_check("SIOCOUTQ");
-	} while (sock_bytes_unsent != 0);
+		timeout_check(name);
+	} while (actual != expected);
 	timeout_end();
 
-	return !ret;
+	return ret >= 0;
+}
+
+/* Wait until transport reports no data left to be sent.
+ * Return false if transport does not implement the unsent_bytes() callback.
+ */
+bool vsock_wait_sent(int fd)
+{
+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
 }
 
 /* Create socket <type>, bind to <cid, port>.
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
 bool vsock_wait_sent(int fd);
 void send_buf(int fd, const void *buf, size_t len, int flags,
 	      ssize_t expected_ret);

-- 
2.34.1


