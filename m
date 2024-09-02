Return-Path: <linux-hyperv+bounces-2930-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3353968104
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B21C21D7D
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC318452C;
	Mon,  2 Sep 2024 07:54:20 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF938DD8;
	Mon,  2 Sep 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263660; cv=none; b=YmG+vIWdTE+UubpVaOYmjLU89gznbs0CTF62qxrShiT+QOzDXd5IPU/OXQkgNTQSOljRy9Pb0X1dNYKwjV05kxPe8I8h0uNTBMAGd++s8PzW1Id1/yoJm8yxGAoHJcnlyjjCqhK/0ELKtflzuLRwlViC6L1XVK2rUMtjFjzvYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263660; c=relaxed/simple;
	bh=JGLMsjEt+FMg01r6Yl49z0spSWCj5MOnev+LDEjQvkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHrUrkVJ4ccucEUqIqnqhlVC5D2LyjQbEpgLhCHavs5QkAFqdKc5GsFw8iCHSbqcjyN7tQOSPLkX181ZkRSaEwgcbNw7IvuI2lVVmB4gWB9QEXeJ89xmpc47bs/hC7oQ5ornpEs6rMiLhmYeK+Xa6UmIv5y2sXWH2vQ5HPJO79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADn7X23bdVmIymEAA--.21911S2;
	Mon, 02 Sep 2024 15:48:07 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	gpiccoli@igalia.com,
	mikelley@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] fbdev/hyperv_fb: Convert comma to semicolon
Date: Mon,  2 Sep 2024 15:44:02 +0800
Message-Id: <20240902074402.3824431-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADn7X23bdVmIymEAA--.21911S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF17Xry3tw4kWr1fCrg_yoWfCwb_Cw
	48ury8WFsrKFnY9r1xAw13Z3say3y7Xr4fZa9Fqr93JFy7uw1fXr13ZFn7Wa4jgryYyF9x
	Jry2q3yI93yF9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr4SrUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: d786e00d19f9 ("drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic notifiers")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/fbdev/hyperv_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 8fdccf033b2d..7fdb5edd7e2e 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1189,7 +1189,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	 * which is almost at the end of list, with priority = INT_MIN + 1.
 	 */
 	par->hvfb_panic_nb.notifier_call = hvfb_on_panic;
-	par->hvfb_panic_nb.priority = INT_MIN + 10,
+	par->hvfb_panic_nb.priority = INT_MIN + 10;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &par->hvfb_panic_nb);
 
-- 
2.25.1


