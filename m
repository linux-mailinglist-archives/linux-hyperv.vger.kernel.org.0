Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9B650F99
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Dec 2022 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLSQFW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Dec 2022 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSQFV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Dec 2022 11:05:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DFF271;
        Mon, 19 Dec 2022 08:05:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8296C38144;
        Mon, 19 Dec 2022 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671465918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zi9DGAHO0BaQvyNUt7EaCCw0VNS9QAUwHpcrOeBGrvY=;
        b=ij+rxhcqW3W6+MWS3kO8nMtHYN3oDHlgFX/aDSZKOujL11P5YyA5Yp7J4PX+Ti5tiGaxVx
        xHeFpGDS6Y790wnabdtJDtShIYRUJWofvBsZb2l3zrBeJHBo1xpeMSqN/+iClmeP6Oep6Y
        0kAs05m6gO/Z7fZltjIngJrkka93pjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671465918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Zi9DGAHO0BaQvyNUt7EaCCw0VNS9QAUwHpcrOeBGrvY=;
        b=0p4gfUQSsxWvjADe+QY4pLfQhm4JPPLDWnJRyBCavXTyEkQMup1ME/v44uJTj5reo8Uvsk
        RFnYZJeqyymWAzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 487F613910;
        Mon, 19 Dec 2022 16:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TWe9EL6LoGPeZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 19 Dec 2022 16:05:18 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/18] drm,fbdev: Remove apertures structure and FBINFO_MISC_FIRMWARE
Date:   Mon, 19 Dec 2022 17:04:58 +0100
Message-Id: <20221219160516.23436-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove struct fb_info.apertures and FBINFO_MISC_FIRMWARE from fbdev
and handle the aperture ownership without involving the fbdev core.

The apertures field in struct fb_info is a remnant from earlier
ownership management for framebuffer apertures. When fbdev core code
still handled ownership of the framebuffer among fbdev device drivers,
generic drivers set the aperture ranges to claim the firmware scanout
buffer for themselves.

Now that we have a module with helpers that manage aperture and
framebuffer ownership among drivers, the aperture field is not needed
any longer. In fact, several drivers set this field, even though they
are not generic fbdev drivers. Only drivers that set FBINFO_MISC_FIRMWARE
can use apertures in a meaningful way.

To remove FBINFO_MISC_FIRMWARE, patches 1 and 2 remove it from fbcon. It
was used to work around issues with font loading. That is now all handled
in userspace.

Patches 3 to 9 remove aperture setup from all non-generic drivers. These
drivers are not for firmware graphics and do not have to set the values.
For DRM, we do not need to allocate the apertures field any longer.

Patches 10 to 17 update all generic fbdev drivers to manage aperture
ownership by themselves by called Linux aperture helpers. The setup of
the apertures field and setting FBINFO_MISC_FIRMWARE is being removed as
a result of that.

With all of its users gone, patch 18 removes FBINFO_MISC_FIRMWARE, struct
fb_info.apertures and the fbdev core's aperture code.

Tested with handover combinations of efifb, simpledrm and radeon.

Thomas Zimmermann (18):
  fbcon: Remove trailing whitespaces
  Revert "fbcon: don't lose the console font across generic->chip driver
    switch"
  drm/gma500: Do not set struct fb_info.apertures
  drm/i915: Do not set struct fb_info.apertures
  drm/radeon: Do not set struct fb_info.apertures
  drm/fb-helper: Do not allocate unused apertures structure
  fbdev/clps711x-fb: Do not set struct fb_info.apertures
  fbdev/hyperv-fb: Do not set struct fb_info.apertures
  vfio-mdev/mdpy-fb: Do not set struct fb_info.apertures
  fbdev/efifb: Add struct efifb_par for driver data
  fbdev/efifb: Do not use struct fb_info.apertures
  fbdev/offb: Allocate struct offb_par with framebuffer_alloc()
  fbdev/offb: Do not use struct fb_info.apertures
  fbdev/simplefb: Do not use struct fb_info.apertures
  fbdev/vesafb: Remove trailing whitespaces
  fbdev/vesafb: Do not use struct fb_info.apertures
  fbdev/vga16fb: Do not use struct fb_info.apertures
  drm/fbdev: Remove aperture handling and FBINFO_MISC_FIRMWARE

 drivers/gpu/drm/drm_fb_helper.c            | 20 ++---------
 drivers/gpu/drm/gma500/framebuffer.c       |  5 ---
 drivers/gpu/drm/i915/display/intel_fbdev.c |  7 ----
 drivers/gpu/drm/radeon/radeon_fb.c         |  4 ---
 drivers/video/fbdev/clps711x-fb.c          | 10 +-----
 drivers/video/fbdev/core/fbcon.c           | 41 ++++++++++------------
 drivers/video/fbdev/core/fbmem.c           | 33 -----------------
 drivers/video/fbdev/core/fbsysfs.c         |  1 -
 drivers/video/fbdev/efifb.c                | 35 +++++++++++-------
 drivers/video/fbdev/hyperv_fb.c            | 17 ++++-----
 drivers/video/fbdev/offb.c                 | 33 +++++++++--------
 drivers/video/fbdev/simplefb.c             | 19 +++++-----
 drivers/video/fbdev/vesafb.c               | 37 ++++++++++---------
 drivers/video/fbdev/vga16fb.c              | 15 +++-----
 include/linux/fb.h                         | 22 ------------
 samples/vfio-mdev/mdpy-fb.c                |  8 -----
 16 files changed, 99 insertions(+), 208 deletions(-)


base-commit: d322881f7e33af24901ee8ccaec3beef82f21203
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
-- 
2.39.0

