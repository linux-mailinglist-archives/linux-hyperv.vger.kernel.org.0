Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D34F6431
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Apr 2022 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiDFPyb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Apr 2022 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiDFPyJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Apr 2022 11:54:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83EF4E83C7;
        Wed,  6 Apr 2022 06:16:14 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id b19so3130498wrh.11;
        Wed, 06 Apr 2022 06:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XackL+WLlGuGuj2h9oRi+3NQ/yFqIkV4Wc+UFjwvBBc=;
        b=uZDgSnLO8jXoGP7lLvS4f7p77ZcGpnSQqhiJViys7Z/oQnn8p0uZ/zQJg2Cb0ua1+1
         BfUu7EdqSZMG9pRYPE9AUSLV4IdTDcHuHFUpQpSFggnd6Q/2bZBuQ51m0cH+Ycp5c7Oy
         F3hcVqc8GG92ew5er7RUD8UIkNok1gX/dEt3wA59Ht7GBhHFLotDzuhYr91e7HAnGsdr
         u7fYfjPdbCw+2XDnlGxIjCBV732k2w74R5OxgVCfOVz2352+uY8CvwGyp95hk2FrgF00
         uezWfpcPt4xjuJr2zZEANA8DM/x1VKZRJElYrNFfxsuoXeZtGF7eYAfWPlkfcYAgFKOY
         8iQg==
X-Gm-Message-State: AOAM531vi3PK6hq++oGJjs0NBxTTCFH15zdLsT2s+cSB6lH3+kil1XrP
        oDwHEMSqkhj6b4HjuLobqj4=
X-Google-Smtp-Source: ABdhPJzfTh43mvodajOKzJRynF7Wkr53y8/yq1kEUtt9kVH3x2nUdU43TIQod50mWPGT8qCNKjNS/g==
X-Received: by 2002:a5d:5886:0:b0:206:db4:f12b with SMTP id n6-20020a5d5886000000b002060db4f12bmr6856930wrf.455.1649250973190;
        Wed, 06 Apr 2022 06:16:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm14679587wrr.58.2022.04.06.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:16:12 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:16:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Drivers: hv: balloon: Temporary fixes for ARM64
Message-ID: <20220406131610.7qbzlhqxkbxktrqs@liuwe-devbox-debian-v2>
References: <20220325023212.1570049-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325023212.1570049-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 25, 2022 at 10:32:10AM +0800, Boqun Feng wrote:
> v1: https://lore.kernel.org/lkml/20220223131548.2234326-1-boqun.feng@gmail.com/
> Boqun Feng (2):
>   Drivers: hv: balloon: Support status report for larger page sizes
>   Drivers: hv: balloon: Disable balloon and hot-add accordingly
> 

Applied to hyperv-fixes. Thanks!
