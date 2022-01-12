Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC648CE3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiALWM1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 17:12:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41174 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiALWM0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 17:12:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D9C0B82141;
        Wed, 12 Jan 2022 22:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8944DC36AE9;
        Wed, 12 Jan 2022 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642025544;
        bh=hAf2PcLanwj0F/dZiWzZLbbtJcj8SpTNj0lZihhMYWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0VSKdIAExQt6DdF/SVXkAF1WMMHt4ZAHaV4TaD0mcbsrJ2BVakVWKnQW+xgAeJQO
         6CL/E+SWdZoTNRED2apGFyuK0CpJVomBwIOYOs1NUeligfauInKoA4TpNd2NLvLyHd
         jomzNEpMLdwOc7HgrweANx8W2umvraIj8Ekg7c+PYQPiCCGmvMxH9S+WXMkYbz6oa5
         jGQuEBS3tHYePtY/OJ9XBSK7FA/eN89XT2xJpb27RNbIkZIedu1UdEP2wWkIAZNsB3
         jNKizA9Vd1mdcFICAnbQUqrJDUboZOiQa1B+360SQGxNp4XGjkAokELsTOaEcwDxKB
         XNSH0m5fBmc5w==
Date:   Wed, 12 Jan 2022 15:12:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 0/9] drivers: hv: dxgkrnl: Driver overview
Message-ID: <Yd9SQxTznfHGjuDD@archlinux-ax161>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

On Wed, Jan 12, 2022 at 11:55:05AM -0800, Iouri Tarassov wrote:
> This is a follow-up on the changes we sent a few months back[1].
> 
> [1] https://lore.kernel.org/lkml/20200814123856.3880009-1-sashal@kernel.org/
> 
> The patches address the feedback, given by Greg KH and other reviewers, contain
> bug fixes, the implementation of asynchronous VM bus messages to the host
> and contain the remaining implementation of our vGPU / Compute hardware
> virtualization support that powers the Windows Subsystem for Linux (WSL) and
> will soon power the Windows Subsystem for Android (WSA).

<snip>

> We're looking forward additional feedback.

I have been including this patch set into my downstream WSL2 kernel that
I build with clang and I noticed an instance of -Wenum-conversion that
is still present in this revision:

In file included from drivers/hv/dxgkrnl/dxgsyncfile.c:21:
drivers/hv/dxgkrnl/dxgvmbus.h:894:26: warning: implicit conversion from enumeration type 'enum dxgkvmb_commandtype' to different enumeration type 'enum dxgkvmb_commandtype_global' [-Wenum-conversion]
        command->command_type   = DXGK_VMBCOMMAND_INVALID;
                                ~ ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
In file included from drivers/hv/dxgkrnl/dxgvmbus.c:23:
drivers/hv/dxgkrnl/dxgvmbus.h:894:26: warning: implicit conversion from enumeration type 'enum dxgkvmb_commandtype' to different enumeration type 'enum dxgkvmb_commandtype_global' [-Wenum-conversion]
        command->command_type   = DXGK_VMBCOMMAND_INVALID;
                                ~ ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
In file included from drivers/hv/dxgkrnl/ioctl.c:21:
drivers/hv/dxgkrnl/dxgvmbus.h:894:26: warning: implicit conversion from enumeration type 'enum dxgkvmb_commandtype' to different enumeration type 'enum dxgkvmb_commandtype_global' [-Wenum-conversion]
        command->command_type   = DXGK_VMBCOMMAND_INVALID;
                                ~ ^~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

This comes from command_vgpu_to_host_init0(), which does not actually
appear to be used anywhere:

$ rg command_vgpu_to_host_init0
drivers/hv/dxgkrnl/dxgvmbus.h
891:static inline void command_vgpu_to_host_init0(struct dxgkvmb_command_vm_to_host

Please consider cleaning this up in a future revision so that clang
builds stay clean :)

I happened to notice there was another function that looks very similar
to command_vgpu_to_host_init0(), command_vm_to_host_init0(), which is
also unused.  This was hidden because it is marked as "static inline" in
a .c file, which should generally be avoided; I would recommend
replacing all instances of "static inline" with just "static". The
compiler will still inline it if it feels it is worthwhile. Doing this
reveals one other unused function, is_empty():

$ sed -i 's/static inline /static /g' drivers/hv/dxgkrnl/*.c

$ make -skj"$(nproc)" LLVM=1 drivers/hv/dxgkrnl/
drivers/hv/dxgkrnl/hmgr.c:167:13: warning: unused function 'is_empty' [-Wunused-function]
static bool is_empty(struct hmgrtable *table)
            ^
1 warning generated.
drivers/hv/dxgkrnl/dxgvmbus.c:234:13: warning: unused function 'command_vm_to_host_init0' [-Wunused-function]
static void command_vm_to_host_init0(struct dxgkvmb_command_vm_to_host
            ^
1 warning generated.

Cheers,
Nathan
