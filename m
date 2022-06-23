Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8FD5576E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiFWJnq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiFWJnq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 05:43:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED649257
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jun 2022 02:43:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x38so34849187ybd.9
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jun 2022 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ghlw3PUbaMRTrNAFN5AzPbagOe/MajrrzGTvbAlxV+E=;
        b=TsZiSygDx16gZQf+Jc32LbL+jgM17ihhfakiZLr2sA3qPgnrzUh4jDCbhHNicYBZD+
         6rjcoooK/s8XPl3XR9E7/la1hF8XdxUcoVDB4TTZJRTjOKXMtv60UajEknsSr18DjsHD
         yziHfXmK3mqGP2OdsndjVmWTzzYZ84DorlaQE3NnJnrprvN5lmbfpIFFaitiA7ry2y3q
         G91wWuIjVCBx3tqunLMMLDvKc6AovoZ2+6BVo2LAl7UKtmE3PALSBzqAZtKWd12g//ZP
         DBFJ+tftTA5UkmtY9jzyA33T8w3zjkWQ7rFrXzQmKZBoT+eXs4PzT/evp184B9IS1sdV
         fkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ghlw3PUbaMRTrNAFN5AzPbagOe/MajrrzGTvbAlxV+E=;
        b=XPMMMJS06cn16fjZ8vigBacjRySqwphcK2L97G9JbTMHiL/3aRWSph2H+eEXCzBWMo
         DAQQDRUfCjBAiWcI8Oyl9k/SdoamtGCItyZRMpdsR8QER6OF9N7MuanZbX4cAssOdGzB
         64jhxQGkM4mdcyBsQmrzu4bDM8HEpzdIpKAewH88qQUGimCJH7TJV8ftx834Lr6FoO/q
         9jlKnAML17er+pGciooqDOeWrh7DIbrxlAGB1ZA9rvIDxC+OLmzHsyKoKgA40D82KFBb
         4Pw1z97VERM2VQNCpm0V+Inu8AcQLFX1Wb5t4bIjt+r2ymm18RIT7VnZKVnMQ5HZhVnD
         i8Yg==
X-Gm-Message-State: AJIora/isxzVg7VHs3LyQYwaEHevlKj2l5J6B0zR0YP/rNFG420xLzfm
        bDMhAdraYFgZruNWt0YBBtmAmAsSIkpNQg5KpWM=
X-Google-Smtp-Source: AGRyM1slXzvIEvmcDEqJ87w+rRnddHO7p3aZ8tUmWfYpJxRs7V/S+6ipO7LuPjYcphVX9gKaPPEfd8vihmXxFCHOKG0=
X-Received: by 2002:a25:e203:0:b0:663:de4f:f233 with SMTP id
 h3-20020a25e203000000b00663de4ff233mr8765381ybe.168.1655977424887; Thu, 23
 Jun 2022 02:43:44 -0700 (PDT)
MIME-Version: 1.0
Sender: ladypnutgram@gmail.com
Received: by 2002:a81:bf42:0:0:0:0:0 with HTTP; Thu, 23 Jun 2022 02:43:44
 -0700 (PDT)
From:   Kate Mucus <katemucus@gmail.com>
Date:   Thu, 23 Jun 2022 09:43:44 +0000
X-Google-Sender-Auth: dExEkXNewsGP0nBwAm7v4l1z85g
Message-ID: <CAGzCr=0QNpRD0NEFKnOHp5yFGwdpKbNh33tUcrFm9KMyxSR48Q@mail.gmail.com>
Subject: gk
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
Hello,
I'd like to talk to you please..

Kate
