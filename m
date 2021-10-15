Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37842F58D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Oct 2021 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbhJOOiQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Oct 2021 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhJOOiP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Oct 2021 10:38:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF8C061570;
        Fri, 15 Oct 2021 07:36:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q5so8784906pgr.7;
        Fri, 15 Oct 2021 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1+buzEnWHFfl/ZaWbrWJXy+M9IGPXk9SXcGFxZnAfs=;
        b=RPL7BCrK2/jYy7dA9EeV9fzfOZdBvV8FM1iW0gA441nrIxQ1xg44AUgbJZXbJN0dLZ
         h8GZ848pgkw/SpggGk3Zko6r2dmRVDyVgm4Qzpu+JQZBNG9uUyRXcLcXSMbKPNZdxitc
         /r2CDWerhToBA5WnN6QULeO+FTZ6euC8cju6Uchf4G5vUgen13X2ecOGczouC8L9W32b
         3MlEbvo6LetX8BjoFIfC7+6AN6NRzKguY9vM57zS01VuXgIlLpDVdVL+ConAEe3b3USo
         OdQi9coc7ijOlKl5z4CG4gkXjcOES8tkv7Dlj3zY2sw4Iv3ZuUxfFKTnCjHiYeOB4D8z
         dzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1+buzEnWHFfl/ZaWbrWJXy+M9IGPXk9SXcGFxZnAfs=;
        b=3fIkL0CINc4xvO2LlhfiUwh6vIEOwxC/9Ln3HxL6SMGZPpOPeOp6te6Iy1ZNroLKs5
         RgjKCdr1ogn27vzmkUjK/6uIsV7NbVfaL3OFd6HAh7EXlpEnLCKpuTRAQjT3XErbEpNK
         cIXIS9YyOj1eraSCH1Tdcuk1te7pfaLAPihD9ocrURn5Hk23167E2jp4YZ3PXlyT/kzJ
         iMc1bE5myvb6DnosqXwAW5iav+nGL2J+/UlZqlmE5sc/ZB/lEkUuWtuTK9GjC9+ypkVJ
         rB4bme2m7PY6+hgQbHr/HtGcpxpMri5VToZJJdY2Aw+rnOw1ZndIesZU810SgnhhoN4L
         ibpg==
X-Gm-Message-State: AOAM531gPb8zQ1nYJemU56sqnvkwmZ5QJPeAQ9rJTYqkH1TCYIrzOGZ2
        2ZUETzbIQ70Kq3QshMY8+T7xprWza0BtAgO/
X-Google-Smtp-Source: ABdhPJyWuQ1K1JxflSMa0Mke7WMw5bxh8bvQ3ExR+gido75xKDvVtio4NGskzHymTTSJ5ZhB267d6g==
X-Received: by 2002:a62:ed01:0:b0:44d:6aa6:30eb with SMTP id u1-20020a62ed01000000b0044d6aa630ebmr12041882pfh.53.1634308567962;
        Fri, 15 Oct 2021 07:36:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id x7sm11536941pjg.5.2021.10.15.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:36:07 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 00/24] Unify PCI error response checking
Date:   Fri, 15 Oct 2021 20:05:51 +0530
Message-Id: <cover.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the 
CPU read, so most hardware fabricates ~0 data.

This patch series adds PCI_ERROR_RESPONSE definition and other helper
definition SET_PCI_ERROR_RESPONSE and RESPONSE_IS_PCI_ERROR and uses it
where appropriate to make these checks consistent and easier to find.

This helps unify PCI error response checking and make error check
consistent and easier to find.

This series also ensures that the error response fabrication now happens
in the PCI_OP_READ and PCI_USER_READ_CONFIG. This removes the
responsibility from controller drivers to do the error response setting. 

Patch 1:
    - Adds the PCI_ERROR_RESPONSE and other related defintions
    - All other patches are dependent on this patch. This patch needs to
      be applied first, before the others

Patch 2:
    - Error fabrication happens in PCI_OP_READ and PCI_USER_READ_CONFIG
      whenever the data read via the controller driver fails.
    - This patch needs to be applied before, Patch 4/24 to Patch 15/24 are
      applied.

