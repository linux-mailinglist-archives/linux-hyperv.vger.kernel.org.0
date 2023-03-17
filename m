Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2046BEE05
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCQQYj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCQQYi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 12:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7550C5AF0;
        Fri, 17 Mar 2023 09:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432FC60BFE;
        Fri, 17 Mar 2023 16:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6F7C433EF;
        Fri, 17 Mar 2023 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679070276;
        bh=O8JIGk5nsYYJhzj0FqYlrFfvfvhDJYNad0cgf6C+4ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zj18jaOzN9aVwIuJb59Q8lTPAE8uKsOZEa0T8aGA/cPNVDoN93IKZR/Hix2TyB8Gj
         8uAc6qE6E0oTkh/1iwsjItgYmDlO/bBvUiiBjRtM/5YAEz8BtPwz947c7nT3imWHuC
         2s0CsP0hOztemBzj9RKY32AzHiAkhFb0TdmtjnviBEFdRnEDFhpCQaAhqDTjMoz7iO
         Y7sE5uw/rikWKxlNq93SSelH+3FSiflFSm9TLKgvoyVT+KxKdSgNzFU5rie2QW3qik
         kR8ig1YAwl90B7GzDWc0N7qSMwoMrP6xTyDkN03+O2f3geGF1NaM8KW47iB9a1/Snw
         HqmoS3oKvAiNA==
Date:   Fri, 17 Mar 2023 09:24:34 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Message-ID: <20230317162434.dpby4idecp7a6hrg@treble>
References: <20230310154452.1169204-1-gpiccoli@igalia.com>
 <20230317160546.1497477-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230317160546.1497477-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Mar 17, 2023 at 01:05:46PM -0300, Guilherme G. Piccoli wrote:
> Annotate the function prototype and definition as noreturn to prevent
> objtool warnings like:
> 
> vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction
> 
> Also, as per Josh's suggestion, add it to the global_noreturns list.
> As a comparison, an objdump output without the annotation:
> 
> [...]
> 1b63:  mov    $0x1,%esi
> 1b68:  xor    %edi,%edi
> 1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
> 1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
> [...]
> 
> Now, after adding the __noreturn to the function prototype:
> 
> [...]
> 17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
> 17e4:  test   %al,%al
> 17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
> [...]  <many insns>
> 1bb9:  mov    $0x1,%esi
> 1bbe:  xor    %edi,%edi
> 1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/r/9698eff1-9680-4f0a-94de-590eaa923e94@app.fastmail.com/
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Looks good to me.  I've got some other noreturn fixes pending, so I can
add this patch to the pile unless somebody else wants to take it.

-- 
Josh
