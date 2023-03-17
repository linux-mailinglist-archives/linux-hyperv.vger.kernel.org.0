Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D175C6BF1A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCQT1u (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQT1t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 15:27:49 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD4810A9F;
        Fri, 17 Mar 2023 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uxf5gWwvz7UPGdoL8yu+UzoQ93mCh7u52QZx31NTrrM=; b=bWanNDEItZAe6i1FJsviwCR23C
        Pe//0OgtOtPwqrWJGwrrOSRvnInUQPEBS5M9bUNzj0wpQ1qM9RzTUeSdHSIizvsPvtcJ96XQDGwgv
        niqcfKQTKYYAikI1IUkvYNms6Q2Evw22YnnBFZWuN0jCCjcOUer4CS6C9GOrPCl0JVwDjCXVoEPxO
        u8e8OdIpP17Mx299Rj0Dbs4mlj867PmZu1B33kf/XLgakzHs8Lg7ozVEEBfzCbmB+UOVMIk62riPm
        dFvNibai7+6rRvRVOE5N/RbSIMQs4IA0abA37tTvN5LD1s+/TJRQhe+40ZFZDt4LWEHGWXSDhdbhj
        UzWjmsfg==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pdFjl-00GDoz-Hb; Fri, 17 Mar 2023 20:27:38 +0100
Message-ID: <25e0fc05-fff3-87b6-14a7-4ab8b07cec01@igalia.com>
Date:   Fri, 17 Mar 2023 16:27:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        thomas.lendacky@amd.com, peterz@infradead.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arnd Bergmann <arnd@arndb.de>
References: <20230310154452.1169204-1-gpiccoli@igalia.com>
 <20230317160546.1497477-1-gpiccoli@igalia.com>
 <20230317162434.dpby4idecp7a6hrg@treble>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230317162434.dpby4idecp7a6hrg@treble>
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

On 17/03/2023 13:24, Josh Poimboeuf wrote:
> [...]
> 
> Looks good to me.  I've got some other noreturn fixes pending, so I can
> add this patch to the pile unless somebody else wants to take it.

Thanks, that'd be great. And thanks Michael for your review =)

