Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0157040EDD7
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Sep 2021 01:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhIPX0X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Sep 2021 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhIPX0X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Sep 2021 19:26:23 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18EC061574
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Sep 2021 16:25:02 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u15-20020a4a970f000000b0029aed4b0e4eso625503ooi.9
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Sep 2021 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N8zdA9XkphjMbQH3XSx+VRb0as/MhMviY1spkk9ofxg=;
        b=XUzkQCe88c/e2GNOBm7RgGpumcLED5tYNV6hw/CD87GjI8L8t/MmMaAyKj29Wit3gB
         XBt0Qc1BnOQ/IK2QAL3kA6jn9JN5/un9jX6L9jdA7ahlofYN9nmnJScBqFvivipGlga6
         x3MC8DVbyc9gQKJWbxL4KDqUqYIIA8ZCOp+jiHpbfiWDIk27cTK3Bwu2g9vRRxD7m8Q1
         /vE12oHop+6CliODvDdjMIj+qWDMu9jOUp6DVLh1faPYvpsEaHXRmE/ZnIaWgwVDH9Zd
         RHZHhUvXoNYftDaE9yq33Ep6XwSwbYcGxrlgLig9sCpNb9T6Nuiwi2PmqhEX25hGfnbC
         RBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=N8zdA9XkphjMbQH3XSx+VRb0as/MhMviY1spkk9ofxg=;
        b=j2m3DeFrcEVFMNdOnrv2uTGFMfnwUGyb6gqMjlbgE18marCqpq6OIzXdmSklEy9bwx
         rx08xjUf70nJi4qYn7Z9vTu4GOt6liUHKaE9AWPIqF/Ahk/qHd8MiG2g1C9SRFawt71B
         +wkb7xzSlQQRWgts0daSiCgTDS4T+8vBUIuzeRGdjv+55z5DqB2pl2IpVZvLmRrytsTd
         J2jJ8ogWb8nZYs3/4ljQWhgwQ0tgS+JNtWT2Cz6Pg+J8nFq/atX+n5g+f7Oqa1tPrxtz
         wunG9Gv1xrIghXTm6DbOq29JnaoCATEC4cOQfqJ0MvHFhI+WPoOshUCpuZOTkDEKVWyp
         Gy6g==
X-Gm-Message-State: AOAM530Ec5+Ou1u8UsZCXxJm7PaCI7BgPrAlKYYpMmyeutuFVTDOgsDi
        /bpX31NfHdBSzaxkx2DYKpvhf2+QNekcFCkt23E=
X-Google-Smtp-Source: ABdhPJzHMDZpaaIXUTlA6YA/y4JkyEpMW6Ho02gN589oZ7DipRAQcUwGonUpCYILdjMfFQD/vyKg7vDytTLKd8s+Zn0=
X-Received: by 2002:a4a:c404:: with SMTP id y4mr6522669oop.88.1631834701581;
 Thu, 16 Sep 2021 16:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aca:eb94:0:0:0:0:0 with HTTP; Thu, 16 Sep 2021 16:25:01
 -0700 (PDT)
Reply-To: asameraa950@gmail.com
From:   Samera Ali <sjen362@gmail.com>
Date:   Thu, 16 Sep 2021 16:25:01 -0700
Message-ID: <CADeDfrmjW4YHrTkkPe_B-+Ds1eo5hHUj+bXs1W9MRmzH1iS06w@mail.gmail.com>
Subject: =?UTF-8?B?T2zDoSBxdWVyaWRh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ol=C3=A1 querida

Prazer em conhec=C3=AA-la, Senhora Samera Encontrei o seu e-mail aqui na
pesquisa do Google e escolhi o interesse em contact=C3=A1-la. Tenho algo
muito importante que gostaria de discutir consigo e agradecia que me
respondesse atrav=C3=A9s do meu endere=C3=A7o de correio electr=C3=B3nico p=
ara lhe
falar mais sobre mim com as minhas fotografias, o meu correio
electr=C3=B3nico privado como colegas??  [ asameraa950@gmail.com ]

De, samera ali
