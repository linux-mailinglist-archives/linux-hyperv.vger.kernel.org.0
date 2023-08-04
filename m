Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3F76FAC4
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 09:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjHDHKF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 03:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjHDHKD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 03:10:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BE9E30DD;
        Fri,  4 Aug 2023 00:10:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D2531207F5BB;
        Fri,  4 Aug 2023 00:09:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2531207F5BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691132999;
        bh=H3kqU/firIHr0S+sRVsFVo5ha4Q/UyDjIzEmNKSv7DA=;
        h=From:To:Subject:Date:From;
        b=QpGMobgtGYz5xyM1/7pPxicy9Nt9W3V+4PG2f1YX6hoH0HT1FOTHWWJ0MZZc9G6i4
         xneqmhYByZKs4LQ0tM83mI0OkCpB7OuohCSmyZXqVjijizcbpEXwSvwRJEhqLXf7Ad
         O5WQptarMMLP0lCz0H3cNYcbmJlvt/6UrhyivrAs=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 0/3] UIO driver for low speed Hyper-V devices
Date:   Fri,  4 Aug 2023 00:09:53 -0700
Message-Id: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V is adding multiple low speed "speciality" synthetic devices.
Instead of writing a new kernel-level VMBus driver for each device,
make the devices accessible to user space through a UIO-based
hv_vmbus_client driver. Each device can then be supported by a user
space driver. This approach optimizes the development process and
provides flexibility to user space applications to control the key
interactions with the VMBus ring buffer.

The new synthetic devices are low speed devices that don't support
VMBus monitor bits, and so they must use vmbus_setevent() to notify
the host of ring buffer updates. The new driver provides this
functionality along with a configurable ring buffer size.

Moreover, this series of patches incorporates an update to the fcopy
application, enabling it to seamlessly utilize the new interface. The
older fcopy driver and application will be phased out gradually.
Development of other similar userspace drivers is still underway.

Moreover, this patch series adds a new implementation of the fcopy
application that uses the new UIO driver. The older fcopy driver and
application will be phased out gradually. Development of other similar
userspace drivers is still underway.

[V4]
- Modify comment to remove RingDataStartOffset mention
- Change downward ALIGN macro to upward ALIGN
- Add error check for setting ring_size value in sysfs entry
- Add error handling in fcopy_get_instance_id for instance id not found case

[V3]
- Removed ringbuffer sysfs entry and used uio framework for mmap
- Remove ".id_table = NULL"
- kasprintf -> devm_kasprintf
- Change global variable ring_size to per device
- More checks on value which can be set for ring_size
- Remove driverctl, and used echo command instead for driver documentation
- Remove unnecessary one time use macros
- Change kernel version and date for sysfs documentation
- Update documentation.
- Made ring buffer data offset depend on page size
- remove rte_smp_rwmb macro and reused rte_compiler_barrier instead
- Added legal counsel sign-off
- simplify mmap
- Removed "Link:" tag 
- Improve cover letter and commit messages
- Improve debug prints
- Instead of hardcoded instance id, query from class id sysfs
- Set the ring_size value from application
- new application compilation dependent on x86
- Not removing the old driver and application for backward compatibility

[V2]
- Update driver info in Documentation/driver-api/uio-howto.rst
- Update ring_size sysfs info in Documentation/ABI/stable/sysfs-bus-vmbus
- Remove DRIVER_VERSION
- Remove refcnt
- scnprintf -> sysfs_emit
- sysfs_create_file -> ATTRIBUTE_GROUPS + ".driver.groups";
- sysfs_create_bin_file -> device_create_bin_file
- dev_notice -> dev_err
- remove MODULE_VERSION
- simpler sysfs path, less parsing

Saurabh Sengar (3):
  uio: Add hv_vmbus_client driver
  tools: hv: Add vmbus_bufring
  tools: hv: Add new fcopy application based on uio driver

 Documentation/ABI/stable/sysfs-bus-vmbus |  10 +
 Documentation/driver-api/uio-howto.rst   |  54 +++
 drivers/uio/Kconfig                      |  12 +
 drivers/uio/Makefile                     |   1 +
 drivers/uio/uio_hv_vmbus_client.c        | 218 +++++++++
 tools/hv/Build                           |   2 +
 tools/hv/Makefile                        |  21 +-
 tools/hv/hv_fcopy_uio_daemon.c           | 587 +++++++++++++++++++++++
 tools/hv/vmbus_bufring.c                 | 297 ++++++++++++
 tools/hv/vmbus_bufring.h                 | 154 ++++++
 10 files changed, 1355 insertions(+), 1 deletion(-)
 create mode 100644 drivers/uio/uio_hv_vmbus_client.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

-- 
2.34.1

