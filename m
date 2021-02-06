Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C936B311DC3
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Feb 2021 15:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBFOif (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 6 Feb 2021 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBFOie (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 6 Feb 2021 09:38:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEDC06178B
        for <linux-hyperv@vger.kernel.org>; Sat,  6 Feb 2021 06:37:54 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id y11so9894650otq.1
        for <linux-hyperv@vger.kernel.org>; Sat, 06 Feb 2021 06:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=syKz014J1IBcIyVXehtylwaHku8NvorhQ6qE7Jquq/aCw5Ng0/U3gCazq94UT3g3Zq
         56uMR754vDVKcEEBpqrfUP9+THssANGCa0J5lSjL1TQY7LrhsQVPkdBibyXht1V0T6rI
         Gl7Or4yJzJM/X65SDMNSoWwhdeKuxixhW3t74YAfYj6uDAJkE5/LOK8aK6A6NDNr3AH2
         F+1F0MAyfRoUT/7LBId9crOQS64Dm/q5ohTaZvxXJ4qyZYz2/DuR1Jde6xSiIoA4od9R
         nqscUXLy6/Ps2Sy87s6ThkesLXmQKBosAoXI9QOAAWKJBcfquxh1A7SUl8NyX6RYUsD+
         bWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=iy9Swt2Oh+dEb+d0XEDiUe4VkSg1h19sWvnnFG+ztANAi5qcxZMROT51NoWAtTVf0e
         8QpyjeosKb4zw0V2+btEQyYe0YAaudd++fQo83YdkuR1fCLhOQrcemKfdjMr5anFPExM
         xg1dCsl+ckk49oGnDBdLqZG2oZnnk4NSOa00opio5W8fKIaBeQM8OxPnh/Ro50ActV+0
         hyw/HDqS0sqvmETLwowBmWuP98jCFNY1erkY4LTUtQUPz2eO12xoIWCjq7H2YuYhq8NB
         6LggQgllcUlHQ/mnYVjS0eVsAk05wlC3C3O9UbWBxgGsL1l0rYGyGQQbjisCbX7BlCz+
         WVig==
X-Gm-Message-State: AOAM530OnWyP4+LFo0iEpqSP2lfoF8obNwXwOhLiO7xRafxcG53B8QAK
        I6q7aYz+4BW57CY5HrcgS/wAqXhnAfvrveH8y/E=
X-Google-Smtp-Source: ABdhPJzrSISI+JulE6ZYxlq+atGXSXfx8GGMCRwjL7uBxwvigCp+65LX8uv60YZFGEOShROQ9Lj+SVapJBPgeIk0pPg=
X-Received: by 2002:a9d:6056:: with SMTP id v22mr7040390otj.266.1612622273885;
 Sat, 06 Feb 2021 06:37:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:37:53 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:37:53 +0100
Message-ID: <CAO_fDi81boC4UMSuQjY11hx_3r8g-rwXH6_+=gjm3QuWtTxwLg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
