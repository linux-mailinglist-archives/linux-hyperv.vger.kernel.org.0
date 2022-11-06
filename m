Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAEA61E03C
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Nov 2022 05:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKFEM6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Nov 2022 00:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFEM5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Nov 2022 00:12:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329BFF008
        for <linux-hyperv@vger.kernel.org>; Sat,  5 Nov 2022 21:12:56 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id k67so7830193vsk.2
        for <linux-hyperv@vger.kernel.org>; Sat, 05 Nov 2022 21:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE7RjcnICkKSIi/AY7a3fxEG1KellRXQCB68D3uOgOA=;
        b=pM3Ypd6rfHwOORXDCPIxKkfqghMG9ViPeJXXXIUsPUmqvyFJBHcguwcqG/PEzo/Ylu
         bkWl3Bu00k5HhwbcNDg4tZBNXhvLAvxgHWq3ksPStacyMYGSq9/DIeIQ3odLkQJ/iqyQ
         hI0oS7q+qTIJArBmbvl3H4ifSjQ2AUDkJnlHWMZJpmEEvFJKFdMtX0xUmLvmw4sHCfBa
         XhFBfXdt3AW+EKt6iZLGeTM3VBcoKTIefBopPyq/JjNy/Km1VOk8lcLRencIDrUWZnCs
         uhKZlShj1tfejykC+TU2a5yEfg2E5OG00p6tjC4pQnWOnmV1m4D2/nIjzaI8hqgkzZF3
         nb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bE7RjcnICkKSIi/AY7a3fxEG1KellRXQCB68D3uOgOA=;
        b=KKED14FmKyPa+adD2jDFfwiaRTiMgjuC5t9aZmGVIA0rOo3WgQJEMNK9T9LnXbrr3k
         mnakyb7cuiGfHoR3aubfEWrdqackYGB6btEQ2LA40CF+eNuPPcE1SrijUctdKH0zeTot
         C0mE4lv1jU6L0GKAKYtS0ptbk6wM7RK1Rch6xQRiiCjyGWvx+CLg/KCqk9Lwvd3wjypf
         Y0bWwivs4QgEU/kpfzqiolqdp1skBeCMEU6BEApgBAztRt3aXPzB+pWVdRNa5WKND8ib
         uIalBXBSU1RrBmsHE+a46/Evt321Z4BffIuI22IytmnfofQtcxPW6bGZLcktJ8eoDvK4
         IKCg==
X-Gm-Message-State: ACrzQf1D+7rmpCNUrb2uwuIRhSf+myXlwgjTk6BsJAEn3yowl0EQ/u97
        2l9VDtGPM6hpLEzcQ2cMQAKIhAcAlwhl07cFMvk=
X-Google-Smtp-Source: AMsMyM7JVdoCaqvUo5UFi57ldpAYnfRjFq9r4ZzLNA5xj/h4cDvHe4aolRmE+p8Z8y9Hr7TbkJvdYD7+KOQDbIn9i2c=
X-Received: by 2002:a67:dc18:0:b0:3ad:9c70:4d58 with SMTP id
 x24-20020a67dc18000000b003ad9c704d58mr4710015vsj.86.1667707974395; Sat, 05
 Nov 2022 21:12:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:ea0d:0:0:0:0:0 with HTTP; Sat, 5 Nov 2022 21:12:54 -0700 (PDT)
Reply-To: drsmithdrava1@gmail.com
From:   "DR. AVA SMITH" <herobestman0@gmail.com>
Date:   Sun, 6 Nov 2022 04:12:54 +0000
Message-ID: <CAOXFw9qF2+mZ4B0zNJ4RGnF9eKNQaZOQQpzykQg-hrMSF69zJg@mail.gmail.com>
Subject: HI DEAR,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
Hello Dear,

My name is DR. AVA SMITH from United States. I am a French and
American national (dual) living in the U.S and  sometimes in the U.K
for the Purpose of Work.

I hope you consider my friend request and consider me worthy to be
your friend. I will share some of my pics and more details about my
self when i get your response

With love
Ava
