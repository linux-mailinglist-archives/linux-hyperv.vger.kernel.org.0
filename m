Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C444BECB
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Nov 2021 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhKJKjy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Nov 2021 05:39:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJKjw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Nov 2021 05:39:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8ABF1FD6B;
        Wed, 10 Nov 2021 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636540623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=53iJmWfdXRk2SFeTBr6pDPBHF4ZYIRGQ6uPrSskM9pQ=;
        b=BiDkAHP+MhMn65qKtJSuWalHrxUYX4aSftVEApEAxTGMlS3MoQPGBAETL3B122gJ59GGbA
        VCamWDFYZY5fTNXZuri/M/P+Ywex4IVPHchwXGs79Ix9AAG0DYqatDIG3GYw5viXTkFkgy
        P3g1wd98hHiCW1hfT5r47Y2XcLyVo68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636540623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=53iJmWfdXRk2SFeTBr6pDPBHF4ZYIRGQ6uPrSskM9pQ=;
        b=a8nItKPaeOfxUVuJMoPTcS66TNDiNRsfHA2gWlarEflxJCGCSSWEUPl7kLFY99S9GnPVSC
        QhB71tKH7q1MbmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55CD313BEA;
        Wed, 10 Nov 2021 10:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TT7xE8+gi2EnPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:03 +0000
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
Subject: [PATCH v3 0/9] drm/simpledrm: Enable damage clips and virtual screens
Date:   Wed, 10 Nov 2021 11:36:53 +0100
Message-Id: <20211110103702.374-1-tzimmermann@suse.de>
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

v3:
	* remove unnecessary clipping in simpledrm (Noralf)
	* fix drm_dev_enter() usage (Noralf)
	* style changes (Noralf)
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
 drivers/gpu/drm/tiny/simpledrm.c            |  37 ++-
 drivers/gpu/drm/tiny/st7586.c               |   2 +-
 include/drm/drm_format_helper.h             |  58 ++---
 include/drm/drm_gem_atomic_helper.h         |  18 ++
 include/drm/drm_mode_config.h               |  13 ++
 14 files changed, 260 insertions(+), 187 deletions(-)


base-commit: 215295e7b0a3deb2015c6d6b343b319e4f6d9a1d
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
--
2.33.1

