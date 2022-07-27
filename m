Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDBC58256E
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Jul 2022 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiG0Ldj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Jul 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiG0Ldi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Jul 2022 07:33:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD813CDE
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Jul 2022 04:33:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9A06385B0;
        Wed, 27 Jul 2022 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658921616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C/ujbkbzfIYXci1rwj67ijrwaq7vCSnZqWDXbrC8XL8=;
        b=FM4SgFXZeQApNPkJ0m0oOP812NFzJHsSyvdYnDss717uNjhXFHXxYUdZQH4PjHqF7pcGyj
        iDABGkkWCsO4H868F63C4ly+bYfPOztNXVILjDwB0gm1nSjBVUhw9K9cCUUPIU4wIJ9Z4t
        UpBsSBqsf/AE2PLjzw9qFYMOpIhy76Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658921616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C/ujbkbzfIYXci1rwj67ijrwaq7vCSnZqWDXbrC8XL8=;
        b=uzU/jXEZ6GFjBP7V5/NXwh4MZovSxj5TYbRwhqd0lLPIm5qhcE8o/MiW3rSJn+QCsrv69F
        F2hTvYPG4InPbbCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89E4813A8E;
        Wed, 27 Jul 2022 11:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TdyvIJAi4WJmBAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 27 Jul 2022 11:33:36 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, noralf@tronnes.org, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, airlied@redhat.com,
        javierm@redhat.com, drawat.floss@gmail.com, kraxel@redhat.com,
        david@lechnology.com, jose.exposito89@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/12] drm/format-helper: Move to struct iosys_map
Date:   Wed, 27 Jul 2022 13:33:00 +0200
Message-Id: <20220727113312.22407-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
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

Change format-conversion helpers to use struct iosys_map for source
and destination buffers. Update all users. Also prepare interface for
multi-plane color formats.

The format-conversion helpers mostly used to convert to I/O memory
or system memory. To actual memory type depended on the usecase. We
now have drivers upcomming that do the conversion entirely in system
memory. It's a good opportunity to stream-line the interface of the
conversion helpers to use struct iosys_map. Source and destination
buffers can now be either in system or in I/O memory. Note that the
implementation still only supports source buffers in system memory.

This patchset also changes the interface to support multi-plane
color formats, where the values for each component are stored in
distinct memory locations. Converting from RGBRGBRGB to RRRGGGBBB
would require a single source buffer with RGB values and 3 destination
buffers for the R, G and B values. Conversion-helper interfaces now
support this.

Thomas Zimmermann (12):
  drm/format-helper: Provide drm_fb_blit()
  drm/format-helper: Merge drm_fb_memcpy() and drm_fb_memcpy_toio()
  drm/format-helper: Convert drm_fb_swab() to struct iosys_map
  drm/format-helper: Rework XRGB8888-to-RGBG332 conversion
  drm/format-helper: Rework XRGB8888-to-RGBG565 conversion
  drm/format-helper: Rework XRGB8888-to-RGB888 conversion
  drm/format-helper: Rework RGB565-to-XRGB8888 conversion
  drm/format-helper: Rework RGB888-to-XRGB8888 conversion
  drm/format-helper: Rework XRGB8888-to-XRGB2101010 conversion
  drm/format-helper: Rework XRGB8888-to-GRAY8 conversion
  drm/format-helper: Rework XRGB8888-to-MONO conversion
  drm/format-helper: Move destination-buffer handling into internal
    helper

 drivers/gpu/drm/drm_format_helper.c           | 379 +++++++++---------
 drivers/gpu/drm/drm_mipi_dbi.c                |   9 +-
 drivers/gpu/drm/gud/gud_pipe.c                |  20 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |  11 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c        |  11 +-
 drivers/gpu/drm/solomon/ssd130x.c             |   7 +-
 .../gpu/drm/tests/drm_format_helper_test.c    |  14 +-
 drivers/gpu/drm/tiny/cirrus.c                 |  19 +-
 drivers/gpu/drm/tiny/repaper.c                |   6 +-
 drivers/gpu/drm/tiny/simpledrm.c              |  18 +-
 drivers/gpu/drm/tiny/st7586.c                 |   5 +-
 include/drm/drm_format_helper.h               |  56 ++-
 12 files changed, 294 insertions(+), 261 deletions(-)


base-commit: 15fbed4f822211fbb7653c2b8591594d92de9551
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
-- 
2.37.1

