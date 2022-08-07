Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7B58BCF8
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 Aug 2022 23:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHGVLM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 Aug 2022 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHGVLL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 Aug 2022 17:11:11 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137D1085
        for <linux-hyperv@vger.kernel.org>; Sun,  7 Aug 2022 14:11:10 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l10so124523qtv.4
        for <linux-hyperv@vger.kernel.org>; Sun, 07 Aug 2022 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=LPLyFl/pR0QK5eh2Io7LYj5LKZX11tpvTS8pI2KBI9Y=;
        b=orwQosaB0SfkRD9FzFhMy/Sd94ASDlUXmiazuoyqrEwDIM5k1UZowfwRHCuSHwhO2I
         COYRz4uHY85MT82PcrJnBzrp9OYC3SwqFaBn9TK26eurJmmgITaY/9ESnfaLCmDNgltQ
         0bTdq312DMTRR7CJVstlAQ4Cz8jVDFYC+LDYAzTTXNoJUYe1sjrWWipDGO4On88VJZyp
         r8bNjwe6RYH4c4HuK0AG2m3s2M8SR2s0KqO7IrqBCWeQXsvX6qCTzX9y/y4fB6ynhCbZ
         XnrAup5H/ODYcL0urZd1apZENSFyp8AkjnKKf3n8R+b3FqfguY8bgsQUScu/fL4znXku
         yzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=LPLyFl/pR0QK5eh2Io7LYj5LKZX11tpvTS8pI2KBI9Y=;
        b=mzXXiFAFJAWc4tlCfaZM4hBItU/itBlffR1H/tAHXQh3YANGDXWQstJdKpFYT+oC1p
         POPdm81OJ3NR7SRhnJ9Ei8JjyLEPw2czlpx6353ieUdRYBWsQhfM/RFrTBZMlSo2u49w
         y7/dx5kKmaUQQMysLfdMurFl2Ibo87Vbjpgv/xK8OMHpH3goUayD0ZYBRz8U0JrbM1o0
         mnlvV6DFv1jCOXisWgv1GBzo1sadgUxSCpM+p+Qliwl0lRuwuLsLmudPOQtS6TtcxIy/
         Foh2OWt+BggylInlWU+eSajFLpmsUeuNegkcx6WGiwopKi648B8nv6dDGqr3b2aZsymL
         aScA==
X-Gm-Message-State: ACgBeo3iB5YE4J4e0WuVcLb9Vk/Sg8M/0RWCXH/3i4hmMNJOpzt53fMQ
        +SXmuHCFYh99S2IeqryOtvQNL+JrKPCJ9nE8B7A=
X-Google-Smtp-Source: AA6agR7HbyFdMrr/ULpvFi8XZlWhk/dQxHFeB+QZcP+72p0ZrZdhmAcLpRIJiRmCODLCWQHCIiCU8eOn+xrGFdCNvFk=
X-Received: by 2002:ac8:5a46:0:b0:33f:3aee:383b with SMTP id
 o6-20020ac85a46000000b0033f3aee383bmr13851562qta.102.1659906669328; Sun, 07
 Aug 2022 14:11:09 -0700 (PDT)
MIME-Version: 1.0
Sender: fousseniomarou@gmail.com
Received: by 2002:a05:620a:29cc:0:0:0:0 with HTTP; Sun, 7 Aug 2022 14:11:09
 -0700 (PDT)
From:   Capt Sherri <sherrigallagher409@gmail.com>
Date:   Sun, 7 Aug 2022 21:11:09 +0000
X-Google-Sender-Auth: pdMDIraF07gFN51X56yi-8qS3Ps
Message-ID: <CAJ4Q6V7dq_bAKU-1fzn0WhjGwDCEkSROfjnnDKFTJ021m+ryQg@mail.gmail.com>
Subject: RE: HOLA QUERIDA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Capt Sherri
