Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D323716E7
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhECOsd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhECOsc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:32 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46327C06174A;
        Mon,  3 May 2021 07:47:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h1so1869486qvv.10;
        Mon, 03 May 2021 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cc7KqrSAJiYapYa5F88FOvtiyXEfLLsv6TzMqNJOvHw=;
        b=P+4pjBqfZWYIzHy1idxXlZrLpeYBcNHZKynKI9jlWICV8xP2E+8MLza3PuZuneqLxK
         ru4RlOsW48q02q7bsO1xNCfWIxkqYyt8Z+zhvWJ0IpAMJzJI/vaWAcIohCTh3vMItnio
         7OZkb8CJ6KYRty/U4Aoo30WUvCUN/7IN+1BO26IPMiMilpLTTwevnY3yTK2p5zg2PieO
         OQduz2EA0MD35EoKbUIzysUAwfES6Zteo3Kd0mKemVJQMmqIFcd8EQJJoXVMvBYycLW6
         cQMzTxjByOW8+/xZEcvwuOskfEhCoM4h5gkf0jbLiZWJsyJTy5wygTHzvoEez+g3EcQs
         2uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cc7KqrSAJiYapYa5F88FOvtiyXEfLLsv6TzMqNJOvHw=;
        b=DNf5US/o+uDzBYrnt5nRYq4Lf4dWTAEgoZrIiaSd6sezcmWm359xKO1bQK8f5TNzuY
         DWf+wtVv01CVZAYQXXKhM7og03Q1rqfDPmc47w+zkgK7LY6EYibT6j58GXgTeZHNNftK
         iJe+dIEOeskSY+u0E4J/sF3MDuJOpf56rY0kG13GL3jmqBkyXK6ieBm4GI3Ws8AdPiwy
         XwaEQvrPL8tEA92deNJuv109koDArIdaFeh3HTEdSMAPTu3RwKKX1EtIb9pknJwVhSTa
         QITcSG2JIqz1SrK6zmNNPTntlsc7XAYRbM7lMRKt0v8LaVfYsnG/BJnhz4KUAYhe5k/t
         tm3g==
X-Gm-Message-State: AOAM532lHPCUbLkkY3QrG+/ewh1I79H+VnlwM+kXk5V5U4QglE3+Yhci
        FDDL44Ck4EviRjzKThVOqETK4AxJJhk/XQ==
X-Google-Smtp-Source: ABdhPJwXngsSyo5CxEf+ZbNm1Rt0FtFhYEyf3zUSNK+ua1xGBaxGy+0Pf40fzQEYJ+WZbXfENVdWDQ==
X-Received: by 2002:ad4:4081:: with SMTP id l1mr20206807qvp.24.1620053258558;
        Mon, 03 May 2021 07:47:38 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l6sm8559395qkk.130.2021.05.03.07.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1826727C0054;
        Mon,  3 May 2021 10:47:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 May 2021 10:47:37 -0400
X-ME-Sender: <xms:Bg2QYKiZOtRFYQqJIZfETbo7gUTj9WdLO5367wkybKv30ZOVfJUQtg>
    <xme:Bg2QYLB41qGWdvQfQsW9xEjBqTDYlvmI_onew7mAfiK81xHIXOj3zO_5zI9TeuyWY
    FmQT59BnkM5va9EhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudefuddruddtjedruddrvd
    ehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:Bg2QYCHbX3KH8uci0pSqNACjxiifaL6gX2H37lwFcSU6RhU1rBI1mg>
    <xmx:Bg2QYDRf_7acyknUEGLucYH-8q2xtKxAOIIWZnMRwdBiQrQpp8WbYQ>
    <xmx:Bg2QYHwFeHK8PmP10Hlc0vsCYz2FrAXozv-VrS63vswVaFoysxeSzA>
    <xmx:CA2QYCKPooNiNy2NPZ2QOy23EYr3CDmy5P16aSCIx4kgmhlvTLI8hxw-DzKsAbLs>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:34 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [RFC v2 0/7] PCI: hv: Support host bridge probing on ARM64
Date:   Mon,  3 May 2021 22:46:28 +0800
Message-Id: <20210503144635.2297386-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn, Arnd and Marc,

This is the updated version of my first try to prepare for virtual PCI
support on Hyper-V ARM64:

	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/

, thanks a lot for your suggestions in the previous one.

This is still more an RFC, and trying to see what I'm on the correct
direction.

The basic problem we need to resolve is that ARM64 is an arch with
PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
Hyper-V PCI provides a paravirtualized PCI interface, so there is no
actual pci_config_window for a PCI host bridge, so no information can be
retrieve from the pci_config_window of a Hyper-V virtual PCI bus.

This patchset mainly handle three things:

1)	PCI domain number. As suggested by Bjorn and Arnd, I introduce
	a member in pci_host_bridge, and Hyper-V can use it to set up
	the correct PCI domain number for the bus, while others remain
	the same behavior.

2)	MSI irq_domain. As suggested by Arnd, I use the
	GENERIC_MSI_IRQ_DOMAIN's dev_{set,get}_msi_domain() to allow
	Hyper-V set up the msi domain using generic code.

3)	pcibios_root_bridge_prepare(). This one is new, PCI core will
	call this during host bridge register, and it will access the
	pci_config_window, luckily the only field it accesses it the
	parent field, and I change the ARM64's behavior to treat the
	acpi device as NULL if pci_config_window::parent is NULL, so
	that Hyper-V can provide a all-zeroed pci_config_window.

With the above, we could enable the virtual PCI on Hyper-V ARM64 guest
with other code under development.

Comments and suggestions are welcome.

Regards,
Boqun

Arnd Bergmann (1):
  PCI: hv: Generify PCI probing

Boqun Feng (6):
  PCI: Introduce pci_host_bridge::domain_nr
  PCI: Allow msi domain set-up at host probing time
  PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
  PCI: hv: Set up msi domain at bridge probing time
  PCI: arm64: Allow pci_config_window::parent to be NULL
  PCI: hv: Turn on the host bridge probing on ARM64

 arch/arm/kernel/bios32.c              |  2 +
 arch/arm/mach-dove/pcie.c             |  2 +
 arch/arm/mach-mv78xx0/pcie.c          |  2 +
 arch/arm/mach-orion5x/pci.c           |  2 +
 arch/arm64/kernel/pci.c               |  5 +-
 arch/mips/pci/pci-legacy.c            |  2 +
 arch/mips/pci/pci-xtalk-bridge.c      |  2 +
 drivers/pci/controller/pci-ftpci100.c |  2 +
 drivers/pci/controller/pci-hyperv.c   | 90 +++++++++++++++------------
 drivers/pci/controller/pci-mvebu.c    |  2 +
 drivers/pci/pci.c                     |  4 +-
 drivers/pci/probe.c                   | 12 +++-
 include/linux/pci.h                   | 11 +++-
 13 files changed, 89 insertions(+), 49 deletions(-)

-- 
2.30.2

