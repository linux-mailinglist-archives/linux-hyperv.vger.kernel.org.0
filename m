Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44C605D21
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJTKiT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiJTKiM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 06:38:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FE1D73CE;
        Thu, 20 Oct 2022 03:38:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E11901FA90;
        Thu, 20 Oct 2022 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666262282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkMHENyFsh6/3SjkSTuYRYMbHc7R5XzWBBCbrwJgYhc=;
        b=1iiK5H3VCq2QZPD9I6TaLe5/dMWlIhalrt5djJ2luVVaxnv1fAuIh/hwuw6a3/WNyh20Zx
        q30hl/TTc5vv9pZ08LkTAQW5UIo5mgzBkMj6j3gzxw0Alyq38w6Ako/4EdwH437ov9gCMb
        69LE0q28P52yd357VRsNAHoJ7rSH73s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666262282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkMHENyFsh6/3SjkSTuYRYMbHc7R5XzWBBCbrwJgYhc=;
        b=x46APQL1svgGc11HQOHFEs8osVroEdR2Ae3IDMhH3RiyBUJNS8G/LmoWWl6MsmYBLslbim
        A0NNGlzosuhEQTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 720DE13AF5;
        Thu, 20 Oct 2022 10:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aMgYGwolUWPPYwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 20 Oct 2022 10:38:02 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, sam@ravnborg.org,
        javierm@redhat.com, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 11/21] drm/fb-helper: Cleanup include statements in header file
Date:   Thu, 20 Oct 2022 12:37:45 +0200
Message-Id: <20221020103755.24058-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221020103755.24058-1-tzimmermann@suse.de>
References: <20221020103755.24058-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Only include what we have to.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_fb_helper.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index fddd0d1af6891..e923089522896 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -32,11 +32,9 @@
 
 struct drm_fb_helper;
 
-#include <drm/drm_client.h>
-#include <drm/drm_crtc.h>
-#include <drm/drm_device.h>
 #include <linux/fb.h>
-#include <linux/kgdb.h>
+
+#include <drm/drm_client.h>
 
 enum mode_set_atomic {
 	LEAVE_ATOMIC_MODE_SET,
-- 
2.38.0

