Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AF3716F0
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhECOsj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhECOsg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EBFC06138B;
        Mon,  3 May 2021 07:47:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u20so5232415qku.10;
        Mon, 03 May 2021 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHMX7e7cca//f8WV13d54/Yw94IX+FFVKn38d4yzFvQ=;
        b=DXIVVgn/RF6pH7mvY6Z3OTOmlU2LdBLelvX8YbNY7kbgAtVktcAGzGNMzkVfVkZ4SD
         yRuA+W4bm5yLjpw/kGhARLMGrNqENocXS94O4wxIFVXw4WXoBCaBd29lECEU/8vx1/Zc
         crMH0ojzcJIzgn5acEbz8ATuh9da596Gf9e0qgeN+Ir7NSIRwN9s3sN6vqCtS7t7luLK
         4/E3tcJOeNgLbHkB0SPyLhCSKePOBhpXQ9cnWvXgsYS2G63V3BYZx/t0RUiHYgiexhGp
         itI/gL9VD23M3kEmsuJeQGeNEzDqfrXKZiDHjIqygiNNmpJxQ0Vx3JbnQe0hUHxVTVwT
         QSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHMX7e7cca//f8WV13d54/Yw94IX+FFVKn38d4yzFvQ=;
        b=b1spZNX24b9/GWg473dgvbSCmd3LcXhTmbC7xdjnHpBdkgoghbaLuDpd7qhWQjTaZj
         J8EkzXJ9RZZXZ+qT6aur2D/MvVczx9PKzZ88WFJjN0+NREqM2qdN2rxUN+l/ZJ3PK910
         Clcb0GyzYO3LuiGNyCj1W1lb1UctmFeN+k62/k+HkPAWd5eVetAghqV458iPvgnLbq73
         PymHIjlKR8h9u4v+hFCDKhq8ca5ntqQDj6pEgJQ3vD2tewa80R35vyGqSkLu2jVH5950
         E41+pZCiLWOPOVBUVzSpomed9D7PNF2tERzqtsmiPYjO4tOaEPB75lnCrJaYY0lOvCxS
         RERg==
X-Gm-Message-State: AOAM5331nxR15b9du0RTQ6eDnD5GfJ2MhMqo084fE5f0isXMS0Ftkiaz
        DZstUyEDi0UfGc/Q/TzYil0=
X-Google-Smtp-Source: ABdhPJyEQrN4krK3JagLFsgtZiFtRmmcwogE+AlaLeRSuxSI0/l3UkXy8YAiBwdd49W8aQxYoGf0Ow==
X-Received: by 2002:a37:9c50:: with SMTP id f77mr6786789qke.107.1620053262469;
        Mon, 03 May 2021 07:47:42 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a26sm9287261qtg.60.2021.05.03.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5AE9527C0054;
        Mon,  3 May 2021 10:47:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 May 2021 10:47:41 -0400
X-ME-Sender: <xms:DQ2QYCMBDRrdhOb8cm2YCycxu2azIceprljzd0T9lsDg8hZ1CczQlQ>
    <xme:DQ2QYA8KyXSG9hu35Wo_n9Dc1cooYJqMZkeLFLbKEZLody9IvGECZ90qPUsRlfNJS
    CAkzTlte-pxe9wA0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:DQ2QYJQa15czChcJ6eLVSpMTf6ikpIL4oxufad3Op-sWkHKSk1EVJw>
    <xmx:DQ2QYCu1ygWBPLbyDTJBHxtlpANJZd-GNZgDFGGC2FBrddQf1Nq4CA>
    <xmx:DQ2QYKeJ-x__qmVsjPwrwNYTlyif3_Ot_NjE2H6UVB2D1ziV4q51JA>
    <xmx:DQ2QYJkse5aCimLmEMQrQGIyZlDkTVZbvr2GCNZlWtCIcB5GLqUqYs3eXTxMudMs>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:40 -0400 (EDT)
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
Subject: [RFC v2 2/7] PCI: Allow msi domain set-up at host probing time
Date:   Mon,  3 May 2021 22:46:30 +0800
Message-Id: <20210503144635.2297386-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For GENERIC_MSI_IRQ_DOMAIN drivers, we can set up the msi domain via
dev_set_msi_domain() at probing time, and drivers can use this more
generic way to set up the msi domain for the host bridge.

This is the preparation for ARM64 Hyper-V PCI support.

Originally-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5e71cc5e1b6c..90afa05ab2f1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -828,11 +828,14 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
 
+	/* Default set by host bridge driver */
+	d = dev_get_msi_domain(bus->bridge);
 	/*
 	 * Any firmware interface that can resolve the msi_domain
 	 * should be called from here.
 	 */
-	d = pci_host_bridge_of_msi_domain(bus);
+	if (!d)
+		d = pci_host_bridge_of_msi_domain(bus);
 	if (!d)
 		d = pci_host_bridge_acpi_msi_domain(bus);
 
-- 
2.30.2

