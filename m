Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814824C0F37
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiBWJ3g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 04:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbiBWJ3f (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 04:29:35 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D612AE26
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 01:29:07 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id l42so5195278vkd.7
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SzEm6i/EwUESKhbVX0osxjmnwu7uiM8aIqN8Ey8PdDw=;
        b=nLA0dvM75/4eSVf0md8dLuKrB2Qva6AFsLJ+RktImjzdCYxrKX//QDVvnuhFgWCbaH
         W0UWKn+ZqstMyDq8wEik8A2M+8CnKSG9M4BIgR8JMgeMLef3lwyLxjFcz4gKUFSqWuDj
         cPFDBdDjlmvzTPqjs7sKlwmTjmy7O48R4w1DgW1UGL8ZyFz4zgIitxvF2GF92j5TuGE2
         3T9OG4Wpls7yKzoiPQO3bsAkcoANp4F3x0Uud2azljxxTtXtxThgtfKoh8QP5494XMOT
         rlz4zL4Xd+/Gy6LcAUon8VzE1kVtO/c4nLl/YD4PP4ZRyVuhNEXxhXLjP3ZK/BnQOWxA
         QYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SzEm6i/EwUESKhbVX0osxjmnwu7uiM8aIqN8Ey8PdDw=;
        b=lQhY0V8q5KK8D5ephnF1gjDRLDZNaVSJR/aWM2lHd4VqCBQGtZC5sPjRtlCNGTOEKG
         oVhspWBAdQbGvH672d/gTxFTs7GJxUvMIZ47re0h4HO1kIH4uG3SYNixdj/cB5WBlZ8s
         y2hyexQyKZsfwf12QlSS8wcyKCLcGKsj0mrPFydkd4U1XUSmy6siXMKgdKHQASJGGDDy
         jUhh9gawuS0tKCR0lKeQ5sG06GK6vWbA/NbtsWBiNz2Ildruj6Vvl5JYFhekbsQbrqs7
         ZCpyDPokyKaZt7yNufXjtzrA4r7Xrl9fr38R0lpDkJX2vST4G13ECYUM5aY302XzT9QG
         Xhlg==
X-Gm-Message-State: AOAM531diKIbbUxrJzO4lVJGGLLKAY2LjSmz4JcVjp+WeC+B7zBB/4Oa
        a3PJpoZX9Fhh/JNNSAd9sN4H0E3yvGxBgnqa+YI=
X-Google-Smtp-Source: ABdhPJwWQUICr32tmkjTcUZmEHSy1T3xqtKsvqX34SDbBopA0fV64hOWF+CiZHdyiUSQXCXHG9uK6zxs+07RUfyata0=
X-Received: by 2002:a05:6122:635:b0:32d:1046:307f with SMTP id
 g21-20020a056122063500b0032d1046307fmr12410096vkp.0.1645608546443; Wed, 23
 Feb 2022 01:29:06 -0800 (PST)
MIME-Version: 1.0
Sender: edwardcarlos536@gmail.com
Received: by 2002:a59:c708:0:b0:28c:495a:1d41 with HTTP; Wed, 23 Feb 2022
 01:29:06 -0800 (PST)
From:   Aisha Al-Qaddafi <aishaalqaddafi066@gmail.com>
Date:   Wed, 23 Feb 2022 09:29:06 +0000
X-Google-Sender-Auth: BropyyCQQeqBfl-o-zDPkI0SDhA
Message-ID: <CAFyj9jwAv=CJoJZTu5vuLmVXyQgtvO84TspePJA978Mu34jnHQ@mail.gmail.com>
Subject: Investment Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

My dear friend,

With sincerity of purpose I wish to communicate with you seeking your
acceptance towards investing in your country under your Management as
my foreign investor/business partner.
I'm Mrs. Gaddafi Aisha-Al, the only biological Daughter of the late
Libyan President (Late Colonel Gaddafi Muammar) I'm a single Mother
and a widow with three Children, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia. I have
investment funds worth Twenty Seven Million Five Hundred Thousand
United State Dollars ($27.500.000.00 ) which I want to entrust to you
for the investment project in your country.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds.


Best Regards

Mrs. Gaddafi Aisha-Al.
