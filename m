Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D5B172E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 04:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfIMCbu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 22:31:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfIMCbu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 22:31:50 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so59008032ion.2;
        Thu, 12 Sep 2019 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZFwKrNvCS5ozupp0xprtAilLn59qOk6VcUa2IgFIOKA=;
        b=kFPtjE9/T9YhOMfvGIw07n+Hb36I/MZw7Gn2swDx1dDU9BEYC76pOiZK0KXeqqgGZr
         uLffLRDbLucglgBvkC0UsIebZuYbUYByN2cIGVvQyJ4oVPhB1bm7iPSJpo9eqiX4E/dk
         q+hCruDqCQkKmo2vu31QbR2B3p6UjwFpEYN26cRucGfq/eiE+/3srgfa3T6VbexqisRw
         FW9a+jQmc51P4XNWhxdsWmBCJFV04nLMGC6cJ+ENBkAm+4E8N7GofRNPF5QJQ5Lz0oN1
         qW9Dali77iP/WLQMplrcndu54VGp4MzUMz9oaH47hbjEcv71QVppGo8Nk2rseEn/IDfD
         EGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZFwKrNvCS5ozupp0xprtAilLn59qOk6VcUa2IgFIOKA=;
        b=rLn0roCvoOEkGzj4UIu7SR4x4o1pKuX+5+rhblA/1YpojKFabWTHS3nqV7zD6HBmBZ
         tX4WdqwZnbn94PesTObbLDyJUKhD49KtLSFVXaAsBjqb5E5etM+bsUlaJvUwZP0XZxGv
         XS8tUewXdfqFz1xC9XObtGLDAgA/SZMYqIT5XkyUNpeeHeBaXQlM8w9/VllYc430UkwI
         A0p73j9kNqBGhAZ19wh/hFOQCfiowxuvPnr9c3tHLuUyK9QSAbI0N6yvW0fmq+LMNE+o
         3oWVh4mUC34HVtNW6U9jHGslkdZR6/gyvDIju7121/I66NJyqwCxBeo+pkgiHJPF5HSc
         6RqA==
X-Gm-Message-State: APjAAAVVt8FMuklnxw1zRx+xoD9/bZlgViUEYwlZaoKjT1ITiCnTPTH3
        M4ArkqY1Xf7Bo3F5q7uf9w==
X-Google-Smtp-Source: APXvYqz/baGGAjOZVGA5+KhVa0VclSYB6jyYKdFJaP5EyObqc8KgJmtXn3/LHWbyEAqN/QnOWzdHmA==
X-Received: by 2002:a05:6638:73d:: with SMTP id j29mr50176970jad.21.1568341909634;
        Thu, 12 Sep 2019 19:31:49 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id x5sm21419690ior.46.2019.09.12.19.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 19:31:48 -0700 (PDT)
Date:   Thu, 12 Sep 2019 22:31:46 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] hv: vmbus: add fuzz testing to hv device
Message-ID: <cover.1568320416.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset introduces a testing framework for Hyper-V drivers.
This framework allows us to introduce delays in the packet receive
path on a per-device basis. While the current code only supports
introducing arbitrary delays in the host/guest communication path,
we intend to expand this to support error injection in the future.

changes in v5:
  patch 1:
	As per Stephen's suggestion, Moved CONFIG_HYPERV_TESTING
	to lib/Kconfig.debug.

	Fixed build issue reported by Kbuild, with Michael's
	suggestion to make hv_debugfs part of the hv_vmbus
	module.
	
changes in v4:
  patch 1:
        Combined previous v3 patches 1 and 2, into a single patch
        which is now patch 1. This was done so that calls to
        the new debugfs functions are in the same patch as
        the definitions for these functions.

        Moved debugfs code from "vmbus_drv.c" that was in
        previous v3 patch 2, into a new file "debugfs.c" in
        drivers/hv.

        Updated the Makefile to compile "debugfs.c" if
        CONFIG_HYPERV_TESTING is enabled

        As per Michael's comments, added empty implementations
        of the new functions, so the compiler will not generate
        code when CONFIG_HYPERV_TESTING is not enabled.

  patch 2 (was previously v3 patch 3):
        Based on Harrys comments, made the tool more
        user friendly and added more error checking.

changes in v3:
  patch 2: change call to IS_ERR_OR_NULL, to IS_ERR.

  patch 3: Align python tool to match Linux coding style.

Changes in v2:
  Patch 1: As per Vitaly's suggestion, wrapped the test code under an
           #ifdef and updated the Kconfig file, so that the test code
           will only be used when the config option is set to true.
           (default is false).

           Updated hyperv_vmbus header to contain new #ifdef with new
           new functions for the test code.

  Patch 2: Moved code from under sysfs to debugfs and wrapped it under
           the new ifdef.

           Updated MAINTAINERS file with new debugfs-hyperv file under
           the section for hyperv.

  Patch 3: Updated testing tool with new debugfs location.

Branden Bonaby (2):
  drivers: hv: vmbus: Introduce latency testing
  tools: hv: add vmbus testing tool

 Documentation/ABI/testing/debugfs-hyperv |  23 ++
 MAINTAINERS                              |   1 +
 drivers/hv/Makefile                      |   1 +
 drivers/hv/connection.c                  |   1 +
 drivers/hv/hv_debugfs.c                  | 185 +++++++++++
 drivers/hv/hyperv_vmbus.h                |  31 ++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |   6 +
 include/linux/hyperv.h                   |  19 ++
 lib/Kconfig.debug                        |   7 +
 tools/hv/vmbus_testing                   | 376 +++++++++++++++++++++++
 11 files changed, 652 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c
 create mode 100644 tools/hv/vmbus_testing

-- 
2.17.1

