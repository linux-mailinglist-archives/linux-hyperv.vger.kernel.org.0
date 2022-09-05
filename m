Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B55AD7F1
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIEQ7G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiIEQ7F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 12:59:05 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D565A826;
        Mon,  5 Sep 2022 09:59:04 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k17so5546264wmr.2;
        Mon, 05 Sep 2022 09:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CgKrfbywM986JsD6pvuwk2YZa7EEUAgSQzvLV0whDF0=;
        b=aICaQe8kwx6kZiXW6XDaut9IZyzL56faLjc2t1gKqqRzaN10mv+kssXSCtAuNLunlE
         8kH8pZvFDFxZkjLp7HRxXVvCVwS+Mrky0ufSDcDejoo2XEGWQq8TN0cZa82694oaaN3B
         GeOf1t8ru/q6TpMq4oGmk8Wd627s0jRxqs2mHnFJ5lvMJjMfMzlNFBTIO85zOddkcb3L
         o0m9NOwrB9WEmLU3uDW6/+twOONFdO0LgnnTROtw5IzrS12cggXQAfzCBzI583tUkWU+
         7YNooyzcwCOMFDE4AQ+uiAmtKH8Mixu6BWMjRsZuwGIMBIw1MzydxVFDCAIzDuBc1ncb
         sZtw==
X-Gm-Message-State: ACgBeo3xuLbbSQGq7pXsP1QeVskFdt5crdvH6I5gVwnruEAUjZCjZfak
        qK00XW4q8On6Y9zs73vb9zFgjvbY4hg=
X-Google-Smtp-Source: AA6agR6ofDrHdFk38CYHi4v6c7fb7YDmAICkMrs4KirhPNkUNgsIiH8ue/0Wsjlc5GjN8lLBkzLnaQ==
X-Received: by 2002:a05:600c:2c47:b0:3a6:4623:4ccf with SMTP id r7-20020a05600c2c4700b003a646234ccfmr11917348wmg.85.1662397142900;
        Mon, 05 Sep 2022 09:59:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm9439397wrq.80.2022.09.05.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:59:02 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:58:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 1/3] PCI: Move
 PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to pci_ids.h
Message-ID: <20220905165858.oxmaxpur44aq6t2q@liuwe-devbox-debian-v2>
References: <20220829171508.GA8481@bhelgaas>
 <875yiauqz9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yiauqz9.fsf@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 30, 2022 at 09:31:54AM +0200, Vitaly Kuznetsov wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Sat, Aug 27, 2022 at 03:03:43PM +0200, Vitaly Kuznetsov wrote:
> >> There are already three places in kernel which define PCI_VENDOR_ID_MICROSOFT
> >> and two for PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these
> >> from core Vmbus code. Move the defines where they belong.
> >
> > It's a minor annoyance that the above is 81 characters long when "git
> > log" adds its 4-character indent, so it wraps in a default terminal.
> >
> > It'd be nice if we could settle on a conventional spelling of "Vmbus",
> > too.  "Vmbus" looks to be in the minority:
> >
> >   $ git grep Vmbus | wc -l; git grep VMbus | wc -l; git grep VMBus | wc -l
> >   4
> >   82
> >   62
> >
> > FWIW, one published microsoft.com doc uses "VMBus":
> > https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/hyper-v-architecture
> 
> Makes sense,
> 
> Wei,
> 
> assuming there are no other concerns about these patches, would you be
> able to tweak the commit message here when queueing or would you like me
> to send v4 instead? 

I can do the tweaking. Don't bother sending v4 if there is no other
concern.

Thanks,
Wei.

> 
> Thanks!
> 
> -- 
> Vitaly
> 
