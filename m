Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41764EB5C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Mar 2022 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiC2WUs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiC2WUq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 18:20:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376B4133F
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Mar 2022 15:19:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so122145wmb.4
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Mar 2022 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=FJ0eh8tU06EWQ41+9chGyITwUAQXL7CsZuHSHpKc5xiQXEpN1uCBi3KJCIAsP0sO6s
         uzre6e7te8FaENR1KxBeXRRP4gLeJGQCN/b7b/O9sKUuNG1+6Ukx9pJ49l5kxcIJdfKQ
         a84OoERDhxNtilyeTbTOJxDQLhyQ3tm4jOWEcp1iqgTfgiHJhI9ShMZ+aqD7q1eNTMsR
         fWWP4WVJDTY716lGSGEHEljQ0z8oa/Wm3WK3/3fliOR9ffVENIwprifB8CdJ1TOCu2sl
         IzzD9MkP28zN5lgNXDRbkwTgFLXaWBdvBBVHcVh73kLkpmwbQTX4napdSe4XvLYp0alK
         UgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=v6e8jvzppRSbCcgRPBAfg/WEEVcoIvrQp1ZYswm4hJBDadqbhn0rp5hzvQ9E6bB86z
         1BLYbBtW3sZuZSlMwBPyntHCwkBELANkYPutG0t7mNgBmqTLKe/+RbrRj+KTYa7ztkdx
         Ei1FHoMPvoqBDqylwg0gLHkGzms3jBCzOAYU1ky+fO35CicG61B5OpVRYJPiYUYglcpN
         9EBoxJiaAkFj5gCJ378hb2ybFEsholZm4mRnzLAcpOkht13tT1GpGXvf8faEJAYPCdA4
         PT6bYAD5rZR2VCP/zkNppW6NDJMm9u7++tMRtiJktdiLOKzlgxQi93J1LryvWqxRRfoQ
         KQzg==
X-Gm-Message-State: AOAM532DUqUGvuSD8QbvNKeTv/qLQfllT/n0bvLB6l3VUgoVQYs4CGAf
        EmEIfCAUS+X+ZqHFCf4Mfus=
X-Google-Smtp-Source: ABdhPJwfA6lfA48j9JcVoFWhEfpHzD35Av7gAe7E+50sF8fN9ROUTollvT8BdvHHQapxFrMyWbC8Xg==
X-Received: by 2002:a05:600c:3b8c:b0:38c:c1a8:7571 with SMTP id n12-20020a05600c3b8c00b0038cc1a87571mr1528483wms.136.1648592341785;
        Tue, 29 Mar 2022 15:19:01 -0700 (PDT)
Received: from [172.20.10.4] ([197.210.71.189])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm15642619wrw.57.2022.03.29.15.18.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:19:01 -0700 (PDT)
Message-ID: <624385d5.1c69fb81.af85d.d5c6@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:18:52 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
