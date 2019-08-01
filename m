Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6E7E3B0
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2019 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfHAUA2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Aug 2019 16:00:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38959 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfHAUA2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Aug 2019 16:00:28 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so147142083ioh.6;
        Thu, 01 Aug 2019 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gJSK6POj+SaTsEhP6mZuOKfNhfXYob24U3YC9u2cnhE=;
        b=SaIIckh5W1GYRsKrWdLmpj/9wvjxGa2xVLUEA5UdHxlCQ5J7SwZFF7MHwdfMF1UfLX
         SKyMHr+l52jdQ321LVBLApxCNfUmOhW3hDWnOkH9dzYe9UQQhuis4KqXfYsoLEuBw8G5
         jRTtLq6MTP/tWTPSAVKV3aqnl2K0b50XAhTmLdwFzofdooRVsjrT8JkZ5XQ8bZ85Ib+Z
         T4QK1KtDi0lrB0nEz0Ck8M34LtPfR1hIly+E5ke4vCOaD2OksuqFkGCzv0/N220vi/Fu
         Aq/6ZlhF0wGspt9lNdRs2yjMjglzmpJ9cdOM90HBcLja9iOizSIXJifZxFj+ylxVk+Ta
         j0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gJSK6POj+SaTsEhP6mZuOKfNhfXYob24U3YC9u2cnhE=;
        b=WbcIDvt0NqsmQ7W5LmGz5eXSkQraibwu8UksV6OlYyA+OD2LMnkJKl+0647Vt9UugN
         DZqhL1H/LiazYk3hJYd21WB+94452gIRysU98v8bxOotYiXOGj3RXIkNulK8yLAq4noR
         SdMGPhRZdkuR2qnDs3HE85CZKqQgh+9nzOq/zGa/IDqmbXEZor7GOJIVwamJf2r7KGk5
         leeGEAyE1uC6EebLgcd6wi1ktNo1dsLA44qW1M+a0N8JmjgwrM68fwx12GmI5vHaWIHP
         opdjmfGRmKKLAXxyJN1t9TeuVTVoUKwit4EUXtNgp9L95HGlw8flbYZQn8i+ujvfV+7j
         vsXg==
X-Gm-Message-State: APjAAAXlna68Q9j3TTgeaeN2evgL1k3IzxcAqiG6pyvBxutaOpgKnGlz
        IzivvfMA96kmr7crtB5u3g==
X-Google-Smtp-Source: APXvYqy/jlf8jCGaEdmuO8gxRpfCVtG12T1tBiYavXuDp4k6Q55JztG8Y0YG90d0VFvhxNZCbq2yrA==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr7071475iop.293.1564689627170;
        Thu, 01 Aug 2019 13:00:27 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id m10sm128925853ioj.75.2019.08.01.13.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 13:00:26 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:00:24 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Cc:     Branden Bonaby <brandonbonaby94@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hv: vmbus: add fuzz testing to hv devices
Message-ID: <cover.1564527684.git.brandonbonaby94@gmail.com>
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

Branden Bonaby (3):
  drivers: hv: vmbus: Introduce latency testing
  drivers: hv: vmbus: add fuzz test attributes to sysfs
  tools: hv: add vmbus testing tool

 Documentation/ABI/stable/sysfs-bus-vmbus |  22 ++
 drivers/hv/connection.c                  |   5 +
 drivers/hv/ring_buffer.c                 |  10 +
 drivers/hv/vmbus_drv.c                   |  97 ++++++-
 include/linux/hyperv.h                   |  14 +
 tools/hv/vmbus_testing                   | 326 +++++++++++++++++++++++
 6 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 tools/hv/vmbus_testing

-- 
2.17.1

