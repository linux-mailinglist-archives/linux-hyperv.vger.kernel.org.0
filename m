Return-Path: <linux-hyperv+bounces-6546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95912B29A16
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E8D3B12B3
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2927586C;
	Mon, 18 Aug 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ua6PgbHB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C8262FF3;
	Mon, 18 Aug 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499736; cv=none; b=glzoohxmvI/orlY9hzMmudjeridP1hQoMgGX5rnYeS8TISyB4g1KL5/5f0TilJmqgoPsYDnBoLSqGLq2xF66YrRe07wW7WxISoKb1HoSCD4c5xT9XfJE2H8yD7w/Mhbzqe+YxTuzAfLhkv36eHwK08ewRKDhlKztqoXlXmkxoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499736; c=relaxed/simple;
	bh=qf29ontj62knSZUjSGDm+YP5IlukT+vZhYZCw7Y7mIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nUa0y4VpCUi40aSr1qMEgsvQghJuEL2eEIy3Rxl78brpCLJE5VPJPLc2QC5cRzchmmWVqXE+fAqoCTHSHU8YJwTrTe561Kx7ZF4kn1X3YBa+MYJJ5iF/yPHLS5IfTsqlVF48FrUfJalIY/mZxDdACnGQ5TPBLaE75AjOGdK8Bbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ua6PgbHB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.46])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BC37207862F;
	Sun, 17 Aug 2025 23:48:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BC37207862F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755499734;
	bh=ssueBJB+wj+D0nuvPAikQ44uWBCzF2qQ4x7zNhPzmLo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ua6PgbHB9f8rm8NJ41TPy/MgiihfjbNXulxUwpbAIY9Mn5LoddDXpLLZEiD0CX25Y
	 e+WqYwGBDPJ6G6jplAgln3i1HlEKGmYn/LV9Sm6SRF8C7net/rEqqaaGRJBkPg9cnf
	 JlqdcjcZF182WAFMeh1Dk7ZtTaUFzfVYiFwVHrMk=
From: Naman Jain <namjain@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namjain@linux.microsoft.com,
	John Starks <jostarks@microsoft.com>
Subject: [PATCH] uio_hv_generic: Let userspace take care of interrupt mask
Date: Mon, 18 Aug 2025 12:18:46 +0530
Message-Id: <20250818064846.271294-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the logic to set interrupt mask by default in uio_hv_generic
driver as the interrupt mask value is supposed to be controlled
completely by the user space. If the mask bit gets changed
by the driver, concurrently with user mode operating on the ring,
the mask bit may be set when it is supposed to be clear, and the
user-mode driver will miss an interrupt which will cause a hang.

For eg- when the driver sets inbound ring buffer interrupt mask to 1,
the host does not interrupt the guest on the UIO VMBus channel.
However, setting the mask does not prevent the host from putting a
message in the inbound ring buffer. So let’s assume that happens,
the host puts a message into the ring buffer but does not interrupt.

Subsequently, the user space code in the guest sets the inbound ring
buffer interrupt mask to 0, saying “Hey, I’m ready for interrupts”.
User space code then calls pread() to wait for an interrupt.
Then one of two things happens:

* The host never sends another message. So the pread() waits forever.
* The host does send another message. But because there’s already a
  message in the ring buffer, it doesn’t generate an interrupt.
  This is the correct behavior, because the host should only send an
  interrupt when the inbound ring buffer transitions from empty to
  not-empty. Adding an additional message to a ring buffer that is not
  empty is not supposed to generate an interrupt on the guest.
  Since the guest is waiting in pread() and not removing messages from
  the ring buffer, the pread() waits forever.

This could be easily reproduced in hv_fcopy_uio_daemon if we delay
setting interrupt mask to 0.

Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
there’s a race condition. Once user space empties the inbound ring
buffer, but before user space sets interrupt_mask to 0, the host could
put another message in the ring buffer but it wouldn’t interrupt.
Then the next pread() would hang.

Fix these by removing all instances where interrupt_mask is changed,
while keeping the one in set_event() unchanged to enable userspace
control the interrupt mask by writing 0/1 to /dev/uioX.

Suggested-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index f19efad4d6f8..3f8e2e27697f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -111,7 +111,6 @@ static void hv_uio_channel_cb(void *context)
 	struct hv_device *hv_dev;
 	struct hv_uio_private_data *pdata;
 
-	chan->inbound.ring_buffer->interrupt_mask = 1;
 	virt_mb();
 
 	/*
@@ -183,8 +182,6 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 		return;
 	}
 
-	/* Disable interrupts on sub channel */
-	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
 	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
@@ -227,9 +224,7 @@ hv_uio_open(struct uio_info *info, struct inode *inode)
 
 	ret = vmbus_connect_ring(dev->channel,
 				 hv_uio_channel_cb, dev->channel);
-	if (ret == 0)
-		dev->channel->inbound.ring_buffer->interrupt_mask = 1;
-	else
+	if (ret)
 		atomic_dec(&pdata->refcnt);
 
 	return ret;
-- 
2.34.1


