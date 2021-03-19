Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01783421AA
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSQUp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCSQUa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 12:20:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A70C061760;
        Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c4so3438744qkg.3;
        Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTqkIslzd3cZ3YjBiwLXA1sHZhbzdhxR9PRY9kOersA=;
        b=XEj7xRWm32bCF4yjMzjwpA6QUw4nqoK//unFI76siTlkarCqwbUdgOu+9sRIGeIaFR
         CpBJPZojis5xSZjzRVswDmA+bmsff91MSDWioPQU0OAiC4Z+di46w3deJDjzganWXNTb
         /cITW1gUvdJQPwqXzNfQbtDB6G0E6Kf26TGuoMxZPnKnTGVibnM8yZ53dFrryqTINTcS
         /Huin2H9VArXjOF1pMhLqdMcS+ydze50OT0CHq/7V5e34Z5/+hFWye8Su57wM+9GwqmU
         veCUyEDOW2G/L0iPZF22+EZdem8PNA7GUgY9LJmyylGO4bI5ba820jBQIHqjefDbdTC8
         dwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTqkIslzd3cZ3YjBiwLXA1sHZhbzdhxR9PRY9kOersA=;
        b=o8ex7jHA+2eH5dVAVvfHeW9i5u/8Zc0wuMBVaR5YEEfSX/i3izkLfriEhqSyhSx2/N
         JRRCwKfrg2lXTM+fiQRoIMhVjn48HBJSglhdPn8F9tYt2s0quBmmzROnn5z/OtEnOQob
         //c3YVKXDg7oZ2r3dIL5v1HeYG9pSU8cSCmhwgzhaQfLFNJGXmGsIu6WCjNulFQk+53o
         LwsjH+XNzHcNpXQkj3Sf+WW9P25Ha9RJcTsSJ5bzy/X3efmk+J93q3UAfw7sjv+R4l3z
         tgFRctL9RPlh1xFOteCYyZZ5VVTtRM3AAbXCCb+VFdB1ndVa53/vRAvarQtD2T0NpM/z
         pFKg==
X-Gm-Message-State: AOAM530dbJxcwswK67Jd/OHubZMyr+tunBLT2EUIjhAwHItqoM3v90NJ
        FqaHrHB4aGQ1wIYG0F8uAu4=
X-Google-Smtp-Source: ABdhPJwOQCi4eHUF3JKAOaJ7+W1gOiAy5rQZqz7Rbbbu3aBu7rigEKpd0Od6PXSPRjxdLrQWaD6gZw==
X-Received: by 2002:a37:9c51:: with SMTP id f78mr9994953qke.228.1616170829706;
        Fri, 19 Mar 2021 09:20:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p1sm4781938qkj.73.2021.03.19.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:20:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 11D1D27C0060;
        Fri, 19 Mar 2021 12:20:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Mar 2021 12:20:28 -0400
X-ME-Sender: <xms:Ss9UYIrWLVsH5Pb9qe35rFDJNUwJqffa7i-B-7SGHBXUeOh4lFPxxg>
    <xme:Ss9UYOpwcrzJbiVx2VrFSBm0_yfjwNJ63O8H5h5vwq2CkfIlS_HTgkK6LpJCj5fWt
    PFlfactaxi15V4vAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ss9UYNOnRAkDQTqky-LLcyIef4nLXi4CaxQQ-oxs0OgFuYvheFRDEw>
    <xmx:Ss9UYP5yapaMfn_O_rvcDpc9c84Qb7HvFhiS-yw7qqXpDQdpmF6b5Q>
    <xmx:Ss9UYH7uDjFBoOuyu_LtQPfQV9goQdbJZEtW4WPIGR3NMrnHqpOhdg>
    <xmx:S89UYGS4Sub_lyPfCo561uOlJpWU64ArNHtlKjxRaTuOKfo_b5vjeoaplyd3Btij>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F1E124005B;
        Fri, 19 Mar 2021 12:20:26 -0400 (EDT)
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
Subject: [RFC 0/2] PCI: Introduce pci_ops::use_arch_sysdata
Date:   Sat, 20 Mar 2021 00:19:54 +0800
Message-Id: <20210319161956.2838291-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Bjorn,

I'm currently working on virtual PCI support for Hyper-V ARM64 guests.
Similar to virtual PCI on x86 Hyper-V guests, the PCI root bus is not
probed via ACPI (or of), it's probed from Hyper-V VMbus, therefore it
doesn't have config window.

Since ARM64 is a CONFIG_PCI_DOMAINS_GENERIC=y, PCI core code always
treats as the root bus has a config window. So we need to resolve this
and want to reuse the code as much as possible. My current solution is
introducing a pci_ops::use_arch_sysdata, and if it's true, the PCI core
code treats the pci_bus::sysdata as an arch-specific sysdata (rather
than pci_config_window) for CONFIG_PCI_DOMAINS_GENERIC=y architectures.
This allows us to reuse the existing code for Hyper-V PCI controller.

This is simply a proposal, I'm open to any suggestion.

Thanks!

Regards,
Boqun


Boqun Feng (2):
  arm64: PCI: Allow use arch-specific pci sysdata
  PCI: hv: Tell PCI core arch-specific sysdata is used

 arch/arm64/include/asm/pci.h        | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/pci.c             | 15 ++++++++++++---
 drivers/pci/controller/pci-hyperv.c |  3 +++
 include/linux/pci.h                 |  3 +++
 4 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.30.2

