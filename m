Return-Path: <linux-hyperv+bounces-6444-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F541B15E53
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41723170F90
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jul 2025 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD147276058;
	Wed, 30 Jul 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iyzo21Il"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A40635;
	Wed, 30 Jul 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871844; cv=none; b=f8t1vXlkK/U+BUFRIZ/4jLu4k+whZhpIFv6izY9OsCyW0bhaaNJto9ZpvxJlWeRYb83m2vliOgymEi2xPfCh9KwdmPSAI/G940gGv6wEhsH/AVmpDB/hVo/q39qPSrpYqiXg8gnm19fZAqmEQIsAX179ZtqJAlTxGCJTMahwG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871844; c=relaxed/simple;
	bh=5MiY79uSTCiApTgg0QkpOqtP5K3XbFb7C1EdeOFdOno=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ul3uTfxnTxg3ujnbO5yY3kU5ZkCjdZB0lCFLT2aHwNMyfFd/+zFaHyJoSBanpICtMIoCPEkFb9yTLappQkYB+I8SoU1WAn58sP0ioE6Orjfl0EaNozBKS9Up7YZwpOkcmVlZZzxPL43cMnzVGpYze/yy5eUA5gn00qQQtiLMagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iyzo21Il; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1218)
	id B56442120E96; Wed, 30 Jul 2025 03:37:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B56442120E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753871842;
	bh=1dIA69gtHyGW2TAC84ofupzUMnhwLhfuQ5oY/vwlB2I=;
	h=From:To:Cc:Subject:Date:From;
	b=iyzo21IlRvuBuVjIwMfc1y02s9ozJRCbs3oLBTKECB2/wW+alJS3dp2BxSdT+ELWT
	 yvDwrecxVuhU2bcJY4ocPB3Nd4XvsY7/W6Rutw93hdsnqK0sflE9WWsLa6js1cnvA+
	 zzEcuMBoFudFvuc3z/lz59tpfPSB0nM0Tr9qcB/E=
From: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
To: abhitiwari@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@microsoft.com
Cc: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Subject: [PATCH] x86/hyperv: Cosmetic changes for hv_utils_transport.c
Date: Wed, 30 Jul 2025 03:37:20 -0700
Message-Id: <1753871840-23636-1-git-send-email-abhitiwari@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix issues reported by checkpatch.pl script for hv_utils_transport.c file
- Update pr_warn() calls to use __func__ for consistent logging context.
- else should follow close brace '}'

No functional changes intended.

Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
---
 drivers/hv/hv_utils_transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832885198643..b3de35ff6334 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -129,8 +129,7 @@ static int hvt_op_open(struct inode *inode, struct file *file)
 		 * device gets released.
 		 */
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	}
-	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
+	} else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
 		/*
 		 * We're switching from netlink communication to using char
 		 * device. Issue the reset first.
@@ -195,7 +194,7 @@ static void hvt_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *nsp)
 	}
 	spin_unlock(&hvt_list_lock);
 	if (!hvt_found) {
-		pr_warn("hvt_cn_callback: spurious message received!\n");
+		pr_warn("%s: spurious message received!\n", __func__);
 		return;
 	}
 
@@ -210,7 +209,7 @@ static void hvt_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *nsp)
 	if (hvt->mode == HVUTIL_TRANSPORT_NETLINK)
 		hvt_found->on_msg(msg->data, msg->len);
 	else
-		pr_warn("hvt_cn_callback: unexpected netlink message!\n");
+		pr_warn("%s: unexpected netlink message!\n", __func__);
 	mutex_unlock(&hvt->lock);
 }
 
@@ -260,8 +259,9 @@ int hvutil_transport_send(struct hvutil_transport *hvt, void *msg, int len,
 		hvt->outmsg_len = len;
 		hvt->on_read = on_read_cb;
 		wake_up_interruptible(&hvt->outmsg_q);
-	} else
+	} else {
 		ret = -ENOMEM;
+	}
 out_unlock:
 	mutex_unlock(&hvt->lock);
 	return ret;
-- 
2.43.0


