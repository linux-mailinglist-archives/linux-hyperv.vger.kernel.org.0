Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502BA6B4B3F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjCJPhd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCJPhN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 10:37:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7328611A9B9;
        Fri, 10 Mar 2023 07:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A846187C;
        Fri, 10 Mar 2023 15:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C455BC433D2;
        Fri, 10 Mar 2023 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678461886;
        bh=fdFn5jrrcyHcyDL2sKP1CQAKHLixa3gGPqtLCUOrSpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsHxC2v7Lp5Z5hXsjw8ICUkwRlX0hnyhJqlnmWLUuTuvNSEF0XGz45+H8/EpmwBHF
         54EtVjBnfk4iKzpe8PpuQFMWfkFgZ0f92/X7Ntgiq18vTNPG2JOlaAslGM0bby7oof
         3yTHjv4IYLK93wGaaBqsP4fa4b9t+3UiiSEueyIEzXArgFdOQDgo9E/ose+RUlpLgf
         T1HdcRiXdkVpmIC/WMr9nhf7hY5fbfZQKKp7/hmY7a3DHfy8JZoY9D/OJHEBgHXti2
         pQsm2AxpnePmw2U7kxDcihEh/zY4yGyHzG1DFLATn2Rm0L+yv/hr9KzTQCBR4I2QXU
         9gnL3xMhedLSw==
Date:   Fri, 10 Mar 2023 07:24:42 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Message-ID: <20230310152442.cbrjise6uex4ak4x@treble>
References: <20230310140251.1159036-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310140251.1159036-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 10, 2023 at 11:02:52AM -0300, Guilherme G. Piccoli wrote:
> Hey folks, after getting the warning myself a quick search led me to Arnd's
> thorough report - investigating a bit, this seems to be the proper solution.
> 
> Notice I didn't add the function to objtool's static list, seems this is
> unnecessary in this case - lemme know otherwise!
> Thanks in advance for reviews,

I'd recommend also adding it to the objtool global_noreturns list,
otherwise this patch will probably trigger warnings with other non-IBT
configs, in cases where the function is called from another translation
unit, where GCC knows the function is noreturn but objtool doesn't.

We're looking at ways of eliminating global_noreturns, but it's
unfortunately still a necessary evil at this point.

Also, FWIW, I have a change coming soon which make these warnings much
easier to diagnose.

-- 
Josh
