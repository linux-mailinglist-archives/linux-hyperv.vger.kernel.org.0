Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC30A103F
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 06:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfH2EYA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Aug 2019 00:24:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfH2EYA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 00:24:00 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so4267233iog.0;
        Wed, 28 Aug 2019 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pOB1i3mTdd6xhVveEaHICqtJMaVyedUAsiHTGFqKc/s=;
        b=BYq1yuUzBGIMCIWADSktNNvBtohGrzAzG+8hj1WZ+K+lM/LEhJ1vSNPfPW9QEFxUR/
         iwtXECQDfK9IhszV9UilfiY/D4gH1vMXHfdNeB7f+CNtfhIaSqmWcNYAbP/7d73IDRBU
         v8aZUMQPZ/Y8Bm+tVDFspHN5XceEzaMcwu8ER9zXfx03f2DfDnArvOPDpxsR1hrFtBF3
         WmJFDRtWrwJkCo/2NfQ2j69BRUR0uUHzykzpifxEdiT6k10c+XMkkY+tXA1xqcpBlEVz
         cNhgl3ldrBvKx7hm6VtFoKtP6gzsmsU0AFbcdUmPOjx/J2QBRUmw40qnOO2BAAvl+KKM
         ayPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pOB1i3mTdd6xhVveEaHICqtJMaVyedUAsiHTGFqKc/s=;
        b=bGFfNZ2bM0EsZ3TuOVfWfklbxhQFP8PX67DV78FNyKyGO3u2xWEAs4jOntXrDGOeAb
         n6+GjMawV1hwixbPfwZXF3TyXyWQeht8RenKe/JDoZjd3YWj+woNm5iw8DZ2IOOzBufa
         ZX9z7XA+rFHD7nqu1TO5/MIDPA3TvaFzFHQiuBmthLDQC1js+pje2plibyzQmkivjlY/
         KjG/IPZvnVscsQjyrCx7h8vOZA+/R1l+Rkwm3gY59CrFqFnIzFMWlV8ny/a8xf8S1rpU
         IybTlVmja4wqEeuoahfuZr8hAHIfi3pC1n3RrYWamCABI30UBKmGqB7aGz3RmkB1g3TJ
         MdgQ==
X-Gm-Message-State: APjAAAUPLNeJ8s5ir9B9CH+MbJitdXTSk7+UyGXlp6xhOSEQ8+r+2SFn
        DuUwaWIOa9/QvoQfv9I0cQ==
X-Google-Smtp-Source: APXvYqwE6tX/41RrYboCFGFxxQRRDs3N98wndf5wDQ8V42hwlxz97PMUts+6Dx6HGJ9hTdrWpw6csA==
X-Received: by 2002:a6b:5a12:: with SMTP id o18mr8578161iob.159.1567052639788;
        Wed, 28 Aug 2019 21:23:59 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id a9sm903916iod.76.2019.08.28.21.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 21:23:58 -0700 (PDT)
Date:   Thu, 29 Aug 2019 00:23:54 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] hv: vmbus: add fuzz testing to hv device
Message-ID: <cover.1567047549.git.brandonbonaby94@gmail.com>
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
 drivers/hv/Kconfig                       |   7 +
 drivers/hv/Makefile                      |   1 +
 drivers/hv/connection.c                  |   1 +
 drivers/hv/hv_debugfs.c                  | 187 +++++++++++
 drivers/hv/hyperv_vmbus.h                |  31 ++
 drivers/hv/ring_buffer.c                 |   2 +
 drivers/hv/vmbus_drv.c                   |   6 +
 include/linux/hyperv.h                   |  19 ++
 tools/hv/vmbus_testing                   | 376 +++++++++++++++++++++++
 11 files changed, 654 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 drivers/hv/hv_debugfs.c
 create mode 100644 tools/hv/vmbus_testing

-- 
2.17.1

