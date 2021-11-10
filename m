Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9444BED2
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Nov 2021 11:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhKJKj5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Nov 2021 05:39:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhKJKjz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Nov 2021 05:39:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3EA921B17;
        Wed, 10 Nov 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636540627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkYQaVKrGH7uTRvl4bz/W0pMqdYAOLpVdgrspXEDLgo=;
        b=2M9ONZooniFT/gdbmz4EnYCN9aduttAFKOcyz7YBU5DtAbngHzLivS2GqYOOHBdzpULvUu
        TV5Ec5iEkdzTxWV1j1Kaz2METEDRQ6yiBAQS1oB3libXS42/f/Z/MrD9EjDwd2rgGxkq6Q
        0BWoKqu+IdNaEvcrqQq4OJ95gJznuAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636540627;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkYQaVKrGH7uTRvl4bz/W0pMqdYAOLpVdgrspXEDLgo=;
        b=sDvOM+0Bkc9eircYBoGci9kxTd/17dgSCU80trUeFT+esBAMiBZzAsxtIcosdJO1CMkxYv
        MYSWfTEoDqkDUYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4999313E72;
        Wed, 10 Nov 2021 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KPvzENOgi2EnPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:07 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
        drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
        david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
        kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
        michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 9/9] drm: Clarify semantics of struct drm_mode_config.{min,max}_{width,height}
Date:   Wed, 10 Nov 2021 11:37:02 +0100
Message-Id: <20211110103702.374-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110103702.374-1-tzimmermann@suse.de>
References: <20211110103702.374-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add additional information on the semantics of the size fields in
struct drm_mode_config. Also add a TODO to review all driver for
correct usage of these fields.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 Documentation/gpu/todo.rst    | 15 +++++++++++++++
 include/drm/drm_mode_config.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 60d1d7ee0719..f4e1d72149f7 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -463,6 +463,21 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>, Christian König, Daniel Vette
 
 Level: Intermediate
 
+Review all drivers for setting struct drm_mode_config.{max_width,max_height} correctly
+--------------------------------------------------------------------------------------
+
+The values in struct drm_mode_config.{max_width,max_height} describe the
+maximum supported framebuffer size. It's the virtual screen size, but many
+drivers treat it like limitations of the physical resolution.
+
+The maximum width depends on the hardware's maximum scanline pitch. The
+maximum height depends on the amount of addressable video memory. Review all
+drivers to initialize the fields to the correct values.
+
+Contact: Thomas Zimmermann <tzimmermann@suse.de>
+
+Level: Intermediate
+
 
 Core refactorings
 =================
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 48b7de80daf5..91ca575a78de 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -359,6 +359,19 @@ struct drm_mode_config_funcs {
  * Core mode resource tracking structure.  All CRTC, encoders, and connectors
  * enumerated by the driver are added here, as are global properties.  Some
  * global restrictions are also here, e.g. dimension restrictions.
+ *
+ * Framebuffer sizes refer to the virtual screen that can be displayed by
+ * the CRTC. This can be different from the physical resolution programmed.
+ * The minimum width and height, stored in @min_width and @min_height,
+ * describe the smallest size of the framebuffer. It correlates to the
+ * minimum programmable resolution.
+ * The maximum width, stored in @max_width, is typically limited by the
+ * maximum pitch between two adjacent scanlines. The maximum height, stored
+ * in @max_height, is usually only limited by the amount of addressable video
+ * memory. For hardware that has no real maximum, drivers should pick a
+ * reasonable default.
+ *
+ * See also @DRM_SHADOW_PLANE_MAX_WIDTH and @DRM_SHADOW_PLANE_MAX_HEIGHT.
  */
 struct drm_mode_config {
 	/**
-- 
2.33.1

