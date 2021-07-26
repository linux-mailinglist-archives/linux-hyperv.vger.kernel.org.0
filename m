Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131093D665E
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhGZR0z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhGZR0y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:26:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497D5C061757;
        Mon, 26 Jul 2021 11:07:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id u7so6594230ilj.8;
        Mon, 26 Jul 2021 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5lFoMgyXkemiYngT6HomI4alStah0h/A9+JLDPEl1A=;
        b=TmKs095aDXGT+gwqQrAmUCutNKy0QaDyqxdbmnS/5SCQxvwn/QKhqFsyAL9aoZiyY+
         5ImE6Jt5EPwKUUKcVDeNWEIUsNyDNzH+Pkyl6fqgTy2ml/ch+IXmgMvKxOOZC6l/8dGj
         gB9MiZkP2XATavcuGtm3tnpCn3INnDnxSvI8crsP6EQw6D9FgpGdu+OXEAfxzoDwfHn3
         8dGba8WrzUnoZIw26ytZws2gBVDtnMqlXuy9imTzQocri0qasBdc05vc4/cJge8AlJem
         oeil6AQwI+X0FjTp4k0LMVaENFeZYtNpLxkRU91lfv8qsSoG7SkUWK7kQiqb0kNetwoG
         UkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5lFoMgyXkemiYngT6HomI4alStah0h/A9+JLDPEl1A=;
        b=NrU7rJo2W8AqZl0CzDcCZYvJD5XiS8e3GwJxfztXe2TW+61v5UCjG5fiemVSD9JMrn
         hvZoOZtvABCwjm3XyQSfIpsbHr7wk2PuFHohJrpDx2BcIkl7+7iXZnaJXunuATFIDkSw
         LejkJU8fNbp1eI096pfByH85udPexLp9sFATCmONw6Cd21Ss7jDZkVgmZaJGBgQCx4K8
         6NYmeXfLEOfOhr7QpWZN8/yvHXDdO8lPi7iRKFXrBwye9Q/eOTtUWkN9GHYap6Fku8Ot
         ZTmBcAO+DaVibR2VnZcsZOkgSGCI0wEDHW8eIxNy8MIxFVwDflpZ9PQRy2gP5L+Gp+/w
         7WIg==
X-Gm-Message-State: AOAM531hl3BwkzBIHDpb51sQITKVS46ThxQq41uwzIpxRlwxofr/0m0H
        sK3TlrhbwzT0kzFz3i2MbKM=
X-Google-Smtp-Source: ABdhPJzOerlWOLVjwwhv9n1/8RjuUNM7aAXhzZH25e1iZayaqLrXVJ53diW7Q58BP+trWts/FoXwrw==
X-Received: by 2002:a92:d990:: with SMTP id r16mr14424299iln.204.1627322842266;
        Mon, 26 Jul 2021 11:07:22 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a11sm220697ilf.79.2021.07.26.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id A727C27C0066;
        Mon, 26 Jul 2021 14:07:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jul 2021 14:07:20 -0400
X-ME-Sender: <xms:1_n-YG8Sq534SnJFNZRNmPECGjQZyhh47uoNyPa5_NBF3DWzLl_qtw>
    <xme:1_n-YGuvsFxqjWisD7jL1z_KXLzW7TpvV_--Rxia-chJOfcyoPQkzNo9MxCjWFEYG
    N6pYkEzBpw35U1mVA>
X-ME-Received: <xmr:1_n-YMAq2ayWUBWfzwMNjHczZOa4ZDHd73MT9NPh-rhYeFJ5_cmFm7Rvl0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1_n-YOcfw-JniADNfl6SO5_kYQELdlCrk_SjcPvWGLzVQuPziCpK1w>
    <xmx:1_n-YLPj9dK0KOTZJXlNXLxbm4wPQ-dc_YvhaonhUUfhaH4mh_FphA>
    <xmx:1_n-YIlhL2FQ1_4Voux5e_Gco98YrGqwCWNcsUbJJPk8IKva8FwVsA>
    <xmx:2Pn-YGGxK5knOkkkc60FlIfu76lQtCSkcBLosIjJsQ4tf3BSIP00H-uemJk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:19 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 0/8] PCI: hv: Support host bridge probing on ARM64
Date:   Tue, 27 Jul 2021 02:06:49 +0800
Message-Id: <20210726180657.142727-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

This is the v6 for the preparation of virtual PCI support on Hyper-V
ARM64, Previous versions:

v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/

Changes since last version:

*	Rebase to 5.14-rc3

*	Comment fixes as suggested by Bjorn.

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
 include/linux/pci.h                 | 11 ++++
 4 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.32.0

