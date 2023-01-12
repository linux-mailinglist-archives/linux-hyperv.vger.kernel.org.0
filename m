Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B97667498
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jan 2023 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjALOKB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Jan 2023 09:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjALOJE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Jan 2023 09:09:04 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EAC5793B;
        Thu, 12 Jan 2023 06:05:00 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id o15so13253346wmr.4;
        Thu, 12 Jan 2023 06:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA6kW34Q7nTzVxLEmzC/Bv2Y0CCosmHi15i9c8XUCOc=;
        b=0nwiy8WrlVkXw+3U1onjB5v4IQrlr/MrmNLSu5HApvXwi8oGS2ghNF3O7/Kjr267Rd
         hz97IlRfaK0032bXGTLmMI1fdG/RWi4SuM5QheJtyztuGvl/w9yJhnlSE8AdyGIpBjMi
         FVsKQhXckoeLbaWkOnbK8fGQdVCfQtoCPUdkX6g1LMbCYj0+vbRIO3PXkkXRdMHy1L4A
         qhFaYyPvY4JasVX+6nb2aEs8gEDY8bJUltbbqjvkOF84ZmlWKXIxx251XpExWcAZKHGx
         FvCy+1vO6HsMJ2Eq0r+fgGHTKf6s+MrAdi6SChkMHXdTCbdcGbHtS7VSJUQb5oC6lpHl
         EHFQ==
X-Gm-Message-State: AFqh2kpvqSZwch7IJLqt4mJYu+z7GUzSS6kKTn7/95DkV4j2PXSL/W9Q
        t/Eeq+ubzc4cAwvmRrdmF4Y=
X-Google-Smtp-Source: AMrXdXvvBrC4wjpSKnljYqdMFEpErcOaFxnwGAeCi5H/8Dp16Mb+0zhLa7hsGaIHg9jPtGMxSA22vA==
X-Received: by 2002:a05:600c:4f83:b0:3d3:49db:d95 with SMTP id n3-20020a05600c4f8300b003d349db0d95mr55293321wmq.37.1673532289849;
        Thu, 12 Jan 2023 06:04:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm12866894wmc.6.2023.01.12.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:04:49 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:04:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 10/16] drivers: hv: move device_to_hv_device to use
 container_of_const()
Message-ID: <Y8ATf37Y5zvTn8gw@liuwe-devbox-debian-v2>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-11-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111113018.459199-11-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 11, 2023 at 12:30:12PM +0100, Greg Kroah-Hartman wrote:
> The driver core is changing to pass some pointers as const, so move
> device_to_hv_device() to use container_of_const() to handle this change.
> 
> device_to_hv_device() now properly keeps the const-ness of the pointer
> passed into it, while as before it could be lost.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Wei Liu <wei.liu@kernel.org>
