Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719C85AD80A
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIERF2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiIERDL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 13:03:11 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD861DA1;
        Mon,  5 Sep 2022 10:03:09 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id e20so12081436wri.13;
        Mon, 05 Sep 2022 10:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PhLq7Jg7THme51MufQlUAx9Xm5cp54HX1BkW+U1Xyec=;
        b=jnmHPK1DysJtmvm6Lu7ax829S+qGZZYTxmhmaXuVMcgZ1dihsioec6AlQRMIOE3UlN
         loiqY4FYNZjbFTWTHFg45jBKamuPhpTFVn/P9ZbKE8jKUpox6P5KrOTv46VZUr/nCO6U
         tbj5PNOfDC/lrpZNFJqlFqJY5Qmza1jAzy1pPvB0al1HQNdaL+tPzFmEigfMxAYdlCHM
         7kbUGPKcJ5+//AjXco/WpHSZZK0kxQZmXHP3qf7M61UI2rbw64UFmxebEgHtQIUj4lsb
         Rw4isMTf4EYkBBWmqdP5I+o1PCY+3OCsm9dmv+tEHJvRaTIAD6P5F87C993CGCwAARGr
         htYg==
X-Gm-Message-State: ACgBeo0saqmeY8mit1Pwbh+Jl2FtO6xNQn44XaKfRbzgA5kFowhiFRv4
        m/oKeFSA8DM9j6p/oe16oCSUIaXMCac=
X-Google-Smtp-Source: AA6agR5S0iuyaUjAWm0IOMULo3XnS5JeNxiF0q+loQpjcjwG2/ubYIc61Vw83rxLgBzCv00NLItm/A==
X-Received: by 2002:a5d:424a:0:b0:228:811f:c1a2 with SMTP id s10-20020a5d424a000000b00228811fc1a2mr3526709wrr.262.1662397387859;
        Mon, 05 Sep 2022 10:03:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p28-20020a05600c1d9c00b003a5b788993csm11733635wms.42.2022.09.05.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:03:07 -0700 (PDT)
Date:   Mon, 5 Sep 2022 17:03:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
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
Subject: Re: [PATCH v3 0/3] Drivers: hv: Avoid allocating MMIO from
 framebuffer region for other passed through PCI devices
Message-ID: <20220905170303.bzjcovvcdg7ou3k4@liuwe-devbox-debian-v2>
References: <20220827130345.1320254-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827130345.1320254-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Aug 27, 2022 at 03:03:42PM +0200, Vitaly Kuznetsov wrote:
[...]
> Changes since v2re (PATCH3).
> 
> Vitaly Kuznetsov (3):
>   PCI: Move PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO
>     definitions to pci_ids.h
>   Drivers: hv: Always reserve framebuffer region for Gen1 VMs
>   Drivers: hv: Never allocate anything besides framebuffer from
>     framebuffer memory region

Series applied to hyperv-fixes. Thanks.
> 