Patch 3:
    - Uses SET_PCI_ERROR_RESPONSE() when device is not found and
      RESPONSE_IS_PCI_ERROR() to check hardware read from the hardware.

Patch 4 - 15:
    - Removes redundant error fabrication that happens in controller 
      drivers when the read from a PCI device fails.
    - These patches are dependent on Patch 2/24 of the series.
    - These can be applied in any order.

Patch 16 - 22:
    - Uses RESPONSE_IS_PCI_ERROR() to check the reads from hardware
    - Patches can be applied in any order.

Patch 23 - 24:
    - Edits the comments to include PCI_ERROR_RESPONSE alsong with
      0xFFFFFFFF, so that it becomes easier to grep for faulty 
      hardware reads.

Changelog
=========

v2:
    - Instead of using SET_PCI_ERROR_RESPONSE in all controller drivers
      to fabricate error response, only use them in PCI_OP_READ and
      PCI_USER_READ_CONFIG

Naveen Naidu (24):
 [PATCH 1/24] PCI: Add PCI_ERROR_RESPONSE and it's related definitions
 [PATCH 2/24] PCI: Set error response in config access defines when ops->read() fails
 [PATCH 3/24] PCI: Unify PCI error response checking
 [PATCH 4/24] PCI: Remove redundant error fabrication when device read fails
 [PATCH 5/24] PCI: thunder: Remove redundant error fabrication when device read fails
 [PATCH 6/24] PCI: iproc: Remove redundant error fabrication when device read fails
 [PATCH 7/24] PCI: mediatek: Remove redundant error fabrication when device read fails
 [PATCH 8/24] PCI: exynos: Remove redundant error fabrication when device read fails
 [PATCH 9/24] PCI: histb: Remove redundant error fabrication when device read fails
 [PATCH 10/24] PCI: kirin: Remove redundant error fabrication when device read fails
 [PATCH 11/24] PCI: aardvark: Remove redundant error fabrication when device read fails
 [PATCH 12/24] PCI: mvebu: Remove redundant error fabrication when device read fails
 [PATCH 13/24] PCI: altera: Remove redundant error fabrication when device read fails
 [PATCH 14/24] PCI: rcar: Remove redundant error fabrication when device read fails
 [PATCH 15/24] PCI: rockchip: Remove redundant error fabrication when device read fails
 [PATCH 16/24] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 17/24] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 18/24] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 19/24] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 20/24] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 21/24] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
 [PATCH 22/24] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
 [PATCH 23/24] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
 [PATCH 24/24] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error

 drivers/pci/access.c                        | 36 ++++++++--------
 drivers/pci/controller/dwc/pci-exynos.c     |  4 +-
 drivers/pci/controller/dwc/pci-keystone.c   |  4 +-
 drivers/pci/controller/dwc/pcie-histb.c     |  4 +-
 drivers/pci/controller/dwc/pcie-kirin.c     |  4 +-
 drivers/pci/controller/pci-aardvark.c       | 10 +----
 drivers/pci/controller/pci-hyperv.c         |  2 +-
 drivers/pci/controller/pci-mvebu.c          |  8 +---
 drivers/pci/controller/pci-thunder-ecam.c   | 46 +++++++--------------
 drivers/pci/controller/pci-thunder-pem.c    |  4 +-
 drivers/pci/controller/pci-xgene.c          |  8 ++--
 drivers/pci/controller/pcie-altera.c        |  4 +-
 drivers/pci/controller/pcie-iproc.c         |  4 +-
 drivers/pci/controller/pcie-mediatek.c      | 11 +----
 drivers/pci/controller/pcie-rcar-host.c     |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c |  4 +-
 drivers/pci/controller/vmd.c                |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c           |  4 +-
 drivers/pci/hotplug/pciehp_hpc.c            | 10 ++---
 drivers/pci/pci.c                           | 10 ++---
 drivers/pci/pcie/dpc.c                      |  4 +-
 drivers/pci/pcie/pme.c                      |  4 +-
 drivers/pci/probe.c                         | 10 ++---
 include/linux/pci.h                         |  9 ++++
 24 files changed, 87 insertions(+), 123 deletions(-)

-- 
2.25.1

