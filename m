Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC50D78B19C
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjH1NWC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjH1NVj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 09:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D4124;
        Mon, 28 Aug 2023 06:21:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C0C8219E6;
        Mon, 28 Aug 2023 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693228895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pnwZ65nZK9qeQ06lv/Mt+cgcaEzXDu6AFEyAEI4AnZk=;
        b=fPBDEz9qgFehf6BuZhp2iHjeAXo/bJTGn1MR05cIllGWQEwYt12OohQ7V/SV5rPR3DRSgS
        +D+xZOWIOPYd5gMN9NtONvBFEh8OoNGl25Uvy02zsnXSDCv2DVVB67QOgcZnp3qmoyQWgs
        L5SEUTRtXCtetol+ZjGd5hSUQQiXIxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693228895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pnwZ65nZK9qeQ06lv/Mt+cgcaEzXDu6AFEyAEI4AnZk=;
        b=wGiy3UgLSj9rxu9VhhXasfT7LMsu/Be88DValn/yjpnAOHvrGmKm0T6IVTQzl+NB5CHtUL
        GuLsL4b/7iaRxtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C699213A11;
        Mon, 28 Aug 2023 13:21:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mx11L16f7GTyOAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 28 Aug 2023 13:21:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/8] fbdev: Use helpers for deferred I/O
Date:   Mon, 28 Aug 2023 15:14:16 +0200
Message-ID: <20230828132131.29295-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Here's another patchset for deferred-I/O helpers. Update a number
of fbdev drivers with deferred I/O to use fbdev's helper macros and
Kconfig tokens.

Generating and initializing via helpers macros will later allow for
a fine-grained setup, depending on Kconfig options. For example, it
will be possible to leave out file I/O if FB_DEVICE has not been set.

Each driver in special in its own way. The smscufx and udlfb drivers
support file I/O without damage updates. (That probably doesn't work
correctly.) So they provide their own mmap code. The hyperv_fb driver
sometimes operates on memory in I/O address spaces and fails to do
damage handling correctly for write operations. The picolcd and fbtft
drivers are outside of fbdev.

Thomas Zimmermann (8):
  fbdev/smscufx: Use fb_ops helpers for deferred I/O
  fbdev/udlfb: Use fb_ops helpers for deferred I/O
  fbdev: Add Kconfig macro FB_IOMEM_HELPERS_DEFERRED
  fbdev/hyperv_fb: Use fb_ops helpers for deferred I/O
  hid: Remove trailing whitespace
  hid/picolcd: Use fb_ops helpers for deferred I/O
  staging/fbtft: Initialize fb_op struct as static const
  staging/fbtft: Use fb_ops helpers for deferred I/O

 drivers/hid/Kconfig                |  8 +--
 drivers/hid/hid-picolcd_fb.c       | 73 ++++++----------------
 drivers/staging/fbtft/Kconfig      |  6 +-
 drivers/staging/fbtft/fbtft-core.c | 99 ++++++++----------------------
 drivers/video/fbdev/Kconfig        |  5 +-
 drivers/video/fbdev/core/Kconfig   |  6 ++
 drivers/video/fbdev/hyperv_fb.c    | 48 +++++----------
 drivers/video/fbdev/smscufx.c      | 85 +++++++------------------
 drivers/video/fbdev/udlfb.c        | 89 +++++++--------------------
 9 files changed, 114 insertions(+), 305 deletions(-)

-- 
2.41.0

