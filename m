Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32371F1E4F
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2020 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgFHR3N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Jun 2020 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbgFHR3M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Jun 2020 13:29:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D58C08C5C2
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2020 10:29:12 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so8713754qvx.11
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jun 2020 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pVi02/1lSeutlFv8vPsavfs6kZD+K668tKO9td/zctd0JVkvceAdDN7y1P5yT2oU22
         LALwYXrZ91X7dBp8yYWkEcs9c68YiLd5wvq+/vXFtuid7jb8ZqwxOsj8rm8B+hg58YpM
         2rGDi43naEm4afX+jL08TetTQT96qbTLwuoZIphKG1NYBRM2IbH2O0t63R/PMMFMW6hz
         Atpj/bmDaQl2dZDY6jQKr5470UEMrYlg1yZwF5K0UMTiueNWD4dxVk3Y8qdByY+/NnCQ
         PPfJNjQRxwioTMr8fugzq4HDBxPzJYPZTPuVxD9c9i8m2tCCNDSTyUwS8EgLjbXquFJ3
         xE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=FW/korXYcERPkqqCF7XvEERS6mi+nvXCXSt4KEu0SEHOhjmgKndIbE7rKw2mgeSEBu
         MwvlQHbGPW59kRy0wOjb7Hz2eH3BgD8ssmHaR3C3nKIOK2uqQgxhgpvJ3MnuGqOK2XfI
         WUk47Z13k+cnQCNI19faFDQ/5zcf4quhuECP8DCJu9uVaS4LtIAcS//NYQCa7hZsr+sB
         fDnDB2/yVZmtds+uvKS9LPBbAwMwTzbcdxq1qXnYubB8A2uEmPgheBP7CkCGAS0fp3NX
         axX+BwqTiJlc3vfoa4Ri4hWiYTgkCtQKMqgLwjIpfVO2hlM36hAGrr5IyzQxr82mMtIe
         KTwg==
X-Gm-Message-State: AOAM533BcRCofmTU2eDdDqzctedE+R2du7yGHuLHv6hUNXWbiIPFIr40
        SmC1fGPBUjj0LX6gv1ffR5fqehOFBfmet8ioF3I=
X-Google-Smtp-Source: ABdhPJx2SGlrMJPeei7WDVMpMHRUBxTpgYW7RBoU3rtutX7XVWdYLRqSo6eKKDQwL2GaEC5aFM5k+F4Nsn+xZ6V+YV0=
X-Received: by 2002:ad4:46af:: with SMTP id br15mr10211701qvb.178.1591637351458;
 Mon, 08 Jun 2020 10:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1926:0:0:0:0 with HTTP; Mon, 8 Jun 2020 10:29:11
 -0700 (PDT)
Reply-To: annie30luvly@outlook.com
From:   Annie <brainmorgan048@gmail.com>
Date:   Mon, 8 Jun 2020 17:29:11 +0000
Message-ID: <CAG-WmJEL2pQR1eK8oEmEJq6Eb-jUZmvMJ8LZcWMQ-1Kfhqb4iA@mail.gmail.com>
Subject: =?UTF-8?Q?P=C3=ABrsh=C3=ABndetje_e_dashur_ju_lutem_m=C3=AB_kontaktoni_tani?=
        =?UTF-8?Q?_kam_di=C3=A7ka_shum=C3=AB_t=C3=AB_r=C3=ABnd=C3=ABsishme_p=C3=ABr_t=C3=AB_diskutuar_me_j?=
        =?UTF-8?Q?u_Annie?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


