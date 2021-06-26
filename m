Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A513B4D14
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Jun 2021 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZGcu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Jun 2021 02:32:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52266 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFZGcu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Jun 2021 02:32:50 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 751F620B6C50; Fri, 25 Jun 2021 23:30:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 751F620B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1624689028;
        bh=8LT0s6KbHdrBhgtawNcOwyleERYGr9I4Roa+ATtvzs0=;
        h=From:To:Cc:Subject:Date:From;
        b=hiJo7OWYqDJbYrFrzPJaJ4QtXwjUr7JN3VueE2h9rw62UT9TIW63S2HvMFYD8pQWi
         b7Jqp/I7vSPHbiR1A+q+XDtnBdXr4qfTGBfi1pYPSAd+Gste71fZGoE1Akr+tx6yx6
         C+uIDsRNfF06SKBmJ3GSmmd5xwr6oG/gMHKvaCU4=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2 0/3] Introduce a driver to support host accelerated access to Microsoft Azure Blob
Date:   Fri, 25 Jun 2021 23:30:17 -0700
Message-Id: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Microsoft Azure Blob storage service exposes a REST API to applications
for data access. While it's flexible and works on most platforms, it's
not as efficient as native network stack.

This patchset implements a VSC that communicates with a VSP on the host
to execute blob storage access via native network stack on the host.

Reference:
https://azure.microsoft.com/en-us/services/storage/blobs/#overview


Long Li (3):
  Drivers: hv: vmbus: add support to ignore certain PCIE devices
  Drivers: hv: add Azure Blob driver
  Drivers: hv: add to maintainer

Changes:

v2:
Refactored the code in vmbus to scan devices
Reworked Azure Blob driver and moved user-mode interfaces to uapi

 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 MAINTAINERS                                        |   1 +
 drivers/hv/Kconfig                                 |  10 +
 drivers/hv/Makefile                                |   1 +
 drivers/hv/azure_blob.c                            | 621 +++++++++++++++++++++
 drivers/hv/channel_mgmt.c                          |  55 +-
 include/linux/hyperv.h                             |   9 +
 include/uapi/misc/azure_blob.h                     |  31 +
 8 files changed, 724 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hv/azure_blob.c
 create mode 100644 include/uapi/misc/azure_blob.h

-- 
1.8.3.1

