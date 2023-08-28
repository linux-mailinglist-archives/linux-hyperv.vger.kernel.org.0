Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA978B1A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjH1NWG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjH1NVm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 09:21:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CBD130;
        Mon, 28 Aug 2023 06:21:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C42601FD69;
        Mon, 28 Aug 2023 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693228895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NML8iokhOzgcRUuPruaBldkgErx0VDUQPo56b5aaTOQ=;
        b=kwuJ2Oe4vJFUSEopXOctZfhG5lFgxIJv3guXKfU9q+3aBJbYw1bTpWHwMt1T2TQPQsqCX4
        mEpvdyIHuEE0JbIKc+8OmI5qFEqq7s3Mb/N4CuUWvGMEBZmitc8wWpnQOjAvuLPPssR0sB
        7tjrcQPZfN+wdpDjKRIdLts8Fhgzzh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693228895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NML8iokhOzgcRUuPruaBldkgErx0VDUQPo56b5aaTOQ=;
        b=7agvQZb3zEebD56+O+FjRInFJ/aN/5SlHCxXknurvmqDBNgafHfl7aoSqutH5Emq1EVKcS
        gp3M/YTEhDQCkuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F95F13A11;
        Mon, 28 Aug 2023 13:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uB4WIl+f7GTyOAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 28 Aug 2023 13:21:35 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, sam@ravnborg.org,
        javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/8] fbdev: Add Kconfig macro FB_IOMEM_HELPERS_DEFERRED
Date:   Mon, 28 Aug 2023 15:14:19 +0200
Message-ID: <20230828132131.29295-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828132131.29295-1-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The new Kconfig macro FB_IOMEM_HELPERS_DEFERRED selects fbdev's
helpers for device I/O memory and deferred I/O. Drivers should
use it if they perform damage updates on device I/O memory.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index baf7e852c75b..e80d6429f76a 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -151,6 +151,12 @@ config FB_IOMEM_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
 
+config FB_IOMEM_HELPERS_DEFERRED
+	bool
+	depends on FB_CORE
+	select FB_DEFERRED_IO
+	select FB_IOMEM_HELPERS
+
 config FB_SYSMEM_HELPERS
 	bool
 	depends on FB_CORE
-- 
2.41.0

