Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6771FB6B
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjFBH5P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 03:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFBH5P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 03:57:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D34213E;
        Fri,  2 Jun 2023 00:57:14 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88A6A20FCD48;
        Fri,  2 Jun 2023 00:57:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88A6A20FCD48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685692633;
        bh=W+LOT8gPMhxml3jc0+5Plcr5ZY+64kjX6KqFWd1KA/o=;
        h=From:To:Subject:Date:From;
        b=dGYPXJYXRCLPeaClCMke4MpVc/Ku7njqFM5+4wXolqxotGsQwcDH3DnQutQtAVwOk
         WGy9ncfLt+LLimwabtUUf9p2D5Yu+P6tLtj4JRxsTsqup+aJZ9cJ4lXrnMNCapXZkb
         2TPdkS3SRP+NkivRjheS1mHbi5ta5WQW+BuqPfkk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 0/5] UIO driver for low speed Hyper-V devices
Date:   Fri,  2 Jun 2023 00:57:04 -0700
Message-Id: <1685692629-31351-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V is adding some low speed "specialty" synthetic devices.
This patch series propose the solution to support these devices.
Instead of writing new kernel-level VMBus drivers for all of
these devices, we propose a solution wherein these devices are
made accessible to user space through a dedicated UIO-based
hv_vmbus_client driver, allowing for efficient device handling
via user space drivers. This solution aims to optimize the
development process by eliminating the need to create
individual kernel-level VMBus drivers for each device and
provide flexibility to user space applications to control the
ring buffer independently.

Since all these new synthetic devices are low speed devices,
they don't support monitor bits and we must use vmbus_setevent()
to enable interrupts from the host. The new uio driver supports
all these requirements effectively. Additionally, this new driver
also provide the support for having smaller/cutom ringbuffer
size.

Furthermore, this patch series includes a revision of the fcopy
application to leverage the new interface seamlessly along with
removal of old driver and application. However, please note that
the development of other similar drivers is still a work in
progress, and will be shared as they become available.

Saurabh Sengar (5):
  uio: Add hv_vmbus_client driver
  tools: hv: Add vmbus_bufring
  tools: hv: Add new fcopy application based on uio driver
  tools: hv: Remove hv_fcopy_daemon
  Drivers: hv: Remove fcopy driver

 drivers/hv/Makefile               |   2 +-
 drivers/hv/hv_fcopy.c             | 427 --------------------------
 drivers/hv/hv_util.c              |  12 -
 drivers/uio/Kconfig               |  12 +
 drivers/uio/Makefile              |   1 +
 drivers/uio/uio_hv_vmbus_client.c | 232 ++++++++++++++
 tools/hv/Build                    |   3 +-
 tools/hv/Makefile                 |  10 +-
 tools/hv/hv_fcopy_daemon.c        | 266 ----------------
 tools/hv/hv_fcopy_uio_daemon.c    | 491 ++++++++++++++++++++++++++++++
 tools/hv/vmbus_bufring.c          | 324 ++++++++++++++++++++
 tools/hv/vmbus_bufring.h          | 158 ++++++++++
 12 files changed, 1226 insertions(+), 712 deletions(-)
 delete mode 100644 drivers/hv/hv_fcopy.c
 create mode 100644 drivers/uio/uio_hv_vmbus_client.c
 delete mode 100644 tools/hv/hv_fcopy_daemon.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

-- 
2.34.1

