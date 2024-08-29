Return-Path: <linux-hyperv+bounces-2910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B76963C55
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 09:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067BD1C237D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2222181339;
	Thu, 29 Aug 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NkGBduH/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00317623C;
	Thu, 29 Aug 2024 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915616; cv=none; b=ClAghSugblbs+AkybGAGgpvUnM/1MLmLUpId+zwsU3iH7+hlZBlJL635XtUv4/ISaWC6zG9Cmc22rLfdC5kP5NUzBUo67oLi20qs3H/29qBMd6AlK13M54vXXIc361QSK1mCDOqYzIruxOB2KPNmNXTuXhveTHpmoRELhEHcCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915616; c=relaxed/simple;
	bh=ldKBYdUvNHYeeJ6vlalxxpge6bh+839fygUyeHLhNOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOtpDgNnIrG7RbMJhXUM82Hnhd0GpwdiCpUOCVft/ejFe4+5BYn+49cMmsofqwieZ4ShT/M0bK/9VGKJK9RSwQRiPXp9F5uHWRcXQUu1gHlkxZ74ByN+IM8toLqOojH6+mQe00+CU+KXBqBmTBLTy1VXsQZzv7HNjBiQ9g2bi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NkGBduH/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4CE720B7127;
	Thu, 29 Aug 2024 00:13:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4CE720B7127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724915609;
	bh=JU+1ZnX25glSX/NUmIYc8XIrpbMICNUqMV7QnaM/p2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkGBduH/iS/S0iVDwtv50gxtkGD3ewotMDEiyj+r3irQPjvWTe4SlI7QROUezpbT8
	 vF8S91rdB9emj7sOkUZekSwZlMLW7S22C3Sp9fu/Euq3YiZYpamMip2K2qjKORFJeQ
	 WS72j1tF6nXNP3ZSz81FAx7p65sIcZpI32TneBJI=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind
Date: Thu, 29 Aug 2024 12:43:11 +0530
Message-Id: <20240829071312.1595-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829071312.1595-1-namjain@linux.microsoft.com>
References: <20240829071312.1595-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

For primary VM Bus channels, primary_channel pointer is always NULL. This
pointer is valid only for the secondary channels. Also, rescind callback
is meant for primary channels only.

Fix NULL pointer dereference by retrieving the device_obj from the parent
for the primary channel.

Cc: stable@vger.kernel.org
Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index b45653752301..e3e66a3e85a8 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -106,10 +106,11 @@ static void hv_uio_channel_cb(void *context)
 
 /*
  * Callback from vmbus_event when channel is rescinded.
+ * It is meant for rescind of primary channels only.
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*
-- 
2.34.1


