Return-Path: <linux-hyperv+bounces-2795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAA95B37D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB80E1C22AC7
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BD18453E;
	Thu, 22 Aug 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZxAZ48QA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48856183CCB;
	Thu, 22 Aug 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324972; cv=none; b=FAphtVmSdcEr3BUw1CymuIbj/JU8sAwvXkWQwxggU4WSrjRPn5cQhnxUd/B02QZK12HjERKpdKhz1XlCWvfgHZLhLbaefsasybtbBpzSnlPvH6YxwUWmNJCn2XYjl5zAVdRHxjP/QRrLNWQGh5wsK8JieHZBftIj2IpyRAYDwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324972; c=relaxed/simple;
	bh=aWww33SGyshCww31ZYjn1FdoQIdulYU7ah1T9dhj3/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JnWCw34SfY680wYwxCH4BxISvG3DqTgxFkWYNmARevRcRSLahP5t3v3UyDFkIKOEVxilzvhqqmr+I6lHM3zzNAzDTxbntfnK2nKXm7aajQPVeEPgAwHN8OZHqU5TBcIARIP4zuONyegQokFBn1DvyTu+BTP2pmbotjDgL5WO4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZxAZ48QA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7C9820B7127;
	Thu, 22 Aug 2024 04:09:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7C9820B7127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724324965;
	bh=WzoWiQTMLIDQsHZ0QPN035MdRK7BLJ1MDbjZBC5wdIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxAZ48QAXcdxF0HPHeynI9agHAQ4a9mwHbfiTdXE197vxE4iFk4Cw6z2oVdmUCGub
	 G+P+OXWsmpsb4xMD5Huwwjk1wmaTepcdN0+M2CeF4r+BFObj34+xzbfUH0AyvIx25r
	 wfLDFBBbj/ON6fJm1r59l8R4wuJX4DLamgNbx5cE=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH 1/2] uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind
Date: Thu, 22 Aug 2024 16:39:11 +0530
Message-Id: <20240822110912.13735-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822110912.13735-1-namjain@linux.microsoft.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

For primary VMBus channels primary_channel pointer is always NULL. This
pointer is valid only for the secondry channels.

Fix NULL pointer dereference by retrieving the device_obj from the parent
in the absence of a valid primary_channel pointer.

Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index b45653752301..c99890c16d29 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -109,7 +109,8 @@ static void hv_uio_channel_cb(void *context)
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->primary_channel ?
+				   channel->primary_channel->device_obj : channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*
-- 
2.34.1


