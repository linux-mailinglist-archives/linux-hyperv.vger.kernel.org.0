Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD84665F61
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jan 2023 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjAKPlf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Jan 2023 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjAKPlc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37602DA
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Jan 2023 07:41:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so11378029wmr.4
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Jan 2023 07:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2sqw4liQtpNZ++ehK/ijyVQMT7dm9/yDDOGWgKM06Q=;
        b=QFSULLmMVFFwJ3kPRo04bI+cTmjJnjfKH40bscRWkka9KWLPADsKgemIa4JXzvMkeK
         v49Cp1Za1fPlLnKdgCl4jKo453bf3sIRTGpbcHpGl7KAbEP0dJP61vP0ovBnnh98zN2z
         7FfdaXLc80KuSpk0fZAE3Tu5F7hg8nJd6DWYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2sqw4liQtpNZ++ehK/ijyVQMT7dm9/yDDOGWgKM06Q=;
        b=2pHtfyXKh45TKTbSzmf6FzkdzLwCxJP2TY1VDh4h5uwDDfd35T96DCuFo7sfT3WKvA
         vsNJgjC1oLUIDvEyduffQNlK1UA0HXcvfqQMN05FzaYIm7CIV1NuVeog8vN+J+MuldrJ
         zt3aUl/pUZv4Ket5dU5ZbbJVci+PhTO+rc57KT81mqOvpLTgY5/FOt/2Kx7qo1sbqnvd
         S2wjMo62HvbRcemJwwGxvTmoL/V1HoUr6FUiHO4HE2g6Tpz4DUXbedjzLqAGgQhAKd5G
         tvs2aRmOj86ByYxwDN+njBYLaI4MRqyNItyOSP95CYYg//jNApki8SHI+37+OCc26WpL
         NJfg==
X-Gm-Message-State: AFqh2kqc0EBWvcdkqhpGJZ5TN3erI8uqeLW1QT2BhKfctBHUO1ypM2UG
        l0rs6i80LlwlUGOQXw5bJwsADQ==
X-Google-Smtp-Source: AMrXdXu2HH4k8cKyE1wj9+khkbKIw1YYqzdu1nSgmTp1TRqQ4OuVM4kG1tuO5FQh+wMSZkKbA60TGA==
X-Received: by 2002:a05:600c:54c2:b0:3d3:3c74:dbd0 with SMTP id iw2-20020a05600c54c200b003d33c74dbd0mr52401995wmb.13.1673451690779;
        Wed, 11 Jan 2023 07:41:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:30 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 08/11] fbdev/hyperv: use pci aperture helpers
Date:   Wed, 11 Jan 2023 16:41:09 +0100
Message-Id: <20230111154112.90575-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Again this just gets setting the primary parameter right, which might
help in some case (but then I guess the hyperv display isn't vga
compatible, I have no idea). It's more consistent for sure.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/video/fbdev/hyperv_fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index fdbf02b42723..1067a64bbdf3 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1076,9 +1076,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_size = dio_fb_size;
 
 getmem_done:
-	aperture_remove_conflicting_devices(info->apertures->ranges[0].base,
-					    info->apertures->ranges[0].size,
-					    false, KBUILD_MODNAME);
+	aperture_remove_conflicting_pci_devices(pdev, KBUILD_MODNAME);
 
 	if (gen2vm) {
 		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
-- 
2.39.0

