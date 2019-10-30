Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C6E9C1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2019 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJ3NP3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Oct 2019 09:15:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45029 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3NP2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Oct 2019 09:15:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4so2596135lja.11
        for <linux-hyperv@vger.kernel.org>; Wed, 30 Oct 2019 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OWOFC9Vd/fJAJ3RAjW3BcHuOSkS0sKPacDNJdaNMlA=;
        b=AYc+eMPb7t7V/IgqOVYH5K3UrmXqZQeUHzT3eASCCnqoEuysmjE0x9w018Baw5soU8
         KHqeLYTWYEWYL1wcgjZktYPugcq4oUD8s7/1/mrjRyJfqbAtn2211DSlTeue3CJFSSYY
         VXtD5xvbAaldbzu/6uqvH3p5jndWBpa9/A0so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OWOFC9Vd/fJAJ3RAjW3BcHuOSkS0sKPacDNJdaNMlA=;
        b=LWMquldg2uDZpWuXf+1w9wOu/8L+TIV+F9ggjixsNEv2EtUg8lcp+TrcrbUF81PKSO
         lB+/fxT0cTBp1Pik2lY6hOKY2zWrNTuYEgL0vNhvY6Pl6ceYUcupowth1dUXNQ2CyCs4
         ikpPw8K7qUgaJQBJWeKyZX7Fvg+6xbAzisbipVsTUZhhisVTFd2vFgVvY18A8aMuya7R
         mLOMFQFnKyy19Xzv8I2Mny+TxoN5gK45r7UQbuqGpG7jGJXxQmfPQcJebFNC2xiMgz5n
         McX9kRtTKCmmvVDBNnrCdl/bC0gPKsac9YDCss3lZPBlzfmcW9OHEhFzpvlCijf4Yv1b
         g0jQ==
X-Gm-Message-State: APjAAAX40IhE7ZrtYnpMGN8azS/v1XOZt7vjM5sFk7Ts+k6NI5Jpgydb
        2VuhbmEZYVsIywcRXLh+FbABmMTx/wKuuA==
X-Google-Smtp-Source: APXvYqwHaDoMyGQrsvNpy44zx/A8wexOgiWLDRMn2H6xkQhjPmkZWxyTayXnrizVyRh9MqEzifmZ2A==
X-Received: by 2002:a2e:8e8e:: with SMTP id z14mr6757988ljk.170.1572441326290;
        Wed, 30 Oct 2019 06:15:26 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e14sm1335327ljb.75.2019.10.30.06.15.24
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 06:15:25 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id w8so2583173lji.13
        for <linux-hyperv@vger.kernel.org>; Wed, 30 Oct 2019 06:15:24 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr6751144ljg.26.1572441324701;
 Wed, 30 Oct 2019 06:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191030113703.266992083E@mail.kernel.org>
In-Reply-To: <20191030113703.266992083E@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 14:15:08 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
Message-ID: <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.4-rc
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 30, 2019 at 12:37 PM Sasha Levin <sashal@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

No, Sasha, I'm not pulling this.

It's completely broken garbage.

You already sent me two of those fixes earlier, and they got pulled in
commit 56c642e2aa1c ("Merge tag 'hyperv-fixes-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/hyper>") two weeks ago.

Fine - of the three fixes you claim, I could do this pull, and get at
least one of them.

Except YOU HAVE REBASED your branch, so I see the other two fixes that
I already got as duplicates.

WHY?

Stop this. Read the documentation on rebasing, and stop doing this
kind of insane thing.

                Linus
