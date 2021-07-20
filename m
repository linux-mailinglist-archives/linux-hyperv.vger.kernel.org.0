Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99F83CFB4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhGTNNN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbhGTNGf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017BBC061766;
        Tue, 20 Jul 2021 06:46:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r18so12878472iot.4;
        Tue, 20 Jul 2021 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TJLMuAHE2H8Lrm5vyfU/q12WLbdatCUnIKtJEhq+Cc=;
        b=N7IKAy8ou25EauYObqKyP0VeMpWzhWsijjJtrwGr6QJzGvl4XULBiUZtRqeH2wsisR
         ojZUteTM+am3Z4aSy/K4BFki5TqearOo8wHiumKhnuyefPHBMPkr6yxAc8j1n1v2clo1
         laQujVmovtq6OL1kNSjVFXn+xVcwlhVmroV8f72kCWeO61xaELIVaFofGR1Rir3ku/I3
         7egoaZ3cmxtJWCIZ8ZlkdGph5oV4wVAskC0xC/JbWTGjdzk4Ps4ImYy807/xRZNmbr1D
         LWuu3LUjqq97ENsVRb2V58phQRG8zwfo+FXzfv2i7VPIswHYgBLxd1diy9fZFEc3eA7X
         DTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TJLMuAHE2H8Lrm5vyfU/q12WLbdatCUnIKtJEhq+Cc=;
        b=ZGqTD8iuWXimBFOESx/WTTv3HOOmnRKdhdEcE54nNrpaRKrHlAorNQQExOO0Pke3EM
         gn7mnD6x+f3zWeTbfAxa1iFWykGGR1LQDeICR3HI5tpLKk2JLeOesfKTA8EqHFB4HLhz
         kLrFWT6U1yGD4sHHX/Z4Y4y60/7BJRfxFmiVlKIWq4t0LH5g5QH6SKW3ZRIuVxmSvI/Q
         7kcTACKZdcYglpGon0lBEHZ+hhMDoGnMzx/Au2iHsL1xNrBNzsTo7FWd/FWZUUVVYa5U
         2+ENxPkcEW42LfgDjwgVAOUJhFqXDs8Z/RVDLmFsqlSGfNT942LXkIn1URS7H1bSji9O
         Beig==
X-Gm-Message-State: AOAM532Sfj43O86nYDFC0TWty4UGYuEmO2QROQZLUE/a2hakvXt8RU9z
        WypHOhHxEtI7SfLuuwq8RS4=
X-Google-Smtp-Source: ABdhPJyS2cEds2zsgyKsEc+5DTMSXbYiWZ+qI9G1rUGWnFSkZyZFxThO99sEp6DD4T2oHNsiqCTX7A==
X-Received: by 2002:a5d:9c4a:: with SMTP id 10mr22772701iof.23.1626788793845;
        Tue, 20 Jul 2021 06:46:33 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j18sm12154262ioa.53.2021.07.20.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:46:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8D8BA27C0054;
        Tue, 20 Jul 2021 09:46:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Jul 2021 09:46:32 -0400
X-ME-Sender: <xms:ttP2YGt8ziA07U91Erhs_U6fQKpq6sk9aWXAG-e6Lm5Y2_3yNNpyjg>
    <xme:ttP2YLc3TUCYc-AaCg2O18fsRz9sfXR4ZPBMkqdZRFwubbZYD-L_ovB89QMwbz3vl
    y_22YzYklCO5BIieA>
X-ME-Received: <xmr:ttP2YBx7A8cIUVK7QM3ywuhtZwGKQz6F5vrfYbC8wlD6auG6cxbjVvF6uBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:ttP2YBP_yef9M8pkJ7xPC1GzXPSfR7HlnLMS_JOCWWMJkrroPVOg8g>
    <xmx:ttP2YG9x9AfJcdoi4wi9MzufkO3HH6VvC69Jtg6PIKVBiiIb9CPbgQ>
    <xmx:ttP2YJWiOFbWQwq3Y1je5oEKq8S2ETgRBLpfdxkiZNHgzcIyvyuAyA>
    <xmx:uNP2YJ2BdEAmfBwAsVm_1pv-UuZk-dcwe_UwQSvZL8c3MWRlhPPvOiVZJlE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 09:46:30 -0400 (EDT)
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
Subject: [RFC v5 2/8] PCI: Support populating MSI domains of root buses via bridges
Date:   Tue, 20 Jul 2021 21:44:23 +0800
Message-Id: <20210720134429.511541-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720134429.511541-1-boqun.feng@gmail.com>
References: <20210720134429.511541-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, at probing time, the MSI domains of root buses are populated
if either the information of MSI domain is available from firmware (DT
or ACPI), or arch-specific sysdata is used to pass the fwnode of the MSI
domain. These two conditions don't cover all, e.g. Hyper-V virtual PCI
on ARM64, which doesn't have the MSI information in the firmware and
couldn't use arch-specific sysdata because running on an architecture
with PCI_DOMAINS_GENERIC=y.

To support populating MSI domains of the root buses at the probing when
neither of the above condition is true, the ->msi_domain of the
corresponding bridge device is used: in pci_host_bridge_msi_domain(),
which should return the MSI domain of the root bus, the ->msi_domain of
the corresponding bridge is fetched first as a potential value of the
MSI domain of the root bus.

In order to use the approach to populate MSI domains, the driver needs
to dev_set_msi_domain() on the bridge before calling
pci_register_host_bridge(), and makes sure GENERIC_MSI_IRQ_DOMAIN=y.

Another advantage of this new approach is providing an arch-independent
way to populate MSI domains, which allows sharing the driver code as
much as possible between architectures.

Originally-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 60c50d4f156f..ea7f2a57e2f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -829,11 +829,15 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
 
+	/* If the host bridge driver sets a MSI domain of the bridge, use it */
+	d = dev_get_msi_domain(bus->bridge);
+
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

