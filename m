Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C84AC816
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiBGSAl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 13:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbiBGRzA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Feb 2022 12:55:00 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8DC0401DC;
        Mon,  7 Feb 2022 09:54:59 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id u23so2481469wru.6;
        Mon, 07 Feb 2022 09:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MgMZtoimtxO2XWZhw1+iy1PmNLRHGLJ65lgwWFNnd+Q=;
        b=4VzzEql7S1l92TGmwkbuxjVszJXPRFD0c4UnMj+53UNOqntXrn8KmKDW9OXsuAq6vP
         ijgEFJy0FWuNXd84GGbyZOCA8F+T7FJw+JnVs/psuW7bB4akAoed/rqNf9Qnt/MASj3+
         TYpEWFa406O9PMhrgsglET701bqWphm3BKqIORO5u4/yHWLFCad8GwCnMToQrtR2439C
         NHTty2mOeVEUssntGWW4v09+lDAY87IFSTlgREjkrF2L0zWrSh4ceIVQh7fAx4yjgy/W
         mFfcqLBqTD/vp4Alq+wJ5Xdpo2XSVE2ID9rjpkxHYzS/9pTpd+CE/mQeFbuitRVbB/gW
         Wk5w==
X-Gm-Message-State: AOAM530OvbysyFWKRPnZT8JdxsJ8zc0MVspl7fNlsIY/4QzdETczQs07
        dQAMoEeLvVxeDQ+pUlTC4YY=
X-Google-Smtp-Source: ABdhPJwqsSu5ejMKrQVUvMG1YdMFq6h2SGjkMEEsKCJSpOvIu+S6aF6URXu3esyaPcELlXwxm4lZxg==
X-Received: by 2002:adf:8010:: with SMTP id 16mr450436wrk.708.1644256497887;
        Mon, 07 Feb 2022 09:54:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f13sm13358wmq.29.2022.02.07.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:54:57 -0800 (PST)
Date:   Mon, 7 Feb 2022 17:54:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Juan Vazquez <juvazq@linux.microsoft.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, decui@microsoft.com,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, sthemmin@microsoft.com,
        wei.liu@kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Fix memory leak in
 vmbus_add_channel_kobj
Message-ID: <20220207175455.ftlpbzzuq5wqducc@liuwe-devbox-debian-v2>
References: <20220128215604.xuqdpnnn4yjqfaoy@surface>
 <20220203173008.43480-1-linmq006@gmail.com>
 <20220206145556.72obb2qxbsktw3sc@surface>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220206145556.72obb2qxbsktw3sc@surface>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 06, 2022 at 06:55:56AM -0800, Juan Vazquez wrote:
> On Fri, Feb 04, 2022 at 01:30:08AM +0800, Miaoqian Lin wrote:
> > kobject_init_and_add() takes reference even when it fails.
> > According to the doc of kobject_init_and_add()：
> > 
> >    If this function returns an error, kobject_put() must be called to
> >    properly clean up the memory associated with the object.
> > 
> > Fix memory leak by calling kobject_put().
> > 
> > Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Changes in v2:
> > - Add cleanup when sysfs_create_group() fails
> > 
> > kobject_uevent() is used for notifying userspace by sending an uevent,
> > I don't think we need to do error handling for it.
> 
> Thanks for the patch. It looks good to me.
> 
> Reviewed-by: Juan Vazquez <juvazq@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.
