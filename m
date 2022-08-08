Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18C58C8B0
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbiHHMyV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiHHMyL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 08:54:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A752E09E
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 05:54:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5BE34C95;
        Mon,  8 Aug 2022 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659963248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ik09SnqexUD06uakj2NLVtxYzVE0gpz9sZNZeW15+mk=;
        b=X890syQvd+elb+aB4Mr/Wy4ux2Gc5pEj4+8e78pbY6R6WPDfOWgxS5XvBe/FOSQWuk5Ezs
        HLNdUBtkzYrWkRQnbC9eJW0nRfJHir8hLIAU1AbIoXN+r13sECMAJGwDrtMLSfbPc3Ou9L
        srzrDYEIZakjdnBCyX+h9suS+3gcOSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659963248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ik09SnqexUD06uakj2NLVtxYzVE0gpz9sZNZeW15+mk=;
        b=NQjPenJ8n0RiAhloW7VTeGOf1DlRN9/CKs6NAXVq5DZRUrRR3cMNZijvwru4np0Xj3PdUZ
        53/CUv7O36zCNrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 354EF13A7C;
        Mon,  8 Aug 2022 12:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JrTxC3AH8WLHUgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:08 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/14] drm/format-helper: Move to struct iosys_map
Date:   Mon,  8 Aug 2022 14:53:52 +0200
Message-Id: <20220808125406.20752-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

v2:
	* add IOSYS_MAP_INIT_VADDR_IOMEM (Sam)
	* use drm_format_info_bpp() (Sam)
	* update documentation (Sam)
	* rename 'vmap' to 'src' (Sam)
	* many smaller cleanups and fixes (Sam, Jose)

Thomas Zimmermann (14):
  iosys-map: Add IOSYS_MAP_INIT_VADDR_IOMEM()
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
  drm/format-helper: Rename parameter vmap to src

 drivers/gpu/drm/drm_format_helper.c           | 509 ++++++++++--------
 drivers/gpu/drm/drm_mipi_dbi.c                |   9 +-
 drivers/gpu/drm/gud/gud_pipe.c                |  20 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |   9 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c        |   9 +-
 drivers/gpu/drm/solomon/ssd130x.c             |   7 +-
 .../gpu/drm/tests/drm_format_helper_test.c    |  45 +-
 drivers/gpu/drm/tiny/cirrus.c                 |  19 +-
 drivers/gpu/drm/tiny/repaper.c                |   6 +-
 drivers/gpu/drm/tiny/simpledrm.c              |   8 +-
 drivers/gpu/drm/tiny/st7586.c                 |   5 +-
 include/drm/drm_format_helper.h               |  56 +-
 include/linux/iosys-map.h                     |  15 +-
 13 files changed, 416 insertions(+), 301 deletions(-)


base-commit: 2bdae66c9988dd0f07633629c0a85383cfc05940
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
-- 
2.37.1

