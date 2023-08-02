Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0116476DAF5
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHBWu5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 18:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjHBWu4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 18:50:56 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921A89B;
        Wed,  2 Aug 2023 15:50:55 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-686f8614ce5so300275b3a.3;
        Wed, 02 Aug 2023 15:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691016655; x=1691621455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSZP6s8E87YIozKHHuno/d/txSVRFI7AHAk3fEQT3oo=;
        b=QbZOKhR3PWBARSvzW1NZN7USu+BXZj4uutwyCwIutvUqKuNeJSvrER2r8Mlt2CmIEq
         LhY5Qmf35B05TAGS0ITQQrvsiWiNhMWcBw+uo6QcfjnnAcxd7fhdKSASsfGhf+CYtUuV
         CRf1lLjFluFu6KMs8hbaegRxh0zISof9jHIOSRsE58nphpjXsgsWp+n0PECvkvPTLfvE
         Ueq94L44zfkbjyhE7+opy6sSrqKKAva7qk0mommmmrSHghFg0xQaCuhIVG7zbOhLUAJv
         k7oofj6aySnB3oBelnjWChr6uS7t65k2m3Mu7oQFJMAIL1a92DYDa0SgFc71MtQadJjl
         r1Eg==
X-Gm-Message-State: ABy/qLZxp+Bd/Ccjm8Q0EtgYfRQ6HjD+v3ebI7fYgV2099VcY+cV0LG3
        X6IIQXiOFAofXK1bBpD3pK8=
X-Google-Smtp-Source: APBJJlEQyc/oGseiiXbsMGMZUszVgfMcxK3SQMnZu2T/xFQsiEwlYTiKIL/zNbyeM4OOfg2IpeyZfg==
X-Received: by 2002:a05:6a20:a10e:b0:13d:b318:5c70 with SMTP id q14-20020a056a20a10e00b0013db3185c70mr13020943pzk.19.1691016655000;
        Wed, 02 Aug 2023 15:50:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b00686e6e2b556sm11467645pfm.26.2023.08.02.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:50:54 -0700 (PDT)
Date:   Wed, 2 Aug 2023 22:50:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V6 net] net: mana: Fix MANA VF unload when hardware is
Message-ID: <ZMrdyFgwr9sL7BmZ@liuwe-devbox-debian-v2>
References: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 26, 2023 at 06:15:36AM -0700, Souradeep Chakrabarti wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Hi Souradeep. The subject line of this patch seems to be cut off half
way.

Thanks,
Wei.
