Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E26B4B9F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Mar 2023 16:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCJPuP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Mar 2023 10:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjCJPtz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Mar 2023 10:49:55 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B829401;
        Fri, 10 Mar 2023 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=btoOgygSSCmk4R4wZNoZ+rRmTeHwDCly0ggRbOBc2pw=; b=hvCbD2Vn0j+xXQfJA2GNikMks5
        xeEt1SNuRogSUyluuQtRV/+rJMM1tQivu/UeSQ+tMQsvVAdbMhwrmTSeOkJ4DFoc7TjJ0mkMTEf6r
        C9YFjXDh/NDgGrlzq1rJgIveGvHh4bdazGwF+EGFf8dOGdBuNtT5+yHz6b19RzUUJYjv8tAYDQEA4
        v85ZgA48HDRtZr18k/hXomotfLX8B7vOFM3A0ZaHNPkRAOfc8jqAaJgtU19e1QpZ7N68jP8OxzT9I
        /nDHnyHJJ8OzdvieP9PfB8fZN5QOXln+aKBZzEXcCKFBWYe3umShr2QzRUbTbupKaypV19MJcCYN7
        +rtlc/ig==;
Received: from 201-68-164-191.dsl.telesp.net.br ([201.68.164.191] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1paesW-002uyd-H0; Fri, 10 Mar 2023 16:41:56 +0100
Message-ID: <9ccc161e-40c0-e66d-2802-160c0f782cf5@igalia.com>
Date:   Fri, 10 Mar 2023 12:41:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arnd Bergmann <arnd@arndb.de>
References: <20230310140251.1159036-1-gpiccoli@igalia.com>
 <20230310152442.cbrjise6uex4ak4x@treble>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230310152442.cbrjise6uex4ak4x@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/03/2023 12:24, Josh Poimboeuf wrote:
> On Fri, Mar 10, 2023 at 11:02:52AM -0300, Guilherme G. Piccoli wrote: 
> I'd recommend also adding it to the objtool global_noreturns list,
> otherwise this patch will probably trigger warnings with other non-IBT
> configs, in cases where the function is called from another translation
> unit, where GCC knows the function is noreturn but objtool doesn't.
> 
> We're looking at ways of eliminating global_noreturns, but it's
> unfortunately still a necessary evil at this point.
> 

Hi Josh, thanks! Makes sense, I'll respond here with a V2 doing that.


> Also, FWIW, I have a change coming soon which make these warnings much
> easier to diagnose.
> 

Cool =)
