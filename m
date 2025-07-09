Return-Path: <linux-hyperv+bounces-6160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A7AFED0A
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610923BE64C
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDF02E6D02;
	Wed,  9 Jul 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0e2KD+R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F642E2678
	for <linux-hyperv@vger.kernel.org>; Wed,  9 Jul 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073549; cv=none; b=eiCqqqrBWx2WwFBEX1XCBad5BY9C3L4bsLO7Zclg38w5CscUvuxVQS91XgUkd7xT3ge5lcoWWB69fRKchFW4JdplCAUU7ZWKaqKf9FxyVEt3e72eEIs2zMz/K9pKsDALE2o19LAHhyivgn3vvcc1v/x6a+beOQEi+JcvOm8gY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073549; c=relaxed/simple;
	bh=m/tt151z5ux7hMXhmxhJ7BxLJ0o0bqtGIuFQnn5UosQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ6LCmQtONr5+9mLJfFWtBa+kyKjXMNwQy+PVTq9BvhV1VhWVRt3iKsNSoiPVKJbCmsfaLmvcI0NDvVQwspUfKK6tfuSgpDtFsteM8p9xsTuAfJWrJE1MkC8415ftvUocA+QeebwErOkyIS7LlvLCXUpKOeAN7dRUr0PYt0mrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0e2KD+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uvFBU/K6+KINjVqqjT8q9fA6T2cNaO+u1OFb0NSXgPM=;
	b=L0e2KD+Ry3GupVkinxO53az7VFQU51qzB8n51gHhvpLgwf1ul7DbmY/pl0ybycZxc7aqzr
	rU0jcMfGOvXmAGkL2/qau4aB9pVvhihCxhe3C8NyBR2NhRs1GzS2+6y2EipA96peU3OHPt
	Pz8R6VpY3mYGH6vLKL3kQlSKCOO0YVw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-NXQ2SL1rMGOjrcgadoRsKQ-1; Wed, 09 Jul 2025 11:05:43 -0400
X-MC-Unique: NXQ2SL1rMGOjrcgadoRsKQ-1
X-Mimecast-MFC-AGG-ID: NXQ2SL1rMGOjrcgadoRsKQ_1752073542
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b39cc43f15so16146f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 09 Jul 2025 08:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073542; x=1752678342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvFBU/K6+KINjVqqjT8q9fA6T2cNaO+u1OFb0NSXgPM=;
        b=wWOBkegpM0/TcWHz0AiENZu/iIRhkYnYojVfIc1C7R80ACkkUYuBTEIQ3VmQ3CQimF
         JEqe+KgxM5GH6KbPUHX2yC24ReZMeQP9rHbKxuW6fqAPYZ3FE6XAHqdce6X8STAH4lHc
         FD+INtji1t828STYrwuIZHmbTNDtpZ1KF8lC4W104YLZ+jnk2rLTqocakYOF7bfiVEd4
         ZfCp3HvgM5feAsFI+FZjPaQ29l9LwYP5g6QT/ujSrvZM44TR3iaBndFOUSOK0y7mhVMt
         GtTzX9oFye1S6kn3bXDXfVE0RUUL2sq1DjCXOazL3qGbRzEe+KSboPTSpK/8Mw0eTBH5
         nM1A==
X-Forwarded-Encrypted: i=1; AJvYcCXlumY3sMpDWFgH9a/5IQLshu/DWxMKhNxeCtQzTHeGdIMBHoL+wvdrjTxzPEpZLOFbQTL3pdndWUCtPII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXBhdjnzJdgQ8XPCT2PHtZMMDhvWeis8x+OEj+Cfgq9WLOAK8
	ozboMs7NvxK0rGLYQxg+tCvoIzMAKWNJqNTI0ha2UhThLEW6zHFWY5cMeL3MgHx9P69UyqiCVca
	AMwyG1PPrDZmK+0+V1kA7wjIKdNtzm8s3I5wIAdc36ZvUJ3lXQnqxIeLKW+JD1YgOhQ==
X-Gm-Gg: ASbGncs8cC9A2Nsxtajz+xo0UFEgtai4Hxs/OoznWJ/4Ot2asMPfBlrz9Tvj6MQ3xFm
	jdIMKrQB0YXZvT2oAst5QvWelz5CSH/JtN4/IkNOsXep4w+qNaNCUbzAqLlowEdk2E0MyCvRpDx
	dJxcpog9kbOn5J5KvoyJ12GpdnSy+ujJpjaS2OG/8ndo7Z6KJ+J9kdFn/e1bPWnMQbi7Moam8Tk
	VzNoj08wfHv1MiZfXPtQ283yyvU7Mo3v1CORHEoK+jxoaqXWK6QDlncx/5OZYZTYAHwaBv9S91m
	H3Z5yj9wB3+kZtxmGk4weI3W+0o=
X-Received: by 2002:a05:6000:22c8:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b5e78d8e4dmr304354f8f.44.1752073541681;
        Wed, 09 Jul 2025 08:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENULoeyQE4yUr9Bfl1DIihXJgUXeW/D01393xr1qgElFSMbyNkVPQ2AkcIO7O6Zl3RAG76Pw==
X-Received: by 2002:a05:6000:22c8:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b5e78d8e4dmr304275f8f.44.1752073540970;
        Wed, 09 Jul 2025 08:05:40 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm15901270f8f.7.2025.07.09.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:05:40 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:05:38 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 4/4] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <j6dgi7ptup6op37lgwpwdvrkfxpnelholoyc3rk6hb26xamgxk@h3nfy4ypnf36>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:14PM +0800, Xuewei Niu wrote:
>Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f69480c0f9c3e2288fc19cd2e74be148..a66d2360133dd0e36940a5907679aeacc8af7714 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -24,6 +24,7 @@
> #include <linux/time64.h>
> #include <pthread.h>
> #include <fcntl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1307,6 +1308,54 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	close(fd);
> }
>
>+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int fd;
>+
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	if (!vsock_ioctl_int(fd, SIOCINQ, MSG_BUF_IOCTL_LEN)) {
>+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	/* All data has been consumed, so the expected is 0. */
>+	vsock_ioctl_int(fd, SIOCINQ, 0);
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1327,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> }
>
>+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -2276,6 +2345,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_transport_change_client,
> 		.run_server = test_stream_transport_change_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>+		.run_client = test_stream_unread_bytes_client,
>+		.run_server = test_stream_unread_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>+		.run_client = test_seqpacket_unread_bytes_client,
>+		.run_server = test_seqpacket_unread_bytes_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.34.1
>

I ran the tests, everything went smoothly!
I had to apply this patch[1] first otherwise the transport_change test 
would cause problems.

Tested-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks for the series!

[1]https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/


