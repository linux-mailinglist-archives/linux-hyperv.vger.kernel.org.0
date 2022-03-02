Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7D4CB193
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiCBVth (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiCBVtg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 16:49:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93663299B
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Mar 2022 13:48:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u7so4142421ljk.13
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Mar 2022 13:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t1Pb+V+SY3o/7hN4naxlbLDHV8QER277N4EQXLdstAE=;
        b=fjoOTS2/How8KTj4ppEx0zCD6qTB3JekNscLsc+Auh6OOXPn/xTCqkRN2wBC/6xfH5
         +qMEFGaqXrWxl/0wz7NJ1R8vALW90XpyrXSInWHgPzfduHiw6K2WQMyJfpIYxgzktC9O
         lE+jT2ZKZ0sqE3wigrDfaxjMYCATaKmvKC9VIMoofSq3tUfwsoKfRw5zwED/M+VZx7lq
         KASCRApzVMK0m3z8k4GFaHPaAZChnY0V9rpXb6mT/Jl/BDhaTGL3oSwWWgktLlEcpQHH
         aEyqJi25xf31ZFjxfI7LdidBKoP9mJ1C+7ZKdmtLCsGybqHHYkW/ZbpBI1n9JoY4hKTQ
         9qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=t1Pb+V+SY3o/7hN4naxlbLDHV8QER277N4EQXLdstAE=;
        b=w3o42eiklvhvFEc243IVOIR+ddGoLRp01RkzxllwGtkV5ZwF5Hv9XRCRG81CoxVId7
         W5XVpcGifbcBKMsBFwyu2OeCHkClDVvqdns8k+ac3/3MXIpB+zdfCRTPMGhWTD6NytAW
         WrzocXSkl43S9QpJEPLqy5pSBy34sVoRd45aSvxk9tQy3/+bGqzsiSl2/KT9m/CG59Qb
         vkvU7HpKblUM7j/thqwC29uPhf6vbVmSo9TKJGVqg4QaNEdCbcBCh6VjH6yUezzLiZeK
         ULKtP650M7kqazotjynzVuThDbW5fryfQUbxVoZKoUOtcMJ+S5hHsLdOQHRLUKNl0mMe
         3yAg==
X-Gm-Message-State: AOAM530o8qpVPhGj1pTF7MW01mw/ycjqNiffLYqdaKbyQRQb5MnSXEL+
        7qshBBxXJB9xv3KSfb6BJBfudyuOCbtljB7Nk9Y=
X-Google-Smtp-Source: ABdhPJwojXyEybYCHHUXKmMfHA3QiiIOO96xjrjGRYolNEYDDXUjWEaSRKbbG6NN9TIm9nVkdAsalWBofDbXD8h50UQ=
X-Received: by 2002:a2e:731a:0:b0:246:4742:2c5b with SMTP id
 o26-20020a2e731a000000b0024647422c5bmr21753608ljc.13.1646257731219; Wed, 02
 Mar 2022 13:48:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:2283:0:0:0:0:0 with HTTP; Wed, 2 Mar 2022 13:48:50 -0800 (PST)
Reply-To: hirokiarisawa@gmail.com
From:   Hiroki Arisawa <amesata8@gmail.com>
Date:   Wed, 2 Mar 2022 22:48:50 +0100
Message-ID: <CAJR0EqOdDsZuWMyPj9S-z=HyAROmPGPy=VDZCLrsnOp6qdeQoQ@mail.gmail.com>
Subject: Buna ziua
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--=20
Vreau s=C4=83 vorbesc cu tine acum, mul=C8=9Bumesc
