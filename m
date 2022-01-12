Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2B48CF2D
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 00:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiALXjQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 18:39:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60458 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiALXjP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 18:39:15 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28BCD20B717A;
        Wed, 12 Jan 2022 15:39:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28BCD20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642030755;
        bh=eDZj7GaCbx/XP92LWIlevNbQ2oDCeHekIAKXkKhl3p4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PzVcfuzseK3TyqYR8+okvr8wj5YtcYDB0KDyHg1+IvlzNpU+mCMnsicfpAvWUl1qr
         j9IduYQ6blNmvcpbjawX/p3I1UTHYtccEL58EwsELF5df2YAxjZKB0E/h7QMuVvrCP
         8eieG2oEai3uOW5+HEY5KS6ez6IZYTGdCWLwZm9g=
Message-ID: <bd36b131-be23-6f4d-16cf-a549a6533f34@linux.microsoft.com>
Date:   Wed, 12 Jan 2022 15:39:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 0/9] drivers: hv: dxgkrnl: Driver overview
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <Yd9SQxTznfHGjuDD@archlinux-ax161>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yd9SQxTznfHGjuDD@archlinux-ax161>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/12/2022 2:12 PM, Nathan Chancellor wrote:
> Hi Iouri,
>
> > We're looking forward additional feedback.
>
> I have been including this patch set into my downstream WSL2 kernel that
> I build with clang and I noticed an instance of -Wenum-conversion that
> is still present in this revision:Please consider cleaning this up in a future revision so that clang
> builds stay clean :)
> ...
> I happened to notice there was another function that looks very similar
> to command_vgpu_to_host_init0(), command_vm_to_host_init0(), which is
> also unused.  This was hidden because it is marked as "static inline" in
> a .c file, which should generally be avoided; I would recommend
> replacing all instances of "static inline" with just "static". The
> compiler will still inline it if it feels it is worthwhile. Doing this
> reveals one other unused function, is_empty():
>
> $ sed -i 's/static inline /static /g' drivers/hv/dxgkrnl/*.c
>
> $ make -skj"$(nproc)" LLVM=1 drivers/hv/dxgkrnl/
> drivers/hv/dxgkrnl/hmgr.c:167:13: warning: unused function 'is_empty' [-Wunused-function]
> static bool is_empty(struct hmgrtable *table)
>              ^
> 1 warning generated.
> drivers/hv/dxgkrnl/dxgvmbus.c:234:13: warning: unused function 'command_vm_to_host_init0' [-Wunused-function]
> static void command_vm_to_host_init0(struct dxgkvmb_command_vm_to_host
>              ^
> 1 warning generated.

Hi Nathan,

Thanks a lot! We will get this fixed

Iouri

> Cheers,
> Nathan
>
>
