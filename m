Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F773A74BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jun 2021 05:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFODPX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Jun 2021 23:15:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFODPR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Jun 2021 23:15:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3tbs6dwmzZdg8;
        Tue, 15 Jun 2021 11:10:17 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:13:12 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:13:12 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <drawat.floss@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>
CC:     <linux-hyperv@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH v2 -next] drm/hyperv: Fix unused const variable 'hyperv_modifiers'
Date:   Tue, 15 Jun 2021 11:14:01 +0800
Message-ID: <20210615031401.231751-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609024940.34933-1-pulehui@huawei.com>
References: <20210609024940.34933-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is a gcc '-Wunused-const-variable' warning:
  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c:152:23: warning:
    'hyperv_modifiers' defined but not used [-Wunused-const-variable=]

while the variable should be used in drm_simple_display_pipe_init()
as suggested by Thomas, let's fix it.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 02718e3e859e..3aaee4730ec6 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -163,7 +163,7 @@ static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 					   &hyperv_pipe_funcs,
 					   hyperv_formats,
 					   ARRAY_SIZE(hyperv_formats),
-					   NULL,
+					   hyperv_modifiers,
 					   &hv->connector);
 	if (ret)
 		return ret;
-- 
2.17.1

