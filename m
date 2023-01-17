Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1366DBDE
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjAQLHn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjAQLHL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 06:07:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79332E46
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 03:06:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r30so5757492wrr.10
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 03:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xXHf/h6w5QScTbFOUIi2cw8hRpsXupQGOfb76sO+Fs=;
        b=UBj7M9iBR4KTkYR64iMwWjmlsvekhNm0hD+SDSJgV8p/Ug74DU8RCF8tPkYfPOID5F
         w9cWWwm7TR5qiZMayMAz9j6k7E0AiorLsNVvFZksE3B2bfYyTu8BMa6ZWhwf6OW6/KdN
         XRkF8jX1A5QXq47HdQombQHDRsvXqJnCaQW9hmXD5ie9IF7rIFmB4g7AfXlNSH7S6VIf
         WCioP8Rdxr6IVlKnXPdaVk6GtWnGEUznVEAi2xbY3cKRK+idBGEwgMUpDlG605FbOLvB
         NCIN99GK7noVALxHatk/FpqVLF/AAbdLhCTfe/FzFFgtrkzNE3ug2Xg4QHNwpSPOctqq
         9f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xXHf/h6w5QScTbFOUIi2cw8hRpsXupQGOfb76sO+Fs=;
        b=j7e8phVtFfNYVgNWcMY0DtP2e9JjUEL97CBCkj3oMKg7+iAngCgAgFHdvUzqsZnjtk
         8vu5quIwCgjAfOspm+x2U9Nhn4lCuPQhd+FQbux+ihUMimNGAt1gm2d1jNjX6W9cwYJR
         BVr0skWrVW+LJpeLztHy71ijPfZ7dGEgmt7Lx3Ky5Es+fhYBd9+xSvODhSQ1vjuRuBbv
         Zol3YRSGieKdWAUpYL82O579kMMVLVNMwzqO7dXZWt4eq7U3WMb5rDeplMJc3bZEFV7C
         efsrvqTekgTtD8/ogS/gAsNn2yZjIpIfiPnU+OeQBHMHYsvSiDix0oYLpnoYNHeX3is2
         foOw==
X-Gm-Message-State: AFqh2kpAw/lV4YKDUbSkLpYGETOL8HAJ3vkllPweibQ6FBTAPiuiMKnD
        vK0fHFwx38MzaPAXQdJ2PTE=
X-Google-Smtp-Source: AMrXdXv07yzVj58K0EuKidtmYQhLyCyEJrsqEcYCMq+//WaBtQzQ2uwxn0cqI4TIg0xCZAnS+ptfjQ==
X-Received: by 2002:a5d:6b8b:0:b0:2be:1d47:b0f2 with SMTP id n11-20020a5d6b8b000000b002be1d47b0f2mr2035816wrx.20.1673953600522;
        Tue, 17 Jan 2023 03:06:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm10576337wrr.20.2023.01.17.03.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:06:40 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:06:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     Tianyu.Lan@microsoft.com, linux-hyperv@vger.kernel.org
Subject: Re: [bug report] x86/hyperv: Add Write/Read MSR registers via ghcb
 page
Message-ID: <Y8aBPTJN9WvLjM1M@kadam>
References: <Y8UM59rdoCD0D6V2@kili>
 <ac8ee542-1f60-fa66-99f5-d716cd2dff33@linux.microsoft.com>
 <Y8Z/ycimio0p1cQP@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Z/ycimio0p1cQP@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 17, 2023 at 02:00:25PM +0300, Dan Carpenter wrote:
> On Tue, Jan 17, 2023 at 04:26:13PM +0530, Jinank Jain wrote:
> > Does making 0 as the default value makes sense?
> > 
> 
> That would silence the warning, and most distros are going to enable
> the config to zero it out anyway so it has no impact on runtime.

The config to zero out stack variables. CONFIG_INIT_STACK_ALL_ZERO.

regards,
dan carpenter

