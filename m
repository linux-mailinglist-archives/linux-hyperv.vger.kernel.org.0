Return-Path: <linux-hyperv+bounces-5356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECACAAB8CF
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC11891FA6
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0332A6E1;
	Tue,  6 May 2025 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="XBd81uXB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAC34FB1A;
	Tue,  6 May 2025 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493009; cv=none; b=kVNKQbumyKm6a10woWlsx2j2GrC3B3fvBckNxArKsEWO75LGUbJVaNlocb4dvae0pMG2eKrqNGliKXCO017mDNBH+7/YJI8Vs0pFgV6T5p8KHVmPcwhJPiVcfZ6Z6hvlPmmdhkM5a6H9DHALG6khcPlJzjpbcUtC2kS5E1wwCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493009; c=relaxed/simple;
	bh=+1GkP85qI28LngPRsSnKVGf3zYfY0BfHkC9fcaE0ldc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UFnXRMzbN3iRTzq1Y8kNGNv2zR1w8ta3UBT3sfiaRjLugkm1YnOl256OrA3a1TdbOXY6mJcrqwxKtNcOTuXeZ84dg4CmE3jZMZZMYdUJXpTk5NGa0FSyRAVxedpDepmx4/fUmLyNIY1P+6d00vT9AfhBuV1R+I9l1NbnpOQpozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=XBd81uXB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id DA8CD2115DC6; Mon,  5 May 2025 17:56:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA8CD2115DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493006;
	bh=U5Gq4AetPfFX7oMakCEVyoFLthNpyCTSJ5kkn3ju7TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBd81uXBcvQA/vmrNcbJMawuyF5dVb/mBt4m2oltAllu9BBKfmbbjVypBX0HwSM8+
	 CXFwkmWZptHknHXVP7DzJvC/3GCE7BAbLjX1k153X/HE6qjf1CwVqQHLci2fJZw2xx
	 OAfvhCuYDAb1mS8REeqKNDFxRHGIKDT9RzwJODcY=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v3 3/5] uio_hv_generic: Align ring size to system page
Date: Mon,  5 May 2025 17:56:35 -0700
Message-Id: <1746492997-4599-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Following the ring header, the ring data should align to system page
boundary. Adjust the size if necessary.

Cc: stable@vger.kernel.org
Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 08385b04c4ab..cb2e7e0e1540 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -256,6 +256,9 @@ hv_uio_probe(struct hv_device *dev,
 	if (!ring_size)
 		ring_size = SZ_2M;
 
+	/* Adjust ring size if necessary to have it page aligned */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.34.1


