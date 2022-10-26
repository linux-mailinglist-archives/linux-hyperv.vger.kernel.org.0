Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2BE60E461
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Oct 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiJZPXz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiJZPXy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 11:23:54 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF19AC3A;
        Wed, 26 Oct 2022 08:23:53 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id v1so26922541wrt.11;
        Wed, 26 Oct 2022 08:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td8R5Tq1ObHQ5/RHZmafzB54dGk/3AydwWuNx9ZCsTE=;
        b=oBk+uKg28SKACeIw3CXvf9YEqonXA45QZIum21GFJx/Fm57jbqr5EaQ16CeNcUcAfQ
         66wpcE1zN/nBC+HRm+tl31oGV4vXbpwLTdNR5FO5uV46+MLdI+cfgqlYdVwxz2UfBC3L
         +4Hiftdt8lSlQa+4oJnke3yvSxXrISD7ZMYJNQUJSwQTTJev+rg2tPyHbsjvtw1/uh6p
         cUU8HKHa5O8VzMkuqTCzyvVcvRk8XPzSjfzF/VKcXlg2SppY6OiKlZ7HSzJK6PtDIheV
         y+B/zKNCXus7avWziUY/PjBI4VhsbOSZffvrbc0LOQcqllaI/b8+osDHTHsSB5bJqp72
         9IKA==
X-Gm-Message-State: ACrzQf0cAcrAkRwrxmMHm8pvB6DS/9iOE4dt0Q6QN8P/YOi7b85roFYu
        DWHAfP2tcSXMnKOYaQhI5N4=
X-Google-Smtp-Source: AMsMyM5SF+DuY/1Sbn8cDtGxXSFKeKodfvys7tXcHL883PjMldf73hByzzZMU9VSX83Dhr/x6qGc/Q==
X-Received: by 2002:a05:6000:1817:b0:236:77f0:ef60 with SMTP id m23-20020a056000181700b0023677f0ef60mr9213108wrh.343.1666797831941;
        Wed, 26 Oct 2022 08:23:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d6b44000000b0023677081f3asm5706068wrw.42.2022.10.26.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:23:51 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:23:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: Remove unnecessary (void*) conversions
Message-ID: <Y1lRBlNrr6qkKmhY@liuwe-devbox-debian-v2>
References: <20221008083206.4486-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008083206.4486-1-zeming@nfschina.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Oct 08, 2022 at 04:32:06PM +0800, Li zeming wrote:
> addrp is a void pointer and does not require a cast type.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

This has already been changed. Thanks for the patch anyway.
