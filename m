Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3850E4CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiDYPz2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiDYPz1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 11:55:27 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479773A5CB;
        Mon, 25 Apr 2022 08:52:23 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d5so6301042wrb.6;
        Mon, 25 Apr 2022 08:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLRphoqRJd15hvh2Z7yc2Bb11NgNdOfgkxNcVBPL67c=;
        b=ue0WHmqoOho8mfqxykY6L7vl8CrOwgPRiGpG7tP+WByPJNDzs4+l3QOrCzKSGL8py0
         cUQ0xOjPz3cWisBit0NREWLjN8oJAywESD2sVWqNdSY7nNG1QggO/G2oDmRqEfZZnTSj
         imPEYtrRNBMIGRYhVQ6JfXKQ64B57A2m4Dl5P5rqNLofCLpAMjAsTvgXYi1iYHiJI80H
         OlRMcA3edQFuiihrdcHZ+tjIq++A8uxbEjYqbBevQ0j5jNrmtufbQCFkiIlnrpvZsf7a
         TBFcP/lCZvpn5/G9HGQ+NHJHJfZd+eiFjhnEN3V9RoFZX277VO1i8EkZQS3YYNI8fV94
         qnuQ==
X-Gm-Message-State: AOAM531gA2UUOPH7qMz98yK6bWj2o6XiNd8727Lz3q6G1kg/ZY25SckB
        mKZIvSwYK7P3jg4FCb7afiQ=
X-Google-Smtp-Source: ABdhPJy8uGQ5DDFUKI/24JBG+XBXwvpKHIadLeW7ZJ3kidmp4zmL+5gTu5Lkqdpk3+fV8Cu2JDse4A==
X-Received: by 2002:adf:df05:0:b0:20a:c402:6811 with SMTP id y5-20020adfdf05000000b0020ac4026811mr15055204wrl.275.1650901941851;
        Mon, 25 Apr 2022 08:52:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b0038ebb6884d8sm10814340wmm.0.2022.04.25.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:52:21 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:52:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: hv: VMbus requestor and related fixes
Message-ID: <20220425155220.xioklqm5sxv6ig26@liuwe-devbox-debian-v2>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419122325.10078-1-parri.andrea@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 19, 2022 at 02:23:19PM +0200, Andrea Parri (Microsoft) wrote:
[...]
> Andrea Parri (Microsoft) (6):
>   Drivers: hv: vmbus: Fix handling of messages with transaction ID of
>     zero
>   PCI: hv: Use vmbus_requestor to generate transaction IDs for VMbus
>     hardening
>   Drivers: hv: vmbus: Introduce vmbus_sendpacket_getid()
>   Drivers: hv: vmbus: Introduce vmbus_request_addr_match()
>   Drivers: hv: vmbus: Introduce {lock,unlock}_requestor()
>   PCI: hv: Fix synchronization between channel callback and
>     hv_compose_msi_msg()
> 

Applied to hyperv-next. Thanks.
