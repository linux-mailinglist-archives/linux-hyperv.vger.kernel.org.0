Return-Path: <linux-hyperv+bounces-2490-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AF916178
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00A2B2459D
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276EB1474D4;
	Tue, 25 Jun 2024 08:38:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E118E1F;
	Tue, 25 Jun 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304730; cv=none; b=ORUvl1grSTDz27gXRpIE1Hj8QAoLsRChDEt52yN7GyR4KHagRfM1q1Acp/7IPPQri5l3Ec2bL07XuvpnCNVqy5/8C8UxlmkWNEdSnXDINg7hzUK6zhgv4WV6Ps4Bob1ug1B7Sfegv5l0bSo0IG/bNgr/YG+UMqycirT3TLb5oKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304730; c=relaxed/simple;
	bh=HHYyyCwOqTRvQoRZ0xSQ2/wl+Sm1u4EXKzPTkMqM9EI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a47kmpX8/qUPMaiSatL+RUX+l0+cwKd6GLrQWflo/3vQ+GN03MUV21vSUNKGB+r+fGXPwFKoVK10sT/T9QRtQT7hEvcLLDlhjiOlWRQK/WtEfbY5u4c9syb+hh6CKDN+vo9JEbR7kKMxjY66xIwPxWSZmsqdkgQps/h22OdZ1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAAXCJn5gXpmc5SiDA--.29808S2;
	Tue, 25 Jun 2024 16:38:25 +0800 (CST)
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
	schakrabarti@linux.microsoft.com,
	erick.archer@outlook.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] net: mana: Fix possible double free in error handling path
Date: Tue, 25 Jun 2024 16:38:16 +0800
Message-Id: <20240625083816.2623936-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXCJn5gXpmc5SiDA--.29808S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4rAFyrCF45uFy7GF15Jwb_yoWDGrX_AF
	yj9rn5Jr4vkF1Skr13KrWrZry0k3yqq3s5Xr1xtFyfK34Uuay5WrZrur48XrWkWrW8Aanr
	u3sIkr17A3s7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOrcfUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), callback function adev_release
calls kfree(madev). We shouldn't call kfree(madev) again
in the error handling path. Set 'madev' to NULL.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- streamlined the patch according suggestions;
- revised the description.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d087cf954f75..608ad31a9702 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2798,6 +2798,8 @@ static int add_adev(struct gdma_dev *gd)
 	if (ret)
 		goto init_fail;
 
+	/* madev is owned by the auxiliary device */
+	madev = NULL;
 	ret = auxiliary_device_add(adev);
 	if (ret)
 		goto add_fail;
-- 
2.25.1


