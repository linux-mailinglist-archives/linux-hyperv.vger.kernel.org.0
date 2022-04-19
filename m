Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A36506C54
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352319AbiDSM0q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbiDSM0h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967B35DD1;
        Tue, 19 Apr 2022 05:23:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v4so21006496edl.7;
        Tue, 19 Apr 2022 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i++nWiV/Aq4vEmjsK9ua00Hl5AmOUpTT4jcNTohrzII=;
        b=gzdc9pjd+EPrAo9/lM4+CJedOY9V2fvphzKPLV9mNld9JKwastcqLZMs7F+665jNVi
         9D62t9ehY1QCilLi6n6L1zA/z9wlL9JximuIhUoRLnOAvnrvsI5X5qIuVWz2l1IGh2Vs
         pGQsGJFYEYEJmCZvPvtXRC6cRBadOfKbqnNApoM1Yr5MQcmBO2gVZzmaZMizLKDqB79u
         Y7wVKemT6t0nrlVmNxhEefHN7f5aVwmlg6iYyfYZ9uEGgHDwXa9phYBd98jIoF67blqr
         ckJt8i2D0KPD8iB/XNcaadoSLpWmYX77yQuaFrbC6UCzu60L/csBqPGKyNlgP6zUWRr5
         cxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i++nWiV/Aq4vEmjsK9ua00Hl5AmOUpTT4jcNTohrzII=;
        b=ZvPvLcmV1iG6KLn3eUE9IPxe0wUMao1W0v056W6S+gk0hf47BxCteJoT007dUZVS8P
         ukbeIym9pf3ITk1jUzjb3HgpH1goivLsZbDpYeiUk3RCj2wQYp5m5V/Mp8JhNkvWgJQ8
         KGniKKX6H8FZscSpvMjDB84MV+wIVIHOutXID0mQ0U256qNA/1SncuIoZUNj4FUon8Qw
         bGTOYQwxK9ozcu2F3AYuteN2SG/iSZvpPIQ0GfH/QfVXsf1sFcvt8/DhbCKZu6NlNWDP
         J/kIwRFDcnwfNQAqiLmNP5ZwgkDysDdxnssdK4gOTOT2Fc3yRNBZurFe63JTqJ96ViB7
         Q9dA==
X-Gm-Message-State: AOAM531imGQYKZXFy7WP8qXmbqAA1ghucMz6K9h2c6HQmOaAR0FYR2A2
        CUmfRXdm+K1ps0N6n/146w8=
X-Google-Smtp-Source: ABdhPJwk1k+MaEG5KJQm5B8AzbhxRzlu7d+fRqbIAuZ0dCL057zEeKMVGU6zWWbTYfhSzUSGcVtArw==
X-Received: by 2002:a50:e78d:0:b0:41d:c8ec:81b0 with SMTP id b13-20020a50e78d000000b0041dc8ec81b0mr16841248edn.56.1650371030938;
        Tue, 19 Apr 2022 05:23:50 -0700 (PDT)
Received: from anparri.mshome.net (host-82-53-3-95.retail.telecomitalia.it. [82.53.3.95])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm5644685ejm.189.2022.04.19.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:23:50 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 0/6] PCI: hv: VMbus requestor and related fixes
Date:   Tue, 19 Apr 2022 14:23:19 +0200
Message-Id: <20220419122325.10078-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Changes since v1 [1]:
  - Use dev_err() in hv_pci_onchannelcallback()
  - Remove Fixes: tag from patch #6
  - Add Reviewed-by: tags

Changes since RFC [2]:
  - Rebase on hyperv-fixes (although more likely -next material)
  - Fix handling of messages with transaction ID of 0
  - Avoid reading trans_id from the ring buffer
  - Move hv_pci_request_addr_match()&co. to VMbus
  - Introduce primitives to lock and unlock the requestor
  - Improve comments and log messages

Applies to v5.18-rc3.

Thanks,
  Andrea

[1] https://lkml.kernel.org/r/20220407043028.379534-1-parri.andrea@gmail.com
[2] https://lkml.kernel.org/r/20220328144244.100228-1-parri.andrea@gmail.com

Andrea Parri (Microsoft) (6):
  Drivers: hv: vmbus: Fix handling of messages with transaction ID of
    zero
  PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus
    hardening
  Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
  Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
  Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
  PCI: hv: Fix synchronization between channel callback and
    hv_compose_msi_msg()

 drivers/hv/channel.c                | 116 +++++++++++++++++++++-------
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/hv/ring_buffer.c            |  14 +++-
 drivers/pci/controller/pci-hyperv.c |  68 ++++++++++++----
 include/linux/hyperv.h              |  27 +++++++
 5 files changed, 179 insertions(+), 48 deletions(-)

-- 
2.25.1

