Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4136395489
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 04:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfHTCoS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 22:44:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36476 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTCoR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 22:44:17 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so8968163iom.3;
        Mon, 19 Aug 2019 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YBOdLNycgzpN9Nla7NkvL7WnvW0innNt2D6Epp2xIi8=;
        b=oBDsaOWfBVYLRu0YEzyaoosa8+ejgL2HgiR7j/gAkh9iTAVKT6jTeMgpFJDQEeruv2
         /pXB+sEhU6DxZkbu/0oAhofQ4BkYJfUbeRzCTmDGnnepzLjd7FV/nHdYHZ18lIzXBq8m
         OmlBvBra7PfFD051LdicGxMlm/mZaH/H6x2DUaDcKk+lP+4aZTeY8oVKudB54gjQ68WX
         qeJ0neFNveebQIt/atHiOEZwAoEYgOlJlqkeqclPwavw75N3DEaP3NP/hsV1Tlqju1mK
         ebvy8j9yKXS38lV6UcrHxG9J2W8dvYYmCFBJT8u+BJ3sSuNU+rCQrPZeE092kyhVJQBS
         x0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YBOdLNycgzpN9Nla7NkvL7WnvW0innNt2D6Epp2xIi8=;
        b=GGwEWskRvX52krVjqoaKhmNR0NEinOSDp5Y1rBye8PN8GGYcyCklSBgRxGm+0BZRK6
         P9PrPplDCf3e4ayaX9DXTioUekEQKxCMkTzSqRPUxBkhp9kS2N75/GFzraduVxObDTgo
         pnco5rHIWNqTOrOb//epdoRTBHW4ZZF5Ouf+qSxuazNZHFRGHhPAwGAZeJeBqkfLDfsc
         021Ka2LSCIn29CM158QSexZWrLZTwiZfxrDiIt29bsInwSxHJaTW5sYuXP2YxnpK7l1L
         XZp+CWPHeEDah7ryIO6HdBVqdQaLiNlh+veqqFEz8SmPEFmMtMF8j0W+gBtqHdJFKTQS
         kjmw==
X-Gm-Message-State: APjAAAWvnM5POmIdKmd0IXFDhR8Tjp0lf9vvBAnvQqOhq1f9rkA+rsz9
        3DvcFPOi2Am7l4u220VXEdXDzUTbNdxD
X-Google-Smtp-Source: APXvYqyQC/+mBogwb1fguZjsZFONKmDQukSRX8G+Izx5RsScURfl70kCvqLXb54dLfKwSvHIkEOckg==
X-Received: by 2002:a6b:ea16:: with SMTP id m22mr10640364ioc.115.1566269056641;
        Mon, 19 Aug 2019 19:44:16 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id n21sm11168946ioh.30.2019.08.19.19.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 19:44:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 22:44:14 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] hv: vmbus: add fuzz testing to hv device
Message-ID: <cover.1566266609.git.brandonbonaby94@gmail.com>
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

Branden Bonaby (3):
  drivers: hv: vmbus: Introduce latency testing
  drivers: hv: vmbus: add fuzz test attributes to debugfs
  tools: hv: add vmbus testing tool

 Documentation/ABI/testing/debugfs-hyperv |  21 ++
 MAINTAINERS                              |   1 +
 drivers/hv/Kconfig                       |   7 +
 drivers/hv/connection.c                  |   3 +
 drivers/hv/hyperv_vmbus.h                |  20 ++
 drivers/hv/ring_buffer.c                 |   7 +
 drivers/hv/vmbus_drv.c                   | 167 ++++++++++++
 include/linux/hyperv.h                   |  21 ++
 tools/hv/vmbus_testing                   | 334 +++++++++++++++++++++++
 9 files changed, 581 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 tools/hv/vmbus_testing

-- 
2.17.1

