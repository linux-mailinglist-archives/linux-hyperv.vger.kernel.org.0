Return-Path: <linux-hyperv+bounces-2480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500809140CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 05:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7171B20586
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BDF567D;
	Mon, 24 Jun 2024 03:21:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D04C97;
	Mon, 24 Jun 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719199309; cv=none; b=HZWK0KrrpWHBfHB01tvwfez/NNLusZIFJvHPqjrvPfjRhVR2sIL7w/v2zGRsm+FKGkPfOJkDE+0g+iR/mpdf8dFgUwoyMRC9Np/z69vWn2Mp0Njvst7NMtFyTippXnGlPsBu+/7+hpFrOuaxZKwiPFCWMgJ4BaqsQZN/0j8hLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719199309; c=relaxed/simple;
	bh=TPlUmIidaURK649FmMFhIidH8ry2RADSBWmEC7zhf00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQ+rI4sttsWahOWwwkwfvG02KbjVZR+XrNDG9L12mrGvRu8zlst4KLBquWmgIG8uTV1Z7pxvU9g/YidE4vCYJhXLZCAXMrNnl3KyZnaA1lCDLfEEs20rbdqy6yxsJUzk0bOD1EbMdx23ryg3BhGKyDMFAqG3lL3jBD+OgIln6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnr+cp5nhm1XhzEg--.23104S2;
	Mon, 24 Jun 2024 11:21:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	horms@kernel.org,
	kotaranov@microsoft.com,
	linyunsheng@huawei.com,
	schakrabarti@linux.microsoft.com,
	make24@iscas.ac.cn,
	erick.archer@outlook.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Fix possible double free in error handling path
Date: Mon, 24 Jun 2024 11:21:12 +0800
Message-Id: <20240624032112.2286526-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+cp5nhm1XhzEg--.23104S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UAF1fKFW3WF18Zr1rtFb_yoW8Xw4fpa
	13Jay5KryxKw4S9a18Xrs5XFy5W397t3sxury7Cw1fCwn8tFs5ZF4SyFyUGryrXrWDtF1S
	yF4Yv3W5CFn0g3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUGVWUWwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUPGYJUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), callback function adev_release
calls kfree(madev) to free memory. We shouldn't call kfree(padev)
again in the error handling path.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d087cf954f75..1754c92a6c15 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2785,8 +2785,10 @@ static int add_adev(struct gdma_dev *gd)
 
 	adev = &madev->adev;
 	ret = mana_adev_idx_alloc();
-	if (ret < 0)
-		goto idx_fail;
+	if (ret < 0) {
+		kfree(madev);
+		return ret;
+	}
 	adev->id = ret;
 
 	adev->name = "rdma";
@@ -2795,26 +2797,21 @@ static int add_adev(struct gdma_dev *gd)
 	madev->mdev = gd;
 
 	ret = auxiliary_device_init(adev);
-	if (ret)
-		goto init_fail;
+	if (ret) {
+		mana_adev_idx_free(adev->id);
+		kfree(madev);
+		return ret;
+	}
 
 	ret = auxiliary_device_add(adev);
-	if (ret)
-		goto add_fail;
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		mana_adev_idx_free(adev->id);
+		return ret;
+	}
 
 	gd->adev = adev;
 	return 0;
-
-add_fail:
-	auxiliary_device_uninit(adev);
-
-init_fail:
-	mana_adev_idx_free(adev->id);
-
-idx_fail:
-	kfree(madev);
-
-	return ret;
 }
 
 int mana_probe(struct gdma_dev *gd, bool resuming)
-- 
2.25.1


