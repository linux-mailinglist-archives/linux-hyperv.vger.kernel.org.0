Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA795932A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Aug 2022 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiHOP6n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiHOP6l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 11:58:41 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162B1A078;
        Mon, 15 Aug 2022 08:58:40 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bu15so1044808wrb.7;
        Mon, 15 Aug 2022 08:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BuR5PayzZgtbh5z6Y/hAM9ja1VULS5THvEibdswTLbU=;
        b=OcBlw6FdGN8jC69mFgOnYFHcG14eGl8m8qKMpxs3CSGKWpOJr67WJV6HyXZe0t2Y1b
         trILp3mOups9J7WSsXpDXLAIoSWrRNPK8aROaqcQD/nh7iQNGGJxQwuFn6IVTrcnuKCU
         kycWOt45KuFoMrTmKhQKzo58WLhFpCNsLrFE4F8rwqNlI2fNr/o+5BFMiAcsGbUCnBI/
         pn00GWcQ3WR/d2Cfa5jTLdeA8UijuK8MtLKprcqZxEt3TtRYfdOKNKileTD22hsAxYMc
         P+spPZ6pVAX30cXvEJfimRfuwCa/tuVws2GcZbRaXWSOboMk7oYhppHNMa1QslhVjaV5
         P4yA==
X-Gm-Message-State: ACgBeo1WXn1P2+dowuGHQyzc/gx7BP4QdI33b2XkiS+fIhlyT7GGMSFZ
        nKQL0oTEjZa6ecm3tqegmvw=
X-Google-Smtp-Source: AA6agR6VrcSgeo1RZiibLkbL4Cdj6cY8J+EBocPIZDYEtveeZ2ZGN4yXVrPQA0uhLLjI1zyP6sT1dw==
X-Received: by 2002:a05:6000:1562:b0:222:c3bb:560c with SMTP id 2-20020a056000156200b00222c3bb560cmr9152762wrz.584.1660579119201;
        Mon, 15 Aug 2022 08:58:39 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm271084wmc.45.2022.08.15.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:58:38 -0700 (PDT)
Date:   Mon, 15 Aug 2022 15:58:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: hv: Fix comment typo
Message-ID: <20220815155837.dkdh7nz2pi4qlyiy@liuwe-devbox-debian-v2>
References: <20220811133433.10175-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811133433.10175-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 11, 2022 at 09:34:33PM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I changed the subject and commit message a bit and applied this to
hyperv-fixes.

Thanks,
Wei.
