Return-Path: <linux-hyperv+bounces-8430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLI0GeNPcWkvCAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8430-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:14:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 497515E9C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60D415A1473
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21643E9EE;
	Wed, 21 Jan 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y99EiGsF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13F421A0A
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033528; cv=none; b=E5zrvrzxtZ9pfHOZ7H9Wmiq4FrnYwqIP1c88t+h7GX456AxuVvPioMjHLuX6QoCHklx/2BkjqzP+5NXFYpB/gtC6Y3vIX/YFzlPzMp0kWpH0qzzM2IxjLY2xREjwolVM3XszE5ztx0/dLZGGzykZ+5CsDW5scH+0j6qmW6sGrJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033528; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+4PXpkxR7xml1xGBkfEEK/nD8t54YKdtazzt/XklIoUkOt+1Hm66Qlxir8cpLuy0j5dIQ/ZIgqRPxt8zbA6OZ8ZyESFvKzwL9KkC20atGLgXBLroE1USgWQ0cM9Q3uG7eRtfuTLSI/xn9/Zq1BTkDIk4KTCjrCj23ki4Yry8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y99EiGsF; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fdb90b670so2970447b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033521; x=1769638321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=Y99EiGsF9tk6R+Itkzxd0coovOKy9u52A1TXP4htixp2HgvCl6iJKdLzALNJZbVNzj
         aJZcvkUY/XMAR+yvEorllUkeZVJ7k7WC6zO1pZIcx8Ql8QQB95xchErZ6Ky0QukvGaAn
         ZStdmxheSgLVJkjkLAxtRJFmIGaW7mqAe9npBxjYaYz7YYCGdaWdz4TfWJEPTEuDt4UH
         zYBc5LesM3ZKR4CSql4qIdUQkNDkGMYmFXAom1jQ7ovREkwAMjGx4hSmomH2LVdtKYdD
         F4WQ0B9Ix79eBtf5yFI6ozINVYcYe1yQk6QNiFgjkMm/M1/ynQOIsw44A/3Sr/regoPl
         No/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033521; x=1769638321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=CwTRFTbW9C+RljrZs1/XDYFY+kEeTATRXCTrcaNTxh1pQ7K1BP8/TdLaNGYfdhYw0v
         A/+umuRgrxsO4bAQG0Vy9JX0MyaiNcXbYDO5fQOW2bAxR3IN02XIXJ8wZVpGq/pg//+U
         dGrsnFNIIUm5deMQXOD9Lv9smmAmKTw8/rWZWeo55b1GSjloCDTjhtIETRKhMb1nVvOa
         E4GZ9aU3rILwiT9XbzulhiYxn6GcnInA2vMOuUEINqCuGUlkox3Tk4xiDx6L66S5jFmP
         tNqjgN4017gSEbacvJZ+9mJD17iCzJdJ3BhvSWrdpagkY+9eX/lYyy4JFvUMWpX7V6Ey
         MRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnS5sseoUBYOtTug+F5a3nvXU+Bc8RBEaJ+IVDWJf1thTi7EBrMpfPnHXKLLw4YNM/kaXYTuPeLtee3yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYT662++DRhFsQENOKi3djJUZF08s7nxMwbr/eWWPK124hCvaE
	/g1gc7QQActg5S8XnJPL2BXekvZn12/jluBjOsKwoSYyH/Dl74oX9N8D
X-Gm-Gg: AZuq6aKbvWpkPUCzDHilgDuIcaHuauUeFF16flTenBWdInMW46C9T8Nk1zWBhhTvHyd
	rAoNi9glRkT4wpNgJeBtLPBr+AP25Jvnhzglan9Cacdg5acQ7F45CWtF7T+YeUhPpX04zhCKKAj
	e2P+XqEAM7KwhueyVmNPDcVoM6tWKQHp/r9uzN51TmeEMPpszdEjIgoC3AqMRb79l14/qEwqcjx
	XsYm6xrGHInfQbVc0iwx2lVJIK3JhBLE1k4dsK2cmBykLwVva4fXT9zGJQAVHSTV0R+DB90dKDw
	/mH6sPdyWOItOKal7vPF9G62mpR/UNVaNv7hh8T+NfN+ulqWGbT6407WieX/spYyZN7QjDMPP1v
	boSZrahHkHaTlwI5C+7uNcMQA/5Ot8AdoQOD+uD6nRvORuXteoWQ/zfjzMSbViyRck8BMFxxJrr
	SbyTmZ6tXH
X-Received: by 2002:a05:690c:4990:b0:794:2ef:a445 with SMTP id 00721157ae682-79402efa762mr75302437b3.15.1769033520799;
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794295ec411sm5665437b3.15.2026.01.21.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:42 -0800
Subject: [PATCH net-next v16 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-2-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8430-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 497515E9C0
X-Rspamd-Action: no action

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


