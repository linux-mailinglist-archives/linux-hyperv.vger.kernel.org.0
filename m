Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7494F7570
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiDGFn6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiDGFn5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 01:43:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41577F225;
        Wed,  6 Apr 2022 22:41:58 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5830C20DFD98;
        Wed,  6 Apr 2022 22:41:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5830C20DFD98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649310118;
        bh=njAIMfs922GPPSTZYstgn/XjmiDRTEg/G01+i37o7Ew=;
        h=From:To:Subject:Date:From;
        b=j5o50bjdJUDIA5A6qKqsW9cfwf9wepQSz6Wa+2c+S4CQkSdUzsLXA0SOgESIQ5d6h
         vMjxbauMK8gFbJz+DqOOzhSk8W3wirQacEf//ryKU+Pg/Yg6Z+7RC49Q+yBExCuo/P
         d6waJqGjx9CxLqCz9dvPEq2IdZic+8TveLjThcQo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, decui@microsoft.com
Subject: [PATCH] drm/hyperv: Added error message for fb size greater then allocated
Date:   Wed,  6 Apr 2022 22:41:52 -0700
Message-Id: <1649310112-25848-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DOS_RCVD_IP_TWICE_B,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: saurabh <saurabh@localhost.localdomain>

Added error message when the size of requested framebuffer is more then
the allocated size by vmbus mmio region for framebuffer

Signed-off-by: saurabh <saurabh@localhost.localdomain>
---
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index e82b815f83a6..92587f0b7694 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -123,8 +123,11 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
 	if (fb->format->format != DRM_FORMAT_XRGB8888)
 		return -EINVAL;
 
-	if (fb->pitches[0] * fb->height > hv->fb_size)
+	if (fb->pitches[0] * fb->height > hv->fb_size) {
+		drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater then allocated size %ld\n",
+		current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
 		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.31.1

