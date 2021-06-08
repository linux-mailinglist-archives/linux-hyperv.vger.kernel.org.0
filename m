Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44039EB31
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jun 2021 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFHBGd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Jun 2021 21:06:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45932 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHBGd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Jun 2021 21:06:33 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 1202B20B83DC; Mon,  7 Jun 2021 18:04:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1202B20B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1623114281;
        bh=gFXV7UcUvIFsGJoKrUGikjqVL6ndMcZc3w1HB4lYFM4=;
        h=From:To:Cc:Subject:Date:From;
        b=OALig6DK+vsBIGu9eDuiF9kbEzTj2A2mAkWgxkBHK31zthaxe8568A2eyE5YrmdY4
         ZmADwOvkfcdQY9p6GtTLzOWAhgEzcpwDy5NlwielQkWRoHyub78+etCQ95ip6Zf+sw
         sO9ERxucY3195Xr6sv2vLe5bexoaLT6QhU1xeTsw=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/2] Add a driver for host accelerated Microsoft Azure Blob Storage access
Date:   Mon,  7 Jun 2021 18:04:34 -0700
Message-Id: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Microsoft Azure Blob Storage servcie exposes a REST API to applications
for data access. While it's flexible and works on most platforms, it's
not as efficient as native network stack.

This patchset implements a VSC that communicates with a VSP on the host
to execute blob storage access via native network stack on the host.

Long Li (2):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add XStore Fastpath driver

 MAINTAINERS                 |   1 +
 drivers/hv/Kconfig          |  11 +
 drivers/hv/Makefile         |   1 +
 drivers/hv/channel_mgmt.c   |  49 ++++
 drivers/hv/hv_xs_fastpath.c | 579 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/hv/hv_xs_fastpath.h |  82 +++++++
 include/linux/hyperv.h      |   9 +
 7 files changed, 732 insertions(+)
 create mode 100644 drivers/hv/hv_xs_fastpath.c
 create mode 100644 drivers/hv/hv_xs_fastpath.h

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
-- 
1.8.3.1

