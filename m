Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518463A1B06
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhFIQf3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:35:29 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:36463 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhFIQfX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:35:23 -0400
Received: by mail-il1-f176.google.com with SMTP id i13so21436755ilk.3;
        Wed, 09 Jun 2021 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtZXviG8uKoMfdBFxqtDjPPlrA8OzkIV4mPRyCmfPJ0=;
        b=YzkkczauS2WvRJIVgV/DNuSg7McxEpu8TA5olLmTNHDc5vb0b/VtwnwDhUFEB3gH78
         XlfTwupw2p3xj+8LVdPmgEsyKLftx8Xu1s1anzpb+3mXJfMx+iFFhty9IyWM7i6ata1m
         dTQ+CRRGK68Qdw2v0wrgavXwnLxMhc6Ci26sUG73UMk32BNChJHmxRZHx0wqcTI+yfLx
         QUzqrgISJSKQnKKvIUAcnYDxbcJ+qXSJ8qGZ8OZ8jCxmytRPbS+cOiOr6u1iwXmgwLka
         8zS/m4IuZtraftHXLX+Os3qA01m6T6rNdjn1fKUJ6iF+pxaTMeRjEheT4fIoeMyfxYZa
         P+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtZXviG8uKoMfdBFxqtDjPPlrA8OzkIV4mPRyCmfPJ0=;
        b=ljeWuqK9mWRd/GGb7TMUVao7bTE8SlaUAiOvpt6FqMcK5WVtdG0QmRQ2XtjAKbBR8Q
         udlnbZ+qVdWdWvi2pEEQvUOJ5cnAN1sJVAvNJ0ZDlV5B9X2+iDlE5iMkzLdl8DvFLLAp
         X+orOWQeQfrUAKgS35guRdtm7tSQXjlGH+5Cg10hXKvwiecxvJQ655wHBti0Y2odDiz0
         1C1pDagcKzhxxgXTBXfQU9F50IwMu/DRSZSbnvpD8e1hwq29DNbrpLdXZqVu+eKYSKbi
         4tyNqDIs8jmmRsHNQNOFJ6gAMcgPRK22bBFlkf7xhBm2zLWBlyHh5OKAm04oGSH8xdL8
         VYtA==
X-Gm-Message-State: AOAM5310FEQkGx08x1H3ZSTCTR5DFL8sW1+5Sc88DNyzcIWBSnv8hJaj
        ysSzIcoiWeTKgYLvPHamjEM=
X-Google-Smtp-Source: ABdhPJyCaLxflqzQktggIYp8gGGDpxLAoGlXyBklc7M80uKlmRSeQ9JOVwhdJWE91P1RNtG49SHSnw==
X-Received: by 2002:a05:6e02:13ec:: with SMTP id w12mr444534ilj.248.1623256338755;
        Wed, 09 Jun 2021 09:32:18 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l12sm282835iln.20.2021.06.09.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20A2E27C005B;
        Wed,  9 Jun 2021 12:32:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 09 Jun 2021 12:32:17 -0400
X-ME-Sender: <xms:D-3AYN0YAv0SLUfpQiDQaNrjbEj2JvLAsQAtu4exvrGGmdiJ85vyVg>
    <xme:D-3AYEFA7XVD0ZmLCm0Tasro2dAVPv7hlZeld1c3e_Llrk8jtFsIVli6v1mVwS_Fz
    qg6f9mTwGu79_YOdw>
X-ME-Received: <xmr:D-3AYN4ZC-_G5Hu5jIkSLtcok1z1FX3Ve9Fp4JN5m69ZSXK67amVtRYkTYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiueevjeelheduteefveeflefgjeetfeehvdekudekgfegudeghfduhfetveej
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:D-3AYK3jgmKjcl1p1nVVjs1lEmUwRy9jHD8vEtHZyJIh-bBWcc5aRg>
    <xmx:D-3AYAEjCLC51vHxRsFbwoU9ZKjR5h8VQtI4Lhi-CFv_mi81ENjaxw>
    <xmx:D-3AYL9pvOZ1OcsFZj2uMKc5UsJt6vszli9lP6REzaWumWoaeHIzHA>
    <xmx:EO3AYGFjz_-tXPuVnjrm87_3uYSuLNjXy6b0dW03flFijiyv5Syxmt6gAhg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:15 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [RFC v3 0/7] PCI: hv: Support host bridge probing on ARM64
Date:   Thu, 10 Jun 2021 00:32:04 +0800
Message-Id: <20210609163211.3467449-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn, Arnd and Marc,

This is the v3 for the preparation of virtual PCI support on Hyper-V
ARM64. Previous versions:

v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/

Changes since last version:

*	Use a sentinel value approach instead of calling
	pci_bus_find_domain_nr() for every CONFIG_PCI_DOMAIN_GENERIC=y
	arch as per suggestion from

*	Improve the commit log and comments for patch #6.

*	Rebase to the latest mainline.

The basic problem we need to resolve is that ARM64 is an arch with
PCI_DOMAINS_GENERIC=y, so the bus sysdata is pci_config_window. However,
Hyper-V PCI provides a paravirtualized PCI interface, so there is no
actual pci_config_window for a PCI host bridge, so no information can be
retrieve from the pci_config_window of a Hyper-V virtual PCI bus. Also
there is no corresponding ACPI device for the Hyper-V PCI root bridge.

With this patchset, we could enable the virtual PCI on Hyper-V ARM64
guest with other code under development.

Comments and suggestions are welcome.

Regards,
Boqun

Arnd Bergmann (1):
  PCI: hv: Generify PCI probing

Boqun Feng (6):
  PCI: Introduce domain_nr in pci_host_bridge
  PCI: Allow msi domain set-up at host probing time
  PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
  PCI: hv: Set up msi domain at bridge probing time
  arm64: PCI: Support root bridge preparation for Hyper-V PCI
  PCI: hv: Turn on the host bridge probing on ARM64

 arch/arm64/kernel/pci.c             |  7 ++-
 drivers/pci/controller/pci-hyperv.c | 87 +++++++++++++++++------------
 drivers/pci/probe.c                 |  9 ++-
 include/linux/pci.h                 | 10 ++++
 4 files changed, 73 insertions(+), 40 deletions(-)

-- 
2.30.2

