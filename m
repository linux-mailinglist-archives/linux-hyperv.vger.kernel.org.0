Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAF5212E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiEJK7M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 May 2022 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiEJK6k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 May 2022 06:58:40 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B327532CC;
        Tue, 10 May 2022 03:52:09 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id bg25so9918733wmb.4;
        Tue, 10 May 2022 03:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6VCNHyiYuDbxgsrbiSQPkXEisIh4ErIQF+ClwhqALo=;
        b=FSYwuDVlKH9wW4QkdUVsZ0vCRN5OqJ05OKq6qiTlw5fEITVE7vaWAQ5Zd7xSQ7ib6t
         6ZsM/u1M8QUd5t6KIv7ENt6euKB6LNn3W1XU0H8uOPUNr2W65O/YZwVhoUrKlFU4jfN7
         2Ve2hLh7SSemKUl1OZj6ltgysDlLSsjz6HXp863arbyznGxD4jNthM9+B5cGruzQ7met
         00I2PvXeymbOPe497l+uO+8jQDlzBjbcJK7gyg+/qNLyBgHv4AcJ3o6P3vqc49yly/aR
         bHQ6Ij+ZjNb9phSRWOW9fhPN84XS2mi4yYQSpuPriiuIaNtJmac+hbvisnXAISCWtzW4
         SAiw==
X-Gm-Message-State: AOAM533vH6VAlcHz6lEmoNXwmQro8TZM7XPAkJmv0QxxGDhmpQO/q4Vl
        bzvk1RvocT1BGhIfj2vlu5c=
X-Google-Smtp-Source: ABdhPJwuWwvFLwODMaM2OHf1KBzQlzSMCPivJS8OGOT5GoBODuzez3+oLb5dA2oywcHIXj7AVTOICQ==
X-Received: by 2002:a05:600c:a08:b0:392:a561:9542 with SMTP id z8-20020a05600c0a0800b00392a5619542mr20338302wmp.62.1652179927424;
        Tue, 10 May 2022 03:52:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003942a244ee2sm2304037wmm.39.2022.05.10.03.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:52:06 -0700 (PDT)
Date:   Tue, 10 May 2022 10:52:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
 compose_msi_msg()
Message-ID: <20220510105204.t57u35y5kicniefs@liuwe-devbox-debian-v2>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <1652132902-27109-2-git-send-email-quic_jhugo@quicinc.com>
 <BYAPR21MB1270A579B909B31FA271FC08BFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
 <8372be1c-5f7d-3a0e-38fb-787b9d38fcd9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8372be1c-5f7d-3a0e-38fb-787b9d38fcd9@quicinc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 09, 2022 at 08:29:19PM -0600, Jeffrey Hugo wrote:
> On 5/9/2022 5:13 PM, Dexuan Cui wrote:
> > > From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Sent: Monday, May 9, 2022 2:48 PM
> > > Subject: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
> > 
> > s/ITRE/IRTE. I suppose Wei can help fix this without a v2 :-)
> 
> Thanks for the review.
> 
> I have no problem sending out a V2.  Especially since you pointed out my
> mistakes on both patches.  I'll wait a little bit for any additional
> feedback, and then send out a V2.

Yes please send out v2.

Thanks,
Wei.
