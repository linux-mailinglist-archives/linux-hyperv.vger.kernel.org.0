Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA47966DF2B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAQNqN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAQNpy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 08:45:54 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFAB3B645;
        Tue, 17 Jan 2023 05:45:10 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so21013333wma.1;
        Tue, 17 Jan 2023 05:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyBnNPnDUwves3WFQbNhme3EQHSXwTRHL2ezHpfEKZc=;
        b=khD7vYqmf4zQEMaRV2CftJ0Dnt/zQ8EOiSAWNXXm4jvPGO1qoh8eKnrV5uNWlxyqB5
         xE3s+ReqYrbEx48eVRLQkWXoXJsN+JRBIr9YGjN6hlUR0WhJ0dqs97ASqZoY0xMPBkBL
         7VRhthQB+QFXmBmiC0xqrGG4oJjaa97PQSCGVxk8YccoQuT1pbUHWD7vkmSttIAdWd7j
         ArjKoMqDG337HDehIXju6QPeFKcZfkV6ts23HdCdiNIGRzKVwDRL1ihaT7Rc7BKU9S/x
         0P8iow33LSyy24IRhRiwcDyorWqW6xnb1GZhkO2B2aSP/nkOEHuGvFYYYvPlHMOYGXBu
         2ptA==
X-Gm-Message-State: AFqh2kqhOi9i9lKBGb3v47W7W9/c9BKRVTPvHA0UPPmVRqAPgy0J4wJF
        MnWHu+4fQlzE0W9+vqPZqeQ=
X-Google-Smtp-Source: AMrXdXsZ3l7oAhGyRFZfiNngZZyFb/TNsE+JwKnbtWb4vkoOQEQco5EceFtorXYPYtY3QDteBR6NSg==
X-Received: by 2002:a05:600c:4fc9:b0:3d9:f769:2115 with SMTP id o9-20020a05600c4fc900b003d9f7692115mr3129597wmq.26.1673963108504;
        Tue, 17 Jan 2023 05:45:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm55222683wmq.18.2023.01.17.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:45:08 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:45:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: Make remove callback of hyperv driver
 void returned
Message-ID: <Y8amYlEJPzTSw9YY@liuwe-devbox-debian-v2>
References: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323A93C55526E4DF239D3ACCAFA9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 05, 2023 at 10:51:23PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> As such, change the remove function for Hyper-V VMBus based
> drivers to return void.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Applied to hyperv-next. Thanks.

Wei.
