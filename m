Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8168A42F539
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Oct 2021 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhJOO3U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Oct 2021 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbhJOO3T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Oct 2021 10:29:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640EC061570;
        Fri, 15 Oct 2021 07:27:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q19so8512507pfl.4;
        Fri, 15 Oct 2021 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1+buzEnWHFfl/ZaWbrWJXy+M9IGPXk9SXcGFxZnAfs=;
        b=mW0YwkEYI+SkJyiLxlQX3Zdlu5EyWW8zMrdZ1/82zOBc94fM7nZ5imuO8lI0tb5Mlc
         GJX5XvSWu1L0mHI8nSrIRx+Do7SdcoiQJmua/qyhISbG1tvsgGAtKU2iaSZvTJBb65H4
         yybCzMgblNgOoHva0cf/tJmCf6kFhrzB7ImRJELkl+97pLZdPXanfD/7ui3T8inIbbwi
         STKVz/5qY9Dvta4IbwFgUI2HPfp+DgGS87+bamOPu7vRmCtOakuf4SGBbo8DvAGhvNNk
         uMToZ3PnjDxeoU2qn1wjU0aa9BC12o3ATwUQxwGE8QbXhHsGamQhQZz4miZcGUh7D1CO
         yNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1+buzEnWHFfl/ZaWbrWJXy+M9IGPXk9SXcGFxZnAfs=;
        b=t+tsIz5+Sg24GgOjSMYuazAyocM0enmt56f/QyIuHyye3njOijxqubLJIgPLZEfN47
         /nbEQ+NCwSbqMfvDydQbfqYAaWKIImvC/FqRBy1zwyTyaAQfEiVgyIJ9g6Un1cAUIqx7
         t4mcg+yMvP6phnCJJzf0mJrZDJ6/RCxup9JM90eMZGQaBdwC1Z48uHQ3XqVE1g2gBiQU
         /Ez6Z3hpgxf8e0u3M/CpX6BnSC8deC+gmb/G0mhK6Qo3jKKFpg8iF2psm+6/bsbDQYZ5
         xXz4NWuiCBArVMKdRoe8alK+XP44OtbpnAutK4VtfkHUBzap7XWyzBsEH+MSn2GyC94Y
         wzSg==
X-Gm-Message-State: AOAM531rLPG7JSs5VTJm27dTrwKTHPg+QUp9V+wUE+UfC7LCfG5FaYoS
        kejn+XzrY/QSdjSwRZBF0Io=
X-Google-Smtp-Source: ABdhPJxFKApjvWHOznC1si5BoWluKZQ8jEGESoKMvikMsJGlwrW7cHZUum4j158SdHMlbo9VkZ0e4A==
X-Received: by 2002:a62:ab17:0:b0:44c:f727:98cd with SMTP id p23-20020a62ab17000000b0044cf72798cdmr12077120pff.35.1634308032813;
        Fri, 15 Oct 2021 07:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:5414:a8c0:67be:6f68:5d31:1ee2])
        by smtp.gmail.com with ESMTPSA id ls7sm5408396pjb.16.2021.10.15.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:27:12 -0700 (PDT)
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
Date:   Fri, 15 Oct 2021 19:56:31 +0530
Message-Id: <cover.1634300660.git.naveennaidu479@gmail.com>
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

