Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19353203558
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2020 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgFVLHS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jun 2020 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgFVLHL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jun 2020 07:07:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB40C061794
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 04:07:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so7440487plr.4
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV6PktgzrB4iRaCAlEY4nZtzBn4RvAQS9ZywaAjB7n8=;
        b=VOfe+Y7ChzK9Hae3UfS3VlrCiV2R/KHaGRHTLJr/5szVGhj7TrcsfoxBc9Umjy9War
         ovsVaObIhd/WOl/0V0cG0CzSYGAuarAwrNYOHAwmGI2QGEjQdATQG96u6q+vBuZ/uMga
         0EKvNMzGlwdb6UzgItYCDis6hEscPRCa2WH+PimmuWz02TJFb1i12EHvC/tmx1p5r5fH
         Tq3DFsehmBUsmjvi9oe0bmKYRl0M+jGFfcxLjJXALGAb/1O/GLQaFkqcSFxtx7vEsQ6d
         7K8tNKwyPKuY5KpBtUJku6+tu5oCKYIEUfJcFey14zU3Mvt1PNAPWfikFS37/+U/+yin
         uFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MV6PktgzrB4iRaCAlEY4nZtzBn4RvAQS9ZywaAjB7n8=;
        b=dtpReeJXjFtXLwMqSnvuuNg9cQ2cZFJC5McO721uNi5Zzm6cLU8iNGmGHM4J+HcUcK
         0laJG8t5b+X9MH9ZTMV2ZklPvayToBG3qctvV6MlJMunAVxXey1KRyDU/COXRCzbX1MF
         QFpg5DQRm3jUDuwLS/o/nWQpixNkhe5XXuAExOJ2zUZpYYLmNTucE+XwtvaT8YUgr+Wk
         xXvOv4GoxpvL3HKLQ2TeKNq5q0yn9PkSMnYZ0xVc4le510fxtZaqw6ppeMbLRf2I8d17
         O1PFeYgtyL1QB2HRPR285DthQGry+JxFo8XcQ55Pn7HUWQ/uZDE4rvEGC2gBWOcQAl5F
         bklQ==
X-Gm-Message-State: AOAM532x9EOWu0iF/1TUC65i8alC2N32Ses0bJ/gz3hzzbmPH0b4SHaS
        YLbt8qLgK+SksATrIYLPKWKh+jXutkUYdQ==
X-Google-Smtp-Source: ABdhPJzNjlHWq+TWNdqX3llNuMrQ81CUpnATGIvbw1KvCn/8BegMf5XOHgtikAC50KiGw6hcVd6LSA==
X-Received: by 2002:a17:90a:7c07:: with SMTP id v7mr17331347pjf.38.1592824029587;
        Mon, 22 Jun 2020 04:07:09 -0700 (PDT)
Received: from arch.hsd1.wa.comcast.net ([2601:600:9500:4390::d3ee])
        by smtp.gmail.com with ESMTPSA id j10sm6284217pgh.28.2020.06.22.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:07:09 -0700 (PDT)
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        K Y Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Wei Hu <weh@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>
Subject: [RFC PATCH 0/2] DRM driver for hyper-v synthetic video device
Date:   Mon, 22 Jun 2020 04:06:21 -0700
Message-Id: <20200622110623.113546-1-drawat.floss@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi All,

First draft of DRM driver for hyper-v synthetic video device. This synthetic
device is already supported by hyper-v and a corresponding framebuffer driver
exist at drivers/video/fbdev/hyperv_fb.c. With this patch, just reworked the
framebuffer driver into DRM, in doing so got mode-setting support. The code is
similar to cirrus DRM driver, using simple display pipe and shmem backed
GEM objects.

The device support more features like hardware cursor, EDID, multiple dirty
regions, etc, which were not supported with framebuffer driver. The plan is to
add support for those in future iteration. Wanted to get initial feedback and
discuss cursor support with simple kms helper. Is there any value to add cursor
support to drm_simple_kms_helper.c so that others can use it, or should I just
add cursor plane as device private? I believe we can still keep this driver
in drm/tiny?

For testing, ran GNOME and Weston with current changes in a Linux VM on
Windows 10 with hyper-v enabled.

Thanks,
Deepak

Deepak Rawat (2):
  drm/hyperv: Add DRM driver for hyperv synthetic video device
  MAINTAINERS: Add maintainer for hyperv video device

 MAINTAINERS                       |    8 +
 drivers/gpu/drm/tiny/Kconfig      |    9 +
 drivers/gpu/drm/tiny/Makefile     |    1 +
 drivers/gpu/drm/tiny/hyperv_drm.c | 1007 +++++++++++++++++++++++++++++
 4 files changed, 1025 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/hyperv_drm.c

-- 
2.27.0

