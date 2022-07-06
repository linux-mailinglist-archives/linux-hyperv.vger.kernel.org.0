Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF356916E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGFSMT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiGFSMS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:12:18 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D5A2980A;
        Wed,  6 Jul 2022 11:12:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id a5so8477482wrx.12;
        Wed, 06 Jul 2022 11:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5lVZBdH+VjmOv7FmgoklMRu15YQcElApUVo2YVt++0=;
        b=otMuRHN172XZeqyhVFgwkE27iwSAidfqMrUonZZRp4ZJV981mKXyjt1P2OeH6/emTq
         6HwTy/6hJpabZUAi7r0dzPakYyBmZZk90Ft3SHg7FW85cKSlm7aQOcWMuVdUsXmESzxZ
         7ZDoElT9inUCz68Vpy0xoWELT/zfftUPXWs+8R7/kW/d2dWF/bUZ9P/xFCX1Lw4QZZmo
         bCusZWvBShjkqZmo0H6hMOvzgATa8ucnKkVP2ouZYlXkJPV2Kzixy3f5fRHF1Ps1plJV
         QjMj0wuiuh1wR1yMluuEOOOGMOC0CQxf89e3TUSvYrwKhwCI2ogqJGz7vF6dg+a4nmvW
         XsoA==
X-Gm-Message-State: AJIora+X9r0Oz/QHHY0XVlK4pS2m6bpFcaB1W0j0z93Oyv0tmZXtWF4Y
        pWLNevnBi15ZGB9WgvBTTOfOvz9BmY4=
X-Google-Smtp-Source: AGRyM1vT7YJXzo3GS2N25x4F2ofy2jQWon0j79AeOBImfzZaECW5hYXin+Fg10Ycf6KTS8CflYRwWg==
X-Received: by 2002:adf:d206:0:b0:21d:6434:a158 with SMTP id j6-20020adfd206000000b0021d6434a158mr21449469wrh.37.1657131135743;
        Wed, 06 Jul 2022 11:12:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id az42-20020a05600c602a00b003a1a02c6d7bsm11576777wmb.35.2022.07.06.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:12:15 -0700 (PDT)
Date:   Wed, 6 Jul 2022 18:12:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
Message-ID: <20220706181207.45jcurksoblsrerq@liuwe-devbox-debian-v2>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 05, 2022 at 08:43:39AM -0700, Michael Kelley wrote:
> This documentation is a high level overview to explain the basics
> of Linux running as a guest on Hyper-V. The intent is to document
> the forest, not the trees. The Hyper-V Top Level Functional Spec
> provides conceptual material and API details for the core Hyper-V
> hypervisor, and this documentation provides additional info on
> how that functionality is applied to Linux. Also, there's no
> public documentation on VMbus or the VMbus synthetic devices, so
> this documentation helps fill that gap at a conceptual level. This
> documentation is not API-level documentation, which can be seen
> in the code and associated comments.
> 
> More topics will be added in future patches, including:
> 
> * Miscellaneous synthetic devices like KVP, timesync, VSS, etc.

There is an UIO driver for Hyper-V. I think that falls under this
category. Not sure if that's on your radar to cover?

Thanks,
Wei.
