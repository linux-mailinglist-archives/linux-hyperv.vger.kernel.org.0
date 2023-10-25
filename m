Return-Path: <linux-hyperv+bounces-582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE857D78C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EE6B212D2
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85135381B2;
	Wed, 25 Oct 2023 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmMxsQ5G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B537CA9
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 23:40:37 +0000 (UTC)
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF7184
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:34 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3b2e7ae47d1so385641b6e.0
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277234; x=1698882034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ax/nU1ZFqft8oVl1VFeTyrFHvNYL9G6jLEqvbbsuZrc=;
        b=NmMxsQ5GzeRKJWkJBxrvU19M2uiKWMwBZb6QsHF3qCL+TaTYI2ErHdJ1TpBPXm8EV3
         sV/v3UPI8Vcdj/Va8l80QY5oR174EKVYqBmjI3OyKp79KdeXkjezPf0bICgHhRKHSeE/
         983jJcTHfzQBUSq4IitnOIYUCngp+O+J8kyTq31q9LrGpPCBqjWU7DeZDw6+c/nt1r6C
         RhV3V0w9LrPq57o75T6aQMJJUeINh6MDWrPdVRad+bn5JK0FnDlFiMxBZ87wOPymRqmy
         7ZJGawZ2M0d3dI1rRCc28K7nhSYMz1Z9hL27UnTd3oOowyMvxGlKHfxAnMbkUDRNXwVz
         dOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277234; x=1698882034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax/nU1ZFqft8oVl1VFeTyrFHvNYL9G6jLEqvbbsuZrc=;
        b=ISbKURNJV4Tkt7vJsfkAXnXGkMAnJWeUybRh9/NFi3wwXQkvkS3b7SNpeeS2iwQZen
         YYjysgt2s5tklV38V+UHChqsZVO8+o5030ezpxSgLK5ckDvESUFzutPCegLIbdKyqPSa
         v+PVS9H2p/LnmJnO/W4klgu8Eq7GNdXnih3x3bX9nRIn/Et09aw8bI+s19lcrROQP/yz
         7nedspr708048b9612HvH/QbSYZiLhTmDp6blFPNvAjy2FW07b2cW2rXeG9gXjZpuin/
         FqFDc7NwgERgFC6qLf9N0gYntC6RiYEaWoJhHv8fqhsWdB8098vB5CJMxBBc4dW1Br2s
         AU4w==
X-Gm-Message-State: AOJu0Yzbjo1VAe4C76Te1jPhbLLDuoQUldg36TO3Q0tbyNUwK3QeoKRg
	+SIiHrAGYT4ijki296+pDAauS9Ai+drt+RHb0w==
X-Google-Smtp-Source: AGHT+IHw/k5Q9J8vO1CuX5M/j0RoZQarFU1nkp8HN+n7tSv4SkiAOjOO7FMq1mjjWL8SudfGtRgbLzDKikkpHA3p+w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:aca:211a:0:b0:3a7:45f6:4b3f with SMTP
 id 26-20020aca211a000000b003a745f64b3fmr5446803oiz.3.1698277233982; Wed, 25
 Oct 2023 16:40:33 -0700 (PDT)
Date: Wed, 25 Oct 2023 23:40:31 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG+nOWUC/x3MQQqAIBBA0avErBPUiqirREjZWAOVohZBePek5
 Vv8/0JATxigL17weFMge2aIsgC9TeeKjJZskFxWgsuGYdyitbtyVwyKDrezSdRtZ8ysW+SQO+f R0PM/hzGlD3eMzaxjAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698277232; l=3351;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=UeXhj1yUBRkd9WratOksK7CyAy5xMK0mPYfyx10bxZQ=; b=0w8LuFAfNlkvjcs5D4bU1gmw4mc0Z8LGR5Gx0Qu+E7eSP/aJ0ejYYmvSor7LgEkb5foJS31Xr
 L/Z9/AOw7F9DSBIfksjjQWnDSVIKPwwS5pRG348fL+1FujQZ1dqzFFE
X-Mailer: b4 0.12.3
Message-ID: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
Subject: [PATCH 0/3] ethtool: Add ethtool_puts()
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Hi,

This series aims to implement ethtool_puts() and send out a wave 1 of
conversions from ethtool_sprintf(). There's also a checkpatch patch
included to check for the cases listed below.

This was sparked from recent discussion here [1]

The conversions are used in cases where ethtool_sprintf() was being used
with just two arguments:
|       ethtool_sprintf(&data, buffer[i].name);
or when it's used with format string: "%s"
|       ethtool_sprintf(&data, "%s", buffer[i].name);
which both now become:
|       ethtool_puts(&data, buffer[i].name);

The first case commonly triggers a -Wformat-security warning with Clang
due to potential problems with format flags present in the strings [3].

The second is just a bit weird with a plain-ol' "%s".

Note that I have some outstanding patches [2] (some picked up) that use
the second case of ethtool_sprintf(). I went with this approach to clean
up some strncpy() uses and avoid -Wformat-security warnings before
discussion about implementing ...puts() arose. I will probably let the
ones that have been picked up land but send new versions for others.

Wave 1 changes found with Cocci [4] and grep [5].

[1]: https://lore.kernel.org/all/202310141935.B326C9E@keescook/
[2]: https://lore.kernel.org/all/?q=dfb%3Aethtool_sprintf+AND+f%3Ajustinstitt
[3]: https://lore.kernel.org/all/202310101528.9496539BE@keescook/
[4]: (script authored by Kees)
@replace_2_args@
identifier BUF;
expression VAR;
@@

-       ethtool_sprintf
+       ethtool_puts
        (&BUF, VAR)

@replace_3_args@
identifier BUF;
expression VAR;
@@

-       ethtool_sprintf(&BUF, "%s", VAR)
+       ethtool_puts(&BUF, VAR)
[5]: $ rg "ethtool_sprintf\(\s*[^,)]+\s*,\s*[^,)]+\s*\)"

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Justin Stitt (3):
      ethtool: Implement ethtool_puts()
      treewide: Convert some ethtool_sprintf() to ethtool_puts()
      checkpatch: add ethtool_sprintf rules

 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 66 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       | 10 ++--
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
 include/linux/ethtool.h                            | 13 +++++
 net/ethtool/ioctl.c                                |  7 +++
 scripts/checkpatch.pl                              | 13 +++++
 18 files changed, 120 insertions(+), 90 deletions(-)
---
base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
change-id: 20231025-ethtool_puts_impl-a1479ffbc7e0

Best regards,
--
Justin Stitt <justinstitt@google.com>


