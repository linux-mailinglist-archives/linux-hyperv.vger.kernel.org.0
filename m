Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78753CFB51
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhGTNNP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbhGTNGg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:36 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B6BC061574;
        Tue, 20 Jul 2021 06:46:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id m20so540082ili.9;
        Tue, 20 Jul 2021 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqleALOEBIm8KewjJS4m2YoZXF1tGe3ZuXoD4Uil2lI=;
        b=rB5Lr/SXz6zRIJH22xI0zBsJHqVnUjFHYWbkpc11KHz1U8ifq0vksXkEYQ36mqzCmV
         U7zBMVdR+uC0kW8XBZUJ8P7dvEgrkskuf5c21Fc2JXlNHGk2CLW629zjqbuhMzEsq5O0
         gIQ2yIfB/YICdwemcSeWjZjr8UbrQVfbSfhgYYoO4JEfSb1pKjegxsZSwOHl7yV8YGx5
         16Jg0iFQKCZdNnFzrVwB3sEcdiKYuMP+zD2+DP4bym2iMkOFiuoya7lKM02NvwZvUJw+
         a+2sZb36y2QzyTZCD7DIeAra2Dcxf0Uxm1BhDTaxQyYdlDuEMPGy7KitGkxbfHMCOaV1
         pCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqleALOEBIm8KewjJS4m2YoZXF1tGe3ZuXoD4Uil2lI=;
        b=qRyLQ4vqZs4d6jm1QhTi3yE3uWWpRHfEzfmaA4LbgxgR3/DFbThvuzz/ujC9bZzGrn
         PASxykHZ/LgYKHTU9HXMvlYE4L8EC6K02p6S/g54Lv/h/GAnCZ58gR0ZYa+byayKDRV7
         +of7nZLNyr5tT+1zqMapelIGShD48e/mWd0ieHdPwxGQ6m8Ag07kJxeEN73QsSTdvACd
         1H0+NBlW7wcReYz18UIBVhGU46hBNJeUntZw2Z2pRSqDhGtYa/a6SDMbXSV+BvCIeklf
         1MMgS1rXsC6a6QXuvcMT8+3beuwC7ud1ij/3JpKlJ1T1NkQ6o8nvM8uyzUV6w+INWdvu
         iBBg==
X-Gm-Message-State: AOAM5331PR07emeLa+O3dHeUpOLfotA33eO4nmf6kULmQUlxVOZ1rVc3
        yTMtgjwxtXfawoDyJa7/z48=
X-Google-Smtp-Source: ABdhPJyIva65aopC9qc9dUyC7XykA+J49f+qwM5h7xk2CouBK89XwULCCFGHAK0hZyzzLw9ht0EBQA==
X-Received: by 2002:a92:d4c4:: with SMTP id o4mr19508497ilm.39.1626788790235;
        Tue, 20 Jul 2021 06:46:30 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q5sm4292697ilt.75.2021.07.20.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 79ECD27C0054;
        Tue, 20 Jul 2021 09:46:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 09:46:28 -0400
X-ME-Sender: <xms:s9P2YKkbRzoWGOgXquE_sKjLVY1ZP4ylUSixtLlDH77C6QoXV1ul4Q>
    <xme:s9P2YB254ghW95CSG1fa_3IUfIqwRaAeNOw7HmwOLizk45ps5u3D0iaZq1Hy2t3Yb
    tXtcJ9VJISQSZ58Lg>
X-ME-Received: <xmr:s9P2YIo39T6Ko6cOED8mnhbQBAi95wucj4MJYxB-KLbgxHK8fVjW7fecPks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiueevjeelheduteefveeflefgjeetfeehvdekudekgfegudeghfduhfetveejuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:s9P2YOkNakLvMsyu39ET4eDK_vMYJZ7Xjq7X_BBhZ5ZqXMwJ6ft33g>
    <xmx:s9P2YI0Gt6zWxc_I1JTq3PgLmd1M_u3z1aIFmjTByBON731weIVGKA>
    <xmx:s9P2YFsUs8q5EDVIQBjwwNaZOgm2dkMZjJxBfc2GTHorei1Mpul0lg>
    <xmx:tNP2YPvPAcjXqFmNE08HwgYCV_mnfkDrI6O8HJT348s6DmIU_LA3rbPqLIs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:27 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [RFC v5 0/8] PCI: hv: Support host bridge probing on ARM64
Date:   Tue, 20 Jul 2021 21:44:21 +0800
Message-Id: <20210720134429.511541-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn, Arnd and Marc,

This is the v5 for the preparation of virtual PCI support on Hyper-V
ARM64, Previous versions:

v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/

Changes since last version:

*	Rebase to 5.14-rc2

*	Wording changes (Capitalization and more explanation on why) as
	suggested by Bjorn.

*	Split the patch #3 in previous into two patches as suggested by
	Bjorn.

The basic problem we need to resolve is that ARM64 is an arch with
PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
Hyper-V PCI provides a paravirtualized PCI interface, so there is no
actual pci_config_window for a PCI host bridge, so no information can be
retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
there is no corresponding ACPI device for the Hyper-V PCI root bridge,
which introduces a special case when trying to find the ACPI device from
the sysdata (see patch #3).

With this patchset, we could enable the virtual PCI on Hyper-V ARM64
guest with other code under development.

Comments and suggestions are welcome.

Regards,
Boqun

Arnd Bergmann (1):
  PCI: hv: Generify PCI probing

Boqun Feng (7):
  PCI: Introduce domain_nr in pci_host_bridge
  PCI: Support populating MSI domains of root buses via bridges
  arm64: PCI: Restructure pcibios_root_bridge_prepare()
  arm64: PCI: Support root bridge preparation for Hyper-V
  PCI: hv: Set ->domain_nr of pci_host_bridge at probing time
  PCI: hv: Set up MSI domain at bridge probing time
  PCI: hv: Turn on the host bridge probing on ARM64

 arch/arm64/kernel/pci.c             | 29 +++++++---
 drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
 drivers/pci/probe.c                 | 12 +++-
 include/linux/pci.h                 | 10 ++++
 4 files changed, 92 insertions(+), 45 deletions(-)

-- 
2.30.2

