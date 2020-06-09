Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A779D1F38CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2020 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFIKzl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jun 2020 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgFIKzk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jun 2020 06:55:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A47C03E97C
        for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2020 03:55:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so13491089ljb.12
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2020 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=QDZbClBa20TO6ImOnk4AdI5saEke92ipctox8nHw+bIBx1MVvKqd5+hT/RljyJElta
         lVqt/EHOEHTBzqs+lVWeBz1O1YSHBBSQw7D/TPD5S7/CoqgwukRJxWXXn3pAAxvzlwxb
         lj/W01rJdDmv7mqBT3ea1aCFOO4VMurQLNz3ZkjnTTF6JVfSSpfFKSw/nfOb03BrsTkj
         YrlBsgXuabkuk31j2rHh91UtcxNQiLWRXSBTqE2yeXqthhzTJzlv4QS5JByCedDF7egw
         j1AW5X1O5gDBIbLVHeIG9IebZ37F2B+/4JTNAH2S3cblfH917tdbqXVncs57nBD9DuDI
         3nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=t6+8+DzP6frG9J8OmRl7j/4X49YiRgNdRmu5wrdQoBBvzh3SbkHcKfqyaCxJQUJTxj
         okxM1IiiG0f6G6+X/Jy+CHnL7ltv//N2q7Fle4rmtFZmj/SUCmK1Fd4rIYWOMIlEQrMv
         uE9DQ/oNMWIflLV23f34pTkT+BcXygmVTAotC0MtffEBlft+9iRlOfDTo9b9iOw66HCJ
         WPu15QIpihz5CMV7BRplVANd1+K+breLr/HHK3PIOH9sofaEwEfZKkK5Wz3HGLNa/MGL
         3bfwD+opuVtR32/LKZDAfhzCFbIFFnxPg4F4boRdg+r/mJVYOcicbBAtjm/mWA5cDKLJ
         y/nQ==
X-Gm-Message-State: AOAM532VoC+/450DDSAJ50EgM983PpvdAOxnPaLdWPiombQwUKtNXSTO
        IECtv1Az135KX1ACgiwE52tU2CzzLLzYdG0GjXs=
X-Google-Smtp-Source: ABdhPJxB/qm+GXNwDAEpQN88SHQ0O9g3GtxPCEBPka4Jf6GU/d48zssKEOLD9ymkcgZSmEPJe4y9e4+v3GXCWTdUIzM=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr13226012ljh.415.1591700137917;
 Tue, 09 Jun 2020 03:55:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:804e:0:0:0:0:0 with HTTP; Tue, 9 Jun 2020 03:55:36 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <nnadinawafo11@gmail.com>
Date:   Tue, 9 Jun 2020 03:55:36 -0700
Message-ID: <CAPhDfr0CF8tL_sfzZ7y5M3sgDr0A8HS8xR8JFd-=quO4BshHSw@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsINCc0LXQvdGPINC30L7QstGD0YIg0JHQsNGA?=
        =?UTF-8?B?0YDQvtCx0LXRgNGCINCQ0L3QtNC10YDRgdC+0L0uINCvINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC?=
        =?UTF-8?B?0L3Ri9C5INC80LXQvdC10LTQttC10YAg0L/QviDRgNCw0LHQvtGC0LUg0YEg0LrQu9C40LXQvdGC0LA=?=
        =?UTF-8?B?0LzQuCDQv9C+0LrQvtC50L3QvtC80YMg0LrQu9C40LXQvdGC0YMuINCSIDIwMTUg0LPQvtC00YMg0Lw=?=
        =?UTF-8?B?0L7QuSDQutC70LjQtdC90YIg0L/QviDQuNC80LXQvdC4INCc0LjRgdGC0LXRgCDQmtCw0YDQu9C+0YEs?=
        =?UTF-8?B?INGB0LrQvtC90YfQsNC70YHRjywg0L/RgNC40YfQuNC90LAsINC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g?=
        =?UTF-8?B?0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuCwg0L/QvtGC0L7QvNGDINGH0YLQviDQstGLINC90L4=?=
        =?UTF-8?B?0YHQuNGC0LUg0YLRgyDQttC1INGE0LDQvNC40LvQuNGOINGBINGD0LzQtdGA0YjQuNC8LCDQuCDRjyA=?=
        =?UTF-8?B?0LzQvtCz0YMg0L/RgNC10LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6INCx0LXQvdC10YTQuNGG?=
        =?UTF-8?B?0LjQsNGA0LAg0Lgg0LHQu9C40LbQsNC50YjQuNGFINGA0L7QtNGB0YLQstC10L3QvdC40LrQvtCyINCy?=
        =?UTF-8?B?INC80L7QuCDRgdGA0LXQtNGB0YLQstCwINC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg?=
        =?UTF-8?B?0YLQviDQstGLINCx0YPQtNC10YLQtSDRgdGC0L7Rj9GC0Ywg0LrQsNC6INC10LPQviDQsdC70LjQttCw?=
        =?UTF-8?B?0LnRiNC40LUg0YDQvtC00YHRgtCy0LXQvdC90LjQutC4INC4INGC0YDQtdCx0L7QstCw0YLRjCDRgdGA?=
        =?UTF-8?B?0LXQtNGB0YLQstCwLiDQvtGB0YLQsNCy0LjQsiDQtNC10L3RjNCz0Lgg0L3QsNGB0LvQtdC00YHRgtCy?=
        =?UTF-8?B?0L4g0YHQtdC80Lgg0LzQuNC70LvQuNC+0L3QvtCyINC/0Y/RgtC40YHQvtGCINGC0YvRgdGP0Ycg0LQ=?=
        =?UTF-8?B?0L7Qu9C70LDRgNC+0LIg0KHQqNCQINCU0L7Qu9C70LDRgNGLICg3LDUwMCwwMDAsMDAg0LTQvtC70Ls=?=
        =?UTF-8?B?0LDRgNC+0LIg0KHQqNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQve+/vQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


