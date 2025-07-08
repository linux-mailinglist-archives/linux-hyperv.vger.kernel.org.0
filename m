Return-Path: <linux-hyperv+bounces-6142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EADAFC2D5
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC24A4B19
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19CE224B05;
	Tue,  8 Jul 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Bygch159"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831E1E48A;
	Tue,  8 Jul 2025 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956617; cv=none; b=Bk4G/DIlhBFkvQGPvnQnEFqFSs4q3oxZi3oElxXbye46xpjT04+xJr6zvYoSHEIxZu0bcVzhfwz9HVfcH+8DGzQrX8sk3O7PXDSo3AMIp21lgJ9yDNc5aUv86yar8YVsA91ljf4KCTEEXriyInGZd6SzQ261T53BlcAvvJIMS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956617; c=relaxed/simple;
	bh=e6+A6V/GIHjY2NtS85toohY3fDmWeS+De+ENSmkaW48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIAJDGlP2fFLOwiP1JjGOp0ykKSsA89EWYfxIIUEYISkXjhFF1J7JXv7nhYLfKf7hUPXLJcJo+wnhvMAhxsQ+x21oiQYxPJD22P3X0h8t9fg8mtSa5Mw0dRnh5WBjgYD0P4YHj9vXhYgnVBfhnbpBcXyonVrtrszKNne+UzAC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Bygch159; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956607; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=+Adkwaehj8WQlyxe1tcyATntmfd0OiZXAi1oQdyK2Hg=;
	b=Bygch159+jT2UvdH3IEyBuVtOG/tTZ+scNwiJRNh5pGfgQu/ZnvJsz692D2JBB8nv/svJ6482ufRaLWEbIs+09tVTNXQniGphK1tcJOQ4rjDDiSC7o3CpEHnmjVTs101O0LpMbUYloI5iWkoK7ZNVOsCUkIVOus1ZqPckw+1OW0=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAgC_1751956605 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:46 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Tue, 08 Jul 2025 14:36:13 +0800
Subject: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
In-Reply-To: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
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


