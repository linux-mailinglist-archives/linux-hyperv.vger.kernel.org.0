Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9361CCB0BD
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfJCVBk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 17:01:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44975 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfJCVBk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 17:01:40 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so8756307iol.11;
        Thu, 03 Oct 2019 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E5SAchAqbt5StPb+s2j3ybaKfrX09uCoGQITz/dDUpk=;
        b=pBKhH56piWOqZZ0XAvUgyFpneZ68ZJgWSbjmYs7zpwuFJcntG55dfrSzXUAw6IecO+
         ikJqW+BIkiX1v9tG7uHt+Gg1uWoHMu35Xop7k/QqeZPZ4/h2kyeGEXR/naL6KyWBXjZS
         obQHSjNMXIWpmcDfawPAb+39E2V0ID8zyLEflWc+d+fnetgEG4WXU7Eit0uut0je+Pk9
         FGznii1X0SB+UsbxwedrsCsJUqiDrBwUygvdIs6Q7brXYadz3xJv5uirNvNZ66aMLHng
         GhG8/2Pf6qAJePHKnQtDkKklXjZ8tVldoKbFQehBE+YYC6EIwrrP7abeKEXMSKpGrRiX
         rVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E5SAchAqbt5StPb+s2j3ybaKfrX09uCoGQITz/dDUpk=;
        b=VuodHcbgHz2WXd5wf/gJ99Uv0m6XxBn1xHXt79aqAwQi5gXNusWry3g2RLFgYU6Wc0
         spoou6bu4yeP+e7MjGw4gkM0PcQMfSYVXTHjd8BSpaBWXOPXpzynRku7+deqHtN2Bbz3
         +XTIZsrv9xqzS5DOSWB3tCQ/b9y7ab8WElJQR6my+23dmxU3Zb7VOOyWwPaUFkOxPdRO
         HgJV3DWB8I6hPXvG74NweKoLD5fYYaisX9AyiUv9jQV3cj55RwmUSD0WgJrV11E2AaHm
         rB0y61o8QpLwINWjj4YMN6NK70BPwS89rN+1Mi3L9Yi6ZIHZDu/p7fnfeA+v81nwb2Cp
         WM8Q==
X-Gm-Message-State: APjAAAVGUM95dhkupWEvH/FkGrPZNwF9UT8rXZskn1wu8kcpAuKEgEg3
        1m6Chig76/q6vEWruElhdT46s4bRd02h
X-Google-Smtp-Source: APXvYqyaM5jB82UnO5hjpqAJhFAH/8ynrmAa3zb8Mx7Fio1SwT7qqn9KwzK0mD7zpUCM7kRDaTivJQ==
X-Received: by 2002:a92:3851:: with SMTP id f78mr11603006ila.179.1570136499208;
        Thu, 03 Oct 2019 14:01:39 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id c17sm1900489ild.31.2019.10.03.14.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 14:01:38 -0700 (PDT)
Date:   Thu, 3 Oct 2019 17:01:36 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] hv: vmbus: add fuzz testing to hv device
Message-ID: <cover.1570130325.git.brandonbonaby94@gmail.com>
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

changes in v6:
  patch 1:
	changed kernel version in 
	Documentation/ABI/testing/debugfs-hyperv to 5.5
	
	removed less than 0 if statement when dealing with
	u64 datatype, as suggested by michael.

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
 drivers/hv/hv_debugfs.c                  | 178 +++++++++++
 drivers/hv/hyperv_vmbus.h                |  31 ++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |   6 +
 include/linux/hyperv.h                   |  19 ++
 lib/Kconfig.debug                        |   7 +
 tools/hv/vmbus_testing                   | 376 +++++++++++++++++++++++
 11 files changed, 645 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c
 create mode 100755 tools/hv/vmbus_testing

-- 
2.17.1

