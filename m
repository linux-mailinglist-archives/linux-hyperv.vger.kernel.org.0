Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554996889AE
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Feb 2023 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBBW0W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Feb 2023 17:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBBW0V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Feb 2023 17:26:21 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF54C0EB
        for <linux-hyperv@vger.kernel.org>; Thu,  2 Feb 2023 14:26:17 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m12so3699815qth.4
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Feb 2023 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBzRyZWomK0ljJC7ADgMv3EMR+dp8JQbHN+nI/dRoIo=;
        b=dK2SoFBsgel8RpP7gCS2aEHNiAbQBvPH6ohnHDeyxsznYtd2xJ+SvY4y8R5sEQIU7o
         aWmepkLhutMB1qSjXqsbhAKEu32PISZx9/kFPjDQ5jRiz4rG4VrSQ5ATJIZjNKCAR6t+
         +g4YfybCycpNwIkElYQ8a4e05rNdHKWfya2wPBKJgAWzZrpevPlZXAOM7iG9lr//e/FD
         YIS4iv2zxhk7QHM47UEvF/XLfNNBYvMdzuckAagl2SQVtL8euWXMX0j1EKZigcKx11bD
         jJObCLBz4iy8otIiX53e/h2F5kYED8lV2WP3bAXm48hegUQuzclgKCOcDby1I7Or/8t0
         K62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBzRyZWomK0ljJC7ADgMv3EMR+dp8JQbHN+nI/dRoIo=;
        b=urRa6vp90MvxiO54kZgWA2lfpVvLISj/J4oBwGOzCWmyhji7XJFsd0VzDcXP+ksxrV
         1e2ds75YjEZcjlW2MzRB6bTxiGNyML+8/AXpSrMzzvCezpeWb9MB3FXAMwdBmKjw5Bvt
         JDTD9snuqzgHbDgUPljkeBBSlci0tMQxRcWsRyP0rw8VQlf7Be4AyHGaWVj91hIZQgZy
         /OHLSRMiAyCCrEHkiyZaw9cTajyWHV2i/ED64JhzdueoAom+h2P/4Q6yN53ATNpT/Ox4
         9OqerFzfsnPBjBQC6mLkbYQJvSHZ2sYt5iPxNbTw2RBDJy6zd7nOPtERglZD6XJ5L80z
         hpIA==
X-Gm-Message-State: AO0yUKV07zpmLCQkeADtiG/TZT+Mq1oIh56I6g3HCdGPVj109Kw9kQPa
        bhIXjTMWzUSFkezJ0Dv8PTTGKXaUhPBiAIDa2Zw=
X-Google-Smtp-Source: AK7set9lhxvjHXhW/eJRuKbsIACccYpuK2xIS2Onwc9EOrXZ0eO8hK2JQaF87xwI4QxaThtwVLMI1Aj1Hecyzwgz7Ds=
X-Received: by 2002:ac8:5c55:0:b0:3b8:296f:fb7f with SMTP id
 j21-20020ac85c55000000b003b8296ffb7fmr829415qtj.402.1675376776751; Thu, 02
 Feb 2023 14:26:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:5652:0:b0:3b8:6c07:fedf with HTTP; Thu, 2 Feb 2023
 14:26:16 -0800 (PST)
Reply-To: revkones123@gmail.com
From:   Rev Andrew Kone <revadk558@gmail.com>
Date:   Thu, 2 Feb 2023 22:26:16 +0000
Message-ID: <CAGL61qXd6LO+Us1dk+OhV49o6W5gOBEq-MUwtiQM3a9eYVnfqg@mail.gmail.com>
Subject: Hi
To:     revkones123@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-- 
I have good news about your ATM card :Bank cheque delivery, Have a
nice day and remain blessed.

Sincerely,
Rev Charles Kone
Catholic Parish Priest
Saint Joseph Catholic Church
Lome Togo
