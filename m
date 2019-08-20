Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4F96DD8
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHTXio (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 19:38:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38689 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfHTXio (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 19:38:44 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so925265iog.5;
        Tue, 20 Aug 2019 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h1utGPSe6HUXp2tUTW1s5hatB9U0uQHZHJs19pSNpeg=;
        b=slcHWYPFTCS3BoN5stMChrCjyTTtJ9aa1GPUABMy6vMY4bAr+rlJR8lbsRD7LiAaI0
         c7SCglm5RSjFWkDAiVUVCZrhvcHwEkDZ3vXIn0oG9AMfWXxoQxYwubr6FYpPhiz9G6Bc
         GYBQ/ge0xThbAGRJBQMtf5tGfY0yriBPFN1t71LBu91/zrVWw/5UsCsRgd58zJUImIMU
         CShOivjrlWXMZPQRh6JFh/AEwdoEjhhucbTDcnA+jP/AFqMLXcRcf/Hv5Gnf+5SNzf2S
         CcBdQMk/HWkBY2OZHm3RWtpnM1IVEoyEOAxhtXitD+nrb8KPBX74XBWoXI4N3y8hq1pL
         lPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h1utGPSe6HUXp2tUTW1s5hatB9U0uQHZHJs19pSNpeg=;
        b=PaauQfnTUlHct7AfJsu48ht+xYO3RhODM9QQ4yISOBhx/MUeaOWWt4PwGU7CW7QkYO
         QGGcDMMH1nlW8iNRWn89Si0Gmy3PulOG9LUTn6vbxg/ohDfC3Pmk7WYywRzx/2+4DHJN
         hAQuestfCHaJWSl+qrAlfk38qyZ2sGGOYd/PzFOh3JQ2C2fcWKtWjPMU8GeR8oAvcUaj
         CGkVwS2eA02asy5lAhNzc1MxSLYBehTMAZ8z2ZgyW0mTC38ahnB7vbVA9WKY9E5MYQvp
         e/fH9NMGHKD19nMsZCWoqj2ix3BkD7ilXpmoc95u7vawYHsZunNG/iS4n6lQ8H8t1pg0
         S1Dg==
X-Gm-Message-State: APjAAAXGS6vEPGz+dwA+NqaSzmusn2lzrtyDr7OsgxT6Ch5HYwKQimz+
        4NcEBWXvUBqGLP6G41P2+w==
X-Google-Smtp-Source: APXvYqxfWlnQcd6iq5uw5cOnDE7zHYi3S7KCVAYlNbp8AW29iYlMVq38htp+SbgV6RHB8R6DHB0Huw==
X-Received: by 2002:a5d:8d12:: with SMTP id p18mr3546216ioj.251.1566344322996;
        Tue, 20 Aug 2019 16:38:42 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id y5sm19796408ioc.86.2019.08.20.16.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 16:38:42 -0700 (PDT)
Date:   Tue, 20 Aug 2019 19:38:40 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] hv: vmbus: add fuzz testing to hv device
Message-ID: <cover.1566340843.git.brandonbonaby94@gmail.com>
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
 drivers/hv/vmbus_drv.c                   | 167 +++++++++++
 include/linux/hyperv.h                   |  21 ++
 tools/hv/vmbus_testing                   | 342 +++++++++++++++++++++++
 9 files changed, 589 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hyperv
 create mode 100644 tools/hv/vmbus_testing

-- 
2.17.1

