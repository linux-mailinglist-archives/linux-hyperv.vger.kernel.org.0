Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E563C82D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhGNKcW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbhGNKcW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 06:32:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C357C06175F;
        Wed, 14 Jul 2021 03:29:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id r125so1066037qkf.1;
        Wed, 14 Jul 2021 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX+DylQFl+b5aUUhEFVAqofxq/SEoe+L/4Ef9sTaObs=;
        b=Q+oIjxWan9rWu2vHb/qP/x9du4L5QsWJ9jpepPvnbmM+3WNvgKn4Ibm7zwwYFOJ7fk
         0NwyVaPd3q7Ap0OdhZzQOjqNfW9jUWppfeXmSUZWhgAN0Ql41A+a6Hd9ofJ5RCXgSXNs
         hoNonFwnuyAR567DDdQDdm/vezNuamvzzNS7YkIIOKONwpwA2RS8FU4e0pBc/gRMPbfS
         L9gBWtnQ9n5So9k08u6Aa8oSUmjpma7G5jb1ySKyQcw/yk10z/BEpHvaIeZtkG6nysvF
         nZ46Qwg/5wwU5G9lxT2kSE46q9KTktkgFWxaeDod9zo8erkv8ByCrmT22v3wXqvVfEgX
         nukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX+DylQFl+b5aUUhEFVAqofxq/SEoe+L/4Ef9sTaObs=;
        b=K2HV4vO3ikHihf7qLD6MsRkBxiOaOGv4A9bKk9lrFynV/NciDYwcXJWk7v7BvlSL0p
         xb5c0R5A5ZjoNshyJ8Qaga64OQ9RmYIZAgxrVayOULPj8htijeDkNvUmocp885ZfdP6S
         LPNriOEqqzjTX/EzKNcKuTv0+kjd2VcAqRBM3k7srbWNBGgylU9Q/ioe0mSup5eQ+QHy
         UmgpIqKhB62LIqJcRLRMb/sSwn3NZ/r8nPqBVfDgmdnptDNLlSjiyk3C4tIKBMZMyfQj
         IfRrPXS+ZqHJewViEBGtrDf6gqVt2hkpVOE5Hp2us1jcWCLDoQQRPxRagVgtgFamu2is
         N2RA==
X-Gm-Message-State: AOAM532JM/cjZRk98hTWdF3jFPjbV7prThUFkOFKO4g2NZTgFTHDIiRw
        Wb7wlY42o2pXCG+uxo6PNBLfeGLIJ8w=
X-Google-Smtp-Source: ABdhPJzoXMzoj4ECc+ahSyiMClRxrusvrrEi+GiSacx8hbeCnlSRQIvBzrJmLLC5yNLTtMDOAUHl6w==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr9317563qkm.362.1626258569161;
        Wed, 14 Jul 2021 03:29:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f19sm836967qkg.70.2021.07.14.03.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id D94AF27C0054;
        Wed, 14 Jul 2021 06:29:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Jul 2021 06:29:27 -0400
X-ME-Sender: <xms:hrzuYKzhzRljOsssx9L6Nb6_7MO05NK6-PtpOpUe0GcGcPdq4F5HCw>
    <xme:hrzuYGS6729ENTURt1st6pNPjAvWAdP1_8lIpTodFHKDPtPddVYJtzsiBTzIAFdUQ
    TDGlwu_mvybasvzyA>
X-ME-Received: <xmr:hrzuYMWMGI4l6CgFFHH89g4vHxIENJB0MAr2FLCX9xxLff1E9m4zl4H0WEPodg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiueevjeelheduteefveeflefgjeetfeehvdekudekgfegudeghfduhfetveejuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:hrzuYAhabG9Zs-hb3gWXAUQbMIxKPwXKvrXfR-HdVp3iFMUrp7bZLA>
    <xmx:hrzuYMBJqfWBKBukdvk483_t9cCZ0pGSA-cK6_W_zin1JgYQ-HncYw>
    <xmx:hrzuYBKDPa9IHVrYKM1JHGJTgNqIVijjLIPE4wgvLWB4f1D-Sb3bnQ>
    <xmx:h7zuYE7xNqeTBCiLZKBDbhYJq86iDsWSx6vzdL_jCwBUHvxRjdudI_M2Oa4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:26 -0400 (EDT)
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
Subject: [RFC v4 0/7] PCI: hv: Support host bridge probing on ARM64
Date:   Wed, 14 Jul 2021 18:27:30 +0800
Message-Id: <20210714102737.198432-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn, Arnd and Marc,

This is the v4 for the preparation of virtual PCI support on Hyper-V
ARM64. Previous versions:

v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/

Changes since last version:

*	Rebase to 5.14-rc1.

*	Change the ordering of patches, now the first three patches are
	non Hyper-V specific ones (i.e. patches touch general code),
	make it convenient to review.

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

Boqun Feng (6):
  PCI: Introduce domain_nr in pci_host_bridge
  PCI: Allow msi domain set-up at host probing time
  arm64: PCI: Support root bridge preparation for Hyper-V PCI
  PCI: hv: Use pci_host_bridge::domain_nr for PCI domain
  PCI: hv: Set up msi domain at bridge probing time
  PCI: hv: Turn on the host bridge probing on ARM64

 arch/arm64/kernel/pci.c             |  8 ++-
 drivers/pci/controller/pci-hyperv.c | 86 +++++++++++++++++------------
 drivers/pci/probe.c                 | 11 +++-
 include/linux/pci.h                 | 10 ++++
 4 files changed, 76 insertions(+), 39 deletions(-)

-- 
2.30.2

