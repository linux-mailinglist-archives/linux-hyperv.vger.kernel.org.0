Return-Path: <linux-hyperv+bounces-2495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1A91688F
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A768283255
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335C14A60D;
	Tue, 25 Jun 2024 13:04:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F51DFC5;
	Tue, 25 Jun 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320643; cv=none; b=LqvP6Fxwi20XvS9q6AmuJVnyNbkHm0nGolDUYHYs0/CLB+t++YhTzJuTuywdz4HV0ns8k4FigbPw1Tv1CaRWLGM6TGxAKkrgVqNX1TtaixsQ4HgxloLQJCQv7LOzWXUVT5AbPfUQb6eWjwWEjbDhtE9f44IRLuzH//5v8hf4xtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320643; c=relaxed/simple;
	bh=vKrctSsMK/Svt99yXvAHe3Wr9BUtj8x6GJqVNkNMQWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BTCfrwTXkaMjrq77/aQKoHxYk4afhObONz68PjsnjI+6cz12tr227Kt9UDy91kYuB4ZHTnOZOy7i37F+vnsdb9uP5+RSYE8P/mDAp9W/Tx4+Nj7ao1oZTykso/iHBtyElz+ctKLGrdnjeDidePw8p5xebrruKXSOTi+y4dquO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABHTZETwHpmyQZnEg--.1722S2;
	Tue, 25 Jun 2024 21:03:25 +0800 (CST)
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
	longli@microsoft.com,
	schakrabarti@linux.microsoft.com,
	erick.archer@outlook.com,
	leon@kernel.org
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v3] net: mana: Fix possible double free in error handling path
Date: Tue, 25 Jun 2024 21:03:14 +0800
Message-Id: <20240625130314.2661257-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHTZETwHpmyQZnEg--.1722S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4rAFyrCF45uFyrurWxJFb_yoWkGFb_AF
	y29rn5JryvkF1Skr43KrWrZry0k3yqq3s5XrWxtFyft347uay5WrZrur18XrWDWrWUAanr
	u3sxK347Z3s7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUby8BUUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), callback function adev_release
calls kfree(madev). We shouldn't call kfree(madev) again
in the error handling path. Set 'madev' to NULL.

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- added a "Fixes" line as suggested.
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


