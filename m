Return-Path: <linux-hyperv+bounces-6151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4EDAFC8FD
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EDE7A5581
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECE2D8DAF;
	Tue,  8 Jul 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1zttYPN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5E26A1A4
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Jul 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972093; cv=none; b=gSZAW7PPpUP++tkmaq/D6pQVI8lZB2dHFZ3XJaad38JMf8tyoBJFOoy6imO1ez/ne12530b1OknhbcOKNcUGL/495XqSPcBq/59+UabwPvDVQINRdUlFvfkir+ZS6CjpH5a+oxyfRvY0W2kwKo4kixVIwERt92SkyPHAYnWJ3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972093; c=relaxed/simple;
	bh=pt6duYiMCIehtx4IxrjJmNZ1YzZaoG3aJy7HoAatvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRLELE9qsXYY+g5pz9894xdBrUkjcHO/3hF/noscnQch1Sw7vbhbpRg/oUW81464KdFPJHQop7YOaWI/YyKhiI3aBJ6R9+s12XBEPnEsxclwpasODww/Ks5wEaFx8aanODQXPKApZGqs+Pc25OS6UphB/kXpgrWWgpvbwVz33xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1zttYPN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
	b=d1zttYPNK7ZaacfyXHtfcHHEGk/IuEzmyv4SX9ytwDmEqN03eOXKaOZ5ERM+ogSted3we+
	SY8za+3pGomfaF9/Dl9TV1o8wQ/uFh7Suf0ilPkbmqwpjbS+ZSNU8UEgNBdpjZ5FUPXon4
	nf+XlIcOvIYAP4GJWwDWwK/s8KKa4lo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-jY3qdq_KOye1aPUu4e5xDw-1; Tue, 08 Jul 2025 06:54:48 -0400
X-MC-Unique: jY3qdq_KOye1aPUu4e5xDw-1
X-Mimecast-MFC-AGG-ID: jY3qdq_KOye1aPUu4e5xDw_1751972087
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d40d2308a4so563996285a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972087; x=1752576887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
        b=QW3dU8ly5eDHeItE8TNo3A2mLHldx+rg5b8w1qStXFpxODtbc2I8Iqx7J9MGW9XT2d
         VA5YFL2wu9RYvABCOEQsTho3iNTZPLYrbBXg85IDyFvTAJn7vLTeLLGsSvKRiHS7OQRp
         pJY+/VxW5BJmucGyHau/xze+/4fzjonneeOTigH2xepUasyeRsMaqz+WK9gXVPdssTel
         vRgrkkX97OoCjRY93XXqznqUL5HRieoEsB1Pc08V0cU9P8AX6QpEs76QmXheX8O5xPlX
         3af/Ao1yceYu6VYRvxYyeDss3dqDrxrBpDSSINLgRL2h9C6+gvcgrGh2/vnE7OXFIFxq
         jyfA==
X-Forwarded-Encrypted: i=1; AJvYcCUunyV7fWvCOuS9bUCFfDu+JfCORIXelBQH+d/RCLGLJ+hGKs3nvdfeLlTEGzbFU+YhfHdlwp4QVxphSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNcLnZ2/DdA1o9EBSbAcGcTW1QWPvkimrEfHQaMWZDRtIZNRZ
	34Za6nZCRymLCNbnb4GaWDpJG632lYWI6lYoAF94yDxUVpVh5e7nNKX4W9+FcfaP8PrKqLHZqmP
	mdM3T0l/K6yMy9UE1qH43RWiNEVUiCDEAZjJXX1M43+ZYkfass1KeTnL2i0+/2BCb3Q==
X-Gm-Gg: ASbGncvf0sC0eQoTOe54gyTDMa9/1CtGGQRSy16tpFK3XjORW1OEw+SB9RX3G1LK1Oa
	mlwMtLPsuokqPD6HWRHBC9EversAOr45ZqoDMhVaQwj3gaSTXn8RfDg0L7H8z0Jc299Rlhg3rPw
	cU8/qxoJdml+lB0Co2tA9074tVfm+7guDacgF34l+Wybm/X/i01nqQcC8XgG9Mi76ONLE6BLbla
	xLR1TTl0CpPGXpDacPaDH479rlVT7Jz9lfKplunhz1LsLrbRWyqwQoj7ZG4oafI2uVGnO5ZjLGR
	uUR3cEloJCh/WIWIjHNQNcUYSNFC
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344296785a.51.1751972087244;
        Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGODJ+k5iQwpBD8zrN9hRkPcNeibB7riAG/EN8ncnQ9dHTW0DTOP7oRQy4VBda/jQ7Oc5xqfg==
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344292285a.51.1751972086595;
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm757715685a.86.2025.07.08.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:54:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <xvteph5sh4wkvfaa754xxakufgwkjzjawzfttnfqcvmei2zcpf@ig6fawckff2h>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:13PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int actual, ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, &actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret >= 0;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
> }
>
> /* Create socket <type>, bind to <cid, port>.
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>
>-- 
>2.34.1
>


