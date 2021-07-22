Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6473D2B10
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGVQpc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhGVQpc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 12:45:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C5AC061575
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jul 2021 10:26:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v6so9676523lfp.6
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jul 2021 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuOs6XPM+Q3/Q5FSz5nCr0Y7zobhha2fUoijl6Bu2BA=;
        b=KFfv4h+yMAYsYLHv2rATQrjCbiBMCJfoJq06Mxs5adn4YXCUe5Em+QXV2L39tUNSrB
         U347JBxT1yLJyFZ42neWsvHQuPeAHuKxSytJ0HXTxmSrn4JEyYp7NMI2Qe8Div/6cou3
         HeWdJgKNMLJ+OM2KBu7XYNy40nFYwWFlqVmPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuOs6XPM+Q3/Q5FSz5nCr0Y7zobhha2fUoijl6Bu2BA=;
        b=IpT4sWanAKn9R7h44L8MlEFwhTGdbESphOvUZI0OdfFUk+lD7D8m6em+DKKobZXq8q
         RgXq/bijKyBhNf5JgGOUOW+M0v58DzAeQycGAPIlfHUmDVwLHees8jWsuRcsRopSy5x8
         uGbambDkIdG0va1uJRVrkPGNVei/kWfNxittsB64rWp4bPibpKjt9dgj7g5rWJy5HCFk
         ASBfOZpw6R4Yp2pHF+JxkwI27/BrQ7CG5+jI+UpS+6EEeopT5iT76z3iuvpVYxEUtE5n
         a2qu7CcHkfkLBdFwVOkYfNoSThVKMrGr7zZkRXdkhN4EGKTueAlDUS219q5iIJz/ts+P
         yoOQ==
X-Gm-Message-State: AOAM531Cq3wbDAxas5QTGnvGeK8rCtHuS6CA6r1aV34UNacrjNrjJkeb
        jK0jgwQ8PjRum1sxnunb/sOyQ+8JYDThxedXxyg=
X-Google-Smtp-Source: ABdhPJxsUDFQBXAxsPUeSYPWATJkvEa9km5S+qN7F7DU6NDNNXT9HjCQk7YpVYY2KhgxteGSr6/KZg==
X-Received: by 2002:a05:6512:3f0d:: with SMTP id y13mr322760lfa.217.1626974763273;
        Thu, 22 Jul 2021 10:26:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r201sm2023731lff.179.2021.07.22.10.26.02
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 10:26:02 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id m16so9628212lfg.13
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jul 2021 10:26:02 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr330523lfv.201.1626974761892;
 Thu, 22 Jul 2021 10:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
In-Reply-To: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Jul 2021 10:25:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
Message-ID: <CAHk-=wirFvNqAvaNaABHc2mi7FKL4n6TEAwQ3WTyTJueJcHCvA@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V fixes for 5.14-rc3
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 22, 2021 at 7:09 AM Wei Liu <wei.liu@kernel.org> wrote:
>
>   - Reversion of a bogus patch that went into 5.14-rc1

When doing a revert, please explain it.

Yes, they are simple in the sense that they just undo something, but
at the same time, that "something" was done for a reason, and the
reason why that original change was wrong, and how it was noticed (ie
what the symptoms of the reverted patch were) is important.

I've pulled this, so it's too late now, but please please please
explain reverts in the future, not just a "This reverts commit XYZ".

                     Linus
