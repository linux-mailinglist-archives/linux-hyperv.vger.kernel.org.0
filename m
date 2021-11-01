Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4CA441C56
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Nov 2021 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKAOSI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Nov 2021 10:18:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOSI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Nov 2021 10:18:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F03752195B;
        Mon,  1 Nov 2021 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635776133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HuhZeq0vdKOIGaUmo7BdgypTDB6banM6V2x33G2xT/M=;
        b=WExAJiEmxaUb3UKF8TzK4kaZu8eOp/fFMOpN+48NwkHx1jNqgrkwVAfPQwtSfMC+DxXTkR
        01xqQSXzuyQOA6jhiIbWCVf/qFB4BHCZwOAlaqBdiJo5U5/bQFkMIhfB2jRpIQ+ENopTp2
        OujmDkvDr0tTfr+wNNYFZdj98cKUWRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635776134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HuhZeq0vdKOIGaUmo7BdgypTDB6banM6V2x33G2xT/M=;
        b=S7h0YOxs9Xi6vVoq04SZ5tunMezUuBSwMAMZdvzEd6mmS7Kn8+EiZY8cg2xP8kV3xuP95e
        js0TCaMPe4RK8gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA261342A;
        Mon,  1 Nov 2021 14:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5IrQIIX2f2GlHwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:33 +0000
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
Subject: [PATCH v2 0/9] drm/simpledrm: Enable damage clips and virtual screens
Date:   Mon,  1 Nov 2021 15:15:23 +0100
Message-Id: <20211101141532.26655-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enable FB_DAMAGE_CLIPS with simpledrm for improved performance and/or
less overhead. With this in place, add support for virtual screens
(i.e., framebuffers that are larger than the display resolution). This
also enables fbdev panning and page flipping.

After the discussion and bug fixing wrt to fbdev overallocation, I
decided to add full support for this to simpledrm. Patches #1 to #5
change the format-helper functions accordingly. Destination buffers
are now clipped by the caller and all functions support a similar
feature set. This has some fallout in various drivers.

Patch #6 change fbdev emulation to support overallocation with
shadow buffers, even if the hardware buffer would be too small.

Patch #7 and #8 update simpledrm to enable damage clipping and virtual
screen sizes. Both features go hand in hand, sort of. For shadow-
buffered planes, the DRM framebuffer lives in system memory. So the
maximum size of the virtual screen is somewhat arbitrary. We add two
constants for resonable maximum width and height of 4096 each.

Patch #9 adds documentation and a TODO item.

Tested with simpledrm. I also ran the recently posted fbdev panning
tests to make sure that the fbdev overallocation works correctly. [1]

v2:
	* add missing docs (Sam)
	* return unsigned int from drm_fb_clip_offset() (Sam, Noralf)
	* fix OOB access in drm_fb_xrgb8888_to_gray8() (Noralf)

[1] https://lists.freedesktop.org/archives/igt-dev/2021-October/036642.html

Thomas Zimmermann (9):
  drm/format-helper: Export drm_fb_clip_offset()
  drm/format-helper: Rework format-helper memcpy functions
  drm/format-helper: Add destination-buffer pitch to drm_fb_swab()
  drm/format-helper: Rework format-helper conversion functions
  drm/format-helper: Streamline blit-helper interface
  drm/fb-helper: Allocate shadow buffer of surface height
  drm/simpledrm: Enable FB_DAMAGE_CLIPS property
  drm/simpledrm: Support virtual screen sizes
  drm: Clarify semantics of struct
    drm_mode_config.{min,max}_{width,height}

 Documentation/gpu/todo.rst                  |  15 ++
 drivers/gpu/drm/drm_fb_helper.c             |   2 +-
 drivers/gpu/drm/drm_format_helper.c         | 247 ++++++++++----------
 drivers/gpu/drm/drm_mipi_dbi.c              |   6 +-
 drivers/gpu/drm/gud/gud_pipe.c              |  14 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |   5 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c      |   4 +-
 drivers/gpu/drm/tiny/cirrus.c               |  24 +-
 drivers/gpu/drm/tiny/repaper.c              |   2 +-
 drivers/gpu/drm/tiny/simpledrm.c            |  41 +++-
 drivers/gpu/drm/tiny/st7586.c               |   2 +-
 include/drm/drm_format_helper.h             |  58 ++---
 include/drm/drm_gem_atomic_helper.h         |  18 ++
 include/drm/drm_mode_config.h               |  13 ++
 14 files changed, 264 insertions(+), 187 deletions(-)

--
2.33.1

