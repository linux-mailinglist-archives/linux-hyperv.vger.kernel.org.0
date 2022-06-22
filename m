Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F11553FDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jun 2022 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiFVBIz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jun 2022 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFVBIy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jun 2022 21:08:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174243191A
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jun 2022 18:08:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ej4so17769586edb.7
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jun 2022 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aaUerIhcmrWygpieSDEiCvn0lG8dVQuGWs6LuxTeDyw=;
        b=MK/Dm5hYjOeXxnDrdl3mAvfmvgwG1lPqx34F3XAtnMDeXHIpGCGVv+hyuEuQ34+aae
         xDgx+GaY/2QwhLM7pGLCPulD0jh9mKrVxx+mhVcdBxOMHiSZguoYTIWTRfdRJB8JjYdK
         o475RKnH23C2lOa7b5ooHU8mMrw3M44qvGfP+J16k1JtaIive/ipGyXIGjCWwHQzZ+XI
         Vm8maIrvrWuDvfsitR7DtAXVR+1uVzqGSz2Ww84impfw3huf0lPiehR2rxwT1NNhVwdF
         hgSWnrsO/E6tmh8J512I1QJaVV5Cb67BhAraRnwZ+e5TW71S1GKi1tv5ygpyDw6VKfgZ
         A7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=aaUerIhcmrWygpieSDEiCvn0lG8dVQuGWs6LuxTeDyw=;
        b=0bpdTvXtiiEUq5kkoxWKtNTQ8XYJl/nYpnd8ATCBvNt7SISiDpQenKvYUxL15riaqh
         w4oQOTbyWbweUCqnESjt3J5ERmdXd5nokQqwp/eKl+E6cnbZHZpZJ1HZhp31ENW3Ozuy
         5S66K0id/ivojPIuAkVQMBmkybuk7w4OTIXOOiOaZNqrIgwDp+H/puhZlAE9sNmwKxvZ
         61gJLlQqgDMsDEAvsxckEHRtDpAV7tBFlMeiVQzYUKWugMlagPFSTpSdYTu/kYbLFXjF
         n1jbUzaMOhgoH9IUglQoUe17ceH72p0QpFxYqodIKCMKqIT15KWpZhOnOPIDzCj6E5Mq
         GwqA==
X-Gm-Message-State: AJIora/uUpIGNAz70DbBkT2hbY3qUy0oVicFSP9vmCa/OeQOQwUiWcTN
        9WwVUf5bjzHF5uUDSTeJaqjXM/A3Gs9j5oo6POg=
X-Google-Smtp-Source: AGRyM1vqLqGie65pjUJBoSdo7dAxwnModrvE4dJSvcQ/u21jn7mSyarxyaY4yfj2k4TcXo3ujT+popsjoDlzOcFGHVk=
X-Received: by 2002:a05:6402:2752:b0:433:3a08:27b1 with SMTP id
 z18-20020a056402275200b004333a0827b1mr1076731edd.235.1655860132599; Tue, 21
 Jun 2022 18:08:52 -0700 (PDT)
MIME-Version: 1.0
Sender: emiliahunt50@gmail.com
Received: by 2002:a17:907:a40b:0:0:0:0 with HTTP; Tue, 21 Jun 2022 18:08:52
 -0700 (PDT)
From:   Gerrate Kriz <gerratekriz@gmail.com>
Date:   Wed, 22 Jun 2022 01:08:52 +0000
X-Google-Sender-Auth: DdR27jtrGMeI0graHe1Nr7n7raM
Message-ID: <CAMXpgEO-g3vSt6NufWPCd214qwxPwYTmj5nppi=sSyZ8N8Vnjw@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--=20
Ol=C3=A1,
Posso falar com voc=C3=AA por favor?

Gerrate Kriz
