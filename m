Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D193A0A3D
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 04:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhFICuv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Jun 2021 22:50:51 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5296 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhFICuv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Jun 2021 22:50:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0BJM4Dy5z1BJmC;
        Wed,  9 Jun 2021 10:44:03 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 10:48:55 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 10:48:54 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <drawat.floss@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-hyperv@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] drm/hyperv: Remove unused variable
Date:   Wed, 9 Jun 2021 10:49:40 +0800
Message-ID: <20210609024940.34933-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixes gcc '-Wunused-const-variable' warning:
  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c:152:23: warning:
    'hyperv_modifiers' defined but not used [-Wunused-const-variable=]

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 02718e3e859e..3f83493909e6 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -149,11 +149,6 @@ static const uint32_t hyperv_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-static const uint64_t hyperv_modifiers[] = {
-	DRM_FORMAT_MOD_LINEAR,
-	DRM_FORMAT_MOD_INVALID
-};
-
 static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 {
 	int ret;
-- 
2.17.1

