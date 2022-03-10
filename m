Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85BF4D3F65
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Mar 2022 03:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiCJCwy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Mar 2022 21:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiCJCwy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Mar 2022 21:52:54 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A1125CB7
        for <linux-hyperv@vger.kernel.org>; Wed,  9 Mar 2022 18:51:52 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id d3so2856013ilr.10
        for <linux-hyperv@vger.kernel.org>; Wed, 09 Mar 2022 18:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=KsYfuK1VkY2187XWZIYnjdlUWi8A7SbSiSeQ4aBqm/GWTIFLoT76XyjirAKTdU53pb
         +yrTPnmV10etrPAPlarefR1bNsRzrmQzUyJWCfBQ73Pek+8zvIXOUt/8UgjmD1s1S58I
         PjWE/fzBA9EietNVAMyoMEOViu+5HI2+amNi2lkrrN57wJ3tUPYSqvSBXW2mrZu8YVsR
         A0rCXzKYBNbWOpd1/8LJZNqywTJvB9v3pgmxYVhx3D2Us5iXoytodlForERUkQ8LA9Zv
         s9biZFmWag0oD34HBgroi+x5vBi3UDnDJ/139+kO5l2qG+cyBAdEvFnI+dCl+ozfUO1F
         4HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=1vIOXBz2z/4FCJT0wlsGJOhZvScnJ7MC5J0+1XXgUhp29/FY1hd5X3MTsbzwcgkQBQ
         2rnZVQdVEfGb9zhnVaY2Id6fyGsqK8IjeLkgD8vkqEbqCczYJ/lMm22kEhBnTMyDsdr7
         dMQyDClYttbkQCEg4tTXtjC3I3R1W+gvtsXm9HwhL14PixOZ+O9QL3sYXY/YW0gxoN8l
         SuYGQSF8ck2HXkkKt+4NpXfhoSrXd5nMUKQtPoeKTNutfxvZXrjQwnxzCP5r6Sp5lpy2
         i2nxGLACh9ypldyL6Bafj6z5ZS/v6Hp/t/DCdCHOFAx1lPRGOX/XOooA5tXmxuacjZGt
         Ppew==
X-Gm-Message-State: AOAM532UkAT3adDghzEA7RHcXmsV7kH/CyFrabkQuN8L/6bC4Koi3Mg1
        FQYtKsepAPqtRDFNErhSJ0aAU2Bkh2ESbP4p1z0=
X-Google-Smtp-Source: ABdhPJx2un4z4qfwzOitIhIz5NWyd45MqmDNAI7vVb0bD1ZUmZx8dS7T0uZnaZsf9hwDZH1MTlWWKgth8BugPy5pqKA=
X-Received: by 2002:a05:6e02:1be1:b0:2c6:7395:a076 with SMTP id
 y1-20020a056e021be100b002c67395a076mr1900024ilv.143.1646880712320; Wed, 09
 Mar 2022 18:51:52 -0800 (PST)
MIME-Version: 1.0
Sender: albertgearldo78@gmail.com
Received: by 2002:a02:b11e:0:0:0:0:0 with HTTP; Wed, 9 Mar 2022 18:51:51 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 18:51:51 -0800
X-Google-Sender-Auth: _kE8gKEgw4vbJ2Oy6Kh5dYw8Y2g
Message-ID: <CAPo9qzONus-Exxr+cwFBfvvdxj_YexUnJ_N5gd3UJqXNitesBA@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
