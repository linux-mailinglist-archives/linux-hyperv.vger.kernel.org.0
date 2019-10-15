Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528A5D73FE
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJOK5D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 06:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfJOK5D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 06:57:03 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2022089C;
        Tue, 15 Oct 2019 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571137022;
        bh=dnP3I0453xbeVkzuRn8mK2w4ROoFLtsCNmpT7EIfIag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QKavsu1JJ+lWqRq6CjnZhVIjctg+IY/PV9dF9xhF8VoDcGdoIeBRMoWgBOS0D9+Wm
         IGQ1d8UvXzFDvVPxtGrN4MXnfBrkPikyGwm3Ctt526DUxbglBE/s14ksmkPX7GjAV3
         0CqnX7V59XaiOg31KdIaN83Sc4W4gFWus9e/4xLM=
Received: by mail-qk1-f178.google.com with SMTP id y144so18690477qkb.7;
        Tue, 15 Oct 2019 03:57:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVjrCQ0ZXB1m5LToUzP1k76oBlUyo1ls2bXXuBsHwo+MyI8gNPQ
        VUDkVkEte4LFjsJzOo+SfiGgJ2nC7PCu76VTkPc=
X-Google-Smtp-Source: APXvYqx5kf8mO8pPHFCbswwtKKpCHJvQQ4CmZ5SlTPttYVBGa3KdYKwperC0jTheIvv74XdcpMO16DAeIwuW4Ujexos=
X-Received: by 2002:a37:6689:: with SMTP id a131mr32134156qkc.345.1571137021649;
 Tue, 15 Oct 2019 03:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191015103502.13156-1-parri.andrea@gmail.com>
In-Reply-To: <20191015103502.13156-1-parri.andrea@gmail.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Tue, 15 Oct 2019 11:56:50 +0100
X-Gmail-Original-Message-ID: <CAHd7Wqxzs54nQ_x_uCCSBQV9eW1p-CD9J+64DmV67abxMbJDWA@mail.gmail.com>
Message-ID: <CAHd7Wqxzs54nQ_x_uCCSBQV9eW1p-CD9J+64DmV67abxMbJDWA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Set pv_info.name to "Hyper-V"
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        x86@kernel.org, "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 15 Oct 2019 at 11:35, Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Michael reported that the x86/hyperv initialization code printed the
> following dmesg when running in a VM on Hyper-V:
>
>   [    0.000738] Booting paravirtualized kernel on bare hardware
>
> Let the x86/hyperv initialization code set pv_info.name to "Hyper-V";
> with this addition, the dmesg read:
>
>   [    0.000172] Booting paravirtualized kernel on Hyper-V
>
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
