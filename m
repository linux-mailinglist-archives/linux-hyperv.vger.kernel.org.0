Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8E3A3067
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jun 2021 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFJQWS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Jun 2021 12:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFJQWR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Jun 2021 12:22:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA1160C40;
        Thu, 10 Jun 2021 16:20:21 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lrNPn-006mBw-J7; Thu, 10 Jun 2021 17:20:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jun 2021 17:20:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [RFC v3 0/7] PCI: hv: Support host bridge probing on ARM64
In-Reply-To: <YMI4fWkHzrD3GKTW@boqun-archlinux>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
 <CAMj1kXGwa28T5Cr_64OC4rqE3qhwWQz+BJPwjdr54G-pVf9+pA@mail.gmail.com>
 <2283b22ae7832db348bd9b3eff3aab16@misterjones.org>
 <YMI4fWkHzrD3GKTW@boqun-archlinux>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <dceabce36dc39aa9dce179f32391ddcf@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: boqun.feng@gmail.com, ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org, csbisa@amazon.com, sunilmut@microsoft.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-06-10 17:06, Boqun Feng wrote:
> On Thu, Jun 10, 2021 at 04:42:45PM +0100, Marc Zyngier wrote:
>> On 2021-06-10 16:01, Ard Biesheuvel wrote:
>> > On Wed, 9 Jun 2021 at 18:32, Boqun Feng <boqun.feng@gmail.com> wrote:
>> > >
>> > > Hi Bjorn, Arnd and Marc,
>> > >
>> >
>> > Instead of cc'ing Arnd, you cc'ed me (Ard)
>> 
>> And I don't know if you intended to Cc me, but you definitely didn't.
>> 
> 
> Weird.. seems my sending script got somewhere wrong. Apologies for you
> both, and Arnd.. I did intend to Cc you and Arnd.

No worries, it happens (I also used the wrong email address when
replying, so we're even).

> How do you want this to proceed? I could do a resend right now, or I
> could wait for a few days (and see others' feedback) and send a V4 next
> week. Sorry again ;-(

Let the current series simmer on the list for a few days, I can
always eyeball it there if I'm short of patches to review... ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
