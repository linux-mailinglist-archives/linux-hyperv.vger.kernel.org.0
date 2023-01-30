Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9349168048F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 05:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjA3EAE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Jan 2023 23:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjA3EAD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Jan 2023 23:00:03 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49991448D;
        Sun, 29 Jan 2023 19:59:49 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675051187;
        bh=iX47upW85gfJMHXCNpRtaH9985qjJ/jS5RtXWPSoIgg=;
        h=From:Subject:Date:To:Cc:From;
        b=URXQEDOMQ30evZignf53zq4fcP+gjLYiP8q4WOrWjvftKlFLN5pDksPfGwtSfKYfj
         7GWr6NC6zgSyblLQuOIz5ROb9kgxN5qjcg/vtbb8/nGH4iqPDPmGC6k7CazHH/9ZSm
         P7AyjEgkp8JEVtwfP3uF4ruicpBanmnISCxFI87I=
Subject: [PATCH 0/9] HID: Constify lowlevel HID drivers
Date:   Mon, 30 Jan 2023 03:59:36 +0000
Message-Id: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKhA12MC/x2NQQoCMQwAv7LkbKDdXsSviIe2SW2gZCXRRVj27
 xaPMzDMAc4m7HBbDjDexWXTCfGyQO1Zn4xCk2ENawoxBexCWDf1N46BZLKzYauNKOUWY7nCLEt
 2xmJZa5+tfsaY8mXc5Ptf3R/n+QNb+Cy3egAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675051184; l=1428;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iX47upW85gfJMHXCNpRtaH9985qjJ/jS5RtXWPSoIgg=;
 b=wUViSb0tGQR60ua/5uXJ4ubJuesnlmDI25uiARSVmgdEPgnthqmmTYYrXBbv5el7sWYGYDodKxYP
 cdNZVeuGB1p0HWiMJ6mcEVfNyvmNoYYYAXwfHnGmb5Jg7ff6SGQI
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

Since 52d225346904 ("HID: Make lowlevel driver structs const") the
lowlevel HID drivers are only exposed as const.

Take advantage of this to constify the underlying structures, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (9):
      HID: amd_sfh: Constify lowlevel HID driver
      HID: hyperv: Constify lowlevel HID driver
      HID: logitech-dj: Constify lowlevel HID driver
      HID: steam: Constify lowlevel HID driver
      HID: intel-ish-hid: Constify lowlevel HID driver
      HID: surface-hid: Constify lowlevel HID driver
      platform/x86: asus-tf103c-dock: Constify lowlevel HID driver
      platform/x86: asus-tf103c-dock: Constify toprow keymap
      staging: greybus: hid: Constify lowlevel HID driver

 drivers/hid/amd-sfh-hid/amd_sfh_hid.c      | 2 +-
 drivers/hid/hid-hyperv.c                   | 2 +-
 drivers/hid/hid-logitech-dj.c              | 4 ++--
 drivers/hid/hid-steam.c                    | 2 +-
 drivers/hid/intel-ish-hid/ishtp-hid.c      | 2 +-
 drivers/hid/surface-hid/surface_hid_core.c | 2 +-
 drivers/platform/x86/asus-tf103c-dock.c    | 4 ++--
 drivers/staging/greybus/hid.c              | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: e04955db6a7c3fc4a1e6978649b61a6f5f8028e3
change-id: 20230130-hid-const-ll-driver-fcfdd3af11b8

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

