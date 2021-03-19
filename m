Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61A3421AB
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCSQUq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhCSQUc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 12:20:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E3C06175F;
        Fri, 19 Mar 2021 09:20:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so7109897qtx.10;
        Fri, 19 Mar 2021 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOigcolInKq2azrkaT41R7EqZELchBXlGjfdA7p16f0=;
        b=R+VQTD45IlVeo8FZIwkbsrXHb5HdN1dGNF0wbJZot8CK1vUlZOYi5miaJxAn8T+F0W
         tzyHBANAN3MCw8jx4+gTtPmTBp+8BCXmBgM5IZeDZcJjjZYD2wWvNh61wW8V7TdF/ZZg
         UZ11EpMynm7tH+61CZs+hXxzW+DDl3fYuFQzSb+uUn8GflXn1f65mSv0pUYrXY7IxCDd
         EhZvXLzYn5pdj40r6h0g8Vn9YsCpGnmD4/eM+sttRxzQUsZPmOBmH+VsxYLm5FvHhqWX
         hVc9ibDoitEdKWpiuR2gFNoR8OOH/xflRcw/ZXFL2w9l+5o+KlORRyG7SHN1UHGHDvcR
         gmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOigcolInKq2azrkaT41R7EqZELchBXlGjfdA7p16f0=;
        b=Zpzw7NgAiNx2TrpaqPk9aQUhTwUlTp/Xj8fXGVorMmgvM4tUEXlzU8NWyYMhe3zqPv
         8vKFG7VVWLPvA8Pw6Ew3ext3eQSVuAnaYRLYOt+3Vcnw5dMBpx5SSLY0NsiCL5XyevbJ
         mzVuZnSZWOC+eMylmmVpRXxbt9cWGFMBm1hZro/HJf18xJ+V6/QvPt2SRqgbYsp5o17e
         Tobgd3fqIU1Bn2Dsk541kGucM30JBxvwpIactAIi/NJUsnfYCTmV7fNO1/nbBpizfE/8
         Y/J2PAkr2y8W6cGGhfsTs72CIuJCOqieOOvnK0Rp8qBY8nJEmrKysVLDmEvtJnnzAnqU
         266A==
X-Gm-Message-State: AOAM5300kH+XKNAz4IVyX50GKSf8NVYoVBRhrykCAKHo0wSdyUN/yzky
        +Aes6TpOOBt+xfLd6Hqu38lpXa2EyoU=
X-Google-Smtp-Source: ABdhPJw5rCfLaNS+oBUljUXMupVv+A4YSSGCfys/J74kbxSkFozJnCNbdN4NNBB4KYeSzyWZl/+M+w==
X-Received: by 2002:ac8:7d52:: with SMTP id h18mr7143435qtb.175.1616170831225;
        Fri, 19 Mar 2021 09:20:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z14sm3929680qti.87.2021.03.19.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1129427C0066;
        Fri, 19 Mar 2021 12:20:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Mar 2021 12:20:29 -0400
X-ME-Sender: <xms:TM9UYKGMYp05jpSXRFFsM8RD4yBpok246P0ykwssE8qe3VR43QSXjQ>
    <xme:TM9UYLWisBf7FSIF_7uECqbxgYvP9Yu1Hfol4zNIx0w46lfet7jib5-dxS_KSzmHG
    Nl5bb7UcM8kPb_NcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TM9UYEI9oLSaec0y8D5MDQlBqGlIJ2E94Tl95vtxXVMWrzu3O-s_QA>
    <xmx:TM9UYEHN_timsoyRkp1B9sf3gcT0W7E0d5L8jxuVaVqNHWbEu-aTqw>
    <xmx:TM9UYAWPFSM6RBNOSkzbdAAgEOpEAWydwNt3FTdnY1Fh6kO0_1Sk3Q>
    <xmx:Tc9UYBvmocUpwABN6Tv8iiUMVtMotII2FAuhluIas_7-5A7uJw_mpBPr1VjEo711>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id A062324005D;
        Fri, 19 Mar 2021 12:20:28 -0400 (EDT)
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
Subject: [RFC 2/2] PCI: hv: Tell PCI core arch-specific sysdata is used
Date:   Sat, 20 Mar 2021 00:19:56 +0800
Message-Id: <20210319161956.2838291-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319161956.2838291-1-boqun.feng@gmail.com>
References: <20210319161956.2838291-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use the newly introduced ->use_arch_sysdata to tell PCI core, we still
use the arch-specific sysdata way to set up root PCI buses on
CONFIG_PCI_DOMAINS_GENERIC=y architectures, this is preparation fo
Hyper-V ARM64 guest virtual PCI support.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 27a17a1e4a7c..7cfa18d8a26e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -859,6 +859,9 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
 static struct pci_ops hv_pcifront_ops = {
 	.read  = hv_pcifront_read_config,
 	.write = hv_pcifront_write_config,
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	.use_arch_sysdata = 1,
+#endif
 };
 
 /*
-- 
2.30.2

