Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6392CFC4B
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgLERlk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 12:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgLERk2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 12:40:28 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A48C09425C;
        Sat,  5 Dec 2020 09:39:48 -0800 (PST)
Received: from cip4d0.informatik.uni-erlangen.de (cip4d0.cip.cs.fau.de [IPv6:2001:638:a000:4160:131:188:60:59])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 22147241036;
        Sat,  5 Dec 2020 18:27:57 +0100 (CET)
Received: by cip4d0.informatik.uni-erlangen.de (Postfix, from userid 68457)
        id 13663D8049E; Sat,  5 Dec 2020 18:27:57 +0100 (CET)
From:   Stefan Eschenbacher <stefan.eschenbacher@fau.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Max Stolze <max.stolze@fau.de>
Subject: [PATCH 0/3] drivers/hv: make max_num_channels_supported configurable
Date:   Sat,  5 Dec 2020 18:26:47 +0100
Message-Id: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

According to the TODO comment in hyperv_vmbus.h the value in macro
MAX_NUM_CHANNELS_SUPPORTED should be configurable. The first patch
accomplishes that by introducting uint max_num_channels_supported as
module parameter.
Also macro MAX_NUM_CHANNELS_SUPPORTED_DEFAULT is introduced with
value 256, which is the currently used macro value.
MAX_NUM_CHANNELS_SUPPORTED was found and replaced in two locations.

During module initialization sanity checks are applied which will result
in EINVAL or ERANGE if the given value is no multiple of 32 or larger than
MAX_NUM_CHANNELS.

While testing, we found a misleading typo in the comment for the macro
MAX_NUM_CHANNELS which is fixed by the second patch.

The third patch makes the added default macro configurable by 
introduction and use of Kconfig parameter HYPERV_VMBUS_DEFAULT_CHANNELS. 
Default value remains at 256.

Two notes on these patches:
1) With above patches it is valid to configure max_num_channels_supported
and MAX_NUM_CHANNELS_SUPPORTED_DEFAULT as 0. We simply don't know if that
is a valid value. Doing so while testing still left us with a working
Debian VM in Hyper-V on Windows 10.
2) To set the Kconfig parameter the user currently has to divide the
desired default number of channels by 32 and enter the result of that
calculation. This way both known constraints we got from the comments in
the code are enforced. It feels a bit unintuitive though. We haven't found
Kconfig options to ensure that the value is a multiple of 32. So if you'd
like us to fix that we'd be happy for some input on how to settle it with
Kconfig.

Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Co-developed-by: Max Stolze <max.stolze@fau.de>
Signed-off-by: Max Stolze <max.stolze@fau.de>

Stefan Eschenbacher (3):
  drivers/hv: make max_num_channels_supported configurable
  drivers/hv: fix misleading typo in comment
  drivers/hv: add default number of vmbus channels to Kconfig

 drivers/hv/Kconfig        | 13 +++++++++++++
 drivers/hv/hyperv_vmbus.h |  8 ++++----
 drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.20.1

