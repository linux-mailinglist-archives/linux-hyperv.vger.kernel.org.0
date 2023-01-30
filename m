Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989168048B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 05:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjA3EAD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Jan 2023 23:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjA3EAC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Jan 2023 23:00:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A912F22;
        Sun, 29 Jan 2023 19:59:49 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675051187;
        bh=ZbgbgVtlPFtq55TH0opkbq5iHNhesuWMDM9ZEPXeOsk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IHtr2UuaboBduqdOMpA0Y3egWz4OZpz39J8oRqVw5iP94dUmf4mF7esWnJ84+m7BG
         v9ZSNw7aALe7JMKpXu5UfKKC/CkAqZP0uuoIX5UMFMDfWoQXbsKtOPWkW6mwCBix+/
         IYpZ5J2dlAz3+VJR98xDZi+ZP27wPkdLw/yy/V+k=
Date:   Mon, 30 Jan 2023 03:59:40 +0000
Subject: [PATCH 4/9] HID: steam: Constify lowlevel HID driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230130-hid-const-ll-driver-v1-4-3fc282b3b1d0@weissschuh.net>
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
In-Reply-To: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675051185; l=865;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZbgbgVtlPFtq55TH0opkbq5iHNhesuWMDM9ZEPXeOsk=;
 b=K+qvlSsOYKsG6L1e28n33S7oEbVaEzdLgqVh5PfopUoHLueDoSD6fx7F81Fsg5y17jqMq6D+mxFI
 Dt3Tz0fCAsJAvZfHiHimUa8Deeuk9XNdvf/Yy+8GUczAZ45Nd/ii
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit 52d225346904 ("HID: Make lowlevel driver structs const")
the lowlevel HID drivers are only exposed as const.

Take advantage of this to constify the underlying structure, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/hid-steam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 8ee43cb225fc..29ec8b34741a 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -674,7 +674,7 @@ static int steam_client_ll_raw_request(struct hid_device *hdev,
 			report_type, reqtype);
 }
 
-static struct hid_ll_driver steam_client_ll_driver = {
+static const struct hid_ll_driver steam_client_ll_driver = {
 	.parse = steam_client_ll_parse,
 	.start = steam_client_ll_start,
 	.stop = steam_client_ll_stop,

-- 
2.39.1

