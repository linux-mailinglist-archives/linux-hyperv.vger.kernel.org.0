Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3981F48E3CB
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 06:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiANFiZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 00:38:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38294 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiANFiZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 00:38:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57AA561C5E;
        Fri, 14 Jan 2022 05:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC7C36AE9;
        Fri, 14 Jan 2022 05:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642138703;
        bh=lLfLPkFxDD1M0EJLDi2zTkNrNaEUxr9mFL959vpQDRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgKjrzUEh0Q1fj62j0WRn1dfeO+rsxq9mcIxXGKcvu5ltcDQL3FHK8oaAiM8khpUQ
         49hNQOB59SxUf9Jt4RA6ZfOuUGTERfZOxq6otUi6seiDqjQcNjdXi41XJtLFE14F5M
         D5HrOw8rrR4YdVbbrY8eAaYz2rf7QvV5rMsnpy5A=
Date:   Fri, 14 Jan 2022 06:38:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v1 8/9] drivers: hv: dxgkrnl: Implement various WDDM
 ioctls
Message-ID: <YeEMTGqDI1UApH81@kroah.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <b3abd5afcf0f46b261064fd0aa4c33a708fbb66b.1641937420.git.iourit@linux.microsoft.com>
 <Yd/ZHYbIHQvHp40a@kroah.com>
 <0c9f1d07-c9ee-5e23-e494-7198a0d0a54c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9f1d07-c9ee-5e23-e494-7198a0d0a54c@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 13, 2022 at 04:19:41PM -0800, Iouri Tarassov wrote:
> 
> On 1/12/2022 11:47 PM, Greg KH wrote:
> > On Wed, Jan 12, 2022 at 11:55:13AM -0800, Iouri Tarassov wrote:
> > > Implement various WDDM IOCTLs.
> > > Again, break this up into smaller pieces.  Would you want to review
> > all
> > of these at the same time?
> > 
> > Remember, you write code for people to review and understand first, and
> > the compiler second.  With large changes like this, you are making it
> > difficult for people to review, which is your target audience.
> > 
> > I'll stop here, please fix up this patch series into something that is
> > reviewable.
> 
> Hi Greg,
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> states that "only post say 15 [patches] or so at a time and wait for review
> and integration".
> The IOCTLs here are simple and I tried to keep the number of patches smaller
> than 15. Is it ok to have more than 15 patches in a submission, or I need to
> submit the driver is several chunks (some of which would be not fully
> functional)?

We get patch series that are much longer all the time, that's fine.  How
many do you feel would be needed to properly break this out?

Again, create changes to make review easy.

greg k-h
