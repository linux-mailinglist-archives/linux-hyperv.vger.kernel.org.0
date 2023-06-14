Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B290730740
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jun 2023 20:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbjFNSQo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbjFNSPV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 14:15:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A47426BF;
        Wed, 14 Jun 2023 11:15:17 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A6B720FE871;
        Wed, 14 Jun 2023 11:15:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A6B720FE871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686766516;
        bh=P4/LsegbU0ZnJYipJHaEnVLb8YhEnuCaEclVr3qm9DQ=;
        h=From:To:Subject:Date:From;
        b=gIAqO0DeiZnxdnWILAk4/Jz2l/XGtReoT+t6sQG+NaKAPjqZbzCuLaB9G8tRv5GuL
         wCNv8Azx8pvcCBGpKpYO7lTtJLOP/j4vsftKUMLwIbfTF1k4JbSjVD2TafiWY1TI/v
         eEzGKZFSZKRiesM7wCGLCZ+kQ0zpEvkq/vIa8czA=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 0/5] UIO driver for low speed Hyper-V devices
Date:   Wed, 14 Jun 2023 11:15:07 -0700
Message-Id: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
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

[V2]
1. Update driver info in Documentation/driver-api/uio-howto.rst
2. Update ring_size sysfs info in Documentation/ABI/stable/sysfs-bus-vmbus
3. Remove DRIVER_VERSION
4. Remove refcnt
5. scnprintf -> sysfs_emit
6. sysfs_create_file -> ATTRIBUTE_GROUPS + ".driver.groups";
7. sysfs_create_bin_file -> device_create_bin_file
8. dev_notice -> dev_err
9. Removed invalid free of devm_ allocated data
10. Updated application with simpler sysfs path


Saurabh Sengar (5):
  uio: Add hv_vmbus_client driver
  tools: hv: Add vmbus_bufring
  tools: hv: Add new fcopy application based on uio driver
  tools: hv: Remove hv_fcopy_daemon
  Drivers: hv: Remove fcopy driver

 Documentation/ABI/stable/sysfs-bus-vmbus |   7 +
 Documentation/driver-api/uio-howto.rst   |  46 +++
 drivers/hv/Makefile                      |   2 +-
 drivers/hv/hv_fcopy.c                    | 427 --------------------
 drivers/hv/hv_util.c                     |  12 -
 drivers/uio/Kconfig                      |  12 +
 drivers/uio/Makefile                     |   1 +
 drivers/uio/uio_hv_vmbus_client.c        | 217 ++++++++++
 tools/hv/Build                           |   3 +-
 tools/hv/Makefile                        |  10 +-
 tools/hv/hv_fcopy_daemon.c               | 266 ------------
 tools/hv/hv_fcopy_uio_daemon.c           | 489 +++++++++++++++++++++++
 tools/hv/vmbus_bufring.c                 | 322 +++++++++++++++
 tools/hv/vmbus_bufring.h                 | 158 ++++++++
 14 files changed, 1260 insertions(+), 712 deletions(-)
 delete mode 100644 drivers/hv/hv_fcopy.c
 create mode 100644 drivers/uio/uio_hv_vmbus_client.c
 delete mode 100644 tools/hv/hv_fcopy_daemon.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

-- 
2.34.1

