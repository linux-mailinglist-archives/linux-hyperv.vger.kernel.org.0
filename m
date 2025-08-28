Return-Path: <linux-hyperv+bounces-6650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD87B392A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 06:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478387C41A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Aug 2025 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6E264A97;
	Thu, 28 Aug 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="afYExwtn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D320C00B;
	Thu, 28 Aug 2025 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356133; cv=none; b=s/axeG8P/zA+L86zR+MLbOsYZK4VLbUzP8tWboA8JRyLyGEnhB4FiQd9Ne3/qearVTAmGdTqIxUbSxzvsubb30kHuDzyW7eLBlbg3NqOK7nE5uKFCXVtBApSYF+Z68iK1kzV4w60UrAd7wP8UnLblPbY66OyPmwyrREPLr+ORlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356133; c=relaxed/simple;
	bh=vK5gxf0YYvwb2yP2XOICuQK5XevoMhfonn1mg0+pBc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nOW6nKPS+/Hlt7POOYizlVM8cbPN2UJmPkDLsPVE7AWnk+gKrmOfFBAxt9iPPpGx2PI2hYsg0sqgLdjNQjpkvI7L16fFAJxU+bOreBIi4y2PHEJhfN01Yo+KZgyLmVegT1DaOMui9P0p1z0747a7xNeK1VCDFNF3Nz+ACdKSSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=afYExwtn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.45])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC69E201656A;
	Wed, 27 Aug 2025 21:42:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC69E201656A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756356130;
	bh=pam2zqzqdVPunbK9HD9NJ5WtVBcnGTuHjVPIY36s2RU=;
	h=From:To:Cc:Subject:Date:From;
	b=afYExwtn6YKhVW//9a3zmFW7IzD3dHXgWCl03WIS7YbSuOw7mXHVVASUS5eNS3Cky
	 AcRzh8c4zabEXyvWH4F7rmjanKev9PJIeUXy/C9HW+oN36Dd51fxO87PPz6HGUa2aP
	 i1NaRLXQrplR36htQ6RZhbhKRgOcNtn8IaA/Iobk=
From: Naman Jain <namjain@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt mask
Date: Thu, 28 Aug 2025 10:12:00 +0530
Message-Id: <20250828044200.492030-1-namjain@linux.microsoft.com>
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

Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Suggested-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Cc: <stable@vger.kernel.org>
---
Changes since v1:
https://lore.kernel.org/all/20250818064846.271294-1-namjain@linux.microsoft.com/
* Added Fixes and Cc stable tags.
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


