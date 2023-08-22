Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863EB78374F
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 03:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjHVBUa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Aug 2023 21:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjHVBU3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Aug 2023 21:20:29 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF413E;
        Mon, 21 Aug 2023 18:20:27 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bdcb800594so23724655ad.1;
        Mon, 21 Aug 2023 18:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692667227; x=1693272027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx19SHLrjyXmFOjumTb8waES21j0hv9NNxPBokSYyns=;
        b=DVTCaXRg7RZyW2ozltK9cwv33dm160TBYlVQu0FpY637NwFSRyGGJsfdvjcsEf90YZ
         O2lMIxVVLNIW3xXrthuP6UuOXy3nKvNRo7ZSwweYLvPi6szIo6rCZZdpGKZNl4pBnksL
         9YLbRYWrnzcWuqG9QO+hadgFSJmNthXjJvpqSwkufnk0q3ki7FHauGi+sn2yj/YOy6aE
         xRmrs445FznJCpSCf9ibpvtbF95+R8v9XgNq8KkbEYhhiKtH0I0aFWCM6ts+BqWdnREF
         6OGdR6TUpWpNBpJuCuMpocnJxpcZyChvVKQTsbvTJ+7QAKcFI6TghoMrjZZfztYDQW3P
         9YsA==
X-Gm-Message-State: AOJu0YzmCLBrHNbmaaAn43D/IiVLvf1DOLsiHyH1zBjtrSu6q/4KIkkQ
        zZuSaq9YqHuQT86AJE65SWY=
X-Google-Smtp-Source: AGHT+IFfMP1opnx1mJJ9atmYR0+4DNNCt96oHCUsPddzBUg50it++Pvisq5wT9GHsDTY1NYqCdJ7TA==
X-Received: by 2002:a17:902:d4c3:b0:1bb:f82f:fb93 with SMTP id o3-20020a170902d4c300b001bbf82ffb93mr6985750plg.2.1692667226770;
        Mon, 21 Aug 2023 18:20:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902b28200b001b81a97860asm7644332plr.27.2023.08.21.18.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:20:26 -0700 (PDT)
Date:   Tue, 22 Aug 2023 01:20:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH v2] hv: hyperv.h: Replace one-element array with
 flexible-array member
Message-ID: <ZOQNRkdqwB1tJW5m@liuwe-devbox-debian-v2>
References: <1692160478-18469-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688FA593FF45C7BCCD74BB9D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688FA593FF45C7BCCD74BB9D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 16, 2023 at 04:52:58AM +0000, Michael Kelley (LINUX) wrote:
 > --
> > 2.34.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next, thanks!
