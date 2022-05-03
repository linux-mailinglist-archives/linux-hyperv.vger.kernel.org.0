Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB885182F6
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiECLDV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiECLDU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 07:03:20 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58772B95;
        Tue,  3 May 2022 03:59:48 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id d5so22839313wrb.6;
        Tue, 03 May 2022 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FS/1ZW5mhYBaurYyULbkqpkXIFIT+G6Pb25VduaI8B0=;
        b=Cm6O4smTWK6WJLJF1UUVti+krTyWjBFf3bmn4B1NiwXGtQjPsHrBbaTLZQ0zo1kc/i
         GlgmuAdiPAab6S9mflKJLiwcsRFalM23rqptZ4DQjvLshOO4Aopa/AmJIVmmW1wn1s8C
         Tz71WSqHVXu4/Ktsxyut/Bg5ot3tX6Gvs9f4K6TnlvVWOot7AlNUi1+IfledqYplK6Yw
         jcUPzx/8hcrlcUcJtrfRONXX2k2Br6Rm3TKPoM+5ZUGU2GdK6NGYT9SJrcctaVy+sRUs
         x59K8PcZ5Pw2KfSUCxBdGWOsAdaNc/hyy7jQq/IDxD+fsfSCh/8SsOGyAL6dbPPwEj+t
         u8QQ==
X-Gm-Message-State: AOAM532bcThHOz1YhZl89mio8k9iULTnVATNE7G3jsiLs2Dutn8wGif5
        t5sJAV/iPGGADnOz+pM9N38=
X-Google-Smtp-Source: ABdhPJz1r0WdWT86Ff3hcmvZrz6jS3SJ8tbvQJeUVMD+me3yv78BAOMD25Qp9V6xanTVf/EK7+4BRw==
X-Received: by 2002:adf:f14a:0:b0:20a:d7bd:a5d4 with SMTP id y10-20020adff14a000000b0020ad7bda5d4mr12103294wro.390.1651575586817;
        Tue, 03 May 2022 03:59:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d15-20020adf9b8f000000b0020c5253d8c8sm8829524wrc.20.2022.05.03.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:59:46 -0700 (PDT)
Date:   Tue, 3 May 2022 10:59:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, kw@linux.com,
        helgaas@kernel.org, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com, jakeo@microsoft.com
Subject: Re: [PATCH v2] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM
 boot time
Message-ID: <20220503105944.nezlg26jfxv4fqha@liuwe-devbox-debian-v2>
References: <20220502074255.16901-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502074255.16901-1-decui@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 02, 2022 at 12:42:55AM -0700, Dexuan Cui wrote:
> Currently when the pci-hyperv driver finishes probing and initializing the
> PCI device, it sets the PCI_COMMAND_MEMORY bit; later when the PCI device
> is registered to the core PCI subsystem, the core PCI driver's BAR detection
> and initialization code toggles the bit multiple times, and each toggling of
> the bit causes the hypervisor to unmap/map the virtual BARs from/to the
> physical BARs, which can be slow if the BAR sizes are huge, e.g., a Linux VM
> with 14 GPU devices has to spend more than 3 minutes on BAR detection and
> initialization, causing a long boot time.
> 
> Reduce the boot time by not setting the PCI_COMMAND_MEMORY bit when we
> register the PCI device (there is no need to have it set in the first place).
> The bit stays off till the PCI device driver calls pci_enable_device().
> With this change, the boot time of such a 14-GPU VM is reduced by almost
> 3 minutes.
> 
> Link: https://lore.kernel.org/lkml/20220419220007.26550-1-decui@microsoft.com/
> Tested-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jake Oshins <jakeo@microsoft.com>

Applied to hyperv-next. Thanks.
