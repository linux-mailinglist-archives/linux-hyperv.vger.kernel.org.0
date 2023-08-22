Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957478418A
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjHVNG3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHVNG3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 09:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83102CD4;
        Tue, 22 Aug 2023 06:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C14C61219;
        Tue, 22 Aug 2023 13:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6C0C43391;
        Tue, 22 Aug 2023 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692709584;
        bh=ky5/JI+OOtw0639ycMC1w4Z4dp2ftsDJNwA8hwne0Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh9FHQePt2aUtWbaBB/yBSqhIRtPXXQnXgbqHFsTcgRj4TtUjNf5SkilE/zdtqNri
         zaa2XHVa2EQvnSYA/H+cwEECy21pcQQ/Iow0Cdtg+GBPiB9Ig1meminchfPfLYqScb
         EUDGFBC8CdI6xxJ++0FVL2De3QHsKMP2zdFiJcwMHMuUO81koj0hpjrqbvG/foLUmJ
         0O2zrNXZwii39ikp7/vcedM+HycGDthl+/Cw/T7XpPxS2JmemXc3TCmNsaOYvnLsaV
         7pdMeFoCfGht6VoL68XrtWBlpVmIFFP5W3FPpXwSoHLcSL9bqsCJYKTWj42sfc52kU
         15YzWs6psY3EA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     tglx@linutronix.de, jgg@ziepe.ca, bhelgaas@google.com,
        haiyangz@microsoft.com, kw@linux.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, wei.liu@kernel.org,
        helgaas@kernel.org, Dexuan Cui <decui@microsoft.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
Date:   Tue, 22 Aug 2023 15:06:16 +0200
Message-Id: <169270956288.17505.3353115322149468320.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816175939.21566-1-decui@microsoft.com>
References: <20230816175939.21566-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 16 Aug 2023 10:59:39 -0700, Dexuan Cui wrote:
> When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
> device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
> device yet), doing a VM hibernation triggers a panic in
> hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
> pdev->dev.msi.data is still NULL.
> 
> Avoid the panic by checking if MSI-X/MSI is enabled.
> 
> [...]

Applied to controller/hv, thanks!

[1/1] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
      https://git.kernel.org/pci/pci/c/04bbe863241a

Thanks,
Lorenzo
