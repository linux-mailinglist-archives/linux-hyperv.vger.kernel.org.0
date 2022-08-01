Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58294586DE0
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Aug 2022 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiHAPhG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Aug 2022 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiHAPhA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Aug 2022 11:37:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA72A71D
        for <linux-hyperv@vger.kernel.org>; Mon,  1 Aug 2022 08:36:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r14so12758741ljp.2
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Aug 2022 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=q9Slei3vdZHf3BWZhWjxjnYHcSiTDd6lLLw5COAJJH4=;
        b=UKcP1FDF09nj1k3uYCs67Q7ZyiUIjGtO/8/Bj2O390UgRgAJaQbdj4bNFv73NHa6D2
         iYDxlXmYJBF3bZ+BbTGm686z3m5B8jXpwu0YmqjPCoKHCXX42ltrt2aAmH4sQv+ccJN+
         OHyZ31OJTJwijh8OV8oO5eWh1/bM4pqSqK2uyo052aPr6eVSdk1CVQkx424vXYMEZQTj
         HsS77Ky28UOjl0KpgsmMPfvxGbLfejaevmoaRlv0kRAHXIpr67GF1/t31ULjMlw9VGDc
         NI+pGTJBLZwknk3P787XURm2/kBy3STaEpJiGhVmWsgdrf7IgJXaPWV7ssfsuJ7alB0a
         /1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q9Slei3vdZHf3BWZhWjxjnYHcSiTDd6lLLw5COAJJH4=;
        b=ycDFQjau26pu4Hnb7es/XEz8uARXYgWEET13+ksckSKusrXDOWK3i1EskpyyiFGqWf
         7tBvvlsfynplTEtnoDSi0ZlyxhR1Eh3Maok3CgtL2nyuDvVyxNsarAyw6x0MUpgZ3UUe
         SvqA02MTGJc1lgfvrMyohy9SgqAPHwsxMgxQLr7NUXeXzIuZx2lvW6QBXcYrduxgr6pL
         ls1+ydWMxPYGFiyJp1qycT+mrCh5iv08iVy/wRK90Nt+yqygr4S4igcn9Z50fYu0/okb
         2KPz3cahjeA0DKyjwTeZU3qoHS/vEFuTog4xy2t3IetP+Cc4AHqFfK1Is7KbkNm5KuHo
         6b8g==
X-Gm-Message-State: AJIora8dzgEijPmA+J59wi7HX/azoXzcC4AECkWDN7v3XOMGtDPbKSXM
        gyXteamPWQ+geRJTkswiP11bwlHnieOxcXFGefY=
X-Google-Smtp-Source: AGRyM1vmE9FJ4oaYsT2Hr55xmADsiyPljwE7zY7KjJ0BGtCDobMH8efpf5FFXcSqHPDNiB3EqFhLCRIlfACfnG64NOA=
X-Received: by 2002:a2e:be90:0:b0:25e:1496:a0b8 with SMTP id
 a16-20020a2ebe90000000b0025e1496a0b8mr5475533ljr.194.1659368215756; Mon, 01
 Aug 2022 08:36:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:cb52:0:b0:1fa:aaed:e6d9 with HTTP; Mon, 1 Aug 2022
 08:36:55 -0700 (PDT)
From:   Bright Gawayn <gben68387@gmail.com>
Date:   Mon, 1 Aug 2022 21:06:55 +0530
Message-ID: <CAG1+V0zQ=FhBLNLT__co7DHJWC=eYBw480NBDxjx-Za_ZVMuzw@mail.gmail.com>
Subject: Lucrative business proposal very urgent!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gben68387[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gben68387[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.5 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello dear My name is Mr Bright Gawayn,  It's my pleasure to contact you today.

We use a certain raw material in our pharmaceutical firm for the
manufacture of animal vaccines and many more.

My intention is to give you the new contact information of the local
manufacturer of this raw material in India and every details regarding
how to supply the material to my company if you're interested, my
company pays in advance for this material.

Due to some reasons, which I will explain in my next email, I cannot
procure this material and supply it to my company myself due to the
fact that I am a staff in the company.

Please get back to me as soon as possible for full detail if you are interested.

Thanks and regards
Bright.
