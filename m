Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E60342E2E
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Mar 2021 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCTQJh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Mar 2021 12:09:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCTQJa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Mar 2021 12:09:30 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MbS0X-1lzRxJ1k7d-00bsD0; Sat, 20 Mar 2021 17:09:28 +0100
Received: by mail-ot1-f44.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso11547416otq.3;
        Sat, 20 Mar 2021 09:09:27 -0700 (PDT)
X-Gm-Message-State: AOAM533ZUKYOyZzGy6OPjuZ1OgQGtZnsaFkmTFVx8z3S8ML4ZksK8UXr
        w1iT+fVqYYWlWi+Ds7ztUm4qxVRWln1w8FnmxYM=
X-Google-Smtp-Source: ABdhPJzVJ2N60DvRV+HXUfGN7wgdYKablAq/4WybV8N0rgJq8z/pefYzkkd4Bi6D1LHZW2s/hrzhyYZqUkMU8Xg6NHw=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr5332246otq.305.1616256566981;
 Sat, 20 Mar 2021 09:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161956.2838291-2-boqun.feng@gmail.com>
 <20210319211246.GA250618@bjorn-Precision-5520> <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3qj=9KEN=X2uGCq0TrOGpyPw1Gwipmn=Gqx4LAfqUEDQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 20 Mar 2021 17:09:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07wedojBU6xDKotiOsPR8k2XEXMB1SvJSRpeG++URA5Q@mail.gmail.com>
Message-ID: <CAK8P3a07wedojBU6xDKotiOsPR8k2XEXMB1SvJSRpeG++URA5Q@mail.gmail.com>
Subject: Re: [RFC 1/2] arm64: PCI: Allow use arch-specific pci sysdata
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:e5seU3cMjlkxmy+JPXSrnFT4ztNPO1iZqQeA233JbxeaFAbG1O7
 FJ9y+M7wlylI8ckUctYL2VG5GAQmHQiDlgI1eCYfVQGQHEoDz8krnzidhXx+zP4WxOjFWc2
 lRCWI5sZ4uhb81wwDRi1wLcbtr52KUSq+LWSil/95SmBbp2fg2viYkZ0KfpA4C0gAhf7XMP
 SZmtSuT1/KbCgSGw3wncQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4EZW7c1Jfts=:8PzPUEN0NNQUVT8VHQ7qpC
 p2O60nEVJjklT8Qa5pFNUavcGblWZ1vLAOkXT1S3F/WT0ZmCJdtDFw44PNmagaPxBoh4Llged
 9gZzbO2Rk3JjsIJcmoCLZw2Mx9E4HXsPFuGNQWW5fh8v/oYHFqgIXDtN8WLR0eHxhvHWFBMSD
 r9f+SfebCrAJdTs+sK6TxuxPatT+lfSI0W/dY1QKNH2As+i9kLmgM321MEjHKNkfSeoiCts5n
 7KwyDYQwSajOHbqhlTpubKxclfhyIo3xOyigEKp4DlcdBHKlor26eeB7u7KnhIpac+aPqq8C0
 ArIHiz2kcdaOWin07xB8OuMNn0N2GaObADAZgq39k/8gDZ54gLgSxTSJe4MG47ZYCXvGNX/Qk
 fktBuSZrv7BkSYOTrw8UCjtLCY6uHXtHpycpqkDjhcSe+N4LYpVttFIlJS1r6
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Mar 20, 2021 at 1:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>      I actually still have a (not really tested) patch series to clean up
> the pci host bridge registration, and this should make this a lot easier
> to add on top.
>
> I should dig that out of my backlog and post for review.

I've uploaded my series to
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
pci-probe-rework-20210320

The purpose of this series is mostly to simplify what variations of
host probe methods exist, towards using pci_host_probe() as the
only method. It does provide some simplifications based on that
that, including a way to universally have access to the pci_host_bridge
pointer during the probe function.

         Arnd
