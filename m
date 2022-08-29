Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E05A52E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Aug 2022 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiH2RPQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Aug 2022 13:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiH2RPP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Aug 2022 13:15:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FEBE16;
        Mon, 29 Aug 2022 10:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB865B80B8C;
        Mon, 29 Aug 2022 17:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D368C433C1;
        Mon, 29 Aug 2022 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661793310;
        bh=T8yf6DaEI9h1ttbcLiN25zYNkViUziozFlJTNfTaQ84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F/1aeNLwEv4qAotml3dc5zTQUgO8luoYVvNXF1SqiIbnqwTjWmfcK916XL88wtzxV
         CkA68pVWNi2J2NCnuMCpJDxJW1cSrbybFXqRmZRU6+OEb/WGNK3PNKsVqCasyHehRN
         b8HRY5OM5p0m1G2IN5ye0ZBuqNJjLDAR9tvkKqQju9J8qhfoN46LJ8L1Th+9r+DSPD
         7Z+vhX3gf+pytuNwomMGD0Hlkk5E+98MojqTSW0mxSQuqexAwidyvr3Nj/UUy3UpK/
         36a6Pe6oT9OqI6gMEJWbdWurDGhU5OAcwdSKn901h4id6ZSKRB/CXhjqS5YNxPpOAg
         yV8L9pSj3QQRw==
Date:   Mon, 29 Aug 2022 12:15:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 1/3] PCI: Move
 PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to pci_ids.h
Message-ID: <20220829171508.GA8481@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827130345.1320254-2-vkuznets@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 27, 2022 at 03:03:43PM +0200, Vitaly Kuznetsov wrote:
> There are already three places in kernel which define PCI_VENDOR_ID_MICROSOFT
> and two for PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these
> from core Vmbus code. Move the defines where they belong.

It's a minor annoyance that the above is 81 characters long when "git
log" adds its 4-character indent, so it wraps in a default terminal.

It'd be nice if we could settle on a conventional spelling of "Vmbus",
too.  "Vmbus" looks to be in the minority:

  $ git grep Vmbus | wc -l; git grep VMbus | wc -l; git grep VMBus | wc -l
  4
  82
  62

FWIW, one published microsoft.com doc uses "VMBus":
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/hyper-v-architecture
