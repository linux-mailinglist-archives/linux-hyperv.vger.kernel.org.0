Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F056AFAD
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 03:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiGHAtj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Jul 2022 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGHAth (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Jul 2022 20:49:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD76050F;
        Thu,  7 Jul 2022 17:49:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 913975C0164;
        Thu,  7 Jul 2022 20:49:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Jul 2022 20:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1657241373; x=1657327773; bh=RVjLlv8eP8dwe6sbjupQRA3e0
        NbRlW7wBbLtagJ7psI=; b=K2cRHoAUQ0st5HMD9r+DTeAYkYtu+CAF+zPUEdpLY
        RTQDa7ACbu6UHvoQnmutzsYo1UYwF3VZ3kbi3w8ZKxFNajrhKzb7oxeSnsutpX1C
        HxgBd/NUG7k662r8aWrx0QVRqprAgBoyJHyNikIu+9TvlRlXzMtXdfE4jOo4NU5+
        d5k3dALErg1fY3XQoLFcOdmy3oX47bBkZ4/zvUUB4aUBkMT1mQz0tFl9Q6wQsu5b
        rRVOrZBCLaa2Ss2/KT+GNtLD6n28LxfnSKlIsdUFa/NyuQv+HQ2Z/GXcZnyDpzd1
        39CnG8dWP0NJkE95N7oFXuUAbWURuJEkglKEXSV9xf5cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1657241373; x=1657327773; bh=RVjLlv8eP8dwe6sbjupQRA3e0NbRlW7wBbL
        tagJ7psI=; b=yPjanZhn4OfvjG0KUFSqfvZ/JnQp36PhFjDU6MqOuf1LT7MU8ic
        +PsmivhN7FNzBBFiC0qCmmldoi9iIaj2QPqk3bscCyquo+iAux+NA1qfuAvYp7v6
        jGZ4pUHm/nvgd4S5zeBt2tMLIUI3/9nGVKp92oxx2ETX45dfOYuLmjj9JRKcJjOQ
        fY6y7UxkUxuEGXipycN6gRFgjj7Zl2lONYYpu6JbxbBmH255OD5EY7+n0cRoEYF6
        JC6WoNPoTIHa0OiXNhDV3ZVqd4LEkyBEm45h0TV5YL8gnMJsuNIcjD0HISekA9OK
        8JypebfdoapEswTBsXbOU8OMnyA8ogHS8SA==
X-ME-Sender: <xms:HX_HYpMKZ7YEiB27BW-2BxbiLM7JNqn-ZckmwsGYfH0wNNKVgh3QCg>
    <xme:HX_HYr-u2b74-fmwJSzADNP3P75PJ7AD0ygzHKBlyrBbZavErt2NCtUyC9cjWhvyP
    vOPXQv1jkVDwJlGQQ>
X-ME-Received: <xmr:HX_HYoRZI4cQ9qirkIuD44ZWpFjL94-9Uucq9WX8iZ9AgzSRxO5k4DwayH-V8TsVb0a33bckW_fvAk1-HeqfiJsU_Wz7-kl4Z-lVpbNkzXzNpEyuwCjZO_kpyV_s9Bu2_4BfOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:HX_HYlshDY-w1OfcUEx1SV2faqFOIxduNz2J8wBnVTVJlCpB1sNDOg>
    <xmx:HX_HYhe6tppqGhYM8MijNglyvi77_-4JAh5z9y4LpefXdRwv2AVaGA>
    <xmx:HX_HYh2CGAvLx9rCHgMb3Dya5AgAjgrQdshS9_R138apm2gcCZ-aUw>
    <xmx:HX_HYs1gCKtsstonSkXPn0greccuEzODNVf3E34F9jb7ysgLdhChuQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 20:49:32 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: hv: Take a const cpumask in hv_compose_msi_req_get_cpu()
Date:   Thu,  7 Jul 2022 19:49:31 -0500
Message-Id: <20220708004931.1672-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The cpumask that is passed to this function ultimately comes from
irq_data_get_effective_affinity_mask(), which was recently changed to
return a const cpumask pointer. The first level of functions handling
the affinity mask were updated, but not this helper function.

Fixes: 4d0b8298818b ("genirq: Return a const cpumask from irq_data_get_affinity_mask")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index aebada45569b..e7c6f6629e7c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1635,7 +1635,7 @@ static u32 hv_compose_msi_req_v1(
  * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
  * by subsequent retarget in hv_irq_unmask().
  */
-static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
+static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 {
 	return cpumask_first_and(affinity, cpu_online_mask);
 }
-- 
2.35.1

