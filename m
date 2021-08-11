Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703243E949C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhHKPhA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhHKPg7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:36:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C7C061765;
        Wed, 11 Aug 2021 08:36:36 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x7so3275048ilh.10;
        Wed, 11 Aug 2021 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4Yippe1FfLHJnm/bBg0Tev596XLEVnx9ptKT8Tmv1w=;
        b=tuo0NJhlbsE1cgJWOCTQMJGME0TyKH6WbYQBRHNGe6yb4vS8khVqpRBj9CelO4Drcu
         ipgawXlzgK+T4+0OBbYZXrAC1LFA5a7zBBMAxXttMA0xiNXNci6NbPSr29QvVBGM+LzW
         29epQDHdAjX31mv91AAwgsMS8FmaqZJ2+oJcz/nKZExo2GdJ6bM9tSj48TZSrpoMKC02
         c+JeSib3R+Nz6EjTa6xDUcvTxRMEGNVg12BZ4RkXpr1AUdAsrvuWuBm2oTzNFEZOw4S7
         PMChY9ksUDnIApH0yl+pHTagBMzZoevhZZ0489tbZYC1FLezbgfwtDnFmSd48OU9F4Sr
         Cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4Yippe1FfLHJnm/bBg0Tev596XLEVnx9ptKT8Tmv1w=;
        b=LpSorsVwJjjVCPeQGFkGkfWbP7HWl53bo8sHm2c7D4QGOsuYZYyV88HR08mZuH45tb
         0er6S5+RvjA6EBDmtYCULRCX0dvtRDnGGO1WUJIHtLumctYOOwYSeNtHGo1v1VQrg64g
         B5KX1sxj8LIbxxFYsBU1OhjZT1ef7qpW+JjhENWVnYtWqW5WKMKkveHbEPrE+m47m1S3
         V6fDbBLTxd2ZFUjOr0u6Qz/vCD/sEgXSkwVg1jvhU8+LodJeon9X2jb/MKQL3UbGyteU
         vRASRzGwI6DP5+bPB9pkohaaInKBZfPyHQBpSy/0YzLfe9EVjjs0611usmD7kN1/TtSk
         cBeA==
X-Gm-Message-State: AOAM530djA9ULyBqQnzmp8PQhXfU3tV0rTxcBJLbT0RUtar2DDabmWdd
        Unc9EAjeiolcGq3TOTiq5cU=
X-Google-Smtp-Source: ABdhPJyNTPz4hVjuOvkYyoJGprZOIGKlvLeq9sYzEWOuFruqzCYMdKQk+WsJtr3StkToCnA5pmFe0A==
X-Received: by 2002:a05:6e02:1aaf:: with SMTP id l15mr51523ilv.128.1628696195512;
        Wed, 11 Aug 2021 08:36:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r1sm12858165ilt.37.2021.08.11.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:35 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1293C27C0054;
        Wed, 11 Aug 2021 11:36:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 11:36:34 -0400
X-ME-Sender: <xms:f-4TYeyDY-tqzLn91IwpWBMsoKdcnhn-Po73HZSJ3YMhnblmhH6gIQ>
    <xme:f-4TYaRPay_p1qCOKeStxdzVbhKSppcTl_RPqCUtDWdQJOq5zohNwNqwm6rsyrJRz
    1s2B_ufH2JLpr152Q>
X-ME-Received: <xmr:f-4TYQWZzjQEVuDeGplKGtke55nDNhu_9lu3CX5s3jm5oyWwKiAwekeYZKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiueevjeelheduteefveeflefgjeetfeehvdekudekgfegudeghfduhfetveejuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:f-4TYUgR8cSw0c2QXu0An5T3UvBrcX3cDGBtKcReql7HxgKePM4i-w>
    <xmx:f-4TYQDQzgoxcAIn_ZyyTk4-napsH79pFmucDo26F5V8xSvPVEIYyw>
    <xmx:f-4TYVIs1alv2ETfrTUIikowPrWaQA-FrrMbpOX1YhoQKGbwm5dRWQ>
    <xmx:ge4TYXC3gDEQxmiAu1dk9kOmvcSH1TynfVeQg8CBKcwSw82hnL8DC6YWMrk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:31 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 0/5] PCI: Use the private field of pci_host_bridge for ACPI device
Date:   Wed, 11 Aug 2021 23:36:14 +0800
Message-Id: <20210811153619.88922-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Lorenzo,

As our previous discussion, I make a patchset showing the required
effort if we want to use ->private in pci_host_bridge to store ACPI
device pointer on ARM64. This patchset is mostly for discussion purpose.

This patchset is based onto the v5 of my Hyper-V PCI on ARM64 patchset:

	https://lore.kernel.org/lkml/20210726180657.142727-1-boqun.feng@gmail.com/

, and I've tested it with other code under development to fully enable
Hyper-V virtual PCI on ARM64.

Regards,
Boqun


Boqun Feng (5):
  PCI: Introduce pci_create_root_bus_priv()
  PCI/ACPI: Store ACPI device information in the host bridge structure
  PCI: hv: Set NULL as the ACPI device for the PCI host bridge
  arm64: PCI: Retrieve ACPI device information directly from host
    bridges
  PCI: hv: Remove the dependency of pci_config_window

 arch/arm64/kernel/pci.c             | 14 +-------------
 drivers/acpi/pci_root.c             |  5 +++--
 drivers/pci/controller/pci-hyperv.c | 20 +++++++++++++++-----
 drivers/pci/probe.c                 | 15 ++++++++++++---
 include/linux/pci-acpi.h            |  5 +++++
 include/linux/pci.h                 |  3 +++
 6 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.32.0

