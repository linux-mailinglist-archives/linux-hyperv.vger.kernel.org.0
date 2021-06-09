Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D063A1B02
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhFIQfQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:35:16 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:35438 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhFIQfQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:35:16 -0400
Received: by mail-io1-f42.google.com with SMTP id d9so23409620ioo.2;
        Wed, 09 Jun 2021 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6/SeYfOWSphhPUzzUCOjWtJORlKfdGfIiP9ztyD/8s=;
        b=VzXVi+aP/kh7qxv56RdgMxAYCmt5nnDhOgudMEpuUcIKcvzShAfp01wYRDjMjsLmqy
         xMmx+fFZbLUFtlfq+iN+jQ6JFFjX04Qk8w6HR9VE5VV3M4kbZc+7za+Xoo5H03lkkTB9
         blGt9ZzjHe4h1jMsU4wWYoVNgcdS9eJvh6qsHcX/9nmw7G7bNWr/uHe3m5uaJbB0Tg/H
         E5IrYL3OJ8VQyo7rsUqZcqIAfEwOAJgxwY3lHIiB6ari5063pTmWT56WJAjRdPUgNFrz
         odriMPk0pPLdW1r0HzGZ+Evxa4R/tQkWlXPebuWowEzMBsADddrNYEsFc4VMjN3jkEEr
         kutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6/SeYfOWSphhPUzzUCOjWtJORlKfdGfIiP9ztyD/8s=;
        b=heZt7/CuNpOsJNmBWFZ+meT4gyQqfHPeXlFgVjf4w8zA0zz+FQgqQfDF6neOnwqxQ4
         B38N1RG0m9JzjwXGnbZGXpOvhAFiPmn+bpVHH/z/8ZMf2qhPfb+ro460zltazAgEPxAT
         ihfa9V2wl70yOuGqJFvXbS0ZLdyt2Pu1Z/EwYsZZYuf10puFardIkt3dYFRzkCVtYGP2
         ESG8rorQlvajI9atbG9pgpA8NzuPnTZFKmLbrSCI3acPO7Pu+RqTOXpWFys3m6/DYp9N
         JIJldPkEEubbHOIVFh3yDoD3zEqsFQ3+X3g24i+xOKzvZwGdNDl73FUZ1sHsOuXu5b1I
         O0tw==
X-Gm-Message-State: AOAM531eTDyfI8uCGfkdHEwqlSk1UBJG5qYrqLLVXqxbaFwlCAq/3cey
        SJw2sJbd7wZ5V7/sSJuFJP4=
X-Google-Smtp-Source: ABdhPJxTGsMwJckSOcHPUfZkQMSOylbN7ZjTcunLm5nQTVNYS9kSiq81BVkc6A3EWg7CyKw7qvnZ4A==
X-Received: by 2002:a5e:860f:: with SMTP id z15mr227163ioj.193.1623256341541;
        Wed, 09 Jun 2021 09:32:21 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j18sm251468ila.29.2021.06.09.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2A12327C005C;
        Wed,  9 Jun 2021 12:32:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 12:32:20 -0400
X-ME-Sender: <xms:E-3AYHVk6Sboc07CIRuU4-n_kkbuDGh6irzefl1IIOkYv0x65ENfLA>
    <xme:E-3AYPn_cptPg3ZTXUQ9iXi5iJ76VknyykL7E9FyEUmsvvOkS8L6b32GuCTpw7OnO
    b-joo2unopTLiymhg>
X-ME-Received: <xmr:E-3AYDYL3WDmtUSnpekm7oVqfCJi27q1DYwz80rP1hANjYS3VKPsWpeUWH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:E-3AYCW220T-bQ-8ciMW1rkVA8dCxoNCY8441cMDCx6aSwzAk06tdw>
    <xmx:E-3AYBmQkfMKMYi2FGaYLgUc7B0PxOv35qV6fvmPYK-yLiyBzo8CvA>
    <xmx:E-3AYPdsY4Ir_-BINE6ncOwsEj9UvkBdiOpaaGIq0qYFhsGFNteKAg>
    <xmx:FO3AYD3BuPaCtqGmRbtQ3eXVeKYKuxUHJ-HwGwxQ_G6o4tnmTC5tmVUulNM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:19 -0400 (EDT)
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
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC v3 2/7] PCI: Allow msi domain set-up at host probing time
Date:   Thu, 10 Jun 2021 00:32:06 +0800
Message-Id: <20210609163211.3467449-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
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
index d2753097a1b0..38bee41dedcc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -829,11 +829,14 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
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

