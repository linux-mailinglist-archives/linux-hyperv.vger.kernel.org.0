Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E31571CE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiGLOiB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiGLOiA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 10:38:00 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26D50728
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 07:37:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h62so11630322ybb.11
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Jul 2022 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=hlacH67SVgLu8ryEgXc9gY77M4s0T9sUBn1DGJR5f5UGv4YUim7RomVYYxdaFrnLuY
         d+fnR5cMqDg6Gm562h1pQMbEy3tCJS7j7eLXp5J9eBuvi492YM35ETgIBHzuxv3Pi1kM
         EBeJw4dO884AjtcjyYxPoJQqFPYA+S++GpinjdVeS1JuqgDrsybwpWbk/n12DNHzkhQ1
         dmgotWkKq4g1wFwN7Y6q+oQpcYtqNuj9tfZUZYgGIl4DhZvyDhU4Gc4drGVvl0sqm7kU
         2TlvpWQFQVsKQxnyHXYzDV4uChI+6KtD4gPZ/iF2dUloe4FMFpc7huwn2DdT85AMpaiQ
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=7NqEdqiKKbnqys7JZ5KKgQ95uX58o32PeKg+PFsD9IMTIOWg1fE+SpX8Bh6dxBAZGm
         WxzPKaK7mzLOeGpyFi+hBdUDuE4eVrKXe9ILxrLxVtuFHIWsCUYbqAqts2njr1DRbYfz
         juQEclBtUSlqB2UixIgodDTxNP8v/x7hCWF+Rscfhs3nrbK45pBknyH82w6w/Mh85v0J
         3janBhFTbsnJXuXrkEFSHwgQG/Dop+R6Mgn3+P0UEoKeBJ1X+oswfcLbeKOSV/LyInXt
         YrBjGyp2pm9Ya1zGdOhD7ahOahZqIaUyHW13FrMY63cebVZV2+ahZNgXmwLb4qug/k2L
         zyyA==
X-Gm-Message-State: AJIora/mwbJMmL7+wC51WCYM3vCgbM39SYT81q0bPs1Fjoq2alo91H7d
        T6wGWqtAC+K3YO5laOy26cIPsX7lnnAxuBjkeOU=
X-Google-Smtp-Source: AGRyM1sHNyvBiVEborfZbgqHBSiUssUREobAogGv6EnjGmT3HHxx8o3ZjBtyHbk8s7hi/FMyOINR79qCdSNPX/XXE3E=
X-Received: by 2002:a25:d094:0:b0:66e:bb36:5118 with SMTP id
 h142-20020a25d094000000b0066ebb365118mr22692514ybg.46.1657636678301; Tue, 12
 Jul 2022 07:37:58 -0700 (PDT)
MIME-Version: 1.0
Sender: genbradstanley@gmail.com
Received: by 2002:a05:7010:5887:b0:2e4:f19a:de60 with HTTP; Tue, 12 Jul 2022
 07:37:57 -0700 (PDT)
From:   Ahil Lia <mrsliaahil070@gmail.com>
Date:   Tue, 12 Jul 2022 14:37:57 +0000
X-Google-Sender-Auth: xy_Ley13ee5annVKHUWe3Wv2WCw
Message-ID: <CACX0y-VX25iXwDMWB0WCc_rfpT+fj68LbqvpdEMBk57q2J0-og@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


