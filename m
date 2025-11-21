Return-Path: <linux-hyperv+bounces-7725-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E486C77205
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 04:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5004D2C84A
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 03:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E442E8897;
	Fri, 21 Nov 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dJnD1woi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9F2E0418;
	Fri, 21 Nov 2025 03:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694677; cv=none; b=LysMRnOtE0vLVDV+zdK4lMjuMUrBpO0OUtNmztijx9IjuH1j+JILeIxg0yBl4dWq0OlP1Ayf19Zd9jYaBQxqzgfwTWCaBaq0zGwyCGSAD+MoTiVmw0Yn7AWsSFbCbGRFq6B2OKy8lPNdUXqJAJTSf+K0VkEJjmutImp5j6dpOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694677; c=relaxed/simple;
	bh=hBWs+LmYlwg3Gb/oFb9zczcItK7fGAYqQ9eFiNEU2KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBHtlgA9cq9D1Iby/5nsF8NHapAw8iYBeqy6hM54yMsJC5zRzww45L1KEU2t/ClTT/OBdG5CDmLTrcHLMP0L9ZXUpGRRM7YrjodWro+oBBypF0K2iFZeO+K34qKCShdEiYqZWaEdHR2QYUknMRGVd9dXFNHtiBQJDNUMGfhaN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dJnD1woi; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dv
	ciVAJoKYnPSiG4xmqUCXX+O3GTlVU/QdVFRdjYScI=; b=dJnD1woihhpxpEdJ2p
	Lk0UKtSObjoQyCJUkMnoOaVeXtJ1fKEIfKbBmuhfY7vKNXUw3lcl5peAKhXWm5dj
	0SgMHDTkvqtYcJbQmxBYQ2mDpDWPteL20Q0LSWrNe+XXJdP0WOOmpk617Y57aeNI
	NnQqPWVCimROck8797cyRz3Gc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3rcQz2B9pv2uDEg--.947S2;
	Fri, 21 Nov 2025 11:10:44 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH 1/1] Drivers: hv: use kmalloc_array() instead of kmalloc()
Date: Fri, 21 Nov 2025 11:10:41 +0800
Message-Id: <20251121031041.56619-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3rcQz2B9pv2uDEg--.947S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr48ZF13tw4fArW8Gw43GFg_yoW3KFXEka
	y5ZrW7Gr1jywn0vwnxWFWrZF9Ikw48Wr4Ika4qqryfJ3srGa93XrW0vr98Zr17WFZ7CF9I
	ya1kCryayF18KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn9Z23UUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXA0NumkfyffYFgACsi

From: Gongwei Li <ligongwei@kylinos.cn>

Replace kmalloc() with kmalloc_array() to prevent potential
overflow, as recommended in Documentation/process/deprecated.rst.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/hv/hv_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 36ee89c0358b..7e9c8e169c66 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -586,7 +586,7 @@ static int util_probe(struct hv_device *dev,
 		(struct hv_util_service *)dev_id->driver_data;
 	int ret;
 
-	srv->recv_buffer = kmalloc(HV_HYP_PAGE_SIZE * 4, GFP_KERNEL);
+	srv->recv_buffer = kmalloc_array(4, HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!srv->recv_buffer)
 		return -ENOMEM;
 	srv->channel = dev->channel;
-- 
2.25.1


