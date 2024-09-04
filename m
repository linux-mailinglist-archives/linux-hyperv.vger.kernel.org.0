Return-Path: <linux-hyperv+bounces-2936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD696AD9A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 03:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84F51F213B7
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F21FC8;
	Wed,  4 Sep 2024 01:07:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07163D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Sep 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412044; cv=none; b=qgSkat/tBxXvmXtbC1uUFYEPsLqr1BU7k97fUAVQ+C6+Nf3GvpCkun+EpYGbLYsVJooZZ9oaJrS9oySw/VrI7np2stBgLFjWLjGqt3+XMz7HkIrEVe7rfkDveQKFL9ubdsqhfk8oDnt6X/s/9jpLj4+gtrf3MEbi170ZY2bRCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412044; c=relaxed/simple;
	bh=EShfjE/wB974wMra0BeHK1EhkNGqeQfMHsbUR5zZMeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnIjDncmEx925ePArznTKaUthI0XAEADLnb5JxqwUBOzGJzylfIf2jRdays7ug3y6A6Op6C6m+mhL1+6ozSU1frw4y39gJ9hRfbl+0HxfpMprQe7eymbnBYkI29CKLClxxx6BW/SNZl4P3YdGWi3il7TY/UA81L/s5CkK56yv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wz44n3Hzdz1HJ6J;
	Wed,  4 Sep 2024 09:03:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E0211400D7;
	Wed,  4 Sep 2024 09:07:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:07:20 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>
CC: <linux-hyperv@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] hv: vmbus: Constify struct kobj_type and struct attribute_group
Date: Wed, 4 Sep 2024 09:15:53 +0800
Message-ID: <20240904011553.2010203-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The `struct attribute_group` and `struct kobj_type` are not
modified, and they are only used in the helpers which take a
const type parameter.

Constifying these structure and moving them to a read-only section,
and this can increase over all security.

```
[Before]
   text   data    bss    dec    hex    filename
  20568   4699     48  25315   62e3    drivers/hv/vmbus_drv.o

[After]
   text   data    bss    dec    hex    filename
  20696   4571     48  25315   62e3    drivers/hv/vmbus_drv.o
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7242c4920427..71fd8b97df33 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1831,12 +1831,12 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group vmbus_chan_group = {
+static const struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
 	.is_visible = vmbus_chan_attr_is_visible
 };
 
-static struct kobj_type vmbus_chan_ktype = {
+static const struct kobj_type vmbus_chan_ktype = {
 	.sysfs_ops = &vmbus_chan_sysfs_ops,
 	.release = vmbus_chan_release,
 };
-- 
2.34.1


